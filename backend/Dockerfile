FROM node:18
WORKDIR /app
COPY . .
RUN npm install --production
EXPOSE 3002
CMD ["npm", "start"]