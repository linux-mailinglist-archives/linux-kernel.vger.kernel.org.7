Return-Path: <linux-kernel+bounces-735136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0FBB08B59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E537BBEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412129B799;
	Thu, 17 Jul 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="afqILlfA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2459299955;
	Thu, 17 Jul 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749373; cv=none; b=j23YMIhYJgqIHa4OZ0yhnz32u1i9K7CX7cYerGXUwHq9HUUq6VeO7dgj2lbvcg75ARznwE3UNDDGi46g5bLtIh3uAqIaMe1qcrV7rNNDEi3dimmFogJM7UYHRIFyqybunXqqK2BlYBFiHejWUUOM6rVOj1EHZpUn58ZLAn52x20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749373; c=relaxed/simple;
	bh=lSP0/9GbrNfw0NFb6DWBwXGSVoqPXgSk/vHOEKnsPg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EshIOyAhAdx2J2EbpSnfWy9zduGW2hTrKvs3+SxvywH1BeI2eCvot0LvDlwu3zQnAi8fN1Y2MbNNl2Q4TnjqC/vKiU7AgaZeqWAlAvFS+0gYU4kakFaRUrCqgfOYj7MVcEg9F3gv/A1Isrl+AoOohixVQrHvuZzcP9NmfdwIgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=afqILlfA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752749368;
	bh=lSP0/9GbrNfw0NFb6DWBwXGSVoqPXgSk/vHOEKnsPg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=afqILlfAdc29dXdjkvF4I3YSbufR0yN5zVs7ZWdCQnSNZrXwIiIA4WW9e1PQ/k43p
	 Df1AEB2qgK1CcIC2XuMPGOq9i8MF1PgD9lXMQFMyfHMy2qs2lYKYLkDmM6v0Us/shN
	 DeZgcw8OSfYG3OVsnu4GAfPh22EEkfQwIerr8K2enqKMerzEu+rty9auXYe9uCeihA
	 xDeE/B9ljTejzYjPTj+lWQyrWh+2TTo1hlFb/5Ahd9q6yRn0Z8nVafoUvgo1a4iuez
	 mm2tuRwf/QUSDWqydPf4JT/ZMW8F76gshZk4c96BmE7M0kUvnAbtKZ8fWuWGawmgNh
	 khghTJQCBNxeg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EE95F17E0C37;
	Thu, 17 Jul 2025 12:49:27 +0200 (CEST)
Message-ID: <327287aa-98c8-4745-adb9-2c36e8d5d825@collabora.com>
Date: Thu, 17 Jul 2025 12:49:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] clk: mediatek: Add MT6789 clock controllers
To: Arseniy Velikanov <me@adomerle.pw>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20250715222221.29406-1-me@adomerle.pw>
 <20250715222221.29406-2-me@adomerle.pw>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250715222221.29406-2-me@adomerle.pw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/07/25 00:22, Arseniy Velikanov ha scritto:
> Add support for MT6789 clock controllers, which includes apmixed, afe,
> camsys, imgsys, infracfg, mcusys, mdpsys, mfgcfg, mmsys, topckgen,
> vdec, venc.
> 
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>

Hi Arseniy,
Thanks for all this work!

The submission looks generally fine, and I'm happy that you've ported those drivers
to the common probe, however, there are a few (relatively small) things to fixup.

Please check below.

> ---
>   drivers/clk/mediatek/Kconfig                  |  68 ++
>   drivers/clk/mediatek/Makefile                 |  11 +
>   drivers/clk/mediatek/clk-mt6789-apmixed.c     | 147 +++
>   drivers/clk/mediatek/clk-mt6789-audiosys.c    | 100 +++
>   drivers/clk/mediatek/clk-mt6789-cam.c         | 131 +++
>   drivers/clk/mediatek/clk-mt6789-img.c         | 100 +++
>   .../clk/mediatek/clk-mt6789-imp_iic_wrap.c    |  90 ++
>   drivers/clk/mediatek/clk-mt6789-infra_ao.c    | 228 +++++
>   drivers/clk/mediatek/clk-mt6789-mcu.c         |  68 ++
>   drivers/clk/mediatek/clk-mt6789-mdp.c         |  81 ++
>   drivers/clk/mediatek/clk-mt6789-mfgcfg.c      |  61 ++
>   drivers/clk/mediatek/clk-mt6789-mm.c          |  85 ++
>   drivers/clk/mediatek/clk-mt6789-topckgen.c    | 846 ++++++++++++++++++
>   drivers/clk/mediatek/clk-mt6789-vdec.c        | 119 +++
>   drivers/clk/mediatek/clk-mt6789-venc.c        |  65 ++
>   15 files changed, 2200 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-apmixed.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-audiosys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-cam.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-img.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-infra_ao.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-mcu.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-mdp.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-mfgcfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-mm.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-topckgen.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-vdec.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6789-venc.c
> 

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt6789-topckgen.c b/drivers/clk/mediatek/clk-mt6789-topckgen.c
> new file mode 100644
> index 000000000000..bd986e861eb4
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6789-topckgen.c
> @@ -0,0 +1,846 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
> + */

..snip..


 > +static const struct mtk_fixed_factor top_divs[] = {
 > +	FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", "mfgpll", 1, 1),

..snip..

 > +	FACTOR(CLK_TOP_F26M, "f26m_ck", "clk26m", 1, 1),
 > +	FACTOR(CLK_TOP_AXI, "axi_ck", "axi_sel", 1, 1),
 > +	FACTOR(CLK_TOP_DISP, "disp_ck", "disp_sel", 1, 1),

Please, remove all instances of FACTOR(.... 1, 1) and use the right parent directly
for the other clocks.

The factor(1,1) means clock_rate * 1 / 1 == clock_rate.

I'm not sure why MediaTek likes to declare these - they are doing that in newer
SoCs as well, but that's not for upstream: it does not make any sense to have those
clocks in the driver, as those are effectively just name wrappers and nothing else.

The only thing those do is increasing the footprint for, well, no good reason...!

There's a pattern that you want to check: all of the "_ck" clocks are suspect! :-)

 > +	FACTOR(CLK_TOP_MDP, "mdp_ck", "mdp_sel", 1, 1),
 > +	FACTOR(CLK_TOP_IMG1, "img1_ck", "img1_sel", 1, 1),
 > +	FACTOR(CLK_TOP_IPE, "ipe_ck", "ipe_sel", 1, 1),
 > +	FACTOR(CLK_TOP_CAM, "cam_ck", "cam_sel", 1, 1),
 > +	FACTOR(CLK_TOP_MFG_REF, "mfg_ref_ck", "mfg_ref_sel", 1, 1),
 > +	FACTOR(CLK_TOP_MFG_PLL, "mfg_pll_ck", "mfg_pll_sel", 1, 1),

..snip..

> +
> +static const char * const dvfsrc_parents[] = {
> +	"tck_26m_mx9_ck",
> +	"osc_d10"
> +};
> +
> +static const char * const aes_msdcfde_parents[] = {
> +	"tck_26m_mx9_ck",
> +	"mainpll_d4_d2",
> +	"mainpll_d6",
> +	"mainpll_d4_d4",
> +	"univpll_d4_d2",
> +	"univpll_d6"
> +};
> +
> +static const char * const mcupm_parents[] = {
> +	"tck_26m_mx9_ck",
> +	"mainpll_d6_d4",
> +	"mainpll_d6_d2"
> +};
> +
> +static const char * const dsi_occ_parents[] = {
> +	"tck_26m_mx9_ck",
> +	"mainpll_d6_d2",
> +	"univpll_d5_d2",
> +	"univpll_d4_d2"
> +};
> +

Look at those parents, you're redefining the very same identical array 10 times
in a row!

Please, avoid this kind of duplication: delete all the duplicated arrays and
just have one called, for example, "apll_i2s_mck_parents", then assign that
to all of the relevant clocks.

Same goes for camtg and others :-)

> +static const char * const apll_i2s0_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s1_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s2_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s3_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s4_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s5_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s6_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s7_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s8_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};
> +
> +static const char * const apll_i2s9_mck_parents[] = {
> +	"aud_1_sel",
> +	"aud_2_sel"
> +};

..snip..

> +module_platform_driver(clk_mt6789_topckgen_drv);
> +
> +MODULE_DESCRIPTION("MediaTek MT6789 top clock generators driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt6789-vdec.c b/drivers/clk/mediatek/clk-mt6789-vdec.c
> new file mode 100644
> index 000000000000..81d6e720b6cd
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6789-vdec.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Copyright (c) 2025 Arseniy Velikanov <me@adomerle.pw>
> + */
> +

..snip..

> +
> +static const struct mtk_clk_desc vde2_desc = {
> +	.clks = vde2_clks,
> +	.num_clks = ARRAY_SIZE(vde2_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt6789_vdec[] = {

Can you please compress all of those?

static const struct of_device_id of_match_clk_mt6789_vdec[] ={
	{ .compatible = "mediatek,mt6789-vdecsys", .data = &vde2_desc },
	{ /* sentinel */ }
};


Note that the same comments do apply to other clock drivers that you're introducing
but I'm only writing once - please apply the comments in the others and wherever
they fit.

Cheers!
Angelo

