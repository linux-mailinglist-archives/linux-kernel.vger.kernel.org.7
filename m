Return-Path: <linux-kernel+bounces-791319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C88BB3B553
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4705EA04957
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51079296BB3;
	Fri, 29 Aug 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hs+Bnybs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F255CDF1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454430; cv=none; b=uW6ZpB60QdZfiGyYU3MsQsAd+PocjJPSry/TBDd9fNjfBK4dkaWkq3dW+n+1wBItqBPecI8WKtL8Qj9nFOTX3BbejXD4d54uo1erOglnvz/IFqgSRJQYbfcKHmdqOWe00T4smRLCo/jBxAHWoJ9oSmJRQh5l78Obt0B7GFmaDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454430; c=relaxed/simple;
	bh=DODr9LwTYNa97ETlnr7bLIvWbeWbSZ/eK8DYx+sJjEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZRt/9np9O6fUNZS/UIgT8ZuidsVRnSHuoUEhOOKNkrPAF2DdciooFUJj+JdXm6/8ZLhgx7+3JinFCsyR/OzCx4f8t6KLAry55P6uSQdz5vQdEbSevSqMlM2dBEWP3tBw2GN+S3CRJngf6R011SXl2Z4MU/ROmPROla82DggoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hs+Bnybs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756454426;
	bh=DODr9LwTYNa97ETlnr7bLIvWbeWbSZ/eK8DYx+sJjEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hs+Bnybs8YY/33GO7r58tvbpnG8deSExM2cziCB2ZBapJ44T4/EbU9lACbKm+h639
	 U3FKsqYegl21Gu3BxXYn2J1k28eBnFgUzuElFvMOoDhCiz+klLXThZ0Yzuv6+8tM8W
	 nKceC/CK0xpCgANXLZdvFMiA/VS4OX8qHyPMF9SdcZ0vFTzeNWOSkcj0a+AVbj3iah
	 qsJHWXig656qmmHAXu4tevPb/c6n30PoWMruk4TM+vBuF9nACwfKxiJ71IABdw7J7a
	 V5UZj4I1KLQVO+OlX00PYBXqOx3FhNQn1ueg2F0/naQm6jQXDB7xfAXz8M6x0gA9pC
	 Swa4NdFpnj47w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BE47C17E011A;
	Fri, 29 Aug 2025 10:00:25 +0200 (CEST)
Date: Fri, 29 Aug 2025 10:00:21 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: assign unique names to queues
Message-ID: <20250829100021.361578c5@fedora>
In-Reply-To: <20250828200532.3534201-1-olvaffe@gmail.com>
References: <20250828200532.3534201-1-olvaffe@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 13:05:32 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> Userspace relies on the ring field of gpu_scheduler tracepoints to
> identify a drm_gpu_scheduler.  The value of the ring field is taken from
> sched->name.
> 
> Because we typically have multiple schedulers running in parallel in
> each process, assign unique names to schedulers such that userspace can
> distinguish them.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Two minor comments below.

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 32 ++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index ba5dc3e443d9c..26616b6cb110d 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -360,6 +360,9 @@ struct panthor_queue {
>  	/** @entity: DRM scheduling entity used for this queue. */
>  	struct drm_sched_entity entity;
>  
> +	/** @name: DRM scheduler name for this queue. */
> +	char name[32];
> +
>  	/**
>  	 * @remaining_time: Time remaining before the job timeout expires.
>  	 *
> @@ -3308,9 +3311,10 @@ static u32 calc_profiling_ringbuf_num_slots(struct panthor_device *ptdev,
>  
>  static struct panthor_queue *
>  group_create_queue(struct panthor_group *group,
> -		   const struct drm_panthor_queue_create *args)
> +		   const struct drm_panthor_queue_create *args, u32 gid,
> +		   u32 qid)
>  {
> -	const struct drm_sched_init_args sched_args = {
> +	struct drm_sched_init_args sched_args = {
>  		.ops = &panthor_queue_sched_ops,
>  		.submit_wq = group->ptdev->scheduler->wq,
>  		.num_rqs = 1,
> @@ -3323,7 +3327,7 @@ group_create_queue(struct panthor_group *group,
>  		.credit_limit = args->ringbuf_size / sizeof(u64),
>  		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
>  		.timeout_wq = group->ptdev->reset.wq,
> -		.name = "panthor-queue",
> +		.name = NULL, /* will point to queue->name */
>  		.dev = group->ptdev->base.dev,
>  	};
>  	struct drm_gpu_scheduler *drm_sched;
> @@ -3398,6 +3402,11 @@ group_create_queue(struct panthor_group *group,
>  	if (ret)
>  		goto err_free_queue;
>  
> +	/* assign a unique name */
> +	snprintf(queue->name, sizeof(queue->name), "panthor-queue-%d-%d", gid,
> +		 qid);
> +	sched_args.name = queue->name;

Should we plan ahead and have the pid in the name too?

> +
>  	ret = drm_sched_init(&queue->scheduler, &sched_args);
>  	if (ret)
>  		goto err_free_queue;
> @@ -3540,12 +3549,18 @@ int panthor_group_create(struct panthor_file *pfile,
>  	memset(group->syncobjs->kmap, 0,
>  	       group_args->queues.count * sizeof(struct panthor_syncobj_64b));
>  
> +	ret = xa_alloc(&gpool->xa, &gid, group,
> +		       XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
> +	if (ret)
> +		goto err_put_group;
> +
>  	for (i = 0; i < group_args->queues.count; i++) {
> -		group->queues[i] = group_create_queue(group, &queue_args[i]);
> +		group->queues[i] =
> +			group_create_queue(group, &queue_args[i], gid, i);

nit: the limit is 100 chars now, so I think we can have it on a single
line.

>  		if (IS_ERR(group->queues[i])) {
>  			ret = PTR_ERR(group->queues[i]);
>  			group->queues[i] = NULL;
> -			goto err_put_group;
> +			goto err_erase_gid;
>  		}
>  
>  		group->queue_count++;
> @@ -3553,10 +3568,6 @@ int panthor_group_create(struct panthor_file *pfile,
>  
>  	group->idle_queues = GENMASK(group->queue_count - 1, 0);
>  
> -	ret = xa_alloc(&gpool->xa, &gid, group, XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
> -	if (ret)
> -		goto err_put_group;
> -
>  	mutex_lock(&sched->reset.lock);
>  	if (atomic_read(&sched->reset.in_progress)) {
>  		panthor_group_stop(group);
> @@ -3575,6 +3586,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  
>  	return gid;
>  
> +err_erase_gid:
> +	xa_erase(&gpool->xa, gid);
> +
>  err_put_group:
>  	group_put(group);
>  	return ret;


