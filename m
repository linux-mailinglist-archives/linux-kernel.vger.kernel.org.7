Return-Path: <linux-kernel+bounces-609442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA9EA92244
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 18:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5060B189A0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924A5254871;
	Thu, 17 Apr 2025 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f68hHFSV"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628025485D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906117; cv=none; b=uHCfkJzpOSWBSbDFdlKb2JdqrP8QQqzX2miEu/Oj+ANsOU7Bn6iBPCgCy3oD7+TOGDZbkoUvpuSKmZD+Z7YYUK8UsYg+6mxfGGcUUp8NSDQE9PVpZuE+fFjGRdu3M55ilyd8qpU++GInoYVwlF+EC5fEZBE6Jz+RxnFdFuW8+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906117; c=relaxed/simple;
	bh=f8zZDWruHrcQGuKQ5HkTvcISSDRv2jhyHs7dosgfHEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It414FR7QcnOCNHCgqQjp3TQWP6CyyGgDVXnGNYtYtIdhcicLIimc7v5Eq2kOWX5WmWLXttmnnwn2CinXDrPLNmxhLp343yRxtzEO0mwdRQmC63hpALVtjdsZrTBpM09XSPlDV2zczi5vDyiqnKeoTZY7dOB/udEzQjYlAxkvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f68hHFSV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=guOC1EANmX1Zli2zwBi3sAECd7mZ2rkKhzb5e/7yiwM=; b=f68hHFSVUmeemdwLH+XOWRg5NS
	3rbqxpcIHat6AG8FT/e4kp4SywBoRq0B2Qt5ql2Wx3ESLFEGmgDn5kuhlUfxrxXsDxk4xWRYLf6T3
	8YmmDtXf3cuTEQqWkMP3NyzOquKp6irgscQlQQA9RtNuvndxdlttL8HrwF05MQJ1OF7x4knqPhPvo
	o0inba+0+lQFN16MfvCVbFIh+dkU6a0BEoJwopj0/qmO8JXxWEB2YjIAoZMRrpd6rF3werQIg8YWC
	pU/U9w/Bmyjm1Vz37CLm3lDk/00EU9KjLRxp0yPJcQsfqS75m24Xcya4aNnAfsW09UaSrZQXsJOIr
	XSHIbtLQ==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u5Rmf-000sOK-H7; Thu, 17 Apr 2025 18:08:13 +0200
Message-ID: <0e8313dc-b1bb-4ce7-b5b7-b8b3e027adb7@igalia.com>
Date: Thu, 17 Apr 2025 17:08:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/sched: Warn if pending list is not empty
To: Danilo Krummrich <dakr@kernel.org>
Cc: phasta@kernel.org, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250407152239.34429-2-phasta@kernel.org>
 <20250407152239.34429-5-phasta@kernel.org>
 <9607e5a54b8c5041dc7fc134425cc36c0c70b5f3.camel@mailbox.org>
 <3ac34c84-fd84-4598-96e1-239418b7109f@igalia.com> <aADv4ivXZoJpEA7k@pollux>
 <83758ca7-8ece-433e-b904-3d21690ead23@igalia.com>
 <aAEUwjzZ9w9xlKRY@cassiopeiae>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <aAEUwjzZ9w9xlKRY@cassiopeiae>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17/04/2025 15:48, Danilo Krummrich wrote:
> On Thu, Apr 17, 2025 at 03:20:44PM +0100, Tvrtko Ursulin wrote:
>>
>> On 17/04/2025 13:11, Danilo Krummrich wrote:
>>> On Thu, Apr 17, 2025 at 12:27:29PM +0100, Tvrtko Ursulin wrote:
>>>>
>>>> On 17/04/2025 08:45, Philipp Stanner wrote:
>>>>> On Mon, 2025-04-07 at 17:22 +0200, Philipp Stanner wrote:
>>>>
>>>> Problem exactly is that jobs can outlive the entities and the scheduler,
>>>> while some userspace may have a dma fence reference to the job via sync
>>>> file. This new callback would not solve it for xe, but if everything
>>>> required was reference counted it would.
>>>
>>> I think you're mixing up the job and the dma_fence here, if a job outlives the
>>> scheduler, it clearly is a bug, always has been.
>>>
>>> AFAIK, Xe reference counts it's driver specific job structures *and* the driver
>>> specific scheduler structure, such that drm_sched_fini() won't be called before
>>> all jobs have finished.
>>
>> Yes, sorry, dma fence. But it is not enough to postpone drm_sched_fini until
>> the job is not finished. Problem is exported dma fence holds the pointer to
>> drm_sched_fence (and so oopses in drm_sched_fence_get_timeline_name on
>> fence->sched->name) *after* job had finished and driver was free to tear
>> everything down.
> 
> Well, that's a bug in drm_sched_fence then and independent from the other topic.
> Once the finished fence in a struct drm_sched_fence has been signaled it must
> live independent of the scheduler.
> 
> The lifetime of the drm_sched_fence is entirely independent from the scheduler
> itself, as you correctly point out.

Connection (re. independent or not) I made was *if* drm_sched would be 
reference counted, would that satisfy both the requirement to keep 
working drm_sched_fence_get_timeline_name and to allow a different 
flavour of the memory leak fix.

I agree drm_sched_fence_get_timeline_name can also be fixed by removing 
the fence->sched dereference and losing the (pretty) name. Historically 
there has been a lot of trouble with those names so maybe that would be 
acceptable.

Revoking s_fence->sched on job completion as an alternative does not 
sound feasible.

To further complicate matters, I suspect rmmod gpu-sched.ko is also 
something which would break exported fences since that would remove the 
fence ops. But that is solvable by module_get/put().

> Starting to reference count things to keep the whole scheduler etc. alive as
> long as the drm_sched_fence lives is not the correct solution.

To catch up on why if you could dig out the links to past discussions it 
would be helpful.

I repeat how there is a lot of attractiveness to reference counting. 
Already mentioned memory leak, s_fence oops, and also not having to 
clear job->entity could be useful for things like tracking per entity 
submission stats (imagine CFS like scheduling, generic scheduling DRM 
cgroup controller). So it would be good for me to hear what pitfalls 
were identified in this space.

>>> Multiple solutions have been discussed already, e.g. just wait for the pending
>>> list to be empty, reference count the scheduler for every pending job. Those all
>>> had significant downsides, which I don't see with this proposal.
>>>
>>> I'm all for better ideas though -- what do you propose?
>>
>> I think we need to brainstorm both issues and see if there is a solution
>> which solves them both, with bonus points for being elegant.
> 
> The problems are not related. As mentioned above, once signaled a
> drm_sched_fence must not depend on the scheduler any longer.
> 
>>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>>>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>>>> index 6b72278c4b72..ae3152beca14 100644
>>>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>>>> @@ -1465,6 +1465,10 @@ void drm_sched_fini(struct drm_gpu_scheduler
>>>>>> *sched)
>>>>>>     	sched->ready = false;
>>>>>>     	kfree(sched->sched_rq);
>>>>>>     	sched->sched_rq = NULL;
>>>>>> +
>>>>>> +	if (!list_empty(&sched->pending_list))
>>>>>> +		dev_err(sched->dev, "%s: Tearing down scheduler
>>>>>> while jobs are pending!\n",
>>>>>> +			__func__);
>>>>
>>>> It isn't fair to add this error since it would out of the blue start firing
>>>> for everyone expect nouveau, no? Regardless if there is a leak or not.
>>>
>>> I think it is pretty fair to warn when detecting a guaranteed bug, no?
>>>
>>> If drm_sched_fini() is call while jobs are still on the pending_list, they won't
>>> ever be freed, because all workqueues are stopped.
>>
>> Is it a guaranteed bug for drivers are aware of the drm_sched_fini()
>> limitation and are cleaning up upon themselves?
> 
> How could a driver clean up on itself (unless the driver holds its own list of
> pending jobs)?
> 
> Once a job is in flight (i.e. it's on the pending_list) we must guarantee that
> free_job() is called by the scheduler, which it can't do if we call
> drm_sched_fini() before the pending_list is empty.
> 
>> In other words if you apply the series up to here would it trigger for
>> nouveau?
> 
> No, because nouveau does something very stupid, i.e. replicate the pending_list.

Ah okay I see it now, it waits for all jobs to finish before calling 
drm_sched_fini(). For some reason I did not think it was doing that 
given the cover letter starts with how that is a big no-no.

>> Reportedly it triggers for the mock scheduler which also has no
>> leak.
> 
> That sounds impossible. How do you ensure you do *not* leak memory when you tear
> down the scheduler while it still has pending jobs? Or in other words, who calls
> free_job() if not the scheduler itself?

Well the cover letter says it triggers so it is possible. :)

Mock scheduler also tracks the pending jobs itself, but different from 
nouveau it does not wait for jobs to finish and free worker to process 
them all, but having stopped the "hw" backend it cancels them and calls 
the free_job vfunc directly.

Going back to the topic of this series, if we go with a solution along 
the lines of the proposed, I wonder if it would be doable without 
mandating that drivers keep a list parallel to pending_list. Instead 
have a vfunc DRM scheduler would call to cancel job at a time from *its* 
pending list. It would go nicely together with prepare/run/timedout/free.

Would it allow getting rid of the new state machinery and just 
cancelling and freeing in one go directly from drm_sched_fini()?

Regards,

Tvrtko

>> Also, I asked in my initial reply if we have a list of which of the current
>> drivers suffer from memory leaks. Is it all or some etc.
> 
> Not all, but quite some I think. The last time I looked (which is about a year
> ago) amdgpu for instance could leak memory when you unbind the driver while
> enough jobs are in flight.


