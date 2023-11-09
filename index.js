const { config } = require("dotenv")()
config()
const { dbClient } = require("./src/libs/dbClient")
const { handleException } = require("./src/exception/ErrorHandler");
const { existsByCPF } = require("./src/service/UserService");
const { generateToken } = require("./src/service/TokenService");

/**
 * Lambda main function
 * @param payload API Gateway http [payload](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#:~:text=HTTP%20API.-,Payload%20format%20version,-The%20payload%20format)
 */
const handler = async (payload) => {
  try {
    await dbClient.connect()
    const body = JSON.parse(payload.body)

    const user = await existsByCPF(body.cpf)

    const accessToken = user 
      ? generateToken(user.cpf, "authenticated")
      : generateToken(body.cpf)

    const userToken = { "access_token": accessToken }

    const responseBody = JSON.stringify(userToken);

    return {
      statusCode: 200,
      body: responseBody,
    };
  } catch (exception) {
    return handleException(exception);
  } finally{
    await dbClient.end()
  }
}

module.exports = { handler };