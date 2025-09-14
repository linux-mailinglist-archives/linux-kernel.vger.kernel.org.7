Return-Path: <linux-kernel+bounces-815729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2E8B56A60
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A762B17D62B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A02DCF73;
	Sun, 14 Sep 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HtZpe4lb"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346FC2DCF69
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865473; cv=none; b=QWFQh/9CLv4+rIInLxpn8Efeyan5WcglB1uu09/kz+95xex6woHWnQdfHTMEPeOQ9gUZV48q5zfmjSAlkvpPYrFkDolEV0uGr6NqDShBeRkkaXJh0+bzJF3LInpIk1pndXv10eAiHi7h4JwvN3UT3bGPIMX+Xdho2QEBEy39GNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865473; c=relaxed/simple;
	bh=bN7JgM0k0U/9inC1tbWjnv1SjLrvbkqAqo6w80vJGaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prv7ByEUvRaoyDVpUHN3AbMkdk9/Od/gCQxbIJrFpIBJ/iopTqD4JTLvigm6nAJYZlI2RWxcLZ99u7oDxjLlPj5+IhswnDyB4ACHfQZylBaDpBeCSURCOvstklSVTNf1hdgW69OONdMNdrVlGFf/kgGt8bJRPAkcm/QVonOm/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HtZpe4lb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDYOBZP09xty0+mF9o95/f9Ufo6O5DV5hlHkQg1lE/Q=;
	b=HtZpe4lbK10DVj9wfGEsCbadWzRatbYLZE9PgJsHf4pqaqtS1nkRGCeBXlr3404daI98qJ
	o8ALoiqXv93VGYvzi1VT+MojDUkxUKoDff1czWi52zF3hoP0nT0ThSDPoX+r/13vZjEjDP
	2GflEG6KTeVPlygvrtIUCBwAm3gf/wM=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v3 3/7] um: Define timers on a per-CPU basis
Date: Sun, 14 Sep 2025 23:56:54 +0800
Message-Id: <20250914155658.1028790-4-tiwei.bie@linux.dev>
In-Reply-To: <20250914155658.1028790-1-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

Define timers on a per-CPU basis to enable each CPU to have its
own timer. This is a preparation for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/linux/time-internal.h |  3 ++
 arch/um/include/shared/os.h           |  6 +--
 arch/um/kernel/irq.c                  |  2 +-
 arch/um/kernel/time.c                 | 58 +++++++++++++++++++--------
 arch/um/os-Linux/main.c               |  2 +-
 arch/um/os-Linux/time.c               | 29 +++++++++-----
 6 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 138908b999d7..c274eb5ad55e 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -90,4 +90,7 @@ extern unsigned long tt_extra_sched_jiffies;
  * which is intentional since we really shouldn't link it in that case.
  */
 void time_travel_ndelay(unsigned long nsec);
+
+int um_setup_timer(void);
+
 #endif /* __TIMER_INTERNAL_H__ */
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 324d4eed3385..0ca6e4548671 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -269,9 +269,9 @@ extern void os_warn(const char *fmt, ...)
 /* time.c */
 extern void os_idle_sleep(void);
 extern int os_timer_create(void);
-extern int os_timer_set_interval(unsigned long long nsecs);
-extern int os_timer_one_shot(unsigned long long nsecs);
-extern void os_timer_disable(void);
+extern int os_timer_set_interval(int cpu, unsigned long long nsecs);
+extern int os_timer_one_shot(int cpu, unsigned long long nsecs);
+extern void os_timer_disable(int cpu);
 extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
 
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index d69d137a0334..e95f6c5a259d 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -683,7 +683,7 @@ void __init init_IRQ(void)
 {
 	int i;
 
-	irq_set_chip_and_handler(TIMER_IRQ, &alarm_irq_type, handle_edge_irq);
+	irq_set_chip_and_handler(TIMER_IRQ, &alarm_irq_type, handle_percpu_irq);
 
 	for (i = 1; i < UM_LAST_SIGNAL_IRQ; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 17da0a870650..b344a36b44eb 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -625,9 +625,10 @@ void time_travel_sleep(void)
 	 * controller application.
 	 */
 	unsigned long long next = S64_MAX;
+	int cpu = raw_smp_processor_id();
 
 	if (time_travel_mode == TT_MODE_BASIC)
-		os_timer_disable();
+		os_timer_disable(cpu);
 
 	time_travel_update_time(next, true);
 
@@ -638,9 +639,9 @@ void time_travel_sleep(void)
 			 * This is somewhat wrong - we should get the first
 			 * one sooner like the os_timer_one_shot() below...
 			 */
-			os_timer_set_interval(time_travel_timer_interval);
+			os_timer_set_interval(cpu, time_travel_timer_interval);
 		} else {
-			os_timer_one_shot(time_travel_timer_event.time - next);
+			os_timer_one_shot(cpu, time_travel_timer_event.time - next);
 		}
 	}
 }
@@ -758,6 +759,8 @@ extern u64 time_travel_ext_req(u32 op, u64 time);
 #define time_travel_del_event(e) do { } while (0)
 #endif
 
+static struct clock_event_device timer_clockevent[NR_CPUS];
+
 void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	unsigned long flags;
@@ -780,12 +783,14 @@ void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 
 static int itimer_shutdown(struct clock_event_device *evt)
 {
+	int cpu = evt - &timer_clockevent[0];
+
 	if (time_travel_mode != TT_MODE_OFF)
 		time_travel_del_event(&time_travel_timer_event);
 
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL)
-		os_timer_disable();
+		os_timer_disable(cpu);
 
 	return 0;
 }
@@ -793,6 +798,7 @@ static int itimer_shutdown(struct clock_event_device *evt)
 static int itimer_set_periodic(struct clock_event_device *evt)
 {
 	unsigned long long interval = NSEC_PER_SEC / HZ;
+	int cpu = evt - &timer_clockevent[0];
 
 	if (time_travel_mode != TT_MODE_OFF) {
 		time_travel_del_event(&time_travel_timer_event);
@@ -805,7 +811,7 @@ static int itimer_set_periodic(struct clock_event_device *evt)
 
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL)
-		os_timer_set_interval(interval);
+		os_timer_set_interval(cpu, interval);
 
 	return 0;
 }
@@ -825,7 +831,7 @@ static int itimer_next_event(unsigned long delta,
 
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL)
-		return os_timer_one_shot(delta);
+		return os_timer_one_shot(raw_smp_processor_id(), delta);
 
 	return 0;
 }
@@ -835,10 +841,9 @@ static int itimer_one_shot(struct clock_event_device *evt)
 	return itimer_next_event(0, evt);
 }
 
-static struct clock_event_device timer_clockevent = {
+static struct clock_event_device _timer_clockevent = {
 	.name			= "posix-timer",
 	.rating			= 250,
-	.cpumask		= cpu_possible_mask,
 	.features		= CLOCK_EVT_FEAT_PERIODIC |
 				  CLOCK_EVT_FEAT_ONESHOT,
 	.set_state_shutdown	= itimer_shutdown,
@@ -856,6 +861,9 @@ static struct clock_event_device timer_clockevent = {
 
 static irqreturn_t um_timer(int irq, void *dev)
 {
+	int cpu = raw_smp_processor_id();
+	struct clock_event_device *evt = &timer_clockevent[cpu];
+
 	/*
 	 * Interrupt the (possibly) running userspace process, technically this
 	 * should only happen if userspace is currently executing.
@@ -867,7 +875,7 @@ static irqreturn_t um_timer(int irq, void *dev)
 	    get_current()->mm)
 		os_alarm_process(get_current()->mm->context.id.pid);
 
-	(*timer_clockevent.event_handler)(&timer_clockevent);
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -904,7 +912,24 @@ static struct clocksource timer_clocksource = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init um_timer_setup(void)
+int um_setup_timer(void)
+{
+	int cpu = raw_smp_processor_id();
+	struct clock_event_device *evt = &timer_clockevent[cpu];
+	int err;
+
+	err = os_timer_create();
+	if (err)
+		return err;
+
+	memcpy(evt, &_timer_clockevent, sizeof(*evt));
+	evt->cpumask = cpumask_of(cpu);
+	clockevents_register_device(evt);
+
+	return 0;
+}
+
+static void __init um_timer_init(void)
 {
 	int err;
 
@@ -913,8 +938,8 @@ static void __init um_timer_setup(void)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
 
-	err = os_timer_create();
-	if (err != 0) {
+	err = um_setup_timer();
+	if (err) {
 		printk(KERN_ERR "creation of timer failed - errno = %d\n", -err);
 		return;
 	}
@@ -924,7 +949,6 @@ static void __init um_timer_setup(void)
 		printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
 		return;
 	}
-	clockevents_register_device(&timer_clockevent);
 }
 
 void read_persistent_clock64(struct timespec64 *ts)
@@ -945,7 +969,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 void __init time_init(void)
 {
 	timer_set_signal_handler();
-	late_time_init = um_timer_setup;
+	late_time_init = um_timer_init;
 }
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
@@ -961,21 +985,21 @@ static int setup_time_travel(char *str)
 {
 	if (strcmp(str, "=inf-cpu") == 0) {
 		time_travel_mode = TT_MODE_INFCPU;
-		timer_clockevent.name = "time-travel-timer-infcpu";
+		_timer_clockevent.name = "time-travel-timer-infcpu";
 		timer_clocksource.name = "time-travel-clock";
 		return 1;
 	}
 
 	if (strncmp(str, "=ext:", 5) == 0) {
 		time_travel_mode = TT_MODE_EXTERNAL;
-		timer_clockevent.name = "time-travel-timer-external";
+		_timer_clockevent.name = "time-travel-timer-external";
 		timer_clocksource.name = "time-travel-clock-external";
 		return time_travel_connect_external(str + 5);
 	}
 
 	if (!*str) {
 		time_travel_mode = TT_MODE_BASIC;
-		timer_clockevent.name = "time-travel-timer";
+		_timer_clockevent.name = "time-travel-timer";
 		timer_clocksource.name = "time-travel-clock";
 		return 1;
 	}
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 3c63ce19e3bf..730723106228 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -171,7 +171,7 @@ int __init main(int argc, char **argv, char **envp)
 	 */
 
 	/* stop timers and set timer signal to be ignored */
-	os_timer_disable();
+	os_timer_disable(0);
 
 	/* disable SIGIO for the fds and set SIGIO to be ignored */
 	err = deactivate_all_fds();
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index f3d4547e5227..e0197bfe4ac9 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -17,7 +17,7 @@
 #include <string.h>
 #include "internal.h"
 
-static timer_t event_high_res_timer = 0;
+static timer_t event_high_res_timer[CONFIG_NR_CPUS] = { 0 };
 
 static inline long long timespec_to_ns(const struct timespec *ts)
 {
@@ -32,20 +32,30 @@ long long os_persistent_clock_emulation(void)
 	return timespec_to_ns(&realtime_tp);
 }
 
+#ifndef sigev_notify_thread_id
+#define sigev_notify_thread_id _sigev_un._tid
+#endif
+
 /**
  * os_timer_create() - create an new posix (interval) timer
  */
 int os_timer_create(void)
 {
-	timer_t *t = &event_high_res_timer;
+	timer_t *t = &event_high_res_timer[0];
+	struct sigevent sev = {
+		.sigev_notify = SIGEV_THREAD_ID,
+		.sigev_signo = SIGALRM,
+		.sigev_value.sival_ptr = t,
+		.sigev_notify_thread_id = gettid(),
+	};
 
-	if (timer_create(CLOCK_MONOTONIC, NULL, t) == -1)
+	if (timer_create(CLOCK_MONOTONIC, &sev, t) == -1)
 		return -1;
 
 	return 0;
 }
 
-int os_timer_set_interval(unsigned long long nsecs)
+int os_timer_set_interval(int cpu, unsigned long long nsecs)
 {
 	struct itimerspec its;
 
@@ -55,13 +65,13 @@ int os_timer_set_interval(unsigned long long nsecs)
 	its.it_interval.tv_sec = nsecs / UM_NSEC_PER_SEC;
 	its.it_interval.tv_nsec = nsecs % UM_NSEC_PER_SEC;
 
-	if (timer_settime(event_high_res_timer, 0, &its, NULL) == -1)
+	if (timer_settime(event_high_res_timer[cpu], 0, &its, NULL) == -1)
 		return -errno;
 
 	return 0;
 }
 
-int os_timer_one_shot(unsigned long long nsecs)
+int os_timer_one_shot(int cpu, unsigned long long nsecs)
 {
 	struct itimerspec its = {
 		.it_value.tv_sec = nsecs / UM_NSEC_PER_SEC,
@@ -71,19 +81,20 @@ int os_timer_one_shot(unsigned long long nsecs)
 		.it_interval.tv_nsec = 0, // we cheat here
 	};
 
-	timer_settime(event_high_res_timer, 0, &its, NULL);
+	timer_settime(event_high_res_timer[cpu], 0, &its, NULL);
 	return 0;
 }
 
 /**
  * os_timer_disable() - disable the posix (interval) timer
+ * @cpu: the CPU for which the timer is to be disabled
  */
-void os_timer_disable(void)
+void os_timer_disable(int cpu)
 {
 	struct itimerspec its;
 
 	memset(&its, 0, sizeof(struct itimerspec));
-	timer_settime(event_high_res_timer, 0, &its, NULL);
+	timer_settime(event_high_res_timer[cpu], 0, &its, NULL);
 }
 
 long long os_nsecs(void)
-- 
2.34.1


