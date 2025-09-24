Return-Path: <linux-kernel+bounces-830336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F78DB996CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE44A7BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F32DE6EE;
	Wed, 24 Sep 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0M1P6pL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7942DCF61
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709574; cv=none; b=E8OolGB1GJk2FCGGm2yMMSx5M+v7o630I611IMW4fI4iTpHTbMxTn3q01VAGEDNoXqAwoXQleUTlK5niaebtIBwpzzRqslStgjcZHjF2RNQXVLTlXHRGz25mOvezttyH8fQ8digY7VFbeEdlNWF7f1A1ukqU4aC2DiHqJdWCKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709574; c=relaxed/simple;
	bh=FDERl7O+VbdNfzowcWXHtxvVhNJTkK3UN+NkYpMvGAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JadUrSHkkbTm/ndX9kwwofQwpW5Rnj9ZQYdaSvcQpPwyR6OG/wvY1+CSOoCIBormklmWcV/4xLQbKk91uQmAiuf1bhFvQuo9l509oh9Os9r4J1QJSOruHjb/3qS/2kzJ7/CJZCsYWuu7ecY/LBaBBbbhBgQ4fWtUM7XZ8SaZiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0M1P6pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B80C4CEE7;
	Wed, 24 Sep 2025 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758709573;
	bh=FDERl7O+VbdNfzowcWXHtxvVhNJTkK3UN+NkYpMvGAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z0M1P6pLwa3SuoEzLlLFg4lieA2XpFpJHwK8CI+qG0z89jN5GpxpwqU0bpkCbrgH3
	 ekn7Jwp0/vRRCzC7d2iD5iV0ytCpXkDiPsaFYxL5HHWNHMNbvuckgLI6izjvyNRMc5
	 DHvKnevSh6Vh3inE2ZVmuardkgF0YLVZr1wbpec1xbAH0A94l/MZuSHmZ6jpvoU7DW
	 3fhFtPjpVbjqdCMdyuFSCdCmTJck664FqoedQpoAh+pcrJQa8TenomfzZdaMpfPj/I
	 gFQQ2hv0NawDGx9UDFdkO2Cq1s9idxVKnq8T+IkyWYZsZa8zv3/df9C8S9LKRX2sae
	 xSoISru9SKdVg==
Message-ID: <5d6641e3-3e89-465a-aaf5-558dc97a7581@kernel.org>
Date: Wed, 24 Sep 2025 19:26:10 +0900
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
In-Reply-To: <CAADnVQK_Dt7Ag9nLQm2LDFoiB_ymorC017YXJ9ZC06VizEHt2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/09/2025 at 04:38, Alexei Starovoitov wrote:
> On Tue, Sep 23, 2025 at 7:02 AM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> The __local_lock_acquire() macro uses a local variable named 'l'. This
>> being a common name, there is a risk of shadowing other variables.
>>
>> For example, it is currently shadowing the parameter 'l' of the:
>>
>>   class_##_name##_t class_##_name##_constructor(_type *l)
>>
>> function factory from linux/cleanup.h.
>>
>> Both sparse (with default options) and GCC (with W=2 option) warn
>> about this shadowing.
>>
>> This is a bening warning, but because the issue appears in a header,
>> it is spamming whoever is using it. So better to fix to remove some
>> noise.
>>
>> Rename the variable from 'l' to '__lock' (with two underscore prefixes
>> as suggested in the Linux kernel coding style [1]) in order to prevent
>> the name collision.
> 
> lockdep has __lock as a local variable.

OK. I didn't saw this one.

But there is a major difference between a shadowing in lockdep.c versus a
shadowing in an header: the shadowing warning is local to lockdep.c and does not
pollute the other users.

My worry is only about the spam created by warnings in headers.

Regardless, would renaming to __locked or __l instead of __lock help to address
your concern?

> So the patch won't really fix the paranoid warning.
> I think it's better to fix sparse to silence this warn.

Well, it is not only about the tooling but also about the Linux kernel coding
style. I quote:

  5) namespace collisions when defining local variables in macros resembling
  functions:

	#define FOO(x)                          \
	({                                      \
	        typeof(x) ret;                  \
	        ret = calc_ret(x);              \
	        (ret);                          \
	})

  ret is a common name for a local variable - __foo_ret is less likely to
  collide with an existing variable.

I really do not want to open the debate on whether shadow warnings are useful or
not. The coding style says that we should care about this, let's just follow the
rule.

Your patch is causing noise in the files I am using. So I hope you can find a
solution for the annoyance your are causing me. I do not mind which solution it
is. I am proposing one, if you do not like it, I am also fine if you prefer to
go on a quest to rewrite the coding style and modify the tooling so that we do
not warn anymore about shadowing. But I think we can agree that it is not *my*
job to rewrite the kernel coding style and the tooling to *your* liking.


Yours sincerely,
Vincent Mailhol


