Return-Path: <linux-kernel+bounces-735522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4AAB09078
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E641C26FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3A2F8C52;
	Thu, 17 Jul 2025 15:24:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE82F7D18
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765860; cv=none; b=t8cFvv6/xHwm6Ox7GPWqNamlrlCVYmkeMqCCm30M1jAnVypjJ1gg0RHG9gOgVyayKCMgoUZBtel4LZa+L8ACebksfETwcOKChSxpsJ7IeYkwqbI1J292/vS5ypf3PPiFcWa9G/0Ppi7y+GxDu9T24lXZ6iJ/1L9jsxmw3TlMbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765860; c=relaxed/simple;
	bh=0pEfm8oK7l4AJOO/4kGs4JPdqY4cIZBb3f5pEx8Zk8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ND7BOhVw6lYumETG43UR3gFbW9rTG+La3VOT+8O78Irn96DWRwVLRBt1PyrSEjmUSq9jGQKRDGYWDl9vnrIUp5I1KhZzYPnfjLQo+0r62xyrjVsquHNwfYdaloO7qb+X5LkvIjCu5tC0Fd/iLzyvebEjshlpg6hXUWwCGiDpgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F1BB1691;
	Thu, 17 Jul 2025 08:24:11 -0700 (PDT)
Received: from [10.1.28.24] (e122027.cambridge.arm.com [10.1.28.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008363F694;
	Thu, 17 Jul 2025 08:24:16 -0700 (PDT)
Message-ID: <5450eea4-def3-4b1c-9de7-6d6eb35b852a@arm.com>
Date: Thu, 17 Jul 2025 16:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] panthor: dump task pid and comm on gpu errors
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250713030831.3227607-1-olvaffe@gmail.com>
 <20250713030831.3227607-4-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250713030831.3227607-4-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2025 04:08, Chia-I Wu wrote:
> It is useful to know which tasks cause gpu errors.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 823b0fe678ba6..47912b06ec9d3 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1364,8 +1364,12 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
>  	fatal = cs_iface->output->fatal;
>  	info = cs_iface->output->fatal_info;
>  
> -	if (group)
> +	if (group) {
> +		drm_warn(&ptdev->base, "CS_FATAL: pid=%d, comm=%s\n",
> +			 group->task_info.pid, group->task_info.comm);
> +
>  		group->fatal_queues |= BIT(cs_id);
> +	}
>  
>  	if (CS_EXCEPTION_TYPE(fatal) == DRM_PANTHOR_EXCEPTION_CS_UNRECOVERABLE) {
>  		/* If this exception is unrecoverable, queue a reset, and make
> @@ -1425,6 +1429,11 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
>  		spin_unlock(&queue->fence_ctx.lock);
>  	}
>  
> +	if (group) {
> +		drm_warn(&ptdev->base, "CS_FAULT: pid=%d, comm=%s\n",
> +			 group->task_info.pid, group->task_info.comm);
> +	}
> +
>  	drm_warn(&ptdev->base,
>  		 "CSG slot %d CS slot: %d\n"
>  		 "CS_FAULT.EXCEPTION_TYPE: 0x%x (%s)\n"
> @@ -1641,11 +1650,15 @@ csg_slot_process_progress_timer_event_locked(struct panthor_device *ptdev, u32 c
>  
>  	lockdep_assert_held(&sched->lock);
>  
> -	drm_warn(&ptdev->base, "CSG slot %d progress timeout\n", csg_id);
> -
>  	group = csg_slot->group;
> -	if (!drm_WARN_ON(&ptdev->base, !group))
> +	if (!drm_WARN_ON(&ptdev->base, !group)) {
> +		drm_warn(&ptdev->base, "CSG_PROGRESS_TIMER_EVENT: pid=%d, comm=%s\n",
> +			 group->task_info.pid, group->task_info.comm);
> +
>  		group->timedout = true;
> +	}
> +
> +	drm_warn(&ptdev->base, "CSG slot %d progress timeout\n", csg_id);
>  
>  	sched_queue_delayed_work(sched, tick, 0);
>  }
> @@ -3227,7 +3240,8 @@ queue_timedout_job(struct drm_sched_job *sched_job)
>  	struct panthor_scheduler *sched = ptdev->scheduler;
>  	struct panthor_queue *queue = group->queues[job->queue_idx];
>  
> -	drm_warn(&ptdev->base, "job timeout\n");
> +	drm_warn(&ptdev->base, "job timeout: pid=%d, comm=%s, seqno=%llu\n",
> +		 group->task_info.pid, group->task_info.comm, job->done_fence->seqno);
>  
>  	drm_WARN_ON(&ptdev->base, atomic_read(&sched->reset.in_progress));
>  


