Return-Path: <linux-kernel+bounces-795747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452FB3F754
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029B520776D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12232E7F02;
	Tue,  2 Sep 2025 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NbcPLt/k"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A782E7F01
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799985; cv=none; b=bn8Aax6RyI/MEkpwoj3Pts9rkkGDhdXODXCHM9JT1VEk8MshLQjdyGFEFg0j6qWuWkhCZSip3hp2Co1kJyNswhx64KCyajlBgqn/gqJbkg30wUNCfAurNbfpL55fC4txLGtmnmtug0WJ0a0zRrc80pcSQCnx0Y/3GPlZlsCJRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799985; c=relaxed/simple;
	bh=nbXYPQ/CA+UPJZzbO8zhgptVGHPVBpOhifvjH6jJ+IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfZXZDtxEx7umRXlF3JrgvuQR/6m99Ek5GkTsrUHvF7UctymT6ClcVAByYl3X0RNL+WYEEGpA8DknVekvA5+c4O5bq44YxC4xddxqL0MX+7HAQ4cwPh4myNry8YTVVL7kGtotsF+n5i+j7XjzrE/gy47iQqHdcRc9cdt4JluIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NbcPLt/k; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wJ61FIB/NmPV7dswnNYnMoUac/R593vmjpM+oAD5/gE=; b=NbcPLt/kcNxKZuGOZ1NxUhKfUy
	eyIJiAUbh0Pv9Y/rUPDndpT4OWbCOyeMxCJAZ/KpmJv4UBrrwSc0+bkPmQnfdPd6k8GVdgXL6SlqC
	X79vT0hJ+vkzbC0kGTthKy6DOgOUM7m6nkBjKhdiwLb2g4ZkwWoujfTVR1nK8CrIHVKjosbHPwQrl
	3t4qWtWQuneOdGgwDG5587KaY/kcqxzwdjXcYNN5Bl7MgfLeCDmtbZ9d7tqLSwe3fqoRE/oI98cRx
	P2rwl+gVYVyvMCYT3HYFaphqZJF6Mtogzmk71V+VTunFiI2J0ZIXyTqLgFKYMXLHGVTTvM0HbWt/8
	EsZgXyiA==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1utLvA-005bRr-Kw; Tue, 02 Sep 2025 09:59:16 +0200
Message-ID: <b9f7a493-5611-4450-a26a-10b03d1dc313@igalia.com>
Date: Tue, 2 Sep 2025 08:59:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: Fix racy access to
 drm_sched_entity.dependency
To: phasta@kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250901124032.1955-1-pierre-eric.pelloux-prayer@amd.com>
 <da59f28c7d8b3d83833aa0494b3b198335cf588f.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <da59f28c7d8b3d83833aa0494b3b198335cf588f.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/09/2025 08:27, Philipp Stanner wrote:
> On Mon, 2025-09-01 at 14:40 +0200, Pierre-Eric Pelloux-Prayer wrote:
>> The drm_sched_job_unschedulable trace point can access
>> entity->dependency after it was cleared by the callback
>> installed in drm_sched_entity_add_dependency_cb, causing:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000020
>> [...]
>> Workqueue: comp_1.1.0 drm_sched_run_job_work [gpu_sched]
>> RIP: 0010:trace_event_raw_event_drm_sched_job_unschedulable+0x70/0xd0 [gpu_sched]
>>
>> To fix this we either need to keep a reference to the fence before
>> setting up the callbacks, or move the trace_drm_sched_job_unschedulable
>> calls into drm_sched_entity_add_dependency_cb where they can be
>> done earlier.
>>
>> Fixes: 76d97c870f29 ("drm/sched: Trace dependencies for GPU jobs")
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Applied to drm-misc-next

Shouldn't it have been drm-misc-fixes?

Regards,

Tvrtko

>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 8867b95ab089..3d06f72531ba 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -391,7 +391,8 @@ EXPORT_SYMBOL(drm_sched_entity_set_priority);
>>    * Add a callback to the current dependency of the entity to wake up the
>>    * scheduler when the entity becomes available.
>>    */
>> -static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
>> +static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
>> +					       struct drm_sched_job *sched_job)
>>   {
>>   	struct drm_gpu_scheduler *sched = entity->rq->sched;
>>   	struct dma_fence *fence = entity->dependency;
>> @@ -421,6 +422,10 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
>>   		entity->dependency = fence;
>>   	}
>>   
>> +	if (trace_drm_sched_job_unschedulable_enabled() &&
>> +	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
>> +		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
>> +
>>   	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
>>   				    drm_sched_entity_wakeup))
>>   		return true;
>> @@ -461,10 +466,8 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>   
>>   	while ((entity->dependency =
>>   			drm_sched_job_dependency(sched_job, entity))) {
>> -		if (drm_sched_entity_add_dependency_cb(entity)) {
>> -			trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
>> +		if (drm_sched_entity_add_dependency_cb(entity, sched_job))
>>   			return NULL;
>> -		}
>>   	}
>>   
>>   	/* skip jobs from entity that marked guilty */
> 


