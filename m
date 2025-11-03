Return-Path: <linux-kernel+bounces-883196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C98C2CBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1CF189B530
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339E30DD1C;
	Mon,  3 Nov 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jzvEqUOn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D330F535
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182864; cv=none; b=TEjMgQvcisf1B7It/NEZvBWQXenF7B/LBPy66MIonnxzTLSSTZokw87z9v0lxmM2336VnR2mzdVPuC3AlwtKpUqWdEXXVt6s8K405F6R//lW4b1/DPI/F0QcNVqWr+RZKnruOnlUlRtcuKvJ09Wi0/fhsh+qyI+qr1Np0YrxR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182864; c=relaxed/simple;
	bh=Fi4+R1Ob18N+hWKOsFjrNw4jSyFKNHKkEG+GMBZjsvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EW/Y/ZBTAemALbQfr2QE18Ebu8/R4WjgUDObOGRzLpbEOwIQbQR4LElxY4kUgEMAEvp6+9lMQ1gNLJitq9bV1XTclqWfpyhrkmWOpEtUnLES5HoXpLGyz1AOIUmZGS4SAW6lK6HDMQL+CYjWR2E1mPsUpxddcbuaPLL0yis19SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jzvEqUOn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762182859;
	bh=Fi4+R1Ob18N+hWKOsFjrNw4jSyFKNHKkEG+GMBZjsvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jzvEqUOnHp5MJRCsQbEcE5I3T47rCyIMaddchuQBJK1HlqfF+m9O6UcJyiT0FskiB
	 paN72tfJGZgGWsCFCl24BrK9Nj3wWE5zoYxct4hL/3AhrkBo7E5VLLfkSenRKspjZ6
	 Hxkq5+ODuoke9HQzEeudTXfuN2rUz0/vQq3CAOGRq+EUTyd10d/o7XRGtJ+2hfKEco
	 bQ4puUQO1AYxi05HXaujHbBEfiYBtjZsxBucnaiVKgbYqRDMB/fBlS05UCFKcedyH/
	 ChuMgmIE1I7ZxvRJVA10cf0WGuxu3JQPbEVOnyhsn0bH2M/rP5mVtBl+2XU+pKGrmS
	 FnIGUQ3uKhXXQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F25A17E00A6;
	Mon,  3 Nov 2025 16:14:19 +0100 (CET)
Message-ID: <7f743fd5-a64f-4378-b8da-198e45fc66e2@collabora.com>
Date: Mon, 3 Nov 2025 16:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] soc: mediatek regulator: Add Support for mt8189
To: "niklaus.liu" <Niklaus.Liu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com, zhigang.qin@mediatek.com,
 sen.chu@mediatek.com
References: <20251103134241.3773-1-Niklaus.Liu@mediatek.com>
 <20251103134241.3773-2-Niklaus.Liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251103134241.3773-2-Niklaus.Liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/11/25 14:42, niklaus.liu ha scritto:
> From: Niklaus Liu <niklaus.liu@mediatek.com>
> 

Please change the title to
"soc: mediatek: mtk-regulator-coupler: Add support for MT8189"

> Enhance the regulator coupler driver to support GPU power control on the
> MediaTek MT8189 platform. This update ensures proper coordination of
> multiple regulators required for GPU operation,improving power management
> and system stability.
> 
> Signed-off-by: Niklaus Liu <niklaus.liu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-regulator-coupler.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
> index 0b6a2884145e..f6e3b2a3a5a8 100644
> --- a/drivers/soc/mediatek/mtk-regulator-coupler.c
> +++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
> @@ -42,6 +42,18 @@ static int mediatek_regulator_balance_voltage(struct regulator_coupler *coupler,
>   	int max_uV = INT_MAX;
>   	int ret;
>   
> +	/*
> +	 * When vsram_gpu is enabled or disabled and the use_count of the
> +	 * vsram_gpu regulator is zero, the regulator coupler driver will
> +	 * execute regulator_do_balance_voltage, which adjusts the vsram_gpu
> +	 * voltage to the minimum value. This may result in vsram_gpu being
> +	 * lower than vgpu. Therefore, when enabling or disabling vsram_gpu,
> +	 * the 8189 temporarily skips the regulator coupler driver's modification
> +	 * of the vsram_gpu voltage.
> +	 */

Looks like you are misconfiguring something here.... VSRAM_GPU on, VGPU off should
not be supported if those are coupled.

It's either both are ON, or both are getting OFF: in case of both being offlined,
it doesn't matter if the voltage is dropping, because the SRAM is getting powered
OFF, as much as the GPU is.

Makes me wonder if you're assigning the power supplies to both of the MFG power
domains *and* to Panfrost (vgpu == mali-supply).

Note that VGPU should be assigned to the outer power domain (the main one, usually
MFG0), and that VSRAM_GPU should be assigned to the inner-next domain (which is
usually MFG1).

Check how it's done in mt8195.dtsi, mt8195-cherry.dtsi :-)

> +	if (of_machine_is_compatible("mediatek,mt8189") && rdev == mrc->vsram_rdev)
> +		return 0;
> +
>   	/*
>   	 * If the target device is on, setting the SRAM voltage directly
>   	 * is not supported as it scales through its coupled supply voltage.
> @@ -148,7 +160,8 @@ static int mediatek_regulator_coupler_init(void)
>   	if (!of_machine_is_compatible("mediatek,mt8183") &&
>   	    !of_machine_is_compatible("mediatek,mt8186") &&
>   	    !of_machine_is_compatible("mediatek,mt8188") &&

Keep entries sorted alphabetically please, 8189 goes here.

Regards,
Angelo

> -	    !of_machine_is_compatible("mediatek,mt8192"))
> +	    !of_machine_is_compatible("mediatek,mt8192") &&
> +	    !of_machine_is_compatible("mediatek,mt8189"))
>   		return 0;
>   
>   	return regulator_coupler_register(&mediatek_coupler.coupler);


