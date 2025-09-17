Return-Path: <linux-kernel+bounces-820624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4BB7D124
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D1B1C02361
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39E32340D;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="QuyD7HZs"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266321CA00
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111355; cv=pass; b=kHTgBnS09h/YvNQyH7YkmNlM1a0ODeL3zp5ZqahibT6FS1J5vqxIx1RbtEjkvnFJUp9zkuk3nhmjSuUc1XDClc+eDrGpfeXPC05Ts9nvErB6oKsOESo2lr2Hu+n5IV8h9OQPtQDqJJ1ZXL8MXCxIxMvX+VnYYkYE6rzWwdfSfRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111355; c=relaxed/simple;
	bh=/uARSEIEhQyxIcBsRQy4ZR/NnVyY3zahXq29mvdWUCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFutWdcd0+jSQgBEH10S4+CeG+Fgr1MN3zsc2BvO6DaNEDqX57igK0zYT4ysL2dxtl33nxHJBj4tf20rwA+yb4xat04u3+tUs3nfIKgjeJocDdryHdKsLGq2iEhIBwur6jn8nDMIpMjlHR0edzFsiJnUVeZklrhlmxMAUga6MqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=QuyD7HZs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758111330; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kSeanP835ERU+sPMQOZzLT1XXNlvuZgyTsDJ4z9rYXVp7jSTIjUpy8aE8Upev1L5J1kpAblRnJZjKixAnf1Bo5jBWeFlgupWwCeVgaHWhg9+ay0mhGvnm3dra4leZc7G/Xlzvvz1QpD7llRbR3f03Md5E5lfdkZ1Y9gtqGwvZpc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758111330; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tuCXQM50C5H6GqSRe8znFQKW6ukBNUU7nxTcXUuTWvA=; 
	b=fNZ+ftH8mH6ZtovnRIkF9zfwrl52JdAPeimlI1KQlQEnHmmtB10xK8viTjiFg05bBeQh4kT+56k4aBLbQndrysfOta6FwTdUn4J3txm4VimNRvHcWWervbpvg81sF9qtYdHuibqcrDPXtn/7ArCdYSvBmFilYm4ZsK1/ADPHIBM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758111330;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=tuCXQM50C5H6GqSRe8znFQKW6ukBNUU7nxTcXUuTWvA=;
	b=QuyD7HZsDiNXQstBaTZkZK/VXr99bGAWErIWOHPZB7MLPRg1WuQz35DVFryV4eDl
	2C4jZqbUKJb3yYPd3BM9NO9UTsmSSEKJQW4sY4oi72kFePnN+3gFCNKHEdBMRDbzWdz
	iHlnRYcJ+W8FcYifAVZKB0FT0RwCZ2naUN6k4E2A=
Received: by mx.zohomail.com with SMTPS id 1758111329015905.5780347565031;
	Wed, 17 Sep 2025 05:15:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:15:24 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, Rob Herring <robh@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 2/4] drm/panfrost: Introduce JM contexts for manging
 job resources
Message-ID: <khadcqej7vmzkkpv5qkm4welv42lmlo66nkdbw47h3ydjsf64q@4f4yoiexlydr>
References: <20250912132002.304187-1-adrian.larumbe@collabora.com>
 <20250912132002.304187-3-adrian.larumbe@collabora.com>
 <ffc945c5-a7dc-4a83-84d5-725e603c0581@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffc945c5-a7dc-4a83-84d5-725e603c0581@arm.com>

Hi Steve, thanks for the review.

On 17.09.2025 11:15, Steven Price wrote:
> On 12/09/2025 14:19, Adrián Larumbe wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > A JM context describes user-requested priorities for the JM queues.
> >
> > Context creation leads to the initialization of scheduling entities of
> > the same priority for all the device's job slots.
> >
> > Until context creation and destruction are exposed to UM, all issued
> > jobs shall be bound to the default Panfrost file context, which has
> > medium priority.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.h |  11 +-
> >  drivers/gpu/drm/panfrost/panfrost_drv.c    |  24 ++-
> >  drivers/gpu/drm/panfrost/panfrost_job.c    | 195 +++++++++++++++++----
> >  drivers/gpu/drm/panfrost/panfrost_job.h    |  25 ++-
> >  4 files changed, 215 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index 077525a3ad68..1e73efad02a8 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -10,11 +10,13 @@
> >  #include <linux/pm.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spinlock.h>
> > +#include <drm/drm_auth.h>
> >  #include <drm/drm_device.h>
> >  #include <drm/drm_mm.h>
> >  #include <drm/gpu_scheduler.h>
> >
> >  #include "panfrost_devfreq.h"
> > +#include "panfrost_job.h"
> >
> >  struct panfrost_device;
> >  struct panfrost_mmu;
> > @@ -22,7 +24,6 @@ struct panfrost_job_slot;
> >  struct panfrost_job;
> >  struct panfrost_perfcnt;
> >
> > -#define NUM_JOB_SLOTS 3
> >  #define MAX_PM_DOMAINS 5
> >
> >  enum panfrost_drv_comp_bits {
> > @@ -206,13 +207,19 @@ struct panfrost_engine_usage {
> >  struct panfrost_file_priv {
> >  	struct panfrost_device *pfdev;
> >
> > -	struct drm_sched_entity sched_entity[NUM_JOB_SLOTS];
> > +	struct xarray jm_ctxs;
> >
> >  	struct panfrost_mmu *mmu;
> >
> >  	struct panfrost_engine_usage engine_usage;
> >  };
> >
> > +static inline bool panfrost_high_prio_allowed(struct drm_file *file)
> > +{
> > +	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
> > +	return (capable(CAP_SYS_NICE) || drm_is_current_master(file));
> > +}
> > +
> >  static inline struct panfrost_device *to_panfrost_device(struct drm_device *ddev)
> >  {
> >  	return ddev->dev_private;
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 1ea6c509a5d5..be384b18e8fd 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -279,9 +279,16 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> >  	struct panfrost_file_priv *file_priv = file->driver_priv;
> >  	struct drm_panfrost_submit *args = data;
> >  	struct drm_syncobj *sync_out = NULL;
> > +	struct panfrost_jm_ctx *jm_ctx;
> >  	struct panfrost_job *job;
> >  	int ret = 0, slot;
> >
> > +	if (args->pad)
> > +		return -EINVAL;
> > +
> > +	if (args->jm_ctx_handle)
> > +		return -EINVAL;
> > +
> >  	if (!args->jc)
> >  		return -EINVAL;
> >
> > @@ -294,10 +301,16 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> >  			return -ENODEV;
> >  	}
> >
> > +	jm_ctx = panfrost_jm_ctx_from_handle(file, args->jm_ctx_handle);
> > +	if (!jm_ctx) {
> > +		ret = -EINVAL;
> > +		goto out_put_syncout;
> > +	}
> > +
> >  	job = kzalloc(sizeof(*job), GFP_KERNEL);
> >  	if (!job) {
> >  		ret = -ENOMEM;
> > -		goto out_put_syncout;
> > +		goto out_put_jm_ctx;
> >  	}
> >
> >  	kref_init(&job->refcount);
> > @@ -307,12 +320,13 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> >  	job->requirements = args->requirements;
> >  	job->flush_id = panfrost_gpu_get_latest_flush_id(pfdev);
> >  	job->mmu = file_priv->mmu;
> > +	job->ctx = panfrost_jm_ctx_get(jm_ctx);
> >  	job->engine_usage = &file_priv->engine_usage;
> >
> >  	slot = panfrost_job_get_slot(job);
> >
> >  	ret = drm_sched_job_init(&job->base,
> > -				 &file_priv->sched_entity[slot],
> > +				 &jm_ctx->slot_entity[slot],
> >  				 1, NULL, file->client_id);
> >  	if (ret)
> >  		goto out_put_job;
> > @@ -338,6 +352,8 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> >  		drm_sched_job_cleanup(&job->base);
> >  out_put_job:
> >  	panfrost_job_put(job);
> > +out_put_jm_ctx:
> > +	panfrost_jm_ctx_put(jm_ctx);
> >  out_put_syncout:
> >  	if (sync_out)
> >  		drm_syncobj_put(sync_out);
> > @@ -564,7 +580,7 @@ panfrost_open(struct drm_device *dev, struct drm_file *file)
> >  		goto err_free;
> >  	}
> >
> > -	ret = panfrost_job_open(panfrost_priv);
> > +	ret = panfrost_job_open(file);
> >  	if (ret)
> >  		goto err_job;
> >
> > @@ -583,7 +599,7 @@ panfrost_postclose(struct drm_device *dev, struct drm_file *file)
> >  	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
> >
> >  	panfrost_perfcnt_close(file);
> > -	panfrost_job_close(panfrost_priv);
> > +	panfrost_job_close(file);
> >
> >  	panfrost_mmu_ctx_put(panfrost_priv->mmu);
> >  	kfree(panfrost_priv);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> > index 82acabb21b27..0f955dae7873 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -22,6 +22,7 @@
> >  #include "panfrost_mmu.h"
> >  #include "panfrost_dump.h"
> >
> > +#define MAX_JM_CTX_PER_FILE 64
> >  #define JOB_TIMEOUT_MS 500
> >
> >  #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
> > @@ -359,6 +360,7 @@ static void panfrost_job_cleanup(struct kref *ref)
> >  		kvfree(job->bos);
> >  	}
> >
> > +	panfrost_jm_ctx_put(job->ctx);
> >  	kfree(job);
> >  }
> >
> > @@ -383,6 +385,9 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
> >  	int slot = panfrost_job_get_slot(job);
> >  	struct dma_fence *fence = NULL;
> >
> > +	if (job->ctx->destroyed)
> > +		return ERR_PTR(-ECANCELED);
> > +
> >  	if (unlikely(job->base.s_fence->finished.error))
> >  		return NULL;
> >
> > @@ -917,39 +922,176 @@ void panfrost_job_fini(struct panfrost_device *pfdev)
> >  	destroy_workqueue(pfdev->reset.wq);
> >  }
> >
> > -int panfrost_job_open(struct panfrost_file_priv *panfrost_priv)
> > +int panfrost_job_open(struct drm_file *file)
> > +{
> > +	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
> > +	int ret;
> > +
> > +	struct drm_panfrost_jm_ctx_create default_jm_ctx = {
> > +		.priority = PANFROST_JM_CTX_PRIORITY_MEDIUM,
> > +	};
> > +
> > +	xa_init_flags(&panfrost_priv->jm_ctxs, XA_FLAGS_ALLOC);
> > +
> > +	ret = panfrost_jm_ctx_create(file, &default_jm_ctx);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* We expect the default context to be assigned handle 0. */
> > +	if (WARN_ON(default_jm_ctx.handle))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +void panfrost_job_close(struct drm_file *file)
> > +{
> > +	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
> > +	struct panfrost_jm_ctx *jm_ctx;
> > +	unsigned long i;
> > +
> > +	xa_for_each(&panfrost_priv->jm_ctxs, i, jm_ctx)
> > +		panfrost_jm_ctx_destroy(file, i);
> > +
> > +	xa_destroy(&panfrost_priv->jm_ctxs);
> > +}
> > +
> > +int panfrost_job_is_idle(struct panfrost_device *pfdev)
> >  {
> > -	struct panfrost_device *pfdev = panfrost_priv->pfdev;
> >  	struct panfrost_job_slot *js = pfdev->js;
> > -	struct drm_gpu_scheduler *sched;
> > -	int ret, i;
> > +	int i;
> >
> >  	for (i = 0; i < NUM_JOB_SLOTS; i++) {
> > -		sched = &js->queue[i].sched;
> > -		ret = drm_sched_entity_init(&panfrost_priv->sched_entity[i],
> > -					    DRM_SCHED_PRIORITY_NORMAL, &sched,
> > -					    1, NULL);
> > -		if (WARN_ON(ret))
> > -			return ret;
> > +		/* If there are any jobs in the HW queue, we're not idle */
> > +		if (atomic_read(&js->queue[i].sched.credit_count))
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static void panfrost_jm_ctx_release(struct kref *kref)
> > +{
> > +	struct panfrost_jm_ctx *jm_ctx = container_of(kref, struct panfrost_jm_ctx, refcnt);
> > +
> > +	WARN_ON(!jm_ctx->destroyed);
> > +
> > +	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity) - 1; i++)
>
> Why the "- 1" here (and below)? AFAICT you've allocated the array to the
> NUM_JOB_SLOTS long but then never use the final entry? I'll admit that
> the 3rd job slot is basically useless. But if we're going down that
> route we should just reduce NUM_JOB_SLOTS by 1 (or I guess define the
> slot_entity array with the "- 1" with a comment explaining the logic).
> Personally I'd just stick with 3 slots as then it's ready in case anyone
> is brave enough to take on the T658 and support multiple core groups
> properly.

I thought I had seen the 'for i in NUM_JOB_SLOTS - 1' or else
'ARRAY_SIZE(pfdev->jobs[0]) - 1' in a few places in the driver and thought
I'd keep allocating a three-entry array but only iterate over the first
two in case someone decided to implement compute support in the future.

I'm fine with either way of iterating over the scheduler entity slots. In fact,
a previous revision iterated over all three of them but marked the third one
as unavailable. I'll do the same and add a TODO comment that anyone daring
to implement compute support for T658 should deal with slot number 3.

I'll be sending a new revision before the end of the day.

Cheers,
Adrian

> Other than that everything looks good.

> Thanks,
> Steve
>
> > +		drm_sched_entity_destroy(&jm_ctx->slot_entity[i]);
> > +
> > +	kfree(jm_ctx);
> > +}
> > +
> > +void
> > +panfrost_jm_ctx_put(struct panfrost_jm_ctx *jm_ctx)
> > +{
> > +	if (jm_ctx)
> > +		kref_put(&jm_ctx->refcnt, panfrost_jm_ctx_release);
> > +}
> > +
> > +struct panfrost_jm_ctx *
> > +panfrost_jm_ctx_get(struct panfrost_jm_ctx *jm_ctx)
> > +{
> > +	if (jm_ctx)
> > +		kref_get(&jm_ctx->refcnt);
> > +
> > +	return jm_ctx;
> > +}
> > +
> > +struct panfrost_jm_ctx *
> > +panfrost_jm_ctx_from_handle(struct drm_file *file, u32 handle)
> > +{
> > +	struct panfrost_file_priv *priv = file->driver_priv;
> > +	struct panfrost_jm_ctx *jm_ctx;
> > +
> > +	xa_lock(&priv->jm_ctxs);
> > +	jm_ctx = panfrost_jm_ctx_get(xa_load(&priv->jm_ctxs, handle));
> > +	xa_unlock(&priv->jm_ctxs);
> > +
> > +	return jm_ctx;
> > +}
> > +
> > +static int jm_ctx_prio_to_drm_sched_prio(struct drm_file *file,
> > +					 enum drm_panfrost_jm_ctx_priority in,
> > +					 enum drm_sched_priority *out)
> > +{
> > +	switch (in) {
> > +	case PANFROST_JM_CTX_PRIORITY_LOW:
> > +		*out = DRM_SCHED_PRIORITY_LOW;
> > +		return 0;
> > +	case PANFROST_JM_CTX_PRIORITY_MEDIUM:
> > +		*out = DRM_SCHED_PRIORITY_NORMAL;
> > +		return 0;
> > +	case PANFROST_JM_CTX_PRIORITY_HIGH:
> > +		if (!panfrost_high_prio_allowed(file))
> > +			return -EACCES;
> > +
> > +		*out = DRM_SCHED_PRIORITY_HIGH;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> >  	}
> > +}
> > +
> > +int panfrost_jm_ctx_create(struct drm_file *file,
> > +			   struct drm_panfrost_jm_ctx_create *args)
> > +{
> > +	struct panfrost_file_priv *priv = file->driver_priv;
> > +	struct panfrost_device *pfdev = priv->pfdev;
> > +	enum drm_sched_priority sched_prio;
> > +	struct panfrost_jm_ctx *jm_ctx;
> > +	int ret;
> > +
> > +	jm_ctx = kzalloc(sizeof(*jm_ctx), GFP_KERNEL);
> > +	if (!jm_ctx)
> > +		return -ENOMEM;
> > +
> > +	kref_init(&jm_ctx->refcnt);
> > +
> > +	ret = jm_ctx_prio_to_drm_sched_prio(file, args->priority, &sched_prio);
> > +	if (ret)
> > +		goto err_put_jm_ctx;
> > +
> > +	for (u32 i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> > +		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
> > +
> > +		ret = drm_sched_entity_init(&jm_ctx->slot_entity[i], sched_prio,
> > +					    &sched, 1, NULL);
> > +		if (ret)
> > +			goto err_put_jm_ctx;
> > +	}
> > +
> > +	ret = xa_alloc(&priv->jm_ctxs, &args->handle, jm_ctx,
> > +		       XA_LIMIT(0, MAX_JM_CTX_PER_FILE), GFP_KERNEL);
> > +	if (ret)
> > +		goto err_put_jm_ctx;
> > +
> >  	return 0;
> > +
> > +err_put_jm_ctx:
> > +	jm_ctx->destroyed = true;
> > +	panfrost_jm_ctx_put(jm_ctx);
> > +	return ret;
> >  }
> >
> > -void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
> > +int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
> >  {
> > -	struct panfrost_device *pfdev = panfrost_priv->pfdev;
> > -	int i;
> > +	struct panfrost_file_priv *priv = file->driver_priv;
> > +	struct panfrost_device *pfdev = priv->pfdev;
> > +	struct panfrost_jm_ctx *jm_ctx;
> >
> > -	for (i = 0; i < NUM_JOB_SLOTS; i++)
> > -		drm_sched_entity_destroy(&panfrost_priv->sched_entity[i]);
> > +	jm_ctx = xa_erase(&priv->jm_ctxs, handle);
> > +	if (!jm_ctx)
> > +		return -EINVAL;
> > +
> > +	jm_ctx->destroyed = true;
> >
> >  	/* Kill in-flight jobs */
> >  	spin_lock(&pfdev->js->job_lock);
> > -	for (i = 0; i < NUM_JOB_SLOTS; i++) {
> > -		struct drm_sched_entity *entity = &panfrost_priv->sched_entity[i];
> > -		int j;
> > +	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity) - 1; i++) {
> > +		struct drm_sched_entity *entity = &jm_ctx->slot_entity[i];
> >
> > -		for (j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
> > +		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
> >  			struct panfrost_job *job = pfdev->jobs[i][j];
> >  			u32 cmd;
> >
> > @@ -980,18 +1122,7 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
> >  		}
> >  	}
> >  	spin_unlock(&pfdev->js->job_lock);
> > -}
> > -
> > -int panfrost_job_is_idle(struct panfrost_device *pfdev)
> > -{
> > -	struct panfrost_job_slot *js = pfdev->js;
> > -	int i;
> >
> > -	for (i = 0; i < NUM_JOB_SLOTS; i++) {
> > -		/* If there are any jobs in the HW queue, we're not idle */
> > -		if (atomic_read(&js->queue[i].sched.credit_count))
> > -			return false;
> > -	}
> > -
> > -	return true;
> > +	panfrost_jm_ctx_put(jm_ctx);
> > +	return 0;
> >  }
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
> > index ec581b97852b..5a30ff1503c6 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> > @@ -18,6 +18,7 @@ struct panfrost_job {
> >
> >  	struct panfrost_device *pfdev;
> >  	struct panfrost_mmu *mmu;
> > +	struct panfrost_jm_ctx *ctx;
> >
> >  	/* Fence to be signaled by IRQ handler when the job is complete. */
> >  	struct dma_fence *done_fence;
> > @@ -39,10 +40,30 @@ struct panfrost_job {
> >  	u64 start_cycles;
> >  };
> >
> > +struct panfrost_js_ctx {
> > +	struct drm_sched_entity sched_entity;
> > +	bool enabled;
> > +};
> > +
> > +#define NUM_JOB_SLOTS 3
> > +
> > +struct panfrost_jm_ctx {
> > +	struct kref refcnt;
> > +	bool destroyed;
> > +	struct drm_sched_entity slot_entity[NUM_JOB_SLOTS];
> > +};
> > +
> > +int panfrost_jm_ctx_create(struct drm_file *file,
> > +			   struct drm_panfrost_jm_ctx_create *args);
> > +int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle);
> > +void panfrost_jm_ctx_put(struct panfrost_jm_ctx *jm_ctx);
> > +struct panfrost_jm_ctx *panfrost_jm_ctx_get(struct panfrost_jm_ctx *jm_ctx);
> > +struct panfrost_jm_ctx *panfrost_jm_ctx_from_handle(struct drm_file *file, u32 handle);
> > +
> >  int panfrost_job_init(struct panfrost_device *pfdev);
> >  void panfrost_job_fini(struct panfrost_device *pfdev);
> > -int panfrost_job_open(struct panfrost_file_priv *panfrost_priv);
> > -void panfrost_job_close(struct panfrost_file_priv *panfrost_priv);
> > +int panfrost_job_open(struct drm_file *file);
> > +void panfrost_job_close(struct drm_file *file);
> >  int panfrost_job_get_slot(struct panfrost_job *job);
> >  int panfrost_job_push(struct panfrost_job *job);
> >  void panfrost_job_put(struct panfrost_job *job);

Adrian Larumbe

