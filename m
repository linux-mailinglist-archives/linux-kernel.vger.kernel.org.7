Return-Path: <linux-kernel+bounces-726599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04459B00F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144515C4693
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B129C32B;
	Thu, 10 Jul 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n6fBUYTE"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97A296173
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188068; cv=none; b=lneJ4WCOxBZ2cIm7sIxJayKSknbJ7cNFGvW0WVA4H9k7PhVr2bCA9x5P/PVLpBJvEbT+3Emj+/7IaAMlSmBci5TFigXr5K3WPR7fI+l4vNGhw7H26siaqdPW4lmywbnbSVm4ymXIPyJ4I+hjD8DEdQ/zy9azLKbWcvCh1A3tA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188068; c=relaxed/simple;
	bh=XszvR0Jw+0DVF6jxzDN6OB0dTX8WmRWVvoI+bI9NT4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oSydOAdPP/Oa9C5EeKATRfjvErx3YakUk7u11ncaTUvUep5exjg9Tiw4UptBr10no+Hys4acwc1t3BMr1Rz74iXblzopBNZCDhtu4XP12HDZBseDuiXVUHQrKX0JTQtZCF3BzyVj7Q9c5uVcwK3Ua/xX1vEcn2KgLRGRtVE93Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n6fBUYTE; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752188064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP8p9g08D9jWaDh9BfM4THHq0w5McsGys06LzlvFrwo=;
	b=n6fBUYTEwv6xJ4QjIHC9mehNBvqpMifcFEr0qIXHldx9TIxM+F1W2LOs40EY2BBUICHlXt
	opZIikH3egkMaXLZ+a29jPuoGVxdi1sF3qdsvfR/9yqwA1PA4zGo/LjBQjUTjETpsdNN08
	aWMfj1PRRQDkmSUhHiwvvQ/20mEhTXc=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>,  Matthew Wilcox <willy@infradead.org>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Liu Shixin
 <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
In-Reply-To: <20250710135713.916a4898fb02f595206ac861@linux-foundation.org>
	(Andrew Morton's message of "Thu, 10 Jul 2025 13:57:13 -0700")
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
	<20250710135713.916a4898fb02f595206ac861@linux-foundation.org>
Date: Thu, 10 Jul 2025 15:54:17 -0700
Message-ID: <8734b3ac86.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 10 Jul 2025 12:52:32 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
>> We've noticed in production that under a very heavy memory pressure
>> the readahead behavior becomes unstable causing spikes in memory
>> pressure and CPU contention on zone locks.
>> 
>> The current mmap_miss heuristics considers minor pagefaults as a
>> good reason to decrease mmap_miss and conditionally start async
>> readahead. This creates a vicious cycle: asynchronous readahead
>> loads more pages, which in turn causes more minor pagefaults.
>> This problem is especially pronounced when multiple threads of
>> an application fault on consecutive pages of an evicted executable,
>> aggressively lowering the mmap_miss counter and preventing readahead
>> from being disabled.
>> 
>> To improve the logic let's check for !uptodate and workingset
>> folios in do_async_mmap_readahead(). The presence of such pages
>> is a strong indicator of thrashing, which is also used by the
>> delay accounting code, e.g. in folio_wait_bit_common(). So instead
>> of decreasing mmap_miss and lower chances to disable readahead,
>> let's do the opposite and bump it by MMAP_LOTSAMISS / 2.
>
> Are there any testing results to share?

Nothing from the production yet, but it makes a lot of difference
to the reproducer I use (authored by Greg Thelen), which basically
runs a huge binary with 2xCPU number of threads in a very constrained
memory cgroup. Without this change the system is oscillating between
performing more or less well and being completely stuck on zone locks
contention when 256 threads are all competing for a small number of
pages. With this change the system is pretty stable once it reaches
the point with the disabled readahead.

>
> What sort of workloads might be harmed by this change?

I hope none, but maybe I miss something.

>
> We do seem to be thrashing around (heh) with these readahead
> heuristics.  Lots of potential for playing whack-a-mole.  
>
> Should we make the readahead code more observable?  We don't seem to
> have much in the way of statistics, counters, etc.  And no tracepoints,
> which is surprising.

I think it's another good mm candidate (the first being oom killer
policies, working on it) for eventual bpf-ization. For example,
I can easily see that a policy specific to a file format can make
a large difference.

In this particular case I guess we can disable readahead based
on memory psi metrics, potentially all in bpf.

Thanks

