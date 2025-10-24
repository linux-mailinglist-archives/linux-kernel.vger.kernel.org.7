Return-Path: <linux-kernel+bounces-868102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F0C045D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C2F0353676
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC9A24BD04;
	Fri, 24 Oct 2025 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GU6Hef9X"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1B228CB0;
	Fri, 24 Oct 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761282852; cv=none; b=fXtiVIOSC/9bp82c0R6Id8+42owY3eFw5OlCI1rmHEZo25+uw0mTvlbaMP3XJ7IiX/iS86AxavopI2xU9nd0aaZD/duo0D2ztL2MwouIwbTo4ZxfU6OksiLRmAaREUeJiK7Vl3YFmQVSRiboN9zA9rPEpZ2WL5vlgtYDUhAuIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761282852; c=relaxed/simple;
	bh=5EEg/RzbwE3s+mLlYbRaS/zjJFFzYoSPj5cjZagyLH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sueFtfag4AtF76u+f4KHyShf4RAY0vUypHnkGIUul43XgJDFqvUH5gCINYk4NSG47APBvmJ9DBhRCBcnATQsEi9Dcwj/qZdD/B03rTgUKfjm3iHWfBOXt+T7pyZNNMWTVwm4yhPyUy4WHo+23rKQ1MNEiPOzhtDBRMafvxqmOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GU6Hef9X; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O5E0aN690420;
	Fri, 24 Oct 2025 00:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761282840;
	bh=B/skm0UaW3KF3UHKou99L8O5DCPGnOOskv0SohMxpmU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GU6Hef9X2H80KkhNHfSv9NXBExe1nvzLDZFY7HHDy6IOTwXQlSuT/jfwr/Hdmd2ww
	 BTHDvkJxJTNJhGletO8Qia0CRXPW27Z/e3fsbVauYrGHMWqQIRZ0eSR7UBDkMfplz0
	 H+l7cvv+OOrfivw5HKRzEFA2cerTyd3xpEevDGpk=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O5Dx753227887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Oct 2025 00:13:59 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 00:13:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 00:13:59 -0500
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O5Dudq4018814;
	Fri, 24 Oct 2025 00:13:56 -0500
Message-ID: <9da776bc-3156-4f4b-9e64-6ada5b47fab3@ti.com>
Date: Fri, 24 Oct 2025 10:43:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add support for Kontron
 SMARC-sAM67
To: Michael Walle <mwalle@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20251017135116.548236-1-mwalle@kernel.org>
 <20251017135116.548236-3-mwalle@kernel.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251017135116.548236-3-mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Michael

On 10/17/2025 7:20 PM, Michael Walle wrote:
> Add device tree support for the Kontron SMARC-sAM67 module, which is
> based on a TI AM67A SoC.
>
> The module features:
>   * Quad-core AM67A94 at 1.4GHz with 8 GiB RAM
>   * 64 GiB eMMC, 4 MiB SPI flash for failsafe booting
>   * Dedicated RTC
>   * Multiple interfaces: 4x UART, 2x USB 2.0/USB 3.2, 2x GBE, QSPI,
>          7x I2C,
>   * Display support: 2x LVDS, 1x DSI (*), 1x DP (*)
>   * Camera support: 4x CSI (*)
>   * Onboard microcontroller for boot control, failsafe booting and
>     external watchdog
>
> (*) not yet supported by the kernel
>
> There is a base device tree and overlays which will add optional
> features. At the moment there is one full featured variant of that
> board whose device tree is generated during build by merging all the
> device tree overlays.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |    7 +
>   .../dts/ti/k3-am67a-kontron-sa67-base.dts     | 1091 +++++++++++++++++
>   .../dts/ti/k3-am67a-kontron-sa67-gbe1.dtso    |   26 +
>   .../dts/ti/k3-am67a-kontron-sa67-gpios.dtso   |   61 +
>   .../ti/k3-am67a-kontron-sa67-rtc-rv8263.dtso  |   31 +
>   5 files changed, 1216 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-gbe1.dtso
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-gpios.dtso
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-rtc-rv8263.dtso
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 743115b849a7..d2a40ea642c4 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -137,7 +137,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-usb0-type-a.dtbo
>   
>   # Boards with J722s SoC
> +k3-am67a-kontron-sa67-dtbs := k3-am67a-kontron-sa67-base.dtb \
> +	k3-am67a-kontron-sa67-rtc-rv8263.dtbo k3-am67a-kontron-sa67-gbe1.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am67a-beagley-ai.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am67a-kontron-sa67.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am67a-kontron-sa67-base.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am67a-kontron-sa67-gbe1.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am67a-kontron-sa67-gpios.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am67a-kontron-sa67-rtc-rv8263.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
> diff --git a/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts b/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
> new file mode 100644
> index 000000000000..7169d934adac
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
> @@ -0,0 +1,1091 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Kontron SMARC-sAM67 module
> + *
> + * Copyright (c) 2025 Kontron Europe GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include "k3-j722s.dtsi"
> +#include "k3-serdes.h"
> +
> [..]+
> +	ospi0_pins_default: ospi0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x000, PIN_OUTPUT, 0)	/* (L24) OSPI0_CLK */
> +			J722S_IOPAD(0x02c, PIN_OUTPUT, 0)	/* (K26) OSPI0_CSn0 */
> +			J722S_IOPAD(0x030, PIN_OUTPUT, 0)	/* (K23) OSPI0_CSn1 */
> +			J722S_IOPAD(0x034, PIN_OUTPUT, 0)	/* (K22) OSPI0_CSn2 */

I am not sure, which flash device is being used , could you check once 
if all three CS are supported.


> +			J722S_IOPAD(0x00c, PIN_INPUT, 0)	/* (K27) OSPI0_D0 */
> +			J722S_IOPAD(0x010, PIN_INPUT, 0)	/* (L27) OSPI0_D1 */
> +			J722S_IOPAD(0x014, PIN_INPUT, 0)	/* (L26) OSPI0_D2 */
> +			J722S_IOPAD(0x018, PIN_INPUT, 0)	/* (L25) OSPI0_D3 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	pcie0_rc_pins_default: pcie0-rc-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x2ac, PIN_OUTPUT, 0)	/* (F25) PCIE0_CLKREQn */
> +			J722S_IOPAD(0x1b4, PIN_OUTPUT, 7)	/* (B20) SPI0_CS0.GPIO1_15 */
> +		>;
> +	};
> +
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x090, PIN_INPUT, 7)	/* (P27) GPMC0_BE0n_CLE.GPIO0_35 */
> +		>;
> +	};
> +
> [..]
> +/* I2C_PM */
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <100000>;
> +	status = "okay";


This is more a question, I see all i2c controller you want to run at 
100Kz, but most of devices are supporting 400Khz

like tps652g1 over main_i2c0 ,  pca9546 over main_i2c1 , is there 
specific reason for this


> +};
> +
> +/* SER3 */
> +&wkup_uart0 {
> +	/* WKUP UART0 is used by Device Manager firmware */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	bootph-all;
> +	status = "reserved";
> +};
[..]

