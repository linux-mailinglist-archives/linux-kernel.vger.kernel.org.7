Return-Path: <linux-kernel+bounces-846867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5ABC9435
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E476350C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2592E718B;
	Thu,  9 Oct 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YdfCF1OD"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED40134AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016129; cv=pass; b=fncs1QIJyQM6TfRmJYUjmSzWkqJ+cXOx37uR00Uh8x4EaKqxO7zGuLjh0PmN9z2t+83EcrrOBNX4jGKJoMvtjbU7CC69nAep2LPH4zO4BbG/TsDPHUcMBr+Od2ZIzIhY5LQkqtjT9Rfhd4PJI2oWrqARrq8PLlzb8xjC38DsrnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016129; c=relaxed/simple;
	bh=1ZPueRgCb6oxgQpxfVkaYjgCj878/QySu03wUPHYk3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdLUyavNTnOcXWybRVBRU/6ruoQhds23IEMPpUqmnlEADwdeA9yCt1FFrvKqTq+LrVQEt7rvQgOdDBQluxFUYifZp92E65QsACF3XwigMtLuI6Z7NSXX3HQbWfPD/OLuF2XMz6zfoeutGiZcb5zXPYYuveMmtk7yQkDoKFtZ8io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=YdfCF1OD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760016108; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FcempHjy+DdfSn3UtY6jSTyC3S0rYMPKr3fi9NgedRaRS0n/L58KHl4jLoen0zrBvsVYVADc/QWsiTaLOZlO19nR4MYpRY4peZqI1Oc56gCetxbIDNuTraeYgcgTR9hwlrMXfprZKJSvt6x6NYDTF0kSLRogEc1hNxOUVyWcf/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760016108; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=utjq3BLYziK+qv+6yeUlMcRAz3+MfLoZbOjnlp1/HhU=; 
	b=m/+5ynmDJ4ZUJalfjO97u0wMSs9y3yhwn3ReNWIngeouh8R9mqH0gFPzCRQibjBeodzrv3olrq2kM7FFWj/4kav72JWc/tA73+rBm7nzQOpat+Ro7zi/4nPWBfuug+kv6Y1zYsIruAT4hSmKLukmvIliEARCLx+eLUlSYDySmYc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760016108;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=utjq3BLYziK+qv+6yeUlMcRAz3+MfLoZbOjnlp1/HhU=;
	b=YdfCF1ODqZB6z1xOgktnYYu6oOMSlyfHuuQzlg22Qsu8oVRcBgej+s9chqdxJzcT
	RedEw9LR3GOdSbPzpKxtlHT+K7dWeEqNM0K1r48FRNe2ynBuUrBOf7xQlDPFP13fAkC
	LxgNQphI2oHBWDzlvqiW4+Zrh/zHvUeDz+xLW2WM=
Received: by mx.zohomail.com with SMTPS id 1760016104702252.90107138331723;
	Thu, 9 Oct 2025 06:21:44 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:21:37 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, healych@amazon.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/panfrost: Name scheduler queues after their job
 slots
Message-ID: <4efwuhiu4ijbqd44vr3tn3v5pi6ps677553ib6udlvgtonkudj@hf4le34hvnk4>
References: <20251009114313.1374948-1-adrian.larumbe@collabora.com>
 <4400c6b4-d2ad-429a-b84c-60a2f593cff1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4400c6b4-d2ad-429a-b84c-60a2f593cff1@arm.com>

Just realised I forgot to add the R-b tags.

On 09.10.2025 13:45, Steven Price wrote:
> On 09/10/2025 12:43, Adrián Larumbe wrote:
> > Drawing from commit d2624d90a0b7 ("drm/panthor: assign unique names to
> > queues"), give scheduler queues proper names that reflect the function
> > of their JM slot, so that this will be shown when gathering DRM
> > scheduler tracepoints.
> >
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>
> Reviewed-by: Steven Price <steven.price@arm.com>
>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++++++----------
> >  drivers/gpu/drm/panfrost/panfrost_job.c |  8 +++++++-
> >  drivers/gpu/drm/panfrost/panfrost_job.h |  2 ++
> >  3 files changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 22350ce8a08f..607a5b8448d0 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -668,23 +668,19 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
> >  	 *   job spent on the GPU.
> >  	 */
> >
> > -	static const char * const engine_names[] = {
> > -		"fragment", "vertex-tiler", "compute-only"
> > -	};
> > -
> > -	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
> > -
> >  	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> >  		if (pfdev->profile_mode) {
> >  			drm_printf(p, "drm-engine-%s:\t%llu ns\n",
> > -				   engine_names[i], panfrost_priv->engine_usage.elapsed_ns[i]);
> > +				   panfrost_engine_names[i],
> > +				   panfrost_priv->engine_usage.elapsed_ns[i]);
> >  			drm_printf(p, "drm-cycles-%s:\t%llu\n",
> > -				   engine_names[i], panfrost_priv->engine_usage.cycles[i]);
> > +				   panfrost_engine_names[i],
> > +				   panfrost_priv->engine_usage.cycles[i]);
> >  		}
> >  		drm_printf(p, "drm-maxfreq-%s:\t%lu Hz\n",
> > -			   engine_names[i], pfdev->pfdevfreq.fast_rate);
> > +			   panfrost_engine_names[i], pfdev->pfdevfreq.fast_rate);
> >  		drm_printf(p, "drm-curfreq-%s:\t%lu Hz\n",
> > -			   engine_names[i], pfdev->pfdevfreq.current_frequency);
> > +			   panfrost_engine_names[i], pfdev->pfdevfreq.current_frequency);
> >  	}
> >  }
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> > index c47d14eabbae..0cc80da12562 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -28,6 +28,10 @@
> >  #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
> >  #define job_read(dev, reg) readl(dev->iomem + (reg))
> >
> > +const char * const panfrost_engine_names[] = {
> > +	"fragment", "vertex-tiler", "compute-only"
> > +};
> > +
> >  struct panfrost_queue_state {
> >  	struct drm_gpu_scheduler sched;
> >  	u64 fence_context;
> > @@ -846,12 +850,13 @@ int panfrost_job_init(struct panfrost_device *pfdev)
> >  		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
> >  		.credit_limit = 2,
> >  		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
> > -		.name = "pan_js",
> >  		.dev = pfdev->dev,
> >  	};
> >  	struct panfrost_job_slot *js;
> >  	int ret, j;
> >
> > +	BUILD_BUG_ON(ARRAY_SIZE(panfrost_engine_names) != NUM_JOB_SLOTS);
> > +
> >  	/* All GPUs have two entries per queue, but without jobchain
> >  	 * disambiguation stopping the right job in the close path is tricky,
> >  	 * so let's just advertise one entry in that case.
> > @@ -887,6 +892,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
> >
> >  	for (j = 0; j < NUM_JOB_SLOTS; j++) {
> >  		js->queue[j].fence_context = dma_fence_context_alloc(1);
> > +		args.name = panfrost_engine_names[j];
> >
> >  		ret = drm_sched_init(&js->queue[j].sched, &args);
> >  		if (ret) {
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
> > index 5a30ff1503c6..458666bf684b 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> > @@ -53,6 +53,8 @@ struct panfrost_jm_ctx {
> >  	struct drm_sched_entity slot_entity[NUM_JOB_SLOTS];
> >  };
> >
> > +extern const char * const panfrost_engine_names[];
> > +
> >  int panfrost_jm_ctx_create(struct drm_file *file,
> >  			   struct drm_panfrost_jm_ctx_create *args);
> >  int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle);
> >
> > base-commit: 30531e9ca7cd4f8c5740babd35cdb465edf73a2d


Adrian Larumbe

