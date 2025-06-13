---
title: Embedded communication technologies
date: 2025-06-13
---

Embedded systems with >1 boards need a way for the boards to communicate.

When possible, prefer a star topology - this makes dealing with failures much easier, as well as debugging.
A device acting as a bridge complicates things, because a network partition can easily occur.

## CAN bus

Reliable! If the receiver actually is on the bus.
Deterministic! Messages have a priority.
Multimaster.
Relatively slow, both for bandwidth and latency.
Can be hooked up to a PC relatively easily, using a convertor; good Wireshark support as well.
Suitable for medium distances with good, shared grounding.

## Ethernet

Good old ethernet.
Fast - 100Mb/s typical.
Large packets possible.
Cheap.
Off the shelf cables, albeit not waterproof ones.
Unreliable physical layer - packet loss is possible.
If using a switch, both packet loss and packet reordering is possible.
Isolation at the bus level, so suitable for long distances and between devices with different grounds - other physical layers like optical also possible.
Multimaster.
Native interop with most computers, although easiest on Linux if using raw frames.

IP adds a lot of complexity.
UDP is basically "raw frames but for IP".
TCP isn't suitable for real time traffic due to very much non-real time delays.

Implementing a reliable transmission is tricky. Options:

- ACK/NAK. This is hard to get right and needs timeouts.
- Periodic resend. Works OK if there is a solid state machine for the protocol. Timeouts must be carefully chosen. It is possible to use a sequence counter on the receiver end to discard duplicates, but it is better to make operations idempotent.

Some kind of connection is also advised, but it is basically a state machine so that both ends agree on where in the sequence they are.

## EtherCAT

Looks interesting.
Uses off the shelf cables.
Sounds like it supports very low latencies - might be a great bus for "dumb node" systems.
Integration with a PC seems difficult, which negates some of the advantages?
Relatively specialized receiver hardware required; expensive?
Circular design might create some "interesting" cabling design choices.

## Modbus

Slow, and a bit flaky.
Old technology; easy enough to implement.
Mostly suited for polling data retrieval or configuration due to high latency and bandwidth restrictions.
Used over twisted pair, so can have relatively long cable runs.
Suits daisy chaining since the bus is inherently shared.

## OneWire

For external sensors and things; not sure of the distance limitations.
Has a neat chip addressing scheme, based on a serial number and family type baked into the chip, with a binary search to make things fast.
Relatively easy to code up, seems robust enough for simple things.
Seems to be limited to one manufacturer.
Literally one wire - plus power/GND.
ESD protection mandatory as goes straight to an MCU pin!
Some EEPROMs require extra circuitry for providing extra power.
CRC for addresses but no CRC for data.

## I2C

PCB internal communication bus.
Bus is prone to locking up.
Not very high performance.
MCU implementations often are buggy.
Need correct pull up resistors and a reasonable bus design, or problems will occur.
An addressable bus, so less MCU pins are required.
Multimaster, although I've never seen that functionality used.

## SPI

PCB internal communication bus.
Easy to work with.
Fast - potentially in MHz.
Generally good hardware support.
No consistency in physical layer, eg choices for clock polarity, data signal low, chip select low.
Need a CS for each chip; some chips don't play nice with other chips on the same bus.


