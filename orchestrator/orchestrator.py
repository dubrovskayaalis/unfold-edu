# orchestrator/orchestrator.py
import uuid
from orchestrator.job_queue import JobQueue
from services.storage.artifact_manager import ArtifactManager
from services.image.upload import handle_upload
from services.unfold.inference import run_inference

class Orchestrator:
    def __init__(self, public_base="http://127.0.0.1:8080/artifacts"):
        self.queue = JobQueue()
        # Передаём public_base в менеджер, чтобы он формировал корректные URL
        self.artifacts = ArtifactManager(public_base=public_base)

    def handle_upload_photos(self, project_id, photos, dimensions):
        # Делегируем сохранение в сервис image
        job_id, status = handle_upload(project_id, photos, dimensions, artifact_manager=self.artifacts)
        # Добавляем в очередь для дальнейшей обработки, если нужно
        self.queue.enqueue({
            "id": job_id,
            "type": "upload_photos",
            "project_id": project_id,
            "dimensions": dimensions,
        })
        # Возвращаем job_id и статус
        return job_id, status

    def handle_get_artifacts(self, job_id):
        items = self.artifacts.list_artifacts(job_id)
        # Преобразуем в формат, ожидаемый gateway
        return [{"type": self._type_from_name(i["filename"]), "url": i["url"]} for i in items]

    def handle_model_to_unfold(self, chunks):
        job_id, status = run_inference(chunks, artifact_manager=self.artifacts)
        self.queue.enqueue({
            "id": job_id,
            "type": "model_to_unfold",
        })
        return job_id, status

    @staticmethod
    def _type_from_name(name: str) -> str:
        name = name.lower()
        if name.endswith((".png", ".jpg", ".jpeg", ".gif", ".bmp", ".webp")):
            return "image"
        if name.endswith(".json"):
            return "json"
        if name.endswith(".bin"):
            return "binary"
        return "file"
