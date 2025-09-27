Return-Path: <linux-kernel+bounces-834788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC88BA585F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C04C516E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305921D00E;
	Sat, 27 Sep 2025 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuLVQQGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EB1EF38C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942264; cv=none; b=sSTwsGn5YAim35HGwIz+ds7XLaAZPxFfcHqM++KqbCW/C6rDadUKiupdz0r0PSLl/SnwFNBKO/LFC8OjIaeBT0yPvLjRJNwJm9wtwls+P25nFuicQ35dbAK0jrYcgRhcdK3fFj/7t/SjWsDRjfEPT+vqhPqGJ8dMEiHnQVH6MT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942264; c=relaxed/simple;
	bh=IAI70w+VPXR4oN4HHYLh/LOzSF12wlhF/e5Vidwt6C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcSBYrprnrqRMLZ544LauRSizbpqgh3dGOhOcB+kmHwtPQSGiVdUhZ+LCEVBq8QILQQdG7hnwV10epk+a7HoUuZbA2i58e+Dh/kQRPHDLOCxGni3olWP3LsCX4Z7WB6eWUzBXQS/fAbT0DEmpG2vvGYu9ybmTdEClFXBOJpx+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuLVQQGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C026C4CEF4;
	Sat, 27 Sep 2025 03:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758942264;
	bh=IAI70w+VPXR4oN4HHYLh/LOzSF12wlhF/e5Vidwt6C0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TuLVQQGgb7OFEAPNN4KM/hvUPeqm8xoRuD+ZJfiFtnK9l3qzRv8pT7Q+0v7Ecg5hC
	 /emtruESZPkHYESWydKs2BUiDurcvl8ptD/MRcssGrGICKBjZgv0TRRqunn3dULJfM
	 W3y1G+nFpx7ReCI/9FdUPzFHIpBimk80UfNAtTHpuF6JWTOoCNBSjbnahWfZVqr+5T
	 QAOeKjoxEnHzVxcewIRlEG2r15Z0p/aoOmsC4ayJn+gE5CxInZz8ixTbUmA63sjCfR
	 P3U2mtAvbe0ngbOXkdWieacdTasF2bTrTBWjUBjT7BCzpqnteHwqVZ2vk/33ukxOfS
	 jWCdqB/ti5RYw==
Message-ID: <5f7821d5-0b48-4600-ab99-d76a52361fc1@kernel.org>
Date: Sat, 27 Sep 2025 12:04:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
To: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
 <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
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
In-Reply-To: <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/26/25 11:16 PM, Vlastimil Babka wrote:
> +CC LOCKING PRIMITIVES maintainers. Looks like local_lock files were never
> added to the section, should we?
> 
> On 9/24/25 20:03, Vincent Mailhol wrote:
>> The Linux kernel coding style [1] advises to avoid common variable
>> names in function-like macros to reduce the risk of collisions.
> 
> I think it would be better if the tools like sparse could recognize if the
> shadowing happens inside a macro only and thus really unlikely to cause a
> misuse due to confusion (code thinks it's manipulating an outer instance but
> instead it's the inner one), because macros in their definition would never
> intend to manipulate a possible outer instance, right? Or are there any
> other problems due to shadowing besides this risk?

Thank would mean:

  - rewriting the shadowing check in sparse
  - removing the -Wshadow from the W=2 list
  - modifying the kernel coding style

I am not against this. But I am not unhappy with the current status quo either.

So far, I kept sending patches whenever I saw such shadow warning in header
files. And over the last five years, this resulted in only three occurrences:

  - commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate
    constant expressions")
    Link: https://git.kernel.org/torvalds/c/146034fed6ee


  - commit 9ce02f0fc683 ("x86/bug: Prevent shadowing in __WARN_FLAGS")
    Link: https://git.kernel.org/torvalds/c/9ce02f0fc683

  - this patch

Between sending one patch every couple year or enrolling to a quest to modify
the tooling, my choice is already made. If someone else want to do this change,
I would be supportive, but that person will not be me.

On a side note, I want to highlight that it is not that I am reluctant to modify
the tooling. For example, I sent contributed this commit to sparse last week:

commit 366ad4b2fa3e ("Warn about "unsigned value that used to be signed against
zero"")

Link:
https://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git/commit/?id=366ad4b2fa3e

As anyone here, I choose my battles, and rewriting the shadow checks is not in
my list.

>> Throughout local_lock_internal.h, several macros use the rather common
>> variable names 'l' and 'tl'. This already resulted in an actual
>> collision: the __local_lock_acquire() function like macro is currently
>> shadowing the parameter 'l' of the:
>>
>>   class_##_name##_t class_##_name##_constructor(_type *l)
>>
>> function factory from linux/cleanup.h.
>>
>> Rename the variable 'l' to '__l' and the variable 'tl' to '__tl'
>> throughout the file to fix the current name collision and to prevent
>> future ones.
>>
>> [1] https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> 
> That said I don't oppose the change, but not my call.

Thanks!


Yours sincerely,
Vincent Mailhol


