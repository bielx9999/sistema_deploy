FROM node:18
WORKDIR /app
COPY package.json .
RUN rm -f package-lock.json && npm install --production
COPY . .
EXPOSE 3002
CMD ["npm", "start"]