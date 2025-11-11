Return-Path: <linux-kernel+bounces-895779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEA4C4EE39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5C4E4E9D96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2C36C59B;
	Tue, 11 Nov 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY1oZ1N6"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0336B06A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876596; cv=none; b=MYWs59AMtLoZubBvDFjCx88Yd/MBZHSVGsYPq2Nk8hjxDnQHr1aoxoSF7me2xbKT4ZifNNn0clIiLnF/WcoGAACisw7hnC5y+M814ZMH0j46VF7yAYwTbfCgNRoIyJF5dlZpyYKDsjX9MTAW03uJvg8qPlkRQ5Hj7qIXcipNxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876596; c=relaxed/simple;
	bh=XVTIKGDo9ThWVGg8qcTaNRRTvL4SJHb9lTtxpWqTLR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDEpxcnUJwqVzUvqKh1VUOpYYXrVwsEp5e4TEwPYuGYhFWuV9mFLWRHdxB8uuhcXjX32gdFa9gkrOa+EBTppnyKe5ZUmFdQ3SonKOkdQR5mU1e9ptcjGgQcg29SwkFUbW/MJebGjyghNY4DeUoC1niXGoq3tUXYoldP0vOWaj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY1oZ1N6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so21234745e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876593; x=1763481393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pskgOVcQzGBDwVn3zzaWjuy3GbH8LGu28I4+iALHLrM=;
        b=SY1oZ1N6fAUVuuKYBYIkAaIgjOut1rWEmwS0XeF2FjfIDTBjMH019fwwgxiPMDCJlY
         k+Kg5cCezOowMoH4XcqARP6tzSlDp7W78MbLh9t0L2SkWPgAQ5yz4VDD7mP/1vqKIHFW
         8VQrFlSmW0sVAAjM6RbyCsVHZYv0XznXAsTB7FJozipH6oFVb0yqqBo7e6OO+nO5cvkb
         dIq3k5otIGg/fYJnD4Rdrivd6hHDr6LQtu8uPy4idInQLGMxCQfBMaCFLtbVQT0e/5D5
         LJHSAiL+dfu/Q2Vhf/YCy3Pbr5GSKJ9W4vaxyQZoe/upBfvV0Yx6iFnOcFeSuwvn+GsY
         i9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876593; x=1763481393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pskgOVcQzGBDwVn3zzaWjuy3GbH8LGu28I4+iALHLrM=;
        b=QMIwO9iTo/noslFsLf3z8S280wUu/4h7dGiCfQM2gSLuZIJa7+GTdVOtwZ1Of/WzI7
         dqO3bhqAdja5fyc1sut/L4zvAmm9Tg2kJJDoSQ87/Nw3xNVaLiJP+rvZ4BJPZINQ/u2m
         57C7mD3Z737P2k6umJCjjGsJEj8dzxLVJoU7oZYyKcHbFhKSFz2gQ9buuX3+lH8AR4nK
         E1L3NxEj34uHtu7cRLF09oA/Teuuqbe8pyVHhcafeLFfIyOWgi6+IczujeGQtP4SBNY3
         jT/LoaQQ3NJ8r2mIFgmLejuL14cjREhy/umVckSYRs9qlNN+BZzOxRj+RAB/c0/hmbn1
         zbeg==
X-Forwarded-Encrypted: i=1; AJvYcCX1XTyUQIFiRJ5YLsmESDomgpLYQyCI/nQbLBsRd3E9a4GdfxIPG7jSXFj4j3rg1SbEnVXrsfnyrLblXYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqo4x43MyO4zs0IT1jG/tXdeLV733pJkQMLaHnlqBduuf06yz4
	jOP7hwj1/7ATJCH9AKwGY3Pswp+++FRpcIxfKxDlrXoAdvfoK01HKMxa
X-Gm-Gg: ASbGncsIPqjJXlXYr0KY0JwRd5vmb9/bpx9RCcLc4YmaCvVAkFDmgPBIJrnEqoxpT8N
	d211ViiEoLdi9dRf5meWVxim+c2yFDCjR2INJ7A5StRy4ZEDLYUzAP4Vse5DuktjSkZuLBbpH3N
	JpqKNH6Mzsm1EP2kj5xai/uZskY/XdURPWy18JCx/fqO1IyJUioHqvOlpZRoyftDE/EcgZ91qCo
	jLXH3YxBjX4JmpwYxG5EFGfqgBeu8adeiCU7UTVDcYYkmbABZ9QZsOLvODV7ZDUOOCi1/PVPxtC
	LIcwV+XVV9vYOCAODMvVk0gURC1GY1qo7dx9v8o1YBpf7nse4GGMguM0yiKSEsqD8ESzmgrb3Ja
	/i6SDHgS51xxXKDdtylRvIrFgH2y6/orIz84zROREBV+8HEQFsqHzcg1EHsB7GtWoXLk4tbbuHh
	JoBMagVMjpjm7raoRU2EFrpZC3YJ8vBCeUA8nFKJxw
X-Google-Smtp-Source: AGHT+IGNg1qYMZqiG3WtGb0ldIMecp9uKwNT0ppjRrCM4YhFq4IcRBoJvBHU+lPwykx7FsAHAwE8Tw==
X-Received: by 2002:a05:6000:26ce:b0:42b:4219:269 with SMTP id ffacd0b85a97d-42b42190643mr4381837f8f.41.1762876592349;
        Tue, 11 Nov 2025 07:56:32 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm28676766f8f.19.2025.11.11.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:56:31 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 2/5] clk: en7523: generalize register clocks function
Date: Tue, 11 Nov 2025 16:56:18 +0100
Message-ID: <20251111155623.9024-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111155623.9024-1-ansuelsmth@gmail.com>
References: <20251111155623.9024-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize register clocks function for Airoha EN7523 and EN7581 clocks
driver. The same logic is applied for both clock hence code can be
reduced and simplified by putting the base_clocks struct in the soc_data
and passing that to a generic register clocks function.

While at it rework some function to return error and use devm variant
for clk_hw_regiser.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 148 +++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 314e7450313f..b040f0f0d727 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -78,8 +78,10 @@ struct en_rst_data {
 
 struct en_clk_soc_data {
 	u32 num_clocks;
+	const struct en_clk_desc *base_clks;
 	const struct clk_ops pcie_ops;
 	int (*hw_init)(struct platform_device *pdev,
+		       const struct en_clk_soc_data *soc_data,
 		       struct clk_hw_onecell_data *clk_data);
 };
 
@@ -450,10 +452,11 @@ static struct clk_hw *en7523_register_pcie_clk(struct device *dev,
 		.ops = &soc_data->pcie_ops,
 	};
 	struct en_clk_gate *cg;
+	int err;
 
 	cg = devm_kzalloc(dev, sizeof(*cg), GFP_KERNEL);
 	if (!cg)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	cg->map = clk_map;
 	cg->hw.init = &init;
@@ -461,12 +464,62 @@ static struct clk_hw *en7523_register_pcie_clk(struct device *dev,
 	if (init.ops->unprepare)
 		init.ops->unprepare(&cg->hw);
 
-	if (clk_hw_register(dev, &cg->hw))
-		return NULL;
+	err = devm_clk_hw_register(dev, &cg->hw);
+	if (err)
+		return ERR_PTR(err);
 
 	return &cg->hw;
 }
 
+static int en75xx_register_clocks(struct device *dev,
+				  const struct en_clk_soc_data *soc_data,
+				  struct clk_hw_onecell_data *clk_data,
+				  struct regmap *map, struct regmap *clk_map)
+{
+	struct clk_hw *hw;
+	u32 rate;
+	int i;
+
+	for (i = 0; i < soc_data->num_clocks - 1; i++) {
+		const struct en_clk_desc *desc = &soc_data->base_clks[i];
+		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
+		int err;
+
+		err = regmap_read(map, desc->base_reg, &val);
+		if (err) {
+			pr_err("Failed reading fixed clk rate %s: %d\n",
+			       desc->name, err);
+			return err;
+		}
+		rate = en7523_get_base_rate(desc, val);
+
+		err = regmap_read(map, reg, &val);
+		if (err) {
+			pr_err("Failed reading fixed clk div %s: %d\n",
+			       desc->name, err);
+			return err;
+		}
+		rate /= en7523_get_div(desc, val);
+
+		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %ld\n",
+			       desc->name, PTR_ERR(hw));
+			return PTR_ERR(hw);
+		}
+
+		clk_data->hws[desc->id] = hw;
+	}
+
+	hw = en7523_register_pcie_clk(dev, clk_map);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	clk_data->hws[EN7523_CLK_PCIE] = hw;
+
+	return 0;
+}
+
 static int en7581_pci_is_enabled(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
@@ -504,38 +557,6 @@ static void en7581_pci_disable(struct clk_hw *hw)
 	usleep_range(1000, 2000);
 }
 
-static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   struct regmap *map, struct regmap *clk_map)
-{
-	struct clk_hw *hw;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(en7523_base_clks); i++) {
-		const struct en_clk_desc *desc = &en7523_base_clks[i];
-		u32 reg = desc->div_reg ? desc->div_reg : desc->base_reg;
-		u32 val;
-
-		regmap_read(map, desc->base_reg, &val);
-
-		rate = en7523_get_base_rate(desc, val);
-		regmap_read(map, reg, &val);
-		rate /= en7523_get_div(desc, val);
-
-		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
-		if (IS_ERR(hw)) {
-			pr_err("Failed to register clk %s: %ld\n",
-			       desc->name, PTR_ERR(hw));
-			continue;
-		}
-
-		clk_data->hws[desc->id] = hw;
-	}
-
-	hw = en7523_register_pcie_clk(dev, clk_map);
-	clk_data->hws[EN7523_CLK_PCIE] = hw;
-}
-
 static const struct regmap_config en7523_clk_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -543,6 +564,7 @@ static const struct regmap_config en7523_clk_regmap_config = {
 };
 
 static int en7523_clk_hw_init(struct platform_device *pdev,
+			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	void __iomem *base, *np_base;
@@ -566,51 +588,7 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(clk_map))
 		return PTR_ERR(clk_map);
 
-	en7523_register_clocks(&pdev->dev, clk_data, map, clk_map);
-
-	return 0;
-}
-
-static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   struct regmap *map, struct regmap *clk_map)
-{
-	struct clk_hw *hw;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(en7581_base_clks); i++) {
-		const struct en_clk_desc *desc = &en7581_base_clks[i];
-		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
-		int err;
-
-		err = regmap_read(map, desc->base_reg, &val);
-		if (err) {
-			pr_err("Failed reading fixed clk rate %s: %d\n",
-			       desc->name, err);
-			continue;
-		}
-		rate = en7523_get_base_rate(desc, val);
-
-		err = regmap_read(map, reg, &val);
-		if (err) {
-			pr_err("Failed reading fixed clk div %s: %d\n",
-			       desc->name, err);
-			continue;
-		}
-		rate /= en7523_get_div(desc, val);
-
-		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
-		if (IS_ERR(hw)) {
-			pr_err("Failed to register clk %s: %ld\n",
-			       desc->name, PTR_ERR(hw));
-			continue;
-		}
-
-		clk_data->hws[desc->id] = hw;
-	}
-
-	hw = en7523_register_pcie_clk(dev, clk_map);
-	clk_data->hws[EN7523_CLK_PCIE] = hw;
+	return en75xx_register_clocks(&pdev->dev, soc_data, clk_data, map, clk_map);
 }
 
 static int en7523_reset_update(struct reset_controller_dev *rcdev,
@@ -689,10 +667,12 @@ static int en7581_reset_register(struct device *dev, struct regmap *map)
 }
 
 static int en7581_clk_hw_init(struct platform_device *pdev,
+			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *map, *clk_map;
 	void __iomem *base;
+	int ret;
 
 	map = syscon_regmap_lookup_by_compatible("airoha,en7581-chip-scu");
 	if (IS_ERR(map))
@@ -706,7 +686,9 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(clk_map))
 		return PTR_ERR(clk_map);
 
-	en7581_register_clocks(&pdev->dev, clk_data, map, clk_map);
+	ret = en75xx_register_clocks(&pdev->dev, soc_data, clk_data, map, clk_map);
+	if (ret)
+		return ret;
 
 	regmap_clear_bits(clk_map, REG_NP_SCU_SSTR,
 			  REG_PCIE_XSI0_SEL_MASK | REG_PCIE_XSI1_SEL_MASK);
@@ -732,7 +714,7 @@ static int en7523_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk_data->num = soc_data->num_clocks;
-	r = soc_data->hw_init(pdev, clk_data);
+	r = soc_data->hw_init(pdev, soc_data, clk_data);
 	if (r)
 		return r;
 
@@ -740,6 +722,7 @@ static int en7523_clk_probe(struct platform_device *pdev)
 }
 
 static const struct en_clk_soc_data en7523_data = {
+	.base_clks = en7523_base_clks,
 	.num_clocks = ARRAY_SIZE(en7523_base_clks) + 1,
 	.pcie_ops = {
 		.is_enabled = en7523_pci_is_enabled,
@@ -750,6 +733,7 @@ static const struct en_clk_soc_data en7523_data = {
 };
 
 static const struct en_clk_soc_data en7581_data = {
+	.base_clks = en7581_base_clks,
 	/* We increment num_clocks by 1 to account for additional PCIe clock */
 	.num_clocks = ARRAY_SIZE(en7581_base_clks) + 1,
 	.pcie_ops = {
-- 
2.51.0


