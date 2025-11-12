Return-Path: <linux-kernel+bounces-897286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176DC527C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B91818822A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2E337B9D;
	Wed, 12 Nov 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mYYssi56"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8EA219A8E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954289; cv=none; b=YWz7XnfeZriaM/ZIJStcNGGHTDEMs40XV6QlzwmOEU+syrwJiQ2OzbwS7HOvnKkPFHloksx6JQD+0gqnSFvC6lIQaWnCjj6i7tMpqiBhFKLmfmtvU1wwu2BZENU2/KM6ptjcMcAQjOSOv0TWtb1oNl8WD/d1nexYjn0rpSc2LmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954289; c=relaxed/simple;
	bh=qU96Uk29tMCvl+xNqOQ5rqiKaI0GWmBHNuklgI3ecKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/qIMyTBP/kzWroh8a4U/U+5x7f13G3KYCdzKAljpKbVc1Cdy+CcTACctm5rKmFwGstiiiG0pCmLmHrBwxuAJ6h1K0Sn6WSov8ZW+alWZBaEQCLoNDcNX0eketFznw8bCNGG7N5Vvrzwrm86ZEz6vlsZZfzx+t9rduh3QsWgQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mYYssi56; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d646z3CjBz9tkC;
	Wed, 12 Nov 2025 14:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762954283; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qU96Uk29tMCvl+xNqOQ5rqiKaI0GWmBHNuklgI3ecKk=;
	b=mYYssi56jZyd7Bh6anocChcfEw9AjUJY7XGwzKhRLm/GIN2UpHUmYWuuhU5UaW7Z3I0dpU
	ZuVQFFclbZIWD8niUd001bOxQIeBtKb2nEtBIlCspHfMA2fToo1gZfDIlZm7+0qWlhuPeT
	VU8IiM83YNRTq7zA77PmISWnLd0woBBdPPQurztPYYp2HArIhLuRRdRGNdQWtw0tHGT+y5
	28Mze1LNAgoFYfWHW/A6NafGUV2q/oZfghOCWDCQlm5C5qRMfPUnDn6WA5u7hRJVgAu6l9
	d4sNsCi9to4DDRIWDq9QwAoKL4DnD+IUAB60TswZgKKZlb44gewsWCL68lFYtw==
Message-ID: <cd7f6684f1d8bfca606c4a6ba75c130d07e3a7fe.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Document racy behavior of
 drm_sched_entity_push_job()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tursulin@ursulin.net>, phasta@kernel.org, Matthew Brost
	 <matthew.brost@intel.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
	 <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Nov 2025 14:31:19 +0100
In-Reply-To: <babc3eae-42c2-4927-95db-7c529a282d6d@ursulin.net>
References: <20251112073138.93355-2-phasta@kernel.org>
	 <e9c02871-fa80-46c7-8b96-bad3a6a2c5b9@ursulin.net>
	 <38bce31a7cdea31738c161bb06af272d5f68af1a.camel@mailbox.org>
	 <babc3eae-42c2-4927-95db-7c529a282d6d@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 6yztzec7q8snpddwiqn1twg5jkcioe6t
X-MBO-RS-ID: 9e51a9854326efa0a78

On Wed, 2025-11-12 at 13:13 +0000, Tvrtko Ursulin wrote:
>=20
> On 12/11/2025 12:15, Philipp Stanner wrote:
> > On Wed, 2025-11-12 at 09:42 +0000, Tvrtko Ursulin wrote:
> > >=20
> > > On 12/11/2025 07:31, Philipp Stanner wrote:
> > > > drm_sched_entity_push_job() uses the unlocked spsc_queue. It takes =
a
> > > > reference to that queue's tip at the start, and some time later rem=
oves
> > > > that entry from that list, without locking or protection against
> > > > preemption.
> > >=20
> > > I couldn't figure out what you refer to by tip reference at the start=
,
> > > and later removes it. Are you talking about the top level view from
> > > drm_sched_entity_push_job() or where exactly?
> > > > This is by design, since the spsc_queue demands single producer and
> > > > single consumer. It was, however, never documented.
> > > >=20
> > > > Document that you must not call drm_sched_entity_push_job() in para=
llel
> > > > for the same entity.
> > > >=20
> > > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > > > ---
> > > > =C2=A0=C2=A0 drivers/gpu/drm/scheduler/sched_entity.c | 3 +++
> > > > =C2=A0=C2=A0 1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu=
/drm/scheduler/sched_entity.c
> > > > index 5a4697f636f2..b31e8d14aa20 100644
> > > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > @@ -562,6 +562,9 @@ void drm_sched_entity_select_rq(struct drm_sche=
d_entity *entity)
> > > > =C2=A0=C2=A0=C2=A0 * drm_sched_entity_push_job - Submit a job to th=
e entity's job queue
> > > > =C2=A0=C2=A0=C2=A0 * @sched_job: job to submit
> > > > =C2=A0=C2=A0=C2=A0 *
> > > > + * It is illegal to call this function in parallel, at least for j=
obs belonging
> > > > + * to the same entity. Doing so leads to undefined behavior.
> > >=20
> > > One thing that is documented in the very next paragraph is that the
> > > design implies a lock held between arm and push. At least to ensure
> > > seqno order matches the queue order.
> > >=20
> > > I did not get what other breakage you found, but I also previously di=
d
> > > find something other than that. Hm.. if I could only remember what it
> > > was. Probably mine was something involving drm_sched_entity_select_rq=
(),
> > > drm_sched_entity_modify_sched() and (theoretical) multi-threaded
> > > userspace submit on the same entity. Luckily it seems no one does tha=
t.
> > >=20
> > > The issue you found is separate and not theoretically fixed by this
> > > hypothetical common lock held over arm and push?
> >=20
> > Well, if 2 CPUs should ever run in parallel in
> > drm_sched_entity_push_job() the spsc_queue will just explode. Most
> > notably, one CPU could get the job at the tip (the oldest job), then be
> > preempted, and then another CPU takes the same job and pops it.
>=20
> Ah, you are talking about the dequeue/pop side. First paragraph of the=
=20
> commit message can be clarified in that case.
>=20
> Pop is serialised by the worker so I don't think two simultaneous=20
> dequeues on the same scheduler are possible. How did you trigger it?
> > The API contract should be that the user doesn't have to know whether
> > there's a linked list or the magic spsc_queue.Luckily we moved the peek=
/pop helpers to sched_internal.h.
>=20
> Btw I thought you gave up on the scheduler and are working on the simple=
=20
> rust queue for firmware schedulers so how come you are finding subtle
> bugs in this code?

I'm a maintainer still, for a variety of reasons. That we work on
something for FW with a clean locking design doesn't mean we don't care
about existing infrastructure anymore. And I firmly believe in
documentation. People should know the rules from the API documentation,
not from looking into the implementation.

It's kind of a crucial design info that you must only push into
entities sequentially, no?

This doesn't fix a bug, obviously, since it's just a line of docu.
Regardless, pushing into the spsc queue in parallel would explode.
Emphasizing that costs as nothing.



P.

