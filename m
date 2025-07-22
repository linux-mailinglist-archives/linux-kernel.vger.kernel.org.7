Return-Path: <linux-kernel+bounces-741186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A768B0E12E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FCC1C25F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484D27A461;
	Tue, 22 Jul 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNn7kbfI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCBBA36
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200235; cv=none; b=AYd1d04kBPVKsBEzM2XrNztUs7I3brgTEnad5pkbRmR13RZANYmRcOp/AYBCKcRik6z1oPyXhMyza2UmBU+ctszybH5ryDDBEYv8AXNGu7hexwSNEUImQMHduwTe0kxdZBDjQd1dG2Ew2mcALg4fcEJCiccNarWDSKWQ3Kg83I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200235; c=relaxed/simple;
	bh=Hh1zR7NiuqHkiCIYP47eAvac9QPxzt32AmMqEGs5KbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuBYLxpm6bwgM7ILG/OO5N1K2hV/RgCwZZt0Eu6ycYxst6KyCgGJ/GWXZK7TASNuw2n/ZRI7hX0QvXqb+N+bY+FShCOzlWqcUQTGY1+d6xIR9HeMFgYCl7ec5ysszIJV7hONsL16UCO8MHkjiWssTquuWfaeQcMYADWhZ0GAoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNn7kbfI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753200222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v15CwaAASIebecWsLEoJV+pNv0uu/91AKcRmtsxqL0g=;
	b=cNn7kbfIcAf0TYA8t/DPECl2U+tcHBM0ulU1tjnEMsVw5z2a9BSnFpy/KtH85zKOT/rpWv
	KDXzkXv+Rc+fSGtTmUd2rcar3RczRpHYEWaKS+gwXoTUDi8v4yGj0Dcg3TsDimAa/Oy63S
	PmdO7lfCcLGrjXhbS3sR5M8RtlN7LSc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423--UVzAClRN5eHeHPY2uS76Q-1; Tue, 22 Jul 2025 12:03:41 -0400
X-MC-Unique: -UVzAClRN5eHeHPY2uS76Q-1
X-Mimecast-MFC-AGG-ID: -UVzAClRN5eHeHPY2uS76Q_1753200220
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso28512085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200220; x=1753805020;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v15CwaAASIebecWsLEoJV+pNv0uu/91AKcRmtsxqL0g=;
        b=kDyWurL7U4o4jixykd9I4kMHx5oQpiZGyRW5GIGBmbhlYBXK9yNA3zZU34MWeapHzL
         46cJpfWgQx7LlxejW7qgt3MXYBKGo5ewy7/R+KP9+wE14yEhF85DEhhuaT13exUHXkYN
         zR5WYcVe6I7GsJrOhMs7zxTuc/2JxelkCna096FAWTRSuYHpfWGXqbjhoIlS1fg+Mz7n
         7Khx4uo3S8IP2mZIxZSoqPzWp5i01CozVIj4RLFiUAMD/YaevfZalrPtO1GApihMf9BZ
         sb6ATJ5PE29xEomR7c1yNULFHdnf1p6kcf5ZDIVcUaFxc6rsIlOFbAbIwRFb8JMxPx9e
         wtiw==
X-Forwarded-Encrypted: i=1; AJvYcCUMXMbD+tKE7YI0vxGxXM8vdPhBJvFNWsOpBVDYOBNKpNJ76IU2uAKzzBYhmjie/anY4bjssvW9fEN+pUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPiKGel5t/qW3XAn1xEeC00YxN0XIrmKFqG9m8AwIJsF4n77V
	2EkKN3BQ0kJ//q6G10pZ9dV8h0JqkPpHjl2Z/5HzHWeLiONj5fFx4jkTc4Wf77PTJEWpPAdKbxU
	LaurA5V8knvBKUPppkvtUhtGJFXdFeaKdBcPJbAEJOJ0IyHlK9N7gNu3g2icilwIycw==
X-Gm-Gg: ASbGncuOmXQvnfUTLt6RaXfeOu3BdXsTbNdhBijwVacJ1+s7h5WX1LrpfqPfCvlLbTM
	vZBOZqsswdX1bpWl+FRZI3DoAKhuVmlLmtFhEiNlkkZTXqQXi/IhBYZHLR21Qelv8P6imrR+EiR
	5oLTMYmZG6bIFWhiyvRYYD8LYN4XlsxoE13TPYUPEoU/vvcyKVFPJ64U/BKzvvaE/MW9qrMRo5n
	LSzGIxzOUOBtlHMU6sDCur/TBXFEia4jsrH1knIE7ycoJlrVNVITpCDCDHJTFvJCLPsaxGs2Han
	oaHdAeq8x6vHbGuzUUMEoQo0A65nh3D4b19gRP5uIe88ejhMJGHQAx8MwggnwaDoI2f3Tp7izzH
	G9pgdnPJBSxlBC/L/WkNv6ByBJPMav+Cj/vFrqfNIWr9hIu1XuXYhiLBzkl7gLkg+34k=
X-Received: by 2002:a05:600c:c84:b0:456:d1c:ef38 with SMTP id 5b1f17b1804b1-4586798f55fmr1065825e9.24.1753200218128;
        Tue, 22 Jul 2025 09:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9KzrNKh9CcwV7LTDal3K5awiRUZDWhKDtMkNJxt2L01VFpDA1WbAK3crvJfh3A364TrxTpA==
X-Received: by 2002:a05:600c:c84:b0:456:d1c:ef38 with SMTP id 5b1f17b1804b1-4586798f55fmr1064865e9.24.1753200217207;
        Tue, 22 Jul 2025 09:03:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f5f3sm132242885e9.25.2025.07.22.09.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:03:36 -0700 (PDT)
Message-ID: <2765db16-431d-4c77-8091-889a45c18e35@redhat.com>
Date: Tue, 22 Jul 2025 18:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] khugepaged: Optimize
 __collapse_huge_page_copy_succeeded() by PTE batching
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250722150559.96465-1-dev.jain@arm.com>
 <20250722150559.96465-3-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250722150559.96465-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 17:05, Dev Jain wrote:
> Use PTE batching to optimize __collapse_huge_page_copy_succeeded().
> 
> On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
> Then, calling ptep_clear() for every pte will cause a TLB flush for every
> contpte block. Instead, clear_ptes() does a contpte_try_unfold_partial()
> which will flush the TLB only for the (if any) starting and ending contpte
> block, if they partially overlap with the range khugepaged is looking at.

I suggest not talking so much about arm specifics.

Simply say that batching reduced the number of TLB flushes, especially 
on architectures that support cont-pte optimizations.

> 
> For all arches, there should be a benefit due to batching atomic operations
> on mapcounts due to folio_remove_rmap_ptes() and saving some calls.

I would rephrase that to "Independent of that, batching PTE unmapping 
has known performance benfits (i.e., less refcount and mapcount updates)".

> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/khugepaged.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a55fb1dcd224..63517ef7eafb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -700,12 +700,15 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   						spinlock_t *ptl,
>   						struct list_head *compound_pagelist)
>   {
> +	unsigned long end = address + HPAGE_PMD_SIZE;
>   	struct folio *src, *tmp;
> -	pte_t *_pte;
>   	pte_t pteval;
> +	pte_t *_pte;
> +	int nr_ptes;

Nit: I guess we should switch to "unsigned int" here now for consistency 
with folio_pte_batch().

>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> -	     _pte++, address += PAGE_SIZE) {
> +	for (_pte = pte; _pte < pte + HPAGE_PMD_NR; _pte += nr_ptes,
> +	     address += nr_ptes * PAGE_SIZE) {
> +		nr_ptes = 1;
>   		pteval = ptep_get(_pte);
>   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>   			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> @@ -722,18 +725,26 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   			struct page *src_page = pte_page(pteval);
>   
>   			src = page_folio(src_page);
> -			if (!folio_test_large(src))
> +
> +			if (folio_test_large(src)) {
> +				int max_nr_ptes = (end - address) >> PAGE_SHIFT;

Dito.

> +
> +				nr_ptes = folio_pte_batch(src, _pte, pteval, max_nr_ptes);
> +			} else {
>   				release_pte_folio(src);
> +			}
> +

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


