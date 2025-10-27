Return-Path: <linux-kernel+bounces-871391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A97C0D1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EE9406C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB22FE58A;
	Mon, 27 Oct 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MDK7dlcT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9D2FC864;
	Mon, 27 Oct 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563634; cv=none; b=nQ4gHSEZ9uRQASOtvWUGU3Y2IvfYztFPfod2kBH+7gn3XOvpWZdu0/h5JTQBwwqqqijTRLY080GnZv5tAi/hg80kFTACXR6U8DBxfdzwizAofDbVaiblpfEXrYkL3Cz5LYGOjMQXHff0whSK5Iu6XAf4DRpyTBfou4w/cZezudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563634; c=relaxed/simple;
	bh=InWvW/RqHEIzJtYcG5sSO2V6IShjDGs6MVJL3tclT7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx6RItPaFf9aBKHTEbR0INpUJEN/kIo9gGXoGZCgBS1F6pIotlLfBJa+fxo/ZuaCvIYjzVBkuw4c0TUoq1IyHBuDm19M8SSdAoNnKfeWcadJ+ELsk3xEPVP8thgqyaayio/+X+p0W0OhjhPDCBj/U0mJWzDSdNBJ8PAiwaYVt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MDK7dlcT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563630;
	bh=InWvW/RqHEIzJtYcG5sSO2V6IShjDGs6MVJL3tclT7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDK7dlcT2L1LfGMOx93zrpnJtbEP3Hz+R9JewLIVXV+IgPok3vs8Srk1CNjmkZiMM
	 L4pDhOn7lSnBMBDZfbDf3yhwe847K3/efs6WmUUQeAZfk8ax5g6CfMq33DQy6Jk8zY
	 Qvyv0MYkOZ4yPiVLWN35TxbAz/1vuyx9vOVLmMJvar9CebnT7ctEanyexKiD/YL36Y
	 VN7mkw/MWotJdFPqXgiUAJaVSAXhKo5IH9+H6VB9ifwLMlp9lWZRpcrUqf8o031Xog
	 unakJNEWUuv/TzY6ERGW/lzAVp3Aoo9FhTG918OUXL5rmbJAY3eQwa0ZhpMemPueT0
	 WcxPXVWx+XIuA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F11B17E1414;
	Mon, 27 Oct 2025 12:13:49 +0100 (CET)
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
Subject: [PATCH v2 5/7] clk: mediatek: Add support to register SPMI Clock Controllers
Date: Mon, 27 Oct 2025 12:13:41 +0100
Message-ID: <20251027111343.21723-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
References: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
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
index 0e8dd82aa84e..0e41990d271f 100644
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
index d8736a060dbd..d2b51e88e51e 100644
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
index 000000000000..945e8e00c226
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


