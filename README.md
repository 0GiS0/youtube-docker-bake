# Docker Bake - Builds como Código

<div align="center">

[![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UC140iBrEZbOtvxWsJ-Tb0lQ?style=for-the-badge&logo=youtube&logoColor=white&color=red)](https://www.youtube.com/c/GiselaTorres?sub_confirmation=1)
[![GitHub followers](https://img.shields.io/github/followers/0GiS0?style=for-the-badge&logo=github&logoColor=white)](https://github.com/0GiS0)
[![LinkedIn Follow](https://img.shields.io/badge/LinkedIn-Sígueme-blue?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/giselatorresbuitrago/)
[![X Follow](https://img.shields.io/badge/X-Sígueme-black?style=for-the-badge&logo=x&logoColor=white)](https://twitter.com/0GiS0)

</div>

---

¡Hola developer 👋🏻! Este repositorio contiene las demos de Docker Bake, una herramienta que te permite usar archivos para definir la configuración y los parámetros de tus builds de Docker, permitiendo incluso lanzar múltiples builds de forma concurrente con una sola invocación.

<a href="https://youtu.be/_lzDrXJssw8">
 <img src="https://img.youtube.com/vi/_lzDrXJssw8/maxresdefault.jpg" alt="15. Docker Builds como código" width="100%" />
</a>

---

## 📑 Tabla de Contenidos
- [Características](#características)
- [Tecnologías](#tecnologías)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Uso](#uso)
  - [1. Configuración Básica](#1-configuración-básica)
  - [2. Construir Múltiples Imágenes](#2-construir-múltiples-imágenes)
  - [3. Generar Imagen Multiplataforma](#3-generar-imagen-multiplataforma)
  - [4. Imágenes con Múltiples Contextos](#4-imágenes-con-múltiples-contextos)
  - [5. Usar Otros Builders](#5-usar-otros-builders)
  - [6. Exportar e Importar Caché](#6-exportar-e-importar-caché)
  - [Validar Archivos Bake](#validar-archivos-bake)
  - [Ejemplo Completo](#ejemplo-completo)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Sígueme en Mis Redes Sociales](#sígueme-en-mis-redes-sociales)

---

## ✨ Características

- **Configuración como código**: Define tus builds de Docker usando archivos HCL (HashiCorp Configuration Language)
- **Builds concurrentes**: Ejecuta múltiples builds en paralelo con un solo comando
- **Soporte multiplataforma**: Genera imágenes para diferentes arquitecturas (ARM64, AMD64, 386)
- **Múltiples contextos**: Combina contextos locales y remotos en tus builds
- **Gestión de caché**: Importa y exporta caché para optimizar tus builds
- **Builders personalizados**: Usa diferentes builders como Docker Build Cloud
- **Validación**: Verifica que tus archivos de configuración estén correctamente definidos

---

## 🛠️ Tecnologías Utilizadas

- **Docker BuildKit**: Motor de build avanzado de Docker
- **Docker Bake**: Herramienta para gestionar builds como código
- **HCL (HashiCorp Configuration Language)**: Lenguaje de configuración
- **Nginx**: Servidor web para las demos
- **.NET**: API de ejemplo (Tour of Heroes)
- **Angular**: Aplicación web de ejemplo (Tour of Heroes)

---

## 📋 Requisitos Previos

- Docker Desktop 4.0+ o Docker Engine 20.10+
- Docker Buildx instalado y habilitado
- Git para clonar el repositorio
- (Opcional) Docker Build Cloud para demos avanzadas

> **Nota**: Docker Bake está incluido con Docker Buildx, que viene preinstalado con Docker Desktop.

---

## 🚀 Instalación

### Paso 1: Clonar el repositorio
```bash
git clone https://github.com/0GiS0/youtube-docker-bake.git
cd youtube-docker-bake
```

### Paso 2: Verificar que Docker Buildx está disponible
```bash
docker buildx version
```

### Paso 3: (Opcional) Crear un builder personalizado
```bash
docker buildx create --name mybuilder --use
```

---

## 💻 Uso

Docker Bake te permite definir la configuración de tus builds en archivos `.hcl` en lugar de escribir comandos largos con múltiples parámetros. A continuación se muestran diferentes casos de uso:

### 1. Configuración Básica

Así sería el comando si no tuvieramos esta configuración:

```bash
docker build -t halloween:v1 .
```

El archivo `docker-bake.hcl` contiene la configuración para este caso. Para lanzarlo hay que usar este comando:

```bash
docker buildx bake
```

### 2. Construir Múltiples Imágenes

Imagínate que tienes que construir más de una imagen a la vez. Con Bake puedes hacerlo de forma sencilla. En lugar de lanzar estos dos comandos:

```bash
docker build -t tour-of-heroes-api:v1 tour-of-heroes-api
docker build -t tour-of-heroes-web:v1 -f tour-of-heroes-angular/Dockerfile.gh-copilot tour-of-heroes-angular
```

En el archivo `bake-multiple-images.hcl` se muestra cómo sería la configuración para este caso.

Para lanzarlo hay que usar este comando:

```bash
docker buildx bake --file bakes/bake-multiple-images.hcl
```

### 3. Generar Imagen Multiplataforma

Una de las ventajas de usar BuildKit es que podemos generar imágenes multiplataforma:

```bash
docker build --platform linux/arm64,linux/amd64,linux/386 -t halloween:v3 .

docker images --tree
```

Si quisieramos hacer esto mismo con Bake, la configuración sería la que se muestra en el archivo `bake-multiple-platforms.hcl`.

```bash
docker buildx create --name mybuilder --use 

docker buildx bake --file bakes/bake-multiple-platforms.hcl --load # --load does not work in ARM machines

docker images --tree
```

### 4. Imágenes con Múltiples Contextos

Otra de las opciones avanzadas que podemos utilizar con BuildKit es la de poder tener múltiples contextos. En este caso, por ejemplo, podríamos tener un contexto local y otro remoto:

```bash
docker build \
--build-context app=./halloween-content \
--build-context config=https://github.com/0GiS0/youtube-docker-buildx.git#main \
-t halloween:v5 \
-f Dockerfile.multicontext.remote .
```

En el archivo bake-multicontext.hcl se muestra cómo sería la configuración para este caso.

```bash
docker buildx bake --file bakes/bake-multicontext.hcl
```

Para probar el resultado puedes lanzar el siguiente comando:

```bash
docker run --name halloween -p 8080:80 -d halloween:v6
docker rm -f halloween
```


### 5. Usar Otros Builders

Si por ejemplo queremos usar un builder de Docker Build Cloud lo hacemos así:

```bash
docker buildx create --driver cloud 0gis0/returngis

docker build --builder cloud-0gis0-returngis -t tour-of-heroes-api:v3 tour-of-heroes-api
```

Y lo equivalente en bake estaría en el archivo `bake-other-builders.hcl`.

```bash
docker buildx bake --file bakes/bake-other-builders.hcl --builder cloud-0gis0-returngis
```


### 6. Exportar e Importar Caché

Y ya por último, si quisieramos exportar/importar la cache, el comando sería:

```bash
docker build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-to type=local,dest=./cache --cache-from type=local,src=./cache -t tour-of-heroes-web:v3 .
```

Y la configuración equivalente en bake estaría en el archivo `bake-cache.hcl`.

```bash
docker buildx bake --file bakes/bake-cache.hcl --load
```

### Validar Archivos Bake

Puedes usar el parámetro `--check` para comprobar que el archivo bake está bien definido:

```bash
docker buildx bake --file bakes/bake-cache.hcl --check
```

### Ejemplo Completo

Y si juntamos todos los ejemplos en algo que pudiera ser un ejemplo real, tendríamos algo así:

```bash
docker buildx bake --file bakes/bake-final.hcl
```

---

## 📁 Estructura del Proyecto

```
youtube-docker-bake/
├── bakes/                              # Archivos de configuración Bake
│   ├── bake-cache.hcl                 # Ejemplo de gestión de caché
│   ├── bake-final.hcl                 # Ejemplo completo combinado
│   ├── bake-multicontext.hcl          # Ejemplo de múltiples contextos
│   ├── bake-multiple-images.hcl       # Ejemplo de múltiples imágenes
│   ├── bake-multiple-platforms.hcl    # Ejemplo multiplataforma
│   └── bake-other-builders.hcl        # Ejemplo de builders personalizados
├── configuration/                      # Archivos de configuración
├── docs/                              # Documentación e imágenes
├── halloween-content/                 # Contenido estático para demo
├── tour-of-heroes-angular/            # Aplicación Angular de ejemplo
├── tour-of-heroes-api/                # API .NET de ejemplo
├── docker-bake.hcl                    # Configuración básica de Bake
├── Dockerfile                         # Dockerfile principal
├── Dockerfile.multicontext.remote     # Dockerfile para multicontexto
└── README.md                          # Este archivo
```

---

## 🌐 Sígueme en Mis Redes Sociales

Si te ha gustado este proyecto y quieres ver más contenido como este, no olvides suscribirte a mi canal de YouTube y seguirme en mis redes sociales:

<div align="center">

[![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UC140iBrEZbOtvxWsJ-Tb0lQ?style=for-the-badge&logo=youtube&logoColor=white&color=red)](https://www.youtube.com/c/GiselaTorres?sub_confirmation=1)
[![GitHub followers](https://img.shields.io/github/followers/0GiS0?style=for-the-badge&logo=github&logoColor=white)](https://github.com/0GiS0)
[![LinkedIn Follow](https://img.shields.io/badge/LinkedIn-Sígueme-blue?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/giselatorresbuitrago/)
[![X Follow](https://img.shields.io/badge/X-Sígueme-black?style=for-the-badge&logo=x&logoColor=white)](https://twitter.com/0GiS0)

</div>

---

¡No te olvides de darle una estrella 🌟 al repositorio si te ha gustado el contenido!

¡Nos vemos! 👋🏻