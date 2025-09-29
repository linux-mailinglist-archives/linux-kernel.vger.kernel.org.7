Return-Path: <linux-kernel+bounces-836165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A7BA8EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA461691FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA282FBE03;
	Mon, 29 Sep 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a18tkNhs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD092F25FC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142851; cv=none; b=MhX6F7DUnE3ggg8YjsQA1zfIqoyNYHjBzYeBWRZq+Ie8oNN9KtrK9HG+xITgJRA9F2CIYwkFrNLhdzawqMuVAVAgw9yFV0tG2e2rUa0vUlxDkMiGPMRYaOLKeJWH2c1efZRgW+leo1WD5sDd/YCvRVOA9LrXGrFAvoMqpuAS3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142851; c=relaxed/simple;
	bh=3KmaPLC7fpBhdiaNP8bZ9DxwULE49IaCJfAvqvOZqCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRBDNpCb49NtSmHcV1dgGw74b0lQaW1X7O1C4OcrYHdY0wwn9pm/qETt/hUoRwBRTZPHsgQqWC76GN51PRX0y6U3Ybs1ko/f3T2Ix1q/NFLisH3Q6h8kw6fs3ZCrg51mo64jebNdYrEDpXqN8djavOQnQGuwh2nNi34ol21cTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a18tkNhs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759142847;
	bh=3KmaPLC7fpBhdiaNP8bZ9DxwULE49IaCJfAvqvOZqCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a18tkNhs8rEVCzUajMFURtTiYu4uii4sccPRHMv5nnFwxi7/UthxKEr1Tdkvv83S0
	 bLDSJCQ+rYDdrISBVqbUnxFUaU/yNfediqXKLYxH1x8EARDOlXjAIrVqM9b+CMk6JX
	 fwAoo07WUL3604SqoyPHJLGaa5wkgTruAvMHXdZoLwBMC7Pbz+kOqj79XdA8LMVgXC
	 iJbsJUaavV8F1TXVS7q1cJ49lTnPZ7ZCETN5+alcs7bj0c1pfAo0C8IscgWxFBb8Vu
	 9K3Td/ZcHVwbqLlSLFg8nmZ41jR4ttUdibT7Z8IAlABo4S+sV6hNZIXT2+aqKU6ElY
	 NGXvTt0KHBMWw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4286417E003B;
	Mon, 29 Sep 2025 12:47:27 +0200 (CEST)
Message-ID: <e9992ba9-bf5b-4533-948a-e19778bb6f50@collabora.com>
Date: Mon, 29 Sep 2025 12:47:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: Use devm_alloc for clk_data allocation to
 fix memory leak on probe error
To: Haotian Zhang <vulab@iscas.ac.cn>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250929023621.1968-1-vulab@iscas.ac.cn>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250929023621.1968-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/09/25 04:36, Haotian Zhang ha scritto:
> The probe functions for the mt6765 apmixed, top, and infrasys clocks
> use mtk_alloc_clk_data() to allocate memory. This requires manual
> freeing of the memory in all error handling paths and in the driver's
> remove function.
> 
> Switch to mtk_devm_alloc_clk_data() in order to fix the memory leak in the
> probe function.
> 
> Fixes: 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

You have to resend this to the correct recipients, and you have to fix the
commit title; something like

clk: mediatek: mt6765: Switch to mtk_devm_alloc_clk_data to fix memleak

For the code:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregnoòcollabora.com>

> ---
>   drivers/clk/mediatek/clk-mt6765.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
> index d53731e7933f..5cfb9a3a5ee3 100644
> --- a/drivers/clk/mediatek/clk-mt6765.c
> +++ b/drivers/clk/mediatek/clk-mt6765.c
> @@ -736,7 +736,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +	clk_data = mtk_devm_alloc_clk_data(CLK_APMIXED_NR_CLK);
>   	if (!clk_data)
>   		return -ENOMEM;
>   
> @@ -770,7 +770,7 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +	clk_data = mtk_devm_alloc_clk_data(CLK_TOP_NR_CLK);
>   	if (!clk_data)
>   		return -ENOMEM;
>   
> @@ -810,7 +810,7 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
> +	clk_data = mtk_devm_alloc_clk_data(CLK_IFR_NR_CLK);
>   	if (!clk_data)
>   		return -ENOMEM;
>   



