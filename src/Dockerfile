ARG VERSION="18-alpine"
FROM node:$VERSION

LABEL maintainer "mganalistati@gmail.com"
LABEL app "kubenews"

WORKDIR /kube-news

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
