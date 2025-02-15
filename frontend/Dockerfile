# Usa una imagen oficial de Node.js
FROM node:18-alpine

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY package.json package-lock.json ./
RUN npm install

# Copia el código fuente
COPY . .

# Expone el puerto en el que corre React
EXPOSE 3000

# Comando para correr la app
CMD ["npm", "start"]
