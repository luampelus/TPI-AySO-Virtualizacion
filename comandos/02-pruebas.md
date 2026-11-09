# Pruebas realizadas

Las tres pruebas se hicieron a mano, porque combinan comandos dentro de la VM con acciones en VirtualBox y en Windows.

## Prueba 1: red NAT vs Bridge

En la VM, con el adaptador en **NAT** (por defecto):

```bash
ip a          # enp0s3 → inet 10.0.2.15/24
```

Desde un celular en el mismo wifi: `http://10.0.2.15` → **ERR_CONNECTION_TIMED_OUT**.

En VirtualBox: *Dispositivos → Red → Configuración de red… → Conectado a: Adaptador puente* (placa Wi-Fi Realtek RTL8723BE). Después, en la VM:

```bash
sudo reboot
ip a          # enp0s3 → inet 192.168.0.124/24 (misma MAC 08:00:27:43:07:d8)
```

Desde el celular: `http://192.168.0.124` → **se ve la página**.

## Prueba 2: memoria de la VM vista desde Windows

1. Con la VM encendida: Administrador de tareas → *Procesos* → «VirtualBox Virtual Machine» → **87,5 MB**.
2. *Rendimiento → Memoria* → **7,9 GB** en uso.
3. Se apaga la VM → **5,6 GB** en uso. Windows libera **2,3 GB**: la RAM del invitado es RAM real del anfitrión, reservada por el driver de kernel de VirtualBox fuera del proceso visible.

## Prueba 3: snapshot y restauración

1. VirtualBox → *Instantáneas* → **Tomar** → «Apache funcionando».
2. En la VM se simula un error grave:

```bash
sudo apt remove -y apache2
curl localhost   # curl: (7) Failed to connect to localhost port 80
```

3. Se cierra la VM → *Apagar la máquina* → marcar **Restaurar instantánea actual**.
4. Se inicia otra vez:

```bash
curl localhost   # responde la página propia
```

Como el snapshot se tomó con la VM encendida, se restauran el disco y también el estado de la memoria.
