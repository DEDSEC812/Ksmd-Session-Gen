FROM node:lts-buster

# Évite les prompts interactifs
ENV DEBIAN_FRONTEND=noninteractive

# Installation des dépendances système
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    libwebp-dev \
    webp \
    && apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Définir le dossier de travail
WORKDIR /usr/src/app

# Copier le fichier package.json et installer les dépendances
COPY package.json ./

RUN npm install && \
    npm install -g qrcode-terminal pm2

# Copier tout le reste du projet
COPY . .

# Ouvrir le port de l'application
EXPOSE 5000

# Commande de démarrage
CMD ["npm", "start"]
