Return-Path: <linux-kernel+bounces-843620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A847EBBFDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8324E2A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778FD1A4E70;
	Tue,  7 Oct 2025 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AVqMWw8K"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE942AA3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797286; cv=pass; b=iKT3zVSwcBDxa8FvF27uEnDnVsVl8jp8CI4k9jSwF4nTrLF1ZLK6p+W3VFJ8/d6yXOlp3HWfm6RrHD3GeaFJoKm4LbRlK8gqzC1CnQL59IrAohgKuSD8id60/wn9jBVUYC6N1P3JkH6PHTXEZbTAgEy3T4NKqNGneCHClXdg91w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797286; c=relaxed/simple;
	bh=jeIZeeYDF9Ng2YqqixU00pcLvIyQeOgTBAAzYPDnvAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFmZnh/jo7JVv1wE4xqRl/BJ18rzBhRl6COQd8hA2Ab1JObB2aETwI08PsKV6uB5nqfFcCP+2oJO/Qn1tjheBOj8GGH98JgenWu5l8X0Pwu8pQFRBy3LipkoR3jm0WOSSOUSEIsokAeZ9fNuCAkUheHdXooiPHtaEeW3mN7BcVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=AVqMWw8K; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759797266; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RlwrFiZvdan50H4kqXG4lG0Z+8rNongazAuAynNOTXCi/uMSqfENHoIOnarV//9ioMhh0ZOF01xTUogA1YBetW93E3owQ+v0mthBT36K9a6fkrDj16WIrvv4FADWE9RluJQVWZyDh/mri/RSTL2nLBTxLg5WhdAj/EPJ2XDVnyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759797266; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+ZMAf+X470UbdXWWHN9Qz4YlFy0BR17oOQDi8pq/BL8=; 
	b=FkUHRft9YxOn6Yb78x4Y3vnuSulVvhQA4gL+Wi2fqjF77W+sneB6e9LqPU4QBMwvZzCg7tU2uzuSeZ4aFY31c8fesweBhbq6eetYOEJ8EuJLikUKECWF1WfChQgmCX6Vd7ULkcjKRwUPvSNW8EFGA5VbhxR56e8ePilN2/M/qr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759797266;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=+ZMAf+X470UbdXWWHN9Qz4YlFy0BR17oOQDi8pq/BL8=;
	b=AVqMWw8KOSTjY6LWGoEvcARkXsY0PyytCoQqPTvxRB6Dk/bsb6jLVyJFh4gWOlW9
	laJnn2PnFFvlzlzmKAtudbiQXyIDM3/7jqc4cmU5Ne0Dd/lA1Ot2B15EagArKiaeKzo
	XDVXFFihWCb2vfETDHQwFabZKu83nBzLMOkatD4s=
Received: by mx.zohomail.com with SMTPS id 175979726147753.982398285844056;
	Mon, 6 Oct 2025 17:34:21 -0700 (PDT)
Date: Tue, 7 Oct 2025 01:34:16 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, Rob Herring <robh@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v4 03/10] drm/panfrost: Handle job HW submit errors
Message-ID: <3mtnplufdgdfjsj23s5f3ftbwwzj5t3rbjzrqmg4ahqkojxyxd@at275hsnrqip>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
 <20251001022039.1215976-4-adrian.larumbe@collabora.com>
 <f20a1595-d5a8-4f3c-8b08-f7c743ca37e9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f20a1595-d5a8-4f3c-8b08-f7c743ca37e9@arm.com>

On 06.10.2025 17:07, Steven Price wrote:
> On 01/10/2025 03:20, Adrián Larumbe wrote:
> > Avoid waiting for the DRM scheduler job timedout handler, and instead, let
> > the DRM scheduler core signal the error fence immediately when HW job
> > submission fails.
> >
> > That means we must also decrement the runtime-PM refcnt for the device,
> > because the job will never be enqueued or inflight.
> >
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_job.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> > index a0123d0a1b7d..3f60adc9b69d 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -196,7 +196,7 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
> >  	return 1;
> >  }
> >
> > -static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
> > +static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
> >  {
> >  	struct panfrost_device *pfdev = job->pfdev;
> >  	unsigned int subslot;
> > @@ -208,10 +208,11 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
> >
> >  	ret = pm_runtime_get_sync(pfdev->base.dev);
> >  	if (ret < 0)
> > -		return;
> > +		goto err_hwsubmit;
> >
> >  	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
> > -		return;
> > +		ret = -EINVAL;
> > +		goto err_hwsubmit;
> >  	}
> >
> >  	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
> > @@ -262,6 +263,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
> >  			job, js, subslot, jc_head, cfg & 0xf);
> >  	}
> >  	spin_unlock(&pfdev->js->job_lock);
> > +
> > +	return 0;
> > +
> > +err_hwsubmit:
> > +	pm_runtime_put_autosuspend(pfdev->base.dev);
>
> I think you're missing something here. You've put a call to
> pm_runtime_put_autosuspend() here which matches the call to
> pm_runtime_get_sync() that we do earlier in the function. But there's no
> corresponding panfrost_devfreq_record_idle() (but the first thing this
> function does is panfrost_devfreq_record_busy()).
>
> So unless I'm missing something (very possible) then this is going to
> mess up the devfreq accounting. A simple fix would be just to move the
> panfrost_devfreq_record_busy() call down in the function.

You didn't miss anything, I completely forgot to keep the devfreq busy
count balanced after this change.

I've moved panfrost_devfreq_record_busy() right after the point the function
can no longer result in an error, as you suggested.

> Thanks,
> Steve
>
> > +	return ret;
> >  }
> >
> >  static int panfrost_acquire_object_fences(struct drm_gem_object **bos,
> > @@ -384,6 +391,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
> >  	struct panfrost_device *pfdev = job->pfdev;
> >  	int slot = panfrost_job_get_slot(job);
> >  	struct dma_fence *fence = NULL;
> > +	int ret;
> >
> >  	if (job->ctx->destroyed)
> >  		return ERR_PTR(-ECANCELED);
> > @@ -405,7 +413,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
> >  		dma_fence_put(job->done_fence);
> >  	job->done_fence = dma_fence_get(fence);
> >
> > -	panfrost_job_hw_submit(job, slot);
> > +	ret = panfrost_job_hw_submit(job, slot);
> > +	if (ret) {
> > +		dma_fence_put(fence);
> > +		return ERR_PTR(ret);
> > +	}
> >
> >  	return fence;
> >  }

Adrian Larumbe

