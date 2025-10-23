Return-Path: <linux-kernel+bounces-866889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DA1C00F29
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F871A015C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FE030F807;
	Thu, 23 Oct 2025 12:01:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6C30F950
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220890; cv=none; b=mRWSNYJvnIznkf4o4F8YQCyIbXaaEsHmpMQMKwtuTH1wiPdmHKuufbBQ9rnJNfw/ejRPZiI+F7VXafx8gLxE3GuOARAL//FomxTtnUYsieJL2mFk2WAtFuiDnGBk7QNcym2m7/plaEpYSrI3zZEnMP9QB81eNDw9lsg99ACEZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220890; c=relaxed/simple;
	bh=6/J4qfTtgniftwPSX2ZpnWqlVt5mOYJfR7RfUzo0A7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+fK86sie+WasFlB8MCw8/jVMTJtEKR0H97G+cbD7f2+c9a69RsVg2ozD9lWspOOSru4W4VZln4MQztbZXANXJ7vepxT1DJWR42Dde1bn+a20fXUqMmMs4K1GFQ5CYnRz0YRpfN6roxjG3ZaLBu4YNDk0nEpZiFYXnJFvqPbuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1vBtzs-00057X-KQ; Thu, 23 Oct 2025 14:00:48 +0200
Message-ID: <56075d3e-30ac-4501-bd77-2a84d0d124bd@pengutronix.de>
Date: Thu, 23 Oct 2025 14:00:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: freescale: imx93-phy{core, board}: Add i2c
 bus recovery
To: Primoz Fiser <primoz.fiser@norik.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, upstream@lists.phytec.de,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251023103426.3606647-1-primoz.fiser@norik.com>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20251023103426.3606647-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 10/23/25 12:34 PM, Primoz Fiser wrote:
> Add bus recovery feature for I2C buses on the PHYTEC phyCORE-i.MX93 SoM
> based boards (that is phyBOARD-Nash-i.MX93 and phyBOARD-Segin-i.MX93).
> This enables the i2c-imx-lpi2c driver to recover the stuck I2C bus by
> switching the SCL and SDA pinmuxing and do the I2C bus bit-banging.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  .../arm64/boot/dts/freescale/imx93-phyboard-nash.dts | 12 +++++++++++-
>  .../boot/dts/freescale/imx93-phyboard-segin.dts      | 12 +++++++++++-
>  arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi | 12 +++++++++++-
>  3 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> index 5599e296919f..96c58cf13754 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> @@ -128,8 +128,11 @@ &flexcan1 {
>  /* I2C2 */
>  &lpi2c2 {
>  	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
> +	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
>  
>  	/* RTC */
> @@ -253,6 +256,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
>  		>;
>  	};
>  
> +	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_I2C2_SCL__GPIO1_IO02		0x31e

I haven't worked with imx93 myself yet, but does this not need the SION
bit set?

Cheers,
Ahmad

> +			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
> +		>;
> +	};
> +
>  	pinctrl_lpspi6: lpspi6grp {
>  		fsl,pins = <
>  			MX93_PAD_GPIO_IO00__GPIO2_IO00		0x386
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> index 802d96b19e4c..1850a93dbaa4 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> @@ -132,8 +132,11 @@ &flexcan1 {
>  /* I2C2 */
>  &lpi2c2 {
>  	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
> +	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
>  
>  	/* Codec */
> @@ -238,6 +241,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
>  		>;
>  	};
>  
> +	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_I2C2_SCL__GPIO1_IO02		0x31e
> +			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
> +		>;
> +	};
> +
>  	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
>  		fsl,pins = <
>  			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> index 3f069905cf0b..ebc57841f27f 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
> @@ -93,8 +93,11 @@ ethphy1: ethernet-phy@1 {
>  /* I2C3 */
>  &lpi2c3 {
>  	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
> +	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
>  
>  	pmic@25 {
> @@ -234,6 +237,13 @@ MX93_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
>  		>;
>  	};
>  
> +	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO28__GPIO2_IO28		0x31e
> +			MX93_PAD_GPIO_IO29__GPIO2_IO29		0x31e
> +		>;
> +	};
> +
>  	pinctrl_pmic: pmicgrp {
>  		fsl,pins = <
>  			MX93_PAD_ENET2_RD3__GPIO4_IO27		0x31e

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


