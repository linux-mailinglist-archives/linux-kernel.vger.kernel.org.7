Return-Path: <linux-kernel+bounces-866356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8CBFF8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B790F3ADCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BF2EC0B7;
	Thu, 23 Oct 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="iKy0yYd5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14A2E0B5F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203979; cv=pass; b=WMm2j9OwnZEvILnR0l3k+Mfni2ug2Mf0dhxRbYSZEXXk1u4z4Fd9OLzbQ5TUz2loCh+3E2HT++xvyqlqetq7GZVSFZXyXcf+UVDjaAamRo6OGst4keOHcg9CcESKShnpBcXcFTV9OW8S1RiD+VJfcJNVt8+qcZqnXUyk62HQ2ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203979; c=relaxed/simple;
	bh=kK79GzJYO8gnjI5i1L6/EEXw/v2K2lo/V1TdaUSX1cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlDz0L8QYtmAWI5JjQzvvLSMnFp9mwqEbvMAP9nM/WPM5J4kFPC+C6GSduNy3iZoWyc4ChRSDTABEK0xctfK111tAhJhrULP4QWuj4p3zWZ34WKz8+2CoOcGyt4J4NjCg7rRWH3lwyCA6DiKbKs/2TrFt1mwuyrqwqPqiGrqGjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=iKy0yYd5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761203954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bsCzS5MDHjxtBJy/3QQFflmrjRjP7+ij7mjvcpmJiVSO9IBjSQQM5C+NSbK6yoChcyE93a8+bTAr7+kIVJWRULaFPG11IwMZ3WWzoX6SRUIHDMxK/i5cFrX6ehbezhmHibQdMECFR8H03JqtHlDHDKEbPztexGSzIGjf9oMA6nk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761203954; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SF5pybulDBHW18c8HlGOwb18Vw0zJMzWb3/sOP7yWg4=; 
	b=K6gwCYSwTLEtYSOy4h2jFuHn+3XWcEyPbxPsb1wQlGLIbF5+/BgBuUMey41TiyBaXduGmi2nM8ks69qEK9ix1B5w2w2e+J3ILdm6WHoGf1PwON8jxd0fd0li8TCyDuIHDPiA8DlhlFW1pUeFUSkTQoNXINUVDOKyCp2tTWEgHdw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761203954;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SF5pybulDBHW18c8HlGOwb18Vw0zJMzWb3/sOP7yWg4=;
	b=iKy0yYd5IOtoKBRwSPCKhVi9FFId6Ye3aOop8qPa2+O2cHYN3UWhjtdHh4X1+yjG
	Q0AJNOmzRt4ophYTGgJDDO6C9IjCLulhIKjVwwj6tAxj0imhEVNGEc4Noq3KBRtoIqL
	2Kp8ddw0qOQjca+mU5BsgLOAxGQn4mdxpS/Qhj0s=
Received: by mx.zohomail.com with SMTPS id 1761203953036917.0062959568356;
	Thu, 23 Oct 2025 00:19:13 -0700 (PDT)
Message-ID: <40d18130-4aab-47ad-9ed4-00ff6f594cc3@collabora.com>
Date: Thu, 23 Oct 2025 10:19:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/rockchip: Set VOP for the DRM DMA device
To: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20251022161948.199731-1-dmitry.osipenko@collabora.com>
 <3705026.LM0AJKV5NW@phil>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3705026.LM0AJKV5NW@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 10/23/25 09:56, Heiko Stuebner wrote:
> Hi Dmitry,
> 
> Am Mittwoch, 22. Oktober 2025, 18:19:48 Mitteleuropäische Sommerzeit schrieb Dmitry Osipenko:
>> Use VOP for DMA operations performed by DRM core. Rockchip DRM driver
>> is backed by a virtual device that isn't IOMMU-capable, while VOP is the
>> actual display controller device backed by IOMMU. Fixes "swiotlb buffer
>> is full" warning messages originated from GEM prime code paths.
>>
>> Note, that backporting is non-trivial as this depends on 143ec8d3f9396
>> ("drm/prime: Support dedicated DMA device for dma-buf imports"), which
>> landed in v6.16 and 421be3ee36a4 ("drm/rockchip: Refactor IOMMU
>> initialisation"), which landed in v5.19.
>>
>> Reported-by: Daniel Stone <daniels@collabora.com>
>> Fixes: 2048e3286f34 ("drm: rockchip: Add basic drm driver")
>> Cc: stable@vger.kernel.org # v6.16+
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> just a process remark for now. This v1 so it definitly shouldn't come
> with any Reviewed-by-s pre-applied, because this should happen in public.
> 
> It's not a huge issue here, because I do trust the people involved (you,
> Sebastian, Daniel) and the change is small enough, but please for future
> changes, let Review happen on the list, not on private channels.
> 
> 
> Will look at the change itself when back home.

Thanks. I also felt uncomfortable adding r-b to v1. There was no much
discussion on the change that you can find on [1] and the change is
indeed small, so I just added the r-b. Should've linked it the patch.

[1]
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/issues/50

-- 
Best regards,
Dmitry

