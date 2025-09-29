Return-Path: <linux-kernel+bounces-836058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248EBA8A35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA3E3B41EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34392C327A;
	Mon, 29 Sep 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lqVhq7Er";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s3YoYH01"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1B2C21D5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138154; cv=none; b=tWaBygP8CaruUXzygZicYLetaxYrOQQTInBDPxERs//yMWYYZDsRJS2jOCwiATPMv8av8j4yNSGrGfAihr8ARo42F1s/DgtAIKUWATBYM6ZxagD/jf1MYVh0xhxSMBz94uBTgQRGEgWVvpJl7Th7lGepcKVcCKuYp3BGATGY3rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138154; c=relaxed/simple;
	bh=09R0bg5+VqUMnV3knNMtLYqKuj7pmVoSejB4o3LoI2Y=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=USRMSTNkk0ntpXTIk7H6JXk3dn9305DlPI+MCtC4wEtVAMF6P8uPTDplQNW6G8GK2MIuG7eUhHkjCEIWGgMS2j2ScCtnWtN00pnl866p9RgxplTLsnRehR26DMjxZhUpfSY6hwesziVb4p+icgEuxNJV3ThssgPFJEOjnnFMzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lqVhq7Er; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s3YoYH01; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=u1qtb3bxqMCBoj5ON0Jmtrgb9p1ztJklwsvyEBOXUqo=;
	b=lqVhq7ErxzTftxCQg30N3peVpDeST130Oq6h26cWQl0O/8YmZmhVojbi4UyPpJKn+kEwQB
	NSvlFIVcRJxcXLfPHAG5tAhfBYG5e0Zmk2VSD33ErAzJOewCWFxZXv8mUVdIKBRsBJvW90
	Uk7idCtSXrsmgYQxzGLikIpbucFveEwlHiGOcWpYjxK9zJXweL31ssNS5/7bw00qyXC3n+
	XO+FjXLjiZa3TfEbPLrf5rQWVAMz27bRcMvKEzamXLKRJguaKPlBOReF5s2pINOrx6FsMh
	CYruc1BvcKcQVbEfNdBgM5TiwVSV518k11v1K9fYcviI9lzpo+qZp4S9aXkcSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=u1qtb3bxqMCBoj5ON0Jmtrgb9p1ztJklwsvyEBOXUqo=;
	b=s3YoYH016uY6SvQ6yXhzTbEnXX36+yNa7i7RmUC0rlCgedQ4G+CFJw7fzRk6AZI/Ls6R11
	1jUeVeKuu+kPUICQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913808853.495041.3476262549602040220.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:29:08 +0200 (CEST)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025=
-09-29

up to:  391253b25f07: time: Fix spelling mistakes in comments

Updates for the time(rs) core subsystem:

  - Address the inconsistent shutdown sequence of per CPU clockevents on
    CPU hotplug, which onoly removed it from the core but failed to invoke
    the actual device driver shutdown callback. This keeps the timer
    active, which prevents power savings and causes pointless noise in
    virtualization.

  - Encapsulate the open coded access to the hrtimer clock base, which is a
    private implementation detail, so that the implementation can be
    changed without breaking a lot of usage sites.

  - Enhance the debug output of the clocksource watchdog to provide better
    information for analysis.

  - The usual set of cleanups and enhancements all over the place

Thanks,

	tglx

------------------>
Bibo Mao (2):
      tick: Do not set device to detached state in tick_shutdown()
      LoongArch: Remove clockevents shutdown call on offlining

Bjorn Helgaas (1):
      jiffies: Remove obsolete SHIFTED_HZ comment

Haofeng Li (1):
      time: Fix spelling mistakes in comments

Jiri Wiesner (1):
      clocksource: Print durations for sync check unconditionally

Thomas Wei=C3=9Fschuh (9):
      posix-timers: Avoid direct access to hrtimer clockbase
      timers/itimer: Avoid direct access to hrtimer clockbase
      sched/core: Avoid direct access to hrtimer clockbase
      lib: test_objpool: Avoid direct access to hrtimer clockbase
      ALSA: hrtimer: Avoid direct access to hrtimer clockbase
      media: pwm-ir-tx: Avoid direct access to hrtimer clockbase
      hrtimer: Use hrtimer_cb_get_time() helper
      hrtimer: Remove hrtimer_clock_base:: Get_time
      hrtimer: Reorder branches in hrtimer_clockid_to_base()


 arch/loongarch/kernel/time.c   |  2 --
 drivers/media/rc/pwm-ir-tx.c   |  5 +----
 include/linux/hrtimer.h        | 14 +++++---------
 include/linux/hrtimer_defs.h   |  2 --
 include/linux/jiffies.h        |  2 +-
 include/vdso/jiffies.h         |  2 +-
 kernel/sched/core.c            |  2 +-
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/clockevents.c      |  2 +-
 kernel/time/clocksource.c      |  7 +++----
 kernel/time/hrtimer.c          | 40 ++++++++++++++++++++++++++++------------
 kernel/time/itimer.c           |  3 +--
 kernel/time/posix-timers.c     |  7 +++----
 kernel/time/tick-common.c      | 16 +++++-----------
 kernel/time/tick-internal.h    |  2 +-
 kernel/time/timer_list.c       |  2 --
 lib/test_objpool.c             |  2 +-
 scripts/gdb/linux/timerlist.py |  2 --
 sound/core/hrtimer.c           |  2 +-
 19 files changed, 54 insertions(+), 62 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index f3092f2de8b5..6fb92cc1a4c9 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -112,8 +112,6 @@ static int arch_timer_starting(unsigned int cpu)
=20
 static int arch_timer_dying(unsigned int cpu)
 {
-	constant_set_state_shutdown(this_cpu_ptr(&constant_clockevent_device));
-
 	/* Clear Timer Interrupt */
 	write_csr_tintclear(CSR_TINTCLR_TI);
=20
diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 84533fdd61aa..047472dc9244 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -117,7 +117,6 @@ static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned =
int *txbuf,
 static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
 {
 	struct pwm_ir *pwm_ir =3D container_of(timer, struct pwm_ir, timer);
-	ktime_t now;
=20
 	/*
 	 * If we happen to hit an odd latency spike, loop through the
@@ -139,9 +138,7 @@ static enum hrtimer_restart pwm_ir_timer(struct hrtimer *=
timer)
 		hrtimer_add_expires_ns(timer, ns);
=20
 		pwm_ir->txbuf_index++;
-
-		now =3D timer->base->get_time();
-	} while (hrtimer_get_expires_tv64(timer) < now);
+	} while (hrtimer_expires_remaining(timer) > 0);
=20
 	return HRTIMER_RESTART;
 }
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 1ef867bb8c44..2cf1bf65b225 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -154,14 +154,11 @@ static inline s64 hrtimer_get_expires_ns(const struct h=
rtimer *timer)
 	return ktime_to_ns(timer->node.expires);
 }
=20
-static inline ktime_t hrtimer_expires_remaining(const struct hrtimer *timer)
-{
-	return ktime_sub(timer->node.expires, timer->base->get_time());
-}
+ktime_t hrtimer_cb_get_time(const struct hrtimer *timer);
=20
-static inline ktime_t hrtimer_cb_get_time(struct hrtimer *timer)
+static inline ktime_t hrtimer_expires_remaining(const struct hrtimer *timer)
 {
-	return timer->base->get_time();
+	return ktime_sub(timer->node.expires, hrtimer_cb_get_time(timer));
 }
=20
 static inline int hrtimer_is_hres_active(struct hrtimer *timer)
@@ -200,8 +197,7 @@ __hrtimer_expires_remaining_adjusted(const struct hrtimer=
 *timer, ktime_t now)
 static inline ktime_t
 hrtimer_expires_remaining_adjusted(const struct hrtimer *timer)
 {
-	return __hrtimer_expires_remaining_adjusted(timer,
-						    timer->base->get_time());
+	return __hrtimer_expires_remaining_adjusted(timer, hrtimer_cb_get_time(time=
r));
 }
=20
 #ifdef CONFIG_TIMERFD
@@ -363,7 +359,7 @@ hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime=
_t interval);
 static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 				      ktime_t interval)
 {
-	return hrtimer_forward(timer, timer->base->get_time(), interval);
+	return hrtimer_forward(timer, hrtimer_cb_get_time(timer), interval);
 }
=20
 /* Precise sleep: */
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index 84a5045f80f3..aa49ffa130e5 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -41,7 +41,6 @@
  * @seq:		seqcount around __run_hrtimer
  * @running:		pointer to the currently running hrtimer
  * @active:		red black tree root node for the active timers
- * @get_time:		function to retrieve the current time of the clock
  * @offset:		offset of this clock to the monotonic base
  */
 struct hrtimer_clock_base {
@@ -51,7 +50,6 @@ struct hrtimer_clock_base {
 	seqcount_raw_spinlock_t	seq;
 	struct hrtimer		*running;
 	struct timerqueue_head	active;
-	ktime_t			(*get_time)(void);
 	ktime_t			offset;
 } __hrtimer_clock_base_align;
=20
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 91b20788273d..0d1927da8055 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -61,7 +61,7 @@
=20
 extern void register_refined_jiffies(long clock_tick_rate);
=20
-/* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
+/* TICK_USEC is the time between ticks in usec */
 #define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
=20
 /* USER_TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
diff --git a/include/vdso/jiffies.h b/include/vdso/jiffies.h
index 2f9d596c8b29..8ca04a141412 100644
--- a/include/vdso/jiffies.h
+++ b/include/vdso/jiffies.h
@@ -5,7 +5,7 @@
 #include <asm/param.h>			/* for HZ */
 #include <vdso/time64.h>
=20
-/* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
+/* TICK_NSEC is the time between ticks in nsec */
 #define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
=20
 #endif /* __VDSO_JIFFIES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..4dc12838ad4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -917,7 +917,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 * doesn't make sense and can cause timer DoS.
 	 */
 	delta =3D max_t(s64, delay, 10000LL);
-	rq->hrtick_time =3D ktime_add_ns(timer->base->get_time(), delta);
+	rq->hrtick_time =3D ktime_add_ns(hrtimer_cb_get_time(timer), delta);
=20
 	if (rq =3D=3D this_rq())
 		__hrtick_restart(rq);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 577f0e6842d4..069d93bfb0c7 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -35,7 +35,7 @@
=20
 /**
  * struct alarm_base - Alarm timer bases
- * @lock:		Lock for syncrhonized access to the base
+ * @lock:		Lock for synchronized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
  * @get_ktime:		Function to read the time correlating to the base
  * @get_timespec:	Function to read the namespace time correlating to the base
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index f3e831f62906..a59bc75ab7c5 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -633,7 +633,7 @@ void tick_offline_cpu(unsigned int cpu)
 	raw_spin_lock(&clockevents_lock);
=20
 	tick_broadcast_offline(cpu);
-	tick_shutdown(cpu);
+	tick_shutdown();
=20
 	/*
 	 * Unregister the clock event devices which were
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0aef0e349e49..a1890a073196 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -144,7 +144,7 @@ static u64 suspend_start;
  * Default for maximum permissible skew when cs->uncertainty_margin is
  * not specified, and the lower bound even when cs->uncertainty_margin
  * is specified.  This is also the default that is used when registering
- * clocks with unspecifed cs->uncertainty_margin, so this macro is used
+ * clocks with unspecified cs->uncertainty_margin, so this macro is used
  * even in CONFIG_CLOCKSOURCE_WATCHDOG=3Dn kernels.
  */
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
@@ -407,9 +407,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	if (!cpumask_empty(&cpus_behind))
 		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_behind), testcpu, cs->name);
-	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind))
-		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s=
.\n",
-			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
+	pr_info("        CPU %d check durations %lldns - %lldns for clocksource %s.=
\n",
+		testcpu, cs_nsec_min, cs_nsec_max, cs->name);
 }
 EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
=20
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8cc52c..7e7b2b471bae 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -59,6 +59,7 @@
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
=20
 static void retrigger_next_event(void *arg);
+static ktime_t __hrtimer_cb_get_time(clockid_t clock_id);
=20
 /*
  * The timer bases:
@@ -76,42 +77,34 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =3D
 		{
 			.index =3D HRTIMER_BASE_MONOTONIC,
 			.clockid =3D CLOCK_MONOTONIC,
-			.get_time =3D &ktime_get,
 		},
 		{
 			.index =3D HRTIMER_BASE_REALTIME,
 			.clockid =3D CLOCK_REALTIME,
-			.get_time =3D &ktime_get_real,
 		},
 		{
 			.index =3D HRTIMER_BASE_BOOTTIME,
 			.clockid =3D CLOCK_BOOTTIME,
-			.get_time =3D &ktime_get_boottime,
 		},
 		{
 			.index =3D HRTIMER_BASE_TAI,
 			.clockid =3D CLOCK_TAI,
-			.get_time =3D &ktime_get_clocktai,
 		},
 		{
 			.index =3D HRTIMER_BASE_MONOTONIC_SOFT,
 			.clockid =3D CLOCK_MONOTONIC,
-			.get_time =3D &ktime_get,
 		},
 		{
 			.index =3D HRTIMER_BASE_REALTIME_SOFT,
 			.clockid =3D CLOCK_REALTIME,
-			.get_time =3D &ktime_get_real,
 		},
 		{
 			.index =3D HRTIMER_BASE_BOOTTIME_SOFT,
 			.clockid =3D CLOCK_BOOTTIME,
-			.get_time =3D &ktime_get_boottime,
 		},
 		{
 			.index =3D HRTIMER_BASE_TAI_SOFT,
 			.clockid =3D CLOCK_TAI,
-			.get_time =3D &ktime_get_clocktai,
 		},
 	},
 	.csd =3D CSD_INIT(retrigger_next_event, NULL)
@@ -208,7 +201,7 @@ static bool hrtimer_suitable_target(struct hrtimer *timer=
, struct hrtimer_clock_
 	/*
 	 * The offline local CPU can't be the default target if the
 	 * next remote target event is after this timer. Keep the
-	 * elected new base. An IPI will we issued to reprogram
+	 * elected new base. An IPI will be issued to reprogram
 	 * it as a last resort.
 	 */
 	if (!hrtimer_base_is_online(this_cpu_base))
@@ -1253,7 +1246,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
 	remove_hrtimer(timer, base, true, force_local);
=20
 	if (mode & HRTIMER_MODE_REL)
-		tim =3D ktime_add_safe(tim, base->get_time());
+		tim =3D ktime_add_safe(tim, __hrtimer_cb_get_time(base->clockid));
=20
 	tim =3D hrtimer_update_lowres(timer, tim, mode);
=20
@@ -1574,10 +1567,10 @@ u64 hrtimer_next_event_without(const struct hrtimer *=
exclude)
 static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 {
 	switch (clock_id) {
-	case CLOCK_REALTIME:
-		return HRTIMER_BASE_REALTIME;
 	case CLOCK_MONOTONIC:
 		return HRTIMER_BASE_MONOTONIC;
+	case CLOCK_REALTIME:
+		return HRTIMER_BASE_REALTIME;
 	case CLOCK_BOOTTIME:
 		return HRTIMER_BASE_BOOTTIME;
 	case CLOCK_TAI:
@@ -1588,6 +1581,29 @@ static inline int hrtimer_clockid_to_base(clockid_t cl=
ock_id)
 	}
 }
=20
+static ktime_t __hrtimer_cb_get_time(clockid_t clock_id)
+{
+	switch (clock_id) {
+	case CLOCK_MONOTONIC:
+		return ktime_get();
+	case CLOCK_REALTIME:
+		return ktime_get_real();
+	case CLOCK_BOOTTIME:
+		return ktime_get_boottime();
+	case CLOCK_TAI:
+		return ktime_get_clocktai();
+	default:
+		WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
+		return ktime_get();
+	}
+}
+
+ktime_t hrtimer_cb_get_time(const struct hrtimer *timer)
+{
+	return __hrtimer_cb_get_time(timer->base->clockid);
+}
+EXPORT_SYMBOL_GPL(hrtimer_cb_get_time);
+
 static void __hrtimer_setup(struct hrtimer *timer,
 			    enum hrtimer_restart (*function)(struct hrtimer *),
 			    clockid_t clock_id, enum hrtimer_mode mode)
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 876d389b2e21..7c6110e964e7 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -163,8 +163,7 @@ void posixtimer_rearm_itimer(struct task_struct *tsk)
 	struct hrtimer *tmr =3D &tsk->signal->real_timer;
=20
 	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr !=3D 0) {
-		hrtimer_forward(tmr, tmr->base->get_time(),
-				tsk->signal->it_real_incr);
+		hrtimer_forward_now(tmr, tsk->signal->it_real_incr);
 		hrtimer_restart(tmr);
 	}
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8b582174b1f9..aa3120104a51 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,8 +299,7 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 {
 	struct hrtimer *timer =3D &timr->it.real.timer;
=20
-	timr->it_overrun +=3D hrtimer_forward(timer, timer->base->get_time(),
-					    timr->it_interval);
+	timr->it_overrun +=3D hrtimer_forward_now(timer, timr->it_interval);
 	hrtimer_restart(timer);
 }
=20
@@ -535,7 +534,7 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 		goto out;
 	}
 	/*
-	 * After succesful copy out, the timer ID is visible to user space
+	 * After successful copy out, the timer ID is visible to user space
 	 * now but not yet valid because new_timer::signal low order bit is 1.
 	 *
 	 * Complete the initialization with the clock specific create
@@ -825,7 +824,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, kti=
me_t expires,
 	hrtimer_setup(&timr->it.real.timer, posix_timer_fn, timr->it_clock, mode);
=20
 	if (!absolute)
-		expires =3D ktime_add_safe(expires, timer->base->get_time());
+		expires =3D ktime_add_safe(expires, hrtimer_cb_get_time(timer));
 	hrtimer_set_expires(timer, expires);
=20
 	if (!sigev_none)
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9a3859443c04..7e33d3f2e889 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -411,24 +411,18 @@ int tick_cpu_dying(unsigned int dying_cpu)
 }
=20
 /*
- * Shutdown an event device on a given cpu:
+ * Shutdown an event device on the outgoing CPU:
  *
- * This is called on a life CPU, when a CPU is dead. So we cannot
- * access the hardware device itself.
- * We just set the mode and remove it from the lists.
+ * Called by the dying CPU during teardown, with clockevents_lock held
+ * and interrupts disabled.
  */
-void tick_shutdown(unsigned int cpu)
+void tick_shutdown(void)
 {
-	struct tick_device *td =3D &per_cpu(tick_cpu_device, cpu);
+	struct tick_device *td =3D this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *dev =3D td->evtdev;
=20
 	td->mode =3D TICKDEV_MODE_PERIODIC;
 	if (dev) {
-		/*
-		 * Prevent that the clock events layer tries to call
-		 * the set mode function!
-		 */
-		clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
 		clockevents_exchange_device(dev, NULL);
 		dev->event_handler =3D clockevents_handle_noop;
 		td->evtdev =3D NULL;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index faac36de35b9..4e4f7bbe2a64 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -26,7 +26,7 @@ extern void tick_setup_periodic(struct clock_event_device *=
dev, int broadcast);
 extern void tick_handle_periodic(struct clock_event_device *dev);
 extern void tick_check_new_device(struct clock_event_device *dev);
 extern void tick_offline_cpu(unsigned int cpu);
-extern void tick_shutdown(unsigned int cpu);
+extern void tick_shutdown(void);
 extern void tick_suspend(void);
 extern void tick_resume(void);
 extern bool tick_check_replacement(struct clock_event_device *curdev,
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index b03d0ada6469..488e47e96e93 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -102,8 +102,6 @@ print_base(struct seq_file *m, struct hrtimer_clock_base =
*base, u64 now)
 	SEQ_printf(m, "  .index:      %d\n", base->index);
=20
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
-
-	SEQ_printf(m,   "  .get_time:   %ps\n", base->get_time);
 #ifdef CONFIG_HIGH_RES_TIMERS
 	SEQ_printf(m, "  .offset:     %Lu nsecs\n",
 		   (unsigned long long) ktime_to_ns(base->offset));
diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index 8f688187fa87..6a34a7582fdb 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -164,7 +164,7 @@ static enum hrtimer_restart ot_hrtimer_handler(struct hrt=
imer *hrt)
 	/* do bulk-testings for objects pop/push */
 	item->worker(item, 1);
=20
-	hrtimer_forward(hrt, hrt->base->get_time(), item->hrtcycle);
+	hrtimer_forward_now(hrt, item->hrtcycle);
 	return HRTIMER_RESTART;
 }
=20
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 98445671fe83..ccc24d30de80 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -56,8 +56,6 @@ def print_base(base):
     text +=3D " .index:      {}\n".format(base['index'])
=20
     text +=3D " .resolution: {} nsecs\n".format(constants.LX_hrtimer_resolut=
ion)
-
-    text +=3D " .get_time:   {}\n".format(base['get_time'])
     if constants.LX_CONFIG_HIGH_RES_TIMERS:
         text +=3D "  .offset:     {} nsecs\n".format(base['offset'])
     text +=3D "active timers:\n"
diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index c364bd126ac8..2d5f4d47071f 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -44,7 +44,7 @@ static enum hrtimer_restart snd_hrtimer_callback(struct hrt=
imer *hrt)
 	}
=20
 	/* calculate the drift */
-	delta =3D ktime_sub(hrt->base->get_time(), hrtimer_get_expires(hrt));
+	delta =3D ktime_sub(hrtimer_cb_get_time(hrt), hrtimer_get_expires(hrt));
 	if (delta > 0)
 		ticks +=3D ktime_divns(delta, ticks * resolution);
=20


