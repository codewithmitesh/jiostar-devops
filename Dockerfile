# Use Node.js Alpine base image
FROM chainguard/node AS build

# Create and set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json /app/

USER root
# Install dependencies
RUN npm install

USER node
# Copy the entire codebase to the working directory
COPY . /app/

# Expose the port your app runs on (replace <PORT_NUMBER> with your app's actual port)
EXPOSE 3000

# Define the command to start your application (replace "start" with the actual command to start your app)
CMD ["npm", "run", "build"]

# Stage 2: Production Build

FROM chainguard/nginx:latest AS production
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
