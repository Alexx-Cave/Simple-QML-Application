# QML Window Factory

[![Qt](https://img.shields.io/badge/Qt-6.0+-brightgreen)](https://www.qt.io)
[![C++](https://img.shields.io/badge/C++-17-blue)](https://isocpp.org)

---

### Overview
**QML Window Factory** is a lightweight test application built with **Qt 6** and **C++** that demonstrates dynamic window creation from QML.  
It features a main window with a button — each click spawns a **new independent QML window** on the fly.

### Purpose
- Test QML engine integration with C++ backend.
- Demonstrate `QQmlApplicationEngine` + manual window instantiation.
- Provide a clean foundation for experimenting with dynamic QML components.

### Features
- 🚀 **One-click window spawning** — each press creates a brand new window.
- 🧩 **Pure QML frontend** + C++ core logic.
- 🔁 **No limit** on the number of windows (test your memory!).
- ⚡ Lightweight and responsive.

### Build & Run
```bash
# Clone the repo
git clone <your-repo-url>
cd qml-window-factory

# Build with CMake
mkdir build && cd build
cmake .. && make

# Run
./appuntitled
```
### Requirements
- Qt 6.2+ (or 5.15 with minor adjustments)
- CMake 3.16+
- C++17 compiler

---
