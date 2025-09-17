Return-Path: <linux-kernel+bounces-820811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8026B7F5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174F01B21723
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36B330506C;
	Wed, 17 Sep 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtHN411b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FB1E25FA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115799; cv=none; b=mFacA91w57aCHu/5aZBkAS+tJV3zSA+dkDLYxwDh/HKFjUz4xUzvjH59V9DYVVfLpk0EgcyUa5lv5WJi0opdsvPeKQSPflvqjXjkykpAp1c8fhPR6dHvSDlfEim5rt9Mx+Q0xCofBk11rPLtps63s2b07uYHlB7bdC9sNN0wGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115799; c=relaxed/simple;
	bh=WLqnIK5fO6LMHVj4rkpSBrR3QhHZuNFGvGx2HGK1r/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJez3s0mFVXqEO1JlXngezAUOZWGLve3VgckGAHErS8iLiyKtQWL/M1RyGkv4VS1t3AH6+ji44TTDyTHeef6S07qKEOmo07deelMFmRlmYrl3EItr9HsfFZiYF5ByjsUu3LlQRfK29XNV0hbLUidlu7lLMv/trIEkGs3eP81d6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtHN411b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758115796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ORcJ/40pST81yvYCAWc/eP0hnGAXGVPHAP2CtAwPNcM=;
	b=UtHN411bjyGhrwbExCb4k4Keoi6ODdDEFpkU4fLTRIqM4yEhMZrzuX2l0lhsrIHFDDM+zT
	yrqHu0+J8MJCChJfnBR1xw92J6h1uDGLYS7my1vyTuWZ112EOGXQ+IxwW6k7MWTGjng/+u
	fTFLS0RQAW6JvYsjYmqZoGo5RuJVYLM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-9EHKU5xBPj2wj7vjrl4XSQ-1; Wed, 17 Sep 2025 09:29:54 -0400
X-MC-Unique: 9EHKU5xBPj2wj7vjrl4XSQ-1
X-Mimecast-MFC-AGG-ID: 9EHKU5xBPj2wj7vjrl4XSQ_1758115793
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso22942335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115793; x=1758720593;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORcJ/40pST81yvYCAWc/eP0hnGAXGVPHAP2CtAwPNcM=;
        b=sjSBKbxeycZpDCQfL+hkLyH/hQAXXeRor3r6Jgs89tGHisFm6eYdJSpDh108JvSMJa
         A6/qaDs43UH00ZOaySCUYnKOKyPyn9/xeKIhmgfTRcCAGJzVzrzd8TosjxD5TntW5sjJ
         wCSdbWiz9UQly5R8wfdlDlkFHuFxCb5ppW42AglcudHff8Sa3VL9SNHWAGGEMvJtsiXA
         KSp4GY+FgcEqdca+4R7KJzH2XlB5cOKmRAeS9SsLb3ID2VNudmfuoI2YdZfiSYmjWpYK
         Emc06c2mrAajnRcwm0YBfpSho0KNCteieoP4TFSsVuBbnhks5LHtu0sDQyYR/7tY4KJ8
         g3NA==
X-Forwarded-Encrypted: i=1; AJvYcCVyHFemuuU3IEMy/D9/4+MCQgwRPBdUc84AbDie/s0PNeZj6LQ1Z9MnyZr/sslBRE2gu8Q0fdb9qks7xy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc234AQLp34gXobYhSLLdFM+uwe3HqixAoTaoXKPjshV7A0gbw
	zQklF2G7v1iHzdzgFGit1wWPrv26VqhzPlD28p52KbAK1YLt446hP0cGamXYC6lQM11MIpJrq2h
	LzYkIW3pd0NPK4GegqE75+JRXuk6Vo7VXKOJCogXQvR8FwZ/AKf3fedLN/mNARev0Bw==
X-Gm-Gg: ASbGncs8fFR/kKLyfdgBBDAda+//PvrNO/XkxRUp4LOzKBxUrUZ+BBI81qnoSurJXHd
	eHRlfPrbfBazL//Eneb94ZU2DiWHkAoztYcjtBET17EVTXxTf/IbrSrRltM+NiV4/qOetzq6BtS
	otK2cw7pq/9/+b6mlp18i0F4wZag29LIXZUBV2QYic327pgsJj/P+EYA5UxqhbP1kL4IwgjMdjn
	nDacdvZ3zNyvoDO0bxYzAYhDnTuEePQJd9kFSj5qbDySiqJd9J/VM8ediprdfZLrxSFFOo/W2yF
	XlLGJuResA57kFj9178gNyJTjG4mrivNx5NgnkTypz+J7/MF6rr+/k0voDwn53zLmljppwzwdFS
	8NHKsCUG234rA3kMGTgvrjSv5Yywqn9nRaF94U3bG+l/jebXwWy4rqYgHV60KlpAc
X-Received: by 2002:a05:600c:1f0e:b0:45b:8adf:cf2c with SMTP id 5b1f17b1804b1-4620683f83amr19218005e9.26.1758115793373;
        Wed, 17 Sep 2025 06:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi7ScQOvFIV87bvvmxFiQ/fPZp7fWi1TbijKapfO5dtDS3+Ivg3MogGqO325Ep+dlBbTlwFQ==
X-Received: by 2002:a05:600c:1f0e:b0:45b:8adf:cf2c with SMTP id 5b1f17b1804b1-4620683f83amr19217705e9.26.1758115792898;
        Wed, 17 Sep 2025 06:29:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm38795825e9.23.2025.09.17.06.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:29:52 -0700 (PDT)
Message-ID: <aba22290-3577-44fa-97b3-71abd3429de7@redhat.com>
Date: Wed, 17 Sep 2025 15:29:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/memblock: Correct totalram_pages accounting with
 KMSAN
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, rppt@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 Aleksandr Nogikh <nogikh@google.com>
References: <20250917123250.3597556-1-glider@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917123250.3597556-1-glider@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 14:32, Alexander Potapenko wrote:
> When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
> for metadata instead of returning them to the early allocator. The callers,
> however, would unconditionally increment `totalram_pages`, assuming the
> pages were always freed. This resulted in an incorrect calculation of the
> total available RAM, causing the kernel to believe it had more memory than
> it actually did.
> 
> This patch refactors `memblock_free_pages()` to return the number of pages
> it successfully frees. If KMSAN stashes the pages, the function now
> returns 0; otherwise, it returns the number of pages in the block.
> 
> The callers in `memblock.c` have been updated to use this return value,
> ensuring that `totalram_pages` is incremented only by the number of pages
> actually returned to the allocator. This corrects the total RAM accounting
> when KMSAN is active.
> 
> Cc: Aleksandr Nogikh <nogikh@google.com>
> Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>   mm/internal.h |  4 ++--
>   mm/memblock.c | 18 +++++++++---------
>   mm/mm_init.c  |  9 +++++----
>   3 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 45b725c3dc030..ae1ee6e02eff9 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -742,8 +742,8 @@ static inline void clear_zone_contiguous(struct zone *zone)
>   extern int __isolate_free_page(struct page *page, unsigned int order);
>   extern void __putback_isolated_page(struct page *page, unsigned int order,
>   				    int mt);
> -extern void memblock_free_pages(struct page *page, unsigned long pfn,
> -					unsigned int order);
> +extern unsigned long memblock_free_pages(struct page *page, unsigned long pfn,
> +					 unsigned int order);
>   extern void __free_pages_core(struct page *page, unsigned int order,
>   		enum meminit_context context);
>   
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 117d963e677c9..de7ff644d8f4f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1834,10 +1834,9 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
>   	cursor = PFN_UP(base);
>   	end = PFN_DOWN(base + size);
>   
> -	for (; cursor < end; cursor++) {
> -		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
> -		totalram_pages_inc();
> -	}
> +	for (; cursor < end; cursor++)
> +		totalram_pages_add(
> +			memblock_free_pages(pfn_to_page(cursor), cursor, 0));
>   }

That part is clear. But for readability we should probably just do

if (memblock_free_pages(pfn_to_page(cursor), cursor, 0))
	totalram_pages_inc();

Or use a temp variable as an alternative.


LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


