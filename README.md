# 🧠 DeepSeek Local WebUI

Este proyecto levanta una instancia local del modelo **DeepSeek-Coder 6.7B Instruct** utilizando GPU, con acceso web protegido mediante Caddy como reverse proxy.

> Modelo ideal para tareas de programación asistida y chat LLM especializado en código.
> Se ejecuta en contenedores Docker con soporte GPU (NVIDIA) y puede integrarse a flujos internos o pruebas de concepto.

---

## 🛠 Requisitos

- Docker y Docker Compose v2
- GPU NVIDIA (recomendado: 16 GB VRAM o más)
- NVIDIA Container Toolkit instalado y funcionando
- Caddy como reverse proxy (incluido automáticamente)
- Acceso a puertos `80`, `443` y `7860`

---

## 🚀 Instrucciones de uso

### 1. Clonar este repositorio

```bash
git clone https://github.com/aweher/deepseek-local-webui.git
cd deepseek-local-webui
```

### 2. Configurar entorno GPU (si no lo hiciste antes)

```bash
sudo apt install nvidia-container-toolkit
sudo systemctl restart docker
```

Asegurate de tener este bloque en `/etc/docker/daemon.json`:

```json
{
  "default-runtime": "nvidia",
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  }
}
```

### 3. Levantar los contenedores

```bash
docker compose up --build
```

Esto:

- Compila el contenedor con todo instalado desde cero
- Descarga el modelo `deepseek-ai/deepseek-coder-6.7b-instruct`
- Expone la interfaz web en `http://localhost`

---

## 📦 Estructura del proyecto

```
.
├── Dockerfile               # Imagen de ejecución con GPU
├── docker-compose.yml       # Orquestación de servicios
├── Caddyfile                # Reverse proxy con autenticación básica
└── README.md
```

---

## 💡 ¿Para qué sirve esto?

- Ejecutar localmente un modelo LLM para desarrollo de código
- Interactuar con DeepSeek vía navegador web
- Integrar la API en herramientas internas (mediante extensión futura)
- Probar cargas sin enviar datos a la nube

---

## 🧪 Próximos pasos

- [ ] Agregar red Docker con `bip` e IPv6
- [ ] Activar modo API REST para acceso programático
- [ ] Implementar múltiples modelos para benchmark local
- [ ] Integración con herramientas como n8n, VSCode, Postman, etc.

---

## 🧠 Créditos

- [DeepSeek](https://huggingface.co/deepseek-ai)
- [text-generation-webui](https://github.com/oobabooga/text-generation-webui)
- [Caddy Server](https://caddyserver.com/)
- [Ayuda.LA](https://ayuda.la)
