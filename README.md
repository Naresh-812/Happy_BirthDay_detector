# 🎂 Happy Birthday Sequence Detector – FPGA RTL Design

## 📘 Overview
The **Happy Birthday Design Problem** implements a digital system with a **Transmitter** and **Receiver** communicating serially.  
The transmitter continuously sends a 10-bit bitstream, while the receiver detects a **9-bit birthday pattern (Month + Date)** and counts how many times it appears in the stream.  
The number of detections is displayed on a **seven-segment display**, updated once per second.

---

## ⚙️ System Architecture

### 🔹 Main Components
1. **Transmitter**
   - Generates and transmits 10-bit data words serially (LSB-first).
   - Uses a 10-bit counter (0–1023) as data source.
   - Each frame = 10 bits → transmitted one bit per 10 kHz clock cycle.
   - Generates a `tx_done` signal every 10 cycles to indicate frame completion.
   - Counter increments once per frame → no overlap between data generation and transmission.

2. **Receiver**
   - Samples serial input (1 bit per 10 kHz clock).
   - Detects a 9-bit pattern corresponding to the date of birth (Month[3:0] + Date[4:0]).
   - Supports overlapping pattern matches.
   - Each match increments a hit counter.
   - Every second, the hit count is converted to **BCD** and displayed on the seven-segment display.

---

## 🧠 Encoding Format

| Field | Bit Width | Description | Example |
|--------|-----------|-------------|----------|
| Month | 4 bits | Encodes month number (1–12) | July = `0111` |
| Date | 5 bits | Encodes date of month (1–31) | 10 = `01010` |
| **Total** | **9 bits** | **Combined birthday sequence** | **`011101010`** |

---

## ⏱ Timing Summary

| Parameter | Description | Value |
|------------|-------------|--------|
| Clock Frequency | System clock | 10 kHz |
| Bits per Frame | Number of bits transmitted per word | 10 |
| Bit Rate | Transmission rate | 10 kHz |
| Frame Rate | Frames per second | 1 kHz |
| Counter Range | 10-bit counter (0–1023) | 1024 |
| Counter Cycle Time | Full counter cycle | ≈ 1.024 seconds |
| Display Update Rate | Display update frequency | 1 Hz |

---
Thus, each full transmission cycle repeats approximately once per second.  
A **1-second clock divider** (10,000 cycles @10kHz) is used for exact display updates.

---

