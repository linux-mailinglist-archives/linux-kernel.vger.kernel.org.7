Return-Path: <linux-kernel+bounces-860671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C514DBF0AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DB2189B242
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F824E4C3;
	Mon, 20 Oct 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Av/j9O58"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54762EC0A9;
	Mon, 20 Oct 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957382; cv=none; b=QzbQgdUWkvU87nsTBimh1a8BgnBl8fYFthaWNIwgvmGCDwUZI80x/gIU1CFAMcbviFOPkQQRCGraQ1anhe/h+MsxtyqtVaNbqqJ2iYz1SfoH31NrcdTxDl7DfVhTU4JEU1MVzMbeEIykYanOpP72/AuwEz4nlr7C8i0SxJkOsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957382; c=relaxed/simple;
	bh=/VcFb2G/ht3F+guTqL6YvdGc27u72T+KofLlYcljNpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP3NV8H1qvzOiTg4uDjDTIOoD864Cbv5ju5J4wDfxy2uSCj9n/NvqiCeX177Fb9OlHwJXdWhuLghXPcDMKH2+95/JVC07T5ermWLCd73MHCJXw5gy3Ft2SlB0LyIaHbTgSNnhN81t6/wFZLFeof+J3SUUuCsEW0jmA1Rznffw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Av/j9O58; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760957379;
	bh=/VcFb2G/ht3F+guTqL6YvdGc27u72T+KofLlYcljNpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Av/j9O58crHA+r3Y1uu8hjcAwjsDNB9wawfJVPFWriYWirEt6j3kI/4s4DCps7iYH
	 uU+KCuo64e8ZaA5mNEBjt3ley8gGlOuEzNeVudBUXSPAMxGrUPGey6G8E5y2d+2PJ6
	 uUg/6ymcAR/EMHoZdxz8TWvRHnkIKjDp6Xzb+atSqJb9FF80/R/NCPgBN5b8kXrRsb
	 biYB4FJZiEkoieVLTILdouXArxtIvaBsQ6Uc6EhHVy+cSTeYowFFDjZetAAwQ7nmLK
	 t8b6Gx760BAgG4H64QmbKKJmSl3xBe6wzLisYbyPppGUmrGI1qge3ZzLoUztQDPdC8
	 dqLLJ66EXdrQQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B8EB417E108C;
	Mon, 20 Oct 2025 12:49:38 +0200 (CEST)
Message-ID: <3df15a75-cc5d-41ea-9a0e-6141b7d2ce39@collabora.com>
Date: Mon, 20 Oct 2025 12:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/13] drm/mediatek: Add support for mt8189 mmsys
 driver probe
To: Xiandong Wang <xiandong.wang@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
 <20251020074211.8942-13-xiandong.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020074211.8942-13-xiandong.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 09:40, Xiandong Wang ha scritto:
> mmsys probe for mt8189
> 
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_ddp_comp.c  |  2 ++
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 40 ++++++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.h  |  2 ++
>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  8 +++++
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 39 +++++++++++++++++++++++
>   5 files changed, 91 insertions(+)
> 

..snip..

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 4c19cffafd0f..9e6d949e5d17 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -187,11 +187,27 @@ static const unsigned int mt8188_mtk_ddp_main[] = {
>   	DDP_COMPONENT_DITHER0,
>   };
>   
> +static const unsigned int mt8189_mtk_ddp_main[] = {
> +	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_RDMA0,
> +	DDP_COMPONENT_COMP0_OUT_CB4,
> +};
> +
> +static const unsigned int mt8189_mtk_ddp_ext[] = {
> +	DDP_COMPONENT_OVL1,
> +	DDP_COMPONENT_RDMA1,
> +	DDP_COMPONENT_COMP0_OUT_CB5,
> +};

NACK. Please use OF Graph only. Stop hardcoding paths in mediatek-drm.

Regards,
Angelo


