Return-Path: <linux-kernel+bounces-831019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68994B9B29C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D32D1779FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE323957D;
	Wed, 24 Sep 2025 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/cqly8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D344231830
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737064; cv=none; b=jFyImdzx8AxIS0UYykt/7p+t38GewkchR2UxHRQh+PJVUgg9z3grAVC/IQoMgNAijjQRpbK5cDGTM2GZ0oOGqVWFRXkVqCgxeq934ZsdJxpYmZyjdonxOBGYE4kJW+wc5LUYGTyvtvd+OtmQIqgsZgYKD9lU23k1i4K8EkJ/qY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737064; c=relaxed/simple;
	bh=76US+72HPzNoXiOXM5P2Dol+ZfKjT4LUSXo1rrFkEfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7uMp8X3vQce32/FJ89IvQIW50hTMMo1FK71vTB8Osj26mAcpiQ7lkDapHvrV7BPS59JuOZsq8nQWRJGVhKAUBd1THI9qhAE/1C6POaxFFCX4mxK60d5lZ3O8x+Uk9a1UD7pQWVmqvdq8YOEH1td24nAxwQUsa/bMFhanxmaD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/cqly8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC108C4CEE7;
	Wed, 24 Sep 2025 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737063;
	bh=76US+72HPzNoXiOXM5P2Dol+ZfKjT4LUSXo1rrFkEfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h/cqly8/cLGNYJt+XdQ3N3wVJ0LhfS9YG3cNHm0m0WgIfac+Sc45aF9aqhbipL7D6
	 MFtp7AtMJjQIkGMyjeYU5sUK1fv2fCYrf8NW8jZmDcWzj3IaGFA0KO6oXZaXuqcwzo
	 oA7pwcd2W6IA67+EA/ZTrxzmIKsFl7KEpKF15x/0TSBCHvf0BxS1O7yBsKdb5airwT
	 442YbRgFleAl+jhuYnMY91pgtvWc0q9EOKSXfBsz+W5h5Qxqa/7eP5IWx+QoBp9UFb
	 XitG1HqT0vG1bQ0RnCEdJIOpzoPUv+bDnDIj3xFOvpdsUyQVOs7JS2r99PtyqVNuH2
	 rHzpGlLn0jQng==
Message-ID: <90cecd21-3ad2-4c21-a0d3-4b30a79d4eac@kernel.org>
Date: Thu, 25 Sep 2025 03:04:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <3b16de2f-9298-452a-95d8-df2b4b668714@kernel.org>
 <CAADnVQ+xGQGdR85R6EnX7Rrv+RqkrTfLjfdZOYJ4bPb9+Govyg@mail.gmail.com>
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
In-Reply-To: <CAADnVQ+xGQGdR85R6EnX7Rrv+RqkrTfLjfdZOYJ4bPb9+Govyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/09/2025 at 02:07, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 4:07 PM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> On 24/09/2025 at 19:26, Vincent Mailhol wrote:
>>> On 24/09/2025 at 04:38, Alexei Starovoitov wrote:
>>>> On Tue, Sep 23, 2025 at 7:02 AM Vincent Mailhol <mailhol@kernel.org> wrote:
>>>>>
>>>>> The __local_lock_acquire() macro uses a local variable named 'l'. This
>>>>> being a common name, there is a risk of shadowing other variables.
>>>>>
>>>>> For example, it is currently shadowing the parameter 'l' of the:
>>>>>
>>>>>   class_##_name##_t class_##_name##_constructor(_type *l)
>>>>>
>>>>> function factory from linux/cleanup.h.
>>>>>
>>>>> Both sparse (with default options) and GCC (with W=2 option) warn
>>>>> about this shadowing.
>>>>>
>>>>> This is a bening warning, but because the issue appears in a header,
>>>>> it is spamming whoever is using it. So better to fix to remove some
>>>>> noise.
>>>>>
>>>>> Rename the variable from 'l' to '__lock' (with two underscore prefixes
>>>>> as suggested in the Linux kernel coding style [1]) in order to prevent
>>>>> the name collision.
>>>>
>>>> lockdep has __lock as a local variable.
>>>
>>> OK. I didn't saw this one.
>>>
>>> But there is a major difference between a shadowing in lockdep.c versus a
>>> shadowing in an header: the shadowing warning is local to lockdep.c and does not
>>> pollute the other users.
>>>
>>> My worry is only about the spam created by warnings in headers.
>>>
>>> Regardless, would renaming to __locked or __l instead of __lock help to address
>>> your concern?
>>
>> __locked was a bad suggestion. It could be named __local_lock (there is already
>> a __local_lock() function like macro, but function like macro does not conflict
>> with variable names).
>>
>> But now, my current preference goes to __ll (and also, to keep things
>> consistent, __tl for the trylock).
> 
> I think s/l/__l/ and s/tl/__tl/ is fine,
> but do it for all macros in that file,
> since renaming one is fishy. It doesn't fix what
> you're claiming to fix, hence the pushback.

OK. This was a fair pushback :)

I took your suggestion and renamed all instances in the file. I just sent the v2.

Thanks!


Yours sincerely,
Vincent Mailhol


