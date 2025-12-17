import os

class ArtifactManager:
    def __init__(self, base_dir="storage/artifacts"):
        self.base_dir = base_dir
        os.makedirs(self.base_dir, exist_ok=True)

    def save_artifact(self, job_id, filename, data: bytes):
        job_dir = os.path.join(self.base_dir, job_id)
        os.makedirs(job_dir, exist_ok=True)
        path = os.path.join(job_dir, filename)
        with open(path, "wb") as f:
            f.write(data)
        print(f"[ArtifactManager] Saved {filename} for job {job_id}")
        return path

    def list_artifacts(self, job_id):
        job_dir = os.path.join(self.base_dir, job_id)
        if not os.path.exists(job_dir):
            return []
        return [os.path.join(job_dir, f) for f in os.listdir(job_dir)]
