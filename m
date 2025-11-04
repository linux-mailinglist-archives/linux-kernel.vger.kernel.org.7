Return-Path: <linux-kernel+bounces-885053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47EBC31D84
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3A63B4142
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E02561AB;
	Tue,  4 Nov 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IwxMFQXU"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39A269D06;
	Tue,  4 Nov 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270245; cv=none; b=pf9mvG5TaDwrz4msw9UmCqzoLPDYWE3iAImgh7L2qo7l/Xf55lKoA+THLI2JM0hnLya7F7BYIHxnxkvAmrDW96w+6Jwr5vXnZFvMIuvsXcWvdzqWsMwTgooFYvJvv62MOLCNlMnyQF3nze5MuMcEQLeZNTj19bLIWqEIDM1kcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270245; c=relaxed/simple;
	bh=7LgTVs0vVnyj5RQK2XpeZ4a55ijlPbDWWeN0aI5fO6w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aS4tvrFKhkYw+U6wPZxMARI/FfcE3zp3T6KfK9TbEOLi9zXFTlSUWfXF6FyrsRbM3MGnNni4QGU2oVzPYlk00/tODR+stsPD9E8oRWah57BPrSykPYztdEXjRI2M3JfRT4Mr6HbdmSEldIq1jJ6RoTRSBloYM0iURGT+2/jVnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IwxMFQXU; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d1C8H2BNPz9v76;
	Tue,  4 Nov 2025 16:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762270239; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXw6kCFBo5eidUV/wPgMY2T8iMEfPQj0hALJrToc0oY=;
	b=IwxMFQXUcI3TdafSuVoVPXSCtxouMMSjDnqn11sgXym8XEDiCOrOK2HYxs3xK6TIFEliG1
	+McIE9KGm4i0lmPhaP+r5zGI5rFZR8pF36F+rQBxmuleWOq6m38Io9WpUsxAsjaTOtq7Zo
	/iZw2c4a/qDmf6Oobue+Tt3Izlq84WpXqHLCN7FE9JFuM1tqEZowZ6f9kuBrkQ5GZ4bdK5
	FLJMW+hhEXRpCYU8cARrrGyWKOYX7oq4IJMJVNwBKfnGJBEGlQ9936FYheUYxlgCJFxEO9
	KMDqjzSnYCSepWseYXsC+GyJ3jCLyKuHlIrRXA+n3B4OPvmoKI4JrpJVw18kog==
Message-ID: <85e573fa81913b4afe274f27142f526062f184f4.camel@mailbox.org>
Subject: Re: [PATCH v3] drm/sched: Fix deadlock in
 drm_sched_entity_kill_jobs_cb
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, phasta@kernel.org, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Matthew
 Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Luben Tuikov <luben.tuikov@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org
Date: Tue, 04 Nov 2025 16:30:24 +0100
In-Reply-To: <c1da66b4-3b71-4d83-8e8e-56151030b691@damsy.net>
References: <20251104095358.15092-1-pierre-eric.pelloux-prayer@amd.com>
	 <628cdf3a0c5b783c09fe2a40aca4a4a48c614e66.camel@mailbox.org>
	 <c1da66b4-3b71-4d83-8e8e-56151030b691@damsy.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: b7zmj93dted6cq4japbk7tzm6j7j7tmc
X-MBO-RS-ID: ce66c1907a5c42a4b78

On Tue, 2025-11-04 at 16:24 +0100, Pierre-Eric Pelloux-Prayer wrote:
>=20
>=20
> Le 04/11/2025 =C3=A0 13:43, Philipp Stanner a =C3=A9crit=C2=A0:
>=20
> >=20
> > Some things I have unfortunately overlooked below.
> >=20
> > >=20
> > > Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fi=
ni")
> >=20
> > We should +Cc stable. It's a deadlock after all.
>=20
> OK.
>=20
> >=20
> > > Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/13908
> > > Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer=
@amd.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 34 +++++++++++=
++-----------
> > > =C2=A0=C2=A01 file changed, 19 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/d=
rm/scheduler/sched_entity.c
> > > index c8e949f4a568..fe174a4857be 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > @@ -173,26 +173,15 @@ int drm_sched_entity_error(struct drm_sched_ent=
ity *entity)
> > > =C2=A0=C2=A0}
> > > =C2=A0=C2=A0EXPORT_SYMBOL(drm_sched_entity_error);
> > > =C2=A0=20
> > > +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
> > > +					=C2=A0 struct dma_fence_cb *cb);
> >=20
> > It's far better to move the function up instead. Can you do that?
>=20
> Since drm_sched_entity_kill_jobs_cb uses drm_sched_entity_kill_jobs and v=
ice=20
> versa, I'll have to forward declare one of the 2 functions anyway.

Ah, right.
OK then.

I can push this and +Cc stable in the commit message if you want.


P.

