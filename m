Return-Path: <linux-kernel+bounces-733662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E811B0778D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5642A3B33BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB81CAA6C;
	Wed, 16 Jul 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4BDtBUZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB861BA27
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674583; cv=none; b=RYCbHpik3lq2T3k4MTmarQ/CaqIkqXZpnf9KR7o2IJPBPxAAES3FffMVxWugCm7vsmXcaQtavNNcG8oWw7Elo1iNePOvmKfkUnauQBhxBxpF3QW2imoqK1YjhX6o+6oyWB85NPi/Rv1XWxB9IGxZcfZLmCHg/DPxC+2zhvnYdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674583; c=relaxed/simple;
	bh=11rsffLSSuCcM8QFAMx2KmEF16GRe0AWBjsEaPVD7I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3VL/aFWt2fpS0A1VZTuii8j9a7dDuzw3gB9u9M0LGTiAndHfpfZ38xemEbqbWGz0BroYhzda+IP5U9TTneti+g4NdHzVxq0Cm7P1XI9Lob6vSZz7Uw1Lushau+Kvs7JGz2MkNu208grjIdlFu8Xjamp6UulyGrNbSshCA1qQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4BDtBUZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EuCVBPhjjaPKQImXvEwQilBSaIVZ4Esr5XTI8Cdh6E4=;
	b=Y4BDtBUZmOjME6vt/K5VDKLIXpnLbjELos3BnNlG/FTfr4+drnRonqCTcY9rhcd/DWafAn
	8E3/JpS0iwkdDoQAJmcEf1Hb4nxE8koSj4pHxQI/PLBPiwue1GGjGc1AvnEhFrsY0qXT+w
	a5KM1WAQd9Ws+ypNPakC3SVRRA5CRw8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-w8rMIsyhODaYZ7uKhRzA1Q-1; Wed, 16 Jul 2025 10:02:54 -0400
X-MC-Unique: w8rMIsyhODaYZ7uKhRzA1Q-1
X-Mimecast-MFC-AGG-ID: w8rMIsyhODaYZ7uKhRzA1Q_1752674570
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso52900425e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674570; x=1753279370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EuCVBPhjjaPKQImXvEwQilBSaIVZ4Esr5XTI8Cdh6E4=;
        b=eCHZI0CL1zcQgrmAv/HkPGserV64Fzf4p7i4X8fz4g/Tb1gGI6ndAPjx2oWD656Mop
         ueESXqye2/sBSg6fWD4Uhybbad9bfR3niOWMg6cZxQGPlXmgp7q0jTyH628/5rPT3bQm
         FGcGTsndCd5FMFEGYPcEO83ColXV+TbpWLXqGCbXx+2RbKHNcecELF+dQJKoy4uAO44i
         Bl5ILyeOSmnP37lyoq711RwvZYJ5ALHUNqfII4jxJUgqQhK1uBYJqT+4lSurKhzgEw8y
         M/um2FzwpvDJXZT4yxWt7urce5Dhi694x71kMcLR/OBqoIZRaE4G5CbgpqfeDRcn/W30
         5Apw==
X-Forwarded-Encrypted: i=1; AJvYcCVyGht9OYkAYcSiIrTEuz4r27LBi+hfDWoIqH1Hgimnb16AxOO4jA1Kr314K9ZI9asBNMy/okv2Guqjic0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IWwJ/Q+efMOEbKcFUuD2t7l3tnEzyXfjxKoejuSzKCg6ABvz
	QdqNWDj1gizof5B5BKmaOsEExZzf9inAVbLvtWCLfGlC8XberJlAbyAkwMLaJXqhgc+I6fMEe1Q
	vTIrTnBLmAi7kWNwchl28v145+JKXRe2uo1fiL9CF4HtQGJhbY1Ssy9CLAaDe+/hV1Q==
X-Gm-Gg: ASbGncsa0Q8zqnPwH4QO8FpWiSd9EglQUyIzMGFjfMsK2dMKtAjEDRIWX7aFbKDs94w
	kfaicOX9EbIaQQr72YUDrZwyGzFC2QI+KDyGw+6lHs0mr9xVUJhztRO51YYNokxfBK8IOl0LjDB
	RbcQNSDOwdLQn+ds4D2PxywNcN5h2ni809ma0VADMkUxGxgnMfQiEug6XcSJYHaxPvLtbeh2yM1
	G2Np+X8oJvZ1debc5qvIqdlCnKEl7ebQiPS5VkAZmjItV889AHUjDLtNiXOBn58x06PqSnbnf69
	4lMQtYFH17/XzwEx2UmjAt7orCnScV/LuttnUnXIAWjeCb4/zzhq0UF+1taPbMrVedYWMBlDsQI
	pc1GN0XCgEa32ZoJXOAj8yHJ5hQHydEtt4WaLMhkHt4gjw1ZZAUBkxALMFIyP6NydQlE=
X-Received: by 2002:a05:600c:3f14:b0:456:2dc1:a603 with SMTP id 5b1f17b1804b1-4562f70fa2cmr22370395e9.5.1752674568347;
        Wed, 16 Jul 2025 07:02:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3wX3Mr86IyLqrsIHFVjFgQl73bgijD88nQKbtQxzm3svX1bNi0MOnFgmITQLdAGujToWWNw==
X-Received: by 2002:a05:600c:3f14:b0:456:2dc1:a603 with SMTP id 5b1f17b1804b1-4562f70fa2cmr22367085e9.5.1752674565706;
        Wed, 16 Jul 2025 07:02:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45630ec911esm11673405e9.38.2025.07.16.07.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:02:45 -0700 (PDT)
Message-ID: <5ff595db-3720-4ce3-8d92-5f08d0625c75@redhat.com>
Date: Wed, 16 Jul 2025 16:02:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-6-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-6-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> generalize the order of the __collapse_huge_page_* functions
> to support future mTHP collapse.
> 
> mTHP collapse can suffer from incosistant behavior, and memory waste
> "creep". disable swapin and shared support for mTHP collapse.
> 
> No functional changes in this patch.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++------------------
>   1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cc9a35185604..ee54e3c1db4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -552,15 +552,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   					unsigned long address,
>   					pte_t *pte,
>   					struct collapse_control *cc,
> -					struct list_head *compound_pagelist)
> +					struct list_head *compound_pagelist,
> +					u8 order)
>   {
>   	struct page *page = NULL;
>   	struct folio *folio = NULL;
>   	pte_t *_pte;
>   	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>   	bool writable = false;
> +	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + (1 << order);
>   	     _pte++, address += PAGE_SIZE) {
>   		pte_t pteval = ptep_get(_pte);
>   		if (pte_none(pteval) || (pte_present(pteval) &&
> @@ -568,7 +570,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   			++none_or_zero;
>   			if (!userfaultfd_armed(vma) &&
>   			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			     none_or_zero <= scaled_none)) {
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> @@ -596,8 +598,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		/* See hpage_collapse_scan_pmd(). */
>   		if (folio_maybe_mapped_shared(folio)) {
>   			++shared;
> -			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
> +			    shared > khugepaged_max_ptes_shared)) {
>   				result = SCAN_EXCEED_SHARED_PTE;
>   				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>   				goto out;
> @@ -698,13 +700,14 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   						struct vm_area_struct *vma,
>   						unsigned long address,
>   						spinlock_t *ptl,
> -						struct list_head *compound_pagelist)
> +						struct list_head *compound_pagelist,
> +						u8 order)
>   {
>   	struct folio *src, *tmp;
>   	pte_t *_pte;
>   	pte_t pteval;
>   
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + (1 << order);
>   	     _pte++, address += PAGE_SIZE) {
>   		pteval = ptep_get(_pte);
>   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> @@ -751,7 +754,8 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   					     pmd_t *pmd,
>   					     pmd_t orig_pmd,
>   					     struct vm_area_struct *vma,
> -					     struct list_head *compound_pagelist)
> +					     struct list_head *compound_pagelist,
> +					     u8 order)
>   {
>   	spinlock_t *pmd_ptl;
>   
> @@ -768,7 +772,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   	 * Release both raw and compound pages isolated
>   	 * in __collapse_huge_page_isolate.
>   	 */
> -	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> +	release_pte_pages(pte, pte + (1 << order), compound_pagelist);
>   }
>   
>   /*
> @@ -789,7 +793,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>   static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
>   		unsigned long address, spinlock_t *ptl,
> -		struct list_head *compound_pagelist)
> +		struct list_head *compound_pagelist, u8 order)
>   {
>   	unsigned int i;
>   	int result = SCAN_SUCCEED;
> @@ -797,7 +801,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   	/*
>   	 * Copying pages' contents is subject to memory poison at any iteration.
>   	 */
> -	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +	for (i = 0; i < (1 << order); i++) {
>   		pte_t pteval = ptep_get(pte + i);
>   		struct page *page = folio_page(folio, i);
>   		unsigned long src_addr = address + i * PAGE_SIZE;
> @@ -816,10 +820,10 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>   
>   	if (likely(result == SCAN_SUCCEED))
>   		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
> -						    compound_pagelist);
> +						    compound_pagelist, order);
>   	else
>   		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> -						 compound_pagelist);
> +						 compound_pagelist, order);
>   
>   	return result;
>   }
> @@ -994,11 +998,11 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>   static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   				       struct vm_area_struct *vma,
>   				       unsigned long haddr, pmd_t *pmd,
> -				       int referenced)
> +				       int referenced, u8 order)
>   {
>   	int swapped_in = 0;
>   	vm_fault_t ret = 0;
> -	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
> +	unsigned long address, end = haddr + (PAGE_SIZE << order);
>   	int result;
>   	pte_t *pte = NULL;
>   	spinlock_t *ptl;
> @@ -1029,6 +1033,15 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   		if (!is_swap_pte(vmf.orig_pte))
>   			continue;
>   
> +		/* Dont swapin for mTHP collapse */
> +		if (order != HPAGE_PMD_ORDER) {
> +			count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SWAP);

Doesn't compile. This is introduced way later in this series.

Using something like

git rebase -i mm/mm-unstable --exec "make -j16"

You can efficiently make sure that individual patches compile cleanly.

-- 
Cheers,

David / dhildenb


