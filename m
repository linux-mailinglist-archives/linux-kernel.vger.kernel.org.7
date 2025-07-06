Return-Path: <linux-kernel+bounces-712370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7935AF0839
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 04:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50184A4CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4719CD0B;
	Wed,  2 Jul 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RiE2Gdx1"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0F1553AA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421618; cv=none; b=R8Yld63qKHm+ACONx5f9scUQquROKJmEJWs6qPyi43kPHE7ptwjmSEUhLM+dryVP0+li1Fsjsuxd86Q+RzaIHY2c2WXOPZtaRgDJGL1IQCKNvC3zw0Sn7z4ewB5zn3/ZpzkcoFu3l4VErdasDYebxQ1KgeB/nYs3zuhvBl2d7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421618; c=relaxed/simple;
	bh=mNL+vL+xN7bDVuRbaJlPg1tSMlXvcNCBR6ykGypA0R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRHACeWOUbhtJP9txYiS3Xy1BXv+GhYZylKbskM9zbP65QOjG6LU3m1vAu5r8mzO1jT4aJzOt/WaqxyUICMfLwJj8teLyhdexacfcBEyuFWpQtFVEUTh5XGS07zGLQboo+GUN+0DMFqP4Rg1GWRNWgWUelxrspURu0+dApQc2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RiE2Gdx1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15ba0933-b0c1-40eb-9d3c-d8837d6ee12a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751421601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKL1FF4hap74WWQz6H6EMD4nNxNTcrjgixOQ6nf32eM=;
	b=RiE2Gdx1GgXM790DtELGwOhTrItveIzucm7gfHPjoIySLpLc8uXMdXgMbBgMGVFdR2oiPa
	ZE/7qEHeI0xkLU5TEopXi/q4uCnVDLWJtMiXIoPqwdBooQY0oQ0+BgREr1zLdI0YFaEH6o
	d8d2D072jp8C+wwdjrBY/r0AvtCnuzk=
Date: Wed, 2 Jul 2025 09:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFT net-next 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
References: <20250701165756.258356-1-wens@kernel.org>
 <20250701165756.258356-3-wens@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250701165756.258356-3-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 7/2/25 12:57 AM, Chen-Yu Tsai 写道:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Allwinner A523 SoC family has a second Ethernet controller, called
> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> numbering. This controller, according to BSP sources, is fully
> compatible with a slightly newer version of the Synopsys DWMAC core.
> The glue layer around the controller is the same as found around older
> DWMAC cores on Allwinner SoCs. The only slight difference is that since
> this is the second controller on the SoC, the register for the clock
> delay controls is at a different offset. Last, the integration includes
> a dedicated clock gate for the memory bus and the whole thing is put in
> a separately controllable power domain.
> 
> Add a new driver for this hardware supporting the integration layer.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>   .../ethernet/stmicro/stmmac/dwmac-sun55i.c    | 161 ++++++++++++++++++
>   3 files changed, 174 insertions(+)
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 67fa879b1e52..38ce9a0cfb5b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -263,6 +263,18 @@ config DWMAC_SUN8I
>   	  stmmac device driver. This driver is used for H3/A83T/A64
>   	  EMAC ethernet controller.
>   
> +config DWMAC_SUN55I
> +	tristate "Allwinner sun55i GMAC200 support"
> +	default ARCH_SUNXI
> +	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
> +	select MDIO_BUS_MUX
> +	help
> +	  Support for Allwinner A523/T527 GMAC200 ethernet controllers.
> +
> +	  This selects Allwinner SoC glue layer support for the
> +	  stmmac device driver. This driver is used for A523/T527
> +	  GMAC200 ethernet controller.
> +
>   config DWMAC_THEAD
>   	tristate "T-HEAD dwmac support"
>   	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index b591d93f8503..51e068e26ce4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
>   obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
>   obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
>   obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> +obj-$(CONFIG_DWMAC_SUN55I)	+= dwmac-sun55i.o
>   obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
>   obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
>   obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
> new file mode 100644
> index 000000000000..7fadb90e3098
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * dwmac-sun55i.c - Allwinner sun55i GMAC200 specific glue layer
> + *
> + * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
> + *
> + * syscon parts taken from dwmac-sun8i.c, which is
> + *
> + * Copyright (C) 2017 Corentin Labbe <clabbe.montjoie@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/stmmac.h>
> +
> +#include "stmmac.h"
> +#include "stmmac_platform.h"
> +
> +#define SYSCON_REG		0x34
> +
> +/* RMII specific bits */
> +#define SYSCON_RMII_EN		BIT(13) /* 1: enable RMII (overrides EPIT) */
insert a blankline.
> +/* Generic system control EMAC_CLK bits */
> +#define SYSCON_ETXDC_MASK		GENMASK(12, 10)
> +#define SYSCON_ERXDC_MASK		GENMASK(9, 5)
ditto.
> +/* EMAC PHY Interface Type */
> +#define SYSCON_EPIT			BIT(2) /* 1: RGMII, 0: MII */
> +#define SYSCON_ETCS_MASK		GENMASK(1, 0)
> +#define SYSCON_ETCS_MII		0x0
> +#define SYSCON_ETCS_EXT_GMII	0x1
> +#define SYSCON_ETCS_INT_GMII	0x2
> +
> +#define MASK_TO_VAL(mask)   ((mask) >> (__builtin_ffsll(mask) - 1))
> +
> +static int sun55i_gmac200_set_syscon(struct device *dev,
> +				     struct plat_stmmacenet_data *plat)
> +{
> +	struct device_node *node = dev->of_node;
> +	struct regmap *regmap;
> +	u32 val, reg = 0;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(node, "syscon");
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to map syscon\n");
> +
-----------
> +	if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {
> +		if (val % 100) {
> +			dev_err(dev, "tx-delay must be a multiple of 100\n");
> +			return -EINVAL;
> +		}
> +		val /= 100;
> +		dev_dbg(dev, "set tx-delay to %x\n", val);
> +		if (val > MASK_TO_VAL(SYSCON_ETXDC_MASK))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid TX clock delay: %d\n",
> +					     val);
> +
> +		reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
> +	}
> +
> +	if (!of_property_read_u32(node, "allwinner,rx-delay-ps", &val)) {
> +		if (val % 100) {
> +			dev_err(dev, "rx-delay must be a multiple of 100\n");
> +			return -EINVAL;
> +		}
> +		val /= 100;
> +		dev_dbg(dev, "set rx-delay to %x\n", val);
> +		if (val > MASK_TO_VAL(SYSCON_ERXDC_MASK))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid RX clock delay: %d\n",
> +					     val);
> +
> +		reg |= FIELD_PREP(SYSCON_ERXDC_MASK, val);
> +	}
------------
These two parts of the code are highly similar.
Can you construct a separate function?
> +
> +	switch (plat->mac_interface) {

> +	case PHY_INTERFACE_MODE_MII:
> +		/* default */
> +		break;
This line of comment seems a bit abrupt here.


Thanks,
Yanteng

