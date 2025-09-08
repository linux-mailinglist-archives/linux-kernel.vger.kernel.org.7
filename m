Return-Path: <linux-kernel+bounces-805525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F4B489AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF853A5652
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E232F6162;
	Mon,  8 Sep 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qo2IWQpw"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE232F5474
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326262; cv=none; b=KBMPH52RWgxkooTRknB24kRO5Rw5oS3lS5iv4yS3USrmxa2ZoxaQh9pjyjnv92rEGadBeql8Fq4d77fYDeAz20o+9DxYLod5QqtsaqzoTlgrwXcueqHMZPnQ5iaNBufsuCygBwZ1/nWSRSu0/Q990JWK9j9tsRZw/uq0wVbu+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326262; c=relaxed/simple;
	bh=B1m1aWs/1lkN65KCR6ZVPb0hlkEG8hAqzg7tJoHujHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=raa8FZ1NDorW+I68d1qAjxXu/pVMVKt4EG1xnDbUDwBRZatAMNGmOvoNYRfGiNm5RsbQOnpu6FAv8l5eA7HofDb8zBYrq1Fg5kRudV4BMWJW90JmglcfNkNk3bBBXujLKy1BGyGVTfVYTEUgE9CdbdzqNB9a1EliiZuvpjuIJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qo2IWQpw; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588AATRX031975;
	Mon, 8 Sep 2025 05:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757326229;
	bh=Zzqan7/hrV9pxQRcmGcS9VOI5S+Zdlj/18cEC7NglsQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Qo2IWQpw92UNJMCJcBkfsHoyPkY4FmemKH8GOeVUFVk6DKdDXXriYj0JIPwwaFp7y
	 TmtUK/iv1Po/nIqfPi6CYp0ERHHCcM9Q+/sQg36DvgIdnSThY1Y06RB30Z7CInJQp+
	 wSLTcoA2J0SLsHelCUNYnHDa1cpZd2oqEO5E8dIU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588AASCe2889558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 05:10:28 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 05:10:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 05:10:27 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588AANkb431727;
	Mon, 8 Sep 2025 05:10:24 -0500
Message-ID: <aa7c2ae8-fc04-4917-9c8b-9c5dd6680580@ti.com>
Date: Mon, 8 Sep 2025 15:40:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tidss: Update Videoport SYNC LOST IRQ bit
To: Harikrishna Shenoy <h-shenoy@ti.com>, <jyri.sarha@iki.fi>,
        <tomi.valkeinen@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <bparrot@ti.com>, <sam@ravnborg.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250903100929.2598626-1-h-shenoy@ti.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20250903100929.2598626-1-h-shenoy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Harikrishna,
Thanks for the patch.

On 9/3/25 15:39, Harikrishna Shenoy wrote:
> Update VP SYNC LOST Bit as per register description for
> DSS0_COMMON_VP_IRQENABLE_0 give in TRM.
> 
> Link:https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM

Broken link, please add a working link.
Please add link to TI's Sitara Devices Technical Reference Manual as well.

Regards,
Swamil

> Table 12-597. DSS0_COMMON_VP_IRQENABLE_0
> 
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
> 
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_irq.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.h b/drivers/gpu/drm/tidss/tidss_irq.h
> index dd61f645f662..0194010a7fff 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.h
> +++ b/drivers/gpu/drm/tidss/tidss_irq.h
> @@ -53,7 +53,7 @@ static inline dispc_irq_t DSS_IRQ_PLANE_MASK(u32 plane)
>   #define DSS_IRQ_VP_FRAME_DONE(ch)	DSS_IRQ_VP_BIT((ch), 0)
>   #define DSS_IRQ_VP_VSYNC_EVEN(ch)	DSS_IRQ_VP_BIT((ch), 1)
>   #define DSS_IRQ_VP_VSYNC_ODD(ch)	DSS_IRQ_VP_BIT((ch), 2)
> -#define DSS_IRQ_VP_SYNC_LOST(ch)	DSS_IRQ_VP_BIT((ch), 3)
> +#define DSS_IRQ_VP_SYNC_LOST(ch)	DSS_IRQ_VP_BIT((ch), 4)
>   
>   #define DSS_IRQ_PLANE_FIFO_UNDERFLOW(plane)	DSS_IRQ_PLANE_BIT((plane), 0)
>   

