Return-Path: <linux-kernel+bounces-729760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0CB03B34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240431884448
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80A241674;
	Mon, 14 Jul 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RyM671SM"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD211DEFDD;
	Mon, 14 Jul 2025 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486285; cv=pass; b=nx36RfZldwtFFc8C1jLQkFedqbqLezNgySJ/HNC3TUiJUtNVl8X9tgkVZ7VNoUgl707z7lkY21pEdkWatqj7LLi+cmwZVOldfM3fssy9XhbdCy/RebqqJX68BFVbykXl6gRHXfRRkvoFJgeiTZ/vAT8Hj89Qp/lT8i9olABUJls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486285; c=relaxed/simple;
	bh=wFQpYHM/GkJMRBVMV6GaikrzPV8bXThWirQq2PNwXaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDk2twS7vJzw51VBll8cdeCA0PfjuUbV99XU24TwaqnMV69HrE9i9bEDTwPdSZMP5wOJ5SKuQ3Wv/9XHLX9KzRQdu9izDCBjGLxh+O71KvO0oZ9ePLn60u59iDqMuKioTg3asCfQ82mfDz3Y+axZw1ho5qHiL9b0pNf7jCqGVJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=RyM671SM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752486258; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M2L4TXjR7KQNBl5rGIiB4Nx5iAV+gGQD7cmn5iH1EPKt/AUfM/okjiYy32vFk9pAyZtCawaP/35+3c3zsdujBPxXruiAhZy2gJNORIECSOTjlnk3ALbuAbHla1XMrEqPzR4CYGRpJ5HmDl0H+I2tKe9uO/v+Om/tfMME3TuqZlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752486258; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DO37fHOFLEisAFzrUi5Kz1aAD1j8FS1kbeMRxgqRKjg=; 
	b=HqsKCLXJld6Um7urA4qghNLuQ37c5AaUXS1Oufv57Nni2eF/oehmwxT95LFeTLYDywp6KypiAKVH1rk7O9FR1XyAra4fMwCGqP4qdd+eFGgXX+SFisQRNgyyiyjUD2lgvhL3ougWpSRI1dN7uWT6oUaJ4M3b6BUAz0Y99tNDv+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752486257;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=DO37fHOFLEisAFzrUi5Kz1aAD1j8FS1kbeMRxgqRKjg=;
	b=RyM671SMHzGNdgWCCDr7RPIalxR8oy+Z0WS6C1ogvPtAAQ73ZP0tzObcYyBSxNj0
	7bTebWNVKqISFXyMrPYHrPvsIV0SmPTfy41GcUonGSF42PSsZoaL3Emo4sLl8dds50A
	on2fQj8/314xmmGwjNMqHXQvz/GjQmemmrO/zjIE=
Received: by mx.zohomail.com with SMTPS id 1752486256438692.7921624244486;
	Mon, 14 Jul 2025 02:44:16 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
Date: Mon, 14 Jul 2025 11:44:11 +0200
Message-ID: <7826308.EvYhyI6sBW@workhorse>
In-Reply-To: <20250712173805.584586-3-jonas@kwiboo.se>
References:
 <20250712173805.584586-1-jonas@kwiboo.se>
 <20250712173805.584586-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Jonas,

see comments in-line.

On Saturday, 12 July 2025 19:37:44 Central European Summer Time Jonas Karlman wrote:
> The ROCK 2A and ROCK 2F is a high-performance single board computer
> developed by Radxa, based on the Rockchip RK3528A SoC.
> 
> Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: Rename led nodes to led-0/led-1 (Chukun Pan)
> v2: Limit sdmmc max-frequency to 100 MHz (Yao Zi)
> 
> Schematics:
> - https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
> - https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 ++++++++++++++++++
>  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
>  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>  4 files changed, 387 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 099520962ffb..4cb6106b16f2 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -90,6 +90,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2f.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3562-evb2-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-d.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-s.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> new file mode 100644
> index 000000000000..aedc7ee9ee46
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> [...]
> +
> +&pinctrl {
> +	bluetooth {
> +		bt_wake_host_h: bt-wake-host-h {
> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		host_wake_bt_h: host-wake-bt-h {
> +			rockchip,pins = <1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		state_led_b: state-led-b {
> +			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdmmc {
> +		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		usb_host_en: usb-host-en {
> +			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		usb_wifi_pwr: usb-wifi-pwr {
> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wifi_reg_on_h: wifi-reg-on-h {
> +			rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;

I don't see an external pull-up or pull-down in the schematic. I'm not
sure what the recommended practice is; should we have a pull direction
set in the SoC's pin controller in these cases, or leave it floating?

> +		};
> +
> +		wifi_wake_host_h: wifi-wake-host-h {
> +			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm1m0_pins>;
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm2m0_pins>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <100000000>;

Any reason why we reduce this from the 150000000 in the SoC .dtsi?
Using the frequency the SoC .dtsi uses seems to work for me on the
ROCK 2A:

  [    0.347556] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
  [    0.547362] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
  [    0.814405] dwmmc_rockchip ffc30000.mmc: Successfully tuned phase to 248
  [    0.815407] mmc1: new UHS-I speed SDR104 SDXC card at address aaaa
  [    0.817030] mmcblk1: mmc1:aaaa SH64G 59.5 GiB
  [    0.820943]  mmcblk1: p1 p2

> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0m0_xfer>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts b/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> new file mode 100644
> index 000000000000..c03ae1dd3456
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> [...]
> +
> +&pinctrl {
> +	ethernet {
> +		gmac1_rstn_l: gmac1-rstn-l {
> +			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;

Same concern as with wifi-reg-on-h, there's no external pull resistor
in the schematic.

> +		};
> +	};
> +
> +	leds {
> +		sys_led_g: sys-led-g {
> +			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		usb_otg_en: usb-otg-en {
> +			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts b/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> new file mode 100644
> index 000000000000..3e2b9b685cb2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3528-rock-2.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK 2F";
> +	compatible = "radxa,rock-2f", "rockchip,rk3528";
> +};
> 

Other than the indicated comments,

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

ensured the pinctrls were correct, checked that they correspond to the
GPIOs being used in the devices associated with them. Also checked the
rock 2a schematic to verify that the vccio_sd switching setup is
correct, i.e. that high is indeed 3.3V and low is 1.8V.

And:

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

test-booted on a ROCK 2A, tested that SD card shows up, made sure
ethernet works as well, also ensured that the adc key works.



