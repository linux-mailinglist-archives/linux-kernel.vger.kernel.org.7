Return-Path: <linux-kernel+bounces-803002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48069B4594C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D74E2230
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3E356904;
	Fri,  5 Sep 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="DfqtuIQG"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171A3568E4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079583; cv=none; b=EYKMdPvXlFvXAF+pxXcu83b1G+NTCZAAIl8egJUqcg0Ezeh28uZSUdaosCLTOj46SAU0/HHevO1fqcSojARFrKuvDljNAiGDF41dzZwyU/h4s4r/8ptP7kivseHnYyRys5LpIxtYR+zhyuMhYR/AiBIYz8lFeCvibGoJS5gtyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079583; c=relaxed/simple;
	bh=6D6Uk8/MybLsuJa4xb10qPsyoIOJmkl+SQHxfp/h2Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sB1KX4XF4ZoRPQnDY7Fw2F+8GjaEjp0XhubdO8iyipGY+cZt9jet6SZTFLowrgGMkCfMlLWDXITo22gp+JdYjv9VRNoGIU5DpapdZafS3De2n3EdgzpXhzx7tbedOcTuZ25jCmIgHlDOtvBy970adR31g7hyyYSAJ7Ow+aEiU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=DfqtuIQG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-72485e14efbso22757367b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1757079579; x=1757684379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS92WKR70glXKDxwb7gpv6vYCrnQlNSeR6V3mFeP7Fo=;
        b=DfqtuIQGWjK+yNcSW63NJXa9l6HgN7fbu6HAh8yYOdKNaaFAWwJoFp+b1jnWPG1QQE
         BAgKdQeeobBL3nnFWrhM47yxw/slARhF4PYL2sdesqj0Ouq2bQXOSI8LAuNoNlXUbnMH
         GDUW5eJQFOCscMV8A17KxavvGjiQ11CZI4m8nKgXHFXoSM/mvYZeDL+Id83ljj4GkM3O
         V9Hl0o3C9YQOXCu9iX9OfFtnw5/vPOY+xIOrEAem6vPVK8RPyaQkPl1o7WATUfvB+7io
         pj0ylY9BK+6aKXQUFs1GXN43GZVD8x1aInDHFuItegZMjIDP1d2t7umdTefAMR9DD7xm
         RQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079579; x=1757684379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS92WKR70glXKDxwb7gpv6vYCrnQlNSeR6V3mFeP7Fo=;
        b=AmgtOFozOHlhewsITFYd/4lXmVzzn9tW9oETW5P7BvAvABVmeTNrDWnh5dkeTa9XdH
         X2y/AyXKhKKZskgOMU7I9hKrK+P6toqWv9Hg998yTuUvBEmW4rN0vqTqByW48u4V829p
         xyvxdNbBe2Z3lxl4mX6ZTE9MyhQDsYF4fWyJPGhUUafjfhWnOG2s0GRyApOot94iOCS/
         sT3Af471Yyg8MxyPBSAiLgAabnqj/o0BIFZoI2yQpdlvMt2f8paHhhlGyz926l2YJJXT
         L086SGfsMLamWGEv/MumURSEUDhQDImz/wz7OVDGD5WV6Ws9HV4eZo7EFxo/xRSniJbn
         DLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHEQ9mO9jaByldyQKNdczaRYYtPg3fhk8IrwySW003t1SNs/0hHtG28DFj3x+gq64DF/QqP2x14kbRog0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMy94z90X5QfLsmz5OAFKIu2xU6XGwnS2tmNJYokqlCPOVv8c
	TDumIkaIcNckKzQY36FFMWcWEqC5BXUxGa2UXtDz+JrDaFu+biG9cK7UV1q7ul7Ak37mSPnPS0Y
	haSWq+TBkQA==
X-Gm-Gg: ASbGnctql2p93sFJbWOU4hXEqcrjvOlPnHSORi8W42t40L7t7MzpJHmX9GsXJeoIa6w
	UidV/+cny3hxE8Ug1IpVK00jZ/dszD/lNUhsc1TiNdHi3J73DlDym7+iFYM9oi1wINQYPLUS2mw
	W4WhwgT3/0n/R+gSh914Sp9d2FgsVUeoGsAKtAb9cW4pS9+QdzNVEWT3o2JqCc1Hma9cf6tUoSM
	T5OR1uNGSCV3nk7ZNFpBtIpGsX6bA8JSvXdK1ZvwJ1/39EOycCoS37byKZHgHne1dn2V5vMbENO
	h6STta8lxpanXA/NHVJm03CZ3p4q9pfzchxidlDvYTBAqVvJc2n92CgpZUMfDq7yKl1yD8WTTv3
	9QrHLSDmj4l7JiazbN29OiAVVj5RVUv6k9kimwfLRYHY/zYiR7B1OmogdC/SDBGCowPzmrhC3zN
	83
X-Google-Smtp-Source: AGHT+IHK486zW0bEURiXmf8HrXQo9LhKf2o5yUiW5EUxLibnT0LA2y/tvrr6BH7e+ngp4yQDcu/ylA==
X-Received: by 2002:a05:690c:4912:b0:719:f1b0:5c29 with SMTP id 00721157ae682-7227635bb9bmr221057447b3.3.1757079579377;
        Fri, 05 Sep 2025 06:39:39 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a855c00esm28791307b3.59.2025.09.05.06.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:39:37 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e9e87d98ce1so324273276.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkeimFK+T8Tpj6cQiGQjk7w7JjGJwWnkx1HZtIUf/VrqHOYja2gdmX14ycQ3kgRlWmlmOfge4DaAEIK60=@vger.kernel.org
X-Received: by 2002:a05:690e:15d3:b0:5fc:1baf:eaf8 with SMTP id
 956f58d0204a3-6017609e045mr4653419d50.13.1757079577439; Fri, 05 Sep 2025
 06:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
 <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com> <abb776bc-5b13-4db7-9421-59259119b859@ursulin.net>
In-Reply-To: <abb776bc-5b13-4db7-9421-59259119b859@ursulin.net>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 5 Sep 2025 15:39:25 +0200
X-Gmail-Original-Message-ID: <CAAObsKBi9i3SKbWKsbkzX+pZcaa=UggwE=b5Yh19A+Wf3OM7QA@mail.gmail.com>
X-Gm-Features: Ac12FXzX5ADfZYxyJV2zTT7vkoFYEHBEAkT5kW_j772qczG1lJB5zDw-0vxN7ZY
Message-ID: <CAAObsKBi9i3SKbWKsbkzX+pZcaa=UggwE=b5Yh19A+Wf3OM7QA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/sched: limit sched score update to jobs change
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
	Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:20=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.ne=
t> wrote:
>
>
>
> + Tomeu and Oded
>
> On 22/08/2025 14:43, Pierre-Eric Pelloux-Prayer wrote:
> > Currently, the scheduler score is incremented when a job is pushed to a=
n
> > entity and when an entity is attached to the scheduler.
> >
> > This leads to some bad scheduling decision where the score value is
> > largely made of idle entities.
> >
> > For instance, a scenario with 2 schedulers and where 10 entities submit
> > a single job, then do nothing, each scheduler will probably end up with
> > a score of 5.
> > Now, 5 userspace apps exit, so their entities will be dropped. In
> > the worst case, these apps' entities where all attached to the same
> > scheduler and we end up with score=3D5 (the 5 remaining entities) and
> > score=3D0, despite the 2 schedulers being idle.
> > When new entities show up, they will all select the second scheduler
> > based on its low score value, instead of alternating between the 2.
> >
> > Some amdgpu rings depended on this feature, but the previous commit
> > implemented the same thing in amdgpu directly so it can be safely
> > removed from drm/sched.
> >
> > Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@a=
md.com>
> > ---
> >   drivers/gpu/drm/scheduler/sched_main.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index 5a550fd76bf0..e6d232a8ec58 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -206,7 +206,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *r=
q,
> >       if (!list_empty(&entity->list))
> >               return;
> >
> > -     atomic_inc(rq->sched->score);
> >       list_add_tail(&entity->list, &rq->entities);
> >   }
> >
> > @@ -228,7 +227,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq=
 *rq,
> >
> >       spin_lock(&rq->lock);
> >
> > -     atomic_dec(rq->sched->score);
> >       list_del_init(&entity->list);
> >
> >       if (rq->current_entity =3D=3D entity)
>
> LGTM.
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Only detail is, I did a revisit of the scheduler users and it looks like
> the new rocket driver is the only one other than amdgpu which passes a
> list of more than one scheduler to drm_sched_entity_init. I don't
> *think* it would be affected though. It would still pick the least
> loaded (based on active jobs) scheduler at job submit time. Unless there
> is some hidden behaviour in that driver where it would be important to
> consider number of entities too. Anyway, it would be good for rocket
> driver to double-check and ack.


Hello,

thanks for pinging. I think it should be fine for Rocket.

Acked-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Regards,

Tomeu

