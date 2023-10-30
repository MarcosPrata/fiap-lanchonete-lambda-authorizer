#!/bin/bash

LAMBDA_NAME=fiap-lanchonete-lambda-authorizer
REGION=us-east-1
STAGE=develop

rm lambda.zip
rm -rf node_modules
rm package-lock.json

yarn install

echo
echo "// Iniciando recursos do localstack --------------------------" 

echo
echo "🟢 Zipando a lambda: zip -r lambda.zip ."
nohup zip -r lambda.zip .

function fail() {
    echo $2
    exit $1
}

echo
echo "🟢 Executando: aws lambda create-function:"
nohup aws --endpoint="http://localhost:4566" lambda create-function \
    --region ${REGION} \
    --function-name ${LAMBDA_NAME} \
    --runtime nodejs14.x \
    --handler index.handler \
    --memory-size 512 \
    --zip-file fileb://lambda.zip \
    --role arn:aws:iam::000000000000:role/${LAMBDA_NAME}-lambda-role \
    --timeout 90 \

[ $? == 0 ] || fail 2 "Failed: AWS / lambda / create-function"

LAMBDA_ARN=$(aws --endpoint="http://localhost:4566" lambda list-functions --query "Functions[?FunctionName==\`${LAMBDA_NAME}\`].FunctionArn" --output text --region ${REGION})

echo
echo "//----------------------------------------"
echo "LAMBDA_ARN - ${LAMBDA_ARN}"
echo "//----------------------------------------"
echo

rm nohup.out
rm lambda.zip