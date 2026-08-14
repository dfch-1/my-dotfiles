estoy creado mis dotfiles para aprender logica
aun no esta competo pero estoy creando una paleta de colores dark red

drivers.sh
Detecta hardware (GPU y CPU) e instala los drivers correspondientes.
Compatible con Arch Linux y distros basadas en Arch (CachyOS, Manjaro, EndeavourOS, etc.)

Caso: GPU híbrida (integrada Intel/AMD + dedicada NVIDIA/AMD) line:17

nvidia-open solo soporta Turing con firmware GSP en adelante:
RTX 20/30/40/50, TITAN RTX, y las profesionales/datacenter Turing+
(Quadro RTX, T-series, A-series, H100...). Las GTX (incluida la
línea GTX 16xx, que también es Turing pero sin GSP) se quedan con
el driver propietario clásico. line:30