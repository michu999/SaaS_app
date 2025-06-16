from django.db import models

# Create your models here.
class Visit(models.Model):
    """
    Model to track visits to the application.
    """
    visit_time = models.DateTimeField(auto_now_add=True)
    user_agent = models.CharField(max_length=255, blank=True, null=True)
    ip_address = models.GenericIPAddressField(blank=True, null=True)

    def __str__(self):
        return f"Visit at {self.visit_time} from {self.ip_address}"