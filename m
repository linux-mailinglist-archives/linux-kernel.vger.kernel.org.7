Return-Path: <linux-kernel+bounces-878209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3382C20089
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AE5463EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9262874F8;
	Thu, 30 Oct 2025 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnVGs4nN"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C04126C17
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827472; cv=none; b=KxpS3shl8mdAiOvnXHJJFg4F1InfXkaNQ8KkiDYrzX6SBNm4up1qu6K1uulm8C5MPmUCORKavrjmtDTzcKk68bQbwrvU7O7hh87b+TRE2PsFkQ03PypreNEHQySOnrpkHZez0Oaz+ZewR+5zEukgw4hwVJ5PFYK8siHgKLVcPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827472; c=relaxed/simple;
	bh=HdcEvt37hCu5aG5hVS7CUVhxB757AfOyx3y6TFDPwJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn6qjHDs7Q5ZSiSNvLfZe5L4YuopEkKrOHtWoqcmwb8TbZg1lPUj3gSH02c6rtva7L80yejD90LBKpfZgyh0MRasgB11yqAduaIkqxm+X/BUo+5WbXdtbqNQ9jBAnyEmNzP+U3mh3ikYh/CDl7GldepuRHKTvyYiiRqrrRZyK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnVGs4nN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32ec291a325so839696a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827470; x=1762432270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUnnnzKNF6jolr4B3pNsI3K3/iZV7NjjIbRTrmi3YPg=;
        b=YnVGs4nNk5U7cBOScksP9/F1MJhU7BANzT4UEPjZjC0w7iTNCXpkn7xvol7AtCRAw5
         +0Cx9teRLQqovULmFutraU+2AXWkWhm7cu6m/eZ9hNDjjdbJn5zn6q/I3aH3jPsmLsGu
         XXblTBFBzJh2VVLWlnkoPj63+57w86QKDsJ10z6VeHzSB6iaAD5ZC3uBg5uS6zvN/FDE
         Ht8YEJGdisX+mIBjICljGdW9KrB7KfboFQG8YtePYGJA9Qmd9JXqxoGswUld2Sr6PzD0
         KkYmCjxMBuYO6b0jHDXLq94LtzK51y3NeX7DPwHv3nqEFd94V97ulL/4ZunAmBt6c2JP
         AMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827470; x=1762432270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUnnnzKNF6jolr4B3pNsI3K3/iZV7NjjIbRTrmi3YPg=;
        b=jOj+pmJkfAwc+s1QquEV0TWSSd22nQpls8jFfpoG7n/TwZEtQA/heX2fLu/Gqm8GGh
         0p6vQ5LV/0L9X1IF7KDFNgsYJMpXi08B9uXQMoPHweSGUQFhE9rre2XoA1OgoRbL4rwn
         ugw0J4UnWjkY3yTA3MH2EeXs16j8XoDgGneytDcNjEOGuLyGA1U0K0F4AAvHmbLuvZy4
         Ebo4elEAEbb+KAHpw62eyfz3Dl4/qStB0Z2+pphDgHAdXDTCHfJMYoVNjd6VqmaqEqOS
         5fZ+Gml7u0uKhg9OeRS/8HIq6F0WGqJM8MUuAWH7exqD0iQEBDqA0SMd1owtJoddkqRR
         qVng==
X-Forwarded-Encrypted: i=1; AJvYcCVWTC/TlP1r+S5wCf50+jff/ZgST6G9pFK9l3VmcJ6Fi0LUdbTDmJl3XEmfWSRfeaj+HkEd0eMlB5cKnjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYqrtz4jJNLAqT4nXa08wjrV9DtXgBQhvZfe0ne9f6wK1SGmE
	fKSJGZrWCY1zpxM2iJhnrc95AyNlHkoaHVKYDM+KlU60KdzfAejOzqX4
X-Gm-Gg: ASbGncvaksBJfAiGLm6A+KeylrgvbWAdgYIgn+cTeM9GRWND3mGRQ+Xxj07kEJYM8d3
	TPJuO2qrURPxQDR8kT2Hi5xyuMMprSMZ5XOzQVpahZfRIVtwOt1JvMgzVCEKeF8MavtWYe7hhUw
	1hRf/QDSPOyeEqMtcQpdAX8qeFcZFqC9vPAPjxAPDFSrriwWv9PyLz+ShY0kLXmUqwaUsiqDfGz
	g5qhZjYvPsp/IUkL3RH7CA4HqMtSL51rQvd4PCE+wllp+yPzi3q9pBilZ1rzQOTgX0NjVwM2LIs
	Y0hX3Qs/6DCt9+pfcHgquBVk9o4wxTHbqjzhxaJYca5jj7rImTaBWpJ93lA0MZxYfUQ5Cg/etJn
	Bt03moURB/AgmhGNrBnuUXcO7UbWvwjGFQfYiTMWGdCpag+80f4CoCECvdQiV8LsEcRb+djwa4g
	zbJK0NlpjQq8Y3QQkWCq0uDkf9f+/YOlhk9T8sAA1TMpE=
X-Google-Smtp-Source: AGHT+IFA6icduLZxkWAsDzHrUB6N/1XP3GWDghxWUFnVHotHexY3CKUXxycdYpJBjS+mrF9P+AZFpg==
X-Received: by 2002:a17:90b:380e:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-3403a2f123emr7979152a91.26.1761827469626;
        Thu, 30 Oct 2025 05:31:09 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2 ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509c89a9sm2510392a91.9.2025.10.30.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:31:09 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:29:19 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ksm: perform a range-walk in break_ksm
Message-ID: <lv2c4z5utzr37moyish53pmazcnyprhp7ncnrp3hwxyh2fxcvh@466zyeltaisr>
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
 <20251028131945.26445-3-pedrodemargomes@gmail.com>
 <85604399-40a8-4d13-809d-e5492e74a988@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85604399-40a8-4d13-809d-e5492e74a988@redhat.com>

On Wed, Oct 29, 2025 at 03:45:14PM +0100, David Hildenbrand wrote:
> On 28.10.25 14:19, Pedro Demarchi Gomes wrote:
> > Make break_ksm() receive an address range and change
> > break_ksm_pmd_entry() to perform a range-walk and return the address of
> > the first ksm page found.
> > 
> > This change allows break_ksm() to skip unmapped regions instead of
> > iterating every page address. When unmerging large sparse VMAs, this
> > significantly reduces runtime, as confirmed by benchmark test (see
> > cover letter).
> 
> Instead of referencing the cover letter, directly include the data here.
> 

Ok

> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> > ---
> >   mm/ksm.c | 88 +++++++++++++++++++++++++++++++-------------------------
> >   1 file changed, 49 insertions(+), 39 deletions(-)
> > 
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 2a9a7fd4c777..1d1ef0554c7c 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -607,34 +607,54 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
> >   	return atomic_read(&mm->mm_users) == 0;
> >   }
> > -static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> > +struct break_ksm_arg {
> > +	unsigned long addr;
> > +};
> 
> You can avoid that by simply passing a pointer to addr.
> 
> > +
> > +static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
> >   			struct mm_walk *walk)
> >   {
> > -	struct page *page = NULL;
> > +	struct page *page;
> >   	spinlock_t *ptl;
> > -	pte_t *pte;
> > -	pte_t ptent;
> > -	int ret;
> > +	pte_t *start_ptep = NULL, *ptep, pte;
> 
> Is there a need to initialize start_ptep?
> 

No, I will fix that.

> > +	int ret = 0;
> > +	struct mm_struct *mm = walk->mm;
> > +	struct break_ksm_arg *private = (struct break_ksm_arg *) walk->private;
> 
> Prefer reverse xmas tree:
> 
> struct break_ksm_arg *private = (struct break_ksm_arg *) walk->private;
> struct mm_struct *mm = walk->mm;
> ...
> 
> With the break_ksm_arg simplification you'd had
> 
> unsigned long *found_addr = (unsigned long *)walk->private;
> 
> 

Ok

> > -	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> > -	if (!pte)
> > +	if (ksm_test_exit(walk->mm))
> >   		return 0;
> > -	ptent = ptep_get(pte);
> > -	if (pte_present(ptent)) {
> > -		page = vm_normal_page(walk->vma, addr, ptent);
> > -	} else if (!pte_none(ptent)) {
> > -		swp_entry_t entry = pte_to_swp_entry(ptent);
> > -		/*
> > -		 * As KSM pages remain KSM pages until freed, no need to wait
> > -		 * here for migration to end.
> > -		 */
> > -		if (is_migration_entry(entry))
> > -			page = pfn_swap_entry_to_page(entry);
> > +	if (signal_pending(current))
> > +		return -ERESTARTSYS;
> 
> I assume that's not a problem for the other callsites that wouldn't check
> this before.
> 

Correct.

> > +
> > +	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> > +	if (!start_ptep)
> > +		return 0;
> > +
> > +	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
> 
> Best to declare pte and folio (see last mail) here in the loop:
> 
> 	pte_t pte = ptep_get(ptep);
> 	struct folio *folio = NULL;
> 

Ok.

> > +		pte = ptep_get(ptep);
> > +		page = NULL;
> > +		if (pte_present(pte)) {
> > +			page = vm_normal_page(walk->vma, addr, pte);
> > +		} else if (!pte_none(pte)) {
> > +			swp_entry_t entry = pte_to_swp_entry(pte);
> > +
> > +			/*
> > +			 * As KSM pages remain KSM pages until freed, no need to wait
> > +			 * here for migration to end.
> > +			 */
> > +			if (is_migration_entry(entry))
> > +				page = pfn_swap_entry_to_page(entry);
> > +		}
> > +		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> > +		ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(pte);
> > +		if (ret) {
> > +			private->addr = addr;
> > +			goto out_unlock;
> > +		}
> 
> I suggest you call "ret" "found" instead.
> 

Ok.

> >   	}
> > -	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> > -	ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(ptent);
> > -	pte_unmap_unlock(pte, ptl);
> > +out_unlock:
> > +	pte_unmap_unlock(ptep, ptl);
> >   	return ret;
> >   }
> > @@ -661,9 +681,11 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
> >    * of the process that owns 'vma'.  We also do not want to enforce
> >    * protection keys here anyway.
> >    */
> > -static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
> > +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
> > +		unsigned long end, bool lock_vma)
> >   {
> >   	vm_fault_t ret = 0;
> > +	struct break_ksm_arg break_ksm_arg;
> >   	const struct mm_walk_ops *ops = lock_vma ?
> >   				&break_ksm_lock_vma_ops : &break_ksm_ops;
> > @@ -671,11 +693,10 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
> >   		int ksm_page;
> >   		cond_resched();
> > -		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
> > -		if (WARN_ON_ONCE(ksm_page < 0))
> > +		ksm_page = walk_page_range_vma(vma, addr, end, ops, &break_ksm_arg);
> > +		if (ksm_page <= 0)
> >   			return ksm_page;
> > -		if (!ksm_page)
> > -			return 0;
> > +		addr = break_ksm_arg.addr;
> >   		ret = handle_mm_fault(vma, addr,
> >   				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
> >   				      NULL);
> > @@ -761,7 +782,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
> >   	mmap_read_lock(mm);
> >   	vma = find_mergeable_vma(mm, addr);
> >   	if (vma)
> > -		break_ksm(vma, addr, false);
> > +		break_ksm(vma, addr, addr + 1, false);
> 
> Better to use addr + PAGE_SIZE
> 

OK.

> -- 
> Cheers
> 
> David / dhildenb
> 
> 

