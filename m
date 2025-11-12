Return-Path: <linux-kernel+bounces-897297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6574DC528B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF90E4FC7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0230B338929;
	Wed, 12 Nov 2025 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="J7hgV/vM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F10328B73
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954703; cv=none; b=UAOvXtxapCzVGGNH6AwvnJEGfph/cUKFbw+Wc8Pt2cYipLUaOl7/8dy3cbGsqHmk86HocV00hE0VySGz6/JtL9PT5LmN6+xubuuayflbDc0IotdGH+JkjO8LFOcvSwb++L9gMRqQRghVAd2pqm3VMIiSEsDUT9U7Bkv6wdmLSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954703; c=relaxed/simple;
	bh=N9Ic65ImEH4X/1MrpWAA79WVZjpOb9FIUfY0l0yoqQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIc26MWzydxgVw2FOfnpR/aRjrYb5/8LRg5hbS8k+sZt2ftxy5xmPJjr6s3w0nDBCpxITDdYIac+CONib3MhHm1gzbbMEtDxV4lIQ3/Kkv521ocfhUnjIatvGQ+MUl22zN0qWMINUvio6GNC7JsK0kPa1Pw49fKeQb0UroBH0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=J7hgV/vM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47721743fd0so4806435e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762954699; x=1763559499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKVPli+vtTdPK0Wb1LRFV8iDiJCBNe0ca15Qkt46LAw=;
        b=J7hgV/vMiRYxWDYTguPXg21tDhPGBOy2QXk4Q4FkAZFLk+HR7D2cCUylQNIAxCS4hO
         Sr5P1eq8vT6pGy8vavFimzTrJzUmkp29sI26hzbdlaxzpDXRLp4kyk3qYmUduWjpF6qi
         8IOwCN5vRxZ7+xftc/jSddZ3ZMRkU0/DnqECI2WRGd9XQ4lyFVFDJRcvLHhC6XyMJ+Rb
         riADfD4saHgQi6osBNqk2LC/jolCYp1zMwNi54kma4AAcaY62JOrBVdbWzvX4cjtD4SK
         TpJrxgv4ay5MtkyfEFLcmYFr4O9mdB3mrm7mYvJV7pGqYibvRP7e12V4BDMuzx1IYfD3
         +QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762954699; x=1763559499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKVPli+vtTdPK0Wb1LRFV8iDiJCBNe0ca15Qkt46LAw=;
        b=D4c9DEg0BexyubSlau2E2iwxEjfmEXiJWDZJw/PUDE3XccN7mV02miv1I4llffyms5
         tdf7wwDHJkWVEgYUkuCf7Mwxk+8vqcfje7dB85FwKPPj8t187R4aOGVGOXkT0DePdpWP
         thC0nUSaqYvNB2DuEnwFXkDBe057+G3P4EGWP4a+v3xYNF0KnWd1dziWXKdt+NAOW57s
         ThFiiE8hAP+6h0voGZfB+GdI3pxls9giFf/1MkwkdAwXZYFOA+EeewaQRVi+ncZo0L34
         kUdPCU0wsedWSjBWbx1KC8yTkzZExeyrKhqhxx+p7soS8DsRINfTFr5Efi1wLqyO6bE3
         yWAA==
X-Forwarded-Encrypted: i=1; AJvYcCUF0H3LBq6b31dJeVzcYeuTD+gAL6D6ZdZoBQV5Y8Mdryg8DNZz96r1bkvkuGTvGGv/fEpZcUiVmRzWePo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMv9bp590lnGK7Ee3BVn2nhTVwTCUv9Ly/mWnQlRZ3FCF6qyt
	RaaITTCN6uC/I0uWid3vYX2uNB0nt+oD2RiiLWVLNxltpoIKqKoylhs50CYLz/lm72TPq8OW8NV
	Wi2qr
X-Gm-Gg: ASbGnct1k0D6vNfXHoD5FvDL4qMGt21KxuTIIx0mX2ThOa1Aqnjh28HBqLCZ6NB0SEP
	5mkM5l3fPQmjFIVcezIzX+vM7a9+kkFxqtdYK0E0APwGZ6MINHoVGJNl3ftkjzg2iufXYER5NHO
	sQcRzI1EoNnVYuHj/0+qup9sNAevEjf81oCAz7TSBgxZ3krbdF1qQHDeGryTp6reg57lUidtxZe
	z1Vy/WVZxkeEjRGh/0IM+cwsyEA70d6OcKXaStfh5sRSjsxJGf2y7ig9LmcbCJcFeZQ1oDAHNoM
	hBhpQ9xGdRRoI2sYmt8HDEsL7F8AS4cjKntkgk+5e1FmVoHbgaeOkhaNu8brU/G0IdeLApTBePp
	PWLOMeNlDzrqzhkDc/YCy284Kspw3SR1tGkfI/nSWwzwisZfVWOmTg3VBt8RxmJ3bsDR72RP++Z
	jtNMm80itESSBRQeEuXDn81A==
X-Google-Smtp-Source: AGHT+IHgmc5huq89+1MnpQMirmZYWR9B+FP7GHxP0enOBtoio6kTy/7iypYs8CCl2+rfT2RT9vY5dg==
X-Received: by 2002:a05:600c:1d1b:b0:477:63db:c0fe with SMTP id 5b1f17b1804b1-477871c3589mr32958135e9.32.1762954699196;
        Wed, 12 Nov 2025 05:38:19 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm35065075e9.12.2025.11.12.05.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:38:18 -0800 (PST)
Message-ID: <b7f66752-a80d-429e-9f00-c631b0490883@ursulin.net>
Date: Wed, 12 Nov 2025 13:38:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Document racy behavior of
 drm_sched_entity_push_job()
To: phasta@kernel.org, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251112073138.93355-2-phasta@kernel.org>
 <e9c02871-fa80-46c7-8b96-bad3a6a2c5b9@ursulin.net>
 <38bce31a7cdea31738c161bb06af272d5f68af1a.camel@mailbox.org>
 <babc3eae-42c2-4927-95db-7c529a282d6d@ursulin.net>
 <cd7f6684f1d8bfca606c4a6ba75c130d07e3a7fe.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <cd7f6684f1d8bfca606c4a6ba75c130d07e3a7fe.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/11/2025 13:31, Philipp Stanner wrote:
> On Wed, 2025-11-12 at 13:13 +0000, Tvrtko Ursulin wrote:
>>
>> On 12/11/2025 12:15, Philipp Stanner wrote:
>>> On Wed, 2025-11-12 at 09:42 +0000, Tvrtko Ursulin wrote:
>>>>
>>>> On 12/11/2025 07:31, Philipp Stanner wrote:
>>>>> drm_sched_entity_push_job() uses the unlocked spsc_queue. It takes a
>>>>> reference to that queue's tip at the start, and some time later removes
>>>>> that entry from that list, without locking or protection against
>>>>> preemption.
>>>>
>>>> I couldn't figure out what you refer to by tip reference at the start,
>>>> and later removes it. Are you talking about the top level view from
>>>> drm_sched_entity_push_job() or where exactly?
>>>>> This is by design, since the spsc_queue demands single producer and
>>>>> single consumer. It was, however, never documented.
>>>>>
>>>>> Document that you must not call drm_sched_entity_push_job() in parallel
>>>>> for the same entity.
>>>>>
>>>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>>>> ---
>>>>>     drivers/gpu/drm/scheduler/sched_entity.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> index 5a4697f636f2..b31e8d14aa20 100644
>>>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> @@ -562,6 +562,9 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>>>>>      * drm_sched_entity_push_job - Submit a job to the entity's job queue
>>>>>      * @sched_job: job to submit
>>>>>      *
>>>>> + * It is illegal to call this function in parallel, at least for jobs belonging
>>>>> + * to the same entity. Doing so leads to undefined behavior.
>>>>
>>>> One thing that is documented in the very next paragraph is that the
>>>> design implies a lock held between arm and push. At least to ensure
>>>> seqno order matches the queue order.
>>>>
>>>> I did not get what other breakage you found, but I also previously did
>>>> find something other than that. Hm.. if I could only remember what it
>>>> was. Probably mine was something involving drm_sched_entity_select_rq(),
>>>> drm_sched_entity_modify_sched() and (theoretical) multi-threaded
>>>> userspace submit on the same entity. Luckily it seems no one does that.
>>>>
>>>> The issue you found is separate and not theoretically fixed by this
>>>> hypothetical common lock held over arm and push?
>>>
>>> Well, if 2 CPUs should ever run in parallel in
>>> drm_sched_entity_push_job() the spsc_queue will just explode. Most
>>> notably, one CPU could get the job at the tip (the oldest job), then be
>>> preempted, and then another CPU takes the same job and pops it.
>>
>> Ah, you are talking about the dequeue/pop side. First paragraph of the
>> commit message can be clarified in that case.
>>
>> Pop is serialised by the worker so I don't think two simultaneous
>> dequeues on the same scheduler are possible. How did you trigger it?
>>> The API contract should be that the user doesn't have to know whether
>>> there's a linked list or the magic spsc_queue.Luckily we moved the peek/pop helpers to sched_internal.h.
>>
>> Btw I thought you gave up on the scheduler and are working on the simple
>> rust queue for firmware schedulers so how come you are finding subtle
>> bugs in this code?
> 
> I'm a maintainer still, for a variety of reasons. That we work on
> something for FW with a clean locking design doesn't mean we don't care
> about existing infrastructure anymore. And I firmly believe in
> documentation. People should know the rules from the API documentation,
> not from looking into the implementation.
> 
> It's kind of a crucial design info that you must only push into
> entities sequentially, no?
> 
> This doesn't fix a bug, obviously, since it's just a line of docu.
> Regardless, pushing into the spsc queue in parallel would explode.
> Emphasizing that costs as nothing.

It wasn't an argument. I was just curious if this is something you 
managed to hit and how.

Regards,

Tvrtko


