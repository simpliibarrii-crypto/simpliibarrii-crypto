FROM python:3.11-slim

WORKDIR /app

COPY pyproject.toml README.md ./
COPY raven_ai/ ./raven_ai/

RUN pip install --no-cache-dir -e .

EXPOSE 8000

CMD ["uvicorn", "raven_ai.main:app", "--host", "0.0.0.0", "--port", "8000"]
