from django.http import HttpResponse
from django.http import HttpRequest
from django.shortcuts import render


def home_page_view(request, *args, **kwargs):
    """
    Render the home page of the application.
    """
    return render(request, 'home.html')

def about_page_view(request: HttpRequest, *args, **kwargs) -> HttpResponse:
    """
    Render the about page of the application.
    """
    return render(request, 'about.html')