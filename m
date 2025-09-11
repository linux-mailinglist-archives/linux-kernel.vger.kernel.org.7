Return-Path: <linux-kernel+bounces-811767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B4B52D91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C0658732C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51212F530A;
	Thu, 11 Sep 2025 09:43:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C682EDD52
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583826; cv=none; b=biyk7nvHIuFI8nEKeR3asvdwh1Ee1bABgW1tanVxu5OwIC2lmEkX6DN2qCD9YqKMUrUyUmX2Sn39PkBeiOX4sZYhufJusdmxk77Q7TVlTX2W3/+NEdHe3M4aA5i0Op40xaDj1JI/fanG5GdJyohKIvOVi9wZUIB2yyVf7qUBs8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583826; c=relaxed/simple;
	bh=xMWlFDmCLb1Y/VLpkZpTuVQkBBmSyl2dG8QKqAL7ONw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q/GnztCcxB6jTsYO7U4lXEcqdg1lJWbrn+6KqX8ZJxCoPHK6BGl54PQk5H9aXyxcwAm168qpvivP0g4ZHWoqkru1f9FbJ8cEf9MezqbncOQuibO2t1NIwusUGHTx0c+8Hjh2tyqQ2/lPvKk/6Ul+8dlD6qKYHk69m7K4K15Mv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13ADC153B;
	Thu, 11 Sep 2025 02:43:35 -0700 (PDT)
Received: from [10.1.30.24] (e122027.cambridge.arm.com [10.1.30.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EC5E3F694;
	Thu, 11 Sep 2025 02:43:41 -0700 (PDT)
Message-ID: <84c5f82e-5931-42c8-b577-123917a7d30c@arm.com>
Date: Thu, 11 Sep 2025 10:43:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/panthor: assign unique names to queues
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250902200624.428175-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250902200624.428175-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 21:06, Chia-I Wu wrote:
> Userspace relies on the ring field of gpu_scheduler tracepoints to
> identify a drm_gpu_scheduler.  The value of the ring field is taken from
> sched->name.
> 
> Because we typically have multiple schedulers running in parallel in
> each process, assign unique names to schedulers such that userspace can
> distinguish them.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Applied to drm-misc-next.

Thanks,
Steve

> 
> ---
> 
> v2:
>  - include drm_client_id in the name to be truly unique
>  - remove unnecessary NULL in drm_sched_init_args initialization
>  - reformat to column width 100
> 
> v3:
>  - switch to kasprintf for queue name
>    - open to alternatives such as name[48], shorter prefix (e.g.,
>      panthor-q), etc.
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   |  2 +-
>  drivers/gpu/drm/panthor/panthor_sched.c | 38 ++++++++++++++++++-------
>  drivers/gpu/drm/panthor/panthor_sched.h |  3 +-
>  3 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 9256806eb6623..be962b1387f03 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1105,7 +1105,7 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  	if (ret)
>  		goto out;
>  
> -	ret = panthor_group_create(pfile, args, queue_args);
> +	ret = panthor_group_create(pfile, args, queue_args, file->client_id);
>  	if (ret < 0)
>  		goto out;
>  	args->group_handle = ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index ba5dc3e443d9c..b328631c00489 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -360,6 +360,9 @@ struct panthor_queue {
>  	/** @entity: DRM scheduling entity used for this queue. */
>  	struct drm_sched_entity entity;
>  
> +	/** @name: DRM scheduler name for this queue. */
> +	char *name;
> +
>  	/**
>  	 * @remaining_time: Time remaining before the job timeout expires.
>  	 *
> @@ -901,6 +904,8 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
>  	if (queue->scheduler.ops)
>  		drm_sched_fini(&queue->scheduler);
>  
> +	kfree(queue->name);
> +
>  	panthor_queue_put_syncwait_obj(queue);
>  
>  	panthor_kernel_bo_destroy(queue->ringbuf);
> @@ -3308,9 +3313,10 @@ static u32 calc_profiling_ringbuf_num_slots(struct panthor_device *ptdev,
>  
>  static struct panthor_queue *
>  group_create_queue(struct panthor_group *group,
> -		   const struct drm_panthor_queue_create *args)
> +		   const struct drm_panthor_queue_create *args,
> +		   u64 drm_client_id, u32 gid, u32 qid)
>  {
> -	const struct drm_sched_init_args sched_args = {
> +	struct drm_sched_init_args sched_args = {
>  		.ops = &panthor_queue_sched_ops,
>  		.submit_wq = group->ptdev->scheduler->wq,
>  		.num_rqs = 1,
> @@ -3323,7 +3329,6 @@ group_create_queue(struct panthor_group *group,
>  		.credit_limit = args->ringbuf_size / sizeof(u64),
>  		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
>  		.timeout_wq = group->ptdev->reset.wq,
> -		.name = "panthor-queue",
>  		.dev = group->ptdev->base.dev,
>  	};
>  	struct drm_gpu_scheduler *drm_sched;
> @@ -3398,6 +3403,15 @@ group_create_queue(struct panthor_group *group,
>  	if (ret)
>  		goto err_free_queue;
>  
> +	/* assign a unique name */
> +	queue->name = kasprintf(GFP_KERNEL, "panthor-queue-%llu-%u-%u", drm_client_id, gid, qid);
> +	if (!queue->name) {
> +		ret = -ENOMEM;
> +		goto err_free_queue;
> +	}
> +
> +	sched_args.name = queue->name;
> +
>  	ret = drm_sched_init(&queue->scheduler, &sched_args);
>  	if (ret)
>  		goto err_free_queue;
> @@ -3447,7 +3461,8 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
>  
>  int panthor_group_create(struct panthor_file *pfile,
>  			 const struct drm_panthor_group_create *group_args,
> -			 const struct drm_panthor_queue_create *queue_args)
> +			 const struct drm_panthor_queue_create *queue_args,
> +			 u64 drm_client_id)
>  {
>  	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_group_pool *gpool = pfile->groups;
> @@ -3540,12 +3555,16 @@ int panthor_group_create(struct panthor_file *pfile,
>  	memset(group->syncobjs->kmap, 0,
>  	       group_args->queues.count * sizeof(struct panthor_syncobj_64b));
>  
> +	ret = xa_alloc(&gpool->xa, &gid, group, XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
> +	if (ret)
> +		goto err_put_group;
> +
>  	for (i = 0; i < group_args->queues.count; i++) {
> -		group->queues[i] = group_create_queue(group, &queue_args[i]);
> +		group->queues[i] = group_create_queue(group, &queue_args[i], drm_client_id, gid, i);
>  		if (IS_ERR(group->queues[i])) {
>  			ret = PTR_ERR(group->queues[i]);
>  			group->queues[i] = NULL;
> -			goto err_put_group;
> +			goto err_erase_gid;
>  		}
>  
>  		group->queue_count++;
> @@ -3553,10 +3572,6 @@ int panthor_group_create(struct panthor_file *pfile,
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
> @@ -3575,6 +3590,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  
>  	return gid;
>  
> +err_erase_gid:
> +	xa_erase(&gpool->xa, gid);
> +
>  err_put_group:
>  	group_put(group);
>  	return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
> index 742b0b4ff3a3c..f4a475aa34c0a 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.h
> +++ b/drivers/gpu/drm/panthor/panthor_sched.h
> @@ -21,7 +21,8 @@ struct panthor_job;
>  
>  int panthor_group_create(struct panthor_file *pfile,
>  			 const struct drm_panthor_group_create *group_args,
> -			 const struct drm_panthor_queue_create *queue_args);
> +			 const struct drm_panthor_queue_create *queue_args,
> +			 u64 drm_client_id);
>  int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
>  int panthor_group_get_state(struct panthor_file *pfile,
>  			    struct drm_panthor_group_get_state *get_state);


