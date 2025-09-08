Return-Path: <linux-kernel+bounces-805324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F43B48722
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C247ABEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D22F657F;
	Mon,  8 Sep 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnXTGIP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDF2F60D6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320076; cv=none; b=OBieDMfx/cQvcUK3q8ar5g5usKhQybMBn31BtlS131PsYlF1t78XDH7u9aOujjY9k3maoBbSSGN8Q1LZE7xbm8UHmSRcOCQVxMaY+gX14Z9OOEdwHTW/lzJrbGe2bbm3EvhMIG7RqLRzbPgECNfskQpeRWFPMEnzRsetnx+EWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320076; c=relaxed/simple;
	bh=CFvvTrfa1t92F7NxctUBMm3QJnsOF0WWxyPhVXxwhCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtV07iXgyqSTyjS5oaM+KsbS0pXCLFhiBgn56c1MFaPxEgcDgiUom2XNLGeP1FlkYvdvxs1UP5hOSjaolf71aSkKY29uRfp/CVI4wtits2ioEAn0iUOdSG1+wt9xsno65xd/R9ZT8nSZcLXtkVB1cK1vXx4esTA34Q/W9TTIlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnXTGIP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D98C4CEF5;
	Mon,  8 Sep 2025 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757320076;
	bh=CFvvTrfa1t92F7NxctUBMm3QJnsOF0WWxyPhVXxwhCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnXTGIP3pULjVEAepJ6qCrd3NuT65KHO7JLgPYCK6GiyxGGYrjnWF6Ox2dxar9Lca
	 i4z/sEg/UtTUZoC9gi488+kRJ3j8liXpyILqPJo69l08TFMSlcZFeVAkWB2lvIZkU6
	 tvLP5ljWIokQmgVfkhfcieOQg0Y0Mc7U/lAgAPOGskryGwdef+naU19kHGFnLf3nFd
	 9W8SIQ26Fa9FeabH022g5Nyq5oftskXyMo4qzCjMfZ2mBIB4B1pHkcagYiAzZIpee2
	 T/cG27wqP1z/4003cPjWGsyJ9Baw3KXaKsFLBAgVdChIdU8B3pOpV9LG+fyaEHtrs2
	 xJe+nThBVRFYg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 RESEND 3/3] irqchip/gic-v5: Fix error handling in gicv5_its_irq_domain_alloc()
Date: Mon,  8 Sep 2025 10:27:45 +0200
Message-ID: <20250908082745.113718-4-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250908082745.113718-1-lpieralisi@kernel.org>
References: <20250908082745.113718-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

Code in gicv5_its_irq_domain_alloc() has two issues:

- it checks the wrong return value/variable when calling gicv5_alloc_lpi()
- The cleanup code does not take previous loop iterations into account

Fix both issues at once by adding the right gicv5_alloc_lpi() variable
check and by reworking the function cleanup code to take into account
current and previous iterations.

[lpieralisi: reworded commit log]

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-its.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 4701ef62b8b2..2fb58d76f521 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -949,15 +949,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 	device_id = its_dev->device_id;
 
 	for (i = 0; i < nr_irqs; i++) {
-		lpi = gicv5_alloc_lpi();
+		ret = gicv5_alloc_lpi();
 		if (ret < 0) {
 			pr_debug("Failed to find free LPI!\n");
-			goto out_eventid;
+			goto out_free_irqs;
 		}
+		lpi = ret;
 
 		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
-		if (ret)
-			goto out_free_lpi;
+		if (ret) {
+			gicv5_free_lpi(lpi);
+			goto out_free_irqs;
+		}
 
 		/*
 		 * Store eventid and deviceid into the hwirq for later use.
@@ -977,8 +980,13 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 
 	return 0;
 
-out_free_lpi:
-	gicv5_free_lpi(lpi);
+out_free_irqs:
+	while (--i >= 0) {
+		irqd = irq_domain_get_irq_data(domain, virq + i);
+		gicv5_free_lpi(irqd->parent_data->hwirq);
+		irq_domain_reset_irq_data(irqd);
+		irq_domain_free_irqs_parent(domain, virq + i, 1);
+	}
 out_eventid:
 	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
 	return ret;
-- 
2.48.0


