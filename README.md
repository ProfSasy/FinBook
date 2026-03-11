# 📊 FinBook

> **La tua app di finanza personale e educazione finanziaria** — Gestisci, impara, simula.

FinBook è un'applicazione mobile **FinTech + EdTech** pensata per **Gen Z e Millennials** che vogliono prendere il controllo delle proprie finanze e colmare il gap di alfabetizzazione finanziaria evidenziato dai dati PISA 2022 e dalle ricerche universitarie italiane.

---

## 🚀 Le 3 Sezioni

### 🏦 Wallet — Gestione Finanze Reali
- Collegamento bancario **SOLA LETTURA** (Open Banking AISP) o inserimento manuale
- Dashboard con saldo, spese mensili e breakdown per categoria
- Tracker **abbonamenti** con costo mensile e annuale
- **Obiettivi di risparmio** con progress visuale
- Tracker **Piani di Accumulo Capitale (PAC)** con grafici di crescita

### 📚 Academy — Tutor AI "Finny" *(in sviluppo)*
- Assessment iniziale con test di piazzamento dinamico generato da IA
- Percorso gamificato **Duolingo-style** con albero delle competenze
- Dai concetti base fino a nozioni universitarie

### 🎮 Palestra — Simulatore Finanziario *(in sviluppo)*
- Simulazioni interattive (budget mensile, investimenti, imprevisti)
- **Analizzatore post-partita stile Chess.com**: ogni scelta viene classificata come:
  - 🔴 Errore Grave (Blunder)
  - 🟠 Imprecisione
  - 🟢 Buona Scelta
  - 🌟 Mossa Eccellente
- L'IA spiega l'alternativa ottimale per ogni decisione

---

## 🛠️ Stack Tecnologico

| Layer | Tecnologia |
|-------|-----------|
| **Frontend** | Flutter (Android, iOS, Web) |
| **State Management** | Riverpod v3 |
| **Routing** | GoRouter (StatefulShellRoute) |
| **Charts** | fl_chart |
| **Backend** | Supabase *(pianificato)* |
| **AI/LLM** | Gemini API *(pianificato)* |
| **Open Banking** | Plaid / Fabrick *(pianificato)* |

---

## 📦 Quick Start

```bash
# Clona il repository
git clone https://github.com/ProfSasy/FinBook.git
cd FinBook

# Installa le dipendenze
flutter pub get

# Avvia l'app (web)
flutter run -d chrome

# Avvia l'app (mobile)
flutter run
```

---

## 📁 Struttura Progetto

```
lib/
├── core/
│   ├── providers/      # Riverpod state management
│   ├── router/         # GoRouter navigation
│   └── theme/          # Design system (colors, typography, spacing)
├── data/
│   ├── mock/           # Dati mock realistici mercato italiano 2026
│   └── models/         # Data models
└── features/
    ├── wallet/         # 🏦 Sezione 1: Finanze
    │   ├── dashboard/
    │   ├── onboarding/
    │   ├── subscriptions/
    │   ├── goals/
    │   └── pac/
    ├── academy/        # 📚 Sezione 2: Academy (placeholder)
    └── simulator/      # 🎮 Sezione 3: Simulatore (placeholder)
```

---

## 🎯 Contesto

Nasce in un contesto macroeconomico critico (2026): inflazione alta sui beni essenziali e crescita del consumo per beni non essenziali. L'app si rivolge a chi cerca:

1. **Uno strumento pratico** per gestire le finanze quotidiane
2. **Un percorso formativo** per studiare economia da zero o colmare lacune specifiche

---

<p align="center">
  Made with 💚 in Italia
</p>
