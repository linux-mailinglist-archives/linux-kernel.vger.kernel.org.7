Return-Path: <linux-kernel+bounces-737300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFFAB0AA72
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933A85C11FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37FB2E973C;
	Fri, 18 Jul 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cqYYLwk3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yIU+PHDe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DF2E92BE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864856; cv=none; b=m+yDe5zLmKPKM5vUq8NdHps7Q0Hz19t+cnh9cqigbBLb1Nw4dC9+76TqQ6i3Jzl4PIqGrFMl+nJCBjHfGFA6IqW9A/7He87TuBIgmoNgNcoY7Xe1OWle3RVv/7XoHDTPsv936EkmSDC18Qpz9NDpBsotbUqsKkQGbRObBByJOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864856; c=relaxed/simple;
	bh=JhaLq7EtVnvmLRiDgpWvSg/8I9R2kuRMq2Qr5Aa677U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=D+4LsKgUocpWbQVvyjCZ0WDiYyfBS/sjvM9hgL3C51lmB4W3OaWxhSGL4Vnhr2pcQ/ECZN3Cxb7TBPFHUgGot8CF68qNgQnphTuwPzyyPvVj4hHTRMJfWyDJNitHK4ZwLCPS3UeDgsQEEuudR5T0fR4LBahlJg24H9gnZUfEK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cqYYLwk3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yIU+PHDe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250718185312.076515034@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752864853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hYxI10KY8qBh1psNMaH8hIt4/i563oOZ80VHzpgsya8=;
	b=cqYYLwk3IDIfTlCEXQN7ROipNRBLd4NBdA80H4zb/QOHqgR4TA89yoTuqIDMUr6wyHqYFO
	VTV88p5kU0w9C4Iiv+Q5jiDG73qAT9QM69gZhOXMhfo72FesUi9Hjuw/zrvL+ruNaXZLyx
	PbFXu37NXpUpSt6EUy5Nx5K3v94lvKdytTJ/XnPxCA/kSlhgokH48/rPkgfyX9J1kBA347
	E7nxkWeiifZu7OqWNInTHPqlMzhGMOkyHeNDYI0f/qIfVfM10mmK0Yp5sOtVR4o483n8KU
	jddw2aajk6VHrWn3nvqaT94/P/hkGq80rXjM3ypIA582aM8eqqpUj2kJPsCdfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752864853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hYxI10KY8qBh1psNMaH8hIt4/i563oOZ80VHzpgsya8=;
	b=yIU+PHDehE+jHZrNzIJtaCvLvrMk7lOwsuWNWPbsoqwLqTgGlVkwuDmn+0iZxqwm3U28ga
	py7C+pLquXvE4vAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 4/4] genirq: Prevent migration live lock in handle_edge_irq()
References: <20250718184935.232983339@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 20:54:12 +0200 (CEST)

Yicon reported and Liangyan debugged a live lock in handle_edge_irq()
related to interrupt migration.

If the interrupt affinity is moved to a new target CPU and the interrupt is
currently handled on the previous target CPU for edge type interrupts the
handler might get stuck on the previous target:

CPU 0 (previous target)		CPU 1 (new target)

  handle_edge_irq()
   repeat:
	handle_event()		handle_edge_irq()
			        if (INPROGESS) {
				  set(PENDING);
				  mask();
				  return;
				}
	if (PENDING) {
	  clear(PENDING);
	  unmask();
	  goto repeat;
	}

The migration in software never completes and CPU0 continues to handle the
pending events forever. This happens when the device raises interrupts with
a high rate and always before handle_event() completes and before the CPU0
handler can clear INPROGRESS so that CPU1 sets the PENDING flag over and
over. This has been observed in virtual machines.

Prevent this by checking whether the CPU which observes the INPROGRESS flag
is the new affinity target. If that's the case, do not set the PENDING flag
and wait for the INPROGRESS flag to be cleared instead, so that the new
interrupt is handled on the new target CPU and the previous CPU is released
from the action.

This is restricted to the edge type handler and only utilized on systems,
which use single CPU targets for interrupt affinity.

Reported-by: Yicong Shen <shenyicong.1023@bytedance.com>
Reported-by: Liangyan <liangyan.peng@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701163558.2588435-1-liangyan.peng@bytedance.com
---
 kernel/irq/chip.c |   41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -466,11 +466,14 @@ static bool irq_wait_on_inprogress(struc
 
 static bool irq_can_handle_pm(struct irq_desc *desc)
 {
+	struct irq_data *irqd = &desc->irq_data;
+	const struct cpumask *aff;
+
 	/*
 	 * If the interrupt is not in progress and is not an armed
 	 * wakeup interrupt, proceed.
 	 */
-	if (!irqd_has_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
+	if (!irqd_has_set(irqd, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
 		return true;
 
 	/*
@@ -491,7 +494,41 @@ static bool irq_can_handle_pm(struct irq
 			return false;
 		return irq_wait_on_inprogress(desc);
 	}
-	return false;
+
+	/* The below works only for single target interrupts */
+	if (!IS_ENABLED(CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK) ||
+	    !irqd_is_single_target(irqd) || desc->handle_irq != handle_edge_irq)
+		return false;
+
+	/*
+	 * If the interrupt affinity was moved to this CPU and the
+	 * interrupt is currently handled on the previous target CPU, then
+	 * busy wait for INPROGRESS to be cleared. Otherwise for edge type
+	 * interrupts the handler might get stuck on the previous target:
+	 *
+	 * CPU 0			CPU 1 (new target)
+	 * handle_edge_irq()
+	 * repeat:
+	 *	handle_event()		handle_edge_irq()
+	 *			        if (INPROGESS) {
+	 *				  set(PENDING);
+	 *				  mask();
+	 *				  return;
+	 *				}
+	 *	if (PENDING) {
+	 *	  clear(PENDING);
+	 *	  unmask();
+	 *	  goto repeat;
+	 *	}
+	 *
+	 * This happens when the device raises interrupts with a high rate
+	 * and always before handle_event() completes and the CPU0 handler
+	 * can clear INPROGRESS. This has been observed in virtual machines.
+	 */
+	aff = irq_data_get_effective_affinity_mask(irqd);
+	if (cpumask_first(aff) != smp_processor_id())
+		return false;
+	return irq_wait_on_inprogress(desc);
 }
 
 static inline bool irq_can_handle_actions(struct irq_desc *desc)


