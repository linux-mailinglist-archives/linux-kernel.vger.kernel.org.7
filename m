Return-Path: <linux-kernel+bounces-727602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC07AB01CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FEEB43D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2A2D3EED;
	Fri, 11 Jul 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRrS50P/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF12D3A86
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238786; cv=none; b=QdSTaJKVPVH6r7kAs/JZ7WrLpBjbU0OepUS5fdkbnjm5ponzQ/vanYZ+ooETxQFicikkwGJFqNuhMEIQML6l1ltwR4n3dRHNWllJzggHe6Ft7TO+3r0HddFRhqbyKypNCSkr+8FOE+/qMMSwD1FqoC6ZhX23+LlmubuaokLypW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238786; c=relaxed/simple;
	bh=m7esh3T1x8yX/AgfDt3ykcW2n2FQbn3jM7clROb6N0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivxnSNXVJi+U/G6TjhOCX0wMe3utLnwj0SeMyUZNyliuAuvV3izQ7ywbAN8GLBCRdO2CTdjoCN7RlsHWLaNkCHMSiEzWXtdeYKxnXdO4k/aRLaMvjxMAM4EFwYy0v9AzRJ0jzKton9VaNZr1CJS71aPHLSc047Bl0y0xFlNNSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRrS50P/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752238782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+KGefdoj7lli46Ixaj0pts4ezHX60fxoxyKo1M6BYo=;
	b=fRrS50P/38ogo/TvO36cIiFmkcmyRRntFnJVnaDibma6Pt0CYwzyICnBi9VHvzsVtV5ZUj
	Vjlt1SAdYzAXlQfaDzJW3gBtFH4/+pZesvloSDJvsZzzGHkJZPoNs/5EfLja/VyS95LkEp
	4UKh4f5++fbmhKaoMGDtb1w4GoJZEPw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-yW5aNU7rPS62hDARt0u14Q-1; Fri, 11 Jul 2025 08:59:41 -0400
X-MC-Unique: yW5aNU7rPS62hDARt0u14Q-1
X-Mimecast-MFC-AGG-ID: yW5aNU7rPS62hDARt0u14Q_1752238780
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d5e345a3fcso313273085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238780; x=1752843580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+KGefdoj7lli46Ixaj0pts4ezHX60fxoxyKo1M6BYo=;
        b=s/B7I2Vxz57mo3O3isa8OiTsoCUxSqyBC8FPdpI2dEoS3Ag+6idIzQfMX6a5/JB1xq
         oZpFvts5ta/oCIIsgYNEuXjbNPG5ATNb1mQGMgFKWKWa71kc1RAi7CvJlsBjNhdM0fv2
         tqjj5rAKQYOByfe8VQxBr1LXz1aFQOuokyCW/PZzn2/MlfVHvx5UxN3YelGgQbDPfiXX
         zFrzhx4La+1ME7iBtIcPq/Lv6Jq66NgI/Hb9F7xEBNq1yyMEwCPJDMC/A+Wd6KrQD5FO
         Mlh7xg3DzK09KgRMlkAJPfYKw9YvcqYjKdoztYJXmcHGI9Cki/db+PFPU8cbJhtWkTN5
         UBUQ==
X-Gm-Message-State: AOJu0Yz6YL/AcC2voEj/QTnizf1Mq8e56+I80I/qrOsraY97ZPypMDTU
	Z3rQiBBIM76jCIdyoap5EHB30DgrEPepgz6CvX2vbKthIx3ErKthkdIdDNXqJD8L27wM6Tfeqx9
	4E7JGXQszT6eu6J/eRODayAtOUHbgCf1vcc/qWve4pItUBBr1gaeFB6Tj5Bx8BbIQfg==
X-Gm-Gg: ASbGncvNQ+KtJKa0BhxeMaADEt3J9MlSo3l+4Oqr4OZbMyy5eWYeZUPoi4v2D8R6V2p
	ho8GGYvrMckcs1S5OCk2+LEzoMFYnDH+MVdBiTXYM3de8+THlaGYXbKb8/c0tXtYaL62FYXA2xD
	zTDDdmVD9GeUrt7XvBkti8eum4fZVWKAPD8omCI/m656OBWqDkNBSEJmAFhnCaWHfPKLWaW3mTM
	0jL+QqZqZ+EDTMELPvlz4NxiatVgrGX9KrsvAx9w3tTszIOB3P+acV3aNhQtpj4CDCSbl5xVt/t
	/at2E4zVis3S/kVC3tqUtpAlZrOnVb+DrAHOwGn7SeEXxNWNp8N7/TSpiLonjL+YgCg2yF8NpU7
	rXIfriT6ZyZh3hkFB1iWqL17N+EE=
X-Received: by 2002:a05:620a:3714:b0:7d5:dbdc:ceef with SMTP id af79cd13be357-7ddea60e61dmr529029185a.18.1752238780272;
        Fri, 11 Jul 2025 05:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI6zgWHWGx3tx10r/0vqCenxYD+GmCdSVxwP9RcNCwzDoMhzl5/VmC5ggoF7ay0iR7evJ9Sg==
X-Received: by 2002:a05:620a:3714:b0:7d5:dbdc:ceef with SMTP id af79cd13be357-7ddea60e61dmr529024585a.18.1752238779653;
        Fri, 11 Jul 2025 05:59:39 -0700 (PDT)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-59-70-29-229-84.dsl.bell.ca. [70.29.229.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39650sm19481236d6.71.2025.07.11.05.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:59:39 -0700 (PDT)
Message-ID: <d2d7e1bf-baf4-4b53-bfa6-83887bec8a60@redhat.com>
Date: Fri, 11 Jul 2025 08:59:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/util: introduce snapshot_page()
To: David Hildenbrand <david@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
 <40d3d56a-e434-4d3d-ba0e-3f1204edbda5@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <40d3d56a-e434-4d3d-ba0e-3f1204edbda5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-07-11 07:56, David Hildenbrand wrote:
> On 07.07.25 20:50, Luiz Capitulino wrote:
>> This commit refactors __dump_page() into snapshot_page().
>>
>> snapshot_page() tries to take a faithful snapshot of a page and its
>> folio representation. The snapshot is returned in the struct
>> page_snapshot parameter along with additional flags that are best
>> retrieved at snapshot creation time to reduce race windows.
>>
>> This function is intended to be used by callers that need a stable
>> representation of a struct page and struct folio so that pointers
>> or page information doesn't change while working on a page.
>>
>> The idea and original implementation of snapshot_page() comes from
>> Matthew Wilcox with suggestions for improvements from David Hildenbrand.
>> All bugs and misconceptions are mine.
>>
>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>> ---
>>   include/linux/mm.h | 19 ++++++++++++
>>   mm/debug.c         | 42 +++----------------------
>>   mm/util.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 100 insertions(+), 38 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 0ef2ba0c667a..090968c6eebb 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
>>   }
>>   #endif
>> +#define PAGE_SNAPSHOT_FAITHFUL     (1 << 0)
>> +#define PAGE_SNAPSHOT_PG_FREE      (1 << 1)
> 
> Can we call this "BUDDY" instead of FREE
> 
> There are other types of free pages -- in particular free hugetlb folios -- which won't be covered by this check. We really only care about "buddy" pages, which correspond to "free" pages.
> 
> That's what we check and alter expose :)

OK, I'll change.

>> +#define PAGE_SNAPSHOT_PG_IDLE      (1 << 2)
>  > +> +struct page_snapshot {
>> +    struct folio folio_snapshot;
>> +    struct page page_snapshot;
>> +    unsigned long pfn;
>> +    unsigned long idx;
>> +    unsigned long flags;
>> +};
>> +
>> +static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
>> +{
>> +    return ps->flags & PAGE_SNAPSHOT_FAITHFUL;
>> +}
>> +
>> +void snapshot_page(struct page_snapshot *ps, const struct page *page);
>> +
>>   #endif /* _LINUX_MM_H */
>> diff --git a/mm/debug.c b/mm/debug.c
>> index 907382257062..7349330ea506 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -129,47 +129,13 @@ static void __dump_folio(struct folio *folio, struct page *page,
>>   static void __dump_page(const struct page *page)
>>   {
>> -    struct folio *foliop, folio;
>> -    struct page precise;
>> -    unsigned long head;
>> -    unsigned long pfn = page_to_pfn(page);
>> -    unsigned long idx, nr_pages = 1;
>> -    int loops = 5;
>> -
>> -again:
>> -    memcpy(&precise, page, sizeof(*page));
>> -    head = precise.compound_head;
>> -    if ((head & 1) == 0) {
>> -        foliop = (struct folio *)&precise;
>> -        idx = 0;
>> -        if (!folio_test_large(foliop))
>> -            goto dump;
>> -        foliop = (struct folio *)page;
>> -    } else {
>> -        foliop = (struct folio *)(head - 1);
>> -        idx = folio_page_idx(foliop, page);
>> -    }
>> +    struct page_snapshot ps;
>> -    if (idx < MAX_FOLIO_NR_PAGES) {
>> -        memcpy(&folio, foliop, 2 * sizeof(struct page));
>> -        nr_pages = folio_nr_pages(&folio);
>> -        if (nr_pages > 1)
>> -            memcpy(&folio.__page_2, &foliop->__page_2,
>> -                   sizeof(struct page));
>> -        foliop = &folio;
>> -    }
>> -
>> -    if (idx > nr_pages) {
>> -        if (loops-- > 0)
>> -            goto again;
>> +    snapshot_page(&ps, page);
>> +    if (!snapshot_page_is_faithful(&ps))
>>           pr_warn("page does not match folio\n");
>> -        precise.compound_head &= ~1UL;
>> -        foliop = (struct folio *)&precise;
>> -        idx = 0;
>> -    }
>> -dump:
>> -    __dump_folio(foliop, &precise, pfn, idx);
>> +    __dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
>>   }
>>   void dump_page(const struct page *page, const char *reason)
>> diff --git a/mm/util.c b/mm/util.c
>> index 0b270c43d7d1..c38d213be83f 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/sizes.h>
>>   #include <linux/compat.h>
>>   #include <linux/fsnotify.h>
>> +#include <linux/page_idle.h>
>>   #include <linux/uaccess.h>
>> @@ -1171,3 +1172,79 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>>       return 0;
>>   }
>>   EXPORT_SYMBOL(compat_vma_mmap_prepare);
>> +
>> +static void set_flags(struct page_snapshot *ps, const struct folio *folio,
>> +              const struct page *page)
>> +{
>> +    /*
>> +     * Caveats on high order pages: PG_buddy and PG_slab will only be set
>> +     * on the head page.
>> +     */
> 
> Talking about slab here is a bit misleading, IIRC they are proper compound pages today. For PG_buddy (which was renamed to PGTY_buddy), we
> are dealing with non-compound higher allocations.
> 
> So talking about "head" is also a bit misleading.
> 
> /*
>   * Only the first page of a high-order buddy page has PageBuddy() set.
>   * So we have to check manually whether this page is part of a high-
>   * order buddy page.
>   */

I'll use this comment.

>> +    if (PageBuddy(page))
>> +        ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>> +    else if (page_count(page) == 0 && is_free_buddy_page(page))
>> +        ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>> +
>> +    if (folio_test_idle(folio))
>> +        ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
>> +}
>> +
>> +/*
> 
> I would suggest writing proper kernel doc (you mostly have that already)
> 
> Something like
> 
> /**
>   * snapshot_page() - Create a snapshot of a "struct page"
>   * @ps: struct page_snapshot to store the page snapshot
>   * @page: the page we want to snapshot
>   *
>   * Create a snapshot of a page and store its struct page and struct
>   * folio ...

I'll fix this too.

> 
>> + * Create a snapshot of a page and store its struct page and struct folio
>> + * representations in a struct page_snapshot.
>> + *
>> + * @ps: struct page_snapshot to store the page snapshot
>> + * @page: the page we want to snapshot
>> + *
>> + * Note that creating a faithful snapshot of a page may fail if the page
>> + * compound keeps changing (eg. due to folio split). In this case we set
>> + * ps->faithful to false and the snapshot will assume that @page refers
>> + * to a single page.
>> + */
> 


