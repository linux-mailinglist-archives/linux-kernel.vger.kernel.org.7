Return-Path: <linux-kernel+bounces-793161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BC3B3CF6C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 23:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63819201324
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B232E716A;
	Sat, 30 Aug 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="DTd3/d89"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91F274669;
	Sat, 30 Aug 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756588454; cv=none; b=BSASkqQp9qBDQygUXY/y88A/SlsG2SwuubaCoJgwGQoM/5OizuSXOz1aGdv/KXuBj4/60p02eCdfdCTxcznKRAs9IMNqLSjsg4pJzT2Z57tJj6Vv9D2t4tqBrnhnUjudIPpJ35Zv/0t/OBLwjLiHNxDwAb+uSR7g5ESeZx2yTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756588454; c=relaxed/simple;
	bh=bSn4qvQ0C6MPakUmA/YdjqPZfRaTfiOS8KJAyPms1J4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImvqXY1oACo9KThbzdOnbJdLeSQ+h4L8lpoZamksGAxYEtreUgFEpLCumBqoZd8+1QmGG2CkfcrHW8eyvwtmQr0sxEv1vjlkenTzYg9e4/r9mDCmdeJ18vAzTui0GrxRJB1HYvc4n20+t5MUiMertDRKbWqhKOQEjMpSBzJnRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=DTd3/d89; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756588450;
	bh=bSn4qvQ0C6MPakUmA/YdjqPZfRaTfiOS8KJAyPms1J4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DTd3/d891FOSd8j/m6pZvG0OCkIgJH3hoNWubz3vHU+IZ8hys79RXcWrIEMCLboqW
	 jpbYkkMtbOy4SSJOPAHEFqM5kNoa/7kSn9n2oFR6f4bfGtRkOD17NLqZRQ3Iq4TbV5
	 3iG1H2lHaiV0rs2ZVPudp56o/1dpRY9JU+KFqSXHR8s9nRThRzA0t9xXjnVB9SrYgZ
	 L76+cTSUa73G38/89dfryy6oG/DfmNa6c/c9L0rqNrwkKpHvtsNVbl5lFDlV/PVQE4
	 OJ0ySsaDIqz9wI1qTy3fK8d84332bXF/uoYC4+bec5+1Z9ma79RuSVjEpkI0cQQqjM
	 US9T2RHuJ2znQ==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50be:5a04:7b87:89ea:8410:bae3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 631A027E476;
	Sat, 30 Aug 2025 21:14:10 +0000 (UTC)
Date: Sat, 30 Aug 2025 17:14:09 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <20250830171409.592c1f63.xunil@tahomasoft.com>
In-Reply-To: <20250818100009.170202-4-amadeus@jmu.edu.cn>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
	<20250818100009.170202-4-amadeus@jmu.edu.cn>
Organization: Tahoma Soft
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 18:00:08 +0800
Chukun Pan <amadeus@jmu.edu.cn> wrote:

> The HINLINK H68K is a development board with the
> Rockchip RK3568 SoC. It has the following features:
> 
> - 2/4GB LPDDR4
> - 1x HDMI Type A
> - 3.5mm jack with mic
> - 1x PCIE 2.0 WiFi slot
> - 1x USB 3.0, 2x USB 2.0
> - 2x 1GbE RTL8211F Ethernet
> - 2x 2.5GbE RTL8125B Ethernet
> - MicroSD card slot / eMMC 32GB
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3568-hinlink-h68k.dts |  83 +++
>  .../boot/dts/rockchip/rk3568-hinlink-opc.dtsi | 666 ++++++++++++++++++
>  3 files changed, 750 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-h68k.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-hinlink-opc.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> b/arch/arm64/boot/dts/rockchip/Makefile index 099520962ffb..09c810cb64a4
> 100644 --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -130,6 +130,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r68s.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-hinlink-h68k.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-mecsbc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-hinlink-h68k.dts
> b/arch/arm64/boot/dts/rockchip/rk3568-hinlink-h68k.dts new file mode 100644
> index 000000000000..793ee651b868
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-hinlink-h68k.dts
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3568-hinlink-opc.dtsi"
> +
> +/ {
> +	model = "HINLINK H68K";
> +	compatible = "hinlink,h68k", "rockchip,rk3568";
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +};
> +
> +&gmac0 {
> +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> +	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy0>;
> +	phy-mode = "rgmii-id";

Please change phy-mode here to "rgmii". This change will yield an ethernet
speed throughput change of a factor of 100+. 

> +	phy-supply = <&vcc3v3_sys>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus
> +		     &gmac0_rstn>;
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";

Same as above: Please change phy-mode here to "rgmii". This change will yield
an ethernet speed throughput change of a factor of 100+. 

> +	phy-supply = <&vcc3v3_sys>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_rgmii_bus
> +		     &gmac1_rstn>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	rgmii_phy0: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pinctrl {
> +	gmac {
> +		gmac0_rstn: gmac0-rstn {
> +			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +
> +		gmac1_rstn: gmac1-rstn {
> +			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-hinlink-opc.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3568-hinlink-opc.dtsi new file mode 100644
> index 000000000000..14f3839ca091
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-hinlink-opc.dtsi
> @@ -0,0 +1,666 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3568.dtsi"
> +
> +/ {
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	ir-receiver {
> +		compatible = "gpio-ir-receiver";
> +		gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm3_ir_m0>;
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&factory>;
> +
> +		button-factory {
> +			label = "factory";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <50>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&green_led>, <&red_led>, <&work_led>;
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_WAN;
> +			gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "netdev";
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_DISK;
> +			gpios = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +	};
> +
> +	vcc0v9_2g5: regulator-0v9-vcc-2g5 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc0v9_2g5";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc12v_dcinp: regulator-12v-vcc-dcinp {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcinp";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc3v3_pi6c_05: regulator-3v3-vcc-pi6c-05 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lan_power_en>;
> +		regulator-name = "vcc3v3_pi6c_05";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_sd: regulator-3v3-vcc-sd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd_pwren>;
> +		regulator-name = "vcc3v3_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc3v3_sys: regulator-3v3-vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: regulator-5v0-vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcinp>;
> +	};
> +
> +	vcc5v0_usb30_otg0: regulator-5v0-vcc-usb30-otg0 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_power_en>;
> +		regulator-name = "vcc5v0_usb30_otg0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +};
> +
> +&combphy0 {
> +	status = "okay";
> +};
> +
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda0v9_image>;
> +	avdd-1v8-supply = <&vcca1v8_image>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		#clock-cells = <1>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>;
> +		system-power-controller;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name = "vdd_logic";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-name = "vdd_gpu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-name = "vdd_npu";
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
> +				regulator-name = "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-name = "vdda0v9_image";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-name = "vdda_0v9";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-name = "vdda0v9_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =
> <900000>;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-name = "vccio_acodec";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =
> <3300000>;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG7 {
> +				regulator-name = "vcca_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG8 {
> +				regulator-name = "vcca1v8_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =
> <1800000>;
> +				};
> +			};
> +
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-name = "vcca1v8_image";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-name = "vcc_3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3: SWITCH_REG2 {
> +				regulator-name = "vcc3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2m1_xfer>;
> +	status = "okay";
> +};
> +
> +&i2s0_8ch {
> +	status = "okay";
> +};
> +
> +&pcie2x1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wifi_perstn>;
> +	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pi6c_05>;
> +	status = "okay";
> +};
> +
> +&pcie30phy {
> +	data-lanes = <1 2>;
> +	status = "okay";
> +};
> +
> +&pcie3x1 {
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lan_resetb>;
> +	reset-gpios = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pi6c_05>;
> +	status = "okay";
> +};
> +
> +&pcie3x2 {
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lan_reseta>;
> +	reset-gpios = <&gpio2 RK_PD0 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pi6c_05>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	keys {
> +		factory: factory {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO
> &pcfg_pull_up>;
> +		};
> +	};
> +
> +	leds {
> +		green_led: green-led {
> +			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +
> +		red_led: red-led {
> +			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +
> +		work_led: work-led {
> +			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +	};
> +
> +	ir {
> +		pwm3_ir_m0: pwm3-ir-m0 {
> +			rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +	};
> +
> +	mmc {
> +		sd_pwren: sd-pwren {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		lan_power_en: lan-power-en {
> +			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +
> +		lan_reseta: lan-reseta {
> +			rockchip,pins = <2 RK_PD0 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +
> +		lan_resetb: lan-resetb {
> +			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +
> +		wifi_perstn: wifi-perstn {
> +			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic-int {
> +			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO
> &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		usb_power_en: usb-power-en {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO
> &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio2-supply = <&vcc_1v8>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_1v8>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pwm0 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8>;
> +	status = "okay";
> +};
> +
> +/* Via Type-C adapter */
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	max-frequency = <200000000>;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +	sd-uhs-sdr50;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	status = "okay";
> +};
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +&usb2phy0_host {
> +	phy-supply = <&vcc5v0_usb30_otg0>;
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	status = "okay";
> +};
> +
> +&usb2phy1_host {
> +	phy-supply = <&vcc5v0_usb30_otg0>;
> +	status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +	phy-supply = <&vcc5v0_usb30_otg0>;
> +	status = "okay";
> +};
> +
> +&vop {
> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi_in_vp0>;
> +	};
> +};


