Return-Path: <linux-kernel+bounces-754888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F360EB19E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE33A4EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF5242D9E;
	Mon,  4 Aug 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UMeLnFLl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FD38FA6;
	Mon,  4 Aug 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297881; cv=none; b=Nzrlx9mdCeTwb16K0Cg9ehMhMfI/y/G/eJ5Xjg3dOF+r+LgauPnSGMNcPjmC2XIDyiusiq0hpK24hfMKP1MV69loktkM1eRWFafetECVsiVWfx/sH74frzSwOlNfxDGlQ0TXNp9oGL41vxv+V4mle9MpVWqUKpRAGu6TFC2tKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297881; c=relaxed/simple;
	bh=BYlIvi6N1B4zZkudRep+yBSyFMv2TAT55xPmCHgg8Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtJ2gvdxZNDDzvFUmR3SAMwicmB9lo0SBfeOMkv6Xwwt+TROd/MTAPoGlknhCM6buV66j1w0WbovAJiTyYvn71QJHDNxwwcnu0wrKvMlvhSkIfN5erp1Ycs4bXBTDTfOzAuU2mFW9zmtQZlkVGGBdmqEISTW1y8H4zfQbhAzmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UMeLnFLl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297877;
	bh=BYlIvi6N1B4zZkudRep+yBSyFMv2TAT55xPmCHgg8Ts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UMeLnFLlhxIsDh+1vjILNaFUWz2Ao8Cj3nIdLdKn+tM+b5dPaOc2KNTNCHabvB/bZ
	 f8PtG+ypH4ZuKB/MplnsrSYUU/nrqU+jdEsQ81s+4PFMHXiILEbtX8Xrf8V/3eyeeO
	 PRW8B2Qu5X5Oe/EUIydBpfYbS35kF3JTFOsSt6xJ2tueuWJekO2lGUM523bOdXah4U
	 uNZ3W5TAT0uur0BAcCfo+H3HufxnuNZJmLfFcNZBRYITI4aOyPgZ4ADCsNlMLpLA/k
	 EbZ1Dj4H8ziFv9IgNnYlo/W5p+qyEYth2cp7k1iYO9xlNXdFitrlPh2HUSST/1iTc5
	 iTKyI69Q7Gw7A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0B05917E04DA;
	Mon,  4 Aug 2025 10:57:55 +0200 (CEST)
Message-ID: <edaeb213-d1df-40bf-9538-9ea86198f3c2@collabora.com>
Date: Mon, 4 Aug 2025 10:57:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/mediatek: Add CCORR component support for
 MT8196
To: Jay Liu <jay.liu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
 CK Hu <ck.hu@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250727071609.26037-1-jay.liu@mediatek.com>
 <20250727071609.26037-2-jay.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250727071609.26037-2-jay.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/07/25 09:15, Jay Liu ha scritto:
> Add CCORR component support for MT8196.
> 
> CCORR is a hardware module that optimizes the visual effects of
> images by adjusting the color matrix, enabling features such as
> night light.
> 
> The 8196 SoC has two CCORR hardware units, which must be chained
> together in a fixed order in the display path to display the image
> correctly. the `mtk_ccorr_ctm_set` API only utilizes one of these units.
> To prevent the unused CCORR unit from inadvertently taking effect,
> we need to block it in the mtk_crtc.c.
> 
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>

Please, remove that bogus "20220315152503 created" user that does not exist.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



