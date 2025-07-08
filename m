Return-Path: <linux-kernel+bounces-720883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10FAFC1AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA72425A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CF72153D2;
	Tue,  8 Jul 2025 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Y2FpZm9V"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CAE1D9A5F;
	Tue,  8 Jul 2025 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751948532; cv=none; b=urrAiz8WXD8+L3gpX+F8cW/vES7t6FQ5oSl8STHSonT7g3+BUAmBXeI73/nf0E5VW8q8lCnDhORbY9ssIqAAP2eN6nH+jwbszYbf6mCT/8Q5reBNiF60lTUGDgmGo8MImzrQ+R1hkAVVPo3h5AiEaG7cAlxyZajw8pKb9MIfGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751948532; c=relaxed/simple;
	bh=j1pQxf0/E7CAqOTMC2NKLnR09+Xge+5C7chGPlEdsKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4NdWLSFuJWY/MXJTTMDDv3j4M939bvrasGSYMsmrc+r41t3XN1eMX9kZqo1nyBgZaDjl1UuU53YpeZYh7YpkxTMUMYSPwi0yefypEnNT7rv04hYtGc6I/UpCYOdVeY+6vukrF2zxTF1AdRuvWyahQ6p5YeYxgeGG1pzukuXHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Y2FpZm9V; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4ZbUL8/OuT41cZx+qcOESroeHGmMgdpATuOoRlj+Mco=; b=Y2FpZm9V5raaulaQq/5bhXIL/G
	NOy2570VHOrWzvsZzxrnlB0XTQma4FbmcrXtk5FPkpmsgcQGGCYT2F7Plrse83UXUgj6hCHyGpe7d
	vcI8/EvcBPMvxNysyOvAQeIqMHuZaHb9PTX6+kYis2UWTV2xGH15npOR54TweUWLk9k5rMjYqVqWS
	U+povErgGPCESlaBkyw1RBmi6cZ89JwIAQO3LD7P3jWztotmE4vYAdpQgkjLOw3/fFggtbFypq1Tw
	0brbEzvhzZWlVD9B1gjTSHUF0OWIfF2lN3GdpidLvsMeN5O/5XYPtuXaDKWN7g9Mz/jv39CYsQiGh
	t/ITPaaw==;
Received: from [89.212.21.243] (port=45388 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uYzqK-00GO9H-1g;
	Tue, 08 Jul 2025 06:22:07 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v3 3/4] arm64: dts: imx93-phyboard-segin: Add PEB-WLBT-05 overlay
Date: Tue,  8 Jul 2025 06:22:05 +0200
Message-Id: <20250708042206.329208-4-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708042206.329208-1-primoz.fiser@norik.com>
References: <20250708042206.329208-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add support for PEB-WLBT-05 WLAN/BT adapter on phyBOARD-Segin-i.MX93.
The PEB-WLBT-05 is equipped with a Sterling-LWB radio module, which is
capable of Wi-Fi 802.11 b/g/n and Bluetooth 4.2.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- fix license to match base dts
- add Reviewed-by tag

 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx93-phyboard-segin-peb-wlbt-05.dtso     | 93 +++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-wlbt-05.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 011b2d58e4f7..3166684ab558 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -326,8 +326,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 
 imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
+imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
 imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-rpmsg.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba91xxca.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-wlbt-05.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-wlbt-05.dtso
new file mode 100644
index 000000000000..a7285f009566
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-wlbt-05.dtso
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Andrej Picej <andrej.picej@norik.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx93-pinfunc.h"
+
+&{/} {
+	usdhc3_pwrseq: usdhc3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <60>;
+		reset-gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+	};
+};
+
+&usdhc3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_wlbt>;
+	pinctrl-1 = <&pinctrl_usdhc3_sleep>, <&pinctrl_wlbt>;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+
+	brmcf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+	};
+};
+
+&iomuxc {
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__USDHC3_CLK		0x179e
+			MX93_PAD_GPIO_IO23__USDHC3_CMD		0x4000139e
+			MX93_PAD_GPIO_IO24__USDHC3_DATA0	0x4000139e
+			MX93_PAD_GPIO_IO25__USDHC3_DATA1	0x4000139e
+			MX93_PAD_GPIO_IO26__USDHC3_DATA2	0x4000139e
+			MX93_PAD_GPIO_IO27__USDHC3_DATA3	0x4000139e
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__USDHC3_CLK		0x31e
+			MX93_PAD_GPIO_IO23__USDHC3_CMD		0x31e
+			MX93_PAD_GPIO_IO24__USDHC3_DATA0	0x31e
+			MX93_PAD_GPIO_IO25__USDHC3_DATA1	0x31e
+			MX93_PAD_GPIO_IO26__USDHC3_DATA2	0x31e
+			MX93_PAD_GPIO_IO27__USDHC3_DATA3	0x31e
+		>;
+	};
+
+	pinctrl_wlbt: wlbtgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_RD3__GPIO4_IO13		0x31e	/* BT ENABLE */
+			MX93_PAD_ENET1_TXC__GPIO4_IO07		0x31e	/* WLAN ENABLE */
+			MX93_PAD_I2C1_SCL__GPIO1_IO00		0x31e	/* HOST WAKEUP */
+		>;
+	};
+};
-- 
2.34.1


