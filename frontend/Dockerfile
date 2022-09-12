# pull official base image
FROM node:12.2.0-alpine as builder

# set working directory
WORKDIR /app



# install app dependencies
#copies package.json and package-lock.json to Docker environment
COPY . /app/

# Installs all node packages
RUN npm install --silent

RUN npm install react-scripts@3.0.1 -g --silent
# Copies everything over to Docker environment
RUN npm run build

#Stage 2
#######################################
#pull the official nginx:1.19.0 base image
FROM nginx:1.16.0-alpine 
#copies React to the container directory
# Set working directory to nginx resources directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static resources
RUN rm -rf ./*
# Copies static resources from builder stage
COPY --from=builder /app/build .
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d/
EXPOSE 80
# Containers run nginx with global directives and daemon off
CMD ["nginx", "-g", "daemon off;"]