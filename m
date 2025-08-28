Return-Path: <linux-kernel+bounces-789530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F41AB396F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855FE1C242A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995122DE6F3;
	Thu, 28 Aug 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pGvhnLcM"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532931E285A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369745; cv=none; b=eE0GWpBLLkbAfQf0RBsq0XSPX8HbVxIz1OfpUSt+mZzYZWCIvGwcJfJDqMGzdHxFQ8ATG3SOaU1ISGy5BLIaeY+AynYWHH7xqUKPgZbxTj+RLqs+Ui89M76HVG/tBFNgcHelsil7xSntXuWKgaFjsBRrjwpUXwXaXyYAHvO6GHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369745; c=relaxed/simple;
	bh=0NTg+qwqHhGGJy7CFFSFLCIsbcG18npQ4bBDIzsClwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WF+XlgZ5xM9eTjF69cGREpjCbpJZZdtzjc2UQNUjZ7MFrJBzIi9EA7TAOmoa/ouf0oH/r2q+bC1LktvKRGZTBzOTmnhu4vD9QiWOb/zOfRxXVhwluaAXToetVtNiIl1KPJ/mnmWsiB1EpcqhzpVo65ERIAZu3Tshxf1WY/wymiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pGvhnLcM; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cCF162CCqz9tRV;
	Thu, 28 Aug 2025 10:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756369738; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFw4tqBP0jjDKzRQjS/NUlldQwm7m+edN6Jc0V91AOY=;
	b=pGvhnLcMdJJOvz7uVPoVJL5NlxV1ATHCFoMQlF342Y3tXZsTZnHg5aBqHUDAkki+E65ZOB
	SL1Xrm6zDAb/6NuCfxXlA8tzfwzUJTEwVVO84frD2W2CCGYyBusZjSS/dZPCH7ObKgNLmi
	Ey3UHF59uc1sivbCywSw1C42GivpDlPEKs63C/Bx3RXjTu06bTIYYRfniboZfO7XAaBMJj
	ENlH3r+yp+/LirNaeTTg5YNAZf0n48o7CwWPMKSbvlmMfzd8V9ovIp2APf5nuUGdcCBaAf
	8DHddeuPMy4HHNNgYRd7XpcaJi8IqDbIDu7tH/SXYBfBz6YabBBWN4y+/+A+Cw==
Message-ID: <c41b717da1345bafc526ba7524b0fa24661243e2.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Document race condition in
 drm_sched_fini()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, James
 Flowers <bold.zone2373@fastmail.com>
Date: Thu, 28 Aug 2025 10:28:53 +0200
In-Reply-To: <DC1BGCY1JPKJ.7BHDGBYZDYMZ@kernel.org>
References: <20250813085654.102504-2-phasta@kernel.org>
	 <DC1BGCY1JPKJ.7BHDGBYZDYMZ@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 93fb8p3pn7pc33koyyzxqjju885p743o
X-MBO-RS-ID: f51ef53e48fd1a49415

On Wed, 2025-08-13 at 14:58 +0200, Danilo Krummrich wrote:
> On Wed Aug 13, 2025 at 10:56 AM CEST, Philipp Stanner wrote:
> > In drm_sched_fini() all entities are marked as stopped - without taking
> > the appropriate lock, because that would deadlock. That means that
> > drm_sched_fini() and drm_sched_entity_push_job() can race against each
> > other.
> >=20
> > This should most likely be fixed by establishing the rule that all
> > entities associated with a scheduler must be torn down first. Then,
> > however, the locking should be removed from drm_sched_fini() alltogethe=
r
> > with an appropriate comment.
> >=20
> > Reported-by: James Flowers <bold.zone2373@fastmail.com>
> > Link: https://lore.kernel.org/dri-devel/20250720235748.2798-1-bold.zone=
2373@fastmail.com/
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>

Applied to drm-misc-next

> > ---
> > Changes in v2:
> > =C2=A0 - Fix typo.
> > ---
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 16 ++++++++++++++++
> > =C2=A01 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index 5a550fd76bf0..46119aacb809 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1424,6 +1424,22 @@ void drm_sched_fini(struct drm_gpu_scheduler *sc=
hed)
> > =C2=A0			 * Prevents reinsertion and marks job_queue as idle,
> > =C2=A0			 * it will be removed from the rq in drm_sched_entity_fini()
> > =C2=A0			 * eventually
> > +			 *
> > +			 * FIXME:
> > +			 * This lacks the proper spin_lock(&s_entity->lock) and
> > +			 * is, therefore, a race condition. Most notably, it
> > +			 * can race with drm_sched_entity_push_job(). The lock
> > +			 * cannot be taken here, however, because this would
> > +			 * lead to lock inversion -> deadlock.
> > +			 *
> > +			 * The best solution probably is to enforce the life
> > +			 * time rule of all entities having to be torn down
> > +			 * before their scheduler. Then, however, locking could
> > +			 * be dropped alltogether from this function.
>=20
> "Enforce the rule" is correct, since factually it's there, as a dependenc=
y in
> the code.
>=20
> Do we know which drivers violate this lifetime rule?

I've got no idea :(

>=20
> @Christian: What about amdgpu (for which the below was added to begin wit=
h)?

+1

P.

>=20
> > +			 * For now, this remains a potential race in all
> > +			 * drivers that keep entities alive for longer than
> > +			 * the scheduler.
> > =C2=A0			 */
> > =C2=A0			s_entity->stopped =3D true;
> > =C2=A0		spin_unlock(&rq->lock);
> > --=20
> > 2.49.0
>=20


