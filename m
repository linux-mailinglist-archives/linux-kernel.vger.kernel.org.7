Return-Path: <linux-kernel+bounces-810166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE290B516CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA681C24F53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF983191C6;
	Wed, 10 Sep 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R/T4K4kZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CF314A7B;
	Wed, 10 Sep 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507098; cv=none; b=NdExe6uKzfi9vtQ4EzqTikcy6Ww77oRy5vJ80Ei/5qdbVE4RtU3Ce7+u9uiGKMFc9XXohSFoRp3GU618aZBkm0/354RkYYlZ90cH3LsY8Xo/cSK+3eJF76Xpcr4G6AIX2p8LbFT7DNzfQbtZwz0/Pc9aticzrHCN/Tc+paCK6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507098; c=relaxed/simple;
	bh=XG4risedyzhaJlFOa2WbFkhBXqEGFq2jhFHoD1cXqr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2XAzKKhl6ogQLAE1lCP5awX8axe06kJ7hfYaq30aVh8eXCZcKPd+TsSGjlwhr88e2SSUGUBxsPFERfWrvL3v3WabjqbqcANc0hxO8MZHP9kMRGQ6VPgqLyWVxxHXSjF6ydGFcVTsQaSxZ9Eiyu/tB/1zKy0fxFV4krReYOaz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R/T4K4kZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757507094;
	bh=XG4risedyzhaJlFOa2WbFkhBXqEGFq2jhFHoD1cXqr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R/T4K4kZw5G7rkwD5a0Sq4j+YyADMkBxO1OodOyptZG1TrjWeBBUNrGXwz07dGe/i
	 aMdRNzMIysVJHM5r1dTVZWwgU6IN4udQAQxWsCN4JGGrEghdzLo0fHGImO7R7GKIZq
	 qRKwszp+DXoEE6PwPhewnq/V2q1DDhdD5D6GbU7xDN/8QMoJh6VTaNhR/bfbM3RGce
	 zrL3xlJn9wusBsIhmsO0npRkyFeAR00ja0YWxjfTPU/aVfd8NwVStvIFAQFmBx+UK7
	 0MnQDnXFDohowKRnJ4qxWqWOXgR+qrk+W3eVT5Aw4JGJk/VzvKRTmD1Eq1eSOV7tbY
	 Nvg8B3JMLxGsA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDD0A17E0125;
	Wed, 10 Sep 2025 14:24:53 +0200 (CEST)
Message-ID: <4367758f-77d8-460c-887a-946b1c7cdd68@collabora.com>
Date: Wed, 10 Sep 2025 14:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/19] drm/mediatek: Add support for multiple mmsys in
 the one mediatek-drm driver
To: Paul Chen <paul-pl.chen@mediatek.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, chunkuang.hu@kernel.org
Cc: matthias.bgg@gmail.com, p.zabel@pengutronix.de,
 jason-jh.lin@mediatek.com, nancy.lin@mediatek.com, singo.chang@mediatek.com,
 xiandong.wang@mediatek.com, sirius.wang@mediatek.com,
 sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
 <20250828080855.3502514-19-paul-pl.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250828080855.3502514-19-paul-pl.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/08/25 10:07, Paul Chen ha scritto:
> From: Nancy Lin <nancy.lin@mediatek.com>
> 
> To support multiple mmsys instances in the one mediatek-drm instance,
> providing improved flexibility and scalability by the following changes:
> 
> 1. Add DDP_COMPONENT_DRM_OVLSYS_ADAPTOR* to probe the
>    ovlsys_adaptor drivers and support different mmsys composition.
> 2. Added new component types MTK_DISP_VIRTUAL to support the
>    routing to virtual display components.
> 3. Added and adjusted the existed structure or interface to extend
>    the support of multiple mmsys instances.
> 4. Modified the component matching and binding logic to support
>    multiple mmsys instances.

This commit is huge and a bit difficult to read, but also you have split the
changes description in four points.

Please, split this in four commits, for each of the changes that you're actually
describing in the description of this single one: this not only makes reviewing a
bit easier, but will help understanding what's being done in case any uncaught
regression shows up "after the fact".

Thanks,
Angelo

> 
> Signed-off-by: Nancy Lin <nancy.lin@mediatek.com>
> Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_crtc.c     | 342 +++++++++++++++++++-----
>   drivers/gpu/drm/mediatek/mtk_crtc.h     |   6 +-
>   drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 105 +++++---
>   drivers/gpu/drm/mediatek/mtk_ddp_comp.h |   2 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  85 +++---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  13 +
>   6 files changed, 421 insertions(+), 132 deletions(-)
> 

