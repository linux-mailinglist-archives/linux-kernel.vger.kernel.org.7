Return-Path: <linux-kernel+bounces-737297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB6B0AA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70F75C0E58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13352E88BD;
	Fri, 18 Jul 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19PzVTwK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kgaDAbJ0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAE1DE2C9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864850; cv=none; b=TzNI0oR9MQx4hiGnNWJ2jKF5VHGN2W0hab2oJ0Hs92nEOObQeggCdLWpWIt2BPCgyg091CAjWtV+EZ3GmLPMz/vYZnCwUnhqof8iwxLrb5a+yAPqKB3Ounj6XoB78O8USlwoYLaoBufQ5W4BQJS4nRHdJRRVKcUnV5eVxT7n7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864850; c=relaxed/simple;
	bh=P567dXRg/KvLhRUo8mwesE1SeWcW+KTYDp7PzEbqHB8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lELF06lOYUO88bsQ3p7ID5ZAYZzjfml6ti5qMZ8DNwNwvTpuZzKSsdaMbmLtk9G+Q0yNTiQQT3Hj7QZCQ6Bzhhut1DR03Vdfzo0Ede6UQ5KZVCqRHlCNZX6Y2OgmN6Q6Ehsl1BL3HsmcF/TJU01/QVl0W6RlOaMmXm/0xZNX+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=19PzVTwK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kgaDAbJ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250718185311.884314473@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752864847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4dZC4L57CDX8HABgPtgp5Q7NV2PV+BaAUb3Jv/YjGBI=;
	b=19PzVTwKfTc1HCU7ASgUsFGhOKfrqAYZKPa79LO5dj5reCBdcPhySBMsD7Ur7pr3lT96Hz
	eV+lo/d99SQVp3ItEJ5KQZO1Uuxq27pJ5TaD6OVsseasgxZZTzAU+2c8IkZpENFL+j1/c+
	9o+50vievgUA08vjS0mPdgcE8Nf96e2vCjcyx/prDw5WbF0VQZ/9FWn6/qp2MZVXCVGfOV
	GhD3m+CAQMxD+vZrRNATjFnGYGr0m0MCaGM/9bIU6FDT9yqfXyKn+QfozOAOqxRMK/rQ4e
	UdH0ncaW9p6z/cuSlRKrbHdHypNHKVDdecFOqVfa+m0PgsqpSaI9mH1HwtT0HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752864847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4dZC4L57CDX8HABgPtgp5Q7NV2PV+BaAUb3Jv/YjGBI=;
	b=kgaDAbJ0keEZs71r28Go7V5G03uUSwnwSY+UyaA16DlxNG4MshUruEu9+Y7nt4zPd7DSml
	e7lSwLTwJnktHLAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 1/4] genirq: Remove pointless local variable
References: <20250718184935.232983339@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 20:54:06 +0200 (CEST)

The variable is only used at one place, which can simply take the constant
as function argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -458,13 +458,11 @@ static bool irq_check_poll(struct irq_de
 
 static bool irq_can_handle_pm(struct irq_desc *desc)
 {
-	unsigned int mask = IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
-
 	/*
 	 * If the interrupt is not in progress and is not an armed
 	 * wakeup interrupt, proceed.
 	 */
-	if (!irqd_has_set(&desc->irq_data, mask))
+	if (!irqd_has_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
 		return true;
 
 	/*


