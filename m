Return-Path: <linux-kernel+bounces-728487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443AB028D8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378074A26F8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413387263F;
	Sat, 12 Jul 2025 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIkQrvFV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C12AE6A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752284900; cv=none; b=L4YZQNmTJFLXNn8pasaOa4ZUaa90d2Acb4+q/nBqeCdldRd6hIxDdtz+ZmzxZDUrOrJRdzyVFGWWBJwUFkN8NjLhXYFkbUt421tPs5eCI04KxnvmRsyHENJV0bcf6YVtYOoZrEpNRb5GLLhdtxj0ubv5MnOi/rmPbTon0QY8n8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752284900; c=relaxed/simple;
	bh=n8SG5cqHDayMwgIC2vrhAw7liIyfBOSEXXtpSS3pq6w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cEqpmvTDs2t7ZzaPps597E8dinUK/7Y6PbpHW8S+KmhXkgi0iNm/F+hIW7xiUY15UHaUyTI+3dpTRwNVCbOK84LZ27aJWWIPxoFnI/bywVIChq3V8wRV721pm2Atw3A3pVYEwaDjYk/z5MLJa/a/b2vilgRUgadkA7b2FP4x0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIkQrvFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752284896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxAwedzZqv67NYTZQJhKk8dVKif/YGLdtab1W/v1f7w=;
	b=JIkQrvFVLi0BScXQrwp6Q6o7AORmqteKcbHUstUj9Q2RD45e/xhxUBpqPineo4xCIr0jBW
	gVcv6heMwSECHRn2rd2nr7LZzfPxkndDth9HwNwKfixNPlj/BRh+OSkLZgbrPgJ7aVCF8/
	LZyPt+ftIngnIqMx/5u3HGG50oJTZJc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ocoOkPdQPHyNC9WA6p8yyQ-1; Fri, 11 Jul 2025 21:48:15 -0400
X-MC-Unique: ocoOkPdQPHyNC9WA6p8yyQ-1
X-Mimecast-MFC-AGG-ID: ocoOkPdQPHyNC9WA6p8yyQ_1752284895
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fab979413fso45760726d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752284895; x=1752889695;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxAwedzZqv67NYTZQJhKk8dVKif/YGLdtab1W/v1f7w=;
        b=G8a830r3iFQeplt2n+//Vha6/OIMK3YV+yF7liqgzZ3WLIP1xBn9fWlXpqq0ZMyUph
         XMfUjBhq0xNNkuo6YMkZrng/nxfWZXm9qD8Ylp6s3+wkdjRCJQbKXhZjSg8jbsfgYV30
         dyIzww644QvzSEZE0qPH8l86R8kte7lXXY6PKsyMsa1PTsedUYikG4LhR6NVj7DPSBe4
         8Si4lBt1stwJT6rOJ5clvJKUEFO5BK/HwIyl9hCLeabl8iUY1NVoSfZ7ae0cWLYR57t+
         +tCYXRnuFzle1Cr3hBEIuF4Wa7vB+lr3DuW1Opx1zqlAKQptWvtsqv+xT/Xug7E0aRIP
         2nnw==
X-Forwarded-Encrypted: i=1; AJvYcCUh23S3p/eFTpb/25qBDRbVrGLEniJIAn/z6dTR+2WCh7GUzRb7NdTsj/s1FhGA9t4arvFCUoUYZsA5j50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIPYtp1IJaon0ZJ2MJwpGjTWFOGLgZgImib14HTEI8WLQNBmX
	NPXluZcFhRHUceGBdg0QroL4oxj6lnSV/zfaSpiEiB0s7HlHDdDEUwz7R3SD9NLfsQTW+EHMTjJ
	O33qNOw8ees7tnfDvEkwzvCVUSak9qO/SscNWD6tU/J5EipC8I7Ixt/4+vehV4fo1xw==
X-Gm-Gg: ASbGncuQ8qppNSxzMdBqsWG+SCARh5vAXhX42ni5K0Xie+jG7LQG0GXNInUO5dlaAez
	kh18HmSsu6q2bsi4bMXolc2UKfdLJgYJS3XN0CDrxjJOmrOBXaHk7zcoN7NG8Plp644c8cRqaWp
	OGf3gaZlVqv9HT/cRg0JWsGbNeLlfhW0NoaJyWtrTcq7PoGSNRgd9s3AQM07eYgzTSROCjIy/u5
	cy335EtbYPpmxXhDFvpjesXZN45Vblrzzyu4hAb3l6mhzodpsH8tjJpOnaTQA9RnwDtv5LFFktV
	zhNgNWMPLbqQqdQiMahXAhvms/2+hrw42pbBCq+dkjx+5dCqUE8UYcs8uZQ1LOMDELEyhta0gdX
	fMD+qZ96+4Q==
X-Received: by 2002:a05:6214:21ac:b0:6fa:cc39:68 with SMTP id 6a1803df08f44-704a35dce21mr100217376d6.15.1752284894743;
        Fri, 11 Jul 2025 18:48:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbJMRQN9f7V+UIy49PZhU+gHqzpBGl16s23hhqMVDWwM2SxfHN6vNKZMLsth4ZGda4h5m0eQ==
X-Received: by 2002:a05:6214:21ac:b0:6fa:cc39:68 with SMTP id 6a1803df08f44-704a35dce21mr100217136d6.15.1752284894422;
        Fri, 11 Jul 2025 18:48:14 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799e463sm25661876d6.21.2025.07.11.18.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 18:48:13 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <00fdac3e-092d-46f0-bbe7-6067c0f22eeb@redhat.com>
Date: Fri, 11 Jul 2025 21:48:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
To: Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20250709193910.151497-1-longman@redhat.com>
 <aHGONjuRiA3KfH1q@tardis-2.local>
 <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
 <aHGeF7ko_4uXHUgl@tardis-2.local>
 <e88452ed-411b-419e-a41d-0ff98d54a59b@redhat.com>
Content-Language: en-US
In-Reply-To: <e88452ed-411b-419e-a41d-0ff98d54a59b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/25 8:42 PM, Waiman Long wrote:
>
> On 7/11/25 7:28 PM, Boqun Feng wrote:
>> On Fri, Jul 11, 2025 at 03:30:05PM -0700, Linus Torvalds wrote:
>>> On Fri, 11 Jul 2025 at 15:20, Boqun Feng <boqun.feng@gmail.com> wrote:
>>>> Meta question: are we able to construct a case that shows this can 
>>>> help
>>>> detect the issue?
>>> Well, the thing that triggered this was hopefully fixed by
>>> 8c2e52ebbe88 ("eventpoll: don't decrement ep refcount while still
>>> holding the ep mutex"), but I think Jann figured that one out by code
>>> inspection.
>>>
>>> I doubt it can be triggered in real life without something like
>>> Waiman's patch, but *with* Waiman's patch, and commit 8c2e52ebbe88
>>> reverted (and obviously with CONFIG_KASAN and CONFIG_DEBUG_MUTEXES
>>> enabled), doing lots of concurrent epoll closes would hopefully then
>>> trigger the warning.
>>>
>>> Of course, to then find *other* potential bugs would be the whole
>>> point, and some of these kinds of bugs are definitely of the kind
>>> where the race condition doesn't actually trigger in any real load,
>>> because it's unlikely that real loads end up doing that kind of
>>> "release all these objects concurrently".
>>>
>>> But it might be interesting to try that "can you even recreate the bug
>>> fixed by 8c2e52ebbe88" with this. Because if that one *known* bug
>>> can't be found by this, then it's obviously unlikely to help find
>>> others.
>>>
>> Yeah, I guess I asked the question because there is no clear link from
>> the bug scenario to an extra context switch, that is, even if the
>> context switch didn't happen, the bug would trigger if
>> __mutex_unlock_slowpath() took too long after giving the ownership to
>> someone else. So my instinct was: would cond_resched() be slow enough
>> ;-)
>>
>> But I agree it's a trivel thing to do, and I think another thing we can
>> do is adding a kasan_check_byte(lock) at the end of
>> __mutex_unlock_slowpath(), because conceptually the mutex should be
>> valid throughout the whole __mutex_unlock_slowpath() function, i.e.
>>
>>     void __mutex_unlock_slowpath(...)
>>     {
>>         ...
>>         raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, 
>> &wake_q);
>>         // <- conceptually "lock" should still be valid here.
>>         // so if anyone free the memory of the mutex, it's going
>>         // to be a problem.
>>         kasan_check_byte(lock);
>>     }
>>
>> I think this may also give us a good chance of finding more bugs, one of
>> the reasons is that raw_spin_unlock_irqrestore_wake() has a
>> preempt_enable() at last, which may trigger a context switch.
>>
>> Regards,
>> Boqun
>
> I think this is a good idea. We should extend that to add the check in 
> rwsem as well. Will a post a patch to do that.

Digging into it some more, I think adding kasan_check_byte() may not be 
necessary. If KASAN is enabled, it will instrument the locking code 
including __mutex_unlock_slowpath(). I checked the generated assembly 
code, it has 2 __kasan_check_read() and 4 __kasan_check_write() calls. 
Adding an extra kasan_check_byte() can be redundant.

Cheers,
Longman


