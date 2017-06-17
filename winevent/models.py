from django.db import models
"""WinEvent collect monitor models"""


class Computer(models.Model):
    """Computers for monitoring"""
    name = models.CharField(max_length=16)
    opersys = models.CharField(max_length=16, blank=True, default=None)
    client_version = models.IntegerField()
    create = models.DateTimeField(auto_now_add=True, auto_now=False)
    update = models.DateTimeField(
        auto_now_add=False,
        auto_now=True,
        blank=True,
        null=True
        )

    def __str__(self):
        return self.name


class WinEvent(models.Model):
    """Collected system events"""
    log_name = models.CharField(max_length=32)
    # providerName
    source = models.CharField(max_length=32)
    # id
    event_id = models.CharField(max_length=16)
    # leveldisplayname or just error, critical, etc
    level = models.CharField(max_length=16)
    # current logged user
    user = models.CharField(max_length=32, blank=True)
    # to delete not neccessary property
    opcode = models.CharField(max_length=16, blank=True)
    # message
    description = models.TextField(blank=True)
    logged = models.DateTimeField()
    task_category = models.CharField(max_length=16, blank=True)
    keywords = models.CharField(max_length=16, blank=True)
    computer = models.ForeignKey(Computer, on_delete=models.CASCADE)
    create = models.DateTimeField(auto_now_add=True, auto_now=False)
    update = models.DateTimeField(
        auto_now_add=False,
        auto_now=True,
        blank=True,
        null=True
    )

    def __str__(self):
        return "{} {}".format(self.source, self.level)
