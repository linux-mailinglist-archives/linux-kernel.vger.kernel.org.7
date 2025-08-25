Return-Path: <linux-kernel+bounces-784734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3BEB34073
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 572C44E331D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA69258EF4;
	Mon, 25 Aug 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IcuRpTvh"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAE1E6DC5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127639; cv=none; b=asepJcCCxJVQuPQmrj+UFfwGqjmDeXobZ9/j5MwbBmnFSnLb27flv6GoN3LZNjvdoVL5V79njPkj8XPa82YPv81dfz2yw8TTTQuhSnoLmEMEiRpwYdYM6zeQbYuLDjEIHqScrA39jxMbiSY6lHm1SLE2Swe1X2hzF5/kunVXH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127639; c=relaxed/simple;
	bh=8gxsbPhLhCm8RlDO8sJfCvkzQuq1s0lkrQPXpH8CPfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTnJrk7Affqw0YZyQV5zO8X2KjUb9eV1fg/IGx6ShL6If/ruIINPoi5nm/TYzhzx0ulXZi5S04ZOjYbW1tE58oeMbZJwql6RspIQHjUQz/b+b2pViOfAkrjbeihkQ5qNJ/cuYgBhVdMm46N/x3TIBt0ay13xoMfDqhPIKuiy30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IcuRpTvh; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c9WTF0FkHz9tCT;
	Mon, 25 Aug 2025 15:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756127633; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JH3NDF6p/5eXjkoYcAAQpi+Uhvkn3l8np9GIYi07vUg=;
	b=IcuRpTvhvOpk0HGLV5WWCm8ZQ6j5PATJBeLHwiyCXWvQrYlyVQAjRiNdjSDFBi0aQ6nUGS
	3zkCssThuRjw2xZAFkcunMAkDSS1Di+vy/lR1Qb4DA6cEtIHWy8FquSwpF9ViFR5erNZpy
	TceEAV6JdpGm7kQqYDnEPaMquHro7modne+UpGCoVPhmPSL8JB23SrXq6i7tFFhiuuM2wA
	ASriA8MkjXn+/Ho3K6xQESHK4y5CpyKWivjri7hhKZLm5gEYLSYSYD0L4f0MXbo9GyveOD
	Ysj5mMNZDF0AumB5AdhtcWHcEV3p28WuqRBL/1tac4a8of4/WEK0W1Rb0gW//g==
Message-ID: <9b68898ca34483b52d7f4510747a20bce52751c7.camel@mailbox.org>
Subject: Re: [PATCH v1 2/2] drm/sched: limit sched score update to jobs
 change
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,  Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2025 15:13:47 +0200
In-Reply-To: <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
	 <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 6db2928092c34427ff6
X-MBO-RS-META: ggyzgztifobbat95zdyt59uu3hig8uxy

On Fri, 2025-08-22 at 15:43 +0200, Pierre-Eric Pelloux-Prayer wrote:
> Currently, the scheduler score is incremented when a job is pushed to an
> entity and when an entity is attached to the scheduler.

It's indeed awkward why attaching is treated equivalently to job
submission.

Can you expand the documentation for drm_sched_init_args a bit so that
it gets clearer what the score is supposed to do?

>=20
> This leads to some bad scheduling decision where the score value is
> largely made of idle entities.
>=20
> For instance, a scenario with 2 schedulers and where 10 entities submit
> a single job, then do nothing, each scheduler will probably end up with
> a score of 5.
> Now, 5 userspace apps exit, so their entities will be dropped.=C2=A0
>=20

"entities will be dropped" =3D=3D "drm_sched_entity_kill() gets called",
right?

> In
> the worst case, these apps' entities where all attached to the same

s/where/were

or better yet: "could be"

> scheduler and we end up with score=3D5 (the 5 remaining entities) and
> score=3D0, despite the 2 schedulers being idle.

Sounds indeed like a (small) problem to me.


> When new entities show up, they will all select the second scheduler
> based on its low score value, instead of alternating between the 2.
>=20
> Some amdgpu rings depended on this feature, but the previous commit
> implemented the same thing in amdgpu directly so it can be safely
> removed from drm/sched.

Can we be that sure that other drivers don't depend on it, though? I
suspect it's likely that it's just amdgpu, but=E2=80=A6



BTW, since you're cleaning up related stuff currently: I saw that it
seems that the only driver that sets &struct drm_sched_init_args.score
is amdgpu. Would be cool if you can take a look whether that's still
needed.


P.

>=20
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 5a550fd76bf0..e6d232a8ec58 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -206,7 +206,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
> =C2=A0	if (!list_empty(&entity->list))
> =C2=A0		return;
> =C2=A0
> -	atomic_inc(rq->sched->score);
> =C2=A0	list_add_tail(&entity->list, &rq->entities);
> =C2=A0}
> =C2=A0
> @@ -228,7 +227,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *=
rq,
> =C2=A0
> =C2=A0	spin_lock(&rq->lock);
> =C2=A0
> -	atomic_dec(rq->sched->score);
> =C2=A0	list_del_init(&entity->list);
> =C2=A0
> =C2=A0	if (rq->current_entity =3D=3D entity)


