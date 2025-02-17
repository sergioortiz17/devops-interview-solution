# ===========================
# 🔹 Etapa 1: Construcción (Instalación de dependencias)
# ===========================
FROM python:3.10-alpine AS builder

WORKDIR /app

# Instalamos solo las librerías necesarias para la compilación
RUN apk add --no-cache gcc musl-dev postgresql-dev libpq python3-dev

# Crear y activar un entorno virtual dentro de la imagen
RUN python -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Copia y descarga las dependencias en la etapa de construcción
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ===========================
# 🔹 Etapa 2: Imagen final optimizada
# ===========================
FROM python:3.10-alpine

WORKDIR /app

# Instalamos solo las librerías necesarias en producción
RUN apk add --no-cache libpq

# Copiamos el entorno virtual desde la etapa de `builder`
COPY --from=builder /app/venv /app/venv

# Copia el código fuente del proyecto
COPY . .

# Activar el entorno virtual en la imagen final
ENV PATH="/app/venv/bin:$PATH"

# Recopilar archivos estáticos de Django antes de ejecutar
RUN python manage.py collectstatic --noinput || echo "collectstatic failed, ignoring"

# Expone el puerto de la aplicación
EXPOSE 8000

# Comando de arranque con Gunicorn, usando `exec` para mejor manejo de señales en contenedores
CMD ["sh", "-c", "python manage.py migrate && exec gunicorn -b 0.0.0.0:8000 core.wsgi:application"]
