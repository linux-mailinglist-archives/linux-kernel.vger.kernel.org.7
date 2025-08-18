Return-Path: <linux-kernel+bounces-774612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3B6B2B4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B527627EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5581FBE87;
	Mon, 18 Aug 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1YJWJCa0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8IX6Q9N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBE1624FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560641; cv=none; b=GwuKvc84s5CErpw/FiUhOdq62UtxVnR1WkX8CjRLYmwBA89WdbhzsJdcfhmcCvWNVczWtkwuOTolaPjOMBe1vVnf9Hj8SXlqXj+4CXQqtbTjI+vU21bdN941i+dLABbnyu8UruXLKD9G1fzYSJzyZS798tedjKzd08KN/wRQo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560641; c=relaxed/simple;
	bh=X5LGZgTPVEYCWi+l/kJHDxO/2aHmYUFIySFnNk87rI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F39dcPviGAcFPobIU9qk7M+Rnhv2vfpypqiG0TtDKoi9rYjWBGE4y1oV8OFDkQZfFatWJSQaQDG4lDZmxplK2ToeHJU+enly6o7CxW6TT3LxBTUghHKcH7tx8B0iGx3iyfNftPyGyJTjp/VyZeo6POmQ5qk/U1m95+0BmdDpNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1YJWJCa0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g8IX6Q9N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755560638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rtyW+t03gYN4576gtlpeh5I/KU7qUpMja6aszNb658=;
	b=1YJWJCa0YwPuXM2lqYKd/SOheYBWO919x9VfdjVZev1k3uK3nAUJIWpHIbPwx/M9NIqAFC
	BgWbRsaQcCyFdZdNvm988yr7yLcZYy3kF0QhjGTNL2Dx3hJrpmMPV0XuXX0A4GHpF4KFuM
	WpaxR6H1GYwxDWVddHitdRKhzPYPYoUkTXw4xlnFqfFRPqWcjab9UX5LjpT9K7HRrolm3z
	qS4tNnQbF5g8AhdIWve0LFbnOtgUgJzDLeaOxk+FA6uyWGujQ5YMo1c0aZMBD9LzTTZ8wg
	jHr4n00TS48qRYNUFSx0FqOVj5HtDjo12YJkpqcDvIaplhRAc2Ob34xS9OPIOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755560638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rtyW+t03gYN4576gtlpeh5I/KU7qUpMja6aszNb658=;
	b=g8IX6Q9NZSALizOmDAsYCZlMTgpe2kbptE7hApaaIFzfgImf+lyC3PqlKWYE6zEGkVhvOW
	DfOE5PeVbN376jCA==
To: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
In-Reply-To: <f5f862e2-5ce9-4d49-970f-b480cb3e7ba2@efficios.com>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk> <87bjoi7vqx.ffs@tglx>
 <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk> <877bz67u3j.ffs@tglx>
 <87y0rh63t0.ffs@tglx> <e6906764-66bb-437d-8082-b1d6a48ffa55@efficios.com>
 <87a53wxtx5.ffs@tglx> <f5f862e2-5ce9-4d49-970f-b480cb3e7ba2@efficios.com>
Date: Tue, 19 Aug 2025 01:43:57 +0200
Message-ID: <875xekxkjm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 18 2025 at 17:29, Michael Jeanson wrote:

> On 2025-08-18 16:21, Thomas Gleixner wrote:
>> That looks about right. Can you reset the branch to
>> 
>>       commit 85b61b265635 ("rseq: Expose stats")
>> 
>> which is just adding primitive stats on top of the current mainline
>> code, and provide numbers for that too?
>> 
>> That gives you 'notify: , cpuid:, fixup:' numbers, which are not 1:1
>> mappable to the final ones, but that should give some interesting
>> insight.
>
> For amd64 kernel and userspace.
>
> Before:
>
> notify:             12467
> fixup:              12467
> cpuid:              12467
>
>
> After:
>
> notify:         123669528
> fixup:          123669528
> cpuid:          123669528

That's insane compared to this:

> exit:          229294046
> signal:               11
> slowp:              4570
> ids:              615950
> cs:              2493682
> clear:            194637
> fixup:           2299044

You can assume that the number of exits (to user) is roughly the same,
i.e. ~23M, so 12M (> 50%) take the TIF_NOTIFY dance on the way out and
most of them for no good reason.

While with the rework only 4.5K go into the NOTIFY slow path and 2.5M
(10 %) do the critical section evaluation and 600k (~ 3%) update CPU/MM
CID.

No suprise that Jens is seeing this in his profiles...

Thanks,

        tglx

