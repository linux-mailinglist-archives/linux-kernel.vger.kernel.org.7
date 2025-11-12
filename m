Return-Path: <linux-kernel+bounces-897190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4742C523C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8422F4EF40C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30CB328258;
	Wed, 12 Nov 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MNnRx03V"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF81327787
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949766; cv=none; b=XZfgIwZM1Orc3M3VlrvN9QF0Okhr4ia4Yf5E0tgBJakWTh/x4tFvsMvjVmFzsrfO1V91tzx5WdYftkG5PhXhmC4TwbPevILzfzh3x0T577mSSbgt8CVJms1+qkOHCjS0FxiUWJmpDIdA5mcoZIePNgB+ZZY2T+iUNi4laODrFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949766; c=relaxed/simple;
	bh=O9LUNJo5r7PS83iZrxvhcBeuzxwUTMP3M8c3Wg/G9iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBHHVVaQtbu94FZXMcMd3pNIXhY13WJMOWzdAY7YssJdT7H9zTwbYyxjpAqcGBv9B7uYN1wsxpDLhNzFAnTdwjF3KPSwTlZr0n1rEaTYq3viYuVxJVo6Gj3agK553/81taZtk/5pKv0JV+ydMbI62V/FFFysGO4mgMF2NZLFxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MNnRx03V; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d62S04mxCz9v6W;
	Wed, 12 Nov 2025 13:16:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762949760; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9LUNJo5r7PS83iZrxvhcBeuzxwUTMP3M8c3Wg/G9iw=;
	b=MNnRx03VlYCovIhai70dGV7KLPVA9AhAgvwq1hy3gL/fwG5xyUz9IlOEfIU8vqXgaY/+Ss
	3aCLfnr33y4NVtVxIGogHZYydg0M/t8FFV8OjDKu6OZ7UV9cTJtc26wUgOLeICOa/pNwmj
	b7cZRyNhOBqBmFDK8UPY5xQCXcYlxKJ0J574iELO1FSmoFUvqZ68tNIwhjgMnoTgKUuv9n
	pQlShYr0/04I+CRuhwUSWeboNpZq3/UruQj1xOyVz4FGj3FA66YT3useEqgBBZXF4G33g5
	Z11yXE7XuH2wKFPmngFScyKHmXHJ6idn0UK+tCayyNQvDJhFA4Y4zwiynNuXeg==
Message-ID: <38bce31a7cdea31738c161bb06af272d5f68af1a.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Document racy behavior of
 drm_sched_entity_push_job()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,  Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Nov 2025 13:15:57 +0100
In-Reply-To: <e9c02871-fa80-46c7-8b96-bad3a6a2c5b9@ursulin.net>
References: <20251112073138.93355-2-phasta@kernel.org>
	 <e9c02871-fa80-46c7-8b96-bad3a6a2c5b9@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: tm8qemr418gbfr3h4eghbo5toqbd37kj
X-MBO-RS-ID: 49125ab28eaa9f3a0b8

On Wed, 2025-11-12 at 09:42 +0000, Tvrtko Ursulin wrote:
>=20
> On 12/11/2025 07:31, Philipp Stanner wrote:
> > drm_sched_entity_push_job() uses the unlocked spsc_queue. It takes a
> > reference to that queue's tip at the start, and some time later removes
> > that entry from that list, without locking or protection against
> > preemption.
>=20
> I couldn't figure out what you refer to by tip reference at the start,=
=20
> and later removes it. Are you talking about the top level view from=20
> drm_sched_entity_push_job() or where exactly?
> > This is by design, since the spsc_queue demands single producer and
> > single consumer. It was, however, never documented.
> >=20
> > Document that you must not call drm_sched_entity_push_job() in parallel
> > for the same entity.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_entity.c | 3 +++
> > =C2=A0 1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm=
/scheduler/sched_entity.c
> > index 5a4697f636f2..b31e8d14aa20 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -562,6 +562,9 @@ void drm_sched_entity_select_rq(struct drm_sched_en=
tity *entity)
> > =C2=A0=C2=A0 * drm_sched_entity_push_job - Submit a job to the entity's=
 job queue
> > =C2=A0=C2=A0 * @sched_job: job to submit
> > =C2=A0=C2=A0 *
> > + * It is illegal to call this function in parallel, at least for jobs =
belonging
> > + * to the same entity. Doing so leads to undefined behavior.
>=20
> One thing that is documented in the very next paragraph is that the=20
> design implies a lock held between arm and push. At least to ensure=20
> seqno order matches the queue order.
>=20
> I did not get what other breakage you found, but I also previously did=
=20
> find something other than that. Hm.. if I could only remember what it
> was. Probably mine was something involving drm_sched_entity_select_rq(),=
=20
> drm_sched_entity_modify_sched() and (theoretical) multi-threaded=20
> userspace submit on the same entity. Luckily it seems no one does that.
>=20
> The issue you found is separate and not theoretically fixed by this=20
> hypothetical common lock held over arm and push?

Well, if 2 CPUs should ever run in parallel in
drm_sched_entity_push_job() the spsc_queue will just explode. Most
notably, one CPU could get the job at the tip (the oldest job), then be
preempted, and then another CPU takes the same job and pops it.

The API contract should be that the user doesn't have to know whether
there's a linked list or the magic spsc_queue.

The entire entity submission pattern is basically designed around
"single producer [per entity]", and that's not very well documented.

I don't think the common lock comment fully addresses that, because
it's merely about the sequence numbers. I think the common lock should
likely prevent any issues, but I feel more comfortable if the user gets
informed explicitly about the potential racyness of this function.

Maybe we can combine the two paragraphs.

P.

