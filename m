Return-Path: <linux-kernel+bounces-803696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFEB463D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10ED65C3FEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309C280A52;
	Fri,  5 Sep 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb25GASt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1927FD49
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101443; cv=none; b=KFzRSqEYRD0V4BgWjKhDH+SsTGjiAlww2mQo4oZ3/960bplmh4XCkVIvZR/vf6qnR10+ReLY0xyPWDvieZl2HbFYpQHSmBJup9gspyeRbB6SAA7TOAMnBxZXF9b//XR2yxUoK+fReHz9I1w6cprEKRl/TiSy98hefxQyIEmqfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101443; c=relaxed/simple;
	bh=qj5NWqYmLfQgUNyQbHqhOAioJ4HtjEhlRLgfXr/ggm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL9h5jCKvfW7U8sBTSZ3ocwljbDN+/BLk7FG08M2tyrDxRgSjV7XGbORkmR/wWpP0IgYgU2ua9bwlhFJKR60KIcZVNcLVMtkGpiSDlKpkA3CoTnXdx5Pw8pDBJJ2TqHXLkwwnofn9EAmbom6ElDyqFhYkaZnB9Ay3g1eCSoY3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb25GASt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895DBC4CEF1;
	Fri,  5 Sep 2025 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757101442;
	bh=qj5NWqYmLfQgUNyQbHqhOAioJ4HtjEhlRLgfXr/ggm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gb25GAStY7PK4KWfMQC7rtd4cff2Ft31RumZ/kNKywLAXwUdYfICHHIJhBPjrZ6j7
	 o7iHpATbrIqVl1AYu1jaVpoUr8IlvHC34mB3TyehId4+9gUdLyyv/gHHn98jalOtC0
	 MX2S360mJGGFkZmz2ogHqkD/MgCf/035PnB2I9Wq5ZfXBWK5fpwd1RbY1MXhtqJPld
	 H5GqrWgLYTQargRJ06fYCqqcMjdxQlMgkFIz1Gqzc+2aRDBKLVXuNsb4wASbw6IEl6
	 597PZCICEO+V0BK33bDDozHnZlGhmt7NvXrmXSlYdy89LJVzrbcrFORdWilzQ/GPWA
	 8B6Fa0HYYbdnA==
Date: Fri, 5 Sep 2025 12:43:59 -0700
From: Minchan Kim <minchan@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, kernel-team@android.com,
	android-mm@google.com, David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
Message-ID: <aLs9f9WjxIOrE3Sr@google.com>
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r>

On Thu, Sep 04, 2025 at 12:46:34AM +0100, Pedro Falcato wrote:
> On Wed, Sep 03, 2025 at 04:24:35PM -0700, Kalesh Singh wrote:
> > The check against the max map count (sysctl_max_map_count) was
> > open-coded in several places. This led to inconsistent enforcement
> > and subtle bugs where the limit could be exceeded.
> > 
> > For example, some paths would check map_count > sysctl_max_map_count
> > before allocating a new VMA and incrementing the count, allowing the
> > process to reach sysctl_max_map_count + 1:
> > 
> >     int do_brk_flags(...)
> >     {
> >         if (mm->map_count > sysctl_max_map_count)
> >             return -ENOMEM;
> > 
> >         /* We can get here with mm->map_count == sysctl_max_map_count */
> > 
> >         vma = vm_area_alloc(mm);
> >         ...
> >         mm->map_count++   /* We've now exceeded the threshold. */
> >     }
> 
> I think this should be fixed separately, and sent for stable.
> 
> > 
> > To fix this and unify the logic, introduce a new function,
> > exceeds_max_map_count(), to consolidate the check. All open-coded
> > checks are replaced with calls to this new function, ensuring the
> > limit is applied uniformly and correctly.
> 
> Thanks! In general I like the idea.
> 
> > 
> > To improve encapsulation, sysctl_max_map_count is now static to
> > mm/mmap.c. The new helper also adds a rate-limited warning to make
> > debugging applications that exhaust their VMA limit easier.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  include/linux/mm.h | 11 ++++++++++-
> >  mm/mmap.c          | 15 ++++++++++++++-
> >  mm/mremap.c        |  7 ++++---
> >  mm/nommu.c         |  2 +-
> >  mm/util.c          |  1 -
> >  mm/vma.c           |  6 +++---
> >  6 files changed, 32 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1ae97a0b8ec7..d4e64e6a9814 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct page *page)
> >  #define MAPCOUNT_ELF_CORE_MARGIN	(5)
> >  #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
> >  
> > -extern int sysctl_max_map_count;
> > +/**
> > + * exceeds_max_map_count - check if a VMA operation would exceed max_map_count
> > + * @mm: The memory descriptor for the process.
> > + * @new_vmas: The number of new VMAs the operation will create.
> > + *
> > + * Returns true if the operation would cause the number of VMAs to exceed
> > + * the sysctl_max_map_count limit, false otherwise. A rate-limited warning
> > + * is logged if the limit is exceeded.
> > + */
> > +extern bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas);
> 
> No new "extern" in func declarations please.
> 
> >  
> >  extern unsigned long sysctl_user_reserve_kbytes;
> >  extern unsigned long sysctl_admin_reserve_kbytes;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 7306253cc3b5..693a0105e6a5 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  		return -EOVERFLOW;
> >  
> >  	/* Too many mappings? */
> > -	if (mm->map_count > sysctl_max_map_count)
> > +	if (exceeds_max_map_count(mm, 0))
> >  		return -ENOMEM;
> 
> If the brk example is incorrect, isn't this also wrong? /me is confused
> >  
> >  	/*
> > @@ -1504,6 +1504,19 @@ struct vm_area_struct *_install_special_mapping(
> >  int sysctl_legacy_va_layout;
> >  #endif
> >  
> > +static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
> > +
> > +bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas)
> > +{
> > +	if (unlikely(mm->map_count + new_vmas > sysctl_max_map_count)) {
> > +		pr_warn_ratelimited("%s (%d): Map count limit %u exceeded\n",
> > +				    current->comm, current->pid,
> > +				    sysctl_max_map_count);
> 
> I'm not entirely sold on the map count warn, even if it's rate limited. It
> sounds like something you can hit in nasty edge cases and nevertheless flood
> your dmesg (more frustrating if you can't fix the damn program).

How about dynamic_debug?

a1394bddf9b6, mm: page_alloc: dump migrate-failed pages

