Return-Path: <linux-kernel+bounces-880162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD8C25032
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BA2F35130D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E223491D1;
	Fri, 31 Oct 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="abt4L+DJ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7EC348462
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913899; cv=none; b=MLzbFgVYDAvW7MiDN2U/7OEiD4Rst0ghY4sKDKZJfKLiOtzD/LkSeH8FbsQ1nS9kv96TfxCBoFB/tiRzB/j/inXorNKsHdaouRt7N7r7p4tzYKvdZ8SawjW1RU1sYIGfCFa4FnNwBkrZYAZs0l42LZb7ZI2ykvalDXwTDRq2MdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913899; c=relaxed/simple;
	bh=WfbbP1hhX+kiPAYHs46B8G4TL3eC7al6qprIiJuS/+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIe/zkRCQ2O71G66HMNfobtnylLgqygnEnnzYosxhn3GF6g1s0WPgaS92oKc9ptEMV2LmTyS17aS7fIwh70+owvVwGLCHZjQwSDL8vljzoI65ouYZ1r6qcX5kTErUyJN/wcVcdAaOz+fZQdL0iWBE3yAOeMCkt9G/tW2T7V5QkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=abt4L+DJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so1452993f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761913894; x=1762518694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08fssheEH26ewL9xgSjQ1sFTztWWkCBjLlcECWJQBfM=;
        b=abt4L+DJjpFOHA+R2FuxQOisG22QXn7plnmf+ggNdTlMcuwqgrEFnqkgG/XpqEK8+x
         Hy/H/8dpA7DyJLu4giUAFBvf2ePxbaj2q7x6svUxtuI0wJB7JhIpfGJ1xbkAAOvFRw9R
         P33g9hCCH6mM0Q9xLpGcQBICzOyNbDiWsZjXwhyiNty5A1ok3mfG0Xt2guhm9qdkHovM
         fzhBP066hh9suQs0onopBG+8qn/ubYW1UvM4hDE3j8ukDpW7XEp8IXsDtAKLBDIAZxSm
         RrOpnb0yEsm+oHK6ZIN2+JI9BvyLCpPMIVzNq7A5GoUcn7e4A7ZkP42Yd2Wdy5K1QZjh
         JYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761913895; x=1762518695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08fssheEH26ewL9xgSjQ1sFTztWWkCBjLlcECWJQBfM=;
        b=TRpq5FahvgNL36FgZqerkUH/uKotBnM9a3iYZvq7vDqGyRl4+OUUcgWGS/tlEpUPMo
         LnY5LCTYsKgSR/Q4h/xOPtYgQeJ5+5MKbskId6C3b0RLEdYwRdHad3dneX4x8rGYjLMY
         3HAJ0yWxBYqqyjgiHFIN60xBkL6OwSro+uzVaKDIMy5Tpsnl43MtTq1Xs8ei/1x8T7/u
         WW8a21tO1l3GDEGbbcBzh97A86I/YQqIu6X5tY6EJSQQ7WyaX8v3nBgMpRq7jea2HZB+
         gUYBpDIR/MSwb7fM5OF69ZQyXbf2jjgT79nR/5sexrFrFPDes91Xq6Lby7b1c+cbYeiP
         B6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX5gF71LHxNSfuBFO1BmvwhxbYo5z+Hz/+/DLBqMEjXskD1Opd1IRNsouXMeWSRzBFRpMmM/fmFGXeGCa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP43CZGyKmFhqIz5aPrGnIWxo/SuNRfZ7Cf8dYGAkY2dA2MKCd
	b8R1/omXJEaSYDzCqlt8Pj23rxPgNbu7Fpt4gPFtOutoRK6lj4JGxtEOQGi8sWftPcU=
X-Gm-Gg: ASbGnctsVzQx6T7LbEB+hVYlsAt13crZ5LWfOQK45ALUmH5PP0VD80/cWIr92ppdet9
	8KIvTIfsDHE3iJxITqgXAqlBm1vD6/7cRjE4r9qrp1gSGWhFW+auCx/XuZcuo69i7d9b+Oek02g
	T9rwyKujEE+ROd+0Ibvzn09i+dRaH0HGwztlxBatmJ1ZDus5iGrlonOZPEeKFX4VLg9ZmusU/JQ
	OQZb5894QckOvw7ZUMwETh35zkWLgd7CbpAzGUGA7pyLAazAFV/0vBeNkjWbIZO0oTlncAH0vs3
	K12gmLTlXHl+WBbH+wF8p7FSvDAvDG/HHcb8dXniBPcGdVmc2wSZRacVX7YGnYcvFKZbRAWhCTs
	SyBcIFmFRsFP2yn8mG+WdvMEeD7xPVQDlgomSUehs1CS1yaQVXWdbmt/ohfa+5ViudYi/Eb53oI
	Tdb/5JtjT/je0SR9JhZ/BgIXSbUik=
X-Google-Smtp-Source: AGHT+IFN1SIbYGYuHJIssflh634/zxs/aR+a86BEewospW9lCTe+InyrPCsK+oVBo1QTVBWURISFmw==
X-Received: by 2002:a05:6000:2288:b0:427:5cf:a284 with SMTP id ffacd0b85a97d-429bd6c2d51mr2705783f8f.60.1761913894379;
        Fri, 31 Oct 2025 05:31:34 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1406a45sm3333829f8f.47.2025.10.31.05.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 05:31:33 -0700 (PDT)
Message-ID: <08bc7f37-d2d7-4ad0-9575-f8a2c36b1c3f@ursulin.net>
Date: Fri, 31 Oct 2025 12:31:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: Fix deadlock in
 drm_sched_entity_kill_jobs_cb
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20251031090704.1111-1-pierre-eric.pelloux-prayer@amd.com>
 <411190d4-92d7-4e95-acac-b39afa438c0f@ursulin.net>
 <50f3743f-8b83-42de-87c8-1c7d52df3ab0@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <50f3743f-8b83-42de-87c8-1c7d52df3ab0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 31/10/2025 12:25, Christian König wrote:
> 
> 
> On 10/31/25 12:50, Tvrtko Ursulin wrote:
>>
>> On 31/10/2025 09:07, Pierre-Eric Pelloux-Prayer wrote:
>>> The Mesa issue referenced below pointed out a possible deadlock:
>>>
>>> [ 1231.611031]  Possible interrupt unsafe locking scenario:
>>>
>>> [ 1231.611033]        CPU0                    CPU1
>>> [ 1231.611034]        ----                    ----
>>> [ 1231.611035]   lock(&xa->xa_lock#17);
>>> [ 1231.611038]                                local_irq_disable();
>>> [ 1231.611039]                                lock(&fence->lock);
>>> [ 1231.611041]                                lock(&xa->xa_lock#17);
>>> [ 1231.611044]   <Interrupt>
>>> [ 1231.611045]     lock(&fence->lock);
>>> [ 1231.611047]
>>>                   *** DEADLOCK ***
>>>
>>> In this example, CPU0 would be any function accessing job->dependencies
>>> through the xa_* functions that doesn't disable interrupts (eg:
>>> drm_sched_job_add_dependency, drm_sched_entity_kill_jobs_cb).
>>>
>>> CPU1 is executing drm_sched_entity_kill_jobs_cb as a fence signalling
>>> callback so in an interrupt context. It will deadlock when trying to
>>> grab the xa_lock which is already held by CPU0.
>>>
>>> Replacing all xa_* usage by their xa_*_irq counterparts would fix
>>> this issue, but Christian pointed out another issue: dma_fence_signal
>>> takes fence.lock and so does dma_fence_add_callback.
>>>
>>>     dma_fence_signal() // locks f1.lock
>>>     -> drm_sched_entity_kill_jobs_cb()
>>>     -> foreach dependencies
>>>        -> dma_fence_add_callback() // locks f2.lock
>>>
>>> This will deadlock if f1 and f2 share the same spinlock.
>>
>> Is it possible to hit this case?
>>
>> Same lock means same execution timeline
> 
> Nope, exactly that is incorrect. It's completely up to the implementation what they use this lock for.

Yes, sorry, I got confused for a moment. The lock can be per hw 
scheduler while execution timeline is per entity.

Regards,

Tvrtko

> 
>> , which should mean dependency should have been squashed in drm_sched_job_add_dependency(), no?
> 
> This makes it less likely, but not impossible to trigger.
> 
> Regards,
> Christian.
> 
>>
>> Or would sharing the lock but not sharing the entity->fence_context be considered legal? It would be surprising at least.
>>
>> Also, would anyone have time to add a kunit test? ;)
>>
>> Regards,
>>
>> Tvrtko
>>
>>> To fix both issues, the code iterating on dependencies and re-arming them
>>> is moved out to drm_sched_entity_kill_jobs_work.
>>>
>>> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/13908
>>> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_entity.c | 34 +++++++++++++-----------
>>>    1 file changed, 19 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>>> index c8e949f4a568..fe174a4857be 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -173,26 +173,15 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>>>    }
>>>    EXPORT_SYMBOL(drm_sched_entity_error);
>>>    +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>> +                      struct dma_fence_cb *cb);
>>> +
>>>    static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
>>>    {
>>>        struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
>>> -
>>> -    drm_sched_fence_scheduled(job->s_fence, NULL);
>>> -    drm_sched_fence_finished(job->s_fence, -ESRCH);
>>> -    WARN_ON(job->s_fence->parent);
>>> -    job->sched->ops->free_job(job);
>>> -}
>>> -
>>> -/* Signal the scheduler finished fence when the entity in question is killed. */
>>> -static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>> -                      struct dma_fence_cb *cb)
>>> -{
>>> -    struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
>>> -                         finish_cb);
>>> +    struct dma_fence *f;
>>>        unsigned long index;
>>>    -    dma_fence_put(f);
>>> -
>>>        /* Wait for all dependencies to avoid data corruptions */
>>>        xa_for_each(&job->dependencies, index, f) {
>>>            struct drm_sched_fence *s_fence = to_drm_sched_fence(f);
>>> @@ -220,6 +209,21 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>>            dma_fence_put(f);
>>>        }
>>>    +    drm_sched_fence_scheduled(job->s_fence, NULL);
>>> +    drm_sched_fence_finished(job->s_fence, -ESRCH);
>>> +    WARN_ON(job->s_fence->parent);
>>> +    job->sched->ops->free_job(job);
>>> +}
>>> +
>>> +/* Signal the scheduler finished fence when the entity in question is killed. */
>>> +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>> +                      struct dma_fence_cb *cb)
>>> +{
>>> +    struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
>>> +                         finish_cb);
>>> +
>>> +    dma_fence_put(f);
>>> +
>>>        INIT_WORK(&job->work, drm_sched_entity_kill_jobs_work);
>>>        schedule_work(&job->work);
>>>    }
>>
> 


