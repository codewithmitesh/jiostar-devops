# Use Debian-based Node.js image
FROM cgr.dev/chainguard/node AS build

WORKDIR /app
COPY --chown=node:node package.json package-lock.json ./
#RUN apt-get update && apt-get install -y --only-upgrade libxslt1.1  # 🔹 Upgrade libxslt1.1
#RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN npm install

COPY --chown=node:node . ./
RUN npm run build

# Use Debian-based Nginx image
FROM cgr.dev/chainguard/nginx AS production

# Copy built files
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]