Return-Path: <linux-kernel+bounces-846417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A58BC7EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF1F3AAF59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9E25D202;
	Thu,  9 Oct 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LRD+5gZ3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAD91FBCA1;
	Thu,  9 Oct 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997380; cv=none; b=PW8ySWnT8z3+mh680zIzZg1kMA1cbRXFN03UjpQKvbiGwWQfCdkQh1vSwYI/ia5PidizVsey18eUEHgXo5LYt3jMUT2VsmGEooHEAOAQmmzRvh9a6Lf/xSH6oWVK19DVxqKYTvVXTLMtzkGkslTcPnucgzfWHLxmyFcTjPN4+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997380; c=relaxed/simple;
	bh=KyklGAMNtWChaurBpHK/F2+DI+34oXWWStcbMlx5O1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egBmkHDzGF6QAVRDrVfyhumIUxlCShxHZpeUIK5CviJ8Cy2e+17xYcNmzgaKMsNS9lI2PBp+VzJm+DEX2f1M/h175D3nXAVAXVGh6ChAiQHkfFP0RvnjVdYIJp+ISXm+8o6VUU9c5jqNGUBCxuB8lg4d7qUzZAaK1XPdkdMl+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LRD+5gZ3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759997376;
	bh=KyklGAMNtWChaurBpHK/F2+DI+34oXWWStcbMlx5O1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LRD+5gZ34GwE1TSoRgv6iHn3KzXA7akJeAMubD6bh35xsyTqRczdE/Pp2ZX8AIGc/
	 kkgExMbedADvQpbyt1HZ3tFIr24wVHWL0tpq6zx1WoryuydCi1Tabn7a6fF8anTL62
	 Q/fs4RLUsgjFP5fkbOnkzHn9sx86LqUYnPfDVQhzRuu/dh8H2aEvFH55HIGv4tb51l
	 0RkT7dPm9F2upYo1nPxrX7gnCxdeaZv7UvPRnuWIMVXA+2eB6WW56uSU5+TIFmTemx
	 8Uk0KeQnXK8FS/6aUWzAingmikgnOp+XBVP55SxRNxi7bfhBEdrjNnv+ibm12vcmug
	 HFmpw8vgavdTA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D69D717E04DA;
	Thu,  9 Oct 2025 10:09:35 +0200 (CEST)
Message-ID: <2477df4e-c89e-408f-bb2a-d5af51f78ef8@collabora.com>
Date: Thu, 9 Oct 2025 10:09:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] clk: mediatek: Refactor pll registration to pass
 device
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
 <20251008-mtk-pll-rpm-v2-2-170ed0698560@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251008-mtk-pll-rpm-v2-2-170ed0698560@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/25 18:05, Nicolas Frattaroli ha scritto:
> As it stands, mtk_clk_register_plls takes a struct device_node pointer
> as its first argument. This is a tragic happenstance, as it's trivial to
> get the device_node from a struct device, but the opposite not so much.
> The struct device is a much more useful thing to have passed down.
> 
> Refactor mtk_clk_register_plls to take a struct device pointer instead
> of a struct device_node pointer, and fix up all users of this function.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   drivers/clk/mediatek/clk-mt2701.c            | 2 +-
>   drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 2 +-
>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 4 ++--
>   drivers/clk/mediatek/clk-mt6765.c            | 2 +-
>   drivers/clk/mediatek/clk-mt6779.c            | 2 +-
>   drivers/clk/mediatek/clk-mt6797.c            | 2 +-
>   drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 +-
>   drivers/clk/mediatek/clk-mt7629.c            | 2 +-
>   drivers/clk/mediatek/clk-mt7981-apmixed.c    | 2 +-
>   drivers/clk/mediatek/clk-mt7986-apmixed.c    | 2 +-
>   drivers/clk/mediatek/clk-mt7988-apmixed.c    | 2 +-
>   drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 3 ++-
>   drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 2 +-
>   drivers/clk/mediatek/clk-mt8183-apmixedsys.c | 2 +-
>   drivers/clk/mediatek/clk-mt8188-apmixedsys.c | 2 +-
>   drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 3 ++-
>   drivers/clk/mediatek/clk-mt8196-apmixedsys.c | 3 ++-
>   drivers/clk/mediatek/clk-mt8196-mcu.c        | 2 +-
>   drivers/clk/mediatek/clk-mt8196-mfg.c        | 2 +-
>   drivers/clk/mediatek/clk-mt8196-vlpckgen.c   | 2 +-
>   drivers/clk/mediatek/clk-mt8365-apmixedsys.c | 2 +-
>   drivers/clk/mediatek/clk-mt8516-apmixedsys.c | 2 +-
>   drivers/clk/mediatek/clk-pll.c               | 7 ++++---
>   drivers/clk/mediatek/clk-pll.h               | 6 +++---
>   24 files changed, 33 insertions(+), 29 deletions(-)
> 

..snip..

> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index d71c150ce83e4bb2fe78290c2d5570a90084246d..0e2b94b9cd4b56adceee3b04e9ab24c2526471da 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -78,9 +78,9 @@ struct mtk_clk_pll {
>   	const struct mtk_pll_data *data;
>   };
>   

There's a forward declaration of struct device_node in this header: with this
change, that becomes unused.

Please change that to a forward declaration of struct device instead.

While at it, I'd appreciate if you could either:
  A. Remove the forward declaration for `struct clk_hw_onecell_data` and for
     `struct clk_ops` (as both come from clk-provider.h - which this already
      includes);
    ...or...
  B. Remove the inclusion of clk-provider.h and keep the forward declarations.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> -int mtk_clk_register_plls(struct device_node *node,
> -			  const struct mtk_pll_data *plls, int num_plls,
> -			  struct clk_hw_onecell_data *clk_data);
> +int mtk_clk_register_plls(struct device *dev, const struct mtk_pll_data *plls,
> +			  int num_plls, struct clk_hw_onecell_data *clk_data);
> +
>   void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
>   			     struct clk_hw_onecell_data *clk_data);
>   
> 



