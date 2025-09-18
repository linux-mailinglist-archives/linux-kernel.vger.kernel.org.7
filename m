Return-Path: <linux-kernel+bounces-822646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FCBB84635
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994D93BDDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D363016E7;
	Thu, 18 Sep 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a62FD3lO"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0452FFF86
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195759; cv=none; b=mUc9MGcDKDiOhnBiDZ6VkdfttrkS6g7U7Gio33rMEKdWY5eEZ5N/zAi9S6CH5QAZUxUCXNQYBlVt9oLp4iWyysGmv8T6H1N3osTnBJ7h3d3B4Gg5Pyyh5ZW8w1y5blWz8u4y13A+MXTDuVlhKNefSvuWQJK4uiw7nyH3jt5H6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195759; c=relaxed/simple;
	bh=t9mifjWp2j3b5VN14M99vHSyYCRjuIn41Mrs2CyxUsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLYYXjoC29GJYJosSZ7UuqTKA9OvpnZcBOJkLTjnJUm8vn31G7W/VdML6K2uGat/WkcCcLC2/AmYwRzx8L1zM5DCw1LVXSQxN5HwPqo8XhOlZAOkPwQD5EROBnrsKXPqxpY+CyvzmE9C4AKVcJ7UE3gtW5l2/RzyRQqgottyk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a62FD3lO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso555645f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758195755; x=1758800555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MDldjfo9tupcUWZQnJpfd82Ij9mxbI05fyuJdEjujE=;
        b=a62FD3lOosjbkKOP3cDs5fPBLK01C7G+W5kGHba3jBJsc8pMMybGujAhYuJCcWlftK
         IIzqeq3M0fzq9/L4U6aDFep3wRnf7oNkAMHGNSCwCL6YGGu4Ea0lqB12hSk1mbMrp/CY
         qfj/UF9oatJbcoFlZk/YMwh+8g/cG/g/waulleQWGxBZj/WOire+Le7ER2TBtjkQ4lSi
         3kxaOyc24usW4fV1hUZ5g44OzasSUEVMYUIiygSQHNRnJ+dmFBtr+fVd+pjnFBpqz7By
         g99ml6sfawbQ+sno377k9krDXJDAzNH8M3loT6dV1fsK7UDNHbEPTKq0HpELg2oygtDj
         mTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195755; x=1758800555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MDldjfo9tupcUWZQnJpfd82Ij9mxbI05fyuJdEjujE=;
        b=kHbik+x3wl1f/Aw33J9VIdiOW49waIEMhHRmiVCTzKdGta3r/ThaUzBAqfJeyFrnLY
         +mDFeCEEH8Nuo3qd/+09ZbVOKYR4NehY4jf+bXahREmGnP3Q7mXJosVrk+wLYDrwfk8a
         JB+Ro0QP0YnUfh4XPvy/Wc8OvXVWt3ut4kX2Ao7alnMiH1S1yE34rFSpAHhnYiYk18dt
         uo7bI+60miIgxpR+FXDIrNzsNgkS7RtlW2JJ2iL7/2c0GYy4pB2iyHYIlKIbMTjTkxrA
         /nJsiEBPS3R87RhaqCRCVaF7HVuB7gXXTBywfuylyRJYD+uVk3pCjGxLE/3D7x5pNoBV
         2teA==
X-Forwarded-Encrypted: i=1; AJvYcCWZH+c+5mt4KNspTBZCVs4kpD2K5UB4h7XRE6uB7hrrKELwy6i5bdDrBOSJISLoA/jay84dEsH/JlmsvOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ek/fPHx0WbUlVBN0A6D5/kU5mhDi8E8DR+1wOu9Vu5FeoDf2
	r48toPlCE+TJs4sH5GyVhAUIfE70oo6OArib2NCOuXq0ODbLM6Tj98Plpln5Uw==
X-Gm-Gg: ASbGncsfgsRouGwZHtcTcizs2c80NEfDJDzsbnxbQ9ZgdDCfb90opuBhUHRNEcle9vm
	kAvfic4HVSbAXNYouXQpA5v5n7+N/synRF8ZM1aXjKTAxharZun9467ccfWnl0ckv2QDhomGzwB
	0PWXj64Pa4kouBiOGeTF9wXH98VGtZK2OX2ezRouonqYlex4aHvG92is9+9Jh312wOv3bdK2uIs
	QbhFNtfy4BscZOSjRhNK3eQKy0keLIi9+Plr1ohXk3Z1mE7paRg0temWID7ZQp6fOM958TwjmsR
	xK38YcM7kdxypb/Axd6unc7kPiIeSdFZxWun+sgGJxE00y4WggDD/oMMeQe91StCeEWxyWdgcwx
	JEjUMWIwri+axdEpPtBFcpexK1lKaA3hn+rkQKgkv/f5Zq+gCIjrFIrDljCguSBGZ3X0z4NrHUA
	8itk2dzUyqHo+RgMlrvoF8cN0shj7BTTciGJ9a/+tZeLinn7c=
X-Google-Smtp-Source: AGHT+IF829AGz7l52wXYxA2mF38Hka9ir3qUf7a8oPfBCDeW8zhPeoB6ZqT8hn60Yp5Ltk7KFhTa5Q==
X-Received: by 2002:a05:6000:4383:b0:3e1:219e:a74a with SMTP id ffacd0b85a97d-3ecdf9c277cmr5586035f8f.21.1758195754770;
        Thu, 18 Sep 2025 04:42:34 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm3405278f8f.60.2025.09.18.04.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:42:33 -0700 (PDT)
Message-ID: <52175d87-50b5-49f8-bb68-6071e6b03557@gmail.com>
Date: Thu, 18 Sep 2025 12:42:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "yuzhao@google.com" <yuzhao@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
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
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <434c092b-0f19-47bf-a5fa-ea5b4b36c35e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/09/2025 09:56, David Hildenbrand wrote:
> On 18.09.25 10:53, Qun-wei Lin (林群崴) wrote:
>> On Fri, 2024-08-30 at 11:03 +0100, Usama Arif wrote:
>>> From: Yu Zhao <yuzhao@google.com>
>>>
>>> Here being unused means containing only zeros and inaccessible to
>>> userspace. When splitting an isolated thp under reclaim or migration,
>>> the unused subpages can be mapped to the shared zeropage, hence
>>> saving
>>> memory. This is particularly helpful when the internal
>>> fragmentation of a thp is high, i.e. it has many untouched subpages.
>>>
>>> This is also a prerequisite for THP low utilization shrinker which
>>> will
>>> be introduced in later patches, where underutilized THPs are split,
>>> and
>>> the zero-filled pages are freed saving memory.
>>>
>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>> Tested-by: Shuang Zhai <zhais@google.com>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>>   include/linux/rmap.h |  7 ++++-
>>>   mm/huge_memory.c     |  8 ++---
>>>   mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++----
>>> -- 
>>>   mm/migrate_device.c  |  4 +--
>>>   4 files changed, 75 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index 91b5935e8485..d5e93e44322e 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
>>>   int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages,
>>> pgoff_t pgoff,
>>>                 struct vm_area_struct *vma);
>>>   -void remove_migration_ptes(struct folio *src, struct folio *dst,
>>> bool locked);
>>> +enum rmp_flags {
>>> +    RMP_LOCKED        = 1 << 0,
>>> +    RMP_USE_SHARED_ZEROPAGE    = 1 << 1,
>>> +};
>>> +
>>> +void remove_migration_ptes(struct folio *src, struct folio *dst, int
>>> flags);
>>>     /*
>>>    * rmap_walk_control: To control rmap traversing for specific needs
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 0c48806ccb9a..af60684e7c70 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct
>>> vm_area_struct *vma, unsigned long addr,
>>>       return false;
>>>   }
>>>   -static void remap_page(struct folio *folio, unsigned long nr)
>>> +static void remap_page(struct folio *folio, unsigned long nr, int
>>> flags)
>>>   {
>>>       int i = 0;
>>>   @@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio,
>>> unsigned long nr)
>>>       if (!folio_test_anon(folio))
>>>           return;
>>>       for (;;) {
>>> -        remove_migration_ptes(folio, folio, true);
>>> +        remove_migration_ptes(folio, folio, RMP_LOCKED |
>>> flags);
>>>           i += folio_nr_pages(folio);
>>>           if (i >= nr)
>>>               break;
>>> @@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page
>>> *page, struct list_head *list,
>>>         if (nr_dropped)
>>>           shmem_uncharge(folio->mapping->host, nr_dropped);
>>> -    remap_page(folio, nr);
>>> +    remap_page(folio, nr, PageAnon(head) ?
>>> RMP_USE_SHARED_ZEROPAGE : 0);
>>>         /*
>>>        * set page to its compound_head when split to non order-0
>>> pages, so
>>> @@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct
>>> page *page, struct list_head *list,
>>>           if (mapping)
>>>               xas_unlock(&xas);
>>>           local_irq_enable();
>>> -        remap_page(folio, folio_nr_pages(folio));
>>> +        remap_page(folio, folio_nr_pages(folio), 0);
>>>           ret = -EAGAIN;
>>>       }
>>>   diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 6f9c62c746be..d039863e014b 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio,
>>> struct list_head *list)
>>>       return true;
>>>   }
>>>   +static bool try_to_map_unused_to_zeropage(struct
>>> page_vma_mapped_walk *pvmw,
>>> +                      struct folio *folio,
>>> +                      unsigned long idx)
>>> +{
>>> +    struct page *page = folio_page(folio, idx);
>>> +    bool contains_data;
>>> +    pte_t newpte;
>>> +    void *addr;
>>> +
>>> +    VM_BUG_ON_PAGE(PageCompound(page), page);
>>> +    VM_BUG_ON_PAGE(!PageAnon(page), page);
>>> +    VM_BUG_ON_PAGE(!PageLocked(page), page);
>>> +    VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
>>> +
>>> +    if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags &
>>> VM_LOCKED) ||
>>> +        mm_forbids_zeropage(pvmw->vma->vm_mm))
>>> +        return false;
>>> +
>>> +    /*
>>> +     * The pmd entry mapping the old thp was flushed and the pte
>>> mapping
>>> +     * this subpage has been non present. If the subpage is only
>>> zero-filled
>>> +     * then map it to the shared zeropage.
>>> +     */
>>> +    addr = kmap_local_page(page);
>>> +    contains_data = memchr_inv(addr, 0, PAGE_SIZE);
>>> +    kunmap_local(addr);
>>> +
>>> +    if (contains_data)
>>> +        return false;
>>> +
>>> +    newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>> +                    pvmw->vma->vm_page_prot));
>>> +    set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte,
>>> newpte);
>>> +
>>> +    dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
>>> +    return true;
>>> +}
>>> +
>>> +struct rmap_walk_arg {
>>> +    struct folio *folio;
>>> +    bool map_unused_to_zeropage;
>>> +};
>>> +
>>>   /*
>>>    * Restore a potential migration pte to a working pte entry
>>>    */
>>>   static bool remove_migration_pte(struct folio *folio,
>>> -        struct vm_area_struct *vma, unsigned long addr, void
>>> *old)
>>> +        struct vm_area_struct *vma, unsigned long addr, void
>>> *arg)
>>>   {
>>> -    DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC |
>>> PVMW_MIGRATION);
>>> +    struct rmap_walk_arg *rmap_walk_arg = arg;
>>> +    DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr,
>>> PVMW_SYNC | PVMW_MIGRATION);
>>>         while (page_vma_mapped_walk(&pvmw)) {
>>>           rmap_t rmap_flags = RMAP_NONE;
>>> @@ -234,6 +278,9 @@ static bool remove_migration_pte(struct folio
>>> *folio,
>>>               continue;
>>>           }
>>>   #endif
>>> +        if (rmap_walk_arg->map_unused_to_zeropage &&
>>> +            try_to_map_unused_to_zeropage(&pvmw, folio,
>>> idx))
>>> +            continue;
>>>             folio_get(folio);
>>>           pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
>>> @@ -312,14 +359,21 @@ static bool remove_migration_pte(struct folio
>>> *folio,
>>>    * Get rid of all migration entries and replace them by
>>>    * references to the indicated page.
>>>    */
>>> -void remove_migration_ptes(struct folio *src, struct folio *dst,
>>> bool locked)
>>> +void remove_migration_ptes(struct folio *src, struct folio *dst, int
>>> flags)
>>>   {
>>> +    struct rmap_walk_arg rmap_walk_arg = {
>>> +        .folio = src,
>>> +        .map_unused_to_zeropage = flags &
>>> RMP_USE_SHARED_ZEROPAGE,
>>> +    };
>>> +
>>>       struct rmap_walk_control rwc = {
>>>           .rmap_one = remove_migration_pte,
>>> -        .arg = src,
>>> +        .arg = &rmap_walk_arg,
>>>       };
>>>   -    if (locked)
>>> +    VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src !=
>>> dst), src);
>>> +
>>> +    if (flags & RMP_LOCKED)
>>>           rmap_walk_locked(dst, &rwc);
>>>       else
>>>           rmap_walk(dst, &rwc);
>>> @@ -934,7 +988,7 @@ static int writeout(struct address_space
>>> *mapping, struct folio *folio)
>>>        * At this point we know that the migration attempt cannot
>>>        * be successful.
>>>        */
>>> -    remove_migration_ptes(folio, folio, false);
>>> +    remove_migration_ptes(folio, folio, 0);
>>>         rc = mapping->a_ops->writepage(&folio->page, &wbc);
>>>   @@ -1098,7 +1152,7 @@ static void migrate_folio_undo_src(struct folio
>>> *src,
>>>                      struct list_head *ret)
>>>   {
>>>       if (page_was_mapped)
>>> -        remove_migration_ptes(src, src, false);
>>> +        remove_migration_ptes(src, src, 0);
>>>       /* Drop an anon_vma reference if we took one */
>>>       if (anon_vma)
>>>           put_anon_vma(anon_vma);
>>> @@ -1336,7 +1390,7 @@ static int migrate_folio_move(free_folio_t
>>> put_new_folio, unsigned long private,
>>>           lru_add_drain();
>>>         if (old_page_state & PAGE_WAS_MAPPED)
>>> -        remove_migration_ptes(src, dst, false);
>>> +        remove_migration_ptes(src, dst, 0);
>>>     out_unlock_both:
>>>       folio_unlock(dst);
>>> @@ -1474,7 +1528,7 @@ static int unmap_and_move_huge_page(new_folio_t
>>> get_new_folio,
>>>         if (page_was_mapped)
>>>           remove_migration_ptes(src,
>>> -            rc == MIGRATEPAGE_SUCCESS ? dst : src,
>>> false);
>>> +            rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
>>>     unlock_put_anon:
>>>       folio_unlock(dst);
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index 8d687de88a03..9cf26592ac93 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -424,7 +424,7 @@ static unsigned long
>>> migrate_device_unmap(unsigned long *src_pfns,
>>>               continue;
>>>             folio = page_folio(page);
>>> -        remove_migration_ptes(folio, folio, false);
>>> +        remove_migration_ptes(folio, folio, 0);
>>>             src_pfns[i] = 0;
>>>           folio_unlock(folio);
>>> @@ -840,7 +840,7 @@ void migrate_device_finalize(unsigned long
>>> *src_pfns,
>>>               dst = src;
>>>           }
>>>   -        remove_migration_ptes(src, dst, false);
>>> +        remove_migration_ptes(src, dst, 0);
>>>           folio_unlock(src);
>>>             if (folio_is_zone_device(src))
>>
>> Hi,
>>
>> This patch has been in the mainline for some time, but we recently
>> discovered an issue when both mTHP and MTE (Memory Tagging Extension)
>> are enabled.
>>
>> It seems that remapping to the same zeropage might causes MTE tag
>> mismatches, since MTE tags are associated with physical addresses.
> 
> Does this only trigger when the VMA has mte enabled? Maybe we'll have to bail out if we detect that mte is enabled.
> 

I believe MTE is all or nothing? i.e. all the memory is tagged when enabled, but will let the arm folks confirm.

Yeah unfortunately I think that might be the only way. We cant change the pointers and I dont think there is a way
to mark the memory as "untagged". If we cant remap to zeropage, then there is no point of shrinker. I am guessing
instead of checking at runtime whether mte is enabled when remapping to shared zeropage, we need to ifndef the
shrinker if CONFIG_ARM64_MTE is enabled?

> Also, I wonder how KSM and the shared zeropage works in general with that, because I would expect similar issues when we de-duplicate memory?
> 

Yeah thats a very good point!

Also the initial report mentioned mTHP instead of THP, but I dont think that matters.


