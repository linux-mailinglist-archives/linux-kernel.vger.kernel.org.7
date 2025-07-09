Return-Path: <linux-kernel+bounces-724451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A798AFF306
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2693B6EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC224466F;
	Wed,  9 Jul 2025 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8tZ1Utj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+lRpMq9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BD24167D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093052; cv=none; b=MLPAHpc9t4Qc6SzNZwPglh9I/A0K+nlmMJDLv7jDf7hNnhWZ4peDrypmWnVamR1a/BeZ0fEfmHXvQSYZLPt+xG9BbccMUlJrCQWdg0OEk9ETwLAgrPM0WqgVOT2z5yDPNeT6Z4l2yU6TXahKZvZIPZSlOUbXbsongbPrVTncits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093052; c=relaxed/simple;
	bh=g+JKZAg/TiCH95nnSuM7T6vJeQVg+SeGa1eL3msI0Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hinyeAo18I5IXGurfaoSnquSUjs17YBZvyk2OA0ce9GHlpOcso5CmAaXiVTgd4zxVVHpr/wXGXvG+Q63ORjoAIqwOEitIYbP18VnlKCALskShjzSIGp3rlu3v3h4khanvfRMNHXBvcToViiMfDHsoVIv8QvGdJ/78eVT7BehLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8tZ1Utj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+lRpMq9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752093046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCZbBJqJSjCot6gOqD2i4qsn8fO/mwHQL/oAFr+hIVY=;
	b=t8tZ1Utjq8wC9+04MsUf9UYdF2uSN9CqhNTCncmhR7hswAp2OeMR3wsJr6p8I6RGxH5EIB
	c7aDRNCxbQVkrWWQPUdJIqXVa9ap28pGxGdB9w8tEK4LJksh9du/TDeFcgjM39F98sThEK
	Arjau/qA+yBMBGXzWgBkjVX9WD2DR80uFp9onSxNgVeBs0chICPH8Liso9aFpo7rUh5DE1
	5Ef1WJi4duzZprQzysVkpREPzLGMjeWGf1tsC3YbHhZt6+gc0Ws1oxnQ71LU7nIJEmMcTA
	UEBksKheulEgkYEw42mXe2xKIWcYvKItejni0pG3B8LsiOWlz+jICx+zu1oVCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752093046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCZbBJqJSjCot6gOqD2i4qsn8fO/mwHQL/oAFr+hIVY=;
	b=y+lRpMq9wq6vAYCqDqmL42VBTYVd/pUU+uWa0GJcapmtI28wakcVkKOxK8K28uh8arXoL7
	DIbqDVZZUcSOQeCw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 3/6] x86: Reorder headers alphabetically
Date: Wed,  9 Jul 2025 22:30:29 +0200
Message-ID: <20250709203033.90125-4-darwi@linutronix.de>
In-Reply-To: <20250709203033.90125-1-darwi@linutronix.de>
References: <20250709170454.74854-1-darwi@linutronix.de>
 <20250709203033.90125-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple x86 source files use the cpuid_*() macros, but implicitly
include the main CPUID API header through <asm/processor.h> instead.

Sort their include lines so that <asm/cpuid/api.h> can be explicitly
included next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/boot/startup/sme.c           |  8 ++--
 arch/x86/coco/tdx/tdx.c               |  5 ++-
 arch/x86/events/amd/uncore.c          | 14 +++---
 arch/x86/events/zhaoxin/core.c        | 11 +++--
 arch/x86/kernel/cpu/amd.c             | 25 +++++------
 arch/x86/kernel/cpu/mce/core.c        | 62 +++++++++++++--------------
 arch/x86/kernel/cpu/microcode/core.c  | 22 +++++-----
 arch/x86/kernel/cpu/microcode/intel.c | 11 ++---
 arch/x86/kernel/cpu/mshyperv.c        | 28 ++++++------
 arch/x86/kernel/cpu/resctrl/core.c    |  5 ++-
 arch/x86/kernel/cpu/scattered.c       |  2 +-
 arch/x86/kernel/cpu/topology_common.c |  2 +-
 arch/x86/kernel/paravirt.c            | 28 ++++++------
 13 files changed, 114 insertions(+), 109 deletions(-)

diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 70ea1748c0a7..922b236be02f 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -34,15 +34,15 @@
  */
 #define USE_EARLY_PGTABLE_L5
 
+#include <linux/cc_platform.h>
 #include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/mem_encrypt.h>
-#include <linux/cc_platform.h>
+#include <linux/mm.h>
 
+#include <asm/coco.h>
 #include <asm/init.h>
-#include <asm/setup.h>
 #include <asm/sections.h>
-#include <asm/coco.h>
+#include <asm/setup.h>
 #include <asm/sev.h>
 
 #define PGD_FLAGS		_KERNPG_TABLE_NOENC
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7b2833705d47..7bc11836c46a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,16 +8,17 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+
 #include <asm/coco.h>
-#include <asm/tdx.h>
-#include <asm/vmx.h>
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
+#include <asm/tdx.h>
 #include <asm/traps.h>
+#include <asm/vmx.h>
 
 /* MMIO direction */
 #define EPT_READ	0
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e8b6af199c73..c1483ef16c0b 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -5,18 +5,18 @@
  * Author: Jacob Shin <jacob.shin@amd.com>
  */
 
-#include <linux/perf_event.h>
-#include <linux/percpu.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/init.h>
 #include <linux/cpu.h>
-#include <linux/cpumask.h>
 #include <linux/cpufeature.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 
-#include <asm/perf_event.h>
 #include <asm/msr.h>
+#include <asm/perf_event.h>
 
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 4bdfcf091200..d59992364880 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -5,16 +5,16 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/stddef.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/init.h>
 #include <linux/nmi.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
+#include <asm/apic.h>
 #include <asm/cpufeature.h>
 #include <asm/hardirq.h>
-#include <asm/apic.h>
 #include <asm/msr.h>
 
 #include "../perf_event.h"
@@ -616,4 +616,3 @@ __init int zhaoxin_pmu_init(void)
 
 	return 0;
 }
-
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 655f44f89ded..6e2ee9ed76d2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1,32 +1,33 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/export.h>
+
 #include <linux/bitops.h>
 #include <linux/elf.h>
-#include <linux/mm.h>
-
+#include <linux/export.h>
 #include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/platform_data/x86/amd-fch.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
-#include <linux/random.h>
 #include <linux/topology.h>
-#include <linux/platform_data/x86/amd-fch.h>
-#include <asm/processor.h>
+
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpu.h>
 #include <asm/cpu_device_id.h>
-#include <asm/spec-ctrl.h>
-#include <asm/smp.h>
+#include <asm/debugreg.h>
+#include <asm/delay.h>
+#include <asm/msr.h>
 #include <asm/numa.h>
 #include <asm/pci-direct.h>
-#include <asm/delay.h>
-#include <asm/debugreg.h>
+#include <asm/processor.h>
 #include <asm/resctrl.h>
-#include <asm/msr.h>
 #include <asm/sev.h>
+#include <asm/smp.h>
+#include <asm/spec-ctrl.h>
 
 #ifdef CONFIG_X86_64
-# include <asm/mmconfig.h>
+#include <asm/mmconfig.h>
 #endif
 
 #include "cpu.h"
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81..5a11c522ea97 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -9,52 +9,52 @@
  * Author: Andi Kleen
  */
 
-#include <linux/thread_info.h>
 #include <linux/capability.h>
-#include <linux/miscdevice.h>
-#include <linux/ratelimit.h>
-#include <linux/rcupdate.h>
-#include <linux/kobject.h>
-#include <linux/uaccess.h>
-#include <linux/kdebug.h>
-#include <linux/kernel.h>
-#include <linux/percpu.h>
-#include <linux/string.h>
-#include <linux/device.h>
-#include <linux/syscore_ops.h>
-#include <linux/delay.h>
+#include <linux/cpu.h>
 #include <linux/ctype.h>
-#include <linux/sched.h>
-#include <linux/sysfs.h>
-#include <linux/types.h>
-#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/irq_work.h>
+#include <linux/kdebug.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/kmod.h>
-#include <linux/poll.h>
+#include <linux/kobject.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
 #include <linux/nmi.h>
-#include <linux/cpu.h>
+#include <linux/percpu.h>
+#include <linux/poll.h>
 #include <linux/ras.h>
-#include <linux/smp.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/debugfs.h>
-#include <linux/irq_work.h>
-#include <linux/export.h>
+#include <linux/ratelimit.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
 #include <linux/set_memory.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/string.h>
 #include <linux/sync_core.h>
+#include <linux/syscore_ops.h>
+#include <linux/sysfs.h>
 #include <linux/task_work.h>
-#include <linux/hardirq.h>
-#include <linux/kexec.h>
+#include <linux/thread_info.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 
-#include <asm/fred.h>
 #include <asm/cpu_device_id.h>
-#include <asm/processor.h>
-#include <asm/traps.h>
-#include <asm/tlbflush.h>
+#include <asm/fred.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/tdx.h>
+#include <asm/tlbflush.h>
+#include <asm/traps.h>
 
 #include "internal.h"
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index fe50eb5b7c4a..9243ed3ded85 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -17,27 +17,27 @@
 
 #define pr_fmt(fmt) "microcode: " fmt
 
-#include <linux/platform_device.h>
-#include <linux/stop_machine.h>
-#include <linux/syscore_ops.h>
-#include <linux/miscdevice.h>
 #include <linux/capability.h>
-#include <linux/firmware.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
-#include <linux/kernel.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
-#include <linux/cpu.h>
-#include <linux/nmi.h>
+#include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/nmi.h>
+#include <linux/platform_device.h>
+#include <linux/stop_machine.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/apic.h>
+#include <asm/cmdline.h>
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include <asm/perf_event.h>
 #include <asm/processor.h>
-#include <asm/cmdline.h>
-#include <asm/msr.h>
 #include <asm/setup.h>
 
 #include "internal.h"
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 371ca6eac00e..99fda8f7dba7 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -11,21 +11,22 @@
  *		      H Peter Anvin" <hpa@zytor.com>
  */
 #define pr_fmt(fmt) "microcode: " fmt
+
+#include <linux/cpu.h>
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
-#include <linux/uaccess.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/cpu.h>
+#include <linux/uaccess.h>
 #include <linux/uio.h>
-#include <linux/mm.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include <asm/processor.h>
-#include <asm/tlbflush.h>
 #include <asm/setup.h>
-#include <asm/msr.h>
+#include <asm/tlbflush.h>
 
 #include "internal.h"
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..d0491bba9e30 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -6,33 +6,35 @@
  * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
  */
 
-#include <linux/types.h>
-#include <linux/time.h>
 #include <linux/clocksource.h>
-#include <linux/init.h>
+#include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/hardirq.h>
-#include <linux/efi.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/random.h>
-#include <asm/processor.h>
-#include <asm/hypervisor.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <clocksource/hyperv_timer.h>
 #include <hyperv/hvhdk.h>
-#include <asm/mshyperv.h>
+
+#include <asm/apic.h>
 #include <asm/desc.h>
+#include <asm/hypervisor.h>
+#include <asm/i8259.h>
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
-#include <asm/i8259.h>
-#include <asm/apic.h>
-#include <asm/timer.h>
-#include <asm/reboot.h>
-#include <asm/nmi.h>
-#include <clocksource/hyperv_timer.h>
+#include <asm/mshyperv.h>
 #include <asm/msr.h>
+#include <asm/nmi.h>
 #include <asm/numa.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
 #include <asm/svm.h>
+#include <asm/timer.h>
 
 /* Is Linux running on nested Microsoft Hypervisor */
 bool hv_nested;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 187d527ef73b..35285567beec 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -17,13 +17,14 @@
 #define pr_fmt(fmt)	"resctrl: " fmt
 
 #include <linux/cpu.h>
-#include <linux/slab.h>
-#include <linux/err.h>
 #include <linux/cpuhotplug.h>
+#include <linux/err.h>
+#include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 #include <asm/resctrl.h>
+
 #include "internal.h"
 
 /*
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index dbf6d71bdf18..3d23b943f596 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -4,8 +4,8 @@
  */
 #include <linux/cpu.h>
 
-#include <asm/memtype.h>
 #include <asm/apic.h>
+#include <asm/memtype.h>
 #include <asm/processor.h>
 
 #include "cpu.h"
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index b5a5e1411469..48c47d02d8a9 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -3,8 +3,8 @@
 
 #include <xen/xen.h>
 
-#include <asm/intel-family.h>
 #include <asm/apic.h>
+#include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/smp.h>
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ab3e172dcc69..3d745cd25a43 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -6,34 +6,34 @@
     2007 - x86_64 support added by Glauber de Oliveira Costa, Red Hat Inc
 */
 
+#include <linux/bcd.h>
+#include <linux/efi.h>
 #include <linux/errno.h>
-#include <linux/init.h>
 #include <linux/export.h>
-#include <linux/efi.h>
-#include <linux/bcd.h>
 #include <linux/highmem.h>
+#include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/pgtable.h>
 #include <linux/static_call.h>
 
+#include <asm/apic.h>
 #include <asm/bug.h>
-#include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/delay.h>
 #include <asm/desc.h>
+#include <asm/fixmap.h>
+#include <asm/gsseg.h>
+#include <asm/io_bitmap.h>
+#include <asm/irq.h>
+#include <asm/msr.h>
+#include <asm/paravirt.h>
+#include <asm/pgalloc.h>
 #include <asm/setup.h>
+#include <asm/special_insns.h>
 #include <asm/time.h>
-#include <asm/pgalloc.h>
-#include <asm/irq.h>
-#include <asm/delay.h>
-#include <asm/fixmap.h>
-#include <asm/apic.h>
-#include <asm/tlbflush.h>
 #include <asm/timer.h>
-#include <asm/special_insns.h>
 #include <asm/tlb.h>
-#include <asm/io_bitmap.h>
-#include <asm/gsseg.h>
-#include <asm/msr.h>
+#include <asm/tlbflush.h>
 
 /* stub always returning 0. */
 DEFINE_ASM_FUNC(paravirt_ret0, "xor %eax,%eax", .entry.text);
-- 
2.49.0


