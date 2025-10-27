Return-Path: <linux-kernel+bounces-871696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 189E7C0E131
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53EDF34DF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2222737E0;
	Mon, 27 Oct 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PsaJ3oVH"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1726CE36
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572101; cv=none; b=bGRhMRaqr7U5Th7W1FqPYhwAkDLoQa26IvWTSTdMds4NFvanYhJyEfC8n+CF5QwfeOBBXD/zqyBmr5epByOnGTi5OlPXH0kDeefklNsSojq0hpG+ho04RIYIt8+HB9WhLVcUqLi0jES+ssH8ZIHeGeCnQT/Akbnusu2pHgZCEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572101; c=relaxed/simple;
	bh=nV7cfjEuKKEn0SJw4MRgqKJDE8ryiX5AlaH03wsfYhs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aszV1HrBsVr8pHE0uaBd8PPGAzI/FCSmKSck9u85YcPOfS9UAxHscS7zAB0PssfCB66jG6yIbrw0m6M5l+g3UroMcpcgiC6qubTMRzmoKvs5htdAzjFfu+GnsNjvWnUdlrh0fHObqVGQxPElUc5jopm4aZjwMluViUf3DSaAKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PsaJ3oVH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so4686142a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761572099; x=1762176899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2tpoOA+Gs0GcQeB3g/zAgXC64WCGfPZHVizPT/nBl4=;
        b=PsaJ3oVHM8ojoW2hJFHDouLA0EX3klvofUmxCrxA71KmAXPPwl5+Dc9BkGjR6FwJfA
         wh1hGgW1DAjkd+hiscFTdHE8YHc6is7wUpk14gXtVqe98iJnTnMfktBryDp1toREzm39
         3e9B29pwle0UbbGhroCLBPDbtuV4TDBzZhrTyLDxpzzrNVgFRaM4lCQ5sZ30S5oH5iuN
         FpHlT/kQLQTssyL9SvV1l7mdkTJX0toH5XgmbXA/q/gz8ddHey9JmKr6a1WbnIyx4OEI
         9gxzCJt5FHoACUg4xUm436+affhY60PG5MqnSZcx2KiWe4kI7Wit27Egf5bgTK5+5IIG
         0Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572099; x=1762176899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2tpoOA+Gs0GcQeB3g/zAgXC64WCGfPZHVizPT/nBl4=;
        b=dz7AKmrRE69ePS7VFuujOewR+ACEoqsh5ZeJFTp0KDuEqLtjyR8PPt+hJxVmzmgMbA
         h/N5sqpw4F7jFAt8ATJ1tw6mVwGMbRb+fwuZaQqPEr+HUkwYsci20vIPOA3VK3m08J+E
         RkS64ZiXtQbIphJZjXC+fUnybrhrP57MblbliNqgJAqn0FAmPFTbphIKn3BotbIzr8O9
         wEugcWIakdjB3w/0t2GXcqnkmWdPD2X5eYX5st1PMtfiXtpCDh9VU9cF3sXbbRRFLmJ/
         2xCan5TvQVbfNIvRjsResW+LVP4TJKeUgAtuiWiQpSLBCiqkTqcnNHVTZO1+XhhPoa5L
         1pEw==
X-Forwarded-Encrypted: i=1; AJvYcCXniMpMG2R/k1EOSrtQGOIdsy7aMTvz945UTD5YWBI3y7IHXhJK/q7PLyCBHTjpHXhZGq9xFjrc7ooFso8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiNa7SK/hGQORxAm0JvgPJA3nAZIGCqPtGUmyWflbYaFOQLZl
	BgY3vEiPjnng2pmlhsdpt2Y7+g1JQdx8eCvyzQQ9d8Oyu7ZWyMpstNf7jeZZ9xunp0cZOVPDMo0
	pSlGA+aA=
X-Gm-Gg: ASbGnctV/DiUuxEX9RYUdFy7fc+PbA5ioethIfTiuBtSbY1CfWgYk6+WYDTuc2wweL1
	ZlAk/vRcJHE4mykNCwh1jJbPlEt9OtoLDUb4VFQMkyTNq4Gblz28a+gG8kTrbe7Fw36tIMbdAin
	MYe/96ib/AGckVY8Ygtc2JRkm1cD/HtW7SyLb2SMdytjybyAHNYZaj2TScO9Ta22yL0PRbz1PRR
	7EdNl/vZNmoZ6zL03WHEkryGtGmIMOnd6lvPRsIgMZRdDUa4YuueqiYGT+PDV5arLjvFS8VgEEA
	G721Gm3ucgRdySO+3OWEmhe/QonMKEwSX5DczH+M8sILChMc6TEKJylUU7aWeMunszz93GiFz15
	SAJk2fpv+hvWGsCXNUn2O6ad/hNQ7OvcZ3L4PI03byAP0fJZWK4FnbX/TOZ3mYmB1G93zO8mVC7
	5JCgSkfXIHoNn6nyVIgnDoQ4XYhu9DGw2rq1ptbe4gg+NEHhORHxbai9c=
X-Google-Smtp-Source: AGHT+IGyC7d4gEQa/irJWDsd6pG/6nY8eBmVQxw1YuZC3U55Ay9+08PmeEB9dusslzwWoy4UiH9GOA==
X-Received: by 2002:a17:903:4b04:b0:271:9b0e:54ca with SMTP id d9443c01a7336-29489db2210mr142833545ad.13.1761572098543;
        Mon, 27 Oct 2025 06:34:58 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42558sm82144935ad.69.2025.10.27.06.34.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 06:34:58 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor@kernel.org,
	cuiyunhui@bytedance.com,
	luxu.kernel@bytedance.com,
	atishp@rivosinc.com,
	cleger@rivosinc.com,
	ajones@ventanamicro.com,
	apatel@ventanamicro.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	songshuaishuai@tinylab.org,
	bjorn@rivosinc.com,
	charlie@rivosinc.com,
	masahiroy@kernel.org,
	valentina.fernandezalanis@microchip.com,
	jassisinghbrar@gmail.com,
	conor.dooley@microchip.com
Subject: [PATCH 2/3] riscv: crash: move IPI crash handling logic to crash.c
Date: Mon, 27 Oct 2025 21:34:30 +0800
Message-Id: <20251027133431.15321-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251027133431.15321-1-cuiyunhui@bytedance.com>
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move IPI crash handling code from smp.c to a new crash.c to
separate concerns and improve code organization, no functional change.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/crash.h | 16 ++++++
 arch/riscv/include/asm/smp.h   | 14 +++++
 arch/riscv/kernel/Makefile     |  2 +-
 arch/riscv/kernel/crash.c      | 84 +++++++++++++++++++++++++++++
 arch/riscv/kernel/smp.c        | 99 +---------------------------------
 5 files changed, 117 insertions(+), 98 deletions(-)
 create mode 100644 arch/riscv/include/asm/crash.h
 create mode 100644 arch/riscv/kernel/crash.c

diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/crash.h
new file mode 100644
index 0000000000000..b64df919277d4
--- /dev/null
+++ b/arch/riscv/include/asm/crash.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_RISC_V_CRASH_H
+#define _ASM_RISC_V_CRASH_H
+
+#ifdef CONFIG_KEXEC_CORE
+void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs);
+#else
+static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	unreachable();
+}
+#endif
+
+#endif
+
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 7ac80e9f22889..ffd7f6f8d25aa 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -12,6 +12,18 @@
 
 #define INVALID_HARTID ULONG_MAX
 
+enum ipi_message_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
+	IPI_IRQ_WORK,
+	IPI_TIMER,
+	IPI_CPU_BACKTRACE,
+	IPI_KGDB_ROUNDUP,
+	IPI_MAX
+};
+
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
@@ -51,6 +63,8 @@ bool riscv_ipi_have_virq_range(void);
 /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
 void riscv_ipi_set_virq_range(int virq, int nr);
 
+void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op);
+
 /* Check other CPUs stop or not */
 bool smp_crash_stop_failed(void);
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 16637e01a6b34..f0fd655b113d3 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -107,7 +107,7 @@ endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
+obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o kexec_image.o machine_kexec_file.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
new file mode 100644
index 0000000000000..12598bbc2df04
--- /dev/null
+++ b/arch/riscv/kernel/crash.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/kexec.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+
+#include <asm/cpu_ops.h>
+
+static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
+
+inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	crash_save_cpu(regs, cpu);
+
+	atomic_dec(&waiting_for_crash_ipi);
+
+	local_irq_disable();
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_has_hotplug(cpu))
+		cpu_ops->cpu_stop();
+#endif
+
+	for (;;)
+		wait_for_interrupt();
+}
+
+/*
+ * The number of CPUs online, not counting this CPU (which may not be
+ * fully online and so not counted in num_online_cpus()).
+ */
+static inline unsigned int num_other_online_cpus(void)
+{
+	unsigned int this_cpu_online = cpu_online(smp_processor_id());
+
+	return num_online_cpus() - this_cpu_online;
+}
+
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+	cpumask_t mask;
+	unsigned long timeout;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	cpus_stopped = 1;
+
+	/*
+	 * If this cpu is the only one alive at this point in time, online or
+	 * not, there are no stop messages to be sent around, so just back out.
+	 */
+	if (num_other_online_cpus() == 0)
+		return;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &mask);
+
+	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
+
+	pr_crit("SMP: stopping secondary CPUs\n");
+	send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
+
+	/* Wait up to one second for other CPUs to stop */
+	timeout = USEC_PER_SEC;
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
+		udelay(1);
+
+	if (atomic_read(&waiting_for_crash_ipi) > 0)
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
+}
+
+bool smp_crash_stop_failed(void)
+{
+	return (atomic_read(&waiting_for_crash_ipi) > 0);
+}
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index e650dec448176..c4191b15b3547 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -24,22 +24,11 @@
 #include <linux/irq_work.h>
 #include <linux/nmi.h>
 
+#include <asm/crash.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
-enum ipi_message_type {
-	IPI_RESCHEDULE,
-	IPI_CALL_FUNC,
-	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
-	IPI_IRQ_WORK,
-	IPI_TIMER,
-	IPI_CPU_BACKTRACE,
-	IPI_KGDB_ROUNDUP,
-	IPI_MAX
-};
-
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -75,33 +64,7 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
-#ifdef CONFIG_KEXEC_CORE
-static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
-
-static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
-{
-	crash_save_cpu(regs, cpu);
-
-	atomic_dec(&waiting_for_crash_ipi);
-
-	local_irq_disable();
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (cpu_has_hotplug(cpu))
-		cpu_ops->cpu_stop();
-#endif
-
-	for(;;)
-		wait_for_interrupt();
-}
-#else
-static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
-{
-	unreachable();
-}
-#endif
-
-static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
 	__ipi_send_mask(ipi_desc[op], mask);
 }
@@ -276,64 +239,6 @@ void smp_send_stop(void)
 			   cpumask_pr_args(cpu_online_mask));
 }
 
-#ifdef CONFIG_KEXEC_CORE
-/*
- * The number of CPUs online, not counting this CPU (which may not be
- * fully online and so not counted in num_online_cpus()).
- */
-static inline unsigned int num_other_online_cpus(void)
-{
-	unsigned int this_cpu_online = cpu_online(smp_processor_id());
-
-	return num_online_cpus() - this_cpu_online;
-}
-
-void crash_smp_send_stop(void)
-{
-	static int cpus_stopped;
-	cpumask_t mask;
-	unsigned long timeout;
-
-	/*
-	 * This function can be called twice in panic path, but obviously
-	 * we execute this only once.
-	 */
-	if (cpus_stopped)
-		return;
-
-	cpus_stopped = 1;
-
-	/*
-	 * If this cpu is the only one alive at this point in time, online or
-	 * not, there are no stop messages to be sent around, so just back out.
-	 */
-	if (num_other_online_cpus() == 0)
-		return;
-
-	cpumask_copy(&mask, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), &mask);
-
-	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
-
-	pr_crit("SMP: stopping secondary CPUs\n");
-	send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
-
-	/* Wait up to one second for other CPUs to stop */
-	timeout = USEC_PER_SEC;
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
-		udelay(1);
-
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			cpumask_pr_args(&mask));
-}
-
-bool smp_crash_stop_failed(void)
-{
-	return (atomic_read(&waiting_for_crash_ipi) > 0);
-}
-#endif
-
 void arch_smp_send_reschedule(int cpu)
 {
 	send_ipi_single(cpu, IPI_RESCHEDULE);
-- 
2.39.5


