Return-Path: <linux-kernel+bounces-788828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066A2B38AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C61BA5D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08712F1FF3;
	Wed, 27 Aug 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PJUwSYzx"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CC2EAB6D;
	Wed, 27 Aug 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326250; cv=none; b=pIP1ftr16vD49wqg7FdM+r1q+itpDbVf+GdsNz+L6XF8JBQXupOqeFciN4FCCPKs6yQWqq5QxAzN0BS3DjMznlDawMf39QYkEoMQTz1j4Yrsjfmk7dzqBhhzq/UX1Kh04UIltS8amGSk7D3XuWZq2NmCCOdXzcUlXMpQYnOeXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326250; c=relaxed/simple;
	bh=C6PmEza3l0nG7shFPk7ihwWxDS27su3MGXCvTXtREkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDHWncTygGqrB2vFE8+nY1pEwS9wrfY+n0TazW23Z2oFIT0Nnb8DTHy1f9NCEFgSoETKYxTJr2ySfFxaXC1t0B5uJhjdcVKoD/8OHX41PoEm2H5uDOC9d5TtWmd1HyR3GQ9lYueyAfiXxb3ueXVSeCu6i8OCJr1MrUPBkZI0AsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PJUwSYzx; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RKNwL21358626;
	Wed, 27 Aug 2025 15:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756326238;
	bh=OhZvUGNzkKwJBBWt0fGwrgmGI6bNK3nytiaCkySyJVA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PJUwSYzx1lbtcFqYNcR6pLPEdje2W44HF4UxxV1+fmP1pN5LWjPlD4B0Ix8MM5Y+Y
	 7OxjyyJRPLEUWsRpmwDyAKG+X1J3Yrc2kRCM185X37Wuar5k5hKjAe1gOVecLFJOAq
	 gYbOJss5rf7qnqUwLyHEsR349QNAqk7mZggvxOvY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RKNwmt2950688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 27 Aug 2025 15:23:58 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 15:23:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 15:23:57 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RKNvZE3367094;
	Wed, 27 Aug 2025 15:23:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, <afd@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>,
        <dmitry.baryshkov@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 5/5] drm/bridge: it66121: Add minimal it66122 support
Date: Wed, 27 Aug 2025 15:23:54 -0500
Message-ID: <20250827202354.2017972-6-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250827202354.2017972-1-nm@ti.com>
References: <20250827202354.2017972-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The IT66122 is a pin compatible replacement for the IT66122. Based on
empirical testing, the new device looks to be compatible with IT66121.
However due to a lack of public data sheet at this time beyond overall
feature list[1] (which seems to add additional features vs ITT66121),
it is hard to determine that additional register operations required
to enable additional features.

So, introduce the device as a new compatible that we will detect based
on vid/pid match, with explicit id that can be used to extend the
driver capability as information becomes available later on.

[1] https://www.ite.com.tw/en/product/cate1/IT66122

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
Changes since V4:
None.

V4: https://lore.kernel.org/all/20250819130807.3322536-6-nm@ti.com/
V3: https://lore.kernel.org/all/20250815034105.1276548-5-nm@ti.com/
V2: https://lore.kernel.org/all/20250813204106.580141-4-nm@ti.com/

 drivers/gpu/drm/bridge/ite-it66121.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 1b2ef774c770..0185f61e6e59 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -287,6 +287,7 @@
 enum chip_id {
 	ID_IT6610,
 	ID_IT66121,
+	ID_IT66122,
 };
 
 struct it66121_chip_info {
@@ -402,7 +403,7 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
 		if (ret)
 			return ret;
 
-		if (ctx->id == ID_IT66121) {
+		if (ctx->id == ID_IT66121 || ctx->id == ID_IT66122) {
 			ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
 						IT66121_AFE_IP_EC1, 0);
 			if (ret)
@@ -428,7 +429,7 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
 		if (ret)
 			return ret;
 
-		if (ctx->id == ID_IT66121) {
+		if (ctx->id == ID_IT66121 || ctx->id == ID_IT66122) {
 			ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
 						IT66121_AFE_IP_EC1,
 						IT66121_AFE_IP_EC1);
@@ -599,7 +600,7 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		return ret;
 
-	if (ctx->id == ID_IT66121) {
+	if (ctx->id == ID_IT66121 || ctx->id == ID_IT66122) {
 		ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
 					IT66121_CLK_BANK_PWROFF_RCLK, 0);
 		if (ret)
@@ -802,7 +803,7 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
 		goto unlock;
 
-	if (ctx->id == ID_IT66121 &&
+	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
 	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
 			      IT66121_CLK_BANK_PWROFF_TXCLK,
 			      IT66121_CLK_BANK_PWROFF_TXCLK)) {
@@ -815,7 +816,7 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 	if (it66121_configure_afe(ctx, adjusted_mode))
 		goto unlock;
 
-	if (ctx->id == ID_IT66121 &&
+	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
 	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
 			      IT66121_CLK_BANK_PWROFF_TXCLK, 0)) {
 		goto unlock;
@@ -1501,6 +1502,7 @@ static const char * const it66121_supplies[] = {
 static const struct it66121_chip_info it66xx_chip_info[] = {
 	{.id = ID_IT6610, .vid = 0xca00, .pid = 0x0611 },
 	{.id = ID_IT66121, .vid = 0x4954, .pid = 0x0612 },
+	{.id = ID_IT66122, .vid = 0x4954, .pid = 0x0622 },
 };
 
 static int it66121_probe(struct i2c_client *client)
@@ -1621,6 +1623,7 @@ static void it66121_remove(struct i2c_client *client)
 static const struct of_device_id it66121_dt_match[] = {
 	{ .compatible = "ite,it6610" },
 	{ .compatible = "ite,it66121" },
+	{ .compatible = "ite,it66122" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, it66121_dt_match);
@@ -1628,6 +1631,7 @@ MODULE_DEVICE_TABLE(of, it66121_dt_match);
 static const struct i2c_device_id it66121_id[] = {
 	{ .name = "it6610" },
 	{ .name = "it66121" },
+	{ .name = "it66122" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, it66121_id);
-- 
2.47.0


