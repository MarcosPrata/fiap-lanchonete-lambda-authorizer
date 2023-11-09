const { dbClient } = require("../libs/dbClient")

async function findUserByCPF(cpf) {
	const user = await dbClient.query(`SELECT * FROM customers WHERE cpf == '${cpf}'`)

  	return user.rows
}

module.exports = { findUserByCPF };
