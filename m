Return-Path: <linux-kernel+bounces-847043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9BDBC9B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8832E19E794F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC761DF246;
	Thu,  9 Oct 2025 15:17:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC041D5ADE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023052; cv=none; b=CnZLgNO7JU7nNwwrzBt2gy6nS42fHNEvDiDA6tlnT/KJD7Z9rBJFey1nsnp0V88iQXgQVbPQaiIEMSDtDtfZ4bigaVD4xgvjeqBRrfbdRmqHM75ivm3hjcyA1Kda+Cg0iG2gZDksleDPkrfkR1PetJjmSBBy2OHBBQRPlkPjKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023052; c=relaxed/simple;
	bh=5jqOKuKfhFoLEaWgi9thITVIR3ykMo/O+lz9T2klnQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/jkLceyufTGAOZDRfAHTaXv93GyAYwd5fKQWhKW+83A2DJUjsdhh0yp1W16vFPfEW4kz0MRScnuzyE2fxAAM64y0hXQaa5aJV5MSdMFTqv3IXFlvx1bZyxfPju0Ip3D6leq3kBu9Q/ChWKy8R49eLhP81tbhK9uefGO27oxsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 652601A2D;
	Thu,  9 Oct 2025 08:17:22 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E42CE3F59E;
	Thu,  9 Oct 2025 08:17:27 -0700 (PDT)
Message-ID: <ec8af377-aa1a-491f-aac3-c1c846c13ad7@arm.com>
Date: Thu, 9 Oct 2025 16:17:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] drm/panfrost: Handle error when allocating AS
 number
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
 <20251007150216.254250-5-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251007150216.254250-5-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2025 16:01, Adrián Larumbe wrote:
> If we reach the beginning of the LRU AS list, then return an error.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Very much "should never happen", but I guess adding error handling can't
hurt ;)

One minor NIT below, but either way:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c     | 6 +++++-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     | 5 +++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.h     | 2 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 9 ++++++++-
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index ea3f2878fd15..1b3af5d52081 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -213,7 +213,11 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
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
> index 718eb44b40f8..a8d821e1bde2 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -132,7 +132,12 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  
>  	perfcnt->user = user;

NIT: If we just move this line below the call to panfrost_mmu_as_get()
then we don't need the extra label and the special error handling.

Thanks,
Steve

>  
> -	as = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	if (ret < 0)
> +		goto err_unsetuser;
> +
> +	as = ret;
> +
>  	cfg = GPU_PERFCNT_CFG_AS(as) |
>  	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
>  
> @@ -166,6 +171,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  
>  	return 0;
>  
> +err_unsetuser:
> +	perfcnt->user = NULL;
>  err_vunmap:
>  	drm_gem_vunmap(&bo->base, &map);
>  err_put_mapping:


