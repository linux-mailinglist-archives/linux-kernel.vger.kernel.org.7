Return-Path: <linux-kernel+bounces-756633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1CB1B712
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8B76250DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC648279DA2;
	Tue,  5 Aug 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PWdYWMaU"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999B13B58A;
	Tue,  5 Aug 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406286; cv=none; b=J3ZEcMDbmxb02I8fDVtCYKzXThxeBHFMiOkEkdI1+P1DeB4Lfy+vzMQeG3IR0Gy+vqgsDJw+Kxu/p8a0WnWxCQwsac7XigdUEsCfuFT0VzaDj1l5ox6PG0UZGXeUiorYjgrTIl1QL2Ix6GCoHxo4PUSCb2+yhShrkfubqpvk2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406286; c=relaxed/simple;
	bh=9uXW9RaBSeIrf8ozKfFOJ+DzM9/7r0rVkR5meCgzgp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vuhdj4YhPmBKYx7bLjJ+Q7WuUrjfdrsU6ZZjYve4OuLSDeF5co8bQVj4xihrtrQSmL5gYyoY2owpIJPf4bRPkdMmRxICESKxEeTNFTT38WCIFYOdhLXfVtiy1Uh5L5mCC1+Sn5sO3gU/Cu4LH9yh0TiRtYtbbkS/YMBo5m1RPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PWdYWMaU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5AB1C22C1F;
	Tue,  5 Aug 2025 17:04:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iU1ZiM43gRSi; Tue,  5 Aug 2025 17:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754406282; bh=9uXW9RaBSeIrf8ozKfFOJ+DzM9/7r0rVkR5meCgzgp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWdYWMaUUt+Up+//W3siXfruVoiUgyuN3U8azP0BYV3JG+AZSB/Y/m68KjGFTZNVo
	 udBhYrs57WW4x60yUrs3kTPRDfKKkLRniI7suSPEG84vJncZ9bUMseXonY/ay90EGY
	 8rinh+CCdBJt/lnOaeOPvRCT7zSdbOe85b1+IbCU6ZvXESMVfA7NygTwSeTpSJKY49
	 34R093C9au54OGJrAJEqh7ucNB47g2G2fQuLkIFmDct3OEECG5rsQ6NBXI8WlWFcWS
	 h360p8iz5246BSEpmBxMAXGc27N4bNadNroP/aipyN8NNqqmxcuQKQ8hgoZyzyUVUT
	 sv9g+wwbnYWiw==
From: Yao Zi <ziyao@disroot.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 5/8] clk: loongson2: Avoid hardcoding firmware name of the reference clock
Date: Tue,  5 Aug 2025 15:01:44 +0000
Message-ID: <20250805150147.25909-6-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-1-ziyao@disroot.org>
References: <20250805150147.25909-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loongson 2K0300 requires a reference clock with a frequency different
from previous SoCs (120MHz v.s. 100MHz), thus hardcoding the firmware
name of the reference clock as ref_100m isn't a good idea.

This patch retrives the clock name of the reference clock dynamically
during probe, avoiding the hardcoded pdata structure and preparing for
support of future SoCs.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/clk-loongson2.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index 7a916c7d2718..52a9f1c2794a 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -13,10 +13,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <dt-bindings/clock/loongson,ls2k-clk.h>
 
-static const struct clk_parent_data pdata[] = {
-	{ .fw_name = "ref_100m", },
-};
-
 enum loongson2_clk_type {
 	CLK_TYPE_PLL,
 	CLK_TYPE_SCALE,
@@ -275,7 +271,8 @@ static const struct clk_ops loongson2_freqscale_recalc_ops = {
 	.recalc_rate = loongson2_freqscale_recalc_rate,
 };
 
-static struct clk_hw *loongson2_clk_register(struct loongson2_clk_provider *clp,
+static struct clk_hw *loongson2_clk_register(const char *parent,
+					     struct loongson2_clk_provider *clp,
 					     const struct loongson2_clk_board_info *cld,
 					     const struct clk_ops *ops)
 {
@@ -292,11 +289,7 @@ static struct clk_hw *loongson2_clk_register(struct loongson2_clk_provider *clp,
 	init.ops   = ops;
 	init.flags = 0;
 	init.num_parents = 1;
-
-	if (!cld->parent_name)
-		init.parent_data = pdata;
-	else
-		init.parent_names = &cld->parent_name;
+	init.parent_names = &parent;
 
 	clk->reg	= clp->base + cld->reg_offset;
 	clk->div_shift	= cld->div_shift;
@@ -321,11 +314,17 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct loongson2_clk_provider *clp;
 	const struct loongson2_clk_board_info *p, *data;
+	const char *refclk_name, *parent_name;
 
 	data = device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
+	refclk_name = of_clk_get_parent_name(dev->of_node, 0);
+	if (IS_ERR(refclk_name))
+		return dev_err_probe(dev, PTR_ERR(refclk_name),
+				     "failed to get refclk name\n");
+
 	for (p = data; p->name; p++)
 		clks_num = max(clks_num, p->id + 1);
 
@@ -347,18 +346,20 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 
 	for (i = 0; i < clks_num; i++) {
 		p = &data[i];
+		parent_name = p->parent_name ? p->parent_name : refclk_name;
+
 		switch (p->type) {
 		case CLK_TYPE_PLL:
-			hw = loongson2_clk_register(clp, p,
+			hw = loongson2_clk_register(parent_name, clp, p,
 						    &loongson2_pll_recalc_ops);
 			break;
 		case CLK_TYPE_SCALE:
-			hw = loongson2_clk_register(clp, p,
+			hw = loongson2_clk_register(parent_name, clp, p,
 						    &loongson2_freqscale_recalc_ops);
 			break;
 		case CLK_TYPE_DIVIDER:
 			hw = devm_clk_hw_register_divider(dev, p->name,
-							  p->parent_name, 0,
+							  parent_name, 0,
 							  clp->base + p->reg_offset,
 							  p->div_shift, p->div_width,
 							  CLK_DIVIDER_ONE_BASED |
@@ -366,15 +367,15 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 							  &clp->clk_lock);
 			break;
 		case CLK_TYPE_GATE:
-			hw = devm_clk_hw_register_gate(dev, p->name, p->parent_name,
+			hw = devm_clk_hw_register_gate(dev, p->name, parent_name,
 						       p->flags,
 						       clp->base + p->reg_offset,
 						       p->bit_idx, 0,
 						       &clp->clk_lock);
 			break;
 		case CLK_TYPE_FIXED:
-			hw = devm_clk_hw_register_fixed_rate_parent_data(dev, p->name, pdata,
-									 0, p->fixed_rate);
+			hw = devm_clk_hw_register_fixed_rate(dev, p->name, parent_name,
+							     0, p->fixed_rate);
 			break;
 		default:
 			return dev_err_probe(dev, -EINVAL, "Invalid clk type\n");
-- 
2.50.1


