Return-Path: <linux-kernel+bounces-794019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1297B3DB8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A518978E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276842EDD55;
	Mon,  1 Sep 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ERBA+2yB"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448332EDD53
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713303; cv=none; b=rFQDNtOFSx4wjEcsobRLp8tKKEOgJbqKGyMtSGw9OG/6NQl4NGvhMMqX98jR3KyK4vKKDvbtBHSKg2VBeSBm202DW6mlZ22fXR6wMUSMLNXCkK1Q4iujE7FlZsfiNbigXJuNEFOddQScGv2iqQtz3OGN9QqUMSnwt1f5/yQCLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713303; c=relaxed/simple;
	bh=pcoPMR/8QdOsolSAzrU9IvrNzfJheD4dxU+iQsuynBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucQAKKwjdyjEzT+0EANYOSAFk3W31z2IfGYiB+c63ct4yNaHVTzuD8he/XZMKXaymZrnZvzLRw5HDKfrwP+t4NvXlI9zSLsORL0scTtbUGD1+JHQttkYZ3HFuLIt6/zOtkhOANF911X3WavhI/OD4+oF8UCszTrB2LOU3nPiITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ERBA+2yB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756713299;
	bh=pcoPMR/8QdOsolSAzrU9IvrNzfJheD4dxU+iQsuynBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERBA+2yBZ3e/6jNIjmGAzMRH87qsGZmm03bBijDoATPglFPThxeH2+2qw3FeJvBAj
	 wdJWCUxXF4GPMz/MLcaP92lDRtrfn4HScL3wCM/LfauZihwFU5WbSIMMaNQjxI5YZ+
	 uxOhWULcT5H5rcU2XrFt2AGfmKw7S0iYRLTNYKPIQJRHqH3V4Hbxyejjq70mTa6akt
	 fdHykyt/fzLl6EGxOjn+TBV6/uMKLHxStmbAGX+e/JCmERds4tJJbhAB3OXiZI1Hw0
	 SI2Op7PYvr7wIszWtfXVmq1CdS1bG14f7AVovXgDc2oK0DGZEr/jVzLmslZWHenwc+
	 v1Ys2Y7UHsjEg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E1AD917E00A8;
	Mon,  1 Sep 2025 09:54:58 +0200 (CEST)
Date: Mon, 1 Sep 2025 09:54:53 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Rob Herring <robh@kernel.org>, Steven Price
 <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 3/5] drm/panfrost: Introduce JM context for manging job
 resources
Message-ID: <20250901095453.19a1aead@fedora>
In-Reply-To: <CAPj87rMRkmkG2MJVnh-zMiNXJ-=fW2jzS_mX7WWWQi3hZmHUyg@mail.gmail.com>
References: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
	<20250828023422.2404784-4-adrian.larumbe@collabora.com>
	<CAPj87rMRkmkG2MJVnh-zMiNXJ-=fW2jzS_mX7WWWQi3hZmHUyg@mail.gmail.com>
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

On Sat, 30 Aug 2025 10:12:32 +0200
Daniel Stone <daniel@fooishbar.org> wrote:

> Hi Adrian,
>=20
> On Thu, 28 Aug 2025 at 04:35, Adri=C3=A1n Larumbe
> <adrian.larumbe@collabora.com> wrote:
> > -void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
> > +int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
> >  {
> > -       struct panfrost_device *pfdev =3D panfrost_priv->pfdev;
> > -       int i;
> > +       struct panfrost_file_priv *priv =3D file->driver_priv;
> > +       struct panfrost_device *pfdev =3D priv->pfdev;
> > +       struct panfrost_jm_ctx *jm_ctx;
> >
> > -       for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> > -               drm_sched_entity_destroy(&panfrost_priv->sched_entity[i=
]);
> > +       jm_ctx =3D xa_erase(&priv->jm_ctxs, handle);
> > +       if (!jm_ctx)
> > +               return -EINVAL;
> > +
> > +       for (u32 i =3D 0; i < ARRAY_SIZE(jm_ctx->slots); i++) {
> > +               if (jm_ctx->slots[i].enabled)
> > +                       drm_sched_entity_destroy(&jm_ctx->slots[i].sche=
d_entity);
> > +       }
> >
> >         /* Kill in-flight jobs */
> >         spin_lock(&pfdev->js->job_lock);
> > -       for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
> > -               struct drm_sched_entity *entity =3D &panfrost_priv->sch=
ed_entity[i];
> > -               int j;
> > +       for (u32 i =3D 0; i < ARRAY_SIZE(jm_ctx->slots); i++) {
> > +               struct drm_sched_entity *entity =3D &jm_ctx->slots[i].s=
ched_entity;
> > +
> > +               if (!jm_ctx->slots[i].enabled)
> > +                       continue;
> >
> > -               for (j =3D ARRAY_SIZE(pfdev->jobs[0]) - 1; j >=3D 0; j-=
-) {
> > +               for (int j =3D ARRAY_SIZE(pfdev->jobs[0]) - 1; j >=3D 0=
; j--) {
> >                         struct panfrost_job *job =3D pfdev->jobs[i][j];
> >                         u32 cmd;
> >
> > @@ -980,18 +1161,7 @@ void panfrost_job_close(struct panfrost_file_priv=
 *panfrost_priv)
> >                 }
> >         }
> >         spin_unlock(&pfdev->js->job_lock);
> > -}
> > -
> > -int panfrost_job_is_idle(struct panfrost_device *pfdev)
> > -{
> > -       struct panfrost_job_slot *js =3D pfdev->js;
> > -       int i;
> > -
> > -       for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
> > -               /* If there are any jobs in the HW queue, we're not idl=
e */
> > -               if (atomic_read(&js->queue[i].sched.credit_count))
> > -                       return false;
> > -       }
> >
> > -       return true;
> > +       panfrost_jm_ctx_put(jm_ctx);
> > +       return 0;
> >  } =20
>=20
> It seems odd that both panfrost_jm_ctx_destroy() and
> panfrost_jm_ctx_release() share lifetime responsibilities. I'd expect
> calling panfrost_jm_ctx_destroy() to just release the xarray handle
> and drop the refcount.

I guess you refer to the drm_sched_entity_destroy() calls. If so, I
agree that they should be removed from panfrost_jm_ctx_release() because
panfrost_jm_ctx_destroy() should always be called for the JM ctx
refcount to drop to zero.

>=20
> I can see why calling panfrost_jm_ctx_destroy() is the one to go try
> to cancel the jobs - because the jobs keep a refcount on the context,
> so we need to break that cycle somehow. But having both the
> handle-release and object-release function drop a ref on the sched
> entity seems odd?

Note that drm_sched_entity_destroy() doesn't really drop a ref, it just
flushes/cancels the jobs, and makes sure the entity is no longer
considered by the scheduler. After the first drm_sched_entity_destroy()
happens (in jm_ctx_destroy()), I'd expect entity->rq to be NULL, making
the subsequent call to drm_sched_entity_destroy() (in jm_ctx_release())
a NOP (both drm_sched_entity_{flush,fini}() bail out early if
entity->rq is NULL). Now, there might be other things in
drm_sched_entity that are not safe to cleanup twice, and I agree that
drm_sched_entity_destroy() shouldn't be called in both places anyway.

>=20
> It doesn't help much that panfrost_job is used both for actual jobs
> (as the type) and the capability for a device to have multiple
> job-manager contexts (as a function prefix). Would be great to clean
> that up, so you don't have to think about whether e.g.
> panfrost_job_close() is actually operating on a panfrost_job, or
> operating on multiple panfrost_jm_ctx which operate on multiple
> panfrost_job.

Yep, we should definitely change the prefix to panthor_jm_ when the
function manipulates the JM scheduler context.

