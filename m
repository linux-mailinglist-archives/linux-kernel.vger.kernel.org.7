Return-Path: <linux-kernel+bounces-757408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EDDB1C1D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD01861DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E45221269;
	Wed,  6 Aug 2025 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjFmo/lX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EC220F34
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467724; cv=none; b=WTfBqLCNWK0e+CJfsMH/1hHAavpade3Jl/700cjuu+6UCaenCqEcaW3p9EzP4qnXClSAbcESaSPJRy+r7kAULT4z6tnPWGorw5TBzwCh9U8oTRpzbvQyn9nWFCiFOo+P6VigticNb8hEVgfQBGNG/TxC56tqR3WvXXfgDK8jCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467724; c=relaxed/simple;
	bh=Kv497r8gjCtMp1AZaokuT2CdphTbW22bGv7BjQIAaXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTHyvaWMz2odSWDgLKU5hQmbPbz0IG3PyKBBz/a49Ks/No0UO1MWKFU7/QBoQRXC9m4Jwc5Ih9q/vT2ND6eDxkA2jxZm1InP9gNOeppOBwu3khRY5PFYGlwtmBZTnNI5P5cB1MY77iqCmNKvahjq+p/UPHuWhLmyNrl9z1BAljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjFmo/lX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754467719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=idlUt3rsM+yBY2pffT/6Us1aEZrNslTr2qkjcKhWpWM=;
	b=DjFmo/lXk+NP00YGNlVoPmgYCvQVmIDepNpo4E2KhEuVIAEDfxY3kpd+aF4hy0bffJxlTZ
	euA99bx7/QCPcm6MCvFAKRIemcUZSUWOuOnmPfJkl9/A0zQ7znfeIYyE/qQoqU+DhPPHpE
	bBh5U06bA6QFcu0u2MndJlcKM/pf23g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4I-5nqsXNB2CUNUFlyu4og-1; Wed, 06 Aug 2025 04:08:37 -0400
X-MC-Unique: 4I-5nqsXNB2CUNUFlyu4og-1
X-Mimecast-MFC-AGG-ID: 4I-5nqsXNB2CUNUFlyu4og_1754467716
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459de0d5fb1so21026695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467716; x=1755072516;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=idlUt3rsM+yBY2pffT/6Us1aEZrNslTr2qkjcKhWpWM=;
        b=VjFShrLjg2jnkoOg1FVqad7R4Ct2iFkr4s2EGZZgB3NxOzEkQIH/eluCS0xQtBK65+
         seR7N5fUw9R88y/p7ickroWm/EQ/3vyEL+/E+mp/lv0r+5aKWurQ3b4uxgOFvRsQJ8RQ
         w2eKhyO9c1DmAOruP2qdRBSX8jv+26HacphKQFG7C6LGKDpxpEXBgGJy/rcAVhuGYaxa
         Hxpnr7tvY/eaFPDUI1M4mz5BJ1i7OLAdyrkLdce5HnlQBc3y3RoRq+Rs+O2t7OPkU1iS
         1IkUudlqUJOC83sRWkrAIdJD6D3je4GCp/omSZo9kDSKFx4kTf6FjnASglROIOVtJ8ra
         Pj+A==
X-Forwarded-Encrypted: i=1; AJvYcCVHPJiFw74JyCH3hcCgEzI9PxTSyHIXAW6uHWJpXrwiNWyMbc29qa/eUQbRI0vc/0msbXAM5YKdJWUZIBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZpzSUU6QZHX5I8iqW1auwY2ZUfSsyWIxh2BQVc/g6OqUzQEd
	Dv04HLa5mISkdt9oS4ngGJOCIuf0eByBKkHl2VRVK60OYPGIsKJh4i+H2hy1EQCQWVmVtKTlj56
	JAK1+IpFEZlSoFgp+tC6t3Ds2Orh9imRx+6UVD6SZACGOTNekvPSDrWt89JeGTa5Hew==
X-Gm-Gg: ASbGncvtGHGumrQdamGYesbMX/uNk8nLlK0TEDKiioFf5+P84sNesI6ndgE8Ik7Pq4X
	sIOtRs0BQGmJA4Q7hgGez/gC6ConLAIGh1uS3qCylYf1n3GqbGMAOM/DrTXBrkb7Adbpbw6bTna
	jjYMS4hcpRLG13X9GgzSjYMiDSuOqgCEnaYQiZV913Zzx+ogVeBfkh9lRQZtCeCqMOI/cRChqAi
	XvvdbNu8V9fs02/RHIj+dOsdMtUHdWa/xqZ7Wj/u8w6eoFvPhdOnqDlP6qZxxkAtJi+B7rMARTy
	Oy9EZgx//bgUdt44LwOjenO8Cj5zqt0Sz+zNbtpWtjwR5do7+uEEr5B3Vs1DyRmPKFPf0E4=
X-Received: by 2002:a05:600c:5307:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-459e7e4cbbdmr10991095e9.28.1754467716137;
        Wed, 06 Aug 2025 01:08:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnF+JC70Y+wij7D0xhvmStL7sg8B0/W7PEfpWoYIUbNo5rKcmTj513UkofaGh3WuFA13jIvg==
X-Received: by 2002:a05:600c:5307:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-459e7e4cbbdmr10990605e9.28.1754467715584;
        Wed, 06 Aug 2025 01:08:35 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0ffa9.dip0.t-ipconnect.de. [79.224.255.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm35850175e9.2.2025.08.06.01.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:08:34 -0700 (PDT)
Message-ID: <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
Date: Wed, 6 Aug 2025 10:08:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250718090244.21092-7-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 11:02, Dev Jain wrote:
> Use folio_pte_batch to batch process a large folio. Note that, PTE
> batching here will save a few function calls, and this strategy in certain
> cases (not this one) batches atomic operations in general, so we have
> a performance win for all arches. This patch paves the way for patch 7
> which will help us elide the TLBI per contig block on arm64.
> 
> The correctness of this patch lies on the correctness of setting the
> new ptes based upon information only from the first pte of the batch
> (which may also have accumulated a/d bits via modify_prot_start_ptes()).
> 
> Observe that the flag combination we pass to mprotect_folio_pte_batch()
> guarantees that the batch is uniform w.r.t the soft-dirty bit and the
> writable bit. Therefore, the only bits which may differ are the a/d bits.
> So we only need to worry about code which is concerned about the a/d bits
> of the PTEs.
> 
> Setting extra a/d bits on the new ptes where previously they were not set,
> is fine - setting access bit when it was not set is not an incorrectness
> problem but will only possibly delay the reclaim of the page mapped by
> the pte (which is in fact intended because the kernel just operated on this
> region via mprotect()!). Setting dirty bit when it was not set is again
> not an incorrectness problem but will only possibly force an unnecessary
> writeback.
> 
> So now we need to reason whether something can go wrong via
> can_change_pte_writable(). The pte_protnone, pte_needs_soft_dirty_wp,
> and userfaultfd_pte_wp cases are solved due to uniformity in the
> corresponding bits guaranteed by the flag combination. The ptes all
> belong to the same VMA (since callers guarantee that [start, end) will
> lie within the VMA) therefore the conditional based on the VMA is also
> safe to batch around.
> 
> Since the dirty bit on the PTE really is just an indication that the folio
> got written to - even if the PTE is not actually dirty but one of the PTEs
> in the batch is, the wp-fault optimization can be made. Therefore, it is
> safe to batch around pte_dirty() in can_change_shared_pte_writable()
> (in fact this is better since without batching, it may happen that
> some ptes aren't changed to writable just because they are not dirty,
> even though the other ptes mapping the same large folio are dirty).
> 
> To batch around the PageAnonExclusive case, we must check the corresponding
> condition for every single page. Therefore, from the large folio batch,
> we process sub batches of ptes mapping pages with the same
> PageAnonExclusive condition, and process that sub batch, then determine
> and process the next sub batch, and so on. Note that this does not cause
> any extra overhead; if suppose the size of the folio batch is 512, then
> the sub batch processing in total will take 512 iterations, which is the
> same as what we would have done before.
> 
> For pte_needs_flush():
> 
> ppc does not care about the a/d bits.
> 
> For x86, PAGE_SAVED_DIRTY is ignored. We will flush only when a/d bits
> get cleared; since we can only have extra a/d bits due to batching,
> we will only have an extra flush, not a case where we elide a flush due
> to batching when we shouldn't have.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>


I wanted to review this, but looks like it's already upstream and I 
suspect it's buggy (see the upstream report I cc'ed you on)

[...]

> +
> +/*
> + * This function is a result of trying our very best to retain the
> + * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
> + * if the vma is a private vma, and we cannot determine whether to change
> + * the pte to writable just from the vma and the pte, we then need to look
> + * at the actual page pointed to by the pte. Unfortunately, if we have a
> + * batch of ptes pointing to consecutive pages of the same anon large folio,
> + * the anon-exclusivity (or the negation) of the first page does not guarantee
> + * the anon-exclusivity (or the negation) of the other pages corresponding to
> + * the pte batch; hence in this case it is incorrect to decide to change or
> + * not change the ptes to writable just by using information from the first
> + * pte of the batch. Therefore, we must individually check all pages and
> + * retrieve sub-batches.
> + */
> +static void commit_anon_folio_batch(struct vm_area_struct *vma,
> +		struct folio *folio, unsigned long addr, pte_t *ptep,
> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
> +{
> +	struct page *first_page = folio_page(folio, 0);

Who says that we have the first page of the folio mapped into the first 
PTE of the batch?

> +	bool expected_anon_exclusive;
> +	int sub_batch_idx = 0;
> +	int len;
> +
> +	while (nr_ptes) {
> +		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);
> +		len = page_anon_exclusive_sub_batch(sub_batch_idx, nr_ptes,
> +					first_page, expected_anon_exclusive);
> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, len,
> +				       sub_batch_idx, expected_anon_exclusive, tlb);
> +		sub_batch_idx += len;
> +		nr_ptes -= len;
> +	}
> +}
> +
> +static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
> +		struct folio *folio, unsigned long addr, pte_t *ptep,
> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
> +{
> +	bool set_write;
> +
> +	if (vma->vm_flags & VM_SHARED) {
> +		set_write = can_change_shared_pte_writable(vma, ptent);
> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
> +				       /* idx = */ 0, set_write, tlb);
> +		return;
> +	}
> +
> +	set_write = maybe_change_pte_writable(vma, ptent) &&
> +		    (folio && folio_test_anon(folio));
> +	if (!set_write) {
> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
> +				       /* idx = */ 0, set_write, tlb);
> +		return;
> +	}
> +	commit_anon_folio_batch(vma, folio, addr, ptep, oldpte, ptent, nr_ptes, tlb);
> +}
> +
>   static long change_pte_range(struct mmu_gather *tlb,
>   		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
>   		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
> @@ -206,8 +302,9 @@ static long change_pte_range(struct mmu_gather *tlb,
>   		nr_ptes = 1;
>   		oldpte = ptep_get(pte);
>   		if (pte_present(oldpte)) {
> +			const fpb_t flags = FPB_RESPECT_SOFT_DIRTY | FPB_RESPECT_WRITE;
>   			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
> -			struct folio *folio;
> +			struct folio *folio = NULL;
>   			pte_t ptent;
>   
>   			/*
> @@ -221,11 +318,16 @@ static long change_pte_range(struct mmu_gather *tlb,
>   
>   					/* determine batch to skip */
>   					nr_ptes = mprotect_folio_pte_batch(folio,
> -						  pte, oldpte, max_nr_ptes);
> +						  pte, oldpte, max_nr_ptes, /* flags = */ 0);
>   					continue;
>   				}
>   			}
>   
> +			if (!folio)
> +				folio = vm_normal_folio(vma, addr, oldpte);
> +
> +			nr_ptes = mprotect_folio_pte_batch(folio, pte, oldpte, max_nr_ptes, flags);
> +
>   			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
>   			ptent = pte_modify(oldpte, newprot);
>   
> @@ -248,14 +350,13 @@ static long change_pte_range(struct mmu_gather *tlb,
>   			 * COW or special handling is required.
>   			 */
>   			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
> -			    !pte_write(ptent) &&
> -			    can_change_pte_writable(vma, addr, ptent))
> -				ptent = pte_mkwrite(ptent, vma);
> -
> -			modify_prot_commit_ptes(vma, addr, pte, oldpte, ptent, nr_ptes);
> -			if (pte_needs_flush(oldpte, ptent))
> -				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
> -			pages++;
> +			     !pte_write(ptent))
> +				set_write_prot_commit_flush_ptes(vma, folio,
> +				addr, pte, oldpte, ptent, nr_ptes, tlb);

While staring at this:

Very broken indentation.

> +			else
> +				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
> +					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);

Semi-broken intendation.

> +			pages += nr_ptes;
>   		} else if (is_swap_pte(oldpte)) {
>   			swp_entry_t entry = pte_to_swp_entry(oldpte);
>   			pte_t newpte;


-- 
Cheers,

David / dhildenb


