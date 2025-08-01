Return-Path: <linux-kernel+bounces-753024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA3B17DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E9B3ABA73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69020B80B;
	Fri,  1 Aug 2025 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rESSvXDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BA20D50B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035123; cv=none; b=tBk77M5M9sy3TP15jj1Bn2avTOA2v4u7Fjf4jFURibhvv0Sx/+cjZXJCOavySMsBmk9y32WIOSCK4rN7DLAOJIvYjyQy78uDnNZvY3m6wxY9GTmaOU032nc8GNrlQoCqkESj+8G4/xk7n+VHmJD2AKrN9tpKC6g1en+xHx6CF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035123; c=relaxed/simple;
	bh=wj4wIimu8my3nvS/NdBRWWVLNhEdyKlGDNwK361o5cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkzcnBhqM/UxVd/tHLVo9PPZYOlEn/kktGaIA5sRdIuvDKWdBMyvhz/VfidIBmm72o12XtRykZgPpfYoBE49YRQPwWB3Ar3okAZ8f66UliyyWPAjJSoim9KA60b+ild66Xcr+84x3/+TPFhN7KxWQZkDNUIsFWsfCLE1RDlM/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rESSvXDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F932C4CEF4;
	Fri,  1 Aug 2025 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754035123;
	bh=wj4wIimu8my3nvS/NdBRWWVLNhEdyKlGDNwK361o5cI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rESSvXDGfupNL+DW0eP5kfOtG5I5dvZBKkkS0ZxgE8E2z9NjLzetZJAid455k/4m+
	 wa8lenlMc85aRH662p2KgkrBZimlXuyXwiJYm5fz1uQBWMbDXqjqC98gNFrl/ElXrf
	 3f2JuM3YguBiNBMt4KzzNDcnkMmzSNhIeMHdbaC1lnFGxBTSLcEFYLT2E3EUaPjvMR
	 8QI/l/ARbYBbJ072Z3iLdhA9T375krp24E2DjjZOJKcUi+4tY/OP+D7Q0l2FhCWn+F
	 yyVjmW5lq/DOITE57M5HiD7DIfmvhe8yKbJuXCJLAPOSY/t7I8Ve2zG4vUxELIge/P
	 AiyWDVZwJouCQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 01 Aug 2025 09:58:18 +0200
Subject: [PATCH 1/3] irqchip/gic-v5: iwb: Fix iounmap probe failure path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-gic-v5-fixes-6-17-v1-1-4fcedaccf9e6@kernel.org>
References: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
In-Reply-To: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Timothy Hayes <timothy.hayes@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15-dev-6f78e

Kbot reported that on the failure path the driver
iounmap() IWB resources that are managed through
devm_ioremap(), which is clearly wrong because
the driver would end up unmapping the MMIO
resource twice on probing failure.

Fix this by removing the error path altogether
and by letting devres manage the iounmapping
on clean-up.

Fixes: 695949d8b16f ("irqchip/gic-v5: Add GICv5 IWB support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508010038.N3r4ZmII-lkp@intel.com
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-iwb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
index ed72fbdd4900..ad9fdc14d1c6 100644
--- a/drivers/irqchip/irq-gic-v5-iwb.c
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -241,7 +241,6 @@ static int gicv5_iwb_device_probe(struct platform_device *pdev)
 	struct gicv5_iwb_chip_data *iwb_node;
 	void __iomem *iwb_base;
 	struct resource *res;
-	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -254,16 +253,10 @@ static int gicv5_iwb_device_probe(struct platform_device *pdev)
 	}
 
 	iwb_node = gicv5_iwb_init_bases(iwb_base, pdev);
-	if (IS_ERR(iwb_node)) {
-		ret = PTR_ERR(iwb_node);
-		goto out_unmap;
-	}
+	if (IS_ERR(iwb_node))
+		return PTR_ERR(iwb_node);
 
 	return 0;
-
-out_unmap:
-	iounmap(iwb_base);
-	return ret;
 }
 
 static const struct of_device_id gicv5_iwb_of_match[] = {

-- 
2.48.0


