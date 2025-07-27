Return-Path: <linux-kernel+bounces-747313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735AB1324A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E4A17043D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C272517AF;
	Sun, 27 Jul 2025 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0BMG1D2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBTHWPgm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04B254AE4
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655891; cv=none; b=qI59O/dE1SxF+hmtafSKQIHaxKwUcsfbRbDRSe9r5ldk5IXaIN+54T6S57nAn8kD8bOmVYFxVOx5WQiCqn7pUr6/5mdxk2zlt+rt4kS3OksPv9hEPta0vrD/DNGLKBQggLzfDeFStPowcyXkuzcuA/3nKNIl0aw6Tz2Bf0LhEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655891; c=relaxed/simple;
	bh=JixFLGcDj+YPkCKP3CO6O/ZO7GLBOPk467z8yJ3X7hU=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=JjcAZn681CJUHSYpplrNIZBrqACAs7YklCV9x1ehBfFRDabXcXpr753frBzk/Pg6a5u6HjZ/FqxE05O+jk0118FiQhe8YkdVB2KFUA5kWJeFN2UwRo27mrUKIKBfmL5X7gQdlHJCyd3EvcwinWZDBsjt2cqWuy4IefQBdFN3xVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0BMG1D2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBTHWPgm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=qfmRd5ZX8Pt990Lls3j1OXHMRoS+wcuE6w8vlWZc3KE=;
	b=p0BMG1D2qiTo4yS9hG3OBAj0qcYlfVvQTkZKCRY1OC9kSmf3L5nTAGRvqsrRAJP5euBnb3
	6r6aEBrTavfYOPktyNeh824F2rvXRPo0m89/lHNYGCFncWtvVpA3Ftk2r3IuqBjKKTn/bg
	t+wNy/f+Ixy33EBuuLYOJ6LCheq0y50asagCPUuvFlZPtTKW1zfddBD34tOqtzUozWrwY/
	RJCO1sj13bjLAjTHbSgeBGNwMv5kXAxIPYNakFs4wgDFruEkiKkv/uw+DsZDGLC4SCNSIq
	4P3jUyzUC+XS0U4qAVb1lM0vWVFCo4E38aTLlwgGx6LAxMb911roA5fbaxONBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=qfmRd5ZX8Pt990Lls3j1OXHMRoS+wcuE6w8vlWZc3KE=;
	b=HBTHWPgm4hTV5yYmMrdG8BwFdEukV+cDeRR5d1g+xVUcBIqkK964BAqSe48VWTY124iN5K
	fNeapzTZiYRQV2Bw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/ptp for v6.17-rc1
References: <175365567943.581055.6806236199247802443.tglx@xen13>
Message-ID: <175365569231.581055.7096435229102369205.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:38:03 +0200 (CEST)

Linus,

please pull the latest timers/ptp branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-ptp-2025-=
07-27

up to:  cd3557a7618b: vdso/gettimeofday: Add support for auxiliary clocks

Updates for the timekeeping and VDSO code:

  - Introduce support for auxiliary timekeepers

      PTP clocks can be disconnected from the universal CLOCK_TAI reality
      for various reasons including regularatory requirements for
      functional safety redundancy.

      The kernel so far only supports a single notion of time, which means
      that all clocks are correlated in frequency and only differ by
      offset to each other.

      Access to non-correlated PTP clocks has been available so far only
      through the file descriptor based "POSIX clock IDs", which are
      subject to locking and have to go all the way out to the hardware.

      The access is not only horribly slow, as it has to go all the way out
      to the NIC/PTP hardware, but that also prevents the kernel to read
      the time of such clocks e.g. from the network stack, where it is
      required for TSN networking both on the transmit and receive side
      unless the hardware provides offloading.

      The auxiliary clocks provide a mechanism to support arbitrary clocks
      which are not correlated to the system clock. This is not restricted
      to the PTP use case on purpose as there is no kernel side association
      of these clocks to a particular PTP device because that's a pure user
      space configuration decision. Having them independent allows to
      utilize them for other purposes and also enables them to be tested
      without hardware dependencies.

      To avoid pointless overhead these clocks have to be enabled
      individualy via a new sysfs interface to reduce the overhead to a
      single compare in the hotpath if they are enabled at the Kconfig
      level at all.

      These clocks utilize the existing timekeeping/NTP infrastructures,
      which has been made possible over the recent releases by incrementaly
      converting these infrastructures over from a single static instance
      to a multi-instance pointer based implementation without any
      performance regression reported.

      The auxiliary clocks provide the same "emulation" of a "correct"
      clock as the existing CLOCK_* variants do with an independent
      instance of data and provide the same steering mechanism through the
      existing sys_clock_adjtime() interface, which has been confirmed to
      work by the chronyd(8) maintainer.

      That allows to provide lockless kernel internal and VDSO support so
      that applications and kernel internal functionalities can access
      these clocks without restrictions and at the same performance as the
      existing system clocks.

  - Avoid double notifications in the adjtimex() syscall. Not a big issue,
    but a trivial to avoid latency source.

Note: The commits, which provide the new interface ktime_get_clock_ts64()
      for the networking stack along with a temporary define have been
      provided to allow the network folks to proceed with the enablement on
      top of other large scale changes in the related PTP code.

      No merge conflicts expected, just some commits with the same SHA
      coming to you either way depending on merge order.

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (4):
      timekeeping: Introduce timekeeper ID
      time: Introduce auxiliary POSIX clocks
      timekeeping: Make __timekeeping_advance() reusable
      timekeeping: Introduce auxiliary timekeepers

Thomas Gleixner (24):
      timekeeping: Remove hardcoded access to tk_core
      timekeeping: Cleanup kernel doc of __ktime_get_real_seconds()
      timekeeping: Avoid double notification in do_adjtimex()
      ntp: Add support for auxiliary timekeepers
      ntp: Add timekeeper ID arguments to public functions
      ntp: Rename __do_adjtimex() to ntp_adjtimex()
      timekeeping: Prepare timekeeping_update_from_shadow()
      timekeeping: Add clock_valid flag to timekeeper
      timekeeping: Provide ktime_get_ntp_seconds()
      ntp: Use ktime_get_ntp_seconds()
      timekeeping: Add AUX offset to struct timekeeper
      timekeeping: Update auxiliary timekeepers on clocksource change
      timekeeping: Provide time getters for auxiliary clocks
      timekeeping: Add minimal posix-timers support for auxiliary clocks
      timekeeping: Provide time setter for auxiliary clocks
      timekeeping: Make timekeeping_inject_offset() reusable
      timekeeping: Add auxiliary clock support to __timekeeping_inject_offset=
()
      timekeeping: Make do_adjtimex() reusable
      timekeeping: Prepare do_adtimex() for auxiliary clocks
      timekeeping: Provide adjtimex() for auxiliary clocks
      timekeeping: Provide update for auxiliary timekeepers
      timekeeping: Provide interface to control auxiliary clocks
      timekeeping: Provide ktime_get_clock_ts64()
      timekeeping: Remove the temporary CLOCK_AUX workaround

Thomas Wei=C3=9Fschuh (11):
      vdso/vsyscall: Introduce a helper to fill clock configurations
      vdso/vsyscall: Split up __arch_update_vsyscall() into __arch_update_vds=
o_clock()
      vdso/helpers: Add helpers for seqlocks of single vdso_clock
      vdso/gettimeofday: Return bool from clock_getres() helpers
      vdso/gettimeofday: Return bool from clock_gettime() helpers
      vdso/gettimeofday: Introduce vdso_clockid_valid()
      vdso/gettimeofday: Introduce vdso_set_timespec()
      vdso/gettimeofday: Introduce vdso_get_timestamp()
      vdso: Introduce aux_clock_resolution_ns()
      vdso/vsyscall: Update auxiliary clock data in the datapage
      vdso/gettimeofday: Add support for auxiliary clocks


 .../ABI/stable/sysfs-kernel-time-aux-clocks        |   5 +
 arch/arm64/include/asm/vdso/vsyscall.h             |   7 +-
 include/asm-generic/vdso/vsyscall.h                |   6 +-
 include/linux/posix-timers.h                       |   5 +
 include/linux/timekeeper_internal.h                |  37 +-
 include/linux/timekeeping.h                        |  12 +
 include/uapi/linux/time.h                          |  11 +
 include/vdso/auxclock.h                            |  13 +
 include/vdso/datapage.h                            |   5 +
 include/vdso/helpers.h                             |  50 +-
 kernel/time/Kconfig                                |  15 +-
 kernel/time/namespace.c                            |   5 +
 kernel/time/ntp.c                                  |  72 +--
 kernel/time/ntp_internal.h                         |  13 +-
 kernel/time/posix-timers.c                         |   3 +
 kernel/time/posix-timers.h                         |   1 +
 kernel/time/timekeeping.c                          | 629 ++++++++++++++++++-=
--
 kernel/time/timekeeping_internal.h                 |   3 +
 kernel/time/vsyscall.c                             |  70 ++-
 lib/vdso/gettimeofday.c                            | 224 +++++---
 20 files changed, 950 insertions(+), 236 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-kernel-time-aux-clocks
 create mode 100644 include/vdso/auxclock.h

diff --git a/Documentation/ABI/stable/sysfs-kernel-time-aux-clocks b/Document=
ation/ABI/stable/sysfs-kernel-time-aux-clocks
new file mode 100644
index 000000000000..825508f42af6
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-kernel-time-aux-clocks
@@ -0,0 +1,5 @@
+What:		/sys/kernel/time/aux_clocks/<ID>/enable
+Date:		May 2025
+Contact:	Thomas Gleixner <tglx@linutronix.de>
+Description:
+		Controls the enablement of auxiliary clock timekeepers.
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index de58951b8df6..417aae5763a8 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -13,12 +13,11 @@
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
 static __always_inline
-void __arm64_update_vsyscall(struct vdso_time_data *vdata)
+void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
-	vdata->clock_data[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
-	vdata->clock_data[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
+	vc->mask	=3D VDSO_PRECISION_MASK;
 }
-#define __arch_update_vsyscall __arm64_update_vsyscall
+#define __arch_update_vdso_clock __arch_update_vdso_clock
=20
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index b550afa15ecd..7fc0b560007d 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -22,11 +22,11 @@ static __always_inline const struct vdso_rng_data *__arch=
_get_vdso_u_rng_data(vo
=20
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
-#ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_time_data *vd=
ata)
+#ifndef __arch_update_vdso_clock
+static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
 }
-#endif /* __arch_update_vsyscall */
+#endif /* __arch_update_vdso_clock */
=20
 #ifndef __arch_sync_vdso_time_data
 static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data=
 *vdata)
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index dd48c64b605e..4d3dbcef379e 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -37,6 +37,11 @@ static inline int clockid_to_fd(const clockid_t clk)
 	return ~(clk >> 3);
 }
=20
+static inline bool clockid_aux_valid(clockid_t id)
+{
+	return IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) && id >=3D CLOCK_AUX && id <=3D =
CLOCK_AUX_LAST;
+}
+
 #ifdef CONFIG_POSIX_TIMERS
=20
 #include <linux/signal_types.h>
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_i=
nternal.h
index 785048a3b3e6..c27aac67cb3f 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -11,6 +11,22 @@
 #include <linux/jiffies.h>
 #include <linux/time.h>
=20
+/**
+ * timekeeper_ids - IDs for various time keepers in the kernel
+ * @TIMEKEEPER_CORE:		The central core timekeeper managing system time
+ * @TIMEKEEPER_AUX_FIRST:	The first AUX timekeeper
+ * @TIMEKEEPER_AUX_LAST:	The last AUX timekeeper
+ * @TIMEKEEPERS_MAX:		The maximum number of timekeepers managed
+ */
+enum timekeeper_ids {
+	TIMEKEEPER_CORE,
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+	TIMEKEEPER_AUX_FIRST,
+	TIMEKEEPER_AUX_LAST =3D TIMEKEEPER_AUX_FIRST + MAX_AUX_CLOCKS - 1,
+#endif
+	TIMEKEEPERS_MAX,
+};
+
 /**
  * struct tk_read_base - base structure for timekeeping readout
  * @clock:	Current clocksource used for timekeeping.
@@ -51,11 +67,14 @@ struct tk_read_base {
  * @offs_real:			Offset clock monotonic -> clock realtime
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
+ * @offs_aux:			Offset clock monotonic -> clock AUX
  * @coarse_nsec:		The nanoseconds part for coarse time getters
+ * @id:				The timekeeper ID
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
  * @cs_was_changed_seq:		The sequence number of clocksource change events
+ * @clock_valid:		Indicator for valid clock
  * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
  * @cycle_interval:		Number of clock cycles in one NTP interval
  * @xtime_interval:		Number of clock shifted nano seconds in one NTP
@@ -95,13 +114,16 @@ struct tk_read_base {
  * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
  * accelerate the VDSO update for CLOCK_BOOTTIME.
  *
+ * @offs_aux is used by the auxiliary timekeepers which do not utilize any
+ * of the regular timekeeper offset fields.
+ *
  * The cacheline ordering of the structure is optimized for in kernel usage =
of
  * the ktime_get() and ktime_get_ts64() family of time accessors. Struct
  * timekeeper is prepended in the core timekeeping code with a sequence coun=
t,
  * which results in the following cacheline layout:
  *
  * 0:	seqcount, tkr_mono
- * 1:	xtime_sec ... coarse_nsec
+ * 1:	xtime_sec ... id
  * 2:	tkr_raw, raw_sec
  * 3,4: Internal variables
  *
@@ -121,8 +143,12 @@ struct timekeeper {
 	struct timespec64	wall_to_monotonic;
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
-	ktime_t			offs_tai;
+	union {
+		ktime_t		offs_tai;
+		ktime_t		offs_aux;
+	};
 	u32			coarse_nsec;
+	enum timekeeper_ids	id;
=20
 	/* Cacheline 2: */
 	struct tk_read_base	tkr_raw;
@@ -131,6 +157,7 @@ struct timekeeper {
 	/* Cachline 3 and 4 (timekeeping internal variables): */
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
+	u8			clock_valid;
=20
 	struct timespec64	monotonic_to_boot;
=20
@@ -163,4 +190,10 @@ static inline void update_vsyscall_tz(void)
 }
 #endif
=20
+#if defined(CONFIG_GENERIC_GETTIMEOFDAY) && defined(CONFIG_POSIX_AUX_CLOCKS)
+extern void vdso_time_update_aux(struct timekeeper *tk);
+#else
+static inline void vdso_time_update_aux(struct timekeeper *tk) { }
+#endif
+
 #endif /* _LINUX_TIMEKEEPER_INTERNAL_H */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 542773650200..aee2c1a46e47 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
=20
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
@@ -263,6 +264,17 @@ extern bool timekeeping_rtc_skipresume(void);
=20
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
=20
+/*
+ * Auxiliary clock interfaces
+ */
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+extern bool ktime_get_aux(clockid_t id, ktime_t *kt);
+extern bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt);
+#else
+static inline bool ktime_get_aux(clockid_t id, ktime_t *kt) { return false; }
+static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) {=
 return false; }
+#endif
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 4f4b6e48e01c..16ca1ac206fd 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -64,6 +64,17 @@ struct timezone {
 #define CLOCK_TAI			11
=20
 #define MAX_CLOCKS			16
+
+/*
+ * AUX clock support. AUXiliary clocks are dynamically configured by
+ * enabling a clock ID. These clock can be steered independently of the
+ * core timekeeper. The kernel can support up to 8 auxiliary clocks, but
+ * the actual limit depends on eventual architecture constraints vs. VDSO.
+ */
+#define CLOCK_AUX			MAX_CLOCKS
+#define MAX_AUX_CLOCKS			8
+#define CLOCK_AUX_LAST			(CLOCK_AUX + MAX_AUX_CLOCKS - 1)
+
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
 #define CLOCKS_MONO			CLOCK_MONOTONIC
=20
diff --git a/include/vdso/auxclock.h b/include/vdso/auxclock.h
new file mode 100644
index 000000000000..6d6e74cbc400
--- /dev/null
+++ b/include/vdso/auxclock.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VDSO_AUXCLOCK_H
+#define _VDSO_AUXCLOCK_H
+
+#include <uapi/linux/time.h>
+#include <uapi/linux/types.h>
+
+static __always_inline u64 aux_clock_resolution_ns(void)
+{
+	return 1;
+}
+
+#endif /* _VDSO_AUXCLOCK_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 1864e76e8f69..02533038640e 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
=20
 #include <linux/compiler.h>
+#include <uapi/linux/bits.h>
 #include <uapi/linux/time.h>
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
@@ -38,6 +39,7 @@ struct vdso_arch_data {
 #endif
=20
 #define VDSO_BASES	(CLOCK_TAI + 1)
+#define VDSO_BASE_AUX	0
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
 			 BIT(CLOCK_BOOTTIME)		| \
@@ -45,6 +47,7 @@ struct vdso_arch_data {
 #define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
 			 BIT(CLOCK_MONOTONIC_COARSE))
 #define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
+#define VDSO_AUX	__GENMASK(CLOCK_AUX_LAST, CLOCK_AUX)
=20
 #define CS_HRES_COARSE	0
 #define CS_RAW		1
@@ -117,6 +120,7 @@ struct vdso_clock {
  * @arch_data:		architecture specific data (optional, defaults
  *			to an empty struct)
  * @clock_data:		clocksource related data (array)
+ * @aux_clock_data:	auxiliary clocksource related data (array)
  * @tz_minuteswest:	minutes west of Greenwich
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
@@ -133,6 +137,7 @@ struct vdso_time_data {
 	struct arch_vdso_time_data	arch_data;
=20
 	struct vdso_clock		clock_data[CS_BASES];
+	struct vdso_clock		aux_clock_data[MAX_AUX_CLOCKS];
=20
 	s32				tz_minuteswest;
 	s32				tz_dsttime;
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 0a98fed550ba..1a5ee9d9052c 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -28,17 +28,47 @@ static __always_inline u32 vdso_read_retry(const struct v=
dso_clock *vc,
 	return seq !=3D start;
 }
=20
-static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
+static __always_inline void vdso_write_seq_begin(struct vdso_clock *vc)
 {
-	struct vdso_clock *vc =3D vd->clock_data;
+	/*
+	 * WRITE_ONCE() is required otherwise the compiler can validly tear
+	 * updates to vc->seq and it is possible that the value seen by the
+	 * reader is inconsistent.
+	 */
+	WRITE_ONCE(vc->seq, vc->seq + 1);
+}
=20
+static __always_inline void vdso_write_seq_end(struct vdso_clock *vc)
+{
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
-	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * updates to vc->seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
+	WRITE_ONCE(vc->seq, vc->seq + 1);
+}
+
+static __always_inline void vdso_write_begin_clock(struct vdso_clock *vc)
+{
+	vdso_write_seq_begin(vc);
+	/* Ensure the sequence invalidation is visible before data is modified */
+	smp_wmb();
+}
+
+static __always_inline void vdso_write_end_clock(struct vdso_clock *vc)
+{
+	/* Ensure the data update is visible before the sequence is set valid again=
 */
+	smp_wmb();
+	vdso_write_seq_end(vc);
+}
+
+static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
+{
+	struct vdso_clock *vc =3D vd->clock_data;
+
+	vdso_write_seq_begin(&vc[CS_HRES_COARSE]);
+	vdso_write_seq_begin(&vc[CS_RAW]);
+	/* Ensure the sequence invalidation is visible before data is modified */
 	smp_wmb();
 }
=20
@@ -46,14 +76,10 @@ static __always_inline void vdso_write_end(struct vdso_ti=
me_data *vd)
 {
 	struct vdso_clock *vc =3D vd->clock_data;
=20
+	/* Ensure the data update is visible before the sequence is set valid again=
 */
 	smp_wmb();
-	/*
-	 * WRITE_ONCE() is required otherwise the compiler can validly tear
-	 * updates to vd[x].seq and it is possible that the value seen by the
-	 * reader is inconsistent.
-	 */
-	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
+	vdso_write_seq_end(&vc[CS_HRES_COARSE]);
+	vdso_write_seq_end(&vc[CS_RAW]);
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index b0b97a60aaa6..7c6a52f7836c 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -82,9 +82,9 @@ config CONTEXT_TRACKING_IDLE
 	help
 	  Tracks idle state on behalf of RCU.
=20
-if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
=20
+if GENERIC_CLOCKEVENTS
 # Core internal switch. Selected by NO_HZ_COMMON / HIGH_RES_TIMERS. This is
 # only related to the tick functionality. Oneshot clockevent devices
 # are supported independent of this.
@@ -208,6 +208,17 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	  interval and NTP's maximum frequency drift of 500 parts
 	  per million.	If the clocksource is good enough for NTP,
 	  it is good enough for the clocksource watchdog!
+endif
+
+config POSIX_AUX_CLOCKS
+	bool "Enable auxiliary POSIX clocks"
+	depends on POSIX_TIMERS
+	help
+	  Auxiliary POSIX clocks are clocks which can be steered
+	  independently of the core timekeeper, which controls the
+	  MONOTONIC, REALTIME, BOOTTIME and TAI clocks.  They are useful to
+	  provide e.g. lockless time accessors to independent PTP clocks
+	  and other clock domains, which are not correlated to the TAI/NTP
+	  notion of time.
=20
 endmenu
-endif
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e3642278df43..667452768ed3 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -242,6 +242,11 @@ static void timens_set_vvar_page(struct task_struct *tas=
k,
 	for (i =3D 0; i < CS_BASES; i++)
 		timens_setup_vdso_clock_data(&vc[i], ns);
=20
+	if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS)) {
+		for (i =3D 0; i < ARRAY_SIZE(vdata->aux_clock_data); i++)
+			timens_setup_vdso_clock_data(&vdata->aux_clock_data[i], ns);
+	}
+
 out:
 	mutex_unlock(&offset_lock);
 }
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b837d3d9d325..97fa99b96dd0 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/audit.h>
+#include <linux/timekeeper_internal.h>
=20
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -86,14 +87,16 @@ struct ntp_data {
 #endif
 };
=20
-static struct ntp_data tk_ntp_data =3D {
-	.tick_usec		=3D USER_TICK_USEC,
-	.time_state		=3D TIME_OK,
-	.time_status		=3D STA_UNSYNC,
-	.time_constant		=3D 2,
-	.time_maxerror		=3D NTP_PHASE_LIMIT,
-	.time_esterror		=3D NTP_PHASE_LIMIT,
-	.ntp_next_leap_sec	=3D TIME64_MAX,
+static struct ntp_data tk_ntp_data[TIMEKEEPERS_MAX] =3D {
+	[ 0 ... TIMEKEEPERS_MAX - 1 ] =3D {
+		.tick_usec		=3D USER_TICK_USEC,
+		.time_state		=3D TIME_OK,
+		.time_status		=3D STA_UNSYNC,
+		.time_constant		=3D 2,
+		.time_maxerror		=3D NTP_PHASE_LIMIT,
+		.time_esterror		=3D NTP_PHASE_LIMIT,
+		.ntp_next_leap_sec	=3D TIME64_MAX,
+	},
 };
=20
 #define SECS_PER_DAY		86400
@@ -300,7 +303,7 @@ static void ntp_update_offset(struct ntp_data *ntpdata, l=
ong offset)
 	 * Select how the frequency is to be controlled
 	 * and in which mode (PLL or FLL).
 	 */
-	real_secs =3D __ktime_get_real_seconds();
+	real_secs =3D ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
 	secs =3D (long)(real_secs - ntpdata->time_reftime);
 	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs =3D 0;
@@ -348,33 +351,38 @@ static void __ntp_clear(struct ntp_data *ntpdata)
=20
 /**
  * ntp_clear - Clears the NTP state variables
+ * @tkid:	Timekeeper ID to be able to select proper ntp data array member
  */
-void ntp_clear(void)
+void ntp_clear(unsigned int tkid)
 {
-	__ntp_clear(&tk_ntp_data);
+	__ntp_clear(&tk_ntp_data[tkid]);
 }
=20
=20
-u64 ntp_tick_length(void)
+u64 ntp_tick_length(unsigned int tkid)
 {
-	return tk_ntp_data.tick_length;
+	return tk_ntp_data[tkid].tick_length;
 }
=20
 /**
  * ntp_get_next_leap - Returns the next leapsecond in CLOCK_REALTIME ktime_t
+ * @tkid:	Timekeeper ID
  *
- * Provides the time of the next leapsecond against CLOCK_REALTIME in
- * a ktime_t format. Returns KTIME_MAX if no leapsecond is pending.
+ * Returns: For @tkid =3D=3D TIMEKEEPER_CORE this provides the time of the n=
ext
+ *	    leap second against CLOCK_REALTIME in a ktime_t format if a
+ *	    leap second is pending. KTIME_MAX otherwise.
  */
-ktime_t ntp_get_next_leap(void)
+ktime_t ntp_get_next_leap(unsigned int tkid)
 {
-	struct ntp_data *ntpdata =3D &tk_ntp_data;
-	ktime_t ret;
+	struct ntp_data *ntpdata =3D &tk_ntp_data[TIMEKEEPER_CORE];
+
+	if (tkid !=3D TIMEKEEPER_CORE)
+		return KTIME_MAX;
=20
 	if ((ntpdata->time_state =3D=3D TIME_INS) && (ntpdata->time_status & STA_IN=
S))
 		return ktime_set(ntpdata->ntp_next_leap_sec, 0);
-	ret =3D KTIME_MAX;
-	return ret;
+
+	return KTIME_MAX;
 }
=20
 /*
@@ -387,9 +395,9 @@ ktime_t ntp_get_next_leap(void)
  *
  * Also handles leap second processing, and returns leap offset
  */
-int second_overflow(time64_t secs)
+int second_overflow(unsigned int tkid, time64_t secs)
 {
-	struct ntp_data *ntpdata =3D &tk_ntp_data;
+	struct ntp_data *ntpdata =3D &tk_ntp_data[tkid];
 	s64 delta;
 	int leap =3D 0;
 	s32 rem;
@@ -605,7 +613,7 @@ static inline int update_rtc(struct timespec64 *to_set, u=
nsigned long *offset_ns
  */
 static inline bool ntp_synced(void)
 {
-	return !(tk_ntp_data.time_status & STA_UNSYNC);
+	return !(tk_ntp_data[TIMEKEEPER_CORE].time_status & STA_UNSYNC);
 }
=20
 /*
@@ -702,7 +710,7 @@ static inline void process_adj_status(struct ntp_data *nt=
pdata, const struct __k
 	 * reference time to current time.
 	 */
 	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
-		ntpdata->time_reftime =3D __ktime_get_real_seconds();
+		ntpdata->time_reftime =3D ktime_get_ntp_seconds(ntpdata - tk_ntp_data);
=20
 	/* only set allowed bits */
 	ntpdata->time_status &=3D STA_RONLY;
@@ -759,10 +767,10 @@ static inline void process_adjtimex_modes(struct ntp_da=
ta *ntpdata, const struct
  * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
-		  s32 *time_tai, struct audit_ntp_data *ad)
+int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct=
 timespec64 *ts,
+		 s32 *time_tai, struct audit_ntp_data *ad)
 {
-	struct ntp_data *ntpdata =3D &tk_ntp_data;
+	struct ntp_data *ntpdata =3D &tk_ntp_data[tkid];
 	int result;
=20
 	if (txc->modes & ADJ_ADJTIME) {
@@ -1031,8 +1039,8 @@ static void hardpps_update_phase(struct ntp_data *ntpda=
ta, long error)
  */
 void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *r=
aw_ts)
 {
+	struct ntp_data *ntpdata =3D &tk_ntp_data[TIMEKEEPER_CORE];
 	struct pps_normtime pts_norm, freq_norm;
-	struct ntp_data *ntpdata =3D &tk_ntp_data;
=20
 	pts_norm =3D pps_normalize_ts(*phase_ts);
=20
@@ -1083,18 +1091,18 @@ void __hardpps(const struct timespec64 *phase_ts, con=
st struct timespec64 *raw_t
=20
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc =3D kstrtos64(str, 0, &tk_ntp_data.ntp_tick_adj);
+	int rc =3D kstrtos64(str, 0, &tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj);
 	if (rc)
 		return rc;
=20
-	tk_ntp_data.ntp_tick_adj <<=3D NTP_SCALE_SHIFT;
+	tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj <<=3D NTP_SCALE_SHIFT;
 	return 1;
 }
-
 __setup("ntp_tick_adj=3D", ntp_tick_adj_setup);
=20
 void __init ntp_init(void)
 {
-	ntp_clear();
+	for (int id =3D 0; id < TIMEKEEPERS_MAX; id++)
+		__ntp_clear(tk_ntp_data + id);
 	ntp_init_cmos_sync();
 }
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 5a633dce9057..7084d839c207 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -3,14 +3,13 @@
 #define _LINUX_NTP_INTERNAL_H
=20
 extern void ntp_init(void);
-extern void ntp_clear(void);
+extern void ntp_clear(unsigned int tkid);
 /* Returns how long ticks are at present, in ns / 2^NTP_SCALE_SHIFT. */
-extern u64 ntp_tick_length(void);
-extern ktime_t ntp_get_next_leap(void);
-extern int second_overflow(time64_t secs);
-extern int __do_adjtimex(struct __kernel_timex *txc,
-			 const struct timespec64 *ts,
-			 s32 *time_tai, struct audit_ntp_data *ad);
+extern u64 ntp_tick_length(unsigned int tkid);
+extern ktime_t ntp_get_next_leap(unsigned int tkid);
+extern int second_overflow(unsigned int tkid, time64_t secs);
+extern int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const=
 struct timespec64 *ts,
+			s32 *time_tai, struct audit_ntp_data *ad);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timesp=
ec64 *raw_ts);
=20
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2053b1a4c9e4..8b582174b1f9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1526,6 +1526,9 @@ static const struct k_clock * const posix_clocks[] =3D {
 	[CLOCK_REALTIME_ALARM]		=3D &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		=3D &alarm_clock,
 	[CLOCK_TAI]			=3D &clock_tai,
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+	[CLOCK_AUX ... CLOCK_AUX_LAST]	=3D &clock_aux,
+#endif
 };
=20
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 61906f0688c1..7f259e845d24 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -41,6 +41,7 @@ extern const struct k_clock clock_posix_dynamic;
 extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
+extern const struct k_clock clock_aux;
=20
 void posix_timer_queue_signal(struct k_itimer *timr);
=20
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a009c91f7b05..243fe25e680a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -6,6 +6,7 @@
 #include <linux/timekeeper_internal.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/kobject.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -25,6 +26,8 @@
 #include <linux/audit.h>
 #include <linux/random.h>
=20
+#include <vdso/auxclock.h>
+
 #include "tick-internal.h"
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -53,7 +56,32 @@ struct tk_data {
 	raw_spinlock_t		lock;
 } ____cacheline_aligned;
=20
-static struct tk_data tk_core;
+static struct tk_data timekeeper_data[TIMEKEEPERS_MAX];
+
+/* The core timekeeper */
+#define tk_core		(timekeeper_data[TIMEKEEPER_CORE])
+
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return ktime_get_aux_ts64(CLOCK_AUX + tkid - TIMEKEEPER_AUX_FIRST, ts);
+}
+
+static inline bool tk_is_aux(const struct timekeeper *tk)
+{
+	return tk->id >=3D TIMEKEEPER_AUX_FIRST && tk->id <=3D TIMEKEEPER_AUX_LAST;
+}
+#else
+static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return false;
+}
+
+static inline bool tk_is_aux(const struct timekeeper *tk)
+{
+	return false;
+}
+#endif
=20
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -113,6 +141,16 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned=
 =3D {
 	.base[1] =3D FAST_TK_INIT,
 };
=20
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static __init void tk_aux_setup(void);
+static void tk_aux_update_clocksource(void);
+static void tk_aux_advance(void);
+#else
+static inline void tk_aux_setup(void) { }
+static inline void tk_aux_update_clocksource(void) { }
+static inline void tk_aux_advance(void) { }
+#endif
+
 unsigned long timekeeper_lock_irqsave(void)
 {
 	unsigned long flags;
@@ -601,7 +639,7 @@ EXPORT_SYMBOL_GPL(pvclock_gtod_unregister_notifier);
  */
 static inline void tk_update_leap_state(struct timekeeper *tk)
 {
-	tk->next_leap_ktime =3D ntp_get_next_leap();
+	tk->next_leap_ktime =3D ntp_get_next_leap(tk->id);
 	if (tk->next_leap_ktime !=3D KTIME_MAX)
 		/* Convert to monotonic time */
 		tk->next_leap_ktime =3D ktime_sub(tk->next_leap_ktime, tk->offs_real);
@@ -663,7 +701,7 @@ static void timekeeping_restore_shadow(struct tk_data *tk=
d)
=20
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int=
 action)
 {
-	struct timekeeper *tk =3D &tk_core.shadow_timekeeper;
+	struct timekeeper *tk =3D &tkd->shadow_timekeeper;
=20
 	lockdep_assert_held(&tkd->lock);
=20
@@ -678,18 +716,22 @@ static void timekeeping_update_from_shadow(struct tk_da=
ta *tkd, unsigned int act
=20
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error =3D 0;
-		ntp_clear();
+		ntp_clear(tk->id);
 	}
=20
 	tk_update_leap_state(tk);
 	tk_update_ktime_data(tk);
+	tk->tkr_mono.base_real =3D tk->tkr_mono.base + tk->offs_real;
=20
-	update_vsyscall(tk);
-	update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
+	if (tk->id =3D=3D TIMEKEEPER_CORE) {
+		update_vsyscall(tk);
+		update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
=20
-	tk->tkr_mono.base_real =3D tk->tkr_mono.base + tk->offs_real;
-	update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
-	update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+		update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
+		update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+	} else if (tk_is_aux(tk)) {
+		vdso_time_update_aux(tk);
+	}
=20
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
@@ -975,9 +1017,14 @@ time64_t ktime_get_real_seconds(void)
 EXPORT_SYMBOL_GPL(ktime_get_real_seconds);
=20
 /**
- * __ktime_get_real_seconds - The same as ktime_get_real_seconds
- * but without the sequence counter protect. This internal function
- * is called just when timekeeping lock is already held.
+ * __ktime_get_real_seconds - Unprotected access to CLOCK_REALTIME seconds
+ *
+ * The same as ktime_get_real_seconds() but without the sequence counter
+ * protection. This function is used in restricted contexts like the x86 MCE
+ * handler and in KGDB. It's unprotected on 32-bit vs. concurrent half
+ * completed modification and only to be used for such critical contexts.
+ *
+ * Returns: Racy snapshot of the CLOCK_REALTIME seconds value
  */
 noinstr time64_t __ktime_get_real_seconds(void)
 {
@@ -1412,41 +1459,73 @@ int do_settimeofday64(const struct timespec64 *ts)
 }
 EXPORT_SYMBOL(do_settimeofday64);
=20
+static inline bool timekeeper_is_core_tk(struct timekeeper *tk)
+{
+	return !IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) || tk->id =3D=3D TIMEKEEPER_COR=
E;
+}
+
 /**
- * timekeeping_inject_offset - Adds or subtracts from the current time.
+ * __timekeeping_inject_offset - Adds or subtracts from the current time.
+ * @tkd:	Pointer to the timekeeper to modify
  * @ts:		Pointer to the timespec variable containing the offset
  *
  * Adds or subtracts an offset value from the current time.
  */
-static int timekeeping_inject_offset(const struct timespec64 *ts)
+static int __timekeeping_inject_offset(struct tk_data *tkd, const struct tim=
espec64 *ts)
 {
+	struct timekeeper *tks =3D &tkd->shadow_timekeeper;
+	struct timespec64 tmp;
+
 	if (ts->tv_nsec < 0 || ts->tv_nsec >=3D NSEC_PER_SEC)
 		return -EINVAL;
=20
-	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
-		struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
-		struct timespec64 tmp;
-
-		timekeeping_forward_now(tks);
+	timekeeping_forward_now(tks);
=20
+	if (timekeeper_is_core_tk(tks)) {
 		/* Make sure the proposed value is valid */
 		tmp =3D timespec64_add(tk_xtime(tks), *ts);
 		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
 		    !timespec64_valid_settod(&tmp)) {
-			timekeeping_restore_shadow(&tk_core);
+			timekeeping_restore_shadow(tkd);
 			return -EINVAL;
 		}
=20
 		tk_xtime_add(tks, ts);
 		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
-		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	} else {
+		struct tk_read_base *tkr_mono =3D &tks->tkr_mono;
+		ktime_t now, offs;
+
+		/* Get the current time */
+		now =3D ktime_add_ns(tkr_mono->base, timekeeping_get_ns(tkr_mono));
+		/* Add the relative offset change */
+		offs =3D ktime_add(tks->offs_aux, timespec64_to_ktime(*ts));
+
+		/* Prevent that the resulting time becomes negative */
+		if (ktime_add(now, offs) < 0) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+		tks->offs_aux =3D offs;
 	}
=20
-	/* Signal hrtimers about time change */
-	clock_was_set(CLOCK_SET_WALL);
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	return 0;
 }
=20
+static int timekeeping_inject_offset(const struct timespec64 *ts)
+{
+	int ret;
+
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock)
+		ret =3D __timekeeping_inject_offset(&tk_core, ts);
+
+	/* Signal hrtimers about time change */
+	if (!ret)
+		clock_was_set(CLOCK_SET_WALL);
+	return ret;
+}
+
 /*
  * Indicates if there is an offset between the system clock and the hardware
  * clock/persistent clock/rtc.
@@ -1522,6 +1601,8 @@ static int change_clocksource(void *data)
 		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	}
=20
+	tk_aux_update_clocksource();
+
 	if (old) {
 		if (old->disable)
 			old->disable(old);
@@ -1573,6 +1654,39 @@ void ktime_get_raw_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_raw_ts64);
=20
+/**
+ * ktime_get_clock_ts64 - Returns time of a clock in a timespec
+ * @id:		POSIX clock ID of the clock to read
+ * @ts:		Pointer to the timespec64 to be set
+ *
+ * The timestamp is invalidated (@ts->sec is set to -1) if the
+ * clock @id is not available.
+ */
+void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts)
+{
+	/* Invalidate time stamp */
+	ts->tv_sec =3D -1;
+	ts->tv_nsec =3D 0;
+
+	switch (id) {
+	case CLOCK_REALTIME:
+		ktime_get_real_ts64(ts);
+		return;
+	case CLOCK_MONOTONIC:
+		ktime_get_ts64(ts);
+		return;
+	case CLOCK_MONOTONIC_RAW:
+		ktime_get_raw_ts64(ts);
+		return;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+			ktime_get_aux_ts64(id, ts);
+		return;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+EXPORT_SYMBOL_GPL(ktime_get_clock_ts64);
=20
 /**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
@@ -1649,10 +1763,12 @@ read_persistent_wall_and_boot_offset(struct timespec6=
4 *wall_time,
 	*boot_offset =3D ns_to_timespec64(local_clock());
 }
=20
-static __init void tkd_basic_setup(struct tk_data *tkd)
+static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids =
tk_id, bool valid)
 {
 	raw_spin_lock_init(&tkd->lock);
 	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+	tkd->timekeeper.id =3D tkd->shadow_timekeeper.id =3D tk_id;
+	tkd->timekeeper.clock_valid =3D tkd->shadow_timekeeper.clock_valid =3D vali=
d;
 }
=20
 /*
@@ -1682,7 +1798,8 @@ void __init timekeeping_init(void)
 	struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
=20
-	tkd_basic_setup(&tk_core);
+	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE, true);
+	tk_aux_setup();
=20
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&
@@ -2034,7 +2151,7 @@ static __always_inline void timekeeping_apply_adjustmen=
t(struct timekeeper *tk,
  */
 static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
-	u64 ntp_tl =3D ntp_tick_length();
+	u64 ntp_tl =3D ntp_tick_length(tk->id);
 	u32 mult;
=20
 	/*
@@ -2115,7 +2232,7 @@ static inline unsigned int accumulate_nsecs_to_secs(str=
uct timekeeper *tk)
 		}
=20
 		/* Figure out if its a leap sec and apply if needed */
-		leap =3D second_overflow(tk->xtime_sec);
+		leap =3D second_overflow(tk->id, tk->xtime_sec);
 		if (unlikely(leap)) {
 			struct timespec64 ts;
=20
@@ -2181,16 +2298,14 @@ static u64 logarithmic_accumulation(struct timekeeper=
 *tk, u64 offset,
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static bool timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool __timekeeping_advance(struct tk_data *tkd, enum timekeeping_adv_=
mode mode)
 {
-	struct timekeeper *tk =3D &tk_core.shadow_timekeeper;
-	struct timekeeper *real_tk =3D &tk_core.timekeeper;
+	struct timekeeper *tk =3D &tkd->shadow_timekeeper;
+	struct timekeeper *real_tk =3D &tkd->timekeeper;
 	unsigned int clock_set =3D 0;
 	int shift =3D 0, maxshift;
 	u64 offset, orig_offset;
=20
-	guard(raw_spinlock_irqsave)(&tk_core.lock);
-
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
 		return false;
@@ -2214,7 +2329,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mo=
de mode)
 	shift =3D ilog2(offset) - ilog2(tk->cycle_interval);
 	shift =3D max(0, shift);
 	/* Bound shift to one less than what overflows tick_length */
-	maxshift =3D (64 - (ilog2(ntp_tick_length())+1)) - 1;
+	maxshift =3D (64 - (ilog2(ntp_tick_length(tk->id)) + 1)) - 1;
 	shift =3D min(shift, maxshift);
 	while (offset >=3D tk->cycle_interval) {
 		offset =3D logarithmic_accumulation(tk, offset, shift, &clock_set);
@@ -2239,19 +2354,27 @@ static bool timekeeping_advance(enum timekeeping_adv_=
mode mode)
 	if (orig_offset !=3D offset)
 		tk_update_coarse_nsecs(tk);
=20
-	timekeeping_update_from_shadow(&tk_core, clock_set);
+	timekeeping_update_from_shadow(tkd, clock_set);
=20
 	return !!clock_set;
 }
=20
+static bool timekeeping_advance(enum timekeeping_adv_mode mode)
+{
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
+	return __timekeeping_advance(&tk_core, mode);
+}
+
 /**
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
+ * It also updates the enabled auxiliary clock timekeepers
  */
 void update_wall_time(void)
 {
 	if (timekeeping_advance(TK_ADV_TICK))
 		clock_was_set_delayed();
+	tk_aux_advance();
 }
=20
 /**
@@ -2449,7 +2572,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwss=
eq, ktime_t *offs_real,
 /*
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtim=
ex
  */
-static int timekeeping_validate_timex(const struct __kernel_timex *txc)
+static int timekeeping_validate_timex(const struct __kernel_timex *txc, bool=
 aux_clock)
 {
 	if (txc->modes & ADJ_ADJTIME) {
 		/* singleshot must not be used with any other mode bits */
@@ -2508,6 +2631,20 @@ static int timekeeping_validate_timex(const struct __k=
ernel_timex *txc)
 			return -EINVAL;
 	}
=20
+	if (aux_clock) {
+		/* Auxiliary clocks are similar to TAI and do not have leap seconds */
+		if (txc->status & (STA_INS | STA_DEL))
+			return -EINVAL;
+
+		/* No TAI offset setting */
+		if (txc->modes & ADJ_TAI)
+			return -EINVAL;
+
+		/* No PPS support either */
+		if (txc->status & (STA_PPSFREQ | STA_PPSTIME))
+			return -EINVAL;
+	}
+
 	return 0;
 }
=20
@@ -2526,74 +2663,103 @@ unsigned long random_get_entropy_fallback(void)
 }
 EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
=20
-/**
- * do_adjtimex() - Accessor function to NTP __do_adjtimex function
- * @txc:	Pointer to kernel_timex structure containing NTP parameters
- */
-int do_adjtimex(struct __kernel_timex *txc)
+struct adjtimex_result {
+	struct audit_ntp_data	ad;
+	struct timespec64	delta;
+	bool			clock_set;
+};
+
+static int __do_adjtimex(struct tk_data *tkd, struct __kernel_timex *txc,
+			 struct adjtimex_result *result)
 {
-	struct audit_ntp_data ad;
-	bool offset_set =3D false;
-	bool clock_set =3D false;
+	struct timekeeper *tks =3D &tkd->shadow_timekeeper;
+	bool aux_clock =3D !timekeeper_is_core_tk(tks);
 	struct timespec64 ts;
+	s32 orig_tai, tai;
 	int ret;
=20
 	/* Validate the data before disabling interrupts */
-	ret =3D timekeeping_validate_timex(txc);
+	ret =3D timekeeping_validate_timex(txc, aux_clock);
 	if (ret)
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
=20
-	if (txc->modes & ADJ_SETOFFSET) {
-		struct timespec64 delta;
+	if (!aux_clock)
+		ktime_get_real_ts64(&ts);
+	else
+		tk_get_aux_ts64(tkd->timekeeper.id, &ts);
=20
-		delta.tv_sec  =3D txc->time.tv_sec;
-		delta.tv_nsec =3D txc->time.tv_usec;
+	add_device_randomness(&ts, sizeof(ts));
+
+	guard(raw_spinlock_irqsave)(&tkd->lock);
+
+	if (!tks->clock_valid)
+		return -ENODEV;
+
+	if (txc->modes & ADJ_SETOFFSET) {
+		result->delta.tv_sec  =3D txc->time.tv_sec;
+		result->delta.tv_nsec =3D txc->time.tv_usec;
 		if (!(txc->modes & ADJ_NANO))
-			delta.tv_nsec *=3D 1000;
-		ret =3D timekeeping_inject_offset(&delta);
+			result->delta.tv_nsec *=3D 1000;
+		ret =3D __timekeeping_inject_offset(tkd, &result->delta);
 		if (ret)
 			return ret;
-
-		offset_set =3D delta.tv_sec !=3D 0;
-		audit_tk_injoffset(delta);
+		result->clock_set =3D true;
 	}
=20
-	audit_ntp_init(&ad);
+	orig_tai =3D tai =3D tks->tai_offset;
+	ret =3D ntp_adjtimex(tks->id, txc, &ts, &tai, &result->ad);
=20
-	ktime_get_real_ts64(&ts);
-	add_device_randomness(&ts, sizeof(ts));
+	if (tai !=3D orig_tai) {
+		__timekeeping_set_tai_offset(tks, tai);
+		timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
+		result->clock_set =3D true;
+	} else {
+		tk_update_leap_state_all(&tk_core);
+	}
=20
-	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
-		struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
-		s32 orig_tai, tai;
+	/* Update the multiplier immediately if frequency was set directly */
+	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+		result->clock_set |=3D __timekeeping_advance(tkd, TK_ADV_FREQ);
=20
-		orig_tai =3D tai =3D tks->tai_offset;
-		ret =3D __do_adjtimex(txc, &ts, &tai, &ad);
+	return ret;
+}
=20
-		if (tai !=3D orig_tai) {
-			__timekeeping_set_tai_offset(tks, tai);
-			timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
-			clock_set =3D true;
-		} else {
-			tk_update_leap_state_all(&tk_core);
-		}
-	}
+/**
+ * do_adjtimex() - Accessor function to NTP __do_adjtimex function
+ * @txc:	Pointer to kernel_timex structure containing NTP parameters
+ */
+int do_adjtimex(struct __kernel_timex *txc)
+{
+	struct adjtimex_result result =3D { };
+	int ret;
=20
-	audit_ntp_log(&ad);
+	ret =3D __do_adjtimex(&tk_core, txc, &result);
+	if (ret < 0)
+		return ret;
=20
-	/* Update the multiplier immediately if frequency was set directly */
-	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		clock_set |=3D timekeeping_advance(TK_ADV_FREQ);
+	if (txc->modes & ADJ_SETOFFSET)
+		audit_tk_injoffset(result.delta);
=20
-	if (clock_set)
+	audit_ntp_log(&result.ad);
+
+	if (result.clock_set)
 		clock_was_set(CLOCK_SET_WALL);
=20
-	ntp_notify_cmos_timer(offset_set);
+	ntp_notify_cmos_timer(result.delta.tv_sec !=3D 0);
=20
 	return ret;
 }
=20
+/*
+ * Invoked from NTP with the time keeper lock held, so lockless access is
+ * fine.
+ */
+long ktime_get_ntp_seconds(unsigned int id)
+{
+	return timekeeper_data[id].timekeeper.xtime_sec;
+}
+
 #ifdef CONFIG_NTP_PPS
 /**
  * hardpps() - Accessor function to NTP __hardpps function
@@ -2607,3 +2773,316 @@ void hardpps(const struct timespec64 *phase_ts, const=
 struct timespec64 *raw_ts)
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
+
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+#include "posix-timers.h"
+
+/*
+ * Bitmap for the activated auxiliary timekeepers to allow lockless quick
+ * checks in the hot paths without touching extra cache lines. If set, then
+ * the state of the corresponding timekeeper has to be re-checked under
+ * timekeeper::lock.
+ */
+static unsigned long aux_timekeepers;
+
+static inline unsigned int clockid_to_tkid(unsigned int id)
+{
+	return TIMEKEEPER_AUX_FIRST + id - CLOCK_AUX;
+}
+
+static inline struct tk_data *aux_get_tk_data(clockid_t id)
+{
+	if (!clockid_aux_valid(id))
+		return NULL;
+	return &timekeeper_data[clockid_to_tkid(id)];
+}
+
+/* Invoked from timekeeping after a clocksource change */
+static void tk_aux_update_clocksource(void)
+{
+	unsigned long active =3D READ_ONCE(aux_timekeepers);
+	unsigned int id;
+
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *tkd =3D &timekeeper_data[id + TIMEKEEPER_AUX_FIRST];
+		struct timekeeper *tks =3D &tkd->shadow_timekeeper;
+
+		guard(raw_spinlock_irqsave)(&tkd->lock);
+		if (!tks->clock_valid)
+			continue;
+
+		timekeeping_forward_now(tks);
+		tk_setup_internals(tks, tk_core.timekeeper.tkr_mono.clock);
+		timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+	}
+}
+
+static void tk_aux_advance(void)
+{
+	unsigned long active =3D READ_ONCE(aux_timekeepers);
+	unsigned int id;
+
+	/* Lockless quick check to avoid extra cache lines */
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *aux_tkd =3D &timekeeper_data[id + TIMEKEEPER_AUX_FIRST];
+
+		guard(raw_spinlock)(&aux_tkd->lock);
+		if (aux_tkd->shadow_timekeeper.clock_valid)
+			__timekeeping_advance(aux_tkd, TK_ADV_TICK);
+	}
+}
+
+/**
+ * ktime_get_aux - Get time for a AUX clock
+ * @id:	ID of the clock to read (CLOCK_AUX...)
+ * @kt:	Pointer to ktime_t to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_aux(clockid_t id, ktime_t *kt)
+{
+	struct tk_data *aux_tkd =3D aux_get_tk_data(id);
+	struct timekeeper *aux_tk;
+	unsigned int seq;
+	ktime_t base;
+	u64 nsecs;
+
+	WARN_ON(timekeeping_suspended);
+
+	if (!aux_tkd)
+		return false;
+
+	aux_tk =3D &aux_tkd->timekeeper;
+	do {
+		seq =3D read_seqcount_begin(&aux_tkd->seq);
+		if (!aux_tk->clock_valid)
+			return false;
+
+		base =3D ktime_add(aux_tk->tkr_mono.base, aux_tk->offs_aux);
+		nsecs =3D timekeeping_get_ns(&aux_tk->tkr_mono);
+	} while (read_seqcount_retry(&aux_tkd->seq, seq));
+
+	*kt =3D ktime_add_ns(base, nsecs);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_aux);
+
+/**
+ * ktime_get_aux_ts64 - Get time for a AUX clock
+ * @id:	ID of the clock to read (CLOCK_AUX...)
+ * @ts:	Pointer to timespec64 to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *ts)
+{
+	ktime_t now;
+
+	if (!ktime_get_aux(id, &now))
+		return false;
+	*ts =3D ktime_to_timespec64(now);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_aux_ts64);
+
+static int aux_get_res(clockid_t id, struct timespec64 *tp)
+{
+	if (!clockid_aux_valid(id))
+		return -ENODEV;
+
+	tp->tv_sec =3D aux_clock_resolution_ns() / NSEC_PER_SEC;
+	tp->tv_nsec =3D aux_clock_resolution_ns() % NSEC_PER_SEC;
+	return 0;
+}
+
+static int aux_get_timespec(clockid_t id, struct timespec64 *tp)
+{
+	return ktime_get_aux_ts64(id, tp) ? 0 : -ENODEV;
+}
+
+static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
+{
+	struct tk_data *aux_tkd =3D aux_get_tk_data(id);
+	struct timekeeper *aux_tks;
+	ktime_t tnow, nsecs;
+
+	if (!timespec64_valid_settod(tnew))
+		return -EINVAL;
+	if (!aux_tkd)
+		return -ENODEV;
+
+	aux_tks =3D &aux_tkd->shadow_timekeeper;
+
+	guard(raw_spinlock_irq)(&aux_tkd->lock);
+	if (!aux_tks->clock_valid)
+		return -ENODEV;
+
+	/* Forward the timekeeper base time */
+	timekeeping_forward_now(aux_tks);
+	/*
+	 * Get the updated base time. tkr_mono.base has not been
+	 * updated yet, so do that first. That makes the update
+	 * in timekeeping_update_from_shadow() redundant, but
+	 * that's harmless. After that @tnow can be calculated
+	 * by using tkr_mono::cycle_last, which has been set
+	 * by timekeeping_forward_now().
+	 */
+	tk_update_ktime_data(aux_tks);
+	nsecs =3D timekeeping_cycles_to_ns(&aux_tks->tkr_mono, aux_tks->tkr_mono.cy=
cle_last);
+	tnow =3D ktime_add(aux_tks->tkr_mono.base, nsecs);
+
+	/*
+	 * Calculate the new AUX offset as delta to @tnow ("monotonic").
+	 * That avoids all the tk::xtime back and forth conversions as
+	 * xtime ("realtime") is not applicable for auxiliary clocks and
+	 * kept in sync with "monotonic".
+	 */
+	aux_tks->offs_aux =3D ktime_sub(timespec64_to_ktime(*tnew), tnow);
+
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+	return 0;
+}
+
+static int aux_clock_adj(const clockid_t id, struct __kernel_timex *txc)
+{
+	struct tk_data *aux_tkd =3D aux_get_tk_data(id);
+	struct adjtimex_result result =3D { };
+
+	if (!aux_tkd)
+		return -ENODEV;
+
+	/*
+	 * @result is ignored for now as there are neither hrtimers nor a
+	 * RTC related to auxiliary clocks for now.
+	 */
+	return __do_adjtimex(aux_tkd, txc, &result);
+}
+
+const struct k_clock clock_aux =3D {
+	.clock_getres		=3D aux_get_res,
+	.clock_get_timespec	=3D aux_get_timespec,
+	.clock_set		=3D aux_clock_set,
+	.clock_adj		=3D aux_clock_adj,
+};
+
+static void aux_clock_enable(clockid_t id)
+{
+	struct tk_read_base *tkr_raw =3D &tk_core.timekeeper.tkr_raw;
+	struct tk_data *aux_tkd =3D aux_get_tk_data(id);
+	struct timekeeper *aux_tks =3D &aux_tkd->shadow_timekeeper;
+
+	/* Prevent the core timekeeper from changing. */
+	guard(raw_spinlock_irq)(&tk_core.lock);
+
+	/*
+	 * Setup the auxiliary clock assuming that the raw core timekeeper
+	 * clock frequency conversion is close enough. Userspace has to
+	 * adjust for the deviation via clock_adjtime(2).
+	 */
+	guard(raw_spinlock_nested)(&aux_tkd->lock);
+
+	/* Remove leftovers of a previous registration */
+	memset(aux_tks, 0, sizeof(*aux_tks));
+	/* Restore the timekeeper id */
+	aux_tks->id =3D aux_tkd->timekeeper.id;
+	/* Setup the timekeeper based on the current system clocksource */
+	tk_setup_internals(aux_tks, tkr_raw->clock);
+
+	/* Mark it valid and set it live */
+	aux_tks->clock_valid =3D true;
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+}
+
+static void aux_clock_disable(clockid_t id)
+{
+	struct tk_data *aux_tkd =3D aux_get_tk_data(id);
+
+	guard(raw_spinlock_irq)(&aux_tkd->lock);
+	aux_tkd->shadow_timekeeper.clock_valid =3D false;
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+}
+
+static DEFINE_MUTEX(aux_clock_mutex);
+
+static ssize_t aux_clock_enable_store(struct kobject *kobj, struct kobj_attr=
ibute *attr,
+				      const char *buf, size_t count)
+{
+	/* Lazy atoi() as name is "0..7" */
+	int id =3D kobj->name[0] & 0x7;
+	bool enable;
+
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	guard(mutex)(&aux_clock_mutex);
+	if (enable =3D=3D test_bit(id, &aux_timekeepers))
+		return count;
+
+	if (enable) {
+		aux_clock_enable(CLOCK_AUX + id);
+		set_bit(id, &aux_timekeepers);
+	} else {
+		aux_clock_disable(CLOCK_AUX + id);
+		clear_bit(id, &aux_timekeepers);
+	}
+	return count;
+}
+
+static ssize_t aux_clock_enable_show(struct kobject *kobj, struct kobj_attri=
bute *attr, char *buf)
+{
+	unsigned long active =3D READ_ONCE(aux_timekeepers);
+	/* Lazy atoi() as name is "0..7" */
+	int id =3D kobj->name[0] & 0x7;
+
+	return sysfs_emit(buf, "%d\n", test_bit(id, &active));
+}
+
+static struct kobj_attribute aux_clock_enable_attr =3D __ATTR_RW(aux_clock_e=
nable);
+
+static struct attribute *aux_clock_enable_attrs[] =3D {
+	&aux_clock_enable_attr.attr,
+	NULL
+};
+
+static const struct attribute_group aux_clock_enable_attr_group =3D {
+	.attrs =3D aux_clock_enable_attrs,
+};
+
+static int __init tk_aux_sysfs_init(void)
+{
+	struct kobject *auxo, *tko =3D kobject_create_and_add("time", kernel_kobj);
+
+	if (!tko)
+		return -ENOMEM;
+
+	auxo =3D kobject_create_and_add("aux_clocks", tko);
+	if (!auxo) {
+		kobject_put(tko);
+		return -ENOMEM;
+	}
+
+	for (int i =3D 0; i <=3D MAX_AUX_CLOCKS; i++) {
+		char id[2] =3D { [0] =3D '0' + i, };
+		struct kobject *clk =3D kobject_create_and_add(id, auxo);
+
+		if (!clk)
+			return -ENOMEM;
+
+		int ret =3D sysfs_create_group(clk, &aux_clock_enable_attr_group);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+late_initcall(tk_aux_sysfs_init);
+
+static __init void tk_aux_setup(void)
+{
+	for (int i =3D TIMEKEEPER_AUX_FIRST; i <=3D TIMEKEEPER_AUX_LAST; i++)
+		tkd_basic_setup(&timekeeper_data[i], i, false);
+}
+#endif /* CONFIG_POSIX_AUX_CLOCKS */
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_int=
ernal.h
index 8c9079108ffb..973ede670a36 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -45,4 +45,7 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 =
mask, u64 max_delta)
 unsigned long timekeeper_lock_irqsave(void);
 void timekeeper_unlock_irqrestore(unsigned long flags);
=20
+/* NTP specific interface to access the current seconds value */
+long ktime_get_ntp_seconds(unsigned int id);
+
 #endif /* _TIMEKEEPING_INTERNAL_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 32ef27c71b57..8ba8b0d8a387 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -15,26 +15,25 @@
=20
 #include "timekeeping_internal.h"
=20
+static inline void fill_clock_configuration(struct vdso_clock *vc, const str=
uct tk_read_base *base)
+{
+	vc->cycle_last	=3D base->cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vc->max_cycles	=3D base->clock->max_cycles;
+#endif
+	vc->mask	=3D base->mask;
+	vc->mult	=3D base->mult;
+	vc->shift	=3D base->shift;
+}
+
 static inline void update_vdso_time_data(struct vdso_time_data *vdata, struc=
t timekeeper *tk)
 {
 	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec, sec;
=20
-	vc[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
-#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vc[CS_HRES_COARSE].max_cycles	=3D tk->tkr_mono.clock->max_cycles;
-#endif
-	vc[CS_HRES_COARSE].mask		=3D tk->tkr_mono.mask;
-	vc[CS_HRES_COARSE].mult		=3D tk->tkr_mono.mult;
-	vc[CS_HRES_COARSE].shift	=3D tk->tkr_mono.shift;
-	vc[CS_RAW].cycle_last		=3D tk->tkr_raw.cycle_last;
-#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vc[CS_RAW].max_cycles		=3D tk->tkr_raw.clock->max_cycles;
-#endif
-	vc[CS_RAW].mask			=3D tk->tkr_raw.mask;
-	vc[CS_RAW].mult			=3D tk->tkr_raw.mult;
-	vc[CS_RAW].shift		=3D tk->tkr_raw.shift;
+	fill_clock_configuration(&vc[CS_HRES_COARSE],	&tk->tkr_mono);
+	fill_clock_configuration(&vc[CS_RAW],		&tk->tkr_raw);
=20
 	/* CLOCK_MONOTONIC */
 	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
@@ -119,7 +118,8 @@ void update_vsyscall(struct timekeeper *tk)
 	if (clock_mode !=3D VDSO_CLOCKMODE_NONE)
 		update_vdso_time_data(vdata, tk);
=20
-	__arch_update_vsyscall(vdata);
+	__arch_update_vdso_clock(&vc[CS_HRES_COARSE]);
+	__arch_update_vdso_clock(&vc[CS_RAW]);
=20
 	vdso_write_end(vdata);
=20
@@ -136,6 +136,46 @@ void update_vsyscall_tz(void)
 	__arch_sync_vdso_time_data(vdata);
 }
=20
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+void vdso_time_update_aux(struct timekeeper *tk)
+{
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
+	struct vdso_timestamp *vdso_ts;
+	struct vdso_clock *vc;
+	s32 clock_mode;
+	u64 nsec;
+
+	vc =3D &vdata->aux_clock_data[tk->id - TIMEKEEPER_AUX_FIRST];
+	vdso_ts =3D &vc->basetime[VDSO_BASE_AUX];
+	clock_mode =3D tk->tkr_mono.clock->vdso_clock_mode;
+	if (!tk->clock_valid)
+		clock_mode =3D VDSO_CLOCKMODE_NONE;
+
+	/* copy vsyscall data */
+	vdso_write_begin_clock(vc);
+
+	vc->clock_mode =3D clock_mode;
+
+	if (clock_mode !=3D VDSO_CLOCKMODE_NONE) {
+		fill_clock_configuration(vc, &tk->tkr_mono);
+
+		vdso_ts->sec	=3D tk->xtime_sec;
+
+		nsec =3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+		nsec +=3D tk->offs_aux;
+		vdso_ts->sec +=3D __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+		nsec =3D nsec << tk->tkr_mono.shift;
+		vdso_ts->nsec =3D nsec;
+	}
+
+	__arch_update_vdso_clock(vc);
+
+	vdso_write_end_clock(vc);
+
+	__arch_sync_vdso_time_data(vdata);
+}
+#endif
+
 /**
  * vdso_update_begin - Start of a VDSO update section
  *
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 93ef801a97ef..02ea19f67164 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -2,6 +2,7 @@
 /*
  * Generic userspace implementations of gettimeofday() and similar.
  */
+#include <vdso/auxclock.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
=20
@@ -71,6 +72,42 @@ static inline bool vdso_cycles_ok(u64 cycles)
 }
 #endif
=20
+static __always_inline bool vdso_clockid_valid(clockid_t clock)
+{
+	/* Check for negative values or invalid clocks */
+	return likely((u32) clock <=3D CLOCK_AUX_LAST);
+}
+
+/*
+ * Must not be invoked within the sequence read section as a race inside
+ * that loop could result in __iter_div_u64_rem() being extremely slow.
+ */
+static __always_inline void vdso_set_timespec(struct __kernel_timespec *ts, =
u64 sec, u64 ns)
+{
+	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec =3D ns;
+}
+
+static __always_inline
+bool vdso_get_timestamp(const struct vdso_time_data *vd, const struct vdso_c=
lock *vc,
+			unsigned int clkidx, u64 *sec, u64 *ns)
+{
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clkidx];
+	u64 cycles;
+
+	if (unlikely(!vdso_clocksource_ok(vc)))
+		return false;
+
+	cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
+	if (unlikely(!vdso_cycles_ok(cycles)))
+		return false;
+
+	*ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
+	*sec =3D vdso_ts->sec;
+
+	return true;
+}
+
 #ifdef CONFIG_TIME_NS
=20
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -82,48 +119,35 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_da=
ta(const struct vdso_tim
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 static __always_inline
-int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
-		   clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,
+		    clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
 	const struct vdso_clock *vc =3D vd->clock_data;
-	const struct vdso_timestamp *vdso_ts;
-	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
+	u64 ns;
=20
 	if (clk !=3D CLOCK_MONOTONIC_RAW)
 		vc =3D &vc[CS_HRES_COARSE];
 	else
 		vc =3D &vc[CS_RAW];
-	vdso_ts =3D &vc->basetime[clk];
=20
 	do {
 		seq =3D vdso_read_begin(vc);
=20
-		if (unlikely(!vdso_clocksource_ok(vc)))
-			return -1;
-
-		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
-			return -1;
-		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec =3D vdso_ts->sec;
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
+			return false;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/* Add the namespace offset */
 	sec +=3D offs->sec;
 	ns +=3D offs->nsec;
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
+	vdso_set_timespec(ts, sec, ns);
=20
-	return 0;
+	return true;
 }
 #else
 static __always_inline
@@ -133,24 +157,23 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_d=
ata(const struct vdso_tim
 }
=20
 static __always_inline
-int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
-		   clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,
+		    clockid_t clk, struct __kernel_timespec *ts)
 {
-	return -EINVAL;
+	return false;
 }
 #endif
=20
 static __always_inline
-int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
-	    clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	     clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
-	u64 cycles, sec, ns;
+	u64 sec, ns;
 	u32 seq;
=20
 	/* Allows to compile the high resolution parts out */
 	if (!__arch_vdso_hres_capable())
-		return -1;
+		return false;
=20
 	do {
 		/*
@@ -172,30 +195,19 @@ int do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 		}
 		smp_rmb();
=20
-		if (unlikely(!vdso_clocksource_ok(vc)))
-			return -1;
-
-		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
-			return -1;
-		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec =3D vdso_ts->sec;
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
+			return false;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
+	vdso_set_timespec(ts, sec, ns);
=20
-	return 0;
+	return true;
 }
=20
 #ifdef CONFIG_TIME_NS
 static __always_inline
-int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
-		     clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
+		      clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
@@ -217,26 +229,22 @@ int do_coarse_timens(const struct vdso_time_data *vdns,=
 const struct vdso_clock
 	sec +=3D offs->sec;
 	nsec +=3D offs->nsec;
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
-	ts->tv_nsec =3D nsec;
-	return 0;
+	vdso_set_timespec(ts, sec, nsec);
+
+	return true;
 }
 #else
 static __always_inline
-int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
-		     clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
+		      clockid_t clk, struct __kernel_timespec *ts)
 {
-	return -1;
+	return false;
 }
 #endif
=20
 static __always_inline
-int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
-	      clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	       clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u32 seq;
@@ -258,19 +266,60 @@ int do_coarse(const struct vdso_time_data *vd, const st=
ruct vdso_clock *vc,
 		ts->tv_nsec =3D vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
-	return 0;
+	return true;
+}
+
+static __always_inline
+bool do_aux(const struct vdso_time_data *vd, clockid_t clock, struct __kerne=
l_timespec *ts)
+{
+	const struct vdso_clock *vc;
+	u32 seq, idx;
+	u64 sec, ns;
+
+	if (!IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+		return false;
+
+	idx =3D clock - CLOCK_AUX;
+	vc =3D &vd->aux_clock_data[idx];
+
+	do {
+		/*
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
+		 */
+		while ((seq =3D READ_ONCE(vc->seq)) & 1) {
+			if (IS_ENABLED(CONFIG_TIME_NS) && vc->clock_mode =3D=3D VDSO_CLOCKMODE_TI=
MENS) {
+				vd =3D __arch_get_vdso_u_timens_data(vd);
+				vc =3D &vd->aux_clock_data[idx];
+				/* Re-read from the real time data page */
+				continue;
+			}
+			cpu_relax();
+		}
+		smp_rmb();
+
+		/* Auxclock disabled? */
+		if (vc->clock_mode =3D=3D VDSO_CLOCKMODE_NONE)
+			return false;
+
+		if (!vdso_get_timestamp(vd, vc, VDSO_BASE_AUX, &sec, &ns))
+			return false;
+	} while (unlikely(vdso_read_retry(vc, seq)));
+
+	vdso_set_timespec(ts, sec, ns);
+
+	return true;
 }
=20
-static __always_inline int
+static __always_inline bool
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
 {
 	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
=20
-	/* Check for negative values or invalid clocks */
-	if (unlikely((u32) clock >=3D MAX_CLOCKS))
-		return -1;
+	if (!vdso_clockid_valid(clock))
+		return false;
=20
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
@@ -283,8 +332,10 @@ __cvdso_clock_gettime_common(const struct vdso_time_data=
 *vd, clockid_t clock,
 		return do_coarse(vd, &vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
 		vc =3D &vc[CS_RAW];
+	else if (msk & VDSO_AUX)
+		return do_aux(vd, clock, ts);
 	else
-		return -1;
+		return false;
=20
 	return do_hres(vd, vc, clock, ts);
 }
@@ -293,9 +344,11 @@ static __maybe_unused int
 __cvdso_clock_gettime_data(const struct vdso_time_data *vd, clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
-	int ret =3D __cvdso_clock_gettime_common(vd, clock, ts);
+	bool ok;
+
+	ok =3D __cvdso_clock_gettime_common(vd, clock, ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_gettime_fallback(clock, ts);
 	return 0;
 }
@@ -312,18 +365,18 @@ __cvdso_clock_gettime32_data(const struct vdso_time_dat=
a *vd, clockid_t clock,
 			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
-	int ret;
+	bool ok;
=20
-	ret =3D __cvdso_clock_gettime_common(vd, clock, &ts);
+	ok =3D __cvdso_clock_gettime_common(vd, clock, &ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_gettime32_fallback(clock, res);
=20
-	/* For ret =3D=3D 0 */
+	/* For ok =3D=3D true */
 	res->tv_sec =3D ts.tv_sec;
 	res->tv_nsec =3D ts.tv_nsec;
=20
-	return ret;
+	return 0;
 }
=20
 static __maybe_unused int
@@ -342,7 +395,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
=20
-		if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (!do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
=20
 		tv->tv_sec =3D ts.tv_sec;
@@ -396,16 +449,15 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(=
__kernel_old_time_t *time
=20
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
-				struct __kernel_timespec *res)
+bool __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t =
clock,
+				 struct __kernel_timespec *res)
 {
 	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
 	u64 ns;
=20
-	/* Check for negative values or invalid clocks */
-	if (unlikely((u32) clock >=3D MAX_CLOCKS))
-		return -1;
+	if (!vdso_clockid_valid(clock))
+		return false;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
@@ -426,24 +478,28 @@ int __cvdso_clock_getres_common(const struct vdso_time_=
data *vd, clockid_t clock
 		 * Preserves the behaviour of posix_get_coarse_res().
 		 */
 		ns =3D LOW_RES_NSEC;
+	} else if (msk & VDSO_AUX) {
+		ns =3D aux_clock_resolution_ns();
 	} else {
-		return -1;
+		return false;
 	}
=20
 	if (likely(res)) {
 		res->tv_sec =3D 0;
 		res->tv_nsec =3D ns;
 	}
-	return 0;
+	return true;
 }
=20
 static __maybe_unused
 int __cvdso_clock_getres_data(const struct vdso_time_data *vd, clockid_t clo=
ck,
 			      struct __kernel_timespec *res)
 {
-	int ret =3D __cvdso_clock_getres_common(vd, clock, res);
+	bool ok;
=20
-	if (unlikely(ret))
+	ok =3D  __cvdso_clock_getres_common(vd, clock, res);
+
+	if (unlikely(!ok))
 		return clock_getres_fallback(clock, res);
 	return 0;
 }
@@ -460,18 +516,18 @@ __cvdso_clock_getres_time32_data(const struct vdso_time=
_data *vd, clockid_t cloc
 				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
-	int ret;
+	bool ok;
=20
-	ret =3D __cvdso_clock_getres_common(vd, clock, &ts);
+	ok =3D __cvdso_clock_getres_common(vd, clock, &ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_getres32_fallback(clock, res);
=20
 	if (likely(res)) {
 		res->tv_sec =3D ts.tv_sec;
 		res->tv_nsec =3D ts.tv_nsec;
 	}
-	return ret;
+	return 0;
 }
=20
 static __maybe_unused int


