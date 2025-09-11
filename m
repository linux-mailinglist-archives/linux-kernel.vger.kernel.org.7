Return-Path: <linux-kernel+bounces-812067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D6B53291
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC837A92E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2B320CDD;
	Thu, 11 Sep 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ftlnpjv/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13C22A4F6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594533; cv=none; b=M4FZOSqHF8oEsARZ63wI/22hhvm2Mek1A3IACoSVip4UFfPHNAhmwGxedGvQ24U244SjdAn2VTEJLaicappNm/ElcQZ/zz1IMJCyf3GEgP7tedRYIRk6/oB45BWud0A1EChx+HVPp6vDsNods02oKFTSovwbxtNlKUOc4oPIORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594533; c=relaxed/simple;
	bh=Z04Ki7B5HrUz2Q5U6rrC9c656Nh93TawTMmr/eeo3/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hyb46JEb+tnybajg93QOVnUUx+uirdoyUYnAY75aRTGQpREoxnaleI+M7N00gijQqRZxoUjeQcFOGZb47s5lKt7nTffww0B3u+CBfbWNwc8+nNlBfqbZ71xpbb3A0wFbt8oDjEHwdRDOQTizverwpN098rehjriimR4MAC1r53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ftlnpjv/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757594530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QgjmqO8SZYiSSNbuqjw/+LEAvLvMVdQ4JyG2LZ/F9u4=;
	b=Ftlnpjv/K63ah5fsylBjzagIhduQUdpEUfcKFf3VDAy41lN+8LZHkalD7t9qNIZEK+QPtb
	Wwj0E9DSNXRgwP3kkWtQK8EisA1hdQq3EtSF04YQEKeraopQFaWBH31GJo+yFEo8Te6FJF
	+3ob5InvEcsx10pqQ9YHSIz/ucCw95U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-jq85js5WOMGrg107MC8aAQ-1; Thu, 11 Sep 2025 08:42:09 -0400
X-MC-Unique: jq85js5WOMGrg107MC8aAQ-1
X-Mimecast-MFC-AGG-ID: jq85js5WOMGrg107MC8aAQ_1757594528
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so6701115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757594528; x=1758199328;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgjmqO8SZYiSSNbuqjw/+LEAvLvMVdQ4JyG2LZ/F9u4=;
        b=N5vwACJQo9KEHKB3vX2Qk/0PIcVIOIOhZZM6XDdHjkJoAc+raD46yVJ2jvm5hENssQ
         Z8yUxrJ5Op2HMV50WkrternzNI1OGOz3EpnnlJ0B/SOebdznrGCkStqGRiiFy1P10KaD
         YSJj98tPt5AH3peRe8Q7tEd834pSLN0gkgShsIskw0PDpQow9tipfc84ElIGHZ/6EbTv
         +IY0HXGqSVMKnHkd4FS2kRuoEqcnxCD6/Zcd8RrE66fgWJNGxA3q6TiwA4dspcXYPGag
         ucbBYmWkJV4rgUyrheS2xFrZ8Ya+ZjjlvLVP8nAD+cJeZ01xEUZyRGlh3wsLvZMw+EWh
         qP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0GNyG2AlZM1/w0shg2MbOjhqNbSM9pNs6LRic2MVOaMBpde5UJXM0SeA8A6ijSKDi8MBkG7TQC/pZQ44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jxWliXK8bum1BqNTK624ay3hcvxezzv27nblfaHa49RuXmBI
	daOmd57DaM0r/jTvrg5BLPLzPvKvhgnwlnsbGxZRBelfzUBADuVnn+hr0UqmcLi+W4zfDrkoQnH
	3TOclrXBhxtgGG3OO9i/fY/LevHDYSeLyOsNEWjAxeunaEPnJM8RDSKxlOfdgBf9zQA==
X-Gm-Gg: ASbGncuo9ZlkiGaxonEcFbOvyCXzgZV+GYG5CXhGqG0YAMzCA/i8NslMW/HrQE3bQbv
	URQzwwGnlzAtMIPwxpELpfK2UWQfmDkrC/e16LhSPuZsScRIupjHHSWfXI832j+8GZ/8+sIwom/
	cSuPLyNlZChD4hNggQOitLUd+i1IIxop6LbcbWVP0Ef+PLEj6TOB5wTOMcvLAX6GsGJLA++7E6V
	g1R1B5sc93MAdFNHnrBv6BoGt8AgD1S39oMlobmnCbWC3ckygz+iigXrTtu9azXNtSNcP5CS0cZ
	b59nnoUgAcC5w+gDHQYbOLBxPBNnhbDZuxWiyBt25q/biKZEHHut+d0rKfqxz92TPBzbWgh7ZV/
	/tx01Bd7UcS4HvC8mOtUsm4241V4/Cuo3J+XlRjIkQBN4aDTpqdJpBnVdHC6wn6sSUvs=
X-Received: by 2002:a05:600c:5247:b0:45d:cf5f:cff8 with SMTP id 5b1f17b1804b1-45de2028e47mr171825455e9.11.1757594527651;
        Thu, 11 Sep 2025 05:42:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO3UgHu/gwI/hsgKG8HwCLbnyXISyfhUyVybHY35t3VDw/LBeDedVd1v1Q4+SvaiJ5o8WPjg==
X-Received: by 2002:a05:600c:5247:b0:45d:cf5f:cff8 with SMTP id 5b1f17b1804b1-45de2028e47mr171824945e9.11.1757594527093;
        Thu, 11 Sep 2025 05:42:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01575fadsm25690325e9.6.2025.09.11.05.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 05:42:06 -0700 (PDT)
Message-ID: <d4ae7f61-f2f9-45dc-91db-4de7f3127744@redhat.com>
Date: Thu, 11 Sep 2025 14:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 07/15] mm/memory/fault: add THP fault handling for zone
 device private pages
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-8-balbirs@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908000448.180088-8-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.09.25 02:04, Balbir Singh wrote:
> Implement CPU fault handling for zone device THP entries through
> do_huge_pmd_device_private(), enabling transparent migration of
> device-private large pages back to system memory on CPU access.
> 
> When the CPU accesses a zone device THP entry, the fault handler
> calls the device driver's migrate_to_ram() callback to migrate
> the entire large page back to system memory.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>   include/linux/huge_mm.h |  7 +++++++
>   mm/huge_memory.c        | 36 ++++++++++++++++++++++++++++++++++++
>   mm/memory.c             |  6 ++++--
>   3 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 23f124493c47..2c6a0c3c862c 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -496,6 +496,8 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
>   
>   vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
>   
> +vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf);
> +
>   extern struct folio *huge_zero_folio;
>   extern unsigned long huge_zero_pfn;
>   
> @@ -675,6 +677,11 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	return 0;
>   }
>   
> +static inline vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
> +{

Is this a VM_WARN_ON_ONCE() or similar? (Maybe BUILD_BUG is possible?)

> +	return 0;
> +}
> +
>   static inline bool is_huge_zero_folio(const struct folio *folio)
>   {
>   	return false;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b720870c04b2..d634b2157a56 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1287,6 +1287,42 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>   
>   }
>   
> +vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +	spinlock_t *ptl;
> +	swp_entry_t swp_entry;
> +	struct page *page;
> +
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +		vma_end_read(vma);
> +		return VM_FAULT_RETRY;
> +	}
> +
> +	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> +	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd))) {
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +	swp_entry = pmd_to_swp_entry(vmf->orig_pmd);
> +	page = pfn_swap_entry_to_page(swp_entry);
> +	vmf->page = page;
> +	vmf->pte = NULL;
> +	if (trylock_page(vmf->page)) {
> +		get_page(page);
> +		spin_unlock(ptl);
> +		ret = page_pgmap(page)->ops->migrate_to_ram(vmf);
> +		unlock_page(vmf->page);
> +		put_page(page);
> +	} else {
> +		spin_unlock(ptl);
> +	}
> +
> +	return ret;
> +}
> +
>   /*
>    * always: directly stall for all thp allocations
>    * defer: wake kswapd and fail if not immediately available
> diff --git a/mm/memory.c b/mm/memory.c
> index d9de6c056179..860665f4b692 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6298,8 +6298,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>   		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
>   
>   		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> -			VM_BUG_ON(thp_migration_supported() &&
> -					  !is_pmd_migration_entry(vmf.orig_pmd));
> +			if (is_device_private_entry(
> +					pmd_to_swp_entry(vmf.orig_pmd)))

Single line please.

But didn't we have a pmd helper for that?

> +				return do_huge_pmd_device_private(&vmf);
> +
>   			if (is_pmd_migration_entry(vmf.orig_pmd))
>   				pmd_migration_entry_wait(mm, vmf.pmd);
>   			return 0;


-- 
Cheers

David / dhildenb


