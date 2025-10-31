Return-Path: <linux-kernel+bounces-879913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D7C24636
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD99B1A64ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4E33B94A;
	Fri, 31 Oct 2025 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k88e6phy"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04327F16A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905461; cv=none; b=TE6U9yP7mhJNQXqyQnBUxtxHWhsX8K1ui6L4UApYmLLoBbOcLfdFsoPcBWw3RrrB315Fx6BErus/b8be0wngl1nDYlqGuUCgMu1Ke+XYGHVx3z9Ko2HYu/HocUbQnyP3RJBQ4mLP2G+0VXQ1Ce5pYU0MzSeuShsScro6nF3fk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905461; c=relaxed/simple;
	bh=zzIA31z1vZE/W2+9f9ZIl6kxQ8d4TebInqnMy4NR1i0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjHEn6ooGJR+NJlbjaZAljcmrbvQhBC29fskSRmaigKGBQ35GMRD+mSQ9Lhws0C0yvpbc1bZslfeA8CHTjrO3yqBw5PtSDu4xtDnoHuerEPy84hZBIOdw4Z2zeMMSTI3iCWhVq+2l5uCa97G4L0buULjRwRN8+aWrKmQWRBIJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=k88e6phy; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cycDy4PDqz9srd;
	Fri, 31 Oct 2025 11:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761905442; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX/fzg/n5SwFz0Vlx5NQrJ0TysuKtNx7wJbpBrBb7Gc=;
	b=k88e6phyFxYs99l4k8KsioLz4O6ef0gXmbm7ITVuJtXtCZFyS6hh5TuF2Wy4FSI47MQ7Qs
	BojqW1hz38sMglZAjHmtgA5sjHCPmPZpIQACSUq3b2X1E9qCbpGn8of51w3XJ+6K71rikJ
	wTZIflBggUbfO8UJAZsvA0eVsj4cUZQ+8f4ErjEwIxtlBzS89ZNupA3/pSaw9yAPDitzkC
	Xi9F/4ib5T4bDtLSlh+df9wQWuHntf0FxccAqK7meDkTwJUhNw8zObwVifxfhR2ZWTBiOW
	UYbTrs6EThAQDGrh4oJr6Oy7eH6cMqKqaH1SDLpw9Parot2qehFDrs8imKTr1g==
Message-ID: <a243e68704eda067bd18458aa41452d1da220d68.camel@mailbox.org>
Subject: Re: [PATCH 1/2] drm/sched: Fix comment in drm_sched_run_job_work()
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
Date: Fri, 31 Oct 2025 11:10:38 +0100
In-Reply-To: <aQJG1/izCBbNnX0a@lstrano-desk.jf.intel.com>
References: <20251028134602.94125-2-phasta@kernel.org>
	 <20251028134602.94125-3-phasta@kernel.org>
	 <aQJG1/izCBbNnX0a@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: d0c2776e058c22ecbae
X-MBO-RS-META: yjw8d48kozfrob7ej5igbn3qmsdok7rq

On Wed, 2025-10-29 at 09:54 -0700, Matthew Brost wrote:
> On Tue, Oct 28, 2025 at 02:46:01PM +0100, Philipp Stanner wrote:
> > drm_sched_run_job_work() contains a comment which explains that an
> > entity being NULL means that there is no more work to do. It can,
> > however, also mean that there is work, but the scheduler doesn't have
> > enough credits to process the jobs right now.
> >=20
> > Provide this detail in the comment.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Applied to drm-misc-next.
Dropped the other patch.

Thx
P.

>=20
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 9 +++++++--
> > =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index c39f0245e3a9..492e8af639db 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1237,8 +1237,13 @@ static void drm_sched_run_job_work(struct work_s=
truct *w)
> > =C2=A0
> > =C2=A0	/* Find entity with a ready job */
> > =C2=A0	entity =3D drm_sched_select_entity(sched);
> > -	if (!entity)
> > -		return;	/* No more work */
> > +	if (!entity) {
> > +		/*
> > +		 * Either no more work to do, or the next ready job needs more
> > +		 * credits than the scheduler has currently available.
> > +		 */
> > +		return;
> > +	}
> > =C2=A0
> > =C2=A0	sched_job =3D drm_sched_entity_pop_job(entity);
> > =C2=A0	if (!sched_job) {
> > --=20
> > 2.49.0
> >=20


