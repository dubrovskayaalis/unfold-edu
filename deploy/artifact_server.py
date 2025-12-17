# deploy/artifact_server.py
import os
from fastapi import FastAPI, HTTPException
from fastapi.responses import FileResponse, HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from urllib.parse import quote

# Путь к артефактам (абсолютный)
ARTIFACTS_DIR = os.path.abspath("services/storage/artifacts")
os.makedirs(ARTIFACTS_DIR, exist_ok=True)

app = FastAPI(title="Artifact Server")

# Разрешаем CORS для разработки (фронт может быть на другом порту)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],            # в продакшне сузить список
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Монтируем статические файлы (опционально)
app.mount("/static", StaticFiles(directory=ARTIFACTS_DIR), name="static")

@app.get("/", response_class=HTMLResponse)
def index():
    """
    Простой HTML-индекс: список job_id и ссылки на файлы.
    """
    jobs = sorted([d for d in os.listdir(ARTIFACTS_DIR) if os.path.isdir(os.path.join(ARTIFACTS_DIR, d))])
    html = ["<html><head><meta charset='utf-8'><title>Artifacts</title></head><body>"]
    html.append("<h1>Artifacts</h1>")
    if not jobs:
        html.append("<p>No jobs found.</p>")
    else:
        html.append("<ul>")
        for job in jobs:
            html.append(f"<li><strong>{job}</strong><ul>")
            job_dir = os.path.join(ARTIFACTS_DIR, job)
            files = sorted(os.listdir(job_dir))
            if not files:
                html.append("<li><em>no files</em></li>")
            else:
                for f in files:
                    url = f"/artifacts/{quote(job)}/{quote(f)}"
                    html.append(f"<li><a href='{url}' target='_blank'>{f}</a></li>")
            html.append("</ul></li>")
        html.append("</ul>")
    html.append("</body></html>")
    return HTMLResponse("".join(html))

@app.get("/artifacts/{job_id}/{filename}")
def get_artifact(job_id: str, filename: str):
    job_dir = os.path.join(ARTIFACTS_DIR, job_id)
    if not os.path.isdir(job_dir):
        raise HTTPException(status_code=404, detail="Job not found")
    file_path = os.path.join(job_dir, filename)
    if not os.path.isfile(file_path):
        raise HTTPException(status_code=404, detail="File not found")
    return FileResponse(path=file_path, filename=filename)

if __name__ == "__main__":
    # Запуск напрямую: uvicorn.run принимает объект app
    uvicorn.run(app, host="127.0.0.1", port=8080, reload=False)
