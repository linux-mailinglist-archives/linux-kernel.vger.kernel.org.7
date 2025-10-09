Return-Path: <linux-kernel+bounces-846803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3FBC9145
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF0C3E8B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570992E2644;
	Thu,  9 Oct 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opc38xVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7252E285B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013551; cv=none; b=L84N5oGvXWt7ArxJJCcWocxv5QL3hykdGNMKZPBK8ESxMPp1HuVDDNHLzOKZPyJTBsmlrz1m0PH0lCY22XFRRTOfnZQSRxuvgzvC5DzCGYCr6uhjXNvNdru4tsZI2owQZ3K9reLxUBu6qvJqYSdEA6u+b7NajxZXHPI3apmKxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013551; c=relaxed/simple;
	bh=AEivT90f2/IEo8mbRFi9jNUJlKhBhMvbE8Q4gxMNaik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvXLuYF1cQXwh6+VJ5DI24hR/QQfcOfNf3PjdcVHR/AMM9YGAWn/j3fvagcTiTkXic32oLVriZxb9OLPb+zbDTqulpKcEZ6I1xihSyUF9VLHbyYluxWjC1D20vpLx+Plb3RlKestFdXq4+3vHwa4vBnmqx/oO4uD9Oy+I3WgnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opc38xVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D4DC4CEE7;
	Thu,  9 Oct 2025 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760013550;
	bh=AEivT90f2/IEo8mbRFi9jNUJlKhBhMvbE8Q4gxMNaik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=opc38xVrlnpK3NQnQl/DqEh2jvrwUnL/VS0laYaMq0/HQddpR6wjdhI8zaZjiy7jJ
	 AeY3mglmsNagmH6QTAoiavJTI36/JpT0d03fTJ5vVwXfuqBhTMlOhBpUoFW9eVgFEu
	 l52uhJG+iLIB2HQPT2zHciqulWpm8P5SYo6KGqG9YFet0eL+uA6CkVEJ7F5KKm6n//
	 Y29Uj3PrOm36Lgaw5GlJuDtuyYXQCZE6kOTnLpQKEFakYpjdCOVZLGBSjNd9RcUsYt
	 RR24lIoswxOx75zheQPQp+JV+UR57XBZrjWkhm8kqFM6Vvu3mc9u1Ez1mQ9QUE3SOn
	 zh5exA26lP59A==
Message-ID: <86b3a4f4-18fd-40c6-9f96-825af52a0509@kernel.org>
Date: Thu, 9 Oct 2025 21:39:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20251009103900.2Fk8stnM@linutronix.de>
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
In-Reply-To: <20251009103900.2Fk8stnM@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

Thanks for the rebase and for this v3.

On 09/10/2025 at 19:39, Sebastian Andrzej Siewior wrote:

(...)

> @@ -223,12 +223,12 @@ typedef spinlock_t local_trylock_t;
>  #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
>  #define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
>  
> -#define __local_lock_init(l)					\
> +#define __local_lock_init(__l)					\
>  	do {							\
> -		local_spin_lock_init((l));			\
> +		local_spin_lock_init((__l));			\
>  	} while (0)
>  
> -#define __local_trylock_init(l)			__local_lock_init(l)
> +#define __local_trylock_init(__l)			__local_lock_init(__l)
>  
>  #define __local_lock(__lock)					\
>  	do {							\

The parameters of a function like macro can not shadow existing
symbols because, when invoked, these parameters would be substituted
during the macro expansion by the actual arguments. Only the local
variables declared in the macro would survive after the preprocessor
and thus only those may cause shadowing.

So this last part of the patch is not needed.


Yours sincerely,
Vincent Mailhol

