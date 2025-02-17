# Etapa 1: Build del frontend (compilación)
FROM node:18-alpine AS builder

WORKDIR /app

# Copia y descarga las dependencias
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Copia el código fuente
COPY . .

# 🔹 Asegurar que REACT_APP_API_URL esté disponible en el build
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# 🔹 Genera el build asegurando que use la variable de entorno
RUN npm run build

# Etapa 2: Servidor Nginx para producción
FROM nginx:alpine

# Copia la configuración de Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copia el build generado en la etapa anterior al directorio de Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Exponer el puerto en el que corre Nginx
EXPOSE 80

# Arranca Nginx
CMD ["nginx", "-g", "daemon off;"]
