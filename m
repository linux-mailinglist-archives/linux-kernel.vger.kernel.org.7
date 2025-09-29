Return-Path: <linux-kernel+bounces-836613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B322BAA296
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBB6171F96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2330101A;
	Mon, 29 Sep 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="e/AkUVJu"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2121257F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166775; cv=none; b=feTHQbYEgdiODTACbDN900TMNmE4N8Hg5/Rw5RwPKT9Y1RwsbHobKugUpYgHNLBpMmzASgqARDsFfh6NWJSHmaEFaDotSAIKj7cMXe5RiYTLmM6SqCg+D1C/EKe2L5UV3RyZJmLDkSGNsc2WP27Y5LwTFG4QXdadp0ONdx5hxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166775; c=relaxed/simple;
	bh=EHIy8dEPDqxt6PRozzxc6lMy2O+yWldQhMw2v42rm5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uw3EJsHeGnmIIe2eeqF+CoNcd3p0GsZB74duJSKqAbzAiUvq9Li53iqQaqB2oXo7kShXsMaEa4hN1R25j3943y31PJxtu0xINoq0lDaAPu2BhTyNWfYKGyTBTFEMU0I08Z6DAjN8vFRyrwXlGrs2tyBWXp5iC8iCGvlVBAQlFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=e/AkUVJu; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 0F19092CCF;
	Mon, 29 Sep 2025 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1759166772;
	bh=e6UOPjDX6GDXZTJ3BHTWH5HK3Gp1+g+0ZC9njXBfRgQ=;
	h=Date:From:To:Cc:Subject;
	b=e/AkUVJuzopXQ5x4xjhxL/a+Pc5OchbpGuqBrhqSYPN8eJ4HziHRO+6Se2NIGdne7
	 dvhIVY1wSMpNSi5+H+MjVrUcTjHoiU/iznFHWXgcZUL6eKNf5cM1RD2a5urWeFVCrO
	 J8aBhFnJPizUXR4d4O9oowLxWLLgsjf1SsP6gmbs=
Date: Mon, 29 Sep 2025 17:26:07 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] x86/irq: Optimize interrupts decimals printing
Message-ID: <aNrBL0Pi6kYXHGxQ@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Function seq_printf supports rich format string for decimals printing,
but it doesn't required for printing /proc/interrupts per CPU counters,
seq_put_decimal_ull_width function can be used instead to print per CPU
counters, because very limited formatting is required for this case.

Performance counter stats (truncated) for 'sh -c cat /proc/interrupts
>/dev/null' (1000 runs) before and after applying the patch below.

Before:

      3.42 msec task-clock        #    0.802 CPUs utilized   ( +-  0.05% )
         1      context-switches  #  291.991 /sec            ( +-  0.74% )
         0      cpu-migrations    #    0.000 /sec
       343      page-faults       #  100.153 K/sec           ( +-  0.01% )
 8,932,242      instructions      #    1.66  insn per cycle  ( +-  0.34% )
 5,374,427      cycles            #    1.569 GHz             ( +-  0.04% )
 1,483,154      branches          #  433.068 M/sec           ( +-  0.22% )
    28,768      branch-misses     #    1.94% of all branches ( +-  0.31% )

0.00427182 +- 0.00000215 seconds time elapsed  ( +-  0.05% )

After:

      2.39 msec task-clock        #    0.796 CPUs utilized   ( +-  0.06% )
         1      context-switches  #  418.541 /sec            ( +-  0.70% )
         0      cpu-migrations    #    0.000 /sec
       343      page-faults       #  143.560 K/sec           ( +-  0.01% )
 7,020,982      instructions      #    1.30  insn per cycle  ( +-  0.52% )
 5,397,266      cycles            #    2.259 GHz             ( +-  0.06% )
 1,569,648      branches          #  656.962 M/sec           ( +-  0.08% )
    25,419      branch-misses     #    1.62% of all branches ( +-  0.72% )

0.00299996 +- 0.00000206 seconds time elapsed  ( +-  0.07% )

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 arch/x86/kernel/irq.c | 96 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 10721a125226..3b5a5e2d16e1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -61,6 +61,14 @@ void ack_bad_irq(unsigned int irq)
 	apic_eoi();
 }
 
+static void put_spaced_decimal(struct seq_file *p, unsigned long long num)
+{
+	const char *delimiter = " ";
+	unsigned int width = 10;
+
+	seq_put_decimal_ull_width(p, delimiter, num, width);
+}
+
 #define irq_stats(x)		(&per_cpu(irq_stat, x))
 /*
  * /proc/interrupts printing for arch specific interrupts
@@ -69,102 +77,102 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->__nmi_count);
+		put_spaced_decimal(p, irq_stats(j)->__nmi_count);
 	seq_puts(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_timer_irqs);
+		put_spaced_decimal(p, irq_stats(j)->apic_timer_irqs);
 	seq_puts(p, "  Local timer interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "SPU");
+	seq_printf(p, "%*s:", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_spurious_count);
+		put_spaced_decimal(p, irq_stats(j)->irq_spurious_count);
 	seq_puts(p, "  Spurious interrupts\n");
-	seq_printf(p, "%*s: ", prec, "PMI");
+	seq_printf(p, "%*s:", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_perf_irqs);
+		put_spaced_decimal(p, irq_stats(j)->apic_perf_irqs);
 	seq_puts(p, "  Performance monitoring interrupts\n");
-	seq_printf(p, "%*s: ", prec, "IWI");
+	seq_printf(p, "%*s:", prec, "IWI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_irq_work_irqs);
+		put_spaced_decimal(p, irq_stats(j)->apic_irq_work_irqs);
 	seq_puts(p, "  IRQ work interrupts\n");
-	seq_printf(p, "%*s: ", prec, "RTR");
+	seq_printf(p, "%*s:", prec, "RTR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->icr_read_retry_count);
+		put_spaced_decimal(p, irq_stats(j)->icr_read_retry_count);
 	seq_puts(p, "  APIC ICR read retries\n");
 	if (x86_platform_ipi_callback) {
-		seq_printf(p, "%*s: ", prec, "PLT");
+		seq_printf(p, "%*s:", prec, "PLT");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->x86_platform_ipis);
+			put_spaced_decimal(p, irq_stats(j)->x86_platform_ipis);
 		seq_puts(p, "  Platform interrupts\n");
 	}
 #endif
 #ifdef CONFIG_SMP
-	seq_printf(p, "%*s: ", prec, "RES");
+	seq_printf(p, "%*s:", prec, "RES");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_resched_count);
+		put_spaced_decimal(p, irq_stats(j)->irq_resched_count);
 	seq_puts(p, "  Rescheduling interrupts\n");
-	seq_printf(p, "%*s: ", prec, "CAL");
+	seq_printf(p, "%*s:", prec, "CAL");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
+		put_spaced_decimal(p, irq_stats(j)->irq_call_count);
 	seq_puts(p, "  Function call interrupts\n");
-	seq_printf(p, "%*s: ", prec, "TLB");
+	seq_printf(p, "%*s:", prec, "TLB");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_tlb_count);
+		put_spaced_decimal(p, irq_stats(j)->irq_tlb_count);
 	seq_puts(p, "  TLB shootdowns\n");
 #endif
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	seq_printf(p, "%*s: ", prec, "TRM");
+	seq_printf(p, "%*s:", prec, "TRM");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_thermal_count);
+		put_spaced_decimal(p, irq_stats(j)->irq_thermal_count);
 	seq_puts(p, "  Thermal event interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	seq_printf(p, "%*s: ", prec, "THR");
+	seq_printf(p, "%*s:", prec, "THR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_threshold_count);
+		put_spaced_decimal(p, irq_stats(j)->irq_threshold_count);
 	seq_puts(p, "  Threshold APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_AMD
-	seq_printf(p, "%*s: ", prec, "DFR");
+	seq_printf(p, "%*s:", prec, "DFR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_deferred_error_count);
+		put_spaced_decimal(p, irq_stats(j)->irq_deferred_error_count);
 	seq_puts(p, "  Deferred Error APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE
-	seq_printf(p, "%*s: ", prec, "MCE");
+	seq_printf(p, "%*s:", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_exception_count, j));
+		put_spaced_decimal(p, per_cpu(mce_exception_count, j));
 	seq_puts(p, "  Machine check exceptions\n");
-	seq_printf(p, "%*s: ", prec, "MCP");
+	seq_printf(p, "%*s:", prec, "MCP");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
+		put_spaced_decimal(p, per_cpu(mce_poll_count, j));
 	seq_puts(p, "  Machine check polls\n");
 #endif
 #ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HYP");
+		seq_printf(p, "%*s:", prec, "HYP");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
+			put_spaced_decimal(p,
 				   irq_stats(j)->irq_hv_callback_count);
 		seq_puts(p, "  Hypervisor callback interrupts\n");
 	}
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (test_bit(HYPERV_REENLIGHTENMENT_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HRE");
+		seq_printf(p, "%*s:", prec, "HRE");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
+			put_spaced_decimal(p,
 				   irq_stats(j)->irq_hv_reenlightenment_count);
 		seq_puts(p, "  Hyper-V reenlightenment interrupts\n");
 	}
 	if (test_bit(HYPERV_STIMER0_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HVS");
+		seq_printf(p, "%*s:", prec, "HVS");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
+			put_spaced_decimal(p,
 				   irq_stats(j)->hyperv_stimer0_count);
 		seq_puts(p, "  Hyper-V stimer0 interrupts\n");
 	}
@@ -174,27 +182,27 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	seq_printf(p, "%*s: %10u\n", prec, "MIS", atomic_read(&irq_mis_count));
 #endif
 #if IS_ENABLED(CONFIG_KVM)
-	seq_printf(p, "%*s: ", prec, "PIN");
+	seq_printf(p, "%*s:", prec, "PIN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->kvm_posted_intr_ipis);
+		put_spaced_decimal(p, irq_stats(j)->kvm_posted_intr_ipis);
 	seq_puts(p, "  Posted-interrupt notification event\n");
 
-	seq_printf(p, "%*s: ", prec, "NPI");
+	seq_printf(p, "%*s:", prec, "NPI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
+		put_spaced_decimal(p,
 			   irq_stats(j)->kvm_posted_intr_nested_ipis);
 	seq_puts(p, "  Nested posted-interrupt event\n");
 
-	seq_printf(p, "%*s: ", prec, "PIW");
+	seq_printf(p, "%*s:", prec, "PIW");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
+		put_spaced_decimal(p,
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
 #endif
 #ifdef CONFIG_X86_POSTED_MSI
-	seq_printf(p, "%*s: ", prec, "PMN");
+	seq_printf(p, "%*s:", prec, "PMN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
+		put_spaced_decimal(p,
 			   irq_stats(j)->posted_msi_notification_count);
 	seq_puts(p, "  Posted MSI notification event\n");
 #endif
-- 
2.47.3


