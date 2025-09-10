Return-Path: <linux-kernel+bounces-809830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B0B5128D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45B41C24FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB19313E25;
	Wed, 10 Sep 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cd/oGOOJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1283126DD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496819; cv=none; b=CU9mmRWoxbEpZ+fLlBkIrpQ3zAkWPGz0LeoAlRVYHUkWV0cIpycwhU+gQdR25gnzqmAsnGumr60fIBr0FEuMr/70N1pvtZt12zB5AkdZtXYjI0tJStkyG+ktbM9g+qP2wcNozte1P/HUkBVD/zon4iH46yM3T136k4cHvwLoz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496819; c=relaxed/simple;
	bh=4TW25vHkdcjLk7pdZ8NdI1vAv/tKPvhm66WuGiHLE+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdMfK4WpWyvcKeTQizZIe8kTD+j7M8zgjOSu2Buw4xtxWFe+tiMzJB75bAbgWRcqsZwtYf3s4SOqG/7GB+wfKh72ua+x3NqogsqCghzjTs98hXkTF1ITh2TxhcsuuFbg+VO8D0Py/0XbjnpmxntElr/65VcFRjfRblkZ3EskgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cd/oGOOJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757496810;
	bh=4TW25vHkdcjLk7pdZ8NdI1vAv/tKPvhm66WuGiHLE+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cd/oGOOJc4U2WUp7XJXVtXpOjWP/MDcbgLpQZb8xexNryDX/Joz7CozswDCywThc1
	 0Or8g/UM46NVvS7NpgT7mEh6BSpi80p1qFnCsTC7iPjTGn2zjscp6eVSCWIOLp2mEn
	 161E4AjeuJyoMnIHMRbxSv7RYt3yXWx4wNoO46z5zIW7I4LRUnAL49//HIMqPEfnUA
	 6tm/4jFzAYL7bk/RCG29RF2bsWpZ6Dse7IlGjhLSZgveMzrqowkzeNSAIoy2rNRyNO
	 QqY4QCmobYYIWms9Ea8aDykmcY0MN1+CJnDaXVtlnUiozXTe1nyUq/kQ+LbmwBVO/s
	 S2socrRuR3ktw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E342417E0100;
	Wed, 10 Sep 2025 11:33:29 +0200 (CEST)
Message-ID: <cb896db9-6fed-4e83-baa1-c075fdf1df1e@collabora.com>
Date: Wed, 10 Sep 2025 11:33:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/mediatek: fix potential OF node use-after-free
To: Johan Hovold <johan@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ma Ke <make24@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829090345.21075-1-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250829090345.21075-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/08/25 11:03, Johan Hovold ha scritto:
> A recent change (included in the drm pull request for 6.17-rc4) fixed a
> device reference leak but also introduced a potential OF node
> use-after-free.
> 
> This series fixes the new OF node reference imbalance and drops the
> unnecessary gotos introduced by the broken fix, effectively reverting
> that change in favour of the minimal fix I had previously posted here:
> 
> 	https://lore.kernel.org/lkml/20250722092722.425-1-johan@kernel.org/
> 
> These should go into 6.17 which (soon) has the broken fix, which was
> also marked for stable backport.
> 
> Johan
> 
> 
> Johan Hovold (2):
>    drm/mediatek: fix potential OF node use-after-free
>    drm/mediatek: clean up driver data initialisation
> 
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)
> 

The whole series is
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

*** URGENT ***

CK, please send this immediately, because [1] breaks *ALL MediaTek boards* making
them *unbootable*.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/mediatek?h=next-20250910&id=1f403699c40f0806a707a9a6eed3b8904224021a

This series fixes the situation and makes them boot again.

Regards,
Angelo

