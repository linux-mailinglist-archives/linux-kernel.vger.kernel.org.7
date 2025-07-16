Return-Path: <linux-kernel+bounces-734026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A7B07C26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6EB583513
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A12F363F;
	Wed, 16 Jul 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fP1KTxR4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DB2E3715
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687407; cv=none; b=elt4idQ0s1r9J/MjHgndPoQx8qZmQ2aw4RCLL8W7GUHoy6YMp3cJtxyzXSw38gjzTEWlD47XRWttFVJ5PNzWd19Amdsq/mL+Qq3Nunq+ZF7Z7foU+Pw4pIay02dq0uFfQR/dQAYHQmjBunHUG+o/Gdr33bRnzBDZxBS4I92SFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687407; c=relaxed/simple;
	bh=vOeKXD3vTZk01h1TytteYR4+sz1KoJmL/VdSE7iB4lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApueuD/ad+0PybaOPMZ0WaaujNes+6KK2/mmQHmRaIcyMjgvO9hLS5QAFY2lStSek5es5XVhZN2Zx7FLs2rhLB0t9hbSFcI6sVW3gEGRg3kVNL09zkLXLdneHddqn0Dyux/sljdwnlKLw1bBzktE4nQMoFwa3d45di8VkHmRUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fP1KTxR4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752687403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtR1aatzbtQ5lskqHrgYtiRweRhyZx8oW0GotUtgZsc=;
	b=fP1KTxR4Q5IJMDG430HRJm8zlTT+RnsU8au1Vwc0lK2gprasKUCd0HZK5nBaJYWxOdrUVc
	vrU295VwmI5VLVKDNVapgOYtoMEPCUvNGAj6QazHSAkEyNmdvuV9JiZA5NDnQBfCsS0pld
	CZuEGNJs+9OlwwidkC7JwiOCBAJ8QGo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-Lycq4TznN5KbtwqaL7YJAA-1; Wed, 16 Jul 2025 13:36:41 -0400
X-MC-Unique: Lycq4TznN5KbtwqaL7YJAA-1
X-Mimecast-MFC-AGG-ID: Lycq4TznN5KbtwqaL7YJAA_1752687400
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5bb68b386so13916185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687400; x=1753292200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtR1aatzbtQ5lskqHrgYtiRweRhyZx8oW0GotUtgZsc=;
        b=FeOH71fNbR6HT8QmE9oiNCiRujZK5kboLQERALQ2y9cHtre+c88gkKl8F8J7WL2Z5v
         jN/+HkD2CDTaY/3OTH09BgfTHiQ/ylL/Vhbc+Fdxh4tw+ENfkk50Ohd3BLUqy++0uCvR
         DrXAKo+69boE5kf/6QHeBYh+HfFvh+tGj7vhkn8ivZj4ZkSsqfV3JHniDzf0vnrgz478
         vnmHEjxrUPlnPZTiADLg+5/jdIUyjgxfQoWUdk9jsKZ0JSxg3QRKZmyavx7U5Kgb32+W
         FGrZC28X/gaJldcL13PUtjbH3Hn330JoGTqJtja1VSsRDNsnICEg6mp3sViyQwK9Vrhi
         EjBg==
X-Gm-Message-State: AOJu0YymofKf99uz60/XIyB70S/xZ1nnpo/YF7kGuhGiv299acdC+02n
	yhqZ0PiF5NggOUNimpn1Q6FDcGAHvpGLnmxVhiXIV55/W2avSLAEV8y9YiElZyGoIej3n6ZnzPH
	X2oRNbZP+bT9fn93E8EAcSyD+kiISeNJ2lCCTSaHKuhMJJcbkkrvJuW1uL4laugBlPw==
X-Gm-Gg: ASbGncvt5tJC88D02zivCpIUrpOTHn86687o0Z9M/9+fgKT/aQOFx/op3xMjKEEtJ2q
	bh3nj56gXwk+YfweNKGNNaqOJwXoyXdmd73gvSXAZdVnEq0xWi2Fvr7SAe64nAa2di2TzJsr9nS
	6prvYncgAmRllsNoAvkbN+i/P7q76lzvN49GYuWXDCIf8Euc0/8f+Pa/ufOnEEB6BjhcZGmeSJf
	7+28M0zAifLwMztiB4U1nvQcochsZNyXhWGiXW68re09/aj6zrp0SIzvq/2UI7dlF+97GZsvdw5
	dJrShTOmY3VcISI+gSfc4lwYyXV5eHqyYlDzFH3z
X-Received: by 2002:a05:620a:394a:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e342a6299fmr581667885a.8.1752687400252;
        Wed, 16 Jul 2025 10:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELv/kV+iJPcIdqfWF4DteQ0Nc4eWrTc1AcTHSF0tcLeAByLigE6eo60muIAn3RRRBcBXHMTQ==
X-Received: by 2002:a05:620a:394a:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e342a6299fmr581662485a.8.1752687399636;
        Wed, 16 Jul 2025 10:36:39 -0700 (PDT)
Received: from [192.168.2.110] ([70.29.229.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e345a80685sm102004985a.105.2025.07.16.10.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:36:39 -0700 (PDT)
Message-ID: <900252c7-b16c-49b9-8c01-60e6a7a48683@redhat.com>
Date: Wed, 16 Jul 2025 13:36:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm/util: introduce snapshot_page()
To: David Hildenbrand <david@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
 <ca72882f-257f-4f41-bea2-0b5324c820d7@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <ca72882f-257f-4f41-bea2-0b5324c820d7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-16 06:16, David Hildenbrand wrote:
> [...]
> 
>> -dump:
>> -    __dump_folio(foliop, &precise, pfn, idx);
>> +    __dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
> 
> Nit that can be cleaned up later on top:
> 
> We should probably call this
> 
> __dump_page_snapshot() and then just pass ... the page_snapshot.
> 
>>   }
>>   void dump_page(const struct page *page, const char *reason)
>> diff --git a/mm/util.c b/mm/util.c
>> index 0b270c43d7d1..f270bf42465b 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/sizes.h>
>>   #include <linux/compat.h>
>>   #include <linux/fsnotify.h>
>> +#include <linux/page_idle.h>
>>   #include <linux/uaccess.h>
>> @@ -1171,3 +1172,81 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>>       return 0;
>>   }
>>   EXPORT_SYMBOL(compat_vma_mmap_prepare);
>> +
>> +static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
>> +             const struct page *page)
>> +{
>> +    /*
>> +     * Only the first page of a high-order buddy page has PageBuddy() set.
>> +     * So we have to check manually whether this page is part of a high-
>> +     * order buddy page.
>> +     */
>> +    if (PageBuddy(page))
>> +        ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
>> +    else if (page_count(page) == 0 && is_free_buddy_page(page))
>> +        ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
>> +
>> +    if (folio_test_idle(folio))
>> +        ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
>> +}
>> +
>> +/**
>> + * snapshot_page() - Create a snapshot of a struct page
>> + * @ps: Pointer to a struct page_snapshot to store the page snapshot
>> + * @page: The page to snapshot
>> + *
>> + * Create a snapshot of the page and store both its struct page and struct
>> + * folio representations in @ps.
>> + *
>> + * Note that creating a faithful snapshot may fail if the compound
> 
> Maybe highlight that this is not really expected to happen, ever.
> 
>> + * state of the page keeps changing (e.g., due to a folio split). In
>> + * this case, ps->faithful is set to false, and the snapshot assumes
> 
> There is no ps->faithful.

Yes, good catch. This was from an earlier version.

Is it fine if I fix only this with a follow up patch for Andrew in this
thread or would you prefer that I post v4 with all the other changes as
well?

> 
>> + * that @page refers to a single page.
>> + */
>> +void snapshot_page(struct page_snapshot *ps, const struct page *page)
>> +{
>> +    unsigned long head, nr_pages = 1;
>> +    struct folio *foliop;
>> +    int loops = 5;
>> +
>> +    ps->pfn = page_to_pfn(page);
>> +    ps->flags = PAGE_SNAPSHOT_FAITHFUL;
>> +
>> +again:
>> +    memset(&ps->folio_snapshot, 0, sizeof(struct folio));
>> +    memcpy(&ps->page_snapshot, page, sizeof(*page));
>> +    head = ps->page_snapshot.compound_head;
>> +    if ((head & 1) == 0) {
>> +        ps->idx = 0;
>> +        foliop = (struct folio *)&ps->page_snapshot;
>> +        if (!folio_test_large(foliop)) {
>> +            set_ps_flags(ps, page_folio(page), page);
>> +            memcpy(&ps->folio_snapshot, foliop,
>> +                   sizeof(struct page));
>> +            return;
>> +        }
>> +        foliop = (struct folio *)page;
>> +    } else {
>> +        foliop = (struct folio *)(head - 1);
>> +        ps->idx = folio_page_idx(foliop, page);
>> +    }
> 
> Condition could be cleaned up by reversing both things
> 
> if (head & 1) {
>      /* Tail page, lookup the actual head. */
>      foliop = (struct folio *)(head - 1);
>      ps->idx = folio_page_idx(foliop, page);
> } else
>      ...
> }
> 
> But you're just moving that code, so no need to do that now.
> 
> 
> I think we could improve some of that in the future a bit to
> make it even more faithful.
> 
> But for now this should be just fine.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


