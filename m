Return-Path: <linux-kernel+bounces-768732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E964AB264B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCE93BF8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB42FAC03;
	Thu, 14 Aug 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dRmLTaVy"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02341474CC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172203; cv=none; b=a82V3f6X2gnsVsDcXEzLNPpYZFuumbwR+XunoQODQ2KYB/EJ7DwUaSqYflyCoSglaQJX0EBx0CXuKUKRMK/NwCKWRGJuyQ+boLXXq659LVW+k7tKELfQ1aC6U45ttffizMXbS9AA477IfbK5shRLSokq9I7HS4LH82zNRNJnZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172203; c=relaxed/simple;
	bh=GxAO8GxUO5oPkP2NA6EgoFzE0QBWX6GYHSPf/SfIVsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3+NXI9w31y0ygIR6XT6lx3kErfZe6Jw25XKyo++Coc2PI/XSYbTcvrpHHiLbH/uNpLMGn1YL+zUDIaTkVb+oJ8onfwJmRJqGb3ddwyc4ngW9mOnTEVkZThD3kQ7+k//lWIjOI+J7yD8hlIT3FhzhevydNrhtFF/btu1gXZUbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dRmLTaVy; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c2k7S027kz9shj;
	Thu, 14 Aug 2025 13:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755172196; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxAO8GxUO5oPkP2NA6EgoFzE0QBWX6GYHSPf/SfIVsc=;
	b=dRmLTaVyUVk7gYm8POtNwrVNTfgdF3cByJB3pkuJX57pGVwxTw3BPa27iHtLISt1bW5eVr
	W/wKu/qH/KncFCY0rMzW9Q5nKM7t/86/MJkIk1NuAa8e+o5XSROwaqfpdl+GqF1vLJ2jRo
	NBGXAHVjdryKHmKbvNzutuT0R16wo9iUqH4qxaR92GoNcjL1JsjjvCh06b6M/aqYF/6wFR
	9LYqEVBHFuhX466rpokIYeZ67OyH2N9IIvfldZ44K9G26xlCJOYoox3nkShB4apf+kVdmI
	S23CWtXZOHTLiVWQzijJy9BQua4JgngeTaCFYW+atMNCA+ASuFooBnuQTrbNZQ==
Message-ID: <7404e73561283f806456d1ecab92fbc17dfdd57a.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Prevent stopped entities from being added to
 the run queue.
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, James
 Flowers <bold.zone2373@fastmail.com>, matthew.brost@intel.com,
 dakr@kernel.org,  ckoenig.leichtzumerken@gmail.com,
 maarten.lankhorst@linux.intel.com,  mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 skhan@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Date: Thu, 14 Aug 2025 13:49:50 +0200
In-Reply-To: <0e5b8c8c-8faf-4167-b4a4-d35215c1d4d9@igalia.com>
References: <20250720235748.2798-1-bold.zone2373@fastmail.com>
	 <66a14b005fa3dc874f4f3261b93901af1292bde9.camel@mailbox.org>
	 <67c6a43a-a18b-4b5c-bb43-ba3aea2df05f@igalia.com>
	 <0e5b8c8c-8faf-4167-b4a4-d35215c1d4d9@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ujg8hnyf5x5q6ftiuqef1w6idd89fpd5
X-MBO-RS-ID: 89f9c6d9679a0b5301c

On Thu, 2025-08-14 at 12:45 +0100, Tvrtko Ursulin wrote:
>=20
> On 14/08/2025 11:42, Tvrtko Ursulin wrote:
> >=20
> > On 21/07/2025 08:52, Philipp Stanner wrote:
> > > +Cc Tvrtko, who's currently reworking FIFO and RR.
> > >=20
> > > On Sun, 2025-07-20 at 16:56 -0700, James Flowers wrote:
> > > > Fixes an issue where entities are added to the run queue in
> > > > drm_sched_rq_update_fifo_locked after being killed, causing a
> > > > slab-use-after-free error.
> > > >=20
> > > > Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> > > > ---
> > > > This issue was detected by syzkaller running on a Steam Deck OLED.
> > > > Unfortunately I don't have a reproducer for it. I've
> > >=20
> > > Well, now that's kind of an issue =E2=80=93 if you don't have a repro=
ducer, how
> > > can you know that your patch is correct? How can we?
> > >=20
> > > It would certainly be good to know what the fuzz testing framework
> > > does.
> > >=20
> > > > included the KASAN reports below:
> > >=20
> > >=20
> > > Anyways, KASAN reports look interesting. But those might be many
> > > different issues. Again, would be good to know what the fuzzer has be=
en
> > > testing. Can you maybe split this fuzz test into sub-tests? I suspsec=
t
> > > those might be different faults.
> > >=20
> > >=20
> > > Anyways, taking a first look=E2=80=A6
> > >=20
> > >=20


[SNIP]

> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > If this is a race, then this patch here is broken, too, because you'r=
e
> > > checking the 'stopped' boolean as the callers of that function do, to=
o
> > > =E2=80=93 just later. :O
> > >=20
> > > Could still race, just less likely.
> > >=20
> > > The proper way to fix it would then be to address the issue where the
> > > locking is supposed to happen. Let's look at, for example,
> > > drm_sched_entity_push_job():
> > >=20
> > >=20
> > > void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0(Bla bla bla)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0/* first job wakes up scheduler */
> > > =C2=A0=C2=A0=C2=A0=C2=A0if (first) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_gpu_scheduler *=
sched;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_rq *rq;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add the entity to the r=
un queue */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&entity->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entity->stopped) {=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 <---- Aha!
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=
in_unlock(&entity->lock);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DR=
M_ERROR("Trying to push to a killed entity\n");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq =3D entity->rq;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched =3D rq->sched;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&rq->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_rq_add_entity(rq=
, entity);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drm_sched_policy =3D=
=3D DRM_SCHED_POLICY_FIFO)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dr=
m_sched_rq_update_fifo_locked(entity, rq, submit_ts);=20
> > > <---- bumm!
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&rq->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&entity->lock)=
;
> > >=20
> > > But the locks are still being hold. So that "shouldn't be happening"(=
tm).
> > >=20
> > > Interesting. AFAICS only drm_sched_entity_kill() and drm_sched_fini()
> > > stop entities. The former holds appropriate locks, but drm_sched_fini=
()
> > > doesn't. So that looks like a hot candidate to me. Opinions?
> > >=20
> > > On the other hand, aren't drivers prohibited from calling
> > > drm_sched_entity_push_job() after calling drm_sched_fini()? If the
> > > fuzzer does that, then it's not the scheduler's fault.
> > >=20
> > > Could you test adding spin_lock(&entity->lock) to drm_sched_fini()?
> > >=20
> > > Would be cool if Tvrtko and Christian take a look. Maybe we even have=
 a
> > > fundamental design issue.
> >=20
> > It would be nice to have a reproducer and from this thread I did not=
=20
> > manage to figure out if the syzkaller snipper James posted was it, or=
=20
> > not quite it.
> >=20
> > In either case, I think one race I see relates to the early exit !=20
> > entity->rq check before setting entity->stopped in drm_sched_entity_kil=
l().
> >=20
> > If the entity was not submitted at all yet (at the time of process=20
> > exit / entity kill), entity->stopped will therefore not be set. A=20
> > parallel job submit can then re-add the entity to the tree, as process=
=20
> > exit / file close / entity kill is continuing and is about to kfree the=
=20
> > entity (in the case of amdgpu report there are two entities embedded in=
=20
> > file_priv).
> >=20
> > One way to make this more robust is to make the entity->rq check in
> > drm_sched_entity_kill() stronger. Or actually to remove it altogether.=
=20
> > But I think it also requires checking for entity->stopped in=20
> > drm_sched_entity_select_rq() and propagating the error code all the way=
=20
> > out from drm_sched_job_arm().
> >=20
> > That was entity->stopped is properly serialized and acted upon early=
=20
> > enough to avoid dereferencing a freed entity and avoid creating jobs no=
t=20
> > attached to anything (but only have a warning from push job).
> >=20
> > Disclaimer I haven't tried to experiment with this yet, so I may be
> > missing something. At least writing a reproducer for the race I=20
> > described sounds easy so unless someone shouts I am talking nonsense I=
=20
> > can do that and also sketch out a fix. *If* the theory will hold water=
=20
> > after I write the test case.
>=20
> Nah I was talking nonsense. Forgot entity->rq is assigned on entity init=
=20
> and jobs cannot be created unless it is set.
>=20
> Okay, I have no theories as to what bug syzkaller found.

I just was about to answer.

I agree that the rq check should be fine.

As you can see in the thread, I suspect that this is a race between
drm_sched_entity_push_job() and drm_sched_fini().

See here:
https://lore.kernel.org/dri-devel/20250813085654.102504-2-phasta@kernel.org=
/


I think as long as there's no reproducer there is not much to do for us
here. A long term goal, though, is to enforce the life time rules.
Entities must be torn down before their scheduler. Checking this for
all drivers will be quite some work, though..


P.


>=20
> Regards,
>=20
> Tvrtko
>=20
> >=20
> > >=20
> > > > =C2=A0=C2=A0}
> > > > =C2=A0=C2=A0/**
> > >=20
> >=20
>=20


