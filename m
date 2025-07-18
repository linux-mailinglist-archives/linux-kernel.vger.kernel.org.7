Return-Path: <linux-kernel+bounces-737298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62DB0AA71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67440189D54E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6BF2E92AF;
	Fri, 18 Jul 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxUaad60";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdZnScR4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6502E8DE6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864852; cv=none; b=FW5vHmX/ABDQc9BgOwXaumaup7PiAJW6T/FU9wX1iCrCt8QhBZNENCB56g/JFJoK7kCI3rPVPjSsjT2lC0OiHPPGOC+fx9Fxae8eo/03obNBE6VmYUPox1yVmm/91tstGGizNV1igE0cbwgdDXHw8rNdIQU6aFWopzFTxgtA5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864852; c=relaxed/simple;
	bh=JkFlwcgj279Syc1L8u/Q6lujZojZqd9U5fxEhAXzlR8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nPdsvCDySozo9ZTJ1Lwued1lMCb1zShPnXE/CDg16tXR2N8Wu79mWTVhVWNB0HSDcECvzAosuN2+Gu7EDyF1U6THxEFgG0t4Zs7HFOrOcebrmMLszyrBloD8oaUfuM/hiNfokaHFUnGrjILumJtx7Dfj89o7Wxa3gGFssfc9GiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxUaad60; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdZnScR4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250718185311.948555026@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752864849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vTV7mchOKPGOAvrE1FkrHv3nOnwG2HV4Y7IDBFMVTO8=;
	b=PxUaad60nrUz2WBQu7IsG9xMMSw80JJLUbyW/xjjXoiwMR1LlXZLt6FWkFeoGFa4vSGvnk
	j+d/0QF2MUHKKrsD3capvGoDv9nvy7xyiJI0haBGMyYesn8V7nz8uDAXmO5Bbh8Yi6vMoY
	bV2TtbcB19Pp9SP0Ck+pBPJ3JLR9NJV+57VhyyNwu1PGXKrlZkhCVKZv/cHcFn2CPVRf82
	9CvqksrnknaPr4/H4prf8vcLVcXkF1YPn3pFkhnJEg+9uObtOHEvYB9X+QVoyoSN0En5fw
	/a6KrGO/QCEyd4MngKlVHGpPbw7+KpUsIFFGvPCi2bSd1LyHHjON7jZqVb1Gdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752864849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vTV7mchOKPGOAvrE1FkrHv3nOnwG2HV4Y7IDBFMVTO8=;
	b=rdZnScR49CTruDGp1GnyveLwXW+wYXh28GCJ1smCI0NvnQ0apJvJhZ0C40Grf3/8sFjBID
	fM7F5Vat3/3m6ODQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 2/4] genirq: Move irq_wait_for_poll() to call site
References: <20250718184935.232983339@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 20:54:08 +0200 (CEST)

Move it to the call site so that the waiting for the INPROGRESS flag can be
reused by an upcoming mitigation for a potential live lock in the edge type
handler.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c      |   29 +++++++++++++++++++++--------
 kernel/irq/internals.h |    2 +-
 kernel/irq/spurious.c  |   37 +------------------------------------
 3 files changed, 23 insertions(+), 45 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -449,11 +449,19 @@ void unmask_threaded_irq(struct irq_desc
 	unmask_irq(desc);
 }
 
-static bool irq_check_poll(struct irq_desc *desc)
+/* Busy wait until INPROGRESS is cleared */
+static bool irq_wait_on_inprogress(struct irq_desc *desc)
 {
-	if (!(desc->istate & IRQS_POLL_INPROGRESS))
-		return false;
-	return irq_wait_for_poll(desc);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		do {
+			raw_spin_unlock(&desc->lock);
+			while (irqd_irq_inprogress(&desc->irq_data))
+				cpu_relax();
+			raw_spin_lock(&desc->lock);
+		} while (irqd_irq_inprogress(&desc->irq_data));
+	}
+	/* Might have been disabled in meantime */
+	return !irqd_irq_disabled(&desc->irq_data) && desc->action;
 }
 
 static bool irq_can_handle_pm(struct irq_desc *desc)
@@ -473,10 +481,15 @@ static bool irq_can_handle_pm(struct irq
 	if (irq_pm_check_wakeup(desc))
 		return false;
 
-	/*
-	 * Handle a potential concurrent poll on a different core.
-	 */
-	return irq_check_poll(desc);
+	/* Check whether the interrupt is polled on another CPU */
+	if (unlikely(desc->istate & IRQS_POLL_INPROGRESS)) {
+		if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
+			      "irq poll in progress on cpu %d for irq %d\n",
+			      smp_processor_id(), desc->irq_data.irq))
+			return false;
+		return irq_wait_on_inprogress(desc);
+	}
+	return false;
 }
 
 static inline bool irq_can_handle_actions(struct irq_desc *desc)
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -20,6 +20,7 @@
 #define istate core_internal_state__do_not_mess_with_it
 
 extern bool noirqdebug;
+extern int irq_poll_cpu;
 
 extern struct irqaction chained_action;
 
@@ -112,7 +113,6 @@ irqreturn_t handle_irq_event(struct irq_
 int check_irq_resend(struct irq_desc *desc, bool inject);
 void clear_irq_resend(struct irq_desc *desc);
 void irq_resend_init(struct irq_desc *desc);
-bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
 void wake_threads_waitq(struct irq_desc *desc);
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -19,45 +19,10 @@ static int irqfixup __read_mostly;
 #define POLL_SPURIOUS_IRQ_INTERVAL (HZ/10)
 static void poll_spurious_irqs(struct timer_list *unused);
 static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
-static int irq_poll_cpu;
+int irq_poll_cpu;
 static atomic_t irq_poll_active;
 
 /*
- * We wait here for a poller to finish.
- *
- * If the poll runs on this CPU, then we yell loudly and return
- * false. That will leave the interrupt line disabled in the worst
- * case, but it should never happen.
- *
- * We wait until the poller is done and then recheck disabled and
- * action (about to be disabled). Only if it's still active, we return
- * true and let the handler run.
- */
-bool irq_wait_for_poll(struct irq_desc *desc)
-{
-	lockdep_assert_held(&desc->lock);
-
-	if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
-		      "irq poll in progress on cpu %d for irq %d\n",
-		      smp_processor_id(), desc->irq_data.irq))
-		return false;
-
-#ifdef CONFIG_SMP
-	do {
-		raw_spin_unlock(&desc->lock);
-		while (irqd_irq_inprogress(&desc->irq_data))
-			cpu_relax();
-		raw_spin_lock(&desc->lock);
-	} while (irqd_irq_inprogress(&desc->irq_data));
-	/* Might have been disabled in meantime */
-	return !irqd_irq_disabled(&desc->irq_data) && desc->action;
-#else
-	return false;
-#endif
-}
-
-
-/*
  * Recovery handler for misrouted interrupts.
  */
 static bool try_one_irq(struct irq_desc *desc, bool force)


