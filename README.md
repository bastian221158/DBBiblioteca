# 📜 Invocando la Base de Datos "Bibliotheca Obscura" 🕯️✨

---

## 🧙‍♂️ Introducción Mística

Has llegado al grimorio digital donde se guarda el conocimiento arcano. Aquí encontrarás el script SQL que da vida a la base de datos de la *Bibliotheca Obscura*, una biblioteca secreta que custodia tomos arcanos, custodios sabios y conjuros de préstamo.

---

## 🗂️ Descarga del Script

1. Descarga el archivo `bibliotheca_obscura.sql` desde el enlace provisto (o tu repositorio).

2. Guarda el archivo en una ubicación conocida, por ejemplo:
```
C:\Users\TuUsuario\Documentos\`
```

---

## ⚔️ Cómo Ejecutar el Script en MariaDB usando CMD (Windows)

### Paso 1: Abre la consola CMD

Presiona `Win + R`, escribe `cmd` y presiona Enter.

---

### Paso 2: Navega a la carpeta donde guardaste el script

```batch
cd C:\Users\TuUsuario\Documentos\
```
Paso 3: Inicia sesión en MariaDB
```bash
mysql -u tu_usuario -p
```
(Se te pedirá tu contraseña; escríbela y presiona Enter.)

Paso 4: Carga el script que contiene los hechizos (tablas, funciones, triggers...)
```sql
SOURCE bibliotheca_obscura.sql;
```
Paso 5: ¡Listo!
Los conjuros han sido invocados y la base de datos está lista para usarse.

🛡️ Notas y consejos
Asegúrate de tener MariaDB instalado y agregado a las variables de entorno para que el comando mysql funcione en CMD.

Si tu usuario no tiene privilegios para crear bases de datos, usa un usuario administrador.

Puedes usar herramientas gráficas como HeidiSQL o DBeaver para cargar y manejar la base con magia visual.

🧙‍♀️ Fin del ritual
¡Que la sabiduría oculta fluya y la Biblioteca Obscura ilumine tu camino!
