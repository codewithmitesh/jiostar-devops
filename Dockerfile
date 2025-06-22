# Use Debian-based Node.js image
FROM cgr.dev/chainguard/node AS build

WORKDIR /app
COPY --chown=node:node package.json package-lock.json ./

RUN npm install

COPY --chown=node:node . ./

ARG REACT_APP_MOVIEDB_APIKEY
ENV REACT_APP_MOVIEDB_APIKEY=$REACT_APP_MOVIEDB_APIKEY

RUN npm run build

# Use Debian-based Nginx image
FROM cgr.dev/chainguard/nginx AS production

# Copy built files
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 8080