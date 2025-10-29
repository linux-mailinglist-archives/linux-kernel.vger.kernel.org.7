Return-Path: <linux-kernel+bounces-875535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE84C19504
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2F9E50948A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C22B31C58E;
	Wed, 29 Oct 2025 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ltgxf6Dp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69E313537
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727654; cv=none; b=TY7P8pxM6h4NSObH7NzGgc9cXE92BaGw7p1vZM7YyERXW5TZSuyUhzpuz3ZlrEp2XvHs6YQW+9skGql1o6QZ46jgvNREYRmnnoR9OzYzGEXHRrep8M2Sk+u9oQ9Ocbf2SrcDEGYcpn9Uk2fGvqIkSMUUMeioVGNVUtSDO8Wyuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727654; c=relaxed/simple;
	bh=0/LbIq8FYu8/MpLbsaNJgC3U+0IkScP4kX+eSZTK3xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn7nK2lIPvpIOdj3e7pSIohqttj+j9gDoG+jzZx1+BSWszxiTxwCeCUsL9hsqIICZmIqG66T76ZUSottQJCHRzxsLK08dQ6Dde4wVRzWnFDfV6tVA+v2XiFPUXWwHV6u9TwhLdSzBnafVUE+LbppF8a2vq89nFpavuGwfAlWfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ltgxf6Dp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=keXt38H1uTmvhd6ELqtGFVSawOg4mCXiGWwRI1amyBs=; b=Ltgxf6DpGvKq52Czy/kWUsEHWU
	tPGTEYG5tZnYQKARNRdTWC0RAgXE0h9VanIh9osh9FgavHg+IM/N3qlIeX47WR4uX/HXNRNnGBV4w
	Lzdb3TePvKAGp2uYls+nl8Sczhmo4rOwZ8kjerZPZTihp0+Tj8Dbxh4AcagnpSrmDXQKr0S12K4mo
	S+1pxqzmeRRmCzZPWA6UAGFfGzF9ZpK60Uxnb2QqnalhpxJ2h0RAO0TW3qILXb+yExDdQxAFRKzlv
	j6VDWTV1Z1fLB3cOPdK7lisvKYDPTCPDz/9QFx82laBZUb+fH4rQjYuvTneN8a9rZ6Rt5AVeTJOC+
	Zuohsicw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0yJ-00000006F70-1QcH;
	Wed, 29 Oct 2025 07:51:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F555300220; Wed, 29 Oct 2025 09:47:25 +0100 (CET)
Date: Wed, 29 Oct 2025 09:47:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <20251029084725.GC988547@noisy.programming.kicks-ass.net>
References: <248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com>

On Tue, Oct 28, 2025 at 01:23:30PM -0700, Tim Chen wrote:
> The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
> only one NUMA load balancing operation to run system-wide at a time.
> 
> Currently, each MC group leader in a NUMA domain attempts to acquire
> the global sched_balance_running flag via cmpxchg() before checking
> whether load balancing is due or whether it is the designated leader for
> that NUMA domain. On systems with a large number of cores, this causes
> significant cache contention on the shared sched_balance_running flag.
> 
> This patch reduces unnecessary cmpxchg() operations by first checking
> whether the balance interval has expired. If load balancing is not due,
> the attempt to acquire sched_balance_running is skipped entirely.
> 
> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled,
> running an OLTP workload, 7.8% of total CPU cycles were previously spent
> in sched_balance_domain() contending on sched_balance_running before
> this change.
> 
>          : 104              static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
>          : 105              {
>          : 106              return arch_cmpxchg(&v->counter, old, new);
>     0.00 :   ffffffff81326e6c:       xor    %eax,%eax
>     0.00 :   ffffffff81326e6e:       mov    $0x1,%ecx
>     0.00 :   ffffffff81326e73:       lock cmpxchg %ecx,0x2394195(%rip)        # ffffffff836bb010 <sched_balance_running>
>          : 110              sched_balance_domains():
>          : 12234            if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>    99.39 :   ffffffff81326e7b:       test   %eax,%eax
>     0.00 :   ffffffff81326e7d:       jne    ffffffff81326e99 <sched_balance_domains+0x209>
>          : 12238            if (time_after_eq(jiffies, sd->last_balance + interval)) {
>     0.00 :   ffffffff81326e7f:       mov    0x14e2b3a(%rip),%rax        # ffffffff828099c0 <jiffies_64>
>     0.00 :   ffffffff81326e86:       sub    0x48(%r14),%rax
>     0.00 :   ffffffff81326e8a:       cmp    %rdx,%rax
> 
> After applying this fix, sched_balance_domain() is gone from
> the profile and there is a 8% throughput improvement.
> 

this..

> v2:
> 1. Rearrange the patch to get rid of an indent level per Peter's
>    suggestion.
> 2. Updated the data from new run by OLTP team.
> 
> link to v1: https://lore.kernel.org/lkml/e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com/

... stuff goes under the '---' sign.

Also, what happened to my other suggestion:

  https://lkml.kernel.org/r/20251014092436.GK4067720@noisy.programming.kicks-ass.net

? That seemed like a better place to put things.

