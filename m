Return-Path: <linux-kernel+bounces-880098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D7C24DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67E5635114D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81343348453;
	Fri, 31 Oct 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="iWszGXr/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7594346FA0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911421; cv=none; b=Czrcv5vA4dMu3QjNEFA9tsJyLxH4/DxNFQWbmklP0L3fTghpOR4pMxaSJP+OZtofFtZ7t/Vn61HUgazOMjf442n2UbDP9Sno8tpLk1dH7KWhiW7VUpifuyipAQswM6bQtGNTEoNBVvoLcB9CCUNBJqXphAFLQucGNbbEVGB402Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911421; c=relaxed/simple;
	bh=qBTF3vC97h/TQ5mFg0ENVn3FRosFpRIjOpgQtABY4KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WA/dHuM6QsAHSjak4o/kLJIYcnQuoNvHfffRXJs+HRfG8tDqnEde+r8EPU8ck9kynueq4RZH98O0rAyHixmw2I9EYwrIRgMB/+rBWimjItsUfQk6cGnZpk5FJot8Ma6/sTaMahfUp2lweTw3sbgsxfbz5rBTziIRw4iVrk+mJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=iWszGXr/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c2f6a580so317305f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761911418; x=1762516218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMW4q1yc/hq1gjF5rKdDD6wjxSe1WwAdRUZxNTv4M7U=;
        b=iWszGXr/WjG0Iy3nl+JyGoceL39J++pv91P2V0gC+pdLjp1+0XI/Ws7fArDdeIXjAs
         sxVq/gfBIjH4WbGXuTgYr+IiZ21/cFjl+Tu68IursCoo/7ie+IRMRGkayago2mlZDnvi
         en4qNhbt57co9O7FyDiUVSD+5uhL2UznR7W4GQBjrhlc0gJTazMPgUOqqlPigMq2csvx
         SD2uoPTJwIjmkx/+0b6oVNbQDbCVjVXUT7/kjZ/TcPgzPAL25sDiviLC9hdKjb4YYLw+
         /X39bAiIOH2onQmK/DBrY95eoHZYl08/KFRoavtOavyr4VZXIpV9Q+3o567jJYKLd1kN
         wMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911418; x=1762516218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMW4q1yc/hq1gjF5rKdDD6wjxSe1WwAdRUZxNTv4M7U=;
        b=BCdQuvli1h3QHmNwlDdhmMWqY+J+07q6cvdqc+ekx37MlrTlyp0nX5GgGcJbAVEXOq
         0wpHDPzUma6TZvclyKWElv0yfPjCzaH7YVElc6yG5yLMmJNs8SNqx87GjvKsRYVzDIjL
         W8eyUB+bLgAlIXVHHD2eqlrbIr3HeFbP6uYaMajnCniYxPit5h8ikJZm5hUsoRMg2Mjq
         tVW76Kwhiw7uaGRuKOsEH38UW41tjLewi2qnGLeSc1Uc6bk+fndRvGY9QWnRbrOZuEsb
         KOpo4bCtllUrZiqwCjiFj3bsb9AM+9kuvwUEjfElZGRvZa1xvCQ6qwrxKiVXNbJuNRLT
         HQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdeC3f2OVbXkdMli3Vxp2nl3StHZkaFKKK0//K1DAOF1a86FG4Ot3RZG0+UWIRq29ly8+UqFRtTjop+0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zMU8/WVlXrhD0cdf/5pzv+z4EqwSMJyyAXBFB1S21oyFsnD8
	2D8Ci9oir2B1FotYDmg+CHBu/2JfhiIYC/zUSIQsxFB2tmry8Eddlo4z1azNdhicyUE=
X-Gm-Gg: ASbGncufun/NwPIn5W7m7wimhG6AkoSSfG5X/XmWWxlrYNAt9n15PfElRzJStg2i04i
	kr0m3v8U7QvpBBopEyfjh8T2FG7JM+OpxscVD33jMdLcoY7aNMlWGZdT28/f3L07dsjxFhPJd/T
	R/Ias4US5CKIM4gQ7XYAZrM5Eb7GSHP++CCtBZge8GjJTnZYYXpNj50c6Icn7eTGZxQZJuIKcO5
	JpndeHbEZJhupHrmnmpSBq+4cNMBAAJCSsyXKdxbzHmvfdu5NiXFyQPniidJU8ywHJo46kW/iPY
	KEZWgUf29TvdK20KQAh/2vyqOXDfmHRLmkBFGuBBcSZsrdnvealpaF7fKRE92idSk2vYhK/dD/Z
	7gbhWlLvmk0PWnQ2ncsqJqgBdWmb8Eoa/FByk0C8JFa5A5qcp+jLE0cmN+a8dRsf5oFlh/dHa5/
	GswsXrF0eUS3+HcBnB
X-Google-Smtp-Source: AGHT+IG7ZgRAfklgWSpAYSPzxFgTxUag6V3Fc8ctTVAuDt+DMbJ27kEs61rDXYyhICbDmi4MeLbsVQ==
X-Received: by 2002:a05:6000:1889:b0:3dc:1473:18bc with SMTP id ffacd0b85a97d-429bd5f72ccmr2613024f8f.0.1761911416851;
        Fri, 31 Oct 2025 04:50:16 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728a979b8sm91657215e9.10.2025.10.31.04.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 04:50:16 -0700 (PDT)
Message-ID: <411190d4-92d7-4e95-acac-b39afa438c0f@ursulin.net>
Date: Fri, 31 Oct 2025 11:50:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: Fix deadlock in
 drm_sched_entity_kill_jobs_cb
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20251031090704.1111-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031090704.1111-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 31/10/2025 09:07, Pierre-Eric Pelloux-Prayer wrote:
> The Mesa issue referenced below pointed out a possible deadlock:
> 
> [ 1231.611031]  Possible interrupt unsafe locking scenario:
> 
> [ 1231.611033]        CPU0                    CPU1
> [ 1231.611034]        ----                    ----
> [ 1231.611035]   lock(&xa->xa_lock#17);
> [ 1231.611038]                                local_irq_disable();
> [ 1231.611039]                                lock(&fence->lock);
> [ 1231.611041]                                lock(&xa->xa_lock#17);
> [ 1231.611044]   <Interrupt>
> [ 1231.611045]     lock(&fence->lock);
> [ 1231.611047]
>                  *** DEADLOCK ***
> 
> In this example, CPU0 would be any function accessing job->dependencies
> through the xa_* functions that doesn't disable interrupts (eg:
> drm_sched_job_add_dependency, drm_sched_entity_kill_jobs_cb).
> 
> CPU1 is executing drm_sched_entity_kill_jobs_cb as a fence signalling
> callback so in an interrupt context. It will deadlock when trying to
> grab the xa_lock which is already held by CPU0.
> 
> Replacing all xa_* usage by their xa_*_irq counterparts would fix
> this issue, but Christian pointed out another issue: dma_fence_signal
> takes fence.lock and so does dma_fence_add_callback.
> 
>    dma_fence_signal() // locks f1.lock
>    -> drm_sched_entity_kill_jobs_cb()
>    -> foreach dependencies
>       -> dma_fence_add_callback() // locks f2.lock
> 
> This will deadlock if f1 and f2 share the same spinlock.

Is it possible to hit this case?

Same lock means same execution timeline, which should mean dependency 
should have been squashed in drm_sched_job_add_dependency(), no?

Or would sharing the lock but not sharing the entity->fence_context be 
considered legal? It would be surprising at least.

Also, would anyone have time to add a kunit test? ;)

Regards,

Tvrtko

> To fix both issues, the code iterating on dependencies and re-arming them
> is moved out to drm_sched_entity_kill_jobs_work.
> 
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/13908
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 34 +++++++++++++-----------
>   1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index c8e949f4a568..fe174a4857be 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -173,26 +173,15 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>   }
>   EXPORT_SYMBOL(drm_sched_entity_error);
>   
> +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
> +					  struct dma_fence_cb *cb);
> +
>   static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
>   {
>   	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
> -
> -	drm_sched_fence_scheduled(job->s_fence, NULL);
> -	drm_sched_fence_finished(job->s_fence, -ESRCH);
> -	WARN_ON(job->s_fence->parent);
> -	job->sched->ops->free_job(job);
> -}
> -
> -/* Signal the scheduler finished fence when the entity in question is killed. */
> -static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
> -					  struct dma_fence_cb *cb)
> -{
> -	struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
> -						 finish_cb);
> +	struct dma_fence *f;
>   	unsigned long index;
>   
> -	dma_fence_put(f);
> -
>   	/* Wait for all dependencies to avoid data corruptions */
>   	xa_for_each(&job->dependencies, index, f) {
>   		struct drm_sched_fence *s_fence = to_drm_sched_fence(f);
> @@ -220,6 +209,21 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>   		dma_fence_put(f);
>   	}
>   
> +	drm_sched_fence_scheduled(job->s_fence, NULL);
> +	drm_sched_fence_finished(job->s_fence, -ESRCH);
> +	WARN_ON(job->s_fence->parent);
> +	job->sched->ops->free_job(job);
> +}
> +
> +/* Signal the scheduler finished fence when the entity in question is killed. */
> +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
> +					  struct dma_fence_cb *cb)
> +{
> +	struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
> +						 finish_cb);
> +
> +	dma_fence_put(f);
> +
>   	INIT_WORK(&job->work, drm_sched_entity_kill_jobs_work);
>   	schedule_work(&job->work);
>   }


