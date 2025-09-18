Return-Path: <linux-kernel+bounces-822760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13BBB849B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D84A650C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5362FCC1B;
	Thu, 18 Sep 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwMTNc+v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F373285043
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198947; cv=none; b=Y232I6uzX6n4EUXAkiC6TizAkd9F4zIqCbzWM4nWUdHHkGb2L+JPW4jrjnualTiw8z8FgYGwIrSTOYke9w2se0J/c85/FknezYif6lWL56Je5lpIjKjk6M8YI55ocQKa7tFXJa5ia4/V+GWBR99MxRaU1nydQFHk7ubmuglIV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198947; c=relaxed/simple;
	bh=h/HXhP7klOwX6TydVKe170aB8zM451tL2x+lcawcaIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHtpEwkBYOsr/L2I9jyj4CkWX7OQgRededcO6JLuYjEqY80hhc0Z1+DBCRlZd54ruTp1hz2rU4jrxXgPFDRH14r0TQWK15hWcWwubWOGTEH7AXfbuytNGoUUxDvgDPw7nq0p3ehe39BbhwoUzmAf5prAqWxGx9fV6sDo/Ew9pR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwMTNc+v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758198944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9fPOqRrWErRNXgx9jQhyKu8CTHDnoT1HNO+bn6HbkYs=;
	b=XwMTNc+vVky7TBeaTnTPHwf1HoUoudpGKeWnotJca6qsnOg9vdJuZXWU9JZFO85oNbFIdN
	KAL1IqD2KHgWZRMuuEgNo5PGuVwOPXbT0foiBPgeJtxKKSTo7vRkzlx8urTH+JFsPGrUrj
	u0Wr3Qq0yIjnz0ho4AdHfEVmutoWm54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-PrJocX-xMzigGsRvV5XMlQ-1; Thu, 18 Sep 2025 08:35:43 -0400
X-MC-Unique: PrJocX-xMzigGsRvV5XMlQ-1
X-Mimecast-MFC-AGG-ID: PrJocX-xMzigGsRvV5XMlQ_1758198942
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f28552927so6598155e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198942; x=1758803742;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fPOqRrWErRNXgx9jQhyKu8CTHDnoT1HNO+bn6HbkYs=;
        b=Rbq8nD59Yn4M/n4tchS2d+acxukKwXKYO3KmOSnMzVpxSzyvmeCXa0l0/f1UnMBaln
         J9QmP1Po/sZ6lGbhwON3VR4sim66eRdTmQXizBZQYdSJ8HQulF6PMkgIpIEyt7BOZ+6r
         rE1zIE0+C9lLA5rp+yfIX99iLNjJy5EefkvEN8nKUzuSMQhPPL+/98NH/opTRxp4D341
         7dykstCFhD8LIk9NCTS8yZHY/S8+NnFgtphOOUXcyqyjpS+t99AS3atJ9SVfZtNRgkdC
         PZch+klBvvJYCZu9zJFiWn57Bn4JqXIum6t8VHQk8vvWiH/uXYc54/Ua/WRePVMBto+u
         jfug==
X-Forwarded-Encrypted: i=1; AJvYcCUADjBgYiJNK0W2oPNbMT69dW8idIDJD+6nIZPQZnr2X6C68ayJN6wnEc+wLXlNaS5u/EWXdCh+J9Fh2V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgQmOFX9V1RScZOjWUSAk6f417c6poeEUFrPJD6Z7BwlMmlfG
	SCUywYUXBEDNMe2MFO5TfGaQPOiZ1/VXz8iWb4juDUWXN3oDjIRFx5uz3T0nKgcmUn0OutDk5sP
	LAZ15RXloPraLizC64IA5Fa50hfu+s3p+Q+LQx1UYCFUVaiSggKnzL5rao6MVfrD7Wg==
X-Gm-Gg: ASbGncvhVi2V5CRqAcAjn4axUPF/7XRvubAbkShZM7EecZNwWWt/UB709YmIGfAKODq
	iiLvYDtBe91lO1RtZ63hGdZ99tn0y7cQ1+xAXyG5EVFdTcf0QHmitmIOa/DOV2iQTqoDXSZ17SO
	7mmNPQmbKpvYnbrd7IibOyo7h2rrwntnEVVWTu5wCV7WaFZoniADVi6JEDy8FJVo+V8ZYCSSUA3
	MPcDtAcvbf2+0iJltCcpB7gezhYOdqVFk9T3qyqmjuDt6puKH51jIZiGVHaYlpd49oQMMMNBeYZ
	uqs1Frdd4wHL7tWFrux9KvkJfWdCEsBgrKPpBNuPINblnoOm3MSpQOZx3hGpienefnd21EeiZp5
	dJma+tYGG93ZAzKpzReaNaOhn6/lL0Q3ksvN7Y3CXpfUXyVT6aofGqlFIgDIAywZ+qK02
X-Received: by 2002:a05:600c:138f:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-462074c5377mr59065975e9.31.1758198941431;
        Thu, 18 Sep 2025 05:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPaI9QmkViVyBCCFVaWi7mKUCW0KTXwDLc6aLw2Gmcx8zAIrUoT+gxaEdwZUyOavJWTU9zQg==
X-Received: by 2002:a05:600c:138f:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-462074c5377mr59065725e9.31.1758198940873;
        Thu, 18 Sep 2025 05:35:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad1b0sm46011235e9.21.2025.09.18.05.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:35:39 -0700 (PDT)
Message-ID: <ebedc478-7519-4e30-854e-f6616a7647b0@redhat.com>
Date: Thu, 18 Sep 2025 14:35:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
To: Lance Yang <lance.yang@linux.dev>
Cc: =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "usamaarif642@gmail.com" <usamaarif642@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "yuzhao@google.com" <yuzhao@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 =?UTF-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
 "npache@redhat.com" <npache@redhat.com>, "rppt@kernel.org"
 <rppt@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "cerasuolodomenico@gmail.com" <cerasuolodomenico@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ryncsn@gmail.com" <ryncsn@gmail.com>, "surenb@google.com"
 <surenb@google.com>, "riel@surriel.com" <riel@surriel.com>,
 "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
 =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
 <chinwen.chang@mediatek.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "baohua@kernel.org" <baohua@kernel.org>,
 "kaleshsingh@google.com" <kaleshsingh@google.com>,
 "zhais@google.com" <zhais@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-3-usamaarif642@gmail.com>
 <a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com>
 <434c092b-0f19-47bf-a5fa-ea5b4b36c35e@redhat.com>
 <CABzRoyYWQMFTGYgfC7N=cWMnL_+5Y05=jrMhFjBf1aKOGxzq5g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CABzRoyYWQMFTGYgfC7N=cWMnL_+5Y05=jrMhFjBf1aKOGxzq5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.09.25 14:22, Lance Yang wrote:
> On Thu, Sep 18, 2025 at 5:21 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.09.25 10:53, Qun-wei Lin (林群崴) wrote:
>>> On Fri, 2024-08-30 at 11:03 +0100, Usama Arif wrote:
>>>> From: Yu Zhao <yuzhao@google.com>
>>>>
>>>> Here being unused means containing only zeros and inaccessible to
>>>> userspace. When splitting an isolated thp under reclaim or migration,
>>>> the unused subpages can be mapped to the shared zeropage, hence
>>>> saving
>>>> memory. This is particularly helpful when the internal
>>>> fragmentation of a thp is high, i.e. it has many untouched subpages.
>>>>
>>>> This is also a prerequisite for THP low utilization shrinker which
>>>> will
>>>> be introduced in later patches, where underutilized THPs are split,
>>>> and
>>>> the zero-filled pages are freed saving memory.
>>>>
>>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>>> Tested-by: Shuang Zhai <zhais@google.com>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>>    include/linux/rmap.h |  7 ++++-
>>>>    mm/huge_memory.c     |  8 ++---
>>>>    mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++----
>>>> --
>>>>    mm/migrate_device.c  |  4 +--
>>>>    4 files changed, 75 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index 91b5935e8485..d5e93e44322e 100644
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
>>>>    int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages,
>>>> pgoff_t pgoff,
>>>>                     struct vm_area_struct *vma);
>>>>
>>>> -void remove_migration_ptes(struct folio *src, struct folio *dst,
>>>> bool locked);
>>>> +enum rmp_flags {
>>>> +    RMP_LOCKED              = 1 << 0,
>>>> +    RMP_USE_SHARED_ZEROPAGE = 1 << 1,
>>>> +};
>>>> +
>>>> +void remove_migration_ptes(struct folio *src, struct folio *dst, int
>>>> flags);
>>>>
>>>>    /*
>>>>     * rmap_walk_control: To control rmap traversing for specific needs
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 0c48806ccb9a..af60684e7c70 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct
>>>> vm_area_struct *vma, unsigned long addr,
>>>>       return false;
>>>>    }
>>>>
>>>> -static void remap_page(struct folio *folio, unsigned long nr)
>>>> +static void remap_page(struct folio *folio, unsigned long nr, int
>>>> flags)
>>>>    {
>>>>       int i = 0;
>>>>
>>>> @@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio,
>>>> unsigned long nr)
>>>>       if (!folio_test_anon(folio))
>>>>               return;
>>>>       for (;;) {
>>>> -            remove_migration_ptes(folio, folio, true);
>>>> +            remove_migration_ptes(folio, folio, RMP_LOCKED |
>>>> flags);
>>>>               i += folio_nr_pages(folio);
>>>>               if (i >= nr)
>>>>                       break;
>>>> @@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page
>>>> *page, struct list_head *list,
>>>>
>>>>       if (nr_dropped)
>>>>               shmem_uncharge(folio->mapping->host, nr_dropped);
>>>> -    remap_page(folio, nr);
>>>> +    remap_page(folio, nr, PageAnon(head) ?
>>>> RMP_USE_SHARED_ZEROPAGE : 0);
>>>>
>>>>       /*
>>>>        * set page to its compound_head when split to non order-0
>>>> pages, so
>>>> @@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct
>>>> page *page, struct list_head *list,
>>>>               if (mapping)
>>>>                       xas_unlock(&xas);
>>>>               local_irq_enable();
>>>> -            remap_page(folio, folio_nr_pages(folio));
>>>> +            remap_page(folio, folio_nr_pages(folio), 0);
>>>>               ret = -EAGAIN;
>>>>       }
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 6f9c62c746be..d039863e014b 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio,
>>>> struct list_head *list)
>>>>       return true;
>>>>    }
>>>>
>>>> +static bool try_to_map_unused_to_zeropage(struct
>>>> page_vma_mapped_walk *pvmw,
>>>> +                                      struct folio *folio,
>>>> +                                      unsigned long idx)
>>>> +{
>>>> +    struct page *page = folio_page(folio, idx);
>>>> +    bool contains_data;
>>>> +    pte_t newpte;
>>>> +    void *addr;
>>>> +
>>>> +    VM_BUG_ON_PAGE(PageCompound(page), page);
>>>> +    VM_BUG_ON_PAGE(!PageAnon(page), page);
>>>> +    VM_BUG_ON_PAGE(!PageLocked(page), page);
>>>> +    VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
>>>> +
>>>> +    if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags &
>>>> VM_LOCKED) ||
>>>> +        mm_forbids_zeropage(pvmw->vma->vm_mm))
>>>> +            return false;
>>>> +
>>>> +    /*
>>>> +     * The pmd entry mapping the old thp was flushed and the pte
>>>> mapping
>>>> +     * this subpage has been non present. If the subpage is only
>>>> zero-filled
>>>> +     * then map it to the shared zeropage.
>>>> +     */
>>>> +    addr = kmap_local_page(page);
>>>> +    contains_data = memchr_inv(addr, 0, PAGE_SIZE);
>>>> +    kunmap_local(addr);
>>>> +
>>>> +    if (contains_data)
>>>> +            return false;
>>>> +
>>>> +    newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>>> +                                    pvmw->vma->vm_page_prot));
>>>> +    set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte,
>>>> newpte);
>>>> +
>>>> +    dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
>>>> +    return true;
>>>> +}
>>>> +
>>>> +struct rmap_walk_arg {
>>>> +    struct folio *folio;
>>>> +    bool map_unused_to_zeropage;
>>>> +};
>>>> +
>>>>    /*
>>>>     * Restore a potential migration pte to a working pte entry
>>>>     */
>>>>    static bool remove_migration_pte(struct folio *folio,
>>>> -            struct vm_area_struct *vma, unsigned long addr, void
>>>> *old)
>>>> +            struct vm_area_struct *vma, unsigned long addr, void
>>>> *arg)
>>>>    {
>>>> -    DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC |
>>>> PVMW_MIGRATION);
>>>> +    struct rmap_walk_arg *rmap_walk_arg = arg;
>>>> +    DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr,
>>>> PVMW_SYNC | PVMW_MIGRATION);
>>>>
>>>>       while (page_vma_mapped_walk(&pvmw)) {
>>>>               rmap_t rmap_flags = RMAP_NONE;
>>>> @@ -234,6 +278,9 @@ static bool remove_migration_pte(struct folio
>>>> *folio,
>>>>                       continue;
>>>>               }
>>>>    #endif
>>>> +            if (rmap_walk_arg->map_unused_to_zeropage &&
>>>> +                try_to_map_unused_to_zeropage(&pvmw, folio,
>>>> idx))
>>>> +                    continue;
>>>>
>>>>               folio_get(folio);
>>>>               pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
>>>> @@ -312,14 +359,21 @@ static bool remove_migration_pte(struct folio
>>>> *folio,
>>>>     * Get rid of all migration entries and replace them by
>>>>     * references to the indicated page.
>>>>     */
>>>> -void remove_migration_ptes(struct folio *src, struct folio *dst,
>>>> bool locked)
>>>> +void remove_migration_ptes(struct folio *src, struct folio *dst, int
>>>> flags)
>>>>    {
>>>> +    struct rmap_walk_arg rmap_walk_arg = {
>>>> +            .folio = src,
>>>> +            .map_unused_to_zeropage = flags &
>>>> RMP_USE_SHARED_ZEROPAGE,
>>>> +    };
>>>> +
>>>>       struct rmap_walk_control rwc = {
>>>>               .rmap_one = remove_migration_pte,
>>>> -            .arg = src,
>>>> +            .arg = &rmap_walk_arg,
>>>>       };
>>>>
>>>> -    if (locked)
>>>> +    VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src !=
>>>> dst), src);
>>>> +
>>>> +    if (flags & RMP_LOCKED)
>>>>               rmap_walk_locked(dst, &rwc);
>>>>       else
>>>>               rmap_walk(dst, &rwc);
>>>> @@ -934,7 +988,7 @@ static int writeout(struct address_space
>>>> *mapping, struct folio *folio)
>>>>        * At this point we know that the migration attempt cannot
>>>>        * be successful.
>>>>        */
>>>> -    remove_migration_ptes(folio, folio, false);
>>>> +    remove_migration_ptes(folio, folio, 0);
>>>>
>>>>       rc = mapping->a_ops->writepage(&folio->page, &wbc);
>>>>
>>>> @@ -1098,7 +1152,7 @@ static void migrate_folio_undo_src(struct folio
>>>> *src,
>>>>                                  struct list_head *ret)
>>>>    {
>>>>       if (page_was_mapped)
>>>> -            remove_migration_ptes(src, src, false);
>>>> +            remove_migration_ptes(src, src, 0);
>>>>       /* Drop an anon_vma reference if we took one */
>>>>       if (anon_vma)
>>>>               put_anon_vma(anon_vma);
>>>> @@ -1336,7 +1390,7 @@ static int migrate_folio_move(free_folio_t
>>>> put_new_folio, unsigned long private,
>>>>               lru_add_drain();
>>>>
>>>>       if (old_page_state & PAGE_WAS_MAPPED)
>>>> -            remove_migration_ptes(src, dst, false);
>>>> +            remove_migration_ptes(src, dst, 0);
>>>>
>>>>    out_unlock_both:
>>>>       folio_unlock(dst);
>>>> @@ -1474,7 +1528,7 @@ static int unmap_and_move_huge_page(new_folio_t
>>>> get_new_folio,
>>>>
>>>>       if (page_was_mapped)
>>>>               remove_migration_ptes(src,
>>>> -                    rc == MIGRATEPAGE_SUCCESS ? dst : src,
>>>> false);
>>>> +                    rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
>>>>
>>>>    unlock_put_anon:
>>>>       folio_unlock(dst);
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index 8d687de88a03..9cf26592ac93 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -424,7 +424,7 @@ static unsigned long
>>>> migrate_device_unmap(unsigned long *src_pfns,
>>>>                       continue;
>>>>
>>>>               folio = page_folio(page);
>>>> -            remove_migration_ptes(folio, folio, false);
>>>> +            remove_migration_ptes(folio, folio, 0);
>>>>
>>>>               src_pfns[i] = 0;
>>>>               folio_unlock(folio);
>>>> @@ -840,7 +840,7 @@ void migrate_device_finalize(unsigned long
>>>> *src_pfns,
>>>>                       dst = src;
>>>>               }
>>>>
>>>> -            remove_migration_ptes(src, dst, false);
>>>> +            remove_migration_ptes(src, dst, 0);
>>>>               folio_unlock(src);
>>>>
>>>>               if (folio_is_zone_device(src))
>>>
>>> Hi,
>>>
>>> This patch has been in the mainline for some time, but we recently
>>> discovered an issue when both mTHP and MTE (Memory Tagging Extension)
>>> are enabled.
>>>
>>> It seems that remapping to the same zeropage might causes MTE tag
>>> mismatches, since MTE tags are associated with physical addresses.
>>
>> Does this only trigger when the VMA has mte enabled? Maybe we'll have to
>> bail out if we detect that mte is enabled.
> 
> It seems RISC-V also has a similar feature (RISCV_ISA_SUPM) that uses
> the same prctl(PR_{GET,SET}_TAGGED_ADDR_CTRL) API.
> 
> config RISCV_ISA_SUPM
>          bool "Supm extension for userspace pointer masking"
>          depends on 64BIT
>          default y
>          help
>            Add support for pointer masking in userspace (Supm) when the
>            underlying hardware extension (Smnpm or Ssnpm) is detected at boot.
> 
>            If this option is disabled, userspace will be unable to use
>            the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
> 
> I wonder if we should disable the THP shrinker for such architectures that

I think where possible we really only want to identify problematic 
(tagged) pages and skip them. And we should either look into fixing KSM 
as well or finding out why KSM is not affected.

-- 
Cheers

David / dhildenb


