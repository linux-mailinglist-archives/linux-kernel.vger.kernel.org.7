Return-Path: <linux-kernel+bounces-792084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69797B3C001
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7773A8C72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9C346A1B;
	Fri, 29 Aug 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es0FMyW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA7346A17
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482589; cv=none; b=GlymJ7eMj+ocISySJfLjgzX5FOWoLR81/VVYyQ4o75IXRuV/WKcgWMwVI9AZtoi/+3G+W9kC3bPMe2dLAeh4DyeGnyjf5qhqsRBIkUh22HmFh15tGT46UyoB0xXX7T1BHjUSXo0wYReeIVPFLR/a/pUyvMizE3zDQar/U9+Jc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482589; c=relaxed/simple;
	bh=chMAaHPdvZjXfYZQTfmqroMaCahKvWi7hxvycGkBc0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9YZ4hYhd2qIC27TBmS2FKV4cxmxH7KqsfcTQtSV3Qbl2owvd0fSCQ5nI/rGmBVSuvWiyVMnI/u/YlqYSonAgPcWax0uGdTr7a4TkpcsOrqei1gRiRdVgnJSPXfkWk6TyRtdsdpLqSDG9enMFJPqXmMS/0HJ9yJfAuodfdfxmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es0FMyW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DDBC4CEF0;
	Fri, 29 Aug 2025 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482588;
	bh=chMAaHPdvZjXfYZQTfmqroMaCahKvWi7hxvycGkBc0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=es0FMyW1SaqVKkgezlAZUhevVLjYaqYFRexaNvJcGe+5ANF//BXhMnqwba1S7xffE
	 Ds6tnsQta6Bqz1F39kztfqbU1kdVjQPnaSVAGTneqthxva9slurGG+63EdbqHMSwDA
	 nEM/aTvaaz+NNKYGx2KE1l/mzecJQNJa+eBsoyfwOLn64InXzi8YDQvRKgwiCirvZW
	 SnI600a6tyIG+pCffJvrESqXiAnw5mtZwW5NwK4Qjfs3ZeJSqQdxP7jAGHJLKBdau4
	 7LVZnKjDhLEsdKeZ7+RkcdudrBImSiZaEGro9s/DF5pZbfWw1LlQ7GMKGE8yA74Jmr
	 mH0a24lK4gqlA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 32/33] genirq: Correctly handle preferred kthreads affinity
Date: Fri, 29 Aug 2025 17:48:13 +0200
Message-ID: <20250829154814.47015-33-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[CHECKME: Do some IRQ threads have strong affinity requirements? In
which case they should use kthread_bind()...]

The affinity of IRQ threads is applied through a direct call to the
scheduler. As a result this affinity may not be carried correctly across
hotplug events, cpuset isolated partitions updates, or against
housekeeping constraints.

For example a simple creation of cpuset isolated partition will
overwrite all IRQ threads affinity to the non isolated cpusets.

To prevent from that, use the appropriate kthread affinity APIs that
takes care of the preferred affinity during these kinds of events.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/irq/manage.c | 47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c94837382037..d96f6675c888 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -176,15 +176,15 @@ bool irq_can_set_affinity_usr(unsigned int irq)
 }
 
 /**
- * irq_set_thread_affinity - Notify irq threads to adjust affinity
+ * irq_thread_notify_affinity - Notify irq threads to adjust affinity
  * @desc:	irq descriptor which has affinity changed
  *
  * Just set IRQTF_AFFINITY and delegate the affinity setting to the
- * interrupt thread itself. We can not call set_cpus_allowed_ptr() here as
- * we hold desc->lock and this code can be called from hard interrupt
+ * interrupt thread itself. We can not call kthread_affine_preferred_update()
+ * here as we hold desc->lock and this code can be called from hard interrupt
  * context.
  */
-static void irq_set_thread_affinity(struct irq_desc *desc)
+static void irq_thread_notify_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
 
@@ -283,7 +283,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 		fallthrough;
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
-		irq_set_thread_affinity(desc);
+		irq_thread_notify_affinity(desc);
 		ret = 0;
 	}
 
@@ -1032,11 +1032,26 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
 	}
 
 	if (valid)
-		set_cpus_allowed_ptr(current, mask);
+		kthread_affine_preferred_update(current, mask);
 	free_cpumask_var(mask);
 }
+
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc)
+{
+	const struct cpumask *mask;
+
+	if (cpumask_available(desc->irq_common_data.affinity))
+		mask = irq_data_get_effective_affinity_mask(&desc->irq_data);
+	else
+		mask = cpu_possible_mask;
+
+	kthread_affine_preferred(t, mask);
+}
 #else
 static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc) { }
 #endif
 
 static int irq_wait_for_interrupt(struct irq_desc *desc,
@@ -1384,7 +1399,8 @@ static void irq_nmi_teardown(struct irq_desc *desc)
 }
 
 static int
-setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
+setup_irq_thread(struct irqaction *new, struct irq_desc *desc,
+		 unsigned int irq, bool secondary)
 {
 	struct task_struct *t;
 
@@ -1405,16 +1421,9 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	 * references an already freed task_struct.
 	 */
 	new->thread = get_task_struct(t);
-	/*
-	 * Tell the thread to set its affinity. This is
-	 * important for shared interrupt handlers as we do
-	 * not invoke setup_affinity() for the secondary
-	 * handlers as everything is already set up. Even for
-	 * interrupts marked with IRQF_NO_BALANCE this is
-	 * correct as we want the thread to move to the cpu(s)
-	 * on which the requesting code placed the interrupt.
-	 */
-	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+
+	irq_thread_set_affinity(t, desc);
+
 	return 0;
 }
 
@@ -1486,11 +1495,11 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
-		ret = setup_irq_thread(new, irq, false);
+		ret = setup_irq_thread(new, desc, irq, false);
 		if (ret)
 			goto out_mput;
 		if (new->secondary) {
-			ret = setup_irq_thread(new->secondary, irq, true);
+			ret = setup_irq_thread(new->secondary, desc, irq, true);
 			if (ret)
 				goto out_thread;
 		}
-- 
2.51.0


