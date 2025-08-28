Return-Path: <linux-kernel+bounces-790668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1955B3AB93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9964E05B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D5284B41;
	Thu, 28 Aug 2025 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY9R0dav"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6D1F9F73
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412581; cv=none; b=mOfhRgnBRydvnbvxB2+KNCN//4aQaQD51BrfOqqla/5e4/vQMkQQST2yYTKn6leZYtuLhH5aJCmf9XfOCj+T5vTi0WyeuKvOAo9Tcia237YKL6sqzmc7lQbiXB1TYobJBinNWhi7ytOajfKefV0WTsDpKmBaiF9HgO/3OxLMn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412581; c=relaxed/simple;
	bh=BVMcHYcBhIxHXC+hO9yG0yYE8xQCUE1iBxcFegieBY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5DSqAGp5LLXF+k1l/Qss1RgtFkULjiDFCkQaw6h9Ggus6rzRv25uWj7uKMCCP3HrdHVmR00EZq+J4XibMGiiz+QeC6Iuq+tiiI9UlttBuwwwJNauq3uz/eA6Vry2lGLqUUDPlXGphqx1mLzZBw92VvBsaIME6j0UX5QqV89Tb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SY9R0dav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756412578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iCw6S1c4Czg1r6M7ZHaUoX4qfCo09yOzs1izbaqUr5M=;
	b=SY9R0davtR+Rtkm/XgRylqZ7uJYz2FlsDT5Ab9PTD5fI4GX2ggxU0c6oeU6fTM6jvGHJKl
	ooc9+NMLs+xeXIAA9QkSWGVYe8s0NL5uX6ydfSYUpT/h41bkC131mwOSz/5bHYbuWiQk2i
	fkeHvzXzj3CCQ5XjO0DzfB7Qo1PEHqM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-c2WPG4XDNfqdeJkQlqCdTg-1; Thu, 28 Aug 2025 16:22:56 -0400
X-MC-Unique: c2WPG4XDNfqdeJkQlqCdTg-1
X-Mimecast-MFC-AGG-ID: c2WPG4XDNfqdeJkQlqCdTg_1756412575
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cf12498799so99532f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412575; x=1757017375;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCw6S1c4Czg1r6M7ZHaUoX4qfCo09yOzs1izbaqUr5M=;
        b=PLnprdpzqsU/Nbm2YBAyg/uhGg2AR1Sbq4/Qr55kX+5kmARQ6MCIIcUYxKLyj6kNqP
         tZ8kSGOAqImPkzE87GFXFBxXLA089wHJpARRNLDQ2JzcenAr0DupCf2q3XU/HM0WGXeN
         Q908Jury9L1174N4lO2BPDRNWzbKm7QKhWznATZSygiEJHFlhXmrg61RUc2he5jxDqF1
         JbtusbV6PjovmF+ZBEFJs1tg0SuqdcrWapYNtqqXBy4ZBgCDaIyEE5+KqNA1nvwWKZOu
         OERW8yz97WTzPyE5cVqOGs5DoF5OEx0gBH7j9xfMN4vubFfY/IZa7FqtSsauTEgw2WMI
         BJWw==
X-Forwarded-Encrypted: i=1; AJvYcCUXaBPA4CfN2NZ8GfJAY3JvrYS64HLAiHEtHbPIQ8Y8jds0qv4dcOV1cReowoW6/OYSFANvQkrpD7+tD/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxvn+J2sw6mOptJBDfScZOcqAmcfPc93WI9uo1MRIb/paiDggm
	lqVHPlTVs66UJIpAIu9Arzp+49aHjfx1fiS92lzFLbTCSuwhnhAS5EFzSpOSYN3gux5xGmMgaVD
	Rv1JiqGJf0q932+//ThzmxWdf32CQ8PR7kwutj4JX7TjjnH/HWv05rLK14w5n1aAGXw==
X-Gm-Gg: ASbGncssyA4GhPG76aYL+y5juyE0fIgZjA6kPysLL82Us0Ie0u+lm+6/r38GTGwknWU
	ddG5B1YXKVn7/aQbBfhqAYTfe5fmUJREx6oGWz1aZFI1aamsgyrG1gs7x/KRfVVSk7V4msRCPC4
	Bi5Oog4D1gBCTCqx9JcSUNzxb5W/tsUu0xbtlWJ2ybctSrrWhf0z2m+WHP+vlj3qkQOgxZhpMS7
	zx9gIN5jpfIHouZGA7aVVIfgpplqlpnPhf3+sWfnSQYz/2ciWj789AGCpM5IF7NX4wdm6ioApJa
	2Bv0V0YO5/FRqImFh+FBBobC+PxR0D8e+ptYw37uvfmfFhMio5kpkCawMGDyaLfjZs5QYeMUhAi
	cjr6PE7M0cqvxLpKKWUB1zr41j7aA3zu5Ya37doknoblB08klTT7czkSKdevqdDl1jLc=
X-Received: by 2002:a05:6000:2c02:b0:3cb:2fbb:cbec with SMTP id ffacd0b85a97d-3cb2fbbcfacmr9199144f8f.2.1756412575186;
        Thu, 28 Aug 2025 13:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1bdB/M72bSY/WXb2DaG2tpHGVwgtZZzzvekQUCsScziZOca1dV+TjSk1aAgRBOQI1EyT87Q==
X-Received: by 2002:a05:6000:2c02:b0:3cb:2fbb:cbec with SMTP id ffacd0b85a97d-3cb2fbbcfacmr9199122f8f.2.1756412574722;
        Thu, 28 Aug 2025 13:22:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f30fe02sm86293885e9.18.2025.08.28.13.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:22:54 -0700 (PDT)
Message-ID: <80a7b182-6bd4-49f5-ba3c-1ef53f51557c@redhat.com>
Date: Thu, 28 Aug 2025 22:22:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 02/11] mm/thp: zone_device awareness in THP handling code
To: Matthew Brost <matthew.brost@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250812024036.690064-1-balbirs@nvidia.com>
 <20250812024036.690064-3-balbirs@nvidia.com>
 <aLC2bfpIQo/a22gr@lstrano-desk.jf.intel.com>
 <00d58bba-7695-4f72-8ebd-d2db23fccec3@redhat.com>
 <aLC5SC7jUgUE2rKh@lstrano-desk.jf.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLC5SC7jUgUE2rKh@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.08.25 22:17, Matthew Brost wrote:
> On Thu, Aug 28, 2025 at 10:12:53PM +0200, David Hildenbrand wrote:
>> On 28.08.25 22:05, Matthew Brost wrote:
>>> On Tue, Aug 12, 2025 at 12:40:27PM +1000, Balbir Singh wrote:
>>>> Make THP handling code in the mm subsystem for THP pages aware of zone
>>>> device pages. Although the code is designed to be generic when it comes
>>>> to handling splitting of pages, the code is designed to work for THP
>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>
>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>> entry is present, enabling try_to_migrate() and other code migration
>>>> paths to appropriately process the entry. page_vma_mapped_walk() will
>>>> return true for zone device private large folios only when
>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
>>>> not zone device private pages from having to add awareness. The key
>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>> callbacks page idle, damon use it for setting young/dirty bits, which is
>>>> not significant when it comes to pmd level bit harvesting.
>>>>
>>>> pmd_pfn() does not work well with zone device entries, use
>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
>>>> entries.
>>>>
>>>> Support partial unmapping of zone device private entries, which happens
>>>> via munmap(). munmap() causes the device private entry pmd to be split,
>>>> but the corresponding folio is not split. Deferred split does not work for
>>>> zone device private folios due to the need to split during fault
>>>> handling. Get migrate_vma_collect_pmd() to handle this case by splitting
>>>> partially unmapped device private folios.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>>> Cc: Byungchul Park <byungchul@sk.com>
>>>> Cc: Gregory Price <gourry@gourry.net>
>>>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>>> Cc: Nico Pache <npache@redhat.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Dev Jain <dev.jain@arm.com>
>>>> Cc: Barry Song <baohua@kernel.org>
>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>> Cc: David Airlie <airlied@gmail.com>
>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>
>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>> ---
>>>>    include/linux/rmap.h    |   2 +
>>>>    include/linux/swapops.h |  17 ++++
>>>>    lib/test_hmm.c          |   2 +-
>>>>    mm/huge_memory.c        | 214 +++++++++++++++++++++++++++++++---------
>>>>    mm/migrate_device.c     |  47 +++++++++
>>>>    mm/page_vma_mapped.c    |  13 ++-
>>>>    mm/pgtable-generic.c    |   6 ++
>>>>    mm/rmap.c               |  24 ++++-
>>>>    8 files changed, 272 insertions(+), 53 deletions(-)
>>>>
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index 6cd020eea37a..dfb7aae3d77b 100644
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -927,6 +927,8 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
>>>>    #define PVMW_SYNC		(1 << 0)
>>>>    /* Look for migration entries rather than present PTEs */
>>>>    #define PVMW_MIGRATION		(1 << 1)
>>>> +/* Look for device private THP entries */
>>>> +#define PVMW_THP_DEVICE_PRIVATE	(1 << 2)
>>>>    struct page_vma_mapped_walk {
>>>>    	unsigned long pfn;
>>>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>>>> index 64ea151a7ae3..2641c01bd5d2 100644
>>>> --- a/include/linux/swapops.h
>>>> +++ b/include/linux/swapops.h
>>>> @@ -563,6 +563,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>>>>    {
>>>>    	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
>>>>    }
>>>> +
>>>>    #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>>>    static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>>>>    		struct page *page)
>>>> @@ -594,6 +595,22 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>>>>    }
>>>>    #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>>> +#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
>>>> +
>>>> +static inline int is_pmd_device_private_entry(pmd_t pmd)
>>>> +{
>>>> +	return is_swap_pmd(pmd) && is_device_private_entry(pmd_to_swp_entry(pmd));
>>>> +}
>>>> +
>>>> +#else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>>> +
>>>> +static inline int is_pmd_device_private_entry(pmd_t pmd)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>>> +
>>>>    static inline int non_swap_entry(swp_entry_t entry)
>>>>    {
>>>>    	return swp_type(entry) >= MAX_SWAPFILES;
>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>> index 761725bc713c..297f1e034045 100644
>>>> --- a/lib/test_hmm.c
>>>> +++ b/lib/test_hmm.c
>>>> @@ -1408,7 +1408,7 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
>>>>    	 * the mirror but here we use it to hold the page for the simulated
>>>>    	 * device memory and that page holds the pointer to the mirror.
>>>>    	 */
>>>> -	rpage = vmf->page->zone_device_data;
>>>> +	rpage = folio_page(page_folio(vmf->page), 0)->zone_device_data;
>>>>    	dmirror = rpage->zone_device_data;
>>>>    	/* FIXME demonstrate how we can adjust migrate range */
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 9c38a95e9f09..2495e3fdbfae 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -1711,8 +1711,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>>    	if (unlikely(is_swap_pmd(pmd))) {
>>>>    		swp_entry_t entry = pmd_to_swp_entry(pmd);
>>>> -		VM_BUG_ON(!is_pmd_migration_entry(pmd));
>>>> -		if (!is_readable_migration_entry(entry)) {
>>>> +		VM_WARN_ON(!is_pmd_migration_entry(pmd) &&
>>>> +				!is_pmd_device_private_entry(pmd));
>>>> +
>>>> +		if (is_migration_entry(entry) &&
>>>> +			is_writable_migration_entry(entry)) {
>>>>    			entry = make_readable_migration_entry(
>>>>    							swp_offset(entry));
>>>>    			pmd = swp_entry_to_pmd(entry);
>>>> @@ -1722,6 +1725,32 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>>    				pmd = pmd_swp_mkuffd_wp(pmd);
>>>>    			set_pmd_at(src_mm, addr, src_pmd, pmd);
>>>>    		}
>>>> +
>>>> +		if (is_device_private_entry(entry)) {
>>>> +			if (is_writable_device_private_entry(entry)) {
>>>> +				entry = make_readable_device_private_entry(
>>>> +					swp_offset(entry));
>>>> +				pmd = swp_entry_to_pmd(entry);
>>>> +
>>>> +				if (pmd_swp_soft_dirty(*src_pmd))
>>>> +					pmd = pmd_swp_mksoft_dirty(pmd);
>>>> +				if (pmd_swp_uffd_wp(*src_pmd))
>>>> +					pmd = pmd_swp_mkuffd_wp(pmd);
>>>> +				set_pmd_at(src_mm, addr, src_pmd, pmd);
>>>> +			}
>>>> +
>>>> +			src_folio = pfn_swap_entry_folio(entry);
>>>> +			VM_WARN_ON(!folio_test_large(src_folio));
>>>> +
>>>> +			folio_get(src_folio);
>>>> +			/*
>>>> +			 * folio_try_dup_anon_rmap_pmd does not fail for
>>>> +			 * device private entries.
>>>> +			 */
>>>> +			VM_WARN_ON(folio_try_dup_anon_rmap_pmd(src_folio,
>>>> +					  &src_folio->page, dst_vma, src_vma));
>>>
>>> VM_WARN_ON compiles out in non-debug builds. I hit this running the
>>> fork self I shared with a non-debug build.
>>
>>
>> folio_try_dup_anon_rmap_pmd() will never fail for
>> folio_is_device_private(folio) -- unless something is deeply messed up that
>> we wouldn't identify this folio as being device-private.
>>
>> Can you elaborate, what were you able to trigger, and in what kind of
>> environment?
>>
> 
> Maybe this was bad phrasing. I compilied the kernel with a non-debug
> build and fork() broke for THP device pages because the above call to
> folio_try_dup_anon_rmap_pmd compiled out (i.e., it wasn't called).

Ah, yes!

As I said in my reply, we should not do any kind of WARN here, like in 
the PTE case.

-- 
Cheers

David / dhildenb


