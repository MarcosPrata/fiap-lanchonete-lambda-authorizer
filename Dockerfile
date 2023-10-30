FROM public.ecr.aws/lambda/nodejs:14

WORKDIR /var/task

COPY package.json .

RUN npm install -g yarn && yarn install

COPY . .

RUN mkdir -p /var/task/tmp

CMD [ "index.handler" ]
