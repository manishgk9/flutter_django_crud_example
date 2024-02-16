from django.contrib import admin
from .models import Student


class StudentAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'address', 'phone']


admin.site.register(Student, StudentAdmin)
