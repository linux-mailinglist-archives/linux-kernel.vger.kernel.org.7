Return-Path: <linux-kernel+bounces-830770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A7B9A796
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663DB164BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB81547D2;
	Wed, 24 Sep 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl327L2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EB22127E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726423; cv=none; b=Vr/okW1IiX4jj8kQj+s5PZ2z9Dml2NhCfb4pYm8A219b/QoDCotg9TC7oy7yzHIbWmOISkEnmyIPIn6V1Ew8G1uM+eT56TdakDdR6cvIDinLP+WZ8fBhBWhujmq1Z+ZXqMuCKw+vMrku8KO1U3kjVfG/z7NLC6nnOWlJ0//3k6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726423; c=relaxed/simple;
	bh=Wtz4dkKTQ8NEPHSd+Co0mwxvLzbQlCw9RFSspis18wU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=paE4YEno6/Zhul6DHJizunXq0RwkzSi1Q80SVem2gZVn6chgAzR2VafeKODMAEyg6prVlRpujvA2ZTylAr30Wp2rFs6YnCXZ0X7q5g+Ta0E8qXEI5IXW/6wtpErUix2bPPk0SSBIkEW19J4o3qXWl0NICBS+dQQWS3+hzPh7++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl327L2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D222EC4CEE7;
	Wed, 24 Sep 2025 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758726423;
	bh=Wtz4dkKTQ8NEPHSd+Co0mwxvLzbQlCw9RFSspis18wU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=sl327L2Q0FHSXbldebTPTJeVxKcNvR7LyjUaYtVHRrMMZeUVzoFoqRenPUrPfVURK
	 LdxvBy9gSWRFud8NgwcK7KqbH0PhuJyMRAJYCObtonD/RByQBNFrCSYzzw/EkvMNdl
	 BIh9PG7JCI0sNPRl/9umHspDzgO+cQ3UlHdLiQ+7fLTTxMlFk1zvOHTdtRN3hBARea
	 YpU0NXTEmCrm3Ap+Xe+bw7lZMKcoJmYB1kzGxn5fTwDKnVd5NXpBDoq5pgusSFjeaO
	 WrILrR/odr4iKpiVwsxeRYiOFhxfa2/48AKQNHkSxkVNOtZVZl2+vm+Z5QUumQn2RG
	 laoe5iEy0RfJw==
Message-ID: <3b16de2f-9298-452a-95d8-df2b4b668714@kernel.org>
Date: Thu, 25 Sep 2025 00:07:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH] locking/local_lock: fix shadowing in
 __local_lock_acquire()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250923-local_lock_internal_fix_shadow-v1-1-14e313c88a46@kernel.org>
 <CAADnVQK_Dt7Ag9nLQm2LDFoiB_ymorC017YXJ9ZC06VizEHt2A@mail.gmail.com>
 <5d6641e3-3e89-465a-aaf5-558dc97a7581@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <5d6641e3-3e89-465a-aaf5-558dc97a7581@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/09/2025 at 19:26, Vincent Mailhol wrote:
> On 24/09/2025 at 04:38, Alexei Starovoitov wrote:
>> On Tue, Sep 23, 2025 at 7:02 AM Vincent Mailhol <mailhol@kernel.org> wrote:
>>>
>>> The __local_lock_acquire() macro uses a local variable named 'l'. This
>>> being a common name, there is a risk of shadowing other variables.
>>>
>>> For example, it is currently shadowing the parameter 'l' of the:
>>>
>>>   class_##_name##_t class_##_name##_constructor(_type *l)
>>>
>>> function factory from linux/cleanup.h.
>>>
>>> Both sparse (with default options) and GCC (with W=2 option) warn
>>> about this shadowing.
>>>
>>> This is a bening warning, but because the issue appears in a header,
>>> it is spamming whoever is using it. So better to fix to remove some
>>> noise.
>>>
>>> Rename the variable from 'l' to '__lock' (with two underscore prefixes
>>> as suggested in the Linux kernel coding style [1]) in order to prevent
>>> the name collision.
>>
>> lockdep has __lock as a local variable.
> 
> OK. I didn't saw this one.
> 
> But there is a major difference between a shadowing in lockdep.c versus a
> shadowing in an header: the shadowing warning is local to lockdep.c and does not
> pollute the other users.
> 
> My worry is only about the spam created by warnings in headers.
> 
> Regardless, would renaming to __locked or __l instead of __lock help to address
> your concern?

__locked was a bad suggestion. It could be named __local_lock (there is already
a __local_lock() function like macro, but function like macro does not conflict
with variable names).

But now, my current preference goes to __ll (and also, to keep things
consistent, __tl for the trylock).

>> So the patch won't really fix the paranoid warning.
>> I think it's better to fix sparse to silence this warn.
> 
> Well, it is not only about the tooling but also about the Linux kernel coding
> style. I quote:
> 
>   5) namespace collisions when defining local variables in macros resembling
>   functions:
> 
> 	#define FOO(x)                          \
> 	({                                      \
> 	        typeof(x) ret;                  \
> 	        ret = calc_ret(x);              \
> 	        (ret);                          \
> 	})
> 
>   ret is a common name for a local variable - __foo_ret is less likely to
>   collide with an existing variable.
> 
> I really do not want to open the debate on whether shadow warnings are useful or
> not. The coding style says that we should care about this, let's just follow the
> rule.
> 
> Your patch is causing noise in the files I am using. So I hope you can find a
> solution for the annoyance your are causing me. I do not mind which solution it
> is. I am proposing one, if you do not like it, I am also fine if you prefer to
> go on a quest to rewrite the coding style and modify the tooling so that we do
> not warn anymore about shadowing. But I think we can agree that it is not *my*
> job to rewrite the kernel coding style and the tooling to *your* liking.

Yours sincerely,
Vincent Mailhol

