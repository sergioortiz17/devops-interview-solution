# Etapa 1: Construcción (instala dependencias en una imagen temporal)
FROM python:3.10-alpine AS builder

WORKDIR /app

# Instalamos paquetes necesarios para compilar psycopg2 y otras dependencias
RUN apk add --no-cache gcc musl-dev postgresql-dev libpq

# Crear un entorno virtual y activar
RUN python -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Copia y instala los paquetes de Python en el entorno virtual
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 2: Imagen final optimizada
FROM python:3.10-alpine

WORKDIR /app

# Instalamos las librerías del sistema necesarias en la imagen final
RUN apk add --no-cache libpq

# Copiamos el entorno virtual desde la etapa anterior
COPY --from=builder /app/venv /app/venv

# Copia el código fuente
COPY . .

# Activar el entorno virtual en la imagen final
ENV PATH="/app/venv/bin:$PATH"

# Expone el puerto 8000
EXPOSE 8000

# Comando de arranque con Gunicorn usando el entorno virtual
CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --noinput && gunicorn -b 0.0.0.0:8000 core.wsgi:application"]
