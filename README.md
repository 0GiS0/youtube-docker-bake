# Demos de Bake

¡Hola developer 👋🏻! Este repositorio contiene las demos de mi vídeo **15. Docker Builds como código**. Se trata de una herramienta, por ahora en fase experimental, que nos permite usar archivos para definir la configuración, o los parámetros, que tendrá nuestro comando `docker build` haciendo que incluso podamos lanzar múltiples build de forma concurrente con una sola invocación.


## 1. Configuración básica

Así sería el comando si no tuvieramos esta configuración:

```bash
docker build -t tour-of-heroes-api:v1 tour-of-heroes-api
```

El archivo `docker-bake.hcl`contiene la configuración para este caso. Para lanzarlo hay que usar este comando:

```bash
docker buildx bake
```

## 2. Generar imágen multiplataforma

```bash
docker build --platform linux/arm64,linux/amd64,linux/386 -t tour-of-heroes-api:v1 tour-of-heroes-api
```

La configuración equivalente a este comando sería `bake-multiple-platforms.hcl`. En este caso como no estamos utilizando el nombre `docker-bake.hcl`para el archivo de configuración habría que llamarlo de la siguiente forma:

```bash
docker buildx bake --file bake-multiple-platforms.hcl
```

### 3. Imágenes con múltiples contextos

Otra de las opciones avanzadas que podemos utilizar con BuildKit es la de poder tener múltiples contextos. En este caso, por ejemplo, podríamos tener un contexto local y otro remoto:

```bash
docker build \
--build-context app=./halloween-content \
--build-context config=https://github.com/0GiS0/youtube-docker-buildx.git#main \
-t halloween:multicontext-remote \
-f Dockerfile.multicontext.remote .
```

En el archivo bake-multicontext.hcl se muestra cómo sería la configuración para este caso.

```bash
docker buildx bake --file bake-multicontext.hcl
```

Para probar el resultado puedes lanzar el siguiente comando:

```bash
docker run --name halloween -p 8080:80 -d halloween:multicontext-remote 
docker rm -f halloween
```


## 3. Usar otros builders que no sea el por defecto

Si por ejemplo queremos usar un builder de Docker Build Cloud lo hacemos así:

```bash
docker build --builder 0gis0-cloud-returngis -t tour-of-heroes-api:v1 tour-of-heroes-api
```

Y lo equivalente en bake estaría en el archivo `bake-other-builders.hcl`.


## 4. Exportar e importar caché

Y ya por último, si quisieramos exportar/importar la cache, el comando sería:

```bash
docker build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-to type=local,dest=./cache -t tour-of-heroes-angular .
```




¡No te olvides de darle una estrella 🌟 al repositorio si te ha gustado el contenido! Y de suscribirte a mi canal de YouTube ❤️

¡Nos vemos! 👋🏻