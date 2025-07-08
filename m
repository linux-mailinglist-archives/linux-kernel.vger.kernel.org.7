Return-Path: <linux-kernel+bounces-720884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F2AFC1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FE91AA7821
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FDD218585;
	Tue,  8 Jul 2025 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="N3dsEHbk"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F71216E26;
	Tue,  8 Jul 2025 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751948538; cv=none; b=n3/4aSa3Fqm8tsu++218Y5983PCjvPJrr6hjECQ69azzdaeyNowwn4EAwgWLkpDA4MlSLEJxubr4gdPtgjDn59N9Uc3Ch+iA1EDZF10ajpo29C5wPM882fguhxpFqtlYJ9aGQGukS54IFGGgRbdQCC12rxKsCNJZvQp78kSFrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751948538; c=relaxed/simple;
	bh=ulZevYqiH1chwMsT0/3qmn16lJZY3s37WSKTXbOGwDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C36geIPGf3nxpHXzQ6E19TsWM1rb2sFBKoepTDqcN1SFnYoR217+sGlpuU34e3p2vQQzNq9cX/0L9Pvm+68OKWso3iSR5FewojALaF5Z44m8H2OqHOar3fkhW1rlisHYzmlhAnTfz3xUOZbL/gphvkIe5hTE1t+3+rt7iejieiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=N3dsEHbk; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TethFMbUHgsgVKgaCK7+OTC1UjdHwcUm63F7FiACyH4=; b=N3dsEHbkPG/fFzLgOrnZTEzAOh
	NoGliEKeMzxwiVXoTM5i7umz4HxknR/N/gkoQ+MGpGHb43lg2KYQ4ANl+W5faFVkYOy5c8aEiB8dr
	sf5yh72YfpPNTJRlpgelh6U9gND4rNKDTIqhcXe1wR34J4aXcOPIF99AS5gGMSx7IjGdwJJKKEiK7
	oS5IWAWH2p9394mB2nDyeyfh05WJOwQsNbUNoHPPtodoizZi8IhCjrAmg2KoZUToeDVJdqWzPWLSi
	1BWcpAlcp83/y6iAu9RKvuhRFppA31Nx2DhAicqwjByO/Do4iibfOMp8wStOu0dncH2MkttRdXqFy
	L2OcG/7w==;
Received: from [89.212.21.243] (port=45388 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uYzqK-00GO9H-1z;
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
Subject: [PATCH v3 4/4] arm64: dts: imx93-phyboard-nash: Add PEB-WLBT-07 overlay
Date: Tue,  8 Jul 2025 06:22:06 +0200
Message-Id: <20250708042206.329208-5-primoz.fiser@norik.com>
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

Add overlay to support PHYTEC PEB-WLBT-07 WiFi/Bluetooth evaluation
adapter on phyBOARD-Nash-i.MX93 board. Adapter uses the u-blox MAYA-W2
module (IW612 chipset) which is capable of Wi-Fi 6 and Bluetooth 5.4 LE.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- fix license to match base dts
- add Reviewed-by tag

 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx93-phyboard-nash-peb-wlbt-07.dtso      | 88 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-peb-wlbt-07.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 3166684ab558..699c3b1d80b2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -325,9 +325,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 
+imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
 imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
 imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
 imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-rpmsg.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-peb-wlbt-07.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-peb-wlbt-07.dtso
new file mode 100644
index 000000000000..7381b87444e8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-peb-wlbt-07.dtso
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
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
+		reset-gpios = <&gpio4 29 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+/*
+ * NOTE: When uSDHC3 port is multiplexed on GPIO_IO[27:22] pads, it only
+ * supports 50 MHz mode, due to introduction of potential variations in
+ * trace impedance, drive strength, and timing skew. Refer to i.MX 93
+ * Application Processors Data Sheet, Rev. 3, page 60 for more details.
+ */
+&usdhc3 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_wlbt>;
+	pinctrl-1 = <&pinctrl_usdhc3_sleep>, <&pinctrl_wlbt>;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	wakeup-source;
+	status = "okay";
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
+			MX93_PAD_SD3_CMD__USDHC3_CMD 		0x4000178e
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0	0x4000138e
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1	0x4000138e
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2	0x4000138e
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3	0x4000138e
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__USDHC3_CLK		0x31e
+			MX93_PAD_SD3_CMD__USDHC3_CMD 		0x31e
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0	0x31e
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1	0x31e
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2	0x31e
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3	0x31e
+		>;
+	};
+
+	pinctrl_wlbt: wlbtgrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27		0x31e	/* WAKE_DEV */
+			MX93_PAD_CCM_CLKO3__GPIO4_IO28		0x31e	/* WAKE_HOST */
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29		0x31e	/* PDn */
+		>;
+	};
+};
-- 
2.34.1


