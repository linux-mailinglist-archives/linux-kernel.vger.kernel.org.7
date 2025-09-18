Return-Path: <linux-kernel+bounces-813215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78475B5420D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9808C1B21DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A0284669;
	Fri, 12 Sep 2025 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh4m5648"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95227B4E5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654921; cv=none; b=LK4Gc9lUwFtzJB+HIw6iqRnA09D+IMvfg5gQwWC+TiFKOdbwaP42z7+ggw933coS6glpHi2siiYn8RTKsoRuLgSjeR8wwU3fYGYbPIkNEae2AyZ5G2fjrWOQ3JZc4Gji/AKU9yh1phzdz/FLbEzFOvFAqU/cHruYtfBN07i/m4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654921; c=relaxed/simple;
	bh=9Cpnoq/DypleHwmgQtKUTSqWF1gCIJKoqqTjacvAgwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y93STOrahRroaiA6lxSk3AyQIeRWhCh5AJryrJLcxoRXeWloAGaFBgUuiz5W/DzPF7D/YvzD9roEhjADiMDr0qgG4BaLTMLmWweOOvCXujO7AKAWXxVxBGn74KdOxzrnXkzKRTXIBj+fmkyhO6PTcfCrc7S1f/Hlm9zTbVzp39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lh4m5648; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757654918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ9I3kFrAfuzRn5zG3IfhkcbkFVirVLdOlMEX4ozb3Q=;
	b=Lh4m5648XNvKQlKdjYrL00gkPUvQtUC9sn5PelqqyzIvEr0gAoKedpxlJ8rkqkFiWtG+Qr
	3XQV9BnpwY9iMQyvTTqlCjX6e7fAmcsEWnCmK33u3kFsAv3In+KVQJ4yjnCkOfy8Nan0GV
	jqHCtZbwkPsEWsyedxHdOo1wTAloAq8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-InuAyUlPOJaAt8nA3-n5nA-1; Fri, 12 Sep 2025 01:28:36 -0400
X-MC-Unique: InuAyUlPOJaAt8nA3-n5nA-1
X-Mimecast-MFC-AGG-ID: InuAyUlPOJaAt8nA3-n5nA_1757654915
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-336de0ff5d6so7618131fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757654915; x=1758259715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ9I3kFrAfuzRn5zG3IfhkcbkFVirVLdOlMEX4ozb3Q=;
        b=IBHADQWlYj9kFYA3f3rfdtksjK32p4c+Di2Edtm+tqMP8eWshY8xWTpmgY8GwViQx/
         f5JAnWkxApUavFZtvja04U46X4+XdpKGIFLkmsJ4cvhVoe/WSdgEsG1EYHvHYSwhpSPx
         mMDtXgtZFh+jYABk6D1DopHJbI4aH5q9ab2257pBWgY+RQuZNls+g6XDE4nffTYWClIr
         X1oP9Fngp5HjSZaWADa8t28zoVkZt5/ws6gL+EQUYX73nMDUNjHR8H6OT+WgWBS8crGi
         9iaklpbD8lr+sWjMQOxuASa0M/nKVwYvzU+8QUHamQ+vwBkt3idbPnIHo/8f0QNShRCJ
         kTMw==
X-Forwarded-Encrypted: i=1; AJvYcCVsuV/XoJ+gjoZJ129QDA0mu+8Mq7rDJRxkqgzIPjtBkCYEBye7xfOTnBkmW/34+K6cW566nCWRilGILfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmAbFVBsh6wtEkHEdqmxErCaqCj5231OFcBm0lZTcMHHG6h7f
	NGyIuqvKLmz68MZSmBPW/ql0XDOLuISVmxNs8qf8t6QJhBq93llhjVoRsn47SdB9daUrQIF4g3B
	UGgh9YhmvzbaGslA7jtixto5IQy52CgyF9bfAfoNbQXv93jxoaFX5eiXHyNl+rLa1
X-Gm-Gg: ASbGnctWfaTNmR+hUFr5VKhYRbYp0uYsN7mqH9xLJCVustJ/deGIKXiXRxiU+NJC7G9
	dckL1EaH23d3LaJS3w97y+xayzVPuAVIHGLVNjfBfF0rU6MMPyzxO38hapgXxKmw1tDx9WQ3RrX
	WuX4x7ckp4XSUB8YezCTSusNad3XZbuG9sBBoPF7WS45D7zHffkPtNxPZyDALcmXvJh/rO2Tlut
	fNIt61fvA0XyfToB0ve3Cno2ZYAVxwBIpFLTlV53JfknW1yK5OcxW4EFSDDf1bUKaof6YUvoUAW
	xDJAfWIUqFyrTVKvMXRNSiyQBAc/ycM8Y2mnn0s/rRjFzJ4JRVd7Zon2gbv0kiAsM/Dvg/woNAB
	2VjSY4JIDMk8EelHUq51sBFY0mhalgltmDyJf+NXCC7iVvMUtKk1K
X-Received: by 2002:a2e:be91:0:b0:351:b11d:e630 with SMTP id 38308e7fff4ca-351b11ded0amr3280491fa.11.1757654914804;
        Thu, 11 Sep 2025 22:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpGJ8fEYHY6vVQRRiNssGfCLT3ZkT3GfJOpIxVKWucfTurAjgfRecqT3PfQJdvJQYHVWNvWA==
X-Received: by 2002:a2e:be91:0:b0:351:b11d:e630 with SMTP id 38308e7fff4ca-351b11ded0amr3280201fa.11.1757654914261;
        Thu, 11 Sep 2025 22:28:34 -0700 (PDT)
Received: from ?IPV6:2001:999:408:6576:1142:7350:b6c5:671e? (n4ctkw60s7hbahed3xa-1.v6.elisa-mobile.fi. [2001:999:408:6576:1142:7350:b6c5:671e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a591fasm6136911fa.9.2025.09.11.22.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 22:28:33 -0700 (PDT)
Message-ID: <4cc2ba18-e7de-448f-aaee-043ed68dc6e3@redhat.com>
Date: Fri, 12 Sep 2025 08:28:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 06/15] mm/migrate_device: implement THP migration of zone
 device pages
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-7-balbirs@nvidia.com>
 <d35eea42-ed32-481f-9dcf-704d22eb8706@redhat.com>
 <49039b9d-4c42-480f-a219-daf0958be28e@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <49039b9d-4c42-480f-a219-daf0958be28e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/12/25 08:04, Balbir Singh wrote:

> On 9/11/25 21:52, Mika Penttilä wrote:
>> sending again for the v5 thread..
>>
>> On 9/8/25 03:04, Balbir Singh wrote:
>>
>>> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
>>> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
>>> device pages as compound pages during device pfn migration.
>>>
>>> migrate_device code paths go through the collect, setup
>>> and finalize phases of migration.
>>>
>>> The entries in src and dst arrays passed to these functions still
>>> remain at a PAGE_SIZE granularity. When a compound page is passed,
>>> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
>>> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
>>> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
>>> representation allows for the compound page to be split into smaller
>>> page sizes.
>>>
>>> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
>>> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
>>> and migrate_vma_insert_huge_pmd_page() have been added.
>>>
>>> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
>>> some reason this fails, there is fallback support to split the folio
>>> and migrate it.
>>>
>>> migrate_vma_insert_huge_pmd_page() closely follows the logic of
>>> migrate_vma_insert_page()
>>>
>>> Support for splitting pages as needed for migration will follow in
>>> later patches in this series.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
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
>>>
>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>> ---
>>>  include/linux/migrate.h |   2 +
>>>  mm/migrate_device.c     | 456 ++++++++++++++++++++++++++++++++++------
>>>  2 files changed, 395 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index 1f0ac122c3bf..41b4cc05a450 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -125,6 +125,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>>>  #define MIGRATE_PFN_VALID	(1UL << 0)
>>>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>>>  #define MIGRATE_PFN_WRITE	(1UL << 3)
>>> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>>>  #define MIGRATE_PFN_SHIFT	6
>>>  
>>>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
>>> @@ -143,6 +144,7 @@ enum migrate_vma_direction {
>>>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>>>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>>>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
>>> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>>>  };
>>>  
>>>  struct migrate_vma {
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index f45ef182287d..1dfcf4799ea5 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -14,6 +14,7 @@
>>>  #include <linux/pagewalk.h>
>>>  #include <linux/rmap.h>
>>>  #include <linux/swapops.h>
>>> +#include <linux/pgalloc.h>
>>>  #include <asm/tlbflush.h>
>>>  #include "internal.h"
>>>  
>>> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>>>  	if (!vma_is_anonymous(walk->vma))
>>>  		return migrate_vma_collect_skip(start, end, walk);
>>>  
>>> +	if (thp_migration_supported() &&
>>> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
>>> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
>>> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
>>> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
>>> +						MIGRATE_PFN_COMPOUND;
>>> +		migrate->dst[migrate->npages] = 0;
>>> +		migrate->npages++;
>>> +		migrate->cpages++;
>>> +
>>> +		/*
>>> +		 * Collect the remaining entries as holes, in case we
>>> +		 * need to split later
>>> +		 */
>>> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
>>> +	}
>>> +
>> seems you have to split_huge_pmd() for the huge zero page here in case
>> of !thp_migration_supported() afaics
>>
> Not really, if pfn is 0, we do a vm_insert_page (please see if (!page) line 1107) and
> folio  handling in migrate_vma_finalize line 1284

Ok actually seems it is handled by migrate_vma_insert_page() which does

        if (!pmd_none(*pmdp)) {
                if (pmd_trans_huge(*pmdp)) {
                        if (!is_huge_zero_pmd(*pmdp))
                                goto abort;
                        folio_get(pmd_folio(*pmdp));
                        split_huge_pmd(vma, pmdp, addr);   <----- here
                } else if (pmd_leaf(*pmdp))
                        goto abort;
        }


>
> Thanks,
> Balbir
>
--Mika


