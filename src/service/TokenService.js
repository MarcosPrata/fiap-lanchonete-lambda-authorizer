const crypto = require('crypto');

function generateToken(cpf, type = "anonymous") {
  const jwt_secret = "jwt_secret"

  const HMACSHA256 = (stringToSign, secret) => {
    const hmac = crypto.createHmac('sha256', secret);
    hmac.update(stringToSign);
    return hmac.digest('base64');
  };

  const header = {
    "alg": "HS256",
    "typ": "JWT"
  }

  const encodedHeaders = Buffer.from(JSON.stringify(header)).toString('base64');

  const claims = {
    "role": type,
    "cpf": cpf
  }

  const encodedPlayload = Buffer.from(JSON.stringify(claims)).toString('base64');

  const signature = HMACSHA256(`${encodedHeaders}.${encodedPlayload}`, jwt_secret)
  const encodedSignature = Buffer.from(signature).toString('base64');

  const jwt = `${encodedHeaders}.${encodedPlayload}.${encodedSignature}`

  return jwt
}

module.exports = { generateToken };
