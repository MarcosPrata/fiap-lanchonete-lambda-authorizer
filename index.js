// const { handleException } = require("./src/exception/ErrorHandler");
// const { existsByCPF } = require("./src/service/UserService");
// const { generateToken } = require("./src/service/TokenService");

// /**
//  * Lambda main function
//  * @param payload API Gateway http [payload](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#:~:text=HTTP%20API.-,Payload%20format%20version,-The%20payload%20format)
//  */
// const handler = async (payload) => {
//   try {
//     const body = JSON.parse(payload.body)

//     const accessToken = generateToken(body.cpf)

//     const userToken = { "access_token": accessToken }

//     const responseBody = JSON.stringify(userToken);

//     return {
//       statusCode: 200,
//       body: responseBody,
//     };
//   } catch (exception) {
//     return handleException(exception);
//   }
// };


// module.exports = { handler };

exports.handler = async (event) => {
  // Your Lambda function logic here

  const response = {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
    message: "Hello from Lambda!"
    // Add more data as needed
  })
};

return response;
};