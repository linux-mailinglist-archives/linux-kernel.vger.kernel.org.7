Return-Path: <linux-kernel+bounces-864769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D4BFB7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3252A3B1E07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B710328609;
	Wed, 22 Oct 2025 10:59:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473CF320CDB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130760; cv=none; b=aKjtQkxXVNL1pK1h8Nei712x3YD4fmMPXYe5KQ6sEg0qPWYjy07dbhd+Ursi19jF8eiXjmWFB7Cu59zBttFvxs8gAcyNz4FzOCgHfKbH1TypD5K/m9wAgSyZkpZ6g8M1Gf2ZTEJh/PJFjY8TSRRSIY7A0u7Xe+8Ez2YpL+X2LZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130760; c=relaxed/simple;
	bh=Hh/QKC12sWmu1qKpuD5981/uK2R7YO1R+G++ar+Yp5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0QqK77rdNevLn8f+RTPS/oGKpWvBICrpDVZM2bfTmWPrvzAAynQAPSRoliAF6Bg084CCKVoz4PONtFto/YLv57Tzy9AAOEwN4NsNiRvYzaJcxqKqsPWIE24CTKlv/DRfXhF/5OKUz5kHX9iSD3QEp/mo6oY01GSY/xFkGnyULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E651063;
	Wed, 22 Oct 2025 03:59:10 -0700 (PDT)
Received: from [10.57.33.187] (unknown [10.57.33.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EDBA3F59E;
	Wed, 22 Oct 2025 03:59:15 -0700 (PDT)
Message-ID: <cdb8495a-519e-469a-82e9-791094a81a52@arm.com>
Date: Wed, 22 Oct 2025 11:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix race with suspend during unplug
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Grant Likely <grant.likely@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251022103242.1083311-1-ketil.johnsen@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251022103242.1083311-1-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2025 11:32, Ketil Johnsen wrote:
> There is a race between panthor_device_unplug() and
> panthor_device_suspend() which can lead to IRQ handlers running on a
> powered down GPU. This is how it can happen:
> - unplug routine calls drm_dev_unplug()
> - panthor_device_suspend() can now execute, and will skip a lot of
>   important work because the device is currently marked as unplugged.
> - IRQs will remain active in this case and IRQ handlers can therefore
>   try to access a powered down GPU.
> 
> The fix is simply to take the PM ref in panthor_device_unplug() a
> little bit earlier, before drm_dev_unplug().
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Fixes: 5fe909cae118a ("drm/panthor: Add the device logical block")

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 81df49880bd87..962a10e00848e 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -83,6 +83,8 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  		return;
>  	}
>  
> +	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> +
>  	/* Call drm_dev_unplug() so any access to HW blocks happening after
>  	 * that point get rejected.
>  	 */
> @@ -93,8 +95,6 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	 */
>  	mutex_unlock(&ptdev->unplug.lock);
>  
> -	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> -
>  	/* Now, try to cleanly shutdown the GPU before the device resources
>  	 * get reclaimed.
>  	 */


