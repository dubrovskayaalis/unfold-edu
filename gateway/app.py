import asyncio, json, os
from websockets.server import serve
import grpc
from concurrent import futures
import cnc_pb2, cnc_pb2_grpc
import uuid

WS_CLIENTS = {}

class GatewayService(cnc_pb2_grpc.GatewayServicer):
    async def UploadPhotos(self, request, context):
        job_id = f"J-{uuid.uuid4()}"
        # Публикуем задачу во внутреннюю шину (ZeroMQ PUB)
        # Здесь только заглушка
        # send_to_zmq({"topic":"image.extract","jobId":job_id, "payload": {...}})
        return cnc_pb2.UploadPhotosResponse(job_id=job_id, status="QUEUED")

    async def GetArtifacts(self, request, context):
        # Заглушка: вернём пусто
        return cnc_pb2.GetArtifactsResponse()

    async def ModelToUnfold(self, request_iterator, context):
        job_id = f"J-{uuid.uuid4()}"
        # Принять стрим байтов модели и сохранить в хранилище
        return cnc_pb2.UploadPhotosResponse(job_id=job_id, status="QUEUED")

async def ws_handler(websocket):
    job_id = await websocket.recv()
    WS_CLIENTS[job_id] = websocket
    await websocket.send(json.dumps({"jobId": job_id, "stage": "QUEUED", "progress": 0.0}))

async def start_ws():
    async with serve(ws_handler, "0.0.0.0", 8080, ping_interval=20, ping_timeout=20):
        await asyncio.Future()

async def start_grpc():
    server = grpc.aio.server()
    cnc_pb2_grpc.add_GatewayServicer_to_server(GatewayService(), server)
    server.add_insecure_port("[::]:50051")
    await server.start()
    await server.wait_for_termination()

if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.create_task(start_ws())
    loop.run_until_complete(start_grpc())
