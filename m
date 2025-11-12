Return-Path: <linux-kernel+bounces-897268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE5C526AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5811B189F93B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E9330B30;
	Wed, 12 Nov 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="i8nRawnJ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22E3043B4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953213; cv=none; b=RelJkVbBNLwSJs3DmIYleHXeME0nSMv7zVKIle/cQE6VCFYTckEtVkB/kMC4Q77G/pV78CWl4K7D1kh9SATWg4sdI5cvrY3mVrR1kSD39n01/xME1K3zby5skZ2vSCfrdunVRPPfkxA/e1uQia9m8hWo8jH7MIztPl16n3nJ4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953213; c=relaxed/simple;
	bh=xv+HDrqNjCfDpEzKer0vKgP20oT/DUThaubwP7TL4Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRRu27OV8gDSQCcz/gFXYsGPUsdfthUxJh2ybp7ROGD1xU3AipQSNGmhhDIlhnUjTemFKDrd0TxRua3v1N1HWvCwQ8TV7Mwe+2NSqHf7RWvqHWzdkaJjIvqxhcdwmpj9WzSvhE1Iq5lxNIAi1/QybZTBdiXlXgJDjABz5OKldxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=i8nRawnJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso1188741a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762953210; x=1763558010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sscEB4nn6s951AWLMLIUM6KOhyDA4FhYMtvx1jB70o=;
        b=i8nRawnJ/b3YgCzlUUeliIMB3/AGKh61Fxjq50NLCDXnvO/X3RoPmXFUWPwsUZKYBH
         epXx+XrRKiUzaYAPZ7TEfdWB+lwi4FYx1OJZ0/+/nRj4hb2RtNAQ5HMxfGiTlrVWff8L
         PEv67lRdD59J9xzdnu1l+SUGhCIqtZd3tEqYFxFO3hTH29SNlmM5vqK8IkEuhR7eDb/V
         Lm5Kq900LXBRGFxqyr78uI8+aY/sHod3tbiPRtb/5GTz+p1BLr6yzu6RhWquszngqc+e
         OPuDW3Nk6/9Mw2yAbmpe8VOabEZwIV83YH4+8sAp/N1ngNmDjpUnQaX2IO3NUxoHffv5
         n+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762953210; x=1763558010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sscEB4nn6s951AWLMLIUM6KOhyDA4FhYMtvx1jB70o=;
        b=CR3McaZC8WX1edi11tX7eO1N7cP7whQhtHT4b16n17P0VwwyfcpkHTDUIr7abySoWH
         3D7TWzyJlzfQi5jbA7zh7LxPt8OjhRt1+f95/NHQPAN/nPgxftr0308ZKuecbb0MbHgb
         8Ha9j7X6XTgnHIFvOhsSVeL8xpyprTWRw0ik6METfAgCBOGeLSv+iHo3/9EvcxFErnS3
         DN1f3t5udiw2Q2AjzSwHFlEKpnWuFTybIzKik7qBkhBDR6/VHJkcejaqXocSTo4zhs36
         vKEXtECKr5FI3d2P9REC1ou+QzI974KLPk547XLhE8FCbIG7fIHv+l2my9uDY03x3TuV
         nmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfhX2fsJyHjdGMDYiboN2ispzIxZ88kLkrOYAl1opl1SNjopPi5b1YZex3mfroGhMFhOheWkG9k6JHP4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SPevN31gu1unwmn7Z9STDdAsYhZOc6xkKpc9i2SvFD6xvtwo
	KpchucJ0fFu6MtO3i8jeNmJVb55cJDh2MWQQvkArJ32rINir1yWwZu3OiLznY4rZ+q4=
X-Gm-Gg: ASbGncvyFesEpYEQZy0Hp/nsENzzUv1WeygC8kCIE7luf3jJzuwEpQMwtjsaUzOrl2K
	BXwc8wXKANOpEq8H8T6F0JCNDFhExDxNgxLMHHy+AxPij5yHn0oMrsKkfrTcsSi8RZcVW+vidKH
	HHONqBWWzJKvuH66nY8JWqAtK77qTmdZYguqnH+MbNS6XKlJ1+hh0fiC7U0BVmbDzaxa2OsLtjo
	aKcFF9RsNM5gxVuSscegzkmeBPbycNGXSVM1l68Bi1YcbIv9kXgh5Q9kqxMHP5BF3wPrunW5rVN
	8YzTNCQYh67omPB8UA5EGajLDVuHBEUFndmHqIFypxWntiiXveuHJuBXE+1sx50tcyhu/BpQHsd
	ylkx3Y2EieZ7P39W7dfxgZs8aMKCRaIFe1lCJs/kLJ6CMNWZTSB2aNN7Kj2zx2u6K+mMCLS/gPP
	E26wgfpJ8eMVr1AesJ1Q/jcg==
X-Google-Smtp-Source: AGHT+IEYmb0xpxTgER0fYsWuK5Jn1jwPhMsmXBG2RWR+GhDMuJu/wWFLRCIrfC34cKO4pe7gQRrGUg==
X-Received: by 2002:a17:906:fc02:b0:b73:4054:dc76 with SMTP id a640c23a62f3a-b734054ddbemr19909966b.26.1762953209514;
        Wed, 12 Nov 2025 05:13:29 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf31286esm1594370566b.21.2025.11.12.05.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:13:29 -0800 (PST)
Message-ID: <babc3eae-42c2-4927-95db-7c529a282d6d@ursulin.net>
Date: Wed, 12 Nov 2025 13:13:28 +0000
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
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <38bce31a7cdea31738c161bb06af272d5f68af1a.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/11/2025 12:15, Philipp Stanner wrote:
> On Wed, 2025-11-12 at 09:42 +0000, Tvrtko Ursulin wrote:
>>
>> On 12/11/2025 07:31, Philipp Stanner wrote:
>>> drm_sched_entity_push_job() uses the unlocked spsc_queue. It takes a
>>> reference to that queue's tip at the start, and some time later removes
>>> that entry from that list, without locking or protection against
>>> preemption.
>>
>> I couldn't figure out what you refer to by tip reference at the start,
>> and later removes it. Are you talking about the top level view from
>> drm_sched_entity_push_job() or where exactly?
>>> This is by design, since the spsc_queue demands single producer and
>>> single consumer. It was, however, never documented.
>>>
>>> Document that you must not call drm_sched_entity_push_job() in parallel
>>> for the same entity.
>>>
>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_entity.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>>> index 5a4697f636f2..b31e8d14aa20 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -562,6 +562,9 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>>>     * drm_sched_entity_push_job - Submit a job to the entity's job queue
>>>     * @sched_job: job to submit
>>>     *
>>> + * It is illegal to call this function in parallel, at least for jobs belonging
>>> + * to the same entity. Doing so leads to undefined behavior.
>>
>> One thing that is documented in the very next paragraph is that the
>> design implies a lock held between arm and push. At least to ensure
>> seqno order matches the queue order.
>>
>> I did not get what other breakage you found, but I also previously did
>> find something other than that. Hm.. if I could only remember what it
>> was. Probably mine was something involving drm_sched_entity_select_rq(),
>> drm_sched_entity_modify_sched() and (theoretical) multi-threaded
>> userspace submit on the same entity. Luckily it seems no one does that.
>>
>> The issue you found is separate and not theoretically fixed by this
>> hypothetical common lock held over arm and push?
> 
> Well, if 2 CPUs should ever run in parallel in
> drm_sched_entity_push_job() the spsc_queue will just explode. Most
> notably, one CPU could get the job at the tip (the oldest job), then be
> preempted, and then another CPU takes the same job and pops it.

Ah, you are talking about the dequeue/pop side. First paragraph of the 
commit message can be clarified in that case.

Pop is serialised by the worker so I don't think two simultaneous 
dequeues on the same scheduler are possible. How did you trigger it?
> The API contract should be that the user doesn't have to know whether
> there's a linked list or the magic spsc_queue.Luckily we moved the peek/pop helpers to sched_internal.h.

Btw I thought you gave up on the scheduler and are working on the simple 
rust queue for firmware schedulers so how come you are finding subtle 
bugs in this code?

> The entire entity submission pattern is basically designed around
> "single producer [per entity]", and that's not very well documented.
> 
> I don't think the common lock comment fully addresses that, because
> it's merely about the sequence numbers. I think the common lock should
> likely prevent any issues, but I feel more comfortable if the user gets
> informed explicitly about the potential racyness of this function.
> 
> Maybe we can combine the two paragraphs.
Yeah, in some way.

Tvrtko


