Return-Path: <linux-kernel+bounces-767546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867FDB255CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C04882BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943D3009E9;
	Wed, 13 Aug 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U1HO0dmy"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCF3009D9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121350; cv=none; b=mrZyw89ma1bcS65c6xc+Drl9wQPaESKRcBY1KENgyjkjxhr+cRE33hNx78MpoW1fzpZNwcrrxujg8FfV5l/jA56AmoBBkYgwwvzyTyRb2/rDLOgzW3J8IPAZf2KT8W/59VVF5uCogw1EGGzcpdjll8OjsdqAhkZIJe/3bzCyX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121350; c=relaxed/simple;
	bh=kyXSBWiFdYPFqweaGhIbkdYM031irDeSYqCA6GS2Dc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruzV74PfIJJvo2ydHkSrPgdUXMLR88g2pbgKlUIPqX56Z/w7QjVK5TYcLrIDr0s0S8Vh6eBUvBl9nSbag0Ull/dtEGvSMamK930wYCO5DxhDhFUDXN2Ko/JZBaxn0D8h3h1VmWC8vcFHjBCWoq3TrXLhW1Pajg1GMPp2WTHTJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U1HO0dmy; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLffL42163419;
	Wed, 13 Aug 2025 16:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121301;
	bh=Sy3YdWqFJNy5sq/10GkOJns1Ey6MZ1hFJo9OWJ642IY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=U1HO0dmyEYwzxhovy+KOhdLitTxaFYBnevJmW0unu5e72iliHDh44gU+PxiD6AuyQ
	 zBV59VfcqfKo+Df24XE33qB4PXEu2PC4SYUkxoj9ewn8o7kGo9c6M1AYghCp5TKRhC
	 Sdk4i0VY528fg8BKpzMyhc2IBjlP2j6yBrKSNplI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLffcm1253252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:41:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:41:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:41:41 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLfdNI2611079;
	Wed, 13 Aug 2025 16:41:40 -0500
From: Andrew Davis <afd@ti.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>, Qin
 Jian <qinjian@cqplus1.com>
CC: <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/6] reset: lpc18xx: Use devm_register_sys_off_handler()
Date: Wed, 13 Aug 2025 16:41:35 -0500
Message-ID: <20250813214138.477659-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250813214138.477659-1-afd@ti.com>
References: <20250813214138.477659-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block and to
later unregister the handler.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/reset/reset-lpc18xx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
index e42b2f24a93da..8ac9f237e1ceb 100644
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -31,7 +31,6 @@
 
 struct lpc18xx_rgu_data {
 	struct reset_controller_dev rcdev;
-	struct notifier_block restart_nb;
 	struct clk *clk_delay;
 	struct clk *clk_reg;
 	void __iomem *base;
@@ -41,11 +40,9 @@ struct lpc18xx_rgu_data {
 
 #define to_rgu_data(p) container_of(p, struct lpc18xx_rgu_data, rcdev)
 
-static int lpc18xx_rgu_restart(struct notifier_block *nb, unsigned long mode,
-			       void *cmd)
+static int lpc18xx_rgu_restart(struct sys_off_data *data)
 {
-	struct lpc18xx_rgu_data *rc = container_of(nb, struct lpc18xx_rgu_data,
-						   restart_nb);
+	struct lpc18xx_rgu_data *rc = data->cb_data;
 
 	writel(BIT(LPC18XX_RGU_CORE_RST), rc->base + LPC18XX_RGU_CTRL0);
 	mdelay(2000);
@@ -178,9 +175,8 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "unable to register device\n");
 
-	rc->restart_nb.priority = 192,
-	rc->restart_nb.notifier_call = lpc18xx_rgu_restart,
-	ret = register_restart_handler(&rc->restart_nb);
+	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART, 192,
+					    lpc18xx_rgu_restart, rc);
 	if (ret)
 		dev_warn(&pdev->dev, "failed to register restart handler\n");
 
-- 
2.39.2


