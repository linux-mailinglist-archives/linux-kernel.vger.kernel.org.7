Return-Path: <linux-kernel+bounces-755481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FCB1A6CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA60189C7AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA7271A7C;
	Mon,  4 Aug 2025 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAQGbouD"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F12749CD;
	Mon,  4 Aug 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322924; cv=none; b=B1RZvNs6lVuT+dTVxc0w3RoVslKnCbsGY9GxvxiWyseR/jwqYHj4J8IeIKqFMEPzPMZeW7yFStwJDLS5ToF4DpQ3RaD4PBvoMzhbcQ01632AkAjFi2iQtVOeAnfuzYIkdV7KwZNht5W5zSdmvfeYNykQw/y1CYL+EtBJlamZYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322924; c=relaxed/simple;
	bh=IAcYmLK57qYfb8a5LlZ62OJ9Z7xiHJQnAtKXNkkeZmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0dldWydk9JwfepOxj7JKlTaXg2i1CmGp5a+WEp/1huf9xCMY7+bujr0r5Itz6s6nNnKtNshwiTFRvIER8JddRTObzniiMzaFc+DEnwBbmu5eYS7afYxht5iZJ3a4tS5nqBRr2rMQuh9wcBh1G56CxtU/biMtkbRH4NK7isfwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAQGbouD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so763109866b.2;
        Mon, 04 Aug 2025 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322920; x=1754927720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YGz5cPkWnmWx7O4iWL1ZseG9pwFetBBfmo91nT+/vc=;
        b=eAQGbouDSSe2mLXr+pcymIckWlWa1970HDYse4lEVwa5JRVOg/tWD3O0LrgiGblE5z
         Qs/CCRxCFxXO8R4tXxabqkp6F4wyt0PJmCCeAI3IC4aMuOa0rMNX3TzRoYMip59hrt4t
         x8y5k7vIFQRuhhZ/C9iRwQEULtQ/6A3hcyk/Bqaokiy7l0/rsmGnCCjhPEPkqWm6Bf2Q
         etoki2w4mLw3Ea4NqvC96K2Ksvrf2ZMk0krJfuwPeVAkBQQqlliXqLHKHwBltI9tkJwt
         HoXCtfiN8LBFrLauC7/hF4wSTdKr/mQtm5t+h7dEHLKCAKDmdjLL0Mj+FI9o5Gaen860
         POMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322920; x=1754927720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YGz5cPkWnmWx7O4iWL1ZseG9pwFetBBfmo91nT+/vc=;
        b=skkH6k7TTiWGE8B9fO9YkywEDSfm+qbqMz+CEA0m97ppNgrTCbV8eRXh5XhDNGWVtH
         RMqDEkypDQA+kSP7lS9yu/5+AjKySuhIOKH13bbI12JwLHi8kEKm8AC96mAJt5HXi0tt
         bqCTnLXlAhXf2hzrhhV1VzEX/yIj3um51Js1MJKzuFROqt4q40DxVHURtlymAmko2cdO
         LLJBZhL+hr/kQzP4fo3Z2y6G2C+AC0H+ntn9psW1KclSuskIbVQc556sP6pOX1+zkWOK
         6XxeoLNaL4+SEvFAwANrP0LV6D1UC7k4x/y6oob2dI/77SjGQfT64v+nGpUJbrKex5dQ
         GErQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+6XmWfP+TPbrPGdb5d8FpK8nFe+5h2Nj5t90Unax8LZNfVUaNlDKbfB1KkAWaakA5UX9+9BpghUKyb806@vger.kernel.org, AJvYcCXbPRbQAqoAAvO0569vCYHuEdb+ruHzwH7I7aqi8zDbd2JejYsVtns9zE52I+lF7YWD4uta+zSDt6Io@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiiBrJBFM4us+8iXTXmgDZl95eb+2flgotpDXkPpVbUIDPLSi
	jkcs8vVabveyLJk6YgocrpoYNKZkyzfvlOYN0QLADEZ7XXfoImT/pivb
X-Gm-Gg: ASbGnctupSzCkOA7chPO+oA2GtLKg8xJRgGfA9idFBrry5IgrrKgahJzQfcSZWki0Ql
	fJL5GVeaE2kSfi/4TDmfpnD2Z42BY4bpFXpmxmHQFi+YOSC4mzLdNs6ta6JNV/uU8vqLOSnF+js
	j3FZTSKXMfkjco4phxmnF4IpcsZpRTf0XPP+iY8lYZY1NzSzYWMka6OLLXqLE1grwmRK9SU1c1A
	zd3V4jRJrPMkBP5UAeUJ8QHV/n8KbIB1XF0DTOHzm0SM/8qrxCqrLhPSXWLmry6orTohlVzZ4K9
	0yFz2CTHtQi7g4vmWcQFwUCP2JznXXfk2O3+aNSckE13PZNrXLFYZzxT3fE7TttLmkan8B9N5q5
	JLWpzOXfEO08dtZu3iLcscx1qC9tk6rxYKiY6EJHv74zuyn/+2q3yxwpW9uY=
X-Google-Smtp-Source: AGHT+IH4rhYeZkTEYN60QVQIBmD6LxL8fP1yhq7naPH7BzL1Kc6gHZhe60uNsm5lfC+/+dGfYxNwSQ==
X-Received: by 2002:a17:906:d54f:b0:ad8:9c97:c2e5 with SMTP id a640c23a62f3a-af93fda17edmr1041557166b.0.1754322920274;
        Mon, 04 Aug 2025 08:55:20 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:19 -0700 (PDT)
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
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 4/7] clk: imx: add driver for imx8ulp's sim lpav
Date: Mon,  4 Aug 2025 11:54:04 -0400
Message-Id: <20250804155407.285353-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
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
 drivers/clk/imx/clk-imx8ulp-sim-lpav.c | 162 +++++++++++++++++++++++++
 2 files changed, 163 insertions(+)
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
index 000000000000..2019e0a61216
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
@@ -0,0 +1,162 @@
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
+
+#define SYSCTRL0 0x8
+
+#define IMX8ULP_HIFI_CLK_GATE(gname, cname, pname, bidx)	\
+	{							\
+		.name = gname"_cg",				\
+		.id = IMX8ULP_CLK_SIM_LPAV_HIFI_##cname,	\
+		.parent = { .fw_name = pname, .name = pname },	\
+		.bit = bidx,					\
+	}
+
+struct clk_imx8ulp_sim_lpav_data {
+	void __iomem *base;
+	struct clk_hw_onecell_data clk_data;
+};
+
+struct clk_imx8ulp_sim_lpav_gate {
+	const char *name;
+	int id;
+	const struct clk_parent_data parent;
+	u8 bit;
+} gates[] = {
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
+static int clk_imx8ulp_sim_lpav_probe(struct platform_device *pdev)
+{
+	struct clk_imx8ulp_sim_lpav_data *data;
+	struct clk_hw *hw;
+	int i, ret;
+
+	data = devm_kzalloc(&pdev->dev,
+			    struct_size(data, clk_data.hws, IMX8ULP_CLK_SIM_LPAV_END),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
+				     "failed to ioremap base\n");
+
+	data->clk_data.num = IMX8ULP_CLK_SIM_LPAV_END;
+
+	for (i = 0; i < ARRAY_SIZE(gates); i++) {
+		hw = devm_clk_hw_register_gate_parent_data(&pdev->dev,
+							   gates[i].name,
+							   &gates[i].parent,
+							   CLK_SET_RATE_PARENT,
+							   data->base + SYSCTRL0,
+							   gates[i].bit,
+							   0x0, NULL);
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
2.34.1


