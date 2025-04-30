Return-Path: <linux-kernel+bounces-627964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11386AA5770
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 23:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB9F1C04B11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BD266571;
	Wed, 30 Apr 2025 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wu9JSOck";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUqjExE/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF6B644;
	Wed, 30 Apr 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048750; cv=none; b=kxosFpkC25cppDJE+7mXP5op5vH5sbKB6MzYzMUyy5RKkJbvK+TcmBROcgX/K0HPIGBmjh6ZuSDusEV16WzWlLxR221mPJcCZG083BGwiGVTHuhF2B4YVtqRp46sjO/fSdcr28vFCfrcus1F0y3a3miW59T3+CcX+UMWF3xr7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048750; c=relaxed/simple;
	bh=GOcU6ETcW7W9kdfdXnnlFyD1O9af5HKFC4ilydOZQHU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FqZXYwAScxygo2TUShY9DAx8EFWiChNEQYTXlRAK4FDzJbr3wyJ2EtN3bWucxvIV+1SynwkcxCRnyQfAsBaMzaTPkRcmLDxzJtCVomkfxNtwUjGPb+GfVqsbrP7kQOZmMj5V/RgxB1uRO4DUafE5l4KwQR9OWDSkkjf2JKCqkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wu9JSOck; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uUqjExE/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 21:32:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746048746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsyaJqhz8MATwW/VM/D7cQ4BbkQFxnchiBO3ELc8uh0=;
	b=Wu9JSOck37N07ExgzummA/oudlB/4IIi5WK0mQoMZ58i79NV2kRzeJH7dmalgH0uJHIuC7
	cCTIvG+wSy/5f1wK0iH4aMk1mRGJt5Bcpjf4weeCgAzmk0DhixdD8HHgkatM+iBAUlOBSe
	HFvQGcxFZ2wmKB0rnIkm92ChjE79CLTxzGsLm8sM1S4V7gBCDmOGTp4aTAYI4eUSyuJ+b9
	r+VKyJbHl4ndmJoPp7+Bdw+cUmbYZCj5Qsu5v+gqW55Fox2D0wd6tZsNmh6j7z5BoxLvuq
	2iRDc5SWufNWkVZNLFljO2ziQ2erWITvBDg+48WXQ1Wg5tpnnrjGM7H/HztcZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746048746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsyaJqhz8MATwW/VM/D7cQ4BbkQFxnchiBO3ELc8uh0=;
	b=uUqjExE/yY8I5DK9lqcT8D0+QMWk2ucmL5fm9ArtfMy3L3Azd2vTNESu0Op7ggAd/yRJOM
	HoSGEZotonBavtCw==
From: "tip-bot2 for Andrew Jones" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/msi: Prevent NULL pointer dereference in
 msi_domain_debug_show()
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250430124836.49964-2-ajones@ventanamicro.com>
References: <20250430124836.49964-2-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174604874066.22196.10092979947113967682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e6a3fc4f10b872d02e25f83227e725c79b25d893
Gitweb:        https://git.kernel.org/tip/e6a3fc4f10b872d02e25f83227e725c79b25d893
Author:        Andrew Jones <ajones@ventanamicro.com>
AuthorDate:    Wed, 30 Apr 2025 14:48:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Apr 2025 23:25:10 +02:00

genirq/msi: Prevent NULL pointer dereference in msi_domain_debug_show()

irq_domain_debug_show_one() calls msi_domain_debug_show() with a non-NULL
domain pointer and a NULL irq_data pointer. irq_debug_show_data() calls it
with a NULL domain pointer.

The domain pointer is not used, but the irq_data pointer is required to be
non-NULL and lacks a NULL pointer check.

Add the missing NULL pointer check to ensure there is a non-NULL irq_data
pointer in msi_domain_debug_show() before dereferencing it.

[ tglx: Massaged change log ]

Fixes: 01499ae673dc ("genirq/msi: Expose MSI message data in debugfs")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250430124836.49964-2-ajones@ventanamicro.com
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5c8d43c..c05ba7c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -761,7 +761,7 @@ static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fw
 static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
 				  struct irq_data *irqd, int ind)
 {
-	struct msi_desc *desc = irq_data_get_msi_desc(irqd);
+	struct msi_desc *desc = irqd ? irq_data_get_msi_desc(irqd) : NULL;
 
 	if (!desc)
 		return;

