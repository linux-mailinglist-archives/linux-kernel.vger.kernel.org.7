Return-Path: <linux-kernel+bounces-886301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD0C35343
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6723B4F92F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849030C633;
	Wed,  5 Nov 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DGJ73Mtj"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4683307AE3;
	Wed,  5 Nov 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339658; cv=none; b=BMqhk5XkWtaaZP3Q6QKpZwaVaJABit+vB+EchZA3V8uZDCrU5nzFg1JfaZ6BEHbIaFAkWPHzHoK4H70N0ZJkNJHyT1LmAR6CV9rGm1e19bDtBtuSMxCgBS6Qzt7Fwfd0YmtvWnyX1zLbROqWxjE0bForhlemQfKT+r+O/y5VdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339658; c=relaxed/simple;
	bh=e8it67Pa+OyILFmynqSvHBKciHv7ID0u90prLX9NZG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXWfJyANLE1tFbfwprYud1/b0S6z/xP0BsHf4JTc8nyuyiUi2GH7Ib9JXBWI4Q86kF0PKc3VF0b7MnWQ1uok2kjP4jFx3ta2ixThzc67RKRAO5d0n/A4aUnDN6zfTEY7nw4jEZNRtIiJ390STm0V/FRq77JRF1uW+5hRjayhM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DGJ73Mtj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A5AisXpB984692, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762339494; bh=deudQ6Q6e9FgiGFN+tzJBoJ9gNfPDXqWuaRtR+SsdAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DGJ73MtjDMWlofD+7MdEyDiw1tsYrWtRw4d43fTTSNVgTDjDNvy39qshLDoU/Gty4
	 6bYSZG9/imlQYxX5QDJWOuBtI9MInp94RdsuDnqe/3OVQkhKEh4EambhlRtWJQ94mo
	 2ABIGQqkrVFzVx9hjDo/VNheNZgSvzfdXqPfvZ4qvIB8RPV1FZxC9PwshldNPy8BaN
	 Jt/mOGK23/Jf4F8sls8dj2CH3Yu8RgQqkTvNTkmdxQt8nUijShMqkrUf1z8keNwXfU
	 Z67RDgwn9qp9GwoGfZKiSKOcHur1zx4Rmva/bC1g3AzqnZ3QkY64nSpL13DfRfvM7Y
	 o5FFNujLjd/BQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A5AisXpB984692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 18:44:54 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 18:44:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 18:44:53 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Wed, 5 Nov 2025 18:44:53 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <afaerber@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lee@kernel.org>, <james.tai@realtek.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cy.huang@realtek.com>,
        <stanley_chang@realtek.com>, <eleanor.lin@realtek.com>
Subject: [PATCH 3/3] arm64: dts: realtek: Add Kent SoC and EVB device trees
Date: Wed, 5 Nov 2025 18:44:52 +0800
Message-ID: <20251105104452.6336-4-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105104452.6336-1-eleanor.lin@realtek.com>
References: <20251105104452.6336-1-eleanor.lin@realtek.com>
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

Include RTD1501S Phantom EVB (8GB), RTD1861B Krypton EVB (8GB), and
RTD1920S Smallville EVB (4GB).

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 arch/arm64/boot/dts/realtek/Makefile          |   5 +
 arch/arm64/boot/dts/realtek/kent.dtsi         | 179 ++++++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1501.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1501s-phantom-8gb.dts |  26 +++
 .../boot/dts/realtek/rtd1501s-phantom.dtsi    | 135 +++++++++++++
 arch/arm64/boot/dts/realtek/rtd1861.dtsi      |  13 ++
 .../boot/dts/realtek/rtd1861b-krypton-8gb.dts |  26 +++
 .../boot/dts/realtek/rtd1861b-krypton.dtsi    |  79 ++++++++
 arch/arm64/boot/dts/realtek/rtd1920.dtsi      |  13 ++
 .../dts/realtek/rtd1920s-smallville-4gb.dts   |  24 +++
 .../boot/dts/realtek/rtd1920s-smallville.dtsi | 145 ++++++++++++++
 11 files changed, 658 insertions(+)
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
index ef8d8fcbaa05..0ef0596681ad 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -13,3 +13,8 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-bpi-m4.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-lionskin.dtb
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
+
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1501s-phantom-8gb.dtb
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1861b-krypton-8gb.dtb
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1920s-smallville-4gb.dtb
+
diff --git a/arch/arm64/boot/dts/realtek/kent.dtsi b/arch/arm64/boot/dts/realtek/kent.dtsi
new file mode 100644
index 000000000000..6af3efa0bda4
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/kent.dtsi
@@ -0,0 +1,179 @@
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
+	arch_timer: arch-timer {
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
+			cache-size = <0x00200000>;
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
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0x00000000 0x00000000 0x00040000>, /* boot code */
+			 <0x98000000 0x00000000 0x98000000 0x00ef0000>, /* reg-bus */
+			 <0xa0000000 0x00000000 0xa0000000 0x10000000>, /* PCIE */
+			 <0xff000000 0x00000000 0xff000000 0x00200000>; /* GIC */
+
+		rbus: reg-bus@98000000 {
+			compatible = "simple-bus";
+			reg = <0x98000000 0x00ef0000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x98000000 0x00ef0000>,
+				 <0xa0000000 0xa0000000 0x10000000>; /* PCIE */
+
+			iso: syscon@7000 {
+				compatible = "realtek,iso-system", "syscon", "simple-mfd";
+				reg = <0x7000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x7000 0x1000>;
+				reg-io-width = <4>;
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
+&iso {
+	uart0: serial@800 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x800 0x100>;
+		clock-frequency = <432000000>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
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
index 000000000000..b0e03f3731e2
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1501s-phantom-8gb.dts
@@ -0,0 +1,26 @@
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
+	memory: memory@40000 {
+		device_type = "memory";
+		reg = <0x00000000 0x00050000 0x00000000 0x7ffb0000>,
+		      <0x00000000 0x8a100000 0x00000000 0x0def0000>,
+		      <0x00000000 0x98700000 0x00000000 0x07900000>,
+		      <0x00000000 0xa0600000 0x00000000 0x5ea00000>,
+		      <0x00000001 0x00000000 0x00000000 0xa0000000>,
+		      <0x00000001 0xa0600000 0x00000000 0x5fa00000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi b/arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi
new file mode 100644
index 000000000000..bf1e499addf9
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1501s-phantom.dtsi
@@ -0,0 +1,135 @@
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
+		bootargs = "earlycon=uart8250,mmio32,0x98007800
+			    console=ttyS0,460800 8250.nr_uarts=2 init=/init
+			    loglevel=8 max_loop=64 loop.max_part=7
+			    firmware_class.path=/vendor/firmware/,/vendor/av_fw";
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
+			alignment = <0x0 0x00400000>;
+			alloc-ranges = <0x0 0x00000000 0x0 0x20000000>;
+			size = <0x0 0x02000000>;
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
+			status = "okay";
+		};
+
+		opp900: opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <850000 850000 1100000>;
+			status = "okay";
+		};
+
+		opp1000: opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <870000 870000 1100000>;
+			status = "okay";
+		};
+
+		opp1100: opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <890000 890000 1100000>;
+			status = "okay";
+		};
+
+		opp1200: opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <910000 910000 1100000>;
+			status = "okay";
+		};
+
+		opp1300: opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <930000 930000 1100000>;
+			status = "okay";
+		};
+
+		opp1400: opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <950000 950000 1100000>;
+			status = "okay";
+		};
+
+		opp1500: opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <970000 970000 1100000>;
+			status = "okay";
+		};
+
+		opp1600: opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <990000 990000 1100000>;
+			opp-suspend;
+			status = "okay";
+		};
+
+		opp1700: opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1010000 1010000 1100000>;
+			status = "okay";
+		};
+
+		opp1800: opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1030000 1030000 1100000>;
+			status = "okay";
+		};
+
+		opp1900: opp-1900000000 {
+			opp-hz = /bits/ 64 <1900000000>;
+			opp-microvolt = <1050000 1050000 1100000>;
+			status = "okay";
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
index 000000000000..c36b485e8c5f
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1861b-krypton-8gb.dts
@@ -0,0 +1,26 @@
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
+	memory: memory@40000 {
+		device_type = "memory";
+		reg = <0x00000000 0x00050000 0x00000000 0x7ffb0000>,
+		      <0x00000000 0x8a100000 0x00000000 0x0def0000>,
+		      <0x00000000 0x98700000 0x00000000 0x07900000>,
+		      <0x00000000 0xa0600000 0x00000000 0x5ea00000>,
+		      <0x00000001 0x00000000 0x00000000 0xa0000000>,
+		      <0x00000001 0xa0600000 0x00000000 0x5fa00000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi b/arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi
new file mode 100644
index 000000000000..acf9066a7d98
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1861b-krypton.dtsi
@@ -0,0 +1,79 @@
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
+		bootargs = "earlycon=uart8250,mmio32,0x98007800 console=ttyS0,460800 8250.nr_uarts=1
+			    8250.share_irqs=1 init=/init loglevel=8 max_loop=64 loop.max_part=7
+			    firmware_class.path=/vendor/firmware/,/vendor/av_fw";
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
+			alignment = <0x0 0x00400000>;
+			alloc-ranges = <0x0 0x00000000 0x0 0x20000000>;
+			size = <0x0 0x02000000>;
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
+			status = "okay";
+		};
+
+		opp1600: opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1000000>;
+			opp-suspend;
+			status = "okay";
+		};
+
+		opp1800: opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1050000>;
+			status = "okay";
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
index 000000000000..2c8296018e68
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1920s-smallville-4gb.dts
@@ -0,0 +1,24 @@
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
+	memory: memory@40000 {
+		device_type = "memory";
+		reg = <0x00000000 0x00050000 0x00000000 0x7ffb0000>,
+		      <0x00000000 0x8a100000 0x00000000 0x0def0000>,
+		      <0x00000000 0x98700000 0x00000000 0x07900000>,
+		      <0x00000000 0xa1000000 0x00000000 0x5e000000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi b/arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi
new file mode 100644
index 000000000000..75d29591b9fa
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1920s-smallville.dtsi
@@ -0,0 +1,145 @@
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
+		bootargs = "earlycon=uart8250,mmio32,0x98007800
+			    console=ttyS0,460800 8250.nr_uarts=11 8250.share_irqs=1
+			    init=/init loglevel=8 max_loop=64 loop.max_part=7
+			    firmware_class.path=/vendor/firmware/,/vendor/av_fw";
+		stdout-path = "serial0:460800n8";
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		protected_mem: protected-mem@50000 {
+			reg = <0x0 0x00050000 0x0 0x00bf0000>;
+			no-map;
+		};
+
+		metadata: metadata@c40000 {
+			reg = <0x0 0x00c40000 0x0 0x003c4000>;
+			no-map;
+		};
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alignment = <0x0 0x00400000>;
+			alloc-ranges = <0x0 0x00000000 0x0 0x20000000>;
+			size = <0x0 0x02000000>;
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
+			status = "okay";
+		};
+
+		opp900: opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <850000 850000 1100000>;
+			status = "okay";
+		};
+
+		opp1000: opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <870000 870000 1100000>;
+			status = "okay";
+		};
+
+		opp1100: opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <890000 890000 1100000>;
+			status = "okay";
+		};
+
+		opp1200: opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <910000 910000 1100000>;
+			status = "okay";
+		};
+
+		opp1300: opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <930000 930000 1100000>;
+			status = "okay";
+		};
+
+		opp1400: opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <950000 950000 1100000>;
+			status = "okay";
+		};
+
+		opp1500: opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <970000 970000 1100000>;
+			status = "okay";
+		};
+
+		opp1600: opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <990000 990000 1100000>;
+			opp-suspend;
+			status = "okay";
+		};
+
+		opp1700: opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1010000 1010000 1100000>;
+			status = "okay";
+		};
+
+		opp1800: opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1030000 1030000 1100000>;
+			status = "okay";
+		};
+
+		opp1900: opp-1900000000 {
+			opp-hz = /bits/ 64 <1900000000>;
+			opp-microvolt = <1050000 1050000 1100000>;
+			status = "okay";
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


