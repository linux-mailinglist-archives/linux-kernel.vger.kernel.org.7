Return-Path: <linux-kernel+bounces-831963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CADB9E063
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF161BC037A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86326F2BB;
	Thu, 25 Sep 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nvKkIdlw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D861FE45D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788476; cv=none; b=Vwdtiye8BccLr0SmPTwJz0GocfdSpw3dqurgtuGMJZWbWoBCa6zDE1jkGYqIgxCGjhHwlqhObE+Qku7IWQuzLsMnRJmTHCD0KuXNHhBslSp2Zb1yl4cgkRdgXUd/ryCtVCK38ui+q01j68zZGE/00PqoraWeKv9fnhvnOX/SJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788476; c=relaxed/simple;
	bh=ZI06X6co9rcInVxoUsju55LiPRORhdWHLVzHpVh7hAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHWHQW2e8BTCaQLEDtGoKz4w8mrdbLVP+dq2/om/MzompjBfaIKk4OQ+c4N9q/KDZ/72P88y3vkW3T7vSWy7CvtFllYikcbivgSOLoiVgN5TCZRFzeuojdn9GC1wb9CybTxpsBxRYGDNpKRERZh/MYoGpjn+m1o9gyhrGv/VImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nvKkIdlw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758788472;
	bh=ZI06X6co9rcInVxoUsju55LiPRORhdWHLVzHpVh7hAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvKkIdlwNsHL/Yx3LP8a8zQ9Otk0Ecz3fJcHBqPn57xvLg5loyha+5fKebOT4d8sG
	 WbFkkgvI8SbCcVhzItvxbtyIzlIDTZKl1OTKcPp1jaCwS5UDjmrPOdGwagUp3BaIvO
	 NneDRa5upSAImG2t5g2KrRB1C1iCiUJgQ4lotd0c9tsoU7iwKKTRZCJP1k2QsO+/H2
	 UGyLx1+mSXwvDfv23q0pjw8glVTZFBC2ssoegWUEXEWcRpNqcbgnHaOjgy/VsU8R+2
	 f1D0gc70AJiYAlxEWAWhE3YS/P857wIdoQMTRbHy/ktodAiSc+jasvIn4C38J6OBJM
	 D5+6gNPpF2q4w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D1C6117E046C;
	Thu, 25 Sep 2025 10:21:11 +0200 (CEST)
Date: Thu, 25 Sep 2025 10:20:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] drm/panthor: Defer scheduler entitiy destruction to
 queue release
Message-ID: <20250925102055.3e6c5703@fedora>
In-Reply-To: <20250919164436.531930-1-adrian.larumbe@collabora.com>
References: <20250919164436.531930-1-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Sep 2025 17:43:48 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Commit de8548813824 ("drm/panthor: Add the scheduler logical block")
> handled destruction of a group's queues' drm scheduler entities early
> into the group destruction procedure.
>=20
> However, that races with the group submit ioctl, because by the time
> entities are destroyed (through the group destroy ioctl), the submission
> procedure might've already obtained a group handle, and therefore the
> ability to push jobs into entities. This is met with a DRM error message
> within the drm scheduler core as a situation that should never occur.
>=20
> Fix by deferring drm scheduler entity destruction to queue release time.
>=20
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Discussed with you before you posted it, so here's the official

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Thanks for fixing that.

Boris


> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 0cc9055f4ee5..f5e01cb16cfc 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -898,8 +898,7 @@ static void group_free_queue(struct panthor_group *gr=
oup, struct panthor_queue *
>  	if (IS_ERR_OR_NULL(queue))
>  		return;
> =20
> -	if (queue->entity.fence_context)
> -		drm_sched_entity_destroy(&queue->entity);
> +	drm_sched_entity_destroy(&queue->entity);
> =20
>  	if (queue->scheduler.ops)
>  		drm_sched_fini(&queue->scheduler);
> @@ -3609,11 +3608,6 @@ int panthor_group_destroy(struct panthor_file *pfi=
le, u32 group_handle)
>  	if (!group)
>  		return -EINVAL;
> =20
> -	for (u32 i =3D 0; i < group->queue_count; i++) {
> -		if (group->queues[i])
> -			drm_sched_entity_destroy(&group->queues[i]->entity);
> -	}
> -
>  	mutex_lock(&sched->reset.lock);
>  	mutex_lock(&sched->lock);
>  	group->destroyed =3D true;


