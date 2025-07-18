Return-Path: <linux-kernel+bounces-737263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A5B0AA06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3104E493F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D52E7F06;
	Fri, 18 Jul 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="CJQ7EmMK";
	dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="sHigkoA/"
Received: from mail.adomerle.pw (mail.adomerle.pw [185.125.100.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5A80C1C;
	Fri, 18 Jul 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.100.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862370; cv=none; b=ZWvdwj210+DjRqTU+UHbnFXooG7hgWHpXg4EqWOOZzZmF7oIcNiOu83LQYL+J58ItC3pSc1dK7UA836Grk1TSniAfsvq+yetM+ZBr7S6xYTqgx1Td5GhlL/qzLXkrD8QuMKh5sqMSbiL0SJqiGGxX2gs8el3hCCKFrWYVwIftZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862370; c=relaxed/simple;
	bh=XHU6vj5ngErCqzUg6h+5wzUS4/1BLcC+CIXqBEdcK7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSFx7WbaLi3kF6aN0Zqu9tOVW9R8u7p7oAL2RwjcIQNrOq349GsqKuItF/5b3nbBCWasRKUB9q63CTLIXbmE8lQPd6VjEF6lN8j1Goz9sUn78dpk4bsXCc8QF02AlXBgBdxcB2k3168Kt7UrJXQwJ60b+8spr5ufeQkBUuyixOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw; spf=pass smtp.mailfrom=adomerle.pw; dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=CJQ7EmMK; dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=sHigkoA/; arc=none smtp.client-ip=185.125.100.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adomerle.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202506r; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752862325; bh=aAFJu8VxmMQrP6lSBu/vAX9
	/45oTvTBHCpQh2Oql4+A=; b=CJQ7EmMKGdXewcAurqsenBNzjOywN1SlpwLeMRz9L5PMWtYZ2W
	xfFmEHzaHZYWh3zRf3c3wd+7PaPaiYDb0jf7TmzMq9FZt5fSVnE8LOWKkkx7En/1qXkOBsrZ2TA
	W8OYnjNcQBlL/E47XGUSrHX7AZAowSgt7G26LSC+aROACx4Y40lWQdvneYKewvlm7DIT/abRoLT
	Bf21Z0MDn1slx+1ZxekWx9ldvmwAaAk/CWreMf177oUP10yL+8H2bLtWe5wDH/QQacv3Ny7NEwe
	K2vNfoB8Gvc3pz7iCM03GkAxaQA+Q6cB47PJ9qYl7Yu3KW5fiMxZ07/pn0P+QOJl/NQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202506e; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752862325; bh=aAFJu8VxmMQrP6lSBu/vAX9
	/45oTvTBHCpQh2Oql4+A=; b=sHigkoA/1kWzZuPTel7Egma6S5calI2vbLjNNIeKo8w9WcSqX/
	C/224nDZpAGxxNBD500h2+3uj5o26pgDLFAA==;
From: Arseniy Velikanov <me@adomerle.pw>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Arseniy Velikanov <me@adomerle.pw>
Subject: [PATCH v2 2/2] clk: mediatek: Add MT6789 clock controllers
Date: Fri, 18 Jul 2025 22:12:00 +0400
Message-ID: <20250718181200.18092-2-me@adomerle.pw>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250718181200.18092-1-me@adomerle.pw>
References: <20250718181200.18092-1-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for MT6789 clock controllers, which includes apmixed, afe,
camsys, imgsys, infracfg, mcusys, mdpsys, mfgcfg, mmsys, topckgen,
vdec, venc.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
---
 drivers/clk/mediatek/Kconfig                  |  68 ++
 drivers/clk/mediatek/Makefile                 |  11 +
 drivers/clk/mediatek/clk-mt6789-apmixed.c     | 146 ++++
 drivers/clk/mediatek/clk-mt6789-audiosys.c    |  95 +++
 drivers/clk/mediatek/clk-mt6789-cam.c         | 122 ++++
 drivers/clk/mediatek/clk-mt6789-img.c         |  93 +++
 .../clk/mediatek/clk-mt6789-imp_iic_wrap.c    |  88 +++
 drivers/clk/mediatek/clk-mt6789-infra_ao.c    | 223 ++++++
 drivers/clk/mediatek/clk-mt6789-mcu.c         |  68 ++
 drivers/clk/mediatek/clk-mt6789-mdp.c         |  76 ++
 drivers/clk/mediatek/clk-mt6789-mfgcfg.c      |  57 ++
 drivers/clk/mediatek/clk-mt6789-mm.c          |  84 +++
 drivers/clk/mediatek/clk-mt6789-topckgen.c    | 673 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt6789-vdec.c        | 115 +++
 drivers/clk/mediatek/clk-mt6789-venc.c        |  61 ++
 15 files changed, 1980 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6789-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-audiosys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-infra_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-mcu.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-mdp.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt6789-venc.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 5f8e6d68fa14..acd6cf4c6fb3 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -303,6 +303,74 @@ config COMMON_CLK_MT6779_AUDSYS
 	help
 	  This driver supports Mediatek MT6779 audsys clocks.
 
+config COMMON_CLK_MT6789
+	tristate "Clock driver for MediaTek MT6789"
+	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK && ARM64
+	help
+	  This driver supports MediaTek MT6789 basic clocks.
+
+config COMMON_CLK_MT6789_IMP_IIC_WRAP
+	tristate "Clock driver for Mediatek MT6789 imp_iic_wrap clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 imp_iic_wrap clocks.
+
+config COMMON_CLK_MT6789_MCUSYS
+	tristate "Clock driver for Mediatek MT6789 mcusys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 mcusys clocks.
+
+config COMMON_CLK_MT6789_MDPSYS
+	tristate "Clock driver for Mediatek MT6789 mdpsys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 mdpsys clocks.
+
+config COMMON_CLK_MT6789_MFGCFG
+	tristate "Clock driver for Mediatek MT6789 mfgcfg clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 mfgcfg clocks.
+
+config COMMON_CLK_MT6789_MMSYS
+	tristate "Clock driver for Mediatek MT6789 mmsys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 mmsys clocks.
+
+config COMMON_CLK_MT6789_VDECSYS
+	tristate "Clock driver for Mediatek MT6789 vdecsys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 vdecsys clocks.
+
+config COMMON_CLK_MT6789_VENCSYS
+	tristate "Clock driver for Mediatek MT6789 vencsys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 vencsys clocks.
+
+config COMMON_CLK_MT6789_IMGSYS
+	tristate "Clock driver for Mediatek MT6789 imgsys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 imgsys clocks.
+
+config COMMON_CLK_MT6789_AUDIOSYS
+	tristate "Clock driver for Mediatek MT6789 audiosys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 audiosys clocks.
+
+config COMMON_CLK_MT6789_CAMSYS
+	tristate "Clock driver for Mediatek MT6789 camsys clocks"
+	depends on COMMON_CLK_MT6789
+	help
+	  This driver supports Mediatek MT6789 camsys clocks.
+
 config COMMON_CLK_MT6795
 	tristate "Clock driver for MediaTek MT6795"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6efec95406bd..9ca426f65567 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -23,6 +23,17 @@ obj-$(CONFIG_COMMON_CLK_MT6779_VDECSYS) += clk-mt6779-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT6779_VENCSYS) += clk-mt6779-venc.o
 obj-$(CONFIG_COMMON_CLK_MT6779_MFGCFG) += clk-mt6779-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT6779_AUDSYS) += clk-mt6779-aud.o
+obj-$(CONFIG_COMMON_CLK_MT6789) += clk-mt6789-apmixed.o clk-mt6789-topckgen.o clk-mt6789-infra_ao.o
+obj-$(CONFIG_COMMON_CLK_MT6789_IMP_IIC_WRAP) += clk-mt6789-imp_iic_wrap.o
+obj-$(CONFIG_COMMON_CLK_MT6789_MCUSYS) += clk-mt6789-mcu.o
+obj-$(CONFIG_COMMON_CLK_MT6789_MDPSYS) += clk-mt6789-mdp.o
+obj-$(CONFIG_COMMON_CLK_MT6789_MFGCFG) += clk-mt6789-mfgcfg.o
+obj-$(CONFIG_COMMON_CLK_MT6789_MMSYS) += clk-mt6789-mm.o
+obj-$(CONFIG_COMMON_CLK_MT6789_VDECSYS) += clk-mt6789-vdec.o
+obj-$(CONFIG_COMMON_CLK_MT6789_VENCSYS) += clk-mt6789-venc.o
+obj-$(CONFIG_COMMON_CLK_MT6789_IMGSYS) += clk-mt6789-img.o
+obj-$(CONFIG_COMMON_CLK_MT6789_AUDIOSYS) += clk-mt6789-audiosys.o
+obj-$(CONFIG_COMMON_CLK_MT6789_CAMSYS) += clk-mt6789-cam.o
 obj-$(CONFIG_COMMON_CLK_MT6795) += clk-mt6795-apmixedsys.o clk-mt6795-infracfg.o \
 				   clk-mt6795-pericfg.o clk-mt6795-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT6795_MFGCFG) += clk-mt6795-mfg.o
diff --git a/drivers/clk/mediatek/clk-mt6789-apmixed.c b/drivers/clk/mediatek/clk-mt6789-apmixed.c
new file mode 100644
index 000000000000..17847712e2a8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-apmixed.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk-mtk.h"
+#include "clk-gate.h"
+#include "clk-mux.h"
+#include "clk-pll.h"
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+#define MT6789_PLL_FMAX		(3800UL * MHZ)
+#define MT6789_PLL_FMIN		(1500UL * MHZ)
+#define MT6789_INTEGER_BITS	8
+
+#define PLL(_id, _name, _reg, _en_reg, _en_mask, _pll_en_bit,		\
+			_pwr_reg, _flags, _rst_bar_mask,		\
+			_pd_reg, _pd_shift, _tuner_reg,			\
+			_tuner_en_reg, _tuner_en_bit,			\
+			_pcw_reg, _pcw_shift, _pcwbits) {		\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.en_reg = _en_reg,					\
+		.en_mask = _en_mask,					\
+		.pll_en_bit = _pll_en_bit,				\
+		.pwr_reg = _pwr_reg,					\
+		.flags = _flags,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.fmax = MT6789_PLL_FMAX,				\
+		.fmin = MT6789_PLL_FMIN,				\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = MT6789_INTEGER_BITS,			\
+	}
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x208, 0x208, 0, 0,
+	    0x214, PLL_AO, BIT(0), 0x20C, 24,
+	    0, 0, 0, 0x20C, 0, 22),
+	PLL(CLK_APMIXED_ARMPLL_BL0, "armpll_bl0", 0x218, 0x218, 0, 0,
+	    0x224, PLL_AO, BIT(0), 0x21C, 24,
+	    0, 0, 0, 0x21C, 0, 22),
+	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x258, 0x258, 0, 0,
+	    0x264, PLL_AO, BIT(0), 0x25C, 24,
+	    0, 0, 0, 0x25C, 0, 22),
+	PLL(CLK_APMIXED_MPLL, "mpll", 0x390, 0x390, 0, 0,
+	    0x39C, PLL_AO, BIT(0), 0x394, 24,
+	    0, 0, 0, 0x394, 0, 22),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x340, 0x340, 0xff000000, 0,
+	    0x34C, HAVE_RST_BAR | PLL_AO, BIT(23), 0x344, 24,
+	    0, 0, 0, 0x344, 0, 22),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x308, 0x308, 0xff000000, 0,
+	    0x314, HAVE_RST_BAR, BIT(23), 0x30C, 24,
+	    0, 0, 0, 0x30C, 0, 22),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x350, 0x350, 0, 0,
+	    0x35C, 0, BIT(0), 0x354, 24,
+	    0, 0, 0, 0x354, 0, 22),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x360, 0x360, 0xff000000, 0,
+	    0x36C, HAVE_RST_BAR, BIT(23), 0x364, 24,
+	    0, 0, 0, 0x364, 0, 22),
+	PLL(CLK_APMIXED_NPUPLL, "npupll", 0x3B4, 0x3B4, 0xff000000, 0,
+	    0x3C0, 0, BIT(0), 0x3B8, 24,
+	    0, 0, 0, 0x3B8, 0, 22),
+	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x268, 0x268, 0, 0,
+	    0x274, 0, BIT(0), 0x26C, 24,
+	    0, 0, 0, 0x26C, 0, 22),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x380, 0x380, 0, 0,
+	    0x38C, 0, BIT(0), 0x384, 24,
+	    0, 0, 0, 0x384, 0, 22),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x318, 0x318, 0, 0,
+	    0x328, 0, BIT(0), 0x31C, 24,
+	    0x040, 0x00C, 0, 0x320, 0, 32),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x32C, 0x32C, 0, 0,
+	    0x33C, 0, BIT(0), 0x330, 24,
+	    0x044, 0x00C, 5, 0x334, 0, 32),
+	PLL(CLK_APMIXED_USBPLL, "usbpll", 0x3C4, 0x3CC, 0, 2,
+	    0x3CC, HAVE_RST_BAR, BIT(23), 0x3C4, 24,
+	    0, 0, 0, 0x3C4, 0, 22),
+};
+
+static const struct of_device_id of_match_clk_mt6789_apmixed[] = {
+	{ .compatible = "mediatek,mt6789-apmixedsys" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_apmixed);
+
+static int clk_mt6789_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	return r;
+
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static void clk_mt6789_apmixed_remove(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static struct platform_driver clk_mt6789_apmixed_drv = {
+	.probe = clk_mt6789_apmixed_probe,
+	.remove = clk_mt6789_apmixed_remove,
+	.driver = {
+		.name = "clk-mt6789-apmixed",
+		.of_match_table = of_match_clk_mt6789_apmixed,
+	},
+};
+module_platform_driver(clk_mt6789_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 apmixedsys clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-audiosys.c b/drivers/clk/mediatek/clk-mt6789-audiosys.c
new file mode 100644
index 000000000000..31c1d6a221cc
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-audiosys.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs afe0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs afe1_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_AFE0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_AFE1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &afe1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+static const struct mtk_gate afe_clks[] = {
+	/* AFE0 */
+	GATE_AFE0(CLK_AFE_AFE, "afe_afe", "audio_sel", 2),
+	GATE_AFE0(CLK_AFE_22M, "afe_22m", "aud_engen1_sel", 8),
+	GATE_AFE0(CLK_AFE_24M, "afe_24m", "aud_engen2_sel", 9),
+	GATE_AFE0(CLK_AFE_APLL2_TUNER, "afe_apll2_tuner", "aud_engen2_sel", 18),
+	GATE_AFE0(CLK_AFE_APLL_TUNER, "afe_apll_tuner", "aud_engen1_sel", 19),
+	GATE_AFE0(CLK_AFE_ADC, "afe_adc", "audio_sel", 24),
+	GATE_AFE0(CLK_AFE_DAC, "afe_dac", "audio_sel", 25),
+	GATE_AFE0(CLK_AFE_DAC_PREDIS, "afe_dac_predis", "audio_sel", 26),
+	GATE_AFE0(CLK_AFE_TML, "afe_tml", "audio_sel", 27),
+	GATE_AFE0(CLK_AFE_NLE, "afe_nle", "audio_sel", 28),
+	/* AFE1 */
+	GATE_AFE1(CLK_AFE_I2S1_BCLK, "afe_i2s1_bclk", "audio_sel", 4),
+	GATE_AFE1(CLK_AFE_I2S2_BCLK, "afe_i2s2_bclk", "audio_sel", 5),
+	GATE_AFE1(CLK_AFE_I2S3_BCLK, "afe_i2s3_bclk", "audio_sel", 6),
+	GATE_AFE1(CLK_AFE_I2S4_BCLK, "afe_i2s4_bclk", "audio_sel", 7),
+	GATE_AFE1(CLK_AFE_GENERAL3_ASRC, "afe_general3_asrc", "audio_sel", 11),
+	GATE_AFE1(CLK_AFE_CONNSYS_I2S_ASRC, "afe_connsys_i2s_asrc", "audio_sel", 12),
+	GATE_AFE1(CLK_AFE_GENERAL1_ASRC, "afe_general1_asrc", "audio_sel", 13),
+	GATE_AFE1(CLK_AFE_GENERAL2_ASRC, "afe_general2_asrc", "audio_sel", 14),
+	GATE_AFE1(CLK_AFE_DAC_HIRES, "afe_dac_hires", "audio_h_sel", 15),
+	GATE_AFE1(CLK_AFE_ADC_HIRES, "afe_adc_hires", "audio_h_sel", 16),
+	GATE_AFE1(CLK_AFE_ADC_HIRES_TML, "afe_adc_hires_tml", "audio_h_sel", 17),
+};
+
+static const struct mtk_clk_desc afe_desc = {
+	.clks = afe_clks,
+	.num_clks = ARRAY_SIZE(afe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_audiosys[] = {
+	{ .compatible = "mediatek,mt6789-afe", .data = &afe_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_audiosys);
+
+static struct platform_driver clk_mt6789_audiosys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-audiosys",
+		.of_match_table = of_match_clk_mt6789_audiosys,
+	},
+};
+module_platform_driver(clk_mt6789_audiosys_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 audio clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-cam.c b/drivers/clk/mediatek/clk-mt6789-cam.c
new file mode 100644
index 000000000000..6db517a0950a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-cam.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs cam_m_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_M(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &cam_m_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate cam_m_clks[] = {
+	GATE_CAM_M(CLK_CAM_M_LARB13, "cam_m_larb13", "cam_sel", 0),
+	GATE_CAM_M(CLK_CAM_M_LARB14, "cam_m_larb14", "cam_sel", 2),
+	GATE_CAM_M(CLK_CAM_M_CAM, "cam_m_cam", "cam_sel", 6),
+	GATE_CAM_M(CLK_CAM_M_CAMTG, "cam_m_camtg", "cam_sel", 7),
+	GATE_CAM_M(CLK_CAM_M_SENINF, "cam_m_seninf", "cam_sel", 8),
+	GATE_CAM_M(CLK_CAM_M_CAMSV1, "cam_m_camsv1", "cam_sel", 10),
+	GATE_CAM_M(CLK_CAM_M_CAMSV2, "cam_m_camsv2", "cam_sel", 11),
+	GATE_CAM_M(CLK_CAM_M_CAMSV3, "cam_m_camsv3", "cam_sel", 12),
+	GATE_CAM_M(CLK_CAM_M_MRAW0, "cam_m_mraw0", "cam_sel", 15),
+	GATE_CAM_M(CLK_CAM_M_FAKE_ENG, "cam_m_fake_eng", "cam_sel", 17),
+	GATE_CAM_M(CLK_CAM_M_CAM2MM_GALS, "cam_m_cam2mm_gals", "cam_sel", 19),
+};
+
+static const struct mtk_clk_desc cam_m_desc = {
+	.clks = cam_m_clks,
+	.num_clks = ARRAY_SIZE(cam_m_clks),
+};
+
+static const struct mtk_gate_regs cam_ra_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_RA(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &cam_ra_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate cam_ra_clks[] = {
+	GATE_CAM_RA(CLK_CAM_RA_LARBX, "cam_ra_larbx", "cam_sel", 0),
+	GATE_CAM_RA(CLK_CAM_RA_CAM, "cam_ra_cam", "cam_sel", 1),
+	GATE_CAM_RA(CLK_CAM_RA_CAMTG, "cam_ra_camtg", "camtm_sel", 2),
+};
+
+static const struct mtk_clk_desc cam_ra_desc = {
+	.clks = cam_ra_clks,
+	.num_clks = ARRAY_SIZE(cam_ra_clks),
+};
+
+static const struct mtk_gate_regs cam_rb_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM_RB(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &cam_rb_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate cam_rb_clks[] = {
+	GATE_CAM_RB(CLK_CAM_RB_LARBX, "cam_rb_larbx", "cam_sel", 0),
+	GATE_CAM_RB(CLK_CAM_RB_CAM, "cam_rb_cam", "cam_sel", 1),
+	GATE_CAM_RB(CLK_CAM_RB_CAMTG, "cam_rb_camtg", "camtm_sel", 2),
+};
+
+static const struct mtk_clk_desc cam_rb_desc = {
+	.clks = cam_rb_clks,
+	.num_clks = ARRAY_SIZE(cam_rb_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_cam[] = {
+	{ .compatible = "mediatek,mt6789-camsys", .data = &cam_m_desc },
+	{ .compatible = "mediatek,mt6789-camsys-rawa", .data = &cam_ra_desc },
+	{ .compatible = "mediatek,mt6789-camsys-rawb", .data = &cam_rb_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_cam);
+
+static struct platform_driver clk_mt6789_cam_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-cam",
+		.of_match_table = of_match_clk_mt6789_cam,
+	},
+};
+module_platform_driver(clk_mt6789_cam_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 Camera clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-img.c b/drivers/clk/mediatek/clk-mt6789-img.c
new file mode 100644
index 000000000000..b0ba2bbcda3a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-img.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs imgsys_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMGSYS(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &imgsys_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate imgsys_clks[] = {
+	GATE_IMGSYS(CLK_IMGSYS_LARB9, "imgsys_larb9", "img1_sel", 0),
+	GATE_IMGSYS(CLK_IMGSYS_LARB10, "imgsys_larb10", "img1_sel", 1),
+	GATE_IMGSYS(CLK_IMGSYS_DIP, "imgsys_dip", "img1_sel", 2),
+	GATE_IMGSYS(CLK_IMGSYS_GALS, "imgsys_gals", "img1_sel", 12),
+};
+
+static const struct mtk_clk_desc imgsys_desc = {
+	.clks = imgsys_clks,
+	.num_clks = ARRAY_SIZE(imgsys_clks),
+};
+
+static const struct mtk_gate_regs ipe_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IPE(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ipe_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate ipe_clks[] = {
+	GATE_IPE(CLK_IPE_LARB19, "ipe_larb19", "ipe_sel", 0),
+	GATE_IPE(CLK_IPE_LARB20, "ipe_larb20", "ipe_sel", 1),
+	GATE_IPE(CLK_IPE_SMI_SUBCOM, "ipe_smi_subcom", "ipe_sel", 2),
+	GATE_IPE(CLK_IPE_FD, "ipe_fd", "ipe_sel", 3),
+	GATE_IPE(CLK_IPE_FE, "ipe_fe", "ipe_sel", 4),
+	GATE_IPE(CLK_IPE_RSC, "ipe_rsc", "ipe_sel", 5),
+	GATE_IPE(CLK_IPE_DPE, "ipe_dpe", "ipe_sel", 6),
+	GATE_IPE(CLK_IPE_GALS, "ipe_gals", "img1_sel", 8),
+};
+
+static const struct mtk_clk_desc ipesys_desc = {
+	.clks = ipe_clks,
+	.num_clks = ARRAY_SIZE(ipe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_img[] = {
+	{ .compatible = "mediatek,mt6789-imgsys", .data = &imgsys_desc },
+	{ .compatible = "mediatek,mt6789-ipesys", .data = &ipesys_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_img);
+
+static struct platform_driver clk_mt6789_img_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-img",
+		.of_match_table = of_match_clk_mt6789_img,
+	},
+};
+module_platform_driver(clk_mt6789_img_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 imgsys clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c
new file mode 100644
index 000000000000..e15f78c598a8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)			\
+	GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift,			\
+		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+
+static const struct mtk_gate imp_iic_wrap_c_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C3, "imp_iic_wrap_c_i2c3", "top_i2c", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C5, "imp_iic_wrap_c_i2c5", "top_i2c", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C6, "imp_iic_wrap_c_i2c6", "top_i2c", 2),
+};
+
+static const struct mtk_gate imp_iic_wrap_w_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C0, "imp_iic_wrap_w_i2c0", "top_i2c", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C1, "imp_iic_wrap_w_i2c1", "top_i2c", 1),
+};
+
+static const struct mtk_gate imp_iic_wrap_n_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_N_I2C7, "imp_iic_wrap_n_i2c7", "top_i2c", 0),
+};
+
+static const struct mtk_gate imp_iic_wrap_en_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_I2C2, "imp_iic_wrap_en_i2c2", "top_i2c", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_I2C4, "imp_iic_wrap_en_i2c4", "top_i2c", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_I2C8, "imp_iic_wrap_en_i2c8", "top_i2c", 2),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_EN_I2C9, "imp_iic_wrap_en_i2c9", "top_i2c", 3),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_c_desc = {
+	.clks = imp_iic_wrap_c_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_c_clks),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_w_desc = {
+	.clks = imp_iic_wrap_w_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_w_clks),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_n_desc = {
+	.clks = imp_iic_wrap_n_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_n_clks),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_en_desc = {
+	.clks = imp_iic_wrap_en_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_en_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_imp_iic_wrap[] = {
+	{ .compatible = "mediatek,mt6789-imp-iic-wrap-c", .data = &imp_iic_wrap_c_desc },
+	{ .compatible = "mediatek,mt6789-imp-iic-wrap-w", .data = &imp_iic_wrap_w_desc },
+	{ .compatible = "mediatek,mt6789-imp-iic-wrap-n", .data = &imp_iic_wrap_n_desc },
+	{ .compatible = "mediatek,mt6789-imp-iic-wrap-en", .data = &imp_iic_wrap_en_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_imp_iic_wrap);
+
+static struct platform_driver clk_mt6789_imp_iic_wrap_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-imp_iic_wrap",
+		.of_match_table = of_match_clk_mt6789_imp_iic_wrap,
+	},
+};
+module_platform_driver(clk_mt6789_imp_iic_wrap_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 I2C Wrapper clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-infra_ao.c b/drivers/clk/mediatek/clk-mt6789-infra_ao.c
new file mode 100644
index 000000000000..e5feecdb5693
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-infra_ao.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+#include <dt-bindings/reset/mediatek,mt6789-resets.h>
+
+static const struct mtk_gate_regs infra_ao0_cg_regs = {
+	.set_ofs = 0x80,
+	.clr_ofs = 0x84,
+	.sta_ofs = 0x90,
+};
+
+static const struct mtk_gate_regs infra_ao1_cg_regs = {
+	.set_ofs = 0x88,
+	.clr_ofs = 0x8C,
+	.sta_ofs = 0x94,
+};
+
+static const struct mtk_gate_regs infra_ao2_cg_regs = {
+	.set_ofs = 0xA4,
+	.clr_ofs = 0xA8,
+	.sta_ofs = 0xAC,
+};
+
+static const struct mtk_gate_regs infra_ao3_cg_regs = {
+	.set_ofs = 0xC0,
+	.clr_ofs = 0xC4,
+	.sta_ofs = 0xC8,
+};
+
+static const struct mtk_gate_regs infra_ao4_cg_regs = {
+	.set_ofs = 0xE0,
+	.clr_ofs = 0xE4,
+	.sta_ofs = 0xE8,
+};
+
+static const struct mtk_gate_regs infra_ao5_cg_regs = {
+	.set_ofs = 0xd0,
+	.clr_ofs = 0xd4,
+	.sta_ofs = 0xd8,
+
+};
+
+#define GATE_IFRAO0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &infra_ao0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFRAO1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &infra_ao1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFRAO2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &infra_ao2_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFRAO3(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &infra_ao3_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFRAO4(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &infra_ao4_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFRAO5(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &infra_ao5_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate infra_ao_clks[] = {
+	/* IFRAO0 */
+	GATE_IFRAO0(CLK_IFRAO_PMIC_TMR, "ifrao_pmic_tmr", "pwrap_ulposc_sel", 0),
+	GATE_IFRAO0(CLK_IFRAO_PMIC_AP, "ifrao_pmic_ap", "pwrap_ulposc_sel", 1),
+	GATE_IFRAO0(CLK_IFRAO_GCE, "ifrao_gce", "axi_sel", 8),
+	GATE_IFRAO0(CLK_IFRAO_GCE2, "ifrao_gce2", "axi_sel", 9),
+	GATE_IFRAO0(CLK_IFRAO_THERM, "ifrao_therm", "axi_sel", 10),
+	GATE_IFRAO0(CLK_IFRAO_I2C_PSEUDO, "ifrao_i2c_pseudo", "i2c_sel", 11),
+	GATE_IFRAO0(CLK_IFRAO_APDMA_PSEUDO, "ifrao_apdma_pseudo", "axi_sel", 12),
+	GATE_IFRAO0(CLK_IFRAO_PWM_HCLK, "ifrao_pwm_hclk", "axi_sel", 15),
+	GATE_IFRAO0(CLK_IFRAO_PWM1, "ifrao_pwm1", "pwm_sel", 16),
+	GATE_IFRAO0(CLK_IFRAO_PWM2, "ifrao_pwm2", "pwm_sel", 17),
+	GATE_IFRAO0(CLK_IFRAO_PWM3, "ifrao_pwm3", "pwm_sel", 18),
+	GATE_IFRAO0(CLK_IFRAO_PWM4, "ifrao_pwm4", "pwm_sel", 19),
+	GATE_IFRAO0(CLK_IFRAO_PWM, "ifrao_pwm", "pwm_sel", 21),
+	GATE_IFRAO0(CLK_IFRAO_UART0, "ifrao_uart0", "uart_sel", 22),
+	GATE_IFRAO0(CLK_IFRAO_UART1, "ifrao_uart1", "uart_sel", 23),
+	GATE_IFRAO0(CLK_IFRAO_UART2, "ifrao_uart2", "uart_sel", 24),
+	GATE_IFRAO0(CLK_IFRAO_UART3, "ifrao_uart3", "uart_sel", 25),
+	GATE_IFRAO0(CLK_IFRAO_GCE_26M, "ifrao_gce_26m", "axi_sel", 27),
+	GATE_IFRAO0(CLK_IFRAO_BTIF, "ifrao_btif", "axi_sel", 31),
+	/* IFRAO1 */
+	GATE_IFRAO1(CLK_IFRAO_SPI0, "ifrao_spi0", "spi_sel", 1),
+	GATE_IFRAO1(CLK_IFRAO_MSDC0, "ifrao_msdc0", "axi_sel", 2),
+	GATE_IFRAO1(CLK_IFRAO_MSDC1, "ifrao_msdc1", "axi_sel", 4),
+	GATE_IFRAO1(CLK_IFRAO_MSDC0_SRC, "ifrao_msdc0_clk", "msdc50_0_sel", 6),
+	GATE_IFRAO1(CLK_IFRAO_AUXADC, "ifrao_auxadc", "clk26m", 10),
+	GATE_IFRAO1(CLK_IFRAO_CPUM, "ifrao_cpum", "axi_sel", 11),
+	GATE_IFRAO1(CLK_IFRAO_CCIF1_AP, "ifrao_ccif1_ap", "axi_sel", 12),
+	GATE_IFRAO1(CLK_IFRAO_CCIF1_MD, "ifrao_ccif1_md", "axi_sel", 13),
+	GATE_IFRAO1(CLK_IFRAO_AUXADC_MD, "ifrao_auxadc_md", "clk26m", 14),
+	GATE_IFRAO1(CLK_IFRAO_MSDC1_SRC, "ifrao_msdc1_clk", "msdc30_1_sel", 16),
+	GATE_IFRAO1(CLK_IFRAO_MSDC0_AES, "ifrao_msdc0_aes_clk", "msdc50_0_sel", 17),
+	GATE_IFRAO1(CLK_IFRAO_CCIF_AP, "ifrao_ccif_ap", "axi_sel", 23),
+	GATE_IFRAO1(CLK_IFRAO_DEBUGSYS, "ifrao_debugsys", "axi_sel", 24),
+	GATE_IFRAO1(CLK_IFRAO_AUDIO, "ifrao_audio", "axi_sel", 25),
+	GATE_IFRAO1(CLK_IFRAO_CCIF_MD, "ifrao_ccif_md", "axi_sel", 26),
+	/* IFRAO2 */
+	GATE_IFRAO2(CLK_IFRAO_SSUSB, "ifrao_ssusb", "usb_sel", 1),
+	GATE_IFRAO2(CLK_IFRAO_DISP_PWM, "ifrao_disp_pwm", "disp_pwm_sel", 2),
+	GATE_IFRAO2(CLK_IFRAO_CLDMA_BCLK, "ifrao_cldmabclk", "axi_sel", 3),
+	GATE_IFRAO2(CLK_IFRAO_AUDIO_26M_BCLK, "ifrao_audio26m", "clk26m", 4),
+	GATE_IFRAO2(CLK_IFRAO_SPI1, "ifrao_spi1", "spi_sel", 6),
+	GATE_IFRAO2(CLK_IFRAO_SPI2, "ifrao_spi2", "spi_sel", 9),
+	GATE_IFRAO2(CLK_IFRAO_SPI3, "ifrao_spi3", "spi_sel", 10),
+	GATE_IFRAO2(CLK_IFRAO_UNIPRO_SYSCLK, "ifrao_unipro_sysclk", "ufs_sel", 11),
+	GATE_IFRAO2(CLK_IFRAO_UNIPRO_TICK, "ifrao_unipro_tick", "clk26m", 12),
+	GATE_IFRAO2(CLK_IFRAO_UFS_SAP_BCLK, "ifrao_u_bclk", "clk26m", 13),
+	GATE_IFRAO2(CLK_IFRAO_SPI4, "ifrao_spi4", "spi_sel", 25),
+	GATE_IFRAO2(CLK_IFRAO_SPI5, "ifrao_spi5", "spi_sel", 26),
+	GATE_IFRAO2(CLK_IFRAO_CQ_DMA, "ifrao_cq_dma", "axi_sel", 27),
+	GATE_IFRAO2(CLK_IFRAO_UFS, "ifrao_ufs", "ufs_sel", 28),
+	GATE_IFRAO2(CLK_IFRAO_UFS_AES, "ifrao_u_aes", "aes_ufsfde_sel", 29),
+	/* IFRAO3 */
+	GATE_IFRAO3(CLK_IFRAO_AP_MSDC0, "ifrao_ap_msdc0", "msdc50_0_sel", 7),
+	GATE_IFRAO3(CLK_IFRAO_MD_MSDC0, "ifrao_md_msdc0", "msdc50_0_sel", 8),
+	GATE_IFRAO3(CLK_IFRAO_CCIF5_MD, "ifrao_ccif5_md", "axi_sel", 10),
+	GATE_IFRAO3(CLK_IFRAO_CCIF2_AP, "ifrao_ccif2_ap", "axi_sel", 16),
+	GATE_IFRAO3(CLK_IFRAO_CCIF2_MD, "ifrao_ccif2_md", "axi_sel", 17),
+	GATE_IFRAO3(CLK_IFRAO_FBIST2FPC, "ifrao_fbist2fpc", "msdc50_0_sel", 24),
+	GATE_IFRAO3(CLK_IFRAO_DPMAIF_MAIN, "ifrao_dpmaif_main", "dpmaif_main_sel", 26),
+	GATE_IFRAO3(CLK_IFRAO_CCIF4_AP, "ifrao_ccif4_ap", "axi_sel", 28),
+	GATE_IFRAO3(CLK_IFRAO_CCIF4_MD, "ifrao_ccif4_md", "axi_sel", 29),
+	GATE_IFRAO3(CLK_IFRAO_SPI6_CK, "ifrao_spi6_ck", "spi_sel", 30),
+	GATE_IFRAO3(CLK_IFRAO_SPI7_CK, "ifrao_spi7_ck", "spi_sel", 31),
+	/* IFRAO4 */
+	GATE_IFRAO4(CLK_IFRAO_66MP_BUS_MCLK_CKP, "ifrao_66mp_mclkp", "axi_sel", 2),
+	/* IFRAO5 */
+	GATE_IFRAO5(CLK_IFRAO_AP_DMA, "ifrao_ap_dma", "ifrao_apdma_pseudo", 31),
+};
+
+static u16 infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+};
+
+static u16 infra_ao_idx_map[] = {
+	[MT6789_INFRA_RST0_LVTS_AP_SWRST] = 0 * RST_NR_PER_BANK + 0,
+	[MT6789_INFRA_RST1_UFSHCI_SWRST] = 1 * RST_NR_PER_BANK + 15,
+	[MT6789_INFRA_RST2_UNIPRO_SWRST] = 3 * RST_NR_PER_BANK + 7,
+	[MT6789_INFRA_RST3_UFS_CRYPTO_SWRST] = 4 * RST_NR_PER_BANK + 21,
+};
+
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
+	.rst_idx_map = infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
+};
+
+static const struct mtk_clk_desc infra_ao_desc = {
+	.clks = infra_ao_clks,
+	.num_clks = ARRAY_SIZE(infra_ao_clks),
+	.rst_desc = &clk_rst_desc,
+};
+
+static const struct of_device_id of_match_clk_mt6789_infra_ao[] = {
+	{ .compatible = "mediatek,mt6789-infracfg-ao", .data = &infra_ao_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_infra_ao);
+
+static struct platform_driver clk_mt6789_infra_ao_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-infra_ao",
+		.of_match_table = of_match_clk_mt6789_infra_ao,
+	},
+};
+module_platform_driver(clk_mt6789_infra_ao_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 infracfg clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-mcu.c b/drivers/clk/mediatek/clk-mt6789-mcu.c
new file mode 100644
index 000000000000..42ff4f954110
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-mcu.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+#include "clk-mtk.h"
+
+static const char * const mcu_armpll_ll_parents[] = {
+	"clk26m",
+	"armpll_ll",
+	"mainpll",
+	"univpll_d2"
+};
+
+static const char * const mcu_armpll_bl_parents[] = {
+	"clk26m",
+	"armpll_bl",
+	"mainpll",
+	"univpll_d2"
+};
+
+static const char * const mcu_armpll_bus_parents[] = {
+	"clk26m",
+	"ccipll",
+	"mainpll",
+	"univpll_d2"
+};
+
+/*
+ * We only configure the CPU muxes when adjust CPU frequency in MediaTek CPUFreq Driver.
+ * Other fields like divider always keep the same value. (set once in bootloader)
+ */
+static struct mtk_composite mcu_muxes[] = {
+	/* MP0_PLL_DIV */
+	MUX(CLK_MCU_ARMPLL_LL_SEL, "mcu_armpll_ll_sel", mcu_armpll_ll_parents, 0x2A0, 9, 2),
+	/* MP1_PLL_DIV */
+	MUX(CLK_MCU_ARMPLL_BL_SEL, "mcu_armpll_bl_sel", mcu_armpll_bl_parents, 0x2A4, 9, 2),
+	/* BUS_PLL_DIV */
+	MUX(CLK_MCU_ARMPLL_BUS_SEL, "mcu_armpll_bus_sel", mcu_armpll_bus_parents, 0x2E0, 9, 2),
+};
+
+static const struct mtk_clk_desc mcu_desc = {
+	.composite_clks = mcu_muxes,
+	.num_composite_clks = ARRAY_SIZE(mcu_muxes),
+};
+
+static const struct of_device_id of_match_clk_mt6789_mcu[] = {
+	{ .compatible = "mediatek,mt6789-mcusys", .data = &mcu_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_mcu);
+
+static struct platform_driver clk_mt6789_mcu_drv = {
+	.driver = {
+		.name = "clk-mt6789-mcu",
+		.of_match_table = of_match_clk_mt6789_mcu,
+	},
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+};
+module_platform_driver(clk_mt6789_mcu_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 mcusys clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-mdp.c b/drivers/clk/mediatek/clk-mt6789-mdp.c
new file mode 100644
index 000000000000..b867fde1b092
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-mdp.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs mdp0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mdp1_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+#define GATE_MDP0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mdp0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MDP1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mdp1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mdp_clks[] = {
+	GATE_MDP0(CLK_MDP_RDMA0, "mdp_rdma0", "mdp_sel", 0),
+	GATE_MDP0(CLK_MDP_TDSHP0, "mdp_tdshp0", "mdp_sel", 1),
+	GATE_MDP0(CLK_MDP_IMG_DL_ASYNC0, "mdp_img_dl_async0", "mdp_sel", 2),
+	GATE_MDP0(CLK_MDP_IMG_DL_ASYNC1, "mdp_img_dl_async1", "mdp_sel", 3),
+	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0", "mdp_sel", 6),
+	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus", "mdp_sel", 7),
+	GATE_MDP0(CLK_MDP_WROT0, "mdp_wrot0", "mdp_sel", 8),
+	GATE_MDP0(CLK_MDP_RSZ0, "mdp_rsz0", "mdp_sel", 9),
+	GATE_MDP0(CLK_MDP_HDR0, "mdp_hdr0", "mdp_sel", 10),
+	GATE_MDP0(CLK_MDP_MUTEX0, "mdp_mutex0", "mdp_sel", 11),
+	GATE_MDP0(CLK_MDP_WROT1, "mdp_wrot1", "mdp_sel", 12),
+	GATE_MDP0(CLK_MDP_RSZ1, "mdp_rsz1", "mdp_sel", 13),
+	GATE_MDP0(CLK_MDP_FAKE_ENG0, "mdp_fake_eng0", "mdp_sel", 14),
+	GATE_MDP0(CLK_MDP_AAL0, "mdp_aal0", "mdp_sel", 15),
+
+	GATE_MDP1(CLK_MDP_IMG_DL_RELAY0_ASYNC0, "mdp_img_dl_rel0_as0", "mdp_sel", 0),
+	GATE_MDP1(CLK_MDP_IMG_DL_RELAY1_ASYNC1, "mdp_img_dl_rel1_as1", "mdp_sel", 8),
+};
+
+static const struct mtk_clk_desc mdp_desc = {
+	.clks = mdp_clks,
+	.num_clks = ARRAY_SIZE(mdp_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_mdp[] = {
+	{ .compatible = "mediatek,mt6789-mdpsys", .data = &mdp_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_mdp);
+
+static struct platform_driver clk_mt6789_mdp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-mdp",
+		.of_match_table = of_match_clk_mt6789_mdp,
+	},
+};
+module_platform_driver(clk_mt6789_mdp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 Multimedia Data Path clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-mfgcfg.c b/drivers/clk/mediatek/clk-mt6789-mfgcfg.c
new file mode 100644
index 000000000000..a22a0863bdc0
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-mfgcfg.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs mfgcfg_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_MFGCFG(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &mfgcfg_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate mfgcfg_clks[] = {
+	GATE_MFGCFG(CLK_MFGCFG_BG3D, "mfgcfg_bg3d", "mfg_pll_sel", 0),
+};
+
+static const struct mtk_clk_desc mfgcfg_desc = {
+	.clks = mfgcfg_clks,
+	.num_clks = ARRAY_SIZE(mfgcfg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_mfgcfg[] = {
+	{ .compatible = "mediatek,mt6789-mfgcfg", .data = &mfgcfg_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_mfgcfg);
+
+static struct platform_driver clk_mt6789_mfgcfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-mfgcfg",
+		.of_match_table = of_match_clk_mt6789_mfgcfg,
+	},
+};
+module_platform_driver(clk_mt6789_mfgcfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 GPU mfg clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-mm.c b/drivers/clk/mediatek/clk-mt6789-mm.c
new file mode 100644
index 000000000000..6061fd83adc5
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-mm.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x1A4,
+	.clr_ofs = 0x1A8,
+	.sta_ofs = 0x1A0,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mm_clks[] = {
+	GATE_MM0(CLK_MM_DISP_MUTEX0, "mm_disp_mutex0", "disp_sel", 0),
+	GATE_MM0(CLK_MM_APB_BUS, "mm_apb_bus", "disp_sel", 1),
+	GATE_MM0(CLK_MM_DISP_OVL0, "mm_disp_ovl0", "disp_sel", 2),
+	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "disp_sel", 3),
+	GATE_MM0(CLK_MM_DISP_OVL0_2L, "mm_disp_ovl0_2l", "disp_sel", 4),
+	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "disp_sel", 5),
+	GATE_MM0(CLK_MM_DISP_RSZ0, "mm_disp_rsz0", "disp_sel", 7),
+	GATE_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0", "disp_sel", 8),
+	GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0", "disp_sel", 9),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "disp_sel", 10),
+	GATE_MM0(CLK_MM_SMI_INFRA, "mm_smi_infra", "disp_sel", 11),
+	GATE_MM0(CLK_MM_DISP_DSC_WRAP0, "mm_disp_dsc_wrap0", "disp_sel", 12),
+	GATE_MM0(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0", "disp_sel", 13),
+	GATE_MM0(CLK_MM_DISP_POSTMASK0, "mm_disp_postmask0", "disp_sel", 14),
+	GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0", "disp_sel", 16),
+	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "disp_sel", 17),
+	GATE_MM0(CLK_MM_DSI0, "mm_dsi0", "disp_sel", 19),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG0, "mm_disp_fake_eng0", "disp_sel", 20),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG1, "mm_disp_fake_eng1", "disp_sel", 21),
+	GATE_MM0(CLK_MM_SMI_GALS, "mm_smi_gals", "disp_sel", 22),
+	GATE_MM0(CLK_MM_SMI_IOMMU, "mm_smi_iommu", "disp_sel", 24),
+
+	GATE_MM1(CLK_MM_DSI0_DSI_CK_DOMAIN, "mm_dsi0_dsi_domain", "dsi_occ_sel", 0),
+	GATE_MM1(CLK_MM_DISP_26M, "mm_disp_26m_ck", "disp_sel", 10),
+};
+
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
+
+static const struct platform_device_id clk_mt6789_mm_id_table[] = {
+	{ .name = "clk-mt6789-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, clk_mt6789_mm_id_table);
+
+static struct platform_driver clk_mt6789_mm_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
+	.driver = {
+		.name = "clk-mt6789-mm",
+	},
+	.id_table = clk_mt6789_mm_id_table,
+};
+module_platform_driver(clk_mt6789_mm_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 MultiMedia clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-topckgen.c b/drivers/clk/mediatek/clk-mt6789-topckgen.c
new file mode 100644
index 000000000000..a993f4064fd9
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-topckgen.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+static DEFINE_SPINLOCK(mt6789_clk_lock);
+
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll", 1, 4),
+	FACTOR(CLK_TOP_MAINPLL_D4_D2, "mainpll_d4_d2", "mainpll", 1, 8),
+	FACTOR(CLK_TOP_MAINPLL_D4_D4, "mainpll_d4_d4", "mainpll", 1, 16),
+	FACTOR(CLK_TOP_MAINPLL_D4_D8, "mainpll_d4_d8", "mainpll", 1, 32),
+	FACTOR(CLK_TOP_MAINPLL_D4_D16, "mainpll_d4_d16", "mainpll", 1, 64),
+	FACTOR(CLK_TOP_MAINPLL_D5, "mainpll_d5", "mainpll", 1, 5),
+	FACTOR(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2", "mainpll", 1, 10),
+	FACTOR(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4", "mainpll", 1, 20),
+	FACTOR(CLK_TOP_MAINPLL_D5_D8, "mainpll_d5_d8", "mainpll", 1, 40),
+	FACTOR(CLK_TOP_MAINPLL_D6, "mainpll_d6", "mainpll", 1, 6),
+	FACTOR(CLK_TOP_MAINPLL_D6_D2, "mainpll_d6_d2", "mainpll", 1, 12),
+	FACTOR(CLK_TOP_MAINPLL_D6_D4, "mainpll_d6_d4", "mainpll", 1, 24),
+	FACTOR(CLK_TOP_MAINPLL_D7, "mainpll_d7", "mainpll", 1, 7),
+	FACTOR(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2", "mainpll", 1, 14),
+	FACTOR(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4", "mainpll", 1, 28),
+	FACTOR(CLK_TOP_MAINPLL_D7_D8, "mainpll_d7_d8", "mainpll", 1, 56),
+	FACTOR(CLK_TOP_MAINPLL_D9, "mainpll_d9", "mainpll", 1, 9),
+	FACTOR(CLK_TOP_UNIVPLL_D4, "univpll_d4", "univpll", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D2, "univpll_d4_d2", "univpll", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D4, "univpll_d4_d4", "univpll", 1, 16),
+	FACTOR(CLK_TOP_UNIVPLL_D4_D8, "univpll_d4_d8", "univpll", 1, 32),
+	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll", 1, 10),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll", 1, 20),
+	FACTOR(CLK_TOP_UNIVPLL_D6, "univpll_d6", "univpll", 1, 6),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D2, "univpll_d6_d2", "univpll", 1, 12),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D4, "univpll_d6_d4", "univpll", 1, 24),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D8, "univpll_d6_d8", "univpll", 1, 48),
+	FACTOR(CLK_TOP_UNIVPLL_D6_D16, "univpll_d6_d16", "univpll", 1, 96),
+	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D2, "univpll_192m_d2", "univpll", 1, 26),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D4, "univpll_192m_d4", "univpll", 1, 52),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D8, "univpll_192m_d8", "univpll", 1, 104),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D16, "univpll_192m_d16", "univpll", 1, 208),
+	FACTOR(CLK_TOP_UNIVPLL_192M_D32, "univpll_192m_d32", "univpll", 1, 416),
+	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1", 1, 2),
+	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1, 4),
+	FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", "apll1", 1, 8),
+	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", "apll2", 1, 2),
+	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2", 1, 4),
+	FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", "apll2", 1, 8),
+	FACTOR(CLK_TOP_MMPLL_D4_D2, "mmpll_d4_d2", "mmpll", 1, 8),
+	FACTOR(CLK_TOP_MMPLL_D5_D2, "mmpll_d5_d2", "mmpll", 1, 12),
+	FACTOR(CLK_TOP_MMPLL_D6, "mmpll_d6", "mmpll", 1, 6),
+	FACTOR(CLK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", "mmpll", 1, 12),
+	FACTOR(CLK_TOP_MMPLL_D7, "mmpll_d7", "mmpll", 1, 7),
+	FACTOR(CLK_TOP_MMPLL_D9, "mmpll_d9", "mmpll", 1, 9),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
+	FACTOR(CLK_TOP_F26M_CK_D2, "f26m_d2", "clk26m", 1, 2),
+	FACTOR(CLK_TOP_OSC_D2, "osc_d2", "ulposc", 1, 2),
+	FACTOR(CLK_TOP_OSC_D4, "osc_d4", "ulposc", 1, 4),
+	FACTOR(CLK_TOP_OSC_D8, "osc_d8", "ulposc", 1, 8),
+	FACTOR(CLK_TOP_OSC_D16, "osc_d16", "ulposc", 1, 16),
+	FACTOR(CLK_TOP_OSC_D10, "osc_d10", "ulposc", 1, 10),
+	FACTOR(CLK_TOP_OSC_D20, "osc_d20", "ulposc", 1, 20),
+};
+
+static const char * const axi_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"mainpll_d7_d2",
+	"mainpll_d4_d2",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2",
+	"osc_d4"
+};
+
+static const char * const spm_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"mainpll_d7_d4",
+	"clkrtc"
+};
+
+static const char * const scp_parents[] = {
+	"clk26m",
+	"univpll_d4",
+	"npupll",
+	"mainpll_d6",
+	"univpll_d6",
+	"mainpll_d4_d2",
+	"mainpll_d4",
+	"mainpll_d7"
+};
+
+static const char * const bus_aximem_parents[] = {
+	"clk26m",
+	"mainpll_d7_d2",
+	"mainpll_d4_d2",
+	"mainpll_d5_d2",
+	"mainpll_d6"
+};
+
+static const char * const disp_parents[] = {
+	"clk26m",
+	"univpll_d6_d2",
+	"mainpll_d5_d2",
+	"mmpll_d6_d2",
+	"univpll_d5_d2",
+	"univpll_d4_d2",
+	"mmpll_d7",
+	"univpll_d6",
+	"mainpll_d4",
+	"mmpll_d5_d2"
+};
+
+static const char * const mdp_parents[] = {
+	"clk26m",
+	"mainpll_d5_d2",
+	"mmpll_d6_d2",
+	"mainpll_d4_d2",
+	"mmpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d5",
+	"mainpll_d4",
+	"tvdpll",
+	"univpll_d4",
+	"mmpll_d5_d2"
+};
+
+static const char * const img1_parents[] = {
+	"clk26m",
+	"univpll_d4",
+	"tvdpll",
+	"mainpll_d4",
+	"univpll_d5",
+	"mmpll_d6",
+	"univpll_d6",
+	"mainpll_d6",
+	"mmpll_d4_d2",
+	"mainpll_d4_d2",
+	"mmpll_d6_d2",
+	"mmpll_d5_d2"
+};
+
+static const char * const ipe_parents[] = {
+	"clk26m",
+	"mainpll_d4",
+	"mmpll_d6",
+	"univpll_d6",
+	"mainpll_d6",
+	"univpll_d4_d2",
+	"mainpll_d4_d2",
+	"mmpll_d6_d2",
+	"mmpll_d5_d2"
+};
+
+static const char * const cam_parents[] = {
+	"clk26m",
+	"mainpll_d4",
+	"mmpll_d6",
+	"univpll_d4",
+	"univpll_d5",
+	"univpll_d6",
+	"mmpll_d7",
+	"univpll_d4_d2",
+	"mainpll_d4_d2",
+	"npupll"
+};
+
+static const char * const mfg_ref_parents[] = {
+	"clk26m",
+	"mainpll_d6_d2",
+	"mainpll_d6",
+	"mainpll_d5_d2"
+};
+
+static const char * const mfg_pll_parents[] = {
+	"mfg_ref_sel",
+	"mfgpll"
+};
+
+static const char * const camtg_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d6_d8",
+	"univpll_192m_d4",
+	"univpll_d6_d16",
+	"f26m_d2",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+static const char * const uart_parents[] = {
+	"clk26m",
+	"univpll_d6_d8"
+};
+
+static const char * const spi_parents[] = {
+	"clk26m",
+	"mainpll_d5_d4",
+	"mainpll_d6_d4",
+	"msdcpll_d4",
+	"msdcpll_d2",
+	"mainpll_d6_d2",
+	"mainpll_d4_d4",
+	"univpll_d5_d4"
+};
+
+static const char * const msdc5hclk_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"mainpll_d6_d2"
+};
+
+static const char * const msdc50_0_parents[] = {
+	"clk26m",
+	"msdcpll",
+	"msdcpll_d2",
+	"univpll_d4_d4",
+	"mainpll_d6_d2",
+	"univpll_d4_d2"
+};
+
+static const char * const msdc30_1_parents[] = {
+	"clk26m",
+	"univpll_d6_d2",
+	"mainpll_d6_d2",
+	"mainpll_d7_d2",
+	"msdcpll_d2"
+};
+
+static const char * const audio_parents[] = {
+	"clk26m",
+	"mainpll_d5_d8",
+	"mainpll_d7_d8",
+	"mainpll_d4_d16"
+};
+
+static const char * const aud_intbus_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"mainpll_d7_d4"
+};
+
+static const char * const pwrap_ulposc_parents[] = {
+	"osc_d10",
+	"clk26m",
+	"osc_d4",
+	"osc_d8",
+	"osc_d16"
+};
+
+static const char * const atb_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"mainpll_d5_d2"
+};
+
+static const char * const sspm_parents[] = {
+	"clk26m",
+	"mainpll_d7_d2",
+	"mainpll_d6_d2",
+	"mainpll_d5_d2",
+	"mainpll_d9",
+	"mainpll_d4_d2"
+};
+
+static const char * const scam_parents[] = {
+	"clk26m",
+	"mainpll_d5_d4"
+};
+
+static const char * const disp_pwm_parents[] = {
+	"clk26m",
+	"univpll_d6_d4",
+	"osc_d2",
+	"osc_d4",
+	"osc_d16"
+};
+
+static const char * const usb_parents[] = {
+	"clk26m",
+	"univpll_d5_d4",
+	"univpll_d6_d4",
+	"univpll_d5_d2"
+};
+
+static const char * const i2c_parents[] = {
+	"clk26m",
+	"mainpll_d4_d8",
+	"univpll_d5_d4"
+};
+
+static const char * const seninf_parents[] = {
+	"clk26m",
+	"univpll_d4_d4",
+	"univpll_d6_d2",
+	"univpll_d4_d2",
+	"npupll",
+	"mmpll_d7",
+	"mmpll_d6",
+	"univpll_d5"
+};
+
+static const char * const dxcc_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"mainpll_d4_d4",
+	"mainpll_d4_d8"
+};
+
+static const char * const aud_engen1_parents[] = {
+	"clk26m",
+	"apll1_d2",
+	"apll1_d4",
+	"apll1_d8"
+};
+
+static const char * const aud_engen2_parents[] = {
+	"clk26m",
+	"apll2_d2",
+	"apll2_d4",
+	"apll2_d8"
+};
+
+static const char * const aes_ufsfde_parents[] = {
+	"clk26m",
+	"mainpll_d4",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d4_d4",
+	"univpll_d4_d2",
+	"univpll_d6"
+};
+
+static const char * const ufs_parents[] = {
+	"clk26m",
+	"mainpll_d4_d4",
+	"mainpll_d4_d8",
+	"univpll_d4_d4",
+	"mainpll_d6_d2",
+	"mainpll_d5_d2",
+	"msdcpll_d2"
+};
+
+static const char * const aud_1_parents[] = {
+	"clk26m",
+	"apll1"
+};
+
+static const char * const aud_2_parents[] = {
+	"clk26m",
+	"apll2"
+};
+
+static const char * const dpmaif_main_parents[] = {
+	"clk26m",
+	"univpll_d4_d4",
+	"mainpll_d6",
+	"mainpll_d4_d2",
+	"univpll_d4_d2"
+};
+
+static const char * const venc_parents[] = {
+	"clk26m",
+	"mmpll_d7",
+	"mainpll_d6",
+	"univpll_d4_d2",
+	"mainpll_d4_d2",
+	"univpll_d6",
+	"mmpll_d6",
+	"mainpll_d5_d2",
+	"mainpll_d6_d2",
+	"mmpll_d9",
+	"univpll_d4_d4",
+	"mainpll_d4",
+	"univpll_d4",
+	"univpll_d5",
+	"univpll_d5_d2",
+	"mainpll_d5"
+};
+
+static const char * const vdec_parents[] = {
+	"clk26m",
+	"univpll_192m_d2",
+	"univpll_d5_d4",
+	"mainpll_d5",
+	"mainpll_d5_d2",
+	"mmpll_d6_d2",
+	"univpll_d5_d2",
+	"mainpll_d4_d2",
+	"univpll_d4_d2",
+	"univpll_d7",
+	"mmpll_d7",
+	"mmpll_d6",
+	"univpll_d5",
+	"mainpll_d4",
+	"univpll_d4",
+	"univpll_d6"
+};
+
+static const char * const camtm_parents[] = {
+	"clk26m",
+	"univpll_d7",
+	"univpll_d6_d2",
+	"univpll_d4_d2"
+};
+
+static const char * const pwm_parents[] = {
+	"clk26m",
+	"univpll_d4_d8"
+};
+
+static const char * const audio_h_parents[] = {
+	"clk26m",
+	"univpll_d7",
+	"apll1",
+	"apll2"
+};
+
+static const char * const spmi_mst_parents[] = {
+	"clk26m",
+	"f26m_d2",
+	"osc_d8",
+	"osc_d10",
+	"osc_d16",
+	"osc_d20",
+	"clkrtc"
+};
+
+static const char * const dvfsrc_parents[] = {
+	"clk26m",
+	"osc_d10"
+};
+
+static const char * const aes_msdcfde_parents[] = {
+	"clk26m",
+	"mainpll_d4_d2",
+	"mainpll_d6",
+	"mainpll_d4_d4",
+	"univpll_d4_d2",
+	"univpll_d6"
+};
+
+static const char * const mcupm_parents[] = {
+	"clk26m",
+	"mainpll_d6_d4",
+	"mainpll_d6_d2"
+};
+
+static const char * const dsi_occ_parents[] = {
+	"clk26m",
+	"mainpll_d6_d2",
+	"univpll_d5_d2",
+	"univpll_d4_d2"
+};
+
+static const char * const apll_i2s_mck_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const struct mtk_mux top_muxes[] = {
+	/* CLK_CFG_0 */
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL, "axi_sel", axi_parents, 0x10, 0x14,
+			0x18, 0, 3, 0x04, 0),
+	MUX_CLR_SET_UPD(CLK_TOP_SPM_SEL, "spm_sel", spm_parents, 0x10, 0x14,
+			0x18, 8, 2, 0x04, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP_SEL, "scp_sel", scp_parents, 0x10, 0x14,
+			     0x18, 16, 3, 23, 0x04, 2),
+	MUX_CLR_SET_UPD(CLK_TOP_BUS_AXIMEM_SEL, "bus_aximem_sel", bus_aximem_parents, 0x10, 0x14,
+			0x18, 24, 3, 0x04, 3),
+	/* CLK_CFG_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_SEL, "disp_sel", disp_parents, 0x20, 0x24,
+			     0x28, 0, 4, 7, 0x04, 4),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MDP_SEL, "mdp_sel", mdp_parents, 0x20, 0x24,
+			     0x28, 8, 4, 15, 0x04, 5),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IMG1_SEL, "img1_sel", img1_parents, 0x20, 0x24,
+			     0x28, 16, 4, 23, 0x04, 6),
+	/* CLK_CFG_2 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IPE_SEL, "ipe_sel", ipe_parents, 0x30, 0x34,
+			     0x38, 0, 4, 7, 0x04, 8),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAM_SEL, "cam_sel", cam_parents, 0x30, 0x34,
+			     0x38, 16, 4, 23, 0x04, 10),
+	/* CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG_REF_SEL, "mfg_ref_sel", mfg_ref_parents, 0x50, 0x54,
+			     0x58, 16, 2, 23, 0x04, 18),
+	MUX_CLR_SET_UPD(CLK_TOP_MFG_PLL_SEL, "mfg_pll_sel", mfg_pll_parents, 0x50, 0x54,
+			0x58, 18, 1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG_SEL, "camtg_sel", camtg_parents, 0x50, 0x54,
+			     0x58, 24, 3, 31, 0x04, 19),
+	/* CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG2_SEL, "camtg2_sel", camtg_parents, 0x60, 0x64,
+			     0x68, 0, 3, 7, 0x04, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG3_SEL, "camtg3_sel", camtg_parents, 0x60, 0x64,
+			     0x68, 8, 3, 15, 0x04, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG4_SEL, "camtg4_sel", camtg_parents, 0x60, 0x64,
+			     0x68, 16, 3, 23, 0x04, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG5_SEL, "camtg5_sel", camtg_parents, 0x60, 0x64,
+			     0x68, 24, 3, 31, 0x04, 23),
+	/* CLK_CFG_6 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG6_SEL, "camtg6_sel", camtg_parents, 0x70, 0x74,
+			     0x78, 0, 3, 7, 0x04, 24),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL, "uart_sel", uart_parents, 0x70, 0x74,
+			     0x78, 8, 1, 15, 0x04, 25),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x70, 0x74,
+			     0x78, 16, 3, 23, 0x04, 26),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL, "msdc5hclk_sel", msdc5hclk_parents, 0x70,
+			     0x74, 0x78, 24, 2, 31, 0x04, 27),
+	/* CLK_CFG_7 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents, 0x80, 0x84,
+			     0x88, 0, 3, 7, 0x04, 28),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents, 0x80, 0x84,
+			     0x88, 8, 3, 15, 0x04, 29),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents, 0x80, 0x84,
+			     0x88, 24, 2, 31, 0x08, 0),
+	/* CLK_CFG_8 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents, 0x90,
+			     0x94, 0x98, 0, 2, 7, 0x08, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWRAP_ULPOSC_SEL, "pwrap_ulposc_sel", pwrap_ulposc_parents,
+			     0x90, 0x94, 0x98, 8, 3, 15, 0x08, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ATB_SEL, "atb_sel", atb_parents, 0x90, 0x94,
+			     0x98, 16, 2, 23, 0x08, 3),
+	MUX_CLR_SET_UPD(CLK_TOP_SSPM_SEL, "sspm_sel", sspm_parents, 0x90, 0x94,
+			0x98, 24, 3, 0x08, 4),
+	/* CLK_CFG_9 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCAM_SEL, "scam_sel", scam_parents, 0xA0, 0xA4,
+			     0xA8, 8, 1, 15, 0x08, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM_SEL, "disp_pwm_sel", disp_pwm_parents, 0xA0, 0xA4,
+			     0xA8, 16, 3, 23, 0x08, 7),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_SEL, "usb_sel", usb_parents, 0xA0, 0xA4,
+			     0xA8, 24, 2, 31, 0x08, 8),
+	/* CLK_CFG_10 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, "i2c_sel", i2c_parents, 0xB0, 0xB4,
+			     0xB8, 8, 2, 15, 0x08, 10),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF_SEL, "seninf_sel", seninf_parents, 0xB0, 0xB4,
+			     0xB8, 16, 3, 23, 0x08, 11),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF1_SEL, "seninf1_sel", seninf_parents, 0xB0, 0xB4,
+			     0xB8, 24, 3, 31, 0x08, 12),
+	/* CLK_CFG_11 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF2_SEL, "seninf2_sel", seninf_parents, 0xC0, 0xC4,
+			     0xC8, 0, 3, 7, 0x08, 13),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF3_SEL, "seninf3_sel", seninf_parents, 0xC0, 0xC4,
+			     0xC8, 8, 3, 15, 0x08, 14),
+	MUX_CLR_SET_UPD(CLK_TOP_DXCC_SEL, "dxcc_sel", dxcc_parents, 0xC0, 0xC4,
+			0xC8, 24, 2, 0x08, 16),
+	/* CLK_CFG_12 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN1_SEL, "aud_engen1_sel", aud_engen1_parents, 0xD0,
+			     0xD4, 0xD8, 0, 2, 7, 0x08, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN2_SEL, "aud_engen2_sel", aud_engen2_parents, 0xD0,
+			     0xD4, 0xD8, 8, 2, 15, 0x08, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_UFSFDE_SEL, "aes_ufsfde_sel", aes_ufsfde_parents, 0xD0,
+			     0xD4, 0xD8, 16, 3, 23, 0x08, 19),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UFS_SEL, "ufs_sel", ufs_parents, 0xD0, 0xD4,
+			     0xD8, 24, 3, 31, 0x08, 20),
+	/* CLK_CFG_13 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_1_SEL, "aud_1_sel", aud_1_parents, 0xE0, 0xE4,
+			     0xE8, 0, 1, 7, 0x08, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_2_SEL, "aud_2_sel", aud_2_parents, 0xE0, 0xE4,
+			     0xE8, 8, 1, 15, 0x08, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPMAIF_MAIN_SEL, "dpmaif_main_sel", dpmaif_main_parents,
+			     0xE0, 0xE4, 0xE8, 24, 3, 31, 0x08, 24),
+	/* CLK_CFG_14 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VENC_SEL, "venc_sel", venc_parents, 0xF0, 0xF4,
+			     0xF8, 0, 4, 7, 0x08, 25),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDEC_SEL, "vdec_sel", vdec_parents, 0xF0, 0xF4,
+			     0xF8, 8, 4, 15, 0x08, 26),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTM_SEL, "camtm_sel", camtm_parents, 0xF0, 0xF4,
+			     0xF8, 16, 2, 23, 0x08, 27),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0xF0, 0xF4,
+			     0xF8, 24, 1, 31, 0x08, 28),
+	/* CLK_CFG_15 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_H_SEL, "audio_h_sel", audio_h_parents, 0x0100, 0x0104,
+			     0x0108, 0, 2, 7, 0x08, 29),
+	MUX_CLR_SET_UPD(CLK_TOP_SPMI_MST_SEL, "spmi_mst_sel", spmi_mst_parents, 0x0100, 0x0104,
+			0x0108, 8, 3, 0x08, 30),
+	MUX_CLR_SET_UPD(CLK_TOP_DVFSRC_SEL, "dvfsrc_sel", dvfsrc_parents, 0x0100, 0x0104,
+			0x0108, 16, 1, 0x0c, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_MSDCFDE_SEL, "aes_msdcfde_sel", aes_msdcfde_parents,
+			     0x0100, 0x0104, 0x0108, 24, 3, 31, 0x0c, 1),
+	/* CLK_CFG_16 */
+	MUX_CLR_SET_UPD(CLK_TOP_MCUPM_SEL, "mcupm_sel", mcupm_parents, 0x0110, 0x0114,
+			0x0118, 0, 2, 0x0c, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSI_OCC_SEL, "dsi_occ_sel", dsi_occ_parents, 0x0110, 0x0114,
+			     0x0118, 16, 2, 23, 0x0c, 4),
+};
+
+static const struct mtk_composite top_aud_divs[] = {
+	/* CLK_AUDDIV_0 */
+	MUX(CLK_TOP_APLL_I2S0_MCK_SEL, "apll_i2s0_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 16, 1),
+	MUX(CLK_TOP_APLL_I2S1_MCK_SEL, "apll_i2s1_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 17, 1),
+	MUX(CLK_TOP_APLL_I2S2_MCK_SEL, "apll_i2s2_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 18, 1),
+	MUX(CLK_TOP_APLL_I2S3_MCK_SEL, "apll_i2s3_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 19, 1),
+	MUX(CLK_TOP_APLL_I2S4_MCK_SEL, "apll_i2s4_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 20, 1),
+	MUX(CLK_TOP_APLL_I2S5_MCK_SEL, "apll_i2s5_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 21, 1),
+	MUX(CLK_TOP_APLL_I2S6_MCK_SEL, "apll_i2s6_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 22, 1),
+	MUX(CLK_TOP_APLL_I2S7_MCK_SEL, "apll_i2s7_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 23, 1),
+	MUX(CLK_TOP_APLL_I2S8_MCK_SEL, "apll_i2s8_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 24, 1),
+	MUX(CLK_TOP_APLL_I2S9_MCK_SEL, "apll_i2s9_mck_sel",
+	    apll_i2s_mck_parents, 0x0320, 25, 1),
+	/* CLK_AUDDIV_2 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV0, "apll12_div0",
+		 "apll_i2s0_mck_sel", 0x0320, 0, 0x0328, 8, 0),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV1, "apll12_div1",
+		 "apll_i2s1_mck_sel", 0x0320, 1, 0x0328, 8, 8),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV2, "apll12_div2",
+		 "apll_i2s2_mck_sel", 0x0320, 2, 0x0328, 8, 16),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV3, "apll12_div3",
+		 "apll_i2s3_mck_sel", 0x0320, 3, 0x0328, 8, 24),
+	/* CLK_AUDDIV_3 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV4, "apll12_div4",
+		 "apll_i2s4_mck_sel", 0x0320, 4, 0x0334, 8, 0),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIVB, "apll12_divb",
+		 "apll12_div4", 0x0320, 5, 0x0334, 8, 8),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV5, "apll12_div5",
+		 "apll_i2s5_mck_sel", 0x0320, 6, 0x0334, 8, 16),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV6, "apll12_div6",
+		 "apll_i2s6_mck_sel", 0x0320, 7, 0x0334, 8, 24),
+	/* CLK_AUDDIV_4 */
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV7, "apll12_div7",
+		 "apll_i2s7_mck_sel", 0x0320, 8, 0x0338, 8, 0),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV8, "apll12_div8",
+		 "apll_i2s8_mck_sel", 0x0320, 9, 0x0338, 8, 8),
+	DIV_GATE(CLK_TOP_APLL12_CK_DIV9, "apll12_div9",
+		 "apll_i2s9_mck_sel", 0x0320, 10, 0x0338, 8, 16),
+};
+
+static const struct mtk_clk_desc topck_desc = {
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+	.composite_clks = top_aud_divs,
+	.num_composite_clks = ARRAY_SIZE(top_aud_divs),
+	.clk_lock = &mt6789_clk_lock,
+};
+
+static const struct of_device_id of_match_clk_mt6789_topckgen[] = {
+	{ .compatible = "mediatek,mt6789-topckgen", .data = &topck_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_topckgen);
+
+static struct platform_driver clk_mt6789_topckgen_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-topckgen",
+		.of_match_table = of_match_clk_mt6789_topckgen,
+	},
+};
+module_platform_driver(clk_mt6789_topckgen_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 top clock generators driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6789-vdec.c b/drivers/clk/mediatek/clk-mt6789-vdec.c
new file mode 100644
index 000000000000..eb2c690d4040
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-vdec.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs vde20_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vde21_cg_regs = {
+	.set_ofs = 0x190,
+	.clr_ofs = 0x190,
+	.sta_ofs = 0x190,
+};
+
+static const struct mtk_gate_regs vde22_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs vde23_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xC,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_VDE20(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde20_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE21(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde21_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_VDE22(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde22_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VDE23(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vde23_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+static const struct mtk_gate vde2_clks[] = {
+	/* VDE20 */
+	GATE_VDE20(CLK_VDE2_VDEC_CKEN, "vde2_vdec_cken", "vdec_sel", 0),
+	GATE_VDE20(CLK_VDE2_VDEC_ACTIVE, "vde2_vdec_active", "vdec_sel", 4),
+	GATE_VDE20(CLK_VDE2_VDEC_CKEN_ENG, "vde2_vdec_cken_eng", "vdec_sel", 8),
+	/* VDE21 */
+	GATE_VDE21(CLK_VDE2_MINI_MDP_CKEN_CFG_RG, "vde2_mini_mdp", "vdec_sel", 0),
+	/* VDE22 */
+	GATE_VDE22(CLK_VDE2_LAT_CKEN, "vde2_lat_cken", "vdec_sel", 0),
+	GATE_VDE22(CLK_VDE2_LAT_ACTIVE, "vde2_lat_active", "vdec_sel", 4),
+	GATE_VDE22(CLK_VDE2_LAT_CKEN_ENG, "vde2_lat_cken_eng", "vdec_sel", 8),
+	/* VDE23 */
+	GATE_VDE23(CLK_VDE2_LARB1_CKEN, "vde2_larb1_cken", "vdec_sel", 0),
+};
+
+static const struct mtk_clk_desc vde2_desc = {
+	.clks = vde2_clks,
+	.num_clks = ARRAY_SIZE(vde2_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_vdec[] = {
+	{ .compatible = "mediatek,mt6789-vdecsys", .data = &vde2_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_vdec);
+
+static struct platform_driver clk_mt6789_vdec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-vdec",
+		.of_match_table = of_match_clk_mt6789_vdec,
+	},
+};
+module_platform_driver(clk_mt6789_vdec_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 Video Decoders clocks driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/clk/mediatek/clk-mt6789-venc.c b/drivers/clk/mediatek/clk-mt6789-venc.c
new file mode 100644
index 000000000000..8a152b75c501
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6789-venc.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt6789-clk.h>
+
+static const struct mtk_gate_regs ven1_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_VEN1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+static const struct mtk_gate ven1_clks[] = {
+	GATE_VEN1(CLK_VEN1_CKE0_LARB, "ven1_cke0_larb", "venc_sel", 0),
+	GATE_VEN1(CLK_VEN1_CKE1_VENC, "ven1_cke1_venc", "venc_sel", 4),
+	GATE_VEN1(CLK_VEN1_CKE2_JPGENC, "ven1_cke2_jpgenc", "venc_sel", 8),
+	GATE_VEN1(CLK_VEN1_CKE5_GALS, "ven1_cke5_gals", "venc_sel", 28),
+};
+
+static const struct mtk_clk_desc ven1_desc = {
+	.clks = ven1_clks,
+	.num_clks = ARRAY_SIZE(ven1_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6789_venc[] = {
+	{ .compatible = "mediatek,mt6789-vencsys", .data = &ven1_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6789_venc);
+
+static struct platform_driver clk_mt6789_venc_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6789-venc",
+		.of_match_table = of_match_clk_mt6789_venc,
+	},
+};
+module_platform_driver(clk_mt6789_venc_drv);
+
+MODULE_DESCRIPTION("MediaTek MT6789 Video Encoders clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.50.0


