from django.shortcuts import render

# Create your views here.
def dashboard(request):
    """Заглушка для главной борды"""
    context = {
        "vart": "Hello!"
    }
    return render(request, 'winevents/dashboard.html', context)
