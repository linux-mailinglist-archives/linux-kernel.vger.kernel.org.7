Return-Path: <linux-kernel+bounces-844169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F23BC1360
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F94189057A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0B62D97BC;
	Tue,  7 Oct 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YNtkdE93"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACF34BA2C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836509; cv=none; b=tv6CfhCxssDi7hXwV13rsZceIL2NYLE/6Ru+mY32+pkX850ts5KyQsnCMejJjzJXACgKe07ItBfV3I3Tq3qN5tJ0iJEQWqWwqVQA0r3u6SfFlfOaMbhG1tv+Oh/TXqjvLloZByhlixM0s9kHImy5x4I26xS0OivDaOkQfLhYe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836509; c=relaxed/simple;
	bh=X8ibm6mwXUKuf5zA0Klh9+LelexJixD5qsdcA0p0dgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQN2XnG/B7FPZ+j86rLSms3m3mztaTf9nAh5ZgCNS5ePh7UAB/DFeJ9wH7tYerpHUy8Cqzef+1yO1IKTYjXbaEkmkZ07c6kM+r5ay5HpmO5Pj9LbvNlDdgEBzUz+zyG2zkw19tNB3fvIgtzqDbjHtF3PvANCow6j3NyVzuuDYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YNtkdE93; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759836505;
	bh=X8ibm6mwXUKuf5zA0Klh9+LelexJixD5qsdcA0p0dgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNtkdE93NWeExvFMBV1th1X1miySswXnQH2ejOYwNWulYNu2BC+rkKuvDj4CghJS2
	 wXUTYLskMAiNNYC34pn4p+zxB9UOmVzeaoD0zlGVx87VV/+58Gte+7h809pO7B8L5h
	 odPyDUl1mQ4YwdpQZv/ME92tJZmpreB/3GbcULufPWV5biHnt0cVATCGWvIySqV4c+
	 7c7wJ3IQY8QaAVHX902LX4b+vJAHkUwQ4gUJFVoksML8S1Nl8C9C8imaI7Kl7XJu1F
	 XLo8atMA9UqHav/GhOxtWrhRJeXCA6Rfp3fHsKW6VN6lynGNTjvxAUuRlcKdfmMpC/
	 bMs1YyvaVNmkg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87E1217E1256;
	Tue,  7 Oct 2025 13:28:24 +0200 (CEST)
Date: Tue, 7 Oct 2025 13:28:19 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH] drm/panfrost: Name scheduler queues after their job
 slots
Message-ID: <20251007132819.24fcb395@fedora>
In-Reply-To: <20251002171139.2067139-1-adrian.larumbe@collabora.com>
References: <20251002171139.2067139-1-adrian.larumbe@collabora.com>
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

On Thu,  2 Oct 2025 18:11:37 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Drawing from commit d2624d90a0b7 ("drm/panthor: assign unique names to
> queues"), give scheduler queues proper names that reflect the function
> of their JM slot, so that this will be shown when gathering DRM
> scheduler tracepoints.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 6 ------
>  drivers/gpu/drm/panfrost/panfrost_job.c | 6 +++++-
>  drivers/gpu/drm/panfrost/panfrost_job.h | 2 ++
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 22350ce8a08f..d08c87bc63a2 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -668,12 +668,6 @@ static void panfrost_gpu_show_fdinfo(struct panfrost=
_device *pfdev,
>  	 *   job spent on the GPU.
>  	 */
> =20
> -	static const char * const engine_names[] =3D {
> -		"fragment", "vertex-tiler", "compute-only"
> -	};
> -
> -	BUILD_BUG_ON(ARRAY_SIZE(engine_names) !=3D NUM_JOB_SLOTS);
> -
>  	for (i =3D 0; i < NUM_JOB_SLOTS - 1; i++) {
>  		if (pfdev->profile_mode) {
>  			drm_printf(p, "drm-engine-%s:\t%llu ns\n",
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index c47d14eabbae..0f0340ffee19 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -28,6 +28,10 @@
>  #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
>  #define job_read(dev, reg) readl(dev->iomem + (reg))
> =20
> +const char * const engine_names[] =3D {
> +	"fragment", "vertex-tiler-compute", "compute-only"

As you already pointed out in a private discussion, it's probably better
if we keep the existing names, so we don't risk regressing fdinfo users.

> +};
> +
>  struct panfrost_queue_state {
>  	struct drm_gpu_scheduler sched;
>  	u64 fence_context;
> @@ -846,7 +850,6 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>  		.num_rqs =3D DRM_SCHED_PRIORITY_COUNT,
>  		.credit_limit =3D 2,
>  		.timeout =3D msecs_to_jiffies(JOB_TIMEOUT_MS),
> -		.name =3D "pan_js",
>  		.dev =3D pfdev->dev,
>  	};
>  	struct panfrost_job_slot *js;
> @@ -887,6 +890,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
> =20
>  	for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
>  		js->queue[j].fence_context =3D dma_fence_context_alloc(1);
> +		args.name =3D engine_names[j];
> =20
>  		ret =3D drm_sched_init(&js->queue[j].sched, &args);
>  		if (ret) {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/pa=
nfrost/panfrost_job.h
> index 5a30ff1503c6..52ff10b8d3d0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> @@ -53,6 +53,8 @@ struct panfrost_jm_ctx {
>  	struct drm_sched_entity slot_entity[NUM_JOB_SLOTS];
>  };
> =20
> +extern const char * const engine_names[];
> +
>  int panfrost_jm_ctx_create(struct drm_file *file,
>  			   struct drm_panfrost_jm_ctx_create *args);
>  int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle);
>=20
> base-commit: 30531e9ca7cd4f8c5740babd35cdb465edf73a2d


