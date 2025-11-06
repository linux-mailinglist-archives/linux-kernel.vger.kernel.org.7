Return-Path: <linux-kernel+bounces-888863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF5C3C205
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEAB3A5919
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC3299957;
	Thu,  6 Nov 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AqM6PpJa"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82274274B46
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443456; cv=none; b=IDWdI4BwVp8Kl53jPHHLyzerCEChtma5I1b/WlVY78fkX25h81JzLXGwmQxgQo9af3S5WFvSx0UFN4E+H88NtuEt0EIXxHX+pgiuuudsfKklbIV62PcPhkUUpJVNuD+orIfHEK9+1FbvMV7vUoh9+Q5JPRKV5xwdOoeMpvc4zFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443456; c=relaxed/simple;
	bh=tBdP/IZR113dSKubFnTF/iCokshd/YfieV+VHXde2f4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EiWmKj5UcJIO3cjoCTusXwNOKxkwsGUQ5e1LAgtOCKLClgPHKv1e1cDjsdBJWBIaDJBama1YzpoX1B9dwBe8WvXQ10Ffi9OJLVMPulIvyBF/3E8raaeu7dZJztmHq/F/1w9E3rcYcRyf23hhba1UUHaWfQ8Xhi0FBeJApWF94FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AqM6PpJa; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d2RC85wbVz9ssn;
	Thu,  6 Nov 2025 16:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762443444; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cN4XQ/yrUjnQZynIJUOa5KorXTWvolGeJbB10svfxsc=;
	b=AqM6PpJaxlmgTu5Q+jXa6O7QtusawLOFlOtIVmFEUkbacSKvd6HoGe92PjjUYEKZjfaVQ7
	dA2e+sJn0TK0ysYyAekfObU5M8mFbWsUGvjh97/lcZqV5K8tf1pLVyZWhcIooz7qPMlxod
	MB6/wb3/scq/Nt+PH7wYVNn+T1oGwhtsWNa6RVr/ORGtsH+Bl15ddm7HqIb3ufwcrqTQAg
	7JxyBfQE9TNnV7bejWPtLJguBAytWrfmCFfhmuj2/+1aHUc7vj5SA9fDFzohidP4GKR8Ml
	58ihyv/efShPRRUnE0DTDPpLWRx5T9n7eQ5HMH0sY//kHNJ76WjmdXRtBRpZ2g==
Message-ID: <b1f91dd8624ed65308b0420fe2d973f0bb44632d.camel@mailbox.org>
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
Date: Thu, 06 Nov 2025 16:37:18 +0100
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
X-MBO-RS-ID: a1198811dd6e4b25ce0
X-MBO-RS-META: rqfh18m4u7737iekrnbknye3yd315ms1

On Thu, 2025-11-06 at 16:01 +0100, Marco Crivellari wrote:
> In the general workqueue implementation, if a user enqueues a work item
> using schedule_delayed_work() the used wq is "system_wq" (per-cpu wq)
> while queue_delayed_work() use WORK_CPU_UNBOUND (used when a cpu is not
> specified). The same applies to schedule_work() that is using system_wq
> and queue_work(), that makes use again of WORK_CPU_UNBOUND.

Alright, just to be sure:
Behavior doesn't change and system_percpu_wq is then still a workqueue
where we can submit normal delayed_work?

The scheduler's timeout mechanism relies on scheduling and canceling
delayed work items.

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

Thanks for the updated commit message, looks great.


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


