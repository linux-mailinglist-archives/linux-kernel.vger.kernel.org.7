Return-Path: <linux-kernel+bounces-795701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F57B3F6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582A83BFDD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981C2E6CC8;
	Tue,  2 Sep 2025 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cQprZjxX"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1952DF144
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798060; cv=none; b=TWHxNjmxhcefQli27V+d4s8vuIt4CvpdBdwTpnv/8Dnwc8oETnvvhtSD9cSLHAJkSqJN0x8gQURbWna8Y5gnZuDlHiZsygdNIGCKW02h1LZttEyUwwnmo49OEw1uOBPgqn2T6NSvRioVIiLZftOD6pR+H2tD430SJzrHrKc+vK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798060; c=relaxed/simple;
	bh=7MM3ZadM3wSzyNk1K9rxHLxE789t1JMtbclB6YOLwbg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1FMODFJGd10ydTTvS2GPATKpes12RXTZvpcBTl7D4Tmw3cX5Av07m89WcTqaNnoTA7bvPPQNy5JpfxYXZeaIkWGJ6U8yQbTwo0Q1gkpf0xPHWf6UL0uHWe2cpV9O30/m8T7N8dCys6sCfnUnUJsfBQBzFOnEc718cMYy5gs3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cQprZjxX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cGHPs58DJz9spP;
	Tue,  2 Sep 2025 09:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756798049; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG8I1xuTHEhEIkmbynHckFwP9cXa9p2PM0q5O3/0wtg=;
	b=cQprZjxXkdXeulkN41CYFIAnkNH/Qp3/xIVXYGi/Dddld7LiwABAnVp+y1Dj0cxHUNZgtf
	RePcPQWbQmleFUPyg8Rn3rhjqJx81lFVLLjyBK97BPH9CbQ5y2Bg1XkVo5HnMTRSz63wq/
	f5e0ecoOHeclDG2HCUrBEthyr2ADxK1DlXv319P1gUTRYR3cDIyoZ9yauIkAjljBco/JBV
	Z6GTe7BWIUZT2/7z5sxnPiuhLR2eO3LxooKIbs2NUz+WiSppJIgVbV2TLhHMpqV9RiZ4gJ
	KrJ1DtGp/B6PlbUNFBswKPIDvPr59R+wnWbkFsktF41aTFCIJSSUIBQj8sWAAw==
Message-ID: <da59f28c7d8b3d83833aa0494b3b198335cf588f.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Fix racy access to
 drm_sched_entity.dependency
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,  Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Sep 2025 09:27:24 +0200
In-Reply-To: <20250901124032.1955-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250901124032.1955-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: m9kgt19mrt1xki6y19ipjzxmsq48bans
X-MBO-RS-ID: e19ebd61c6c47cd73d7

On Mon, 2025-09-01 at 14:40 +0200, Pierre-Eric Pelloux-Prayer wrote:
> The drm_sched_job_unschedulable trace point can access
> entity->dependency after it was cleared by the callback
> installed in drm_sched_entity_add_dependency_cb, causing:
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> [...]
> Workqueue: comp_1.1.0 drm_sched_run_job_work [gpu_sched]
> RIP: 0010:trace_event_raw_event_drm_sched_job_unschedulable+0x70/0xd0 [gp=
u_sched]
>=20
> To fix this we either need to keep a reference to the fence before
> setting up the callbacks, or move the trace_drm_sched_job_unschedulable
> calls into drm_sched_entity_add_dependency_cb where they can be
> done earlier.
>=20
> Fixes: 76d97c870f29 ("drm/sched: Trace dependencies for GPU jobs")
>=20
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied to drm-misc-next

Thx
P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++----
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 8867b95ab089..3d06f72531ba 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -391,7 +391,8 @@ EXPORT_SYMBOL(drm_sched_entity_set_priority);
> =C2=A0 * Add a callback to the current dependency of the entity to wake u=
p the
> =C2=A0 * scheduler when the entity becomes available.
> =C2=A0 */
> -static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *=
entity)
> +static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *=
entity,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_job *sched_jo=
b)
> =C2=A0{
> =C2=A0	struct drm_gpu_scheduler *sched =3D entity->rq->sched;
> =C2=A0	struct dma_fence *fence =3D entity->dependency;
> @@ -421,6 +422,10 @@ static bool drm_sched_entity_add_dependency_cb(struc=
t drm_sched_entity *entity)
> =C2=A0		entity->dependency =3D fence;
> =C2=A0	}
> =C2=A0
> +	if (trace_drm_sched_job_unschedulable_enabled() &&
> +	=C2=A0=C2=A0=C2=A0 !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->depe=
ndency->flags))
> +		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
> +
> =C2=A0	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
> =C2=A0				=C2=A0=C2=A0=C2=A0 drm_sched_entity_wakeup))
> =C2=A0		return true;
> @@ -461,10 +466,8 @@ struct drm_sched_job *drm_sched_entity_pop_job(struc=
t drm_sched_entity *entity)
> =C2=A0
> =C2=A0	while ((entity->dependency =3D
> =C2=A0			drm_sched_job_dependency(sched_job, entity))) {
> -		if (drm_sched_entity_add_dependency_cb(entity)) {
> -			trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
> +		if (drm_sched_entity_add_dependency_cb(entity, sched_job))
> =C2=A0			return NULL;
> -		}
> =C2=A0	}
> =C2=A0
> =C2=A0	/* skip jobs from entity that marked guilty */


