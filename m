Return-Path: <linux-kernel+bounces-846881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A3BC952E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD23A6021
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCFD2E62C5;
	Thu,  9 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UDo0BlK1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557B35966
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016904; cv=none; b=HJGnfhmetKoN32FGxLK7MV4EZx5Dos0Mu6wn5nSwH6+N9CTZc8dUS//6eSw3/gCCHyQU6ixLQWGi83MFOsUe+YYqVe2H1Y9iZLJ27WowdZXdxn4NkHdFpmSkD6N9L0cpYmb1gKseQ3C0EFHKr0eX8N2bF9tAN+gBEeI44ww2f1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016904; c=relaxed/simple;
	bh=CAmBj03hKuHqdR7xKw0lp59hnQtMwoRdZApMK9PloWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHJxFmFZSLpFja/+ML3YY77RccyYDeRsrSH++JGx5sxQOkSjpgEVR7Jnkj6Fg3U9F+Ag5Vv+7BJltvhw3XvGqaRAD7N41fs5xEZx9yTr/Sbo4H6SoJaZVsMaQP+mT37Vo/5zuwCFdtWgwRC4wifqSEe9tyVIBv/5Mk/gzBOvLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UDo0BlK1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760016897;
	bh=CAmBj03hKuHqdR7xKw0lp59hnQtMwoRdZApMK9PloWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDo0BlK1bY2MLwNpd5YVH+CHWNw5G63UBvAVGj/BkG/VP4kuPByH2IWmbIEiGaicL
	 QYUeAYV9ciGVt68LEtuQ7V+44rF85lTfkJAGtzFgqJJqsDgpUbUse2XAjZmUHRICk7
	 Yd0BvPd06UqmwI9NKInUowqXAqUNRWRPUmyX5t7H3085PENTGfj9jYffvqUqLYOGG6
	 xx5Y5rB2AWuwWBnf6rTuqxLz9hNXTobh6lxZGdW+KUMadhGK5ss/TLavIFHfD5pEF+
	 ssvX3fcDHEGtNkHz/++xvX4h2iUEPo/TaqLlp0pmJifbaNhY/YaxQFSoqjYKj/DWcR
	 aBf3A9Ea5bLlA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D6A8817E1060;
	Thu,  9 Oct 2025 15:34:56 +0200 (CEST)
Date: Thu, 9 Oct 2025 15:34:54 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, healych@amazon.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/panfrost: Name scheduler queues after their job
 slots
Message-ID: <20251009153454.5d04a85d@fedora>
In-Reply-To: <4400c6b4-d2ad-429a-b84c-60a2f593cff1@arm.com>
References: <20251009114313.1374948-1-adrian.larumbe@collabora.com>
	<4400c6b4-d2ad-429a-b84c-60a2f593cff1@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Oct 2025 13:45:47 +0100
Steven Price <steven.price@arm.com> wrote:

> On 09/10/2025 12:43, Adri=C3=A1n Larumbe wrote:
> > Drawing from commit d2624d90a0b7 ("drm/panthor: assign unique names to
> > queues"), give scheduler queues proper names that reflect the function
> > of their JM slot, so that this will be shown when gathering DRM
> > scheduler tracepoints.
> >=20
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =20
>=20
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

>=20
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++++++----------
> >  drivers/gpu/drm/panfrost/panfrost_job.c |  8 +++++++-
> >  drivers/gpu/drm/panfrost/panfrost_job.h |  2 ++
> >  3 files changed, 15 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/=
panfrost/panfrost_drv.c
> > index 22350ce8a08f..607a5b8448d0 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -668,23 +668,19 @@ static void panfrost_gpu_show_fdinfo(struct panfr=
ost_device *pfdev,
> >  	 *   job spent on the GPU.
> >  	 */
> > =20
> > -	static const char * const engine_names[] =3D {
> > -		"fragment", "vertex-tiler", "compute-only"
> > -	};
> > -
> > -	BUILD_BUG_ON(ARRAY_SIZE(engine_names) !=3D NUM_JOB_SLOTS);
> > -
> >  	for (i =3D 0; i < NUM_JOB_SLOTS - 1; i++) {
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
> > =20
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/=
panfrost/panfrost_job.c
> > index c47d14eabbae..0cc80da12562 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -28,6 +28,10 @@
> >  #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
> >  #define job_read(dev, reg) readl(dev->iomem + (reg))
> > =20
> > +const char * const panfrost_engine_names[] =3D {
> > +	"fragment", "vertex-tiler", "compute-only"
> > +};
> > +
> >  struct panfrost_queue_state {
> >  	struct drm_gpu_scheduler sched;
> >  	u64 fence_context;
> > @@ -846,12 +850,13 @@ int panfrost_job_init(struct panfrost_device *pfd=
ev)
> >  		.num_rqs =3D DRM_SCHED_PRIORITY_COUNT,
> >  		.credit_limit =3D 2,
> >  		.timeout =3D msecs_to_jiffies(JOB_TIMEOUT_MS),
> > -		.name =3D "pan_js",
> >  		.dev =3D pfdev->dev,
> >  	};
> >  	struct panfrost_job_slot *js;
> >  	int ret, j;
> > =20
> > +	BUILD_BUG_ON(ARRAY_SIZE(panfrost_engine_names) !=3D NUM_JOB_SLOTS);
> > +
> >  	/* All GPUs have two entries per queue, but without jobchain
> >  	 * disambiguation stopping the right job in the close path is tricky,
> >  	 * so let's just advertise one entry in that case.
> > @@ -887,6 +892,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
> > =20
> >  	for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
> >  		js->queue[j].fence_context =3D dma_fence_context_alloc(1);
> > +		args.name =3D panfrost_engine_names[j];
> > =20
> >  		ret =3D drm_sched_init(&js->queue[j].sched, &args);
> >  		if (ret) {
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/=
panfrost/panfrost_job.h
> > index 5a30ff1503c6..458666bf684b 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> > @@ -53,6 +53,8 @@ struct panfrost_jm_ctx {
> >  	struct drm_sched_entity slot_entity[NUM_JOB_SLOTS];
> >  };
> > =20
> > +extern const char * const panfrost_engine_names[];
> > +
> >  int panfrost_jm_ctx_create(struct drm_file *file,
> >  			   struct drm_panfrost_jm_ctx_create *args);
> >  int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle);
> >=20
> > base-commit: 30531e9ca7cd4f8c5740babd35cdb465edf73a2d =20
>=20


