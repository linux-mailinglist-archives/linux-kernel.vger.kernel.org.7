Return-Path: <linux-kernel+bounces-847041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE9BC9B88
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D648C3473D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2018859B;
	Thu,  9 Oct 2025 15:17:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878015D1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023050; cv=none; b=jljcXII0wZCCoEHtbHctXuoUpGYUD+XVxwyNDlWGK4JxRIRec539l/SQX+zn3E1pAKYOtLXS5KcC1kPv0Y7YB61FuMQM3RO23fGqITuGCCMagxtvaoM75WKl05oOmsBM0hrhFuGpv4zXK/kSZh5Y4oRp3GuI87zwULBDyncOG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023050; c=relaxed/simple;
	bh=yMT4j40UU3AQhF/ldrc+EL/aD0wn0bT353e6lwBQSxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMzzOycP/hoOwSPCHDShT2BSz39JCX7bGXl2jesYlTYImRSw04ZyfOSBJphNW5xODGRgqWQGhMds+l9QFb2ipMSXNLXUHGt0bh40nkb3AAr59Wp7LwlMwKXzXw2aLHWB0bbi4FJE6mbrW4rs6kzimdhDGSiLJdCooKkauQbyGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89CBA1688;
	Thu,  9 Oct 2025 08:17:19 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBF6F3F59E;
	Thu,  9 Oct 2025 08:17:23 -0700 (PDT)
Message-ID: <936703a3-15b6-4ade-b9e5-5554dffc4430@arm.com>
Date: Thu, 9 Oct 2025 16:17:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] drm/panfrost: Handle job HW submit errors
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
 <20251007150216.254250-4-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251007150216.254250-4-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2025 16:01, Adrián Larumbe wrote:
> Avoid waiting for the DRM scheduler job timedout handler, and instead, let
> the DRM scheduler core signal the error fence immediately when HW job
> submission fails.
> 
> That means we must also decrement the runtime-PM refcnt for the device,
> because the job will never be enqueued or inflight.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index a0123d0a1b7d..ea3f2878fd15 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -196,7 +196,7 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
>  	return 1;
>  }
>  
> -static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
> +static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  {
>  	struct panfrost_device *pfdev = job->pfdev;
>  	unsigned int subslot;
> @@ -204,18 +204,19 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  	u64 jc_head = job->jc;
>  	int ret;
>  
> -	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
> -
>  	ret = pm_runtime_get_sync(pfdev->base.dev);
>  	if (ret < 0)
> -		return;
> +		goto err_hwsubmit;
>  
>  	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
> -		return;
> +		ret = -EINVAL;
> +		goto err_hwsubmit;
>  	}
>  
>  	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
>  
> +	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
> +
>  	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
>  	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
>  
> @@ -262,6 +263,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  			job, js, subslot, jc_head, cfg & 0xf);
>  	}
>  	spin_unlock(&pfdev->js->job_lock);
> +
> +	return 0;
> +
> +err_hwsubmit:
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> +	return ret;
>  }
>  
>  static int panfrost_acquire_object_fences(struct drm_gem_object **bos,
> @@ -384,6 +391,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
>  	struct panfrost_device *pfdev = job->pfdev;
>  	int slot = panfrost_job_get_slot(job);
>  	struct dma_fence *fence = NULL;
> +	int ret;
>  
>  	if (job->ctx->destroyed)
>  		return ERR_PTR(-ECANCELED);
> @@ -405,7 +413,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
>  		dma_fence_put(job->done_fence);
>  	job->done_fence = dma_fence_get(fence);
>  
> -	panfrost_job_hw_submit(job, slot);
> +	ret = panfrost_job_hw_submit(job, slot);
> +	if (ret) {
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}
>  
>  	return fence;
>  }


