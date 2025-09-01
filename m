Return-Path: <linux-kernel+bounces-793788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C5B3D835
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697773B8E43
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55E238142;
	Mon,  1 Sep 2025 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="I84SXVPt"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475E224AE0;
	Mon,  1 Sep 2025 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756700650; cv=none; b=dtA2RZyS6xwY3QenRvAz7auiqSXnKZss6FDwbW+KNSYQ8+BTGyk/pD0fr7Ua2pVDWQjS9Yq1GuB+sdrdo3Tj6H8hbpnXs6/ZmKPVFmeSRQMg8V/QsNY0zYTbsoB0M1WS65D24KWOfCDFe4HlDCGUK/el8OoSaJ7MzgDlzdm5gIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756700650; c=relaxed/simple;
	bh=AyARZ8O9kOKQYCzMN7H8nfyDa+QfPPanHy+EOHRlTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqT5TKlZ4MCWLXGik/j4/JoWZpAoywVGUGjWWXF8xUgJ4fV1u3mdlk02+hjUwoar3qdu42vNbuH5Ak0sE2ArbPK4HONRweQxx9NnB38cVLtLOC995fvMHECWsPpoRv8cDz8QA4vhFwbJwfAZ1GsgaHYV0HoaiJQ5j2AdT8KyCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=I84SXVPt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7A6D720A4A;
	Mon,  1 Sep 2025 06:24:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F_DJaGlQeZov; Mon,  1 Sep 2025 06:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756700645; bh=AyARZ8O9kOKQYCzMN7H8nfyDa+QfPPanHy+EOHRlTZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I84SXVPtprJx5B7cvt8/XmOO6KhoKS5ue/q1CYtWmnXJc4c96hUItTooEuRA+1eJD
	 C6sYbhGgMemKMo/euh3NdC778y0iEvAr40yNu3a2HUSrSxUl9rACcXvJ4V47X7/aV9
	 pF3VRBp3znTnDQKCfM7gmv09sue7GHPicqPeGvyosLNP8X9eZrgYaK0TXr/T2Sqz3Y
	 4LThA1EAsA59xmy77lcUx9jH1xTQOO6S/gsM5Y+VZi6J7Wik3QYE6DHzJO54Hlo56r
	 QhHoDlVIefIlehFW4NBLY07RmL3jAMQqvcQu+yWJEd+gn7A6klqzGQWHY82+ITtbPc
	 dVnZT76n1Wh3g==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/4] reset: th1520: Prepare for supporting multiple controllers
Date: Mon,  1 Sep 2025 04:23:18 +0000
Message-ID: <20250901042320.22865-3-ziyao@disroot.org>
In-Reply-To: <20250901042320.22865-1-ziyao@disroot.org>
References: <20250901042320.22865-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TH1520 SoC is divided into several subsystems, shipping distinct reset
controllers with similar control logic. Let's make reset signal mapping
a data structure specific to one compatible to prepare for introduction
of more reset controllers in the future.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/reset/reset-th1520.c | 42 +++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
index 14d964a9c6b6..2b65a95ed021 100644
--- a/drivers/reset/reset-th1520.c
+++ b/drivers/reset/reset-th1520.c
@@ -29,14 +29,20 @@
 #define TH1520_HDMI_SW_MAIN_RST		BIT(0)
 #define TH1520_HDMI_SW_PRST		BIT(1)
 
+struct th1520_reset_map {
+	u32 bit;
+	u32 reg;
+};
+
 struct th1520_reset_priv {
 	struct reset_controller_dev rcdev;
 	struct regmap *map;
+	const struct th1520_reset_map *resets;
 };
 
-struct th1520_reset_map {
-	u32 bit;
-	u32 reg;
+struct th1520_reset_data {
+	const struct th1520_reset_map *resets;
+	size_t num;
 };
 
 static const struct th1520_reset_map th1520_resets[] = {
@@ -90,7 +96,7 @@ static int th1520_reset_assert(struct reset_controller_dev *rcdev,
 	struct th1520_reset_priv *priv = to_th1520_reset(rcdev);
 	const struct th1520_reset_map *reset;
 
-	reset = &th1520_resets[id];
+	reset = &priv->resets[id];
 
 	return regmap_update_bits(priv->map, reset->reg, reset->bit, 0);
 }
@@ -101,7 +107,7 @@ static int th1520_reset_deassert(struct reset_controller_dev *rcdev,
 	struct th1520_reset_priv *priv = to_th1520_reset(rcdev);
 	const struct th1520_reset_map *reset;
 
-	reset = &th1520_resets[id];
+	reset = &priv->resets[id];
 
 	return regmap_update_bits(priv->map, reset->reg, reset->bit,
 				  reset->bit);
@@ -120,11 +126,14 @@ static const struct regmap_config th1520_reset_regmap_config = {
 
 static int th1520_reset_probe(struct platform_device *pdev)
 {
+	const struct th1520_reset_data *data;
 	struct device *dev = &pdev->dev;
 	struct th1520_reset_priv *priv;
 	void __iomem *base;
 	int ret;
 
+	data = device_get_match_data(dev);
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -138,22 +147,31 @@ static int th1520_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->map))
 		return PTR_ERR(priv->map);
 
-	/* Initialize GPU resets to asserted state */
-	ret = regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
-				 TH1520_GPU_RST_CFG_MASK, 0);
-	if (ret)
-		return ret;
+	if (of_device_is_compatible(dev->of_node, "thead,th1520-reset")) {
+		/* Initialize GPU resets to asserted state */
+		ret = regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
+					 TH1520_GPU_RST_CFG_MASK, 0);
+		if (ret)
+			return ret;
+	}
 
 	priv->rcdev.owner = THIS_MODULE;
-	priv->rcdev.nr_resets = ARRAY_SIZE(th1520_resets);
+	priv->rcdev.nr_resets = data->num;
 	priv->rcdev.ops = &th1520_reset_ops;
 	priv->rcdev.of_node = dev->of_node;
 
+	priv->resets = data->resets;
+
 	return devm_reset_controller_register(dev, &priv->rcdev);
 }
 
+static const struct th1520_reset_data th1520_reset_data = {
+	.resets = th1520_resets,
+	.num = ARRAY_SIZE(th1520_resets),
+};
+
 static const struct of_device_id th1520_reset_match[] = {
-	{ .compatible = "thead,th1520-reset" },
+	{ .compatible = "thead,th1520-reset", .data = &th1520_reset_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, th1520_reset_match);
-- 
2.50.1


