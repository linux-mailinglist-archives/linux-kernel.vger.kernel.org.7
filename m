Return-Path: <linux-kernel+bounces-769342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB55EB26D31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC08A1C86599
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4560212D83;
	Thu, 14 Aug 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LvsqxMXM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xN0u8NfG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70732144C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190795; cv=none; b=BQRftMowL3/61WICcdymeqVQ9l3UpPRYlTPCQB50TEWm3Hg9Pi2Gk1UK7GJqkSlGmDAodGhvCkVwy/UO/vqt3MCDRBfz226P2MrY6EGeLFbmx5qS2Ydx2wZ8PFaOFVQX27SEBRggR9HwCyMC2r3I2Gr9PlCup/H+RVpLRlAfuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190795; c=relaxed/simple;
	bh=aYxn012GZa+sNus+9OaWyvgfbMxPSJC45jdnCAh+dkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M23uZRHRj8MoEvWPjKNcS9FlyUmSqySk1KeZ5OTgvj2yXeUihksyLR+1RhkHlVNNFqBGaW62uJmx3v+6jrXqeTohf3MreRE84PFTelRo9DnQofwawrA8WAtjapeG83u56XODRd2zVYvwKn5TOLQOmhVCh6EFQ7Z/QPDISKm/GvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LvsqxMXM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xN0u8NfG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Aug 2025 18:59:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755190791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fYuxLuZBWcamM/4PXxfGNSKBOfauVKFowwp2lZ9QWb0=;
	b=LvsqxMXMKMAO9z5ijJGZxirLQv0Pv+k2QTL9QG1olWocfnwm9rwNPMmapW+gWu1wufqEWy
	BLcheYPb74/NFFvj/TovnPLL1OPupWdtOei1UZQUixLFihQwK4BWA2u2CORgW+jATJj5EL
	/vd2COueQs0qCQi0EgV7S70FoRCKI8KsXd2yI49Fe62yt7/2Dmx+3s48UmeKw33YCn9osO
	0De5z7YnLsmUC1j4PNTyEHRgP5QQKAXOlVz1UX6H/HF/P7jY/ONucmsoXIWbMUr2/H63ub
	psJj2Vk2D54XreBg/M7i/TPNZCyMjOnPUnqh0a9vvjIkYOx/r9p56gS5irPpAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755190791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fYuxLuZBWcamM/4PXxfGNSKBOfauVKFowwp2lZ9QWb0=;
	b=xN0u8NfGy5xsbcku3LwniacOqrxcxF7MWqkNjay8iM5PCDWAMrCdpmrVQnfTynI1gFNX4/
	A+lR2jzlxXqB6wCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] genirq: Remove GENERIC_IRQ_LEGACY
Message-ID: <20250814165949.hvtP03r4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

IA64 is gone and withit the last GENERIC_IRQ_LEGACY user.

Remove GENERIC_IRQ_LEGACY.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irq.h  | 4 ----
 kernel/irq/Kconfig   | 4 ----
 kernel/irq/irqdesc.c | 7 -------
 3 files changed, 15 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1d6b606a81efe..c9bcdbf6bc635 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -976,10 +976,6 @@ static inline void irq_free_desc(unsigned int irq)
 	irq_free_descs(irq, 1);
 }
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY
-void irq_init_desc(unsigned int irq);
-#endif
-
 /**
  * struct irq_chip_regs - register offsets for struct irq_gci
  * @enable:	Enable register offset to reg_base
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1da5e9d9da719..36673640c4fc2 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -6,10 +6,6 @@ menu "IRQ subsystem"
 config MAY_HAVE_SPARSE_IRQ
        bool
 
-# Legacy support, required for itanic
-config GENERIC_IRQ_LEGACY
-       bool
-
 # Enable the generic irq autoprobe mechanism
 config GENERIC_IRQ_PROBE
 	bool
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b64c57b44c203..db714d3014b5f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -653,13 +653,6 @@ void irq_mark_irq(unsigned int irq)
 	irq_insert_desc(irq, irq_desc + irq);
 }
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY
-void irq_init_desc(unsigned int irq)
-{
-	free_desc(irq);
-}
-#endif
-
 #endif /* !CONFIG_SPARSE_IRQ */
 
 int handle_irq_desc(struct irq_desc *desc)
-- 
2.50.1


