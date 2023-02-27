FROM node:16

RUN apt-get update -qq && \
    apt-get install -qq -y libvips libvips-dev

# Define the working folder
WORKDIR /image

# Copy package.json file
COPY package.json ./

# Install dependencies
RUN npm install --platform=linux --arch=x64 --ignore-scripts=false --verbose --unsafe-perm

# copy the rest of files
COPY *.js ./

# Start the aplicación
CMD ["node", "app.js"]
