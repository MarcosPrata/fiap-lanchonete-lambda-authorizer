const { findUserByCPF } = require("../repository/UserRepository");

async function existsByCPF(cpf) {
  const userData = await findUserByCPF(cpf);

  return userData !== null;
}

module.exports = { existsByCPF };
