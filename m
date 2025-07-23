Return-Path: <linux-kernel+bounces-742709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07471B0F598
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9BE5861A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA392EB5A8;
	Wed, 23 Jul 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CVyTPFHM"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88F2F5326
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281679; cv=none; b=bpE1/Y3D5HTyN9QRFmauhvAQm+pGUXoJaXU7x6A9v33EwDgw7yp6AF+RqdMWa3JmrpITkkD9PWBtXYW0iZnUf2gJyV1ABDZDI4eGXxE9tVFwJazGHepLYgCUBRFNil7sRFB2aBVBkgUhUQeuB/tYRS7pzKgo6hH06Gb3r+SWGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281679; c=relaxed/simple;
	bh=wteYmcwWCA7BnQWclTsLrO3anUFeqw8fAnAGGJwj0jY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akJnaYD/wW/vRUMuuL0isDIgXObtYUDYfcqBp2ienVD7eQessl/GY2IArYKfS8POBF6PLam3cTM7Q6Wn1CsSeJzq2D8x5zDcQBdvinutQ2V2Lr/CgDoJrzk7Y5J8adgPezBGnku02jhd66Bf6hAuOiMvWXYZTHl5wf+5Qierjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CVyTPFHM; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bnGz75YDmz9snp;
	Wed, 23 Jul 2025 16:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753281667; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ke85bfOu9U/z4qWHLgSi9M97NOdAmDef0WSr+i5D30M=;
	b=CVyTPFHMw9F9OMHBskxiQxmgaymMt1BF6AVnDhl45qgNfNOKdPvwxFJiM5VQSTIvkDDX2T
	anguJMI127QV62LM/NpwAXoLlguIDDWwDx8FXg2r3SPsHYTqk6IuPqVjlYFPVN9fDCeFEm
	uu7Uqvwf1g3ebQCtE2xC9lLGPkP5fqN1IksYEGUSbli2cyu8B/HHkcl3IgNbnmr4Ao/ylF
	pRY+8p444o+qKgdN/SPwpgE/vgsp2j6+Btw1KohWJmoNjNM0j0oVtpPyJho+GBVjQxoP50
	xzhCzqTRkZhbZqKnRFxdocXpJZG0SzONZbV3Rpyt7tMh2CqhXeGrXs3hos6RIg==
Message-ID: <5ce98154b3f16c09b2d9b48493e88a4c6916281e.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Prevent stopped entities from being added to
 the run queue.
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: James <bold.zone2373@fastmail.com>, phasta@kernel.org, 
 matthew.brost@intel.com, dakr@kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 maarten.lankhorst@linux.intel.com,  mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,  Shuah Khan
 <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Date: Wed, 23 Jul 2025 16:41:00 +0200
In-Reply-To: <a6b4f8a2-7be1-4bc7-9700-fe7e52e21ea4@app.fastmail.com>
References: <20250720235748.2798-1-bold.zone2373@fastmail.com>
	 <66a14b005fa3dc874f4f3261b93901af1292bde9.camel@mailbox.org>
	 <e7c0f63678a93261182b69aa526217821552a150.camel@mailbox.org>
	 <a6b4f8a2-7be1-4bc7-9700-fe7e52e21ea4@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: u1f6subx8934y76me46mas51hpeg9cpi
X-MBO-RS-ID: 52395c03797e5330bee

Hello,

On Tue, 2025-07-22 at 13:05 -0700, James wrote:
> On Mon, Jul 21, 2025, at 1:16 AM, Philipp Stanner wrote:
> > On Mon, 2025-07-21 at 09:52 +0200, Philipp Stanner wrote:
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
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: slab-use-after-free in rb_next+0xda/0x160 lib/rbtree.c:=
505
> > > > Read of size 8 at addr ffff8881805085e0 by task kworker/u32:12/192

[SNIP]

> > > >=20
> > > > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 6 ++++--
> > > > =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/d=
rm/scheduler/sched_main.c
> > > > index bfea608a7106..997a2cc1a635 100644
> > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > @@ -172,8 +172,10 @@ void drm_sched_rq_update_fifo_locked(struct dr=
m_sched_entity *entity,
> > > > =C2=A0
> > > > =C2=A0	entity->oldest_job_waiting =3D ts;
> > > > =C2=A0
> > > > -	rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_compare_before);
> > > > +	if (!entity->stopped) {
> > > > +		rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_compare_before)=
;
> > > > +	}
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
> > > 	(Bla bla bla)
> > >=20
> > > =C2=A0	=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6
> > >=20
> > > 	/* first job wakes up scheduler */
> > > 	if (first) {
> > > 		struct drm_gpu_scheduler *sched;
> > > 		struct drm_sched_rq *rq;
> > >=20
> > > 		/* Add the entity to the run queue */
> > > 		spin_lock(&entity->lock);
> > > 		if (entity->stopped) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <---- Aha!
> > > 			spin_unlock(&entity->lock);
> > >=20
> > > 			DRM_ERROR("Trying to push to a killed entity\n");
> > > 			return;
> > > 		}
> > >=20
> > > 		rq =3D entity->rq;
> > > 		sched =3D rq->sched;
> > >=20
> > > 		spin_lock(&rq->lock);
> > > 		drm_sched_rq_add_entity(rq, entity);
> > >=20
> > > 		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> > > 			drm_sched_rq_update_fifo_locked(entity, rq, submit_ts); <---- bumm=
!
> > >=20
> > > 		spin_unlock(&rq->lock);
> > > 		spin_unlock(&entity->lock);
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
> >=20
> > Ah no, forget about that.
> >=20
> > In drm_sched_fini(), you'd have to take the locks in reverse order as
> > in drm_sched_entity_push/pop_job(), thereby replacing race with
> > deadlock.
> >=20
> > I suspect that this is an issue in amdgpu. But let's wait for
> > Christian.
> >=20
> >=20
> > P.
> >=20
> >=20
> > >=20
> > > Would be cool if Tvrtko and Christian take a look. Maybe we even have=
 a
> > > fundamental design issue.
> > >=20
> > >=20
> > > Regards
> > > P.
> > >=20
> > >=20
> > > > =C2=A0}
> > > > =C2=A0
> > > > =C2=A0/**
> > >=20
>=20
> Thanks for taking a look at this. I did try to get a reproducer using syz=
kaller, without success. I can attempt it myself but I expect it will take =
me some time, if I'm able to at all with this bug. I did run some of the ig=
t-gpu-tools tests (amdgpu and drm ones), and there was no difference after =
the changes on my system. After this change I wasn't running into the UAF e=
rrors after 100k+ executions but I see what you mean, Philipp - perhaps it'=
s missing the root issue.=20
>=20
> FYI, as an experiment I forced the use of RR with "drm_sched_policy =3D D=
RM_SCHED_POLICY_RR", and I'm not seeing any slab-use-after-frees, so maybe =
the problem is with the FIFO implementation?=20

I can't imagine that. The issue your encountering is most likely a race
caused by the driver tearing down entities after the scheduler, so
different scheduler runtime behavior might hide ("fix") the race
(that's the nature of races, actually: sometimes they're there,
sometimes not). RR running with different time patterns than FIFO
doesn't mean that FIFO has a bug.

>=20
> For now, the closest thing to a reproducer I can provide is my syzkaller =
config, in case anyone else is able to try this with a Steam Deck OLED. I'v=
e included this below along with an example program run by syzkaller (in ge=
nerated C code and a Syz language version).

Thanks for investigating this.

My recommendation for now is that you write a reproducer program,
possibly inspired by the syzkaller code you showed.

Reproduce it cleanly and (optionally) try a fix. Then another mail
would be good, especially with the amdgpu maintainers on Cc since I
suspect that this is a driver issue.

Don't get me wrong, a UAF definitely needs to be fixed; but since it's
not occurring outside of fuzzing currently and as we can't reproduce
it, we can't really do much about it until that's the case.

I will in the mean time provide a patch pimping up the memory life time
documentation for scheduler objects.

Thx
P.

