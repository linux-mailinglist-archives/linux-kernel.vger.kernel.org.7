Return-Path: <linux-kernel+bounces-898033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C6AC542D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8527E42324C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667793570C1;
	Wed, 12 Nov 2025 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nm24AbZn"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC3351FA1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975476; cv=none; b=W3ZWYyCnd4EnWo7bqhRt98nsnaCIVqdCPyapCsm4X6c+KBXtP/O13oHaGUv9i5cjM+xnkDDPOonesKTqzMCf1No1OlusFMBzLBf9bfE33z60+iLZaOX/BR3kmOeVKI6ObwnaQqsXk4pmbR4WcRy3Qqws2SMGPtBPlWUptZt9jGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975476; c=relaxed/simple;
	bh=EcEMz/roqR7p5kfQ+SF+75AAG1oH5FluG3tlNWV3tf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oM2MinQxXgIUZQ0fHKqIB/nRx0axKMHRzXUhpuZwQKm5tlOg987feVRCMJsF5BOn+VKaOLNo8/gwTPOjtDeoThAqslfVbM/pGBAmgc+Oxx8zWEPancvDCJl8kH6zDe0s0mWTQ4Etsp+QRy+9EhGugPTCuB5KrdAN0STZW8j9QzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nm24AbZn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so519255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975471; x=1763580271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VC1j8oYRoAipyh2PTAdRVVd7/P28VqKYCYBPW/DVTGs=;
        b=nm24AbZn+Y+Cmb88a5cgtTmTaHTeDrlWeRoyZ9etBYXRkKyT2RYd6UKWfNXVFGsmSa
         iJNETg3WxbV0LxwNd17M6oUrWtzZ6vtlH29wwyp/Wq2LZjAzkbDS74Y3CvkmHIhBeU5I
         iPEHo3OFnFf174/EWznUSkgwaRYqPZ4WwWbxVj7mJ2FrsUX4PvPssKdhGzqZQ350rPwp
         rLP5qjMIa2vG1Gn9JYIwXO+CaR5Xs8xyPkwqhizUjQ/VwEBe5GBzx1owJ75zw0qLJwdi
         KtzmGdtG4bm17IriYI4S4GxRbnUdURqWqrv+wZWwI/W/xYV5615jU99deX6kmBlHpy6z
         70/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975471; x=1763580271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VC1j8oYRoAipyh2PTAdRVVd7/P28VqKYCYBPW/DVTGs=;
        b=CDjku3ZdwIPw42hYBJ2DLy//2tvun34kppJFBxb4S8Ph2rrJ4Cf3LdJoKQ6rIYeV4+
         nLgdzLjGeER7wf5Sv0nh48wNotnVUqP2e7CWva32YrcRGAcAFgN3IGZi6EgSA9MlXd9i
         yWKcb1LNwRz2GtPi160kFwO87ftxwIgBFupRIP0rowI5rx3gNu910xe6I9KdS9epBBKw
         b1lxg0lmR4Jr4OsYW/aS5ace3SVBYlN2QG3dcs0fcH3VBdX27kpSu3Oh7T5I3xlnCMM2
         SBm3D226BeKbdSnVcBmEYk20k9cke588BadmFlbyRiaTzvkyQ3VQoazRo/eSq4HnJD0L
         sLfA==
X-Gm-Message-State: AOJu0YyUQVOmNn29GzAXlrq8qY/9Sb/eOBBkHPOVvCG0aWbdKaCl/pEd
	/hLaotA0cg52zgxpKJCOLDWljILshqg+dT+Ni/BUlMcEroPiLl/51OW1BAWj7M586p85Tqpy/4K
	HMVjuJQ==
X-Google-Smtp-Source: AGHT+IES5L+U2SYBYYvmU4RSiZn/1uxydaGSZ+d9qkJ7f9qO3dw4Mv7B3ZWzNFbDg7tNlJ/GNLLLBlHqCLk=
X-Received: from wmjq25.prod.google.com ([2002:a7b:ce99:0:b0:46e:1e57:dbd6])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3546:b0:46e:32a5:bd8d
 with SMTP id 5b1f17b1804b1-4778703e738mr45602905e9.3.1762975471183; Wed, 12
 Nov 2025 11:24:31 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:07 +0000
In-Reply-To: <20251112192408.3646835-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-6-lrizzo@google.com>
Subject: [PATCH 5/6] x86/irq: soft_moderation: add support for posted_msi (intel)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

On recent Intel CPUs, kernels compiled with CONFIG_X86_POSTED_MSI=y,
and the boot option "intremap=posted_msi", all MSI interrupts
that hit a CPU issue a single POSTED_MSI interrupt processed by
sysvec_posted_msi_notification() instead of having separate interrupts.

This change adds soft moderation hooks to the above handler.
Soft moderation on posted_msi does not require per-source enable,
irq_moderation.delay_us > 0 suffices.

To test it, run a kernel with the above options and enable moderation by
setting delay_us > 0.  The column "from_msi" in /proc/irq/soft_moderation
will show a non-zero value.

Change-Id: Idcd6005f05048c4b3f9d002c8587039b46bc9d73
---
 arch/x86/kernel/irq.c          | 12 +++++++
 include/linux/irq_moderation.h | 62 ++++++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.c    | 39 ++++++++++++++++-----
 3 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 10721a1252269..241d57fadc30c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -4,6 +4,7 @@
  */
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/irq_moderation.h>
 #include <linux/kernel_stat.h>
 #include <linux/of.h>
 #include <linux/seq_file.h>
@@ -448,6 +449,13 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 	inc_irq_stat(posted_msi_notification_count);
 	irq_enter();
 
+	if (posted_msi_moderation_enabled()) {
+		if (posted_msi_should_rearm(handle_pending_pir(pid->pir, regs)))
+			goto rearm;
+		else
+			goto common_end;
+	}
+
 	/*
 	 * Max coalescing count includes the extra round of handle_pending_pir
 	 * after clearing the outstanding notification bit. Hence, at most
@@ -458,6 +466,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 			break;
 	}
 
+rearm:
 	/*
 	 * Clear outstanding notification bit to allow new IRQ notifications,
 	 * do this last to maximize the window of interrupt coalescing.
@@ -471,6 +480,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 	 */
 	handle_pending_pir(pid->pir, regs);
 
+common_end:
+	posted_msi_moderation_epilogue();
+
 	apic_eoi();
 	irq_exit();
 	set_irq_regs(old_regs);
diff --git a/include/linux/irq_moderation.h b/include/linux/irq_moderation.h
index 45df60230e42e..aabcfaba1aefc 100644
--- a/include/linux/irq_moderation.h
+++ b/include/linux/irq_moderation.h
@@ -155,6 +155,14 @@ static inline void irq_moderation_hook(struct irq_desc *desc)
 	if (!irq_moderation_enabled())
 		return;
 
+#ifdef CONFIG_X86_POSTED_MSI
+	if (ms->in_posted_msi) { /* these calls are not moderated */
+		ms->from_posted_msi++;
+		ms->irq_count += irq_mod_info.count_msi_calls;
+		return;
+	}
+#endif
+
 	if (!READ_ONCE(desc->moderation_mode))
 		return;
 
@@ -193,11 +201,65 @@ static inline void irq_moderation_epilogue(const struct irq_desc *desc)
 		irq_moderation_start_timer(ms);
 }
 
+#ifdef CONFIG_X86_POSTED_MSI
+/*
+ * Helpers for to sysvec_posted_msi_notification(), use as follows
+ *
+ *	if (posted_msi_moderation_enabled()) {
+ *		if (posted_msi_should_rearm(handle_pending_pir(pid->pir, regs)))
+ *			goto rearm;
+ *		else
+ *			goto common_end;
+ *	}
+ *	...
+ *  common_end:
+ *	posted_msi_moderation_epilogue();
+ */
+static inline bool posted_msi_moderation_enabled(void)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (!irq_moderation_enabled())
+		return false;
+	irq_moderation_adjust_delay(ms);
+	ms->in_posted_msi = true;	/* tell handler to not throttle these calls */
+	return true;
+}
+
+/* Decide whether to rearm or not posted_msi */
+static inline bool posted_msi_should_rearm(bool work_done)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (ms->rounds_left > 0)	/* timer pending, no rearm */
+		return false;
+	if (!work_done)			/* no work done, can rearm */
+		return true;
+	if (!irq_moderation_needed(ms)) /* moderation not needed, rearm */
+		return true;
+	ms->kick_posted_msi = true;	/* do kick in timer callback */
+	irq_moderation_start_timer(ms);
+	return false;	/* timer now active, no rearm */
+}
+
+/* Cleanup state set in posted_msi_moderation_enabled() */
+static inline void posted_msi_moderation_epilogue(void)
+{
+	this_cpu_ptr(&irq_mod_state)->in_posted_msi = false;
+}
+#endif
+
 #else	/* empty stubs to avoid conditional compilation */
 
 static inline void irq_moderation_hook(struct irq_desc *desc) {}
 static inline void irq_moderation_epilogue(const struct irq_desc *desc) {}
 
+#ifdef CONFIG_X86_POSTED_MSI
+static inline bool posted_msi_moderation_enabled(void) { return false; }
+static inline bool posted_msi_should_rearm(bool work_done) { return false; }
+static inline void posted_msi_moderation_epilogue(void) {}
+#endif
+
 #endif /* CONFIG_IRQ_SOFT_MODERATION */
 
 #endif /* _LINUX_IRQ_MODERATION_H */
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 0229697a6a95a..672e161ecf29e 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -7,6 +7,15 @@
 #include <linux/irq_moderation.h>
 #include <linux/kernel_stat.h>	/* interrupt.h, kcpustat_this_cpu */
 #include "internals.h"
+#ifdef CONFIG_X86
+#include <asm/apic.h>
+#endif
+
+#ifdef CONFIG_IRQ_REMAP
+extern bool enable_posted_msi;
+#else
+static bool enable_posted_msi;
+#endif
 
 /*
  * Platform-wide software interrupt moderation.
@@ -29,6 +38,10 @@
  *   moderation on that CPU/irq. If so, calls disable_irq_nosync() and starts
  *   an hrtimer with appropriate delay.
  *
+ * - Intel only: using "intremap=posted_msi", all the above is done in
+ *   sysvec_posted_msi_notification(). In this case all host device interrupts
+ *   are subject to moderation.
+ *
  * - the timer callback calls enable_irq() for all disabled interrupts on that
  *   CPU. That in turn will generate interrupts if there are pending events.
  *
@@ -82,6 +95,7 @@ struct irq_mod_info irq_mod_info ____cacheline_aligned = {
 	.delay_us = 100,
 	.update_ms = 1,
 	.scale_cpus = 100,
+	.count_msi_calls = true,
 	.count_timer_calls = true,
 	.decay_factor = 16,
 	.grow_factor = 8,
@@ -216,6 +230,17 @@ static enum hrtimer_restart moderation_timer_cb(struct hrtimer *timer)
 
 	ms->rounds_left--;
 
+#ifdef CONFIG_X86_POSTED_MSI
+	if (ms->kick_posted_msi) {
+		if (ms->rounds_left <= 0)
+			ms->kick_posted_msi = false;
+		/* Next call will be from timer, count it conditionally */
+		ms->irq_count -= !irq_mod_info.count_timer_calls;
+		ms->timer_calls++;
+		apic->send_IPI_self(POSTED_MSI_NOTIFICATION_VECTOR);
+	}
+#endif
+
 	if (ms->rounds_left > 0) {
 		/* Timer still alive. Just call the handlers */
 		list_for_each_entry_safe(desc, next, &ms->descs, ms_node) {
@@ -277,13 +302,6 @@ static void set_moderation_mode(struct irq_desc *desc, bool mode)
 	}
 }
 
-/* irq_to_desc is not exported. Wrap it in this function for a specific use. */
-void irq_moderation_set_mode(int irq, bool mode)
-{
-	set_moderation_mode(irq_to_desc(irq), mode);
-}
-EXPORT_SYMBOL(irq_moderation_set_mode);
-
 #pragma clang diagnostic error "-Wformat"
 /* Print statistics */
 static int moderation_show(struct seq_file *p, void *v)
@@ -325,7 +343,7 @@ static int moderation_show(struct seq_file *p, void *v)
 	}
 
 	seq_printf(p, "\n"
-		   "enabled              %s\n"
+		   "enabled              %s%s\n"
 		   "delay_us             %u\n"
 		   "target_irq_rate      %u\n"
 		   "hardirq_percent      %u\n"
@@ -333,13 +351,15 @@ static int moderation_show(struct seq_file *p, void *v)
 		   "update_ms            %u\n"
 		   "scale_cpus           %u\n"
 		   "count_timer_calls    %s\n"
+		   "count_msi_calls      %s\n"
 		   "decay_factor         %u\n"
 		   "grow_factor          %u\n",
-		   str_yes_no(delay_us),
+		   str_yes_no(delay_us), enable_posted_msi ? " (also on posted_msi)" : "",
 		   delay_us, irq_mod_info.target_irq_rate, irq_mod_info.hardirq_percent,
 		   irq_mod_info.timer_rounds, irq_mod_info.update_ms,
 		   irq_mod_info.scale_cpus,
 		   str_yes_no(irq_mod_info.count_timer_calls),
+		   str_yes_no(irq_mod_info.count_msi_calls),
 		   get_decay_factor(), get_grow_factor());
 
 	seq_printf(p,
@@ -375,6 +395,7 @@ struct var_names {
 	{ "timer_rounds", &irq_mod_info.timer_rounds, 0, 50 },
 	{ "update_ms", &irq_mod_info.update_ms, 1, 100 },
 	{ "count_timer_calls", &irq_mod_info.count_timer_calls, 0, 1 },
+	{ "count_msi_calls", &irq_mod_info.count_msi_calls, 0, 1 },
 	{}
 };
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


