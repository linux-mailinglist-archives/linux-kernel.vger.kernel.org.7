Return-Path: <linux-kernel+bounces-884916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50908C317E2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0B1B348F92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8636632C942;
	Tue,  4 Nov 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cg1qWtq9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501792EBDCB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266259; cv=none; b=KRbaND9LY3eYbZsxT9ZWlsrATDufrQoyffFsAwoVUGFo3RtQneam7PMeFjgxwVKZqOCUD+rgS56T1RyagxQOUOeDYU1606RqnFiXfWFxqQ66uZot6dxnQoR/qclSkBbvIvO4obPSKq3gSq8hAkpHMvlprR6R7R47B9KxmS9atOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266259; c=relaxed/simple;
	bh=lGfuQV2S/g+wlL+QpilQu5Ha+EG82kPQCE+jmEMzG9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEr43RHPBa+wXKb+6c27vtaSImN3FvjS4+6xbH2yMXM0K+G9eQ/ihiFsG0/07CDiuHlYmq5uah9WGNLtogrPBuraIBNUdOSYXIP/WRfF21L/ZPaKmipD+uSL2sStjkS88KGn1mlh3ZEWTku/4k6RP1gNpua5zfoDybtH7gHracQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cg1qWtq9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762266255;
	bh=lGfuQV2S/g+wlL+QpilQu5Ha+EG82kPQCE+jmEMzG9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cg1qWtq9S+mmImzto0dgoNbpvvRgaV6OlSefpWB1OjUhv9lHNPJdDPs8WZKolG1cF
	 UtHdKs8zAxV8LxBJ6fXecuM9rkRH/TG/LIh18OLeWvN2zxAgbyWnnUn0j+hLyb4tzJ
	 gsD05CyQdKSCl/ygm6l0/P38uQFrPypZ3muk41IICy1Z7GaPjps7u6ufI/QDB1A1p0
	 UfmwQrwtuoRcPl+52HWtO7RssJFNGuPg8gp4FZb19xGSJfgZsEHBtvoMcsncqoYPSV
	 aMQGqVKIUCpLrS7oxmBzAiZz206AEUJ9F+6vZeoLL+Y2ra54hHTpcwg3PV18TWvuRt
	 7HpiVu3Icqvqg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C70A17E1249;
	Tue,  4 Nov 2025 15:24:15 +0100 (CET)
Message-ID: <542ceb46-0b57-4cd1-a679-ec55457043ae@collabora.com>
Date: Tue, 4 Nov 2025 15:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/1] soc: mediatek: mtk-regulator-coupler: Add support
 for MT8189
To: "niklaus.liu" <Niklaus.Liu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com, zhigang.qin@mediatek.com,
 sen.chu@mediatek.com
References: <20251104071252.12539-1-Niklaus.Liu@mediatek.com>
 <20251104071252.12539-2-Niklaus.Liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251104071252.12539-2-Niklaus.Liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/11/25 08:12, niklaus.liu ha scritto:
> From: Niklaus Liu <niklaus.liu@mediatek.com>
> 
> Enhance the regulator coupler driver to support GPU power control on the
> MediaTek MT8189 platform. This update ensures proper coordination of
> multiple regulators required for GPU operation,improving power management
> and system stability.
> 
> Signed-off-by: Niklaus Liu <niklaus.liu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
> index 0b6a2884145e..e2a1fb459e42 100644
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

This will break the rules of your own hardware. Seriously.

The VSRAM_GPU has to be set in a specific range, where the minimum voltage has to
guarantee that the GPU can run in the first quarter of the OPP entries (which does
always correspond to lowest/lower/low or lowest/low) for the GPU.

If you return zero here, and VSRAM_GPU was set to Vmax (scenario: GPU was at Turbo
frequency) before shutting down completely (ex.: system suspend), at device resume
time, the VSRAM_GPU rail will be overvolting the GPU SRAM.

While that won't cause any "magic smoke" because the VSRAM is still in the maximum
operating ranges constraint, this will leak power, hence increase the chip's heat
output, and might as well create possible instabilities.

Remember that the GPU SRAM voltage has to *always be constrained* as:
  - VSRAM <= VGPU when VGPU must be over the VSRAM constraint
  - VSRAM == VGPU if the voltages are in range between each other
  - VSRAM > VGPU *only* for SLEEP (or LOWEST) freq setting

As I already said in my previous review for this patch, your devicetree may be
misconfiguring the regulators, or their hierarchy (as those are MFG0/1+Panfrost).

Besides, are you testing this on Panfrost, even, or on the Mali DDK driver?
That really doesn't look right.

Also - MT8189 is not special. There's nothing different between MT8189 and the
others in regard to how the GPU regulators should be coupled, and in regard to
their constraints relationship.

Regards,
Angelo

> +	if (of_machine_is_compatible("mediatek,mt8189") && rdev == mrc->vsram_rdev)
> +		return 0;
> +
>   	/*
>   	 * If the target device is on, setting the SRAM voltage directly
>   	 * is not supported as it scales through its coupled supply voltage.
> @@ -148,6 +160,7 @@ static int mediatek_regulator_coupler_init(void)
>   	if (!of_machine_is_compatible("mediatek,mt8183") &&
>   	    !of_machine_is_compatible("mediatek,mt8186") &&
>   	    !of_machine_is_compatible("mediatek,mt8188") &&
> +	    !of_machine_is_compatible("mediatek,mt8189") &&

(but this is ok here)

>   	    !of_machine_is_compatible("mediatek,mt8192"))
>   		return 0;
>   


