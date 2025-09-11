Return-Path: <linux-kernel+bounces-812760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5FB53C56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587E216469E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129EB267B89;
	Thu, 11 Sep 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="kASgYeAZ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051C25F798
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619325; cv=pass; b=dGRRDf9PzZql08th2YCUM1v1vFg/5U2S42k0OxN2R8ZL9kMutFhvX616EV7U6fMtzSu0nQ+d7mtQUa9B99BJ5jRo9q+JwarXD7fksSJWk7JpSTTCgk5bPE9mO+MkqqVrQwiV93xUbDR60cXtamcDCFQKlWj1wnJFEwGfXWFlT6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619325; c=relaxed/simple;
	bh=yKPuSiB4DaFpEdabMvyhA/f31/QRzEWyp4sbMnEmhn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEy4Hk5U7f0UcoiAozAptPzzN7C2rQBcW7uH6HOjlLqCtFAias8KoxhxXw5/GU/MY9uoV3n9X+iJA2Sz3nPWHi9DCf/iWFDCzKzU25zuITObDhK794aOimzVIP3Jkb6DB96SkB8s5oIMIcIG5FQLmgFgjEE/LC1t2dGP9ByfINo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=kASgYeAZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757619302; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R8NUsHG1jmmI+81c8fHhLqdf1yGWxoItdONK7onzteCxZVJNiplmTLW6vQ/y5Q6/q3TuBFNnpvYqyVMJsns9NwUROGHRGO/pceBRmlNEtJ450neTC74IY3xduTAumhH1pxyqxHqUCYZIaKdyBZBA0yecthB03H7xUN8icatoGCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757619302; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XJjFIh9EwKZBb5wnlvbbwIsPRnAfea2hTk/TU92RDko=; 
	b=RoC38DpPTLa9T44d9yb9F6hTf7V0K9uY9t/A+ulce7g9VQbjNNJB4c1uVWcC5S85NkoUEBGAC2pDnzruiMvtn+KVXrBKkd4+iiJRj/kon9FjHXN9wEfDalic0aLOEgDF47TjhkcAT10fxm3rEVBl9iTbMJnCAxm5ZpNzaMDNfIQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757619302;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=XJjFIh9EwKZBb5wnlvbbwIsPRnAfea2hTk/TU92RDko=;
	b=kASgYeAZqSNVf5terchRPavq0KfI3xRfO1oZKDZihwhtSyPXSQQ0WupRazY7pyan
	ZTXqbcOklXF5tN/3tXqfeWFoNFKxQX9XY4qmrj/Jm4rNe1VUrJYGUfUDquDq9INCoi/
	C/JMVRiJqa+7YZZxzvB45ZVAaCB7YvZHv9klqPwE=
Received: by mx.zohomail.com with SMTPS id 175761930133947.356696681226936;
	Thu, 11 Sep 2025 12:35:01 -0700 (PDT)
Date: Thu, 11 Sep 2025 20:34:57 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, Rob Herring <robh@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 3/4] drm/panfrost: Expose JM context IOCTLs to UM
Message-ID: <4sp5ary2xfd7yjqux4yex5vtb3gmcrhwsg5mnoeirubzf62eot@ydroedwvv6pb>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
 <20250904001054.147465-4-adrian.larumbe@collabora.com>
 <1b270301-c5d1-4054-a602-aa6e227bd85e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b270301-c5d1-4054-a602-aa6e227bd85e@arm.com>

On 10.09.2025 16:42, Steven Price wrote:
> On 04/09/2025 01:08, Adrián Larumbe wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > Minor revision of the driver must be bumped because this expands the
> > uAPI. On top of that, let user know the available priorities so that
> > they can create contexts with legal priority values.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 35 +++++++++++++++++++++++--
> >  1 file changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 398c067457d9..02f704ec4961 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <drm/panfrost_drm.h>
> > +#include <drm/drm_auth.h>
> >  #include <drm/drm_debugfs.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_ioctl.h>
> > @@ -109,6 +110,15 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
> >  #endif
> >  		break;
> >
> > +	case DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES:
> > +		param->value = BIT(PANFROST_JM_CTX_PRIORITY_LOW) |
> > +			       BIT(PANFROST_JM_CTX_PRIORITY_MEDIUM);
> > +
> > +		/* High prio require CAP_SYS_NICE or DRM_MASTER */
> > +		if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
>
> NIT: This is repeating the check in jm_ctx_prio_to_drm_sched_prio(). It
> would be nice to have this check in one place to ensure that the two
> cannot get out of sync.

I noticed some other drivers are performing the same check, e.g.

- amdgpu: in amdgpu_ctx_priority_permit()
- imagination: remap_priority
- panthor ...

Which makes me wonder, maybe adding a helper to drm_auth.c would be good in this case?
Anyway, that perhaps should be matter for a different patch .


> > +			param->value |= BIT(PANFROST_JM_CTX_PRIORITY_HIGH);
> > +		break;
> > +
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -295,8 +305,7 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> >  			return -ENODEV;
> >  	}
> >
> > -	/* TODO: Use the default JM context until ctx management IOCTLs are exposed */
> > -	jm_ctx = panfrost_jm_ctx_from_handle(file, 0);
> > +	jm_ctx = panfrost_jm_ctx_from_handle(file, args->jm_ctx_handle);
>
> I'm not sure if this should go in this patch or the previous one, but:
> we need to add a check that the padding is 0. Personally I'd be tempted
> to put it in the previous patch and enforce that jm_ctx_handle is zeroed
> too (and drop that check here when you also remove the TODO).

Acked.

> >  	if (!jm_ctx) {
> >  		ret = -EINVAL;
> >  		goto out_put_syncout;
> > @@ -547,6 +556,24 @@ static int panfrost_ioctl_set_label_bo(struct drm_device *ddev, void *data,
> >  	return ret;
> >  }
> >
> > +static int panfrost_ioctl_jm_ctx_create(struct drm_device *dev, void *data,
> > +					struct drm_file *file)
> > +{
> > +	return panfrost_jm_ctx_create(file, data);
> > +}
> > +
> > +static int panfrost_ioctl_jm_ctx_destroy(struct drm_device *dev, void *data,
> > +					 struct drm_file *file)
> > +{
> > +	const struct drm_panfrost_jm_ctx_destroy *args = data;
> > +
> > +	/* We can't destroy the default context created when the file is opened. */
> > +	if (!args->handle)
> > +		return -EINVAL;
>
> Also need a check for padding being non-zero.
>
> Thanks,
> Steve
>
> > +
> > +	return panfrost_jm_ctx_destroy(file, args->handle);
> > +}
> > +
> >  int panfrost_unstable_ioctl_check(void)
> >  {
> >  	if (!unstable_ioctls)
> > @@ -614,6 +641,8 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
> >  	PANFROST_IOCTL(PERFCNT_DUMP,	perfcnt_dump,	DRM_RENDER_ALLOW),
> >  	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
> >  	PANFROST_IOCTL(SET_LABEL_BO,	set_label_bo,	DRM_RENDER_ALLOW),
> > +	PANFROST_IOCTL(JM_CTX_CREATE,	jm_ctx_create,	DRM_RENDER_ALLOW),
> > +	PANFROST_IOCTL(JM_CTX_DESTROY,	jm_ctx_destroy,	DRM_RENDER_ALLOW),
> >  };
> >
> >  static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
> > @@ -710,6 +739,8 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
> >   * - 1.3 - adds JD_REQ_CYCLE_COUNT job requirement for SUBMIT
> >   *       - adds SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY queries
> >   * - 1.4 - adds SET_LABEL_BO
> > + * - 1.5 - adds JM_CTX_{CREATE,DESTROY} ioctls and extend SUBMIT to allow
> > + *	   context creation with configurable priorities/affinity
> >   */
> >  static const struct drm_driver panfrost_drm_driver = {
> >  	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,

Adrian Larumbe

