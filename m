Return-Path: <linux-kernel+bounces-864299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3842EBFA74C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34690506697
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC72F617F;
	Wed, 22 Oct 2025 07:05:57 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F12F5A3F;
	Wed, 22 Oct 2025 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116756; cv=none; b=qohrvdURFj/uX/Huh/ehQ7EGHKUnI1ASgSgCpKB66EgCUk0g1GLaeoxgBi/tmIDz4Wjago1tDm2deZe3FCRfCTGFjgMyp0xqhJpahi0dASv3dHxBZazNv2cj9pQCH59c3FGUsbZChIo4v7DoNaJUtoZvOBYau6fRDRYKqKmt/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116756; c=relaxed/simple;
	bh=AUAsIfcVrxEwRZrx2jeBinK2+N38/x+qU2mLV27m7M0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hatfdiwqPOXTH8Anqo2sOIxqNXulaMUAnpXqqffPZFl38pW5PoHM1VVxIT/8LNKADE8coRp2UZKIDJgQrRLVCl71cBGJMktYFNte1iIk/iC4+JsUUKsaP6xi+LNHXxlSh/IH7uNAS7qn+NLHfmEwarSefF+6912aKDPIHYBWPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 15:05:44 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 15:05:44 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, <bmc-sw@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Date: Wed, 22 Oct 2025 15:05:41 +0800
Message-ID: <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add initial device tree for the ASPEED 8th BMC SoC family.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 516 ++++++++++++++++++++++
 1 file changed, 516 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
new file mode 100644
index 000000000000..be6ca2739958
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+
+/ {
+	compatible = "aspeed,ast2700";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		serial10 = &uart10;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		serial13 = &uart13;
+		serial14 = &uart14;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+		};
+	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf: trusted-firmware-a@430000000 {
+			reg = <0x4 0x30000000 0x0 0x80000>;
+			no-map;
+		};
+
+		optee_core: optee-core@430080000 {
+			reg = <0x4 0x30080000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+	};
+
+	gic: interrupt-controller@12200000 {
+		compatible = "arm,gic-v3";
+		reg = <0 0x12200000 0 0x10000>, /* GICD */
+		      <0 0x12280000 0 0x80000>, /* GICR */
+		      <0 0x40440000 0 0x1000>;  /* GICC */
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+	};
+
+	soc0: soc@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x10000000 0x0 0x4000000>;
+
+		intc0: interrupt-controller@12100000 {
+			compatible = "aspeed,ast2700-intc0";
+			reg = <0 0x12100000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x12100000 0x4000>;
+
+			intc0_11: interrupt-controller@1b00 {
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				compatible = "aspeed,ast2700-intc0-ic";
+				reg = <0x1b00 0x10>;
+				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		syscon0: syscon@12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x0 0x12c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x12c02000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			silicon-id@0 {
+				compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
+				reg = <0x0 0x4>;
+			};
+
+			scu_ic0: interrupt-controller@1d0 {
+				compatible = "aspeed,ast2700-scu-ic0";
+				reg = <0x1d0 0xc>;
+				#interrupt-cells = <1>;
+				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+			};
+
+			scu_ic1: interrupt-controller@1e0 {
+				compatible = "aspeed,ast2700-scu-ic1";
+				reg = <0x1e0 0xc>;
+				#interrupt-cells = <1>;
+				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+			};
+		};
+
+		gpio0: gpio@12c11000 {
+			#gpio-cells = <2>;
+			gpio-controller;
+			compatible = "aspeed,ast2700-gpio";
+			reg = <0x0 0x12c11000 0x0 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			ngpios = <12>;
+			clocks = <&syscon0 SCU0_CLK_APB>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		uart4: serial@12c1a000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x12c1a000 0x0 0x1000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			no-loopback-test;
+			status = "disabled";
+		};
+	};
+
+	soc1: soc@14000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x14000000 0x0 0x10000000>;
+
+		mdio0: mdio@14040000 {
+			compatible = "aspeed,ast2600-mdio";
+			reg = <0 0x14040000 0 0x8>;
+			resets = <&syscon1 SCU1_RESET_MII>;
+			status = "disabled";
+		};
+
+		mdio1: mdio@14040008 {
+			compatible = "aspeed,ast2600-mdio";
+			reg = <0 0x14040008 0 0x8>;
+			resets = <&syscon1 SCU1_RESET_MII>;
+			status = "disabled";
+		};
+
+		mdio2: mdio@14040010 {
+			compatible = "aspeed,ast2600-mdio";
+			reg = <0 0x14040010 0 0x8>;
+			resets = <&syscon1 SCU1_RESET_MII>;
+			status = "disabled";
+		};
+
+		syscon1: syscon@14c02000 {
+			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+			reg = <0x0 0x14c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x14c02000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			scu_ic2: interrupt-controller@100 {
+				compatible = "aspeed,ast2700-scu-ic2";
+				reg = <0x100 0x8>;
+				#interrupt-cells = <1>;
+				interrupts-extended = <&intc1_5 0>;
+				interrupt-controller;
+			};
+
+			scu_ic3: interrupt-controller@108 {
+				compatible = "aspeed,ast2700-scu-ic3";
+				reg = <0x108 0x8>;
+				#interrupt-cells = <1>;
+				interrupts-extended = <&intc1_5 26>;
+				interrupt-controller;
+			};
+
+		};
+
+		gpio1: gpio@14c0b000 {
+			#gpio-cells = <2>;
+			gpio-controller;
+			compatible = "aspeed,ast2700-gpio";
+			reg = <0x0 0x14c0b000 0x0 0x1000>;
+			interrupts-extended = <&intc1_2 18>;
+			ngpios = <216>;
+			clocks = <&syscon1 SCU1_CLK_AHB>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		intc1: interrupt-controller@14c18000 {
+			compatible = "aspeed,ast2700-intc1";
+			reg = <0 0x14c18000 0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x14c18000 0x400>;
+
+			intc1_0: interrupt-controller@100 {
+				compatible = "aspeed,ast2700-intc1-ic";
+				reg = <0x100 0x10>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 0>;
+			};
+
+			intc1_1: interrupt-controller@110 {
+				compatible = "aspeed,ast2700-intc1-ic";
+				reg = <0x110 0x10>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 1>;
+			};
+
+			intc1_2: interrupt-controller@120 {
+				compatible = "aspeed,ast2700-intc1-ic";
+				reg = <0x120 0x10>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 2>;
+			};
+
+			intc1_3: interrupt-controller@130 {
+				compatible = "aspeed,ast2700-intc1-ic";
+				reg = <0x130 0x10>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 3>;
+			};
+
+			intc1_4: interrupt-controller@140 {
+				compatible = "aspeed,ast2700-intc1-ic";
+				reg = <0x140 0x10>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 4>;
+			};
+
+			intc1_5: interrupt-controller@150 {
+				compatible = "aspeed,ast2700-intc1-ic";
+				reg = <0x150 0x10>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 5>;
+			};
+		};
+
+		uart0: serial@14c33000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33000 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART0CLK>;
+			interrupts-extended = <&intc1_4 7>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart1: serial@14c33100 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33100 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART1CLK>;
+			interrupts-extended = <&intc1_4 8>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart2: serial@14c33200 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33200 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART2CLK>;
+			interrupts-extended = <&intc1_4 9>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart3: serial@14c33300 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33300 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART3CLK>;
+			interrupts-extended = <&intc1_4 10>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart5: serial@14c33400 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33400 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART5CLK>;
+			interrupts-extended = <&intc1_4 11>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart6: serial@14c33500 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33500 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART6CLK>;
+			interrupts-extended = <&intc1_4 12>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart7: serial@14c33600 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33600 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART7CLK>;
+			interrupts-extended = <&intc1_4 13>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart8: serial@14c33700 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33700 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART8CLK>;
+			interrupts-extended = <&intc1_4 14>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart9: serial@14c33800 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33800 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART9CLK>;
+			interrupts-extended = <&intc1_4 15>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart10: serial@14c33900 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33900 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART10CLK>;
+			interrupts-extended = <&intc1_4 16>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart11: serial@14c33a00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33a00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART11CLK>;
+			interrupts-extended = <&intc1_4 17>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart12: serial@14c33b00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33b00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
+			interrupts-extended = <&intc1_4 18>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart13: serial@14c33c00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33c00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_UART13>;
+			interrupts-extended = <&intc1_0 23>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart14: serial@14c33d00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33d00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_UART14>;
+			interrupts-extended = <&intc1_1 23>;
+			no-loopback-test;
+			status = "disabled";
+		};
+	};
+};
-- 
2.34.1


