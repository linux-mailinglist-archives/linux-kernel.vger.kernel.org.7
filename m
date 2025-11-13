Return-Path: <linux-kernel+bounces-899334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E63C576EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1556A34B80B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518B34F49C;
	Thu, 13 Nov 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ChU+DoDL"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DC86352;
	Thu, 13 Nov 2025 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037195; cv=none; b=JvIYfsRTj87HhuhWw6rDqRUXV1KfcOucznrs2zjM5lLS2VieX3xSbR26MIWBhbbt8U818x0yxyvX8uJDtgaYP1xo7slRoddFDcv55j3OJ4znYqYteMINLeemC/thIsdL2y+KEiXMSC6gvLbZyh3vnU53zyYPxIo06oKcIHTgYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037195; c=relaxed/simple;
	bh=GBsqL6UVb0UxXnQffEhYz5VSrtecQt83aDI2hrRb+iI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6gEjGAOK2KNrb7qYt+sSrUMnmyoY8k6/GxEmdccf5lZB6q3/SAFtfoIb0iu27XRf5gEHbJnASRrU0F1J+UMsyVYA+qJFYDVZ/w0V5BYVNLubpBicXAP1jCA7m5RGsBX+V3FqjKPtYNVDfXkHGBqwNoaE2mV+fAdI747bO+flqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ChU+DoDL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ADCUAEK03591314, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763037010; bh=g3mVldQTeP3kDlUa3dFGpE3f9Xdo9n+YNlFLDftc4Iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ChU+DoDL0MBedbSBLOlb5hsvP7ROHzG6lGy1jEX9qt0RLrWckRclvDIA3OdBzugVx
	 HRUOOTujLMOLTIutY82czzJzC9QFT0k3geY1s+4JzbZAyoM11crGyrrvspaZ1YA1cA
	 HIYPImttFXNxabFJMMJe2r333H4A9fhBhw+k+CviwQqBupDZOiU5WHsBHWCqEE8uCg
	 1nXLUIBQIahjwEnA5dF+M3PtN0uzWfGPJ1OoSWtXxc2r+ct8YrUZuJIcuBghZDNveB
	 AnJctAsi8Zh+LbbboBxP5fM8C1qe/q3E5daq8Xi2Yyq6gmzFGXSAvBVGq1K1OCnR/i
	 52igwk+/5kJvg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ADCUAEK03591314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 20:30:10 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 20:30:10 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 20:30:10 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <afaerber@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lee@kernel.org>, <james.tai@realtek.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cy.huang@realtek.com>,
        <stanley_chang@realtek.com>, <eleanor.lin@realtek.com>
Subject: [PATCH v2 3/3] arm64: dts: realtek: Add Kent SoC and EVB device trees
Date: Thu, 13 Nov 2025 20:30:09 +0800
Message-ID: <20251113123009.26568-4-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113123009.26568-1-eleanor.lin@realtek.com>
References: <20251113123009.26568-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add Device Tree hierarchy for Realtek Kent SoC family:

- kent.dtsi: base SoC layer
- rtd<variant>.dtsi: SoC variant layer
- rtd<variant>-<board>.dtsi: board layer
- rtd<variant>-<board>-<config>.dts: board configuration layer

Include RTD1501s Phantom EVB (8GB), RTD1861B Krypton EVB (8GB), and
RTD1920s Smallville EVB (4GB).

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 arch/arm64/boot/dts/realtek/Makefile          |   7 +-
 arch/arm64/boot/dts/realtek/kent.dtsi         | 174 ++++++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1501.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1501s-phantom-8gb.dts |  25 +++
 .../boot/dts/realtek/rtd1501s-phantom.dtsi    | 119 ++++++++++++
 arch/arm64/boot/dts/realtek/rtd1861.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1861b-krypton-8gb.dts |  25 +++
 .../boot/dts/realtek/rtd1861b-krypton.dtsi    |  73 ++++++++
 arch/arm64/boot/dts/realtek/rtd1920.dtsi      |  13 ++
 .../dts/realtek/rtd1920s-smallville-4gb.dts   |  23 +++
 .../boot/dts/realtek/rtd1920s-smallville.dtsi | 129 +++++++++++++
 11 files changed, 610 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/kent.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1501.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1501s-phantom-8gb.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1861.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1861b-krypton-8gb.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1920.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1920s-smallville-4gb.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index ef8d8fcbaa05..8a8e143182b9 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -1,15 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1293-ds418j.dtb
-
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-mele-v9.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-xnano-x5.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
-
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
-
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-bpi-m4.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-lionskin.dtb
-
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1501s-phantom-8gb.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1861b-krypton-8gb.dtb
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1920s-smallville-4gb.dtb
+
diff --git a/arch/arm64/boot/dts/realtek/kent.dtsi b/arch/arm64/boot/dts/realtek/kent.dtsi
new file mode 100644
index 000000000000..8d1b082c6ec8
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/kent.dtsi
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek Kent SoC family
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI  9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+			dynamic-power-coefficient = <454>;
+			#cooling-cells = <2>;
+
+			l2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-size = <0x40000>;
+				cache-unified;
+				next-level-cache = <&l3>;
+			};
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+			dynamic-power-coefficient = <454>;
+			#cooling-cells = <2>;
+
+			l2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-size = <0x40000>;
+				cache-unified;
+				next-level-cache = <&l3>;
+			};
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x200>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+			dynamic-power-coefficient = <454>;
+			#cooling-cells = <2>;
+
+			l2_2: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-size = <0x40000>;
+				cache-unified;
+				next-level-cache = <&l3>;
+			};
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x300>;
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+			dynamic-power-coefficient = <454>;
+			#cooling-cells = <2>;
+
+			l2_3: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-size = <0x40000>;
+				cache-unified;
+				next-level-cache = <&l3>;
+			};
+		};
+
+		l3: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <0x200000>;
+			cache-unified;
+		};
+	};
+
+	psci: psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		ranges = <0x0 0x0 0x0 0x40000>, /* boot code */
+			 <0x98000000 0x0 0x98000000 0xef0000>, /* rbus */
+			 <0xa0000000 0x0 0xa0000000 0x10000000>, /* PCIE */
+			 <0xff000000 0x0 0xff000000 0x200000>; /* GIC */
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		rbus: bus@98000000 {
+			compatible = "simple-bus";
+			ranges = <0x0 0x98000000 0xef0000>,
+				 <0xa0000000 0xa0000000 0x10000000>; /* PCIE */
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			iso: syscon@7000 {
+				compatible = "realtek,misc", "syscon", "simple-mfd";
+				reg = <0x7000 0x1000>;
+				ranges = <0x0 0x7000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				uart0: serial@800 {
+					compatible = "snps,dw-apb-uart";
+					reg = <0x800 0x100>;
+					clock-frequency = <432000000>;
+					interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+					reg-io-width = <4>;
+					reg-shift = <2>;
+					status = "disabled";
+				};
+			};
+		};
+
+		gic: interrupt-controller@ff100000 {
+			compatible = "arm,gic-v3";
+			reg = <0xff100000 0x10000>,
+			      <0xff140000 0x80000>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#interrupt-cells = <3>;
+			#size-cells = <1>;
+		};
+	};
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1501.dtsi b/arch/arm64/boot/dts/realtek/rtd1501.dtsi
new file mode 100644
index 000000000000..1df5d9843505
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1501.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1501 SoC
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+#include "kent.dtsi"
+
+&uart0 {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1501s-phantom-8gb.dts b/arch/arm64/boot/dts/realtek/rtd1501s-phantom-8gb.dts
new file mode 100644
index 000000000000..c708a713fc4d
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1501s-phantom-8gb.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1501S Phantom EVB
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd1501s-phantom.dtsi"
+
+/ {
+	compatible = "realtek,phantom", "realtek,rtd1501s";
+	model = "Realtek Phantom EVB Chromium (8GB)";
+
+	memory@40000 {
+		device_type = "memory";
+		reg = <0x0 0x50000 0x0 0x7ffb0000>,
+		      <0x0 0x8a100000 0x0 0xdef0000>,
+		      <0x0 0x98700000 0x0 0x7900000>,
+		      <0x0 0xa0600000 0x0 0x5ea00000>,
+		      <0x1 0x0 0x0 0xa0000000>,
+		      <0x1 0xa0600000 0x0 0x5fa00000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi b/arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi
new file mode 100644
index 000000000000..a3639bd6a75b
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1501S Phantom EVB
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/thermal/thermal.h>
+#include "rtd1501.dtsi"
+
+/ {
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0x98007800";
+		stdout-path = "serial0:460800n8";
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alignment = <0x0 0x400000>;
+			alloc-ranges = <0x0 0x0 0x0 0x20000000>;
+			size = <0x0 0x2000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	cpu_opps: opp-table-cpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp800: opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <830000 830000 1100000>;
+		};
+
+		opp900: opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <850000 850000 1100000>;
+		};
+
+		opp1000: opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <870000 870000 1100000>;
+		};
+
+		opp1100: opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <890000 890000 1100000>;
+		};
+
+		opp1200: opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <910000 910000 1100000>;
+		};
+
+		opp1300: opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <930000 930000 1100000>;
+		};
+
+		opp1400: opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <950000 950000 1100000>;
+		};
+
+		opp1500: opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <970000 970000 1100000>;
+		};
+
+		opp1600: opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <990000 990000 1100000>;
+			opp-suspend;
+		};
+
+		opp1700: opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1010000 1010000 1100000>;
+		};
+
+		opp1800: opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1030000 1030000 1100000>;
+		};
+
+		opp1900: opp-1900000000 {
+			opp-hz = /bits/ 64 <1900000000>;
+			opp-microvolt = <1050000 1050000 1100000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1861.dtsi b/arch/arm64/boot/dts/realtek/rtd1861.dtsi
new file mode 100644
index 000000000000..e9b1b85c7a63
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1861.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1861 SoC
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+#include "kent.dtsi"
+
+&uart0 {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1861b-krypton-8gb.dts b/arch/arm64/boot/dts/realtek/rtd1861b-krypton-8gb.dts
new file mode 100644
index 000000000000..38feec66d4e9
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1861b-krypton-8gb.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1861B Krypton EVB
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd1861b-krypton.dtsi"
+
+/ {
+	compatible = "realtek,krypton", "realtek,rtd1861b";
+	model = "Realtek Krypton EVB (8GB)";
+
+	memory@40000 {
+		device_type = "memory";
+		reg = <0x0 0x50000 0x0 0x7ffb0000>,
+		      <0x0 0x8a100000 0x0 0xdef0000>,
+		      <0x0 0x98700000 0x0 0x7900000>,
+		      <0x0 0xa0600000 0x0 0x5ea00000>,
+		      <0x1 0x0 0x0 0xa0000000>,
+		      <0x1 0xa0600000 0x0 0x5fa00000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi b/arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi
new file mode 100644
index 000000000000..3773284ce95b
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1861B Krypton EVB
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd1861.dtsi"
+
+/ {
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0x98007800";
+		stdout-path = "serial0:460800n8";
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alignment = <0x0 0x400000>;
+			alloc-ranges = <0x0 0x0 0x0 0x20000000>;
+			size = <0x0 0x2000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	cpu_opps: opp-table-cpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp1200: opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <900000>;
+		};
+
+		opp1600: opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1000000>;
+			opp-suspend;
+		};
+
+		opp1800: opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1920.dtsi b/arch/arm64/boot/dts/realtek/rtd1920.dtsi
new file mode 100644
index 000000000000..ffefde9749a1
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1920.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1920 SoC
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+#include "kent.dtsi"
+
+&uart0 {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1920s-smallville-4gb.dts b/arch/arm64/boot/dts/realtek/rtd1920s-smallville-4gb.dts
new file mode 100644
index 000000000000..b6900b11f34d
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1920s-smallville-4gb.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1920S Smallville EVB
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd1920s-smallville.dtsi"
+
+/ {
+	compatible = "realtek,smallville", "realtek,rtd1920s";
+	model = "Realtek Smallville EVB (4GB)";
+
+	memory@40000 {
+		device_type = "memory";
+		reg = <0x0 0x50000 0x0 0x7ffb0000>,
+		      <0x0 0x8a100000 0x0 0xdef0000>,
+		      <0x0 0x98700000 0x0 0x7900000>,
+		      <0x0 0xa1000000 0x0 0x5e000000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi b/arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi
new file mode 100644
index 000000000000..0989afcbde67
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1920S Smallville EVB
+ *
+ * Copyright (c) 2024 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/thermal/thermal.h>
+#include "rtd1920.dtsi"
+
+/ {
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0x98007800";
+		stdout-path = "serial0:460800n8";
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		protected_mem: protected-mem@50000 {
+			reg = <0x0 0x50000 0x0 0xbf0000>;
+			no-map;
+		};
+
+		metadata: metadata@c40000 {
+			reg = <0x0 0xc40000 0x0 0x3c4000>;
+			no-map;
+		};
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alignment = <0x0 0x400000>;
+			alloc-ranges = <0x0 0x0 0x0 0x20000000>;
+			size = <0x0 0x2000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	cpu_opps: opp-table-cpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp800: opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <830000 830000 1100000>;
+		};
+
+		opp900: opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <850000 850000 1100000>;
+		};
+
+		opp1000: opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <870000 870000 1100000>;
+		};
+
+		opp1100: opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <890000 890000 1100000>;
+		};
+
+		opp1200: opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <910000 910000 1100000>;
+		};
+
+		opp1300: opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <930000 930000 1100000>;
+		};
+
+		opp1400: opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <950000 950000 1100000>;
+		};
+
+		opp1500: opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <970000 970000 1100000>;
+		};
+
+		opp1600: opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <990000 990000 1100000>;
+			opp-suspend;
+		};
+
+		opp1700: opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1010000 1010000 1100000>;
+		};
+
+		opp1800: opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1030000 1030000 1100000>;
+		};
+
+		opp1900: opp-1900000000 {
+			opp-hz = /bits/ 64 <1900000000>;
+			opp-microvolt = <1050000 1050000 1100000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opps>;
+	#cooling-cells = <2>;
+};
+
-- 
2.34.1


