Return-Path: <linux-kernel+bounces-879166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25405C226D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B411405DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9125A35F;
	Thu, 30 Oct 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4i6yXum"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6F2D8370
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860020; cv=none; b=uR/9GKQljdivQRBX79JAPDN8YEvemlgfL0xxvZL88JiLQGlDDQDSEF0q7woLdNfBBRQBLMRU4EeT37Lmx+LiTuAILVIfJ+fKLyoZAicijv+JZ0CR7xU7FUnmGGw9emewxGyuJssXxGlUW3IM6IZpzTxMsqs8kXmUUZfRK+ro7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860020; c=relaxed/simple;
	bh=jgUn8Iji2NckCgVvpA+aHNQusK5waa58ry76dhIn2eU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAY8Hg12Rw03Kwnre4TXfv3BlW4ZNkanh3Hhnyc9S16tjubBIZ/WCR6ZC49pxEu8zDh83AMnJIS4MH27ptEeGLXYMeNRtUP1CwpSm66O68XIo7CUbjNn4d053xUmlE6dQkEoN89iLR36a6I9f/Zo58Gu2YnJsdc6/FJGbrzUwwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4i6yXum; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761860017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BTjF9iBAr+SXjRmdiLA1R0VxivfZSdqF5XNYnvvpZY=;
	b=c4i6yXumYV0qVgbopWsCK0dJKy3SHZcmnifSFPS4ZNUXQYmuRWwEIQnyZHpvf/I59vr83S
	/8F9QRPrzQ1Q3aB0rgpyW5Qw7Lf44QvNTfCPrhhBs7lOGNtME6WtwLpZbZ339PFQRvN02Z
	QOJt2Ja/Gon8peEoxeX6Mn70HVdisRo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-xnOVAUYXNVm6TQLSJI0F6Q-1; Thu, 30 Oct 2025 17:33:35 -0400
X-MC-Unique: xnOVAUYXNVm6TQLSJI0F6Q-1
X-Mimecast-MFC-AGG-ID: xnOVAUYXNVm6TQLSJI0F6Q_1761860015
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a3c5e46a06so436025785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860015; x=1762464815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BTjF9iBAr+SXjRmdiLA1R0VxivfZSdqF5XNYnvvpZY=;
        b=Uk/tTIBEcgdr4ONdW1SPhDt3PE8ba/V4+hOJYWo0127jURjWStpyG2DJEkhe9eiv+X
         iGVCdvNVC18AhIuLBJCYWH/D6QhpL85qOEEimbgEhGlqaEmNbtwDkdoX8+Y4/aJ+y1ZI
         pvMCdAHEeQ8mC1Xat/4/CUKD/G1soUxQp0J1MX5JMT41QeDbI9X1559gfKTWNTyVzGzt
         YI+Uoun3UgQfYC86x5v4VkSVG4M9Sp1nQOPIPvUUlMB1tJaa5QRQMkqbYsye8mVlFJ4g
         HEWm1bXFqaxkKyOh3UTDmdlqmv14rmFb9zfrhw4L8KWhtqqMhYJ+z9k5WXlEZg9RUGNU
         fKig==
X-Forwarded-Encrypted: i=1; AJvYcCV6yTUoIJizUT8P7HwzcluUIL7w6ghOpAY2SbuwRTJY3fdhMNgh1dhVXyq1bXL0tdvQOuMaOCWUUp8f9pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8/gW1v8Y8qowyi/ESlIJ5Dsi7uG7FmuQYwt4NsBCvtaplPiR
	gyj4Pv2iSU9sERCAL3fwd1gs/elURUkU+P5ieVY/pyoLkAvnZuuVtpYBB2yR1Mk5rCXUyFX97tI
	0JddbdUOTTHWar7AnkFlh6Uch76xgMGgKIe55ZWrctrrg2H74nhS+bpa4Da391JzaKA==
X-Gm-Gg: ASbGncvD+DgAyZnBOjNtDeAHrbH9anMNnR0Ut/HCEx82/2bZJQpLi3v87NT5kCtIUI0
	qgkgDfODmUXkZ+A8NPl8yqDS8rbg0k2DQhJZ39jFcEUF76zGCWorR6SfysvgNoIpeiErbrqcfxr
	ZQA3h9k5Mj62/QjT/M00UmYsddH0Hc4PMvYfivbUP/zWQjhyZA7IubMrcAJjrGl7jdefIuk1Grb
	NzZIbiPbEcIqLNbbn4iZoJRGbSDoOwZ1roYS0aDbez9q21QEMb7GMA/e2t3DpLrBlR2XDWSZirE
	FMdcNFDfY4n1ut1gU1lcids7Y3GLN+1F2xuYEa1FqbBQKbv3W6s8e6mgHVjEi/sX3hk=
X-Received: by 2002:a05:620a:470a:b0:866:1327:82e9 with SMTP id af79cd13be357-8ab990ab101mr149323485a.16.1761860015159;
        Thu, 30 Oct 2025 14:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM7NW4gQYEH6hfXUiyF8LoUjp9QHHlpvIxudEkcHo2wWKq5Ki71GgmZpXDDbqRu5pp+Hlprg==
X-Received: by 2002:a05:620a:470a:b0:866:1327:82e9 with SMTP id af79cd13be357-8ab990ab101mr149320985a.16.1761860014633;
        Thu, 30 Oct 2025 14:33:34 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f252ad31dsm1324211985a.27.2025.10.30.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:33:33 -0700 (PDT)
Date: Thu, 30 Oct 2025 17:33:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aQPZqyUUVjexKWaJ@x1.local>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
 <aQPCwFZqNd_ZlZ0S@x1.local>
 <bx3pshg4iwcgbzihgsoxmpubbsecgm5r2x37g3sfriloke7fk3@kbyponznh3sl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bx3pshg4iwcgbzihgsoxmpubbsecgm5r2x37g3sfriloke7fk3@kbyponznh3sl>

On Thu, Oct 30, 2025 at 04:52:26PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251030 15:56]:
> > On Thu, Oct 30, 2025 at 03:07:18PM -0400, Peter Xu wrote:
> > > > Patches are here:
> > > > 
> > > > https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem
> > > 
> > > Great!  Finally we have something solid to discuss on top.
> > > 
> > > Yes, I'm extremely happy to see whatever code there is, I'm happy to review
> > > it.  I'm happy to see it rolling.  If it is better, we can adopt it.
> > 
> > So here is a summary of why I think my proposal is better:
> > 
> > - Much less code
> > 
> >   I think this is crystal clear..  I'm pasting once more in this summary
> >   email on what your proposal touches:
> > 
> >  fs/userfaultfd.c              |  14 +--
> >  include/linux/hugetlb.h       |  21 ----
> >  include/linux/mm.h            |  11 ++
> >  include/linux/shmem_fs.h      |  14 ---
> >  include/linux/userfaultfd_k.h | 108 ++++++++++------
> >  mm/hugetlb.c                  | 359 +++++++++++++++++++++++++++++++++++++++++++++--------
> >  mm/shmem.c                    | 245 ++++++++++++++++++++++++------------
> >  mm/userfaultfd.c              | 869 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------
> >  8 files changed, 962 insertions(+), 679 deletions(-)
> 
> Including the following highlights:
>  -#include <linux/hugetlb.h>
> 
> and
> 
>  -typedef unsigned int __bitwise uffd_flags_t;

So you spent ~1000 LOC for these as highlights..  It's ok, I'll wait for a
second opinion.

> 
> 
> > 
> > - Much less future code
> > 
> >   The new proposal needs at least 6 APIs to implement even minor fault..
> >   One of the API needs to be implemented with uffd_info* which further
> >   includes 10+ fields to process.  It means we'll have a bunch of
> >   duplicated code in the future if new things pop up, so it's not only
> >   about what we merge.
> 
> You can reuse existing functions if there is no change.
> 
> > 
> > - Much less exported functions to modules
> 
> I haven't exported anything.  You asked for code and I provided it.
> This doesn't do what guest_memfd needs as it is.  This is all clean up
> you wouldn't do.
> 
> > 
> >   My solution, after exposing vm_uffd_ops, doesn't need to export any
> >   function.
> > 
> >   Your solution needs to export a lot of new functions to modules.  I
> >   didn't pay a lot of attention but the list should at least include these
> >   10 functions:
> >   
> >         void uffd_complete_register(struct vm_area_struct *vma);
> >         unsigned int uffd_page_shift(struct vm_area_struct *vma);
> >         int uffd_writeprotect(struct uffd_info *info);
> >         ssize_t uffd_failed_do_unlock(struct uffd_info *info);
> >         int uffd_atomic_pte_copy(struct folio *folio, unsigned long src_addr);
> >         unsigned long mfill_size(struct vm_area_struct *vma)
> >         int mfill_atomic_pte_poison(struct uffd_info *info);
> >         int mfill_atomic_pte_copy(struct uffd_info *info);
> >         int mfill_atomic_pte_zeropage(struct uffd_info *info);
> >         ssize_t uffd_get_dst_pmd(struct vm_area_struct *dst_vma, unsigned long dst_addr,pmd_t **dst_pmd);
> > 
> >   It's simply unnecessary.
> 
> Maybe we don't export any of them.  Maybe there's another function
> pointer that could be checked or overwritten?  We can do that without a
> flag or setting or wahtever the name you used for your flag was.

You need to export them when guest-memfd will be involved, am I right?

> 
> > 
> > - Less error prone
> > 
> >   At least to support minor fault, my solution only needs one hook fetching
> >   page cache, then set the CONTINUE ioctl in the supported_ioctls.
> 
> Your code just adds more junk to uffd, and fails to modularize anything
> beyond getting a folio.  And you only support certain types and places.

So would CoC accepts "junk" in this context?

> 
> > 
> > - Safer
> > 
> >   Your code allows to operate on pmd* in a module??? That's too risky and
> >   mm can explode!  Isn't it?
> 
> Again. I didn't export anything.
> 
> > 
> > - Do not build new codes on top of hugetlbfs
> > 
> >   AFAICT, more than half of your solution's API is trying to service
> >   hugetlbfs.  IMHO that's the wrong way to go.  I explained to you multiple
> >   times.  We should either keep hugetlbfs alone, or having hugetlbfs adopt
> >   mm APIs instead.  We shouldn't build any new code only trying to service
> >   hugetlbfsv1 but nobody else.  We shouldn't introduce new mm API only to
> >   service hugetlbfs.
> 
> Ignoring hugetlb exists is a problem.  I have removed the hugetlb from
> being included in uffd while you have left it in its own loop.  This
> doesn't build new things on hugetlb, it moves the code for hugetlb out
> of mm/userfaultfd.c - how is it building on hugetlb?

The APIs you introduced is building for hugetlb.  If without hugetlb, more
than half of the API is not needed.

> 
> Believe it or not, hugetlb is a memory type.
> 
> Certainly smaller changes are inherently less bug prone.  I honestly
> think all of what I have here needs to be done, regardless of memfd
> support.  I cannot believe that things were allowed to be pushed this
> far.  I do not think they should be allowed to go further.
> 
> > 
> > - Much less risk of breaking things
> > 
> >   I'm pretty sure my code introduce zero or very little bug, if there's
> >   one, I'll fix it, but really, likely not, because the changes are
> >   straightforward.
> > 
> >   Your changes are huge.  I would not be surprised you break things here
> >   and there.  I hope at least you will be around fixing them when it
> >   happens, even if we're not sure the benefits of most of the changes.
> 
> I have always been prompt in fixing my issues and have taken
> responsibility for anything I've written.  I maintain the maple tree and
> other areas of mm.  I have no plans of leaving Linux and I hope not to
> die.
> 
> I can maintain mm/userfaultfd.c, if that helps.  I didn't feel like I
> knew the area enough before, but I'm learning a lot doing this.

I'm not maintainer of userfaultfd, I'm a reviewer.  I was almost just
trying to help, in reality that is also true that obviously I don't make
decisions.

I definitely think you can at least propose add yourself as a reviewer if
you like to start looking after userfaultfds, or even M if Andrew likes it.

You're already listed as core mm R so I don't see much difference if it's
only a R addition.

-- 
Peter Xu


