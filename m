Return-Path: <linux-kernel+bounces-792951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD92B3CAD1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A860A189FE7E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13C2750FB;
	Sat, 30 Aug 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rFK51Grz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CD262FD9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756557583; cv=none; b=KotaC9A73nth+AnC3wvZPdnXI97Yo463llRPB7c9tWfPSh4Kf+PJvF01HDJwEe/3s8E6SbQBgklT1URH0Z0j7QdHwqdM2N+pVj+4V7HgNbVx1E9LzsOz/cNTflNoAL/AdIcBdhLGEpGIkeCM9wp351+7XFvDDHC8Xhu7qI4MOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756557583; c=relaxed/simple;
	bh=hoDa/3/QtGQtggrIjZwVy/iE6leVL2+LzkTUHzAoKDU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ghzaz39Y3lCT3CaCk5hhHJdNG5VbCBluqNPS70KG1UPGZ51jAV6aTxPQzAEbLxU/LL6CdXhRLAO5aUcctDoCjuHDQcI/89Ey7mXx/YXPAflKdFHJPE06L0/ReGBOsPjKZxnM6TGtHt4UTWaPD8YtZYMuH2+G7qoQUc71ihmLPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rFK51Grz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3cbb3ff70a0so1791931f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756557579; x=1757162379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=20be7LxlHZS/TfDHvRrUbWwFo2dLHszKiltGX5N2eNg=;
        b=rFK51GrzuY6NNu4A08dzr/44QdcSCm3n0825tal/6nfxDDLiQ7Kbb/w0gJDpSVstwA
         rDwSSKPYahJqxqH826LcHPFD3+bf9daOIcIuLr1tDevXtnd546QMI2nlHVbVc8ijT1LP
         gKEjBY1B6lHeFB3ZNQAzrbhucXe9v0f75p4LU/w85d+43LQpAfv/Z9eE2r9n7cormpzk
         iWl0DZeUugHRFwCJhyiWOmJ9C2VOWgT/atZ89tdxlxFcqeRASInTxAw3YlLz1d2wDH78
         QupV0RMYDj/IeHl52PZ85kSOQ0g0TgS8tok4Roiy37e/50dUgHSE8VnfyFY/TDgHg/ZB
         vxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756557579; x=1757162379;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20be7LxlHZS/TfDHvRrUbWwFo2dLHszKiltGX5N2eNg=;
        b=W1Gj5tckXxw0EUhbV9FPwudQQpHtkFgKU4NyBxL6W3jyOX354bKFpiXSvOYsKM4vpg
         fczqOekVy53x0tV5+lQtBR70x2b4lHf9Qx0AaTeAZ04S6o3mBsHB67DhjngQL1WmueaT
         E2fvjn0DasWsZWpXZgBml8h9WeZNFsDI/Ov/v+6Scxkau33yUh9qJ8vBgBflHeLPXD8P
         ZjoI08y7CpKx3SUA7tiSwh91QGuHNY1qeFb7oqUqYXWmAulCDAom7gdKtttPTUwesuvJ
         A6F2DzzBQdNkh50pwfoojkhWqQAlNSFsRwZXM06tay2zPT5JsEdO21JNyVM5ZFC2HLCO
         RtLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjJCbIObvsdmeLYV4Y7yn7Jb62SKf6aZ76lwk6y++3P6axNJnHhH+uojG3LX1GvnvPgAOkZxTjZn1f+f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/r2SSeAdJjIjhOiR3nOLRDeD3F5l9DG+jJqzOlPrVJL77rN1S
	8BplLuN+wm6qjVNaRNQnSurYpQqHvWv+pPpdCGuaXvgzF9wpbVH+LLJuF+8cimSgYvU=
X-Gm-Gg: ASbGncuUvEJFe4jBcEWImHdPLgSnCJ6wZWqg7pFbB42da5egp/lnvzMUvkgxiS4gPXc
	Ep8gUy3NElwSjFzcMJnM0gX2Wn6qTlPw1e1ZtrstENoxrtAIF/TPe01kAf8daYfv3D2wLmk7HXY
	cSTn9SbSWR+hBnxcAoYJfFnq6QWHAqKdw+yzIoM55yioz8TnvJTOZv5/A9EZVsFSpy1o0DcybF1
	BbcstgMhsPJc5I7oPhCfP9xbxD3Aj4+budQ6xKAQDq8vaGuLXoh7NbTnbsHU4TTvcGXW7WWXHwX
	Brr49xmN2lReFIGsFVdEHfOCo5p7xNpHNNUbNmmWBoQPBRXYlqDRiiK58+z9OcEaZDrxJjiXHFJ
	v7WPLxqoO4KHvZHqbFlNnxZAdXG9HQAE=
X-Google-Smtp-Source: AGHT+IGKkE6cnTA2T9YBQwa/Qeamu7DQ0EQ692z25ggyQOzjLkICVbtUjYY9SsUAQGsVhw5drZzJrA==
X-Received: by 2002:a05:6000:1884:b0:3cb:285f:8da9 with SMTP id ffacd0b85a97d-3d1e05bb61fmr1279177f8f.51.1756557578628;
        Sat, 30 Aug 2025 05:39:38 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f30fe02sm153940835e9.18.2025.08.30.05.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 05:39:38 -0700 (PDT)
Message-ID: <99d7dddb-d240-4906-9c53-0f487084cff5@tuxon.dev>
Date: Sat, 30 Aug 2025 15:39:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] reset: rzg2l-usbphy-ctrl: Add support for USB
 PWRRDY
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
 <20250819054212.486426-5-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
In-Reply-To: <20250819054212.486426-5-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Just a gentle ping for this patch and the series in general.

(For whatever reason the cover letter didn't land in my inbox so I replied
to this patch. Appologies for any inconvenience).

Thank you,
Claudiu

On 19.08.2025 08:42, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> On the Renesas RZ/G3S SoC, the USB PHY block has an input signal called
> PWRRDY. This signal is managed by the system controller and must be
> de-asserted after powering on the area where USB PHY resides and asserted
> before powering it off.
> 
> On power-on the USB PWRRDY signal need to be de-asserted before enabling
> clock and switching the module to normal state (through MSTOP support). The
> power-on configuration sequence must be:
> 
> 1/ PWRRDY=0
> 2/ CLK_ON=1
> 3/ MSTOP=0
> 
> On power-off the configuration sequence should be:
> 
> 1/ MSTOP=1
> 2/ CLK_ON=0
> 3/ PWRRDY=1
> 
> The CLK_ON and MSTOP functionalities are controlled by clock drivers.
> 
> After long discussions with the internal HW team, it has been confirmed
> that the HW connection b/w USB PHY block, the USB channels, the system
> controller, clock, MSTOP, PWRRDY signal is as follows:
> 
>                                ┌──────────────────────────────┐
>                                │                              │◄── CPG_CLKON_USB.CLK0_ON
>                                │     USB CH0                  │
> ┌──────────────────────────┐   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK2_ON
> │                 ┌────────┐   ││host controller registers  │ │
> │                 │        │   ││function controller registers│
> │                 │ PHY0   │◄──┤└───────────────────────────┘ │
> │     USB PHY     │        │   └────────────▲─────────────────┘
> │                 └────────┘                │
> │                          │    CPG_BUS_PERI_COM_MSTOP.MSTOP{6, 5}_ON
> │┌──────────────┐ ┌────────┐
> ││USHPHY control│ │        │
> ││  registers   │ │ PHY1   │   ┌──────────────────────────────┐
> │└──────────────┘ │        │◄──┤     USB CH1                  │
> │                 └────────┘   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK1_ON
> └─▲───────▲─────────▲──────┘   ││ host controller registers │ │
>   │       │         │          │└───────────────────────────┘ │
>   │       │         │          └────────────▲─────────────────┘
>   │       │         │                       │
>   │       │         │           CPG_BUS_PERI_COM_MSTOP.MSTOP7_ON
>   │PWRRDY │         │
>   │       │   CPG_CLK_ON_USB.CLK3_ON
>   │       │
>   │  CPG_BUS_PERI_COM_MSTOP.MSTOP4_ON
>   │
> ┌────┐
> │SYSC│
> └────┘
> 
> where:
> - CPG_CLKON_USB.CLK.CLKX_ON is the register bit controlling the clock X
>   of different USB blocks, X in {0, 1, 2, 3}
> - CPG_BUS_PERI_COM_MSTOP.MSTOPX_ON is the register bit controlling the
>   MSTOP of different USB blocks, X in {4, 5, 6, 7}
> - USB PHY is the USB PHY block exposing 2 ports, port0 and port1, used
>   by the USB CH0, USB CH1
> - SYSC is the system controller block controlling the PWRRDY signal
> - USB CHx are individual USB block with host and function capabilities
>   (USB CH0 have both host and function capabilities, USB CH1 has only
>   host capabilities)
> 
> The USBPHY control registers are controlled though the
> reset-rzg2l-usbphy-ctrl driver. The USB PHY ports are controlled by
> phy_rcar_gen3_usb2 (drivers/phy/renesas/phy-rcar-gen3-usb2.c file). The
> USB PHY ports request resets from the reset-rzg2l-usbphy-ctrl driver.
> 
> The connection b/w the system controller and the USB PHY CTRL driver is
> implemented through the renesas,sysc-pwrrdy device tree property
> proposed in this patch. This property specifies the register offset and the
> bitmask required to control the PWRRDY signal.
> 
> Since the USB PHY CTRL driver needs to be probed before any other
> USB-specific driver on RZ/G3S, control of PWRRDY is passed exclusively
> to it. This guarantees the correct configuration sequence between clocks,
> MSTOP bits, and the PWRRDY bit. At the same time, changes are kept minimal
> by avoiding modifications to the USB PHY driver to also handle the PWRRDY
> itself.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - updated patch description
> - updated rzg2l_usbphy_ctrl_pwrrdy_init() to map directly the
>   "renesas,sysc-pwrrdy" as the SYSC signal abstraction was dropped
>   in this version, along with rz_sysc_get_signal_map()
> - dropped priv member of rzg2l_usbphy_ctrl_pwrrdy_init() as it is
>   not needed in this version
> - shift left !power_on with pwrrdy->mask as this is how the
>   regmap_update_bits() needs the last member to be
> - selected MFD_SYSCON
> 
> Changes in v3:
> - none; this patch is new
> 
>  drivers/reset/Kconfig                   |  1 +
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 66 +++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 78b7078478d4..329730cbcfb9 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -237,6 +237,7 @@ config RESET_RASPBERRYPI
>  config RESET_RZG2L_USBPHY_CTRL
>  	tristate "Renesas RZ/G2L USBPHY control driver"
>  	depends on ARCH_RZG2L || COMPILE_TEST
> +	select MFD_SYSCON
>  	help
>  	  Support for USBPHY Control found on RZ/G2L family. It mainly
>  	  controls reset and power down of the USB/PHY.
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> index 8a7f167e405e..3856072b23a3 100644
> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -13,6 +13,7 @@
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/reset-controller.h>
> +#include <linux/mfd/syscon.h>
>  
>  #define RESET			0x000
>  #define VBENCTL			0x03c
> @@ -41,6 +42,18 @@ struct rzg2l_usbphy_ctrl_priv {
>  
>  #define rcdev_to_priv(x)	container_of(x, struct rzg2l_usbphy_ctrl_priv, rcdev)
>  
> +/**
> + * struct rzg2l_usbphy_ctrl_pwrrdy - SYSC PWRRDY signal descriptor
> + * @regmap: SYSC regmap
> + * @offset: offset into the SYSC address space for accessing PWRRDY
> + * @mask: mask into the register at offset for accessing PWRRDY
> + */
> +struct rzg2l_usbphy_ctrl_pwrrdy {
> +	struct regmap *regmap;
> +	u32 offset;
> +	u32 mask;
> +};
> +
>  static int rzg2l_usbphy_ctrl_assert(struct reset_controller_dev *rcdev,
>  				    unsigned long id)
>  {
> @@ -91,6 +104,8 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
>  	return !!(readl(priv->base + RESET) & port_mask);
>  }
>  
> +#define RZG2L_USBPHY_CTRL_PWRRDY	1
> +
>  static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
>  	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
>  	{ /* Sentinel */ }
> @@ -110,6 +125,53 @@ static const struct regmap_config rzg2l_usb_regconf = {
>  	.max_register = 1,
>  };
>  
> +static void rzg2l_usbphy_ctrl_set_pwrrdy(struct rzg2l_usbphy_ctrl_pwrrdy *pwrrdy,
> +					 bool power_on)
> +{
> +	regmap_update_bits(pwrrdy->regmap, pwrrdy->offset, pwrrdy->mask,
> +			   !power_on << pwrrdy->mask);
> +}
> +
> +static void rzg2l_usbphy_ctrl_pwrrdy_off(void *data)
> +{
> +	rzg2l_usbphy_ctrl_set_pwrrdy(data, false);
> +}
> +
> +static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
> +{
> +	struct rzg2l_usbphy_ctrl_pwrrdy *pwrrdy;
> +	struct of_phandle_args args;
> +	struct regmap *regmap;
> +	const int *data;
> +	int ret;
> +
> +	data = device_get_match_data(dev);
> +	if (data != (int *)RZG2L_USBPHY_CTRL_PWRRDY)
> +		return 0;
> +
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node, "renesas,sysc-pwrrdy", 2,
> +					       0, &args);
> +	if (ret)
> +		return ret;
> +
> +	regmap = syscon_node_to_regmap(args.np);
> +	of_node_put(args.np);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	pwrrdy = devm_kzalloc(dev, sizeof(*pwrrdy), GFP_KERNEL);
> +	if (!pwrrdy)
> +		return -ENOMEM;
> +
> +	pwrrdy->regmap = regmap;
> +	pwrrdy->offset = args.args[0];
> +	pwrrdy->mask = args.args[1];
> +
> +	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
> +
> +	return devm_add_action_or_reset(dev, rzg2l_usbphy_ctrl_pwrrdy_off, pwrrdy);
> +}
> +
>  static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -132,6 +194,10 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> +	error = rzg2l_usbphy_ctrl_pwrrdy_init(dev);
> +	if (error)
> +		return error;
> +
>  	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>  	if (IS_ERR(priv->rstc))
>  		return dev_err_probe(dev, PTR_ERR(priv->rstc),


