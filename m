Return-Path: <linux-kernel+bounces-728632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D1B02B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F3B1C21AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A26278767;
	Sat, 12 Jul 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xLIuR7Xx"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D527874A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328499; cv=none; b=ovFE9/1962ZyAwpcAUE3eCcFzpi6odqxtdzx5UAeaYWsx9sk6e/pb+HPs5umugWg+8n1ZfCcmUzZfwCcu93rdlgYKLAldaIJwCT4JAUqAglxWWyctjWr8pMQwv9CQnlNsIlY15iiIrGlDJmzRgi947x4wCpz3jKLjMgYVgYH2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328499; c=relaxed/simple;
	bh=3bgcB1TurwhT7L9X2KCmbojs72aEaLZWW2bUy/QsO0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o3p+JClYZsxnXi6Vj4L+/ixrD5uIc9Y6d2pUhM3L1JcdKvmsNYZ0GpPamgHUUvTiXc+di+5Jpw4jD/QRlRn24riug22MRpIrTVB1yRAfl+eAMgg4Dki7xAluKvjjpEKIc+nsmO/xwFzjKkXGWGCx4SOqU5khX5QZAP3YFzRN3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xLIuR7Xx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752328484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kRD9GIGPAcl9+9P+wxlR8UOcfZFBQSucv2vMLbdggbU=;
	b=xLIuR7XxssCPgWrpAWX6KhdeLgfSZm9ysPUvboMvBIo8LQL8Ap9TdANcGPc/8jgXMKRJMj
	nlHqr7f5qAtor9nOxYXwezNvzz812lHV+5C1xl1y9qVCiLI4mF+6sOSNsF0YLLIeMqFg2L
	kCI3TzVhwtdOJlyNU6yq9/WlC9Rr13o=
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Sat, 12 Jul 2025 21:54:35 +0800
Subject: [PATCH] ASoC: rockchip: i2s: simplify clock handling and error
 cleanup in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-rockchip-i2s-simplify-clk-v1-1-3b23fd1b3e26@linux.dev>
X-B4-Tracking: v=1; b=H4sIABppcmgC/x3MQQqDMBBG4avIrDuQRCXQq5Qu2jjRH62GDEgle
 HeDy2/xXiGVDFF6NoWy7FBsa4V9NBSmzzoKY6gmZ1xvvHWctzCHCYnhlBW/tCAeHJaZxXjT9T4
 O39ZS7VOWiP/9fr3P8wLSOgSMawAAAA==
X-Change-ID: 20250712-rockchip-i2s-simplify-clk-e070457fdb31
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752328479; l=4147;
 i=troy.mitchell@linux.dev; s=20250712; h=from:subject:message-id;
 bh=3bgcB1TurwhT7L9X2KCmbojs72aEaLZWW2bUy/QsO0Y=;
 b=p4ygt/SPN0WzYAquOnuf0wpNUMCA+lbmD7jSoi9sBqx1GRoMNauMF41Zbx2G6x+OmQYVZFzsi
 opM26vamUVkAZG6iJJch82NRs8/tqFdUlNa9fx84WRY72rxTvOpvL7T
X-Developer-Key: i=troy.mitchell@linux.dev; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-Migadu-Flow: FLOW_OUT

Replace devm_clk_get + clk_prepare_enable with devm_clk_get_enabled
to simplify clock acquisition and enabling.

Use dev_err_probe for concise error logging and return handling,
reducing boilerplate code and improving readability.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
 sound/soc/rockchip/rockchip_i2s.c | 51 +++++++++++----------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 0a0a95b4f5204701b52ca924683d51c29992015d..bd1b5771ae7c6f91e57c0fe3579a3d9974839f8e 100644
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
@@ -757,38 +757,23 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
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
+		return dev_err_probe(&pdev->dev, ret, "Failed to initialise managed register map");
 
 	i2s->bclk_ratio = 64;
 	i2s->pinctrl = devm_pinctrl_get(&pdev->dev);
@@ -796,11 +781,9 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
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
@@ -843,20 +826,14 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
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


