# gateway/server.py
import time
from concurrent import futures
import grpc
from . import cnc_pb2 
from . import cnc_pb2_grpc
from .orchestrator.orchestrator import Orchestrator

# Если FastAPI будет на другом хосте/порту, передай сюда соответствующий public_base
orch = Orchestrator(public_base="http://127.0.0.1:8080/artifacts")

class GatewayServicer(cnc_pb2_grpc.GatewayServicer):
    def UploadPhotos(self, request, context):
        photos = [{"filename": p.filename, "data": p.data, "view": p.view} for p in request.photos]
        dimensions = [{"name": d.name, "value": d.value} for d in request.dimensions]
        job_id, status = orch.handle_upload_photos(request.project_id, photos, dimensions)
        return cnc_pb2.UploadPhotosResponse(job_id=job_id, status=status)

    def GetArtifacts(self, request, context):
        artifacts = orch.handle_get_artifacts(request.job_id)
        return cnc_pb2.GetArtifactsResponse(
            artifacts=[cnc_pb2.ArtifactRef(type=a["type"], url=a["url"]) for a in artifacts]
        )

    def ModelToUnfold(self, request_iterator, context):
        chunks = [chunk.data for chunk in request_iterator]
        job_id, status = orch.handle_model_to_unfold(chunks)
        return cnc_pb2.UploadPhotosResponse(job_id=job_id, status=status)

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    cnc_pb2_grpc.add_GatewayServicer_to_server(GatewayServicer(), server)
    server.add_insecure_port('[::]:50051')
    print("gRPC Gateway running on port 50051")
    server.start()
    try:
        while True:
            time.sleep(86400)
    except KeyboardInterrupt:
        server.stop(0)

if __name__ == '__main__':
    serve()
