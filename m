Return-Path: <linux-kernel+bounces-847990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64591BCC38D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45C03A55E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884B25EF90;
	Fri, 10 Oct 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I65+FkmK"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF691DE3B7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086331; cv=none; b=ANWW7s10EwaKtSnjyOuRDdzD7Unkra/lSISkYjQG9YdEafMJd05A82X11bZpWNSV59heZYHhARKgBTNVPtOqieelFeRsyuCPAzVNpZzCw6QHeiWI6lZoNAJocBiqUQUYKt+Q0LWycS4dJfp2HFAHFT6Svv7ZYCPU3eOustYuonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086331; c=relaxed/simple;
	bh=DDx2jQ44UcYgADHR50SsvCLFlSwXmWfRDl8EjZfp3dA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P94XZ1jVyFRIL8dRpQ1wpGtqmuRPW+5CQ17XeNUQ8RJWEdWKILghFVZHzJRmx813lUXBjA5hWVs3YhckY+AN6djKn5w9C/MM3WCMJnKrAiftwGfG5GQPxQtfyWAFMv8aNsqjB/5YLMhAvoTF+qZvbPfdgLbCqX20NeZcrbXNYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=I65+FkmK; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cjgTq279Mz9tyS;
	Fri, 10 Oct 2025 10:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760086319; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDx2jQ44UcYgADHR50SsvCLFlSwXmWfRDl8EjZfp3dA=;
	b=I65+FkmKVoKEyK6Q/AoM4dmjeGLxzkiAzRQJi3NNHyTl2sTKOOSwHT2NWwYg0zNu5v0rC0
	GPD/MnJf2JgivWN8jHtc/UNa5pGWsdTPjPJZvZ94YrMGap0OqNXINsG/YzWh9Z668x0apN
	5kZ+AV/OenJoI6bJo5VPa8X/DC/VlxXlK+De9c0oyAmS1uZw9YCURV2r/rDuH/yuC6F2jx
	Uk3Nkd2OJlJInAD8h8sgHmkN+sJWURU1w0dTV97JxNHvM4e2+rP54awWc1yUrVjGHrt176
	TJx7qcnPUlswFlDQIMOR+GKzxVEy5vf5gidJc9jvF2pN7U46OVtzniCMcWu0RA==
Message-ID: <f609ca476429b0737238cd9f6389e85472ac7529.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Mandate usage of drm_sched_job_cleanup()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <ckoenig.leichtzumerken@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 10:51:55 +0200
In-Reply-To: <aNq9/6Ks2N3A1hDu@lstrano-desk.jf.intel.com>
References: <20250926123630.200920-2-phasta@kernel.org>
	 <aNq9/6Ks2N3A1hDu@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: cijir8hi1qag4711ie6wwtmkh7me6w3i
X-MBO-RS-ID: 8cd8832534db39e8cba

On Mon, 2025-09-29 at 10:12 -0700, Matthew Brost wrote:
> On Fri, Sep 26, 2025 at 02:36:31PM +0200, Philipp Stanner wrote:
> > drm_sched_job_cleanup()'s documentation so far uses relatively soft
> > language, only "recommending" usage of the function. To avoid memory
> > leaks and, potentiall, other bugs, however, the function has to be used=
.
> >=20
> > Demand usage of the function explicitly.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index 46119aacb809..0a9df9e61963 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1030,7 +1030,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
> > =C2=A0 *
> > =C2=A0 * Cleans up the resources allocated with drm_sched_job_init().
> > =C2=A0 *
> > - * Drivers should call this from their error unwind code if @job is ab=
orted
> > + * Drivers need to call this from their error unwind code if @job is a=
borted
> > =C2=A0 * before drm_sched_job_arm() is called.
> > =C2=A0 *
> > =C2=A0 * drm_sched_job_arm() is a point of no return since it initializ=
es the fences
> > @@ -1038,7 +1038,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
> > =C2=A0 * submit it with drm_sched_entity_push_job() and cannot simply a=
bort it by
> > =C2=A0 * calling drm_sched_job_cleanup().
> > =C2=A0 *
> > - * This function should be called in the &drm_sched_backend_ops.free_j=
ob callback.
> > + * This function must be called in the &drm_sched_backend_ops.free_job=
 callback.
>=20
> I believe both the existing documentation and the new version are
> incorrect.

Feel free to submit a proposal.

What's important for this patch is: do you agree that cleanup_job()
must be called in free_job()?

>=20
> Also, the free_job callback is probably misnamed. This ties into a
> statement made during your XDC presentation today that confused me. The
> DRM scheduler only holds a reference to the driver-allocated job from
> the time run_job is called (i.e., once drm_sched_job_arm is invoked)
> until the job=E2=80=99s fence signals. It does not own the responsibility=
 of
> freeing the job =E2=80=94 the driver should manage the job=E2=80=99s refe=
rence count and
> free it as appropriate.
>=20
> For most drivers, the only reference is the creation reference, which is
> transferred to the DRM scheduler after drm_sched_job_arm and released in
> free_job.
>=20
> So, I think what really needs to be documented is this reference
> counting transfer. drm_sched_job_cleanup is actually associated with
> drm_sched_job_init =E2=80=94 meaning drm_sched_job_cleanup must be called=
 if
> drm_sched_job_init was called. This is typically handled by the driver
> through reference counting of the job.
>=20
> Finally, I think free_job should probably be renamed to something like
> sched_job_put to better reflect its purpose.

That's maybe how free_job() was intended once, but it's not how it's
implemented in some drivers currently. The implementation is fractured.
Some drivers maybe have refcounted jobs, some others don't.

That's exactly where our problems come from. free_job() and the
scheduler de facto manage job lifetime.

Moreover, I'm wondering what good it would even be to have everything
refcounted and then have the scheduler tell the driver to drop its
refcount.. that sounds fundamentally broken to me. It's not the purpose
of refcounting.
The idea is that everyone holds his reference until he doesn't need it
anymore, and then drops it.


I think we should leave free_job() as is, agree that having it in the
first place was a fundamental design mistake, and go on and do better
with future job-managing infrastructure.


P.

>=20
> We can discuss this more in person on Wednesday at the workshop or grab
> in the hallway.
>=20
> Matt
>=20
> > =C2=A0 */
> > =C2=A0void drm_sched_job_cleanup(struct drm_sched_job *job)
> > =C2=A0{
> > --=20
> > 2.49.0
> >=20


