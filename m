Return-Path: <linux-kernel+bounces-737719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA3B0AFBC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C993B00D7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B44238C3C;
	Sat, 19 Jul 2025 12:11:42 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58484221F01;
	Sat, 19 Jul 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927101; cv=none; b=Us4kb8qE4Dh6oA5+/5R1wArmzdnz016GnbM3LeAQWFQGSshVEiqXdyr+YL6uYiT61/pgaTnn5wDdAAOkmeTD4gDQ+CP4JWIaXFVolR+ZXy2JlioJd2MbUjjUD/sJ8K3ntimgPKlwSIyHqO0ILYBHqwIKUoR9mtvWqq6DtQ6cNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927101; c=relaxed/simple;
	bh=d7b0NQklUbd30khoRMPI/W98vBf/gSQuiHhpGKkYHPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbPCd1ShOQoj5UHtFkk03i7C9Cntd1RIcnebi644/CkeTK7DfVbtJfxzNdIQGEOMdNfMz4GG71BYisheGw89Hxd9/A64hN9U557xhAdzvaKGdPp3mepOeux8qzelSI0JSY8pYqDRAFceoLoMa5jUqmEQyF7d7OyvhG2EP7iBr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id DDCA81C06A3;
	Sat, 19 Jul 2025 14:11:31 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id 4E1BC1C06E1;
	Sat, 19 Jul 2025 14:11:31 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sat, 19 Jul 2025 14:09:42 +0200
Subject: [PATCH 06/12] drm: sprd: add support for UMS9230 DSI PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-ums9230-drm-v1-6-e4344a05eb3d@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
In-Reply-To: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Move platform-specific PLL parameters to the device tree match data and
add the parameters for UMS9230.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/megacores_pll.c | 21 ++++++++-------------
 drivers/gpu/drm/sprd/sprd_dsi.c      | 21 ++++++++++++++++++++-
 drivers/gpu/drm/sprd/sprd_dsi.h      |  9 ++++++++-
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sprd/megacores_pll.c b/drivers/gpu/drm/sprd/megacores_pll.c
index 3091dfdc11e3b547a05a9edaa4047a1e367c1596..e5a18599678ab6e3771cd732dcca409ab2d59f72 100644
--- a/drivers/gpu/drm/sprd/megacores_pll.c
+++ b/drivers/gpu/drm/sprd/megacores_pll.c
@@ -21,12 +21,6 @@
 
 #define AVERAGE(a, b) (min(a, b) + abs((b) - (a)) / 2)
 
-/* sharkle */
-#define VCO_BAND_LOW	750
-#define VCO_BAND_MID	1100
-#define VCO_BAND_HIGH	1500
-#define PHY_REF_CLK	26000
-
 static int dphy_calc_pll_param(struct dphy_pll *pll)
 {
 	const u32 khz = 1000;
@@ -36,11 +30,10 @@ static int dphy_calc_pll_param(struct dphy_pll *pll)
 	int i;
 
 	pll->potential_fvco = pll->freq / khz;
-	pll->ref_clk = PHY_REF_CLK / khz;
 
 	for (i = 0; i < 4; ++i) {
-		if (pll->potential_fvco >= VCO_BAND_LOW &&
-		    pll->potential_fvco <= VCO_BAND_HIGH) {
+		if (pll->potential_fvco >= pll->platform->band_low &&
+		    pll->potential_fvco <= pll->platform->band_high) {
 			pll->fvco = pll->potential_fvco;
 			pll->out_sel = BIT(i);
 			break;
@@ -50,21 +43,23 @@ static int dphy_calc_pll_param(struct dphy_pll *pll)
 	if (pll->fvco == 0)
 		return -EINVAL;
 
-	if (pll->fvco >= VCO_BAND_LOW && pll->fvco <= VCO_BAND_MID) {
+	if (pll->fvco >= pll->platform->band_low &&
+	    pll->fvco <= pll->platform->band_mid) {
 		/* vco band control */
 		pll->vco_band = 0x0;
 		/* low pass filter control */
 		pll->lpf_sel = 1;
-	} else if (pll->fvco > VCO_BAND_MID && pll->fvco <= VCO_BAND_HIGH) {
+	} else if (pll->fvco > pll->platform->band_mid &&
+		   pll->fvco <= pll->platform->band_high) {
 		pll->vco_band = 0x1;
 		pll->lpf_sel = 0;
 	} else {
 		return -EINVAL;
 	}
 
-	pll->nint = pll->fvco / pll->ref_clk;
+	pll->nint = pll->fvco / pll->platform->ref_clk;
 	tmp = pll->fvco * factor * mhz;
-	do_div(tmp, pll->ref_clk);
+	do_div(tmp, pll->platform->ref_clk);
 	tmp = tmp - pll->nint * factor * mhz;
 	tmp *= BIT(20);
 	do_div(tmp, 100000000);
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 43fff12d73f12619da57606a3c4785924e2c1507..db5f9bcbb2500096402b9d44b9cc4428070e69ba 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -1061,8 +1061,23 @@ static const struct mipi_dsi_host_ops sprd_dsi_host_ops = {
 	.transfer = sprd_dsi_host_transfer,
 };
 
+static const struct dphy_pll_platform dphy_pll_sharkl3 = {
+	.band_low = 750,
+	.band_mid = 1100,
+	.band_high = 1500,
+	.ref_clk = 26,
+};
+
+static const struct dphy_pll_platform dphy_pll_ums9230 = {
+	.band_low = 1250,
+	.band_mid = 1800,
+	.band_high = 2500,
+	.ref_clk = 26,
+};
+
 static const struct of_device_id dsi_match_table[] = {
-	{ .compatible = "sprd,sharkl3-dsi-host" },
+	{ .compatible = "sprd,sharkl3-dsi-host", .data = &dphy_pll_sharkl3 },
+	{ .compatible = "sprd,ums9230-dsi-host", .data = &dphy_pll_ums9230 },
 	{ /* sentinel */ },
 };
 
@@ -1080,6 +1095,10 @@ static int sprd_dsi_probe(struct platform_device *pdev)
 	dsi->host.ops = &sprd_dsi_host_ops;
 	dsi->host.dev = dev;
 
+	dsi->ctx.pll.platform = of_device_get_match_data(dev);
+	if (!dsi->ctx.pll.platform)
+		return -EINVAL;
+
 	return mipi_dsi_host_register(&dsi->host);
 }
 
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.h b/drivers/gpu/drm/sprd/sprd_dsi.h
index f18f7398df6fa995df7ec2c59cf5c2745fbd28bd..0b9f1cabe71570743cbc68a8061e95a249f27191 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.h
+++ b/drivers/gpu/drm/sprd/sprd_dsi.h
@@ -66,6 +66,13 @@ enum pll_timing {
 	TA_WAIT,
 };
 
+struct dphy_pll_platform {
+	u32 band_low;
+	u32 band_mid;
+	u32 band_high;
+	u32 ref_clk; /* dphy reference clock, unit: MHz */
+};
+
 struct dphy_pll {
 	u8 refin; /* Pre-divider control signal */
 	u8 cp_s; /* 00: SDM_EN=1, 10: SDM_EN=0 */
@@ -73,7 +80,6 @@ struct dphy_pll {
 	u8 sdm_en;
 	u8 div;
 	u8 int_n; /* integer N PLL */
-	u32 ref_clk; /* dphy reference clock, unit: MHz */
 	u32 freq; /* panel config, unit: KHz */
 	u32 fvco;
 	u32 potential_fvco;
@@ -83,6 +89,7 @@ struct dphy_pll {
 	u8 out_sel; /* post divider control */
 	u8 vco_band; /* vco range */
 	u8 det_delay;
+	const struct dphy_pll_platform *platform;
 };
 
 struct dsi_context {

-- 
2.50.0

