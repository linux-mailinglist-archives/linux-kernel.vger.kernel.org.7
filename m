Return-Path: <linux-kernel+bounces-602625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E18A87D36
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D5188E44E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3F269892;
	Mon, 14 Apr 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCrmAO5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42674267386;
	Mon, 14 Apr 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625576; cv=none; b=GwjP513uQ7whslbsz7KEfJEOiOd79l2mYPzIt8YGu/GEhrpzyCRtXjfkx2ZzRplOTmQYDdR+W4Ku/WsIlrGicgHNLQLQGLLrNuiaorCqk6kcYY7kwOmDpIZIvkrGUybnh7D7BOCGT5ZZlP1CbjjK8vUCcdf7wgu0ZFhlZGgW0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625576; c=relaxed/simple;
	bh=Wutptj4TTqatUZ3B9nw/6gxUA67cI9AYWKb8DByZ0sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FP8ZIfpPnYhNQWMNOkiJ9pExZEgHAkIgfoyGEStS7pjhmbm9+P3GIi0wUKVI4m/aIp6wghmS/z3NAV1Mpwx5+LgBaqZ0wdirdTWHqYkzGT/YMp5BMFLfPcWjGxkew1Vi1n6K0ZDAqJU8beDH5UAK/gzU9dhDu9pG4mEqDyXSmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCrmAO5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9B7C4CEE5;
	Mon, 14 Apr 2025 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625575;
	bh=Wutptj4TTqatUZ3B9nw/6gxUA67cI9AYWKb8DByZ0sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aCrmAO5Ubm6/7WN6Q9vVluLDsdS5puZF5L1qyhtA0vS/433vmsaItPjeZpoXKIAn8
	 gWupjkRoV+6uVfMSy82Wtu92uKbndd5oIVeKlmlq4TYHjlN1vk8iOvBeE4jELmp/dv
	 ZIUz1ctxcRgecTGmyXOGzmHSVopCx2KspivhXockDzpkDq+jafYcbL3LFHSawDnMHV
	 6zFiKoHzfNSrVuBHWPd9Kc0gPdu1frUctvppV+f5C89pErV5JCD/IAoHeA504xcOmR
	 ccTCpvtAkfrBhP7WwIqktXTa6sxKY4B8W2d7MVmnDwnUgd/rMnb1HX3Dpk1RMpeoSR
	 rm0lQ3OoTsgAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E3C369B6;
	Mon, 14 Apr 2025 10:12:55 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 14 Apr 2025 18:12:28 +0800
Subject: [PATCH v2 1/7] soc: amlogic: clk-measure: Define MSR_CLK's
 register offset separately
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-clk-measure-v2-1-65077690053a@amlogic.com>
References: <20250414-clk-measure-v2-0-65077690053a@amlogic.com>
In-Reply-To: <20250414-clk-measure-v2-0-65077690053a@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744625573; l=5775;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=By8GsacXTpSc4iTBr14dvYmj461RtPWVVIfMTZf+l5Y=;
 b=/Oan9OrYDRaJKIk9TmWDumuW8ZdHbA9Q7ZQA7WnSCPfQUtundkqmeSBf1bknFCImosyx6Ql8+
 aa6NsdwtApqCeZpY4nY0YSWt7Y1c2FsoP8sbUa58K762wYbYHNdFjfy
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Since the MSR_CLK register offset differs between chip variants, we
replace the macro-based definition with chip-specific assignments.

Change the max_register in regmap_config to be retrieved from DTS.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 54 ++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 39638d6a593c..82c008ade894 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -14,11 +14,6 @@
 
 static DEFINE_MUTEX(measure_lock);
 
-#define MSR_CLK_DUTY		0x0
-#define MSR_CLK_REG0		0x4
-#define MSR_CLK_REG1		0x8
-#define MSR_CLK_REG2		0xc
-
 #define MSR_DURATION		GENMASK(15, 0)
 #define MSR_ENABLE		BIT(16)
 #define MSR_CONT		BIT(17) /* continuous measurement */
@@ -39,9 +34,17 @@ struct meson_msr_id {
 	const char *name;
 };
 
+struct msr_reg_offset {
+	unsigned int duty_val;
+	unsigned int freq_ctrl;
+	unsigned int duty_ctrl;
+	unsigned int freq_val;
+};
+
 struct meson_msr_data {
 	struct meson_msr_id *msr_table;
 	unsigned int msr_count;
+	struct msr_reg_offset *reg;
 };
 
 struct meson_msr {
@@ -495,6 +498,7 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 			    unsigned int duration)
 {
 	struct meson_msr *priv = clk_msr_id->priv;
+	struct msr_reg_offset *reg = priv->data.reg;
 	unsigned int val;
 	int ret;
 
@@ -502,22 +506,22 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 	if (ret)
 		return ret;
 
-	regmap_write(priv->regmap, MSR_CLK_REG0, 0);
+	regmap_write(priv->regmap, reg->freq_ctrl, 0);
 
 	/* Set measurement duration */
-	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_DURATION,
+	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_DURATION,
 			   FIELD_PREP(MSR_DURATION, duration - 1));
 
 	/* Set ID */
-	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
+	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_CLK_SRC,
 			   FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id));
 
 	/* Enable & Start */
-	regmap_update_bits(priv->regmap, MSR_CLK_REG0,
+	regmap_update_bits(priv->regmap, reg->freq_ctrl,
 			   MSR_RUN | MSR_ENABLE,
 			   MSR_RUN | MSR_ENABLE);
 
-	ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
+	ret = regmap_read_poll_timeout(priv->regmap, reg->freq_ctrl,
 				       val, !(val & MSR_BUSY), 10, 10000);
 	if (ret) {
 		mutex_unlock(&measure_lock);
@@ -525,10 +529,10 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 	}
 
 	/* Disable */
-	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
+	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_ENABLE, 0);
 
 	/* Get the value in multiple of gate time counts */
-	regmap_read(priv->regmap, MSR_CLK_REG2, &val);
+	regmap_read(priv->regmap, reg->freq_val, &val);
 
 	mutex_unlock(&measure_lock);
 
@@ -599,11 +603,10 @@ static int clk_msr_summary_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(clk_msr_summary);
 
-static const struct regmap_config meson_clk_msr_regmap_config = {
+static struct regmap_config meson_clk_msr_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = MSR_CLK_REG2,
 };
 
 static int meson_msr_probe(struct platform_device *pdev)
@@ -611,6 +614,7 @@ static int meson_msr_probe(struct platform_device *pdev)
 	const struct meson_msr_data *match_data;
 	struct meson_msr *priv;
 	struct dentry *root, *clks;
+	struct resource *res;
 	void __iomem *base;
 	int i;
 
@@ -636,15 +640,23 @@ static int meson_msr_probe(struct platform_device *pdev)
 	       match_data->msr_count * sizeof(struct meson_msr_id));
 	priv->data.msr_count = match_data->msr_count;
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	meson_clk_msr_regmap_config.max_register = resource_size(res) - 4;
 	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &meson_clk_msr_regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	priv->data.reg = devm_kzalloc(&pdev->dev, sizeof(struct msr_reg_offset),
+				      GFP_KERNEL);
+	if (!priv->data.reg)
+		return -ENOMEM;
+
+	memcpy(priv->data.reg, match_data->reg, sizeof(struct msr_reg_offset));
+
 	root = debugfs_create_dir("meson-clk-msr", NULL);
 	clks = debugfs_create_dir("clks", root);
 
@@ -664,29 +676,41 @@ static int meson_msr_probe(struct platform_device *pdev)
 	return 0;
 }
 
+struct msr_reg_offset msr_reg_offset = {
+	.duty_val = 0x0,
+	.freq_ctrl = 0x4,
+	.duty_ctrl = 0x8,
+	.freq_val = 0xc,
+};
+
 static const struct meson_msr_data clk_msr_gx_data = {
 	.msr_table = (void *)clk_msr_gx,
 	.msr_count = ARRAY_SIZE(clk_msr_gx),
+	.reg = &msr_reg_offset,
 };
 
 static const struct meson_msr_data clk_msr_m8_data = {
 	.msr_table = (void *)clk_msr_m8,
 	.msr_count = ARRAY_SIZE(clk_msr_m8),
+	.reg = &msr_reg_offset,
 };
 
 static const struct meson_msr_data clk_msr_axg_data = {
 	.msr_table = (void *)clk_msr_axg,
 	.msr_count = ARRAY_SIZE(clk_msr_axg),
+	.reg = &msr_reg_offset,
 };
 
 static const struct meson_msr_data clk_msr_g12a_data = {
 	.msr_table = (void *)clk_msr_g12a,
 	.msr_count = ARRAY_SIZE(clk_msr_g12a),
+	.reg = &msr_reg_offset,
 };
 
 static const struct meson_msr_data clk_msr_sm1_data = {
 	.msr_table = (void *)clk_msr_sm1,
 	.msr_count = ARRAY_SIZE(clk_msr_sm1),
+	.reg = &msr_reg_offset,
 };
 
 static const struct of_device_id meson_msr_match_table[] = {

-- 
2.42.0



