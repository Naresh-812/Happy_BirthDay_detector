🎂 Happy Birthday Sequence Detector – FPGA RTL Design
🧩 Overview

The Happy Birthday Design Problem implements a simple digital communication system consisting of a Transmitter and a Receiver.
The transmitter continuously sends a 10-bit serial data stream, while the receiver detects a 9-bit pattern corresponding to a specific date of birth (Month + Date).
Every time this birthday pattern is detected in the received bit stream, the system increments a hit counter.
The count of detections per second is displayed on a seven-segment display.

⚙️ System Architecture
🔸 Top-Level Description

The design operates on a 10 kHz system clock shared by both transmitter and receiver.
It consists of two main functional blocks:

Transmitter Block

Generates and transmits 10-bit data words serially (LSB-first).

Data source: A 10-bit counter (0–1023).

Transmits 1 bit per clock → one 10-bit word every 1 ms.

Signals:

i_tx_ena_n: Active-low enable signal.

tx_done: One-clock pulse after 10-bit word transmission.

The generator counter increments only after tx_done → ensures frame synchronization.

Receiver Block

Samples one bit per clock from the serial data line.

Detects a fixed 9-bit pattern (Month[3:0] + Date[4:0]).

Increments hit counter on each pattern detection (supports overlapping matches).

Every 1 second, the hit count is:

Latched and converted to BCD.

Displayed on seven-segment display.

Counter resets for the next interval.

🧠 Encoding Format
Field	Bit Width	Description	Example
Month	4 bits	Encodes month number (1–12)	July = 0111
Date	5 bits	Encodes day of month (1–31)	10 = 01010
Total	9 bits	Combined birthday pattern	011101010
⏱ Timing Summary
Parameter	Description	Value
Clock Frequency	System Clock	10 kHz
Bits per Frame	10	
Bit Rate	10 kHz	One bit per clock
Frame Rate	1 kHz	One 10-bit frame every 1 ms
Counter Range	0–1023	10-bit counter
Counter Cycle Time	≈ 1.024 s	(1024 frames × 1 ms/frame)
Display Update Rate	1 Hz	New hit count displayed every 1 s
🧮 Maths Behind the Logic

Transmission frequency:

𝑓
𝑇
𝑋
=
𝑓
𝐶
𝐿
𝐾
𝑁
𝑏
𝑖
𝑡
𝑠
=
10
𝑘
𝐻
𝑧
10
=
1
𝑘
𝐻
𝑧
f
TX
	​

=
N
bits
	​

f
CLK
	​

	​

=
10
10kHz
	​

=1kHz

Cycle duration:

𝑇
𝑐
𝑦
𝑐
𝑙
𝑒
=
2
𝑁
𝑐
𝑜
𝑢
𝑛
𝑡
𝑒
𝑟
𝑓
𝑇
𝑋
=
1024
1
𝑘
𝐻
𝑧
≈
1.024
𝑠
T
cycle
	​

=
f
TX
	​

2
N
counter
	​

	​

=
1kHz
1024
	​

≈1.024s

Display synchronization:
Instead of relying on counter rollover, a 1-second divider (10,000 cycles at 10 kHz) is used to ensure precise 1 Hz updates.

🧱 Block Diagram
          +-----------------------+
          |     TRANSMITTER       |
          |-----------------------|
          | 10-bit Counter        |
          | Serial Shifter (LSB)  |
          | TX Control Logic      |
          +---------+-------------+
                    |
                    | Serial Data Stream (10kHz)
                    v
          +---------+-------------+
          |       RECEIVER        |
          |-----------------------|
          | 9-bit Shift Register  |
          | Pattern Comparator    |
          | Hit Counter (1s)      |
          | BCD Encoder + Display |
          +-----------------------+

🔌 Top-Level Port List
Port Name	Direction	Width	Description
i_clk	Input	1	System clock @10kHz
i_rst	Input	1	Active-high synchronous reset
i_tx_ena_n	Input	1	Active-low transmit enable
o_hit_count	Output	NumDig×7	Seven-segment display output
o_hit_count_valid	Output	1	Indicates new valid display value
🧰 Design Modules

Transmitter

Inputs: i_clk, i_rst, i_tx_ena_n

Outputs: o_tx_serial, o_tx_done

Functions:

Shifts out 10 bits serially.

Generates tx_done after transmission.

Increments generator counter.

Receiver

Inputs: i_clk, i_rst, i_serial_in

Outputs: o_hit_count, o_hit_count_valid

Functions:

Stores recent 9 bits in shift register.

Compares with fixed 9-bit birthday pattern.

Increments hit counter on match.

BCD Encoder + Display Driver

Converts binary hit count to BCD.

Drives seven-segment display.

Refreshes display once per second.

Clock Divider (1 Hz)

Divides 10 kHz clock by 10,000.

Provides a 1 Hz enable pulse for display updates.

🧪 Simulation Flow

Stimulus

Apply 10 kHz clock and reset sequence.

Set i_tx_ena_n = 0 to enable transmission.

Transmission

Observe serial data stream from transmitter.

Detection

Receiver compares sliding 9-bit window with fixed pattern.

Display Update

Once per second, hit count is displayed and counter resets.

Verification

Check o_hit_count changes every 1 second.

Verify o_hit_count_valid pulse indicates valid display update.
