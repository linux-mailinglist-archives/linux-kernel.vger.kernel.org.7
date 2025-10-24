Return-Path: <linux-kernel+bounces-868391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75942C0519D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DA94222C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693D30CD8D;
	Fri, 24 Oct 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z8H1HvJy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1F30BF55;
	Fri, 24 Oct 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294797; cv=none; b=ZtSv8MYz3QgBiiGxsp1q5eB9QbKlqb+lTSceVrn1/ZhTZ1gKhZPEMrbmW0EWJJl2WYmMokSe9SEOReSeQxoxGtpP3B6r2lAMZN6QcSc8+zwceGOabhAwJRmwHN5BLlSzo9zNon5zhqB1TC/N5VVBbRxpmXMQXajrzVikOeMunLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294797; c=relaxed/simple;
	bh=rJJ2efOMdG1uiMrhh7FumEGpXW6HuTOuMobzi6JLLGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atZYEkrfNq/VLeMBkOY+jH1wZUnl6s0qM4JcHO5wlsww5iLI7NKOPVS3AaaRVtV27Z0rbjkKwSQCDHnZUWKfnA+KOCbj6swyhgyz4vY5mvIM2KTQJFfliekuRFa3PnPhde5CsxR/HN+iW6aymC5KJ9TUI9UE1HQIV7CsAUjnJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z8H1HvJy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294793;
	bh=rJJ2efOMdG1uiMrhh7FumEGpXW6HuTOuMobzi6JLLGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8H1HvJyZCryVOTaPLPIv6vBdLnzbt4MrLBTlgWkt8qD7GEl+jiBpJtzqN/VuNpru
	 W8x91VfEhU14j82ybp0zvai/HakVA7DB0La0LwKftN0FWxQQUB1mKF5J80ToUzhEQC
	 9Ffd2AZBtHHlTA8AfhpkNupIVlNf/wxCi0EsaIj62Kk0p0Ul36cixwcIi2qSufMmss
	 142F4RtZOpfXwEBkMc7j8Qbif0ImY5rZtAIFd3GG8P54fLry21YHftrXwc18Arh9SR
	 z/Vz3CyiwkMBhDgouIwTEgRpzo2TmZYHbKEy+GVaFVUcR8SqPPrSnkMRAz4EP89V39
	 /ASKaoZQMa8pw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F8A417E1416;
	Fri, 24 Oct 2025 10:33:13 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	nfraprado@collabora.com,
	wenst@chromium.org,
	y.oudjana@protonmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 5/7] clk: mediatek: Add support to register SPMI Clock Controllers
Date: Fri, 24 Oct 2025 10:32:59 +0200
Message-ID: <20251024083301.25845-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
References: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new mtk_spmi_clk_simple_probe() helper in a new file to add
support for registering SPMI Clock Controllers, and change the
Makefile to conditionally embed the new clk-mtk-spmi inside of
a clk-mediatek object.

This was all done like that because clk-mtk-spmi wants to import
the "SPMI" namespace as it uses functions to register a new SPMI
subdevice (the clock controller), but doing so is not necessary
if SPMI Clock Controllers support is not desired.

This means that COMMON_CLK_MEDIATEK_SPMI may be either y or n,
as this conditionally includes or excludes it from the object
which will require said namespace only if support is desired.

As a last note, when COMMON_CLK_MEDIATEK_SPMI=n, the generated
object will be "the same as before" (bar the name), because the
object generated by COMMON_CLK_MEDIATEK was already containing
all of the ones that are included right now (again, if built
without support for SPMI Clock Controllers).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig        |  8 ++++
 drivers/clk/mediatek/Makefile       |  5 ++-
 drivers/clk/mediatek/clk-mtk-spmi.c | 62 +++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk-spmi.h | 31 +++++++++++++++
 4 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mtk-spmi.c
 create mode 100644 drivers/clk/mediatek/clk-mtk-spmi.h

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 0d52771d06b3..3452dcbc9e45 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -18,6 +18,14 @@ config COMMON_CLK_MEDIATEK_FHCTL
 	  This driver supports MediaTek frequency hopping and
 	  spread spectrum clocking features.
 
+config COMMON_CLK_MEDIATEK_SPMI
+	bool
+	depends on COMMON_CLK_MEDIATEK
+	select REGMAP_SPMI
+	select SPMI
+	help
+	  MediaTek PMICs clock support.
+
 config COMMON_CLK_MT2701
 	bool "Clock driver for MediaTek MT2701"
 	depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 4daba371342f..1471d8affa44 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
+clk-mediatek-y := clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
+clk-mediatek-$(CONFIG_COMMON_CLK_MEDIATEK_SPMI) += clk-mtk-spmi.o
+obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mediatek.o
+
 obj-$(CONFIG_COMMON_CLK_MEDIATEK_FHCTL) += clk-fhctl.o clk-pllfh.o
 
 obj-$(CONFIG_COMMON_CLK_MT6735) += clk-mt6735-apmixedsys.o clk-mt6735-infracfg.o clk-mt6735-pericfg.o clk-mt6735-topckgen.o
diff --git a/drivers/clk/mediatek/clk-mtk-spmi.c b/drivers/clk/mediatek/clk-mtk-spmi.c
new file mode 100644
index 000000000000..0206e1f8ec27
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mtk-spmi.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Collabora Ltd
+ *		      AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/spmi.h>
+
+#include "clk-mtk.h"
+#include "clk-mtk-spmi.h"
+
+int mtk_spmi_clk_simple_probe(struct platform_device *pdev)
+{
+	struct regmap_config mtk_spmi_clk_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.fast_io = true
+	};
+	struct device_node *node = pdev->dev.of_node;
+	const struct mtk_spmi_clk_desc *mscd;
+	struct spmi_subdevice *sub_sdev;
+	struct spmi_device *sparent;
+	struct regmap *regmap;
+	int ret;
+
+	ret = of_property_read_u32(node, "reg", &mtk_spmi_clk_regmap_config.reg_base);
+	if (ret)
+		return ret;
+
+	/* If the max_register was not declared the pdata is not valid */
+	mscd = device_get_match_data(&pdev->dev);
+	if (mscd->max_register == 0)
+		return -EINVAL;
+
+	mtk_spmi_clk_regmap_config.max_register = mscd->max_register;
+
+	sparent = to_spmi_device(pdev->dev.parent);
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
+
+	regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &mtk_spmi_clk_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return mtk_clk_simple_probe_internal(pdev, node, mscd->desc, regmap);
+}
+EXPORT_SYMBOL_GPL(mtk_spmi_clk_simple_probe);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("SPMI");
diff --git a/drivers/clk/mediatek/clk-mtk-spmi.h b/drivers/clk/mediatek/clk-mtk-spmi.h
new file mode 100644
index 000000000000..39499d1db10a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mtk-spmi.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Collabora Ltd
+ * 		      AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __DRV_CLK_MTK_SPMI_H
+#define __DRV_CLK_MTK_SPMI_H
+
+struct mtk_clk_desc;
+struct platform_device;
+
+struct mtk_spmi_clk_desc {
+	const struct mtk_clk_desc *desc;
+	u16 max_register;
+};
+
+#ifdef CONFIG_COMMON_CLK_MEDIATEK_SPMI
+
+int mtk_spmi_clk_simple_probe(struct platform_device *pdev);
+
+#else
+
+inline int mtk_spmi_clk_simple_probe(struct platform_device *pdev)
+{
+	return -ENXIO;
+}
+
+#endif /* CONFIG_COMMON_CLK_MEDIATEK_SPMI */
+
+#endif /* __DRV_CLK_MTK_SPMI_H */
-- 
2.51.1


