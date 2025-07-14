Return-Path: <linux-kernel+bounces-730032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782FFB03F69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE13A8CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936024A047;
	Mon, 14 Jul 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYCJGS4l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E93149C7B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498990; cv=none; b=eRNUBfDLVsw/mmT4XunvdDvnn4G11vVFz9pRaFP1iWktkkX8xuPguBSgLLIseU2hzsYj0WChU7eX+/YA267SnNUuHZzGFRCWRFKOzOztAORcihFrecJkz4nZQekBiu+BURiBhuAn+f7HRifLpXgEDzzOfV98vQkfozQSN57joEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498990; c=relaxed/simple;
	bh=PZMKheVzUKV1+LhoHrlFariWP4NbaZV6IQWwV7A/NM0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s8X4wS+UI6q5KVyCJ5dOq/3ba11JpPvDrzjmJtpGRYwxBG4LZjvOrOXLcqVDcJbnRk5d/w6y5KHgZGv/dHQKGRe0UKYeNN9x/EGpfya040u4rivaezoaqNMlhxoQRrc7hqDFJMDRLdsC2CXQNjPo+xWxJQOF5OeRzJhQns90wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYCJGS4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752498986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib77k7eAfBr6oqef0Ex2EcxB2hnN68oB0e1cVj8uYzo=;
	b=KYCJGS4lcWaqhZtfV9It5xgN2ILYvgO41FaQH3Pnj1eQI17i7i8W0ybiE6okqNJn+oRLUd
	A7pO3E812D4aPjsTGK9wNzSdqJGF2ioSM9xFsNe2W1bAHPCiBHaOQburjWRji0SWwAxWZx
	8emLPbCK4Z32l1NYSY81cIZMHDF6mVg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-9D-vljrjNH6RvCw355dsrg-1; Mon, 14 Jul 2025 09:16:25 -0400
X-MC-Unique: 9D-vljrjNH6RvCw355dsrg-1
X-Mimecast-MFC-AGG-ID: 9D-vljrjNH6RvCw355dsrg_1752498985
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e093bccd5eso308131585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752498985; x=1753103785;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib77k7eAfBr6oqef0Ex2EcxB2hnN68oB0e1cVj8uYzo=;
        b=PUc81nrsN7xAUI8E2QRqVNCRI5VsddNwiTPLi+ClhZHhInny+TWBmR1AdI5axpPzJ5
         KK6yczerJ5/Gbz+Zcn/3PXVRwQuxxMpW5DogU8kD2a0iVcerOPIdxhqUuRZeHShDYiR5
         kWitVTobrSQc7pkoKUI07oH6vMxhH5Q2OElQ57nYrM2qvIiIGzOJcHRarOurhUCBXRzd
         RBGe6USX3JUhtbHilY7W7opoaoWRXirU6wrbfoK0Y7MK0Gv6e/3uHqHzh9/eyhJ/QR5V
         LgonPYN8dhFAEOTFe7bEeQRjupPiB6FTqoBCaQBEKFf9wELVpA/Yncm68aJd65XTKroe
         dIDA==
X-Gm-Message-State: AOJu0Yw88ljMWch29TtipwI+NPm/jKj6PLDrnAFOLvvPO4/jum98rg1p
	zZ86nf4QChCOrqq6m/0k92OZYpPf12Y4mEkqMyXJOvxgtTNXsMWT/2jIEnHN1DCnZEhoSMJLxka
	u37GmHwsdgMaE1Gp72uRQsr58a/3ZSYihekGD2Q0Ws04PputmNekLnq6hQ96lh+mCdQ==
X-Gm-Gg: ASbGncs8KI4HoTd3Pm7xxb5TXZGYizwsnXshi6b2zWqAIDtSJhhlz+Wf16V3OcVdK0x
	MmH5o5+hv588EbF8ABeb4XjQZTTCPpDs6j2OxOo3zrcwpqBqzQIyHWr6fpIF4A+sjaeslqzdJGM
	Rq7BWiilVp3vPEvIRBzOpDncZfRbmN00ANd0VWM92HIT2s7How4H6AP97nB3nZME4Xmj21XUGSs
	IwzngqQppxwOF526llU9R7ezTIMQMQdjiJRn5Z+a/4fc4rDWocXkzr97ZdtUElES8njz9VgY80u
	DPXAaoUvxNvnSK9I+KCZHrUbU9vbkHrbuouJwK8Y
X-Received: by 2002:a05:620a:290f:b0:7e3:3604:5047 with SMTP id af79cd13be357-7e336045076mr2677585a.38.1752498984785;
        Mon, 14 Jul 2025 06:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPUrFGR4YDRevL4SLsVtbgKHacggj9VWxy5bSHPv6taO97ydd55xZFzgAfWdcEMNR+dSDZcw==
X-Received: by 2002:a05:620a:290f:b0:7e3:3604:5047 with SMTP id af79cd13be357-7e336045076mr2674085a.38.1752498984323;
        Mon, 14 Jul 2025 06:16:24 -0700 (PDT)
Received: from [192.168.2.110] ([70.29.229.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb0ceaesm506633285a.13.2025.07.14.06.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:16:24 -0700 (PDT)
Message-ID: <017e17e9-c9d7-4dc2-90bc-0ef06289007c@redhat.com>
Date: Mon, 14 Jul 2025 09:16:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/util: introduce snapshot_page()
From: Luiz Capitulino <luizcap@redhat.com>
To: Shivank Garg <shivankg@amd.com>, david@redhat.com, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
 <3942336d-20e6-457d-8b53-e198eed5d9d9@amd.com>
 <60a1a526-52dd-478a-9ed4-79e6428743ac@redhat.com>
Content-Language: en-US, en-CA
In-Reply-To: <60a1a526-52dd-478a-9ed4-79e6428743ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-07-08 12:59, Luiz Capitulino wrote:
> On 2025-07-08 01:49, Shivank Garg wrote:
>>
>>
>> On 7/8/2025 12:20 AM, Luiz Capitulino wrote:
>>> This commit refactors __dump_page() into snapshot_page().
>>>
>>> snapshot_page() tries to take a faithful snapshot of a page and its
>>> folio representation. The snapshot is returned in the struct
>>> page_snapshot parameter along with additional flags that are best
>>> retrieved at snapshot creation time to reduce race windows.
>>>
>>> This function is intended to be used by callers that need a stable
>>> representation of a struct page and struct folio so that pointers
>>> or page information doesn't change while working on a page.
>>>
>>> The idea and original implementation of snapshot_page() comes from
>>> Matthew Wilcox with suggestions for improvements from David Hildenbrand.
>>> All bugs and misconceptions are mine.
>>>
>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>> ---
>>>   include/linux/mm.h | 19 ++++++++++++
>>>   mm/debug.c         | 42 +++----------------------
>>>   mm/util.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 100 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 0ef2ba0c667a..090968c6eebb 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
>>>   }
>>>   #endif
>>> +#define PAGE_SNAPSHOT_FAITHFUL     (1 << 0)
>>> +#define PAGE_SNAPSHOT_PG_FREE      (1 << 1)
>>> +#define PAGE_SNAPSHOT_PG_IDLE      (1 << 2)
>>> +
>>> +struct page_snapshot {
>>> +    struct folio folio_snapshot;
>>> +    struct page page_snapshot;
>>> +    unsigned long pfn;
>>> +    unsigned long idx;
>>> +    unsigned long flags;
>>> +};
>>> +
>>> +static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
>>> +{
>>> +    return ps->flags & PAGE_SNAPSHOT_FAITHFUL;
>>> +}
>>> +
>>> +void snapshot_page(struct page_snapshot *ps, const struct page *page);
>>> +
>>>   #endif /* _LINUX_MM_H */
>>> diff --git a/mm/debug.c b/mm/debug.c
>>> index 907382257062..7349330ea506 100644
>>> --- a/mm/debug.c
>>> +++ b/mm/debug.c
>>> @@ -129,47 +129,13 @@ static void __dump_folio(struct folio *folio, struct page *page,
>>>   static void __dump_page(const struct page *page)
>>>   {
>>> -    struct folio *foliop, folio;
>>> -    struct page precise;
>>> -    unsigned long head;
>>> -    unsigned long pfn = page_to_pfn(page);
>>> -    unsigned long idx, nr_pages = 1;
>>> -    int loops = 5;
>>> -
>>> -again:
>>> -    memcpy(&precise, page, sizeof(*page));
>>> -    head = precise.compound_head;
>>> -    if ((head & 1) == 0) {
>>> -        foliop = (struct folio *)&precise;
>>> -        idx = 0;
>>> -        if (!folio_test_large(foliop))
>>> -            goto dump;
>>> -        foliop = (struct folio *)page;
>>> -    } else {
>>> -        foliop = (struct folio *)(head - 1);
>>> -        idx = folio_page_idx(foliop, page);
>>> -    }
>>> +    struct page_snapshot ps;
>>> -    if (idx < MAX_FOLIO_NR_PAGES) {
>>> -        memcpy(&folio, foliop, 2 * sizeof(struct page));
>>> -        nr_pages = folio_nr_pages(&folio);
>>> -        if (nr_pages > 1)
>>> -            memcpy(&folio.__page_2, &foliop->__page_2,
>>> -                   sizeof(struct page));
>>> -        foliop = &folio;
>>> -    }
>>> -
>>> -    if (idx > nr_pages) {
>>> -        if (loops-- > 0)
>>> -            goto again;
>>> +    snapshot_page(&ps, page);
>>> +    if (!snapshot_page_is_faithful(&ps))
>>>           pr_warn("page does not match folio\n");
>>> -        precise.compound_head &= ~1UL;
>>> -        foliop = (struct folio *)&precise;
>>> -        idx = 0;
>>> -    }
>>> -dump:
>>> -    __dump_folio(foliop, &precise, pfn, idx);
>>> +    __dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
>>>   }
>>>   void dump_page(const struct page *page, const char *reason)
>>> diff --git a/mm/util.c b/mm/util.c
>>> index 0b270c43d7d1..c38d213be83f 100644
>>> --- a/mm/util.c
>>> +++ b/mm/util.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/sizes.h>
>>>   #include <linux/compat.h>
>>>   #include <linux/fsnotify.h>
>>> +#include <linux/page_idle.h>
>>>   #include <linux/uaccess.h>
>>> @@ -1171,3 +1172,79 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>>>       return 0;
>>>   }
>>>   EXPORT_SYMBOL(compat_vma_mmap_prepare);
>>> +
>>> +static void set_flags(struct page_snapshot *ps, const struct folio *folio,
>>> +              const struct page *page)
>>> +{
>>> +    /*
>>> +     * Caveats on high order pages: PG_buddy and PG_slab will only be set
>>> +     * on the head page.
>>> +     */
>>> +    if (PageBuddy(page))
>>> +        ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>>> +    else if (page_count(page) == 0 && is_free_buddy_page(page))
>>> +        ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>>> +
>>> +    if (folio_test_idle(folio))
>>> +        ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
>>> +}
>>> +
>>> +/*
>>> + * Create a snapshot of a page and store its struct page and struct folio
>>> + * representations in a struct page_snapshot.
>>> + *
>>> + * @ps: struct page_snapshot to store the page snapshot
>>> + * @page: the page we want to snapshot
>>> + *
>>> + * Note that creating a faithful snapshot of a page may fail if the page
>>> + * compound keeps changing (eg. due to folio split). In this case we set
>>> + * ps->faithful to false and the snapshot will assume that @page refers
>>> + * to a single page.
>>> + */
>>> +void snapshot_page(struct page_snapshot *ps, const struct page *page)
>>> +{
>>> +    unsigned long head, nr_pages = 1;
>>> +    struct folio *foliop, folio;
>>> +    int loops = 5;
>>> +
>>> +    ps->pfn = page_to_pfn(page);
>>> +    ps->flags = PAGE_SNAPSHOT_FAITHFUL;
>>> +
>>> +again:
>>> +    memcpy(&ps->page_snapshot, page, sizeof(*page));
>>> +    head = ps->page_snapshot.compound_head;
>>> +    if ((head & 1) == 0) {
>>> +        foliop = (struct folio *)&ps->page_snapshot;
>>> +        ps->idx = 0;
>>> +        if (!folio_test_large(foliop)) {
>>> +            set_flags(ps, page_folio(page), page);
>>> +            goto out;
>>> +        }
>>> +        foliop = (struct folio *)page;
>>> +    } else {
>>> +        foliop = (struct folio *)(page->compound_head - 1);
>>                       ^^^^
>> should we use ps->page_snapshot here?
>> IIUC, page may change due to race.
> 
> You're right the race exists, but we can't make foliop point to the
> snapshot because we do pointer arithmetic and other operations that need
> the real page memory address to work properly.

While working on v3 I realized it should be fine (and correct) to use
the head pointer from ps->page_snapshot like the original __dump_page()
does (assuming this is what you meant for me to change). So, I changed
this for v3.

> 
>>> +        ps->idx = folio_page_idx(foliop, page);
>>> +    }
>>> +
>>> +    if (ps->idx < MAX_FOLIO_NR_PAGES) {
>>> +        memcpy(&folio, foliop, 2 * sizeof(struct page));
>>> +        nr_pages = folio_nr_pages(&folio);
>>> +        if (nr_pages > 1)
>>> +            memcpy(&folio.__page_2, &foliop->__page_2,
>>> +                   sizeof(struct page));
>>> +        set_flags(ps, foliop, page);
>>> +        foliop = &folio;
>>> +    }
>>> +
>>> +    if (ps->idx > nr_pages) {
>>> +        if (loops-- > 0)
>>> +            goto again;
>>> +        ps->page_snapshot.compound_head &= ~1UL;
>>
>> Should we use clear_compound_head() for clarity?
> 
> Yes, we can do that.
> 
> Andrew, since you applied this series already, can you squash the change
> below into this patch? If not, I can send v3.
> 
> diff --git a/mm/util.c b/mm/util.c
> index c38d213be83f..ce4200529772 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1239,7 +1239,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
>       if (ps->idx > nr_pages) {
>           if (loops-- > 0)
>               goto again;
> -        ps->page_snapshot.compound_head &= ~1UL;
> +        clear_compound_head(&ps->page_snapshot);
>           foliop = (struct folio *)&ps->page_snapshot;
>           ps->flags = 0;
>           ps->idx = 0;


