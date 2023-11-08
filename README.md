# fiap-lanchonete-lambda-authorizer

![Turma](https://img.shields.io/badge/👨🏻‍🏫_Turma-SOAT2-blue?style=for-the-badge)
![Equipe](https://img.shields.io/badge/🧑🏻‍💻_equipe-20-blue?style=for-the-badge)


[![Javascript](https://img.shields.io/badge/Javascript-%23F7DF1E.svg?style=for-the-badge&logo=javascript&logoColor=black)](https://www.javascript.com/)
[![NodeJs](https://img.shields.io/badge/Node.js-%23339933.svg?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org/en/)

[![Lamda](https://img.shields.io/badge/lambda_functions-aws-%23FF9900?style=for-the-badge&logo=awslambda&logoColor=white)](https://docs.aws.amazon.com/pt_br/lambda/latest/dg/welcome.html)

[![Localstack](https://img.shields.io/badge/aws-Localstack-%236b82f6?style=for-the-badge&&logo=amazonaws&logoColor=white)](https://github.com/localstack)

## 📄 Descrição

Essa lambda é responsável por autenticar o usuário, recebe o cpf do usuário verifica se ele existe no banco e retorna um Token JWT válido caso positivo.

![Diagrama da arquitetura do projeto](docs/arquitetura.png)

Os seguintes repositórios também fazem parte desse projeto:

> [fiap-lanchonete-terraform](https://github.com/MarcosPrata/fiap-lanchonete-terraform) - Reponsável por provisionar a infra na AWS.

> [fiap-lanchonete-api](https://github.com/MarcosPrata/fiap-lanchonete-api) - API core responsável por registrar e acompanhar pedidos e usuários.

> [fiap-lanchonete-api-gateway](https://github.com/MarcosPrata/fiap-lanchonete-lambda-authorizer) - Reponsável por autenticar e autorizar as chamadas requests dos usuários que passarem pelo API Gateway.

## 🚀 Quick Start

Para trabalhar em ambiente local é necessário:

- Instalar e configurar o [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) na sua máquina.

1. Preparando o [LocalStack](https://localstack.cloud/)
    - Caso não tenha uma instância do localstack rodando ainda, execute o seguinte comando na pasta raiz para subir o container do localstack

    ``` bash
    yarn localstack:run
    ```

    - Quando o ambiente do localstack estiver pronto. Execute este comando para criar a lambda no localstack.

    ``` bash
    yarn localstack:lambda:create
    ```

## Variáveis de Ambiente

Para a função lambda funcionar corretamente ela precisa das seguintes variáveis de ambiente:

>**DB_HOST** → default: 'localhost'
>
>**DB_PORT** → default: 5432
>
>**DB_USER** → default: 'postgres'
>
>**DB_PASSWORD** → default: 'postgres'
>
>**DB_NAME** → default: 'lanchonete'

## 🎓 Integrantes / Devs

> Nome: Marcos Henrique Prata Junior
>
> Matrícula: RM349949
>
> [![Linkedin](https://img.shields.io/badge/Linkedin-0E76A8.svg?style=for-the-badge&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/marcos-henrique-prata-junior/)
> [![GitHub](https://img.shields.io/badge/GitHub-333.svg?style=for-the-badge&logo=GitHub&logoColor=white)](https://github.com/MarcosPrata)

> Nome: Marcos Moreira
>
> Matrícula: RM349544
>
> [![Linkedin](https://img.shields.io/badge/Linkedin-0E76A8.svg?style=for-the-badge&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/moreira-dev/)
> [![GitHub](https://img.shields.io/badge/GitHub-333.svg?style=for-the-badge&logo=GitHub&logoColor=white)](https://github.com/MarcosPotato)

> Nome: Marcelo Gonçalves de Barros
>
> Matrícula: RM349535
>
> [![Linkedin](https://img.shields.io/badge/Linkedin-0E76A8.svg?style=for-the-badge&logo=Linkedin&logoColor=white)]()
> [![GitHub](https://img.shields.io/badge/GitHub-333.svg?style=for-the-badge&logo=GitHub&logoColor=white)]()


> Nome: Henrique de Paula Leite
>
> Matrícula: RM350046
>
> [![Linkedin](https://img.shields.io/badge/Linkedin-0E76A8.svg?style=for-the-badge&logo=Linkedin&logoColor=white)]()
> [![GitHub](https://img.shields.io/badge/GitHub-333.svg?style=for-the-badge&logo=GitHub&logoColor=white)]()
