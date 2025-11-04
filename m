Return-Path: <linux-kernel+bounces-885048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0435C31D33
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01442189C126
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4652258ED5;
	Tue,  4 Nov 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="fbMo2WAo";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="B/j8Nngl"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADF215F42;
	Tue,  4 Nov 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269889; cv=none; b=YQzwduRyIGu8x3u3jr4GLTIx8qvY0jiiSSCkNOXT4rAnvZbBG0rFkX8XoqQZknL90H8/bsFin24Iw1JqjGB6EiPsWxaiHlaQORGiAk79ZMstxJxHn6uICrfuHOYlghrL9C5qiNhC8pUkhYEToHVGP3LH26MW69rLjM0dqvxVhwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269889; c=relaxed/simple;
	bh=h/sQ5sjkpNGwHLN8MFhWgxjYYkMM9SNpSbQY9pfKcL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKUVaeQjR5R3IAgr/NCIP6iNgcj5wUi/VeYiI14iqPz8wiTAAstWH1zhjoqJLt63zNFYtK1Exz2Lr+jLr//6fe+244ua6P5dblrtpyGQPXhZBoloFy9TrgL5V2fqLQKGQR3URwn4mnAzlLdCllqwO9qkk0ySOGhqMAreKgNm8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=fbMo2WAo; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=B/j8Nngl; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762269846; bh=Md3JXufxJqYTYDD+0LVVo5S
	jqxZHasmKDqpehjHw5dk=; b=fbMo2WAoOTSO/uU6bDOvUwhinhZTOHOaW/et4qJ8N6hq9rRgKL
	jJFDT46tFLjhEuxBQefWD+yVfJ8T2nwnZ5+kxPrEg6FNsfeHcIpdgM7x2BJNnHD/42lusVxeiEN
	xzGmoE1VirB7YKn19rKchyDTu9lM91XLEXwrQeSZ0h/NT3WDluxtwO3/guL+CkqFHfEIDXFnG85
	fqAZgqiIKq+Hv+NlhrT9O7zY+wLq9XeqetWUWps4gswIkMutfeQHhPr7TI0KQwA2NcEi2hQ/kNz
	dIk1iZ8DXibbbYdYKwMIBUjz9MhaW8Ir7/SopS/NOzc1LfzDpjn7bTCvfsMLfYcjjHg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762269846; bh=Md3JXufxJqYTYDD+0LVVo5S
	jqxZHasmKDqpehjHw5dk=; b=B/j8NnglB5dEWa4XIPmntCOh5fE1cR/Z/+Peyo/fB/Qv9AQ3+r
	Nb544jcRoJoMx3GlaVRGbghxkz3rY8QrQ8AQ==;
Message-ID: <c1da66b4-3b71-4d83-8e8e-56151030b691@damsy.net>
Date: Tue, 4 Nov 2025 16:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/sched: Fix deadlock in
 drm_sched_entity_kill_jobs_cb
To: phasta@kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Luben Tuikov <luben.tuikov@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20251104095358.15092-1-pierre-eric.pelloux-prayer@amd.com>
 <628cdf3a0c5b783c09fe2a40aca4a4a48c614e66.camel@mailbox.org>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <628cdf3a0c5b783c09fe2a40aca4a4a48c614e66.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/11/2025 à 13:43, Philipp Stanner a écrit :
> On Tue, 2025-11-04 at 10:53 +0100, Pierre-Eric Pelloux-Prayer wrote:
>> The Mesa issue referenced below pointed out a possible deadlock:
>>
>> [ 1231.611031]  Possible interrupt unsafe locking scenario:
>>
>> [ 1231.611033]        CPU0                    CPU1
>> [ 1231.611034]        ----                    ----
>> [ 1231.611035]   lock(&xa->xa_lock#17);
>> [ 1231.611038]                                local_irq_disable();
>> [ 1231.611039]                                lock(&fence->lock);
>> [ 1231.611041]                                lock(&xa->xa_lock#17);
>> [ 1231.611044]   <Interrupt>
>> [ 1231.611045]     lock(&fence->lock);
>> [ 1231.611047]
>>                  *** DEADLOCK ***
>>
>> In this example, CPU0 would be any function accessing job->dependencies
>> through the xa_* functions that doesn't disable interrupts (eg:
>> drm_sched_job_add_dependency, drm_sched_entity_kill_jobs_cb).
>>
>> CPU1 is executing drm_sched_entity_kill_jobs_cb as a fence signalling
>> callback so in an interrupt context. It will deadlock when trying to
>> grab the xa_lock which is already held by CPU0.
>>
>> Replacing all xa_* usage by their xa_*_irq counterparts would fix
>> this issue, but Christian pointed out another issue: dma_fence_signal
>> takes fence.lock and so does dma_fence_add_callback.
>>
>>    dma_fence_signal() // locks f1.lock
>>    -> drm_sched_entity_kill_jobs_cb()
>>    -> foreach dependencies
>>       -> dma_fence_add_callback() // locks f2.lock
>>
>> This will deadlock if f1 and f2 share the same spinlock.
>>
>> To fix both issues, the code iterating on dependencies and re-arming them
>> is moved out to drm_sched_entity_kill_jobs_work.
>>
>> v2: reworded commit message (Philipp)
>> v3: added Fixes tag (Philipp)
> 
> Thx for the update.
> In the future please put the changelog below between a pair of '---'
> 
> ---
> v2: …
> v3: …
> ---

OK.

> 
> Some things I have unfortunately overlooked below.
> 
>>
>> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
> 
> We should +Cc stable. It's a deadlock after all.

OK.

> 
>> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/13908
>> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c | 34 +++++++++++++-----------
>>   1 file changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index c8e949f4a568..fe174a4857be 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -173,26 +173,15 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>>   }
>>   EXPORT_SYMBOL(drm_sched_entity_error);
>>   
>> +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>> +					  struct dma_fence_cb *cb);
> 
> It's far better to move the function up instead. Can you do that?

Since drm_sched_entity_kill_jobs_cb uses drm_sched_entity_kill_jobs and vice 
versa, I'll have to forward declare one of the 2 functions anyway.


> 
>> +
>>
> 
> […]
> 
>> +/* Signal the scheduler finished fence when the entity in question is killed. */
>> +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>> +					  struct dma_fence_cb *cb)
>> +{
>> +	struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
>> +						 finish_cb);
>> +
>> +	dma_fence_put(f);
> 
> It would be great if we knew what fence is being dropped here and why.
> I know you're just moving the pre-existing code, but if you should
> know, informing about that via comment would be great.
> 

As discussed offline, "f" is simply the fence being signaled, I'm not sure it 
warrants a comment.

Regards,
Pierre-Eric

> Optional.
> 
> 
> Rest of the code looks good. No further objections.
> 
> 
> P.


