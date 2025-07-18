Return-Path: <linux-kernel+bounces-737299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDECBB0AA70
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30E45C101A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC42E92D5;
	Fri, 18 Jul 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l9z3Lp+T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1njCx6D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A902E8E18
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864855; cv=none; b=im8piSIvqShXzf+qBISskIBglCaU70H9IhSaS9j26yJw9YfkVAI692+VG2t6/Bfzk/+R+y0RYbZZsyU6d2AoSPoiTeSM7nxyIwPXoCKnWkb3wWY0wEtURRZXnNcNny5K8fAbzKKWbv2gu6hJackmvDcheuQbKPzlzUdAQTsxQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864855; c=relaxed/simple;
	bh=2fKUlqcKzOMteLiS9jM/alObVnn4pd9v6yZCJlV7+eE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=O+ItsNRZD1SlBkCBV06ld+Lc++wjhVrlmyWAqwVd0J8yRSj579GiJXHwWEo62Atsv5YfWk/PnVfaMOJGBdwxbuXGmL1mj3isbHXfr5jBtFbhiZbkPr7fyygqQNyNzXnUqBACVBWs7C8kkOnoHZ4n8aYhF8Ov0UBfPOxmOGBFrC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l9z3Lp+T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1njCx6D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250718185312.012392426@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752864851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=62YA7+LLFBCjUV35wEq9c6t9DDEhYaWuSwUN6QyYWC0=;
	b=l9z3Lp+TYFOp7Ew3Wx0/KKUSTOxH9RYU+Esr/yOS1MrPYxDMGDGPe0Mii5JQSVRjZ/tXwB
	Thxq/lnig0fo0Vuws855gn7GCvh7GWeGilgeuPwvxfqJ/iy92jxhbDBOQsPDYk/9l8evH2
	FYyHtur04JWYUhuCHj9qyAXfq49qg/1GlL6Toj5OgOqf+TyPcnilZEXXmeugW/c9377QIe
	O9bDi/0WjvsSZ0UETt3M9g8IMksUgyWeSs04JbV6Dv3V52VcXTbYZAtVLyRud8BfwT9til
	BoRKLKT7j7UwV38XhiPaYRLPlCZWhXUbh9zk1++31BKKdpaRKaNjX1O3InMu3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752864851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=62YA7+LLFBCjUV35wEq9c6t9DDEhYaWuSwUN6QyYWC0=;
	b=L1njCx6DLQvlCU+G/Eh3ktOAzca8GuAOzpmrqq58fVtiUbIZ3m7hmRTOVXI0gNerRoxXiD
	hMAnQ3xUcLyiz8Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 3/4] genirq: Split up irq_pm_check_wakeup()
References: <20250718184935.232983339@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 20:54:10 +0200 (CEST)

Let the calling code check for the IRQD_WAKEUP_ARMED flag to prepare for a
live lock mitigation in the edge type handler.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c      |    4 +++-
 kernel/irq/internals.h |    4 ++--
 kernel/irq/pm.c        |   16 ++++++----------
 3 files changed, 11 insertions(+), 13 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -478,8 +478,10 @@ static bool irq_can_handle_pm(struct irq
 	 * and suspended, disable it and notify the pm core about the
 	 * event.
 	 */
-	if (irq_pm_check_wakeup(desc))
+	if (unlikely(irqd_has_set(irqd, IRQD_WAKEUP_ARMED))) {
+		irq_pm_handle_wakeup(desc);
 		return false;
+	}
 
 	/* Check whether the interrupt is polled on another CPU */
 	if (unlikely(desc->istate & IRQS_POLL_INPROGRESS)) {
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -277,11 +277,11 @@ static inline bool irq_is_nmi(struct irq
 }
 
 #ifdef CONFIG_PM_SLEEP
-bool irq_pm_check_wakeup(struct irq_desc *desc);
+void irq_pm_handle_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
 void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action);
 #else
-static inline bool irq_pm_check_wakeup(struct irq_desc *desc) { return false; }
+static inline void irq_pm_handle_wakeup(struct irq_desc *desc) { }
 static inline void
 irq_pm_install_action(struct irq_desc *desc, struct irqaction *action) { }
 static inline void
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -13,17 +13,13 @@
 
 #include "internals.h"
 
-bool irq_pm_check_wakeup(struct irq_desc *desc)
+void irq_pm_handle_wakeup(struct irq_desc *desc)
 {
-	if (irqd_is_wakeup_armed(&desc->irq_data)) {
-		irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
-		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
-		desc->depth++;
-		irq_disable(desc);
-		pm_system_irq_wakeup(irq_desc_get_irq(desc));
-		return true;
-	}
-	return false;
+	irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
+	desc->depth++;
+	irq_disable(desc);
+	pm_system_irq_wakeup(irq_desc_get_irq(desc));
 }
 
 /*


