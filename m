Return-Path: <linux-kernel+bounces-811999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F1B53170
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3372A48540F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA431A54D;
	Thu, 11 Sep 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhSc4X63"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF831A54B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591530; cv=none; b=NJU8URnGmoHFJ3qw/JPKHlgguc0eg/UtRYHlDG7bpXLN9jEWX0hYHZXbYo8MBzDRTSxNGoBfUQ+7HSZfrIErLHvZ/NwqrXNdM98jiMTidzZG7QXjC6xVo1HMx3LU78LtqS3TwLQKcUPaLLeIbhAbWapgZpl/rTweh1KOshsrKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591530; c=relaxed/simple;
	bh=3VrK/DRasySAnblNWGRTvNY2Gm9SQ0N4L81fU3iYy0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcxFH8QpFudiZqxlUl1Dyvr80sopWB6jOpr253zFZGSEPdJq3nhkww7td7Qn3DPlQFKafs5vEP9bawM8H0oqO+W40/7veyRnnIR0A+EyX60WymQujD7FOalVSl+iOKFc8oNcHJE8HqzXFDMa2YxTGitwv8mjf5a6QKgDeVSSWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhSc4X63; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757591527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFSNAReIPxMfDq0//HsR9GYvcebZMlltpyKxC4QevlA=;
	b=WhSc4X63qwLqyAv0SmW/MYfjUmwnrHKMxROidgne1fCdaunzx8xF16ERFs90iayEgLrMb1
	UFZi6havjawnbSEv7JCpNet1AHeZoU1bZKcBnG2BivhBUIjUYMNe9LVZUc8wZb+HFpHQTD
	rngajiHEGxZJ8KYU5j3dDWYTz7IB/3c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-OnVIUw7TMIOA9-4KsFPTcg-1; Thu, 11 Sep 2025 07:52:06 -0400
X-MC-Unique: OnVIUw7TMIOA9-4KsFPTcg-1
X-Mimecast-MFC-AGG-ID: OnVIUw7TMIOA9-4KsFPTcg_1757591525
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55f68ad3a06so413924e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757591525; x=1758196325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFSNAReIPxMfDq0//HsR9GYvcebZMlltpyKxC4QevlA=;
        b=wXRqvIFk+FUIgymZOx/TqCu8k7JxLBoF0BnaZ4U/GoPgI9c+pP5b8BuRG8xU2jbOJn
         SuEUnjqc3YFiy6IL29kIDNCEksNIcs7V/dOsx256b+uKjgEWdpr+AN8sTnpipl4J0X5q
         CfNdjNqa3EQaxpIUjhaY4yWMR+y9FxWJFeQ/rh5chdylIVgXpsBF2UWuM9IBG8tt97za
         tpfxuIQ96yUSAdIT7Kk94vLr4c0RMEQoaepIbY5zPMqzcLLQTEJ4dlsz4LKWkREBguIW
         cSvEepaE+OZuTufgTzckoGByeGV/l29jZpuxLRX9Yy2rXc1b5Zr16d4VHvGueFCWKTXP
         BjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9cJQzWMdP+zybJyfqDPWUPEPEZNfFxsFeyWnXdBhFucWsNgNx6+0cB2RUrQvaMhKrpRdSGsk6jIOpV1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTWZWhU3FIE8hlJ+OIqV3SvBu6O8z2kY8c30nnmIHhHbliHjec
	F3zLTjcSRSX+CXOiIBnu2d9Kmvp04lnhzbixpR1o1Dtj6AyCz/WcT+uCaZ0/u12fyXn/aFP4Pjr
	vtw5Bkmud1mH1gtFnxL4y9WNW5QXb45Z1lPPgUrR2YcldaBz38W6XygdHNygkmlXQ
X-Gm-Gg: ASbGncv7XLTg3MOe75CQrPWVST4Z2GqNJoYONEiw2EChQ9nsLkJ4LoR/LfPV+e6008+
	7X6/hiJJx+PcTx0//fe3soKKIvZ9n3EPLxuru0BipL27MRGYJKw16HVbOFh7GIZ7MtgzMz9vyTe
	ftLFbURbchV9iMzgC0qMKuLyNT1QPUu4BD33P2ARUdBF2AvSWDyTRfuWKMeHRyinv0d7Hjkjm6z
	t67dFQQHvo4jT3q5WO9jLmd8fyK88ftY3NF+Pp+KLEczOlyOnD754fxWBqngGpBI8niQlFNxEqn
	NrUWbRS7qL9q2JEBD15GpukAnd4a0dkpf7K8wkkHyoTakWXVHq5asS68PSNRO/ygpEKXycZ+TV6
	scDZloDcry4gw37qjOR2CPnisgq0FKqY+ur3//2oK5DkrvU/Usg==
X-Received: by 2002:a05:6512:3e19:b0:55f:6831:6eff with SMTP id 2adb3069b0e04-5625eb95710mr7497392e87.4.1757591524566;
        Thu, 11 Sep 2025 04:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSZqn3zLcuK5tUPBaAcRR8ioorhgaZjrssIarYSMWB+fPQ8ZMZad/gn0ZbUOMVd1PP6SS9vQ==
X-Received: by 2002:a05:6512:3e19:b0:55f:6831:6eff with SMTP id 2adb3069b0e04-5625eb95710mr7497368e87.4.1757591523996;
        Thu, 11 Sep 2025 04:52:03 -0700 (PDT)
Received: from ?IPV6:2001:999:704:9310:43e6:e14c:406:e339? (n7kwfhcd2z0e9u7cxfd-1.v6.elisa-mobile.fi. [2001:999:704:9310:43e6:e14c:406:e339])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63e47sm377870e87.80.2025.09.11.04.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 04:52:03 -0700 (PDT)
Message-ID: <d35eea42-ed32-481f-9dcf-704d22eb8706@redhat.com>
Date: Thu, 11 Sep 2025 14:52:02 +0300
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250908000448.180088-7-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sending again for the v5 thread..

On 9/8/25 03:04, Balbir Singh wrote:

> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
> device pages as compound pages during device pfn migration.
>
> migrate_device code paths go through the collect, setup
> and finalize phases of migration.
>
> The entries in src and dst arrays passed to these functions still
> remain at a PAGE_SIZE granularity. When a compound page is passed,
> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
> representation allows for the compound page to be split into smaller
> page sizes.
>
> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
> and migrate_vma_insert_huge_pmd_page() have been added.
>
> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
> some reason this fails, there is fallback support to split the folio
> and migrate it.
>
> migrate_vma_insert_huge_pmd_page() closely follows the logic of
> migrate_vma_insert_page()
>
> Support for splitting pages as needed for migration will follow in
> later patches in this series.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  include/linux/migrate.h |   2 +
>  mm/migrate_device.c     | 456 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 395 insertions(+), 63 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 1f0ac122c3bf..41b4cc05a450 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -125,6 +125,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>  #define MIGRATE_PFN_VALID	(1UL << 0)
>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>  #define MIGRATE_PFN_SHIFT	6
>  
>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> @@ -143,6 +144,7 @@ enum migrate_vma_direction {
>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>  };
>  
>  struct migrate_vma {
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index f45ef182287d..1dfcf4799ea5 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swapops.h>
> +#include <linux/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
>  
> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	if (!vma_is_anonymous(walk->vma))
>  		return migrate_vma_collect_skip(start, end, walk);
>  
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> +						MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages] = 0;
> +		migrate->npages++;
> +		migrate->cpages++;
> +
> +		/*
> +		 * Collect the remaining entries as holes, in case we
> +		 * need to split later
> +		 */
> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +	}
> +

seems you have to split_huge_pmd() for the huge zero page here in case
of !thp_migration_supported() afaics

>  	for (addr = start; addr < end; addr += PAGE_SIZE) {


