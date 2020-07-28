# Container base: python 3.6 Alpine Linux
FROM python:3


ENV PYTHONUNBUFFERED 1

# Set timezone env
ENV TZ America/Araguaina

# Set locale
ENV LANG pt_BR.UTF-8
ENV LANGUAGE pt_BR.UTF-8
ENV LC_ALL pt_BR.UTF-8

# Set Timezone
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Cria diretório onde vão ficar os fontes
RUN mkdir /app

# Define o diretório de trabalho
WORKDIR /app

# "Copia" arquivo requirements.txt para o diretorio code
ADD requirements.txt /app/

# Executa o pip
RUN pip install -r requirements.txt