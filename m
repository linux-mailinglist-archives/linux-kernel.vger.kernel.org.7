Return-Path: <linux-kernel+bounces-816554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF08B5754F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CAAA4E1A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C72FABEC;
	Mon, 15 Sep 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iCBSPSqS"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C22F9C29;
	Mon, 15 Sep 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930121; cv=none; b=IOrDqEz/yuBVjGu0w9TBLONyA1yOvGS51Sb6V8xt51+wucCQ7UrKKxrh/zAMpqziYdvh79B10A00X7I0kCrRW5a3NT4ibJuTGdh21d3IPQ6tjg6bnLGORanfJLocrUfmR5zWbzDipCJibUqCAdm0CBbEXhT9dsCBAYze5hEb+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930121; c=relaxed/simple;
	bh=AyARZ8O9kOKQYCzMN7H8nfyDa+QfPPanHy+EOHRlTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4eIrGrifWB59mSa8DUKrbXeZLhyLVpG95P423nzcC2dYe8qONP/5wvb6WFS+uaHXa3nJB6knWbOyEnWPPgzSDxASnN/ehdwonlfc+9ORUBfqFQ2UXlIsWHdY4zNG3Y6jWUfZLnZAPKSZ1LYjWHUklw3etdzzZaUlRJl8jRMm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iCBSPSqS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8657F25D67;
	Mon, 15 Sep 2025 11:55:16 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgoPlgG5Q7LO; Mon, 15 Sep 2025 11:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757930115; bh=AyARZ8O9kOKQYCzMN7H8nfyDa+QfPPanHy+EOHRlTZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iCBSPSqSf/ae2cdGdzoi0nIYnHcl9swtZg5xYgVMHaA+RK+TiTywEm6ndQBr/wYzU
	 W9XUHaRhY1aWw1HH3B0u0+ZF7zat9tAFKGny94W7SHYKCoiEYoNsPxcab1nGWX7kXs
	 UjnJDlDC5Y/MK0I7Dt0NFNeWysLtScQIZpCMMRis7VhTTk/XfQuXr4OUMoz3tgXfv6
	 JRCNeuTZFUpXmXRKqTRPE65/GaKF0vLIWWqkIhd48jenzvqh+zbnQFSIJrmymlXcRz
	 EwapK/485NYNDeYc7YIyP/U8PGGiLNKCg0R618XoWgwCgxvgJYtj8TxbCFvs5LU8qk
	 LyD9oulumYEJA==
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
Subject: [PATCH v2 3/5] reset: th1520: Prepare for supporting multiple controllers
Date: Mon, 15 Sep 2025 09:53:29 +0000
Message-ID: <20250915095331.53350-4-ziyao@disroot.org>
In-Reply-To: <20250915095331.53350-1-ziyao@disroot.org>
References: <20250915095331.53350-1-ziyao@disroot.org>
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


