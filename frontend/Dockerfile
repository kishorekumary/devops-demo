#Stage-1

#Pull official image from Dockerhub
FROM node:12.2.0-alpine as builder
# set working directory
WORKDIR /app
#Copy the package.json files to install packages
COPY package*.json ./
RUN npm install
#Copy  everything over to Docker environment
COPY . .
#build the code
RUN npm run build

#Stage-2

#Pull official image from Dockerhub
FROM nginx:1.16.0-alpine 
#Set working directory
WORKDIR /usr/share/nginx/html
RUN apk add busybox-extras
#clean up if something exists there
RUN rm -rf ./*
#Copy the build folder created in the previous stage
COPY --from=builder /app/build .
#Delete the  default.conf
RUN rm /etc/nginx/conf.d/default.conf
#Copy the nginx.conf file 
COPY nginx/nginx.conf /etc/nginx/conf.d/
#expose Port 80 of the container
EXPOSE 80
#add permissions for nginx user
# RUN chown -R nginx:nginx /usr/share/nginx/html  && chmod -R 755 /usr/share/nginx/html && \
#         chown -R nginx:nginx /var/cache/nginx && \
#         chown -R nginx:nginx /var/log/nginx && \
#         chown -R nginx:nginx /etc/nginx/conf.d
# RUN touch /var/run/nginx.pid && \
#         chown -R nginx:nginx /var/run/nginx.pid
# #set user to nginx
# USER nginx
#To run in foreground debug mode
CMD ["nginx", "-g", "daemon off;"]


