Return-Path: <linux-kernel+bounces-798791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8DB42305
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A1B3A2942
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F2730E859;
	Wed,  3 Sep 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D2CH0amq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W8dEcRC7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D11DEFE9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908291; cv=none; b=Yjourr3/0unCaNfgg60ScggGHKihtKjYv8rqILwQZNGm4DyehUsoo5zYieKTYCUQ7xemg+1mRhtPN/kfpUIv3wP14ehsPY5+4t5T07GVdzrnsAbgF61JnsII02ZJS6CmBHgT9kKq/4DjADrIhYCai1hxy0mFhHqheTgK2jhiHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908291; c=relaxed/simple;
	bh=c4jxF5VsWGE8/NaAHmTFJpAckQ+TbS1bG7M/90SDduA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=i0JTM/aRFe0AxYFyAOc4wkRzROV7G1r+a7m11n5/2WP82KlSl+oInX4LulULvYBnlKKS93XdvNaXuxGuDb2g3UagIxVid3XT2dNRAIU+nCD1wpiJMmj45F0riFljH+AugWTE4rHyWmQ0OSI6hn2ZWQbzO5jJoHlBq2Z2YvrcWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D2CH0amq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W8dEcRC7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250903135433.380783272@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756908287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=EGz2zaDvFdXeRQqyZacdGqCCxPU+HkhYjz1f6Tjk9Zw=;
	b=D2CH0amqrrIFspcFMiKihYVYafh06VAR3Mu0YLa4UBuXNXq9Sd4wyxh80PNXOLdrRQ1UEI
	2U6Bwx1mBJSqKedsi3fVR8ZWNlYAHzPzKddvRrKzHJ+4uvJFx+EEo8KVmpilZJMoVpcOhc
	iW5iKwFMSptIhFNinMQFnE4qBAmDkTge9RUhzUUrwfGdZ/dSlzj5xIpHMvGnJSQCgHBOEr
	R94nysbKn1Gz9HU7a0hAXyPXLoz/s29LcNugbii8s/kw8kF4zPLtWOvBZ0EfwX875eVJBG
	evaZKf9Fq5hlxBLYR5EsTWDY5+JlLLiAWJSmE5yzvArP7QF2Wng0103bSUNy6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756908287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=EGz2zaDvFdXeRQqyZacdGqCCxPU+HkhYjz1f6Tjk9Zw=;
	b=W8dEcRC7O+enCPD6meNEx9Iulvn0Y4mvwWxwEhj8rkA7A5vwnWgf58JZSIdyJUk/hotp7D
	DoA3pzWKPJ0tmrBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [patch 1/2] irqchip/msi-lib: Honor the MSI_FLAG_PCI_MSI_MASK_PARENT
 flag
References: <86o6vjelw2.wl-maz@kernel.org>
 <87ecv1ob9q.ffs@tglx>
 <20250903134437.863638669@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed,  3 Sep 2025 16:04:46 +0200 (CEST)

From: Marc Zyngier <maz@kernel.org>

For systems that implement interrupt masking at the interrupt controller
level, the MSI library offers MSI_FLAG_PCI_MSI_MASK_PARENT.  It indicates
that it isn't enough to only unmask the interrupt at the PCI device level,
but that the interrupt controller must also be involved.

However, the way this is currently done is less than optimal, as the
masking/unmasking is done on both sides, always. It would be far cheaper to
unmask both at the start of times, and then only deal with the interrupt
controller mask, which is cheaper than a round-trip to the PCI endpoint.

Now that the PCI/MSI layer implements irq_startup() and irq_shutdown()
callbacks, which [un]mask at the PCI level and honor the request to
[un]mask the parent, this can be trivially done.

Overwrite the irq_mask/unmask() callbacks of the device domain interrupt
chip with irq_[un]mask_parent() when the parent domain asks for it.

[ tglx: Adopted to the PCI/MSI changes ]

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-msi-lib.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -112,6 +112,20 @@ bool msi_lib_init_dev_msi_info(struct de
 	 */
 	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
 		chip->irq_set_affinity = msi_domain_set_affinity;
+
+	/*
+	 * If the parent domain insists on being in charge of masking, obey
+	 * blindly. The interrupt is un-masked at the PCI level on startup
+	 * and masked on shutdown to prevent rogue interrupts after the
+	 * driver freed the interrupt. Not masking it at the PCI level
+	 * speeds up operation for disable/enable_irq() as it avoids
+	 * getting all the way out to the PCI device.
+	 */
+	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
+		chip->irq_mask		= irq_chip_mask_parent;
+		chip->irq_unmask	= irq_chip_unmask_parent;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);


