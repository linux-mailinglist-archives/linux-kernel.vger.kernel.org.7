Return-Path: <linux-kernel+bounces-766688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272DDB24A08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0F5882843
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92802E54D8;
	Wed, 13 Aug 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="batDg6bZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D923184540
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089930; cv=none; b=HWmH6ozXtkNpC4nKqqVleDQApFmUa08pkPkAODr0dAfuSL9CgV3kaxhuRa72borjHgAbcY3r9rs27IJrQgCVD1NSkrIf+oxjv0L3jKcbtrmfqvNZeT0Xljdsb0E8o+qQiyRb+wRENEgKQXJ4st3Ap+/ROCBBxDdIYN9//kP/C1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089930; c=relaxed/simple;
	bh=RkV4BeWFbdxMx75LQHna92WI+HaPKkvSdiwARMtLxig=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BvK+fimkoX6/G7T5aJzZou1MJ64dXJJi63O7iZphL0H+s6Ah+ztnFHzCh/k3v4Eq6DoLfbsUUd2Eizm7YVYQa/isIbLGvidcHcFYhtx23PQTzXm7H7LoHT/NpLo6CnE3yMwOQW+e29ArqG0U++00I37pUltJKAd3MkyRUqKCQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=batDg6bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D2BC4CEEB;
	Wed, 13 Aug 2025 12:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755089929;
	bh=RkV4BeWFbdxMx75LQHna92WI+HaPKkvSdiwARMtLxig=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=batDg6bZttXznkMLUheH+SDQRcG2HSzhJ8UNOxc1aKM5VzP9TCS5rjJlclqHJPLTC
	 8PnkuJAd7ZumcpWcNGTCl72GoleiGzeiZcVEB4tk4GqoTLW4GwfSMwVca7JrEQIJZY
	 RZMDXsA+D3ab7O9N6Ent0wYMiHTTevZ3yQ6DX3X5FTa2HnBYtArOT+s7wto06u0EGt
	 jBkiPzJ72cZIkIW/cEGu0rgEbjANrdw2efoc656292Xr/XBLPiH0j1f8Fz9jPwEBIg
	 E21HTdDGp5Q/FBX+QgyDazLvqUCGAWVbbtlGvu5XLmAewD3Y39TuiQsuNWzEm+3T3q
	 gTVOG5Oa0mqEg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 14:58:45 +0200
Message-Id: <DC1BGCY1JPKJ.7BHDGBYZDYMZ@kernel.org>
Subject: Re: [PATCH v2] drm/sched: Document race condition in
 drm_sched_fini()
Cc: "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "James
 Flowers" <bold.zone2373@fastmail.com>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250813085654.102504-2-phasta@kernel.org>
In-Reply-To: <20250813085654.102504-2-phasta@kernel.org>

On Wed Aug 13, 2025 at 10:56 AM CEST, Philipp Stanner wrote:
> In drm_sched_fini() all entities are marked as stopped - without taking
> the appropriate lock, because that would deadlock. That means that
> drm_sched_fini() and drm_sched_entity_push_job() can race against each
> other.
>
> This should most likely be fixed by establishing the rule that all
> entities associated with a scheduler must be torn down first. Then,
> however, the locking should be removed from drm_sched_fini() alltogether
> with an appropriate comment.
>
> Reported-by: James Flowers <bold.zone2373@fastmail.com>
> Link: https://lore.kernel.org/dri-devel/20250720235748.2798-1-bold.zone23=
73@fastmail.com/
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Changes in v2:
>   - Fix typo.
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 5a550fd76bf0..46119aacb809 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1424,6 +1424,22 @@ void drm_sched_fini(struct drm_gpu_scheduler *sche=
d)
>  			 * Prevents reinsertion and marks job_queue as idle,
>  			 * it will be removed from the rq in drm_sched_entity_fini()
>  			 * eventually
> +			 *
> +			 * FIXME:
> +			 * This lacks the proper spin_lock(&s_entity->lock) and
> +			 * is, therefore, a race condition. Most notably, it
> +			 * can race with drm_sched_entity_push_job(). The lock
> +			 * cannot be taken here, however, because this would
> +			 * lead to lock inversion -> deadlock.
> +			 *
> +			 * The best solution probably is to enforce the life
> +			 * time rule of all entities having to be torn down
> +			 * before their scheduler. Then, however, locking could
> +			 * be dropped alltogether from this function.

"Enforce the rule" is correct, since factually it's there, as a dependency =
in
the code.

Do we know which drivers violate this lifetime rule?

@Christian: What about amdgpu (for which the below was added to begin with)=
?

> +			 * For now, this remains a potential race in all
> +			 * drivers that keep entities alive for longer than
> +			 * the scheduler.
>  			 */
>  			s_entity->stopped =3D true;
>  		spin_unlock(&rq->lock);
> --=20
> 2.49.0


