Return-Path: <linux-kernel+bounces-803887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B5B466CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF5E4E1E1A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23E29D277;
	Fri,  5 Sep 2025 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D11SbykN"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B929D270
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112288; cv=none; b=lDLuMGCo9QX+0Uz5Wjev6e135n3iAgxBi5o8wXckkLZlUADoiFjaUO6jS0HbEkSH+CQR1xPNfBBPlJU5lWQcnJ+/SjWb7G0uborIEM5QrfmMRyD+psPO6HRRbVjfJaUdP3fiHq+SG2r3DQHyT3+CtjMwRC/NlP+iwmVnaQxiZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112288; c=relaxed/simple;
	bh=V23C9Ebj02wqWuD1jFpn8uhOfCPGnEw6lbKl9cWUTRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LtdZ6WRKKf5V0kJhhacFsvnppD34tKZQlpKcCTW16GThKJb0fL//bUuVUhPtYgan+t7t9/uMuIJQrHxLcLLmPxyCQastbLuRjhxBXO3nrl7i2YFV3PJ83WvctjPt9QJ2UvexwCz7Vj5qZ0+qIxyw0nDPaD20eb2BNEo4m/N7yqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D11SbykN; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757112274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IEvTf0gu2uvX4iNptGPGuSQc3Jmjp1dV6o5P5PehWGU=;
	b=D11SbykNSIElurYGwH8imcgAOpuoUqmYxP+VrnGYqNwwXfriFXq2dx3BkVqnX9Rvg0B+82
	hnSm4wVK2Zit7mfTkJ54avRQbmsT6cHrZRK6Z8tn1mLUC+8OndYp4Q2VLeJ/IqgrZCj3ze
	BjbZntUKHiduelcTWnahlGLb4HT2xAY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,
  Muchun Song <muchun.song@linux.dev>,  Alexei Starovoitov
 <ast@kernel.org>,  Peilin Ye <yepeilin@google.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  bpf@vger.kernel.org,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  linux-kernel@vger.kernel.org,  Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
In-Reply-To: <6bcjnhdsbyfmlua2x7olz6w3gheejfatnrtn5qu7ls5svegrok@zeatti7whrnq>
	(Shakeel Butt's message of "Fri, 5 Sep 2025 14:50:17 -0700")
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
	<87y0qsa95d.fsf@linux.dev>
	<mai3ndkvqrpkfpblkazbyejvpkizrp7dh22374tpkmepfji32o@3troawzsuvqe>
	<87ecska85y.fsf@linux.dev>
	<6bcjnhdsbyfmlua2x7olz6w3gheejfatnrtn5qu7ls5svegrok@zeatti7whrnq>
Date: Fri, 05 Sep 2025 15:44:28 -0700
Message-ID: <87cy848qpf.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Fri, Sep 05, 2025 at 02:42:01PM -0700, Roman Gushchin wrote:
>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>> 
>> > On Fri, Sep 05, 2025 at 02:20:46PM -0700, Roman Gushchin wrote:
>> >> Shakeel Butt <shakeel.butt@linux.dev> writes:
>> >> 
>> >> > Generally memcg charging is allowed from all the contexts including NMI
>> >> > where even spinning on spinlock can cause locking issues. However one
>> >> > call chain was missed during the addition of memcg charging from any
>> >> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
>> >> > cgroup_file_notify().
>> >> >
>> >> > The possible function call tree under cgroup_file_notify() can acquire
>> >> > many different spin locks in spinning mode. Some of them are
>> >> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
>> >> > just skip cgroup_file_notify() from memcg charging if the context does
>> >> > not allow spinning.
>> >> 
>> >> Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
>> >> like a bit deal, but OOM events can be way more important.
>> >> 
>> >> Should we instead preserve the event (e.g. as a pending_event_mask) and
>> >> raise it on the next occasion / from a different context?
>> >>
>> >
>> > Thanks for the review. For now only MAX can happen in non-spinning
>> > context. All others only happen in process context. Maybe with BPF OOM,
>> > OOM might be possible in a different context (is that what you are
>> > thinking?). I think we can add the complexity of preserving the event
>> > when the actual need arise.
>> 
>> No, I haven't thought about any particular use case, just a bit
>> worried about silently dropping some events. It might be not an issue
>> now, but might be easy to miss a moment when it becomes a problem.
>> 
>
> Only the notification can be dropped and not the event (i.e. we are
> still incrementing the counters). Also for MAX only but I got your
> point.
>
>> So in my opinion using some delayed delivery mechanism is better
>> than just dropping these events.
>
> Let me see how doing this irq_work looks like and will update here.

Thanks!

If it won't work out for some reason, maybe at least explicitly
narrow it down to the MEMCG_MAX events.

