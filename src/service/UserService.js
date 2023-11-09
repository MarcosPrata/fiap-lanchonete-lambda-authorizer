const { findUserByCPF } = require("../repository/UserRepository");

async function existsByCPF(cpf) {
  const userData = await findUserByCPF(cpf);

  if(userData.length <= 0){
    return null
  }

  return userData[0]
}

module.exports = { existsByCPF };
