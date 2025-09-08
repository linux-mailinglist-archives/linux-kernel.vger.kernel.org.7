Return-Path: <linux-kernel+bounces-805024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A94B4831D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CC117A06E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DE21C9E1;
	Mon,  8 Sep 2025 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMWSqTjs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0117136658
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304851; cv=none; b=Hy5p+Cyiw4oZSsvS2BAxIu2Tg932MmexFJdszIVT03oEWoaUgg96oghECDs80/7+RptyxPvsBngbioWyE6TYoK1sFsZdcC4suc2zyICz08vMINRUbDnYr1dBJR5DqvEDew3c9LDIve+2tHjw5gahMmH6N6yUMubrq8eji7Sb14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304851; c=relaxed/simple;
	bh=pl18FtxmRQkEuk8/U2WKz5seSMT0xb0I2q75aWzNVjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bN+m3rhNCj7FaxT4M0D2pgjiSRe5K/TM0Hwxc/gTsFPUhxKp1mRmCXnFvb57Zq82PgD/INQ8CZLP8kYtHirJQBy1moDeRyR1tkELerZK8uIOVj/7nIdvCjZdLVYwtghKwr25ovv14V6KCvRxfnzoM8iTUlgUZtmN/uqgF90cS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMWSqTjs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757304848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJsCe6eTTTGDK/V3oOGv4fFA8SBbBbHuaXgk/m4NaJ0=;
	b=HMWSqTjsiZM0MnGz6HyrdAWFmkzjc7WJpEbmRLkJZDvRtN+vSHWH6yTYE5wzIC5Ii92wTI
	d8Sz47QhE1M6Xv0VBfu+YN4EkiALuez8vRT4/HoC6OCakDxJW6hwuGh3FBwqqcMghNq3+9
	Tx8PipirggEZ5DKL171Oate6YvOnSds=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-L3GKh0AYMCu8NlhqqFbThg-1; Mon, 08 Sep 2025 00:14:07 -0400
X-MC-Unique: L3GKh0AYMCu8NlhqqFbThg-1
X-Mimecast-MFC-AGG-ID: L3GKh0AYMCu8NlhqqFbThg_1757304846
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dcfc6558cso27794025e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 21:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757304846; x=1757909646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJsCe6eTTTGDK/V3oOGv4fFA8SBbBbHuaXgk/m4NaJ0=;
        b=q7dEpl3RmQXiDaGE812k7mLW62Rkomb9KgtWULXOosb0yrkYff0RXuxxFss4v3LfTc
         3EtT9y/2Xp0DCX21Ar0Zfr+y5uMwb26JYyT+Ije6Zl4NM9B+HpWnoHCc2CGHqI9XeUmk
         dxiJbPfU0Zn9jTjxnosK1Xyck8cXZx7pbyvzdzUvUEaR0pDlXpIpk8J9bJMmLYtREsRj
         iwXxnJwZ9t4Z7y8BkG6RJq6Pad3oxgevkETPqu12to0wnKvtEn/hOwotGYzPhRUHKQ7U
         UMRaGRDe3VMSsGcmb5JTMVPedUt5wPjhYUc8QHrVbZFJo/RuNYAcBLhtGKJxdDYKY8rx
         pkVw==
X-Forwarded-Encrypted: i=1; AJvYcCUaCM7OHdTqsaPbQwFX9sPb0towUysHYl2d+MMzQa0Yxi8Tfq2HDA/lp3DMnMT+VFhFUM4W6q0jO9Y4dkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqodhvf90SjtVfkcmx8DFbnxdbmAMUJhinhiYTEtd5KAc5O/MC
	bsEZyMjl51RfQlm0AYiQgJzltk7mtWzw8jY5Kv/P4wK/A1iIvyCFJfHJEHbWp6OvSejMHXqe0Og
	2f5HOFGofjcp6MhUw7GcruAwkDxs5kCxEzTTsKkhHUcpl57Q03U+mJu0s8ZtYuV5q
X-Gm-Gg: ASbGncsFdyBr55uurl/FaYmt3GtyoEzQt8KE9a8aousw41X9yPGsVRak6N6+iyzWEoQ
	aIboWaohWbsszu3Sxs9oHbkaLKMH/vQemq70DmO02y/Dz+uQP5Ue2WidD9rGpmN5+hcweyemYCx
	6xsRdUpibYg43vohy4lB96TLEibfhELs11EVeOnGVAvWQql8UwVqT/VXUMZyPREjtqNnu9S2NMy
	luSi/kifFtksA1f8JNal4f9QnwR63Ei7ILHpt52kWLIn54bg4EwAY9NevVyqJ64WKLe+d5VER2f
	TZnlxbrUseQRsaDFPrdnRB4jlN4w4RwITqS2QS97yK4FI49gtprvXRJqRIFU9fkUXw==
X-Received: by 2002:a05:600c:458d:b0:45d:d50d:c0db with SMTP id 5b1f17b1804b1-45dddea5102mr52603685e9.15.1757304845805;
        Sun, 07 Sep 2025 21:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFutUyjnY3i7VNpdhUwrQ7pqW1CmodIEYjJPgtpuIcj6TCRCx7EUrnPJPxT8ek+IEd6gcbzjw==
X-Received: by 2002:a05:600c:458d:b0:45d:d50d:c0db with SMTP id 5b1f17b1804b1-45dddea5102mr52603475e9.15.1757304845375;
        Sun, 07 Sep 2025 21:14:05 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm142588705e9.1.2025.09.07.21.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 21:14:04 -0700 (PDT)
Message-ID: <e6b795de-f522-4952-9ec3-00a2359c43a9@redhat.com>
Date: Mon, 8 Sep 2025 07:14:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 05/15] mm/migrate_device: handle partially mapped folios
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
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-6-balbirs@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250908000448.180088-6-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/8/25 03:04, Balbir Singh wrote:

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
>  mm/migrate_device.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index abd9f6850db6..f45ef182287d 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -54,6 +54,53 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	return 0;
>  }
>  
> +/**
> + * migrate_vma_split_folio() - Helper function to split a THP folio
> + * @folio: the folio to split
> + * @fault_page: struct page associated with the fault if any
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
> @@ -136,6 +183,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			 * page table entry. Other special swap entries are not
>  			 * migratable, and we ignore regular swapped page.
>  			 */
> +			struct folio *folio;
> +
>  			entry = pte_to_swp_entry(pte);
>  			if (!is_device_private_entry(entry))
>  				goto next;
> @@ -147,6 +196,29 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
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
> @@ -171,6 +243,28 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
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

This comment is still not changed, there are other reasons for pte mapped large pages. 
Also now all the mTHPs are splitted, which is change of behavior (currently ignored)
for order < PMD_ORDER.

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

--Mika


