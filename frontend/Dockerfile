
FROM node:12.2.0-alpine as builder
# set working directory
WORKDIR /app
#Copy the package.json files to install packages
COPY package*.json .
RUN npm install
#Copy  everything over to Docker environment
COPY . .
#build the code
RUN npm run build
#Stage-2 using nginx
FROM nginx:1.16.0-alpine 
#Set working directory
WORKDIR /usr/share/nginx/html
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
#To run in foreground debug mode
CMD ["nginx", "-g", "daemon off;"]


