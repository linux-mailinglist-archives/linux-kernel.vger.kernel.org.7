Return-Path: <linux-kernel+bounces-866516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F58BFFFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E45CF4F4429
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929322F3C28;
	Thu, 23 Oct 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="igiHR0Sj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66BC29BDA3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208972; cv=none; b=VfBmdUYRqbyOIfrOhYo2lRqCgKA7/HPSZGPTbnrqPPfpU8quvDdgs4+ZfXTHcJN/ksJ1U4A12OXRN1eiXmUSygLLJVedy1uNTP5v/WGzE5WMsQntFLevYImM21xc6bT6cKH3/M1nCF1WqM7ZSfucLQUpUKPfZzOCImokz/zTp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208972; c=relaxed/simple;
	bh=sn155PxY4c6KoChuMd294Ou+jNKdIOB15aowevCx2w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lf7f2sANf34jU7iAzUBwn3hHTy5qvm9TjymdlLBVaYttufYooQZXDojRUSFJKRE6u4diH+mwiWEcEiAVcQjyjPR8yNg7KgVMdTrq+mw8Bzg+zmWJqs5AzzFFBfsydvlWR7anXyjzBDx+WX4EM8sClH37ttmRhN73o2uHF4iJL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=igiHR0Sj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761208967;
	bh=sn155PxY4c6KoChuMd294Ou+jNKdIOB15aowevCx2w4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=igiHR0SjfmIarvQk/NjsVaXyggKa7DLNKihy7JDojejk6ToxCdKqI/hSLZccxT67W
	 tpX9hvWL4q8HZc4ioHrQ20yMd/FHDys2VK/g1xh9DQUx0FkxEaO44wEU15zUJUAshd
	 ftfJHXIsACb0ykiS5OVplw8HDNQqdITDPUrKv9Vw8DrTTxaHhYx1SBS6nuWrzHpXh+
	 Jn6MI3ftrjKYPNMOhTsB1Og72LlpKju9+zKvK6b5Yen08RmM1+/+jFqsJwVK6frQUk
	 tlLUpTj2bO8b5fFV/EwIDIQ/2gn4DSvuP5oQ0Z5gtQP27Kws3tXb0vXiWTYCNtGPEY
	 NPe8nR5SyEKqw==
Received: from [192.168.1.90] (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 77CA917E127F;
	Thu, 23 Oct 2025 10:42:47 +0200 (CEST)
Message-ID: <b25aa269-6dc8-43d4-a3f3-85691ace134e@collabora.com>
Date: Thu, 23 Oct 2025 11:42:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/rockchip: Set VOP for the DRM DMA device
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20251022161948.199731-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20251022161948.199731-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 7:19 PM, Dmitry Osipenko wrote:
> Use VOP for DMA operations performed by DRM core. Rockchip DRM driver
> is backed by a virtual device that isn't IOMMU-capable, while VOP is the
> actual display controller device backed by IOMMU. Fixes "swiotlb buffer
> is full" warning messages originated from GEM prime code paths.
> 
> Note, that backporting is non-trivial as this depends on 143ec8d3f9396
> ("drm/prime: Support dedicated DMA device for dma-buf imports"), which
> landed in v6.16 and 421be3ee36a4 ("drm/rockchip: Refactor IOMMU
> initialisation"), which landed in v5.19.
> 
> Reported-by: Daniel Stone <daniels@collabora.com>
> Fixes: 2048e3286f34 ("drm: rockchip: Add basic drm driver")
> Cc: stable@vger.kernel.org # v6.16+
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---

With the patch applied I'm not able to fire those warnings anymore - tested on
my ROCK 5B (RK3588) and ROCK 4D (RK3576) boards.  Hence you may add:

Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>


