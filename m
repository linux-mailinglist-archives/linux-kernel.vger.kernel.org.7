Return-Path: <linux-kernel+bounces-750994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D6B163CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CA45672CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7176D2D9EE3;
	Wed, 30 Jul 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/XgFRyr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0913AA3C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890027; cv=none; b=tEjVbuOBGrKkUmGbsCp4tgxmmknSRIKnI5TvQjADpd0HU1ZoJUmDVXmDrktWT74de5N/QeWS42VE9DHGf55128nZRQG+2R+Pskxd1EpRBbV4h5SR/4nsIWz57eaz1VUY3kgfGSr3o8vgpRdwM+evoEf9ud8GNdR99AIZTzFMGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890027; c=relaxed/simple;
	bh=RAQmfQAP2goAc8Rjuvuv+mAyj4XWLpqkX8/giYekDyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8ZukwB29vkuBTusBOIcQEUE+vk0yy8eOqAUINyYZeHy7OsmqogrR/U5Ziv0HeJR218cpthILBb4kQ0v4UpAiwWJBQeRCGA1FpfB98bsdbXpq++GoIzaliIO2uea/Xb12Sa679GATYhnlEfUOSD5TN42B+H7lQMCgXn7ltvHtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/XgFRyr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753890024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXVJcyzQitkg69HpKmss8HJpY0HtUIPZr8ZaGUiNEY8=;
	b=d/XgFRyrxEcONLXWVi8TUr8Wvxj5FlXancNQ0BNSsaStz8jus5KmoUpp5rf37g7JNmfLL1
	bNTkGhZqJdioQZfPp7a+VkvLT5XhgYMYI1AxChcnpFteNsfClyMzQEUxA8qSVGJwAGrnr7
	VfghjLoc+xJ8enkfODr4N2n+e+3dvU4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-75qiyhjbO9uY5RJAU81dNw-1; Wed, 30 Jul 2025 11:40:23 -0400
X-MC-Unique: 75qiyhjbO9uY5RJAU81dNw-1
X-Mimecast-MFC-AGG-ID: 75qiyhjbO9uY5RJAU81dNw_1753890021
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-557e35aad50so4033545e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753890020; x=1754494820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXVJcyzQitkg69HpKmss8HJpY0HtUIPZr8ZaGUiNEY8=;
        b=ScMNMuNlPsDLshxag9IEE3FKZcpjqNMWUPjIPzLWxY9chMhpTi3YuDtUsTqCRpV9VZ
         rMmUhOACqQ6rRzPbzycDMP270fsqPVsn22CWroF217m7X9/JsZYVxulRbfKv+r/TSAeL
         FHUlt3yJLgj4Ovk9yreEIAiuXQQvFJHFZjG8NmvU/mUkIg9tc4Br0cvkMTtY7tMnue+7
         FeMQ/Oiy/u7ls+vOKyWLw1OYytFAXhS+TOZO+O7Ehxfwnkim6tQBIfnGl9HNEkpBAdKd
         Kv1C8/IB+tkweBrMmdU7AIIJ9EXE/25MIV3feNj0/wPeFQW77mt+RfbP4G1r/evaCZeS
         GTsw==
X-Forwarded-Encrypted: i=1; AJvYcCXlod8YL4uB47i4UasN1IRrOS4oSPxN2HYiYEXKmb/dhMTE66Zr10NjzbajlbKSp7m1FK3fHe7w8T1C6Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQ4tPpVr/+HGRjujn4dkukif4IrgQZ1uumqIbiMbNn9wjSxvq
	goFwR+yaU6NQ5URVyryVyP8AHPo3HzQZQTnO2gH7OCMpEc+LQKKYDMS8A60PAEREZYz2aRbLun+
	l4VsBLy6l4JqJCfT+06rYbXs7y4ltFNnFCMja/XmJ+MGWSzKREOpgWTXWMc6gEU3E
X-Gm-Gg: ASbGncvDL2V4/R0+f1lFizGutnhLpEAnRnH0ocguPAryL5/LNpNJUrV9Pki9eJK3Jy3
	QR/OLyAfCm/+drFhZB6Oc2/upa0yQL5v10hxL0XbUeUKn0UPuMqvumc2ONtvpxHYmQL8ss15yQC
	CftDyldDdzplQhPkuLmBz4jvv657Xwmt5bG94d6djC3TgXqt9lsNhMgY16z9wJw9X3r51CU2Stn
	tiTKYhbm3zjmQGQ6XOVYW3Uu8MHuv0cg00xS9P7of0XJtkdfpbo2BG9RqokVQC4/6fN4N/KLP6T
	b68eLcrsr40qrFmiEtjsaklMxeXmkz/949z3nc0UAOKXDnjHf8qod3tp4hC8ffXvBA==
X-Received: by 2002:a05:6512:1188:b0:553:2668:6f34 with SMTP id 2adb3069b0e04-55b7c07f9ccmr1183034e87.45.1753890020334;
        Wed, 30 Jul 2025 08:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhHAkbosESgOHtK+TLbzZRkJ0+s3tZB6YDIybLt+V9RyMPuHRew80ikAzaLwrE9zZIHOcTgA==
X-Received: by 2002:a05:6512:1188:b0:553:2668:6f34 with SMTP id 2adb3069b0e04-55b7c07f9ccmr1183009e87.45.1753890019823;
        Wed, 30 Jul 2025 08:40:19 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316d9bbsm2197627e87.9.2025.07.30.08.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 08:40:19 -0700 (PDT)
Message-ID: <2308291f-3afc-44b4-bfc9-c6cf0cdd6295@redhat.com>
Date: Wed, 30 Jul 2025 18:40:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
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
 <884b9246-de7c-4536-821f-1bf35efe31c8@redhat.com>
 <6291D401-1A45-4203-B552-79FE26E151E4@nvidia.com>
 <b62234fc-051f-4b2a-b7da-0c0959fb269b@redhat.com>
 <8E2CE1DF-4C37-4690-B968-AEA180FF44A1@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <8E2CE1DF-4C37-4690-B968-AEA180FF44A1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/30/25 18:10, Zi Yan wrote:
> On 30 Jul 2025, at 8:49, Mika Penttilä wrote:
>
>> On 7/30/25 15:25, Zi Yan wrote:
>>> On 30 Jul 2025, at 8:08, Mika Penttilä wrote:
>>>
>>>> On 7/30/25 14:42, Mika Penttilä wrote:
>>>>> On 7/30/25 14:30, Zi Yan wrote:
>>>>>> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>>>>>>
>>>>>>> On 30 Jul 2025, at 7:16, Mika Penttilä wrote:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 7/30/25 12:21, Balbir Singh wrote:
>>>>>>>>> Make THP handling code in the mm subsystem for THP pages aware of zone
>>>>>>>>> device pages. Although the code is designed to be generic when it comes
>>>>>>>>> to handling splitting of pages, the code is designed to work for THP
>>>>>>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>>>>>>
>>>>>>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>>>>>>> entry is present, enabling try_to_migrate() and other code migration
>>>>>>>>> paths to appropriately process the entry. page_vma_mapped_walk() will
>>>>>>>>> return true for zone device private large folios only when
>>>>>>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
>>>>>>>>> not zone device private pages from having to add awareness. The key
>>>>>>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>>>>>>> callbacks page idle, damon use it for setting young/dirty bits, which is
>>>>>>>>> not significant when it comes to pmd level bit harvesting.
>>>>>>>>>
>>>>>>>>> pmd_pfn() does not work well with zone device entries, use
>>>>>>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
>>>>>>>>> entries.
>>>>>>>>>
>>>>>>>>> Zone device private entries when split via munmap go through pmd split,
>>>>>>>>> but need to go through a folio split, deferred split does not work if a
>>>>>>>>> fault is encountered because fault handling involves migration entries
>>>>>>>>> (via folio_migrate_mapping) and the folio sizes are expected to be the
>>>>>>>>> same there. This introduces the need to split the folio while handling
>>>>>>>>> the pmd split. Because the folio is still mapped, but calling
>>>>>>>>> folio_split() will cause lock recursion, the __split_unmapped_folio()
>>>>>>>>> code is used with a new helper to wrap the code
>>>>>>>>> split_device_private_folio(), which skips the checks around
>>>>>>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>>>>>>> folio.
>>>>>>>>>
>>>>>>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>>>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>>>>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>>>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>>>>> ---
>>>>>>>>>  include/linux/huge_mm.h |   1 +
>>>>>>>>>  include/linux/rmap.h    |   2 +
>>>>>>>>>  include/linux/swapops.h |  17 +++
>>>>>>>>>  mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>>>>>>>>>  mm/page_vma_mapped.c    |  13 +-
>>>>>>>>>  mm/pgtable-generic.c    |   6 +
>>>>>>>>>  mm/rmap.c               |  22 +++-
>>>>>>>>>  7 files changed, 278 insertions(+), 51 deletions(-)
>>>>>>>>>
>>>>>>> <snip>
>>>>>>>
>>>>>>>>> +/**
>>>>>>>>> + * split_huge_device_private_folio - split a huge device private folio into
>>>>>>>>> + * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>>>>> + * split folios for pages that are partially mapped
>>>>>>>>> + *
>>>>>>>>> + * @folio: the folio to split
>>>>>>>>> + *
>>>>>>>>> + * The caller has to hold the folio_lock and a reference via folio_get
>>>>>>>>> + */
>>>>>>>>> +int split_device_private_folio(struct folio *folio)
>>>>>>>>> +{
>>>>>>>>> +	struct folio *end_folio = folio_next(folio);
>>>>>>>>> +	struct folio *new_folio;
>>>>>>>>> +	int ret = 0;
>>>>>>>>> +
>>>>>>>>> +	/*
>>>>>>>>> +	 * Split the folio now. In the case of device
>>>>>>>>> +	 * private pages, this path is executed when
>>>>>>>>> +	 * the pmd is split and since freeze is not true
>>>>>>>>> +	 * it is likely the folio will be deferred_split.
>>>>>>>>> +	 *
>>>>>>>>> +	 * With device private pages, deferred splits of
>>>>>>>>> +	 * folios should be handled here to prevent partial
>>>>>>>>> +	 * unmaps from causing issues later on in migration
>>>>>>>>> +	 * and fault handling flows.
>>>>>>>>> +	 */
>>>>>>>>> +	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>>> Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?
>>>>>>> Based on my off-list conversation with Balbir, the folio is unmapped in
>>>>>>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>>>>>>> device side mapping.
>>>>>> Maybe we should make it aware of device private mapping? So that the
>>>>>> process mirrors CPU side folio split: 1) unmap device private mapping,
>>>>>> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
>>>>>> 5) remap device private mapping.
>>>>> Ah ok this was about device private page obviously here, nevermind..
>>>> Still, isn't this reachable from split_huge_pmd() paths and folio is mapped to CPU page tables as a huge device page by one or more task?
>>> The folio only has migration entries pointing to it. From CPU perspective,
>>> it is not mapped. The unmap_folio() used by __folio_split() unmaps a to-be-split
>>> folio by replacing existing page table entries with migration entries
>>> and after that the folio is regarded as “unmapped”.
>>>
>>> The migration entry is an invalid CPU page table entry, so it is not a CPU
>> split_device_private_folio() is called for device private entry, not migrate entry afaics.
> Yes, but from CPU perspective, both device private entry and migration entry
> are invalid CPU page table entries, so the device private folio is “unmapped”
> at CPU side.

Yes both are "swap entries" but there's difference, the device private ones contribute to mapcount and refcount.

Also which might confuse is that v1 of the series had only 
  migrate_vma_split_pages()
which operated only on truly unmapped (mapcount wise) folios. Which was a motivation for split_unmapped_folio()..
Now, 
  split_device_private_folio()
operates on mapcount != 0 folios.

>
>
>> And it is called from split_huge_pmd() with freeze == false, not from folio split but pmd split.
> I am not sure that is the right timing of splitting a folio. The device private
> folio can be kept without splitting at split_huge_pmd() time.

Yes this doesn't look quite right, and also
+	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));

looks suspicious

Maybe split_device_private_folio() tries to solve some corner case but maybe good to elaborate
more the exact conditions, there might be a better fix.

>
> But from CPU perspective, a device private folio has no CPU mapping, no other
> CPU can access or manipulate the folio. It should be OK to split it.
>
>>> mapping, IIUC.
>>>
>>>>>>>>> +	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>>>>>>> Confusing to  __split_unmapped_folio() if folio is mapped...
>>>>>>> From driver point of view, __split_unmapped_folio() probably should be renamed
>>>>>>> to __split_cpu_unmapped_folio(), since it is only dealing with CPU side
>>>>>>> folio meta data for split.
>>>>>>>
>>>>>>>
>>>>>>> Best Regards,
>>>>>>> Yan, Zi
>>>>>> Best Regards,
>>>>>> Yan, Zi
>>>>>>
>>>> --Mika
>>> Best Regards,
>>> Yan, Zi
>>>
>> --Mika
>
> Best Regards,
> Yan, Zi
>
--Mika



