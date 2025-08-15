Return-Path: <linux-kernel+bounces-771294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BCB2853C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838327B95B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE85317701;
	Fri, 15 Aug 2025 17:38:03 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4183176F7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279483; cv=none; b=d08SDEzA0Nig2fBTWlLHkjCrTh9w4GGQrc5XKGeF+Qgz7RUfWqEts/mHhK6BwSlRwlBsZ2j0oztKgnVjHai//8rhbBJb+F6t2jC+5WfYF0iSHXY0MAj7fb2dQeqlZR0MUcIdwbFXTwr27JdkXrRkaNCJxKBRwrokZk5FkUcELsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279483; c=relaxed/simple;
	bh=122jLdmAfkEvNJQZzQRq+OrAt1kQ0FibmKg0Lmc9H20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u19ei9EP1vHEH3L4GrOXQL8hDzPAJ6MQMpfqvy1SwXbE0EDVkaPafJ8s6vyiB6EONg1VDFDjJzSbObalHuIbzqKdtYD/FOPbBbe6EjIf6JNhosHRC5hvvsGkHJEl01aO7PDnXrWhOgL/3JwhdKHhh3K2KmKTzfCqApnA+rPtm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c3TpP1ZcfzYpCvG;
	Sat, 16 Aug 2025 01:37:49 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 01:37:57 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 01:37:54 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <lorenzo.stoakes@oracle.com>
CC: <akpm@linux-foundation.org>, <andrealmeid@igalia.com>,
	<dave@stgolabs.net>, <dvhart@infradead.org>, <feng.han@honor.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <liulu.liu@honor.com>, <mhocko@suse.com>,
	<mingo@redhat.com>, <npache@redhat.com>, <peterz@infradead.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <tglx@linutronix.de>,
	<zhongjinji@honor.com>
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap() traverse the maple tree in opposite orders
Date: Sat, 16 Aug 2025 01:37:50 +0800
Message-ID: <20250815173750.15323-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8e20a389-9733-4882-85a0-b244046b8b51@lucifer.local>
References: <8e20a389-9733-4882-85a0-b244046b8b51@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

> 
> On Thu, Aug 14, 2025 at 09:55:55PM +0800, zhongjinji@honor.com wrote:
> > From: zhongjinji <zhongjinji@honor.com>
> >
> > When a process is OOM killed, if the OOM reaper and the thread running
> > exit_mmap() execute at the same time, both will traverse the vma's maple
> > tree along the same path. They may easily unmap the same vma, causing them
> > to compete for the pte spinlock. This increases unnecessary load, causing
> > the execution time of the OOM reaper and the thread running exit_mmap() to
> > increase.
> 
> You're not giving any numbers, and this seems pretty niche, you really
> exiting that many processes with the reaper running at the exact same time
> that this is an issue? Waiting on a spinlock also?
> 
> This commit message is very unconvincing.

Thank you, I will reconfirm this issue.

> 
> >
> > When a process exits, exit_mmap() traverses the vma's maple tree from low to high
> > address. To reduce the chance of unmapping the same vma simultaneously,
> > the OOM reaper should traverse vma's tree from high to low address. This reduces
> > lock contention when unmapping the same vma.
> 
> Are they going to run through and do their work in exactly the same time,
> or might one 'run past' the other and you still have an issue?
> 
> Seems very vague and timing dependent and again, not convincing.

well, Thank you, I should capture a perf trace for the oom reaper, not perfetto.

> 
> >
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > ---
> >  include/linux/mm.h | 3 +++
> >  mm/oom_kill.c      | 9 +++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0c44bb8ce544..b665ea3c30eb 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -923,6 +923,9 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
> >  #define for_each_vma_range(__vmi, __vma, __end)				\
> >  	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
> >
> > +#define for_each_vma_reverse(__vmi, __vma)					\
> > +	while (((__vma) = vma_prev(&(__vmi))) != NULL)
> 
> Please don't casually add an undocumented public VMA iterator hidden in a
> patch doing something else :)

sorry, I got it.

> 
> Won't this skip the first VMA? Not sure this is really worth having as a
> general thing anyway, it's not many people who want to do this in reverse.
> 
> > +
> >  #ifdef CONFIG_SHMEM
> >  /*
> >   * The vma_is_shmem is not inline because it is used only by slow
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 7ae4001e47c1..602d6836098a 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -517,7 +517,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> >  {
> >  	struct vm_area_struct *vma;
> >  	bool ret = true;
> > -	VMA_ITERATOR(vmi, mm, 0);
> > +	VMA_ITERATOR(vmi, mm, ULONG_MAX);
> >
> >  	/*
> >  	 * Tell all users of get_user/copy_from_user etc... that the content
> > @@ -527,7 +527,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> >  	 */
> >  	set_bit(MMF_UNSTABLE, &mm->flags);
> >
> > -	for_each_vma(vmi, vma) {
> > +	/*
> > +	 * When two tasks unmap the same vma at the same time, they may contend for the
> > +	 * pte spinlock. To avoid traversing the same vma as exit_mmap unmap, traverse
> > +	 * the vma maple tree in reverse order.
> > +	 */
> 
> Except you won't necessarily avoid anything, as if one walker is faster
> than the other they'll run ahead, plus of course they'll have a cross-over
> where they share the same PTE anyway.
> 
> I feel like maybe you've got a fairly specific situation that indicates an
> issue elsewhere and you're maybe solving the wrong problem here?

Thank you, I will reconfirm this issue.

> 
> > +	for_each_vma_reverse(vmi, vma) {
> >  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> >  			continue;
> >
> > --
> > 2.17.1
> >
> >



