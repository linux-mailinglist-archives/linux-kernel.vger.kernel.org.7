Return-Path: <linux-kernel+bounces-830340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C95B996F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE744C0154
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DF2D9EEC;
	Wed, 24 Sep 2025 10:31:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7619D07E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709892; cv=none; b=Thu7Edn16qTbVGPEmw7M7M9sAzUZEzxwTGhwphbVEcEsjNLu3ZxwmR+KdaNOcF640Ddo4HbJnl5S6sGOeF3aLiJ2BxpFgKLwmKJrHqQTMf4rsNesLxj6cX1UB8Jcx8PKHb0vLfI3IMx4wqevpbleaMiSHOh5+Pv6R3yhQZ35vvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709892; c=relaxed/simple;
	bh=6ZKuDE4Hc9++IA6b/HC+RhyOZFxU4Kd/rKNnUrSCTQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf8e85b8kcMAryondAImu5vKxrvYuR10bqC2oKYIMW7zspl1YIUHN8b/u9bLguiljDYZbJmu0sKQ96HZhEP99ejRtUCPmNe/hpTHpHgZmd9hgxV5l3UL8lKMzuzZ7tDQwPeZUX1UUD/8ffNzk+jajPKdalbNWIuPdYLvYL8Aa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E824C106F;
	Wed, 24 Sep 2025 03:31:17 -0700 (PDT)
Received: from [10.1.32.53] (e122027.cambridge.arm.com [10.1.32.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0077E3F66E;
	Wed, 24 Sep 2025 03:31:23 -0700 (PDT)
Message-ID: <30f56d2a-941c-4876-90e6-c7054b51ec10@arm.com>
Date: Wed, 24 Sep 2025 11:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Defer scheduler entitiy destruction to queue
 release
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250919164436.531930-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250919164436.531930-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2025 17:43, Adrián Larumbe wrote:
> Commit de8548813824 ("drm/panthor: Add the scheduler logical block")
> handled destruction of a group's queues' drm scheduler entities early
> into the group destruction procedure.
> 
> However, that races with the group submit ioctl, because by the time
> entities are destroyed (through the group destroy ioctl), the submission
> procedure might've already obtained a group handle, and therefore the
> ability to push jobs into entities. This is met with a DRM error message
> within the drm scheduler core as a situation that should never occur.
> 
> Fix by deferring drm scheduler entity destruction to queue release time.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Looks good - I can't figure out why we had the early destruction, this
is more simple and safer.

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0cc9055f4ee5..f5e01cb16cfc 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -898,8 +898,7 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
>  	if (IS_ERR_OR_NULL(queue))
>  		return;
>  
> -	if (queue->entity.fence_context)
> -		drm_sched_entity_destroy(&queue->entity);
> +	drm_sched_entity_destroy(&queue->entity);
>  
>  	if (queue->scheduler.ops)
>  		drm_sched_fini(&queue->scheduler);
> @@ -3609,11 +3608,6 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
>  	if (!group)
>  		return -EINVAL;
>  
> -	for (u32 i = 0; i < group->queue_count; i++) {
> -		if (group->queues[i])
> -			drm_sched_entity_destroy(&group->queues[i]->entity);
> -	}
> -
>  	mutex_lock(&sched->reset.lock);
>  	mutex_lock(&sched->lock);
>  	group->destroyed = true;


