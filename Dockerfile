FROM node

RUN mkdir /app
WORKDIR /app
VOLUME /app

RUN mkdir src
RUN mkdir dist


RUN git clone https://github.com/swagger-api/swagger-ui.git swagger-ui-master
RUN cp -R swagger-ui-master/dist swagger-ui
RUN rm -fR swagger-ui-master
RUN sed -i -E 's/https\:\/\/petstore\.swagger\.io\/v2\/swagger\.json/\.\/openapi\.yaml/g' swagger-ui/index.html

COPY ./package.json /app/package.json
RUN npm install

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT /entrypoint.sh
