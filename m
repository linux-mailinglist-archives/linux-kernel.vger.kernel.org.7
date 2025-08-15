Return-Path: <linux-kernel+bounces-770115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC7B276F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7643C1CC741F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE52BE02F;
	Fri, 15 Aug 2025 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vAcSgHgd"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D721C9F2;
	Fri, 15 Aug 2025 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229279; cv=none; b=OjckHth8OnAQ+PYbVWu71S3oWfaSFXKmOO/lG/nLgO1gtlrec/vEyaD+tY+k1upWoogBmibML52nC7mh3Vfp2BY42Q2enuE7jwU9OZtLy4cqNpDyCI3ncv5yAHwWpEzgSAdhKbHZu5nawjPUvsHcSrZqA/DRpyw6VhWR3yF3TQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229279; c=relaxed/simple;
	bh=LZ2oIlScxMjEVE6sXZQIp9eGC6mhAMoZRGIJjY9WN+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMWfcxOMaRWdMsokzWwepN0ibC3VzvQm6rHIv84uyuRn+1G0jpa1UkgR7LoZSbcWH/06DxRQMKDldt2k6+f+qr3gPjFHncWQBJNZqX4gnYPCpr98OiBv9fBaiUukT8G+IdM5PzR3HoESwYhqtfnG5uVFqRsbTHMmYK9BzbH52qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vAcSgHgd; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F3f99E2526244;
	Thu, 14 Aug 2025 22:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755229269;
	bh=0nnpdAsOqPmBlFg4DS1pedpp234rEjm3RCMYFwuD8kk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vAcSgHgd28beLrAuWTo2dKUj3yNnZ4aw21dE5eBoQnPqe7LPLo3ntLaRGA1kvUq0i
	 HYyyYEhOCLXsmn4nEfuoPsn5at7rfOVAuBOJ4dLJvv+BV2kQocM0KY3LisrQNA3Fwv
	 IdX0mzC6ZgCMgW9hEJzNcgzT5mCP4nZSQ6vgBXew=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F3f9Wf1320969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 22:41:09 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 22:41:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 22:41:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F3f82p727660;
	Thu, 14 Aug 2025 22:41:08 -0500
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
        Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V3 4/4] drm/bridge: it66121: Add minimal it66122 support
Date: Thu, 14 Aug 2025 22:41:05 -0500
Message-ID: <20250815034105.1276548-5-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815034105.1276548-1-nm@ti.com>
References: <20250815034105.1276548-1-nm@ti.com>
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
---
Changes in V3:
* Dropped the claim that it is 1-1 replacement of IT66121.
* Based on emperical test result[2], introduce the same configuration of
  IT66121, but provide ID as suggested by Devarsh to allow for future
  expansion of functionality.

NOTE: I did consider the possibility of converting the chip_id into a
bitfield, but decided it is over-engineering, so kept the enum.

[2] https://github.com/beagleboard/linux/commits/v6.1.83-ti-rt-r40

V2: https://lore.kernel.org/all/20250813204106.580141-4-nm@ti.com/

 drivers/gpu/drm/bridge/ite-it66121.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 5ac9631bcd9a..a108d287722d 100644
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
@@ -1614,12 +1615,14 @@ static void it66121_remove(struct i2c_client *client)
 }
 
 static const struct it66121_chip_info it66xx_chip_info[] = {
+	{.id = ID_IT66122, .vid = 0x4954, .pid = 0x0622 },
 	{.id = ID_IT66121, .vid = 0x4954, .pid = 0x0612 },
 	{.id = ID_IT6610, .vid = 0xca00, .pid = 0x0611 },
 	{ }
 };
 
 static const struct of_device_id it66121_dt_match[] = {
+	{ .compatible = "ite,it66122", &it66xx_chip_info },
 	{ .compatible = "ite,it66121", &it66xx_chip_info },
 	{ .compatible = "ite,it6610", &it66xx_chip_info },
 	{ }
@@ -1627,6 +1630,7 @@ static const struct of_device_id it66121_dt_match[] = {
 MODULE_DEVICE_TABLE(of, it66121_dt_match);
 
 static const struct i2c_device_id it66121_id[] = {
+	{ "it66122", (kernel_ulong_t)&it66xx_chip_info },
 	{ "it66121", (kernel_ulong_t)&it66xx_chip_info },
 	{ "it6610", (kernel_ulong_t)&it66xx_chip_info },
 	{ }
-- 
2.47.0


