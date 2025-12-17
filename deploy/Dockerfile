# deploy/Dockerfile
FROM python:3.11-slim

# Установим зависимости
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем только то, что нужно
COPY deploy/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Копируем сервер
COPY deploy/artifact_server.py /app/deploy/artifact_server.py

# Создаём папку для артефактов (в контейнере)
RUN mkdir -p /app/services/storage/artifacts

ENV ARTIFACTS_DIR=/app/services/storage/artifacts
ENV HOST=0.0.0.0
ENV PORT=8080

EXPOSE 8080

# Запуск через uvicorn (в контейнере используем модульный запуск)
CMD ["python", "/app/deploy/artifact_server.py"]
