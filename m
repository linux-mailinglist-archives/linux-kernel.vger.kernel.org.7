Return-Path: <linux-kernel+bounces-838833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D282EBB03D8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F72A1847
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519A2E266C;
	Wed,  1 Oct 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RXrwp3iR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BCD2E229C;
	Wed,  1 Oct 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319399; cv=none; b=jpzbOkAWvgK1p0oS5+cWZnVRNFOSvVQ6XC6ZKQt0SyBREdFjIdlE340A7+mXbN2t7ua6eNnkal9NBgPrjD/Hp8O+/CDo3K/EUTJL5TC492Xve35hhBCYQHfKc/Wwe9ruoteLikRIErIVFNKuIuhT8NQFanG1LeZST+NIP8UJTpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319399; c=relaxed/simple;
	bh=/F77SMQlVVL9OAIkxdw2JODfBGuMaP1lWltHWiHzzDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq1j7tkE9UHyNRD1/mriq4W1c9g5VJ5ZBsok9UVRNfPJSUyTj8q3ry23HQUDsnaCX/TX9hb/xly8Jp9QIQlevMYnZGPHXSfHcewMTFs3IN4ps0M+UKrSJVgKW8O6AbtcZC3rKHHhMyYoj8/ggoll4MYd0okOWddWI+WrHO9AfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RXrwp3iR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759319395;
	bh=/F77SMQlVVL9OAIkxdw2JODfBGuMaP1lWltHWiHzzDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RXrwp3iRm3UaMHIEdQEQUyfH/KjvjQY2rz0IAv4paMqKAAZEr8JD4Qqv/pWpBe7I7
	 7IM/RG43EmffRL/Pm+w4lr0zw4Gag8NbBjrkoS0dGcyDEaHLxf3A0PYdhrpjAAZf8M
	 lh88J6SxMK1SaZ+Zy0l75H6Cwbxw0WC7/W2Wg3+8aPz3gsnbdmEFpGjdObe/xbKx3w
	 dbPr8foukNUKq237V8zybdSPkP/6DB3deYncAhJW780DsqTXclTxYOeBaCKwMuJXq1
	 Czrb19UobgJrapwnwEjSo/wLZvlGXs6Tk23PrujLYWeKWfu8D+11mNSDRAcubRkTFV
	 ElgTIJULpJzBQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0B75F17E00EC;
	Wed,  1 Oct 2025 13:49:55 +0200 (CEST)
Message-ID: <748f1176-c73c-48af-a1af-0b63d088e834@collabora.com>
Date: Wed, 1 Oct 2025 13:49:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: mediatek: Add rpm clocks to clk-mt8196-mfg
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Guangjie Song <guangjie.song@mediatek.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: kernel@collabora.com, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
 <20250929-mtk-pll-rpm-v1-4-49541777878d@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250929-mtk-pll-rpm-v1-4-49541777878d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/09/25 14:13, Nicolas Frattaroli ha scritto:
> The mfgpll clocks on mt8196 require that the MFG's EB clock is on if
> their control registers are touched in any way at all.

....so, the MFGPLL clocks are children of EB?

Why are you using such a convoluted way of adding a parent clock to the MFGPLL
instead of just
---->   `.parent_name = "mfg_eb"`  <-----

???????

Cheers,
Angelo

> Failing to ensure
> this results in a pleasant SError interrupt if the EB clock happens to
> be off.
> 
> To achieve this, leverage the CCF core's runtime power management
> support. Define the necessary suspend/resume callbacks, add the
> necessary code to get RPM clocks from the DT, and make sure RPM is
> enabled before clock registration happens.
> 
> For the RPM callbacks to really make much sense at all, we change the
> drvdata from clk_data to a new private struct, as is common in drivers
> across the Linux kernel.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   drivers/clk/mediatek/clk-mt8196-mfg.c | 104 +++++++++++++++++++++++++++-------
>   drivers/clk/mediatek/clk-pll.h        |   2 +
>   2 files changed, 87 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
> index 8e09c0f7b7548f8e286671cea2dac64530b8ce47..64cc0c037f62d7eab8d0e7fc00c05d122bf4130c 100644
> --- a/drivers/clk/mediatek/clk-mt8196-mfg.c
> +++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
> @@ -13,6 +13,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   
>   #include "clk-mtk.h"
>   #include "clk-pll.h"
> @@ -38,7 +39,7 @@
>   	    _flags, _rst_bar_mask,				\
>   	    _pd_reg, _pd_shift, _tuner_reg,			\
>   	    _tuner_en_reg, _tuner_en_bit,			\
> -	    _pcw_reg, _pcw_shift, _pcwbits) {			\
> +	    _pcw_reg, _pcw_shift, _pcwbits, _rpm_clks) {	\
>   		.id = _id,					\
>   		.name = _name,					\
>   		.reg = _reg,					\
> @@ -58,26 +59,60 @@
>   		.pcw_shift = _pcw_shift,			\
>   		.pcwbits = _pcwbits,				\
>   		.pcwibits = MT8196_INTEGER_BITS,		\
> +		.rpm_clk_names = _rpm_clks,			\
> +		.num_rpm_clks = ARRAY_SIZE(_rpm_clks),		\
>   	}
>   
> +static const char * const mfgpll_rpm_clk_names[] = {
> +	NULL
> +};
> +
>   static const struct mtk_pll_data mfg_ao_plls[] = {
>   	PLL(CLK_MFG_AO_MFGPLL, "mfgpll", MFGPLL_CON0, MFGPLL_CON0, 0, 0, 0,
> -	    BIT(0), MFGPLL_CON1, 24, 0, 0, 0,
> -	    MFGPLL_CON1, 0, 22),
> +	    BIT(0), MFGPLL_CON1, 24, 0, 0, 0, MFGPLL_CON1, 0, 22,
> +	    mfgpll_rpm_clk_names),
>   };
>   
>   static const struct mtk_pll_data mfgsc0_ao_plls[] = {
>   	PLL(CLK_MFGSC0_AO_MFGPLL_SC0, "mfgpll-sc0", MFGPLL_SC0_CON0,
>   	    MFGPLL_SC0_CON0, 0, 0, 0, BIT(0), MFGPLL_SC0_CON1, 24, 0, 0, 0,
> -	    MFGPLL_SC0_CON1, 0, 22),
> +	    MFGPLL_SC0_CON1, 0, 22, mfgpll_rpm_clk_names),
>   };
>   
>   static const struct mtk_pll_data mfgsc1_ao_plls[] = {
>   	PLL(CLK_MFGSC1_AO_MFGPLL_SC1, "mfgpll-sc1", MFGPLL_SC1_CON0,
>   	    MFGPLL_SC1_CON0, 0, 0, 0, BIT(0), MFGPLL_SC1_CON1, 24, 0, 0, 0,
> -	    MFGPLL_SC1_CON1, 0, 22),
> +	    MFGPLL_SC1_CON1, 0, 22, mfgpll_rpm_clk_names),
>   };
>   
> +struct clk_mt8196_mfg {
> +	struct clk_hw_onecell_data *clk_data;
> +	struct clk_bulk_data *rpm_clks;
> +	unsigned int num_rpm_clks;
> +};
> +
> +static int __maybe_unused clk_mt8196_mfg_resume(struct device *dev)
> +{
> +	struct clk_mt8196_mfg *clk_mfg = dev_get_drvdata(dev);
> +
> +	if (!clk_mfg || !clk_mfg->rpm_clks)
> +		return 0;
> +
> +	return clk_bulk_prepare_enable(clk_mfg->num_rpm_clks, clk_mfg->rpm_clks);
> +}
> +
> +static int __maybe_unused clk_mt8196_mfg_suspend(struct device *dev)
> +{
> +	struct clk_mt8196_mfg *clk_mfg = dev_get_drvdata(dev);
> +
> +	if (!clk_mfg || !clk_mfg->rpm_clks)
> +		return 0;
> +
> +	clk_bulk_disable_unprepare(clk_mfg->num_rpm_clks, clk_mfg->rpm_clks);
> +
> +	return 0;
> +}
> +
>   static const struct of_device_id of_match_clk_mt8196_mfg[] = {
>   	{ .compatible = "mediatek,mt8196-mfgpll-pll-ctrl",
>   	  .data = &mfg_ao_plls },
> @@ -92,35 +127,60 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mfg);
>   static int clk_mt8196_mfg_probe(struct platform_device *pdev)
>   {
>   	const struct mtk_pll_data *plls;
> -	struct clk_hw_onecell_data *clk_data;
> +	struct clk_mt8196_mfg *clk_mfg;
>   	struct device_node *node = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
>   	const int num_plls = 1;
> -	int r;
> +	int r, i;
>   
> -	plls = of_device_get_match_data(&pdev->dev);
> +	plls = of_device_get_match_data(dev);
>   	if (!plls)
>   		return -EINVAL;
>   
> -	clk_data = mtk_alloc_clk_data(num_plls);
> -	if (!clk_data)
> +	clk_mfg = devm_kzalloc(dev, sizeof(*clk_mfg), GFP_KERNEL);
> +	if (!clk_mfg)
>   		return -ENOMEM;
>   
> -	r = mtk_clk_register_plls(&pdev->dev, plls, num_plls, clk_data);
> +	clk_mfg->num_rpm_clks = plls[0].num_rpm_clks;
> +
> +	if (clk_mfg->num_rpm_clks) {
> +		clk_mfg->rpm_clks = devm_kcalloc(dev, clk_mfg->num_rpm_clks,
> +						 sizeof(*clk_mfg->rpm_clks),
> +						 GFP_KERNEL);
> +		if (!clk_mfg->rpm_clks)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < clk_mfg->num_rpm_clks; i++)
> +			clk_mfg->rpm_clks->id = plls[0].rpm_clk_names[i];
> +
> +		r = devm_clk_bulk_get(dev, clk_mfg->num_rpm_clks,
> +				      clk_mfg->rpm_clks);
> +		if (r)
> +			return r;
> +	}
> +
> +	clk_mfg->clk_data = mtk_alloc_clk_data(num_plls);
> +	if (!clk_mfg->clk_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, clk_mfg);
> +	pm_runtime_enable(dev);
> +
> +	r = mtk_clk_register_plls(dev, plls, num_plls, clk_mfg->clk_data);
>   	if (r)
>   		goto free_clk_data;
>   
> -	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
> +				   clk_mfg->clk_data);
>   	if (r)
>   		goto unregister_plls;
>   
> -	platform_set_drvdata(pdev, clk_data);
> -
>   	return r;
>   
>   unregister_plls:
> -	mtk_clk_unregister_plls(plls, num_plls, clk_data);
> +	mtk_clk_unregister_plls(plls, num_plls, clk_mfg->clk_data);
>   free_clk_data:
> -	mtk_free_clk_data(clk_data);
> +	mtk_free_clk_data(clk_mfg->clk_data);
>   
>   	return r;
>   }
> @@ -128,20 +188,26 @@ static int clk_mt8196_mfg_probe(struct platform_device *pdev)
>   static void clk_mt8196_mfg_remove(struct platform_device *pdev)
>   {
>   	const struct mtk_pll_data *plls = of_device_get_match_data(&pdev->dev);
> -	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +	struct clk_mt8196_mfg *clk_mfg = dev_get_drvdata(&pdev->dev);
>   	struct device_node *node = pdev->dev.of_node;
>   
>   	of_clk_del_provider(node);
> -	mtk_clk_unregister_plls(plls, 1, clk_data);
> -	mtk_free_clk_data(clk_data);
> +	mtk_clk_unregister_plls(plls, 1, clk_mfg->clk_data);
> +	mtk_free_clk_data(clk_mfg->clk_data);
>   }
>   
> +static DEFINE_RUNTIME_DEV_PM_OPS(clk_mt8196_mfg_pm_ops,
> +				 clk_mt8196_mfg_suspend,
> +				 clk_mt8196_mfg_resume,
> +				 NULL);
> +
>   static struct platform_driver clk_mt8196_mfg_drv = {
>   	.probe = clk_mt8196_mfg_probe,
>   	.remove = clk_mt8196_mfg_remove,
>   	.driver = {
>   		.name = "clk-mt8196-mfg",
>   		.of_match_table = of_match_clk_mt8196_mfg,
> +		.pm = pm_ptr(&clk_mt8196_mfg_pm_ops),
>   	},
>   };
>   module_platform_driver(clk_mt8196_mfg_drv);
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index 0f2a1d19eea78b7390b221af47016eb9897f3596..82b86b849a67359d8f23d828f50422081c2747e3 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -53,6 +53,8 @@ struct mtk_pll_data {
>   	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
>   	u8 pcw_chg_bit;
>   	u8 fenc_sta_bit;
> +	const char * const *rpm_clk_names;
> +	unsigned int num_rpm_clks;
>   };
>   
>   /*
> 



