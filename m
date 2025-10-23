Return-Path: <linux-kernel+bounces-866667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DAC00656
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9891A1891336
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027812FF14C;
	Thu, 23 Oct 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="OCUWIGcy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1572FF14A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213981; cv=pass; b=KbX0aY9QJm7x9iQHrkyK6FfiwZ5RZr+sOuaAfpwVhb/bp3QeSTSrkCvnPN4RITOSF6U9SmS38t6V5v9LmmHpYVOO1FZ8rxmbdEmobb2hgKWKMBhPl2oEydWhlVXEhaSrWggriW/LlK1oWaec0ghT9ceLoU1AX8PVr86y7nANFZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213981; c=relaxed/simple;
	bh=U9jp0SPlim+y8Eqq/PrlyNwVnUwoUNx9rDZcE9gTefc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFvicyHrBvrOeO4b3SQBWDWTfJOZuqGEsG+jGwGLQv1AQIESSSbG/YnyWEJStZnSd4stbQAyaAzLpl4sGBv3CGZTd1c+z3XooC7qiH6VCbkbXsV3Bu/b+JDec58cGvaINcJWE9CV2qWsRUHrMebyFNWs9Vyx9IGfku8uA3qNv0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=OCUWIGcy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761213959; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OLK072fVQUm6uoyWmfSIvM7Gj2Plzm1vwQw3XoZ/InQPjlVp1Z/wQJJCUffCt5SKo2J5IqyXiun/m0UgmZPGudqubUvjkrEicAUbIt6C1AVJEE9rxrcZsrCOcDZndyvMbTK9M43IOOxu3TfHb0P4D0M/zxa8It48BDGlQj9bgDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761213959; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MVDEM4oD9jX0d+ROBJ3prXRtO6D5OWGJxHZZT3Buk38=; 
	b=n6sbHRfdYDRZpJ5gR7ftbntFW5AnxsqJUmn/n1mrafkz4TWKDPfAuC5PSzrV3hXk9maWGdB21sW5TUx2Wu+JVCQhLLMovvTjxswpgSph96gFhLa6vMDdUAEoSR7I794DDtsyJJ2NmrkFmrefRcNEXt3SKbCNlJBHfVvMJcoD9uQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761213959;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MVDEM4oD9jX0d+ROBJ3prXRtO6D5OWGJxHZZT3Buk38=;
	b=OCUWIGcyWmrXejR9OAxxkrU1SvAfqTyolX19MGbGBuFk45ewELOkHo/86QNMtlnb
	xcGpL6V9ttgJ88u0+ZVpZotdaw8KdWDI7Od+UTTGxLJ7GsE7ItqxtpDnWxrI6hfhBl3
	IXrOKXratDXejg44wig9LtpjiG6KRBdhgG06h31I=
Received: by mx.zohomail.com with SMTPS id 1761213957436587.1983409307098;
	Thu, 23 Oct 2025 03:05:57 -0700 (PDT)
Message-ID: <3bc33fe2-5a6e-4f7b-a925-6fc72625a8c7@collabora.com>
Date: Thu, 23 Oct 2025 13:05:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/rockchip: Set VOP for the DRM DMA device
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20251022161948.199731-1-dmitry.osipenko@collabora.com>
 <b25aa269-6dc8-43d4-a3f3-85691ace134e@collabora.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <b25aa269-6dc8-43d4-a3f3-85691ace134e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/23/25 11:42, Cristian Ciocaltea wrote:
> On 10/22/25 7:19 PM, Dmitry Osipenko wrote:
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
>> ---
> 
> With the patch applied I'm not able to fire those warnings anymore - tested on
> my ROCK 5B (RK3588) and ROCK 4D (RK3576) boards.  Hence you may add:
> 
> Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

More testing is good, thanks.

Forgot to mention I'm myself tested on 5b/3588 and 4c/3399.

-- 
Best regards,
Dmitry

