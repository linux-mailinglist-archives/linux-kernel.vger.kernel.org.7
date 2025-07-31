Return-Path: <linux-kernel+bounces-752340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3525AB1744F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA5D177425
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402F20D51A;
	Thu, 31 Jul 2025 15:53:08 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDF1DF991;
	Thu, 31 Jul 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977188; cv=none; b=XLuRJF1q+jKU+SZhQ6zrBFfZou6PCkIuSw76pyffadjnLPWJoIXOiymeRQz7ydB5qLc9KiVa6pbi66zhREwH06vCPQCwe9DbxIegL41s1YSpnVMHqpMFNAqzZofV17vKn6adXnZfSlIvAk1kiO4EwBb5PjTLVD6+V0sJ+sTTbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977188; c=relaxed/simple;
	bh=K8BHA+iA1iydveDUvp/YesIVTsMaDiSb18vKNRsmk48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4pyn4H+y2FF/3VJjpG3lZB/gqx/5wlCy0muYuDUiEAAp+/YVgtap24n7yWNJOYyYgRakLcjyJkRWYHDVDzEAYK/xmT6Fv/Xh4itDewNpbvwdcfnUUZj5KQAsCUz/Lmu1X7VLjYbVgiIfIQFEkUTolnAmq07xpDuY2FXNt9GEX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 0F55C1C271E;
	Thu, 31 Jul 2025 17:52:59 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id CA3B71C270C;
	Thu, 31 Jul 2025 17:52:55 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:21 +0200
Subject: [PATCH v3 08/16] drm: sprd: add support for UMS9230 DSI PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-8-06d4f57c4b08@abscue.de>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
In-Reply-To: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
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
index 22f300654a1903ecb7002c1e643361c6c51623d4..106a0e7dac5cb89e6a96cc33a1698ec48c9f2745 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -1071,8 +1071,23 @@ static const struct mipi_dsi_host_ops sprd_dsi_host_ops = {
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
 
@@ -1091,6 +1106,10 @@ static int sprd_dsi_probe(struct platform_device *pdev)
 	dsi->host.ops = &sprd_dsi_host_ops;
 	dsi->host.dev = dev;
 
+	dsi->ctx.pll.platform = of_device_get_match_data(dev);
+	if (!dsi->ctx.pll.platform)
+		return -EINVAL;
+
 	return mipi_dsi_host_register(&dsi->host);
 }
 
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.h b/drivers/gpu/drm/sprd/sprd_dsi.h
index d15b8bfd61f2e69f877aa727fbbbe4b61e9cb0fe..1aa609b1da33601217941390673553552f2923b1 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.h
+++ b/drivers/gpu/drm/sprd/sprd_dsi.h
@@ -64,6 +64,13 @@ enum pll_timing {
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
@@ -71,7 +78,6 @@ struct dphy_pll {
 	u8 sdm_en;
 	u8 div;
 	u8 int_n; /* integer N PLL */
-	u32 ref_clk; /* dphy reference clock, unit: MHz */
 	u32 freq; /* panel config, unit: KHz */
 	u32 fvco;
 	u32 potential_fvco;
@@ -81,6 +87,7 @@ struct dphy_pll {
 	u8 out_sel; /* post divider control */
 	u8 vco_band; /* vco range */
 	u8 det_delay;
+	const struct dphy_pll_platform *platform;
 };
 
 struct dsi_context {

-- 
2.50.0

