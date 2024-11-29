# Use the node image from official Docker Hub
FROM node:18-alpine as build-stage
# set the working directory
WORKDIR /app
# Copy the working directory in the container
COPY /vue-project/package*.json ./
# Install the project dependencies
RUN npm install
# Copy the rest of the project files to the container
COPY /vue-project .
# Build the Vue.js application to the production mode to dist folder
RUN npm run build
# Debugging: List the contents of /app/dist to verify the build
RUN ls -l /app/dist

# Use the lightweight Nginx image from the previous stage for the nginx container
FROM caddy:2.7.6-alpine as production-stage

COPY /caddy/Caddyfile /etc/caddy/Caddyfile

RUN mkdir -p /var/www/html

# Copy the build application from the previous stage to the Nginx container
COPY --from=build-stage /app/dist /var/www/html
