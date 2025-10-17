Return-Path: <linux-kernel+bounces-857937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A482CBE84B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475FF1A61BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD83469EE;
	Fri, 17 Oct 2025 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXcvHnLV"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D73343D71
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700116; cv=none; b=C6ShNVjI6Iv6xxuUtvC7HzAnjYgSPSncP7bazlGsdQSSM67KmfuSjV85kXg+5+6sa1nkQysTk+KKVvIiMTrvQkLgc7kxFOrcNmXH+UmRujpsgvG6kd4fnjVUqBaliZ+p6XUckE853q9jSTh2Bu+myEJD2tvjutOOr5vl7aYSdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700116; c=relaxed/simple;
	bh=QbwHtai+BJxYFudgqpSVpK+6DZzgQhT5atZHskToNH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9iib4m6KSIBFHjiztDFNyOLU6g+oB1FNwNsghKGX7t4fXtLwe/HnSXD43TAdDK+wTx/uWVvBwHO46f7agE8FDmhZl7InxB0SG0ze9Y29uTSjUpYxV2Bqj/HqP7u+W9qgo3abV/3mZl2WG1/Jl7XGnmM37MtIp7GkOlsnAVZbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXcvHnLV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b64cdbb949cso156682466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760700111; x=1761304911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SRcF0cyXRIrCALSbv1WyqVPHL5usg6xc8X0h6BNH44=;
        b=NXcvHnLVeRe35lgom4xnkPrL6s6snKC6qHC4QvuOOoVsB7rHWYwJE1nULw1x5pdnGR
         TmJEk61ZZoFo85lzM0jrp41xUTBHNlt/N0xTXw+Tnr6KaeqVnrZaXD6KmyL1Pji7GeMf
         GOCdMlEvpuc0P5dYenpKN1+75FYZqPrjq688t/M89oHjF27YyU/YaUuaBppheSP2Dn7b
         Do/OBFfVhnf/uelxMvUJdEqfOkojjUBbBeKpZg7uxZBv9t56sav9b3rWL/GRSTnOScSk
         3BuNRgPtfedbQbLSUwXaClge9MraHv5UpUJ6TRktAFXk2/p5TMHGfHHGAhZ0hYOaaBnh
         Ujxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700111; x=1761304911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SRcF0cyXRIrCALSbv1WyqVPHL5usg6xc8X0h6BNH44=;
        b=GntwoDESggGZhYF2DmTH/mj+VRxegrh3D/GMWJZcVER/zMRBmHpeRISuVzebIaRBIe
         wIjXhTdReq9aSgofowsvYz2jkSUP+RNjE1siB/sUHeiov0oufqimYT+HfaxplliaAcx2
         Z/Uq4gCcg1WalFJBQE6MhBtraTJ/Klv2WctT58MCIzedxEt132RYbfcpWDZgE2g1OyTI
         Ep4kt2X6hIkjFV/5oiZlwjE6NVvfrV9UlRGCI3gawrjKw8EAbhIYRFbQb0vdGJzQr+VL
         PASwmTrilPfaO2ZoGjs6OLh4rRZCHEXuDDtIEKCK1lZ5xUbXvlrJOVg3PhW8xG8SkWlo
         jvSA==
X-Forwarded-Encrypted: i=1; AJvYcCWjZhZixbqWqiFnP8SfPMDQqRBebfrnLr5OvaiWl9Hnbuiw3Z29Bk7ut29mhkmF3BrnjjBOG207c+qnhvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxDL2DQX9Jgqo07oCFMUQS1SJZ7LbtX80B1qXL7L5P1zY/lRe
	CZvCVe+y5MNuhRcrQzSFXgglCSipD17ydZP7dfVL/zviTrLw43kLiQys
X-Gm-Gg: ASbGncvglSeqhsXbEarwF6xPyORbRzIpfqljC9N27aF2zbViAWXd+VPUHlG8g1AqqJK
	6V823z0I6XSeOalBIK157/bPvA0wr/t5adgdJ2EHzOYtvl1A0/dTJrc3sAF7VkeXO3giR2jcE6I
	+VRHdNCIgOn1y8nQENcFh61ZaMyXGykrsvbJxJC2Jt0LE2iYFHG5HEhuWBuJNqz15TA2zOlC0mr
	9GNyWMR80LyZuQcaEVMyrXiK2/C8J7n5aijXSEihajsMlq2hoWyYVeTglv1vVpEFGXfjEJDlGz3
	6cLgB+XPCoEhmjhIUo/VV9or0JfY7SzkVbSkBEZwocOxUYkRwv16OS08s+jxVLQYXd+RvKF4dzo
	5hc5ihwwF+9YeA/NLxu0WIzVjKJfg9ReiYgY4wgwsWyJr4C8DXA5mR2+yFp4pZwiq1uAuXMDgdY
	D2SXnFL/OHwDNePVMkYhN0DTwxbJklILn99Qh/7g==
X-Google-Smtp-Source: AGHT+IHawqhbMGg/z/t1tyezNSy1w1pPa2pT2cKM5bF1DJpICbbtH0JfsYDVp5aeJapIE5IuD8wpSQ==
X-Received: by 2002:a17:907:2dab:b0:b44:f9fe:913a with SMTP id a640c23a62f3a-b6475d04cb3mr349744166b.65.1760700111023;
        Fri, 17 Oct 2025 04:21:51 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af35fsm788256166b.60.2025.10.17.04.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:21:50 -0700 (PDT)
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
Subject: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
Date: Fri, 17 Oct 2025 04:20:20 -0700
Message-ID: <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
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
 drivers/clk/imx/clk-imx8ulp-sim-lpav.c | 211 +++++++++++++++++++++++++
 2 files changed, 212 insertions(+)
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
index 000000000000..a67a0e50e1ce
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
@@ -0,0 +1,211 @@
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
+
+#define SYSCTRL0 0x8
+
+#define IMX8ULP_HIFI_CLK_GATE(gname, cname, pname, bidx)	\
+	{							\
+		.name = gname "_cg",				\
+		.id = IMX8ULP_CLK_SIM_LPAV_HIFI_##cname,	\
+		.parent = { .fw_name = pname, .name = pname },	\
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
+	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "hifi_core", 17),
+	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "lpav_bus", 18),
+	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "hifi_plat", 19)
+};
+
+#ifdef CONFIG_RESET_CONTROLLER
+static void clk_imx8ulp_sim_lpav_aux_reset_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static void clk_imx8ulp_sim_lpav_unregister_aux_reset(void *data)
+{
+	struct auxiliary_device *adev = data;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
+{
+	struct auxiliary_device *adev __free(kfree) = NULL;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = "reset";
+	adev->dev.parent = &pdev->dev;
+	adev->dev.release = clk_imx8ulp_sim_lpav_aux_reset_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize aux dev\n");
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		dev_err(&pdev->dev, "failed to add aux dev\n");
+		return ret;
+	}
+
+	return devm_add_action_or_reset(&pdev->dev,
+					clk_imx8ulp_sim_lpav_unregister_aux_reset,
+					no_free_ptr(adev));
+}
+#else
+static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif /* CONFIG_RESET_CONTROLLER */
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
+	ret = clk_imx8ulp_sim_lpav_register_aux_reset(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
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


