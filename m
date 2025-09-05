Return-Path: <linux-kernel+bounces-802266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E05B45015
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEF67B0541
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A43261B64;
	Fri,  5 Sep 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT53coIe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9FF257825
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058033; cv=none; b=msL4zko7bR2Ah32Y97oKRfrPZN8wxPHbOwrIFpx6hlUZYMofDkyj71ZjYq0atUaOICNjU9770rTY2msA9li3xKgcHegSVwoj1vfJUTQRKBeEM5wKr1cvhOsdB4vJ9IWFAuAHjoSsywRTuegzjXdyAR4htlvvLGfE6T/9X8lXY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058033; c=relaxed/simple;
	bh=8UKw6qV+Fp9Btn+/AfFbnwNu4EeEIhUSHPGO2BLKRVk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urznD4ha51qvMANM0fFCUuHPQ5kr7AjICNtzC17kKecTRgYVpA9xtLQv828rJAfShL9OT2DMXfInNfJm35oGuPA6TBNRgtLFQHH0CSx++Lp5c6Qh8AyNcYko4iNc6uDTNnHTwW0cUGMFCYSj5/YzltruipCmuLdh0MGI1i7tJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT53coIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FECC4CEF1;
	Fri,  5 Sep 2025 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757058033;
	bh=8UKw6qV+Fp9Btn+/AfFbnwNu4EeEIhUSHPGO2BLKRVk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=mT53coIe6u+FbsfjBU1Qu0I0ndzTHQnBZTnkprg1+cQO85N9TkB+L73GC+CnbNCs9
	 fFg7ptRLcnM77drww+TIHh8PMsbMKi6o4kmXdKfF0ImRIfY6ufE9lUnxEsCCyhc2ld
	 sKf9R9GlYPQikEjAzKR+xV/pq6Hsp3vVa7lKI/sxWjocRmTVuaXgfouj9ejOp2JP0V
	 PzSu2DOZkbiioOmV17nqpR1kLXcga4C1jCVKTlYOEYXzX5Pw5sl9FQjqjRr0KKEDeC
	 nXo/lXiC70ZYJU6TEcQ5Tlorm2QkkaGUoj+AElEEiVgPkCFBQvDvXvUPzhq/303++1
	 zD9YcYMstQjkA==
Date: Fri, 5 Sep 2025 10:40:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	akpm@linux-foundation.org, minchan@kernel.org,
	kernel-team@android.com, android-mm@google.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
Message-ID: <aLqT6M6xgvEREQu6@kernel.org>
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <827c844f-7106-4f62-a108-1f83544aa56e@lucifer.local>
 <43ryds7hzhs5bpaxznco7fppmakdb4f46agwtsc5erudqfoz2x@7y4jgbtft7jj>
 <413ee338-1795-433c-b3d4-72c870488d95@lucifer.local>
 <84aad392-3bff-4f98-b612-5e9a046edb36@redhat.com>
 <CAC_TJvc=5=iS8gCumJWqH5eF4XufFSogqtWHJmiH5WBN1A6gng@mail.gmail.com>
 <4chxl7uxr4exy2z2dcshxla3c5nzzo2tbnelsbbky7pdzrih6a@hzfnpbenfmub>
 <8e1881b8-3867-4cea-b03e-50c05ed8148d@redhat.com>
 <e3lsreaj3gpqgt6l32edvyjbiscekyezhosaew3lgu4xvbwmsv@2bfpvwtl4bpe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3lsreaj3gpqgt6l32edvyjbiscekyezhosaew3lgu4xvbwmsv@2bfpvwtl4bpe>

On Thu, Sep 04, 2025 at 03:11:46PM -0400, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [250904 15:02]:
> > On 04.09.25 20:49, Liam R. Howlett wrote:
> > > * Kalesh Singh <kaleshsingh@google.com> [250904 13:51]:
> > > > On Thu, Sep 4, 2025 at 10:42 AM David Hildenbrand <david@redhat.com> wrote:
> > > > > 
> > > > > On 04.09.25 19:33, Lorenzo Stoakes wrote:
> > > > > > On Thu, Sep 04, 2025 at 01:22:51PM -0400, Liam R. Howlett wrote:
> > > > > > > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > > > > > > index e618a706aff5..793fad58302c 100644
> > > > > > > > > --- a/mm/mremap.c
> > > > > > > > > +++ b/mm/mremap.c
> > > > > > > > > @@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
> > > > > > > > >      * We'd prefer to avoid failure later on in do_munmap:
> > > > > > > > >      * which may split one vma into three before unmapping.
> > > > > > > > >      */
> > > > > > > > > -  if (current->mm->map_count >= sysctl_max_map_count - 3)
> > > > > > > > > +  if (exceeds_max_map_count(current->mm, 4))
> > > > > > > > >             return -ENOMEM;
> > > > > > > > 
> > > > > > > > In my version this would be:
> > > > > > > > 
> > > > > > > >      if (map_count_capacity(current->mm) < 4)
> > > > > > > >              return -ENOMEM;
> > > > > > > > 
> > > > > > > 
> > > > > > > Someone could write map_count_capacity(current->mm) <= 4 and reintroduce
> > > > > > > what this is trying to solve.  And with the way it is written in this
> > > > > > > patch, someone could pass in the wrong number.
> > > > > > 
> > > > > > Right, but I think 'capacity' is pretty clear here, if the caller does something
> > > > > > silly then that's on them...
> > > > > > 
> > > > > > > 
> > > > > > > I'm not sure this is worth doing.  There are places we allow the count
> > > > > > > to go higher.
> > > > > > 
> > > > > > ...But yeah, it's kinda borderline as to how useful this is.
> > > > > > 
> > > > > > I _do_ however like the 'put map count in one place statically' rather than
> > > > > > having a global, so a minimal version of this could be to just have a helper
> > > > > > function that gets the sysctl_max_map_count, e.g.:
> > > > > > 
> > > > > > if (current->mm->mmap_count >= max_map_count() - 3)
> > > > > 
> > > > > I enjoy seeing sysctl_max_map_count hidden. But map_count_capacity() is
> > > > > even more readable, so I like it.
> > > > > 
> > > > > I don't complete like the "capacity" term, but I cannot think of
> > > > > something better right now. Maybe something around "free" or
> > > > > "remaining", not sure.
> > > > > 
> > > > > I also don't completely like "map_count" (I know, I know, we call it
> > > > > like that in structures), because it reminds me of the mapcount ...
> > > > > talking somehow about "vmas" would be quite clear.
> > > > 
> > > > Thanks David, my original implementation started with vma_limit() :).
> > > > Maybe something like vma_count_remaining() ?
> > > 
> > > Yes, reducing this confusion would very much be helpful.  In fact, if
> > > you put it in its own function we could change the actual name with
> > > lower impact.  map_count vs mapcount is annoying.
> > > 
> > > vma_headroom() ?
> > > additional_vma_space() ?
> > 
> > VMA space might be interpreted as VA space.
> 
> Fair enough.
> 
> > 
> > I think basing it on "vma_count" would be good.
> > 
> > vma_count_capacity()
> > 
> > vma_count_headroom()
> > 
> > vma_count_remaining()
> 
> headroom or remaining have my vote as the clearest.

I like 'remaining' more
 
> > vma_count_avail()
> > 
> > vma_count_left()
> > 

-- 
Sincerely yours,
Mike.

