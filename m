Return-Path: <linux-kernel+bounces-797688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32EB41394
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756465E81BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBD2D3EE1;
	Wed,  3 Sep 2025 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZohyeTE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52242D3A71
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874451; cv=none; b=OyHr63zcKIrYYvBcQME4+F6oHJu+HUD8ntWo/n5pIOw2VeJB3cCfzlxXF5gZ8nGvjekhSDAEc/z6qtiyBBJrYYDTu5G332Q62mLBW37Xv//ntaRWkRT8zvbjOoV09f8QHkflfdW6AGjVcteLUh1Jz14c5fNgqpLUoIXV4IuxAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874451; c=relaxed/simple;
	bh=KWFa2fQ25xYb+puOyfr3wLeuHY8yOvTpbdOg+JLQUIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPsFGHdC80dFA+AhqdHDhLDdRD7KfMFrgBCaWtxn1Q9G+fYQbVF7J9yp3GJFN7zGHHvV6jl8XcKA44N8kb8jTYkE17TdyKgqM/64gBMiDrgBSCrD4NnK0pMoislR0yqaubeEOshy/yS0RgrAxgA8TcHFq5khG7cyMWSxhvFRPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZohyeTE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756874447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFKFd7BRRcC6ayNrWC4OEZv5/Y2ehiWbsueptb8aZyE=;
	b=CZohyeTE2MCbNM9IWRRbTit0bHlm+r7BgS6rChWfe6kzkKrNFeKoBWwwHYZT81p5qhYELB
	Mh54Kzlor0g8OulIVaNW4TFkHR/oZEdO7ikR4o5XNopjRf2eViXmZCosDqIx3QMxAeW9FX
	2ze++G4ZogPqDnDa7BiXXN82xQrzvhU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-gOrAATvnOberpiIFYQJNqA-1; Wed, 03 Sep 2025 00:40:46 -0400
X-MC-Unique: gOrAATvnOberpiIFYQJNqA-1
X-Mimecast-MFC-AGG-ID: gOrAATvnOberpiIFYQJNqA_1756874445
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-337f3ee628eso7600741fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 21:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756874444; x=1757479244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFKFd7BRRcC6ayNrWC4OEZv5/Y2ehiWbsueptb8aZyE=;
        b=FQOHsWQlIg5+WSP1KrVxeYd/bz508K2ejEo1bjSW30Q8B8Kh4GYSBUda3IBQPBDB2O
         b2G4tkgDNatY4P0Z03kw4D4AS9Jxcxi1Ih4oWJu585Yde9+f4jvmIwi+x58hlMHuEg1U
         rLuAfp6onMU4BqvEHQBkaMuYDfW7sDgT9h2RqSlMNZPI+3PPoH7njho+fFGkynPYyGyg
         WmTUuirVi4PSX++FQj5L4vfvsA0QL6NtjX9EeRqSlyvgF5HmfYOVWPjs5r0cW2QnxREX
         ql9neC7of+WCtxinmYtRki+/mMdsMa+SFaE81kM1f3RQIz2pSoiJPKBBXVy88YWnONfA
         Sgog==
X-Forwarded-Encrypted: i=1; AJvYcCW7HcLM4A5ooMpQBz56hUa6LXdamtRFzlbAr5zKLwJ7WWYV5yXpIUlH3x41nTd5H0RYf8/joPM5cqzjHIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6tie6j9FYQW/wiQeYxjH9BikWrG4l/IDqMBGy/2EOLOYAJAm
	8+ETS06edq6fI83eNcg6fkau3JPfh5ig9JRdW17t7pHs+vM+Z8xfP687lTkolSAckSI5a7CuiWL
	eE+hyvLRmIHslRSWZw3YcI0gquoiUvkkYJ9vjW8d7b8ForMj+faCb88inwbzkk/B0
X-Gm-Gg: ASbGnctkXp6qyRG7i0FL1i8amoeZXfpGgufkfd3P8TWsE6ub4mugZyYzo2q+/3Lp44O
	JLIVoNS9gpuZy/HJ6OH0J/YDDYynZAwBcyiV0ieOfXBwbuSqZ0joEYEYGakA9yUhn04rLFzJhtW
	RfvAUWmX9DA5rEqle6M/C7vkyUElh8zFUIueMO972WbPtEaLsDeOF6epcPEMbKyYmi/hhCN46Ia
	sLdKESpUq6SCxnDI0Emx0RQstnOZFV05Fyai+3emF8WH6Gd227PYyBBrwS2tqexPglfj6fY29J2
	5TodIiqNxpcLmLYhO9pwxy+4XE8Jb1FrRiAPBXfPO1HYDXvYPjltOwX13ZBsVXwQAA==
X-Received: by 2002:a2e:a990:0:b0:336:e1d6:8920 with SMTP id 38308e7fff4ca-336e1d6917cmr23417341fa.31.1756874444346;
        Tue, 02 Sep 2025 21:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB9QYuRkeTjERXflES7M4qiiN/3BjWaFP3YSaUZpEcyOTHs10oLde5VZHbPVXv9pkoXi4/XQ==
X-Received: by 2002:a2e:a990:0:b0:336:e1d6:8920 with SMTP id 38308e7fff4ca-336e1d6917cmr23417061fa.31.1756874443807;
        Tue, 02 Sep 2025 21:40:43 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c50f79sm7951591fa.1.2025.09.02.21.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 21:40:43 -0700 (PDT)
Message-ID: <ea6caec5-fd20-444c-b937-6cab61198c46@redhat.com>
Date: Wed, 3 Sep 2025 07:40:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 05/15] mm/migrate_device: handle partially mapped folios
 during collection
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
 <20250903011900.3657435-6-balbirs@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250903011900.3657435-6-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/3/25 04:18, Balbir Singh wrote:

> Extend migrate_vma_collect_pmd() to handle partially mapped large
> folios that require splitting before migration can proceed.
>
> During PTE walk in the collection phase, if a large folio is only
> partially mapped in the migration range, it must be split to ensure
> the folio is correctly migrated.
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
>  mm/migrate_device.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index e05e14d6eacd..e58c3f9d01c8 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -54,6 +54,54 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	return 0;
>  }
>  
> +/**
> + * migrate_vma_split_folio - Helper function to split a(n) (m)THP folio
> + *
> + * @folio - the folio to split
> + * @fault_page - struct page associated with the fault if any
> + *
> + * Returns 0 on success
> + */
> +static int migrate_vma_split_folio(struct folio *folio,
> +				   struct page *fault_page)
> +{
> +	int ret;
> +	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
> +	struct folio *new_fault_folio = NULL;
> +
> +	if (folio != fault_folio) {
> +		folio_get(folio);
> +		folio_lock(folio);
> +	}
> +
> +	ret = split_folio(folio);
> +	if (ret) {
> +		if (folio != fault_folio) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +		return ret;
> +	}
> +
> +	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
> +
> +	/*
> +	 * Ensure the lock is held on the correct
> +	 * folio after the split
> +	 */
> +	if (!new_fault_folio) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	} else if (folio != new_fault_folio) {
> +		folio_get(new_fault_folio);
> +		folio_lock(new_fault_folio);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +
> +	return 0;
> +}
> +
>  static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  				   unsigned long start,
>  				   unsigned long end,
> @@ -136,6 +184,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			 * page table entry. Other special swap entries are not
>  			 * migratable, and we ignore regular swapped page.
>  			 */
> +			struct folio *folio;
> +
>  			entry = pte_to_swp_entry(pte);
>  			if (!is_device_private_entry(entry))
>  				goto next;
> @@ -147,6 +197,29 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			    pgmap->owner != migrate->pgmap_owner)
>  				goto next;
>  
> +			folio = page_folio(page);
> +			if (folio_test_large(folio)) {
> +				int ret;
> +
> +				/*
> +				 * The reason for finding pmd present with a
> +				 * large folio for the pte is partial unmaps.
> +				 * Split the folio now for the migration to be
> +				 * handled correctly
> +				 */
> +				pte_unmap_unlock(ptep, ptl);
> +				ret = migrate_vma_split_folio(folio,
> +							  migrate->fault_page);
> +
> +				if (ret) {
> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +					goto next;
> +				}
> +
> +				addr = start;
> +				goto again;
> +			}
> +
>  			mpfn = migrate_pfn(page_to_pfn(page)) |
>  					MIGRATE_PFN_MIGRATE;
>  			if (is_writable_device_private_entry(entry))
> @@ -171,6 +244,28 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  					pgmap->owner != migrate->pgmap_owner)
>  					goto next;
>  			}
> +			folio = page_folio(page);
> +			if (folio_test_large(folio)) {
> +				int ret;
> +
> +				/*
> +				 * The reason for finding pmd present with a
> +				 * large folio for the pte is partial unmaps.
> +				 * Split the folio now for the migration to be
> +				 * handled correctly
> +				 */

There are other reasons like vma splits for various reasons.

> +				pte_unmap_unlock(ptep, ptl);
> +				ret = migrate_vma_split_folio(folio,
> +							  migrate->fault_page);
> +
> +				if (ret) {
> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +					goto next;
> +				}
> +
> +				addr = start;
> +				goto again;
> +			}
>  			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>  		}


