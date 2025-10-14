Return-Path: <linux-kernel+bounces-852200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A68BD86DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3503C4F59AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF652E7645;
	Tue, 14 Oct 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuliMOGb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA732E5D2A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433974; cv=none; b=lKl1JZ9SE7y3IT8oqKQ/A0uqU4nwXF6sNaWqUViNDYWaN+97kb5pXmN8pp2QjV/5CCdGQzXQvWi+KuVxFFQjBCTNaZNna58rEbVOQje+N72GQt5CxnWoRfOQeHUj/Je4ILb8tdo+FJrwR2rPdQPFbFHZJYEgU922UXsz71EMlmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433974; c=relaxed/simple;
	bh=hUzW4S5w/YuwBH//A8HhU7m8kyQ+pHLx4AFNLcDnne0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMJliCTdyEcQkhvnn4rRoT+UZrv1uGZEkJBHzBv77fCThmkZB+c+JABCPpt6vKyCVQMD3RDz2gkgaGTAm0Vg0GDQ2jxUyOxa0gcc5PG+2pYPAVKHImGFBw3LrJVNJmPVpS2GVhAPtqAmRDZXGHoap0Q2fsxAyWSgJ65xJCNzOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuliMOGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=epY9cTOAfMdmGHzXRCTULCEHrX9oPkawi6gd7QKfPGE=;
	b=BuliMOGb0RF0XpN0SKdLyNhIi/kdkaS1jOfOfH8Y4BjdRPy5dOcAG0E58NMR1g2krAJ0gD
	rRGwSqyQ/3rwOAAVzWZlp77iWLDheI2bNMjLtq9N8FWfMVdK/cqOD+Q5/xWh/B47NKZ542
	5dcuyNcUJ2ru8YF9t6C6HnZzin5EsQM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-JdiIvC8lP1mUcp0fpNbB5Q-1; Tue, 14 Oct 2025 05:26:10 -0400
X-MC-Unique: JdiIvC8lP1mUcp0fpNbB5Q-1
X-Mimecast-MFC-AGG-ID: JdiIvC8lP1mUcp0fpNbB5Q_1760433969
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e46486972so29265565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433969; x=1761038769;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epY9cTOAfMdmGHzXRCTULCEHrX9oPkawi6gd7QKfPGE=;
        b=XAMuagy4U9OmMcZxeM18KUfKa1N+pI/HwRI0AmUoE1j+HbNA+N86aSEGd5/tGzAXMi
         0hgSoPfx8b08++b3cmRQwUwRghLoVx7rg/S4gVowYscYDm6Oqy5mIpJPq3+WQMbRmJHt
         rN+lDFqz2B0on2YPwgUkggVQJkBSS+EvUxVmCxBf8uVkjFmIooQuYbVHflIgxLI0knJv
         5Bkqpmdr5QraVVkFFezkX6uJMkb5gXbT0nr5J/0doSuiP7Lz5y+7f5DcRD8ECGfTrvOi
         bHHMGkzkiEe+1YiInwpuCeL3ULu2YHy6oTcqheUQq+Yhhf4B0ThXbxfO1s90w7TvQaxx
         O5kA==
X-Forwarded-Encrypted: i=1; AJvYcCU+9UKjwxqUXzEsuHfaD5w0ZV8NS4maw3jkEbSQiW/0SIEqgw8IZuD9cgPMxrZ6yiM9Yutfm0Uz9S5lhC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61k7YQpenlFkbKrBUhnvvuCOBRSH0APekBC1MF9y60e6BFJih
	SGr+Jz6OF7RB8Su83YLjObKXAm6LyT5HL2tERW6z5eFVxVFk0bsNf3Ie6WyxFMIaAXRlGdP8+Ad
	evsIw192/T8lYCa7ASoYzWDjkL2Nl1caSnfp9D4e8iEhlgNjdTy/ZRFebnTjw9hEYkA==
X-Gm-Gg: ASbGncu4oaR2unddAzhJ6e0AtzvVasRYqH1/LgJVhPB/DLLWsQDTwFy7Oa81hJd8mYu
	a42yPxZbNErNKYyWwl22Xyoy+a9ET5//rQwJ8ybXmBGJohPWO9Bd8eCi4zo0zZcx+/n6ynGqrGu
	44RHCYKz69El6RWKxEngCwmvZoyZVxe6y/ODutpfGC27pyAe5qf5Lpkkg8NH0U6Tg+CiJNSqN1s
	015D5NtKPSKteFC7j+CYxAWMoOpO686I1xrnKvUSCDRyUTCbj+bITNKxWXMvND0PO0t0ioqK77m
	myGrswhtxKU/X9wg4lCrFi/THqVBe/Xerb1W8NYba3RZlMWZSKcz6i/neSjDCycqnrK2+dhKtA=
	=
X-Received: by 2002:a05:600c:34c2:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46fa9b06d3dmr160572895e9.25.1760433968672;
        Tue, 14 Oct 2025 02:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz24vdSkuu30OwayZZ9SUOJh17Co9zGWb3j3wgTocTGDAZP13z/cUBLRlA4kl+O/4g18va9g==
X-Received: by 2002:a05:600c:34c2:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46fa9b06d3dmr160572695e9.25.1760433968175;
        Tue, 14 Oct 2025 02:26:08 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497aea6sm231420515e9.4.2025.10.14.02.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:26:07 -0700 (PDT)
Message-ID: <90ed950a-c3bb-46d5-91f9-338f5ca15af6@redhat.com>
Date: Tue, 14 Oct 2025 11:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, craftfever@murena.io
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251014055828.124522-1-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014055828.124522-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 07:58, Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> 
> To evaluate this change, I created a test that maps a 1 TB virtual area
> where only the first and last 10 MB are populated with identical data.
> With this patch applied, KSM scanned and merged the region approximately
> seven times faster.
> 
> This problem was previously discussed in [1].
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 136 ++++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 79 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 3aed0478fdce..584fd987e8ae 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2455,15 +2455,80 @@ static bool should_skip_rmap_item(struct folio *folio,
>   	return true;
>   }
>   
> +struct ksm_walk_private {
> +	struct page *page;
> +	struct ksm_rmap_item *rmap_item;
> +	struct ksm_mm_slot *mm_slot;
> +};
> +
> +static int ksm_walk_test(unsigned long addr, unsigned long next, struct mm_walk *walk)
> +{
> +	struct vm_area_struct *vma = walk->vma;
> +
> +	if (!vma || !(vma->vm_flags & VM_MERGEABLE))

The anon_vma check should go in here as well.

How can we possibly get !vma?

> +		return 1;
> +	return 0;
> +}
> +
> +static int ksm_pte_entry(pte_t *pte, unsigned long addr,
> +			    unsigned long end, struct mm_walk *walk)
> +{
> +	struct mm_struct *mm = walk->mm;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct ksm_walk_private *private = (struct ksm_walk_private *) walk->private;
> +	struct ksm_mm_slot *mm_slot = private->mm_slot;
> +	pte_t ptent = ptep_get(pte);
> +	struct page *page = pfn_to_online_page(pte_pfn(ptent));

Oh no.

vm_normal_page()

> +	struct ksm_rmap_item *rmap_item;
> +	struct folio *folio;
> +
> +	ksm_scan.address = addr;
> +
> +	if (ksm_test_exit(mm))
> +		return 1;
> +
> +	if (!page)
> +		return 0;
> +
> +	folio = page_folio(page);
> +	if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +		return 0;
> +
> +	folio_get(folio);
> +
> +	flush_anon_page(vma, page, ksm_scan.address);
> +	flush_dcache_page(page);
> +	rmap_item = get_next_rmap_item(mm_slot,
> +		ksm_scan.rmap_list, ksm_scan.address);
> +	if (rmap_item) {
> +		ksm_scan.rmap_list =
> +				&rmap_item->rmap_list;
> +
> +		if (should_skip_rmap_item(folio, rmap_item)) {
> +			folio_put(folio);
> +			return 0;
> +		}
> +		ksm_scan.address = end;
> +		private->page = page;
> +	} else
> +		folio_put(folio);
> +

You're under PTL, get_next_rmap_item() will perform an allocation, so 
that won't work.

Observe how the original code worked around that by performing all magic 
outside of the PTL (folio_walk_end()).

When you switch to .pmd_entry() (see below) you will be able to handle it.

What you could also try doing is returing page+folio and letting the 
caller deal with everything starting at the flush_anon_page().

> +	private->rmap_item = rmap_item;
> +	return 1;
> +}
> +
> +struct mm_walk_ops walk_ops = {
> +	.pte_entry = ksm_pte_entry,
> +	.test_walk = ksm_walk_test,
> +	.walk_lock = PGWALK_RDLOCK,
> +};

It's more complicated: you'd be remapping each PMD to be mapped by PTEs 
first, which is not what we want. You'll have to handle pmd_entry 
instead of pte_entry.

> +
>   static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   {
>   	struct mm_struct *mm;
>   	struct ksm_mm_slot *mm_slot;
>   	struct mm_slot *slot;
> -	struct vm_area_struct *vma;
> -	struct ksm_rmap_item *rmap_item;
> -	struct vma_iterator vmi;
> -	int nid;
> +	int nid, ret;
>   
>   	if (list_empty(&ksm_mm_head.slot.mm_node))
>   		return NULL;
> @@ -2527,64 +2592,21 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   
>   	slot = &mm_slot->slot;
>   	mm = slot->mm;
> -	vma_iter_init(&vmi, mm, ksm_scan.address);
>   
>   	mmap_read_lock(mm);
>   	if (ksm_test_exit(mm))
>   		goto no_vmas;
>   
> -	for_each_vma(vmi, vma) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> -			continue;
> -		if (ksm_scan.address < vma->vm_start)
> -			ksm_scan.address = vma->vm_start;
> -		if (!vma->anon_vma)
> -			ksm_scan.address = vma->vm_end;
> -
> -		while (ksm_scan.address < vma->vm_end) {
> -			struct page *tmp_page = NULL;
> -			struct folio_walk fw;
> -			struct folio *folio;
> -
> -			if (ksm_test_exit(mm))
> -				break;
> -
> -			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> -			if (folio) {
> -				if (!folio_is_zone_device(folio) &&
> -				     folio_test_anon(folio)) {
> -					folio_get(folio);
> -					tmp_page = fw.page;
> -				}
> -				folio_walk_end(&fw, vma);
> -			}
> -
> -			if (tmp_page) {
> -				flush_anon_page(vma, tmp_page, ksm_scan.address);
> -				flush_dcache_page(tmp_page);
> -				rmap_item = get_next_rmap_item(mm_slot,
> -					ksm_scan.rmap_list, ksm_scan.address);
> -				if (rmap_item) {
> -					ksm_scan.rmap_list =
> -							&rmap_item->rmap_list;
> -
> -					if (should_skip_rmap_item(folio, rmap_item)) {
> -						folio_put(folio);
> -						goto next_page;
> -					}
> -
> -					ksm_scan.address += PAGE_SIZE;
> -					*page = tmp_page;
> -				} else {
> -					folio_put(folio);
> -				}
> -				mmap_read_unlock(mm);
> -				return rmap_item;
> -			}
> -next_page:
> -			ksm_scan.address += PAGE_SIZE;
> -			cond_resched();

You're dropping all cond_resched(), which will be a problem.

> -		}
> +	struct ksm_walk_private walk_private = {
> +		.page = NULL,
> +		.rmap_item = NULL,
> +		.mm_slot = ksm_scan.mm_slot
> +	};

empty line missing

> +	ret = walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) &walk_private);
> +	*page = walk_private.page;
> +	if (ret) {
> +		mmap_read_unlock(mm);
> +		return walk_private.rmap_item;
>   	}
>   
>   	if (ksm_test_exit(mm)) {


-- 
Cheers

David / dhildenb


