Return-Path: <linux-kernel+bounces-838817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB051BB0366
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F4B1887A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A882D6605;
	Wed,  1 Oct 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S05kqDyN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A052C3263;
	Wed,  1 Oct 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318857; cv=none; b=pT/VEK2VhginoKWmJYyoguubqHKJZdpKYwbLxpc3IErDwk2IUL3FegYoE+qrneX+AYfsuTGtkEJ2VRfaHFL5er6y8iEDLUz9YWkJeB/GJLudquv5s5e5f+bayFBkImejROfCQN/9OJYEpf75QEuCHjaFn+ITxTzl5RcGbcLX2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318857; c=relaxed/simple;
	bh=pe7+znf6mpyZlP+jxhc4JLkMrXrdb9R9nlQiJWAL+Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CC7EtD/yHGEeu9c7uLps1GsqgN6mu/4d3bMCVSfNeQ1rL/1p2zxltEziKyK+iAidRAuK4rjAz0gDanVcVkxNzWg8NvrnlLjlPmH9WM5Ig3aEfDDzhD7nOvLMVM7JfitFTYTi3bQkcLKj+CrqO6KBHUwHTLjA8bVJCHES+SnQuWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S05kqDyN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318854;
	bh=pe7+znf6mpyZlP+jxhc4JLkMrXrdb9R9nlQiJWAL+Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S05kqDyNRj+pe9gVvonHeRgxc9guOFsO7g6gLLdPFYpQ/9tT5CQdQdvMTE1VksqrB
	 rmrGEPCDvOKU2Dc/a68BHzcbqMBSseRUjeHmSnVf2ZORiPxtBzoVfecyuvQyDPAIrR
	 KOKTA6Bbbb0Eu4S+tUrceHpnEzJACVC1xROtoMHBywqK7g5K8jxdC8cXjihSr7OdST
	 Dfrb9c66uo1GUqRSUSzWyPhLD5+QHxyjbXB3y5dL6UBRm+hXEMujV4+OKBKodLC1KG
	 1XQ6P8rkBoWLo0I+jl6Ed/Brji/egH4mmYS5DTotXN26ouvfonaX0EYe02QSgSRPsR
	 84ai4DMes2oDQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 769AE17E12DA;
	Wed,  1 Oct 2025 13:40:53 +0200 (CEST)
Message-ID: <bddf658c-c9b1-48c7-b39c-0720e9d4c934@collabora.com>
Date: Wed, 1 Oct 2025 13:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: mediatek: Pass device to clk_hw_register for
 PLLs
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
 <20250929-mtk-pll-rpm-v1-3-49541777878d@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250929-mtk-pll-rpm-v1-3-49541777878d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/09/25 14:13, Nicolas Frattaroli ha scritto:
> Passing the struct device pointer to clk_hw_register allows for runtime
> power management to work for the registered clocks. However, the
> mediatek PLL clocks do not do this.
> 
> Change this by adding a struct device pointer argument to
> mtk_clk_register_pll, and fix up the only other user of it. Also add a
> new member to the struct mtk_clk_pll for the struct device pointer,
> which is set by mtk_clk_register_pll and is used by
> mtk_clk_register_pll_ops.
> 
> If mtk_clk_register_pll is called with a NULL struct device pointer,
> then everything still works as expected; the clock core will simply
> treat them as previously, i.e. without runtime power management.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   drivers/clk/mediatek/clk-pll.c   | 9 ++++++---
>   drivers/clk/mediatek/clk-pll.h   | 4 +++-
>   drivers/clk/mediatek/clk-pllfh.c | 2 +-
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 

..snip..

> diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
> index 83630ee07ee976bf980c8cf2dd35ea24c1b40821..62bfe4a480f14a0a742fb094aff0e6d1a79fe0c3 100644
> --- a/drivers/clk/mediatek/clk-pllfh.c
> +++ b/drivers/clk/mediatek/clk-pllfh.c
> @@ -220,7 +220,7 @@ int mtk_clk_register_pllfhs(struct device_node *node,
>   		if (use_fhctl)
>   			hw = mtk_clk_register_pllfh(pll, pllfh, base);
>   		else
> -			hw = mtk_clk_register_pll(pll, base);
> +			hw = mtk_clk_register_pll(NULL, pll, base);
>   

Seriously, you've done all that work in patch [2/4], and now you're doing that
just only with PLLFH?

Nicolas, c'mon. It's just 5 minutes ahead. :-D

Cheers,
Angelo

>   		if (IS_ERR(hw)) {
>   			pr_err("Failed to register %s clk %s: %ld\n",
> 


