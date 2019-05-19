#include <iostream>
#include <aws/core/Aws.h>
#include <aws/lambda-runtime/runtime.h>
#include <aws/core/utils/json/JsonSerializer.h>
#include <aws/core/utils/Outcome.h>
#include <aws/comprehend/ComprehendClient.h>
#include <aws/comprehend/model/DetectSentimentRequest.h>
#include <aws/core/utils/logging/ConsoleLogSystem.h>
#include <aws/core/utils/logging/AWSLogging.h>
#include <aws/core/utils/memory/AWSMemory.h>

using namespace aws::lambda_runtime;

namespace {
struct MyHandler {
  MyHandler() {
    Aws::Client::ClientConfiguration cfg;
    cfg.region = "us-west-2";
    cfg.scheme = Aws::Http::Scheme::HTTPS;
    cfg.caFile = "/etc/pki/tls/certs/ca-bundle.crt";
    cfg.connectTimeoutMs = 30000;
    cfg.requestTimeoutMs = 600000;

    client = new Aws::Comprehend::ComprehendClient{cfg};    
  }

  ~MyHandler() {
    delete client;
  }

  Aws::Comprehend::ComprehendClient* client;      
  
  invocation_response my_handler(invocation_request const& req)
  {
    Aws::Utils::Json::JsonValue json{req.payload.c_str()};
    const auto lang = json.View().GetString("lang");
    const auto text = json.View().GetString("text");

    Aws::Comprehend::Model::DetectSentimentRequest request;
    request.SetLanguageCode(Aws::Comprehend::Model::LanguageCode::en);
    request.SetText(text);


    auto response = client->DetectSentiment(request);
    if (response.IsSuccess()) {
      using SentimentType = Aws::Comprehend::Model::SentimentType;
      std::string sentiment;
      switch(response.GetResult().GetSentiment()) {
        case SentimentType::NOT_SET: sentiment = "NOT_SET"; break;
        case SentimentType::POSITIVE: sentiment = "POSITIVE"; break;
        case SentimentType::NEGATIVE: sentiment = "NEGATIVE"; break;
        case SentimentType::MIXED: sentiment = "MIXED"; break;
        case SentimentType::NEUTRAL: sentiment = "NEUTRAL";
      }
      return invocation_response::success(sentiment,         /*payload*/
                                          "application/json" /*MIME type*/);
    } else {
      return invocation_response::failure(response.GetError().GetMessage().c_str(),
                                          response.GetError().GetExceptionName().c_str());
    }
  }
};
}

int main(int argc, char** argv)
{
  namespace Logging = Aws::Utils::Logging;
  for(auto i = 0U; i < argc ; ++i) {
    std::cout << argv[i] << std::endl;
  }
  Aws::SDKOptions options;
  Logging::InitializeAWSLogging(
      Aws::MakeShared<Logging::ConsoleLogSystem>("Julio", Logging::LogLevel::Info));
  
  Aws::InitAPI(options);
  MyHandler hdlr;
  run_handler(std::bind(&MyHandler::my_handler, &hdlr, std::placeholders::_1));
  Aws::ShutdownAPI(options);
  return 0;
}
