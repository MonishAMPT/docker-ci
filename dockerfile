# Step 1: Use the official node image for building the React app
FROM node:18-alpine as build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Install dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install

# Step 4: Copy the React app source code
COPY . ./

# Step 5: Build the React app
RUN npm run build

# Step 6: Use NGINX to serve the React app
FROM nginx:alpine

# Step 7: Copy the build output from the previous step to NGINX's default directory
COPY --from=build /app/build /usr/share/nginx/html

# Step 8: Expose port 80 to serve the app
EXPOSE 80

# Step 9: Start NGINX
CMD ["nginx", "-g", "daemon off;"]
