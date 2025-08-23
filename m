Return-Path: <linux-kernel+bounces-782911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F1B326CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 06:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1477BBB9A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 04:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3C212569;
	Sat, 23 Aug 2025 04:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TNDxbOIw"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57353393DF4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755922819; cv=none; b=GjAipfOIS+4/HaspgOBtgpw36Kxy9PYMaHGPkEH7zslNkI/NcL2EpVAwLne5wHI4g/WG2AI/FqV/YFjRdyVmLGYLq49T9d2HuXYbcrFNiC9vwQBzccgUxWutj6lN1++YzvviWvigXQw1uR3UAbcOZXbyGCZ2b5poBF+RpPnXpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755922819; c=relaxed/simple;
	bh=geH/2/dEmefYTs8LsKskD5hMbxIdV69fdN0JKHDYKzY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/+ihdt/TN3KL9kyJ3E87S2zmf00GBafPPh3IFoJcoY0hzwrcDCK3NhTvmBIWZfhWVKJExieKEHlRCn78oh22g1PKG8q+qBj2PsuRTxGGKuIduxykwmQk+kW6mTn0bR/BQ9JdvdaN6Akipaz+7XUh/Nt1smjOJIqTrtGKDUsWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TNDxbOIw; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57N4JYlf854535;
	Fri, 22 Aug 2025 23:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755922774;
	bh=KKZnIH6gv75VfTKwVgLDkiUmzBQdoIwEj6j1RUMmWgE=;
	h=From:To:Subject:Date;
	b=TNDxbOIwtxNxv79RoMAuKp21EZurcVbeJ8aOI7tMJshe5wuVdM0bpXO/zFjruuPRZ
	 sxDpMnN3sJwwP1jBW2yK5UoIuteyvSBvk6oLfwmz7V+je+gdtwf6DbZYutKM6sX+U2
	 D9FlMLZRKqukkjWmrGmHKlA5BPD8ntUuN6CXLTYo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57N4JXgt3180198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 23:19:33 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 23:19:33 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Fri, 22 Aug
 2025 23:19:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 23:19:33 -0500
Received: from uda0513920.dhcp.ti.com (uda0513920.dhcp.ti.com [10.24.68.114])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57N4JQST624491;
	Fri, 22 Aug 2025 23:19:26 -0500
From: vishnu singh <v-singh1@ti.com>
To: <mark.rutland@arm.com>, <maz@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <jstultz@google.com>, <Ttglx@linutronix.de>,
        <sboyd@kernel.org>, <akpm@linux-foundation.org>,
        <chenhuacai@kernel.org>, <pmladek@suse.com>, <agordeev@linux.ibm.com>,
        <bigeasy@linutronix.de>, <urezki@gmail.com>, <Llillian@star-ark.net>,
        <francesco@valla.it>, <guoweikang.kernel@gmail.com>,
        <alexander.shishkin@linux.intel.com>, <rrangel@chromium.org>,
        <kpsingh@kernel.org>, <anna-maria@linutronix.de>, <mingo@kernel.org>,
        <frederic@kernel.org>, <boe@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot timestamp
Date: Sat, 23 Aug 2025 09:49:25 +0530
Message-ID: <20250823041925.153091-1-v-singh1@ti.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vishnu Singh <v-singh1@ti.com>

Part of BOOT SIG Initiative, This patch adds a tiny,opt-in facility to
help measure kernel boot duration without full tracing:

New CONFIG_BOOT_TIME_TRACKER in kernel/time/Kconfig.
When enabled, the kernel logs two boot markers:
    1. kernel entry in start_kernel()
    2. first userspace start in kernel_init() before run_init_process()

These markers are intended for post-boot parsers to compute coarse
kernel boot time and to merge with bootloader/MCU/DSP records into
a unified timeline.

Core helper u64 boot_time_now() in kernel/time/boot_time_now.c,
exporting a counter‑derived timestamp via small per-arch primitives.
This series includes an initial arm64 primitive that uses CNTVCT_EL0
as the source, other architectures can wire up equivalents.

Files touched:
kernel/time/Kconfig, kernel/time/Makefile
kernel/time/boot_time_now.c (new core helper)
arch/arm64/include/asm/boot_time_primitives.h (arm64 primitive)
include/linux/boot_time_now.h (public API + IDs)
init/main.c (print two markers)

This complements U-Boot’s stashed bootstage records so a userspace tool
can build a system-wide boot timeline across SPL, U-Boot, kernel and other
subsystems.

Reference boot-time parser utility:
     https://github.com/v-singh1/boot-time-parser

Sample boot time report:
+--------------------------------------------------------------------+
                 am62xx-evm Boot Time Report
+--------------------------------------------------------------------+
Device Power On         : 0 ms
SPL Time                : 843 ms
U-Boot Time             : 2173 ms
Kernel handoff time     : 462 ms
Kernel Time             : 2522 ms
Total Boot Time         : 6000 ms
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
                 Bootloader and Kernel Boot Records
+--------------------------------------------------------------------+
BOOTSTAGE_AWAKE                =      0 ms (+  0 ms)
BOOTSTAGE_START_UBOOT_F        =    843 ms (+  0 ms)
BOOTSTAGE_ACCUM_DM_F           =    843 ms (+  0 ms)
BOOTSTAGE_START_UBOOT_R        =   1951 ms (+1108 ms)
BOOTSTAGE_ACCUM_DM_R           =   1951 ms (+  0 ms)
BOOTSTAGE_NET_ETH_START        =   2032 ms (+ 81 ms)
BOOTSTAGE_NET_ETH_INIT         =   2053 ms (+ 21 ms)
BOOTSTAGE_MAIN_LOOP            =   2055 ms (+  2 ms)
BOOTSTAGE_START_MCU            =   2661 ms (+606 ms)
BOOTSTAGE_BOOTM_START          =   2959 ms (+298 ms)
BOOTSTAGE_RUN_OS               =   3016 ms (+ 57 ms)
BOOTSTAGE_BOOTM_HANDOFF        =   3016 ms (+  0 ms)
BOOTSTAGE_KERNEL_START         =   3478 ms (+462 ms)
BOOTSTAGE_KERNEL_END           =   6000 ms (+2522 ms)
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
                 MCU Boot Records
+--------------------------------------------------------------------+
MCU_AWAKE                      =   2661 ms (+  0 ms)
BOARD_PERIPHERALS_INIT         =   2661 ms (+  0 ms)
MAIN_TASK_CREATE               =   2661 ms (+  0 ms)
FIRST_TASK                     =   2662 ms (+  1 ms)
DRIVERS_OPEN                   =   2662 ms (+  0 ms)
BOARD_DRIVERS_OPEN             =   2662 ms (+  0 ms)
IPC_SYNC_FOR_LINUX             =   6636 ms (+3974 ms)
IPC_REGISTER_CLIENT            =   6636 ms (+  0 ms)
IPC_SUSPEND_TASK               =   6636 ms (+  0 ms)
IPC_RECEIVE_TASK               =   6636 ms (+  0 ms)
IPC_SYNC_ALL                   =   6787 ms (+151 ms)
+--------------------------------------------------------------------+

Signed-off-by: Vishnu Singh <v-singh1@ti.com>
---
 MAINTAINERS                                   |  3 +++
 arch/arm64/include/asm/boot_time_primitives.h | 14 ++++++++++++++
 include/linux/boot_time_now.h                 | 16 ++++++++++++++++
 init/main.c                                   | 13 +++++++++++++
 kernel/time/Kconfig                           | 10 ++++++++++
 kernel/time/Makefile                          |  1 +
 kernel/time/boot_time_now.c                   | 13 +++++++++++++
 7 files changed, 70 insertions(+)
 create mode 100644 arch/arm64/include/asm/boot_time_primitives.h
 create mode 100644 include/linux/boot_time_now.h
 create mode 100644 kernel/time/boot_time_now.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e913c1edd1fd..e5273b338814 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1994,6 +1994,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
+F:	arch/arm64/include/asm/boot_time_primitives.h
 F:	drivers/clocksource/arm_arch_timer.c
 F:	drivers/clocksource/arm_arch_timer_mmio.c
 
@@ -25466,6 +25467,7 @@ R:	Stephen Boyd <sboyd@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
+F:	include/linux/boot_time_now.h
 F:	include/linux/clocksource.h
 F:	include/linux/time.h
 F:	include/linux/timekeeper_internal.h
@@ -25474,6 +25476,7 @@ F:	include/linux/timex.h
 F:	include/uapi/linux/time.h
 F:	include/uapi/linux/timex.h
 F:	kernel/time/alarmtimer.c
+F:	kernel/time/boot_time_now.c
 F:	kernel/time/clocksource*
 F:	kernel/time/ntp*
 F:	kernel/time/time.c
diff --git a/arch/arm64/include/asm/boot_time_primitives.h b/arch/arm64/include/asm/boot_time_primitives.h
new file mode 100644
index 000000000000..9bbbd500a95d
--- /dev/null
+++ b/arch/arm64/include/asm/boot_time_primitives.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_BOOT_TIME_PRIMITIVES_H
+#define __ASM_BOOT_TIME_PRIMITIVES_H
+
+#include <asm/arch_timer.h>
+#include <linux/math64.h>
+
+static inline u64 arch_boot_counter_now(void)
+{
+	return ((arch_timer_read_cntvct_el0() * 1000000) / arch_timer_get_cntfrq());
+}
+
+#endif
diff --git a/include/linux/boot_time_now.h b/include/linux/boot_time_now.h
new file mode 100644
index 000000000000..a18a1809057f
--- /dev/null
+++ b/include/linux/boot_time_now.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_BOOT_TRACKER_H
+#define _LINUX_BOOT_TRACKER_H
+
+#include <linux/types.h>
+
+enum kernel_bootstage_id {
+	BOOTSTAGE_ID_KERNEL_START = 300,
+	BOOTSTAGE_ID_KERNEL_END = 301,
+};
+
+/* Return boot time in nanoseconds using hardware counter */
+u64 boot_time_now(void);
+
+#endif
diff --git a/init/main.c b/init/main.c
index 9b5150166bcf..76eb8098ab20 100644
--- a/init/main.c
+++ b/init/main.c
@@ -115,6 +115,10 @@
 
 #include <kunit/test.h>
 
+#ifdef CONFIG_BOOT_TIME_TRACKER
+#include <linux/boot_time_now.h>
+#endif
+
 static int kernel_init(void *);
 
 /*
@@ -929,6 +933,11 @@ void start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
+
+#ifdef CONFIG_BOOT_TIME_TRACKER
+	pr_info("[BOOT TRACKER] - ID:%d, %s = %llu\n",
+		BOOTSTAGE_ID_KERNEL_START, __func__, boot_time_now());
+#endif
 	/* Static keys and static calls are needed by LSMs */
 	jump_label_init();
 	static_call_init();
@@ -1503,6 +1512,10 @@ static int __ref kernel_init(void *unused)
 
 	do_sysctl_args();
 
+#ifdef CONFIG_BOOT_TIME_TRACKER
+	pr_info("[BOOT TRACKER] - ID:%d, %s = %llu\n",
+		BOOTSTAGE_ID_KERNEL_END, __func__, boot_time_now());
+#endif
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
 		if (!ret)
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 7c6a52f7836c..aadfd66d5d69 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -221,4 +221,14 @@ config POSIX_AUX_CLOCKS
 	  and other clock domains, which are not correlated to the TAI/NTP
 	  notion of time.
 
+config BOOT_TIME_TRACKER
+	bool "boot time tracking support"
+	help
+	  Prints boot timestamps at the beginning of the kernel and when the
+	  first user-space process is launched. This helps measure basic
+	  boot latency for embedded and multi-core systems.
+
+	  The messages appear using printk and can be parsed by boot
+	  instrumentation tools or console logs.
+
 endmenu
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index e6e9b85d4db5..f7c115a385bb 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
 obj-$(CONFIG_TIME_NS)				+= namespace.o
 obj-$(CONFIG_TEST_CLOCKSOURCE_WATCHDOG)		+= clocksource-wdtest.o
 obj-$(CONFIG_TIME_KUNIT_TEST)			+= time_test.o
+obj-$(CONFIG_BOOT_TIME_TRACKER) 		+= boot_time_now.o
diff --git a/kernel/time/boot_time_now.c b/kernel/time/boot_time_now.c
new file mode 100644
index 000000000000..6dc12d454be0
--- /dev/null
+++ b/kernel/time/boot_time_now.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: LGPL-2.0
+
+#include <linux/boot_time_now.h>
+#include <asm/boot_time_primitives.h>
+
+u64 boot_time_now(void)
+{
+	return arch_boot_counter_now();
+}
+EXPORT_SYMBOL_GPL(boot_time_now);
+
+MODULE_DESCRIPTION("boot time tracker");
+MODULE_LICENSE("GPL");
-- 
2.50.1


