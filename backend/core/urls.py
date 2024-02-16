from django.urls import path
from . import views

urlpatterns = [
    path('', views.home),
    path('get/', views.GetAndCreate.as_view()),
    path('get/<int:pk>', views.UpdateData.as_view()),
    path('delete/<int:id>/', views.DeleteData.as_view())
]
