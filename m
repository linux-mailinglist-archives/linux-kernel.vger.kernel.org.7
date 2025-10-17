Return-Path: <linux-kernel+bounces-858081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF44BE8D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE206E256C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64334F488;
	Fri, 17 Oct 2025 13:25:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A62D641D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707524; cv=none; b=URRoxRGiiKRRTor9mF8bcZkUUUfZP0KYqT9gHRNQ46PQjLlzmjXa2pTAfvg1q4OYLm/eV5eAfvYMAI9RWL2RCjV5I3rThurY8EJmOQKaEDvWtxRl8uxX5bj7K2MS4ZqkO0KvqHxfqy9kLM532TsW9GdvMdJ+JLQDY8qm+djLfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707524; c=relaxed/simple;
	bh=Vt7VPD5PpCe+VrVpG8PpLDMDCXp2h8ZUzDo/2QBWPQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hN5zyp0FeDDoaPTWKEGkWHIvlcijZsAJtcpobmVrFyVVM83myX+n0OIGyN7XLybo2yKNzsDGqBA+hNaahdpJZVsMJFXqW8e29uzIXVPHNTYd7m24pI+SMEET8xxIqhOSYrxn9e1jgHdsaESVgJniFvHU1TUXRuKh3nrbjCGWw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A711595;
	Fri, 17 Oct 2025 06:25:14 -0700 (PDT)
Received: from [10.57.36.104] (unknown [10.57.36.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83C933F66E;
	Fri, 17 Oct 2025 06:25:18 -0700 (PDT)
Message-ID: <f1cad54b-5f25-4a1a-9e61-c96d72ac3637@arm.com>
Date: Fri, 17 Oct 2025 14:25:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/12] drm/panfrost: Handle error when allocating AS
 number
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
 <20251015000930.356073-5-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251015000930.356073-5-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/10/2025 01:09, Adrián Larumbe wrote:
> If we reach the beginning of the LRU AS list, then return an error.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c     | 6 +++++-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     | 5 +++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.h     | 2 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 8 ++++++--
>  4 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 0722f297d142..d53e9db945ad 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -217,7 +217,11 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  		goto err_hwsubmit;
>  	}
>  
> -	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
> +	ret = panfrost_mmu_as_get(pfdev, job->mmu);
> +	if (ret < 0)
> +		goto err_hwsubmit;
> +
> +	cfg = ret;
>  
>  	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 1d696eeea2fa..cf272b167feb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -258,7 +258,7 @@ static int panfrost_mmu_cfg_init(struct panfrost_mmu *mmu,
>  	}
>  }
>  
> -u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
> +int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
>  {
>  	int as;
>  
> @@ -300,7 +300,8 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
>  			if (!atomic_read(&lru_mmu->as_count))
>  				break;
>  		}
> -		WARN_ON(&lru_mmu->list == &pfdev->as_lru_list);
> +		if (WARN_ON(&lru_mmu->list == &pfdev->as_lru_list))
> +			return -EBUSY;

I was about to apply this series, but sparse told me that this is
broken. We're holding the as_lock here, so we need to drop that before
returning.

Thanks,

Steve

>  
>  		list_del_init(&lru_mmu->list);
>  		as = lru_mmu->as;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> index 022a9a74a114..e6e6966a0cca 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> @@ -16,7 +16,7 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev);
>  void panfrost_mmu_reset(struct panfrost_device *pfdev);
>  void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
>  
> -u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
> +int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
>  void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
>  
>  struct panfrost_mmu *panfrost_mmu_ctx_get(struct panfrost_mmu *mmu);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index 718eb44b40f8..7020c0192e18 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -130,9 +130,11 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  		goto err_vunmap;
>  	}
>  
> -	perfcnt->user = user;
> +	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	if (ret < 0)
> +		goto err_vunmap;
>  
> -	as = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	as = ret;
>  	cfg = GPU_PERFCNT_CFG_AS(as) |
>  	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
>  
> @@ -164,6 +166,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
>  
> +	perfcnt->user = user;
> +
>  	return 0;
>  
>  err_vunmap:


