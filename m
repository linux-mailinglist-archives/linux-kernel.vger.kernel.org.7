Return-Path: <linux-kernel+bounces-733305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AB7B072F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411105675A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E412F2C69;
	Wed, 16 Jul 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIXWrIsr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C62F237F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660969; cv=none; b=nKZW2u3eXsLHE8mbvJlPjl9qYwfY8JYd+2rig7eBDhcrO2CJSq5MmHlLnZ5BAai4azTrg3VGlMQHJcYRiA6zAKRrLSA+CoAPPx7FpH1ShMjyqKN4Oe3LyO6umFbsWqSOZXHQCLdyZDiTT595Qx/iKKCL/3Yx4cLn30kJgCMMGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660969; c=relaxed/simple;
	bh=F0Pd9lOqj7J7dTxWDn+7McmgKo7mGS/KYc3ODDLHZug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYBNiXfsGVPDe6mBLW5FxdkCO1Qsy3MMFKy8JH5L/i7TaOYHyW9QRFle07BoLBhYCISqvpyUQboa17w73zTGbHtWMnvkERqtGLmZXUW7cXp4HJ9zVZ2kfkTCBWzqANXat93W4aQm9Rh6PxR3sKTDPDpp4gh4CV9QYn98qIw3axA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIXWrIsr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752660966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=flA8nx4B4YOnN5P74oY+zDuUkp95nmtsIwS1BvsmrjQ=;
	b=WIXWrIsrNfXlTwbojbcL+1q8lCzoNh+dz2U+5sAs7srd35xNSMYvSQSn6vj1miVi9kXLjn
	A6ApgzimOTY/mnQOJImaxR4HRmPbdz2KxdMN5Wj6zbya3m59zzuqT6umZCV+GSd1adpn5+
	i6SGywCEqSBvqYmzgeigsjm3d5LY5Zc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404--ALYLSLVOU6UtwHYEiGz4g-1; Wed, 16 Jul 2025 06:16:05 -0400
X-MC-Unique: -ALYLSLVOU6UtwHYEiGz4g-1
X-Mimecast-MFC-AGG-ID: -ALYLSLVOU6UtwHYEiGz4g_1752660964
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45359bfe631so37395345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660964; x=1753265764;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=flA8nx4B4YOnN5P74oY+zDuUkp95nmtsIwS1BvsmrjQ=;
        b=pGwKZnqOnSpP+QqLrwZBWYi51vlagdFPh70L9yOMv65xTDHxbirXaoAEym39SdpBH1
         uw4ohQD4PKM1Q2C2+iyb5ceVI8OsU34t3JIeQlYb6gfml1Y/IImaJdSHdhUaPSYCM/PH
         1rCO1bp/TtK6U4dFJY6qjEAVpsqH23Yll3Ziv6EEJyg1qGx2AFifIAc9Edo0b593q9NC
         Z77V7UCj3ZyDMw5k6b6vMv9tFIlqbAQ6VAWpQ1nszAD3mnPB9fyaR+REMwW6zfaj417x
         CqzzEa7YdApe6qEv3LR26nskQX9g9XpQJ6zkh0FlxzzaZhoM8qAg9TljhWDNkdT2kvpR
         ypVQ==
X-Gm-Message-State: AOJu0YwTlGySu+UwJPUA4syFqKHqsfwH4PXQPUSo6qRgnzmWkwMdxNCD
	xnv8x7Bq0CwlZIw33XpLiVYRx4Z6aKdP8XBbB7yvSgW/7iB9cFN4/a2Dy1ZlvAPFemPSvBr4sgy
	CxAlpZ3yrqb+Gtd/aINWzoigUdvidDOw30DxYs0JYUyQA9BDveD7gXUmsq654Q2okaw==
X-Gm-Gg: ASbGncuLvWzXX5n8Mw2wZfxydjT7XLjFS8ElBdM+ow9bwJBRbG5sFAYLk9JBGJ6OYLK
	wWxnjcHf34klSuNSZw57diaKmTCt1XcG5309QxkLCD5Crrjk2YC3wCkXOIIpUhBx5Ilu9MECV/2
	YP1QRAhC4Sg0mI/zrF1OjWNE8c/sdM6/ghX06IOsLi8OcRZcDKMiyrOzronqUZbN1g6zcu1og1P
	9UYjrIGeF3ithloH2n92k7gxZY1oCsFP9Q1hZ48r2+0ZWE7onlonzEQkmUKBQz29clh4HQEcBDB
	8P2fuxidL/uFfpSDPZk4BgO8c1mYQeU3zH2nzo5nPLInJp9+0rw/Jp4TgRVevK4yN/Br9Og9cUh
	B4EEHIdGTeClOtFFfpkQ9iRQHi5jHBeCnkNaDeC7kjGSrZxJnwQMqtOs9HBvATxf9FwA=
X-Received: by 2002:a05:600c:46ca:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-4562dfd72admr23028835e9.6.1752660964342;
        Wed, 16 Jul 2025 03:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPu49QZciwGvdobBdNGHoaNlj2yAUibyYfxl6yDGr/NB9XNFV1l6HtcPoXfaR9qKs3coPWuA==
X-Received: by 2002:a05:600c:46ca:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-4562dfd72admr23028315e9.6.1752660963819;
        Wed, 16 Jul 2025 03:16:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm17251054f8f.22.2025.07.16.03.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:16:03 -0700 (PDT)
Message-ID: <ca72882f-257f-4f41-bea2-0b5324c820d7@redhat.com>
Date: Wed, 16 Jul 2025 12:16:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm/util: introduce snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

>   
> -dump:
> -	__dump_folio(foliop, &precise, pfn, idx);
> +	__dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);

Nit that can be cleaned up later on top:

We should probably call this

__dump_page_snapshot() and then just pass ... the page_snapshot.

>   }
>   
>   void dump_page(const struct page *page, const char *reason)
> diff --git a/mm/util.c b/mm/util.c
> index 0b270c43d7d1..f270bf42465b 100644
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
> @@ -1171,3 +1172,81 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>   	return 0;
>   }
>   EXPORT_SYMBOL(compat_vma_mmap_prepare);
> +
> +static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
> +			 const struct page *page)
> +{
> +	/*
> +	 * Only the first page of a high-order buddy page has PageBuddy() set.
> +	 * So we have to check manually whether this page is part of a high-
> +	 * order buddy page.
> +	 */
> +	if (PageBuddy(page))
> +		ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
> +	else if (page_count(page) == 0 && is_free_buddy_page(page))
> +		ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
> +
> +	if (folio_test_idle(folio))
> +		ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
> +}
> +
> +/**
> + * snapshot_page() - Create a snapshot of a struct page
> + * @ps: Pointer to a struct page_snapshot to store the page snapshot
> + * @page: The page to snapshot
> + *
> + * Create a snapshot of the page and store both its struct page and struct
> + * folio representations in @ps.
> + *
> + * Note that creating a faithful snapshot may fail if the compound

Maybe highlight that this is not really expected to happen, ever.

> + * state of the page keeps changing (e.g., due to a folio split). In
> + * this case, ps->faithful is set to false, and the snapshot assumes

There is no ps->faithful.

> + * that @page refers to a single page.
> + */
> +void snapshot_page(struct page_snapshot *ps, const struct page *page)
> +{
> +	unsigned long head, nr_pages = 1;
> +	struct folio *foliop;
> +	int loops = 5;
> +
> +	ps->pfn = page_to_pfn(page);
> +	ps->flags = PAGE_SNAPSHOT_FAITHFUL;
> +
> +again:
> +	memset(&ps->folio_snapshot, 0, sizeof(struct folio));
> +	memcpy(&ps->page_snapshot, page, sizeof(*page));
> +	head = ps->page_snapshot.compound_head;
> +	if ((head & 1) == 0) {
> +		ps->idx = 0;
> +		foliop = (struct folio *)&ps->page_snapshot;
> +		if (!folio_test_large(foliop)) {
> +			set_ps_flags(ps, page_folio(page), page);
> +			memcpy(&ps->folio_snapshot, foliop,
> +			       sizeof(struct page));
> +			return;
> +		}
> +		foliop = (struct folio *)page;
> +	} else {
> +		foliop = (struct folio *)(head - 1);
> +		ps->idx = folio_page_idx(foliop, page);
> +	}

Condition could be cleaned up by reversing both things

if (head & 1) {
	/* Tail page, lookup the actual head. */
	foliop = (struct folio *)(head - 1);
	ps->idx = folio_page_idx(foliop, page);
} else
	...
}

But you're just moving that code, so no need to do that now.


I think we could improve some of that in the future a bit to
make it even more faithful.

But for now this should be just fine.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


