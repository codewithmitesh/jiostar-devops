# Use Debian-based Node.js image
FROM node:latest AS build

WORKDIR /app
COPY package.json package-lock.json ./
#RUN apt-get update && apt-get install -y --only-upgrade libxslt1.1  # 🔹 Upgrade libxslt1.1
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN npm install
COPY . ./
RUN npm run build

# Use Debian-based Nginx image
FROM nginx:latest AS production

# Upgrade libxslt1.1 in the production image too
RUN apt-get update && apt-get install -y --only-upgrade libxslt1.1  

# Copy built files
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]