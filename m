Return-Path: <linux-kernel+bounces-593745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD49A7FD26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E25189C1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8807226AAB8;
	Tue,  8 Apr 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BibSWXta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABD268FEB;
	Tue,  8 Apr 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109511; cv=none; b=PgaPjBcWE5FN76TTiXDd2uQybCLQCivpeINmgrQlh2UVg+rl81VfQjkcHgYTzRWlelPIJq3SNQVUHqEz9d4FJfaT6hUbSDOmkLzMHBOjxpNUI0bNuWXoOTkZ6sxz2T58RpveAUemIMwqoyPHs01Cz3+rhbqjgGZH5BT3Su8FKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109511; c=relaxed/simple;
	bh=WxlJpUqowBsQvYZOUMs8IGUAxzbj1n5Ter/RIBHuc/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAoZTj9TSfWfQoRbcmPsgX3459R8HLcmn55aGtneJbGK2inRw1mYmOgnR8T5rQkvCyrlEtseQ2j32YyTvZ40wDYPpOKQPgeXJSzozuILE+Fi81OnWbaN1W6G/mGTdUp6fWGy36xG+WlZfZHZ9F6/gizl6UZ5VN8siRcYQVl5J9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BibSWXta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48794C4CEE5;
	Tue,  8 Apr 2025 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744109511;
	bh=WxlJpUqowBsQvYZOUMs8IGUAxzbj1n5Ter/RIBHuc/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BibSWXtaJKEo1CvnXPoF6Tkzjzru09cSXP70AY72DWEuPIN8CcynJBn68yzf7TqSA
	 kffXvLlNT771qRUeE/Ukegf45ppT5Iz65XwfRojT+ccXpmbyJ3NChDyXZsNWEFHBoF
	 fjIZ17ZhbjvoCmrJGQBlxXCpoXAWNhey8clL8/BWoDUX1I5dhyt60qLTwrzqFDIo5T
	 otbUOaw8J2INx4sqWPHsDViZOBpYSBrKDkDI6Jgr08yF/zzd6eoV3ocxjcb7IRPe2q
	 D6c8jHrVe4ypMZ48G1lyqeKCUuxE0bna3jBPvNS81FCtP4LFooCVu2dl+6So3DXZPs
	 1wD3Q7KiFm5eg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Tue, 08 Apr 2025 12:50:16 +0200
Subject: [PATCH 17/24] arm64: smp: Support non-SGIs for IPIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-gicv5-host-v1-17-1f26db465f8d@kernel.org>
References: <20250408-gicv5-host-v1-0-1f26db465f8d@kernel.org>
In-Reply-To: <20250408-gicv5-host-v1-0-1f26db465f8d@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.14.2

From: Marc Zyngier <maz@kernel.org>

The arm64 arch has relied so far on GIC architectural software
generated interrupt (SGIs) to handle IPIs. Those are per-cpu
software generated interrupts.

arm64 architecture code that allocates the IPIs virtual IRQs and
IRQ descriptors was written accordingly.

On GICv5 systems, IPIs are implemented using LPIs that are not
per-cpu interrupts - they are just normal routable IRQs.

Add arch code to set-up IPIs on systems where they are handled
using normal routable IRQs.

For those systems, force the IRQ affinity (and make it immutable)
to the cpu a given IRQ was assigned to.

Signed-off-by: Marc Zyngier <maz@kernel.org>
[timothy.hayes@arm.com: fixed ipi/irq conversion, irq flags]
Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
[lpieralisi: changed affinity set-up, log]
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/smp.h |   7 ++-
 arch/arm64/kernel/smp.c      | 139 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 111 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2510eec026f7e3d6f0ecf1197c3a81b183ddd216..d6fd6efb66a673ae33825971e4aa07e791c02ee5 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -53,7 +53,12 @@ extern void smp_init_cpus(void);
 /*
  * Register IPI interrupts with the arch SMP code
  */
-extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
+extern void set_smp_ipi_range_percpu(int ipi_base, int nr_ipi, int ncpus);
+
+static inline void set_smp_ipi_range(int ipi_base, int n)
+{
+	set_smp_ipi_range_percpu(ipi_base, n, 0);
+}
 
 /*
  * Called from the secondary holding pen, this is the secondary CPU entry point.
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3b3f6b56e733039cad7ff5b8995db16a68f3c762..3f3712e47c94c62836fb89cd4bfb3595fbb41557 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -83,7 +83,26 @@ enum ipi_msg_type {
 
 static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
-static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
+
+struct ipi_descs {
+	struct irq_desc *descs[MAX_IPI];
+};
+
+static DEFINE_PER_CPU(struct ipi_descs, pcpu_ipi_desc);
+
+#define get_ipi_desc(__cpu, __ipi) (per_cpu_ptr(&pcpu_ipi_desc, __cpu)->descs[__ipi])
+
+static bool percpu_ipi_descs __ro_after_init;
+
+static int ipi_to_irq(int ipi, int cpu)
+{
+	return ipi_irq_base + (cpu * nr_ipi) + ipi;
+}
+
+static int irq_to_ipi(int irq)
+{
+	return (irq - ipi_irq_base) % nr_ipi;
+}
 
 static bool crash_stop;
 
@@ -844,7 +863,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(get_ipi_desc(cpu, i), cpu));
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
 
@@ -919,7 +938,13 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
-	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
+	unsigned int cpu;
+
+	if (!percpu_ipi_descs)
+		__ipi_send_mask(get_ipi_desc(0, IPI_CPU_BACKTRACE), mask);
+	else
+		for_each_cpu(cpu, mask)
+			__ipi_send_single(get_ipi_desc(cpu, IPI_CPU_BACKTRACE), cpu);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
@@ -944,7 +969,7 @@ void kgdb_roundup_cpus(void)
 		if (cpu == this_cpu)
 			continue;
 
-		__ipi_send_single(ipi_desc[IPI_KGDB_ROUNDUP], cpu);
+		__ipi_send_single(get_ipi_desc(cpu, IPI_KGDB_ROUNDUP), cpu);
 	}
 }
 #endif
@@ -1013,14 +1038,21 @@ static void do_handle_IPI(int ipinr)
 
 static irqreturn_t ipi_handler(int irq, void *data)
 {
-	do_handle_IPI(irq - ipi_irq_base);
+	do_handle_IPI(irq_to_ipi(irq));
 	return IRQ_HANDLED;
 }
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
+	unsigned int cpu;
+
 	trace_ipi_raise(target, ipi_types[ipinr]);
-	__ipi_send_mask(ipi_desc[ipinr], target);
+
+	if (!percpu_ipi_descs)
+		__ipi_send_mask(get_ipi_desc(0, ipinr), target);
+	else
+		for_each_cpu(cpu, target)
+			__ipi_send_single(get_ipi_desc(cpu, ipinr), cpu);
 }
 
 static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
@@ -1046,11 +1078,15 @@ static void ipi_setup(int cpu)
 		return;
 
 	for (i = 0; i < nr_ipi; i++) {
-		if (ipi_should_be_nmi(i)) {
-			prepare_percpu_nmi(ipi_irq_base + i);
-			enable_percpu_nmi(ipi_irq_base + i, 0);
+		if (!percpu_ipi_descs) {
+			if (ipi_should_be_nmi(i)) {
+				prepare_percpu_nmi(ipi_irq_base + i);
+				enable_percpu_nmi(ipi_irq_base + i, 0);
+			} else {
+				enable_percpu_irq(ipi_irq_base + i, 0);
+			}
 		} else {
-			enable_percpu_irq(ipi_irq_base + i, 0);
+			enable_irq(irq_desc_get_irq(get_ipi_desc(cpu, i)));
 		}
 	}
 }
@@ -1064,44 +1100,79 @@ static void ipi_teardown(int cpu)
 		return;
 
 	for (i = 0; i < nr_ipi; i++) {
-		if (ipi_should_be_nmi(i)) {
-			disable_percpu_nmi(ipi_irq_base + i);
-			teardown_percpu_nmi(ipi_irq_base + i);
+		if (!percpu_ipi_descs) {
+			if (ipi_should_be_nmi(i)) {
+				disable_percpu_nmi(ipi_irq_base + i);
+				teardown_percpu_nmi(ipi_irq_base + i);
+			} else {
+				disable_percpu_irq(ipi_irq_base + i);
+			}
 		} else {
-			disable_percpu_irq(ipi_irq_base + i);
+			disable_irq(irq_desc_get_irq(get_ipi_desc(cpu, i)));
 		}
 	}
 }
 #endif
 
-void __init set_smp_ipi_range(int ipi_base, int n)
+static void ipi_setup_ppi(int ipi)
+{
+	int err, irq, cpu;
+
+	irq = ipi_irq_base + ipi;
+
+	if (ipi_should_be_nmi(irq)) {
+		err = request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
+		WARN(err, "Could not request IRQ %d as NMI, err=%d\n", irq, err);
+	} else {
+		err = request_percpu_irq(irq, ipi_handler, "IPI", &irq_stat);
+		WARN(err, "Could not request IRQ %d as IRQ, err=%d\n", irq, err);
+	}
+
+	for_each_possible_cpu(cpu)
+		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);
+
+	irq_set_status_flags(irq, IRQ_HIDDEN);
+}
+
+static void ipi_setup_lpi(int ipi, int ncpus)
+{
+	for (int cpu = 0; cpu < ncpus; cpu++) {
+		int err, irq;
+
+		irq = ipi_to_irq(ipi, cpu);
+
+		err = irq_force_affinity(irq, cpumask_of(cpu));
+
+		WARN(err, "Could not force affinity IRQ %d, err=%d\n", irq, err);
+
+		err = request_irq(irq, ipi_handler, IRQF_NO_AUTOEN, "IPI",
+				  &irq_stat);
+
+		WARN(err, "Could not request IRQ %d, err=%d\n", irq, err);
+
+		irq_set_status_flags(irq, (IRQ_HIDDEN | IRQ_NO_BALANCING_MASK));
+
+		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);
+	}
+}
+
+void __init set_smp_ipi_range_percpu(int ipi_base, int n, int ncpus)
 {
 	int i;
 
 	WARN_ON(n < MAX_IPI);
 	nr_ipi = min(n, MAX_IPI);
 
-	for (i = 0; i < nr_ipi; i++) {
-		int err;
-
-		if (ipi_should_be_nmi(i)) {
-			err = request_percpu_nmi(ipi_base + i, ipi_handler,
-						 "IPI", &irq_stat);
-			WARN(err, "Could not request IPI %d as NMI, err=%d\n",
-			     i, err);
-		} else {
-			err = request_percpu_irq(ipi_base + i, ipi_handler,
-						 "IPI", &irq_stat);
-			WARN(err, "Could not request IPI %d as IRQ, err=%d\n",
-			     i, err);
-		}
-
-		ipi_desc[i] = irq_to_desc(ipi_base + i);
-		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
-	}
-
+	percpu_ipi_descs = !!ncpus;
 	ipi_irq_base = ipi_base;
 
+	for (i = 0; i < nr_ipi; i++) {
+		if (!percpu_ipi_descs)
+			ipi_setup_ppi(i);
+		else
+			ipi_setup_lpi(i, ncpus);
+	}
+
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
 }

-- 
2.48.0


