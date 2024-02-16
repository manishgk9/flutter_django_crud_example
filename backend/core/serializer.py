from rest_framework import serializers
from .models import Student


class StudentSeriaizer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = '__all__'
