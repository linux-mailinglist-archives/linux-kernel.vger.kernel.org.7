Return-Path: <linux-kernel+bounces-740389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0FB0D39D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10241884130
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF222E3B1D;
	Tue, 22 Jul 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dOtFOwV2"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05142D9EE7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169843; cv=none; b=SK9APc7bEAmNFG8io1d3EOBniEpKiH6RUL0rpUx+fZTPRBROgWnwg2lHLfxibDaCDAir4IfeiDsFbBoJXMSnLhLK5N42s45r4Y0I5PrFw9Z0MXbe/WUjCkaArx3+qJpTjgNS59HOzx94N2aw2jk21hHU3XYqoajbmUTtO8FsGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169843; c=relaxed/simple;
	bh=jsSSy/EZQq/KL4x7xv0cp3iZrBIkYUwJy2lQplAbGh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1qETn6ATBOdG4psbR9vzH3YY3SxSYeJ7NACaGBdRHKwWqOP2WWCdqsFoC9vyma2e2AcxCtiD4P54Kal+DXhU/RSun/TVQsSmjMkXnpoOXNMd1QLaZVIfb8nzt48AZMHjRavFdKj7iAgxkAlD+dLtpK08rKjXt+fC2dhdXNRRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dOtFOwV2; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bmTcY17jTz9tCQ;
	Tue, 22 Jul 2025 09:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753169837; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2bLNMdIPfKO4SCOWzbgq6cW49X1f449Ft9JQplmrnM=;
	b=dOtFOwV2s+2zqp8anZO/A3wt55S5GA+OUOdwddJkA6Xjqamo+BQst4UfQ1JL6TSjS2sZWp
	hSn/PbC0KPmuOmrOM1dn+j7gU6WDQXF86SLej4or0iuiYXKr83IAVO06VaE5JEtdIhutRA
	7iIjLWAu4hlySiyyiRVjhYrK29/pHSHdDUzG+dHFCl6jGwZ2AcKK4kZ+c3ipQ8AS8UDOda
	ANr40iGCENe9NWv9sO9/iDNOuyUoHYIB0aNCliEseREeYj6OZHwTMfL2p0voQPmoXVM/QA
	HRmqPZf2SiZdS/23U9Cqow6eIx8X5zxQFEi7KbVC3M262lc2LGI2JEg04IGK4A==
Message-ID: <80f569dd3c42f11927324ea80e7c14ac2d3352b5.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Prevent stopped entities from being added to
 the run queue.
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: phasta@kernel.org, James Flowers <bold.zone2373@fastmail.com>, 
 ckoenig.leichtzumerken@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch,  skhan@linuxfoundation.org,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Date: Tue, 22 Jul 2025 09:37:11 +0200
In-Reply-To: <aH6B7JruWCkReaLw@lstrano-desk.jf.intel.com>
References: <20250720235748.2798-1-bold.zone2373@fastmail.com>
	 <66a14b005fa3dc874f4f3261b93901af1292bde9.camel@mailbox.org>
	 <e7c0f63678a93261182b69aa526217821552a150.camel@mailbox.org>
	 <DBHNK2XQHUIW.TQHV41LR5D8I@kernel.org>
	 <aH6B7JruWCkReaLw@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 41a315498ead22c9c49
X-MBO-RS-META: pxs98gsf34wnustn6xmuyoea4zjoi7m8

On Mon, 2025-07-21 at 11:07 -0700, Matthew Brost wrote:
> On Mon, Jul 21, 2025 at 12:14:31PM +0200, Danilo Krummrich wrote:
> > On Mon Jul 21, 2025 at 10:16 AM CEST, Philipp Stanner wrote:
> > > On Mon, 2025-07-21 at 09:52 +0200, Philipp Stanner wrote:
> > > > On Sun, 2025-07-20 at 16:56 -0700, James Flowers wrote:
> > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu=
/drm/scheduler/sched_main.c
> > > > > index bfea608a7106..997a2cc1a635 100644
> > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > @@ -172,8 +172,10 @@ void drm_sched_rq_update_fifo_locked(struct =
drm_sched_entity *entity,
> > > > > =C2=A0
> > > > > =C2=A0	entity->oldest_job_waiting =3D ts;
> > > > > =C2=A0
> > > > > -	rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > > > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_compare_before=
);
> > > > > +	if (!entity->stopped) {
> > > > > +		rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_compare_befor=
e);
> > > > > +	}
> > > >=20
> > > > If this is a race, then this patch here is broken, too, because you=
're
> > > > checking the 'stopped' boolean as the callers of that function do, =
too
> > > > =E2=80=93 just later. :O
> > > >=20
> > > > Could still race, just less likely.
> > > >=20
> > > > The proper way to fix it would then be to address the issue where t=
he
> > > > locking is supposed to happen. Let's look at, for example,
> > > > drm_sched_entity_push_job():
> > > >=20
> > > >=20
> > > > void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
> > > > {
> > > > 	(Bla bla bla)
> > > >=20
> > > > =C2=A0	=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6
> > > >=20
> > > > 	/* first job wakes up scheduler */
> > > > 	if (first) {
> > > > 		struct drm_gpu_scheduler *sched;
> > > > 		struct drm_sched_rq *rq;
> > > >=20
> > > > 		/* Add the entity to the run queue */
> > > > 		spin_lock(&entity->lock);
> > > > 		if (entity->stopped) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <---- Aha!
> > > > 			spin_unlock(&entity->lock);
> > > >=20
> > > > 			DRM_ERROR("Trying to push to a killed entity\n");
> > > > 			return;
> > > > 		}
> > > >=20
> > > > 		rq =3D entity->rq;
> > > > 		sched =3D rq->sched;
> > > >=20
> > > > 		spin_lock(&rq->lock);
> > > > 		drm_sched_rq_add_entity(rq, entity);
> > > >=20
> > > > 		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> > > > 			drm_sched_rq_update_fifo_locked(entity, rq, submit_ts); <---- bu=
mm!
> > > >=20
> > > > 		spin_unlock(&rq->lock);
> > > > 		spin_unlock(&entity->lock);
> > > >=20
> > > > But the locks are still being hold. So that "shouldn't be happening=
"(tm).
> > > >=20
> > > > Interesting. AFAICS only drm_sched_entity_kill() and drm_sched_fini=
()
> > > > stop entities. The former holds appropriate locks, but drm_sched_fi=
ni()
> > > > doesn't. So that looks like a hot candidate to me. Opinions?
> > > >=20
> > > > On the other hand, aren't drivers prohibited from calling
> > > > drm_sched_entity_push_job() after calling drm_sched_fini()? If the
> > > > fuzzer does that, then it's not the scheduler's fault.
> >=20
> > Exactly, this is the first question to ask.
> >=20
> > And I think it's even more restrictive:
> >=20
> > In drm_sched_fini()
> >=20
> > 	for (i =3D DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
> > 		struct drm_sched_rq *rq =3D sched->sched_rq[i];
> >=20
> > 		spin_lock(&rq->lock);
> > 		list_for_each_entry(s_entity, &rq->entities, list)
> > 			/*
> > 			 * Prevents reinsertion and marks job_queue as idle,
> > 			 * it will be removed from the rq in drm_sched_entity_fini()
> > 			 * eventually
> > 			 */
> > 			s_entity->stopped =3D true;
> > 		spin_unlock(&rq->lock);
> > 		kfree(sched->sched_rq[i]);
> > 	}
> >=20
> > In drm_sched_entity_kill()
> >=20
> > 	static void drm_sched_entity_kill(struct drm_sched_entity *entity)
> > 	{
> > 		struct drm_sched_job *job;
> > 		struct dma_fence *prev;
> >=20
> > 		if (!entity->rq)
> > 			return;
> >=20
> > 		spin_lock(&entity->lock);
> > 		entity->stopped =3D true;
> > 		drm_sched_rq_remove_entity(entity->rq, entity);
> > 		spin_unlock(&entity->lock);
> >=20
> > 		[...]
> > 	}
> >=20
> > If this runs concurrently, this is a UAF as well.
> >=20
> > Personally, I have always been working with the assupmtion that entites=
 have to
> > be torn down *before* the scheduler, but those lifetimes are not docume=
nted
> > properly.
>=20
> Yes, this is my assumption too. I would even take it further: an entity
> shouldn't be torn down until all jobs associated with it are freed as
> well. I think this would solve a lot of issues I've seen on the list
> related to UAF, teardown, etc.

That's kind of impossible with the new tear down design, because
drm_sched_fini() ensures that all jobs are freed on teardown. And
drm_sched_fini() wouldn't be called before all jobs are gone,
effectively resulting in a chicken-egg-problem, or rather: the driver
implementing its own solution for teardown.

P.


>=20
> >=20
> > There are two solutions:
> >=20
> > =C2=A0 (1) Strictly require all entities to be torn down before drm_sch=
ed_fini(),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i.e. stick to the natural ownership and =
lifetime rules here (see below).
> >=20
> > =C2=A0 (2) Actually protect *any* changes of the relevent fields of the=
 entity
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 structure with the entity lock.
> >=20
> > While (2) seems rather obvious, we run into lock inversion with this ap=
proach,
> > as you note below as well. And I think drm_sched_fini() should not mess=
 with
> > entities anyways.
> >=20
> > The ownership here seems obvious:
> >=20
> > The scheduler *owns* a resource that is used by entities. Consequently,=
 entities
> > are not allowed to out-live the scheduler.
> >=20
> > Surely, the current implementation to just take the resource away from =
the
> > entity under the hood can work as well with appropriate locking, but th=
at's a
> > mess.
> >=20
> > If the resource *really* needs to be shared for some reason (which I do=
n't see),
> > shared ownership, i.e. reference counting, is much less error prone.
>=20
> Yes, Xe solves all of this via reference counting (jobs refcount the
> entity). It's a bit easier in Xe since the scheduler and entities are
> the same object due to their 1:1 relationship. But even in non-1:1
> relationships, an entity could refcount the scheduler. The teardown
> sequence would then be: all jobs complete on the entity =E2=86=92 teardow=
n the
> entity =E2=86=92 all entities torn down =E2=86=92 teardown the scheduler.
>=20
> Matt


