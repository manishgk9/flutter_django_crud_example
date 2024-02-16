from django.db import models

# Create your models here.


class Student(models.Model):
    name = models.CharField(max_length=100)
    address = models.CharField(max_length=150)
    phone = models.IntegerField()
    # description = models.TextField()

    def __str__(self):
        return f'name is {self.name}'
