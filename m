Return-Path: <linux-kernel+bounces-870735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE4C0B8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C6B3A74D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AACC30E820;
	Mon, 27 Oct 2025 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lQjAA7Fl"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF41E503D;
	Mon, 27 Oct 2025 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761526293; cv=none; b=AhQN2+pmQz1eYaCpilXN8UV0IsFMJWib3aTL5YzrKeMnLVEe2Tr4QA3nWZwrcvVF1b55q6hCAdPuXyG8qAiM7m0iNQlLLTuYFK+2XD404QpB4s+GXmDrG1k+tpErNmaccTs65FfY+OaYxxK3OPliOQF5yYT86PNqPYxpK+q66aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761526293; c=relaxed/simple;
	bh=ICOtlUgV56LEePKk9OLdGgoIx0Fxoy0iWhPefk7duTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unKGp5iSGwHFLYP+ckG+0Biq1RucJImaM4XCyZXWgJNyTo1iQlQ/GrDEl73DSBS6hncYfoVIs6ELyTHebVl9mkJs0YrG8tnoB3nYMpHNrRAsyxxqPs7lvm1eyZgZbURWqlQhxUBfT2SRGUoS7uRc5jehSCaeBQDfp26WY3AaCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lQjAA7Fl; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Mfe/m5mRhKga9zLtu31a/sVqXTyfvHsMKaxlczQ85zs=;
	b=lQjAA7Flm3b7icS0LXV5lqPBu2tMioIDSh+mHMhH7vxjSynDEwGF0MZmsVi0UC
	o9yNOxpmkRMmM8pAPWW5iMFNNURoqVxpSOncm1I9rIVQd3XRR/QzDjYjxI+ZLdsU
	5N81f86PIssO//es7FueWFSvZH7sLuiEhKgBSXRf2pjt4=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDn94u0wf5o7MO1AA--.46675S3;
	Mon, 27 Oct 2025 08:49:58 +0800 (CST)
Date: Mon, 27 Oct 2025 08:49:56 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 2/3] ARM: dts: imx28-amarula-rmm: add I2S audio
Message-ID: <aP7BtHVgigfcdtcE@dragon>
References: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
 <20250924130749.3012071-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924130749.3012071-2-dario.binacchi@amarulasolutions.com>
X-CM-TRANSID:M88vCgDn94u0wf5o7MO1AA--.46675S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWkury8ur4ftFy7CFyrXrb_yoW5Cr47pr
	1vkw4fCry8Aw18J34rJa4DGFs3G3yDGrWq9rnaqr1UAF9Iv34UXrW0kw15uF93XrZ3Aw4a
	gF98ZFyIkws8t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7UUUUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNRZ33Gj+wbZOVwAA3w

On Wed, Sep 24, 2025 at 03:07:45PM +0200, Dario Binacchi wrote:
> Add support for I2S audio on Amarula rmm board. Audio codec
> TLV320AIC3X is connected as slave to SAIF0, which provides
> bitclock, frame and MCLK.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  .../boot/dts/nxp/mxs/imx28-amarula-rmm.dts    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts b/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
> index af59211842fb..0c5b52f67178 100644
> --- a/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
> @@ -112,6 +112,29 @@ reg_usb1_vbus: regulator-usb1-vbus {
>  		enable-active-high;
>  		regulator-always-on;
>  	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "imx28-mrmmi-tlv320aic3x-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&cpu_dai>;
> +		simple-audio-card,frame-master = <&cpu_dai>;
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "HPROUT",
> +			"Headphone Jack", "HPRCOM";
> +		simple-audio-card,mclk-fs = <512>;
> +
> +		cpu_dai: simple-audio-card,cpu {
> +			sound-dai = <&saif0>;
> +			clocks = <&saif0>;
> +		};
> +
> +		codec_dai: simple-audio-card,codec {
> +			sound-dai = <&tlv320aic3x>;
> +		};
> +	};
>  };
>  
>  &auart0 {
> @@ -154,6 +177,20 @@ &i2c0 {
>  	pinctrl-0 = <&i2c0_pins_a>;
>  	status = "okay";
>  
> +	tlv320aic3x: tlv320aic3x@18 {

Can we use a generic node name?

> +		compatible = "ti,tlv320aic3x";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tlv320aic3x_pins>;
> +		reg = <0x18>;
> +		reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <0>;
> +

Nitpick: unnecessary newline

Shawn

> +		DVDD-supply = <&reg_1v8>;
> +		IOVDD-supply = <&reg_3v3>;
> +		AVDD-supply = <&reg_3v3>;
> +		DRVDD-supply = <&reg_3v3>;
> +	};
> +
>  	touchscreen: touchscreen@38 {
>  		compatible = "edt,edt-ft5306";
>  		reg = <0x38>;
> @@ -246,6 +283,14 @@ MX28_PAD_PWM1__GPIO_3_17
>  		fsl,voltage = <MXS_VOLTAGE_HIGH>;
>  	};
>  
> +	tlv320aic3x_pins: tlv320aic3x-pins@0 {
> +		reg = <0>;
> +		fsl,pinmux-ids = <MX28_PAD_SSP0_DATA4__GPIO_2_4>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,pull-up = <MXS_PULL_ENABLE>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +	};
> +
>  	usb0_vbus_enable_pin: usb0-vbus-enable@0 {
>  		reg = <0>;
>  		fsl,pinmux-ids = <MX28_PAD_SSP0_DATA5__GPIO_2_5>;
> @@ -269,6 +314,12 @@ &pwm {
>  	status = "okay";
>  };
>  
> +&saif0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&saif0_pins_a>;
> +	status = "okay";
> +};
> +
>  /* microSD */
>  &ssp0 {
>  	compatible = "fsl,imx28-mmc";
> -- 
> 2.43.0
> 
> base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
> branch: microgea-rmm-audio


