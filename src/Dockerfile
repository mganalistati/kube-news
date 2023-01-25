ARG VERSION="18-alpine"
FROM node:$VERSION
LABEL maintainer="mganalistati@gmail.com"
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
WORKDIR /kube-new
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
