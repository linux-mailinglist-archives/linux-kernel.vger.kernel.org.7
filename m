Return-Path: <linux-kernel+bounces-760077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C14AB1E63E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3FA1AA387B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9422741B3;
	Fri,  8 Aug 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PTC+Ivtk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492B2737E4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648008; cv=none; b=JN1914aqL2KIXi4lu972wxTcJmrAf7xQbMNGLzRC0PVvwonEsy+pT6wThTC/dQo2OTWqqyLWM+ItJl1jYECexBdKK8C5r89iNxNybwYUihuonzjspThpEgmoerGhTM/gdEZJ/RaC7wxh5vYAmXNJnU5itqgAfxjKeu4x1B4YoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648008; c=relaxed/simple;
	bh=2f4KsiqFn2G6up2UbEEbGEh/1NCDwD1LyNW0a6wNUH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCmaBNiL+rQgzib3sgI6M6935LzbS2zakKGy0jz3Y3Hbrojd+oB1/e0jjnEpQx+Qa91YGEqUr0t76xpwv9NSH+70xXM9aJgP9yLlkj48OqMS2KOjotRFIbHFQN6i/6YxzHOqFbgxq19L8n4ovrdris7+Nz2KnY0a2pgGY7vmsak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PTC+Ivtk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754648004;
	bh=2f4KsiqFn2G6up2UbEEbGEh/1NCDwD1LyNW0a6wNUH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PTC+Ivtkx9EtkIoCwmqjPZwEhYg2jYTBBo1IpvJ1D0bK02OzQeKXzArtEfW9f5ANJ
	 SDvitSqNiOx+NvFWuPqBXQyAsFHghPYQTlb3mCwLAMNNyJlM46glaFD1Ai+V3eJhpB
	 6jJqbFW2rhiDo8WJZtQn/eQarjj8C6PLSwQrSi6S32Z6gKvKLHXaqFTJmOAkn6pfjx
	 AFiCf70arv6vu0W6qZg4oAi5K1xOwM1ZPttOvcewJasd0YP5g3SXbghz+YwVYV9ZHV
	 hnlEPn/EU5XtJ+1+3QWFdXXWLnaXafbcEWUwA8WMbnQLWGWbnGPZ6ZStILobJi7sAC
	 rEZ/tRIXzkzFg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B7AE17E01F5;
	Fri,  8 Aug 2025 12:13:24 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 08 Aug 2025 12:12:12 +0200
Subject: [PATCH v10 02/10] drm/mediatek: mtk_hdmi: Improve
 mtk_hdmi_get_all_clk() flexibility
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-mediatek-drm-hdmi-v2-v10-2-21ea82eec1f6@collabora.com>
References: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
In-Reply-To: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754648002; l=3369;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=xnx1IaetdDkDo+i9PLhUTBKoc6Cky0j3zcT6XI9QWTk=;
 b=n0YVRgmc0m/ApOdY4c7Hh9BuETYUhPDlU8k9Ukxhi1LqMjq3O0cL0rBdLUK2Z6w/2kam+/X9A
 zK9+jqIwCUeCwe5MldCThnSLLdhZA7VaPcfO5iPvS2XHcrfU7Pxi646
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In preparation for splitting common bits of this driver and for
introducing a new version of the MediaTek HDMI Encoder IP, improve
the flexibility	of function mtk_hdmi_get_all_clk() by adding a
pointer to the clock names array and size of it to its parameters.

Also change the array of struct clock pointers in the mtk_hdmi
structure to be dynamically allocated, and allocate it in probe.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 0ac4e755bdf8aace766feffa57712a8fbf4ff791..f38269616679544810edafd70fdd156aca14ad46 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -159,7 +159,7 @@ struct mtk_hdmi {
 	struct phy *phy;
 	struct device *cec_dev;
 	struct i2c_adapter *ddc_adpt;
-	struct clk *clk[MTK_HDMI_CLK_COUNT];
+	struct clk **clk;
 	struct drm_display_mode mode;
 	bool dvi_mode;
 	struct regmap *sys_regmap;
@@ -1072,17 +1072,18 @@ static const char * const mtk_hdmi_clk_names[MTK_HDMI_CLK_COUNT] = {
 	[MTK_HDMI_CLK_AUD_SPDIF] = "spdif",
 };
 
-static int mtk_hdmi_get_all_clk(struct mtk_hdmi *hdmi,
-				struct device_node *np)
+static int mtk_hdmi_get_all_clk(struct mtk_hdmi *hdmi, struct device_node *np,
+				const char * const *clock_names, size_t num_clocks)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mtk_hdmi_clk_names); i++) {
-		hdmi->clk[i] = of_clk_get_by_name(np,
-						  mtk_hdmi_clk_names[i]);
+	for (i = 0; i < num_clocks; i++) {
+		hdmi->clk[i] = of_clk_get_by_name(np, clock_names[i]);
+
 		if (IS_ERR(hdmi->clk[i]))
 			return PTR_ERR(hdmi->clk[i]);
 	}
+
 	return 0;
 }
 
@@ -1379,15 +1380,15 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 	return 0;
 }
 
-static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
-				   struct platform_device *pdev)
+static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
+				   const char * const *clk_names, size_t num_clocks)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *remote, *i2c_np;
 	int ret;
 
-	ret = mtk_hdmi_get_all_clk(hdmi, np);
+	ret = mtk_hdmi_get_all_clk(hdmi, np, clk_names, num_clocks);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");
 
@@ -1636,6 +1637,7 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
 {
 	struct mtk_hdmi *hdmi;
 	struct device *dev = &pdev->dev;
+	const int num_clocks = MTK_HDMI_CLK_COUNT;
 	int ret;
 
 	hdmi = devm_drm_bridge_alloc(dev, struct mtk_hdmi, bridge,
@@ -1646,7 +1648,11 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
 	hdmi->dev = dev;
 	hdmi->conf = of_device_get_match_data(dev);
 
-	ret = mtk_hdmi_dt_parse_pdata(hdmi, pdev);
+	hdmi->clk = devm_kcalloc(dev, num_clocks, sizeof(*hdmi->clk), GFP_KERNEL);
+	if (!hdmi->clk)
+		return -ENOMEM;
+
+	ret = mtk_hdmi_dt_parse_pdata(hdmi, pdev, mtk_hdmi_clk_names, num_clocks);
 	if (ret)
 		return ret;
 

-- 
2.50.1


