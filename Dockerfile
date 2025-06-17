FROM python:3.9-slim

LABEL authors="michu999"
LABEL description="SaaS Application Container"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBUG=0
ENV PORT=8000
ENV PROJ_NAME=saas

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

# Create runner script
RUN printf "#!/bin/bash\n" > ./paracord_runner.sh && \
    printf "RUN_PORT=\"\${PORT:-8000}\"\n\n" >> ./paracord_runner.sh && \
    printf "python manage.py migrate --no-input\n" >> ./paracord_runner.sh && \
    printf "gunicorn ${PROJ_NAME}.wsgi:application --bind \"[::]:\$RUN_PORT\"\n" >> ./paracord_runner.sh && \
    chmod +x ./paracord_runner.sh

# Expose port
EXPOSE 8000

# Set CMD to use the runner script
CMD ["./paracord_runner.sh"]