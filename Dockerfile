FROM node:lts-buster

# Évite les prompts pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Préparation de l’environnement système
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    gnupg \
    software-properties-common && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    libwebp-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Dossier de travail
WORKDIR /usr/src/app

# Dépendances Node.js
COPY package.json ./
RUN npm install && \
    npm install -g qrcode-terminal pm2

# Copie de tous les fichiers
COPY . .

# Port exposé
EXPOSE 5000

# Lancement de l’application
CMD ["npm", "start"]
