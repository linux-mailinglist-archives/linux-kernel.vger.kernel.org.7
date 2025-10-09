Return-Path: <linux-kernel+bounces-846840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC7BC9338
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7891A6151A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68E2E6CD4;
	Thu,  9 Oct 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvMEWVuP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430A24634F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015289; cv=none; b=iYuY/grdUfYds/mKq/mnybg9pghHbVNNg6r1e6Pq0/kdZrzQXGWE7WgrrDRw5uSdZBPTa/tMIohbKKKe5ZTjYurqIJAm8vT5bK/Nm0CV8DaftUj993abih1/PhXzV+bSMiLPYjNNtDoLK7fZtAVuZWLF/zyukkZ9kqE5F0Hhh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015289; c=relaxed/simple;
	bh=DXFzEfo7WCJAHVezgw1/hIh9ExiH4mJCOYJ0YYMfxRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdW1Yi5CItsP822EaN1DRkvr/EMhb1MGqhBeoG28bDYbtsopRNDZHje1ViioZqgt//1m2V5tQ7V8GeuKyU9tP3o8uk5NYPcK/x3/5qVgz4QPEEh1rgX8V8qQJXGpEgCBtiip0s7Hf/a5iwvwXpAfO9YuDlebLxiq5JDyLqN6was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvMEWVuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59076C4CEE7;
	Thu,  9 Oct 2025 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760015286;
	bh=DXFzEfo7WCJAHVezgw1/hIh9ExiH4mJCOYJ0YYMfxRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CvMEWVuPDywf53Rx4fiFOepSLMdggJsYbe4xyZ9NkMO1iDxW9irAtSlRFX+HLwCy/
	 4dv5ZVfVmBfwWbRTp+/8Ns4IBzha1PNrHGsvQRFXuLkOcfe3QBMkHiBLB4iQHTKLEr
	 q2cx9xugmXNy2myfH8e+81rswaKSbV9BRDqc+Fl5v8fhL5Pq/YRwkoqdurP5u2g+JT
	 u0SJ/UV5sm+9r6lieevItio2U3H2qvz0ZyLigvwJm8ctyJsLvCeXFBZ1lo9vy/zm7Y
	 53ytwvyqC7L+ve70fGma2W32cB7hV9XHK1/z8z6OAvvO/ptmiV1GFCfGE84J2p27AU
	 o0ktq9Iflw5yQ==
Message-ID: <7ad85953-7cc8-4925-bc08-6e97bdf8d0b6@kernel.org>
Date: Thu, 9 Oct 2025 22:08:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
References: <20251009103900.2Fk8stnM@linutronix.de>
 <86b3a4f4-18fd-40c6-9f96-825af52a0509@kernel.org>
 <20251009124315.KS20u0OG@linutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251009124315.KS20u0OG@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2025 at 21:43, Sebastian Andrzej Siewior wrote:
> On 2025-10-09 21:39:07 [+0900], Vincent Mailhol wrote:
>> Hi Sebastian,
> Hi Vincent,
> 
>> On 09/10/2025 at 19:39, Sebastian Andrzej Siewior wrote:
>>
>> (...)
>>
>>> @@ -223,12 +223,12 @@ typedef spinlock_t local_trylock_t;
>>>  #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
>>>  #define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
>>>  
>>> -#define __local_lock_init(l)					\
>>> +#define __local_lock_init(__l)					\
>>>  	do {							\
>>> -		local_spin_lock_init((l));			\
>>> +		local_spin_lock_init((__l));			\
>>>  	} while (0)
>>>  
>>> -#define __local_trylock_init(l)			__local_lock_init(l)
>>> +#define __local_trylock_init(__l)			__local_lock_init(__l)
>>>  
>>>  #define __local_lock(__lock)					\
>>>  	do {							\
>>
>> The parameters of a function like macro can not shadow existing
>> symbols because, when invoked, these parameters would be substituted
>> during the macro expansion by the actual arguments. Only the local
>> variables declared in the macro would survive after the preprocessor
>> and thus only those may cause shadowing.
>>
>> So this last part of the patch is not needed.
> 
> Right, but then we have the same __l variable in the whole file. Isn't
> this worth something?

What I really wanted to point out is that this is not needed in
regards to the shadowing problem. So this part feels a bit out of
scope of what the patch is trying to achieve.

That said, if you as a maintainer think that it is better to add this
for the global harmony of the file, then I am OK. I wouldn't do that
in a file which I maintain, but the maintainer here is you, not me. It
make sense that you do it your preferred way.

In other words, if you like it this way, keep the patch as is :)


Yours sincerely,
Vincent Mailhol

