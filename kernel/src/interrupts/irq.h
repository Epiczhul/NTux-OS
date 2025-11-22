#ifndef IRQ_H
#define IRQ_H

#include <stdint.h>

// Funktion zum Installieren eines IRQ-Handlers
void irq_register_handler(int irq, void (*handler)(void));

// IRQ-Handler, der von den IRQ-Stubs aufgerufen wird
void irq_handler_c(uint64_t *stack);

#endif
