# 📈 YooFinans

💹 Plataforma para simular carteras de inversión en ETF y fondos indexados con precios reales de mercado.

YooFinans permite construir carteras virtuales, simular compras y ventas, programar aportaciones periódicas, comparar estrategias y estimar la fiscalidad española de las ganancias, todo sin arriesgar dinero real. 🔍📊

> ⚠️ YooFinans no es un broker, no ejecuta órdenes en mercados financieros y no ofrece asesoramiento financiero ni fiscal. Todas las operaciones son simuladas y las estimaciones fiscales son orientativas.

🌐 Dirección prevista: `yoofinans.noemmang.com`

## 🧭 Más que un simulador

Una hoja de cálculo sirve para apuntar compras y calcular una rentabilidad. YooFinans va más allá:

- 📡 Usa **precios reales** descargados automáticamente cada día, sin datos inventados.
- 🧮 Calcula **comisiones configurables** y **fiscalidad española** por ejercicio, con ventas parciales y compensación de pérdidas.
- 🔁 Distingue entre **simulación de cartera** y **backtesting** con datos históricos.
- 📈 Ofrece **dashboards** con evolución, distribución y rentabilidad por instrumento y por periodo.
- 🔔 Avisa mediante **alertas de precio** comprobadas por tareas programadas.
- 🏦 Trata igual ETF y fondos tradicionales, con reglas de ejecución propias para cada uno.

## 🎓 Finalidad del proyecto

Es un proyecto personal publicado con fines didácticos y educativos. Sirve para aprender y probar:

- 🏛️ **Arquitectura hexagonal** dentro de un monolito modular.
- ☕ **Backend Java** con Spring Boot, JPA y PostgreSQL.
- 💶 **Cálculo financiero preciso** con `BigDecimal`.
- 🧪 **Pruebas** de reglas de negocio y de arquitectura.
- 🔐 **Autenticación** con JWT y refresh token.
- ⏱️ **Tareas programadas** independientes del backend.
- 🅰️ **Frontend Angular** con soporte bilingüe.
- ☁️ **Despliegue en la nube** con escalado a cero y coste mínimo.
- 🔄 **CI/CD** con GitHub Actions.

## 🏗️ Arquitectura

YooFinans es un **monolito modular** con **arquitectura hexagonal**. No usa microservicios: para un proyecto de este tamaño añadirían complejidad sin aportar nada.

```
            Navegador
                │
                ▼
     Angular (frontend estático)
                │  REST + JWT
                ▼
  ┌───────────────────────────────┐
  │  Backend Spring Boot          │
  │  (monolito modular)           │
  └───────────────┬───────────────┘
                  │
                  ▼
        PostgreSQL (Neon)
                  ▲
                  │
  Job de ingestión ───► Fuente de precios
```

El **Job de ingestión** usa el mismo código y la misma imagen que el backend, arrancado con otro perfil. Descarga los precios, los valida, los guarda y termina.

### 🧩 Módulos

| Módulo | Responsabilidad |
|---|---|
| `identity` | Usuarios y autenticación |
| `portfolio` | Carteras y posiciones |
| `trading` | Compras, ventas y órdenes |
| `instruments` | Catálogo de ETF y fondos |
| `marketdata` | Proveedores, precios e histórico |
| `analytics` | Rentabilidad y estadísticas |
| `investmentplans` | Aportaciones periódicas |
| `tax` | Reglas fiscales y estimaciones |
| `alerts` | Alertas de precio |
| `simulation` | Simulaciones y backtesting |

### ⬡ Capas de cada módulo

```
modulo/
├── domain/        entidades y reglas de negocio (Java puro)
├── application/   casos de uso y puertos
└── adapter/
    ├── in/        controladores REST y tareas programadas
    └── out/       persistencia y clientes externos
```

El dominio no depende de Spring ni de JPA. Las reglas de dependencia entre capas se verifican con tests de arquitectura.

## 🛠️ Stack tecnológico

### ⚙️ Backend
- ☕ Java 25 (LTS)
- 🌱 Spring Boot 4.1
- 📦 Maven
- 🗄️ Spring Data JPA / Hibernate
- 🔀 Flyway (migraciones de base de datos)
- 🔐 Spring Security con JWT
- 💶 `BigDecimal` para importes y cantidades

### 🎨 Frontend
- 🅰️ Angular (componentes standalone y signals)
- 🧱 Angular Material
- 📊 Apache ECharts
- 🌍 Transloco (español e inglés)

### 🗃️ Datos
- 🐘 PostgreSQL
- ☁️ Neon (PostgreSQL gestionado con suspensión automática)

### 🧪 Calidad
- ✅ JUnit 5 y Mockito
- 🐳 Testcontainers
- 🏛️ ArchUnit

### ☁️ Infraestructura y DevOps
- 🐳 Docker
- 🔄 GitHub Actions
- 🤖 Dependabot
- 🚀 Azure Container Apps y Azure Container Apps Jobs
- 🌐 Azure Static Web Apps

## ✨ Funcionalidades principales

- 💼 Carteras virtuales con saldo, posiciones e historial de operaciones.
- 🛒 Compras y ventas simuladas, incluidas ventas parciales.
- 💸 Comisiones fijas, porcentuales o combinadas.
- 🇪🇸 Estimación de la fiscalidad española, versionada por ejercicio.
- 📊 Dashboard con patrimonio, rentabilidad, evolución y distribución.
- 🔁 Planes de inversión periódica.
- ⏪ Simulaciones históricas y backtesting.
- 🔔 Alertas de precio.
- 🎯 Objetivos de inversión.
- 🧾 Informe fiscal anual orientativo.
- 🌍 Interfaz en español e inglés.

## 📚 Fuentes de datos

La aplicación trabaja con **precios diarios reales** de ETF UCITS. Los instrumentos iniciales son dos ETF de iShares:

- 🌎 iShares Core S&P 500 UCITS ETF (acumulación)
- 🌐 iShares Core MSCI World UCITS ETF (acumulación)

La fuente de precios está en evaluación. El acceso a los datos se hace a través de una capa de integración, de modo que el proveedor puede cambiarse sin tocar el motor de inversión. Los datos nunca se inventan: si faltan, se registra el hueco.

## 🔌 API

La API REST estará documentada con OpenAPI (Swagger UI) y protegida con JWT. Esta sección se completará cuando exista.

## 🔄 CI/CD

🚧 Previsto. Un workflow de GitHub Actions que, en cada pull request y en cada push a `main`:

- 🔨 Compila el backend y el frontend.
- 🧪 Ejecuta los tests, incluidos los de arquitectura.
- 🐳 Construye la imagen de contenedor.
- ☁️ Despliega en Azure desde `main`.

## ☁️ Despliegue en Azure

🚧 Previsto. El objetivo es un coste mensual de unos 10 € como máximo, con escalado a cero:

| Componente | Servicio |
|---|---|
| Backend | Azure Container Apps (puede bajar a cero réplicas) |
| Actualización diaria de precios | Azure Container Apps Jobs |
| Frontend | Azure Static Web Apps |
| Base de datos | Neon (Frankfurt) |

Se aceptan arranques en frío del backend a cambio de mantener el gasto muy bajo.

## 🚧 Estado del proyecto

🟡 **En desarrollo activo.** Se construye por fases y la arquitectura puede cambiar por el camino.

| Fase | Contenido | Estado |
|---|---|---|
| 0 | Repositorio y estructura base | 🟡 En curso |
| 1 | Datos de mercado y actualización diaria | ⬜ Pendiente |
| 2 | Usuarios y carteras | ⬜ Pendiente |
| 3 | Compras y ventas | ⬜ Pendiente |
| 4 | Dashboard y análisis | ⬜ Pendiente |
| 5 | Planes periódicos y simulaciones | ⬜ Pendiente |
| 6 | Alertas | ⬜ Pendiente |
| 7 | Fiscalidad | ⬜ Pendiente |
| 8 | Fondos indexados tradicionales | ⬜ Pendiente |
| 9 | Objetivos y ampliaciones | ⬜ Pendiente |

## 📂 Estructura del repositorio

```
yoofinans/
├── backend/     API Spring Boot
├── frontend/    aplicación Angular
├── infra/       Docker y notas de Azure
├── docs/        documentación
└── .github/     workflows de GitHub Actions
```

## 📄 Licencia

Este proyecto no tiene una licencia de uso abierto: todos los derechos están reservados. El código es público y puede consultarse y revisarse con fines educativos y de evaluación. No se autoriza su uso comercial ni su redistribución sin permiso del autor.

## 👨‍💻 Autor

**Noe Mmang Obono**

🐙 GitHub: [@noemmang](https://github.com/noemmang)

Proyecto publicado con fines didácticos y educativos. 🎓📚