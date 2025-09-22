Return-Path: <linux-kernel+bounces-827011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B30B8FE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC7C57A6653
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3E2F5A1E;
	Mon, 22 Sep 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lTQLW89V"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2742F5326;
	Mon, 22 Sep 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535108; cv=none; b=lamOqRJkglgZU39b+avkq+HhtnfaE3oFNoEFV0ZH6judvLKzft7/SDhvu7+yn3HfZp2pFlJmtXxC0/sGRYExBSGfCZl85bsbCncT8vMWJYug0nQ2E4ghr0OJStYK0W6MOu7lkEruAf+gxXCSrmo7Wm5hSFtvI7eKWrVfPlQHqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535108; c=relaxed/simple;
	bh=ZCHyRLM+j9OlCRrd3bKmx78gsMrZ5IafU4Re3JgUqMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NnzfNW3XFjJT6F3OT+y65G135IeK3CUHSF2F7oVnxpIwsZeX1uEwWqI0zOjj0qhbpWkA1NwuYNl3ovYTEqyEyuFf3dVKGDPHaPwpIKFYOHMZhOPuqhUU3bgFLhxhMimJb+f4OvA2DfZhxkyOIBPqqTY6SAQ+i782W951KeSM6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lTQLW89V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758535104;
	bh=ZCHyRLM+j9OlCRrd3bKmx78gsMrZ5IafU4Re3JgUqMI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lTQLW89VcBrKHcN6nJF22Ssn434CXDHE5MA2w9+4kD7D2zedW/k4uAS1VNO+MeL0B
	 cl5AAz9agLrZ4jcXIFcXVWCT5Ii13IHsQ1/g7xM4gjtcLGNT+pc/00FBBj7HbvhYIA
	 tP/mR3Ui6dO49jUwu31gir9RhCQJmYNOKGI33Srb1b+cPrJkLR26YiYLruQI9rhZLx
	 7t1f2O5Pfv5kf5+k9LUYDw7ejcDhn4rlYE35mbn79sCFjvQeywOZ4Hqm/ts+a6adOV
	 X6GW2NUyZtsenotXH8dQbF5NiaaYCAOWm9e2cvCliO0Y3pQdpybwv0OvmJ4V/OnT1j
	 XCs6iZcs7jEPQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1DFB217E0237;
	Mon, 22 Sep 2025 11:58:24 +0200 (CEST)
Message-ID: <371a8b2a-1e89-4735-b8cd-5c00643e9ab6@collabora.com>
Date: Mon, 22 Sep 2025 11:58:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] clk: mediatek: mt7988-infracfg: SPI0 clocks are
 not critical
To: Daniel Golle <daniel@makrotopia.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Sam Shih <sam.shih@mediatek.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <49fb368b4da6f5ed11812dceb45f174ceca8f10a.1758477397.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <49fb368b4da6f5ed11812dceb45f174ceca8f10a.1758477397.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/09/25 19:58, Daniel Golle ha scritto:
> SPI0 clocks have wrongly been marked as critical while, probably due
> to the SPI driver not requesting them. This can (and should) be addressed
> in device tree instead.
> Remove CLK_IS_CRITICAL flag from clocks related to SPI0.
> 

Eh, technically you're right about the Fixes tag - but if there is a problem in the
devicetree and this patch gets backported to older releases, the device gets broken
in all old kernels.

So - I agree with this change and besides, the SPI clocks are correctly declared in
at least mt7988a.dtsi so I don't see this breaking any device in the current kernel
but please, at this point, drop the Fixes tag so that we avoid backports.

Once the tag is removed, you can add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> Fixes: 4b4719437d85 ("clk: mediatek: add drivers for MT7988 SoC")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Patch originally sent 2024-10-31 but never received any feedback.
> 
>   drivers/clk/mediatek/clk-mt7988-infracfg.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> index ef8267319d91..c40e18c27f12 100644
> --- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> @@ -196,12 +196,10 @@ static const struct mtk_gate infra_clks[] = {
>   	GATE_INFRA2(CLK_INFRA_SPINFI, "infra_f_fspinfi", "spinfi_sel", 10),
>   	GATE_INFRA2_FLAGS(CLK_INFRA_66M_NFI_HCK, "infra_hf_66m_nfi_hck", "sysaxi_sel", 11,
>   			  CLK_IS_CRITICAL),
> -	GATE_INFRA2_FLAGS(CLK_INFRA_104M_SPI0, "infra_hf_104m_spi0", "infra_mux_spi0_sel", 12,
> -			  CLK_IS_CRITICAL),
> +	GATE_INFRA2(CLK_INFRA_104M_SPI0, "infra_hf_104m_spi0", "infra_mux_spi0_sel", 12),
>   	GATE_INFRA2(CLK_INFRA_104M_SPI1, "infra_hf_104m_spi1", "infra_mux_spi1_sel", 13),
>   	GATE_INFRA2(CLK_INFRA_104M_SPI2_BCK, "infra_hf_104m_spi2_bck", "infra_mux_spi2_sel", 14),
> -	GATE_INFRA2_FLAGS(CLK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck", "sysaxi_sel", 15,
> -			  CLK_IS_CRITICAL),
> +	GATE_INFRA2(CLK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck", "sysaxi_sel", 15),
>   	GATE_INFRA2(CLK_INFRA_66M_SPI1_HCK, "infra_hf_66m_spi1_hck", "sysaxi_sel", 16),
>   	GATE_INFRA2(CLK_INFRA_66M_SPI2_HCK, "infra_hf_66m_spi2_hck", "sysaxi_sel", 17),
>   	GATE_INFRA2(CLK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi", "sysaxi_sel", 18),


