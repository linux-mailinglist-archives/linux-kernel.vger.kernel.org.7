Return-Path: <linux-kernel+bounces-727522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FEB01B47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D716B41CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7928E575;
	Fri, 11 Jul 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKopnqPe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02011175D47
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235001; cv=none; b=QM2FHh+q7pmfWuQ4c9053M0aNA329OR1X0hQCdFP6dg3VNASygBqNE/Nr5A5E9xl8C3woYXzdJhhNuIMtuY6qLL9uqziM8StAR+4F/GZaw0HfVYB2v2DDNm/dVe1EPmC9zdsb5ojavTt52TEHp6N7aR3lailwd1iAMKUu/xFXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235001; c=relaxed/simple;
	bh=xuqFTaY+B18PA1D08AT0Cwp7X/6BfwsiWmrMknuLR+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WA+ORLmuTXP4jgpSgTeFLhd1rKdtFDuJLfUMA6WgFwe+H0JvgGsN1hDQkSKcIdMJI2A3OGu+rR1O5b7uSQikG9vkIfIX3issI+OLfUy1BjSZ+ykspQz+Y5P+toZ1xqlq+fBdxbTUMz9E1g/ggFB5ERqDv+1PXbhluVddy4PVOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKopnqPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752234998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BZxYI/9wIUBgFT+OSGp9NvxtvS4cZKRz8rn5ILEqRaE=;
	b=BKopnqPeIEsy5iol205iGLJHE648FZxVWkEDF9cENu4uXTUI68hPi4xrGZGQXMWEe7pXdF
	FQGyV72BoqxKxl6WFC+I+B/6r605tmBW+0nhHKmaltfuvqqlyhfjEJ3QWZUV14eSLqYLzw
	qqLzt8Ex703vYJmant5JKjSXuE8gLMI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-494zBUcyPa69ZIuWcY4B2g-1; Fri, 11 Jul 2025 07:56:37 -0400
X-MC-Unique: 494zBUcyPa69ZIuWcY4B2g-1
X-Mimecast-MFC-AGG-ID: 494zBUcyPa69ZIuWcY4B2g_1752234996
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-454acc74f22so13014635e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234996; x=1752839796;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZxYI/9wIUBgFT+OSGp9NvxtvS4cZKRz8rn5ILEqRaE=;
        b=EXFpSCVuBNbqls1e4E8wL24wVFn3Sy1n72YA0Wg4ONMl7nFfGK67RpwcarhvksincJ
         ZllpzQSqKeGZo3gSbv83SlefHh+BqZTV3tPU7JZootAin+39PkmCzihyqop8pzRhTLm/
         f6zoZKTY0kVB0VXqjOXIiutsRsxEzqvzDxuSuww64HHk2thMhzxjPcDfWBgMhZPrbPAA
         wSDs2o7PSBjnpDzN7O31TlU+tEkVcmIYoMt2pBt0/wgqRwtpT6hjAGslHzpjnPe/DHQ4
         gC+IRFj3dWiNP04bxR8R4Z/sYjrYT+Z2bn/EHN6zc9CTugvoRD93lHaWrayzK1GEpzXH
         IAvg==
X-Gm-Message-State: AOJu0Yyaq3WaMVBonz/LyBcqImVKhjMficqtwP3fJOtNOSPXcYf4vKxU
	bppaTUg1qdESBbVjQVah8Jq8FVDkJpMG1eMCHi8/fh0JH1YRAaQKzI/VFI8PYOJBH1aqx2+LeIF
	VmFNBYE2xClcHUvH9iwxpxze2xGrSQv8qTYIwOs/5P+3Wt229BpVlmcbXNsAWdy/N5w==
X-Gm-Gg: ASbGncuDp89Q1K5gHbfCRhNE5wvAurtHyPlRcEdKpSC1mpo541TmoEqRB2CbHfMKzpg
	xn8WU6ZLpa5gyy0eVsdkfsGG0RNLLR/kUqZD1zOrgCcm/gPrDFIXoKVEiLO3+/br/3JP9pIEq2O
	+Lixc3sq9Ul1Ab4fv12ApkDCFK5GP6jwtm1u9KyneuOiBlFjVPwHDLerF7272uiSQvnZnaT/o3E
	Fb2kdY0gX8gkFC9Sx3ZSkjmFY4D1M2uhiYIiJBmd+28oGDIN2KTwtfmRE5fwyeMfGdmmzZMnF3r
	zcLRtkIkk46kjZgLaq9ysd6y2ev8tPNJbdP1m0cxz1spSE4rXcxBs6qLXS+WFr+DSVgl4hjkdbH
	vWLhk2orxEUeFcictyixT0JWLTw7zKcV/hVda+qqySN5JnFiw/AhmsIz5eMqH/Ef5cmE=
X-Received: by 2002:a05:600c:34c5:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-45565edc8f4mr20078635e9.23.1752234996227;
        Fri, 11 Jul 2025 04:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJupiNvYJVh7JrpQF1MrlV6PbQYiv7lXZ9WrSatpba31oH5MBEJUnIt4ILpVV2n+71+b6Mvg==
X-Received: by 2002:a05:600c:34c5:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-45565edc8f4mr20078315e9.23.1752234995668;
        Fri, 11 Jul 2025 04:56:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f6794a00sm2066425e9.37.2025.07.11.04.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 04:56:35 -0700 (PDT)
Message-ID: <40d3d56a-e434-4d3d-ba0e-3f1204edbda5@redhat.com>
Date: Fri, 11 Jul 2025 13:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/util: introduce snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 20:50, Luiz Capitulino wrote:
> This commit refactors __dump_page() into snapshot_page().
> 
> snapshot_page() tries to take a faithful snapshot of a page and its
> folio representation. The snapshot is returned in the struct
> page_snapshot parameter along with additional flags that are best
> retrieved at snapshot creation time to reduce race windows.
> 
> This function is intended to be used by callers that need a stable
> representation of a struct page and struct folio so that pointers
> or page information doesn't change while working on a page.
> 
> The idea and original implementation of snapshot_page() comes from
> Matthew Wilcox with suggestions for improvements from David Hildenbrand.
> All bugs and misconceptions are mine.
> 
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>   include/linux/mm.h | 19 ++++++++++++
>   mm/debug.c         | 42 +++----------------------
>   mm/util.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 100 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..090968c6eebb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
>   }
>   #endif
>   
> +#define PAGE_SNAPSHOT_FAITHFUL     (1 << 0)
> +#define PAGE_SNAPSHOT_PG_FREE      (1 << 1)

Can we call this "BUDDY" instead of FREE

There are other types of free pages -- in particular free hugetlb folios 
-- which won't be covered by this check. We really only care about 
"buddy" pages, which correspond to "free" pages.

That's what we check and alter expose :)

> +#define PAGE_SNAPSHOT_PG_IDLE      (1 << 2)
 > +> +struct page_snapshot {
> +	struct folio folio_snapshot;
> +	struct page page_snapshot;
> +	unsigned long pfn;
> +	unsigned long idx;
> +	unsigned long flags;
> +};
> +
> +static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
> +{
> +	return ps->flags & PAGE_SNAPSHOT_FAITHFUL;
> +}
> +
> +void snapshot_page(struct page_snapshot *ps, const struct page *page);
> +
>   #endif /* _LINUX_MM_H */
> diff --git a/mm/debug.c b/mm/debug.c
> index 907382257062..7349330ea506 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -129,47 +129,13 @@ static void __dump_folio(struct folio *folio, struct page *page,
>   
>   static void __dump_page(const struct page *page)
>   {
> -	struct folio *foliop, folio;
> -	struct page precise;
> -	unsigned long head;
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long idx, nr_pages = 1;
> -	int loops = 5;
> -
> -again:
> -	memcpy(&precise, page, sizeof(*page));
> -	head = precise.compound_head;
> -	if ((head & 1) == 0) {
> -		foliop = (struct folio *)&precise;
> -		idx = 0;
> -		if (!folio_test_large(foliop))
> -			goto dump;
> -		foliop = (struct folio *)page;
> -	} else {
> -		foliop = (struct folio *)(head - 1);
> -		idx = folio_page_idx(foliop, page);
> -	}
> +	struct page_snapshot ps;
>   
> -	if (idx < MAX_FOLIO_NR_PAGES) {
> -		memcpy(&folio, foliop, 2 * sizeof(struct page));
> -		nr_pages = folio_nr_pages(&folio);
> -		if (nr_pages > 1)
> -			memcpy(&folio.__page_2, &foliop->__page_2,
> -			       sizeof(struct page));
> -		foliop = &folio;
> -	}
> -
> -	if (idx > nr_pages) {
> -		if (loops-- > 0)
> -			goto again;
> +	snapshot_page(&ps, page);
> +	if (!snapshot_page_is_faithful(&ps))
>   		pr_warn("page does not match folio\n");
> -		precise.compound_head &= ~1UL;
> -		foliop = (struct folio *)&precise;
> -		idx = 0;
> -	}
>   
> -dump:
> -	__dump_folio(foliop, &precise, pfn, idx);
> +	__dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
>   }
>   
>   void dump_page(const struct page *page, const char *reason)
> diff --git a/mm/util.c b/mm/util.c
> index 0b270c43d7d1..c38d213be83f 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -25,6 +25,7 @@
>   #include <linux/sizes.h>
>   #include <linux/compat.h>
>   #include <linux/fsnotify.h>
> +#include <linux/page_idle.h>
>   
>   #include <linux/uaccess.h>
>   
> @@ -1171,3 +1172,79 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>   	return 0;
>   }
>   EXPORT_SYMBOL(compat_vma_mmap_prepare);
> +
> +static void set_flags(struct page_snapshot *ps, const struct folio *folio,
> +		      const struct page *page)
> +{
> +	/*
> +	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
> +	 * on the head page.
> +	 */

Talking about slab here is a bit misleading, IIRC they are proper 
compound pages today. For PG_buddy (which was renamed to PGTY_buddy), we
are dealing with non-compound higher allocations.

So talking about "head" is also a bit misleading.

/*
  * Only the first page of a high-order buddy page has PageBuddy() set.
  * So we have to check manually whether this page is part of a high-
  * order buddy page.
  */

> +	if (PageBuddy(page))
> +		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
> +	else if (page_count(page) == 0 && is_free_buddy_page(page))
> +		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
> +
> +	if (folio_test_idle(folio))
> +		ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
> +}
> +
> +/*

I would suggest writing proper kernel doc (you mostly have that already)

Something like

/**
  * snapshot_page() - Create a snapshot of a "struct page"
  * @ps: struct page_snapshot to store the page snapshot
  * @page: the page we want to snapshot
  *
  * Create a snapshot of a page and store its struct page and struct
  * folio ...

> + * Create a snapshot of a page and store its struct page and struct folio
> + * representations in a struct page_snapshot.
> + *
> + * @ps: struct page_snapshot to store the page snapshot
> + * @page: the page we want to snapshot
> + *
> + * Note that creating a faithful snapshot of a page may fail if the page
> + * compound keeps changing (eg. due to folio split). In this case we set
> + * ps->faithful to false and the snapshot will assume that @page refers
> + * to a single page.
> + */

-- 
Cheers,

David / dhildenb


