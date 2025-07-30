Return-Path: <linux-kernel+bounces-750696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5AEB15FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698F618C55DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA15293B73;
	Wed, 30 Jul 2025 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzrPp96s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25242874F2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753877336; cv=none; b=NMCkEVJL5LEZ57R3Lq6uwsV0thbr6s8tLwMThLnthXk/UlB4dq19+2nGx9TmyWVhf7y9Uo7IVarVOKUt98o7ohAMBP4iOBqxR6gtLaKL3OwxLDEIkg2y4wxxul3XLtTtNib9LKsloGE4SOsZpZJwfwDu5/NSi2zGhN4b4WenIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753877336; c=relaxed/simple;
	bh=n4E3dSdFCN4QVczwtCanSQYTzz7QT00QqO2Qi4tubSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gY9x92tXmhstIIqQSzKPKFUGndAM0CvWnOIR6f+gZTptjlmTDXDPV8ANGyg0TZ4guRMBcvtioLPXUXMjMPpg1V5i50ppQljiSHYffn+jxR/m4HdAbecZp0T1KVHTzm/7MUlRRMjRajiN6euJJ+7h180LLFnO6Qhxm+PnnZdeFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzrPp96s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753877333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zayXxjXOJyhWgrxS4M7tAq9Of6SpcSVV6owXdHf3Lo=;
	b=XzrPp96smXgqeMQePrElxobZJGnTAYMopJJJLa/jjfuSWMPiSDuG7Aq0pZxNuNzCNi/LyU
	dTJCedwBFTAz38fcXeEzqZqmARZhcIFC52ZefiB2265He2akt7RL5kDODV5qNA/Wg7S993
	HubpfeD9sd7P6lEissY9bpjgdO64hWw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-DxwQJNTFPzGVolFVwBbTYQ-1; Wed, 30 Jul 2025 08:08:51 -0400
X-MC-Unique: DxwQJNTFPzGVolFVwBbTYQ-1
X-Mimecast-MFC-AGG-ID: DxwQJNTFPzGVolFVwBbTYQ_1753877329
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-55b823523a9so307446e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753877329; x=1754482129;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zayXxjXOJyhWgrxS4M7tAq9Of6SpcSVV6owXdHf3Lo=;
        b=Nr1dc2kCfTicST5PfLYL2d9fllUEuDkA246aU5fomE2OgtmMeSRUWBbp57FUWLocqy
         CgNRONtyoHcpMtiTT6tpbzrpEAy0u3igjRmDDIw5USHepJXg6EGAXGh+I/jFrBV9VhfP
         Bo1gRIL9aEyaO6UnzTvvnj0tywDm12OFKP2LcXCkILVdKb++7Bd6Dy0T1OhbBnoQERpQ
         +R5VFg8OLSy0KcU+M9eRVBehErMgjCZh3hS2RsGTh8SdLLdBgfUFND75zKH8KxygGsch
         WkpNKaAg4x+iUys68w6+gPRmQkiXXWn5s6acGNeX9VuoAO94LGnMcglLkN9UZm6oXKY9
         UbOw==
X-Forwarded-Encrypted: i=1; AJvYcCXuQQ3DPpnpQuJ+2+x2kyd2KYEqAe4aPsQ+dLnT6vrpscSCsxF5rbOmQiS1NwCG3h/2GWulL1GJkkNNeJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxziJS5NKZSmOqcopsisGxxJReEKS06V004brvhocMcwQ4yq9x1
	0avA9LMYv0P4EQaYSsdL7eypXKLeKGmIorv64kmbZzcEyDhkGW9AX6NXaHcfwiMbdl/T9bv5zZU
	gxLTmbFoOPLUD771PGMCGu18H3PwlNpcvMEJAx7cmovEL6LB9X8CHxbsNr/+0ibq1
X-Gm-Gg: ASbGncsw8a7vbbxa2OyXct6GeFOWMQtl9Ogow9VvDX6udUyp6jz/mY0+/+e0PpMhY4x
	Db0jRtC0JhtuzKg3Kv0cNre7IxMdj5hJ//OKFEjygDUcDjjXWj2vKNn/YYWQpzoyQuKULPm9D/O
	PgyUFNqbnyQQjmNQ7/prv2t0qg7HLTLJomma3sTix2kmrPmQeYPSwgElbP2rEbgKmD9vUmKIfGf
	mzypJEzQTiwHFX9h61A1iIgYunzKuVWUyV8o4AgBFgf96nWtQJe1AJzIDSlIxW3Z/r3a13VweRF
	62h2WfLQ72LxMJVgdQ+JksOLw02b0TFqvYekrAEuIea1kkkH3fW1xIt5mhnwwwAehQ==
X-Received: by 2002:a05:6512:3c84:b0:55b:2242:a9c1 with SMTP id 2adb3069b0e04-55b7c089e2bmr964218e87.49.1753877329122;
        Wed, 30 Jul 2025 05:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvIhc4qMQOPIbpnZe14iwXH/4Cx+G2ep9eLTTzMWEJn+T/HUl1X158JOxA2msrN/fq149EBA==
X-Received: by 2002:a05:6512:3c84:b0:55b:2242:a9c1 with SMTP id 2adb3069b0e04-55b7c089e2bmr964196e87.49.1753877328627;
        Wed, 30 Jul 2025 05:08:48 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63393c72sm2127002e87.178.2025.07.30.05.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:08:48 -0700 (PDT)
Message-ID: <884b9246-de7c-4536-821f-1bf35efe31c8@redhat.com>
Date: Wed, 30 Jul 2025 15:08:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
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
Content-Language: en-US
In-Reply-To: <9f836828-4f53-41a0-b5f7-bbcd2084086e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/30/25 14:42, Mika Penttilä wrote:
> On 7/30/25 14:30, Zi Yan wrote:
>> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>>
>>> On 30 Jul 2025, at 7:16, Mika Penttilä wrote:
>>>
>>>> Hi,
>>>>
>>>> On 7/30/25 12:21, Balbir Singh wrote:
>>>>> Make THP handling code in the mm subsystem for THP pages aware of zone
>>>>> device pages. Although the code is designed to be generic when it comes
>>>>> to handling splitting of pages, the code is designed to work for THP
>>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>>
>>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>>> entry is present, enabling try_to_migrate() and other code migration
>>>>> paths to appropriately process the entry. page_vma_mapped_walk() will
>>>>> return true for zone device private large folios only when
>>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
>>>>> not zone device private pages from having to add awareness. The key
>>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>>> callbacks page idle, damon use it for setting young/dirty bits, which is
>>>>> not significant when it comes to pmd level bit harvesting.
>>>>>
>>>>> pmd_pfn() does not work well with zone device entries, use
>>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
>>>>> entries.
>>>>>
>>>>> Zone device private entries when split via munmap go through pmd split,
>>>>> but need to go through a folio split, deferred split does not work if a
>>>>> fault is encountered because fault handling involves migration entries
>>>>> (via folio_migrate_mapping) and the folio sizes are expected to be the
>>>>> same there. This introduces the need to split the folio while handling
>>>>> the pmd split. Because the folio is still mapped, but calling
>>>>> folio_split() will cause lock recursion, the __split_unmapped_folio()
>>>>> code is used with a new helper to wrap the code
>>>>> split_device_private_folio(), which skips the checks around
>>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>>> folio.
>>>>>
>>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>>
>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>> ---
>>>>>  include/linux/huge_mm.h |   1 +
>>>>>  include/linux/rmap.h    |   2 +
>>>>>  include/linux/swapops.h |  17 +++
>>>>>  mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>>>>>  mm/page_vma_mapped.c    |  13 +-
>>>>>  mm/pgtable-generic.c    |   6 +
>>>>>  mm/rmap.c               |  22 +++-
>>>>>  7 files changed, 278 insertions(+), 51 deletions(-)
>>>>>
>>> <snip>
>>>
>>>>> +/**
>>>>> + * split_huge_device_private_folio - split a huge device private folio into
>>>>> + * smaller pages (of order 0), currently used by migrate_device logic to
>>>>> + * split folios for pages that are partially mapped
>>>>> + *
>>>>> + * @folio: the folio to split
>>>>> + *
>>>>> + * The caller has to hold the folio_lock and a reference via folio_get
>>>>> + */
>>>>> +int split_device_private_folio(struct folio *folio)
>>>>> +{
>>>>> +	struct folio *end_folio = folio_next(folio);
>>>>> +	struct folio *new_folio;
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	/*
>>>>> +	 * Split the folio now. In the case of device
>>>>> +	 * private pages, this path is executed when
>>>>> +	 * the pmd is split and since freeze is not true
>>>>> +	 * it is likely the folio will be deferred_split.
>>>>> +	 *
>>>>> +	 * With device private pages, deferred splits of
>>>>> +	 * folios should be handled here to prevent partial
>>>>> +	 * unmaps from causing issues later on in migration
>>>>> +	 * and fault handling flows.
>>>>> +	 */
>>>>> +	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>> Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?
>>> Based on my off-list conversation with Balbir, the folio is unmapped in
>>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>>> device side mapping.
>> Maybe we should make it aware of device private mapping? So that the
>> process mirrors CPU side folio split: 1) unmap device private mapping,
>> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
>> 5) remap device private mapping.
> Ah ok this was about device private page obviously here, nevermind..

Still, isn't this reachable from split_huge_pmd() paths and folio is mapped to CPU page tables as a huge device page by one or more task?

>
>>>>> +	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>>> Confusing to  __split_unmapped_folio() if folio is mapped...
>>> From driver point of view, __split_unmapped_folio() probably should be renamed
>>> to __split_cpu_unmapped_folio(), since it is only dealing with CPU side
>>> folio meta data for split.
>>>
>>>
>>> Best Regards,
>>> Yan, Zi
>> Best Regards,
>> Yan, Zi
>>

--Mika



