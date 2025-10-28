Return-Path: <linux-kernel+bounces-873711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D25C14816
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF298625CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D631BC84;
	Tue, 28 Oct 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="aNtHXz7Q"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553331A55F;
	Tue, 28 Oct 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652706; cv=none; b=FDn3gSq22zTFrGpc7dPKF7V3n9yFAKNAp9cZ9JPAlExQ4pEySZbGTMMb0uIJSe72gcDT1HgILWocoiaRMrMMLC/XQmMyk7N72gn0vLvlDgMxDorzhD635q4v/uGyZVtKvus7W6xevTFYxlVI9liPm9QE7nJio5gUOURIkR8Ufn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652706; c=relaxed/simple;
	bh=GFhN+QKVn/2rZZls6ckpoX+ccSnRPCMoDCx19pccf8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKtvytxLWYq5Fh7729jXvJS178YPotMtQwN50f8D0ZbxfLBATSygD0c2PFrWuQcXrWmYoMaqe+jfPgRWO4MjkGiZthfdhN3yiwMga2oKnQHHuISvu1vF927ctVxPSyGAKfz0jZm23V2TBs8npBxnz/QH3HL7PgOp/IWq6JRrbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=aNtHXz7Q; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GqiilCvBT89TNpnfIdoOAPlel/VpSlUIATq3oQ5TsnI=; b=aNtHXz7Qio/7YewRk/tpYqSx5v
	JCCN3sra/xcNi2hlzNxV8YFgYJEZ5Rk0ffAp655Znesk+KM6K+CztLoJX5nxI+Xe2V9r1GSiO4Lcb
	+3m1g+tjL2GYlAbgGjNzadbWQ8BM9x/SxM9O1yzPcvmpe1VSmrHubMwwlyw4ohhEoQuumvkbq76Un
	MBu4tw2lBtu0CdC/xB1m4Tg1hjPYV/oCFE+rByS7kCKFAC/PI7mTjzTww/HINZpl5j8EhfE/06zIQ
	wDD217wfEFq/Flh6hGyJ6WJbfTgxzcmGph1zmsy8crBozSrRQdKJ6C28cxDMqtbWi72APdsDu8bef
	nfNebSEg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:39330 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1vDiLI-00000009Q7M-0bQf;
	Tue, 28 Oct 2025 12:58:22 +0100
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
Subject: [PATCH v2 2/2] arm64: dts: freescale: imx93-phyboard-nash: Add pwm-fan overlay
Date: Tue, 28 Oct 2025 12:58:20 +0100
Message-Id: <20251028115820.3165399-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028115820.3165399-1-primoz.fiser@norik.com>
References: <20251028115820.3165399-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add overlay to support PWM fan on the phyBOARD-Nash-i.MX93 board. Fan
can be connected to the FAN (X48) connector on the board and will be
controlled according to the following CPU temperature trips table:

 - bellow 50 degrees - fan is off (<1% duty cycle)
 - between 50 and 58 degrees - low fan speed (~35% duty cycle)
 - between 58 and 65 degrees - fan medium speed (~60% duty cycle)
 - above 65 degrees - fan at full speed (>99% duty cycle)

The output frequency of PWM signal is set to 25 kHz.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Reviewed-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
Changes in v2:
- add Reviewed-by: tag

Link to v1: https://lore.kernel.org/all/20251007084028.1125185-2-primoz.fiser@norik.com/

 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx93-phyboard-nash-pwm-fan.dtso          | 75 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-pwm-fan.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 33151065684f..e5c71dd7f4f3 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -359,11 +359,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 
 imx93-phyboard-nash-jtag-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-jtag.dtbo
 imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
+imx93-phyboard-nash-pwm-fan-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-pwm-fan.dtbo
 imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
 imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
 imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-jtag.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-pwm-fan.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-rpmsg.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-pwm-fan.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-pwm-fan.dtso
new file mode 100644
index 000000000000..d1adf04d56d9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-pwm-fan.dtso
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#include <dt-bindings/pwm/pwm.h>
+#include "imx93-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fan>;
+		cooling-levels = <1 90 150 200 255>;
+		pwms = <&tpm6 1 40000 PWM_POLARITY_INVERTED>;
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			trips {
+				cpu_low: cpu-low {
+					hysteresis = <3000>;
+					temperature = <50000>;
+					type = "active";
+				};
+
+				cpu_med: cpu-med {
+					hysteresis = <3000>;
+					temperature = <58000>;
+					type = "active";
+				};
+
+				cpu_high: cpu-high {
+					hysteresis = <3000>;
+					temperature = <65000>;
+					type = "active";
+				};
+			};
+
+			cooling-maps {
+				map1 {
+					cooling-device = <&fan0 1 1>;
+					trip = <&cpu_low>;
+				};
+
+				map2 {
+					cooling-device = <&fan0 2 2>;
+					trip = <&cpu_med>;
+				};
+
+				map3 {
+					cooling-device = <&fan0 4 4>;
+					trip = <&cpu_high>;
+				};
+			};
+		};
+	};
+};
+
+&tpm6 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fan: fangrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO23__TPM6_CH1	0x31e
+		>;
+	};
+};
-- 
2.34.1


