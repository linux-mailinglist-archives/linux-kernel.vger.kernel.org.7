Return-Path: <linux-kernel+bounces-726444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11754B00D25
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BF91897720
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6E52FEE0F;
	Thu, 10 Jul 2025 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="OPKsz0rD"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA172FE395
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179420; cv=none; b=EzgdZbOfLAWuIpyc9ToJMYw88A5BBk7e8Hj5z59Eu6DXE5QmF0uzQkKimJ9fe8nNqykgxVB2zTPUlvOuwiixFPe1S5ge74NakbksZ97ouAmIoyF8LWBiB3fDc9WW/3Hp2+72fR2gIgFM/7YFLxPJGTLcf29gu3XJ2JXHlWMIuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179420; c=relaxed/simple;
	bh=H8NP96b6H+Xf9B6K6QAVSd2DiJQ8emHtj65WhLFusM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPb32WxYEjYF/Zp0NdkogYC47B3Hp30bqA/07D5xTcg+HCfuue6nRmGiQgbGXJalc6DgMZHIHftItUTAE3cTUp7t2KfFR/iU4icMGh2T5FbQcg1PaBVcSC5frzVdu2A/2m74Wss63YkwbyXWnjRRX1qSiJ6FT0CE63BDFmIbAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=OPKsz0rD; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752179417; bh=1M6pIUTsx9U79zIGyyAqcUwvGw4yC/yWo12uPv0lrxU=;
 b=OPKsz0rDehlq17nT+aOs7uokABfrLPv9flrouMuuWjuYUYV9qplZ1FnvW0TjdPYO2ndPvpYXg
 hsxNqWtPcKbIj1vYvNlFBdEgVsuTKpPkIKyDOOJqVx8wkMOeJrTwCPIZerOMUfDu2WUNqDBv+QN
 K0ocfrALl9kuQbfjS1pnpHCuDyIqly8FUw6quB4ChfaUIQCyymNKgRFNhBy+9UflLIwv5Kz+Jqj
 uP9M0z8LESM0/+mLjLP8Uc9uuY/2xDh8ClHcg6LC94T6MeM/z2fP4ITxHkVD1VgUGIHRK4SxEcV
 Pn04toq6pWQZG66y07AgUPwIIAolmRKkO4wqJfy1PqOA==
X-Forward-Email-ID: 687022d65dd88a88be4f4e55
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.3
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
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
Date: Thu, 10 Jul 2025 20:29:41 +0000
Message-ID: <20250710202958.3717181-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710202958.3717181-1-jonas@kwiboo.se>
References: <20250710202958.3717181-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ROCK 2A and ROCK 2F is a high-performance single board computer
developed by Radxa, based on the Rockchip RK3528A SoC.

Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Limit sdmmc max-frequency to 100 MHz (Yao Zi)

Schematics:
- https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
- https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
---
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 ++++++++++++++++++
 .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
 .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
 4 files changed, 387 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 099520962ffb..4cb6106b16f2 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -90,6 +90,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2f.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3562-evb2-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-d.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
new file mode 100644
index 000000000000..83fa7750f909
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "rk3528.dtsi"
+
+/ {
+	aliases {
+		i2c1 = &i2c1;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-maskrom {
+			label = "MASKROM";
+			linux,code = <KEY_SETUP>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_led_b>;
+
+		led-state {
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	vdd_0v9: regulator-0v9-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_ddr: regulator-1v1-vcc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_ddr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc_3v3: regulator-3v3-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_wifi: regulator-3v3-vcc-wifi {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_wifi_pwr>;
+		regulator-name = "vcc_wifi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc5v0_usb20: regulator-5v0-vcc-usb20 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_en>;
+		regulator-name = "vcc5v0_usb20";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vccio_sd: regulator-vccio-sd {
+		compatible = "regulator-gpio";
+		gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
+		regulator-name = "vccio_sd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <1800000 0x0>, <3300000 0x1>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_arm: regulator-vdd-arm {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 5000 PWM_POLARITY_INVERTED>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_arm";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <746000>;
+		regulator-max-microvolt = <1201000>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	vdd_logic: regulator-vdd-logic {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 5000 PWM_POLARITY_INVERTED>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_logic";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <705000>;
+		regulator-max-microvolt = <1006000>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-wlan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_reg_on_h>;
+		radio-type = "wlan";
+		shutdown-gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&gpu {
+	mali-supply = <&vdd_logic>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1m0_xfer>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "belling,bl24c16a", "atmel,24c16";
+		reg = <0x50>;
+		pagesize = <16>;
+		read-only;
+		vcc-supply = <&vcc_3v3>;
+	};
+};
+
+&pinctrl {
+	bluetooth {
+		bt_wake_host_h: bt-wake-host-h {
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		host_wake_bt_h: host-wake-bt-h {
+			rockchip,pins = <1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		state_led_b: state-led-b {
+			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_host_en: usb-host-en {
+			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		usb_wifi_pwr: usb-wifi-pwr {
+			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wifi_reg_on_h: wifi-reg-on-h {
+			rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wifi_wake_host_h: wifi-wake-host-h {
+			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1m0_pins>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2m0_pins>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	max-frequency = <100000000>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts b/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
new file mode 100644
index 000000000000..c6f4d9b683d8
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3528-rock-2.dtsi"
+
+/ {
+	model = "Radxa ROCK 2A";
+	compatible = "radxa,rock-2a", "rockchip,rk3528";
+
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
+	vcc5v0_usb30_otg: regulator-5v0-vcc-usb30-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_otg_en>;
+		regulator-name = "vcc5v0_usb30_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&vcc_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
+		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>;
+	status = "okay";
+};
+
+&leds {
+	pinctrl-names = "default";
+	pinctrl-0 = <&state_led_b>, <&sys_led_g>;
+
+	led-sys {
+		color = <LED_COLOR_ID_GREEN>;
+		default-state = "on";
+		function = LED_FUNCTION_STATUS;
+		gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_LOW>;
+		linux,default-trigger = "default-on";
+	};
+};
+
+&mdio1 {
+	rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac1_rstn_l>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	ethernet {
+		gmac1_rstn_l: gmac1-rstn-l {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		sys_led_g: sys-led-g {
+			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_otg_en: usb-otg-en {
+			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts b/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
new file mode 100644
index 000000000000..3e2b9b685cb2
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3528-rock-2.dtsi"
+
+/ {
+	model = "Radxa ROCK 2F";
+	compatible = "radxa,rock-2f", "rockchip,rk3528";
+};
-- 
2.49.0


