Return-Path: <linux-kernel+bounces-876297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1864C1BA79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC05625FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CEA3559DC;
	Wed, 29 Oct 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0JbF/u7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4143559C1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746171; cv=none; b=kT48ODbmr0P3u222Ma+Ff2DBYBp1xokqdpSFZ42j/c5o2ZJClcMkAoD8mzk2i1dM8nwm8uKtZncFn0avARGnhmGXty5O/rl8wVZhBB7jaaVrRBu9FP6H45P/WnxM9Bik71hMXnUuDVSuvt7o1dDVzS/WqVluqwnVtjeh1LQMqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746171; c=relaxed/simple;
	bh=OKYSetcDO2rFXo/y45ZZWWssOa+5KtBgQGteOChOd3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kja7Ro9FslF1fC514xu/PwcNCJjx8yJD5e4Z0B61X/OfCcdCvRVUPhNrnYQ/W0SYY110uu0D0B5M6byGElwMd0sMRwQvq1lsnMNxhxakb2kM7wy5uFOMv+30iRiWyTm1GqUuE3MHNiefV6HEzJih+9w0cTmXJOxDHByADB7AjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0JbF/u7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5a8184144dso1139597066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746167; x=1762350967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3VoDc4JO2kSm8qVM4RA31MFseJ8uanXq2MvOCfPyqg=;
        b=V0JbF/u7poz7+VnoTEohpx4I598Hd+qVbz42sO7wGPH3kj6sDJ0uDxKe7Ied68SYdA
         IEt9e/S/pWH/JuCdwCYnEA3TsJPOYUE6A+s3SmMThDLpjAlvTBr6a/rCW3Mx6zEfcuUm
         oK0xNIS9TE/20B861m1W/NHM7Pf1Z+xrImaRsU+BpXfIBiytf8eDfiKep9UhxmFRbwh8
         DOBcWCAzn/kw2BMIsjoA3kAr10ZLgR5rf2aqoYPVhg8fORpi7wIntE982jEjKISA4cDA
         5jtZRIBcTxxaM75iRoTT1WKqHtwC6g8xzcMVKG61gJpN2bRdm381VGflHM0faf/tidYa
         7b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746167; x=1762350967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3VoDc4JO2kSm8qVM4RA31MFseJ8uanXq2MvOCfPyqg=;
        b=sEZCjCvm9IfmsnP0pWymTqj196gbHzGI6eiNolZW4LozM8hl9jxS4O6PkMpPiwOAVl
         x3+7qjmOOzU04Z3aB9zluTD19kRAc4uvQgSYkW0idBIAWoQRBb8kKg+AzkZCAh+q0GHl
         fh337VN58r6ZgiQUMOEILQ7SLPp1V/ZpnFb3w8VQS66/bOM6vIB4iZwomWpDtTfKqrYv
         zDN7D9xGlXiK0brPmJC7IN1w7ZW5Xiz6fERaH7hnCflwYYCzYlE55YypSDBCdA3Oa+q4
         QsIh8uxpqqchQGVN3nwC/jRL8Xrqvj6IYz/QennTlHYYSj6ai2FX2frVlEIAeMiyzbTr
         Jc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7gKLm/C7tqyf5jzkPWOB/Fe0ptOUPSQjkGV6EX8yItV7nATHAJRTiMKLT27KL/JDLkb1GMgBgDT6Bnws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshO52Zr3p/LrKESdCk1G4VF/QirEKBOUUcioBDY5R8oVU7Kis
	PVMEmjZtXFNVFkgNgZ4JVnZWzNGHLGxlFXxoVjeaa2j7q6upPEQjO2tn
X-Gm-Gg: ASbGncsWE/0UQ9c92JU1GLatmVNQoX80QSTtHBYSIlA3uEAm2/a9W/FZXun6U5B2WCZ
	/a8wBQ4WB45P9M4e3xL8etNxB2I5zEu5VHzzMBrHIfYD9zHY3mSzBJyrhL0jdouggP83VgW/c6F
	od1hki+b28nmTGkIf52uJC8U4IBymojC38zeVU1SQWXq7RqMj9GYWs82jgwvnv53mk6hrm1HM1+
	c3LRVPrN55njmY/5ns8gnQ4yrKvT6FEdH6CRc3NjXiAp+sLQRdqjQ1lrbIKLujxTp2rLRvilUme
	R/wveyQSdQp8VXL/mn6/dIfAz3rZP3HHFNj/8BcIdaqoKj9grI3ma9Pv27+u5OrTbye/HvH0x+B
	FP3urziA9yKg+t/Tzmvd0tB6B0IhAN6akQPE6tade+OiBoYsV6aNVFmmnlcJ7jS4dUkvvobw1BG
	nZeFy1c9BCeLlaCfoZX6P0Qt/j+g==
X-Google-Smtp-Source: AGHT+IFJsqqYrA0WrTuMNeD7nw3M886Ul6n9khe7BJCg7Kfwbb6WZmCEdmQ2yDNV4wiQtrjXo+zUqQ==
X-Received: by 2002:a17:906:f588:b0:b6d:bf78:8bde with SMTP id a640c23a62f3a-b703d2e3f70mr271201766b.7.1761746167029;
        Wed, 29 Oct 2025 06:56:07 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8534d99dsm1444960766b.21.2025.10.29.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:56:06 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 3/8] clk: imx: add driver for imx8ulp's sim lpav
Date: Wed, 29 Oct 2025 06:52:24 -0700
Message-ID: <20251029135229.890-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The i.MX8ULP System Integration Module (SIM) LPAV module is a block
control module found inside the LPAV subsystem, which offers some clock
gating options and reset line assertion/de-assertion capabilities.

Therefore, the clock gate management is supported by registering the
module's driver as a clock provider, while the reset capabilities are
managed via the auxiliary device API to allow the DT node to act as a
reset and clock provider.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/clk/imx/Makefile               |   1 +
 drivers/clk/imx/clk-imx8ulp-sim-lpav.c | 160 +++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 03f2b2a1ab63..208b46873a18 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -41,6 +41,7 @@ clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
 clk-imx-acm-$(CONFIG_CLK_IMX8QXP) = clk-imx8-acm.o
 
 obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp.o
+obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp-sim-lpav.o
 
 obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
 obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
diff --git a/drivers/clk/imx/clk-imx8ulp-sim-lpav.c b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
new file mode 100644
index 000000000000..1614d9209734
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <dt-bindings/clock/imx8ulp-clock.h>
+
+#include <linux/auxiliary_bus.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define SYSCTRL0 0x8
+
+#define IMX8ULP_HIFI_CLK_GATE(gname, cname, pname, bidx)	\
+	{							\
+		.name = gname "_cg",				\
+		.id = IMX8ULP_CLK_SIM_LPAV_HIFI_##cname,	\
+		.parent = { .fw_name = pname },			\
+		.bit = bidx,					\
+	}
+
+struct clk_imx8ulp_sim_lpav_data {
+	void __iomem *base;
+	struct regmap *regmap;
+	spinlock_t lock; /* shared by MUX, clock gate and reset */
+	unsigned long flags; /* for spinlock usage */
+	struct clk_hw_onecell_data clk_data; /*  keep last */
+};
+
+struct clk_imx8ulp_sim_lpav_gate {
+	const char *name;
+	int id;
+	const struct clk_parent_data parent;
+	u8 bit;
+};
+
+static struct clk_imx8ulp_sim_lpav_gate gates[] = {
+	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "core", 17),
+	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "bus", 18),
+	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "plat", 19)
+};
+
+static void clk_imx8ulp_sim_lpav_lock(void *arg) __acquires(&data->lock)
+{
+	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
+
+	spin_lock_irqsave(&data->lock, data->flags);
+}
+
+static void clk_imx8ulp_sim_lpav_unlock(void *arg) __releases(&data->lock)
+{
+	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
+
+	spin_unlock_irqrestore(&data->lock, data->flags);
+}
+
+static const struct regmap_config clk_imx8ulp_sim_lpav_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.lock = clk_imx8ulp_sim_lpav_lock,
+	.unlock = clk_imx8ulp_sim_lpav_unlock,
+};
+
+static int clk_imx8ulp_sim_lpav_probe(struct platform_device *pdev)
+{
+	struct clk_imx8ulp_sim_lpav_data *data;
+	struct regmap_config regmap_config;
+	struct auxiliary_device *adev;
+	struct clk_hw *hw;
+	int i, ret;
+
+	data = devm_kzalloc(&pdev->dev,
+			    struct_size(data, clk_data.hws, ARRAY_SIZE(gates)),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, data);
+
+	memcpy(&regmap_config, &clk_imx8ulp_sim_lpav_regmap_cfg, sizeof(regmap_config));
+	regmap_config.lock_arg = &pdev->dev;
+
+	/*
+	 * this lock is used directly by the clock gate and indirectly
+	 * by the reset and mux controller via the regmap API
+	 */
+	spin_lock_init(&data->lock);
+
+	data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
+				     "failed to ioremap base\n");
+	/*
+	 * although the clock gate doesn't use the regmap API to modify the
+	 * registers, we still need the regmap because of the reset auxiliary
+	 * driver and the MUX drivers, which use the parent device's regmap
+	 */
+	data->regmap = devm_regmap_init_mmio(&pdev->dev, data->base, &regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->regmap),
+				     "failed to initialize regmap\n");
+
+	data->clk_data.num = ARRAY_SIZE(gates);
+
+	for (i = 0; i < ARRAY_SIZE(gates); i++) {
+		hw = devm_clk_hw_register_gate_parent_data(&pdev->dev,
+							   gates[i].name,
+							   &gates[i].parent,
+							   CLK_SET_RATE_PARENT,
+							   data->base + SYSCTRL0,
+							   gates[i].bit,
+							   0x0, &data->lock);
+		if (IS_ERR(hw))
+			return dev_err_probe(&pdev->dev, PTR_ERR(hw),
+					     "failed to register %s gate\n",
+					     gates[i].name);
+
+		data->clk_data.hws[i] = hw;
+	}
+
+	adev = devm_auxiliary_device_create(&pdev->dev, "reset", NULL);
+	if (!adev)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to register aux reset\n");
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev,
+					  of_clk_hw_onecell_get,
+					  &data->clk_data);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register clk hw provider\n");
+
+	/* used to probe MUX child device */
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id clk_imx8ulp_sim_lpav_of_match[] = {
+	{ .compatible = "fsl,imx8ulp-sim-lpav" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clk_imx8ulp_sim_lpav_of_match);
+
+static struct platform_driver clk_imx8ulp_sim_lpav_driver = {
+	.probe = clk_imx8ulp_sim_lpav_probe,
+	.driver = {
+		.name = "clk-imx8ulp-sim-lpav",
+		.of_match_table = clk_imx8ulp_sim_lpav_of_match,
+	},
+};
+module_platform_driver(clk_imx8ulp_sim_lpav_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("i.MX8ULP LPAV System Integration Module (SIM) clock driver");
+MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
-- 
2.43.0


