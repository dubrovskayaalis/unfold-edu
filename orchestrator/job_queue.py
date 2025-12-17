import queue
import threading

class JobQueue:
    def __init__(self):
        self._queue = queue.Queue()
        self._lock = threading.Lock()

    def enqueue(self, job):
        with self._lock:
            self._queue.put(job)
            print(f"[JobQueue] Enqueued job {job['id']}")

    def dequeue(self):
        with self._lock:
            if self._queue.empty():
                return None
            job = self._queue.get()
            print(f"[JobQueue] Dequeued job {job['id']}")
            return job

    def size(self):
        return self._queue.qsize()
