# tag first stage
FROM node:alpine as builder

WORKDIR '/app'

COPY package*.json ./
RUN npm install

COPY ./ ./
RUN npm run build

# second stage (no need for tag if you dont need ref)
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default command for nginx starts it for us