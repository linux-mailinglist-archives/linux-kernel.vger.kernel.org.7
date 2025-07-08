Return-Path: <linux-kernel+bounces-722180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB45AFD650
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5754481989
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AB2E7173;
	Tue,  8 Jul 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fPsDD3L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dCpwlruk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48552882A2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998826; cv=none; b=lvcZwohIct2dCzsgoTnxxyRxdrLVe0cjNu6ukfS1LYttasQ3aHFE0Cpd+gE7OME5NRb8TVlKGqmd2HrVg5Nx1gSNKqWOMgTOY4ZA43xE1CDRrjgU8sUUtq8PGX4nbtXlkwzJhBKx8j1TOJnntFSkWAsaz+tBjqOjqU0tfP03sKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998826; c=relaxed/simple;
	bh=WdKMm9IjzlwvSCwjQCfLuXtxih3VqABNxzTe9GyiOnU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gxwDJWW1irX0xnCUTwNXJ63rZTYRevhow+1cKivOGZ5cIf9AxuUt2cawL8/Z4qQwciUZK5MMDAfKSIh4CAP3cecvSw/3w+gn7BOegI0pVwrbd6enn0quuPauoUZQKdRP8R++TCXZLK+FQWse8wjEDiVte8DfLk6YVpVqtj3rWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fPsDD3L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dCpwlruk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Np8bBsw6Lm3NLFYjMKSOvAf2is/UK90GPWVRCr/3kbc=;
	b=0fPsDD3LDvrHR7Zrkcr6d44hv2N8yfXkhDhgt4FNHozx2TEjek0kqaRHMXq6/0qD/93tI5
	zjr+4cyTHtMXANrCAR0cbo9Kb1vXfYaj8VUxOtEWn/wlwXqNElvuF+yK8LaMoo1+lbL5Za
	VsbGanVQOOJeMRWwXbejSGN2M9pBQ3wkw0qv96nRuQD72e58dlC+0SSUmg1Nzgvkgoz2YZ
	XKlNgoAh9tUPqi/dGPWaP/RlTdzjO+DHl5f4UW1n6lO4nmKAHvAISa3IDo8EfjSvA80+79
	8BRgLXYHqYxf/H9jMO+6ueI+X1uZH98XOAR/cYzo6uwtgacMJ7rqRkPFvLDX6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Np8bBsw6Lm3NLFYjMKSOvAf2is/UK90GPWVRCr/3kbc=;
	b=dCpwlruk29bSzmbNXNX+fqt02g7fBXsMRyr/6zQqzGRYzpUqb2AB8Bo1YZSjwnjHVEZgUF
	OFsvhVmUXq7SC/Bw==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/msi-lib: Add
 IRQ_DOMAIN_FLAG_FWNODE_PARENT handling
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20250703-gicv5-host-v7-27-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-27-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199882197.406.260316084878228381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     8b65db1e93a227ad9cc1b67cb221b06869f0b35f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8b65db1e93a227ad9cc1b67cb221b06869f0b35f
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:17 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:52 +01:00

irqchip/msi-lib: Add IRQ_DOMAIN_FLAG_FWNODE_PARENT handling

In some irqchip implementations the fwnode representing the IRQdomain
and the MSI controller fwnode do not match; in particular the IRQdomain
fwnode is the MSI controller fwnode parent.

To support selecting such IRQ domains, add a flag in core IRQ domain
code that explicitly tells the MSI lib to use the parent fwnode while
carrying out IRQ domain selection.

Update the msi-lib select callback with the resulting logic.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-27-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-msi-lib.c | 5 ++++-
 include/linux/irqdomain.h     | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 246c302..454c7f1 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -133,11 +133,14 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 {
 	const struct msi_parent_ops *ops = d->msi_parent_ops;
 	u32 busmask = BIT(bus_token);
+	struct fwnode_handle *fwh;
 
 	if (!ops)
 		return 0;
 
-	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
+	fwh = d->flags & IRQ_DOMAIN_FLAG_FWNODE_PARENT ? fwnode_get_parent(fwspec->fwnode)
+						       : fwspec->fwnode;
+	if (fwh != d->fwnode || fwspec->param_count != 0)
 		return 0;
 
 	/* Handle pure domain searches */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 7387d18..25c7cbe 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -212,6 +212,9 @@ enum {
 	/* Address and data pair is mutable when irq_set_affinity() */
 	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
 
+	/* IRQ domain requires parent fwnode matching */
+	IRQ_DOMAIN_FLAG_FWNODE_PARENT	= (1 << 12),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the

