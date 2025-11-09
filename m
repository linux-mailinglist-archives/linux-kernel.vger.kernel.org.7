Return-Path: <linux-kernel+bounces-891825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8BC439B6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C56E84E4953
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607742690D1;
	Sun,  9 Nov 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVKWhFcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CE24A05D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672316; cv=none; b=m0EFdISPGYsKZlwGCp9gDxrHBbLG7s0uHaYZakhcpToVCW+PUpyXOpbdkS1VVokfGFib1dyFk3NP4udneVApc2Ny87MeoqmP1HnK1Ey85otwU6Bxl+FmbRB8KUE42ZAmRlSdM3nszmr5uaK2muP0IjFns161tJKQ+096dAJtd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672316; c=relaxed/simple;
	bh=fz6YEmNbySw049IgPi0sWFOajARsPNxOfb00HrLa7F8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwltEva02oui2YO1dFG2BdmhPCDuj2rro68hI/bRCtL1AmBiHX3WOEtSgBlcOwpnNBXmPjEvGS3fgLGQEf0vtXno3NSaxje+NOtByN2ssOgG/bkpv1qbw6Q3Wt+CFw1coV7y+j9JmaD8naC0rugxLID4QMngN1TSi0U+CGgGDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVKWhFcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D66C4CEF8;
	Sun,  9 Nov 2025 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762672316;
	bh=fz6YEmNbySw049IgPi0sWFOajARsPNxOfb00HrLa7F8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=VVKWhFcmmgsl0CgGP3/akeP+0Deoi+k93/1z4vFV2wLPYduROhSgadLQkVRPas+ct
	 bXGtRL2xpjdwXydNiHc4niRWU3TVWR1KVz9Sk5iIXyx5yrFTu1d04HgF7JEHWJSAs+
	 zZe49jXIXS+EHNDOJFKdv27ji6NG0rMhyuLEKouXGZCNafwjes6GENkhi1UbW5CIB1
	 DUVR32kpzIqm6aG2/azj7wGzkR1hP39Obw+X4edU0YSRM0EZxYBlclJNh6ztFzEUJG
	 E0gdub8CEQJVy/junBGUitqhCWn0BrVwHk5Sx4K78HKJm95/a7Htmn+t2cjjGQh+a5
	 sMVUNSCPeCT4A==
Date: Sun, 9 Nov 2025 09:11:45 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, conduct@kernel.org
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aRA-se6hJPzHD3mA@kernel.org>
References: <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
 <aQPCwFZqNd_ZlZ0S@x1.local>
 <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
 <aQPU-tyo_w68cnKK@x1.local>
 <7768bbb5-f060-45f7-b584-95bd73c47146@kernel.org>
 <aQkUwbx7Z4q1qcSB@x1.local>
 <5f128cbf-7210-42d9-aca1-0a5ed20928c2@kernel.org>
 <aQmplrpNjvCVjWb_@kernel.org>
 <mnjrtg62qh2rd353mbudryvs3neukt26xtovyddm5uosxurmfi@lldnrp7a3666>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnjrtg62qh2rd353mbudryvs3neukt26xtovyddm5uosxurmfi@lldnrp7a3666>

Hi Liam,

On Thu, Nov 06, 2025 at 11:32:46AM -0500, Liam R. Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [251104 02:22]:
> > On Mon, Nov 03, 2025 at 10:27:05PM +0100, David Hildenbrand (Red Hat) wrote:
> > > 
> > > And maybe that's the main problem here: Liam talks about general uffd
> > > cleanups while you are focused on supporting guest_memfd minor mode "as
> > > simple as possible" (as you write below).
> > 
> > Hijacking for the technical part for a moment ;-)
> > 
> > It seems that "as simple as possible" can even avoid data members in struct
> > vm_uffd_ops, e.g something along these lines:
> 
> I like this because it removes the flag.
> 
> If we don't want to return the folio, we could modify the
> mfill_atomic_pte_continue() to __mfill_atomic_pte_continue() which takes
> a function pointer and have the callers pass a different get_folio() by
> memory type.  Each memory type (anon, shmem, and guest_memfd) would have
> a small stub that would be set in the vm_ops.

I'm not sure I follow you here.
What do you mean by "don't want to return the folio"? 

Isn't ->minor_get_folio() is already a different get_folio() by memory
type?

> It also looks similar to vma_get_uffd_ops() in 1fa9377e57eb1
> ("mm/userfaultfd: Introduce userfaultfd ops and use it for destination
> validation") [1].  But I always returned a uffd ops, which passes all
> uffd testing.  When would your NULL uffd ops be hit?  That is, when
> would uffd_ops not be set and not be anon?

The patch is a prototype. Quite possibly you are right and there's no need
to return NULL there.
 
> [1].  https://git.infradead.org/?p=users/jedix/linux-maple.git;a=blobdiff;f=mm/userfaultfd.c;h=e2570e72242e5a350508f785119c5dee4d8176c1;hp=e8341a45e7e8d239c64f460afeb5b2b8b29ed853;hb=1fa9377e57eb16d7fa579ea7f8eb832164d209ac;hpb=2166e91882eb195677717ac2f8fbfc58171196ce
> 
> Thanks,
> Liam
> 
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index d16b33bacc32..840986780cb5 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -605,6 +605,8 @@ struct vm_fault {
> >  					 */
> >  };
> >  
> > +struct vm_uffd_ops;
> > +
> >  /*
> >   * These are the virtual MM functions - opening of an area, closing and
> >   * unmapping it (needed to keep files on disk up-to-date etc), pointer
> > @@ -690,6 +692,9 @@ struct vm_operations_struct {
> >  	struct page *(*find_normal_page)(struct vm_area_struct *vma,
> >  					 unsigned long addr);
> >  #endif /* CONFIG_FIND_NORMAL_PAGE */
> > +#ifdef CONFIG_USERFAULTFD
> > +	const struct vm_uffd_ops *uffd_ops;
> > +#endif
> >  };
> >  
> >  #ifdef CONFIG_NUMA_BALANCING
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index c0e716aec26a..aac7ac616636 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -111,6 +111,11 @@ static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_at
> >  /* Flags controlling behavior. These behavior changes are mode-independent. */
> >  #define MFILL_ATOMIC_WP MFILL_ATOMIC_FLAG(0)
> >  
> > +struct vm_uffd_ops {
> > +	int (*minor_get_folio)(struct inode *inode, pgoff_t pgoff,
> > +			       struct folio **folio);
> > +};
> > +
> >  extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
> >  				    struct vm_area_struct *dst_vma,
> >  				    unsigned long dst_addr, struct page *page,
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b9081b817d28..b4318ad3bdf9 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -3260,6 +3260,17 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
> >  	shmem_inode_unacct_blocks(inode, 1);
> >  	return ret;
> >  }
> > +
> > +static int shmem_uffd_minor_get_folio(struct inode *inode, pgoff_t pgoff,
> > +				      struct folio **folio)
> > +{
> > +	return shmem_get_folio(inode, pgoff, 0, folio, SGP_NOALLOC);
> > +}
> > +
> > +static const struct vm_uffd_ops shmem_uffd_ops = {
> > +	.minor_get_folio = shmem_uffd_minor_get_folio,
> > +};
> > +
> >  #endif /* CONFIG_USERFAULTFD */
> >  
> >  #ifdef CONFIG_TMPFS
> > @@ -5292,6 +5303,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
> >  	.set_policy     = shmem_set_policy,
> >  	.get_policy     = shmem_get_policy,
> >  #endif
> > +#ifdef CONFIG_USERFAULTFD
> > +	.uffd_ops	= &shmem_uffd_ops,
> > +#endif
> >  };
> >  
> >  static const struct vm_operations_struct shmem_anon_vm_ops = {
> > @@ -5301,6 +5315,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
> >  	.set_policy     = shmem_set_policy,
> >  	.get_policy     = shmem_get_policy,
> >  #endif
> > +#ifdef CONFIG_USERFAULTFD
> > +	.uffd_ops	= &shmem_uffd_ops,
> > +#endif
> >  };
> >  
> >  int shmem_init_fs_context(struct fs_context *fc)
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index af61b95c89e4..6b30a8f39f4d 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -20,6 +20,20 @@
> >  #include "internal.h"
> >  #include "swap.h"
> >  
> > +static const struct vm_uffd_ops anon_uffd_ops = {
> > +};
> > +
> > +static inline const struct vm_uffd_ops *vma_get_uffd_ops(struct vm_area_struct *vma)
> > +{
> > +	if (vma->vm_ops && vma->vm_ops->uffd_ops)
> > +		return vma->vm_ops->uffd_ops;
> > +
> > +	if (vma_is_anonymous(vma))
> > +		return &anon_uffd_ops;
> > +
> > +	return NULL;
> > +}
> > +
> >  static __always_inline
> >  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
> >  {
> > @@ -382,13 +396,14 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
> >  				     unsigned long dst_addr,
> >  				     uffd_flags_t flags)
> >  {
> > +	const struct vm_uffd_ops *uffd_ops = vma_get_uffd_ops(dst_vma);
> >  	struct inode *inode = file_inode(dst_vma->vm_file);
> >  	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> >  	struct folio *folio;
> >  	struct page *page;
> >  	int ret;
> >  
> > -	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
> > +	ret = uffd_ops->minor_get_folio(inode, pgoff, &folio);
> >  	/* Our caller expects us to return -EFAULT if we failed to find folio */
> >  	if (ret == -ENOENT)
> >  		ret = -EFAULT;
> > @@ -707,6 +722,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
> >  	unsigned long src_addr, dst_addr;
> >  	long copied;
> >  	struct folio *folio;
> > +	const struct vm_uffd_ops *uffd_ops;
> >  
> >  	/*
> >  	 * Sanitize the command parameters:
> > @@ -766,10 +782,11 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
> >  		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
> >  					     src_start, len, flags);
> >  
> > -	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> > +	uffd_ops = vma_get_uffd_ops(dst_vma);
> > +	if (!uffd_ops)
> >  		goto out_unlock;
> > -	if (!vma_is_shmem(dst_vma) &&
> > -	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE) &&
> > +	    !uffd_ops->minor_get_folio)
> >  		goto out_unlock;
> >  
> >  	while (src_addr < src_start + len) {
> >  
> > -- 
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.

