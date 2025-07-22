Return-Path: <linux-kernel+bounces-741208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD757B0E177
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E45563331
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9A27934A;
	Tue, 22 Jul 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ/hdL/5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D048836
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201030; cv=none; b=JxBOuRRnJP9zg+zvu4CUmczUQc4R0uVLsFoEsMp5GvpkO4i2ucQXvRZKqmnom0aRi3tueRPVe0Zc4Puc/td8gQZ6hMux5LIpd3/k+uAZt4JAlqbX0IapPjpZuBWRZatWIgAjWPlY+uHk/itAn3V9G3/qU532dbfzAQed2k6d0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201030; c=relaxed/simple;
	bh=tt/zcUeWbXw3rWd8kfav/lL2PGoaH5UHSjvEexf0EVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbC8/ds6od4DK8fDWMGw8w+YieMj1U30Npc/XPNQ4O424RfwkS0ZP/4UbbB0JsDf5go26ECEqRZGzXskncug/Q3p1FurAo72rTvYtoSgEAC6jmpQI4QhCfAZyWmu3Il098zZfQAk6YKhgM8JeKMj/b7FLjKUBG9R3KDL6O0vWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJ/hdL/5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753201027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zgrmDxPukJEiLJxm8blqAG1LGqhXeXnp1DkbV6uZnXo=;
	b=FJ/hdL/5T0FHeJ3Ip5JkWLoABHtsDiFXHYLNNzg70bsU8soj6pQ1QQcw859Hh3Gjm8z3YO
	a7l7gJ7JX27eZu9QwR8YL6zusPi9dSYPSxXYw4K3D85UA7oG5MvwjD9ww4geoxdDOZKS+Z
	FHVhthL3h1G1VeeXeRwDAX6rLQV/jU8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-6CxTWZOeNBSNTcvI2XZZPg-1; Tue, 22 Jul 2025 12:17:05 -0400
X-MC-Unique: 6CxTWZOeNBSNTcvI2XZZPg-1
X-Mimecast-MFC-AGG-ID: 6CxTWZOeNBSNTcvI2XZZPg_1753201025
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816cc58so2074073f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201024; x=1753805824;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zgrmDxPukJEiLJxm8blqAG1LGqhXeXnp1DkbV6uZnXo=;
        b=VlMpBYGcOEophmLaXJYj7MYQlhmAhKDwh+B/2jpZ9hSCkaFSvdZDpYOAjOPp7mUv2v
         xsQgaLSL0g8Gi8M28Q4VcHo75jyFGjRebf9b5l/W60pZxu/iJ1xDq+yAGUwHkQdTIp7t
         myV4zQI4EQmhB5zmr26/tkImjAtaYMl0laZQe17SZIlsKifMt40zO1TLN0lqOZqiEldN
         +B5jibc2q5O5eAt6BH/tjK942keGmpBI85oN5UgEPHy3J1UU38SIGW0qyqxNye1M4jI0
         h9NEgYincmAhXOvLcJ7WagCRP2nyKHYH7VDo8hVKLL6fqLSKw5cVtNwSWe0n/KMVm1Vp
         vt2g==
X-Forwarded-Encrypted: i=1; AJvYcCVjo9A0Gw9ZkbzHKFK8CSVYk+I+eBO5OsEyhveqqOtRuUKqXI2H7cRHH6It7+59gbAD7xAsP73YK3QHiE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbaju481E0IPMi/KRQDnOLUex4rieeAwHFKURtCCUF20Ld8B8B
	MD3dO4zcw5SeZemUBJ7mtmwaDhlbRsnuYgPan/YtTQcsx0CdOutBMfqktJ30mTxpJgsXEVezEI0
	YRJSI0yIhL/WWAJBFauZj2n2wg5KNk2uSFsBMwXNlr23MEI305rQH+tijpkBosSaw9w==
X-Gm-Gg: ASbGncsyEMWKjtjkXBeZDEFXM09hisxgjglvNdUFNYgta8q4W3RXgH1RwCkHpPjpfIy
	6C+cs5Z1z6XDpUELY8TARGawjDcRsAnqHQ3Rl/VMrrDR3D47jImGOxtSDYT/K0p5L34xYnSEHpw
	eVnAFGyPlntOwRt+bMZBTNCC25/eU9P6OxHgn0zfUZ8pTwlOk9YYyLCVgW/cFIz8fRVvbpy25TO
	/9NeDG8tc9krP4xh+r2Z1B7J7ns9s0BDkO2hh0OXtjzwjcJ+rlr2qYq3W/dMett9q2+pMED9hgt
	IwNpDpEMYUf8gYrlX5Yo4fC1XDKVhRE4qnlU/CCDUsF8KA5FJ1fcGPi2GdiaZWqUHocrv/8=
X-Received: by 2002:a05:600c:4f46:b0:456:1d4e:c161 with SMTP id 5b1f17b1804b1-456352d0b48mr212646585e9.2.1753201024564;
        Tue, 22 Jul 2025 09:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBlPu188TQS5+VNgBWuYZr82JHaWKwW9P5rBiofD6Df6J5XVyjTwzc+rPD8gpRnyI4ohUcDQ==
X-Received: by 2002:a05:600c:4f46:b0:456:1d4e:c161 with SMTP id 5b1f17b1804b1-456352d0b48mr212646265e9.2.1753201023959;
        Tue, 22 Jul 2025 09:17:03 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f597.dip0.t-ipconnect.de. [79.224.245.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45862cf0fcbsm23088775e9.0.2025.07.22.09.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:17:02 -0700 (PDT)
Message-ID: <c9a34cf3-96a5-4a92-8e4c-34d67b1d3fe8@redhat.com>
Date: Tue, 22 Jul 2025 18:17:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] khugepaged: Optimize collapse_pte_mapped_thp() by
 PTE batching
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250722150559.96465-1-dev.jain@arm.com>
 <20250722150559.96465-4-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250722150559.96465-4-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 17:05, Dev Jain wrote:
> Use PTE batching to optimize collapse_pte_mapped_thp().
> 
> On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
> Then, calling ptep_clear() for every pte will cause a TLB flush for every
> contpte block. Instead, clear_ptes() does a contpte_try_unfold_partial()
> which will flush the TLB only for the (if any) starting and ending contpte
> block, if they partially overlap with the range khugepaged is looking at.
> 
> For all arches, there should be a benefit due to batching atomic operations
> on mapcounts due to folio_remove_rmap_ptes() and saving some calls.

Please simplify that (and make it less arm specific) like suggested for 
patch #2.

PTE batching has known benefits on all architectures :)

> 
> Note that we do not need to make a change to the check
> "if (folio_page(folio, i) != page)"; if i'th page of the folio is equal
> to the first page of our batch, then i + 1, .... i + nr_batch_ptes - 1
> pages of the folio will be equal to the corresponding pages of our
> batch mapping consecutive pages.

Yeah, that must stay to make the comment from "step 1" happy.

> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/khugepaged.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 63517ef7eafb..1ff0c7dd2be4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1503,15 +1503,16 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>   int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   			    bool install_pmd)
>   {
> +	int nr_mapped_ptes = 0, nr_batch_ptes, result = SCAN_FAIL;
>   	struct mmu_notifier_range range;
>   	bool notified = false;
>   	unsigned long haddr = addr & HPAGE_PMD_MASK;
> +	unsigned long end = haddr + HPAGE_PMD_SIZE;
>   	struct vm_area_struct *vma = vma_lookup(mm, haddr);
>   	struct folio *folio;
>   	pte_t *start_pte, *pte;
>   	pmd_t *pmd, pgt_pmd;
>   	spinlock_t *pml = NULL, *ptl;
> -	int nr_ptes = 0, result = SCAN_FAIL;
>   	int i;
>   
>   	mmap_assert_locked(mm);
> @@ -1625,11 +1626,15 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   		goto abort;
>   
>   	/* step 2: clear page table and adjust rmap */
> -	for (i = 0, addr = haddr, pte = start_pte;
> -	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
> +	for (i = 0, addr = haddr, pte = start_pte; i < HPAGE_PMD_NR;
> +	     i += nr_batch_ptes, addr += nr_batch_ptes * PAGE_SIZE,
> +	     pte += nr_batch_ptes) {
 > +		int max_nr_batch_ptes = (end - addr) >> PAGE_SHIFT;>   		struct 
page *page;
>   		pte_t ptent = ptep_get(pte);
>   
> +		nr_batch_ptes = 1;
> +
>   		if (pte_none(ptent))
>   			continue;
>   		/*
> @@ -1643,26 +1648,29 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   			goto abort;
>   		}
>   		page = vm_normal_page(vma, addr, ptent);
> +
>   		if (folio_page(folio, i) != page)
>   			goto abort;
>   
> +		nr_batch_ptes = folio_pte_batch(folio, pte, ptent, max_nr_batch_ptes);

Same comment regarding matching types for folio_pte_batch(), now that we 
changed that -- unsigned int.

> +
>   		/*
>   		 * Must clear entry, or a racing truncate may re-remove it.
>   		 * TLB flush can be left until pmdp_collapse_flush() does it.
>   		 * PTE dirty? Shmem page is already dirty; file is read-only.
>   		 */
> -		ptep_clear(mm, addr, pte);
> -		folio_remove_rmap_pte(folio, page, vma);
> -		nr_ptes++;
> +		clear_ptes(mm, addr, pte, nr_batch_ptes);
> +		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
> +		nr_mapped_ptes += nr_batch_ptes;
>   	}
>   
>   	if (!pml)
>   		spin_unlock(ptl);
>   
>   	/* step 3: set proper refcount and mm_counters. */
> -	if (nr_ptes) {
> -		folio_ref_sub(folio, nr_ptes);
> -		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
> +	if (nr_mapped_ptes) {
> +		folio_ref_sub(folio, nr_mapped_ptes);
> +		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
>   	}
>   
>   	/* step 4: remove empty page table */
> @@ -1695,10 +1703,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   			: SCAN_SUCCEED;
>   	goto drop_folio;
>   abort:
> -	if (nr_ptes) {
> +	if (nr_mapped_ptes) {
>   		flush_tlb_mm(mm);
> -		folio_ref_sub(folio, nr_ptes);
> -		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
> +		folio_ref_sub(folio, nr_mapped_ptes);
> +		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);

Doing the TLB flush and adjusting the refcount after dropping the PTL 
... interesting. Well, nothing surprises me in khugpaged code anymore.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


