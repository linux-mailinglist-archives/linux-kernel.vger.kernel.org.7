Return-Path: <linux-kernel+bounces-795813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886FB3F835
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96771189416D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB882E6CDB;
	Tue,  2 Sep 2025 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LD+cdvM9"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAFC2E6CB3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801374; cv=none; b=M+vNgSe+CsVK+iZjIIDh6bIu6W3gXwqOXXWNaZFGTZNSSxRAYd9eaN6c/KepkHdC4bKqEfyY3VPkvoy/MKn/wrtDYh19cgG/cK+DG+iMjvwysF9rbLl1rIxv/di+64CjHC0tGPWLKBYzwBUH0pNhaawxPUM5k1cHfOmu22GJ+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801374; c=relaxed/simple;
	bh=Dc8MMwXTTGvKLpSxDRCNT5fDY5xRdaUwGFDfeKfoCio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyXTmFkDA03fmFn7XyMmDpU1Nfu8kbW6DQ81lDHU/Gtalo1psQ7ZG5KDWkVuo7bWO0piThYX0zfJuTOjFWHaAX70k4c/8sYDDGHc5xxd3v8scSS4d4paK//OlZyRyHS39BMn52yYA+7h+gHRpHW9L6fzSubMhWXFfHHhpW5FpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LD+cdvM9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cGJdh6Vqlz9tf6;
	Tue,  2 Sep 2025 10:22:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756801369; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=en6LVJI6Ft1nj1SdoDFK2xwOUoJpf4ZZcEfX+P4EGZE=;
	b=LD+cdvM90P785scDPIJYkTwA7faADZZg3nicq3+6E0gPg3rqOWM8ZDKEit21khPhyb71OE
	onfLU+dmrYxSK1znWZ/auH3AOZC7eZC95BSar0V0AghFaTOLsyYl5SPtZ5HYLFZRaIXI+C
	KF/ADLblqAPSfcLe2IQfjhjkmtBcD2QEpT3gzCDfJzs8LAnR2y6Vv+87OY/J+QoxgM+pkh
	jzC5g/2khLBGb+IdGq0tI7eV7tS9xnLQYydm7PH48l4yhsrcGtXNuW0ZlnanMkaeRmux9v
	cESFUNgxrcq00vRvbt8RMoc9o2TejmOO2jY2i2EUdgIcaHr4YZKccqryw+8CsA==
Message-ID: <b40a3e3a75a8f504f3f0e1ed678eadce9a54baf5.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Fix racy access to
 drm_sched_entity.dependency
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Matthew
 Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Sep 2025 10:22:43 +0200
In-Reply-To: <22e70ef7472310ad5147f934044a7ba0e02e02d6.camel@mailbox.org>
References: <20250901124032.1955-1-pierre-eric.pelloux-prayer@amd.com>
	 <da59f28c7d8b3d83833aa0494b3b198335cf588f.camel@mailbox.org>
	 <b9f7a493-5611-4450-a26a-10b03d1dc313@igalia.com>
	 <22e70ef7472310ad5147f934044a7ba0e02e02d6.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: gnozewwefo7gsf45314hpfrtrar58nb7
X-MBO-RS-ID: 1f685d850fb43ec053b

On Tue, 2025-09-02 at 10:18 +0200, Philipp Stanner wrote:
> On Tue, 2025-09-02 at 08:59 +0100, Tvrtko Ursulin wrote:
> >=20
> > On 02/09/2025 08:27, Philipp Stanner wrote:
> > > On Mon, 2025-09-01 at 14:40 +0200, Pierre-Eric Pelloux-Prayer wrote:
> > > > The drm_sched_job_unschedulable trace point can access
> > > > entity->dependency after it was cleared by the callback
> > > > installed in drm_sched_entity_add_dependency_cb, causing:
> > > >=20
> > > > BUG: kernel NULL pointer dereference, address: 0000000000000020
> > > > [...]
> > > > Workqueue: comp_1.1.0 drm_sched_run_job_work [gpu_sched]
> > > > RIP: 0010:trace_event_raw_event_drm_sched_job_unschedulable+0x70/0x=
d0 [gpu_sched]
> > > >=20
> > > > To fix this we either need to keep a reference to the fence before
> > > > setting up the callbacks, or move the trace_drm_sched_job_unschedul=
able
> > > > calls into drm_sched_entity_add_dependency_cb where they can be
> > > > done earlier.
> > > >=20
> > > > Fixes: 76d97c870f29 ("drm/sched: Trace dependencies for GPU jobs")
> > > >=20
> > > > Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-pray=
er@amd.com>
> > > > Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > >=20
> > > Applied to drm-misc-next
> >=20
> > Shouldn't it have been drm-misc-fixes?
>=20
> I considered that, but thought not: the fixed commit is only in this rc
> (v6.17), and in this case the committer guidelines say it should go to
> misc-next:
>=20
> https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-dr=
m-misc.html

OK, wait, the opposite is the case. I slipped to the wrong branch in
the diagram.

Oh dear. My coffee machine broke a few days ago, and it shows.

My bad, sorry. Let me ping the drm maintainers to sort that one out.

P.



>=20
> Same reason we don't need to +Cc stable.
>=20
> But correct me if I made a mistake.
>=20
> P.
>=20
>=20
> >=20
> > Regards,
> >=20
> > Tvrtko
> >=20
> > > > ---
> > > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++--=
--
> > > > =C2=A0=C2=A01 file changed, 7 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu=
/drm/scheduler/sched_entity.c
> > > > index 8867b95ab089..3d06f72531ba 100644
> > > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > @@ -391,7 +391,8 @@ EXPORT_SYMBOL(drm_sched_entity_set_priority);
> > > > =C2=A0=C2=A0 * Add a callback to the current dependency of the enti=
ty to wake up the
> > > > =C2=A0=C2=A0 * scheduler when the entity becomes available.
> > > > =C2=A0=C2=A0 */
> > > > -static bool drm_sched_entity_add_dependency_cb(struct drm_sched_en=
tity *entity)
> > > > +static bool drm_sched_entity_add_dependency_cb(struct drm_sched_en=
tity *entity,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_job *sc=
hed_job)
> > > > =C2=A0=C2=A0{
> > > > =C2=A0=C2=A0	struct drm_gpu_scheduler *sched =3D entity->rq->sched;
> > > > =C2=A0=C2=A0	struct dma_fence *fence =3D entity->dependency;
> > > > @@ -421,6 +422,10 @@ static bool drm_sched_entity_add_dependency_cb=
(struct drm_sched_entity *entity)
> > > > =C2=A0=C2=A0		entity->dependency =3D fence;
> > > > =C2=A0=C2=A0	}
> > > > =C2=A0=20
> > > > +	if (trace_drm_sched_job_unschedulable_enabled() &&
> > > > +	=C2=A0=C2=A0=C2=A0 !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity=
->dependency->flags))
> > > > +		trace_drm_sched_job_unschedulable(sched_job, entity->dependency)=
;
> > > > +
> > > > =C2=A0=C2=A0	if (!dma_fence_add_callback(entity->dependency, &entit=
y->cb,
> > > > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0 drm_sched_entity_wakeup))
> > > > =C2=A0=C2=A0		return true;
> > > > @@ -461,10 +466,8 @@ struct drm_sched_job *drm_sched_entity_pop_job=
(struct drm_sched_entity *entity)
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0	while ((entity->dependency =3D
> > > > =C2=A0=C2=A0			drm_sched_job_dependency(sched_job, entity))) {
> > > > -		if (drm_sched_entity_add_dependency_cb(entity)) {
> > > > -			trace_drm_sched_job_unschedulable(sched_job, entity->dependency=
);
> > > > +		if (drm_sched_entity_add_dependency_cb(entity, sched_job))
> > > > =C2=A0=C2=A0			return NULL;
> > > > -		}
> > > > =C2=A0=C2=A0	}
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0	/* skip jobs from entity that marked guilty */
> > >=20
> >=20
>=20


