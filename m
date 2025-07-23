Return-Path: <linux-kernel+bounces-742140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91471B0EDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ECD1C2146C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ADD283FC2;
	Wed, 23 Jul 2025 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="WHHrpUXM"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B1281351
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261051; cv=none; b=TFH6rFFpT/omEqfTY7UHK1evyKAs7Z09MQpLa2c7g9aTJ/xAKx5wdVL9vn/qS2jDzZSuiV9w5uVSQp+x6oHX79d3CHZ+G2L938q5hKDLS0c2OUnm5ecxP4tGnaeXBg7fZmVT5VvIK41PDX+I8y451W4UG+vTI0XRrqUXw9M1mHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261051; c=relaxed/simple;
	bh=mj9prXlaTjSFcP5X0qUxXZoRlZEtKroaMp0wXLiJyug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryXR4Y6sAYr7oYp0eNxFrwqvPc7URxQTG31+96EE17HpWeR2f/vpuHg2sNn9V1ReQBzXaRLHmEPIbzWBh4W1Hu23Lo9OA58E4EtsoSrYt9vMwq1Tq0UDtMjf8TNNzi7eT+35Z2wV7qGJLuoAoGhHRXOhVMvHqZ7yl9oqkXE+E8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=WHHrpUXM; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753261049; bh=Da739bwPyzQ7G/L23+gHR9/t8GlZz/n/c0y0bZk0xxs=;
 b=WHHrpUXMJkaVl7t+SFp67nHet5L5rxbDvNCejJBChcWqWIrZRWmb+zu6zuJWhyQ2lOhxp73g2
 Cy4xS6+/aHS9Z6SDKVBlfVyd2cpjppMf6lqXxAPcdPW8xbtAZG5hY1KVy3ot7NTFxS32qhxC6Im
 1WoiXke3Ak/lQX3iYwcpVigeNgxp9n8d1edSmXt1nJxDcChe2gPQIDvN8Z9/LtqMAPiA3OycaNx
 ydsouNOM/wem1HjpjFDWxx801UYtLXOpX2OXOxT/ASNLHh0sT3vwdii3A51R/P3n3dfFp9AV9/G
 TkzFJedQA98tQRvHF369+MJbWMRbR1Fi/PCxQW4U4/4g==
X-Forward-Email-ID: 6880a3f1144dc4a5e5baee5e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 5/5] arm64: dts: rockchip: Enable more power domains for RK3528
Date: Wed, 23 Jul 2025 08:56:47 +0000
Message-ID: <20250723085654.2273324-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723085654.2273324-1-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe device power-domains and enable the PD_RKVENC, PD_VO and PD_VPU
power-domains on RK3528.

The PD_RKVDEC is used by RKVDEC and DDRPHY CRU, and is kept disabled to
prevent a full system reset trying to read the rate of the SCMI_CLK_DDR
clock.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Add power-domains for spi nodes
- Rebased on top of next-20250722
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 30 +++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 54fa8089c4d3..85bc3f5aa2c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -155,6 +155,7 @@ gpio1: gpio@ffaf0000 {
 			gpio-ranges = <&pinctrl 0 32 32>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			power-domains = <&power RK3528_PD_VPU>;
 		};
 
 		gpio2: gpio@ffb00000 {
@@ -167,6 +168,7 @@ gpio2: gpio@ffb00000 {
 			gpio-ranges = <&pinctrl 0 64 32>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			power-domains = <&power RK3528_PD_VO>;
 		};
 
 		gpio3: gpio@ffb10000 {
@@ -179,6 +181,7 @@ gpio3: gpio@ffb10000 {
 			gpio-ranges = <&pinctrl 0 96 32>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			power-domains = <&power RK3528_PD_VPU>;
 		};
 
 		gpio4: gpio@ffb20000 {
@@ -191,6 +194,7 @@ gpio4: gpio@ffb20000 {
 			gpio-ranges = <&pinctrl 0 128 32>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 		};
 	};
 
@@ -501,7 +505,6 @@ power-domain@RK3528_PD_RKVENC {
 					reg = <RK3528_PD_RKVENC>;
 					pm_qos = <&qos_rkvenc>;
 					#power-domain-cells = <0>;
-					status = "disabled";
 				};
 				power-domain@RK3528_PD_VO {
 					reg = <RK3528_PD_VO>;
@@ -515,7 +518,6 @@ power-domain@RK3528_PD_VO {
 						 <&qos_vdpp>,
 						 <&qos_vop>;
 					#power-domain-cells = <0>;
-					status = "disabled";
 				};
 				power-domain@RK3528_PD_VPU {
 					reg = <RK3528_PD_VPU>;
@@ -529,7 +531,6 @@ power-domain@RK3528_PD_VPU {
 						 <&qos_usb3otg>,
 						 <&qos_vpu>;
 					#power-domain-cells = <0>;
-					status = "disabled";
 				};
 			};
 		};
@@ -571,6 +572,7 @@ spi0: spi@ff9c0000 {
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 25>, <&dmac 24>;
 			dma-names = "tx", "rx";
+			power-domains = <&power RK3528_PD_RKVENC>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -585,6 +587,7 @@ spi1: spi@ff9d0000 {
 			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 31>, <&dmac 30>;
 			dma-names = "tx", "rx";
+			power-domains = <&power RK3528_PD_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -609,6 +612,7 @@ uart1: serial@ff9f8000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 11>, <&dmac 10>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -621,6 +625,7 @@ uart2: serial@ffa00000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 13>, <&dmac 12>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -633,6 +638,7 @@ uart3: serial@ffa08000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 15>, <&dmac 14>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -645,6 +651,7 @@ uart4: serial@ffa10000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 17>, <&dmac 16>;
+			power-domains = <&power RK3528_PD_VO>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -657,6 +664,7 @@ uart5: serial@ffa18000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 19>, <&dmac 18>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -669,6 +677,7 @@ uart6: serial@ffa20000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 21>, <&dmac 20>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -681,6 +690,7 @@ uart7: serial@ffa28000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 23>, <&dmac 22>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -693,6 +703,7 @@ i2c0: i2c@ffa50000 {
 			clocks = <&cru CLK_I2C0>, <&cru PCLK_I2C0>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -705,6 +716,7 @@ i2c1: i2c@ffa58000 {
 			clocks = <&cru CLK_I2C1>, <&cru PCLK_I2C1>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -731,6 +743,7 @@ i2c3: i2c@ffa68000 {
 			clocks = <&cru CLK_I2C3>, <&cru PCLK_I2C3>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -745,6 +758,7 @@ i2c4: i2c@ffa70000 {
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c4_xfer>;
+			power-domains = <&power RK3528_PD_VO>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -757,6 +771,7 @@ i2c5: i2c@ffa78000 {
 			clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -769,6 +784,7 @@ i2c6: i2c@ffa80000 {
 			clocks = <&cru CLK_I2C6>, <&cru PCLK_I2C6>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -783,6 +799,7 @@ i2c7: i2c@ffa88000 {
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c7_xfer>;
+			power-domains = <&power RK3528_PD_VO>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -874,6 +891,7 @@ saradc: adc@ffae0000 {
 			clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
 			clock-names = "saradc", "apb_pclk";
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_P_SARADC>;
 			reset-names = "saradc-apb";
 			#io-channel-cells = <1>;
@@ -894,6 +912,7 @@ gmac0: ethernet@ffbd0000 {
 			interrupt-names = "macirq", "eth_wake_irq";
 			phy-handle = <&rmii0_phy>;
 			phy-mode = "rmii";
+			power-domains = <&power RK3528_PD_VO>;
 			resets = <&cru SRST_A_MAC_VO>;
 			reset-names = "stmmaceth";
 			rockchip,grf = <&vo_grf>;
@@ -952,6 +971,7 @@ gmac1: ethernet@ffbe0000 {
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "eth_wake_irq";
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_A_MAC>;
 			reset-names = "stmmaceth";
 			rockchip,grf = <&vpu_grf>;
@@ -1002,6 +1022,7 @@ sdhci: mmc@ffbf0000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>,
 				    <&emmc_strb>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
 				 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
 				 <&cru SRST_T_EMMC>;
@@ -1023,6 +1044,7 @@ sdio0: mmc@ffc10000 {
 			max-frequency = <200000000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_H_SDIO0>;
 			reset-names = "reset";
 			status = "disabled";
@@ -1042,6 +1064,7 @@ sdio1: mmc@ffc20000 {
 			max-frequency = <200000000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_H_SDIO1>;
 			reset-names = "reset";
 			status = "disabled";
@@ -1062,6 +1085,7 @@ sdmmc: mmc@ffc30000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
 				    <&sdmmc_det>;
+			power-domains = <&power RK3528_PD_VO>;
 			resets = <&cru SRST_H_SDMMC0>;
 			reset-names = "reset";
 			rockchip,default-sample-phase = <90>;
-- 
2.50.1


