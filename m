Return-Path: <linux-kernel+bounces-750755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58BDB160A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D6416306C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B4267F57;
	Wed, 30 Jul 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqrtjZkn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4739ACC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879754; cv=none; b=Oro1ANTZwKrTvKbllVwKOSlhiEwrTVNHc3EpQGNwOCoQnll0qW7mBiAYTPeZAaYlo8cJTzaoiJlIZAdYgXcqBkgLB7QpMTkS7v3IKAlvmKWKIkzX1s1COO4OA1TavfBWOSqWj3CYxK+6pP7Lm32E3++ahnoyKg4PPFtYN9TKyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879754; c=relaxed/simple;
	bh=irpRGxd7pDpwUsdW4k1yqe3sWcMycbgU17Cbq1P+jEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRw4P+i91R9BKcPAlVc1m/ayXFMvmdHV1JflOUAWuAObhUZgqtM29uizzy6hpJqx6V932yOnNycSJ6tNrbrNoLD3nYaGm1oQqxdlsngkcwmEwGQ6MShVRVu2TY5EhzRcVdVhqIQPbZhght9g7efsXguCDNM0VHn30QrTKE04mjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqrtjZkn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753879750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZUN75x2L14EgNPJJUNjgv3vPQSsoNHFr+OA9tV21yY=;
	b=WqrtjZknqZx6vNZNCrMiXmk6kf/BKLO9Vh8ggS66gwpdioantIKhygulFrtgGao4Smohkr
	kEn9dDg+zg/zEgteZFShlzKel1/zQQ6efhIUMaB/WtIZh7T94HSK2AJ+xaUO0lqfe7A6Fe
	ZEH33m+KjQfPZCHbywY+Tbwi+ZkDGP8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-wmgzGkHYMGCAP89PRsaaCg-1; Wed, 30 Jul 2025 08:49:08 -0400
X-MC-Unique: wmgzGkHYMGCAP89PRsaaCg-1
X-Mimecast-MFC-AGG-ID: wmgzGkHYMGCAP89PRsaaCg_1753879747
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3323287983bso265331fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753879746; x=1754484546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZUN75x2L14EgNPJJUNjgv3vPQSsoNHFr+OA9tV21yY=;
        b=mwT6YJubi7rHNdiyYAGq4Uiqh/Wxqu64o/n+5kOJmQsNYZ/38qvEZFj+s+H1blSdbt
         xVGhnNE80E0Nef/aXbq2ur49AK9lqLlEa+SMWcCEPwxd6U+qihY3qYgpUvqlj2JP001P
         D+7kNbvlINziaqP7uOsOVLk5EI2HbsYDua8DlI1VWoFW5TEW2USSIENwN+z2EhDXz3or
         5WfnRnIdE6LZWTcqp6iEOfgdoNDUqyncxd7W7ksw2b/z7FWeCfSjcu8XAGfFAev7KGY+
         t0OfVlHlqP+DLTi+8josd8rKIRgGXIvX4vzOU3cenFx9XdoFrLi7snmYRrU16lb/ZSwb
         u2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNypLsDfxs4E/QBYGZ1bliE+T+qCyWBwUjxQ1u3aHMxp3575HIG7k8xpaB53LxsTMbHom5k4okpHP7X+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDNVlQ840n1grie+ShDzKRCllX9VABhjGPRo3iu1azjc9r3HY
	+Ag8TF6QNcabpDkTMUeBQ4J12PVbYTW4q0jrSZ3Shj7HsrZxDPoyEoTX4RiPUyYqWnh9HX14ELX
	mgB+RGAh+yvVTFxWbc9DpeOPlBzXf3mhuZRy5BKIR55CD3nlx432M3UfEd7BCXhzYsQdz+iOmar
	o=
X-Gm-Gg: ASbGncv2XYs8tVtK/Wmqe0Zc9hqt3xoKJE1/QxuvzFuuUnxNbZGCjFINoZX0T5Qs4m6
	5ljqMi8zI+yYhNWftIpoNjP8iUcvy/5SR3Oot7z/6CRilB93e8VUvdv6DZk9xGOnX/+8ZmyCBut
	0YMH01U/FrYVW/CC7wff3zPYf1qeA+pJAPXUJ5yEaYjp7fR62rGqH0DMwlHQD1wiGICsAiFk09x
	krJzLilFi/FazU4DS5aDdBkzgLAVCZ1pjtVAjcj4ZmKVHPjizNPatxvgwn2zobGGYl12iU/3G0t
	LK+vZYT2t+tknHpHXH+xjGk5Bvca2A2dZnJs6rIkprDIQYTe4NKaj9yaAsdKdHmlAw==
X-Received: by 2002:a05:6512:4015:b0:553:23f9:bb37 with SMTP id 2adb3069b0e04-55b7c072c36mr1043785e87.40.1753879746187;
        Wed, 30 Jul 2025 05:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6BFlRd8e64dL1jm2ku8mwGgkk3C2uMqJsm2lCzIapccB0coiry6mKgtB9ZE0tEYSS0gk96g==
X-Received: by 2002:a05:6512:4015:b0:553:23f9:bb37 with SMTP id 2adb3069b0e04-55b7c072c36mr1043777e87.40.1753879745647;
        Wed, 30 Jul 2025 05:49:05 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316d9e7sm2128039e87.26.2025.07.30.05.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:49:05 -0700 (PDT)
Message-ID: <b62234fc-051f-4b2a-b7da-0c0959fb269b@redhat.com>
Date: Wed, 30 Jul 2025 15:49:04 +0300
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <6291D401-1A45-4203-B552-79FE26E151E4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/30/25 15:25, Zi Yan wrote:
> On 30 Jul 2025, at 8:08, Mika Penttilä wrote:
>
>> On 7/30/25 14:42, Mika Penttilä wrote:
>>> On 7/30/25 14:30, Zi Yan wrote:
>>>> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>>>>
>>>>> On 30 Jul 2025, at 7:16, Mika Penttilä wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 7/30/25 12:21, Balbir Singh wrote:
>>>>>>> Make THP handling code in the mm subsystem for THP pages aware of zone
>>>>>>> device pages. Although the code is designed to be generic when it comes
>>>>>>> to handling splitting of pages, the code is designed to work for THP
>>>>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>>>>
>>>>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>>>>> entry is present, enabling try_to_migrate() and other code migration
>>>>>>> paths to appropriately process the entry. page_vma_mapped_walk() will
>>>>>>> return true for zone device private large folios only when
>>>>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
>>>>>>> not zone device private pages from having to add awareness. The key
>>>>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>>>>> callbacks page idle, damon use it for setting young/dirty bits, which is
>>>>>>> not significant when it comes to pmd level bit harvesting.
>>>>>>>
>>>>>>> pmd_pfn() does not work well with zone device entries, use
>>>>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
>>>>>>> entries.
>>>>>>>
>>>>>>> Zone device private entries when split via munmap go through pmd split,
>>>>>>> but need to go through a folio split, deferred split does not work if a
>>>>>>> fault is encountered because fault handling involves migration entries
>>>>>>> (via folio_migrate_mapping) and the folio sizes are expected to be the
>>>>>>> same there. This introduces the need to split the folio while handling
>>>>>>> the pmd split. Because the folio is still mapped, but calling
>>>>>>> folio_split() will cause lock recursion, the __split_unmapped_folio()
>>>>>>> code is used with a new helper to wrap the code
>>>>>>> split_device_private_folio(), which skips the checks around
>>>>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>>>>> folio.
>>>>>>>
>>>>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>>>>
>>>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>>> ---
>>>>>>>  include/linux/huge_mm.h |   1 +
>>>>>>>  include/linux/rmap.h    |   2 +
>>>>>>>  include/linux/swapops.h |  17 +++
>>>>>>>  mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>>>>>>>  mm/page_vma_mapped.c    |  13 +-
>>>>>>>  mm/pgtable-generic.c    |   6 +
>>>>>>>  mm/rmap.c               |  22 +++-
>>>>>>>  7 files changed, 278 insertions(+), 51 deletions(-)
>>>>>>>
>>>>> <snip>
>>>>>
>>>>>>> +/**
>>>>>>> + * split_huge_device_private_folio - split a huge device private folio into
>>>>>>> + * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>>> + * split folios for pages that are partially mapped
>>>>>>> + *
>>>>>>> + * @folio: the folio to split
>>>>>>> + *
>>>>>>> + * The caller has to hold the folio_lock and a reference via folio_get
>>>>>>> + */
>>>>>>> +int split_device_private_folio(struct folio *folio)
>>>>>>> +{
>>>>>>> +	struct folio *end_folio = folio_next(folio);
>>>>>>> +	struct folio *new_folio;
>>>>>>> +	int ret = 0;
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * Split the folio now. In the case of device
>>>>>>> +	 * private pages, this path is executed when
>>>>>>> +	 * the pmd is split and since freeze is not true
>>>>>>> +	 * it is likely the folio will be deferred_split.
>>>>>>> +	 *
>>>>>>> +	 * With device private pages, deferred splits of
>>>>>>> +	 * folios should be handled here to prevent partial
>>>>>>> +	 * unmaps from causing issues later on in migration
>>>>>>> +	 * and fault handling flows.
>>>>>>> +	 */
>>>>>>> +	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>> Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?
>>>>> Based on my off-list conversation with Balbir, the folio is unmapped in
>>>>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>>>>> device side mapping.
>>>> Maybe we should make it aware of device private mapping? So that the
>>>> process mirrors CPU side folio split: 1) unmap device private mapping,
>>>> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
>>>> 5) remap device private mapping.
>>> Ah ok this was about device private page obviously here, nevermind..
>> Still, isn't this reachable from split_huge_pmd() paths and folio is mapped to CPU page tables as a huge device page by one or more task?
> The folio only has migration entries pointing to it. From CPU perspective,
> it is not mapped. The unmap_folio() used by __folio_split() unmaps a to-be-split
> folio by replacing existing page table entries with migration entries
> and after that the folio is regarded as “unmapped”.
>
> The migration entry is an invalid CPU page table entry, so it is not a CPU

split_device_private_folio() is called for device private entry, not migrate entry afaics. 
And it is called from split_huge_pmd() with freeze == false, not from folio split but pmd split.

> mapping, IIUC.
>
>>>>>>> +	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>>>>> Confusing to  __split_unmapped_folio() if folio is mapped...
>>>>> From driver point of view, __split_unmapped_folio() probably should be renamed
>>>>> to __split_cpu_unmapped_folio(), since it is only dealing with CPU side
>>>>> folio meta data for split.
>>>>>
>>>>>
>>>>> Best Regards,
>>>>> Yan, Zi
>>>> Best Regards,
>>>> Yan, Zi
>>>>
>> --Mika
>
> Best Regards,
> Yan, Zi
>
--Mika



