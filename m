Return-Path: <linux-kernel+bounces-604928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148EFA89ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C228E188AF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E7296D21;
	Tue, 15 Apr 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ol58IuTu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4E2957DF;
	Tue, 15 Apr 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713838; cv=none; b=tqpWB+bwvz0Dxvz2LtUd+tLcfsC9lMrYn+MiLpwKrWr8lI5u7I/Ueavo9U92rgNkR+qOMfpQlOESYrev8H3GlyN6XrSMLOUAfl2qd30sBooRmJIMI9gx2Fagjd5VNVDlxW5o9SAxx3obn9Ft7M+8YTiyso+1JzTu3hYt2LHMBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713838; c=relaxed/simple;
	bh=b9YcalvXw4ohTPfdl6oCK3yb6tz2Bn3pvcUfCFfm4TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpgQOgZUmSuEMH4ImjelmY9XDvr8e5DF6Z6Ud7Bf4wbm8S8j0YSmkWbEfd4OmUWloDiyooX5fthRioC47EniBkN55rv4ZBEseAMQ9hw/ussruPtISIWAKNepmbRpAjGeSeVv307zwlhcEtOqWAkLj/jhhVqTt+6T87QnGBDMouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ol58IuTu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744713835;
	bh=b9YcalvXw4ohTPfdl6oCK3yb6tz2Bn3pvcUfCFfm4TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ol58IuTuq5wO3EcMUHvIVGoEL7tsyI9fkySykAzQKGmXY29n/eMxJHMBH2JNO0uRT
	 /2JEaXsREKZGt3ZzXY6x5PAVIomVC0Rctl1d/JlmPZ0EC7vDW4AhyuwfH5FqanJqbr
	 bFFXZFeDygx1f7nsb1RSM8X3MSgqgsiFjiKv7zfF7fU5XoBD1jXt61YJHVf4MtNnl3
	 x8nNs1qCgsV4QjkTyiaihuUnXhYZxW8sNgs2o5MCdfqrQKClAXZIxMGTkPyNAdj9Mo
	 hQ2iSQjgfQcG1TDFPlQ2Ga5BHKROdgZyvjawRRszXBrdhDoNjPnyGts/R2hOQmraeC
	 9+pe2gocFsW0A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97A3317E3642;
	Tue, 15 Apr 2025 12:43:53 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	dmitry.baryshkov@linaro.org,
	lewis.liao@mediatek.com,
	ives.chenjh@mediatek.com,
	tommyyl.chen@mediatek.com,
	jason-jh.lin@mediatek.com
Subject: [PATCH v9 15/23] drm/mediatek: mtk_hdmi: Improve mtk_hdmi_get_all_clk() flexibility
Date: Tue, 15 Apr 2025 12:43:13 +0200
Message-ID: <20250415104321.51149-16-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415104321.51149-1-angelogioacchino.delregno@collabora.com>
References: <20250415104321.51149-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for splitting common bits of this driver and for
introducing a new version of the MediaTek HDMI Encoder IP, improve
the flexibility	of function mtk_hdmi_get_all_clk() by adding a
pointer to the clock names array and size of it to its parameters.

Also change the array of struct clock pointers in the mtk_hdmi
structure to be dynamically allocated, and allocate it in probe.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index b4fbd2e60089..b17f8df145eb 100644
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
 
@@ -1377,15 +1378,15 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
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
 
@@ -1634,6 +1635,7 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
 {
 	struct mtk_hdmi *hdmi;
 	struct device *dev = &pdev->dev;
+	const int num_clocks = MTK_HDMI_CLK_COUNT;
 	int ret;
 
 	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
@@ -1643,7 +1645,11 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
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
2.49.0


