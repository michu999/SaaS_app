FROM python:3.9-slim

LABEL authors="michu999"
LABEL description="SaaS Application Container"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBUG=0
ENV PORT=8000

# Set work directory
WORKDIR /app

# Create and activate virtual environment
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY ./src /app/

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port and set CMD
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:${PORT}", "saas.wsgi:application"]