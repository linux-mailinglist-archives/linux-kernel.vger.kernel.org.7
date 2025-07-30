Return-Path: <linux-kernel+bounces-750677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DDB15F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D982B18C7ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3E2900A4;
	Wed, 30 Jul 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3zWdUJg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE712B73
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875732; cv=none; b=cxP+UtoPvTptA1MbhTlBTNn7nrLXrnW1yUTe/73b+5di6LnCHnHfz99v9nfFlHn4ZLuLfjvorCzcELQ6UJB56grfqnYKlh9iG8qcyoeymLx7JMso8KUz9DluE3c22OPbvpzGXqYCicAUCsSzHtVT8Oyp+WH+2FCuPL+RGzH38Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875732; c=relaxed/simple;
	bh=svoiyIe4mX7cybblQlOO7dyigj3+dz6Odm8O6l/VPLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpqMvZkTkbpcfFUq6KMqLvcLM0AJEF0AJLtso+MshOSUIGYsuNlzGBKOiCWtCi5jgxqxGkcMHYUMclkENmTvm+D0izjhj12d2JjT6XePkzOKGltlGnDCCoWTavoCgmh9D4CKqm29iXAknXjvFuAKK96SVbsim4cFXI5D0YBzRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3zWdUJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753875729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6VJryhEVMx1lwOdZs4jCrrpFWzvXShieQVAVyEHU5c=;
	b=K3zWdUJgd1dlPHruGtBWYecB6sa/V+nv1mSZudBhNFEOksO/0BY9FcQRGkQM+Jxq/7sUFE
	vM+9alKCzb5bP3VuDtP/bN+mYYPY6GsSWNANTj3IONLi/FkWHKtUm4mkXgjvLY4bHWbq6W
	t8MwnnWVJ2LboMT7exynpARGvR4ooOc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-7w99EMt3MX-Pcm_fZu57Sw-1; Wed, 30 Jul 2025 07:42:07 -0400
X-MC-Unique: 7w99EMt3MX-Pcm_fZu57Sw-1
X-Mimecast-MFC-AGG-ID: 7w99EMt3MX-Pcm_fZu57Sw_1753875726
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3322b8dfb91so2657111fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753875726; x=1754480526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6VJryhEVMx1lwOdZs4jCrrpFWzvXShieQVAVyEHU5c=;
        b=ol38x2sWoPr5l2FKi+CfMwG5E6Fy/tyMfsYcsCv5LAytg2g98NuefqR0Uw0RKAZQGe
         wR2mivT/5jsg4zuBQYLsa3YOUgAWQL1IpKV18PwqJQWhhVVJMj5/2MsQdCWmt2jd/05V
         FTzyo6tsRMmxykuEsDxacyUAfJAFnBkmQKK+lwLNc3NGABIuqm/ID1jSbaJYe/Q4ZO03
         4cfGjTrAIwQ/Y3dg6Uizep+WaXUCmXFaZvMl/bRTWzOArRimWHok1+KIedfhgnZxDufd
         +zVMfzQN5cKXfJtDh8G6f1CeOTL1Nfr2f1mDTMMMPERxWNXQgsNxuvTKeJDADESFIAgg
         Tifw==
X-Forwarded-Encrypted: i=1; AJvYcCW+u4X1KLF8Owg0ctETOV1M8vz1LpohKxghz1TlKvSmQZRsAc+KCWvB2jTY87FjFuVHJG2AQwx3XtSvSGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvgVgVh2eWFToXI92//d7RumJlg8n9JM8eK/JnLgX2WYNvl5G
	X9MlEePkR5S4viPj+TMOtLGtm7ie+IdHy8INvVYSCIDvGYfiEmqOE8M28LJF6+e96vZ0jyw0K6o
	TIfWc3fpgRdYQqoM2cdFBKxQT+1HI5UF3KpsBagQeudbx+R/A/yPQGPhu4SNGZv0e
X-Gm-Gg: ASbGncu5Ew7642pb4saY4mI9Q3+o+DisHz53LjANknkxDYpdKhmvhG+U2O4QPyfFHrV
	i0yqbzS7PfqdA7UmUVTBnbn6LlupOhkaLM1gmDKL7L9/jSQKlEKU1KUsIv5K2YTtkSIhlhG+1Mu
	w7rx6YwhRwYOaDFjzHN8WDP7HqjzrQUALej38GxJnRgnJM5VNbDqmO5SSMH8NlkRxbE3g200Xjm
	VqSTSBB8qpLhtVMuygj8vbSx6Zhn1Vam4rpBzYG0Ygr209TvvzVqFRZiCtMegZj+4mQUM/lifHo
	qiP+rinsBQz8xstdeWCFAvvHyYqliwLvr7NUkvklQLytjZRHay5b6Q1a+/oL23Ompw==
X-Received: by 2002:a2e:b88b:0:b0:32b:9e00:1237 with SMTP id 38308e7fff4ca-33224be10b7mr10327311fa.32.1753875726172;
        Wed, 30 Jul 2025 04:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs9ngHPB+tu/9eDEWrFOEnZfpKYOAMZyv8bEY/A9NAiVGysSSEIhOPDSQM7MiLIqxglBjJUA==
X-Received: by 2002:a2e:b88b:0:b0:32b:9e00:1237 with SMTP id 38308e7fff4ca-33224be10b7mr10327111fa.32.1753875725689;
        Wed, 30 Jul 2025 04:42:05 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4235880sm19577641fa.58.2025.07.30.04.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:42:05 -0700 (PDT)
Message-ID: <9f836828-4f53-41a0-b5f7-bbcd2084086e@redhat.com>
Date: Wed, 30 Jul 2025 14:42:04 +0300
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <F60614E1-28D1-466B-A434-7FF1061B0778@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/30/25 14:30, Zi Yan wrote:
> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>
>> On 30 Jul 2025, at 7:16, Mika Penttilä wrote:
>>
>>> Hi,
>>>
>>> On 7/30/25 12:21, Balbir Singh wrote:
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
>>>> Zone device private entries when split via munmap go through pmd split,
>>>> but need to go through a folio split, deferred split does not work if a
>>>> fault is encountered because fault handling involves migration entries
>>>> (via folio_migrate_mapping) and the folio sizes are expected to be the
>>>> same there. This introduces the need to split the folio while handling
>>>> the pmd split. Because the folio is still mapped, but calling
>>>> folio_split() will cause lock recursion, the __split_unmapped_folio()
>>>> code is used with a new helper to wrap the code
>>>> split_device_private_folio(), which skips the checks around
>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>> folio.
>>>>
>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>> Cc: David Airlie <airlied@gmail.com>
>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Barry Song <baohua@kernel.org>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Peter Xu <peterx@redhat.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>
>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>> ---
>>>>  include/linux/huge_mm.h |   1 +
>>>>  include/linux/rmap.h    |   2 +
>>>>  include/linux/swapops.h |  17 +++
>>>>  mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>>>>  mm/page_vma_mapped.c    |  13 +-
>>>>  mm/pgtable-generic.c    |   6 +
>>>>  mm/rmap.c               |  22 +++-
>>>>  7 files changed, 278 insertions(+), 51 deletions(-)
>>>>
>> <snip>
>>
>>>> +/**
>>>> + * split_huge_device_private_folio - split a huge device private folio into
>>>> + * smaller pages (of order 0), currently used by migrate_device logic to
>>>> + * split folios for pages that are partially mapped
>>>> + *
>>>> + * @folio: the folio to split
>>>> + *
>>>> + * The caller has to hold the folio_lock and a reference via folio_get
>>>> + */
>>>> +int split_device_private_folio(struct folio *folio)
>>>> +{
>>>> +	struct folio *end_folio = folio_next(folio);
>>>> +	struct folio *new_folio;
>>>> +	int ret = 0;
>>>> +
>>>> +	/*
>>>> +	 * Split the folio now. In the case of device
>>>> +	 * private pages, this path is executed when
>>>> +	 * the pmd is split and since freeze is not true
>>>> +	 * it is likely the folio will be deferred_split.
>>>> +	 *
>>>> +	 * With device private pages, deferred splits of
>>>> +	 * folios should be handled here to prevent partial
>>>> +	 * unmaps from causing issues later on in migration
>>>> +	 * and fault handling flows.
>>>> +	 */
>>>> +	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>> Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?
>> Based on my off-list conversation with Balbir, the folio is unmapped in
>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>> device side mapping.
> Maybe we should make it aware of device private mapping? So that the
> process mirrors CPU side folio split: 1) unmap device private mapping,
> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
> 5) remap device private mapping.

Ah ok this was about device private page obviously here, nevermind..

>>>> +	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>> Confusing to  __split_unmapped_folio() if folio is mapped...
>> From driver point of view, __split_unmapped_folio() probably should be renamed
>> to __split_cpu_unmapped_folio(), since it is only dealing with CPU side
>> folio meta data for split.
>>
>>
>> Best Regards,
>> Yan, Zi
>
> Best Regards,
> Yan, Zi
>


