Return-Path: <linux-kernel+bounces-889972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8CC3EF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F1C3ADE9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D630FC19;
	Fri,  7 Nov 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="allEpq75"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27B30F7FB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504098; cv=none; b=qB69eHqwUWZCvJ1swjE6medDwEfkvJ9Bk9CFEVt29rHE/5UQk3HslzXom9pIRSf3Vm0RBXbLZq3FM/At2dZDOqY4dUGfgowNuXII1IFm2kXRFC0wKig+z6T4tFBhrGlLDS+RNT4U6tDpHvUr6oi0PDUReA1LwCjm3NrSa3P3USI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504098; c=relaxed/simple;
	bh=BU/Gs0JHM6CN5mC4vI6SuDD7CItkNy31jtdFXbpBBkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CR2r5DdwmJiTUer2k9MswMMDsat35OuRg/45aqSjEWcWK1+qCIww6Pmj6mr9XuC3aK+Zb2vAoM+ON01UuHPCSkyM+68hULRUwMd/6hxLU/A4KAPhL77RcUy0DWiaQpmu7TVqhtOSJ+H856tkR1U6IczsokPbETukoe7biWsyRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=allEpq75; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d2sdL5n5Bz9v92;
	Fri,  7 Nov 2025 09:28:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762504086; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6c+wR5OUX7a2v3uoQXxO3f6A3/Jg6yxUDY1v6h0RlM=;
	b=allEpq75HTp0dm+F3EGqJbCpsw/xZ6bs1pnpHxmFyRRv40d/qrdzHEnXr8AECKK1rZxArq
	4ClprlOnpVL5i6lKvyUvX2IYj+Bn+ohpiZPc3bGQv9SzkNgyV2csJgGDAm91wE4NN+oieu
	qrHCkceZMafCPjuCqeq5S8oSSkE7DrDtLmR5NXsYkQrENabaom34ONWWXv54mzAlbzxiCh
	hsUbeJpXOrUzRwxzkqDoKzgKSUwAAN9gWdI0Rj7rLbfkbLeRwCbMbIs/OeTU41NoQHD4Fr
	sO3NCzlEYeSuyuyfUkoRLAK4Efn54FZCkv4oeh0YhG4WLNYD+bHUa1WbhWvNDg==
Message-ID: <3b6c211d4da50273ac5441bc939dfadb537c655d.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Replace use of system_wq with
 system_percpu_wq
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Marco Crivellari <marco.crivellari@suse.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Michal Hocko <mhocko@suse.com>, Matthew Brost
 <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,  Philipp
 Stanner <phasta@kernel.org>, Christian Konig
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Date: Fri, 07 Nov 2025 09:28:00 +0100
In-Reply-To: <20251106150121.256367-1-marco.crivellari@suse.com>
References: <20251106150121.256367-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1d6f8abc1971d72ad65
X-MBO-RS-META: b3x6mitjoinicedcwpy6bbgd61fqqxf5

On Thu, 2025-11-06 at 16:01 +0100, Marco Crivellari wrote:
> In the general workqueue implementation, if a user enqueues a work item
> using schedule_delayed_work() the used wq is "system_wq" (per-cpu wq)
> while queue_delayed_work() use WORK_CPU_UNBOUND (used when a cpu is not
> specified). The same applies to schedule_work() that is using system_wq
> and queue_work(), that makes use again of WORK_CPU_UNBOUND.
>=20
> This lack of consistency cannot be addressed without refactoring the API.
> For more details see the Link tag below.
>=20
> This continues the effort to refactor worqueue APIs, which has begun
> with the change introducing new workqueues and a new alloc_workqueue flag=
:
>=20
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>=20
> Use the successor of system_wq, system_percpu_wq, for the scheduler's
> default timeout_wq. system_wq will be removed in a few release cycles.
>=20
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied to drm-misc-next.

Thanks a lot
P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index c39f0245e3a9..13192e99637a 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1315,7 +1315,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,=
 const struct drm_sched_init_
> =C2=A0	sched->name =3D args->name;
> =C2=A0	sched->timeout =3D args->timeout;
> =C2=A0	sched->hang_limit =3D args->hang_limit;
> -	sched->timeout_wq =3D args->timeout_wq ? args->timeout_wq : system_wq;
> +	sched->timeout_wq =3D args->timeout_wq ? args->timeout_wq : system_perc=
pu_wq;
> =C2=A0	sched->score =3D args->score ? args->score : &sched->_score;
> =C2=A0	sched->dev =3D args->dev;
> =C2=A0


