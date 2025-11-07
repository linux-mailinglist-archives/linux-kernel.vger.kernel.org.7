Return-Path: <linux-kernel+bounces-890285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E46C3FB50
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF113A4901
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7421FF21;
	Fri,  7 Nov 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="hdPZP/Gu"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB5308F0C;
	Fri,  7 Nov 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514494; cv=none; b=o8FzSepWnsTB8xwIHJ7jX6a2vteGUaOlkDo+3hPMIUnfzshiDnoSTHkAxj48y2+N5UTqcOBZVk/VIrcwudUoOXX3fPL6TFbz8bR4gg2gJW+RX/U3SnPNY9dSESL4ReMg5ReuWPEeBKUG9IpEhGuof0AV+hg7XsIjC79hc+3Hsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514494; c=relaxed/simple;
	bh=9iK1e0arG5sk9dKhcZ8+y80Aim9yH795LPCQSsJ3ww4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3HMu1ujatCKaUxrv8MmcPvsdcvfX4VUE8QKabRuGXgTFYDjA5f+1Zuuq343fMXiQrkgfhSsJRCM2uxeEWTuFqEbZ3rzD7KfJkmtvTA+FunGtSUM1rTUPzZ4jDrlO7Q85KjvVadKARjHQTHHAoRtpWGcF7iVEX3Xzae1M0CN4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=hdPZP/Gu; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1762514457;
	bh=hUMRAdATsttLNlsrLVuPVviCKivZ9rxSuFousSL+h5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hdPZP/GuZAsk84iBtoepSHNV5pYJvfh3UMAq8iqGYnbTuKJYWq9bmo3zDmSLAZvLn
	 ASBPN7JUGpMEkWaRi2tDFEnUysaELSF+A21lpvp8WmEl+MaHf1x/QlFYSnQGyJ7swL
	 DXnt3h1FaSj4W4QmyGt9fH7sNXxOeoGtFcB4MA3ZBqLXsU+EpwN6pG96fHubnJ932O
	 lNQ/kI+R5kkvd4AoOuB1nHkM1JV39fOgEuVKe2VUQIS7TK0m0tABozwSkXRYyS0BeW
	 Zy2vKzrCUCpG4YBjboG0215JV0sPIAbgXyShB55MwiVHko75pYA96UrDZ73SzS2MQG
	 ecwzwQvwWrU9w==
Received: from [192.168.2.54] (unknown [143.105.119.212])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id BDC09B22046F;
	Fri,  7 Nov 2025 12:20:53 +0100 (CET)
Message-ID: <dba78080-682f-45d5-9403-bcead3c0eb11@freeshell.de>
Date: Fri, 7 Nov 2025 03:20:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] riscv: dts: starfive: Split jh7110-common.dtsi and
 move opp table to it
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <20251107095530.114775-5-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251107095530.114775-5-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 01:55, Hal Feng wrote:
> Preparing to add JH7110S based board device trees, move the content of
> jh7110-common.dtsi to the new file jh711x-common.dtsi and move opp table
> to jh7110-common.dtsi.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7110-common.dtsi      | 665 +-----------------
>  .../boot/dts/starfive/jh711x-common.dtsi      | 664 +++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh711x.dtsi      |  16 -
>  3 files changed, 678 insertions(+), 667 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh711x-common.dtsi
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 809274625615..dd5805ef70a1 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -5,660 +5,23 @@
>   */
>  
>  /dts-v1/;
> -#include "jh711x.dtsi"
> -#include "jh7110-pinfunc.h"
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
> +#include "jh711x-common.dtsi"
>  
> -/ {
> -	aliases {
> -		ethernet0 = &gmac0;
> -		i2c0 = &i2c0;
> -		i2c2 = &i2c2;
> -		i2c5 = &i2c5;
> -		i2c6 = &i2c6;
> -		mmc0 = &mmc0;
> -		mmc1 = &mmc1;
> -		serial0 = &uart0;
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
>  	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	memory@40000000 {
> -		device_type = "memory";
> -		reg = <0x0 0x40000000 0x1 0x0>;
> -		bootph-pre-ram;
> -	};
> -
> -	gpio-restart {
> -		compatible = "gpio-restart";
> -		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> -		priority = <224>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -
> -		led_status_power: led-0 {
> -			gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	pwmdac_codec: audio-codec {
> -		compatible = "linux,spdif-dit";
> -		#sound-dai-cells = <0>;
> -	};
> -
> -	sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		simple-audio-card,dai-link@0 {
> -			reg = <0>;
> -			format = "left_j";
> -			bitclock-master = <&sndcpu0>;
> -			frame-master = <&sndcpu0>;
> -
> -			sndcpu0: cpu {
> -				sound-dai = <&pwmdac>;
> -			};
> -
> -			codec {
> -				sound-dai = <&pwmdac_codec>;
> -			};
> -		};
> -	};
> -};
> -
> -&cpus {
> -	timebase-frequency = <4000000>;
> -};
> -
> -&dvp_clk {
> -	clock-frequency = <74250000>;
> -};
> -
> -&gmac0_rgmii_rxin {
> -	clock-frequency = <125000000>;
> -};
> -
> -&gmac0_rmii_refin {
> -	clock-frequency = <50000000>;
> -};
> -
> -&gmac1_rgmii_rxin {
> -	clock-frequency = <125000000>;
> -};
> -
> -&gmac1_rmii_refin {
> -	clock-frequency = <50000000>;
> -};
> -
> -&hdmitx0_pixelclk {
> -	clock-frequency = <297000000>;
> -};
> -
> -&i2srx_bclk_ext {
> -	clock-frequency = <12288000>;
> -};
> -
> -&i2srx_lrck_ext {
> -	clock-frequency = <192000>;
> -};
> -
> -&i2stx_bclk_ext {
> -	clock-frequency = <12288000>;
> -};
> -
> -&i2stx_lrck_ext {
> -	clock-frequency = <192000>;
> -};
> -
> -&mclk_ext {
> -	clock-frequency = <12288000>;
> -};
> -
> -&osc {
> -	clock-frequency = <24000000>;
> -};
> -
> -&rtc_osc {
> -	clock-frequency = <32768>;
> -};
> -
> -&tdm_ext {
> -	clock-frequency = <49152000>;
> -};
> -
> -&camss {
> -	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
> -			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
> -	assigned-clock-rates = <49500000>, <198000000>;
> -
> -	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> -		};
> -
> -		port@1 {
> -			reg = <1>;
> -
> -			camss_from_csi2rx: endpoint {
> -				remote-endpoint = <&csi2rx_to_camss>;
> -			};
> -		};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
>  	};
> -};
> -
> -&csi2rx {
> -	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
> -	assigned-clock-rates = <297000000>;
> -
> -	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> -
> -			/* remote MIPI sensor endpoint */
> -		};
> -
> -		port@1 {
> -			reg = <1>;
> -
> -			csi2rx_to_camss: endpoint {
> -				remote-endpoint = <&camss_from_csi2rx>;
> -			};
> -		};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
>  	};
> -};
> -
> -&gmac0 {
> -	phy-handle = <&phy0>;
> -	phy-mode = "rgmii-id";
> -
> -	mdio {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "snps,dwmac-mdio";
> -
> -		phy0: ethernet-phy@0 {
> -			reg = <0>;
> -		};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
>  	};
>  };
> -
> -&i2c0 {
> -	clock-frequency = <100000>;
> -	i2c-sda-hold-time-ns = <300>;
> -	i2c-sda-falling-time-ns = <510>;
> -	i2c-scl-falling-time-ns = <510>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0_pins>;
> -};
> -
> -&i2c2 {
> -	clock-frequency = <100000>;
> -	i2c-sda-hold-time-ns = <300>;
> -	i2c-sda-falling-time-ns = <510>;
> -	i2c-scl-falling-time-ns = <510>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c2_pins>;
> -	status = "okay";
> -};
> -
> -&i2c5 {
> -	clock-frequency = <100000>;
> -	i2c-sda-hold-time-ns = <300>;
> -	i2c-sda-falling-time-ns = <510>;
> -	i2c-scl-falling-time-ns = <510>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c5_pins>;
> -	status = "okay";
> -
> -	axp15060: pmic@36 {
> -		compatible = "x-powers,axp15060";
> -		reg = <0x36>;
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -
> -		regulators {
> -			vcc_3v3: dcdc1 {
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_3v3";
> -			};
> -
> -			vdd_cpu: dcdc2 {
> -				regulator-always-on;
> -				regulator-min-microvolt = <500000>;
> -				regulator-max-microvolt = <1540000>;
> -				regulator-name = "vdd_cpu";
> -			};
> -
> -			emmc_vdd: aldo4 {
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "emmc_vdd";
> -			};
> -		};
> -	};
> -
> -	eeprom@50 {
> -		compatible = "atmel,24c04";
> -		reg = <0x50>;
> -		bootph-pre-ram;
> -		pagesize = <16>;
> -	};
> -};
> -
> -&i2c6 {
> -	clock-frequency = <100000>;
> -	i2c-sda-hold-time-ns = <300>;
> -	i2c-sda-falling-time-ns = <510>;
> -	i2c-scl-falling-time-ns = <510>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c6_pins>;
> -	status = "okay";
> -};
> -
> -&mmc0 {
> -	max-frequency = <100000000>;
> -	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> -	assigned-clock-rates = <50000000>;
> -	bus-width = <8>;
> -	bootph-pre-ram;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	cap-mmc-hw-reset;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins>;
> -	vmmc-supply = <&vcc_3v3>;
> -	vqmmc-supply = <&emmc_vdd>;
> -	status = "okay";
> -};
> -
> -&mmc1 {
> -	max-frequency = <100000000>;
> -	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> -	assigned-clock-rates = <50000000>;
> -	bus-width = <4>;
> -	bootph-pre-ram;
> -	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	cap-sd-highspeed;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc1_pins>;
> -	status = "okay";
> -};
> -
> -&pcie0 {
> -	perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
> -	phys = <&pciephy0>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie0_pins>;
> -};
> -
> -&pcie1 {
> -	perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
> -	phys = <&pciephy1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie1_pins>;
> -};
> -
> -&pwmdac {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwmdac_pins>;
> -};
> -
> -&qspi {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	nor_flash: flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		bootph-pre-ram;
> -		cdns,read-delay = <2>;
> -		spi-max-frequency = <100000000>;
> -		cdns,tshsl-ns = <1>;
> -		cdns,tsd2d-ns = <1>;
> -		cdns,tchsh-ns = <1>;
> -		cdns,tslch-ns = <1>;
> -
> -		partitions {
> -			compatible = "fixed-partitions";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			spl@0 {
> -				reg = <0x0 0xf0000>;
> -			};
> -			uboot-env@f0000 {
> -				reg = <0xf0000 0x10000>;
> -			};
> -			uboot@100000 {
> -				reg = <0x100000 0xf00000>;
> -			};
> -		};
> -	};
> -};
> -
> -&pwm {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm_pins>;
> -};
> -
> -&spi0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi0_pins>;
> -};
> -
> -&syscrg {
> -	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> -			  <&syscrg JH7110_SYSCLK_QSPI_REF>,
> -			  <&syscrg JH7110_SYSCLK_CPU_CORE>,
> -			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
> -	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> -				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> -				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> -				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> -	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1500000000>;
> -};
> -
> -&sysgpio {
> -	i2c0_pins: i2c0-0 {
> -		i2c-pins {
> -			pinmux = <GPIOMUX(57, GPOUT_LOW,
> -					      GPOEN_SYS_I2C0_CLK,
> -					      GPI_SYS_I2C0_CLK)>,
> -				 <GPIOMUX(58, GPOUT_LOW,
> -					      GPOEN_SYS_I2C0_DATA,
> -					      GPI_SYS_I2C0_DATA)>;
> -			bias-disable; /* external pull-up */
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	i2c2_pins: i2c2-0 {
> -		i2c-pins {
> -			pinmux = <GPIOMUX(3, GPOUT_LOW,
> -					     GPOEN_SYS_I2C2_CLK,
> -					     GPI_SYS_I2C2_CLK)>,
> -				 <GPIOMUX(2, GPOUT_LOW,
> -					     GPOEN_SYS_I2C2_DATA,
> -					     GPI_SYS_I2C2_DATA)>;
> -			bias-disable; /* external pull-up */
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	i2c5_pins: i2c5-0 {
> -		bootph-pre-ram;
> -
> -		i2c-pins {
> -			pinmux = <GPIOMUX(19, GPOUT_LOW,
> -					      GPOEN_SYS_I2C5_CLK,
> -					      GPI_SYS_I2C5_CLK)>,
> -				 <GPIOMUX(20, GPOUT_LOW,
> -					      GPOEN_SYS_I2C5_DATA,
> -					      GPI_SYS_I2C5_DATA)>;
> -			bias-disable; /* external pull-up */
> -			bootph-pre-ram;
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	i2c6_pins: i2c6-0 {
> -		i2c-pins {
> -			pinmux = <GPIOMUX(16, GPOUT_LOW,
> -					      GPOEN_SYS_I2C6_CLK,
> -					      GPI_SYS_I2C6_CLK)>,
> -				 <GPIOMUX(17, GPOUT_LOW,
> -					      GPOEN_SYS_I2C6_DATA,
> -					      GPI_SYS_I2C6_DATA)>;
> -			bias-disable; /* external pull-up */
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -	};
> -
> -	mmc0_pins: mmc0-0 {
> -		mmc-pins {
> -			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
> -				 <PINMUX(PAD_SD0_CMD, 0)>,
> -				 <PINMUX(PAD_SD0_DATA0, 0)>,
> -				 <PINMUX(PAD_SD0_DATA1, 0)>,
> -				 <PINMUX(PAD_SD0_DATA2, 0)>,
> -				 <PINMUX(PAD_SD0_DATA3, 0)>,
> -				 <PINMUX(PAD_SD0_DATA4, 0)>,
> -				 <PINMUX(PAD_SD0_DATA5, 0)>,
> -				 <PINMUX(PAD_SD0_DATA6, 0)>,
> -				 <PINMUX(PAD_SD0_DATA7, 0)>;
> -			bias-pull-up;
> -			drive-strength = <12>;
> -			input-enable;
> -		};
> -	};
> -
> -	mmc1_pins: mmc1-0 {
> -		clk-pins {
> -			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength = <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
> -		mmc-pins {
> -			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
> -					     GPOEN_SYS_SDIO1_CMD,
> -					     GPI_SYS_SDIO1_CMD)>,
> -				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
> -					      GPOEN_SYS_SDIO1_DATA0,
> -					      GPI_SYS_SDIO1_DATA0)>,
> -				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
> -					      GPOEN_SYS_SDIO1_DATA1,
> -					      GPI_SYS_SDIO1_DATA1)>,
> -				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
> -					     GPOEN_SYS_SDIO1_DATA2,
> -					     GPI_SYS_SDIO1_DATA2)>,
> -				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
> -					     GPOEN_SYS_SDIO1_DATA3,
> -					     GPI_SYS_SDIO1_DATA3)>;
> -			bias-pull-up;
> -			drive-strength = <12>;
> -			input-enable;
> -			input-schmitt-enable;
> -			slew-rate = <0>;
> -		};
> -	};
> -
> -	pcie0_pins: pcie0-0 {
> -		clkreq-pins {
> -			pinmux = <GPIOMUX(27, GPOUT_LOW,
> -					      GPOEN_DISABLE,
> -					      GPI_NONE)>;
> -			bias-pull-down;
> -			drive-strength = <2>;
> -			input-enable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
> -		wake-pins {
> -			pinmux = <GPIOMUX(32, GPOUT_LOW,
> -					      GPOEN_DISABLE,
> -					      GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength = <2>;
> -			input-enable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -	};
> -
> -	pcie1_pins: pcie1-0 {
> -		clkreq-pins {
> -			pinmux = <GPIOMUX(29, GPOUT_LOW,
> -					      GPOEN_DISABLE,
> -					      GPI_NONE)>;
> -			bias-pull-down;
> -			drive-strength = <2>;
> -			input-enable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
> -		wake-pins {
> -			pinmux = <GPIOMUX(21, GPOUT_LOW,
> -				      GPOEN_DISABLE,
> -					      GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength = <2>;
> -			input-enable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -	};
> -
> -	pwmdac_pins: pwmdac-0 {
> -		pwmdac-pins {
> -			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>,
> -				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>;
> -			bias-disable;
> -			drive-strength = <2>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -	};
> -
> -	pwm_pins: pwm-0 {
> -		pwm-pins {
> -			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
> -					      GPOEN_SYS_PWM0_CHANNEL0,
> -					      GPI_NONE)>,
> -				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
> -					      GPOEN_SYS_PWM0_CHANNEL1,
> -					      GPI_NONE)>;
> -			bias-disable;
> -			drive-strength = <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -	};
> -
> -	spi0_pins: spi0-0 {
> -		mosi-pins {
> -			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>;
> -			bias-disable;
> -			input-disable;
> -			input-schmitt-disable;
> -		};
> -
> -		miso-pins {
> -			pinmux = <GPIOMUX(53, GPOUT_LOW,
> -					      GPOEN_DISABLE,
> -					      GPI_SYS_SPI0_RXD)>;
> -			bias-pull-up;
> -			input-enable;
> -			input-schmitt-enable;
> -		};
> -
> -		sck-pins {
> -			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
> -					      GPOEN_ENABLE,
> -					      GPI_SYS_SPI0_CLK)>;
> -			bias-disable;
> -			input-disable;
> -			input-schmitt-disable;
> -		};
> -
> -		ss-pins {
> -			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
> -					      GPOEN_ENABLE,
> -					      GPI_SYS_SPI0_FSS)>;
> -			bias-disable;
> -			input-disable;
> -			input-schmitt-disable;
> -		};
> -	};
> -
> -	uart0_pins: uart0-0 {
> -		tx-pins {
> -			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> -					     GPOEN_ENABLE,
> -					     GPI_NONE)>;
> -			bias-disable;
> -			drive-strength = <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
> -		rx-pins {
> -			pinmux = <GPIOMUX(6, GPOUT_LOW,
> -					     GPOEN_DISABLE,
> -					     GPI_SYS_UART0_RX)>;
> -			bias-disable; /* external pull-up */
> -			drive-strength = <2>;
> -			input-enable;
> -			input-schmitt-enable;
> -			slew-rate = <0>;
> -		};
> -	};
> -};
> -
> -&uart0 {
> -	bootph-pre-ram;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_pins>;
> -	status = "okay";
> -};
> -
> -&U74_1 {
> -	cpu-supply = <&vdd_cpu>;
> -};
> -
> -&U74_2 {
> -	cpu-supply = <&vdd_cpu>;
> -};
> -
> -&U74_3 {
> -	cpu-supply = <&vdd_cpu>;
> -};
> -
> -&U74_4 {
> -	cpu-supply = <&vdd_cpu>;
> -};
> diff --git a/arch/riscv/boot/dts/starfive/jh711x-common.dtsi b/arch/riscv/boot/dts/starfive/jh711x-common.dtsi
> new file mode 100644
> index 000000000000..809274625615
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh711x-common.dtsi
> @@ -0,0 +1,664 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh711x.dtsi"
> +#include "jh7110-pinfunc.h"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
> +
> +/ {
> +	aliases {
> +		ethernet0 = &gmac0;
> +		i2c0 = &i2c0;
> +		i2c2 = &i2c2;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x1 0x0>;
> +		bootph-pre-ram;
> +	};
> +
> +	gpio-restart {
> +		compatible = "gpio-restart";
> +		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> +		priority = <224>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led_status_power: led-0 {
> +			gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	pwmdac_codec: audio-codec {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		simple-audio-card,dai-link@0 {
> +			reg = <0>;
> +			format = "left_j";
> +			bitclock-master = <&sndcpu0>;
> +			frame-master = <&sndcpu0>;
> +
> +			sndcpu0: cpu {
> +				sound-dai = <&pwmdac>;
> +			};
> +
> +			codec {
> +				sound-dai = <&pwmdac_codec>;
> +			};
> +		};
> +	};
> +};
> +
> +&cpus {
> +	timebase-frequency = <4000000>;
> +};
> +
> +&dvp_clk {
> +	clock-frequency = <74250000>;
> +};
> +
> +&gmac0_rgmii_rxin {
> +	clock-frequency = <125000000>;
> +};
> +
> +&gmac0_rmii_refin {
> +	clock-frequency = <50000000>;
> +};
> +
> +&gmac1_rgmii_rxin {
> +	clock-frequency = <125000000>;
> +};
> +
> +&gmac1_rmii_refin {
> +	clock-frequency = <50000000>;
> +};
> +
> +&hdmitx0_pixelclk {
> +	clock-frequency = <297000000>;
> +};
> +
> +&i2srx_bclk_ext {
> +	clock-frequency = <12288000>;
> +};
> +
> +&i2srx_lrck_ext {
> +	clock-frequency = <192000>;
> +};
> +
> +&i2stx_bclk_ext {
> +	clock-frequency = <12288000>;
> +};
> +
> +&i2stx_lrck_ext {
> +	clock-frequency = <192000>;
> +};
> +
> +&mclk_ext {
> +	clock-frequency = <12288000>;
> +};
> +
> +&osc {
> +	clock-frequency = <24000000>;
> +};
> +
> +&rtc_osc {
> +	clock-frequency = <32768>;
> +};
> +
> +&tdm_ext {
> +	clock-frequency = <49152000>;
> +};
> +
> +&camss {
> +	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
> +			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
> +	assigned-clock-rates = <49500000>, <198000000>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			camss_from_csi2rx: endpoint {
> +				remote-endpoint = <&csi2rx_to_camss>;
> +			};
> +		};
> +	};
> +};
> +
> +&csi2rx {
> +	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
> +	assigned-clock-rates = <297000000>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			/* remote MIPI sensor endpoint */
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			csi2rx_to_camss: endpoint {
> +				remote-endpoint = <&camss_from_csi2rx>;
> +			};
> +		};
> +	};
> +};
> +
> +&gmac0 {
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +
> +		phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	i2c-sda-hold-time-ns = <300>;
> +	i2c-sda-falling-time-ns = <510>;
> +	i2c-scl-falling-time-ns = <510>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	i2c-sda-hold-time-ns = <300>;
> +	i2c-sda-falling-time-ns = <510>;
> +	i2c-scl-falling-time-ns = <510>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	clock-frequency = <100000>;
> +	i2c-sda-hold-time-ns = <300>;
> +	i2c-sda-falling-time-ns = <510>;
> +	i2c-scl-falling-time-ns = <510>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +	status = "okay";
> +
> +	axp15060: pmic@36 {
> +		compatible = "x-powers,axp15060";
> +		reg = <0x36>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		regulators {
> +			vcc_3v3: dcdc1 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc_3v3";
> +			};
> +
> +			vdd_cpu: dcdc2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1540000>;
> +				regulator-name = "vdd_cpu";
> +			};
> +
> +			emmc_vdd: aldo4 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "emmc_vdd";
> +			};
> +		};
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c04";
> +		reg = <0x50>;
> +		bootph-pre-ram;
> +		pagesize = <16>;
> +	};
> +};
> +
> +&i2c6 {
> +	clock-frequency = <100000>;
> +	i2c-sda-hold-time-ns = <300>;
> +	i2c-sda-falling-time-ns = <510>;
> +	i2c-scl-falling-time-ns = <510>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pins>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +	assigned-clock-rates = <50000000>;
> +	bus-width = <8>;
> +	bootph-pre-ram;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	cap-mmc-hw-reset;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +	assigned-clock-rates = <50000000>;
> +	bus-width = <4>;
> +	bootph-pre-ram;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
> +	phys = <&pciephy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_pins>;
> +};
> +
> +&pcie1 {
> +	perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
> +	phys = <&pciephy1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_pins>;
> +};
> +
> +&pwmdac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwmdac_pins>;
> +};
> +
> +&qspi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	nor_flash: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		bootph-pre-ram;
> +		cdns,read-delay = <2>;
> +		spi-max-frequency = <100000000>;
> +		cdns,tshsl-ns = <1>;
> +		cdns,tsd2d-ns = <1>;
> +		cdns,tchsh-ns = <1>;
> +		cdns,tslch-ns = <1>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			spl@0 {
> +				reg = <0x0 0xf0000>;
> +			};
> +			uboot-env@f0000 {
> +				reg = <0xf0000 0x10000>;
> +			};
> +			uboot@100000 {
> +				reg = <0x100000 0xf00000>;
> +			};
> +		};
> +	};
> +};
> +
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pins>;
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>;
> +};
> +
> +&syscrg {
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> +			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> +			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> +			  <&syscrg JH7110_SYSCLK_QSPI_REF>,
> +			  <&syscrg JH7110_SYSCLK_CPU_CORE>,
> +			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
> +	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> +				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> +	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1500000000>;
> +};
> +
> +&sysgpio {
> +	i2c0_pins: i2c0-0 {
> +		i2c-pins {
> +			pinmux = <GPIOMUX(57, GPOUT_LOW,
> +					      GPOEN_SYS_I2C0_CLK,
> +					      GPI_SYS_I2C0_CLK)>,
> +				 <GPIOMUX(58, GPOUT_LOW,
> +					      GPOEN_SYS_I2C0_DATA,
> +					      GPI_SYS_I2C0_DATA)>;
> +			bias-disable; /* external pull-up */
> +			input-enable;
> +			input-schmitt-enable;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-0 {
> +		i2c-pins {
> +			pinmux = <GPIOMUX(3, GPOUT_LOW,
> +					     GPOEN_SYS_I2C2_CLK,
> +					     GPI_SYS_I2C2_CLK)>,
> +				 <GPIOMUX(2, GPOUT_LOW,
> +					     GPOEN_SYS_I2C2_DATA,
> +					     GPI_SYS_I2C2_DATA)>;
> +			bias-disable; /* external pull-up */
> +			input-enable;
> +			input-schmitt-enable;
> +		};
> +	};
> +
> +	i2c5_pins: i2c5-0 {
> +		bootph-pre-ram;
> +
> +		i2c-pins {
> +			pinmux = <GPIOMUX(19, GPOUT_LOW,
> +					      GPOEN_SYS_I2C5_CLK,
> +					      GPI_SYS_I2C5_CLK)>,
> +				 <GPIOMUX(20, GPOUT_LOW,
> +					      GPOEN_SYS_I2C5_DATA,
> +					      GPI_SYS_I2C5_DATA)>;
> +			bias-disable; /* external pull-up */
> +			bootph-pre-ram;
> +			input-enable;
> +			input-schmitt-enable;
> +		};
> +	};
> +
> +	i2c6_pins: i2c6-0 {
> +		i2c-pins {
> +			pinmux = <GPIOMUX(16, GPOUT_LOW,
> +					      GPOEN_SYS_I2C6_CLK,
> +					      GPI_SYS_I2C6_CLK)>,
> +				 <GPIOMUX(17, GPOUT_LOW,
> +					      GPOEN_SYS_I2C6_DATA,
> +					      GPI_SYS_I2C6_DATA)>;
> +			bias-disable; /* external pull-up */
> +			input-enable;
> +			input-schmitt-enable;
> +		};
> +	};
> +
> +	mmc0_pins: mmc0-0 {
> +		mmc-pins {
> +			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
> +				 <PINMUX(PAD_SD0_CMD, 0)>,
> +				 <PINMUX(PAD_SD0_DATA0, 0)>,
> +				 <PINMUX(PAD_SD0_DATA1, 0)>,
> +				 <PINMUX(PAD_SD0_DATA2, 0)>,
> +				 <PINMUX(PAD_SD0_DATA3, 0)>,
> +				 <PINMUX(PAD_SD0_DATA4, 0)>,
> +				 <PINMUX(PAD_SD0_DATA5, 0)>,
> +				 <PINMUX(PAD_SD0_DATA6, 0)>,
> +				 <PINMUX(PAD_SD0_DATA7, 0)>;
> +			bias-pull-up;
> +			drive-strength = <12>;
> +			input-enable;
> +		};
> +	};
> +
> +	mmc1_pins: mmc1-0 {
> +		clk-pins {
> +			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		mmc-pins {
> +			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
> +					     GPOEN_SYS_SDIO1_CMD,
> +					     GPI_SYS_SDIO1_CMD)>,
> +				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
> +					      GPOEN_SYS_SDIO1_DATA0,
> +					      GPI_SYS_SDIO1_DATA0)>,
> +				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
> +					      GPOEN_SYS_SDIO1_DATA1,
> +					      GPI_SYS_SDIO1_DATA1)>,
> +				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
> +					     GPOEN_SYS_SDIO1_DATA2,
> +					     GPI_SYS_SDIO1_DATA2)>,
> +				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
> +					     GPOEN_SYS_SDIO1_DATA3,
> +					     GPI_SYS_SDIO1_DATA3)>;
> +			bias-pull-up;
> +			drive-strength = <12>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pcie0_pins: pcie0-0 {
> +		clkreq-pins {
> +			pinmux = <GPIOMUX(27, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-down;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		wake-pins {
> +			pinmux = <GPIOMUX(32, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pcie1_pins: pcie1-0 {
> +		clkreq-pins {
> +			pinmux = <GPIOMUX(29, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-down;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		wake-pins {
> +			pinmux = <GPIOMUX(21, GPOUT_LOW,
> +				      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwmdac_pins: pwmdac-0 {
> +		pwmdac-pins {
> +			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>,
> +				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <2>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm_pins: pwm-0 {
> +		pwm-pins {
> +			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
> +					      GPOEN_SYS_PWM0_CHANNEL0,
> +					      GPI_NONE)>,
> +				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
> +					      GPOEN_SYS_PWM0_CHANNEL1,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	spi0_pins: spi0-0 {
> +		mosi-pins {
> +			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +		};
> +
> +		miso-pins {
> +			pinmux = <GPIOMUX(53, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_SPI0_RXD)>;
> +			bias-pull-up;
> +			input-enable;
> +			input-schmitt-enable;
> +		};
> +
> +		sck-pins {
> +			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
> +					      GPOEN_ENABLE,
> +					      GPI_SYS_SPI0_CLK)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +		};
> +
> +		ss-pins {
> +			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
> +					      GPOEN_ENABLE,
> +					      GPI_SYS_SPI0_FSS)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	uart0_pins: uart0-0 {
> +		tx-pins {
> +			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> +					     GPOEN_ENABLE,
> +					     GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <12>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pinmux = <GPIOMUX(6, GPOUT_LOW,
> +					     GPOEN_DISABLE,
> +					     GPI_SYS_UART0_RX)>;
> +			bias-disable; /* external pull-up */
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	bootph-pre-ram;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +	status = "okay";
> +};
> +
> +&U74_1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&U74_2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&U74_3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&U74_4 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh711x.dtsi b/arch/riscv/boot/dts/starfive/jh711x.dtsi
> index 6e56e9d20bb0..a380d3dabedd 100644
> --- a/arch/riscv/boot/dts/starfive/jh711x.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh711x.dtsi
> @@ -205,22 +205,6 @@ core4 {
>  	cpu_opp: opp-table-0 {
>  			compatible = "operating-points-v2";
>  			opp-shared;
> -			opp-375000000 {
> -					opp-hz = /bits/ 64 <375000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-500000000 {
> -					opp-hz = /bits/ 64 <500000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-750000000 {
> -					opp-hz = /bits/ 64 <750000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-1500000000 {
> -					opp-hz = /bits/ 64 <1500000000>;
> -					opp-microvolt = <1040000>;
> -			};
>  	};
>  
>  	thermal-zones {

Reviewed-by: E Shattow <e@freeshell.de>

