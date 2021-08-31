FROM node:14.15.0
RUN apt-get update && apt-get install -y \
  nginx

ARG SOURCE_PATH=/var/www/app

RUN mkdir -p $SOURCE_PATH
WORKDIR $SOURCE_PATH
ADD . $SOURCE_PATH
COPY . $SOURCE_PATH
RUN yarn install 
# RUN yarn generate

COPY ./nginx/default.conf /etc/nginx/sites-available/default
RUN service nginx restart
