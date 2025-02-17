# Etapa 1: Build del frontend (compilación)
FROM node:18-alpine AS builder

WORKDIR /app

# Copia y descarga las dependencias
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Copia el código fuente y construye la aplicación
COPY . .
RUN npm run build

# Etapa 2: Servidor Nginx para producción
FROM nginx:alpine

# Copia el build generado en la etapa anterior al directorio de Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Exponer el puerto en el que corre Nginx
EXPOSE 80

# Arranca Nginx
CMD ["nginx", "-g", "daemon off;"]
