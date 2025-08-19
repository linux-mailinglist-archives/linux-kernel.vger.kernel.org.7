Return-Path: <linux-kernel+bounces-776078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB50B2C852
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0855672BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022922848BA;
	Tue, 19 Aug 2025 15:18:48 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65728466F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616727; cv=none; b=knbx9nXql5Wim9z3ozzQM/T6mOAw6Lzpj1vwoxLlZSPSIATGSBu1YgSZsJpkCnmIt+zZk18aZKhVBzJ5IwsDVXIPowRR6w+jNXL/5w+1ASXb3G3oIx9HoqCJuorvqs453Ckq1FjtUpYnqWNPjHJTDCV0Fy3AMPo95R5PQHlqhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616727; c=relaxed/simple;
	bh=2hwehRl4m0bP09+TjQDntl69EqVhTE7Aaa1gfgbBp3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkGu+ux6PwH6cfXuWaNygg/9jrmfXefoZopyWFqAKbaR3+L9Lv5s7XzS3U6yIQZssvEwbyodjgOOpyBUyPjBYR/AbCif7PyKMN9/ZQ7zwhcRL5aePAcqcjLkfhIxCnsDKlOU++/jX99AefYZ02bBKpr6He/B/+2DeiTTBWwmHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c5tWm0mcszYlXBY;
	Tue, 19 Aug 2025 23:18:28 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 23:18:39 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 23:18:38 +0800
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
Date: Tue, 19 Aug 2025 23:18:34 +0800
Message-ID: <20250819151834.20414-1-zhongjinji@honor.com>
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
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

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

This is the perf data: the first one is without this patch applied, and the
second one is with this patch applied.  It is obvious that without this patch,
the lock contention on the pte spinlock will be very intense.

|--99.74%-- oom_reaper
|    |--76.67%-- unmap_page_range
|    |    |--33.70%-- __pte_offset_map_lock
|    |    |    |--98.46%-- _raw_spin_lock
|    |    |--27.61%-- free_swap_and_cache_nr
|    |    |--16.40%-- folio_remove_rmap_ptes
|    |    |--12.25%-- tlb_flush_mmu
|    |--12.61%-- tlb_finish_mmu


|--98.84%-- oom_reaper
|    |--53.45%-- unmap_page_range
|    |    |--24.29%-- [hit in function]
|    |    |--48.06%-- folio_remove_rmap_ptes
|    |    |--17.99%-- tlb_flush_mmu
|    |    |--1.72%-- __pte_offset_map_lock
|    |
|    |--30.43%-- tlb_finish_mmu

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
> 
> Won't this skip the first VMA? Not sure this is really worth having as a
> general thing anyway, it's not many people who want to do this in reverse.

I got it. mas_find_rev() should be used instead of vma_prev().

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
> 
> > +	for_each_vma_reverse(vmi, vma) {
> >  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> >  			continue;
> >
> > --
> > 2.17.1
> >
> >

