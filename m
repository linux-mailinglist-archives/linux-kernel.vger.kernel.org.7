Return-Path: <linux-kernel+bounces-859069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A7437BEC9B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D06F6350CC8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0F28725F;
	Sat, 18 Oct 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpGs3Uku"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F59257820
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760775235; cv=none; b=Y6ydvPrJi6U34AOGfXMnwuRKdfoKow/L23X6Wb71RmJPjeDb8ilSvLuPE4WDuhoKxufkLaeg2VGLvNMow29iNCM6MbVqG+Jzzf3Er9DgH0TY3zvFRNw+yCwsUAks42qFJZSiYvSNT9a2RGutMRv8M1ziqPj6fC7LG9QdFz9bNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760775235; c=relaxed/simple;
	bh=Da/aVxjsRIGx83gKjIdUHyyCDKnsf8FH4q0xEFl+Vqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPV0O+59iaWUTA5sejOZXmkIxiylLSInqQWK0R0PjVyNFB2TUv+HSmAxIz3oTeN58lXT+qETNJ6MijK5PWFzmTWE97zggh0Lr3O/G3TabojFTUEyDHwQef+H62eSH40Thnw8IigeK0mzN1Zz/fC1eMBnteq99P0rNMl+jWdmSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpGs3Uku; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so478065666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760775232; x=1761380032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BWm2fVryTSX7TLsnuCucMdyctrF8pcZJHdFO1Qboag=;
        b=LpGs3Uku7CeBHXWfsphXewFXpzv3K+4EQg07RoqN880YfHw69Pf3qtfIULrZsvb5Rv
         fAIcDYOrB4LnBgoT0Y+G7EKTCT1g+TxipgySf1GUnM7qKrJrY/W32/8gYEF8MflFZcjU
         Okk9EI35Esw7dVE5gm4SH56N0PpEwvnc6305vs47oqvBywgJWv0FFdjSSAN+rHsSwyA8
         72cXjWGfbT/w/Y5QWi0BDlS9Yz7K+fK2buaQxqBomSx+LKRx/w/OL/QNZBXnbtqDHRxr
         AMw7tzvWEVeQ7HAk4zneGnJ4P76/iCl6CDzrjVk01IHFdaUlYuDoLro/BaBgGSQbSqqP
         OWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760775232; x=1761380032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BWm2fVryTSX7TLsnuCucMdyctrF8pcZJHdFO1Qboag=;
        b=nIsKmfKUNGcTHvtBqmIpMOH+NRmrydR8xe/EOEja+jo+IetqJbXu2GR8E/8x76WAIc
         UDhswk2GGLm2pKApxOsmZsjIZF/aY2YmNjPdUj2VxB7gEjXVpC63Th7r6Nn2cTvF2Z9E
         H/yoeHsIohoSgXQfP5yohHmDKfFN3CJxL2TKKqksjU+eiZzWYcS2kubTrvGC9wUdJb+b
         NN3ak2PzGneY7GFDLUFmWjKyG5BPuSZqU31VYM5So06/wOXf4c0sLAtkpfqUwci8zTr0
         gIGumHWvGFx43lnqZoGZu/7LJ01eBh+lol6fxOMNalNwFhxTzfspynCxtldKIcVvcvuq
         pnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmuctRPIsRy+TJJftB3WVyHVuQhRP5KxeWe3EclAaAOsG98EgAgFW5TaeOibNK3wcr3Xir+hE5P+TADDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnNar7bskaEw1mpCQSVxPSASZXxCjLZrN7SKGB3dDodxViLr0
	bXKre7yy0nfFD7y9mugQUM4mPYPANpkSUcXB7196zk5yLdoYxM7ge5AQ
X-Gm-Gg: ASbGncsHQVDGDKNFeLP4/73zRAcGVi9REeb37mTcgLk/H+935ATCrn77ep/5f0PslZA
	zbfCwS3wJRzXJjXy9Y0VjqUmgg0d+YhN0G7b1/wbqmFz3e9uS2t5NYnOtSw+5dDe4HBoKKEbX08
	aQTbLAoQZLp8FaMkUJtXki2yJ5qvlzkHSsCbJRoc/W9zzZuKvTcZA0heLtTyFraZLwVDfCehTKt
	TVuchyBh3moA0N6oXEip8RJvwLwq1gRwWU9a3bobdDYV13Vy2pCJJ/4SI+ZF0kr24YFX/Z6P/Hy
	/JJWBjxq8sf1noV6PbElTpYafTsk0U1O8aLd+gDwDsb1EWqgDbkZ6z374FTfDL70qMjlPDQ8zw1
	W8y8Rwp489Q6fNMJARZ6mo7wZz2mbx1BZYyiMeuNda7LIcViE2rGX21zO6Jay6s5ukE5tWBE1bn
	6kDw3agZv65dr+XS6ynw+uvYFh51EwHQwVt9uIC5QEwKN3pgc61jcuyg==
X-Google-Smtp-Source: AGHT+IGNDixJtPAW8Oef1zChTYomkbozhZ1mWKG9sYnl651V3ZzOLY2THmU+caOxpLoTq8ZVNQRwBQ==
X-Received: by 2002:a17:906:f58b:b0:b49:2021:793f with SMTP id a640c23a62f3a-b64764e4b0amr723616466b.53.1760775231364;
        Sat, 18 Oct 2025 01:13:51 -0700 (PDT)
Received: from [192.168.1.103] (79-100-18-255.ip.btc-net.bg. [79.100.18.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb035b81sm182545366b.51.2025.10.18.01.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 01:13:50 -0700 (PDT)
Message-ID: <37daba64-5233-4573-95de-38612c2358f2@gmail.com>
Date: Sat, 18 Oct 2025 11:13:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] phy: Add Google Tensor SoC USB PHY driver
To: Roy Luo <royluo@google.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joy Chakraborty <joychakr@google.com>, Naveen Kumar <mnkumar@google.com>,
 Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20251017235159.2417576-1-royluo@google.com>
 <20251017235159.2417576-3-royluo@google.com>
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20251017235159.2417576-3-royluo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/25 02:51, Roy Luo wrote:
> Support the USB PHY found on Google Tensor G5. This particular USB PHY
> supports both high-speed and super-speed operations, and is integrated
> with the SNPS DWC3 controller that's also on the SoC.
> This initial patch specifically adds functionality for high-speed.
>
> Co-developed-by: Joy Chakraborty <joychakr@google.com>
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> Co-developed-by: Naveen Kumar <mnkumar@google.com>
> Signed-off-by: Naveen Kumar <mnkumar@google.com>
> Signed-off-by: Roy Luo <royluo@google.com>
> ---
>  drivers/phy/Kconfig          |  13 ++
>  drivers/phy/Makefile         |   1 +
>  drivers/phy/phy-google-usb.c | 271 +++++++++++++++++++++++++++++++++++
>  3 files changed, 285 insertions(+)
>  create mode 100644 drivers/phy/phy-google-usb.c
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 58c911e1b2d2..fe32d1356002 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -101,6 +101,19 @@ config PHY_NXP_PTN3222
>  	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
>  	  Speed and High Speed.
>  
> +config PHY_GOOGLE_USB
> +	tristate "Google Tensor SoC USB PHY driver"
> +	depends on HAS_IOMEM
> +	depends on OF
> +	depends on TYPEC
> +	select GENERIC_PHY
> +	help
> +	  Enable support for the USB PHY on Google Tensor SoCs, starting with
> +	  the G5 generation. This driver provides the PHY interfaces to
> +	  interact with the SNPS eUSB2 and USB 3.2/DisplayPort Combo PHY, both
> +	  of which are integrated with the DWC3 USB controller.

So it's more like a DRD controller, since it encapsulates multiple phys?

> +	  This driver currently supports USB high-speed.
> +
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index c670a8dac468..1d7a1331bd19 100644
...
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +#include <linux/cleanup.h>
> +#include <linux/usb/typec_mux.h>
> +
> +#define USBCS_USB2PHY_CFG19_OFFSET 0x0
> +#define USBCS_USB2PHY_CFG19_PHY_CFG_PLL_FB_DIV GENMASK(19, 8)

I'd suggest implementing the eUSB support in the existing snps-eusb2
driver for the sake of clarity. That way, you can pass it as a phandle
to this driver and probe it when drd is probing.

> +
> +#define USBCS_USB2PHY_CFG21_OFFSET 0x8
> +#define USBCS_USB2PHY_CFG21_PHY_ENABLE BIT(12)
> +#define USBCS_USB2PHY_CFG21_REF_FREQ_SEL GENMASK(15, 13)
> +#define USBCS_USB2PHY_CFG21_PHY_TX_DIG_BYPASS_SEL BIT(19)
> +
> +#define USBCS_PHY_CFG1_OFFSET 0x28
> +#define USBCS_PHY_CFG1_SYS_VBUSVALID BIT(17)
> +
> +enum google_usb_phy_id {
> +	GOOGLE_USB2_PHY,
> +	GOOGLE_USB_PHY_NUM,
> +};
> +
> +struct google_usb_phy_instance {
> +	int index;
> +	struct phy *phy;
> +	int num_clks;
> +	struct clk_bulk_data *clks;
> +	struct reset_control *rsts;
> +};
> +
> +struct google_usb_phy {
> +	struct device *dev;
> +	void __iomem *u2phy_cfg_base;
> +	void __iomem *dp_top_base;
> +	struct google_usb_phy_instance insts[GOOGLE_USB_PHY_NUM];
> +	/* serialize phy access */
> +	struct mutex phy_mutex;
> +	struct typec_switch_dev *sw;
> +	enum typec_orientation orientation;
> +};
> +
> +static inline struct google_usb_phy *to_google_usb_phy(struct google_usb_phy_instance *inst)
> +{
> +	return container_of(inst, struct google_usb_phy, insts[inst->index]);
> +}
> +
> +static void set_vbus_valid(struct google_usb_phy *gphy)
> +{
> +	u32 reg;
> +
> +	if (gphy->orientation == TYPEC_ORIENTATION_NONE) {
> +		reg = readl(gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
> +		reg &= ~USBCS_PHY_CFG1_SYS_VBUSVALID;
> +		writel(reg, gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
> +	} else {
> +		reg = readl(gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
> +		reg |= USBCS_PHY_CFG1_SYS_VBUSVALID;
> +		writel(reg, gphy->dp_top_base + USBCS_PHY_CFG1_OFFSET);
> +	}
> +}
> +
> +static int google_usb_set_orientation(struct typec_switch_dev *sw,
> +				      enum typec_orientation orientation)
> +{
> +	struct google_usb_phy *gphy = typec_switch_get_drvdata(sw);
> +
> +	dev_dbg(gphy->dev, "set orientation %d\n", orientation);
> +
> +	gphy->orientation = orientation;
> +
> +	if (pm_runtime_suspended(gphy->dev))
> +		return 0;
> +
> +	guard(mutex)(&gphy->phy_mutex);
> +
> +	set_vbus_valid(gphy);
> +
> +	return 0;
> +}
> +
> +static int google_usb2_phy_init(struct phy *_phy)
> +{
> +	struct google_usb_phy_instance *inst = phy_get_drvdata(_phy);
> +	struct google_usb_phy *gphy = to_google_usb_phy(inst);
> +	u32 reg;
> +	int ret = 0;
> +
> +	dev_dbg(gphy->dev, "initializing usb2 phy\n");
> +
> +	guard(mutex)(&gphy->phy_mutex);
> +
> +	reg = readl(gphy->u2phy_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
> +	reg &= ~USBCS_USB2PHY_CFG21_PHY_TX_DIG_BYPASS_SEL;
> +	reg &= ~USBCS_USB2PHY_CFG21_REF_FREQ_SEL;
> +	reg |= FIELD_PREP(USBCS_USB2PHY_CFG21_REF_FREQ_SEL, 0);
> +	writel(reg, gphy->u2phy_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
> +
> +	reg = readl(gphy->u2phy_cfg_base + USBCS_USB2PHY_CFG19_OFFSET);
> +	reg &= ~USBCS_USB2PHY_CFG19_PHY_CFG_PLL_FB_DIV;
> +	reg |= FIELD_PREP(USBCS_USB2PHY_CFG19_PHY_CFG_PLL_FB_DIV, 368);

Yeah, it's definitely the eUSB IP, but wired differently.

phy-snps-eusb2.c:
#define EXYNOS_USB_PHY_CFG_PLLCFG0 (0x8)
#define PHY_CFG_PLL_FB_DIV_19_8_MASK GENMASK(19, 8)
#define DIV_19_8_19_2_MHZ_VAL (0x170)

> +	writel(reg, gphy->u2phy_cfg_base + USBCS_USB2PHY_CFG19_OFFSET);
> +
> +	set_vbus_valid(gphy);
> +
> +	ret = clk_bulk_prepare_enable(inst->num_clks, inst->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(inst->rsts);
> +	if (ret) {
> +		clk_bulk_disable_unprepare(inst->num_clks, inst->clks);
> +		return ret;
> +	}
> +
> +	reg = readl(gphy->u2phy_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
> +	reg |= USBCS_USB2PHY_CFG21_PHY_ENABLE;
> +	writel(reg, gphy->u2phy_cfg_base + USBCS_USB2PHY_CFG21_OFFSET);
> +
> +	return ret;
> +}
> +
...
> +
> +	gphy->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(gphy->sw))
> +		return dev_err_probe(dev, PTR_ERR(gphy->sw),
> +				     "failed to register typec switch\n");
> +
> +	return 0;
> +}
> +
> +static void google_usb_phy_remove(struct platform_device *pdev)
> +{
> +	struct google_usb_phy *gphy = dev_get_drvdata(&pdev->dev);
> +
> +	typec_switch_unregister(gphy->sw);
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
> +static const struct of_device_id google_usb_phy_of_match[] = {
> +	{
> +		.compatible = "google,gs5-usb-phy",

Did the naming scheme also change from gs{N}01 to gsN?

> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, google_usb_phy_of_match);
> +
> +static struct platform_driver google_usb_phy = {
> +	.probe	= google_usb_phy_probe,
> +	.remove = google_usb_phy_remove,
> +	.driver = {
> +		.name		= "google-usb-phy",
> +		.of_match_table	= google_usb_phy_of_match,
> +	}
> +};
> +
> +module_platform_driver(google_usb_phy);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Google USB phy driver");

Great work!

Best regards,
Ivaylo

