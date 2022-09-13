
FROM node:12.2.0-alpine as builder

WORKDIR /app

COPY . /app/

RUN npm install --silent

RUN npm install react-scripts@3.0.1 -g --silent

RUN npm run build

FROM nginx:1.16.0-alpine 

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /app/build .
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d/
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]