Return-Path: <linux-kernel+bounces-735218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC5B08C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEF2A6370C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971929B767;
	Thu, 17 Jul 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hp8awFxx"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9A136358
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753516; cv=none; b=UHE82UYJ/C6gM7/GoKHl5daRsV83cq8Ckn3wbAkPcE51SDOLz41/ijYF7AaQgL8ypLl9rIeDLEcEBGdbUhF8Ae1R+A4KQDS2yyCG/8TSvHrJXlihMJRdMZ5yS7REhNu3oSDjUrEvrFdldSCU9uvrXxqe6MZgT9/VMEMjjgcM3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753516; c=relaxed/simple;
	bh=5U5+oKM9TS56skKvfyBUuonPmWf8aGSQ+l3JH2CKHPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rdA5osKO/0rLRBuafWzXHNUC/y65lqv04q2mQkSNeGpw5Armg0wLyLiX+vIMcxfYfI65nmI7+9uNWbJg2k5Rj7cTV5qIAFXnbtsFHMvs1hRSDOKVe7oAKdHWcweM1+QEfvpB0srAsa7e8KhC7UtC1Awet2N+KE+GT4rdzGPpipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hp8awFxx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752753501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xA00jKif1Xuf/U1rsSjs5Phuq/bmyeN3v9XfSiZkCX0=;
	b=Hp8awFxxYJS44VzcWpL9s0NNCpc4wJENQzB7wswBrKcAaKncIeFm7UkWaHc97p3N9uB/XL
	k7X+Pj7r0RD1hY/pyh2D6F+IqsJbFy2WZL6Npyl/tgVjIFK7Y1ab8xrO2ao6IE50B7vtmo
	qtHcX7uXNdK8x7JjAvwwa/D979GnoMQ=
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Thu, 17 Jul 2025 19:58:01 +0800
Subject: [PATCH v2] ASoC: rockchip: i2s: simplify clock handling and error
 cleanup in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-rockchip-i2s-simplify-clk-v2-1-b697542a7c32@linux.dev>
X-B4-Tracking: v=1; b=H4sIAEjleGgC/42NQQ6CMBBFr0Jm7Zh2KpK48h6EhbRTmYBAWm0gh
 LtbOYHL95L//gaRg3CEW7FB4CRRpjEDnQqw3WN8MorLDKSoVJUmDJPtbSczCkWM8poH8SvaoUd
 WlbqUlXet0ZD3c2Avy9Gum8ydxPcU1uMq6Z/9p5o0ajQtGe90a5iu90HGz3J2nKDZ9/0LrI/EU
 8IAAAA=
X-Change-ID: 20250712-rockchip-i2s-simplify-clk-e070457fdb31
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752753489; l=4356;
 i=troy.mitchell@linux.dev; s=20250712; h=from:subject:message-id;
 bh=5U5+oKM9TS56skKvfyBUuonPmWf8aGSQ+l3JH2CKHPI=;
 b=H3hkHMXg+LJmKavNAJi6r6t4igwPotof77JG4whPYAh5YKQkdHsjFaSDCELs6RIYLtRrQpeke
 aK/5osgdscRDVYT5GW9fb2mt9rGyqmXcehKlwzBOhMHud0Y+c6hEvEE
X-Developer-Key: i=troy.mitchell@linux.dev; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-Migadu-Flow: FLOW_OUT

Replace devm_clk_get + clk_prepare_enable with devm_clk_get_enabled
to simplify clock acquisition and enabling.

Use dev_err_probe for concise error logging and return handling,
reducing boilerplate code and improving readability.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
Changes in v2:
- Fix return value of regmap resource(robot's warning)
- Link to v1: https://lore.kernel.org/r/20250712-rockchip-i2s-simplify-clk-v1-1-3b23fd1b3e26@linux.dev
---
 sound/soc/rockchip/rockchip_i2s.c | 52 +++++++++++----------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 0a0a95b4f5204701b52ca924683d51c29992015d..1dba2d9b2241860a9d87dd4319b135dc249d8e17 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -31,7 +31,6 @@ struct rk_i2s_pins {
 struct rk_i2s_dev {
 	struct device *dev;
 
-	struct clk *hclk;
 	struct clk *mclk;
 
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
@@ -739,6 +738,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	struct snd_soc_dai_driver *dai;
 	struct resource *res;
 	void __iomem *regs;
+	struct clk *clk;
 	int ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
@@ -757,38 +757,24 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	}
 
 	/* try to prepare related clocks */
-	i2s->hclk = devm_clk_get(&pdev->dev, "i2s_hclk");
-	if (IS_ERR(i2s->hclk)) {
-		dev_err(&pdev->dev, "Can't retrieve i2s bus clock\n");
-		return PTR_ERR(i2s->hclk);
-	}
-	ret = clk_prepare_enable(i2s->hclk);
-	if (ret) {
-		dev_err(i2s->dev, "hclock enable failed %d\n", ret);
-		return ret;
-	}
+	clk = devm_clk_get_enabled(&pdev->dev, "i2s_hclk");
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "hclock enable failed");
 
 	i2s->mclk = devm_clk_get(&pdev->dev, "i2s_clk");
-	if (IS_ERR(i2s->mclk)) {
-		dev_err(&pdev->dev, "Can't retrieve i2s master clock\n");
-		ret = PTR_ERR(i2s->mclk);
-		goto err_clk;
-	}
+	if (IS_ERR(i2s->mclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->mclk),
+				     "Can't retrieve i2s master clock");
 
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		goto err_clk;
-	}
+	if (IS_ERR(regs))
+		dev_err_probe(&pdev->dev, PTR_ERR(regs), "Can't ioremap registers");
 
 	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
 					    &rockchip_i2s_regmap_config);
-	if (IS_ERR(i2s->regmap)) {
-		dev_err(&pdev->dev,
-			"Failed to initialise managed register map\n");
-		ret = PTR_ERR(i2s->regmap);
-		goto err_clk;
-	}
+	if (IS_ERR(i2s->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->regmap),
+				     "Failed to initialise managed register map");
 
 	i2s->bclk_ratio = 64;
 	i2s->pinctrl = devm_pinctrl_get(&pdev->dev);
@@ -796,11 +782,9 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		i2s->bclk_on = pinctrl_lookup_state(i2s->pinctrl, "bclk_on");
 		if (!IS_ERR_OR_NULL(i2s->bclk_on)) {
 			i2s->bclk_off = pinctrl_lookup_state(i2s->pinctrl, "bclk_off");
-			if (IS_ERR_OR_NULL(i2s->bclk_off)) {
-				dev_err(&pdev->dev, "failed to find i2s bclk_off\n");
-				ret = -EINVAL;
-				goto err_clk;
-			}
+			if (IS_ERR_OR_NULL(i2s->bclk_off))
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "failed to find i2s bclk_off");
 		}
 	} else {
 		dev_dbg(&pdev->dev, "failed to find i2s pinctrl\n");
@@ -843,20 +827,14 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		i2s_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-err_clk:
-	clk_disable_unprepare(i2s->hclk);
 	return ret;
 }
 
 static void rockchip_i2s_remove(struct platform_device *pdev)
 {
-	struct rk_i2s_dev *i2s = dev_get_drvdata(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
-
-	clk_disable_unprepare(i2s->hclk);
 }
 
 static const struct dev_pm_ops rockchip_i2s_pm_ops = {

---
base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
change-id: 20250712-rockchip-i2s-simplify-clk-e070457fdb31

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.dev>


