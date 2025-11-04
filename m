Return-Path: <linux-kernel+bounces-884716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CEC30E08
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D718C3C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE42F5499;
	Tue,  4 Nov 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCwhekH0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BC2F4A06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257849; cv=none; b=pp80G/xcq7AifA+N/bHH8/e6vsOaYfgtq4UZVL7r4sn5ECE3HjMDeRXU7u/7Wc8fqpiH2DtBtOFIriEiNSIBbtobWIKD2mvaJaZVD4fFAhffXAOpTH9nNBIq2Q3Qdew7r7OFpd6GkMmzmCgOE4jv6McCwWleT0PPHvl7igUmhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257849; c=relaxed/simple;
	bh=d7xwmEi0KnFnU6RGoU18XKBliBKtfnG1R0Qs2x25v9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+xv4CIamlGSAEDLx0cWUG2qXBSt38El5di8AIOda6eSc5asvRSjV9CZf11iN4GYD5zqLnWEEMsiUuHVQcNNRRjPPsSoLOY+Qzdkha5oPomPGSLsjYaOGi3Nq5wXArG3mJFv43KcpdfUgM3hNIs5Hy1GDRE8vP8IKNp+r/njGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCwhekH0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1083777066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257846; x=1762862646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aafw4HLBs7KDKvmUtk2iQQvLgZcs98N6FosFfKLOmF4=;
        b=fCwhekH0+Ozce8hR6i1AWuRwU0M1XOA8gWvkX2V6sXU8qHU1PacDJEovo+2I9zllcl
         SgcV1I5O8lGj1Ysh4pFCxSFNbSHxzxhqlXQDCr4GL8aFsvuPsBSbyOjX+m7e+ndfmUYL
         ZHtHcOHlN1DxkohPPIh1m39KpfIMgfl0nWxMLVjQBQc+MPhAMZIZJ7hSAumFLyr08zFH
         XUtRoFi9BGFBX8F/x9Ky+BPGEbYWPqbHZEMg/LUnvvSOaz0PxeUr1EGEnJvBMq1pfb9l
         1NESyxMizLQKquNukFhFuH3OCBnIlBNdjFxQwQ53ZZ1pRMNCd0GOeslqT9q2nyajgzUl
         2xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257846; x=1762862646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aafw4HLBs7KDKvmUtk2iQQvLgZcs98N6FosFfKLOmF4=;
        b=tlqRipdR1UeOpT6gCIs41B4yPAcIZdpryO7ORAqgTtXsXQB59RRCQzIx+RBNMKywmV
         kW4KaTa8OAag0lqemr9ZjSShFYr8TQMmNCj9EALgJYm3RLQ1b9fSWkPgnAUxDsbizgud
         yXxWAlw7Gvi91FMAl+ii99m3LiXwhccNNkLEQvXFsyCn4Du4i/LpcTp5p4vHHFlwdFcr
         lue14ScDw4DkYpYTJfAF+gc9WrNzGmBLKo7aJCRwgfBr8apU6lDZa7Z4w3c9xfJ68oR3
         KiEVvO84yApO2yEYr7+xtMRRDH+E+hcRs6DnPTyANkTq8M326XlYn7DCNqKJjUglCr12
         Ui+g==
X-Forwarded-Encrypted: i=1; AJvYcCVDNhP0zCJiLOMIxFTgCCFj4nDGtXevG2nmCnmORW2RMCkwRSkSCTWJu/ObAtBEwIjmtZrH4KHHWdbRdMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVglKVRq4ae/74N4aIdrGN8Bwq4kd52CAOrylc7B6625fN4e2
	zMlRCvxsZbq2TLtNOSD8U7iLyJToh9WQJELc3ZdBWE7i8eL9+Et51MDL
X-Gm-Gg: ASbGncswFmWoGBCHRClclCs474Qjt7uQqqDuhuNqu4+zhq3vVL1z2LbcgOc965/wv9z
	i/45kHjV+B37KyfnLz9daSwqde+Sn2D9Y6daVPHejEqapylu3mrUrZn8bApv3KiFE0lAt8UTklK
	uj4aVItKPThYnv2t8oBJ1hoQemWAHwWq5uq0dUbp8cbExBnOQQ7tGQ3j6d+sEZoWZRUTMKB7xx1
	47hdlzTuEKhCBoXrp6LJyLci/Enj+a1v5M0fqvDeali1/bp3qNrRCqliYwh3xibVkwvc0GOdluO
	dT4yhEGZPX8ISxVFPpIKJVYo5ejX0ITjuNGZZi1v+WTxqni130SolL3ZOzhamPHLICO5wAR5cNM
	IggfYOzPxEoosEwIMGWeHB9lWCEVrnmX0OQvr1icJCoSzld9xSkA81ni7Ms+xmbvW8xvCQNo7EP
	8XgrxhtzijiL9q3Y8mVufEmRvNQA==
X-Google-Smtp-Source: AGHT+IHeD+7pAL1LN+vGwVw7YenhruMsQ1qqYloFn0IzgJZ0tjNxTI+ZA1fCBUoZtXsnijqYIZ4NdA==
X-Received: by 2002:a17:907:da5:b0:b72:51fd:5a5f with SMTP id a640c23a62f3a-b7251fd62a9mr192609166b.1.1762257845988;
        Tue, 04 Nov 2025 04:04:05 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:04:05 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 5/8] reset: imx8mp-audiomix: Switch to using regmap API
Date: Tue,  4 Nov 2025 04:02:58 -0800
Message-ID: <20251104120301.913-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Switch to using the regmap API to allow performing register operations
under the same lock. This is needed for cases such as i.MX8ULP's SIM LPAV
where clock gating, reset control and MUX-ing is performed via the same
register (i.e. SYSCTRL0) and different subsystem APIs.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 93 +++++++++++++++++----------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index e9643365a62c..18a7f68aa59f 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
 #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
@@ -42,8 +43,7 @@ static const struct imx8mp_reset_map reset_map[] = {
 
 struct imx8mp_audiomix_reset {
 	struct reset_controller_dev rcdev;
-	spinlock_t lock; /* protect register read-modify-write cycle */
-	void __iomem *base;
+	struct regmap *regmap;
 };
 
 static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
@@ -55,26 +55,15 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
 				  unsigned long id, bool assert)
 {
 	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
-	void __iomem *reg_addr = priv->base;
-	unsigned int mask, offset, active_low;
-	unsigned long reg, flags;
+	unsigned int mask, offset, active_low, shift, val;
 
 	mask = reset_map[id].mask;
 	offset = reset_map[id].offset;
 	active_low = reset_map[id].active_low;
+	shift = ffs(mask) - 1;
+	val = (active_low ^ assert) << shift;
 
-	spin_lock_irqsave(&priv->lock, flags);
-
-	reg = readl(reg_addr + offset);
-	if (active_low ^ assert)
-		reg |= mask;
-	else
-		reg &= ~mask;
-	writel(reg, reg_addr + offset);
-
-	spin_unlock_irqrestore(&priv->lock, flags);
-
-	return 0;
+	return regmap_update_bits(priv->regmap, offset, mask, val);
 }
 
 static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
@@ -94,6 +83,52 @@ static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
 	.deassert = imx8mp_audiomix_reset_deassert,
 };
 
+static const struct regmap_config regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+/* assumption: registered only if not using parent regmap */
+static void imx8mp_audiomix_reset_iounmap(void *data)
+{
+	void __iomem *base = (void __iomem *)data;
+
+	iounmap(base);
+}
+
+static int imx8mp_audiomix_reset_get_regmap(struct imx8mp_audiomix_reset *priv)
+{
+	void __iomem *base;
+	struct device *dev;
+	int ret;
+
+	dev = priv->rcdev.dev;
+
+	/* try to use the parent's regmap */
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (priv->regmap)
+		return 0;
+
+	/* ... if that's not possible then initialize the regmap right now */
+	base = of_iomap(dev->parent->of_node, 0);
+	if (!base)
+		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
+
+	ret = devm_add_action_or_reset(dev,
+				       imx8mp_audiomix_reset_iounmap,
+				       (void __force *)base);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register action\n");
+
+	priv->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "failed to initialize regmap\n");
+
+	return 0;
+}
+
 static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
 				       const struct auxiliary_device_id *id)
 {
@@ -105,36 +140,25 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->lock);
-
 	priv->rcdev.owner     = THIS_MODULE;
 	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
 	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
 	priv->rcdev.of_node   = dev->parent->of_node;
 	priv->rcdev.dev	      = dev;
 	priv->rcdev.of_reset_n_cells = 1;
-	priv->base            = of_iomap(dev->parent->of_node, 0);
-	if (!priv->base)
-		return -ENOMEM;
 
 	dev_set_drvdata(dev, priv);
 
+	ret = imx8mp_audiomix_reset_get_regmap(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regmap\n");
+
 	ret = devm_reset_controller_register(dev, &priv->rcdev);
 	if (ret)
-		goto out_unmap;
+		return dev_err_probe(dev, ret,
+				     "failed to register reset controller\n");
 
 	return 0;
-
-out_unmap:
-	iounmap(priv->base);
-	return ret;
-}
-
-static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
-{
-	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(&adev->dev);
-
-	iounmap(priv->base);
 }
 
 static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
@@ -147,7 +171,6 @@ MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
 
 static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
 	.probe		= imx8mp_audiomix_reset_probe,
-	.remove		= imx8mp_audiomix_reset_remove,
 	.id_table	= imx8mp_audiomix_reset_ids,
 };
 
-- 
2.43.0


