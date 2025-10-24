Return-Path: <linux-kernel+bounces-868394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187BC051F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AC94229F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF73730DD20;
	Fri, 24 Oct 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pICVBLD7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2D30C35E;
	Fri, 24 Oct 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294799; cv=none; b=NT2Yia86fuhwDgmeyqvbNT0yU1iAaUUYNp4H4eEvxgnNjGBAxa9iKXxEUMEXCI/tcvwQ3eBXAnjeZL9RPFUuUo1k++h/vPaCnMJ+r5XYf+9H0WyVt1Mkbq9ewEYxUuP4KAkScWYpZoyJNtqUSsI1sW3DnWY6MLeWqkbmaF2cLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294799; c=relaxed/simple;
	bh=EvJjtJYPMkY+wg28Z8s4t5T9jEANTPME3U612w+D8i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1zv+8MGk8qFLlK7LTPr31A8Nr/bvsSfZVsNaXNXhLUcIatWhAk922pO9+aaH7A3zj9nh29RvW+kV8VfXfan0aqZseS51s2g38zUBSpGfSUOlgymif2ZvNfvVa2oRZ2w7MqLXC0kwdk6tmmXa0fX49dLx2piFI9MhE1/g+tgpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pICVBLD7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294795;
	bh=EvJjtJYPMkY+wg28Z8s4t5T9jEANTPME3U612w+D8i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pICVBLD7r6cRxXEkGY321+hLIeTUWHf3suAoMLlwKdsaqwOwDoAvWhHGBjG6QZySA
	 ysxtNqO5uTzzAVWs1GGCVzmZsZGyuWxvjMp6prSBUM3OuwkRPrYqdjnd76f6Ap6krJ
	 zRmJsvFiCVLJdnAOlgUq4Z0GZc9B/zrBqbuzKGKVZ5A5mxZjyY8v6JbrAm+boOKoyn
	 85+cw4XUP53Ia0pDR74PsrOdyPCJwzi6qsOoQca/00FqNmiUoBaPH62VA5BzTOyqRh
	 QavABbfqiM82F2790/30REFuemcVR+Y2WNinaFcpeM1KEd5YPLvi1By+veJsrOArEy
	 FyvhGslzptwyA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CAFB317E141F;
	Fri, 24 Oct 2025 10:33:14 +0200 (CEST)
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
Subject: [PATCH v1 7/7] clk: mediatek: Add support for MT6685 PM/Clock IC Clock Controller
Date: Fri, 24 Oct 2025 10:33:01 +0200
Message-ID: <20251024083301.25845-8-angelogioacchino.delregno@collabora.com>
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
index 3452dcbc9e45..eb1764418b1e 100644
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
index 1471d8affa44..d68837f1aa06 100644
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


