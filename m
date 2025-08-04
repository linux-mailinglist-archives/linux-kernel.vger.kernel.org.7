Return-Path: <linux-kernel+bounces-755408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC17B1A5E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB53117EF66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35521FF53;
	Mon,  4 Aug 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObGTYIPH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B320A5F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321084; cv=none; b=UArc0Q6tz9h4KmurLnxWCPtnSMSRPGITbGrqCkfCXyczEeJ5hlxyGVV5GjsyLBflq0SnZmjgn/3+umerw/kcy1/zZQytz+x2MsIwvMlCibsOKOlV8xD+vitwsZ9hrSgQchhJvM0JcvxhTHsT6DKrdayW9rhM1lIQXfxsq3yN2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321084; c=relaxed/simple;
	bh=8sPCuZFbx8jtYrDGcnfw/YAzIMM6NLklRmiIWWyRoQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsEnoX7meg+NS40hCb159CmBXHmX2G6Itn87MFAYw06iel6qfoO6hLXw3+NqFWArblD4+LCiMPeql2N3vwIu4UWp2gzoWupWBJx6Lh4k+sA66tLqVmK5dMBY61qAcuymCTi1XNGQKAlZpR/8TObZR34YkVqs6iz9CXhuPTJ560U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObGTYIPH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754321081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kW4XtQ/FhoaGY9EkuOe6y+0BG9ZRHFWRVCua+Iw0inQ=;
	b=ObGTYIPHKNW7Yx9DUPMf4xMUHI2xs+pDUyeeNJh2vOnpDivPWmwyTztpQIXpDZBAyeDvvk
	ZjW9xRCWgQFke7Vt/4zrlMTFhwRtPoqDajZjVj2ves7/1oLRSs7eHkq3tE0J52w4xcKedG
	o6+f7WD39Sjn0tH9alXCPRFtxtVfnGg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-tKTEAYekNcGxoYV4GMX8zw-1; Mon, 04 Aug 2025 11:24:40 -0400
X-MC-Unique: tKTEAYekNcGxoYV4GMX8zw-1
X-Mimecast-MFC-AGG-ID: tKTEAYekNcGxoYV4GMX8zw_1754321079
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b836f17b50so1962692f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321079; x=1754925879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kW4XtQ/FhoaGY9EkuOe6y+0BG9ZRHFWRVCua+Iw0inQ=;
        b=NWvB++o95OFsucT3M3IN0ac3dA6IsptqSx+4o8dAf+4HTNAjjfNnSRk1vK9rKOBZjD
         f5VXQSI5cQFStjOMHNdLKLfFYSqF2N8PuBxkuEJwu4LdLwnwduytvvaOPZMmNZpzIpvq
         /lxakOvVQLvlk/xgIioSnKSyGjchuvUiYFBmsDEZ3vfVAcALGFQeJIVq65zl+eGATaRb
         4PmunDARrtJYgrce9e8RioN72Mq4BXJf4mnfDcu4NzPtwJSWpojwvTI2xXDRfoQvTKMl
         ve1NR0AV6TCmlGVfnIZCZlPmnGKqltu+/hEHv4HsnKKcIPnjOZ6imCbxe2H7PXiahejO
         1K2g==
X-Forwarded-Encrypted: i=1; AJvYcCVbtuRjnKo6qHRznPbRM9x/sOfJY/OGbDi1KzlvLpwUs09yFTykyMQLLMdpKSDDps/SfFJCpRwgTcTlb9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvJG7VqPKsF3YqBW8h7bVogo25K/OM1lR3B5OMMfzmWu47eUZ
	hI6snSdYYRe8xWUI1FW3Gft1r37W29Iuw1safK2+Tm7e5N8DNyzEISlY3LeqgNk+RwCEzr5vbu5
	YWQm/p6mYta0IpyzuENptXrU4wEbso37EO3A59dba1CH/2T7ySW09AYjPFASKTW9VEg==
X-Gm-Gg: ASbGncv5n/c5N+iQ6y5fHH5kqFJmOZK7x3BFscWHv2ufbr25XX1Fkht4zR4yr6fUHBR
	1ihacozQ5KT/Rs8n8/bjJ/LW8DaaIoq2fPW44N9wWTfMU+WFD3dpcbslBZrmxA9bVJkA2Oa2T7D
	r/hkZ4WbStGoTBceCYkKQFT8OkwFeNwJmKqx5OZuFfTh7jgZVF+HU4bxRigsAZsvO3ZVUQ1Tw7L
	iOVt1Ik8jRnPohVM+uCL03BM4jHlRLeen8PcvnUZ4AvquN69qLu/LK+DiidNVuTaTQML+6RcmFc
	GIrEOSos75hSY//PsXQuEW27qgDV/bCEzR37B4fqnLZG0DmtfTbeLm9YEauI9WMI/APueq+VxBr
	puXbLkPJjYnCUTQi/h4M48+3uj42ifBwWOXteRqkMmkO3RYXtnBsEh3S+tKaoPIEVyzM=
X-Received: by 2002:a05:6000:40e1:b0:3b7:8c5c:539a with SMTP id ffacd0b85a97d-3b8d94b997fmr7049633f8f.38.1754321078701;
        Mon, 04 Aug 2025 08:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8UktDNXc+sUhDaDsDt8iUUUu8OhJBBMLKFLygBGUdsEfwIEPiwPZU87tf9aZQY65OJesAhA==
X-Received: by 2002:a05:6000:40e1:b0:3b7:8c5c:539a with SMTP id ffacd0b85a97d-3b8d94b997fmr7049607f8f.38.1754321078224;
        Mon, 04 Aug 2025 08:24:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm15914012f8f.18.2025.08.04.08.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:24:37 -0700 (PDT)
Message-ID: <34d34fac-9a8b-4496-a6db-725c40d0408b@redhat.com>
Date: Mon, 4 Aug 2025 17:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix accounting of memmap pages for early sections
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>
References: <20250804151328.2326642-1-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804151328.2326642-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 17:13, Sumanth Korikkar wrote:
> memmap pages can be allocated either from the memblock (boot) allocator
> during early boot or from the buddy allocator.
> 
> When these memmap pages are removed via arch_remove_memory(), the
> deallocation path depends on their source:
> 
> * For pages from the buddy allocator, depopulate_section_memmap() is
>    called, which should decrement the count of nr_memmap_pages.
> 
> * For pages from the boot allocator, free_map_bootmem() is called, which
>    should decrement the count of the nr_memmap_boot_pages.
> 
> Ensure correct tracking of memmap pages for both early sections and non
> early sections by adjusting the accounting in section_deactivate().
> 
> Cc: stable@vger.kernel.org
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
> v2: consider accounting for !CONFIG_SPARSEMEM_VMEMMAP.
> 
>   mm/sparse.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 3c012cf83cc2..b9cc9e548f80 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -680,7 +680,6 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>   	unsigned long start = (unsigned long) pfn_to_page(pfn);
>   	unsigned long end = start + nr_pages * sizeof(struct page);
>   
> -	memmap_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
>   	vmemmap_free(start, end, altmap);
>   }
>   static void free_map_bootmem(struct page *memmap)
> @@ -856,10 +855,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>   	 * The memmap of early sections is always fully populated. See
>   	 * section_activate() and pfn_valid() .
>   	 */
> -	if (!section_is_early)
> +	if (!section_is_early) {
> +		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
>   		depopulate_section_memmap(pfn, nr_pages, altmap);
> -	else if (memmap)
> +	} else if (memmap) {
> +		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
> +				      PAGE_SIZE)));
>   		free_map_bootmem(memmap);
> +	}
>   
>   	if (empty)
>   		ms->section_mem_map = (unsigned long)NULL;

Acked-by: David Hildenbrand <david@redhat.com>

Hopefully we're not missing anything important.

-- 
Cheers,

David / dhildenb


