Return-Path: <linux-kernel+bounces-871392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38255C0D1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 097424ED3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CA30146A;
	Mon, 27 Oct 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aAzEvc6t"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A962FD1B5;
	Mon, 27 Oct 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563635; cv=none; b=I3KWBC441UvhP+F7d62qlQzrWXJM6hFfORwyEb8CKmEGkB6B/XmLlpuC9FpZEZJykuQz9L+pQBuSJSMtH6oYVHyx2UUXGFBWpkigFMU/FaLmR8GVeTGeFCMaw0MCOG+97/NVR4S7tDEhIonahujrc1oqecLwEWsTO8GYxtQEg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563635; c=relaxed/simple;
	bh=r0mhGlPr+9zzYVG1jnK8tXKevnB7GtErZuWoP0D+6Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy6Q7RTQZ3+Q69rJ9J57D8Wa4V1XiptkplKngId4Xdurg3rJV2OpsIrKXTMW/b7ayaGRUOc1bq+w7zl6nNLACvtppfPGa601nNRNksKN041DXLCtu5b/mPsAkPKuv2DeYLZ5XMe34tgeevzkkfkmXKAmUI5mtW/1IhTfBMiK8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aAzEvc6t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563631;
	bh=r0mhGlPr+9zzYVG1jnK8tXKevnB7GtErZuWoP0D+6Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAzEvc6tZjRkDBEyI2vr2gGSF3Do5eUqzrNc16W3TlMSSGasklbBW0rpNV0or6YJV
	 cU/s0dpbqdQWfyFU2JYFZ1TZ7Ad7oHLZlihbv/I4ZmqTvkFF/eSCKRb6wi8CTCcuIg
	 wY6jaJArnV984zl1mR3C22LP+I+AevfxxiH0j6wSXCnzPuWZm+DEbcBY7qDzMh46J5
	 xfXojfULO5iZmct/wC83a49jVnXikz5M2c7WEEFiGriwFqxOwV7s6pOiR/xV1+Vy1S
	 B3dtSbQMLKICGvboZrWrOkJ4XX+/B1Brn3CJNhhR3VJx2AbWk+eIrz9Ct6Z4neWZEo
	 ewhHXChfQC5fg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F78D17E1423;
	Mon, 27 Oct 2025 12:13:51 +0100 (CET)
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
Subject: [PATCH v2 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC Clock Controller
Date: Mon, 27 Oct 2025 12:13:43 +0100
Message-ID: <20251027111343.21723-8-angelogioacchino.delregno@collabora.com>
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

Add support for the SCK_TOP Clock Controller IP found in the
MediaTek MT6685 PM/Clock IC as a SPMI Sub-Device.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig      |  7 ++++
 drivers/clk/mediatek/Makefile     |  2 +
 drivers/clk/mediatek/clk-mt6685.c | 70 +++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6685.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 0e41990d271f..4a67b58c3e55 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -132,6 +132,13 @@ config COMMON_CLK_MT2712_VENCSYS
 	help
 	  This driver supports MediaTek MT2712 vencsys clocks.
 
+config COMMON_CLK_MT6685
+	tristate "Clock driver for MediaTek MT6685 Clock IC"
+	depends on ARCH_MEDIATEK
+	select COMMON_CLK_MEDIATEK_SPMI
+	help
+	  This driver supports clocks provided by the MT6685 Clock IC.
+
 config COMMON_CLK_MT6735
 	tristate "Main clock drivers for MediaTek MT6735"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d2b51e88e51e..b47527002b02 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -5,6 +5,8 @@ obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mediatek.o
 
 obj-$(CONFIG_COMMON_CLK_MEDIATEK_FHCTL) += clk-fhctl.o clk-pllfh.o
 
+obj-$(CONFIG_COMMON_CLK_MT6685) += clk-mt6685.o
+
 obj-$(CONFIG_COMMON_CLK_MT6735) += clk-mt6735-apmixedsys.o clk-mt6735-infracfg.o clk-mt6735-pericfg.o clk-mt6735-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT6735_IMGSYS) += clk-mt6735-imgsys.o
 obj-$(CONFIG_COMMON_CLK_MT6735_MFGCFG) += clk-mt6735-mfgcfg.o
diff --git a/drivers/clk/mediatek/clk-mt6685.c b/drivers/clk/mediatek/clk-mt6685.c
new file mode 100644
index 000000000000..1d524aef61a5
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6685.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+#include <dt-bindings/clock/mediatek,mt6685-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-mtk-spmi.h"
+#include "reset.h"
+
+static const struct mtk_gate_regs spmi_mt6685_sck_top_cg_regs = {
+	.set_ofs = 0x1,
+	.clr_ofs = 0x2,
+	.sta_ofs = 0x0
+};
+
+#define GATE_SCKTOP(_id, _name, _parent, _shift)	\
+{							\
+	.id = _id,					\
+	.name = _name,					\
+	.parent_name = _parent,				\
+	.regs = &spmi_mt6685_sck_top_cg_regs,		\
+	.shift = _shift,				\
+	.flags = CLK_IGNORE_UNUSED,			\
+	.ops = &mtk_clk_gate_ops_setclr,		\
+}
+
+static const struct mtk_gate sck_top_clks[] = {
+	GATE_SCKTOP(CLK_RTC_SEC_MCLK, "rtc_sec_mclk", "rtc_sec_32k", 0),
+	GATE_SCKTOP(CLK_RTC_EOSC32, "rtc_eosc32", "clk26m", 2),
+	GATE_SCKTOP(CLK_RTC_SEC_32K, "rtc_sec_32k", "clk26m", 3),
+	GATE_SCKTOP(CLK_RTC_MCLK, "rtc_mclk", "rtc_32k", 4),
+	GATE_SCKTOP(CLK_RTC_32K, "rtc_32k", "clk26m", 5),
+};
+
+static const struct mtk_clk_desc mt6685_sck_top_mcd = {
+	.clks = sck_top_clks,
+	.num_clks = ARRAY_SIZE(sck_top_clks),
+};
+
+static const struct mtk_spmi_clk_desc mt6685_sck_top_mscd = {
+	.desc = &mt6685_sck_top_mcd,
+	.max_register = 0x10,
+};
+
+static const struct of_device_id of_match_clk_mt6685[] = {
+	{ .compatible = "mediatek,mt6685-sck-top", .data = &mt6685_sck_top_mscd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt6685);
+
+static struct platform_driver clk_mt6685_spmi_drv = {
+	.probe = mtk_spmi_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-spmi-mt6685",
+		.of_match_table = of_match_clk_mt6685,
+	},
+};
+module_platform_driver(clk_mt6685_spmi_drv);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("MediaTek MT6685 SPMI Clock IC clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.51.1


