Return-Path: <linux-kernel+bounces-775790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1AAB2C4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032B81894357
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526733EAE2;
	Tue, 19 Aug 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ux1FMWYZ"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E0341ABD;
	Tue, 19 Aug 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608918; cv=none; b=QfzFFRzUNre04sF65PwvziyWKI/ykzLjxU/05G5ardiHJmODtYFoj97eX7y+YAtq/5E96TGKvbD6mRT0V7ATfXs8j3mOKMzZ5buEhFye87uquk2pSBOQUAvWO+0mftL+38zRb2aFgD8iUo0J8WwRdKocOPqhKcCr5KbxLql3inM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608918; c=relaxed/simple;
	bh=KCWnjMiB9XFoVGMpf6BPVRD0gmoXcgXGP7kPth7WYwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li2JAc5dZuT2aT+1i5/78UBi1Mbe4/chs2/RzeXTf5okPacBlJjoU1lN3KuoSGX/d9TR1mNEcVuZT/UYw1YXEVbZHD4OX9RXy2AbOgpO0vT2UTtvdPBKyVeNw95jj/X3+q85GgwDnrCc8v/hS5xpBmElxFNdQt9PRJo2BOEqVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ux1FMWYZ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JD8Box015729;
	Tue, 19 Aug 2025 08:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755608891;
	bh=xtTTfFfNriT5ktHRzxyQ7zHdkREPkpN1b5TtXHfK0sc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ux1FMWYZ2cMzW1QEKitGOj7dqtY7Fq7VRpNnr3AVIm5+envElShArvPDpM5iEQbI/
	 5xzKH5K3Q9ghRK9tIHrM56MDHWbd30DV4LwrVYQM4Hd9f+IOwZdzKRlSC79IF6Ux3z
	 lysTf4+IYT1llzi9nqsiBje/akG/g203vXxhbJo4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JD8B7X421272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 08:08:11 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 08:08:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 08:08:11 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JD8BSh2747739;
	Tue, 19 Aug 2025 08:08:11 -0500
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
Subject: [PATCH V4 5/5] drm/bridge: it66121: Add minimal it66122 support
Date: Tue, 19 Aug 2025 08:08:07 -0500
Message-ID: <20250819130807.3322536-6-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250819130807.3322536-1-nm@ti.com>
References: <20250819130807.3322536-1-nm@ti.com>
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
Changes in V4:
* just rebase
* Picked Andrew's review

V3: https://lore.kernel.org/all/20250815034105.1276548-5-nm@ti.com/
V2: https://lore.kernel.org/all/20250813204106.580141-4-nm@ti.com/

 drivers/gpu/drm/bridge/ite-it66121.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index a1b0f8a8f3e8..fd71609a804e 100644
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
 	{ }
 };
 
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


