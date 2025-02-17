# ===========================
# 🔹 Etapa 1: Construcción del frontend con Node.js
# ===========================
FROM node:18-alpine AS builder

WORKDIR /app

# Copia los archivos de dependencias primero para aprovechar el cache de Docker
COPY package.json package-lock.json ./

# 🔹 Instala solo dependencias de producción
RUN npm ci --production

# Copia el código fuente
COPY . .

# 🔹 Asegurar que REACT_APP_API_URL esté disponible en el build
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# 🔹 Construcción del frontend
RUN npm run build && rm -rf node_modules

# ===========================
# 🔹 Etapa 2: Optimización de archivos estáticos
# ===========================
FROM alpine:latest AS optimizer

# Instalar herramientas para comprimir archivos
RUN apk add --no-cache gzip

WORKDIR /app

# Copia el build generado en la etapa anterior
COPY --from=builder /app/build /app

# Comprime los archivos estáticos
RUN find . -type f -name "*.js" -exec gzip -9 {} \; && \
    find . -type f -name "*.css" -exec gzip -9 {} \;

# ===========================
# 🔹 Etapa 3: Servidor Nginx optimizado
# ===========================
FROM nginx:alpine

# Copia la configuración de Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copia los archivos optimizados al directorio de Nginx
COPY --from=optimizer /app /usr/share/nginx/html

# Exponer el puerto en el que corre Nginx
EXPOSE 80

# Arranca Nginx
CMD ["nginx", "-g", "daemon off;"]
