Return-Path: <linux-kernel+bounces-892577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4FC45619
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D4D734701C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE22F531B;
	Mon, 10 Nov 2025 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rBIAQKf8"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CCD21CC59
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763476; cv=none; b=cxZXMxT8k1uIXIK5157kDVx6oYwKAIocSC2ChCcLtcZBGQO+sY5eYWMzV0/RZPIE9JIzTrSjPj+u7SP6l9d5U7ZcyzISvyNH7nempLZZtmiLjZZ0vW3vB//lg8XJvgRUb0ZoUUaZ61Qp7ym3F1PFV7y0drYZs3uu97ubfPOtx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763476; c=relaxed/simple;
	bh=3WvXtQkRSRUw4Suxveb2NQbjWXh8sybhedSUxOOLo2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JooOOXJdVr7D9KxcoBuzxxHopouulcbK1A/aoB60SF5MJedIICeVNFFo708Kz1GG/cKZzMcTFkHlv6n4EDJoNckYn/WLhaDVOQAZdn7RdZgi9G1JxqefE2bvNCmzJwJIGwlh7C6YPYThfvl5YYE57qIDeRpxhsTcRocoMq6eNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rBIAQKf8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d4jYP12zHz9t00;
	Mon, 10 Nov 2025 09:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762763465; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N39W5ot4azs3SlcJiZaQEzotzbF0rjsii8g3NyeHdx0=;
	b=rBIAQKf8qdPgU3GKLcuaXGCG/nYtN8ug65Kh8k99DqVtBdJwT97q9dPqCvxXnw+MmYcJ5D
	xMgieDhHZJ/Th7/6MIsUOxtaksDsT9tu8Pqu8KtbQVrVizY0XrkjYCAjZ4tkEEmy7R1pQq
	4Itoh+udHiY1Lo7CmeSiqRVoOJDJ7fUzFQxvYxtW0e6kr/bcPm9RGSjSJwN83+LP8kDprH
	s/Cg6L7qfWxKeAAF7d5CeYS1Gp45Zk4eIf0GHtbXSb5VT6g2RJEEVLqDQoaXbOu9u6Tnyg
	ILFFSs7ITTti9Q6KiC72OUqZYPgz4L5I0O0rpih5aOKn44FNlMISHfR03fWovw==
Message-ID: <b8ffe136ca4dcfc94530e1fe7dbac889930f03be.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Don't crash kernel on wrong params
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 09:30:54 +0100
In-Reply-To: <c4a10ad7-22c0-412c-a456-d2dd0f049ac9@ursulin.net>
References: <20251107125508.235449-2-phasta@kernel.org>
	 <c4a10ad7-22c0-412c-a456-d2dd0f049ac9@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: ec2c35470daf59186e2
X-MBO-RS-META: pcwceht67bs4xe1r3qnj3nkyh3kixuhw

On Fri, 2025-11-07 at 14:42 +0000, Tvrtko Ursulin wrote:
>=20
> On 07/11/2025 12:55, Philipp Stanner wrote:
> > drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
> > entity being NULL. While drm_sched_job_arm() crashing or not effectivel=
y
> > arming jobs is certainly a huge issue that needs to be noticed,
> > completely shooting down the kernel reduces the probability of reaching
> > and debugging a system to 0.
> >=20
> > Moreover, the checkpatch script by now strongly discourages all new use=
s
> > of BUG_ON() for this reason.
> >=20
> > Replace the BUG_ON() in drm_sched_job_arm() with a WARN_ON().
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index 1d4f1b822e7b..3bf4ae0ca4bc 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -857,7 +857,7 @@ void drm_sched_job_arm(struct drm_sched_job *job)
> > =C2=A0=C2=A0	struct drm_gpu_scheduler *sched;
> > =C2=A0=C2=A0	struct drm_sched_entity *entity =3D job->entity;
> > =C2=A0=20
> > -	BUG_ON(!entity);
> > +	WARN_ON(!entity);
> > =C2=A0=C2=A0	drm_sched_entity_select_rq(entity);
>=20
> void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
> {
> 	struct dma_fence *fence;
> 	struct drm_gpu_scheduler *sched;
> 	struct drm_sched_rq *rq;
>=20
> 	/* single possible engine and already selected */
> 	if (!entity->sched_list)
>=20
> Still the same end result.
>=20
> I believe best practice is to simply not have BUG_ON's followed by null=
=20
> pointer dereferences since they add no value. Ie. it should just be=20
> removed and not replaced.

Hm, right. I agree. Both jobs and entities are initialized to 0
anyways. Existing users work, and new users would notice a null ptr
crash.

Let's remove it altogether.


P.

