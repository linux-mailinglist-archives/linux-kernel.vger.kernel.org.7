Return-Path: <linux-kernel+bounces-775116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF33B2BB74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0527F1B65AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF53101D5;
	Tue, 19 Aug 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t/0nro3v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FaxGUqJh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073B2B9B9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591132; cv=none; b=SgCcbFWxUl8KpF1DwBZD/dAKCFEuSd0dDXcHemq9U5/G5C3PSFas2KFvS4WXqcSqJpHfhvIba0bHcy+o3+/W/wWNx0fn6N+6FpZ/+FgqP4U/ED0E+ZsmIWVpupWcv06ACZ5th/Nvc7ORwjHw1IJopR2qu83UtoTZqYBFZDOdgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591132; c=relaxed/simple;
	bh=EneyqHGYpOuLy6/ReqhfuuzSEBr8vux4tStVrB53oB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebexBN02yFLObpOrHdb9IFM2ry76D81v//EBVg8U+z8B1kYMV5tpdn6i5gXJUp5Jl4CezdgJWzXUIrfOb/9Q5fzgkjIpiwxjPLdXYQErUhIDQo3aDgEup0mK20lBxbWCM99GvPT8KeIw6kZ2fdZVJ4GwSbty5g7WP5enixqNBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t/0nro3v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FaxGUqJh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755591129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yNyCn0GM5JSpUyAEcFzk3JIR+XLzqb8e9tzT4MhOaw=;
	b=t/0nro3vHnOlHfDMHBtmd5H0qppkssuI5P9lRdYgO9yod1G8qHr6DyEaRjTkuUYCSWnog8
	hqERnNqrUmgpNte8aq8UgAMiF88awRKbCla2f+SNrPvusAo9zEi95SmYwq+UvPfU4N7vpo
	91sLiF0Sg+0xUodHvYbTzi43d7UmIIUxZTRlxprBN8OK00qQ01RnFbGU4CCdgPG4bGllDT
	dXnhHnv41L/o6qv1LA34/BMmaffIZ14ebwh3B350+4CzmP+v6hNzj6L6kZwECZM5Yl5EPj
	HDot01mniqojLp/a+l6Z/YtoRovpEkt3zIX3pqAJ3By+4qZfLci4WZAiOCEmFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755591129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yNyCn0GM5JSpUyAEcFzk3JIR+XLzqb8e9tzT4MhOaw=;
	b=FaxGUqJh9x7KZEqwoiUMAscwkU+oMpVhNSodnTyrDZf5P/o/gi3pzFCTAyfiUyv8mtiR3h
	ti2FSIoSkyn7u9Bw==
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "vineethr@linux.ibm.com"
 <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
In-Reply-To: <20250818131655.1FybFuR4@linutronix.de>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com>
 <87a54bcmd7.ffs@tglx> <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
 <87o6smb3a0.ffs@tglx> <20250813161927.CFYHxNIv@linutronix.de>
 <87jz376tzj.ffs@tglx> <20250818131655.1FybFuR4@linutronix.de>
Date: Tue, 19 Aug 2025 10:12:08 +0200
Message-ID: <87zfbvwx0n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 18 2025 at 15:16, bigeasy@linutronix.de wrote:
> On 2025-08-13 18:56:16 [+0200], Thomas Gleixner wrote:
>> On Wed, Aug 13 2025 at 18:19, bigeasy@linutronix.de wrote:
>> > I spent some time on the review. I tried to test it but for some reason
>> > userland always segfaults. This is not subject to your changes because
>> > param_test (from tools/testing/selftests/rseq) also segfaults. Also on a
>> > Debian v6.12. So this must be something else and maybe glibc related.
>> 
>> Hrm. I did not run the rseq tests. I only used the test I wrote, but
>> that works and the underlying glibc uses rseq too, but I might have
>> screwed up there. As I said it's POC. I'm about to send out the polished
>> version, which survive the selftests nicely :)
>
> It was not your code. Everything exploded here. Am right to assume that
> you had a recent/ current Debian Trixie environment testing? My guess is
> that glibc or gcc got out of sync.

  https://lore.kernel.org/lkml/aKODByTQMYFs3WVN@google.com

:)

>> > gcc has __atomic_fetch_and() and __atomic_fetch_or() provided as
>> > built-ins.
>> > There is atomic_fetch_and_explicit() and atomic_fetch_or_explicit()
>> > provided by <stdatomic.h>. Mostly the same magic.
>> >
>> > If you use this like
>> > |  static inline int test_and_clear_bit(unsigned long *ptr, unsigned int bit)
>> > |  {
>> > |          return __atomic_fetch_and(ptr, ~(1 << bit), __ATOMIC_RELAXED) & (1 << bit);
>> > |  }
>> >
>> > the gcc will emit btr. Sadly the lock prefix will be there, too. On the
>> > plus side you would have logic for every architecture.
>> 
>> I know, but the whole point is to avoid the LOCK prefix because it's not
>> necessary in this context and slows things down. The only requirement is
>> CPU local atomicity vs. an interrupt/exception/NMI or whatever the CPU
>> uses to mess things up. You need LOCK if you have cross CPU concurrency,
>> which is not the case here. The LOCK is very measurable when you use
>> this pattern with a high frequency and that's what the people who long
>> for this do :)
>
> Sure. You can keep it on x86 and use the generic one in the else case
> rather than abort with an error.
> Looking at arch___test_and_clear_bit() in the kernel, there is x86 with
> its custom implementation. s390 points to generic___test_and_clear_bit()
> which is a surprise. alpha's and sh's isn't atomic so this does not look
> right. hexagon and m68k might okay and a candidate.

Right, I'll look into that after I sorted out the underlying rseq
mess. See the context of the link above. That solved will make the
integration of this timeslice muck way simpler (famous last words).

Thanks,

        tglx



