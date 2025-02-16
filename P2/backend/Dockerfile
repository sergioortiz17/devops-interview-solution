# Usa una imagen base de Python
FROM python:3.10

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de requerimientos y los instala
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo el código al contenedor
COPY . .

# Expone el puerto 8000
EXPOSE 8000

# Comando por defecto para ejecutar Django
CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --noinput && python manage.py runserver 0.0.0.0:8000"]
