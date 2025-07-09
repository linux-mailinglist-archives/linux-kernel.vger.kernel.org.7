Return-Path: <linux-kernel+bounces-724445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A6BAFF2F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1291C8604D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D6242D94;
	Wed,  9 Jul 2025 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tl4HY3yM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2sxymW0F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A15248F57
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092859; cv=none; b=YJq1wNYAUWJi3+SiuMXdRZRgnu5V4aBxmaGlnbTTMKJ9Rl1HstJVDbNVDzO4tHn0r/NzDCWERxiId4by3IAj9BeKhOEI/d2J9imxf6N9crbHwPn+fU3sgm3gEZpROVhIZ8i9ofaehJpNrtUsRFliTO+3nn657j6AiZ7u7RXXkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092859; c=relaxed/simple;
	bh=ff1tIAse2S7/NtwZVWkfHmsKQJ09vpxH4D2bn4QIcfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6sGjjEOfDIVvHj5VUe6PyWbL79jVNJMN2BC66hQUJ1O3J+6iErpYGRkZg+lbBqPt8rm3DxVmmqutm9Dbnnd23DGj4+8dXIWj+xk9GgvgSSVjC6dveaC1edTCf+jvCexmqaoBcEwxRyW5Z0xk10mAiYS/saDLmlVpjasI1OwCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tl4HY3yM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2sxymW0F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752092855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrH0b3ftJBn3lwAscJtounFGQKd8qvXnYhPIxpCwgwE=;
	b=tl4HY3yM2+PzUzJRurDIuRvSTWJsKB6kiSyw/JimG53BukRMXIuMRiqWvSkMj0qIvR5iki
	SmRfDRS8tdmbSjtelcjkc00B1uunChQhQLYqOlxQOw0u13LVXkfmyfX7PJ1JpbsNXZMWe1
	nsWSpEBZKHrRQQgN1jlffGLGGynHIHyDsnj1RUmEvrwoJoOCa8P82gPT6J+K58wLFlRmsd
	3fr1OjiphNEwc0dvrgTQN4dtvI6+oPK/sE/JwFgw10F/sYElmhZZ9tGOgs7qsUzuxBbZAm
	/MembwztF3S1kVLAMFnMc7G/fISfrJf2nekF9a04rRN5Pi4xADkXmsFbN7LWTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752092855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrH0b3ftJBn3lwAscJtounFGQKd8qvXnYhPIxpCwgwE=;
	b=2sxymW0FHNA2ivq6baEq7KNn7mS4BpCQwGgg6rEq47zyZhY3Z4pRPlBiM4CD9a01N4yQad
	HfW/5WdgJZbGe0BA==
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
Subject: [PATCH v2 5/6] treewide: Explicitly include CPUID headers
Date: Wed,  9 Jul 2025 22:26:32 +0200
Message-ID: <20250709202635.89791-6-darwi@linutronix.de>
In-Reply-To: <20250709202635.89791-1-darwi@linutronix.de>
References: <20250612234010.572636-1-darwi@linutronix.de>
 <20250709202635.89791-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify all CPUID call sites which implicitly include any of the CPUID
headers through <asm/processor.h> to explicitly include the CPUID headers
instead.

This allows disentangling <asm/cpuid/api.h> and <asm/cpuid/types.h> from
<asm/processor.h> at a later step.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/boot/compressed/pgtable_64.c        | 1 +
 arch/x86/boot/startup/sme.c                  | 1 +
 arch/x86/coco/tdx/tdx.c                      | 1 +
 arch/x86/events/amd/core.c                   | 2 ++
 arch/x86/events/amd/ibs.c                    | 1 +
 arch/x86/events/amd/lbr.c                    | 2 ++
 arch/x86/events/amd/power.c                  | 3 +++
 arch/x86/events/amd/uncore.c                 | 1 +
 arch/x86/events/intel/core.c                 | 1 +
 arch/x86/events/intel/lbr.c                  | 1 +
 arch/x86/events/zhaoxin/core.c               | 1 +
 arch/x86/include/asm/acrn.h                  | 2 ++
 arch/x86/include/asm/microcode.h             | 1 +
 arch/x86/include/asm/xen/hypervisor.h        | 1 +
 arch/x86/kernel/cpu/amd.c                    | 1 +
 arch/x86/kernel/cpu/centaur.c                | 1 +
 arch/x86/kernel/cpu/hygon.c                  | 1 +
 arch/x86/kernel/cpu/mce/core.c               | 1 +
 arch/x86/kernel/cpu/mce/inject.c             | 1 +
 arch/x86/kernel/cpu/microcode/core.c         | 1 +
 arch/x86/kernel/cpu/microcode/intel.c        | 1 +
 arch/x86/kernel/cpu/mshyperv.c               | 1 +
 arch/x86/kernel/cpu/resctrl/core.c           | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c        | 1 +
 arch/x86/kernel/cpu/scattered.c              | 1 +
 arch/x86/kernel/cpu/sgx/main.c               | 3 +++
 arch/x86/kernel/cpu/topology_amd.c           | 1 +
 arch/x86/kernel/cpu/topology_common.c        | 1 +
 arch/x86/kernel/cpu/topology_ext.c           | 1 +
 arch/x86/kernel/cpu/transmeta.c              | 3 +++
 arch/x86/kernel/cpu/zhaoxin.c                | 1 +
 arch/x86/kernel/cpuid.c                      | 1 +
 arch/x86/kernel/paravirt.c                   | 1 +
 arch/x86/kvm/cpuid.h                         | 3 +++
 arch/x86/kvm/mmu/spte.c                      | 1 +
 arch/x86/kvm/reverse_cpuid.h                 | 2 ++
 drivers/cpufreq/longrun.c                    | 1 +
 drivers/cpufreq/powernow-k7.c                | 1 +
 drivers/cpufreq/powernow-k8.c                | 1 +
 drivers/cpufreq/speedstep-lib.c              | 1 +
 drivers/firmware/efi/libstub/x86-5lvl.c      | 1 +
 drivers/hwmon/fam15h_power.c                 | 1 +
 drivers/hwmon/k10temp.c                      | 2 ++
 drivers/hwmon/k8temp.c                       | 1 +
 drivers/thermal/intel/intel_hfi.c            | 1 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 1 +
 46 files changed, 59 insertions(+)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff7..d94d98595780 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -2,6 +2,7 @@
 #include "misc.h"
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
+#include <asm/cpuid/api.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "../string.h"
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 922b236be02f..6a58ab568390 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -40,6 +40,7 @@
 #include <linux/mm.h>
 
 #include <asm/coco.h>
+#include <asm/cpuid/api.h>
 #include <asm/init.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7bc11836c46a..4ed8ec642646 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -10,6 +10,7 @@
 #include <linux/kexec.h>
 
 #include <asm/coco.h>
+#include <asm/cpuid/api.h>
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b20661b8621d..d28d45ceb707 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -7,8 +7,10 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+
 #include <asm/apicdef.h>
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/nmi.h>
 
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 112f43b23ebf..0c7848e6149e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -15,6 +15,7 @@
 #include <linux/sched/clock.h>
 
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 
 #include "../perf_event.h"
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index d24da377df77..5b437dc8e4ce 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
+
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/perf_event.h>
 
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index dad42790cf7d..744dffa42dee 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -10,8 +10,11 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
+
 #include "../perf_event.h"
 
 /* Event code: LSB 8 bits, passed in attr->config any other bit is reserved. */
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index c1483ef16c0b..5261f12007df 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -15,6 +15,7 @@
 #include <linux/smp.h>
 #include <linux/types.h>
 
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/perf_event.h>
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c2fb729c270e..ebbcdf82b494 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -17,6 +17,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 #include <asm/debugreg.h>
 #include <asm/hardirq.h>
 #include <asm/intel-family.h>
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7aa59966e7c3..0d1ec3651735 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
 
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index d59992364880..15bb9c9c9358 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -14,6 +14,7 @@
 
 #include <asm/apic.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 #include <asm/hardirq.h>
 #include <asm/msr.h>
 
diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index fab11192c60a..db42b477c41d 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_ACRN_H
 #define _ASM_X86_ACRN_H
 
+#include <asm/cpuid/api.h>
+
 /*
  * This CPUID returns feature bitmaps in EAX.
  * Guest VM uses this to detect the appropriate feature bit.
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 8b41f26f003b..645e65ac1586 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_MICROCODE_H
 
 #include <asm/msr.h>
+#include <asm/cpuid/api.h>
 
 struct cpu_signature {
 	unsigned int sig;
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index c2fc7869b996..7c596cebfb78 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -37,6 +37,7 @@ extern struct shared_info *HYPERVISOR_shared_info;
 extern struct start_info *xen_start_info;
 
 #include <asm/bug.h>
+#include <asm/cpuid/api.h>
 #include <asm/processor.h>
 
 #define XEN_SIGNATURE "XenVMMXenVMM"
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6e2ee9ed76d2..6bfe714c75dd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -15,6 +15,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/cpu.h>
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/debugreg.h>
 #include <asm/delay.h>
 #include <asm/msr.h>
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index a3b55db35c96..cc5a390dcd07 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -5,6 +5,7 @@
 
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 #include <asm/e820/api.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 2154f12766fb..75ad7eb1301a 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -10,6 +10,7 @@
 
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/cpuid/api.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
 #include <asm/cacheinfo.h>
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5a11c522ea97..31ff1c578b40 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -47,6 +47,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/fred.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index d02c4f556cd0..42c82c14c48a 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -26,6 +26,7 @@
 
 #include <asm/amd/nb.h>
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/irq_vectors.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 9243ed3ded85..eae9eaa455ba 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -35,6 +35,7 @@
 #include <asm/apic.h>
 #include <asm/cmdline.h>
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/perf_event.h>
 #include <asm/processor.h>
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 99fda8f7dba7..30d20f78f07d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -23,6 +23,7 @@
 #include <linux/uio.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d0491bba9e30..771a65e6fefb 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -22,6 +22,7 @@
 #include <hyperv/hvhdk.h>
 
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
 #include <asm/i8259.h>
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 35285567beec..52d3753ab020 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/resctrl.h>
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c261558276cd..5dffb9453d77 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -21,6 +21,7 @@
 #include <linux/resctrl.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 
 #include "internal.h"
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 3d23b943f596..15f8752d4132 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -5,6 +5,7 @@
 #include <linux/cpu.h>
 
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/memtype.h>
 #include <asm/processor.h>
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2de01b379aa3..00bf42f4c536 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -14,8 +14,11 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/vmalloc.h>
+
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/sgx.h>
+
 #include "driver.h"
 #include "encl.h"
 #include "encls.h"
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 843b1655ab45..abc6f5a7a486 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -2,6 +2,7 @@
 #include <linux/cpu.h>
 
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/memtype.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 48c47d02d8a9..38189e4fea0e 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -4,6 +4,7 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/smp.h>
diff --git a/arch/x86/kernel/cpu/topology_ext.c b/arch/x86/kernel/cpu/topology_ext.c
index 467b0326bf1a..eb915c73895f 100644
--- a/arch/x86/kernel/cpu/topology_ext.c
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -2,6 +2,7 @@
 #include <linux/cpu.h>
 
 #include <asm/apic.h>
+#include <asm/cpuid/api.h>
 #include <asm/memtype.h>
 #include <asm/processor.h>
 
diff --git a/arch/x86/kernel/cpu/transmeta.c b/arch/x86/kernel/cpu/transmeta.c
index 42c939827621..1fdcd69c625c 100644
--- a/arch/x86/kernel/cpu/transmeta.c
+++ b/arch/x86/kernel/cpu/transmeta.c
@@ -3,8 +3,11 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
+
 #include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
+
 #include "cpu.h"
 
 static void early_init_transmeta(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 89b1c8a70fe8..cfcfb6221e3f 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -4,6 +4,7 @@
 
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 
 #include "cpu.h"
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index dae436253de4..cbd04b677fd1 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -37,6 +37,7 @@
 #include <linux/gfp.h>
 #include <linux/completion.h>
 
+#include <asm/cpuid/api.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 3d745cd25a43..b7fc3b78086c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -18,6 +18,7 @@
 
 #include <asm/apic.h>
 #include <asm/bug.h>
+#include <asm/cpuid/api.h>
 #include <asm/debugreg.h>
 #include <asm/delay.h>
 #include <asm/desc.h>
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index d3f5ae15a7ca..89f8ed3fb37a 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -3,8 +3,11 @@
 #define ARCH_X86_KVM_CPUID_H
 
 #include "reverse_cpuid.h"
+
 #include <asm/cpu.h>
+#include <asm/cpuid/api.h>
 #include <asm/processor.h>
+
 #include <uapi/asm/kvm_para.h>
 
 extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index cfce03d8f123..e7b69275ae50 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -15,6 +15,7 @@
 #include "x86.h"
 #include "spte.h"
 
+#include <asm/cpuid/api.h>
 #include <asm/e820/api.h>
 #include <asm/memtype.h>
 #include <asm/vmx.h>
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index fde0ae986003..be774dcf5e97 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -3,8 +3,10 @@
 #define ARCH_X86_KVM_REVERSE_CPUID_H
 
 #include <uapi/asm/kvm.h>
+
 #include <asm/cpufeature.h>
 #include <asm/cpufeatures.h>
+#include <asm/cpuid/types.h>
 
 /*
  * Define a KVM-only feature flag.
diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 263c48b8f628..3429857feb96 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -12,6 +12,7 @@
 #include <linux/timex.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
 
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 0608040fcd1e..7a324a829a43 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -27,6 +27,7 @@
 #include <linux/timex.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/timer.h>		/* Needed for recalibrate_cpu_khz() */
 
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 2b5cdd8f1c0a..e909eee30edd 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -41,6 +41,7 @@
 
 #include <asm/msr.h>
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 
 #include <acpi/processor.h>
 
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index f08817331aec..3c323cd8eede 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/tsc.h>
 
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index f1c5fb45d5f7..029ad80cf0b4 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -2,6 +2,7 @@
 #include <linux/efi.h>
 
 #include <asm/boot.h>
+#include <asm/cpuid/api.h>
 #include <asm/desc.h>
 #include <asm/efi.h>
 
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 5a5674e85f63..1ecaef25f04e 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -19,6 +19,7 @@
 #include <linux/time.h>
 #include <linux/topology.h>
 
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index babf2413d666..12115654689a 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -20,7 +20,9 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
+
 #include <asm/amd/node.h>
+#include <asm/cpuid/api.h>
 #include <asm/processor.h>
 
 MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 8c1efce9a04b..eb167be245b9 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#include <asm/cpuid/api.h>
 #include <asm/processor.h>
 
 #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index bd2fca7dc017..c910cc563d9d 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -41,6 +41,7 @@
 #include <linux/topology.h>
 #include <linux/workqueue.h>
 
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 
 #include "intel_hfi.h"
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index c843cb5fc5c3..1b9e0b49856c 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -20,6 +20,7 @@
 #include <linux/thermal.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/cpuid/api.h>
 #include <asm/msr.h>
 
 #include "thermal_interrupt.h"
-- 
2.49.0


