Return-Path: <linux-kernel+bounces-843889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5DBC0800
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6F71897C12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866AA2550A3;
	Tue,  7 Oct 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="maSJV69L"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0B34BA47;
	Tue,  7 Oct 2025 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759822613; cv=none; b=eRMJ2ZwcK0ZqZx5VJxHK03/kTMPqazXmJQSDhcmqEFEf7OLpZerCpDWoOYsMLmwhSWl89mwt0xChrTXnez3sCAfMtt1+itWTtoZAGVwiX7KoRdh2iIpE23xX8uDg1XJnnaAM+cAo1sePo7TcnHadop0ogw9D+x5+nN+NzowO/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759822613; c=relaxed/simple;
	bh=LTwbcNxTatK0DtSUOSCgV0jqks6Qi4GG4tijmgArRBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7wHaUwPD2rwWAjmQtiD7JrSSB+g8A24E4qj+qM/o5moGynCj0KEvd6YklH/Ym4G2QYPdMkIRL/SLhoBbLUFSakK9/eY/jxOpZlFFK5gdPfhGG59+KfQ6oSASU/Ymdtv2IRaAjQe3/SAs3VJA0XB+gx0Yww4TGJscWdeBHDTKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=maSJV69L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759822608;
	bh=LTwbcNxTatK0DtSUOSCgV0jqks6Qi4GG4tijmgArRBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=maSJV69LuPOFXUdiF44lQs299hntSCsAw/7LV6ZQZnlFXkDqcLvcxroWNKNWcosIa
	 9XAXc1XMueNaTqRM0IKcay80bPSH59zL4USNLNvphn+fuao6d9qS5FTPvD3rzufH42
	 q/vB+ghOkQnWoXWLYinDoQaM4Y4ckoVl/U8SwUUGZr72ukRgEH2yaC9YaPgfWSNZqk
	 LFQ9Y3rwLHoC9HuHwzPUYT1LVtPu+cwyzQjfw8kltMTO5GKFu8X4TE5m85lqpPvh3J
	 M1IAplgxaaA3jXzGCoyJ1U0hlciYRf10SBaFm4CdT5jhpyZbbUAYa9LB3M9PPjEl4s
	 XuRdz3sFUEPHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFCD917E0FDB;
	Tue,  7 Oct 2025 09:36:47 +0200 (CEST)
Message-ID: <fade146a-fe6a-47d3-8936-39b355e44216@collabora.com>
Date: Tue, 7 Oct 2025 09:36:47 +0200
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
 <748f1176-c73c-48af-a1af-0b63d088e834@collabora.com>
 <6441788.lOV4Wx5bFT@workhorse> <2164240.KlZ2vcFHjT@workhorse>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2164240.KlZ2vcFHjT@workhorse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/10/25 21:01, Nicolas Frattaroli ha scritto:
> On Wednesday, 1 October 2025 15:17:13 Central European Summer Time Nicolas Frattaroli wrote:
>> On Wednesday, 1 October 2025 13:49:54 Central European Summer Time AngeloGioacchino Del Regno wrote:
>>> Il 29/09/25 14:13, Nicolas Frattaroli ha scritto:
>>>> The mfgpll clocks on mt8196 require that the MFG's EB clock is on if
>>>> their control registers are touched in any way at all.
>>>
>>> ....so, the MFGPLL clocks are children of EB?
>>>
>>> Why are you using such a convoluted way of adding a parent clock to the MFGPLL
>>> instead of just
>>> ---->   `.parent_name = "mfg_eb"`  <-----
>>>
>>> ???????
>>
>> They're not children. A child would mean that they derive their
>> clock rate from the parent clock. This isn't the relationship here
>> though, their clock signal is completely independent of mfg_eb,
>> but the registers they access for clock control depend on mfg_eb to
>> be on. This means that even if mfgpll is off, and something wants to
>> check if they're on or not, the mfg_eb needs to be on for that
>> register access to happen. Similarly, when reconfiguring the mfgpll
>> rate, the clock rate of mfg_eb plays no role. It just needs to be on
>> for the register access.
>>
>> mfg_eb here is a clock that drives a register, the register just
>> happens to be part of a clock controller.
> 
> As a follow-up to this, I've done some experiments now, as Angelo
> let me know that the only way we can know for sure is by observing
> mfgpll working while mfg_eb is off.
> 
> With horrid hacks, I've managed to manufacture a scenario in which
> EB was definitely off, the mfgplls were still on, the GPUEB didn't
> try to ruin the party by fiddling with the mfgpll clock registers,
> and what I got in return was panthor printing errors about its jobs
> timing out, before an SError splat after several timeouts.
> 
> This makes me think that mfg_eb really is a parent of mfgpll, as
> evidently mfgpll didn't seem to be ticking anymore and caused the
> timeouts to happen before something touched unclocked registers
> and caused an SError. Put in glmark2 terms, the horse was no longer
> spinning around its axis, causing much grief.
> 
> The other possibility is, and I think this is quite likely: we are
> modeling the mfgpll power up/down wrong anyway, and always rely on
> the GPUEB to actually do this properly. I've diffed the mfgpll clock
> registers with the GPUEB running and with it not running, here are
> the results in addr u32 u32 u32 u32 format:
> 
> $ diff -u mfgplldump-not-running.txt mfgplldump-running.txt
> --- mfgplldump-not-running.txt  2025-10-06 20:03:11.902125545 +0200
> +++ mfgplldump-running.txt      2025-10-06 20:03:08.457020814 +0200
> @@ -1,5 +1,5 @@
> -4b810000  00000000 0001fc23  00084444 831a0000
> -4b810010  001a0000 00000002  00000048 00000200
> +4b810000  00000000 0001fc23  00084445 031a0000
> +4b810010  001a0000 80000002  00000048 00000200
>   4b810020  00000000 00000000  00000000 00000000
>   4b810030  00000000 00000000  00000000 00000000
>   4b810040  00018000 01ff1a00  00000000 00000000
> @@ -62,8 +62,8 @@
>   4b8103d0  00000000 00000000  00000000 00000000
>   4b8103e0  00000000 00000000  00000000 00000000
>   4b8103f0  00000000 00000000  00000000 00000000
> -4b810400  00000000 0001fc23  00084444 831a0000
> -4b810410  001a0000 00000002  00000048 00000200
> +4b810400  00000000 0001fc23  00084445 031a0000
> +4b810410  001a0000 80000002  00000048 00000200
>   4b810420  00000000 00000000  00000000 00000000
>   4b810430  00000000 00000000  00000000 00000000
>   4b810440  00018000 01ff1a00  00000000 00000000
> @@ -126,8 +126,8 @@
>   4b8107d0  00000000 00000000  00000000 00000000
>   4b8107e0  00000000 00000000  00000000 00000000
>   4b8107f0  00000000 00000000  00000000 00000000
> -4b810800  00000000 0001fc23  00084444 831a0000
> -4b810810  001a0000 00000002  00000048 00000200
> +4b810800  00000000 0001fc23  00084445 031a0000
> +4b810810  001a0000 80000002  00000048 00000200
>   4b810820  00000000 00000000  00000000 00000000
>   4b810830  00000000 00000000  00000000 00000000
>   4b810840  00018000 01ff1a00  00000000 00000000
> 
> Note how bit 31 of MFGPLL*CON3 gets flipped to 1 in the registers
> when the GPUEB is running. Nothing in our code would model it to be
> like this.
> 
> I'll rework the series to just model MFG_EB as a parent. I'll drop the
> bindings patch, but will keep the refactor since it's still useful.
> Then I'll drop the mfgpll RPM patch and make it a fixes patch to add
> the EB parent instead.
> 
> However, I'm not happy about this, because I am quite certain that
> the code here is not all that correct, but we do not have access to
> the documentation to show us how it would be correct, and downstream
> kernels are not of any help either.
> 
> I also can't just adjust the mfgpll stuff to fit the bit writes I
> actually see happening from the EB, because powering off the EB so
> it doesn't try to touch them and then setting those registers right
> again will still leave a gap wherein the register is not correct
> and who knows what happens. Ditto for the regulators. Similarly,
> I can't just try disabling MFG_EB while the EB is running, because
> it will touch the control registers of the clocks and depends on
> MFG_EB for sure, and I can't observe whether MFGPLL is ticking in
> any other way other than looking at whether the GPU is working. Or
> maybe I can and there's some monitor register somewhere, but not
> anywhere I have documentation for.
> 
> I've checked the remaining memory area of the mfgpll clock controllers,
> and found no suspiciously changing values in there that could indicate
> a monitor register that contains the actual pll frequency.
> 

It's possible that there is a specific mode for firmware-control for the PLL, which
makes it "useless" without the EB parent being on - but then since that is not
described in the datasheets we can't really reinvent the wheel here on hypotetical
variations.

This SoC has EB (as much as some other old ones like MT8188/92/95, but since there
we never enabled the GPUEB, we don't really-really-really know) and from your test
the EB is clearly a parent of the MFGPLL... so... like it or not, it is what it is.

Btw, regarding the possibilty of powering on the MFGPLL in some wrong way...

No.

The poweron sequence is correct - as per the datasheets (and matches with other MTK
PLL on/off strategies).

Thanks for doing this crazy test, and thanks for confirming my suspect!

Cheers,
Angelo


>>>
>>>> Failing to ensure
>>>> this results in a pleasant SError interrupt if the EB clock happens to
>>>> be off.
>>>>
>>>> To achieve this, leverage the CCF core's runtime power management
>>>> support. Define the necessary suspend/resume callbacks, add the
>>>> necessary code to get RPM clocks from the DT, and make sure RPM is
>>>> enabled before clock registration happens.
>>>>
>>>> For the RPM callbacks to really make much sense at all, we change the
>>>> drvdata from clk_data to a new private struct, as is common in drivers
>>>> across the Linux kernel.
>>>>
>>>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>>> ---
>>>>    drivers/clk/mediatek/clk-mt8196-mfg.c | 104 +++++++++++++++++++++++++++-------
>>>>    drivers/clk/mediatek/clk-pll.h        |   2 +
>>>>    2 files changed, 87 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
>>>> index 8e09c0f7b7548f8e286671cea2dac64530b8ce47..64cc0c037f62d7eab8d0e7fc00c05d122bf4130c 100644
>>>> --- a/drivers/clk/mediatek/clk-mt8196-mfg.c
>>>> +++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
>>>> @@ -13,6 +13,7 @@
>>>>    #include <linux/of_address.h>
>>>>    #include <linux/of_device.h>
>>>>    #include <linux/platform_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>>    
>>>>    #include "clk-mtk.h"
>>>>    #include "clk-pll.h"
>>>> @@ -38,7 +39,7 @@
>>>>    	    _flags, _rst_bar_mask,				\
>>>>    	    _pd_reg, _pd_shift, _tuner_reg,			\
>>>>    	    _tuner_en_reg, _tuner_en_bit,			\
>>>> -	    _pcw_reg, _pcw_shift, _pcwbits) {			\
>>>> +	    _pcw_reg, _pcw_shift, _pcwbits, _rpm_clks) {	\
>>>>    		.id = _id,					\
>>>>    		.name = _name,					\
>>>>    		.reg = _reg,					\
>>>> @@ -58,26 +59,60 @@
>>>>    		.pcw_shift = _pcw_shift,			\
>>>>    		.pcwbits = _pcwbits,				\
>>>>    		.pcwibits = MT8196_INTEGER_BITS,		\
>>>> +		.rpm_clk_names = _rpm_clks,			\
>>>> +		.num_rpm_clks = ARRAY_SIZE(_rpm_clks),		\
>>>>    	}
>>>>    
>>>> +static const char * const mfgpll_rpm_clk_names[] = {
>>>> +	NULL
>>>> +};
>>>> +
>>>>    static const struct mtk_pll_data mfg_ao_plls[] = {
>>>>    	PLL(CLK_MFG_AO_MFGPLL, "mfgpll", MFGPLL_CON0, MFGPLL_CON0, 0, 0, 0,
>>>> -	    BIT(0), MFGPLL_CON1, 24, 0, 0, 0,
>>>> -	    MFGPLL_CON1, 0, 22),
>>>> +	    BIT(0), MFGPLL_CON1, 24, 0, 0, 0, MFGPLL_CON1, 0, 22,
>>>> +	    mfgpll_rpm_clk_names),
>>>>    };
>>>>    
>>>>    static const struct mtk_pll_data mfgsc0_ao_plls[] = {
>>>>    	PLL(CLK_MFGSC0_AO_MFGPLL_SC0, "mfgpll-sc0", MFGPLL_SC0_CON0,
>>>>    	    MFGPLL_SC0_CON0, 0, 0, 0, BIT(0), MFGPLL_SC0_CON1, 24, 0, 0, 0,
>>>> -	    MFGPLL_SC0_CON1, 0, 22),
>>>> +	    MFGPLL_SC0_CON1, 0, 22, mfgpll_rpm_clk_names),
>>>>    };
>>>>    
>>>>    static const struct mtk_pll_data mfgsc1_ao_plls[] = {
>>>>    	PLL(CLK_MFGSC1_AO_MFGPLL_SC1, "mfgpll-sc1", MFGPLL_SC1_CON0,
>>>>    	    MFGPLL_SC1_CON0, 0, 0, 0, BIT(0), MFGPLL_SC1_CON1, 24, 0, 0, 0,
>>>> -	    MFGPLL_SC1_CON1, 0, 22),
>>>> +	    MFGPLL_SC1_CON1, 0, 22, mfgpll_rpm_clk_names),
>>>>    };
>>>>    
>>>> +struct clk_mt8196_mfg {
>>>> +	struct clk_hw_onecell_data *clk_data;
>>>> +	struct clk_bulk_data *rpm_clks;
>>>> +	unsigned int num_rpm_clks;
>>>> +};
>>>> +
>>>> +static int __maybe_unused clk_mt8196_mfg_resume(struct device *dev)
>>>> +{
>>>> +	struct clk_mt8196_mfg *clk_mfg = dev_get_drvdata(dev);
>>>> +
>>>> +	if (!clk_mfg || !clk_mfg->rpm_clks)
>>>> +		return 0;
>>>> +
>>>> +	return clk_bulk_prepare_enable(clk_mfg->num_rpm_clks, clk_mfg->rpm_clks);
>>>> +}
>>>> +
>>>> +static int __maybe_unused clk_mt8196_mfg_suspend(struct device *dev)
>>>> +{
>>>> +	struct clk_mt8196_mfg *clk_mfg = dev_get_drvdata(dev);
>>>> +
>>>> +	if (!clk_mfg || !clk_mfg->rpm_clks)
>>>> +		return 0;
>>>> +
>>>> +	clk_bulk_disable_unprepare(clk_mfg->num_rpm_clks, clk_mfg->rpm_clks);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static const struct of_device_id of_match_clk_mt8196_mfg[] = {
>>>>    	{ .compatible = "mediatek,mt8196-mfgpll-pll-ctrl",
>>>>    	  .data = &mfg_ao_plls },
>>>> @@ -92,35 +127,60 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mfg);
>>>>    static int clk_mt8196_mfg_probe(struct platform_device *pdev)
>>>>    {
>>>>    	const struct mtk_pll_data *plls;
>>>> -	struct clk_hw_onecell_data *clk_data;
>>>> +	struct clk_mt8196_mfg *clk_mfg;
>>>>    	struct device_node *node = pdev->dev.of_node;
>>>> +	struct device *dev = &pdev->dev;
>>>>    	const int num_plls = 1;
>>>> -	int r;
>>>> +	int r, i;
>>>>    
>>>> -	plls = of_device_get_match_data(&pdev->dev);
>>>> +	plls = of_device_get_match_data(dev);
>>>>    	if (!plls)
>>>>    		return -EINVAL;
>>>>    
>>>> -	clk_data = mtk_alloc_clk_data(num_plls);
>>>> -	if (!clk_data)
>>>> +	clk_mfg = devm_kzalloc(dev, sizeof(*clk_mfg), GFP_KERNEL);
>>>> +	if (!clk_mfg)
>>>>    		return -ENOMEM;
>>>>    
>>>> -	r = mtk_clk_register_plls(&pdev->dev, plls, num_plls, clk_data);
>>>> +	clk_mfg->num_rpm_clks = plls[0].num_rpm_clks;
>>>> +
>>>> +	if (clk_mfg->num_rpm_clks) {
>>>> +		clk_mfg->rpm_clks = devm_kcalloc(dev, clk_mfg->num_rpm_clks,
>>>> +						 sizeof(*clk_mfg->rpm_clks),
>>>> +						 GFP_KERNEL);
>>>> +		if (!clk_mfg->rpm_clks)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		for (i = 0; i < clk_mfg->num_rpm_clks; i++)
>>>> +			clk_mfg->rpm_clks->id = plls[0].rpm_clk_names[i];
>>>> +
>>>> +		r = devm_clk_bulk_get(dev, clk_mfg->num_rpm_clks,
>>>> +				      clk_mfg->rpm_clks);
>>>> +		if (r)
>>>> +			return r;
>>>> +	}
>>>> +
>>>> +	clk_mfg->clk_data = mtk_alloc_clk_data(num_plls);
>>>> +	if (!clk_mfg->clk_data)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dev_set_drvdata(dev, clk_mfg);
>>>> +	pm_runtime_enable(dev);
>>>> +
>>>> +	r = mtk_clk_register_plls(dev, plls, num_plls, clk_mfg->clk_data);
>>>>    	if (r)
>>>>    		goto free_clk_data;
>>>>    
>>>> -	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>>> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
>>>> +				   clk_mfg->clk_data);
>>>>    	if (r)
>>>>    		goto unregister_plls;
>>>>    
>>>> -	platform_set_drvdata(pdev, clk_data);
>>>> -
>>>>    	return r;
>>>>    
>>>>    unregister_plls:
>>>> -	mtk_clk_unregister_plls(plls, num_plls, clk_data);
>>>> +	mtk_clk_unregister_plls(plls, num_plls, clk_mfg->clk_data);
>>>>    free_clk_data:
>>>> -	mtk_free_clk_data(clk_data);
>>>> +	mtk_free_clk_data(clk_mfg->clk_data);
>>>>    
>>>>    	return r;
>>>>    }
>>>> @@ -128,20 +188,26 @@ static int clk_mt8196_mfg_probe(struct platform_device *pdev)
>>>>    static void clk_mt8196_mfg_remove(struct platform_device *pdev)
>>>>    {
>>>>    	const struct mtk_pll_data *plls = of_device_get_match_data(&pdev->dev);
>>>> -	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
>>>> +	struct clk_mt8196_mfg *clk_mfg = dev_get_drvdata(&pdev->dev);
>>>>    	struct device_node *node = pdev->dev.of_node;
>>>>    
>>>>    	of_clk_del_provider(node);
>>>> -	mtk_clk_unregister_plls(plls, 1, clk_data);
>>>> -	mtk_free_clk_data(clk_data);
>>>> +	mtk_clk_unregister_plls(plls, 1, clk_mfg->clk_data);
>>>> +	mtk_free_clk_data(clk_mfg->clk_data);
>>>>    }
>>>>    
>>>> +static DEFINE_RUNTIME_DEV_PM_OPS(clk_mt8196_mfg_pm_ops,
>>>> +				 clk_mt8196_mfg_suspend,
>>>> +				 clk_mt8196_mfg_resume,
>>>> +				 NULL);
>>>> +
>>>>    static struct platform_driver clk_mt8196_mfg_drv = {
>>>>    	.probe = clk_mt8196_mfg_probe,
>>>>    	.remove = clk_mt8196_mfg_remove,
>>>>    	.driver = {
>>>>    		.name = "clk-mt8196-mfg",
>>>>    		.of_match_table = of_match_clk_mt8196_mfg,
>>>> +		.pm = pm_ptr(&clk_mt8196_mfg_pm_ops),
>>>>    	},
>>>>    };
>>>>    module_platform_driver(clk_mt8196_mfg_drv);
>>>> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
>>>> index 0f2a1d19eea78b7390b221af47016eb9897f3596..82b86b849a67359d8f23d828f50422081c2747e3 100644
>>>> --- a/drivers/clk/mediatek/clk-pll.h
>>>> +++ b/drivers/clk/mediatek/clk-pll.h
>>>> @@ -53,6 +53,8 @@ struct mtk_pll_data {
>>>>    	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
>>>>    	u8 pcw_chg_bit;
>>>>    	u8 fenc_sta_bit;
>>>> +	const char * const *rpm_clk_names;
>>>> +	unsigned int num_rpm_clks;
>>>>    };
>>>>    
>>>>    /*
>>>>
>>>
>>>
>>>
>>
>>
> 
> 
> 
> 

