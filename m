Return-Path: <linux-kernel+bounces-849860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9791BD11C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662EA3BB1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7A264638;
	Mon, 13 Oct 2025 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bXX03/8s"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655C1E51E1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320130; cv=none; b=h27v9LHmFlBNYDkosoDOCT7kjzTkFLPXtxRKQOuUcEh+UE9kJgVhPiQOWYJDQjTf9HcDtIjohYl/F6FdIn0SG/Dhcmu20zJxbW86Wzh1W9Je5tf0KXpAJjdg9DovVsP4HnOcQ9bCaDAuI9OpXHfHRtqmbC5BM1X0BWtQbqQ02gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320130; c=relaxed/simple;
	bh=wxFaCpiHskkeK0uEPxkIbPVT69cU8Yn679wCXAzxWHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9o+2qhUAtpMDac+DWRO3//aLJwQWPZsnPQnl3HDHNO76p0usJVmIuRIQdOFXScGeuOLgHT/TnS7ptpNAS1hyAj6sr0HaZUPkPuauUCmV+2RkMLh5KwpxWHngWyGaKwFJY9PHi4TTBp3PC+LmUhUgKKL+TQWf/e9F1NBw/GjHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bXX03/8s; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83492e9c-3f17-42e5-8897-9c0ed5aa76e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760320125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gj2RUXsmZP7PFmKR9Hbs9L37/EeDx8LOSN13TezBQY=;
	b=bXX03/8sypLzEqxjMgSLg6S6KJ4kx88F2oJNJoY6wtz8ODzWzwFRiwv3G4HvihQLWuiaDt
	q+Ms2lDX8Ihlvl+anmvX0mKnUGSooXoDL0DkZ2LxLt38QiCGv6rOwsg2pSk49MIw/U8I2i
	UYzxgrVRyXndoEgLT2uTa1/GMhKbM2I=
Date: Mon, 13 Oct 2025 09:48:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v7 03/16] mm/huge_memory: add device-private THP support to PMD
 operations
Content-Language: en-US
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, akpm@linux-foundation.org,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
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
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20251001065707.920170-1-balbirs@nvidia.com>
 <20251001065707.920170-4-balbirs@nvidia.com>
 <CABzRoyYg1o8Oyjx1AQ8or-Vxm94zQXeAx7mWco2qs7=w4mBcMw@mail.gmail.com>
 <1b311458-957a-4f0d-b7f9-51e75bbabd55@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <1b311458-957a-4f0d-b7f9-51e75bbabd55@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/13 08:01, Balbir Singh wrote:
> On 10/13/25 02:46, Lance Yang wrote:
>> On Wed, Oct 1, 2025 at 4:20 PM Balbir Singh <balbirs@nvidia.com> wrote:
>>>
>>> Extend core huge page management functions to handle device-private THP
>>> entries.  This enables proper handling of large device-private folios in
>>> fundamental MM operations.
>>>
>>> The following functions have been updated:
>>>
>>> - copy_huge_pmd(): Handle device-private entries during fork/clone
>>> - zap_huge_pmd(): Properly free device-private THP during munmap
>>> - change_huge_pmd(): Support protection changes on device-private THP
>>> - __pte_offset_map(): Add device-private entry awareness
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>> Cc: Byungchul Park <byungchul@sk.com>
>>> Cc: Gregory Price <gourry@gourry.net>
>>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>> Cc: Nico Pache <npache@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Dev Jain <dev.jain@arm.com>
>>> Cc: Barry Song <baohua@kernel.org>
>>> Cc: Lyude Paul <lyude@redhat.com>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>> ---
>>>   include/linux/swapops.h | 32 +++++++++++++++++++++++
>>>   mm/huge_memory.c        | 56 ++++++++++++++++++++++++++++++++++-------
>>>   mm/pgtable-generic.c    |  2 +-
>>>   3 files changed, 80 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>>> index 64ea151a7ae3..2687928a8146 100644
>>> --- a/include/linux/swapops.h
>>> +++ b/include/linux/swapops.h
>>> @@ -594,10 +594,42 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>>>   }
>>>   #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>>
>>> +#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
>>> +
>>> +/**
>>> + * is_pmd_device_private_entry() - Check if PMD contains a device private swap entry
>>> + * @pmd: The PMD to check
>>> + *
>>> + * Returns true if the PMD contains a swap entry that represents a device private
>>> + * page mapping. This is used for zone device private pages that have been
>>> + * swapped out but still need special handling during various memory management
>>> + * operations.
>>> + *
>>> + * Return: 1 if PMD contains device private entry, 0 otherwise
>>> + */
>>> +static inline int is_pmd_device_private_entry(pmd_t pmd)
>>> +{
>>> +       return is_swap_pmd(pmd) && is_device_private_entry(pmd_to_swp_entry(pmd));
>>> +}
>>> +
>>> +#else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>> +
>>> +static inline int is_pmd_device_private_entry(pmd_t pmd)
>>> +{
>>> +       return 0;
>>> +}
>>> +
>>> +#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>> +
>>>   static inline int non_swap_entry(swp_entry_t entry)
>>>   {
>>>          return swp_type(entry) >= MAX_SWAPFILES;
>>>   }
>>>
>>> +static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
>>> +{
>>> +       return is_pmd_migration_entry(pmd) || is_pmd_device_private_entry(pmd);
>>> +}
>>> +
>>>   #endif /* CONFIG_MMU */
>>>   #endif /* _LINUX_SWAPOPS_H */
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 1b81680b4225..8e0a1747762d 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1703,17 +1703,45 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>          if (unlikely(is_swap_pmd(pmd))) {
>>>                  swp_entry_t entry = pmd_to_swp_entry(pmd);
>>>
>>> -               VM_BUG_ON(!is_pmd_migration_entry(pmd));
>>> -               if (!is_readable_migration_entry(entry)) {
>>> -                       entry = make_readable_migration_entry(
>>> -                                                       swp_offset(entry));
>>> +               VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
>>> +
>>> +               if (is_writable_migration_entry(entry) ||
>>> +                   is_readable_exclusive_migration_entry(entry)) {
>>> +                       entry = make_readable_migration_entry(swp_offset(entry));
>>>                          pmd = swp_entry_to_pmd(entry);
>>>                          if (pmd_swp_soft_dirty(*src_pmd))
>>>                                  pmd = pmd_swp_mksoft_dirty(pmd);
>>>                          if (pmd_swp_uffd_wp(*src_pmd))
>>>                                  pmd = pmd_swp_mkuffd_wp(pmd);
>>>                          set_pmd_at(src_mm, addr, src_pmd, pmd);
>>> +               } else if (is_device_private_entry(entry)) {
>>> +                       /*
>>> +                        * For device private entries, since there are no
>>> +                        * read exclusive entries, writable = !readable
>>> +                        */
>>> +                       if (is_writable_device_private_entry(entry)) {
>>> +                               entry = make_readable_device_private_entry(swp_offset(entry));
>>> +                               pmd = swp_entry_to_pmd(entry);
>>> +
>>> +                               if (pmd_swp_soft_dirty(*src_pmd))
>>> +                                       pmd = pmd_swp_mksoft_dirty(pmd);
>>> +                               if (pmd_swp_uffd_wp(*src_pmd))
>>> +                                       pmd = pmd_swp_mkuffd_wp(pmd);
>>> +                               set_pmd_at(src_mm, addr, src_pmd, pmd);
>>> +                       }
>>> +
>>> +                       src_folio = pfn_swap_entry_folio(entry);
>>> +                       VM_WARN_ON(!folio_test_large(src_folio));
>>> +
>>> +                       folio_get(src_folio);
>>> +                       /*
>>> +                        * folio_try_dup_anon_rmap_pmd does not fail for
>>> +                        * device private entries.
>>> +                        */
>>> +                       folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
>>> +                                                       dst_vma, src_vma);
>>>                  }
>>> +
>>>                  add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>>                  mm_inc_nr_ptes(dst_mm);
>>>                  pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
>>> @@ -2211,15 +2239,16 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>                          folio_remove_rmap_pmd(folio, page, vma);
>>>                          WARN_ON_ONCE(folio_mapcount(folio) < 0);
>>>                          VM_BUG_ON_PAGE(!PageHead(page), page);
>>> -               } else if (thp_migration_supported()) {
>>> +               } else if (is_pmd_non_present_folio_entry(orig_pmd)) {
>>>                          swp_entry_t entry;
>>>
>>> -                       VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>>>                          entry = pmd_to_swp_entry(orig_pmd);
>>>                          folio = pfn_swap_entry_folio(entry);
>>>                          flush_needed = 0;
>>> -               } else
>>> -                       WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>>> +
>>> +                       if (!thp_migration_supported())
>>> +                               WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>>> +               }
>>>
>>>                  if (folio_test_anon(folio)) {
>>>                          zap_deposited_table(tlb->mm, pmd);
>>> @@ -2239,6 +2268,12 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>                                  folio_mark_accessed(folio);
>>>                  }
>>>
>>> +               if (folio_is_device_private(folio)) {
>>> +                       folio_remove_rmap_pmd(folio, &folio->page, vma);
>>> +                       WARN_ON_ONCE(folio_mapcount(folio) < 0);
>>> +                       folio_put(folio);
>>> +               }
>>
>> IIUC, a device-private THP is always anonymous, right? would it make sense
>> to move this folio_is_device_private() block inside the folio_test_anon()
>> check above?
>>
> Yes, they are, there is discussion on file-backed mapping at
> https://lwn.net/Articles/1016124/. I don't see a benefit from moving it, do you?

Ah, I see. Never mind :)

Cheers,
Lance


