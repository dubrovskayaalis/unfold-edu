# services/storage/artifact_manager.py
import os
from urllib.parse import quote

class ArtifactManager:
    def __init__(self, base_dir="services/storage/artifacts", public_base="http://127.0.0.1:8080/artifacts"):
        self.base_dir = os.path.abspath(base_dir)
        self.public_base = public_base.rstrip("/")
        os.makedirs(self.base_dir, exist_ok=True)

    def save_artifact(self, job_id, filename, data: bytes):
        job_dir = os.path.join(self.base_dir, job_id)
        os.makedirs(job_dir, exist_ok=True)
        path = os.path.join(job_dir, filename)
        with open(path, "wb") as f:
            f.write(data)
        print(f"[ArtifactManager] Saved {filename} for job {job_id}")
        # Возвращаем публичный URL
        return f"{self.public_base}/{quote(job_id)}/{quote(filename)}"

    def list_artifacts(self, job_id):
        job_dir = os.path.join(self.base_dir, job_id)
        if not os.path.exists(job_dir):
            return []
        files = sorted(os.listdir(job_dir))
        # Возвращаем список словарей с именем и публичным URL
        return [{"filename": f, "url": f"{self.public_base}/{quote(job_id)}/{quote(f)}"} for f in files]
