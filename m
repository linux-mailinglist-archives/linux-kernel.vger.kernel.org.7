Return-Path: <linux-kernel+bounces-883555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6711C2DBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9649E1898CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFD31DDA0;
	Mon,  3 Nov 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="VhsGwNWp"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB331D73F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195880; cv=none; b=XPdCK0eX7N/q9mF49imfgBPDwrvwVjRfBr6JgTUq0YvOE2b8mzKJupcKQoKKCKS4CmqEE5yY0a4D+dIEF54i+Btd+uyleXm52dGPuupuP4x1G0ze9bFfW2uP0nK04FRg0/vsUjHyF8doDzsDK+NjFTGsdvPHa0lAW96pYfWWr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195880; c=relaxed/simple;
	bh=u7ddJcTMvseUbhBQvYq4I8Nb1DKXl9yW2xpS7XW47LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ISCFwmtrdqpbNk/mY144Eu44KwyDIBAKMVM82wteMQJJksdu4QpdQYY1qwxPnA//x7ER4C/gzODXsOwJ4vqqI4bo6my7HI2xjQzAbHbhXuSQJwA6giLw6Jx73y8Rt4TP3/uTdR29ve4undbVcD+0ZjV/TihOTWqO9WbWfr+87Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=VhsGwNWp; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 9BE569B2C1;
	Mon, 03 Nov 2025 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1762195867;
	bh=R7GvX8u4d4xxHCve7gZsGtG9ntMpv9yoMQZrAVAM2Bs=;
	h=Date:From:To:Cc:Subject;
	b=VhsGwNWpFH3qZhZgsHS9M2R8k6+iUyUA9gIAxG7WfFtFuiESTZUVMt+vL3wME6vM/
	 ARaGeT6LuY0LBW89yjNwkkGx0JgM36GoVWiwSiCsm97GUa9VucgAgoT8N2cDK0eVXh
	 iRr219RuDeguvwG/T8iWYzH2d52yCHWoLvhI223k=
Date: Mon, 3 Nov 2025 18:51:04 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2] x86/irq: Optimize interrupts decimals printing
Message-ID: <aQj5mGZ6_BBlAm3B@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Monitoring tools (such as Prometheus [1] or dynolog [2]) periodically
pull /proc/interrupts to export metrics as a timeseries for future
analysis and investigation.

In large fleets, /proc/interrupts is polled (often every few seconds) on
every machine. The cumulative overhead adds up quickly across thousands
of nodes, so reducing the cost of generating these stats does have a
measurable operational impact. With the ongoing trend toward higher core
counts per machine, this cost becomes even more noticeable over time,
since interrupt counters are per-CPU. In Meta's fleet, we have observed
this overhead at scale.

Although a binary /proc interface would be a better long-term solution
due to lower formatting (kernel side) and parsing (userspace side)
overhead, the text interface will remain in use for some time, even if
better solutions will be available. Optimizing the /proc/interrupts
printing code is therefore still beneficial.

Function seq_printf() supports rich format string for decimals printing,
but it doesn't required for printing /proc/interrupts per CPU counters,
seq_put_decimal_ull_width() function can be used instead to print per
CPU counters, because very limited formatting is required for this case.
Similar optimization idea is already used in show_interrupts().

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

Relative speed up in time elapsed is around 29%.

[1]: https://github.com/prometheus/prometheus
[2]: https://github.com/facebookincubator/dynolog

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
Changes v2:
- Expanded commit message: add more rationale for the proposed change.
- Renamed helper put_spaced_decimal() -> put_decimal() primarely to make
  checkpatch.pl --strict pass.

 arch/x86/kernel/irq.c | 107 ++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 10721a125226..4a8bac31be70 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -61,6 +61,18 @@ void ack_bad_irq(unsigned int irq)
 	apic_eoi();
 }
 
+/*
+ * A helper routine for putting space and decimal number without overhead
+ * from rich format of printf().
+ */
+static void put_decimal(struct seq_file *p, unsigned long long num)
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
@@ -69,103 +81,101 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->__nmi_count);
+		put_decimal(p, irq_stats(j)->__nmi_count);
 	seq_puts(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_printf(p, "%*s: ", prec, "LOC");
+	seq_printf(p, "%*s:", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_timer_irqs);
+		put_decimal(p, irq_stats(j)->apic_timer_irqs);
 	seq_puts(p, "  Local timer interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "SPU");
+	seq_printf(p, "%*s:", prec, "SPU");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_spurious_count);
+		put_decimal(p, irq_stats(j)->irq_spurious_count);
 	seq_puts(p, "  Spurious interrupts\n");
-	seq_printf(p, "%*s: ", prec, "PMI");
+	seq_printf(p, "%*s:", prec, "PMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_perf_irqs);
+		put_decimal(p, irq_stats(j)->apic_perf_irqs);
 	seq_puts(p, "  Performance monitoring interrupts\n");
-	seq_printf(p, "%*s: ", prec, "IWI");
+	seq_printf(p, "%*s:", prec, "IWI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->apic_irq_work_irqs);
+		put_decimal(p, irq_stats(j)->apic_irq_work_irqs);
 	seq_puts(p, "  IRQ work interrupts\n");
-	seq_printf(p, "%*s: ", prec, "RTR");
+	seq_printf(p, "%*s:", prec, "RTR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->icr_read_retry_count);
+		put_decimal(p, irq_stats(j)->icr_read_retry_count);
 	seq_puts(p, "  APIC ICR read retries\n");
 	if (x86_platform_ipi_callback) {
-		seq_printf(p, "%*s: ", prec, "PLT");
+		seq_printf(p, "%*s:", prec, "PLT");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", irq_stats(j)->x86_platform_ipis);
+			put_decimal(p, irq_stats(j)->x86_platform_ipis);
 		seq_puts(p, "  Platform interrupts\n");
 	}
 #endif
 #ifdef CONFIG_SMP
-	seq_printf(p, "%*s: ", prec, "RES");
+	seq_printf(p, "%*s:", prec, "RES");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_resched_count);
+		put_decimal(p, irq_stats(j)->irq_resched_count);
 	seq_puts(p, "  Rescheduling interrupts\n");
-	seq_printf(p, "%*s: ", prec, "CAL");
+	seq_printf(p, "%*s:", prec, "CAL");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
+		put_decimal(p, irq_stats(j)->irq_call_count);
 	seq_puts(p, "  Function call interrupts\n");
-	seq_printf(p, "%*s: ", prec, "TLB");
+	seq_printf(p, "%*s:", prec, "TLB");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_tlb_count);
+		put_decimal(p, irq_stats(j)->irq_tlb_count);
 	seq_puts(p, "  TLB shootdowns\n");
 #endif
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	seq_printf(p, "%*s: ", prec, "TRM");
+	seq_printf(p, "%*s:", prec, "TRM");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_thermal_count);
+		put_decimal(p, irq_stats(j)->irq_thermal_count);
 	seq_puts(p, "  Thermal event interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	seq_printf(p, "%*s: ", prec, "THR");
+	seq_printf(p, "%*s:", prec, "THR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_threshold_count);
+		put_decimal(p, irq_stats(j)->irq_threshold_count);
 	seq_puts(p, "  Threshold APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE_AMD
-	seq_printf(p, "%*s: ", prec, "DFR");
+	seq_printf(p, "%*s:", prec, "DFR");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_deferred_error_count);
+		put_decimal(p, irq_stats(j)->irq_deferred_error_count);
 	seq_puts(p, "  Deferred Error APIC interrupts\n");
 #endif
 #ifdef CONFIG_X86_MCE
-	seq_printf(p, "%*s: ", prec, "MCE");
+	seq_printf(p, "%*s:", prec, "MCE");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_exception_count, j));
+		put_decimal(p, per_cpu(mce_exception_count, j));
 	seq_puts(p, "  Machine check exceptions\n");
-	seq_printf(p, "%*s: ", prec, "MCP");
+	seq_printf(p, "%*s:", prec, "MCP");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
+		put_decimal(p, per_cpu(mce_poll_count, j));
 	seq_puts(p, "  Machine check polls\n");
 #endif
 #ifdef CONFIG_X86_HV_CALLBACK_VECTOR
 	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HYP");
+		seq_printf(p, "%*s:", prec, "HYP");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_callback_count);
+			put_decimal(p, irq_stats(j)->irq_hv_callback_count);
 		seq_puts(p, "  Hypervisor callback interrupts\n");
 	}
 #endif
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (test_bit(HYPERV_REENLIGHTENMENT_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HRE");
+		seq_printf(p, "%*s:", prec, "HRE");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->irq_hv_reenlightenment_count);
+			put_decimal(p,
+				    irq_stats(j)->irq_hv_reenlightenment_count);
 		seq_puts(p, "  Hyper-V reenlightenment interrupts\n");
 	}
 	if (test_bit(HYPERV_STIMER0_VECTOR, system_vectors)) {
-		seq_printf(p, "%*s: ", prec, "HVS");
+		seq_printf(p, "%*s:", prec, "HVS");
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ",
-				   irq_stats(j)->hyperv_stimer0_count);
+			put_decimal(p, irq_stats(j)->hyperv_stimer0_count);
 		seq_puts(p, "  Hyper-V stimer0 interrupts\n");
 	}
 #endif
@@ -174,28 +184,25 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	seq_printf(p, "%*s: %10u\n", prec, "MIS", atomic_read(&irq_mis_count));
 #endif
 #if IS_ENABLED(CONFIG_KVM)
-	seq_printf(p, "%*s: ", prec, "PIN");
+	seq_printf(p, "%*s:", prec, "PIN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->kvm_posted_intr_ipis);
+		put_decimal(p, irq_stats(j)->kvm_posted_intr_ipis);
 	seq_puts(p, "  Posted-interrupt notification event\n");
 
-	seq_printf(p, "%*s: ", prec, "NPI");
+	seq_printf(p, "%*s:", prec, "NPI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_nested_ipis);
+		put_decimal(p, irq_stats(j)->kvm_posted_intr_nested_ipis);
 	seq_puts(p, "  Nested posted-interrupt event\n");
 
-	seq_printf(p, "%*s: ", prec, "PIW");
+	seq_printf(p, "%*s:", prec, "PIW");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
+		put_decimal(p, irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
 #endif
 #ifdef CONFIG_X86_POSTED_MSI
-	seq_printf(p, "%*s: ", prec, "PMN");
+	seq_printf(p, "%*s:", prec, "PMN");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ",
-			   irq_stats(j)->posted_msi_notification_count);
+		put_decimal(p, irq_stats(j)->posted_msi_notification_count);
 	seq_puts(p, "  Posted MSI notification event\n");
 #endif
 	return 0;
-- 
2.47.3


