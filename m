Return-Path: <linux-kernel+bounces-753092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46408B17E89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F26B7B7ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006DD21D3DF;
	Fri,  1 Aug 2025 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVy0QlrA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C876217666
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037972; cv=none; b=BGs3eL5TS65eIgiXj9CXgiz1UqEERtxG+cgZXFmnngc4EZYEczCa8G39KZEdcEcClSS4EGYe8BW3l1NeuPHTYuQRqClwvw4WVUx6ZAJaiNL9oJQEYYG5ZESNY7TqB560CCXscMdKGqvX8QRsWqNcEBKK3JCwM5CgN/abQ/+5mG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037972; c=relaxed/simple;
	bh=PxPUfaSND4weaeX8YhaFlNv1I31RohpeMff9zvm+bAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTpTXCo13KoX3l1egLszjpJGz38NfZUxHmU3nXx0v+aHKrS+VOik5keD4iWO9+km0njNvbzXxU1/30SRhAzKiVDnU7geSXLP0LAJz17VTcvfVcY1KOCWUnP7uHq7ik/EPGff++iysv9qC9kiIOzE2kIaqWVdOB0uWb+UdFrFu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVy0QlrA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754037969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tNATn/2ugWZyna25jbAUNk6dcj83Uqk5tOZ9+X6G0VY=;
	b=MVy0QlrA5hrwYD88avMgqd3EbOG7QDyifEvKxS+4z0MbLqB6ReAzXdMh0x9N//8pDbglik
	9BI4FgzJLQ1+c8NlPgMesISsH17n39G0nis4V+UWATRUMtbSqLiJdSgXyLEEUn9EmPxtNs
	kU5mb652gbTiotmHpWccxOVFmOBrKRY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-lTsXkpRUNJyN3qIQBf-KUg-1; Fri, 01 Aug 2025 04:46:07 -0400
X-MC-Unique: lTsXkpRUNJyN3qIQBf-KUg-1
X-Mimecast-MFC-AGG-ID: lTsXkpRUNJyN3qIQBf-KUg_1754037966
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7806a620cso842171f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037966; x=1754642766;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNATn/2ugWZyna25jbAUNk6dcj83Uqk5tOZ9+X6G0VY=;
        b=GOobAdvV6CgDhrldYdV6VVh/XaIZwgqdmUJWoQAQMtZOo4nWtS3S7R7w09wNp9EFLy
         Opz9cB46BSq4KunVojDKt+hHCBFjIx/Ry7K/yc28mKqpQfLRvftvKmV1Q1xf99JxFE/z
         kv13yWdBDxxwrnAMWcR7HJ0DGYdJLvchMHaQmXP8RGVHv115+O1m5kIv6gEqZ0PBzvef
         IVvlN+u3C4tOeUw5p6vPKst7/HituWswAXm3aCO2kwiJZJVlJUspU0c/PIOddmfljF29
         1rTpnfp6FpC34Fk/C2THKs6rLz6PapV+AQ/24vw2iiVAVWYznkA2sn3sr79zjGS6NL+B
         q+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfoxRtjkmqEBC4wnkeVXW+JngWCSUO8mD60on6ZzwJjIn1xjBm8wUB/dYsPl9qFGDAZ/JwMPRbClnW0TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4L+5ksIg2+L+cuCo1xwgYVGNT06xg+MdXPitm5pHrUxoemufS
	SUqcCLshTn34dmWCj5Kb93G+4LerJWNJje/KxqaDMaSo6/X2eyI1lReb+UNEZrLernHLqcPP6bV
	2BAT7wxWUOH+v4AiHv9E9VRtbCXbWz4d8xFnlJpy9rN8KTkOBVD6po6yKzqjUCaplRA==
X-Gm-Gg: ASbGncsQpc2lpgRi1WtuETTv4NYY7kWFsih2YzGqlRNz4zuNBi3TxmZjBDYi2NeHc9S
	4UI5BVEq3PX8pps3qdf1sPjOyrAVKkqM5ezurAjzAxsoOv8oZN2VCsIlF05Kt7TtOHj1z7x0/T7
	jOkMeGdfhGL9Oghm/TyW4MhzszinMGP3+6imWQi2HeqHxqavpWlefmd6h7LqnK8q5CPJu59Jq0A
	a3P3gCJuEFkhHUcwGZdE/+uz7aaQL50fVgrnb6XjPO8qUJ+NZaQzPJ57LdUyPir01dmlpjBgBgC
	y0859t81FuXDNRDwx/HcvhLC9Z5qp2MW6iSeVM2nhgCs+x+1yRyLmqjkUvZX31T93uBGGGz0FvL
	68w/HCJUIlpwJcIk5CrJzDwwy1S4N9jVGa0rK5fzBklihyTtt3ZCTs+1zpEZJ3oic
X-Received: by 2002:a05:6000:2f82:b0:3a4:df80:7284 with SMTP id ffacd0b85a97d-3b794fe4d15mr9138124f8f.1.1754037966363;
        Fri, 01 Aug 2025 01:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXFVRt7bblgfIPcovk2KkwivUnfrwtgK68+lmPJEclvTLGX9kjUiCuLPhGN4CHtx1sKjDy+Q==
X-Received: by 2002:a05:6000:2f82:b0:3a4:df80:7284 with SMTP id ffacd0b85a97d-3b794fe4d15mr9138082f8f.1.1754037965753;
        Fri, 01 Aug 2025 01:46:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf93dsm5098971f8f.27.2025.08.01.01.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:46:05 -0700 (PDT)
Message-ID: <ee06bd19-4831-493f-ae88-f1d8a2fe9fa4@redhat.com>
Date: Fri, 1 Aug 2025 10:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
To: Balbir Singh <balbirs@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Zi Yan <ziy@nvidia.com>
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
 <edbe38d4-3489-4c83-80fb-dc96a7684294@redhat.com>
 <e8f867cf-67f1-413a-a775-835a32861164@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <e8f867cf-67f1-413a-a775-835a32861164@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.08.25 10:01, Balbir Singh wrote:
> On 8/1/25 17:04, David Hildenbrand wrote:
>> On 01.08.25 06:44, Balbir Singh wrote:
>>> On 8/1/25 11:16, Mika Penttilä wrote:
>>>> Hi,
>>>>
>>>> On 8/1/25 03:49, Balbir Singh wrote:
>>>>
>>>>> On 7/31/25 21:26, Zi Yan wrote:
>>>>>> On 31 Jul 2025, at 3:15, David Hildenbrand wrote:
>>>>>>
>>>>>>> On 30.07.25 18:29, Mika Penttilä wrote:
>>>>>>>> On 7/30/25 18:58, Zi Yan wrote:
>>>>>>>>> On 30 Jul 2025, at 11:40, Mika Penttilä wrote:
>>>>>>>>>
>>>>>>>>>> On 7/30/25 18:10, Zi Yan wrote:
>>>>>>>>>>> On 30 Jul 2025, at 8:49, Mika Penttilä wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 7/30/25 15:25, Zi Yan wrote:
>>>>>>>>>>>>> On 30 Jul 2025, at 8:08, Mika Penttilä wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 7/30/25 14:42, Mika Penttilä wrote:
>>>>>>>>>>>>>>> On 7/30/25 14:30, Zi Yan wrote:
>>>>>>>>>>>>>>>> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 30 Jul 2025, at 7:16, Mika Penttilä wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On 7/30/25 12:21, Balbir Singh wrote:
>>>>>>>>>>>>>>>>>>> Make THP handling code in the mm subsystem for THP pages aware of zone
>>>>>>>>>>>>>>>>>>> device pages. Although the code is designed to be generic when it comes
>>>>>>>>>>>>>>>>>>> to handling splitting of pages, the code is designed to work for THP
>>>>>>>>>>>>>>>>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>>>>>>>>>>>>>>>>> entry is present, enabling try_to_migrate() and other code migration
>>>>>>>>>>>>>>>>>>> paths to appropriately process the entry. page_vma_mapped_walk() will
>>>>>>>>>>>>>>>>>>> return true for zone device private large folios only when
>>>>>>>>>>>>>>>>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
>>>>>>>>>>>>>>>>>>> not zone device private pages from having to add awareness. The key
>>>>>>>>>>>>>>>>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>>>>>>>>>>>>>>>>> callbacks page idle, damon use it for setting young/dirty bits, which is
>>>>>>>>>>>>>>>>>>> not significant when it comes to pmd level bit harvesting.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> pmd_pfn() does not work well with zone device entries, use
>>>>>>>>>>>>>>>>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
>>>>>>>>>>>>>>>>>>> entries.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Zone device private entries when split via munmap go through pmd split,
>>>>>>>>>>>>>>>>>>> but need to go through a folio split, deferred split does not work if a
>>>>>>>>>>>>>>>>>>> fault is encountered because fault handling involves migration entries
>>>>>>>>>>>>>>>>>>> (via folio_migrate_mapping) and the folio sizes are expected to be the
>>>>>>>>>>>>>>>>>>> same there. This introduces the need to split the folio while handling
>>>>>>>>>>>>>>>>>>> the pmd split. Because the folio is still mapped, but calling
>>>>>>>>>>>>>>>>>>> folio_split() will cause lock recursion, the __split_unmapped_folio()
>>>>>>>>>>>>>>>>>>> code is used with a new helper to wrap the code
>>>>>>>>>>>>>>>>>>> split_device_private_folio(), which skips the checks around
>>>>>>>>>>>>>>>>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>>>>>>>>>>>>>>>>> folio.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>>>>>>>>>>>>>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>>>>>>>>>>>>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>>>>>>>>>>>>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>>>>>>>>>>>>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>>>>>>>>>>>>>>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>>>>>>>>>>>>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>>>>>>>>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>>>>>>>>>>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>>>>>>>>>>>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>>>>>>>>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>>>>>>>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>>>>>>>>>>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>>>>>>>>>>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>>>>>>>>>>>>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>>>>>>>>>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>>>>>>>>>>>>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>>>>>>>>>>>>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>>>>>>>>>>>>>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>>>>>>>>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>>>>>>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>>>>>>>>>>>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>>>>>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>     include/linux/huge_mm.h |   1 +
>>>>>>>>>>>>>>>>>>>     include/linux/rmap.h    |   2 +
>>>>>>>>>>>>>>>>>>>     include/linux/swapops.h |  17 +++
>>>>>>>>>>>>>>>>>>>     mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>>>>>>>>>>>>>>>>>>>     mm/page_vma_mapped.c    |  13 +-
>>>>>>>>>>>>>>>>>>>     mm/pgtable-generic.c    |   6 +
>>>>>>>>>>>>>>>>>>>     mm/rmap.c               |  22 +++-
>>>>>>>>>>>>>>>>>>>     7 files changed, 278 insertions(+), 51 deletions(-)
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> <snip>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> +/**
>>>>>>>>>>>>>>>>>>> + * split_huge_device_private_folio - split a huge device private folio into
>>>>>>>>>>>>>>>>>>> + * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>>>>>>>>>>>>>>> + * split folios for pages that are partially mapped
>>>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>>>> + * @folio: the folio to split
>>>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>>>> + * The caller has to hold the folio_lock and a reference via folio_get
>>>>>>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>>>>>>> +int split_device_private_folio(struct folio *folio)
>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>> +    struct folio *end_folio = folio_next(folio);
>>>>>>>>>>>>>>>>>>> +    struct folio *new_folio;
>>>>>>>>>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    /*
>>>>>>>>>>>>>>>>>>> +     * Split the folio now. In the case of device
>>>>>>>>>>>>>>>>>>> +     * private pages, this path is executed when
>>>>>>>>>>>>>>>>>>> +     * the pmd is split and since freeze is not true
>>>>>>>>>>>>>>>>>>> +     * it is likely the folio will be deferred_split.
>>>>>>>>>>>>>>>>>>> +     *
>>>>>>>>>>>>>>>>>>> +     * With device private pages, deferred splits of
>>>>>>>>>>>>>>>>>>> +     * folios should be handled here to prevent partial
>>>>>>>>>>>>>>>>>>> +     * unmaps from causing issues later on in migration
>>>>>>>>>>>>>>>>>>> +     * and fault handling flows.
>>>>>>>>>>>>>>>>>>> +     */
>>>>>>>>>>>>>>>>>>> +    folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>>>>>>>>>>>>> Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?
>>>>>>>>>>>>>>>>> Based on my off-list conversation with Balbir, the folio is unmapped in
>>>>>>>>>>>>>>>>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>>>>>>>>>>>>>>>>> device side mapping.
>>>>>>>>>>>>>>>> Maybe we should make it aware of device private mapping? So that the
>>>>>>>>>>>>>>>> process mirrors CPU side folio split: 1) unmap device private mapping,
>>>>>>>>>>>>>>>> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
>>>>>>>>>>>>>>>> 5) remap device private mapping.
>>>>>>>>>>>>>>> Ah ok this was about device private page obviously here, nevermind..
>>>>>>>>>>>>>> Still, isn't this reachable from split_huge_pmd() paths and folio is mapped to CPU page tables as a huge device page by one or more task?
>>>>>>>>>>>>> The folio only has migration entries pointing to it. From CPU perspective,
>>>>>>>>>>>>> it is not mapped. The unmap_folio() used by __folio_split() unmaps a to-be-split
>>>>>>>>>>>>> folio by replacing existing page table entries with migration entries
>>>>>>>>>>>>> and after that the folio is regarded as “unmapped”.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The migration entry is an invalid CPU page table entry, so it is not a CPU
>>>>>>>>>>>> split_device_private_folio() is called for device private entry, not migrate entry afaics.
>>>>>>>>>>> Yes, but from CPU perspective, both device private entry and migration entry
>>>>>>>>>>> are invalid CPU page table entries, so the device private folio is “unmapped”
>>>>>>>>>>> at CPU side.
>>>>>>>>>> Yes both are "swap entries" but there's difference, the device private ones contribute to mapcount and refcount.
>>>>>>>>> Right. That confused me when I was talking to Balbir and looking at v1.
>>>>>>>>> When a device private folio is processed in __folio_split(), Balbir needed to
>>>>>>>>> add code to skip CPU mapping handling code. Basically device private folios are
>>>>>>>>> CPU unmapped and device mapped.
>>>>>>>>>
>>>>>>>>> Here are my questions on device private folios:
>>>>>>>>> 1. How is mapcount used for device private folios? Why is it needed from CPU
>>>>>>>>>       perspective? Can it be stored in a device private specific data structure?
>>>>>>>> Mostly like for normal folios, for instance rmap when doing migrate. I think it would make
>>>>>>>> common code more messy if not done that way but sure possible.
>>>>>>>> And not consuming pfns (address space) at all would have benefits.
>>>>>>>>
>>>>>>>>> 2. When a device private folio is mapped on device, can someone other than
>>>>>>>>>       the device driver manipulate it assuming core-mm just skips device private
>>>>>>>>>       folios (barring the CPU access fault handling)?
>>>>>>>>>
>>>>>>>>> Where I am going is that can device private folios be treated as unmapped folios
>>>>>>>>> by CPU and only device driver manipulates their mappings?
>>>>>>>>>
>>>>>>>> Yes not present by CPU but mm has bookkeeping on them. The private page has no content
>>>>>>>> someone could change while in device, it's just pfn.
>>>>>>> Just to clarify: a device-private entry, like a device-exclusive entry, is a *page table mapping* tracked through the rmap -- even though they are not present page table entries.
>>>>>>>
>>>>>>> It would be better if they would be present page table entries that are PROT_NONE, but it's tricky to mark them as being "special" device-private, device-exclusive etc. Maybe there are ways to do that in the future.
>>>>>>>
>>>>>>> Maybe device-private could just be PROT_NONE, because we can identify the entry type based on the folio. device-exclusive is harder ...
>>>>>>>
>>>>>>>
>>>>>>> So consider device-private entries just like PROT_NONE present page table entries. Refcount and mapcount is adjusted accordingly by rmap functions.
>>>>>> Thanks for the clarification.
>>>>>>
>>>>>> So folio_mapcount() for device private folios should be treated the same
>>>>>> as normal folios, even if the corresponding PTEs are not accessible from CPUs.
>>>>>> Then I wonder if the device private large folio split should go through
>>>>>> __folio_split(), the same as normal folios: unmap, freeze, split, unfreeze,
>>>>>> remap. Otherwise, how can we prevent rmap changes during the split?
>>>>>>
>>>>> That is true in general, the special cases I mentioned are:
>>>>>
>>>>> 1. split during migration (where we the sizes on source/destination do not
>>>>>      match) and so we need to split in the middle of migration. The entries
>>>>>      there are already unmapped and hence the special handling
>>>>> 2. Partial unmap case, where we need to split in the context of the unmap
>>>>>      due to the isses mentioned in the patch. I expanded the folio split code
>>>>>      for device private can be expanded into its own helper, which does not
>>>>>      need to do the xas/mapped/lru folio handling. During partial unmap the
>>>>>      original folio does get replaced by new anon rmap ptes (split_huge_pmd_locked)
>>>>>
>>>>> For (2), I spent some time examining the implications of not unmapping the
>>>>> folios prior to split and in the partial unmap path, once we split the PMD
>>>>> the folios diverge. I did not run into any particular race either with the
>>>>> tests.
>>>>
>>>> 1) is totally fine. This was in v1 and lead to Zi's split_unmapped_folio()
>>>>
>>>> 2) is a problem because folio is mapped. split_huge_pmd() can be reached also from other than unmap path.
>>>> It is vulnerable to races by rmap. And for instance this does not look right without checking:
>>>>
>>>>      folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>
>>>
>>> I can add checks to make sure that the call does succeed.
>>>
>>>> You mention 2) is needed because of some later problems in fault path after pmd split. Would it be
>>>> possible to split the folio at fault time then?
>>>
>>> So after the partial unmap, the folio ends up in a little strange situation, the folio is large,
>>> but not mapped (since large_mapcount can be 0, after all the folio_rmap_remove_ptes). Calling folio_split()
>>> on partially unmapped fails because folio_get_anon_vma() fails due to the folio_mapped() failures
>>> related to folio_large_mapcount. There is also additional complexity with ref counts and mapping.
>>
>> I think you mean "Calling folio_split() on a *fully* unmapped folio fails ..."
>>
>> A partially mapped folio still has folio_mapcount() > 0 -> folio_mapped() == true.
>>
> 
> Looking into this again at my end
> 
>>>
>>>
>>>> Also, didn't quite follow what kind of lock recursion did you encounter doing proper split_folio()
>>>> instead?
>>>>
>>>>
>>>
>>> Splitting during partial unmap causes recursive locking issues with anon_vma when invoked from
>>> split_huge_pmd_locked() path.
>>
>> Yes, that's very complicated.
>>
> 
> Yes and I want to avoid going down that path.
> 
>>> Deferred splits do not work for device private pages, due to the
>>> migration requirements for fault handling.
>>
>> Can you elaborate on that?
>>
> 
> If a folio is under deferred_split() and is still pending a split. When a fault is handled on a partially
> mapped folio, the expectation is that as a part of fault handling during migration, the code in migrate_folio_mapping()
> assumes that the folio sizes are the same (via check for reference and mapcount)

If you hit a partially-mapped folio, instead of migrating, you would 
actually want to split and then migrate I assume.

-- 
Cheers,

David / dhildenb


