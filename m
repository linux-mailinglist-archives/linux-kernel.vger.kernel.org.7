Return-Path: <linux-kernel+bounces-888146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 466A7C39F54
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61B714FA873
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAA30C611;
	Thu,  6 Nov 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qovKgCVV"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEE30C602
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422655; cv=none; b=uS8XXCGBHyWisEb3EI7CB51dwTg6Sk9uglaO7wOWYlTNTRTF67WT98ouUFEuxGNdPCwdG60BHtFxSh2zOeE1kg8EAx6oEEjHmuCM7vzHxunKoqaLmt9J5LTHUL03b37cT/wh+sVFPXC1Qb8rwBSlWBop3MeSjx3sY+d+0ywtijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422655; c=relaxed/simple;
	bh=m43dYP7glDMloORiT3NvjW11E8f5qaOFyTHs6SlQjWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DByYRrl+PKHsiLECuAmNeIrDwtzshigDp2QKwX81lTH+1CFDqqH7dF4BbFgtpOfOKzZ7azlZChBMJeS3+K8mzFGO2dCZwBDDSZD2WrOOq3FT9ndItMYVYW6ZGh/B/qFcQU6P/1woAgFsi1z+mojV1yrmtqdChNiiP489zj+wSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qovKgCVV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d2HWF6KsWz9tQY;
	Thu,  6 Nov 2025 10:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762422649; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8sLIsn41o2aLlhzZn+I7H/kW8FSsCLuLR2IghUfYRI=;
	b=qovKgCVVqfBQFCQ1I+nTvI0zAyLQdFAHMqy7g7j2Hq7liQJfJO+3/vTEWDyMzuLQVB3eL1
	n/gPs8Uzk4Gj6rkZnezyxbjh6M4hQH0gtnCIEjaNRXMOq6vR+Omx8X6SGSTk7OYEnNO4nj
	Y4rSygg6M0w79FI14Q2Sv1pi5XO8zrtjpNuERa1CjN11PB/jySRp3/KhrxVeNNuoKDiZp2
	xne5CgBLjziJNVbS0OQB5MPcZkmV8CEInH3W856Qa3DJHUa6xuWKIev3ro5vdOWfPoHd4D
	ywc7AbFY/1inTAZIOA4WMXvBO3roCO28v3WpUBxuZVVfDFgBIp2ahp63/JQuJA==
Message-ID: <7317df627873853cfd2b91e5d2452ca1a9433a42.camel@mailbox.org>
Subject: Re: [PATCH v3 4/4] drm/sched: limit sched score update to jobs
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
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Tomeu Vizoso
	 <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 06 Nov 2025 10:50:43 +0100
In-Reply-To: <20251106093933.18859-4-pierre-eric.pelloux-prayer@amd.com>
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
	 <20251106093933.18859-4-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 8514c36133ca0e4e967
X-MBO-RS-META: yajwoktwpu53ojiixzwcxhidqxp35h51

nit: s/limit/Limit

On Thu, 2025-11-06 at 10:39 +0100, Pierre-Eric Pelloux-Prayer wrote:
> Currently, the scheduler score is incremented when a job is pushed to an
> entity and when an entity is attached to the scheduler.
>=20
> This leads to some bad scheduling decision where the score value is
> largely made of idle entities.
>=20
> For instance, a scenario with 2 schedulers and where 10 entities submit
> a single job, then do nothing, each scheduler will probably end up with
> a score of 5.
> Now, 5 userspace apps exit, so their entities will be dropped. In

s/Now,/Now, let's imagine

> the worst case, these apps' entities where all attached to the same

s/where/were

> scheduler and we end up with score=3D5 (the 5 remaining entities) and
> score=3D0, despite the 2 schedulers being idle.
> When new entities show up, they will all select the second scheduler
> based on its low score value, instead of alternating between the 2.
>=20
> Some amdgpu rings depended on this feature, but the previous commit
> implemented the same thing in amdgpu directly so it can be safely
> removed from drm/sched.
>=20
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Acked-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

With the commit message fixed up a little bit:

Acked-by: Philipp Stanner <phasta@kernel.org

Apply how you want :)


P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index c39f0245e3a9..8a3d99a86090 100644
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


