Return-Path: <linux-kernel+bounces-752938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6BB17CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135464E171F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3E33987;
	Fri,  1 Aug 2025 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OStZGcvL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44B1F03D8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028091; cv=none; b=bF+dxirF6yVZvA8tljPhOh6fujWOPXzrJPwpNdPTOK/RGmwP3GJwF+Eqo3Zyu4YZWfI63tsM3WOWfJU2EDXeK9//ffHk7AWpKcIi3qAlNfMiamIsqBsrcqZ2GeTjorryUwgDxXp2iPFtMLesjhgrc/Sqpl2WBy+22SUxlCuHW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028091; c=relaxed/simple;
	bh=6nidgS63eC/zAM9jduh9uY5RAMABPjqeSAd7Sn2/D7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6x2F5iTELV+zm1YfX8e/Fmf16WpG3y3HXraACotaOz2KvGFEvdNS1L6qDvyxEb1l2mFyGe5WQLFQBPhJzfXYQYM/b0Q6f+G1aw46d5Lnku5oEDp98hnUssY9rYoOxaGljwzUnGgWhIU+xdZDWFqarhdgoMgbbE7Tiw7AsRzBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OStZGcvL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754028087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdZC5+nmo9dUHgvl2KKSykpDdecoEUXr7xB1ysKzrIg=;
	b=OStZGcvLAm2PcD8dMBfP1NxoLYunhzcwG8gs+mJwMxS1VSgiFz8q+PXzZvaJnWH1gyODdF
	NTIPwYZpYbFxN9a5GvXPDGADU0ZboKsq3B2l7NuhM8JrHOHjgt0t9a3dOXohqNcGVcmdnw
	T/rg21wK5CVPy6X32SssyZVsC69MQYU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Eq3fkC68MGmDBrkVMWWJ5Q-1; Fri, 01 Aug 2025 02:01:25 -0400
X-MC-Unique: Eq3fkC68MGmDBrkVMWWJ5Q-1
X-Mimecast-MFC-AGG-ID: Eq3fkC68MGmDBrkVMWWJ5Q_1754028082
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55b91b8f858so63984e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754028082; x=1754632882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdZC5+nmo9dUHgvl2KKSykpDdecoEUXr7xB1ysKzrIg=;
        b=bULwRrgQuNfZkSQol41vGJD9cTdsoDs4pD3cblPg8Wz4wnNymnnyuIbmZf5wTKd2Yf
         78dEvO2AyPVnMdNojw31KiSSTW1F6VqLGwpRfY4ugaFk+rIvxv/pKBvS8aXmVd8AqNoc
         zHdjCmHKahPwqc2e4EZz41LExnSX2hivBQjFSq9/u3jsHgS5Q1JmJuPILWtU60sNNFWk
         sSECQiXY9NCDvyDuJ/FE9Qs1mYf2o0yq8UW2FubYWVapoXBDRHn2/SIPFAvgwjgStfbM
         UkK3KDSptUBmV3VTBBR10SXXk2znt5bXxixHRH1MDR2LW51ew072L8KeqZlCc+l8W4CL
         f1yA==
X-Forwarded-Encrypted: i=1; AJvYcCWqBJGzj8xDFTwtYQeXQfwlvydlZutC5ZBquLpC5smF+hr8akaobBCpU4mDjvT/Lu9QEsY4a+21b0oFMPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZHs1FecUA2jnmbOOyOMoC/1fv0k9scfGozGNHepljV+um+4+
	RPWa4c9Srqi3L5QtxhVXwwrLsXQzVxZklXdrE8wY3de+ZzNOjd9vvmCnTloPJPBVj8BqGWPESdX
	ZXQS0NGke5Jn3xYm59E7rrA4OtstVSTpNkd83Bp2EyPE90Z/0dfx8MPz63tdD26nw
X-Gm-Gg: ASbGnct9F1nY3K/UqHsFRxi0i76H3w1FaXpMPBjJZ+Jk3P5dGDzIwJQc8k5pwNc+75C
	2OeWNWPGPPeIUX1EnPh6yQAgJInfALeoe3nFb4KZUHWBjBUNZt7y/73G9aNGUXtLtezbbYSSnOo
	kgkT2Y1MgNQctCDKAtGo6Pb+sAHGFcdLsQ00xZ2QX+Bv6morf9XPaadNHAcFu2eRIm/8mdWTvKv
	VDoOF7TmN2jS2hrLQKM6vqgCWojhB0beLWsjUCHop7+76Mt1OES6J4gMl0WKPuN2C9pWGympgZw
	KoAko/Pu0sfsyaG6yinVPEQ4STcmlYysalag1rlfiXnUrEvjs/av6bRxlOn/VDzV1w==
X-Received: by 2002:a05:6512:138b:b0:55b:894b:72fc with SMTP id 2adb3069b0e04-55b8f262bddmr523004e87.10.1754028081850;
        Thu, 31 Jul 2025 23:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYBE28J5PJ5xh2/y8f+TbNJAhiqdTHtKUFB3l97nn8fQ38bAYqBti7BEIZZMYbtXFaBC1VcQ==
X-Received: by 2002:a05:6512:138b:b0:55b:894b:72fc with SMTP id 2adb3069b0e04-55b8f262bddmr522764e87.10.1754028073515;
        Thu, 31 Jul 2025 23:01:13 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8899dc75sm456787e87.40.2025.07.31.23.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 23:01:12 -0700 (PDT)
Message-ID: <e9b58e5c-adfd-4738-a4b6-4a9b09509549@redhat.com>
Date: Fri, 1 Aug 2025 09:01:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
To: Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-3-balbirs@nvidia.com>
 <c2f2fe52-a358-489e-a1f2-5c0a6f5b4db5@redhat.com>
 <22D1AD52-F7DA-4184-85A7-0F14D2413591@nvidia.com>
 <F60614E1-28D1-466B-A434-7FF1061B0778@nvidia.com>
 <9f836828-4f53-41a0-b5f7-bbcd2084086e@redhat.com>
 <884b9246-de7c-4536-821f-1bf35efe31c8@redhat.com>
 <6291D401-1A45-4203-B552-79FE26E151E4@nvidia.com>
 <b62234fc-051f-4b2a-b7da-0c0959fb269b@redhat.com>
 <8E2CE1DF-4C37-4690-B968-AEA180FF44A1@nvidia.com>
 <2308291f-3afc-44b4-bfc9-c6cf0cdd6295@redhat.com>
 <9FBDBFB9-8B27-459C-8047-055F90607D60@nvidia.com>
 <11ee9c5e-3e74-4858-bf8d-94daf1530314@redhat.com>
 <b5fa0989-a64a-4c91-ac34-6fb29ee6d132@redhat.com>
 <EC99D49E-86FF-4A50-A1AA-FC43A7D3716C@nvidia.com>
 <14aeaecc-c394-41bf-ae30-24537eb299d9@nvidia.com>
 <e5dd3f46-c063-45ff-8be7-64ac92534985@redhat.com>
 <71c736e9-eb77-4e8e-bd6a-965a1bbcbaa8@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <71c736e9-eb77-4e8e-bd6a-965a1bbcbaa8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/1/25 07:44, Balbir Singh wrote:
> On 8/1/25 11:16, Mika Penttilä wrote:
>> Hi,
>>
>> On 8/1/25 03:49, Balbir Singh wrote:
>>
>>> On 7/31/25 21:26, Zi Yan wrote:
>>>> On 31 Jul 2025, at 3:15, David Hildenbrand wrote:
>>>>
>>>>> On 30.07.25 18:29, Mika Penttilä wrote:
>>>>>> On 7/30/25 18:58, Zi Yan wrote:
>>>>>>> On 30 Jul 2025, at 11:40, Mika Penttilä wrote:
>>>>>>>
>>>>>>>> On 7/30/25 18:10, Zi Yan wrote:
>>>>>>>>> On 30 Jul 2025, at 8:49, Mika Penttilä wrote:
>>>>>>>>>
>>>>>>>>>> On 7/30/25 15:25, Zi Yan wrote:
>>>>>>>>>>> On 30 Jul 2025, at 8:08, Mika Penttilä wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 7/30/25 14:42, Mika Penttilä wrote:
>>>>>>>>>>>>> On 7/30/25 14:30, Zi Yan wrote:
>>>>>>>>>>>>>> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 30 Jul 2025, at 7:16, Mika Penttilä wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 7/30/25 12:21, Balbir Singh wrote:
>>>>>>>>>>>>>>>>> Make THP handling code in the mm subsystem for THP pages aware of zone
>>>>>>>>>>>>>>>>> device pages. Although the code is designed to be generic when it comes
>>>>>>>>>>>>>>>>> to handling splitting of pages, the code is designed to work for THP
>>>>>>>>>>>>>>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>>>>>>>>>>>>>>> entry is present, enabling try_to_migrate() and other code migration
>>>>>>>>>>>>>>>>> paths to appropriately process the entry. page_vma_mapped_walk() will
>>>>>>>>>>>>>>>>> return true for zone device private large folios only when
>>>>>>>>>>>>>>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
>>>>>>>>>>>>>>>>> not zone device private pages from having to add awareness. The key
>>>>>>>>>>>>>>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>>>>>>>>>>>>>>> callbacks page idle, damon use it for setting young/dirty bits, which is
>>>>>>>>>>>>>>>>> not significant when it comes to pmd level bit harvesting.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> pmd_pfn() does not work well with zone device entries, use
>>>>>>>>>>>>>>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
>>>>>>>>>>>>>>>>> entries.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Zone device private entries when split via munmap go through pmd split,
>>>>>>>>>>>>>>>>> but need to go through a folio split, deferred split does not work if a
>>>>>>>>>>>>>>>>> fault is encountered because fault handling involves migration entries
>>>>>>>>>>>>>>>>> (via folio_migrate_mapping) and the folio sizes are expected to be the
>>>>>>>>>>>>>>>>> same there. This introduces the need to split the folio while handling
>>>>>>>>>>>>>>>>> the pmd split. Because the folio is still mapped, but calling
>>>>>>>>>>>>>>>>> folio_split() will cause lock recursion, the __split_unmapped_folio()
>>>>>>>>>>>>>>>>> code is used with a new helper to wrap the code
>>>>>>>>>>>>>>>>> split_device_private_folio(), which skips the checks around
>>>>>>>>>>>>>>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>>>>>>>>>>>>>>> folio.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>>>>>>>>>>>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>>>>>>>>>>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>>>>>>>>>>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>>>>>>>>>>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>>>>>>>>>>>>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>>>>>>>>>>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>>>>>>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>>>>>>>>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>>>>>>>>>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>>>>>>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>>>>>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>>>>>>>>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>>>>>>>>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>>>>>>>>>>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>>>>>>>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>>>>>>>>>>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>>>>>>>>>>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>>>>>>>>>>>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>>>>>>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>>>>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>>>>>>>>>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>>>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>   include/linux/huge_mm.h |   1 +
>>>>>>>>>>>>>>>>>   include/linux/rmap.h    |   2 +
>>>>>>>>>>>>>>>>>   include/linux/swapops.h |  17 +++
>>>>>>>>>>>>>>>>>   mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>>>>>>>>>>>>>>>>>   mm/page_vma_mapped.c    |  13 +-
>>>>>>>>>>>>>>>>>   mm/pgtable-generic.c    |   6 +
>>>>>>>>>>>>>>>>>   mm/rmap.c               |  22 +++-
>>>>>>>>>>>>>>>>>   7 files changed, 278 insertions(+), 51 deletions(-)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> <snip>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> +/**
>>>>>>>>>>>>>>>>> + * split_huge_device_private_folio - split a huge device private folio into
>>>>>>>>>>>>>>>>> + * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>>>>>>>>>>>>> + * split folios for pages that are partially mapped
>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>> + * @folio: the folio to split
>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>> + * The caller has to hold the folio_lock and a reference via folio_get
>>>>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>>>>> +int split_device_private_folio(struct folio *folio)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +	struct folio *end_folio = folio_next(folio);
>>>>>>>>>>>>>>>>> +	struct folio *new_folio;
>>>>>>>>>>>>>>>>> +	int ret = 0;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +	/*
>>>>>>>>>>>>>>>>> +	 * Split the folio now. In the case of device
>>>>>>>>>>>>>>>>> +	 * private pages, this path is executed when
>>>>>>>>>>>>>>>>> +	 * the pmd is split and since freeze is not true
>>>>>>>>>>>>>>>>> +	 * it is likely the folio will be deferred_split.
>>>>>>>>>>>>>>>>> +	 *
>>>>>>>>>>>>>>>>> +	 * With device private pages, deferred splits of
>>>>>>>>>>>>>>>>> +	 * folios should be handled here to prevent partial
>>>>>>>>>>>>>>>>> +	 * unmaps from causing issues later on in migration
>>>>>>>>>>>>>>>>> +	 * and fault handling flows.
>>>>>>>>>>>>>>>>> +	 */
>>>>>>>>>>>>>>>>> +	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>>>>>>>>>>> Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?
>>>>>>>>>>>>>>> Based on my off-list conversation with Balbir, the folio is unmapped in
>>>>>>>>>>>>>>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>>>>>>>>>>>>>>> device side mapping.
>>>>>>>>>>>>>> Maybe we should make it aware of device private mapping? So that the
>>>>>>>>>>>>>> process mirrors CPU side folio split: 1) unmap device private mapping,
>>>>>>>>>>>>>> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
>>>>>>>>>>>>>> 5) remap device private mapping.
>>>>>>>>>>>>> Ah ok this was about device private page obviously here, nevermind..
>>>>>>>>>>>> Still, isn't this reachable from split_huge_pmd() paths and folio is mapped to CPU page tables as a huge device page by one or more task?
>>>>>>>>>>> The folio only has migration entries pointing to it. From CPU perspective,
>>>>>>>>>>> it is not mapped. The unmap_folio() used by __folio_split() unmaps a to-be-split
>>>>>>>>>>> folio by replacing existing page table entries with migration entries
>>>>>>>>>>> and after that the folio is regarded as “unmapped”.
>>>>>>>>>>>
>>>>>>>>>>> The migration entry is an invalid CPU page table entry, so it is not a CPU
>>>>>>>>>> split_device_private_folio() is called for device private entry, not migrate entry afaics.
>>>>>>>>> Yes, but from CPU perspective, both device private entry and migration entry
>>>>>>>>> are invalid CPU page table entries, so the device private folio is “unmapped”
>>>>>>>>> at CPU side.
>>>>>>>> Yes both are "swap entries" but there's difference, the device private ones contribute to mapcount and refcount.
>>>>>>> Right. That confused me when I was talking to Balbir and looking at v1.
>>>>>>> When a device private folio is processed in __folio_split(), Balbir needed to
>>>>>>> add code to skip CPU mapping handling code. Basically device private folios are
>>>>>>> CPU unmapped and device mapped.
>>>>>>>
>>>>>>> Here are my questions on device private folios:
>>>>>>> 1. How is mapcount used for device private folios? Why is it needed from CPU
>>>>>>>     perspective? Can it be stored in a device private specific data structure?
>>>>>> Mostly like for normal folios, for instance rmap when doing migrate. I think it would make
>>>>>> common code more messy if not done that way but sure possible.
>>>>>> And not consuming pfns (address space) at all would have benefits.
>>>>>>
>>>>>>> 2. When a device private folio is mapped on device, can someone other than
>>>>>>>     the device driver manipulate it assuming core-mm just skips device private
>>>>>>>     folios (barring the CPU access fault handling)?
>>>>>>>
>>>>>>> Where I am going is that can device private folios be treated as unmapped folios
>>>>>>> by CPU and only device driver manipulates their mappings?
>>>>>>>
>>>>>> Yes not present by CPU but mm has bookkeeping on them. The private page has no content
>>>>>> someone could change while in device, it's just pfn.
>>>>> Just to clarify: a device-private entry, like a device-exclusive entry, is a *page table mapping* tracked through the rmap -- even though they are not present page table entries.
>>>>>
>>>>> It would be better if they would be present page table entries that are PROT_NONE, but it's tricky to mark them as being "special" device-private, device-exclusive etc. Maybe there are ways to do that in the future.
>>>>>
>>>>> Maybe device-private could just be PROT_NONE, because we can identify the entry type based on the folio. device-exclusive is harder ...
>>>>>
>>>>>
>>>>> So consider device-private entries just like PROT_NONE present page table entries. Refcount and mapcount is adjusted accordingly by rmap functions.
>>>> Thanks for the clarification.
>>>>
>>>> So folio_mapcount() for device private folios should be treated the same
>>>> as normal folios, even if the corresponding PTEs are not accessible from CPUs.
>>>> Then I wonder if the device private large folio split should go through
>>>> __folio_split(), the same as normal folios: unmap, freeze, split, unfreeze,
>>>> remap. Otherwise, how can we prevent rmap changes during the split?
>>>>
>>> That is true in general, the special cases I mentioned are:
>>>
>>> 1. split during migration (where we the sizes on source/destination do not
>>>    match) and so we need to split in the middle of migration. The entries
>>>    there are already unmapped and hence the special handling
>>> 2. Partial unmap case, where we need to split in the context of the unmap
>>>    due to the isses mentioned in the patch. I expanded the folio split code
>>>    for device private can be expanded into its own helper, which does not
>>>    need to do the xas/mapped/lru folio handling. During partial unmap the
>>>    original folio does get replaced by new anon rmap ptes (split_huge_pmd_locked)
>>>
>>> For (2), I spent some time examining the implications of not unmapping the
>>> folios prior to split and in the partial unmap path, once we split the PMD
>>> the folios diverge. I did not run into any particular race either with the
>>> tests.
>> 1) is totally fine. This was in v1 and lead to Zi's split_unmapped_folio()
>>
>> 2) is a problem because folio is mapped. split_huge_pmd() can be reached also from other than unmap path.
>> It is vulnerable to races by rmap. And for instance this does not look right without checking:
>>
>>    folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>
> I can add checks to make sure that the call does succeed. 
>
>> You mention 2) is needed because of some later problems in fault path after pmd split. Would it be
>> possible to split the folio at fault time then?
> So after the partial unmap, the folio ends up in a little strange situation, the folio is large,
> but not mapped (since large_mapcount can be 0, after all the folio_rmap_remove_ptes). Calling folio_split()
> on partially unmapped fails because folio_get_anon_vma() fails due to the folio_mapped() failures
> related to folio_large_mapcount. There is also additional complexity with ref counts and mapping.

Is this after the deferred split -> map_unused_to_zeropage flow which would leave the page unmapped? Maybe disable that for device pages?


>
>
>> Also, didn't quite follow what kind of lock recursion did you encounter doing proper split_folio()
>> instead?
>>
>>
> Splitting during partial unmap causes recursive locking issues with anon_vma when invoked from
> split_huge_pmd_locked() path. Deferred splits do not work for device private pages, due to the
> migration requirements for fault handling.
>
> Balbir Singh

--Mika


