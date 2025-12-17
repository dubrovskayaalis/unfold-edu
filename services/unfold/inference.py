# services/unfold/inference.py
import uuid
from services.model.model import UnfoldModel

def run_inference(chunks, artifact_manager):
    job_id = str(uuid.uuid4())
    data = b"".join(chunks)
    model = UnfoldModel()
    result = model.run(data)
    artifact_manager.save_artifact(job_id, "model.bin", data)
    artifact_manager.save_artifact(job_id, "result.json", (str(result) + "\n").encode())
    print(f"[Inference] Job {job_id} processed")
    return job_id, "processed"
