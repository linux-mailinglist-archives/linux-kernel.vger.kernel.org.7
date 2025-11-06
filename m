Return-Path: <linux-kernel+bounces-889334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E526C3D4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5AB4E47DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1335580A;
	Thu,  6 Nov 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2FUT7Ls"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AC2DCC1C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459188; cv=none; b=m6gs6IV0wPuu68lj9+QAHJDJIDHEQfsT7aXr0WzaMQ0oLFTYuqNB4RyZAhnTm0zvutRZ8GRjru95Llkhkbr7JxoS8OuZ0i0jDCLLAjLIMVsc4kY9twoipbyQ1FoNTKJcmoLm0vhSdAhwqn/xe739bVeNyOx5dJAocBocVR2wivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459188; c=relaxed/simple;
	bh=XVTIKGDo9ThWVGg8qcTaNRRTvL4SJHb9lTtxpWqTLR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scPDFAWpCIiq1N5xnQ+KxSNeSvMJDqtgSH4825jBG9uJwmge1bqdvgbGGyNKHANFSXzrR2CDmOUBlfxFgBYoz5r8EKWMPCXhR0K4RMwLqT+lA7IGo/cXx12S+XJpEpYH177FPWshjmT6/erCypPnAoB77rnnN9MYIk5YZVBjtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2FUT7Ls; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477563bcaacso127665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459185; x=1763063985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pskgOVcQzGBDwVn3zzaWjuy3GbH8LGu28I4+iALHLrM=;
        b=P2FUT7LsBsiU6GnjcZNCkpoPY8GmlU06WipPPWS11sVCDDXYtvUydGadQJjJlOBtPD
         QnIbv3AdbfuilT2hxaj7rGykcv1cWGaWhq0LpSfBgoA6aRjTlYWhm4/rOfl+HtF+0/nv
         sj1u7se8xdJhJXY0dQeRaKF7dmNqlBSDlL2ROOleWcQmuWCqFjSBR9i2agpsT76O+za8
         mQIWInDQ8seY96aNYe2P2TFL+zDvyufLpGXV/I86W8lH28V/m3lHtChXGY4Y8G4Q2nL1
         IKVpnv4TpbnrZUYnFmLKs0QtuIRc2wfHVTwP2MKyKCsC+hrcr7roBSEv+UqIQhgJPMrt
         ON0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459185; x=1763063985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pskgOVcQzGBDwVn3zzaWjuy3GbH8LGu28I4+iALHLrM=;
        b=cdFVHnLi7l1sy53lH6Xllzb1ZvUkpSYAq3kgjg3Sp7IPpzLSnDjWXJlhWNomCSpcao
         Xj/CMDmCw9f5GndPguer3NpVUFVQaSsWGsuHQkIK+IE+Dz8VoNuvUcg7F3qD9Y/oGCbc
         BLPMWzt1BckOxymYMqcNXHJu02d5bwV8WFGd/+7dVc6KZO76NQxRd1+EQ9IdAtVg/52A
         0X+t/Apf8CE673r8/zZEa9rKfHdZ8EdM4pSKW495zxIJpONQYvp+x6C7N7JvNf1big9o
         X40lGWvV2Fixkd+JygYxjrNRp1kB28NPd9+ijgXnW6uZDOC5ilLsez7tiFKsLa09vDN3
         zcNw==
X-Forwarded-Encrypted: i=1; AJvYcCUoCPMbAWtQQQOpGourCgZGQUv5WsG6ZhtVgV+ur6s/mSsZXOB9ex+5Ulj7HS56/4qUTMLngVGly1QhaXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLR505m666RvNs+ZECJqslosq+nDLSeUPlaszHAHtRWeB8pU+V
	sLY8NSWNAwo2OFyqa4gSD49L4hxvfMtL7ngSiE1uVjA5uSdKtvmzBXWr
X-Gm-Gg: ASbGnct3+usgIZodxRr84Ee6PoEnzJqpZKcMRuG/p3xfEh/MhsTV7uZA0X7SArRcplN
	q3Ohnen8CnO2aN/3tMmU/R7bhI24zYcogLcgpcg8W35JqgBJVe9JR3ObHq073Sz2vFJkLBHihSr
	I3NbNybO4CxA1f2dhFbMi4VdpSf+1MvGAV1xm12nQ76JoHtwYF7nzsQZH1qc3vwejs/quEKEEOi
	fjrUF81/eE0DsIta6nnpk+EigSy5g2lqviZmc0stuGyjm9Sg53v/6nCUhxiMgXp94dODGKc1JQg
	rgXbLFjL1zloxHaKu0u4UX04qJ+Wf9hbIt1sORY63o3hn3znsnIZFxOaCQxSi+U6cvLBrBL2AOW
	rk8Ndq4F9MsVvz0Dyf/v217A0P2plF9sl+HoFqcIai9uEQvgxI4zztNo4B2Cb6GcgnfrZyvHR/W
	L0ilPwPmEUTOhKtXAcGxvZSdw7JK/CMw==
X-Google-Smtp-Source: AGHT+IEefEb23D7rQRXsWY+IYQ7blyDScwcNUJaMoeGyD2G8x7lssAcK9wUXEK+8MlfDjlAHquSykw==
X-Received: by 2002:a05:600c:1d28:b0:475:dd59:d8d8 with SMTP id 5b1f17b1804b1-4776bc88c55mr4372585e9.8.1762459184729;
        Thu, 06 Nov 2025 11:59:44 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm990037f8f.5.2025.11.06.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:59:44 -0800 (PST)
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
Subject: [PATCH v3 2/5] clk: en7523: generalize register clocks function
Date: Thu,  6 Nov 2025 20:59:29 +0100
Message-ID: <20251106195935.1767696-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106195935.1767696-1-ansuelsmth@gmail.com>
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
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


