from rest_framework.response import Response
from rest_framework.decorators import api_view
from .serializer import StudentSeriaizer
from rest_framework import generics
from .models import Student
from rest_framework import status


@api_view(['GET'])
def home(request):
    url = ['get/', 'get/id', 'delete/id']
    return Response(url)


class GetAndCreate(generics.ListCreateAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentSeriaizer


class UpdateData(generics.RetrieveUpdateAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentSeriaizer


class DeleteData(generics.DestroyAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentSeriaizer
