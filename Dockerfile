# Etapa 1: Construcción de la aplicación Angular
FROM node:18 AS build

WORKDIR /app

# Copiar archivos necesarios para instalar dependencias
COPY package.json package-lock.json ./
RUN npm install

# Copiar todo el código fuente
COPY . .

# Construir la aplicación Angular
RUN npm run build --prod

# Etapa 2: Servir la aplicación con Nginx
FROM nginx:1.23-alpine

# Copiar la aplicación compilada al directorio de Nginx
COPY --from=build /app/dist/mi-proyecto-angular /usr/share/nginx/html

# Configurar Nginx (opcional, si necesitas cambios en la configuración)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
