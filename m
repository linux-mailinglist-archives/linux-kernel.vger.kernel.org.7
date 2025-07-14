Return-Path: <linux-kernel+bounces-729893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650CFB03D14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA36A16D987
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BD24501B;
	Mon, 14 Jul 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ERDEhpx8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5419AD48;
	Mon, 14 Jul 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491731; cv=pass; b=Agmef6mtVOxbboZHy5F5+yF9r1RpCd7nDN9KI7WK7yyZIsA5JqswpTi2dpDaYhXLcFSSeD8Ymuvj5ouTYsxI8NFpuD+/grmPr8kCTK0QUoi4lm74e9C7CxjyfLmCWtrsZrdIX+zOIyME6I4ed3PE2WbwCbHMuiHfeRZupqtcq9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491731; c=relaxed/simple;
	bh=Mx1KoyIL7gUVDbcDVP2WsZQB5r9wnwIsiXlxlLMLSQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ig2q6o1Noam7H/nM79Adtjs35niCAeTIooBWC1P0xMOQIqD9QwgR8eHrVj2ftDiTDLn2PPTQ1Kec+iFTd02EuJaWWjtkH3ym/217XD21NpZGrknbkvXd7afl1P9VJw3OcKVib712FFCeEODd0CEkhl3vQAJKOdfDWeg2DSafmdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ERDEhpx8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752491708; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ibsPL+Yzf77mSlY7Lf1egFE2iTkwDtHU6GT2qNDcj7XWUlyxhIcv1NVNVAQCGvWKZTa7xWB4+DuykKUYvIspil6K3CghdmSgYR9ilY8BywL5bGc8DOzuD2zdBXBLM6IuSZf9K85NWIu9g2gr0JqC5s3AuQxr6bavXjPVzKkjNrg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752491708; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PXtC+Ido9YgtHxLvcR+egm84Hyw0TuokS2ZdVegZyNI=; 
	b=GBWyE6UeZ+RMC1M8QkdgITsjQLqOhr0iUUP0Sh4VDow6/JwVbfennNxp9wqpkBvQP+5YNNOycH1+2Zs0He9Kf+8864vT4dZkM5tNT7xwIBH6AxKkNFESLqFJN9ZMg2jmVtRitGJNVn7rAZeZYb/kKWZvWfrJpTfj9Gms4TY2GJQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752491708;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=PXtC+Ido9YgtHxLvcR+egm84Hyw0TuokS2ZdVegZyNI=;
	b=ERDEhpx8linIT39t7UxCNawgqgt40n96Iw5HQkSwLUoOxFLi5Ab/HLgEDU+iYgXp
	t966lIBjCiVkRAT+H9mwTTWUpOUBiEq64aFN0M2vuCHMoPhJJ4tkXMrPgzuB2u+qfrl
	w+gVnx5JYUFFRqK0yG+H3HzErm0afCh140k83uf4=
Received: by mx.zohomail.com with SMTPS id 175249170629941.44373789408917;
	Mon, 14 Jul 2025 04:15:06 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-rockchip@lists.infradead.org, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
Date: Mon, 14 Jul 2025 13:15:01 +0200
Message-ID: <6066694.MhkbZ0Pkbq@workhorse>
In-Reply-To: <54a76b31-5f69-4004-a030-0096a18a0de4@kwiboo.se>
References:
 <20250712173805.584586-1-jonas@kwiboo.se> <7826308.EvYhyI6sBW@workhorse>
 <54a76b31-5f69-4004-a030-0096a18a0de4@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Jonas,

On Monday, 14 July 2025 12:49:24 Central European Summer Time Jonas Karlman wrote:
> Hi Nicolas,
> 
> On 7/14/2025 11:44 AM, Nicolas Frattaroli wrote:
> > Hi Jonas,
> > 
> > see comments in-line.
> > 
> > On Saturday, 12 July 2025 19:37:44 Central European Summer Time Jonas Karlman wrote:
> >> The ROCK 2A and ROCK 2F is a high-performance single board computer
> >> developed by Radxa, based on the Rockchip RK3528A SoC.
> >>
> >> Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >> v3: Rename led nodes to led-0/led-1 (Chukun Pan)
> >> v2: Limit sdmmc max-frequency to 100 MHz (Yao Zi)
> >>
> >> Schematics:
> >> - https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
> >> - https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
> >> ---
> >>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
> >>  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 ++++++++++++++++++
> >>  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
> >>  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
> >>  4 files changed, 387 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> >> index 099520962ffb..4cb6106b16f2 100644
> >> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >> @@ -90,6 +90,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
> >> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2a.dtb
> >> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2f.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3562-evb2-v10.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-d.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-s.dtb
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> >> new file mode 100644
> >> index 000000000000..aedc7ee9ee46
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> >> [...]
> >> +
> >> +&pinctrl {
> >> +	bluetooth {
> >> +		bt_wake_host_h: bt-wake-host-h {
> >> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> >> +		};
> >> +
> >> +		host_wake_bt_h: host-wake-bt-h {
> >> +			rockchip,pins = <1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +	};
> >> +
> >> +	leds {
> >> +		state_led_b: state-led-b {
> >> +			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +	};
> >> +
> >> +	sdmmc {
> >> +		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
> >> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +	};
> >> +
> >> +	usb {
> >> +		usb_host_en: usb-host-en {
> >> +			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +	};
> >> +
> >> +	wifi {
> >> +		usb_wifi_pwr: usb-wifi-pwr {
> >> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +
> >> +		wifi_reg_on_h: wifi-reg-on-h {
> >> +			rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> > 
> > I don't see an external pull-up or pull-down in the schematic. I'm not
> > sure what the recommended practice is; should we have a pull direction
> > set in the SoC's pin controller in these cases, or leave it floating?
> 
> This is at least what I have done for gpio output pins in the past, see
> other defines for a wifi_reg_on_h in tree.
> 
> My (possible wrong) reasoning is that this pin is used as a gpio output
> pin and the output value should determin high/low. For this perticiular
> board the wifi_reg_on_h pin is referenced as shutdown-gpios in the
> rfkill-gpio node, so when this is initialized the output value should be
> set high/low and the internal pull value no longer has a real purpose.
> 
> Please correct me if my reasoning is wrong :-)

Your explanation makes sense to me. I don't know which way is the right
way, but I assume setting pulls does indeed not do much because any
effect they'd have would already be way too late in the power cycle.

> 
> > 
> >> +		};
> >> +
> >> +		wifi_wake_host_h: wifi-wake-host-h {
> >> +			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&pwm1 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pwm1m0_pins>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&pwm2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pwm2m0_pins>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&saradc {
> >> +	vref-supply = <&vcc_1v8>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sdhci {
> >> +	bus-width = <8>;
> >> +	cap-mmc-highspeed;
> >> +	mmc-hs200-1_8v;
> >> +	no-sd;
> >> +	no-sdio;
> >> +	non-removable;
> >> +	vmmc-supply = <&vcc_3v3>;
> >> +	vqmmc-supply = <&vcc_1v8>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&sdmmc {
> >> +	bus-width = <4>;
> >> +	cap-mmc-highspeed;
> >> +	cap-sd-highspeed;
> >> +	disable-wp;
> >> +	max-frequency = <100000000>;
> > 
> > Any reason why we reduce this from the 150000000 in the SoC .dtsi?
> 
> Please see v1 of this series, Yao Zi reported issues when 150 MHz was
> usued with a SD-card that works with 150 MHz on the Radxa E20C.
> 
> Vendor kernel seem to change drive strenght of clk pin, but that did not
> improve the situation, so I changed it to use a lower rate for now.

Oops, thanks for pointing this out. Yeah, that makes sense to me then.

> 
> > Using the frequency the SoC .dtsi uses seems to work for me on the
> > ROCK 2A:
> > 
> >   [    0.347556] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> >   [    0.547362] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> >   [    0.814405] dwmmc_rockchip ffc30000.mmc: Successfully tuned phase to 248
> >   [    0.815407] mmc1: new UHS-I speed SDR104 SDXC card at address aaaa
> >   [    0.817030] mmcblk1: mmc1:aaaa SH64G 59.5 GiB
> >   [    0.820943]  mmcblk1: p1 p2
> 
> Using 150 MHz also worked with my 2A/3F boards and the two SD-cards I
> could test.
> 
> > 
> >> +	sd-uhs-sdr104;
> >> +	vmmc-supply = <&vcc_3v3>;
> >> +	vqmmc-supply = <&vccio_sd>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&uart0 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart0m0_xfer>;
> >> +	status = "okay";
> >> +};
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts b/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> >> new file mode 100644
> >> index 000000000000..c03ae1dd3456
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> >> [...]
> >> +
> >> +&pinctrl {
> >> +	ethernet {
> >> +		gmac1_rstn_l: gmac1-rstn-l {
> >> +			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> > 
> > Same concern as with wifi-reg-on-h, there's no external pull resistor
> > in the schematic.
> 
> Same resoning as above, this pin is used as the Ethernet PHY reset-gpios
> pin. Here the bootloader (U-Boot) will also configure this pin with a
> gpio output value to trigger a PHY reset.
> 
> I can change these to pull-down as that seem to be the reset value for
> these two pins, if I understand the schematic and PinOut correctly, if
> you have a strong opinion on that these defines are wrong.

I don't feel strongly about the pinctrl at all, I think your explanation
that U-Boot got there before us puts a nail in the coffin of whether
they should be set at all; if anything, we'd probably make the device
even less happy by needlessly toggling the reset again with a pull
before it then gets toggled again by the Linux driver.

Everything looks good to me with those questions of mine cleared up,
thanks for working on this!

Kind regards,
Nicolas Frattaroli

> 
> Regards,
> Jonas
> 
> > 
> >> +		};
> >> +	};
> >> +
> >> +	leds {
> >> +		sys_led_g: sys-led-g {
> >> +			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +	};
> >> +
> >> +	usb {
> >> +		usb_otg_en: usb-otg-en {
> >> +			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +	};
> >> +};
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts b/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> >> new file mode 100644
> >> index 000000000000..3e2b9b685cb2
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> >> @@ -0,0 +1,10 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "rk3528-rock-2.dtsi"
> >> +
> >> +/ {
> >> +	model = "Radxa ROCK 2F";
> >> +	compatible = "radxa,rock-2f", "rockchip,rk3528";
> >> +};
> >>
> > 
> > Other than the indicated comments,
> > 
> > Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> > ensured the pinctrls were correct, checked that they correspond to the
> > GPIOs being used in the devices associated with them. Also checked the
> > rock 2a schematic to verify that the vccio_sd switching setup is
> > correct, i.e. that high is indeed 3.3V and low is 1.8V.
> > 
> > And:
> > 
> > Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> > test-booted on a ROCK 2A, tested that SD card shows up, made sure
> > ethernet works as well, also ensured that the adc key works.
> > 
> > 
> 
> 





