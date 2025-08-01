Return-Path: <linux-kernel+bounces-753012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1A9B17DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349B63BD214
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD56202C30;
	Fri,  1 Aug 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CGvqrRC1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE71FE451;
	Fri,  1 Aug 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033947; cv=none; b=t+DZ8ujvDSWqG6WvvKWn8lA35W8luRIoONQsI8UyBWRRG37j9fSYau0dJcgswxjHxN/eiAjkLbhDzoRrrWqDV2EdaT/E8Pd04O2mIJ0jBjuAMQreRR/QTRSTTMRf13b2QGddwuWByMlkxB+Qxa/h1fZS8pa2vp7kt5YHnTrSxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033947; c=relaxed/simple;
	bh=wAiPTqgnauUCUB9qcLcvnu642yRlTqzNKg/FCLXG3hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDYv0B3sORebq/YbQGL2z0RMBtv0gcYaf/GhS+wE4pQ6XXUCL6TyOddbDkTWQQk856PJ4PF457BeFnhBkNCjA9M0g0aFs3IEbMwVLp+H5ezY9vk/Of+Yh6rvN2OErSy4SpAeit8W5szTSs8hbRnGTrZznsOz49/+dw6ILFRUwdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CGvqrRC1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033944;
	bh=wAiPTqgnauUCUB9qcLcvnu642yRlTqzNKg/FCLXG3hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CGvqrRC11iEJ2l+58kHuA3tF7uQu74MzunG8cZcQ0+6z8Ggxki17DOYY4LX3MvqgO
	 wV8P8NPAHQpy0rZyOSwe3NLVhQhg82zoJnIwnm0cM6qga9YySzWL/KRuhunzPerzsg
	 1vCNLWUp9Ro9rndQThheFpX67sn6oS4EtbJsS4qvTPhOf8q9Nn4xeEtsC8mHYKlNQK
	 Gi9xY+EsIDII0tOrshYm4xWcbRJZDg2bMtV2c31hzYn+PGcBUFnOAZE2wzPRYgwlF+
	 KY7uB0wAiH7BPKqWlXVo2wLQT1EsjZQiH+Bpxh1Ke7FFPsGmzSArfgK3Mm9pCso4MI
	 wTQrugt6vGF5g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C55617E0202;
	Fri,  1 Aug 2025 09:39:03 +0200 (CEST)
Message-ID: <9b70908a-d664-4f2c-8fd1-3ca280fe7381@collabora.com>
Date: Fri, 1 Aug 2025 09:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc:mediatek mt8189: Porting driver for spmi/pwrap
To: "niklaus.liu" <niklaus.liu@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250801070913.3109-1-niklaus.liu@mediatek.com>
 <20250801070913.3109-3-niklaus.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250801070913.3109-3-niklaus.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/08/25 08:39, niklaus.liu ha scritto:
> Modify spmi/pwrap driver for mt8189
> 
> Signed-off-by: niklaus.liu <niklaus.liu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 27 +++++++++++++++++++++++++++
>   drivers/spmi/spmi-mtk-pmif.c         |  3 +++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 0bcd85826375..e3e8234e29a0 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1087,6 +1087,17 @@ static const int mt8183_regs[] = {
>   	[PWRAP_WACS2_VLDCLR] =			0xC28,
>   };
>   
> +static int mt8189_regs[] = {
> +	[PWRAP_INIT_DONE2] =		0x0,
> +	[PWRAP_TIMER_EN] =		0x3e4,
> +	[PWRAP_INT_EN] =		0x450,
> +	[PWRAP_WACS2_CMD] =		0x880,
> +	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
> +	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
> +	[PWRAP_WACS2_VLDCLR] =		0x8a4,
> +	[PWRAP_WACS2_RDATA] =		0x8a8,
> +};

You can fully reuse mt8195_regs, as mt8189 has the same layout.

> +
>   static const int mt8195_regs[] = {
>   	[PWRAP_INIT_DONE2] =		0x0,
>   	[PWRAP_STAUPD_CTRL] =		0x4C,
> @@ -1324,6 +1335,7 @@ enum pwrap_type {
>   	PWRAP_MT8173,
>   	PWRAP_MT8183,
>   	PWRAP_MT8186,
> +	PWRAP_MT8189,
>   	PWRAP_MT8195,
>   	PWRAP_MT8365,
>   	PWRAP_MT8516,
> @@ -1854,6 +1866,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   		break;
>   	case PWRAP_MT6873:
>   	case PWRAP_MT8183:
> +	case PWRAP_MT8189:
>   	case PWRAP_MT8195:
>   		break;
>   	}
> @@ -2393,6 +2406,19 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
>   	.init_soc_specific = pwrap_mt8183_init_soc_specific,
>   };
>   
> +static struct pmic_wrapper_type pwrap_mt8189 = {
> +	.regs = mt8189_regs,
> +	.type = PWRAP_MT8189,
> +	.arb_en_all = 0x777f,
> +	.int_en_all = 0x180000,
> +	.int1_en_all = 0,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.caps = PWRAP_CAP_ARB,

Why are you avoiding to enable the INT1 interrupt on MT8189?

Is this working around a hardware bug, or did you simply forget to enable it?
I think you should really enable it, which means....

> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>   static const struct pmic_wrapper_type pwrap_mt8195 = {
>   	.regs = mt8195_regs,
>   	.type = PWRAP_MT8195,
> @@ -2456,6 +2482,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>   	{ .compatible = "mediatek,mt8173-pwrap", .data = &pwrap_mt8173 },
>   	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
>   	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
> +	{ .compatible = "mediatek,mt8189-pwrap", .data = &pwrap_mt8189 },

...means that you don't even need to add a new compatible in this list, because
the MT8195 compatible can be reused.

You only have to add the MT8189 compatible to the bindings, so that you are
allowed to specify in your devicetree node

compatible = "mediatek,mt8189-pwrap", "mediatek,mt8195-pwrap";

>   	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
>   	{ .compatible = "mediatek,mt8365-pwrap", .data = &pwrap_mt8365 },
>   	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> index 160d36f7d238..00420568afef 100644
> --- a/drivers/spmi/spmi-mtk-pmif.c
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -530,6 +530,9 @@ static const struct of_device_id mtk_spmi_match_table[] = {
>   	{
>   		.compatible = "mediatek,mt6873-spmi",
>   		.data = &mt6873_pmif_arb,
> +	}, {
> +		.compatible = "mediatek,mt8189-spmi",
> +		.data = &mt8195_pmif_arb,

This change is useless. Just add the compatible to the bindings so that you
can specify

compatible = "mediatek,mt8189-spmi", "mediatek,mt8195-spmi";

Regards,
Angelo

