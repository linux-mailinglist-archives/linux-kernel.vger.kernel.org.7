Return-Path: <linux-kernel+bounces-878965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57693C21DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 731144EC75F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDC937DBCF;
	Thu, 30 Oct 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnD6wWTB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350F374ABA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851248; cv=none; b=RfBPLuqlk0M+7BHUv6iAYd45yuSd0h6QzjCQ0fFL/z1lXxczOBTNxLlucyC6q79mgXnqYyIv8ZI0REkrpALwUZxm/Brv1aluw9Tf0ALzUA9QYasiDklVl6L0ffk8dUL8apjXM/JelOIacJVj8Paq7Itj8kZ5R64bOVWGylLXILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851248; c=relaxed/simple;
	bh=8Htz0GJochmj2Pe68386NmR7ROXoeJ+FBBnk3JrlxaQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6XKawKdS/bT+K2ZWR5rQJV7NTbiS2clAgwaZf3Z7OaA607WcioXUgFdXhndGv4a6iIkWYIthVbo5RnMIFneQ0MPtZKqLnN0wXW/LAHfwGbzaGanrx3vpXOA1+TMONo2LgZH52yKTyDnAB2q29tc7+CvnfDYSlqScnVUYSY0RYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnD6wWTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761851244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Y7S1Zgr4iVGtRsh64LfgvKoH0XA8jwp4qVFPtKmeeA=;
	b=HnD6wWTBuKVuB+CvbcKv97XxfK8wwM12EaFBwBM2BzqomM+GlPBRuMzpU1FMCMyOslx6jc
	n34dyYu5M6CAebJi1z/4cDiPRXyFnIY8HrxHnJbXD3j7BPBG8GvSlqh7Dvf64ZdN5HAzS/
	rWmHbouFwE8dDaSlvNC7tCQGYj/6zQA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-SEslqo-NOryDDbqA397PBg-1; Thu, 30 Oct 2025 15:07:23 -0400
X-MC-Unique: SEslqo-NOryDDbqA397PBg-1
X-Mimecast-MFC-AGG-ID: SEslqo-NOryDDbqA397PBg_1761851243
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88f7eff9d5fso336889885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851243; x=1762456043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y7S1Zgr4iVGtRsh64LfgvKoH0XA8jwp4qVFPtKmeeA=;
        b=bwjeU6vrJiuUBY6YIF6GBhL69WMenox+WEO4do67MLDbrEXJngFpFRVkonOa/dIi9a
         n8v42EoITOfqD4PNqO0EEVXYSTq+Oh1WFR+GpY+lKE+zszeHCZLEQUaQDoeDBsFLsIdt
         zyEeQvkXlyAXqZw9B+JeBE9vsSWS7DxtJdT1ltfQwODDk1rDUGmPcc3hi0TefmMh/aUu
         rnAeJAtV3OhQ7ogFP/FzlDPMqHVMwn0yS5RePZfadimRASNGi03/b7AlNT/676a53BQ+
         7pjRbv/Rdp+JqE6oPkODGIz24JfHOQ9fXLDtDYxnqwwHfVi/g0fPI9ON8JKxjDtR/yDs
         95wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2ODYDaEy2RjS9V+DbSuSZBkmm2tRQFlW5fO4TQReDFVoPx40flVcMh6eK9XtTj8HfYRoSZpAxEDP48Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCeIoCEDepo4K3g1xIv6sWwxV+XymE4QFMIz8MbNSrrou6J5rK
	j91cZ/XFUJiPuMzUOSbr6eojYv9Gy4Lt9b+UyYO7306EBxP44eRsBkNJAk/dTE/0lmdk0iBeqJk
	Zl6DO1Lw2oz0gvuiufn0Iozkj8s8jaS28ikXAdAMTWCEzAM41CnCJDWzCiJQYKh7RmA==
X-Gm-Gg: ASbGncvUDixjhu9/QlGnNDUOeP8udezCk2QiTAvHzRpAqjgiDTKtK7OuIZA3F8RYKxz
	+OtD4VFZOZrZPhYN/Pp9iSEoNAszztQS9+3GUIEgJL8h1ILEUHAcDOnxd2q7Cta7bbHLlMuHb6h
	CeF2+36Nnxzssrbp9FFruQaKaomRLKLjuP0yTQaors0byT2f2JJajgddD56x55roHsv4mi+RDAr
	WdtwzsJhdXHrmQnRCQXh0CXitJ2urWaXETd7ranwV7NozuGGzkKTj3WtHRkF6lDFJ+jrIW7a+Bo
	06PRVLBTYE8+XFvlHg8BnrK+sbnCxJ41U3t2S2O+9nywjghzlHSVnsk/ScSIvlDymXw=
X-Received: by 2002:a05:620a:4410:b0:884:bea2:f01f with SMTP id af79cd13be357-8ab9afd1550mr60938985a.58.1761851242522;
        Thu, 30 Oct 2025 12:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHagFIkBv4J+3JA0af8KFwdWyaUAnlJH88LcP/SWIKEfGEGCPpq1Uvsvq9Iaf4DVL5Sxox3rA==
X-Received: by 2002:a05:620a:4410:b0:884:bea2:f01f with SMTP id af79cd13be357-8ab9afd1550mr60932985a.58.1761851241805;
        Thu, 30 Oct 2025 12:07:21 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3863cc2sm113652571cf.32.2025.10.30.12.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 12:07:21 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:07:18 -0400
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
Message-ID: <aQO3Zko6Qrk7O96u@x1.local>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>

On Thu, Oct 30, 2025 at 01:13:24PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251021 12:28]:
> 
> ...
> 
> > Can you send some patches and show us the code, help everyone to support
> > guest-memfd minor fault, please?
> 
> Patches are here:
> 
> https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem

Great!  Finally we have something solid to discuss on top.

Yes, I'm extremely happy to see whatever code there is, I'm happy to review
it.  I'm happy to see it rolling.  If it is better, we can adopt it.

> 
> This is actually modularized memory types.  That means there is no
> hugetlb.h or shmem.h included in mm/userfaultfd.c code.
> 
> uffd_flag_t has been removed.  This was turning into a middleware and
> it is not necessary.  Neither is supported_ioctls.
> 
> hugetlb now uses the same functions as every other memory type,
> including anon memory.
> 
> Any memory type can change functionality without adding instructions or
> flags or anything to some other code.
> 
> This code passes uffd-unit-test and uffd-wp-mremap (skipped the swap
> tests).
> 
> guest-memfd can implement whatever it needs to (or use others
> implementations), like shmem_uffd_ops here:

I didn't look at the patches in details, however I already commented
previously on a similar comment you left.  Since you have solid code this
time, let me ask one by one clearly this time inline:

> 
> static const struct vm_uffd_ops shmem_uffd_ops = {
>         .copy                   =       shmem_mfill_atomic_pte_copy,

This is optional, if you did the convertion it's perfect (though it's buggy
right now, more below).  Yes, UFFDIO_COPY might be a good fit for a global
API like this, however that's the least useful, as I mentioned, I do not
expect a new user..

It means, what you did on this may not grow any user.  The whole change may
not be useful to anyone..

Then I see what you introduced as the API:

struct vm_uffd_ops {
	int (*copy)(struct uffd_info *info);
	int (*zeropage)(struct uffd_info *info);
	int (*cont)(struct uffd_info *info);
	int (*poison)(struct uffd_info *info);
	int (*writeprotect)(struct uffd_info *info);
	/* Required features below */
	ssize_t (*is_dst_valid)(struct vm_area_struct *dst_vma,
				unsigned long dst_start, unsigned long len);
	unsigned long (*increment)(struct vm_area_struct *vma);
	ssize_t (*failed_do_unlock)(struct uffd_info *info);
	unsigned int (*page_shift)(struct vm_area_struct *src_vma);
	void (*complete_register)(struct vm_area_struct *vma);
};

The copy() interface (and most of the rest) takes something called
uffd_info*.  Then it looks like this:

struct uffd_info {
	unsigned long dst_addr;			/* Target address */
	unsigned long src_addr;			/* Source address */
	unsigned long len;			/* Total length to copy */
	unsigned long src_last;			/* starting src_addr + len */
	unsigned long dst_last;			/* starting dst_addr + len */
	struct folio *foliop;			/* folio pointer for retry */
	struct userfaultfd_ctx *ctx;		/* The userfaultfd context */

	struct vm_area_struct *dst_vma;		/* Target vma */
	unsigned long increment;		/* Size of each operation */
	bool wp;				/* Operation is requesting write protection */
	const struct vm_uffd_ops *uffd_ops;	/* The vma uffd_ops pointer */
	int (*op)(struct uffd_info *info);	/* The operation to perform on the dst */
	long copied;
};

You went almost mad when I introduced uffd_copy() in v1.  It might be
because there used to have pmd* and something around pgtables.  However
I'll still need to question whether this is a better and easier to adopt
interface if a mem type wants to opt-in any uffd features.

So are you happy yourself now with above complicated struct that memtype
needs to implement and support?

>         .zeropage               =       shmem_mfill_atomic_pte_zeropage,

Why a memory type needs to provide a separate hook to inject a zeropage?
It should almost always be the same of UFFDIO_COPY except copying.

>         .cont                   =       shmem_mfill_atomic_pte_continue,

It's OK to have it.  However said that, what we really need is "fetching a
cache folio".  I'll need to check how you exposed the userfaultfd helpers
so that it will support mem types to opt-in this.  To me, this is really an
overkill.

Shmem impl:

static int shmem_mfill_atomic_pte_continue(struct uffd_info *info)
{
	struct vm_area_struct *dst_vma = info->dst_vma;
	struct inode *inode = file_inode(dst_vma->vm_file);
	pgoff_t pgoff = linear_page_index(dst_vma, info->dst_addr);
	pmd_t *dst_pmd;
	struct folio *folio;
	struct page *page;
	int ret;

	ret = uffd_get_dst_pmd(dst_vma, info->dst_addr, &dst_pmd);
	if (ret)
		return ret;

	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
	/* Our caller expects us to return -EFAULT if we failed to find folio */
	if (ret == -ENOENT)
		ret = -EFAULT;
	if (ret)
		goto out;
	if (!folio) {
		ret = -EFAULT;
		goto out;
	}

	page = folio_file_page(folio, pgoff);
	if (PageHWPoison(page)) {
		ret = -EIO;
		goto out_release;
	}

	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, info->dst_addr,
				       page, false, info->wp);
	if (ret)
		goto out_release;

	folio_unlock(folio);
	ret = 0;
out:
	return ret;
out_release:
	folio_unlock(folio);
	folio_put(folio);
	goto out;
}

So are you sure this is better than the oneliner?

In your new API, the driver also needs to operate on pmd*.  Is it a concern
to you?  Maybe you don't think it's a concern now, even if you used to
think uffd_copy() has concerns exposing pmd* pointers?

The current series I proposed is not only simpler, but only expose folio*.
That's at least safer at least from your theory, is that right?

>         .poison                 =       mfill_atomic_pte_poison,

Why this is needed if UFFDIO_POISON should exactly do the same thing for
each memory type?

>         .writeprotect           =       uffd_writeprotect,

Same question.  Wr-protect over a pagecache folio should really behave the
same.  Why do you need to introduce it?

After all, even in your branch you reused change_protection(), where the
hugetlb special operations reside.  I don't see much point on why it's
needed.

>         .is_dst_valid           =       shmem_is_dst_valid,

It's definitely not obvious what this is for.

Looks like it's trying to verify vma validity.  However then I see shmem
impl has this:

static ssize_t shmem_is_dst_valid(struct vm_area_struct *dst_vma,
		unsigned long dst_start, unsigned long len)
{
	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
	    return -EINVAL;

	return 0;
}

Why shmem allows anon vma?

>         .increment              =       mfill_size,

This is almost only useful for hugetlbfs, same to page_shift and
complete_register.

It's ok if you want to clean hugetlbfs.  But if we want to fetch the
granule of the folios inside a vma, IMHO we should make it a vma attribute,
not something special to userfaultfd.

>         .failed_do_unlock       =       uffd_failed_do_unlock,

You'd better at least change the name of it.  It so far unlocks some
misterious locks then try to copy the folio without mmap/vma lock.

inline ssize_t
uffd_failed_do_unlock(struct uffd_info *info)
{
	ssize_t err;
	void *kaddr;

	up_read(&info->ctx->map_changing_lock);
	uffd_mfill_unlock(info->dst_vma);
	VM_WARN_ON_ONCE(!info->foliop);

	kaddr = kmap_local_folio(info->foliop, 0);
	err = copy_from_user(kaddr, (const void __user *) info->src_addr,
			     PAGE_SIZE);
	kunmap_local(kaddr);
	if (unlikely(err))
		return -EFAULT;

	flush_dcache_folio(info->foliop);
	return 0;
}

How do the mem type know what locks to unlock if they do not lock it first
themselves?

>         .page_shift             =       uffd_page_shift,
>         .complete_register      =       uffd_complete_register,

Hugetlbfs specific hooks.  It's OK if you prefer rewritting code for
hugetlbfs.  I don't have objections.

> };   
> 
> Where guest-memfd needs to write the one function:
> guest_memfd_pte_continue(), from what I understand.

You did mention what is required in your new API:

	/* Required features below */
	ssize_t (*is_dst_valid)(struct vm_area_struct *dst_vma,
				unsigned long dst_start, unsigned long len);
	unsigned long (*increment)(struct vm_area_struct *vma);
	ssize_t (*failed_do_unlock)(struct uffd_info *info);
	unsigned int (*page_shift)(struct vm_area_struct *src_vma);
	void (*complete_register)(struct vm_area_struct *vma);

So guest-memfd needs to implement these 6 APIs to support minor fault.

> 
> Obviously some of the shmem_ functions would need to be added to a
> header, or such.
> 
> And most of that can come from shmem_mfill_atomic_pte_continue(), from
> what I understand.  This is about 40 lines of code, but may require
> exposing some shmem functions to keep the code that compact.
> 
> So we don't need to expose getting a folio to a module, or decode any
> special flags or whatever.  We just call the function that needs to be

I didn't reply before, but I don't think supported_ioctls is special flags
or magic values.  They're simply flags showing what the mem type supports
on the ioctls.  One can set it wrong, but I don't think what you proposed
with above 6 APIs would be easier to get right.  Any module can also make
things wrong in any of above.

UFFDIO_CONTINUE itself is definitely getting much more complicated, it used
to only set a flag in supported_ioctls, provide a oneliner to fetch a
cache.  Now it needs all above 6 APIs, one of them taking uffd_info* which
further contains 10+ fields to process.

> called on the vma that is found.
> 
> If anyone has tests I can use for guest-memfd and instructions on
> guest-memfd setup, I'll just write it instead of expanding the
> userfaultfd middleware.

Personally, this whole thing is an overkill to me:

$ git diff --stat 63f84ba525ea04ef376eac851efce2f82dd05f21..HEAD
 fs/userfaultfd.c              |  14 +--
 include/linux/hugetlb.h       |  21 ----
 include/linux/mm.h            |  11 ++
 include/linux/shmem_fs.h      |  14 ---
 include/linux/userfaultfd_k.h | 108 ++++++++++------
 mm/hugetlb.c                  | 359 +++++++++++++++++++++++++++++++++++++++++++++--------
 mm/shmem.c                    | 245 ++++++++++++++++++++++++------------
 mm/userfaultfd.c              | 869 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------
 8 files changed, 962 insertions(+), 679 deletions(-)

I can wait for some second opinions, but if you are confident this will be
welcomed by others, I suggest you prepare a minimum changeset preparing
support for guest-memfd minor fault, then post it formally upstream.

Thanks,

-- 
Peter Xu


