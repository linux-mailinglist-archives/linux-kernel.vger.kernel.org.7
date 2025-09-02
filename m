Return-Path: <linux-kernel+bounces-796318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A923B3FEE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2853E3A63BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC00303CAE;
	Tue,  2 Sep 2025 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rTEFP3Ih"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3F2848AA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814055; cv=none; b=FfZu5mr6zfRhK7J11dvIS5gQSDwiLJWhS+NpYaOSAf8xDGRqVRaBZHfs9sE/5e4IOcQdSKT1B1HgCLmZjtuJyorjxWDhf9sRTE4+x38f5DaydRTbWgIAN8lRihlmxPJRwoZ67Awrm2CsLG2baJoqHN8bfnCbqH4iXWZ/KIv3iIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814055; c=relaxed/simple;
	bh=A3oYmGMRkstL2rktDLFWJEbetTQIeAZ0cKssgdD76C0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcxiSvCanl1A8KXa9hDVRsHKHBFJx58y/1LO4of9UPv+9jXZRYddTFbte1e5QzCVsSI/gKXdgJneX0iCVSFmHKX8PyMNQQhFpxk/2kzfFr72JyG6W2Pp20b+N14qihr0cPBsWU+YtMl07L2P8InozvvO+9/IzLOG7rSEdjWil4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rTEFP3Ih; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cGPKX0wrhz9tR3;
	Tue,  2 Sep 2025 13:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756814048; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQfOullEKJbtvzY93DucdIHN8FLO7u/qthSzwSFy9vY=;
	b=rTEFP3IhcEDcVCKEjC5sR0s5bQ98CVeCGFYfUfjXo02gK9IHf00Hy1WOb8Cl/6dbDQTvf8
	aU6bDns+h/UP0BSx8buaioiXnuDHPkDK217eACCfdIxVTROTteaVyIOuwf+ASPL+mArPIe
	KNWe8aHo9fUnd1EnmO2Qt53sH62Y5YM4rYq8q8cXucJpwM7CqFbfxC+L2xtHuy6Brs5pOs
	9PgPDg1K4ga4+tlu5HZTINpLIbp06aUItBpa0RuX1AhFQwZpuEJEF8wSlPeW2P7DqHs+SL
	qiISZS+J3ATfBvVVtsuu1pjByNlOSNvavaPXyQawYgG+ZtKAPiss8R6OvsA1Og==
Message-ID: <3ac127e7ae0c71c354eead23a77d2006bde42692.camel@mailbox.org>
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
Date: Tue, 02 Sep 2025 13:54:02 +0200
In-Reply-To: <b40a3e3a75a8f504f3f0e1ed678eadce9a54baf5.camel@mailbox.org>
References: <20250901124032.1955-1-pierre-eric.pelloux-prayer@amd.com>
	 <da59f28c7d8b3d83833aa0494b3b198335cf588f.camel@mailbox.org>
	 <b9f7a493-5611-4450-a26a-10b03d1dc313@igalia.com>
	 <22e70ef7472310ad5147f934044a7ba0e02e02d6.camel@mailbox.org>
	 <b40a3e3a75a8f504f3f0e1ed678eadce9a54baf5.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: d14s54ed9xbycoz7nw4dyh9twrrtknpx
X-MBO-RS-ID: cc990f10a1ae4e576e8

On Tue, 2025-09-02 at 10:22 +0200, Philipp Stanner wrote:
> On Tue, 2025-09-02 at 10:18 +0200, Philipp Stanner wrote:
> > On Tue, 2025-09-02 at 08:59 +0100, Tvrtko Ursulin wrote:
> > >=20
> > > On 02/09/2025 08:27, Philipp Stanner wrote:
> > > > On Mon, 2025-09-01 at 14:40 +0200, Pierre-Eric Pelloux-Prayer wrote=
:
> > > > > The drm_sched_job_unschedulable trace point can access
> > > > > entity->dependency after it was cleared by the callback
> > > > > installed in drm_sched_entity_add_dependency_cb, causing:
> > > > >=20
> > > > > BUG: kernel NULL pointer dereference, address: 0000000000000020
> > > > > [...]
> > > > > Workqueue: comp_1.1.0 drm_sched_run_job_work [gpu_sched]
> > > > > RIP: 0010:trace_event_raw_event_drm_sched_job_unschedulable+0x70/=
0xd0 [gpu_sched]
> > > > >=20
> > > > > To fix this we either need to keep a reference to the fence befor=
e
> > > > > setting up the callbacks, or move the trace_drm_sched_job_unsched=
ulable
> > > > > calls into drm_sched_entity_add_dependency_cb where they can be
> > > > > done earlier.
> > > > >=20
> > > > > Fixes: 76d97c870f29 ("drm/sched: Trace dependencies for GPU jobs"=
)
> > > > >=20
> > > > > Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-pr=
ayer@amd.com>
> > > > > Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > >=20
> > > > Applied to drm-misc-next
> > >=20
> > > Shouldn't it have been drm-misc-fixes?
> >=20
> > I considered that, but thought not: the fixed commit is only in this rc
> > (v6.17), and in this case the committer guidelines say it should go to
> > misc-next:
> >=20
> > https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-=
drm-misc.html
>=20
> OK, wait, the opposite is the case. I slipped to the wrong branch in
> the diagram.
>=20
> Oh dear. My coffee machine broke a few days ago, and it shows.
>=20
> My bad, sorry. Let me ping the drm maintainers to sort that one out.

Maxime was so kind to fix this for me.
Merci, Maxime, and sorry guys.

Is now on drm-misc-fixes and we're good.

P.

>=20
> P.
>=20
>=20
>=20
> >=20
> > Same reason we don't need to +Cc stable.
> >=20
> > But correct me if I made a mistake.
> >=20
> > P.
> >=20
> >=20
> > >=20
> > > Regards,
> > >=20
> > > Tvrtko
> > >=20
> > > > > ---
> > > > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++=
----
> > > > > =C2=A0=C2=A01 file changed, 7 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/g=
pu/drm/scheduler/sched_entity.c
> > > > > index 8867b95ab089..3d06f72531ba 100644
> > > > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > @@ -391,7 +391,8 @@ EXPORT_SYMBOL(drm_sched_entity_set_priority);
> > > > > =C2=A0=C2=A0 * Add a callback to the current dependency of the en=
tity to wake up the
> > > > > =C2=A0=C2=A0 * scheduler when the entity becomes available.
> > > > > =C2=A0=C2=A0 */
> > > > > -static bool drm_sched_entity_add_dependency_cb(struct drm_sched_=
entity *entity)
> > > > > +static bool drm_sched_entity_add_dependency_cb(struct drm_sched_=
entity *entity,
> > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_job *=
sched_job)
> > > > > =C2=A0=C2=A0{
> > > > > =C2=A0=C2=A0	struct drm_gpu_scheduler *sched =3D entity->rq->sche=
d;
> > > > > =C2=A0=C2=A0	struct dma_fence *fence =3D entity->dependency;
> > > > > @@ -421,6 +422,10 @@ static bool drm_sched_entity_add_dependency_=
cb(struct drm_sched_entity *entity)
> > > > > =C2=A0=C2=A0		entity->dependency =3D fence;
> > > > > =C2=A0=C2=A0	}
> > > > > =C2=A0=20
> > > > > +	if (trace_drm_sched_job_unschedulable_enabled() &&
> > > > > +	=C2=A0=C2=A0=C2=A0 !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &enti=
ty->dependency->flags))
> > > > > +		trace_drm_sched_job_unschedulable(sched_job, entity->dependenc=
y);
> > > > > +
> > > > > =C2=A0=C2=A0	if (!dma_fence_add_callback(entity->dependency, &ent=
ity->cb,
> > > > > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0 drm_sched_entity_wakeup))
> > > > > =C2=A0=C2=A0		return true;
> > > > > @@ -461,10 +466,8 @@ struct drm_sched_job *drm_sched_entity_pop_j=
ob(struct drm_sched_entity *entity)
> > > > > =C2=A0=20
> > > > > =C2=A0=C2=A0	while ((entity->dependency =3D
> > > > > =C2=A0=C2=A0			drm_sched_job_dependency(sched_job, entity))) {
> > > > > -		if (drm_sched_entity_add_dependency_cb(entity)) {
> > > > > -			trace_drm_sched_job_unschedulable(sched_job, entity->dependen=
cy);
> > > > > +		if (drm_sched_entity_add_dependency_cb(entity, sched_job))
> > > > > =C2=A0=C2=A0			return NULL;
> > > > > -		}
> > > > > =C2=A0=C2=A0	}
> > > > > =C2=A0=20
> > > > > =C2=A0=C2=A0	/* skip jobs from entity that marked guilty */
> > > >=20
> > >=20
> >=20
>=20


