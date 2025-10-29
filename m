Return-Path: <linux-kernel+bounces-875333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB6C18B23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE67D4E6573
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450F2EC09E;
	Wed, 29 Oct 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hf/93c7P"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689921FF55
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723059; cv=none; b=YVZopyXhEphMrqL/Ii4bcOmKF7EGJsWJrrAJUH4TuuPRMTicjV05ZuKNw8boTvkqfgSXelieCGJToMNpDjXVC+uACrTvlOd+AfPsy9jmWr18RkQFtzsYNvZvz7/5zsdHaXuIjHPGI6VgRh3GxiEnMQuQ9R/sBbRzsvJ0hTRgmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723059; c=relaxed/simple;
	bh=QCyxb0xcrl3PvihmGpfzx6cNsXm9t2fYoe560FSwjS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPZLuTWYkhd4ullCohdEQVliWiUmUm11k9HXVlSSHV1S9+zaoLk5n3mghpiNDxjGebMj4xtICkCUr3kwNl27F0LwR8plWmkydVPtvXeOUAPJJa5RcxpSzL0IKreXNO7sFTlMzKG69uxy+CfFzm39o/YvbPVHqtxO+SroNxjZQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hf/93c7P; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cxJnT6ZF8z9tSV;
	Wed, 29 Oct 2025 08:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761723053; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dc/nHQJ01/k3r4k37WvJJ6sn+d52mPfesqmqjpSbQFU=;
	b=hf/93c7PuLW8msZp53XX2GgIOcde7vWqwZCDjevZDuox54GHsQcAGLizWY2LJy//9wp11H
	5F/3eNrBC+E4lJ+nzFrmv+1miVPGMXmCAmAcw+u89yzFDhHopvrM9UqpaRWtdDJ6+Jd5Fl
	Sm2WZRSmFwboyRaCScCGey7n1klbdre2BSqyeJrfVaj3ML7HpYsbYmPUIYY6W6wFDZbqQl
	kHGqKsoozkEys2IR7QWMtuJl/UBlOYqaidFtMe01YL1BULrqVfreed6HRe7jfFuPWCt/HS
	buRHmRR58Xzt5Wqeq5y88yz7kj6k1RhA86LWH4SQGxUFSx9q+SB5vBR2ZDoaxw==
Message-ID: <2e08b320a9d81faee6d1ec2a3fe8a1df6773c8f6.camel@mailbox.org>
Subject: Re: [PATCH 2/2] drm/sched: Add FIXME detailing potential hang
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,  tursulin@ursulin.net,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org
Date: Wed, 29 Oct 2025 08:30:48 +0100
In-Reply-To: <aQEc5eUR8bq+XNG1@lstrano-desk.jf.intel.com>
References: <20251028134602.94125-2-phasta@kernel.org>
	 <20251028134602.94125-4-phasta@kernel.org>
	 <aQEc5eUR8bq+XNG1@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 231303fb3b5f76a16db
X-MBO-RS-META: qtg7zkqcp5wj9caew7eose6iunjn1qdi

On Tue, 2025-10-28 at 12:43 -0700, Matthew Brost wrote:
> On Tue, Oct 28, 2025 at 02:46:02PM +0100, Philipp Stanner wrote:
> > If a job from a ready entity needs more credits than are currently
> > available, drm_sched_run_job_work() (a work item) simply returns and
> > doesn't reschedule itself. The scheduler is only woken up again when th=
e
> > next job gets pushed with drm_sched_entity_push_job().
> >=20
> > If someone submits a job that needs too many credits and doesn't submit
> > more jobs afterwards, this would lead to the scheduler never pulling th=
e
> > too-expensive job, effectively hanging forever.
> >=20
> > Document this problem as a FIXME.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++++++
> > =C2=A01 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index 492e8af639db..eaf8d17b2a66 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1237,6 +1237,16 @@ static void drm_sched_run_job_work(struct work_s=
truct *w)
> > =C2=A0
> > =C2=A0	/* Find entity with a ready job */
> > =C2=A0	entity =3D drm_sched_select_entity(sched);
> > +	/*
> > +	 * FIXME:
> > +	 * The entity can be NULL when the scheduler currently has no capacit=
y
> > +	 * (credits) for more jobs. If that happens, the work item terminates
> > +	 * itself here, without rescheduling itself.
> > +	 *
> > +	 * It only gets started again in drm_sched_entity_push_job(). IOW, th=
e
> > +	 * scheduler might hang forever if a job that needs too many credits
> > +	 * gets submitted to an entity and no other, subsequent jobs are.
> > +	 */
>=20
> drm_sched_job_done frees the credits, which triggers
> drm_sched_free_job_work, and that in turn triggers
> drm_sched_run_job_work.

Sounds correct to me.

We can still merge #1, though, for a bit more clearness.

P.

