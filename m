Return-Path: <linux-kernel+bounces-843186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FCBBBE970
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FB60349FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757982D7DE3;
	Mon,  6 Oct 2025 16:07:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF682D8DC2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766833; cv=none; b=CUUe0HMfvHMUeD1kJ2/VwZQvdOHfs63Sa95cBWPUZBZSIxu/gR7+6RgviEJY1pJswoJTwMlbKmxXxaVg0xwqa9oC+bQu5jWehb4XzKjzrs85phITDKAGG2L/VNYychvkDJWZb86gGhcMAlXUisl1DVzuQSwfzzDttKuURwJEloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766833; c=relaxed/simple;
	bh=u06vwWlbhYRmbDghVQZCfzW2x3lwkhJmjTal/yIbbAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svdUYOy+2aEVS+HYsRLQkeCw2JGuMkkqu70gUB6WpnykS/0TbEmKlLTDZfQmqIl+PA/0aLtqJj9qTaRl9hhkaWNILZbYCpY3IOZ/xOBD68ONuv0/17dIJ3pD0DAQ5/JfkIggkLavlurToIyxOrdwr6R47WMYn9+Iv8OnK3EUazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 021FF1515;
	Mon,  6 Oct 2025 09:07:02 -0700 (PDT)
Received: from [10.57.34.189] (unknown [10.57.34.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DBCD3F738;
	Mon,  6 Oct 2025 09:07:07 -0700 (PDT)
Message-ID: <f20a1595-d5a8-4f3c-8b08-f7c743ca37e9@arm.com>
Date: Mon, 6 Oct 2025 17:07:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] drm/panfrost: Handle job HW submit errors
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
 <20251001022039.1215976-4-adrian.larumbe@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20251001022039.1215976-4-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/10/2025 03:20, Adrián Larumbe wrote:
> Avoid waiting for the DRM scheduler job timedout handler, and instead, let
> the DRM scheduler core signal the error fence immediately when HW job
> submission fails.
> 
> That means we must also decrement the runtime-PM refcnt for the device,
> because the job will never be enqueued or inflight.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index a0123d0a1b7d..3f60adc9b69d 100644
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
> @@ -208,10 +208,11 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  
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
> @@ -262,6 +263,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  			job, js, subslot, jc_head, cfg & 0xf);
>  	}
>  	spin_unlock(&pfdev->js->job_lock);
> +
> +	return 0;
> +
> +err_hwsubmit:
> +	pm_runtime_put_autosuspend(pfdev->base.dev);

I think you're missing something here. You've put a call to
pm_runtime_put_autosuspend() here which matches the call to
pm_runtime_get_sync() that we do earlier in the function. But there's no
corresponding panfrost_devfreq_record_idle() (but the first thing this
function does is panfrost_devfreq_record_busy()).

So unless I'm missing something (very possible) then this is going to
mess up the devfreq accounting. A simple fix would be just to move the
panfrost_devfreq_record_busy() call down in the function.

Thanks,
Steve

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


