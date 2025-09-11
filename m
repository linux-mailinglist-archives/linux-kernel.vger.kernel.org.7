Return-Path: <linux-kernel+bounces-811906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A198EB52FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3BA17490C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66083318144;
	Thu, 11 Sep 2025 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9eEUmXW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667231281F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589108; cv=none; b=jLGdvqKH+u0Mp8nqvCXLnp6RwYgiFiME7a/WiX5QRofYC1+zDvnwkoPqHZTwbX5xwfNs1HJsG/x+wZgee+mYZxlPR3vfFH0rJg6W00EORgT6qcts9FzndMI46Ij1l95l32i8UPuoSA8G+hLxG2i+skCOUMDz/YRKypC7ZGzgf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589108; c=relaxed/simple;
	bh=ZUH+tMoTUJYwd65jUEfLy0Lppo/4pU83bUnbcy+fV1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsyrcV5PUfckfZgAzDj4fOFrDejSmRtQyNfUZ5pS4CWMbupxkETNhONSuLhtVSxDYuRUvelrFaag/xyKBQWukVqnt0c0ueRt25MDDDx/gxpoj3JqofGPC3KUIc6vEoenAgsNpTXsDQlyUAoRjgiLb3l3VJsYrEDPxFytYHVuKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9eEUmXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757589105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnoZL9IlsM4I8snaZrLtF+NT0iFbOyLl7iwd0dyctVo=;
	b=O9eEUmXWoqQ41fyUaO5ts3c2SZEu5wwGB6m+JyGIWOoWTYWP4r7nelGdk/7yM/SVJoN6JH
	hyJiPRyP9Ljl9zb7z+E9ktZ2iqlgBLhoXU11sR6yQhJiJ5RnTXtSausPZlAauXz3QaJlAu
	OGcS8CYUGfWLvIegC39SXr+Zw6FXdtc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-OBmFir_7MtKC6QsilXFs9g-1; Thu, 11 Sep 2025 07:11:44 -0400
X-MC-Unique: OBmFir_7MtKC6QsilXFs9g-1
X-Mimecast-MFC-AGG-ID: OBmFir_7MtKC6QsilXFs9g_1757589103
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-56088a475cdso317489e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589103; x=1758193903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnoZL9IlsM4I8snaZrLtF+NT0iFbOyLl7iwd0dyctVo=;
        b=w9wcoFXF7JMxnHo01Nu8GGOAN0/y2SiHhtkIE9auKA2mYjCybn8ggx8Bzxs8XtJFSi
         yfOtymQKbxW1x+x3zMeZb8GG22J22v/8H9wvsKLP39/boRpIHQADCbnLiDqoOpfwUZjJ
         3hyYHCSvq5x2AMa5ILYWqE6uDHHqGoyiqRKuRXHfYjy0TtXSbtehlZtblJxVqEUBjgB5
         dejIhdwyEXvC2zg+PpTCMsrxzm1H3FLod0rMEofIpHQN2239bSzpEExdcjywnegc6q/W
         g163NxhL5O//tIwlr1cQhmitWfDCpv2EAUvVQYZU6rqmdOAfcqCuqrYxRd5RikSrYmiV
         +liQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoyrIb3755Ub7IHn2iQBjts0XIY3jsz6WPh8XOb/9XiB3RnknkvwR+7EuLdpyq6Z+MsOYdn3nHGAPUidE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhinKbybLIj5lRzcnl+7jrC/pCKqoSJjThGAmfGVjM23IVM7r
	DHhtw+tNYEbhchqdT68BaBpdEiy8cqctBay/3OxIJGeriACqBbKyYFzfgUMBRDuUARjbn/M4yfx
	kPJigaqbumpa6M1E6/sGJMiR+4yKLb8n+bKSJrXJQ6FKwdZwALj7TgTutudRGZW15
X-Gm-Gg: ASbGncu26BhoUWkWk3zedyGeb6qY1B2A3SLaUEk1Y0PorJkXpGc8xSEdX+0v5iVMbnx
	aYjPL4Inq84Hg1dS9MRd9VYxc7zs44unNtQka8lylfP+xuT0a/r7evJwE0KaY+JMxkpfrBy9b+/
	0LZQLtzdnBFsDQ6V8xs/z5xv2GFCBcFbttH7swqz5VGe5pGyBgYJQJoOOQdyuLnn+V79nsrXKGR
	zM24l+Kd11MfGwzmPapQqqY0Hn5YnDpxZLzdvJgZ1p6ykrH8gl/CvKNSVV9FWRosc2rAF7e2pl2
	J9CNhSCvmKZZ38kMcQnbEqOdtD3PSyjSUdNiNON9Oa6byeaw6P41Q7eNXd7Cd1bRN0Ej7vSiIU1
	2+ZuA8FjRVGemRw6GaFwcqMSe/VwjKNTgwgmsd06DQFH1Gh3Y9Q==
X-Received: by 2002:a05:6512:1593:b0:55f:3faa:7c2e with SMTP id 2adb3069b0e04-5625f535a77mr5703532e87.22.1757589102506;
        Thu, 11 Sep 2025 04:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHndKi4ZUjcu5xTRlvMfXjlXFcDZdujE+IlsZ0U4neE95H5mnTNxQ6YofItgf/sP/wsePXmQ==
X-Received: by 2002:a05:6512:1593:b0:55f:3faa:7c2e with SMTP id 2adb3069b0e04-5625f535a77mr5703497e87.22.1757589101977;
        Thu, 11 Sep 2025 04:11:41 -0700 (PDT)
Received: from ?IPV6:2001:999:704:9310:43e6:e14c:406:e339? (n7kwfhcd2z0e9u7cxfd-1.v6.elisa-mobile.fi. [2001:999:704:9310:43e6:e14c:406:e339])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6002sm364013e87.28.2025.09.11.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 04:11:41 -0700 (PDT)
Message-ID: <9047198d-7b35-435b-a933-ff7b1357919b@redhat.com>
Date: Thu, 11 Sep 2025 14:11:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 06/15] mm/migrate_device: implement THP migration of zone
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
References: <20250903011900.3657435-1-balbirs@nvidia.com>
 <20250903011900.3657435-7-balbirs@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250903011900.3657435-7-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/3/25 04:18, Balbir Singh wrote:

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
> index 9009e27b5f44..40e1c792eb54 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -134,6 +134,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>  #define MIGRATE_PFN_VALID	(1UL << 0)
>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>  #define MIGRATE_PFN_SHIFT	6
>  
>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> @@ -152,6 +153,7 @@ enum migrate_vma_direction {
>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>  };
>  
>  struct migrate_vma {
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index e58c3f9d01c8..aba0cd7856da 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swapops.h>
> +#include <asm/pgalloc.h>
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

seems you have to split_huge_pmd() for the huge zero page here in case of !thp_migration_supported() afaics

>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
>  		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>  		migrate->dst[migrate->npages] = 0;
> @@ -102,57 +120,150 @@ static int migrate_vma_split_folio(struct folio *folio,
>  	return 0;
>  }

--Mika


