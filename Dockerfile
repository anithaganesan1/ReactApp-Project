# Stage 1: Build React App
FROM node:22.15-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve  Use Nginx to serve pre-built static React files
FROM nginx:alpine

# Copy custom Nginx config to support client-side routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the pre-built React app from local `build/` folder
COPY build/ /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
#
