Return-Path: <linux-kernel+bounces-847081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9933BBC9D23
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A0944FB094
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233251FE455;
	Thu,  9 Oct 2025 15:35:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC61F5825
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024149; cv=none; b=QhfnDY/iqKfRTwy3IZMeGgF7Vd6eJD3n4l/Rrq40QgC/Hf0adbEfsi8sBrLlgROuwJY4jlxxfgTEekoCv5NhyIE9Azs+zqnP/D/+gN5CpFu2s15g0jiXDkP5418PVpnN5HVKaLviqFHH/fs54ea/fI7CClxXQxlSpFPkIfkFlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024149; c=relaxed/simple;
	bh=Jiv8Y8z61m2TnkJXjvUmlNoZ1CT0gkcxUZC8dFzopTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOkeCuOHKdscGVl+92LPr/maPKbgIheBt6O4As9T92JjF0DzBv7N+tQYAlboqnk/PyAC485o+lQbnx3kef+P/iNbTz6tqP3kj+h4ZayLqMUpBzG8K4912zTv/ki7a4qaZW0wfz2D6O1/lKE8CNasnwSR6gPY0kExvh8IjucwAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3ABB1688;
	Thu,  9 Oct 2025 08:35:39 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15133F59E;
	Thu,  9 Oct 2025 08:35:44 -0700 (PDT)
Message-ID: <8b0fbe08-f3ef-4043-9a45-e5a74c1962a9@arm.com>
Date: Thu, 9 Oct 2025 16:35:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] drm/panfrost: Make re-enabling job interrupts at
 device reset optional
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
 <20251007150216.254250-9-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251007150216.254250-9-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2025 16:01, Adrián Larumbe wrote:
> Rather than remasking interrupts after a device reset in the main reset
> path, allow selecting whether to do this with an additional bool parameter.
> 
> To this end, split reenabling job interrupts into two functions, one that
> clears the interrupts and another one which unmasks them conditionally.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c |  9 ++++++---
>  drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 17 ++++++++---------
>  drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
>  4 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 733b728ec75f..f1d811a6de6c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -400,13 +400,16 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
>  	return false;
>  }
>  
> -void panfrost_device_reset(struct panfrost_device *pfdev)
> +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
>  {
>  	panfrost_gpu_soft_reset(pfdev);
>  
>  	panfrost_gpu_power_on(pfdev);
>  	panfrost_mmu_reset(pfdev);
> -	panfrost_job_enable_interrupts(pfdev);
> +
> +	panfrost_job_reset_interrupts(pfdev);
> +	if (enable_job_int)
> +		panfrost_job_enable_interrupts(pfdev);
>  }
>  
>  static int panfrost_device_runtime_resume(struct device *dev)
> @@ -430,7 +433,7 @@ static int panfrost_device_runtime_resume(struct device *dev)
>  		}
>  	}
>  
> -	panfrost_device_reset(pfdev);
> +	panfrost_device_reset(pfdev, true);
>  	panfrost_devfreq_resume(pfdev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index ac7147ed806b..45d77cda8b89 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -250,7 +250,7 @@ int panfrost_unstable_ioctl_check(void);
>  
>  int panfrost_device_init(struct panfrost_device *pfdev);
>  void panfrost_device_fini(struct panfrost_device *pfdev);
> -void panfrost_device_reset(struct panfrost_device *pfdev);
> +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
>  
>  extern const struct dev_pm_ops panfrost_pm_ops;
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index ff525d3efd76..541cdf80142d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -426,11 +426,14 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
>  	return fence;
>  }
>  
> +void panfrost_job_reset_interrupts(struct panfrost_device *pfdev)
> +{
> +	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
> +}
> +
>  void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
>  {
>  	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
> -
> -	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
>  	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
>  }
>  
> @@ -723,12 +726,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>  	spin_unlock(&pfdev->js->job_lock);
>  
>  	/* Proceed with reset now. */
> -	panfrost_device_reset(pfdev);
> -
> -	/* panfrost_device_reset() unmasks job interrupts, but we want to
> -	 * keep them masked a bit longer.
> -	 */
> -	job_write(pfdev, JOB_INT_MASK, 0);
> +	panfrost_device_reset(pfdev, false);
>  
>  	/* GPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&pfdev->reset.pending, 0);
> @@ -750,7 +748,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>  		drm_sched_start(&pfdev->js->queue[i].sched, 0);
>  
>  	/* Re-enable job interrupts now that everything has been restarted. */
> -	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
> +	panfrost_job_enable_interrupts(pfdev);
>  
>  	dma_fence_end_signalling(cookie);
>  }
> @@ -901,6 +899,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>  		}
>  	}
>  
> +	panfrost_job_reset_interrupts(pfdev);
>  	panfrost_job_enable_interrupts(pfdev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
> index 5a30ff1503c6..30eda74e3c34 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> @@ -67,6 +67,7 @@ void panfrost_job_close(struct drm_file *file);
>  int panfrost_job_get_slot(struct panfrost_job *job);
>  int panfrost_job_push(struct panfrost_job *job);
>  void panfrost_job_put(struct panfrost_job *job);
> +void panfrost_job_reset_interrupts(struct panfrost_device *pfdev);
>  void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
>  void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
>  int panfrost_job_is_idle(struct panfrost_device *pfdev);


