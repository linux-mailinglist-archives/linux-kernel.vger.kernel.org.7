Return-Path: <linux-kernel+bounces-820757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B02B7F183
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53124624482
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F23233E9;
	Wed, 17 Sep 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E+r4h8g3"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0131A814
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114113; cv=none; b=qWy+qmLXpkMYyQI52iJ+I+9rpW2guKqZHv70wkTcstvN+0zoUJowZXhC/MANWOVKXMlquxM64UCHg+KdnPFOzrbcrnJu/QM3X3zejPSFhodhgzCjj2nD+XBf+u7yAbLAi8Vt625Nid2ScuArRjOSR7koo1oxCRo9lx5tEE4jWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114113; c=relaxed/simple;
	bh=LQ4u/583uE1+dOOVzGmM3HhS72iikorD+a/SwNVox+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slqbtcVT65cJMVs1BazyZPFom61RJ/kWrVr4kSRK65FUTdoj7h3a3ok+6GQh/GQgs5w7KIbWoZyyei4GM3cozkxtRyIn4Dv7o3XW4qxRE16jWQdOsK6/gYWILP8oZ3DI8NVNjXGl7CD05XbomYaiGoNOkEi2QKJG3hJqv93N9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=E+r4h8g3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cRf6g2dVmz9sq6;
	Wed, 17 Sep 2025 15:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758114107; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ4u/583uE1+dOOVzGmM3HhS72iikorD+a/SwNVox+M=;
	b=E+r4h8g3Ro/vE8nUHJ5jxNaby3Ap8GG1KHyuF2GxWd1gfCdy5Gru10GOlDyqIFdogaN98a
	gNm3W/myhA/8Dj7XxImyvZ8nmgPqPQmhFno5Cv4VKlKmFMhMrCvPGTYzWcfBSkk8QvBq4H
	uLSzkaKotcqeZ3T5xjvRYKpxL7zuVHjn5QQIoMGmDZlIaZWJ58L+Y2mq2M4EM8tlqbJTUN
	Q+pJbeVfWeMGkEBfG43HJVKrp02RMfNPHx/oW9zZiHDqoTImmyR15MCIRhoO4so7k59pvU
	5geT4zEnUS9p1AAFq0NVLd1qIOESaLTEqrFqtTMdx9+Pv1NhRxmQeXNHGdMoxQ==
Message-ID: <e640f2abdf1503f5687ca0d79ec3dc061ff6d2c9.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: struct member doc fix
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Luc Ma <onion0709@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
 <dakr@kernel.org>,  Philipp Stanner <phasta@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Date: Wed, 17 Sep 2025 15:01:42 +0200
In-Reply-To: <20250915132327.6293-1-onion0709@gmail.com>
References: <20250915132327.6293-1-onion0709@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 6rzetnuy3m91itdsjtof9m1bym1t9ffc
X-MBO-RS-ID: 2d479856e6987a114d2

On Mon, 2025-09-15 at 21:23 +0800, Luc Ma wrote:
> The mentioned function has been renamed since commit 180fc134d712
> ("drm/scheduler: Rename cleanup functions v2."), so let it refer to
> the current one.
>=20
> v2: use proper pattern for function cross-reference
>=20
> Signed-off-by: Luc Ma <onion0709@gmail.com>

Applied to drm-misc-next, thx.

For the next time: In drm/sched we agreed to not include change logs in
the commit messages because they aren't really useful.

P.

> ---
> =C2=A0include/drm/gpu_scheduler.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 323a505e6e6a..fb88301b3c45 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -546,7 +546,7 @@ struct drm_sched_backend_ops {
> =C2=A0 * @num_rqs: Number of run-queues. This is at most DRM_SCHED_PRIORI=
TY_COUNT,
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as t=
here's usually one run-queue per priority, but could be less.
> =C2=A0 * @sched_rq: An allocated array of run-queues of size @num_rqs;
> - * @job_scheduled: once @drm_sched_entity_do_release is called the sched=
uler
> + * @job_scheduled: once drm_sched_entity_flush() is called the scheduler
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 waits on this wait queue until all the sc=
heduled jobs are
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished.
> =C2=A0 * @job_id_count: used to assign unique id to the each job.


