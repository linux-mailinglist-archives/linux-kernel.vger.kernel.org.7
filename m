Return-Path: <linux-kernel+bounces-846445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C013BC807F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC77422798
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14222D1F61;
	Thu,  9 Oct 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fgFtgjAy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AD2D0C70;
	Thu,  9 Oct 2025 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998153; cv=none; b=NIIweqlf0V925krSCsKgFFTY22BQAQ7c2RwmG1QKEzEAuadNbCFGEcPPjHnhLuX37aEmpWUQtHzhyrRyvsOnbvTCsftBzhsaIxLkQ0RxmHaOKaE6vBhly45yX202VdivZg7lxWwgPMH1WmVmkIolD5EnTRw5Zdr3pM4QlNy5ZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998153; c=relaxed/simple;
	bh=RwXOzAEExmYYK2xWJ/GpwNUlwCJM7Pp4R1DD5Pw3L1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKUKBuSMLuMjmRz7V9eM+0GVF1Clr4dFyhkc8ZrtyqeyPA3K822M3PCvQ2DCwgqcIWFDBQekSY8CnVCC2NvmIrBlD4sl06tRaHG16Kk+3H3Y6UBck863srqaUf40jJibeuYzIn2c27i2kVQlwfRrdaCmq4nylyVP4uwZvAyYWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fgFtgjAy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759998149;
	bh=RwXOzAEExmYYK2xWJ/GpwNUlwCJM7Pp4R1DD5Pw3L1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fgFtgjAyu6QL1QdsnIAhHguOzXtqSBdlRXBxbEegyAgyTRV3Zi9Ww9p0/RboDVFs5
	 ObdmYZ+uawvyAuTKsB4HGLZf8P+rYD5XZNAs+HdJu8TZe0Rb/WyUivwmsOcoRvZtJf
	 in2KU9oWjEhG7RrqCN4Uubl9vB9TVSQKOl38kQ7NvcEq628ziYoU8BoZygCtdiYacz
	 RAKrdXNrG7naXh+fULsQMIkrTLUGzUHh0WSloSSALUwSnsS5AaIh0bOxYmxgE8huVH
	 leaLQVfdvgDWpR3IgRB6Ec1aYrtvAcDplcFQDpF7pVwAO/eE5gM7WHnt+Lszo5ZtHe
	 fZ6glFgpx1wNA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C660817E1060;
	Thu,  9 Oct 2025 10:22:28 +0200 (CEST)
Message-ID: <6d3e4b81-b8fc-45b3-a12f-b8492d8dc892@collabora.com>
Date: Thu, 9 Oct 2025 10:22:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] clk: mediatek: Add mfg_eb as parent to mt8196
 mfgpll clocks
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
 <20251008-mtk-pll-rpm-v2-5-170ed0698560@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251008-mtk-pll-rpm-v2-5-170ed0698560@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/25 18:05, Nicolas Frattaroli ha scritto:
> All the MFGPLL require MFG_EB to be on for any operation on them, and
> they only tick when MFG_EB is on as well, therefore making this a
> parent-child relationship.
> 
> This dependency wasn't clear during the initial upstreaming of these
> clock controllers, as it only made itself known when I could observe
> the effects of the clock by bringing up a different piece of hardware.
> 
> Add a new PLL_PARENT_EN flag to mediatek's clk-pll.h, and check for it
> when initialising the pll to then translate it into the actual
> CLK_OPS_PARENT_ENABLE flag.
> 
> Then add the mfg_eb parent to the mfgpll clocks, and set the new
> PLL_PARENT_EN flag.
> 
> Fixes: 03dc02f8c7dc ("clk: mediatek: Add MT8196 mfg clock support")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   drivers/clk/mediatek/clk-mt8196-mfg.c | 3 ++-
>   drivers/clk/mediatek/clk-pll.c        | 3 +++
>   drivers/clk/mediatek/clk-pll.h        | 1 +
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
> index 8e09c0f7b7548f8e286671cea2dac64530b8ce47..de6f426f148184e1bb95b5cfca590b1763fc0573 100644
> --- a/drivers/clk/mediatek/clk-mt8196-mfg.c
> +++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
> @@ -45,7 +45,7 @@
>   		.en_reg = _en_reg,				\
>   		.en_mask = _en_mask,				\
>   		.pll_en_bit = _pll_en_bit,			\
> -		.flags = _flags,				\
> +		.flags = (_flags) | PLL_PARENT_EN,		\

In the event that we may want, one day, maybe commonize the PLL macro to all of the
PLL drivers, can you please add the PLL_PARENT_EN to the three clocks instead of
doing it in the macro itself?

static const struct mtk_pll_data mfg_ao_plls[] = {
	PLL(CLK_MFG_AO_MFGPLL, "mfgpll", MFGPLL_CON0, MFGPLL_CON0, 0, 0,
	    PLL_PARENT_EN, BIT(0), MFGPLL_CON1, 24, 0, 0, 0,
	    MFGPLL_CON1, 0, 22),
};

static const struct mtk_pll_data mfgsc0_ao_plls[] = {
	PLL(CLK_MFGSC0_AO_MFGPLL_SC0, "mfgpll-sc0", MFGPLL_SC0_CON0,
	    MFGPLL_SC0_CON0, 0, 0, PLL_PARENT_EN, BIT(0),
	    MFGPLL_SC0_CON1, 24, 0, 0, 0, MFGPLL_SC0_CON1, 0, 22),
};

static const struct mtk_pll_data mfgsc1_ao_plls[] = {
	PLL(CLK_MFGSC1_AO_MFGPLL_SC1, "mfgpll-sc1", MFGPLL_SC1_CON0,
	    MFGPLL_SC1_CON0, 0, 0, PLL_PARENT_EN, BIT(0),
	    MFGPLL_SC1_CON1, 24, 0, 0, 0, MFGPLL_SC1_CON1, 0, 22),
};


After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   		.rst_bar_mask = _rst_bar_mask,			\
>   		.fmax = MT8196_PLL_FMAX,			\
>   		.fmin = MT8196_PLL_FMIN,			\
> @@ -58,6 +58,7 @@
>   		.pcw_shift = _pcw_shift,			\
>   		.pcwbits = _pcwbits,				\
>   		.pcwibits = MT8196_INTEGER_BITS,		\
> +		.parent_name = "mfg_eb",			\
>   	}
>   
>   static const struct mtk_pll_data mfg_ao_plls[] = {
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index c4f9c06e5133dbc5902f261353c197fbde95e54d..0f3759fcd9d0228c23f4916d041d17b731a6c838 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -359,6 +359,9 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
>   
>   	init.name = data->name;
>   	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
> +	if (data->flags & PLL_PARENT_EN)
> +		init.flags |= CLK_OPS_PARENT_ENABLE;
> +
>   	init.ops = pll_ops;
>   	if (data->parent_name)
>   		init.parent_names = &data->parent_name;
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index 0f2a1d19eea78b7390b221af47016eb9897f3596..492cad8ff80ba31a78a96085285cb938e9b978e9 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -21,6 +21,7 @@ struct mtk_pll_div_table {
>   
>   #define HAVE_RST_BAR	BIT(0)
>   #define PLL_AO		BIT(1)
> +#define PLL_PARENT_EN	BIT(2)
>   #define POSTDIV_MASK	GENMASK(2, 0)
>   
>   struct mtk_pll_data {
> 


