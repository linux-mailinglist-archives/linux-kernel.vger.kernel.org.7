Return-Path: <linux-kernel+bounces-757625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386FB1C46F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6B218C04AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F45828A1D3;
	Wed,  6 Aug 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1y8ifgKs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="toS1IjGN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7C2571C5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476753; cv=none; b=jrOcer5EZvbVyavOkdulB1Spl7Kut62Bc7jF0qsLvGhOH/ATKJCB74Ar4Uivvo8SujgOZM02rNzNu+TNqCFjA0FXIHmTH8OOfm8W8pm9zxILLnT5UY1H2tMwkgjK0feaN+q7iLZK8vLoBwZRZ05RH0t/qqtDYM0EgNfIJAlYnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476753; c=relaxed/simple;
	bh=4avSKfWvL28pdH6MrnrnhaXv4f/HUlfPxhJGeGx2V/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GHnqEaV80MAsGYKhlcfqXIug6hFjHG8UkHixb+1wGVyYZj2UbNDiaILEC0zsHNREdjGdxtzAtVCtYTaW5Y818cq2Igg4dzMmw0warLmne5rBHAUGRnSj+emz/e+0HprjOVsOqzLBi3IxG0VHW6VPv07nCmeOwb3f/KcvNV/82Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1y8ifgKs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=toS1IjGN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754476749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhKBjBL0r+ZMyH7ZvDnPT8IRUyvC+7V+Yvg1xfVi4zk=;
	b=1y8ifgKsKOhwxKOFaOdd4FhBFUCxw9urKa04WdCdOnVhl2hNkpbnUv96e7kQf4W8Pduid0
	+GT0IBKfm/dWo0GW+3netUezCF1T4zQNjw2vAN8BggMyEj+xu7qmpy5EaVHcvuHI/lsUxz
	KaOS8Tb4dt4do3t/xeyOJQUjFWMc+D8LYw8G6erCR4Yd4XraR/3bAqClxrGba8PTJRr5xJ
	Nn/O5De/zMGIvXLQKZJ1sbAVQIE01rjHAumEkWwqcBN/ArIemkidhb1REzvuvZ9bm/TTsh
	0XApwyQIR9Ht5iJv2FjKDwuxqf1kWJrEgOIeDnc111kJYW8dogBg/iHWBku4JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754476749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhKBjBL0r+ZMyH7ZvDnPT8IRUyvC+7V+Yvg1xfVi4zk=;
	b=toS1IjGNfZoqRXGyiwSsAeCZYwQrk6b//DsCVNMJeLwyycx0mPt6dil7hFiSEtMNY+6HU4
	ONdyXmizynHcl7BA==
To: Oliver Sang <oliver.sang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [tip:locking/futex] [futex]  56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
In-Reply-To: <aJMT5DsFlOL6V+Nv@xsang-OptiPlex-9020>
References: <87a54usty4.ffs@tglx> <aINKAQt3qcj2s38N@xsang-OptiPlex-9020>
 <87seikp94v.ffs@tglx> <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020>
 <87wm7ro3r7.ffs@tglx> <aIrJipeLsGUM92+R@xsang-OptiPlex-9020>
 <87cy9gilo8.ffs@tglx> <874iusihka.ffs@tglx>
 <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020> <87qzxoeuav.ffs@tglx>
 <aJMT5DsFlOL6V+Nv@xsang-OptiPlex-9020>
Date: Wed, 06 Aug 2025 12:39:09 +0200
Message-ID: <87bjosenua.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 06 2025 at 16:35, Oliver Sang wrote:

> On Wed, Aug 06, 2025 at 10:19:36AM +0200, Thomas Gleixner wrote:
>> Oliver!
>> 
>> On Wed, Aug 06 2025 at 16:01, Oliver Sang wrote:
>> > On Thu, Jul 31, 2025 at 04:03:01PM +0200, Thomas Gleixner wrote:
>> >> On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
>> >> > Either you make the timeout longer or try the following on the kernel
>> >> > command line instead of 'ftrace_dump_on_cpu':
>> >> 
>> >>   instead of 'ftrace_dump_ooops'
>> >
>> > sorry for late, I just took several-day off.
>> 
>> I hope you had a good time!
>> 
>> > attached dmesg FYI.
>> 
>> Thanks for doing this. Now the buffer is too short and as nothing stops
>> the tracer the interesting stuff goes out of sight.
>> 
>> Can you please apply the patch below and try again?
>
> got it!
>
> just want to confirm, still use below params or need some modification?
>
> trace_event=preemptirq:preempt_disable,preemptirq:preempt_enable ftrace_dump_on_oops=orig_cpu trace_buf_size=100K panic_on_warn=1

Those should be good. Let's see.

