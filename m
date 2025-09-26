Return-Path: <linux-kernel+bounces-833745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81744BA2EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6271C7A2720
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C721D3D2;
	Fri, 26 Sep 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="RgWmD1J0"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B610942
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875054; cv=none; b=IBey3RGFwjOOjWHZ2+iljRy9mNaNw8xg+I0E7TOKbVy8PxqWl21esFBiycconRlIsXBVq30zMoGE9Dz2uBtPlwlO2iU01Ip/XyJiIuSWIlQA1DA7b4i5+pFQD36rcsLYnzee2bnFFLfRsJ81wj12hL03VBDsq6U9b0trMM0v6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875054; c=relaxed/simple;
	bh=3q37OmqV+TAsTkBOCLiM5niHxmjoY0ncgRtWYvtIXOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhW/YpScEOX9u3rpaq5ZBXvDrNMX1gybrzd++nn6jpXx/TtoMw01oEgtWokgEGKjqOAHVp0CzTbi6m2W1wXSm4HbUJbQe8bQa5LVVLSPXJYA5o+1TK7fvMf2AG1gvVO1OhAy2KMNJ4cT1Rp/ESdamKrpZv2YSaGFtLeknD8Y5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=RgWmD1J0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1923338f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1758875051; x=1759479851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUD/8CRZzggBoLEA3Cnl2jWaOfaB/XHcGKtwCB0bD9U=;
        b=RgWmD1J0lWFQq21D5zmgqztPSlYz8hyuJ3ynB7OS3GACnRCQ0KYeRYY48CRVhObPYt
         AUb1m8XeSYTi0XE65UImLgHmogKbI8S/xaR3gSk3s90MeazSswQNGTjHXJXYx2hemsM5
         ETtfLG/dm/8ybBAwu3oljl2ws6ZFJaCUmM6bJIvCKA27RmS+GREHehyRyemAKuxtBz+7
         yyaiCDJkTOol8uerZbVpIOL45tm90ShAE9jFwRx8iy+cT+erUWBgd9kuzU9tfcPgj8GS
         LxXk3vwma35MOok61KHvWwEOvq3kCKD2xHxHIObneaZHNgiPs82zCVRLYhRGOnaIA9Je
         xHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875051; x=1759479851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUD/8CRZzggBoLEA3Cnl2jWaOfaB/XHcGKtwCB0bD9U=;
        b=lWL3sPanZ17LLiWyYmTme3fOp+0suokqb/IdrZ+D5g7L2+rINyIzm7tU/YA7qlXEuP
         2OpUrD7Kd9y4zOCOyTx4Rc2tSRPHP/PmodlEBbs/VOLXFnEY6KYsgHyjfABC0ZiUBxVS
         2viEx4HKJBkOCkTgjBlKQ36URruUlsJ59GiVlOQCIJYwi+r95btdzMqd4RSu1y+Vknbx
         Abfui3mx1EIi7+v4MjWBJYAolPyDib7+7HClpjn/ihFOsQB/zXG5wnWM9tR8E6JSquAY
         auWvGpahq5gDldvJUxAoS9/XlLIb8rgVb1Nm7EwzeSn5uD5Nn0QuSXb86MuiHjrNO6Vf
         XdWA==
X-Forwarded-Encrypted: i=1; AJvYcCWKPQxdM5X42zHR7BxMG/JyDQDyeRLpwGxLwjL4SzKLQDtI1l54yKHmTAtVpdWq3mSw8ZikOHsMvoL7ld8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+WSkzvlW4fG6mufts7wgQeOFvn/Y7tbMlmAJG8x8YE5ZvzTh
	VnNOzQl5ms8CLtEufL/YDqGKQ6eYZYEl5wFBkUnK+fhLPEO4VaDce0GSVQQQiYiURpE=
X-Gm-Gg: ASbGncvLFC6L1Pb2BAtLWBaAZEvLi4+XDmsN9ove+C3/eroT8UuHKTx71OsiZ0gyz27
	9/KKTZFPNsjI/5ql9UoJsvj/9i4Ux//Cq4fNyhHneUayiDS1URAwev+uWn9KNFjcKEZCifoaKUx
	dxFWLeNFICQEsXoNivSSwG+tqolM5O0bk9jvbn/K51/TbiS7RX6TEzubiuUYnpiNWeHES5Zc/tn
	skA2ZJocfI0L5q8YAMHDIqDflvyRo2JQIfUpMihJm6/FFFvb1d+J86wR0Y7ZkntJtWO2V1EYseC
	w0kD6fwuvs8HL6gH9n2fbW0icv0o9p+NCaNqr4up0S+1aIvjqEktfL73PHX2HROTmkC98rJq7un
	jw4f3pyOQpYRrOOqIsvmucf81ymmCJJA1Gd8T4xSyAPC4vQ==
X-Google-Smtp-Source: AGHT+IG8YwG9HrnLSH6VPVzo/IyxpaQEQKPMBPPWJSnyXSi9ksjE6toq2AR1AXEwtgR5IyEF+jGJag==
X-Received: by 2002:a05:6000:615:b0:3ee:f10c:6baa with SMTP id ffacd0b85a97d-40e4b850ab1mr5498435f8f.37.1758875050740;
        Fri, 26 Sep 2025 01:24:10 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2ff6sm5985729f8f.56.2025.09.26.01.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:24:09 -0700 (PDT)
Message-ID: <f5a7ceb4-2313-48b9-bf75-628e9ad91757@ursulin.net>
Date: Fri, 26 Sep 2025 09:24:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/sched: limit sched score update to jobs change
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Philipp Stanner <phasta@kernel.org>
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
 <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
 <abb776bc-5b13-4db7-9421-59259119b859@ursulin.net>
 <5183ed88-1634-42c2-9bd8-ed0e626f877b@damsy.net>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <5183ed88-1634-42c2-9bd8-ed0e626f877b@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 26/09/2025 09:20, Pierre-Eric Pelloux-Prayer wrote:
> Hi,
> 
> Le 01/09/2025 à 11:20, Tvrtko Ursulin a écrit :
>>
>>
>> + Tomeu and Oded
>>
>> On 22/08/2025 14:43, Pierre-Eric Pelloux-Prayer wrote:
>>> Currently, the scheduler score is incremented when a job is pushed to an
>>> entity and when an entity is attached to the scheduler.
>>>
>>> This leads to some bad scheduling decision where the score value is
>>> largely made of idle entities.
>>>
>>> For instance, a scenario with 2 schedulers and where 10 entities submit
>>> a single job, then do nothing, each scheduler will probably end up with
>>> a score of 5.
>>> Now, 5 userspace apps exit, so their entities will be dropped. In
>>> the worst case, these apps' entities where all attached to the same
>>> scheduler and we end up with score=5 (the 5 remaining entities) and
>>> score=0, despite the 2 schedulers being idle.
>>> When new entities show up, they will all select the second scheduler
>>> based on its low score value, instead of alternating between the 2.
>>>
>>> Some amdgpu rings depended on this feature, but the previous commit
>>> implemented the same thing in amdgpu directly so it can be safely
>>> removed from drm/sched.
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux- 
>>> prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/sched_main.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/ 
>>> drm/ scheduler/sched_main.c
>>> index 5a550fd76bf0..e6d232a8ec58 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -206,7 +206,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq 
>>> *rq,
>>>       if (!list_empty(&entity->list))
>>>           return;
>>> -    atomic_inc(rq->sched->score);
>>>       list_add_tail(&entity->list, &rq->entities);
>>>   }
>>> @@ -228,7 +227,6 @@ void drm_sched_rq_remove_entity(struct 
>>> drm_sched_rq *rq,
>>>       spin_lock(&rq->lock);
>>> -    atomic_dec(rq->sched->score);
>>>       list_del_init(&entity->list);
>>>       if (rq->current_entity == entity)
>>
>> LGTM.
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
> 
> Thanks.
> 
>> Only detail is, I did a revisit of the scheduler users and it looks 
>> like the new rocket driver is the only one other than amdgpu which 
>> passes a list of more than one scheduler to drm_sched_entity_init. I 
>> don't *think* it would be affected though. It would still pick the 
>> least loaded (based on active jobs) scheduler at job submit time. 
>> Unless there is some hidden behaviour in that driver where it would be 
>> important to consider number of entities too. Anyway, it would be good 
>> for rocket driver to double-check and ack.
>>
> 
> Tomeu, Oded: any concerns about this change?

Tomeu acked it in case you missed it:

https://lore.kernel.org/dri-devel/20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com/T/#m4efa0d69211b2bb378cfb302e459faa30e57f58c

Regards,

Tvrtko


