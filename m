Return-Path: <linux-kernel+bounces-792535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614EB3C555
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1F43B8324
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E82264BB;
	Fri, 29 Aug 2025 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmeuDYAd"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A92BD5BB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507424; cv=none; b=gl9zOtKUcZG7q/zn10BONvqp0LJykLFwpWu4DvjEcsGl2+N5FvZNkRilgKKiVVaI5v0zZWYeY4Xcf30H9dc7q8PAfXaWQGsvGKwwY+01VI2N+AJCLpdba4wqaR6+5MsouJD/v76yZqvbPZRnmCexgTmNUahdrQINT4oN4YMOTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507424; c=relaxed/simple;
	bh=kdnjf6C/AMsFJ1bFnsQ2VRryDsgcSJByP/CfeCMRFlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtLRw/Rs2BS11QvcgX+k21Y3OL67yKby0+S8ALKlafg8+dEaYsz8IcbZC7mxOCxwskGF2njDZGl/76JP94gzVhe6/n4ZyJyiCJVh9AAtmzVcmfj1tbXegkEC/KYi0923RLyA4YWXCBdkhIdPyEwXQFYl0u3uh6NwFhfKo48rOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmeuDYAd; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d5fe46572so24510167b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756507421; x=1757112221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udiKLVNkIDA74KaNKsNLED3CYr951WL3Mof5I/6GvIs=;
        b=ZmeuDYAdX9aBsvWYhmdJ7TAlgj5q26tqJ+NYAXmSVGv3gAJaF/OghTpFxI2yhx28s4
         uAgc77uIkBT1k4SQcBBTKPJs1YhWp7DtgiesIWRog8mLkSdNM7xiCouCBDJHZIM1wSiQ
         Xl66pJ85KjzS82h/8j7zJ57m6IYuP9Y2N0FqRrjIvOfc3KcYY41+Xb/Ihn74yWESA9sK
         j6timC7oUK4gwIakMVj86dMgotlURXElTLgTFi3g0BfbRriZEp2fc+ilQwoXCG3AGxcx
         LOO/url7huKOMAPTDVJqPuRGanBgsG8pq4kjyf7l1/kmqOZlS9JiDrA7Z+rqdI2BT886
         TXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507421; x=1757112221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udiKLVNkIDA74KaNKsNLED3CYr951WL3Mof5I/6GvIs=;
        b=iEFANHSlqcmVMzG6zYz+RT/UhqPHezgWXuD6BG4yu6lRtimfXzaWlOa4scEHA1naSt
         Zfr+wJI6USVCbxrCsQg33AdOw8jsPAyx0C7VVfvjWALwwjpFjY5SjBIhBwVBDOvoDauH
         D5eV/Y2ev9vV2MsP+Cs8pkQs4bzJdjFsS6bTELutWj04Op8L5VEaA1sDFTic+nAjpExu
         3KrFsPfKeZR5gGa2rGmOlpW5V4JCFOndiruJ3MkNDQlwimaoPNhu4ImHhuWjYwi8j7Wm
         0C/892STpWKgoOD8fFkRO466svkbZG9ua0zoQVQRGJWn5tUoIWkQSSgcl2fFt/nheP7o
         23ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXUqLPGcNkoz/1xuD6dxhWQ1tvjg/c/tRZOUY9pBHIEoT82djGKhI2YSt5aqdDq+LzOVtwDhodS4gy7bN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB01szqCCwA/vQGY/AzBzz6H+id+IS5a1MQ9+NHdorwahd7md0
	CXetfG15JOk5IJUIlk28UAhdtIlF+UOzcFKdruWxS/y/9/3SWoiL+BUEiA0a+luoRQ2G/nt9P3Q
	R9LgzOITqAdVQWpQ70BrtfF7fTLHLm+s=
X-Gm-Gg: ASbGncv2erGy5pPanXngTE+tGMz98ty3/7SgJWJcLcqSWtSBOlz8AjDzSqk45dPJ2Vp
	wAPPD0HByFTa14eFI6gjqtjKF72WIQkhKGQsb20Ig3UNFV437JnvuQYflFRqv2BcT83lRXDfakT
	a42u4raV6A6C7xgRYkWo00cyQDxvs7sm6Z6ey2uQKWlx4Uks61VvftTKeIUS0yHmboxGnSwhurq
	TWKZTNVZMWjPk9+IS9b+5NgVJvWTH4EeVMfy2Ic
X-Google-Smtp-Source: AGHT+IG7+qrK10j2OniIUuE6HYEwMQmZ44Ww1i+O+Xzn42Xt0t77rSw2hX1Ufver3FsgGcbygrcesYnK1tIHq9EWZxc=
X-Received: by 2002:a05:690c:9308:b0:71b:fdc2:e2f5 with SMTP id
 00721157ae682-72273c07007mr8660787b3.12.1756507421394; Fri, 29 Aug 2025
 15:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828200532.3534201-1-olvaffe@gmail.com> <20250829100021.361578c5@fedora>
In-Reply-To: <20250829100021.361578c5@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 29 Aug 2025 15:43:30 -0700
X-Gm-Features: Ac12FXw_fmpijziG28lSyisZ_EUbaH9OTC2ukYTDG5aMUwFtStQTYxDDoyaJoh8
Message-ID: <CAPaKu7TTwf9F20g3nqOk6Yns7zbgA9kaAonCFZJTko=9p_Q+hw@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: assign unique names to queues
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:00=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 28 Aug 2025 13:05:32 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > Userspace relies on the ring field of gpu_scheduler tracepoints to
> > identify a drm_gpu_scheduler.  The value of the ring field is taken fro=
m
> > sched->name.
> >
> > Because we typically have multiple schedulers running in parallel in
> > each process, assign unique names to schedulers such that userspace can
> > distinguish them.
> >
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>
> Two minor comments below.
>
> > ---
> >  drivers/gpu/drm/panthor/panthor_sched.c | 32 ++++++++++++++++++-------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/=
panthor/panthor_sched.c
> > index ba5dc3e443d9c..26616b6cb110d 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -360,6 +360,9 @@ struct panthor_queue {
> >       /** @entity: DRM scheduling entity used for this queue. */
> >       struct drm_sched_entity entity;
> >
> > +     /** @name: DRM scheduler name for this queue. */
> > +     char name[32];
> > +
> >       /**
> >        * @remaining_time: Time remaining before the job timeout expires=
.
> >        *
> > @@ -3308,9 +3311,10 @@ static u32 calc_profiling_ringbuf_num_slots(stru=
ct panthor_device *ptdev,
> >
> >  static struct panthor_queue *
> >  group_create_queue(struct panthor_group *group,
> > -                const struct drm_panthor_queue_create *args)
> > +                const struct drm_panthor_queue_create *args, u32 gid,
> > +                u32 qid)
> >  {
> > -     const struct drm_sched_init_args sched_args =3D {
> > +     struct drm_sched_init_args sched_args =3D {
> >               .ops =3D &panthor_queue_sched_ops,
> >               .submit_wq =3D group->ptdev->scheduler->wq,
> >               .num_rqs =3D 1,
> > @@ -3323,7 +3327,7 @@ group_create_queue(struct panthor_group *group,
> >               .credit_limit =3D args->ringbuf_size / sizeof(u64),
> >               .timeout =3D msecs_to_jiffies(JOB_TIMEOUT_MS),
> >               .timeout_wq =3D group->ptdev->reset.wq,
> > -             .name =3D "panthor-queue",
> > +             .name =3D NULL, /* will point to queue->name */
> >               .dev =3D group->ptdev->base.dev,
> >       };
> >       struct drm_gpu_scheduler *drm_sched;
> > @@ -3398,6 +3402,11 @@ group_create_queue(struct panthor_group *group,
> >       if (ret)
> >               goto err_free_queue;
> >
> > +     /* assign a unique name */
> > +     snprintf(queue->name, sizeof(queue->name), "panthor-queue-%d-%d",=
 gid,
> > +              qid);
> > +     sched_args.name =3D queue->name;
>
> Should we plan ahead and have the pid in the name too?
Yes!  I intended for the name to be unique, but incorrectly assumed
that the group pool was global.

Since group pools are per-file, I will include file->client_id in the
names in v2.

>
> > +
> >       ret =3D drm_sched_init(&queue->scheduler, &sched_args);
> >       if (ret)
> >               goto err_free_queue;
> > @@ -3540,12 +3549,18 @@ int panthor_group_create(struct panthor_file *p=
file,
> >       memset(group->syncobjs->kmap, 0,
> >              group_args->queues.count * sizeof(struct panthor_syncobj_6=
4b));
> >
> > +     ret =3D xa_alloc(&gpool->xa, &gid, group,
> > +                    XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
> > +     if (ret)
> > +             goto err_put_group;
> > +
> >       for (i =3D 0; i < group_args->queues.count; i++) {
> > -             group->queues[i] =3D group_create_queue(group, &queue_arg=
s[i]);
> > +             group->queues[i] =3D
> > +                     group_create_queue(group, &queue_args[i], gid, i)=
;
>
> nit: the limit is 100 chars now, so I think we can have it on a single
> line.
>
> >               if (IS_ERR(group->queues[i])) {
> >                       ret =3D PTR_ERR(group->queues[i]);
> >                       group->queues[i] =3D NULL;
> > -                     goto err_put_group;
> > +                     goto err_erase_gid;
> >               }
> >
> >               group->queue_count++;
> > @@ -3553,10 +3568,6 @@ int panthor_group_create(struct panthor_file *pf=
ile,
> >
> >       group->idle_queues =3D GENMASK(group->queue_count - 1, 0);
> >
> > -     ret =3D xa_alloc(&gpool->xa, &gid, group, XA_LIMIT(1, MAX_GROUPS_=
PER_POOL), GFP_KERNEL);
> > -     if (ret)
> > -             goto err_put_group;
> > -
> >       mutex_lock(&sched->reset.lock);
> >       if (atomic_read(&sched->reset.in_progress)) {
> >               panthor_group_stop(group);
> > @@ -3575,6 +3586,9 @@ int panthor_group_create(struct panthor_file *pfi=
le,
> >
> >       return gid;
> >
> > +err_erase_gid:
> > +     xa_erase(&gpool->xa, gid);
> > +
> >  err_put_group:
> >       group_put(group);
> >       return ret;
>

