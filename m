Return-Path: <linux-kernel+bounces-722190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43398AFD65D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3343B2DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2F42E92CF;
	Tue,  8 Jul 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQb197jD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pwn9EmlQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419A2E8E04
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998835; cv=none; b=rQOVRgbOb0uEUqahG91HcqnCm7Pq+8wMvecIJTmzej7M0vWxGH7lLudfSynDZOwZrL3u67IW4akVV63F38H8Y+tRbDwmY/LsItvKfs4/oQSX6xE3b0JLbdm7XTAaQNFvQ6Osi9qu3lFh0dejrYW63V4V9Y1nagu9HfLRG0eldsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998835; c=relaxed/simple;
	bh=+BbKXFnqUZoNjuttDNUKfQcvvjO3w9ORUqX1B9W8j30=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZnkLfNuKAIUFRKYry3h7RcGOBndnhPtilB2lOf9Fa1FDk0v5bQwoV+GnnOnE93opWrDeHtPeoTqSsSEtgPqHvmr2Wka59AmFRW0OuW3XetcnnNKNrZV4OHIuE2LIJBR65tIR65C0ZPza9QaJgk4xk66JSxuyrID/PlBRsiXZ8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQb197jD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pwn9EmlQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcsnNIz0oFH6zTEuxccvU6HN/dpaCRQ8YzjVrqXj0F4=;
	b=UQb197jDY5mkrLW/aczp3l4pE9CryHE/FcW2FuusZfE6jgFzm3O5uKRIQwwXmDSEtPERgl
	TcWuMs/Pbzye4X2j/kgVcd9Hf/9AG1BIgSyDgO22UuFDq0jlDodHqv2CzgOUPhRvqlGxUR
	DGy/4kxMJUL2T1wTCtNkyiwK2O514/xEMOzsOhVlzQvv9PsRAr8AN4e+J3E17L9I/aHYd4
	Gc0JKKvbkDPn1nQIsQ/3oiQPU0Ruu3N7p/33lhS6GAZU/le+J79iJLEIsfFO8YQU98wgzs
	JGmiCnOIRf68wrdKvwyNwgFUX0jUDHwiQS4WDfAI8tW/Oyuxw1japKOb8/g7Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcsnNIz0oFH6zTEuxccvU6HN/dpaCRQ8YzjVrqXj0F4=;
	b=Pwn9EmlQOvBGupn8UolWGPNtyM2pCx6Y31/2f+L8ylb2Zqxk/9V/BHN+7P8C3QCc101HrW
	yfoq/dItHvoxgfAA==
From: "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: smp: Support non-SGIs for IPIs
Cc: Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883030.406.16112927183706227147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ba1004f861d16f24179f14f13f70c09227ccbffb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ba1004f861d16f24179f14f13f70c09227ccbffb
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:08 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64: smp: Support non-SGIs for IPIs

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

Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
[lpieralisi: changed affinity set-up, log]
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/smp.h |   7 +-
 arch/arm64/kernel/smp.c      | 125 +++++++++++++++++++++++++---------
 2 files changed, 98 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2510eec..d6fd6ef 100644
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
index 3b3f6b5..2c501e9 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -83,7 +83,16 @@ enum ipi_msg_type {
 
 static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
-static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
+
+struct ipi_descs {
+	struct irq_desc *descs[MAX_IPI];
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct ipi_descs, pcpu_ipi_desc);
+
+#define get_ipi_desc(__cpu, __ipi) (per_cpu_ptr(&pcpu_ipi_desc, __cpu)->descs[__ipi])
+
+static bool percpu_ipi_descs __ro_after_init;
 
 static bool crash_stop;
 
@@ -844,7 +853,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(get_ipi_desc(cpu, i), cpu));
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
 
@@ -917,9 +926,20 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }
 
+static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
+{
+	unsigned int cpu;
+
+	if (!percpu_ipi_descs)
+		__ipi_send_mask(get_ipi_desc(0, nr), mask);
+	else
+		for_each_cpu(cpu, mask)
+			__ipi_send_single(get_ipi_desc(cpu, nr), cpu);
+}
+
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
-	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
+	arm64_send_ipi(mask, IPI_CPU_BACKTRACE);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
@@ -944,7 +964,7 @@ void kgdb_roundup_cpus(void)
 		if (cpu == this_cpu)
 			continue;
 
-		__ipi_send_single(ipi_desc[IPI_KGDB_ROUNDUP], cpu);
+		__ipi_send_single(get_ipi_desc(cpu, IPI_KGDB_ROUNDUP), cpu);
 	}
 }
 #endif
@@ -1013,14 +1033,16 @@ static void do_handle_IPI(int ipinr)
 
 static irqreturn_t ipi_handler(int irq, void *data)
 {
-	do_handle_IPI(irq - ipi_irq_base);
+	unsigned int ipi = (irq - ipi_irq_base) % nr_ipi;
+
+	do_handle_IPI(ipi);
 	return IRQ_HANDLED;
 }
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
 	trace_ipi_raise(target, ipi_types[ipinr]);
-	__ipi_send_mask(ipi_desc[ipinr], target);
+	arm64_send_ipi(target, ipinr);
 }
 
 static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
@@ -1046,11 +1068,15 @@ static void ipi_setup(int cpu)
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
@@ -1064,44 +1090,77 @@ static void ipi_teardown(int cpu)
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
+static void ipi_setup_sgi(int ipi)
 {
-	int i;
+	int err, irq, cpu;
 
-	WARN_ON(n < MAX_IPI);
-	nr_ipi = min(n, MAX_IPI);
+	irq = ipi_irq_base + ipi;
 
-	for (i = 0; i < nr_ipi; i++) {
-		int err;
+	if (ipi_should_be_nmi(irq)) {
+		err = request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
+		WARN(err, "Could not request IRQ %d as NMI, err=%d\n", irq, err);
+	} else {
+		err = request_percpu_irq(irq, ipi_handler, "IPI", &irq_stat);
+		WARN(err, "Could not request IRQ %d as IRQ, err=%d\n", irq, err);
+	}
 
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
 
-		ipi_desc[i] = irq_to_desc(ipi_base + i);
-		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+		irq = ipi_irq_base + (cpu * nr_ipi) + ipi;
+
+		err = irq_force_affinity(irq, cpumask_of(cpu));
+		WARN(err, "Could not force affinity IRQ %d, err=%d\n", irq, err);
+
+		err = request_irq(irq, ipi_handler, IRQF_NO_AUTOEN, "IPI",
+				  NULL);
+		WARN(err, "Could not request IRQ %d, err=%d\n", irq, err);
+
+		irq_set_status_flags(irq, (IRQ_HIDDEN | IRQ_NO_BALANCING_MASK));
+
+		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);
 	}
+}
 
+void __init set_smp_ipi_range_percpu(int ipi_base, int n, int ncpus)
+{
+	int i;
+
+	WARN_ON(n < MAX_IPI);
+	nr_ipi = min(n, MAX_IPI);
+
+	percpu_ipi_descs = !!ncpus;
 	ipi_irq_base = ipi_base;
 
+	for (i = 0; i < nr_ipi; i++) {
+		if (!percpu_ipi_descs)
+			ipi_setup_sgi(i);
+		else
+			ipi_setup_lpi(i, ncpus);
+	}
+
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
 }

