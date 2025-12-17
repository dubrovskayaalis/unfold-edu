# services/image/upload.py
import uuid

def handle_upload(project_id, photos, dimensions, artifact_manager):
    job_id = str(uuid.uuid4())
    for photo in photos:
        # photo: {"filename": ..., "data": ..., "view": ...}
        artifact_manager.save_artifact(job_id, photo["filename"], photo["data"])
    meta = {
        "project_id": project_id,
        "dimensions": dimensions,
        "photos": [p["filename"] for p in photos],
    }
    artifact_manager.save_artifact(job_id, "meta.json", (str(meta) + "\n").encode())
    print(f"[PhotoUploader] Job {job_id} saved")
    return job_id, "queued"
