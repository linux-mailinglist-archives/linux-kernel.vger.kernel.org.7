Return-Path: <linux-kernel+bounces-735067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A9B08A71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C963AA28B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E88B2900AA;
	Thu, 17 Jul 2025 10:23:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C504503B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747821; cv=none; b=nHwbdLm8DQo+y/9+AJz18RKeTu5bRVufp/ASyNVq0QipGxFCkrzZ7XEHVWGBnTyL4Q7rY1T28BBtsoiRPoc5F+NUB5E+HuEozEYNEwu0rT7Eqi1Hc2E2ZTS50X9KxhQU9/LzMzIESLVeh1GRq5JV9UvMbtUAoCsJGNlxvTayt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747821; c=relaxed/simple;
	bh=5GDC4YKogpT5kG3m+HMg1GSAAu2zwX7ZaNU1tqR7eNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YURCCcsAFw55tVnupM92tEocF3Wi5HRexMIfq21/2VJ8m2g29ZRvey/UmxLmpkk2l6O97a4vGtcM8nOcRFEX71lRx71TVn+T0MvijQ56OyjmfHX9ld65b4BG8annHUEBj6JnR+q44GPfVTUnJqGkaPk65W67K8rf365CT/nkcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85EDF1596;
	Thu, 17 Jul 2025 03:23:21 -0700 (PDT)
Received: from [10.1.28.24] (e122027.cambridge.arm.com [10.1.28.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC7903F6A8;
	Thu, 17 Jul 2025 03:23:26 -0700 (PDT)
Message-ID: <97149cf3-b3cb-4b90-a486-7eea5ee41b59@arm.com>
Date: Thu, 17 Jul 2025 11:23:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Fix leak when free gem object
To: lihongtao <lihongtao@kylinos.cn>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250710030527.167710-1-lihongtao@kylinos.cn>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250710030527.167710-1-lihongtao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/07/2025 04:05, lihongtao wrote:
> obj->mappings.lock should be destroyed when free
> panfrost gem object in panfrost_gem_free_object.

mutex_destroy() doesn't actually release any resources. It is purely a
debugging feature (if CONFIG_DEBUG_MUTEXES is disabled then it is
compiled away completely).

So it's not a "leak" as such. But there is some value in using it as it
would (in debug builds) warn us if we attempt to destroy a locked mutex
or attempt to use a mutex after the destroy.

But if we're going to fix this I think we should be more complete. A
quick grep should we have 6 different mutexes in panfrost:

panfrost_device.c:      mutex_init(&pfdev->sched_lock);
panfrost_device.c:      mutex_init(&pfdev->debugfs.gems_lock);
panfrost_drv.c: mutex_init(&pfdev->shrinker_lock);
panfrost_gem.c: mutex_init(&obj->mappings.lock);
panfrost_gem.c: mutex_init(&obj->label.lock);
panfrost_perfcnt.c:     mutex_init(&perfcnt->lock);

But there's only one existing call to mutex_destroy():

panfrost_gem.c: mutex_destroy(&bo->label.lock);

It would be good to consider if the other mutexes should also be destroyed.

Thanks,
Steve

> 
> Signed-off-by: lihongtao <lihongtao@kylinos.cn>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 963f04ba2de6..00549f482eec 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -49,6 +49,7 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
>  		kvfree(bo->sgts);
>  	}
>  
> +	mutex_destroy(&bo->mappings.lock);
>  	drm_gem_shmem_free(&bo->base);
>  }
>  


