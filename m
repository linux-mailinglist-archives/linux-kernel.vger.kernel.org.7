Return-Path: <linux-kernel+bounces-852739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EABD9C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51C324E10F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998ED311C1E;
	Tue, 14 Oct 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTztnreo"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C692571B0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449109; cv=none; b=oy/SwceJ3u4yaKJp5KfPz2yRqcCt+B0V4QsnISMupHdQTPn72I1yog+fO1acJAgzy+iSdSnU49iZN3JvEbxQt2Bwt88k6k2guzPFGca9SqfEBvI8tRhjTbp+acUFyPY8RR7Phj+gDOB2e5QoYgHONzOebRLDCquYPIA2BeYUlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449109; c=relaxed/simple;
	bh=nyss/j1T4ON/dUUvn/87APzn3GilvJzOc6kuqhLNMU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI5RSdf2sY4YkiaC1pSbjI3rAbtRyLJpqP30NqC05NhB6AwXEsTHoMdX+c6XxLgdjLYwB9peTT8h+W9hrlKxeVZmhy62i0tYBkTB4SROwhIFEOy2x3vKC6dbaq8ckJ+MGbHB9XWqOIExn+vGcz3cvS4b4yGIlNVRdSFp4A2N6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTztnreo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339d53f4960so5603537a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760449107; x=1761053907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A085BtH7ekRyYK8/+lQK6CtKf8LhcnavzYT4kIWkbTg=;
        b=FTztnreoLy5y7osldBPe2a8bawvJEFwEnSg9JTzKvTLjzRZh7BMPNRezVaF1ZUm9sZ
         cp4m5BqjvIdjbewai7ZTJiiR3yyjvgBiNAS6MamcJRfCAPjiFXooirManaa/GKllLBQH
         FJKEw0Ar262HpnfKecOGV8k1Spq8Y1l5psMXAeAeA0GWyOV+IrdaBSCh5+/HQSSoQbtA
         VIMj5dKjg6Y6lfew1DG/18cNdVL8cRnAqci0gESW4WPcp51QEcYg1BjwCY64XlJy4lzv
         A4eRn3L6aWHkEk/+ZOjr1mwnyxcTMPbxmrr0iq+HyYps22XaeeVyOPTCX+3KAyCTz9v4
         vMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449107; x=1761053907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A085BtH7ekRyYK8/+lQK6CtKf8LhcnavzYT4kIWkbTg=;
        b=usPzav1+YwdiXtMd+nwaF66OoptrTpCj+Yfw87wt4K4DFf1dta+oKt2KIxoKhsgh/u
         vOoTZvAipX0yR5GyU7CZNMq2uQY1U8vDoa/AJwpn5JFfLiDU5z5eHiTZKc4NBQ3ey7Up
         tcFeYT8BSgwK/aUnwIbc6wo/nlSWXGcTcdjkCvpyZTPoZ0oRM5g2UXRY+3OzFKCdIUbt
         cwac6zIabxF+SLHrDOOQGsPvv8BFNVYOLkj/0s6Je00/gqKlJ+OwDzA61MX8kz5LkBZD
         xm/K/MgQAD1SvurRwL38G0y8I8ygBifT9+GFbq1t8gVsAKHM4XBrk61cs4+mAL1sA8BA
         SU6A==
X-Forwarded-Encrypted: i=1; AJvYcCVkRikfTN1nGf4Xt/AaSe5S4kWLsGbp/DzTb8+GLbtLhnwhL8sWqKY1y36nmLT/AGMZsb6mE5vcB55F5eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7c275FENYFX3T5R8EV+Zjuh3rNM+QYIZUb7ya7jPlUCnj+us
	FKYAHZaLm7s/0Q/PV9ZYAnTAW6Z1ofnL2uOgXvNf0Nca7Zxs3AJYBSaM
X-Gm-Gg: ASbGncuDpMAZYLWmKGLU18gsh0mMPFpDxbs8zp29JJcKKTsfAby7dB4TJcf5pZDfqTH
	lPtc3HURayFeRpXqrIkjST5vuAA1l52yPsFseLGq9YjjFt2tbTkgt6Kun9uhHKLj7wOsJWTJnz2
	z0qXl+W5KtfEuUGc7uVlG0ks16tBwQXdSXv8bo2qXK/K+Upv0wSxHI6Fs/1EONw1R7SCdgR+LfF
	tKqGn6XA+ldDxqL8UVvxk+4iAyvtQO5ms+4frsaw9+5vYxUkVYEfDzSP3bfEXEOsozKl6X9VHCg
	F4QY2qWwfFuqOZdTSns5LOrMjGpOBHktm0MM1XdZLigRnLPQ3adPisp7Iu4IQmTTh5QURb661vH
	Dnk2xm7/wc0JybikaCVnOKBWqvzdViMueDzbzBcQ3wksVzBGM0i8W/RkrL2zrqSlg+kQ=
X-Google-Smtp-Source: AGHT+IHZoEpNtqb3Er/H8rHrHDUjXVXuJ/umcp1U+VvoRsZ+h9SpEmOctIzSeP+NFNUAR2TR1CliKg==
X-Received: by 2002:a17:90b:3511:b0:32e:5646:d43f with SMTP id 98e67ed59e1d1-33b513b4c25mr34617827a91.19.1760449107333;
        Tue, 14 Oct 2025 06:38:27 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2 ([2804:30c:166c:ce00:5a20:94db:a4ce:661d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cbf2sm16117618a91.8.2025.10.14.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:38:26 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:36:49 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, craftfever@murena.io, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
Message-ID: <qrf6mertexxf3hcazexkv6jxokdg5jnsbuixih62w2peq3ooyl@u3mhuopdjrfc>
References: <20251014055828.124522-1-pedrodemargomes@gmail.com>
 <90ed950a-c3bb-46d5-91f9-338f5ca15af6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ed950a-c3bb-46d5-91f9-338f5ca15af6@redhat.com>

On Tue, Oct 14, 2025 at 11:26:06AM +0200, David Hildenbrand wrote:
> On 14.10.25 07:58, Pedro Demarchi Gomes wrote:
> > Currently, scan_get_next_rmap_item() walks every page address in a VMA
> > to locate mergeable pages. This becomes highly inefficient when scanning
> > large virtual memory areas that contain mostly unmapped regions.
> > 
> > This patch replaces the per-address lookup with a range walk using
> > walk_page_range(). The range walker allows KSM to skip over entire
> > unmapped holes in a VMA, avoiding unnecessary lookups.
> > 
> > To evaluate this change, I created a test that maps a 1 TB virtual area
> > where only the first and last 10 MB are populated with identical data.
> > With this patch applied, KSM scanned and merged the region approximately
> > seven times faster.
> > 
> > This problem was previously discussed in [1].
> > 
> > [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> > 
> > Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> > ---
> >   mm/ksm.c | 136 ++++++++++++++++++++++++++++++++-----------------------
> >   1 file changed, 79 insertions(+), 57 deletions(-)
> > 
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 3aed0478fdce..584fd987e8ae 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -2455,15 +2455,80 @@ static bool should_skip_rmap_item(struct folio *folio,
> >   	return true;
> >   }
> > +struct ksm_walk_private {
> > +	struct page *page;
> > +	struct ksm_rmap_item *rmap_item;
> > +	struct ksm_mm_slot *mm_slot;
> > +};
> > +
> > +static int ksm_walk_test(unsigned long addr, unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct vm_area_struct *vma = walk->vma;
> > +
> > +	if (!vma || !(vma->vm_flags & VM_MERGEABLE))
> 
> The anon_vma check should go in here as well.
> 
> How can we possibly get !vma?
> 
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int ksm_pte_entry(pte_t *pte, unsigned long addr,
> > +			    unsigned long end, struct mm_walk *walk)
> > +{
> > +	struct mm_struct *mm = walk->mm;
> > +	struct vm_area_struct *vma = walk->vma;
> > +	struct ksm_walk_private *private = (struct ksm_walk_private *) walk->private;
> > +	struct ksm_mm_slot *mm_slot = private->mm_slot;
> > +	pte_t ptent = ptep_get(pte);
> > +	struct page *page = pfn_to_online_page(pte_pfn(ptent));
> 
> Oh no.
> 
> vm_normal_page()
> 
> > +	struct ksm_rmap_item *rmap_item;
> > +	struct folio *folio;
> > +
> > +	ksm_scan.address = addr;
> > +
> > +	if (ksm_test_exit(mm))
> > +		return 1;
> > +
> > +	if (!page)
> > +		return 0;
> > +
> > +	folio = page_folio(page);
> > +	if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> > +		return 0;
> > +
> > +	folio_get(folio);
> > +
> > +	flush_anon_page(vma, page, ksm_scan.address);
> > +	flush_dcache_page(page);
> > +	rmap_item = get_next_rmap_item(mm_slot,
> > +		ksm_scan.rmap_list, ksm_scan.address);
> > +	if (rmap_item) {
> > +		ksm_scan.rmap_list =
> > +				&rmap_item->rmap_list;
> > +
> > +		if (should_skip_rmap_item(folio, rmap_item)) {
> > +			folio_put(folio);
> > +			return 0;
> > +		}
> > +		ksm_scan.address = end;
> > +		private->page = page;
> > +	} else
> > +		folio_put(folio);
> > +
> 
> You're under PTL, get_next_rmap_item() will perform an allocation, so that
> won't work.
> 
> Observe how the original code worked around that by performing all magic
> outside of the PTL (folio_walk_end()).
> 
> When you switch to .pmd_entry() (see below) you will be able to handle it.
> 
> What you could also try doing is returing page+folio and letting the caller
> deal with everything starting at the flush_anon_page().
> 
> > +	private->rmap_item = rmap_item;
> > +	return 1;
> > +}
> > +
> > +struct mm_walk_ops walk_ops = {
> > +	.pte_entry = ksm_pte_entry,
> > +	.test_walk = ksm_walk_test,
> > +	.walk_lock = PGWALK_RDLOCK,
> > +};
> 
> It's more complicated: you'd be remapping each PMD to be mapped by PTEs
> first, which is not what we want. You'll have to handle pmd_entry instead of
> pte_entry.
> 
> > +
> >   static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
> >   {
> >   	struct mm_struct *mm;
> >   	struct ksm_mm_slot *mm_slot;
> >   	struct mm_slot *slot;
> > -	struct vm_area_struct *vma;
> > -	struct ksm_rmap_item *rmap_item;
> > -	struct vma_iterator vmi;
> > -	int nid;
> > +	int nid, ret;
> >   	if (list_empty(&ksm_mm_head.slot.mm_node))
> >   		return NULL;
> > @@ -2527,64 +2592,21 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
> >   	slot = &mm_slot->slot;
> >   	mm = slot->mm;
> > -	vma_iter_init(&vmi, mm, ksm_scan.address);
> >   	mmap_read_lock(mm);
> >   	if (ksm_test_exit(mm))
> >   		goto no_vmas;
> > -	for_each_vma(vmi, vma) {
> > -		if (!(vma->vm_flags & VM_MERGEABLE))
> > -			continue;
> > -		if (ksm_scan.address < vma->vm_start)
> > -			ksm_scan.address = vma->vm_start;
> > -		if (!vma->anon_vma)
> > -			ksm_scan.address = vma->vm_end;
> > -
> > -		while (ksm_scan.address < vma->vm_end) {
> > -			struct page *tmp_page = NULL;
> > -			struct folio_walk fw;
> > -			struct folio *folio;
> > -
> > -			if (ksm_test_exit(mm))
> > -				break;
> > -
> > -			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> > -			if (folio) {
> > -				if (!folio_is_zone_device(folio) &&
> > -				     folio_test_anon(folio)) {
> > -					folio_get(folio);
> > -					tmp_page = fw.page;
> > -				}
> > -				folio_walk_end(&fw, vma);
> > -			}
> > -
> > -			if (tmp_page) {
> > -				flush_anon_page(vma, tmp_page, ksm_scan.address);
> > -				flush_dcache_page(tmp_page);
> > -				rmap_item = get_next_rmap_item(mm_slot,
> > -					ksm_scan.rmap_list, ksm_scan.address);
> > -				if (rmap_item) {
> > -					ksm_scan.rmap_list =
> > -							&rmap_item->rmap_list;
> > -
> > -					if (should_skip_rmap_item(folio, rmap_item)) {
> > -						folio_put(folio);
> > -						goto next_page;
> > -					}
> > -
> > -					ksm_scan.address += PAGE_SIZE;
> > -					*page = tmp_page;
> > -				} else {
> > -					folio_put(folio);
> > -				}
> > -				mmap_read_unlock(mm);
> > -				return rmap_item;
> > -			}
> > -next_page:
> > -			ksm_scan.address += PAGE_SIZE;
> > -			cond_resched();
> 
> You're dropping all cond_resched(), which will be a problem.
> 
> > -		}
> > +	struct ksm_walk_private walk_private = {
> > +		.page = NULL,
> > +		.rmap_item = NULL,
> > +		.mm_slot = ksm_scan.mm_slot
> > +	};
> 
> empty line missing
> 
> > +	ret = walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) &walk_private);
> > +	*page = walk_private.page;
> > +	if (ret) {
> > +		mmap_read_unlock(mm);
> > +		return walk_private.rmap_item;
> >   	}
> >   	if (ksm_test_exit(mm)) {
> 
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

Thanks for the explanations, I will send a v2 shortly.

