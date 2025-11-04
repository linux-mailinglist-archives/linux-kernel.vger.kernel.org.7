Return-Path: <linux-kernel+bounces-884714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D7C30E17
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F28AA4F37BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109322F3C03;
	Tue,  4 Nov 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W24ts3uQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B52EDD60
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257845; cv=none; b=fCb0VLyGuAfGmU+yClqHf3X5ssjXSX1zoxDmNJ7bcjxXKIPn68KgR6RhE7oj0oOee/k4Cw2/485sGFhq0KK+hZobnK7i7qzZbWLf5jdVRwknPzYCSXYg2wPG9nVvEsL7h3m5EVrV6+qMcISkVlh8YxFwnA+y5ug0m5iILJOQiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257845; c=relaxed/simple;
	bh=D4SadG5nYvl7nyBB87cKRikM6SJkXeonJxlw+/bopKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKuU/ml4tpWqcXmit4hROMo5Xduz5ZcdvUfiGfXphQmrHSsTsrCc7nKcAGIpk4NgRK0lqHVrMp/RR6AC/Xrqn/6vVoWmG92fA61rUyMTm/LIU29iRDJSwgAKK7mdriiVs2ZhK7jB//KVVDnElbqFvSarOOvODExMnsNrIz20o0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W24ts3uQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7042e50899so951105566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257842; x=1762862642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/BYF33DXlVlPj+AeWQJ/lLnj1HAK6WNR64lw8fuXu8=;
        b=W24ts3uQYaZSv3GFwmHRY8qRhRuLAPK+au6okfrXrlu+zB85ZHkYfOnvBTaw2UrgDb
         6GzwQ0BT9K350rGrVf7L54hg62VZBddbHOCqHUO8TYhxbRw4msz5hUs2OioysoAK05Za
         0bX6Rj7ZZsbH503Vp0JT8oe1+6DXw6HJX+l3dmfihUf3Z3nhIx7NaGfOgupgcTmyfw3x
         xhleMz0ffuLtS81NWfhlHOWAkRX8YjvsWYI2Q1trjDRtNs3kivf7WYGW+TbCfxtqRJw3
         qrfeuI+1mucm9X7qjDMQHgKSdeUmFG5KLymQRbfrGvJufeyobFf8qWPIyLsghCHjbZM3
         TWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257842; x=1762862642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/BYF33DXlVlPj+AeWQJ/lLnj1HAK6WNR64lw8fuXu8=;
        b=UgaaIMK7yhuMWg/BBnPwbWeivwDF6uXVpKDj7zco9Jy9yppKhRfyeFjmlzR+ZTs6uS
         mixGS4yhJHX5m5rfoa1vaIqfFU/Daw+ET5t5XYuTVYFqizLVWIbZvuIExsbDiIHY0nqh
         g7q3EB9GQ77O4f+rZP9lhSyBTgLFM4+bqEkbXsO+bS0ekypBcPnJ6SBjwNoXYTglh+zk
         jJL44nPPg82EU/CK5c3fbHTPbeMNu0nxuGsx2Kt5kb6bm27BY2eyDCNwzWi4zN3qJfPJ
         S3+B5rKNKfOZLcUzIfce+8SNlttSphapf6rS9AxOl+FrloBoOJyYbQPRBYnnK+SrGYAb
         D7wA==
X-Forwarded-Encrypted: i=1; AJvYcCWA2uV9WhoMqx17O/MtOzrDPwkk5+05gVIxG91x+K2WvpYJxkXCgaTIIIDHldjGQr6/ci9+/B7GV9JVOTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/m3CRKuhDzyNGFQeQuJvVIpMSRpvBp1+N48G/j7mluAta9QD0
	TYybKe6AEU1D1r4S5lAh/P+cBMSg7x5IB71jcNwDvX4IyjomZgVM+01v
X-Gm-Gg: ASbGncsXfjnil0psS0syk/LArjQBEb8Z0yyHTCbnmYLtc83ZfbsmUJAiXcf4ScQLXN0
	tRgs/fUAyK+I5YHTd5SM8z5w288yhihc7m/xjBQrpKRmj3DpFNUSqfEoPiKCB/UBfPs9GgmNkr7
	5KQokxpQzLJRgyVm7ycSRQTgQSj809ItEXUd389nHxLbaAsppz48l+ICJKxR0QoSytX6BOQ8r6M
	MpY3jYB3cgdLtO3MR5+X2QmOngrav8N+6Z6ulAPYki0mHd0MEBXYlUNuCpDP3bmK+g9XbTtD5g8
	qyidOWj4CuG5d2nX9+amFfNxv9BsQ2NCTdRf4Q+K/Et/UpEkUlYNhQ2o/0Ht12VYici4HTvVxG7
	enDq/CkosdOmnTMafELZYhVrpquh+CRimop5GwNn11gZcVWvbDml74x/ALJQjKg0/ucTqp+6cLK
	orEATI6WhgMHtsAcvzO479RX2orbq2tlABeYBs
X-Google-Smtp-Source: AGHT+IENrgHXUckIu1P8DzjyOH/pQJ15zIuOl+8iK5w7p2OYmzxyymXxjra+BK5po5WGmx8SH+hcTg==
X-Received: by 2002:a17:906:fe4e:b0:b65:abf2:417a with SMTP id a640c23a62f3a-b7070891072mr1736993766b.64.1762257841281;
        Tue, 04 Nov 2025 04:04:01 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:04:00 -0800 (PST)
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
Subject: [PATCH v4 3/8] clk: imx: add driver for imx8ulp's sim lpav
Date: Tue,  4 Nov 2025 04:02:56 -0800
Message-ID: <20251104120301.913-4-laurentiumihalcea111@gmail.com>
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

The i.MX8ULP System Integration Module (SIM) LPAV module is a block
control module found inside the LPAV subsystem, which offers some clock
gating options and reset line assertion/de-assertion capabilities.

Therefore, the clock gate management is supported by registering the
module's driver as a clock provider, while the reset capabilities are
managed via the auxiliary device API to allow the DT node to act as a
reset and clock provider.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/clk/imx/Kconfig                |   1 +
 drivers/clk/imx/Makefile               |   1 +
 drivers/clk/imx/clk-imx8ulp-sim-lpav.c | 156 +++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 6ff6d934848a..b292e7ca5c24 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -105,6 +105,7 @@ config CLK_IMX8ULP
 	tristate "IMX8ULP CCM Clock Driver"
 	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
+	select AUXILIARY_BUS
 	help
 	    Build the driver for i.MX8ULP CCM Clock Driver
 
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
index 000000000000..990c95b89b75
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
@@ -0,0 +1,156 @@
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
+static int clk_imx8ulp_sim_lpav_probe(struct platform_device *pdev)
+{
+	const struct regmap_config regmap_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.lock = clk_imx8ulp_sim_lpav_lock,
+		.unlock = clk_imx8ulp_sim_lpav_unlock,
+		.lock_arg = &pdev->dev,
+	};
+	struct clk_imx8ulp_sim_lpav_data *data;
+	struct auxiliary_device *adev;
+	struct regmap *regmap;
+	void __iomem *base;
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
+	/*
+	 * this lock is used directly by the clock gate and indirectly
+	 * by the reset and mux controller via the regmap API
+	 */
+	spin_lock_init(&data->lock);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "failed to ioremap base\n");
+	/*
+	 * although the clock gate doesn't use the regmap API to modify the
+	 * registers, we still need the regmap because of the reset auxiliary
+	 * driver and the MUX drivers, which use the parent device's regmap
+	 */
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+				     "failed to initialize regmap\n");
+
+	data->clk_data.num = ARRAY_SIZE(gates);
+
+	for (i = 0; i < ARRAY_SIZE(gates); i++) {
+		hw = devm_clk_hw_register_gate_parent_data(&pdev->dev,
+							   gates[i].name,
+							   &gates[i].parent,
+							   CLK_SET_RATE_PARENT,
+							   base + SYSCTRL0,
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


