# -*- coding: utf-8 -*-
import time

from rest_framework.decorators import api_view
from rest_framework.response import Response

start_time = time.time()


@api_view(['GET'])
def heartbeat(request):
    return Response({
        'startTime': start_time,
        'upTime': time.time() - start_time,
        'status': 'running',
        'mode': 'simple',
    })
