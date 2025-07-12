Return-Path: <linux-kernel+bounces-728502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2BB0291C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581DE3BA48E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63808136352;
	Sat, 12 Jul 2025 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q214Ac5C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A394A24
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752290213; cv=none; b=UG32jTCbtfWB1WfoRMLeVvm8EkXM72MPH47dNqRmVb3kxbJHrL2reAiK2ZBfNGivtPJlfUsWiLnUAe1tYX2QMkEOepondF+BS5zMihishLMLHne4M7c8hID8UNyUw0fTQGBLvyxutlE6D6tR1gz4NIxOrS/+CK/YfbtUCeEzeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752290213; c=relaxed/simple;
	bh=jDDxomOWRHEdlTfXWiVJqHDKGmUM/WGoB1ksFpT+Y1E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n0SxCUOztOi5SKOlwk/2ouNePhDWL1sdsfiQ/KcBEuyG70fnpEDtP980yhzEh3QJLPpeISiahSQ1IQnzwKCYc3QKbbhgkGdLRgyHqMMfxPsdzR7RhDOhdwTIv6GR9u1xoDyJM0hyj48T54sl3LQE46dDzxuuCcbz5KhvhPEI4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q214Ac5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752290210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TidUQjbg5VdfVOHgFugyYJCpMI/5w88+k3ZJDwZkRdo=;
	b=Q214Ac5CN79nKn3vDWrSzVgJUyUNyqzMTxxPMH9SI6DT4IbVUjy9t5C7Sze7A1zZjepWoJ
	VuNxkI91LMSy+rylA1rjCeuFaEJPwNOOHlB3ZoA8ZZ8d6TwoV2UoJ4BOuJaE2mx/2Pi6fH
	P6FkeTdUf8EP615rDRekE8POJPTVWvE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-DAdfkWPUMsCoLXb5mRutQw-1; Fri, 11 Jul 2025 23:16:49 -0400
X-MC-Unique: DAdfkWPUMsCoLXb5mRutQw-1
X-Mimecast-MFC-AGG-ID: DAdfkWPUMsCoLXb5mRutQw_1752290208
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74d12fa4619so2317189b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752290207; x=1752895007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TidUQjbg5VdfVOHgFugyYJCpMI/5w88+k3ZJDwZkRdo=;
        b=xInr/QbTmQrLwuHYs9xNuafxraDTORCHw4xvx5id4EOAfYK2GfrnR6Oh0f1s8hX5B6
         NBee8cQX6mVC84H1HMgmpx9+POga8xqaHXsMbCBK3ojBgyKO7U9zIH0d3ArZm0mze5u+
         YidY0Ixphe8OTidEmsiH7U8kIIQFLzDC+U2GG41p7XPVqtYDFfM8s3ccesnotdeVqsI2
         RbIifJro6N86dLvvhOttx+LXCBajQ473MHDX5JmsZ1mCAqVb9n0Vu8RpuVmqIQ6QsB9M
         X6jpCEvM051HsCRTcNIUxl/Pw+t6GnWEBvPfipKP89FV+WEWFBNnY1GL2oiVSNDYBKeK
         cvbA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZbPBZPW7QhW1eR68GjyBFdkKXhDimfR4SoUpG7LVZhOxRLT60fZqXI+o8Oy0mEHn2x2V+lLKqO6FSUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSteS8P/qOaZvuTq5VT6YgWfAuuv/V4OMytkuxnyw/WHKgGHw
	3KcXnu03/c9kRE3xGNf/uThm/hC+xr5SOgBRVYJTwST3ebAkL1zHrIk2ONVOYZUMTcwczNWMybb
	7prOUpTpks+jzOgarRyMz11TqE1UBFiyJlBLtPnadQfQ2C8oRBdgsfu1JP9Q5ys7DtXDiiNZGjP
	nA
X-Gm-Gg: ASbGncuKgiD4iuMUbUqWW/yhfC4vMGZ2+hypAJG864xgcZQ3CjM9CFccl3hCJcSmGFE
	TvW7Byq8rjH8/YaCishzKFpExOyJ/VmTr5xxJDH299kAswfbDGzmgMRuU4b5UkBux7tPnuVdRe9
	7jwikybHmI8eapMmtaXOb+0oTa+9lzJDBOvTowfpPJ/C/pzBTyKT4TINoQSSwDt6Ug2XKrCqt8h
	GLt+iiBkhVhxEob3ncwGsT6M4wkPmH/cEDL4WXGQGmB1TLnfo1eJ9araSLrINRlCFVY8ELIAu9C
	egzuHAtszZvA3J5vjlvJFAZcqrlSwUJxEgGJTcQLR+9/JO03s7xFSMP9CBgFLUAiHu/fAiYoP/9
	IiwpATZXSew==
X-Received: by 2002:a05:6a00:4f8b:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-74ee12978bamr7193253b3a.7.1752290207324;
        Fri, 11 Jul 2025 20:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyRtzwLlVueHszDNWt0dctMXAun6KhoDUkekS7zpmk8MA8wMlExDOh8NtUNHoCsEv/8RpGXQ==
X-Received: by 2002:a05:6a00:4f8b:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-74ee12978bamr7193215b3a.7.1752290206829;
        Fri, 11 Jul 2025 20:16:46 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e061a6sm6720076b3a.50.2025.07.11.20.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 20:16:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cad83f32-d1ed-4885-8ed1-c65e5683237e@redhat.com>
Date: Fri, 11 Jul 2025 23:16:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
To: Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20250709193910.151497-1-longman@redhat.com>
 <aHGONjuRiA3KfH1q@tardis-2.local>
 <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
 <aHGeF7ko_4uXHUgl@tardis-2.local>
 <e88452ed-411b-419e-a41d-0ff98d54a59b@redhat.com>
 <00fdac3e-092d-46f0-bbe7-6067c0f22eeb@redhat.com>
 <aHHHZJ5sKGscTCqo@tardis.local>
Content-Language: en-US
In-Reply-To: <aHHHZJ5sKGscTCqo@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/25 10:24 PM, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 09:48:13PM -0400, Waiman Long wrote:
>> On 7/11/25 8:42 PM, Waiman Long wrote:
>>> On 7/11/25 7:28 PM, Boqun Feng wrote:
>>>> On Fri, Jul 11, 2025 at 03:30:05PM -0700, Linus Torvalds wrote:
>>>>> On Fri, 11 Jul 2025 at 15:20, Boqun Feng <boqun.feng@gmail.com> wrote:
>>>>>> Meta question: are we able to construct a case that shows
>>>>>> this can help
>>>>>> detect the issue?
>>>>> Well, the thing that triggered this was hopefully fixed by
>>>>> 8c2e52ebbe88 ("eventpoll: don't decrement ep refcount while still
>>>>> holding the ep mutex"), but I think Jann figured that one out by code
>>>>> inspection.
>>>>>
>>>>> I doubt it can be triggered in real life without something like
>>>>> Waiman's patch, but *with* Waiman's patch, and commit 8c2e52ebbe88
>>>>> reverted (and obviously with CONFIG_KASAN and CONFIG_DEBUG_MUTEXES
>>>>> enabled), doing lots of concurrent epoll closes would hopefully then
>>>>> trigger the warning.
>>>>>
>>>>> Of course, to then find *other* potential bugs would be the whole
>>>>> point, and some of these kinds of bugs are definitely of the kind
>>>>> where the race condition doesn't actually trigger in any real load,
>>>>> because it's unlikely that real loads end up doing that kind of
>>>>> "release all these objects concurrently".
>>>>>
>>>>> But it might be interesting to try that "can you even recreate the bug
>>>>> fixed by 8c2e52ebbe88" with this. Because if that one *known* bug
>>>>> can't be found by this, then it's obviously unlikely to help find
>>>>> others.
>>>>>
>>>> Yeah, I guess I asked the question because there is no clear link from
>>>> the bug scenario to an extra context switch, that is, even if the
>>>> context switch didn't happen, the bug would trigger if
>>>> __mutex_unlock_slowpath() took too long after giving the ownership to
>>>> someone else. So my instinct was: would cond_resched() be slow enough
>>>> ;-)
>>>>
>>>> But I agree it's a trivel thing to do, and I think another thing we can
>>>> do is adding a kasan_check_byte(lock) at the end of
>>>> __mutex_unlock_slowpath(), because conceptually the mutex should be
>>>> valid throughout the whole __mutex_unlock_slowpath() function, i.e.
>>>>
>>>>      void __mutex_unlock_slowpath(...)
>>>>      {
>>>>          ...
>>>>          raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags,
>>>> &wake_q);
>>>>          // <- conceptually "lock" should still be valid here.
>>>>          // so if anyone free the memory of the mutex, it's going
>>>>          // to be a problem.
>>>>          kasan_check_byte(lock);
>>>>      }
>>>>
>>>> I think this may also give us a good chance of finding more bugs, one of
>>>> the reasons is that raw_spin_unlock_irqrestore_wake() has a
>>>> preempt_enable() at last, which may trigger a context switch.
>>>>
>>>> Regards,
>>>> Boqun
>>> I think this is a good idea. We should extend that to add the check in
>>> rwsem as well. Will a post a patch to do that.
>> Digging into it some more, I think adding kasan_check_byte() may not be
>> necessary. If KASAN is enabled, it will instrument the locking code
>> including __mutex_unlock_slowpath(). I checked the generated assembly code,
>> it has 2 __kasan_check_read() and 4 __kasan_check_write() calls. Adding an
> The point is we want to check the memory at the end of
> __mutex_unlock_slowpath(), so it's an extra checking.

It is likely that the instrumented kasan_check* calls can be invoked 
near the beginning when the lock is first accessed, as I don't see any 
kasan_check*() around the inlined raw_spin_unlock_irqrestore_wake() call.

So if we want a check at the end, we may have to manually add one.

>
> Also since kasan will instrument all memory accesses, what you saw may
> not be the instrument on "lock" but something else, for example,
> wake_q_init() in raw_spin_unlock_irqrestore_wake().

The wake_q memory is from stack which I don't believe the compiler will 
generate kasan_check for that. I also don't see any kasan_check*() call 
when the wake_q is being manipulated.

> Actually, I have 3 extension to the idea:
>
> First it occurs to me that we could just put the kasan_check_byte() at
> the outermost thing, for example, mutex_unlock().
>
> Second I wonder whether kasan has a way to tag a pointer parameter of a
> function, for example for mutex_unlock():
>
> 	void mutex_unlock(struct mutex * __ref lock)
> 	{
> 		...
> 	}
>
> a kasan_check_byte(lock) will auto generate whenever the function
> returns.
>
> I actually tried to use __cleanup to implement __ref, like
>
> 	#define __ref __cleanup(kasan_check_byte)
>
> but seems the "cleanup" attritube doesn't work on function parameters ;(
>
> Third, I went to implement a always_alive():
>
> 	#define always_alive(ptr)                                                              \
> 	       typeof(ptr) __UNIQUE_ID(always_alive_guard) __cleanup(kasan_check_byte) = ptr;
>
> and you can use in mutex_unlock():
>
> 	void mutex_unlock(struct mutex *lock)
> 	{
> 		always_alive(lock);
> 		...
> 	}
>
> This also guarantee we emit a kasan_check_byte() at the very end.

Adding a kasan_check_byte() test at the end of unlock is a locking 
specific problem that we don't have that many instances where a check is 
needed. So it may not be worth the effort to devise a special mechanism 
just for that. Adding a simple macro to abstract it may be enough. 
Anyway, it is your call.

Cheers,
Longman


