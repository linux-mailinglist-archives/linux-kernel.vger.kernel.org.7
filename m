Return-Path: <linux-kernel+bounces-830131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBAB98DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A344E1892BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971C283FF8;
	Wed, 24 Sep 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O4T5RwlG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15427877B;
	Wed, 24 Sep 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702296; cv=none; b=CYZFNsyjSaUeb00esw3mVS4kN+SPqi+j8TKPSBQb3E6vaKWg/7W8a+6kyOGpJqi4rzCbVdV0NafrcTaMDg66pAnsvAp0FNjGPU1dg6z7sDBcIPy7SHUpvoA1+o+sv9/IG+SUBtdZOponCJwoR5KZZwhQozbvhK++r69xIGyRows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702296; c=relaxed/simple;
	bh=nc3lW4hEPO4+UuoQL/uQ7/SVAuuMyo049NNa4zT6c8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apeuZFKpINXT/FmAhX/y/emeZMOrGKevLrDRxUORVwPOtvu14I6gZCuAlRzS9mQfETZHGf8xs0aRj3Fovm8fu0snh5ntYUfx4NCJw2w8mlOuMJGOybMj6046g+K7gx51dLu0QaKMY70ewkkVUqqed6Fo9KqxEKSclOEjYfUp1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O4T5RwlG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758702292;
	bh=nc3lW4hEPO4+UuoQL/uQ7/SVAuuMyo049NNa4zT6c8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O4T5RwlG/l99iCRkcEwzdsV6JY/OpyJQDfQ6W7/poAYXWcSO4tV5AcGEaWcHoCNvl
	 kiU/KsrBZxpZ1uJBs6LAFEtnF3X+pPELLZksBI4PgG4q3I3qQp0uJdlDRoz3V4rp8S
	 5STjySeXm8+5yr9L9srjG51a+IGK6UixO1CW+jS0/tNrpS5BWyfQHH30Wd/yM2MEp2
	 oXZnGt/BnHDLFCLdLDITI2JVLBNCq24ciTvAxmbMERCsGWhHs6iGI1td6gnG5fB6k1
	 wycjzBy8/mD+dFny/+JZV5958k39l65AgNU+w/a51w9lzTO5XgiAKuQSs88L7N0IpW
	 5ZGphx99dbu3w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0A62F17E068C;
	Wed, 24 Sep 2025 10:24:52 +0200 (CEST)
Message-ID: <fee90caf-1646-4fdf-8835-20c28c0181c6@collabora.com>
Date: Wed, 24 Sep 2025 10:24:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: en7523: Add reset-controller support for EN7523
 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Felix Fietkau <nbd@nbd.name>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924060509.1889131-3-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250924060509.1889131-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/25 08:05, Mikhail Kshevetskiy ha scritto:
> Introduce reset API support to EN7523 clock driver. EN7523 uses the
> same reset logic as EN7581, so just reuse existing code. The patch
> renames:
>   * en7581_rst_ofs to en75xx_rst_ofs,
>   * en7581_reset_register() to en75xx_reset_register()
> because they are not en7581 specific.
> 
> This patch also updates en7523 dtsi file to add required '#reset-cells'
> property to the System Control Unit node.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   arch/arm/boot/dts/airoha/en7523.dtsi |  1 +

Driver and devicetree changes have to be done in two different commits.
Please split.

>   drivers/clk/clk-en7523.c             | 72 ++++++++++++++++++++++++----
>   2 files changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
> index b523a868c4ad..7d60a4f2e650 100644
> --- a/arch/arm/boot/dts/airoha/en7523.dtsi
> +++ b/arch/arm/boot/dts/airoha/en7523.dtsi
> @@ -91,6 +91,7 @@ scu: system-controller@1fa20000 {
>   		reg = <0x1fa20000 0x400>,
>   		      <0x1fb00000 0x1000>;
>   		#clock-cells = <1>;
> +		#reset-cells = <1>;
>   	};
>   
>   	gic: interrupt-controller@9000000 {
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index 15bbdeb60b8e..f276937181b9 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
> @@ -9,6 +9,7 @@
>   #include <linux/regmap.h>
>   #include <linux/reset-controller.h>
>   #include <dt-bindings/clock/en7523-clk.h>
> +#include <dt-bindings/reset/airoha,en7523-reset.h>
>   #include <dt-bindings/reset/airoha,en7581-reset.h>
>   
>   #define RST_NR_PER_BANK			32
> @@ -294,11 +295,58 @@ static const struct en_clk_desc en7581_base_clks[] = {
>   	}
>   };
>   
> -static const u16 en7581_rst_ofs[] = {
> +static const u16 en75xx_rst_ofs[] = {

There's no need to rename this.

>   	REG_RST_CTRL2,
>   	REG_RST_CTRL1,
>   };
>   
> +static const u16 en7523_rst_map[] = {
> +	/* RST_CTRL2 */
> +	[EN7523_XPON_PHY_RST]		= 0,
> +	[EN7523_XSI_MAC_RST]		= 7,
> +	[EN7523_XSI_PHY_RST]		= 8,
> +	[EN7523_NPU_RST]		= 9,
> +	[EN7523_I2S_RST]		= 10,
> +	[EN7523_TRNG_RST]		= 11,
> +	[EN7523_TRNG_MSTART_RST]	= 12,
> +	[EN7523_DUAL_HSI0_RST]		= 13,
> +	[EN7523_DUAL_HSI1_RST]		= 14,
> +	[EN7523_HSI_RST]		= 15,
> +	[EN7523_DUAL_HSI0_MAC_RST]	= 16,
> +	[EN7523_DUAL_HSI1_MAC_RST]	= 17,
> +	[EN7523_HSI_MAC_RST]		= 18,
> +	[EN7523_WDMA_RST]		= 19,
> +	[EN7523_WOE0_RST]		= 20,
> +	[EN7523_WOE1_RST]		= 21,
> +	[EN7523_HSDMA_RST]		= 22,
> +	[EN7523_I2C2RBUS_RST]		= 23,
> +	[EN7523_TDMA_RST]		= 24,
> +	/* RST_CTRL1 */
> +	[EN7523_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
> +	[EN7523_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
> +	[EN7523_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
> +	[EN7523_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
> +	[EN7523_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
> +	[EN7523_TIMER_RST]		= RST_NR_PER_BANK + 8,
> +	[EN7523_PCM1_RST]		= RST_NR_PER_BANK + 11,
> +	[EN7523_UART_RST]		= RST_NR_PER_BANK + 12,
> +	[EN7523_GPIO_RST]		= RST_NR_PER_BANK + 13,
> +	[EN7523_GDMA_RST]		= RST_NR_PER_BANK + 14,
> +	[EN7523_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
> +	[EN7523_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
> +	[EN7523_SFC_RST]		= RST_NR_PER_BANK + 18,
> +	[EN7523_UART2_RST]		= RST_NR_PER_BANK + 19,
> +	[EN7523_GDMP_RST]		= RST_NR_PER_BANK + 20,
> +	[EN7523_FE_RST]			= RST_NR_PER_BANK + 21,
> +	[EN7523_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
> +	[EN7523_GSW_RST]		= RST_NR_PER_BANK + 23,
> +	[EN7523_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
> +	[EN7523_PCIE0_RST]		= RST_NR_PER_BANK + 26,
> +	[EN7523_PCIE1_RST]		= RST_NR_PER_BANK + 27,
> +	[EN7523_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
> +	[EN7523_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
> +};
> +
>   static const u16 en7581_rst_map[] = {
>   	/* RST_CTRL2 */
>   	[EN7581_XPON_PHY_RST]		= 0,
> @@ -357,6 +405,9 @@ static const u16 en7581_rst_map[] = {
>   	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
>   };
>   
> +static int en75xx_reset_register(struct device *dev, void __iomem *base,
> +				 const u16 *rst_map, int nr_resets);
> +
>   static u32 en7523_get_base_rate(const struct en_clk_desc *desc, u32 val)
>   {
>   	if (!desc->base_bits)
> @@ -552,7 +603,8 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
>   
>   	en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
>   
> -	return 0;
> +	return en75xx_reset_register(&pdev->dev, np_base, en7523_rst_map,
> +				     ARRAY_SIZE(en7523_rst_map));
>   }
>   
>   static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
> @@ -646,13 +698,14 @@ static int en7523_reset_xlate(struct reset_controller_dev *rcdev,
>   	return rst_data->idx_map[reset_spec->args[0]];
>   }
>   
> -static const struct reset_control_ops en7581_reset_ops = {
> +static const struct reset_control_ops en75xx_reset_ops = {

Same, no need to rename.

>   	.assert = en7523_reset_assert,
>   	.deassert = en7523_reset_deassert,
>   	.status = en7523_reset_status,
>   };
>   
> -static int en7581_reset_register(struct device *dev, void __iomem *base)
> +static int en75xx_reset_register(struct device *dev, void __iomem *base,
> +				 const u16 *rst_map, int nr_resets)

And again. No need to rename.

Cheers,
Angelo



