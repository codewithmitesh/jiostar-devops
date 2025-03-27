# # Use Node.js Alpine base image
# FROM node:alpine AS build

# # Create and set the working directory inside the container
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
# COPY package.json package-lock.json /app/
# USER root

# # Install dependencies
# RUN npm install
# USER node

# # Copy the entire codebase to the working directory
# COPY . /app/

# # Expose the port your app runs on (replace <PORT_NUMBER> with your app's actual port)
# EXPOSE 3000

# # Define the command to start your application (replace "start" with the actual command to start your app)
# CMD ["npm", "run", "build"]

# # # Stage 2: Production Build
# # FROM chainguard/nginx:latest-dev AS production

# # # Copy built files
# # COPY --from=build /app/build /var/lib/nginx/html

# # # Expose port 80
# # EXPOSE 80

# # # Run Nginx with the correct binary
# # CMD ["/usr/nginx", "-c", "/etc/nginx/nginx.conf"]
# FROM nginx:latest AS production
# COPY --from=build /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD [ "nginx", "-g", "daemon off;" ]

# Build stage
FROM node:alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
# Add nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]