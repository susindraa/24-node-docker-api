# Use official Node.js LTS image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy app source
COPY . .

# Expose the app port
EXPOSE 3000

# Run the app
CMD [ "node", "app.js" ]
