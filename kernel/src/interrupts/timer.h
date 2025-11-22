#ifndef TIMER_H
#define TIMER_H

#include <stdint.h>

void timer_pit_config(void);
void init_timer(void);
void sleep(uint32_t ticks);

#endif // TIMER_H
