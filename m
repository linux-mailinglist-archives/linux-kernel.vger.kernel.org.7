Return-Path: <linux-kernel+bounces-832184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA48B9E956
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F69B1BC4D75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055EE2DE1F0;
	Thu, 25 Sep 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjsoqQna"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA326CE2A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795125; cv=none; b=ZbDkOEaaKchoy7R1rxLR4boYUxPhx7WKHykZEkK+Jjs0eSzYVdW13WsBdjGF9EBjWftV69eyyd9WvzxHdXRFDJ3VixZekzXRBpF/yvDM/yIBezP9TYeoYiFkkCTMLQEuwPm+BrR/VBCzb724F4r+AeG4kmMSFzw1GjuXAXRw9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795125; c=relaxed/simple;
	bh=bqjRzRkAxHbPvHDukofehyRkFCGJOoB0EPf4l7P7/nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhLiGSo8Rh5BDSMYibMDE3e+r97Q69EtWbcKl3AA+pVSd9sBDTanFmYxrj5y8xxbNbkW2e88EbFvd41XSNtvCplprzlrNCnwq+dgWMasGWtMz9v0G3MJ/jak3bRbqEjjUE9jHlIjPTsssEToJlm/K3VbRQKliw4duIpZhw0HP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjsoqQna; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758795122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lG8Q/FN8wXVOGFD2S5MD44NnHhqfaQZRP/OiKpWlrJQ=;
	b=BjsoqQnaGQwWRGBCqIMJlbGvf3Yc5a1Md2kk1MFGZ7sEa2UdZOu69ncVG1kF7+VbAddf0r
	lBMOuvp+fQj4qqng9ryHiUniwgVbpXVRQBsWrMFOzXXtllvK0rQ/gW7kjSQ4UZr2namQsW
	MF+keq6KGL+59bRR7buktZq17vNWhuc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-RafQEq2COamgmUQPCzHkSA-1; Thu, 25 Sep 2025 06:12:00 -0400
X-MC-Unique: RafQEq2COamgmUQPCzHkSA-1
X-Mimecast-MFC-AGG-ID: RafQEq2COamgmUQPCzHkSA_1758795120
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso6693705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795120; x=1759399920;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lG8Q/FN8wXVOGFD2S5MD44NnHhqfaQZRP/OiKpWlrJQ=;
        b=CvjgXCEOqUo4QQqDhMzV74STlgQRoPxT8tWL+6pQELownJbDPFk6Aus05H9xiAPaab
         UjlJfPtkdIaSADjTlwGow+tsoizx2Ib6Q6MsrNHN2frU2FdazSxr18XaKUAtnf7HoSzD
         s4YdOa7Rph9KEJOzIbZWM6HreREgsqg3GiZg+c1O9w25Pkm8oiHOo2zHlkrKFGhp/NFL
         TV2s3IgqZFo9EaQOFsfApIA1jFxMyCzzxj1wG/gObpvBYxwqOz7AGIHH58seZX2T8VxT
         QMCofZ1P6HIX4dtm4vMu1migy7K38TmYu2AcGtx+DfEs0T89k7H/ueMQ7IRGBLqH6Zc2
         Zeyg==
X-Forwarded-Encrypted: i=1; AJvYcCXNESjmNOd/LuBWwI8SNEL2Js7+0piZbz6AFCmkXcx7xsSboDvJJL3zcLr3bKEnOTC7eGQzz4sApLMWz1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YygsQZ8ey+qiwt1+TLftM6ow0cjbgxB/Yuq/ZRsY2Cwy7I8VZGj
	3ZP+BfDdSLQ2+bJoOXW2r5IPhNgso6GlbQd3wgZ6pADrGp3OJw38gzg0/NcaJXLbmtC2ZCkMH4s
	B9Sb7hgK/HW+/ayQSP3g0kNbg7Chdjr8Pj8UBATciZfvSWgXmHQWJYWzPSmDf0Fzsbg==
X-Gm-Gg: ASbGnctA+L5yyGzTnofx2YWSGGRtU0sdHncRJXtGkvD8Lkr1kPU60vsDDLWX9zm224R
	PJoxyuB7y35yQ6VegrqvOKV/TsPwnVfHcD3oI3w9QWltM8ImmeZ4lEAPkWmZI9dF/lB5A5UIdIU
	59WudL1X9PE9wZ114K4xkZ+PpGK3HazH5zt3ukg0kPmAeMMKiPeePNW3ZEzK2ZD3wchgedK1+yU
	wFaGJIxX6mMW6fToEhWU8HEPdetaRJOUpgKuw6T6mjAIUqnQZHCUyZr0EPybBQ0vK1oYe38ZYKE
	6itJekn99lmmGSq12oLVq0yjn1WoHFLNTVMXNf9HIPaQgFygqOptNuXOdWdJHqKIXnBqjPWZZjS
	86cG6M/uj0uH+S6+KPIMbCkP+fwNjmFoRbsU/IbwDi0njIY/Ex/WG39q1p3BEcs4rBt3o
X-Received: by 2002:a05:600c:1ca5:b0:46e:2637:d182 with SMTP id 5b1f17b1804b1-46e32a08feamr34778175e9.28.1758795119603;
        Thu, 25 Sep 2025 03:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlNMDizXc3Rq/dhiO8rd/15mVcqt0iIObArVPXmOTFpH25amynq0pBhSR/qoFGTRlMvFSsQw==
X-Received: by 2002:a05:600c:1ca5:b0:46e:2637:d182 with SMTP id 5b1f17b1804b1-46e32a08feamr34777545e9.28.1758795119112;
        Thu, 25 Sep 2025 03:11:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9eabbsm29826805e9.3.2025.09.25.03.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:11:58 -0700 (PDT)
Message-ID: <7fe72c55-fbf9-472e-8d10-5b6396994435@redhat.com>
Date: Thu, 25 Sep 2025 12:11:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 07/15] mm/memory/fault: add THP fault handling for zone
 device private pages
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alistair Popple <apopple@nvidia.com>
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Oscar Salvador <osalvador@suse.de>,
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
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-8-balbirs@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250916122128.2098535-8-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.09.25 14:21, Balbir Singh wrote:
> Implement CPU fault handling for zone device THP entries through
> do_huge_pmd_device_private(), enabling transparent migration of
> device-private large pages back to system memory on CPU access.
> 
> When the CPU accesses a zone device THP entry, the fault handler calls the
> device driver's migrate_to_ram() callback to migrate the entire large page
> back to system memory.
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
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
> ---
>   include/linux/huge_mm.h |  7 +++++++
>   mm/huge_memory.c        | 36 ++++++++++++++++++++++++++++++++++++
>   mm/memory.c             |  5 +++--
>   3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc985..2d669be7f1c8 100644
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
> @@ -671,6 +673,11 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	return 0;
>   }
>   
> +static inline vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
> +{
> +	return 0;
> +}
> +
>   static inline bool is_huge_zero_folio(const struct folio *folio)
>   {
>   	return false;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5291ee155a02..90a1939455dd 100644
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

We should be operating on a folio here. folio_trylock() + folio_get() + 
folio_unlock() + folio_put().

> +		get_page(page);
> +		spin_unlock(ptl);
> +		ret = page_pgmap(page)->ops->migrate_to_ram(vmf);

BTW, I was wondering whether it is really the right design to pass the 
vmf here. Likely the const vma+addr+folio could be sufficient. I did not 
look into all callbaks, though.

-- 
Cheers

David / dhildenb


