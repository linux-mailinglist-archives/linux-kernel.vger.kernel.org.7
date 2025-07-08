Return-Path: <linux-kernel+bounces-720881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E28BAFC1A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6E87ADFC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FE820101D;
	Tue,  8 Jul 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="iAU8ed0W"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F41C8610;
	Tue,  8 Jul 2025 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751948531; cv=none; b=sd0LOwNAey7VOYg9q4K6jKuntwZn+89S/C5Eu5XJzgyWdh3TU9r7gk0UANhZLGhjckF6x1D1dgjzRtZZVdacQsTmX2sdl4KrCawItuUGb8mM5NCh8YqXRH13op3NeJVekoPVc+Vwt1IO9cl+WDe4bZx5OooLsCcx3vE8vF4L0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751948531; c=relaxed/simple;
	bh=lK+/YCpPKtoiftQ5RjFEFQRAnYJ5Nka4bSWUC+ntovA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ff+EG+61ssK2292lOCtoKDfecO26ymq8xZWoZ3yag7Jj3pR1b2bwgemDURQEtQo/hy+WSA8wDbn+RjcHd1YscA9l7llQEBn45DD9P8TNvfYuOJVimhT0O5AFn/nABsMmdm5upzqMmbXOEtOAx/pEXelfTqhCRQvaTwQ4QUqajqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=iAU8ed0W; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xgOAbYrU3I65DP3OBtlB0nUbAXTzxo+RZlakjhJvTL4=; b=iAU8ed0WIG7iFMLG4xU0oWUvyJ
	hmFDqbDFyQUgLDXCL4GOHS11eVF1kP3wSS60gTBo4FvhfFxJJdQuJdT39GkDJ0Nhph3Fr+ojumGaG
	C6W0khng+aU/ZZhJQsVxuEgW5jgH02EFOLoF58qql9uH/Yki4u28p/mc4Kq+SRK0XbNove0YeDnD2
	zT4ySjk72zQgmUOs8kqASWxd5ID+VZQYW+KS6QHpOHbQvw9wnSEpFR7EkgkEclyydgaA0h+0PjOTK
	nfRIdFa8Q4M4QEctwYTHHocd/UKtiNNhz1OT8Xk5yqKcWPtIcIIGtYyX309Ab49bbBEEapzEKhhT9
	tTJ1tEug==;
Received: from [89.212.21.243] (port=45388 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uYzqK-00GO9H-1N;
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
Subject: [PATCH v3 2/4] arm64: dts: imx93-phyboard-segin: Add PEB-EVAL-01 overlay
Date: Tue,  8 Jul 2025 06:22:04 +0200
Message-Id: <20250708042206.329208-3-primoz.fiser@norik.com>
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

Add overlay to support PEB-EVAL-01 adapter on phyBOARD-Segin-i.MX93.
This is a PHYTEC evaluation module with three LEDs and two input buttons
that users can attach to the board expansion connector X16.

Note that, due to compatibility with existing PHYTEC platforms using the
phyBOARD-Segin carrier board such as i.MX6UL and STM32MP1, we face some
hardware limitations and can thus only support one user LED (D2) and one
button (S2) on the i.MX93 variant of the phyBOARD-Segin.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- fix license to match base dts
- add Reviewed-by tag

 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx93-phyboard-segin-peb-eval-01.dtso     | 52 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-eval-01.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 08a1de299538..011b2d58e4f7 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -325,7 +325,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 
+imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
 imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-rpmsg.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba91xxca.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-eval-01.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-eval-01.dtso
new file mode 100644
index 000000000000..a20898734741
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin-peb-eval-01.dtso
@@ -0,0 +1,52 @@
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
+#include <dt-bindings/input/input.h>
+#include "imx93-pinfunc.h"
+
+&{/} {
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		button-s2 {
+			label = "sleep";
+			linux,code = <KEY_SLEEP>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	user-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_user_leds>;
+
+		user-led2 {
+			gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10	0x31e
+		>;
+	};
+
+	pinctrl_user_leds: userledsgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_RD3__GPIO4_IO13		0x31e
+		>;
+	};
+};
-- 
2.34.1


