Return-Path: <linux-kernel+bounces-810156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AFB516AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A3441272
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EA313E2E;
	Wed, 10 Sep 2025 12:20:17 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64B276051
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506817; cv=none; b=D+m8Vo81h0V7CmV6crqgO6bHldZAIGDDDmmPEOjMLEG5PLUiP+iHRuZWV5W0TIvSgvLGQlXEZWrSphaIrtPvPQT+jAu8MQPWuz3zlIpxzhUDuSJKriDYLex4mR+9OZsgf3W2PhCuemI9pFWzTxITYy+2LyW43KC8hdinhPCbuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506817; c=relaxed/simple;
	bh=Rnaz4lvvqv81VAJPYG7sxvyAagH672MXsv7FDe2/yao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgF6gamiArKBcSb+3N1t4fK/92gpQebrihGV+M4MAllFRokIrNX1Os/gkbM8O3VmHt8nHYb5ArHvjOSz9NknzJYUj0sKYS1UbrgN7di3OYqAjlLhD2SHxbytyN9Xb+piv7821s2CJNIrVgSCcsVkLpfhNOGsDHp2sKaZhaqReoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.26])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2258dbfa4;
	Wed, 10 Sep 2025 20:20:05 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Vinod Koul <vkoul@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] phy: rockchip: naneng-combphy: use existing DT property check for rk3528
Date: Wed, 10 Sep 2025 20:20:00 +0800
Message-Id: <20250910122000.951100-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9933919ce703a2kunm0b30bd90142f2c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQkxOVh9DTE5JT0xJSBhNQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVJTVlXWRYaDxIVHRRZQVlPS0hVSktIS0pITVVKS0tVS1
	kG

The naneng-combphy driver already has DT property checks for
"rockchip,enable-ssc" and "rockchip,ext-refclk", use it for
the rk3528_combphy_cfg. Also aligned the indentation of the
rk3528_combphy_grfcfgs parameters (using tabs).

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index a3ef19807b9e..ad6c8a11951b 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -518,7 +518,7 @@ static int rk3528_combphy_cfg(struct rockchip_combphy_priv *priv)
 		return -EINVAL;
 	}
 
-	if (device_property_read_bool(priv->dev, "rockchip,ext-refclk")) {
+	if (priv->ext_refclk) {
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
 
 		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
@@ -543,11 +543,9 @@ static int rk3528_combphy_cfg(struct rockchip_combphy_priv *priv)
 		}
 	}
 
-	if (priv->type == PHY_TYPE_PCIE) {
-		if (device_property_read_bool(priv->dev, "rockchip,enable-ssc"))
-			rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_EN,
-						 RK3528_PHYREG40_SSC_EN, RK3528_PHYREG40);
-	}
+	if (priv->type == PHY_TYPE_PCIE && priv->enable_ssc)
+		rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_EN,
+					 RK3528_PHYREG40_SSC_EN, RK3528_PHYREG40);
 
 	return 0;
 }
@@ -571,7 +569,7 @@ static const struct rockchip_combphy_grfcfg rk3528_combphy_grfcfgs = {
 	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x101 },
 	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
 	/* pipe-grf */
-	.u3otg0_port_en         = { 0x0044, 15, 0, 0x0181, 0x1100 },
+	.u3otg0_port_en		= { 0x0044, 15, 0, 0x0181, 0x1100 },
 };
 
 static const struct rockchip_combphy_cfg rk3528_combphy_cfgs = {
-- 
2.25.1


