Return-Path: <linux-kernel+bounces-768766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A662B2653D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF6D583242
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602672FCBEA;
	Thu, 14 Aug 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZyN4Q/cR"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059E1F582A;
	Thu, 14 Aug 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173853; cv=none; b=m4MkbcHgwq4YXPPX5JBClMgfPIOcmGhJ/njzlDJw+ECpti4gHGVmTgDgjn0z4s2gCd9iVrYdoutPXanCTDcMmSdY0OET1nn572/HTwlEx6/ELmz8D49DM69PN66YncTVdyw+WyrdbyO0/g+6nw1U7frrnH1mJz+N5rOmeCdo8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173853; c=relaxed/simple;
	bh=GCI3UkzoLskNX9YAgNjPzxJEkiYHbWi5Zy1B0N1f9Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlUo5eIjH07esf4Xo9P1kD/29ZdhuPpNAygDkn0N99IsbHsJrK1DZ2SJvcmNiIndEySymXE0rKUhVAJhjHZwWjRHGqP+UKah/0vuN5NML96SGM6yexuuBRAuvDYsGovP3+lqLmiU7VISOtyijeVTySCNPI0jcrxTyXcE3kWzBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZyN4Q/cR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZOG76uaDp8U/rjuwq6QpgPB3jTygDtge7PgnECYfTCc=; b=ZyN4Q/cRDZ77eadd96PiRMVKH3
	F56CxSXoLuFtQmnocLtG8razLjjHnqMURESaHIqO4JCs2iDW0BEpQdRXf1mERV9HZmGPqc2VvUyyT
	2fzrmihDuEypkugKJZ3vPalu+RTpASZRTA2POsrZZRF0G6NRO/3HcaXmXXtx8J5iufHvWQb8zATF7
	IA1jpFNKWJynZQ0217VFo+15groR0ZNPFweSbVJTzV2nqmAlQC/glzs/na97Eh1jwh1eMPoRNBMna
	omFqSxKu0o3LklVK9oYGAEZjpVldV1Qreoa4lLEjQWyVx86Gmi6/tuOp4tOhDy029+IWj8vM0GDex
	mcHKBqcg==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1umWtO-00E6Rh-L4; Thu, 14 Aug 2025 14:17:14 +0200
Message-ID: <ba5ebb9d-4d56-445f-91bb-733c334a54a6@igalia.com>
Date: Thu, 14 Aug 2025 13:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Prevent stopped entities from being added to
 the run queue.
To: phasta@kernel.org, James Flowers <bold.zone2373@fastmail.com>,
 matthew.brost@intel.com, dakr@kernel.org, ckoenig.leichtzumerken@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, skhan@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250720235748.2798-1-bold.zone2373@fastmail.com>
 <66a14b005fa3dc874f4f3261b93901af1292bde9.camel@mailbox.org>
 <67c6a43a-a18b-4b5c-bb43-ba3aea2df05f@igalia.com>
 <0e5b8c8c-8faf-4167-b4a4-d35215c1d4d9@igalia.com>
 <7404e73561283f806456d1ecab92fbc17dfdd57a.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <7404e73561283f806456d1ecab92fbc17dfdd57a.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/08/2025 12:49, Philipp Stanner wrote:
> On Thu, 2025-08-14 at 12:45 +0100, Tvrtko Ursulin wrote:
>>
>> On 14/08/2025 11:42, Tvrtko Ursulin wrote:
>>>
>>> On 21/07/2025 08:52, Philipp Stanner wrote:
>>>> +Cc Tvrtko, who's currently reworking FIFO and RR.
>>>>
>>>> On Sun, 2025-07-20 at 16:56 -0700, James Flowers wrote:
>>>>> Fixes an issue where entities are added to the run queue in
>>>>> drm_sched_rq_update_fifo_locked after being killed, causing a
>>>>> slab-use-after-free error.
>>>>>
>>>>> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
>>>>> ---
>>>>> This issue was detected by syzkaller running on a Steam Deck OLED.
>>>>> Unfortunately I don't have a reproducer for it. I've
>>>>
>>>> Well, now that's kind of an issue – if you don't have a reproducer, how
>>>> can you know that your patch is correct? How can we?
>>>>
>>>> It would certainly be good to know what the fuzz testing framework
>>>> does.
>>>>
>>>>> included the KASAN reports below:
>>>>
>>>>
>>>> Anyways, KASAN reports look interesting. But those might be many
>>>> different issues. Again, would be good to know what the fuzzer has been
>>>> testing. Can you maybe split this fuzz test into sub-tests? I suspsect
>>>> those might be different faults.
>>>>
>>>>
>>>> Anyways, taking a first look…
>>>>
>>>>
> 
> 
> [SNIP]
> 
>>>>>
>>>>> ==================================================================
>>>>
>>>> If this is a race, then this patch here is broken, too, because you're
>>>> checking the 'stopped' boolean as the callers of that function do, too
>>>> – just later. :O
>>>>
>>>> Could still race, just less likely.
>>>>
>>>> The proper way to fix it would then be to address the issue where the
>>>> locking is supposed to happen. Let's look at, for example,
>>>> drm_sched_entity_push_job():
>>>>
>>>>
>>>> void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>>>> {
>>>>      (Bla bla bla)
>>>>
>>>>        …………
>>>>
>>>>      /* first job wakes up scheduler */
>>>>      if (first) {
>>>>          struct drm_gpu_scheduler *sched;
>>>>          struct drm_sched_rq *rq;
>>>>
>>>>          /* Add the entity to the run queue */
>>>>          spin_lock(&entity->lock);
>>>>          if (entity->stopped) {                  <---- Aha!
>>>>              spin_unlock(&entity->lock);
>>>>
>>>>              DRM_ERROR("Trying to push to a killed entity\n");
>>>>              return;
>>>>          }
>>>>
>>>>          rq = entity->rq;
>>>>          sched = rq->sched;
>>>>
>>>>          spin_lock(&rq->lock);
>>>>          drm_sched_rq_add_entity(rq, entity);
>>>>
>>>>          if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
>>>>              drm_sched_rq_update_fifo_locked(entity, rq, submit_ts);
>>>> <---- bumm!
>>>>
>>>>          spin_unlock(&rq->lock);
>>>>          spin_unlock(&entity->lock);
>>>>
>>>> But the locks are still being hold. So that "shouldn't be happening"(tm).
>>>>
>>>> Interesting. AFAICS only drm_sched_entity_kill() and drm_sched_fini()
>>>> stop entities. The former holds appropriate locks, but drm_sched_fini()
>>>> doesn't. So that looks like a hot candidate to me. Opinions?
>>>>
>>>> On the other hand, aren't drivers prohibited from calling
>>>> drm_sched_entity_push_job() after calling drm_sched_fini()? If the
>>>> fuzzer does that, then it's not the scheduler's fault.
>>>>
>>>> Could you test adding spin_lock(&entity->lock) to drm_sched_fini()?
>>>>
>>>> Would be cool if Tvrtko and Christian take a look. Maybe we even have a
>>>> fundamental design issue.
>>>
>>> It would be nice to have a reproducer and from this thread I did not
>>> manage to figure out if the syzkaller snipper James posted was it, or
>>> not quite it.
>>>
>>> In either case, I think one race I see relates to the early exit !
>>> entity->rq check before setting entity->stopped in drm_sched_entity_kill().
>>>
>>> If the entity was not submitted at all yet (at the time of process
>>> exit / entity kill), entity->stopped will therefore not be set. A
>>> parallel job submit can then re-add the entity to the tree, as process
>>> exit / file close / entity kill is continuing and is about to kfree the
>>> entity (in the case of amdgpu report there are two entities embedded in
>>> file_priv).
>>>
>>> One way to make this more robust is to make the entity->rq check in
>>> drm_sched_entity_kill() stronger. Or actually to remove it altogether.
>>> But I think it also requires checking for entity->stopped in
>>> drm_sched_entity_select_rq() and propagating the error code all the way
>>> out from drm_sched_job_arm().
>>>
>>> That was entity->stopped is properly serialized and acted upon early
>>> enough to avoid dereferencing a freed entity and avoid creating jobs not
>>> attached to anything (but only have a warning from push job).
>>>
>>> Disclaimer I haven't tried to experiment with this yet, so I may be
>>> missing something. At least writing a reproducer for the race I
>>> described sounds easy so unless someone shouts I am talking nonsense I
>>> can do that and also sketch out a fix. *If* the theory will hold water
>>> after I write the test case.
>>
>> Nah I was talking nonsense. Forgot entity->rq is assigned on entity init
>> and jobs cannot be created unless it is set.
>>
>> Okay, I have no theories as to what bug syzkaller found.
> 
> I just was about to answer.
> 
> I agree that the rq check should be fine.
> 
> As you can see in the thread, I suspect that this is a race between
> drm_sched_entity_push_job() and drm_sched_fini().
> 
> See here:
> https://lore.kernel.org/dri-devel/20250813085654.102504-2-phasta@kernel.org/

Yeah I read it.

Problem with the amdgpu angle and this KASAN report is that to me it 
looked the UAF is about the two VM update entities embedded in struct 
file priv. And the schedulers used to initialize those are not torn down 
until driver unload. So I didn't think syzkaller would have hit that and 
was looking for alternative ideas.

Regards,

Tvrtko

> I think as long as there's no reproducer there is not much to do for us
> here. A long term goal, though, is to enforce the life time rules.
> Entities must be torn down before their scheduler. Checking this for
> all drivers will be quite some work, though..
> 
> 
> P.
> 
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>
>>>>
>>>>>    }
>>>>>    /**
>>>>
>>>
>>
> 


