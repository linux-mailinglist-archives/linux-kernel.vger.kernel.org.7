Return-Path: <linux-kernel+bounces-829277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25348B96ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50949177459
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638AD26B769;
	Tue, 23 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmOXLYC9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25E223DDA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643008; cv=none; b=c8OGhFmfJ4Akh0cCJpYT71L/JfLLzEet4dTsJL4g2U+rD5fu8Zqin1USunI7YLoInIsyS+f2BJfM2vGKNcMjVLxmTAkyNS5peTVz6EshQzPj/P1J2sxFtkM4eJZMYHcl1IgP91ptTlSoj16zW9EqDExQTrsa3K3gdQk8uSY1DzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643008; c=relaxed/simple;
	bh=7xcrEyFC+WS6yolaKMt8zA4l8k1ql4prabs4jrFFfx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8c5RpI/WCGjdsJ7hVtgxk5S07I0nLAxBssSmUdIc+pxdWc1YPFDjhJxFgohEjIuG9xMhd/eD+bXkLkQaJJMFJdF+xKWN2ejuLAESAYzxy+/HWt5BZDbvDEW4v+qz4pMfFT/EBFbeHFoWIt9lAnsP23NzLKU+NY8lRjNljkj7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmOXLYC9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e23a6617dso6558235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643003; x=1759247803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RAZ4THQUhLp/jCSZc6k8pRe3JJ30LyWIBv7Rdm7k38s=;
        b=KmOXLYC9mpUqZEOBCxuo6Rx5tDI83jyk44JSaEHg/Hcv3COXVpI5J+zrL67Vhccfso
         uC5GTaO5VTCli0B9HmGXSoi9K83j4q91D4ouYK9SWO1YSqlkgAmbOnE2+ukoJdWzypsw
         L6vg8k1Sc4TBuzR2xBJI/5bnYXN0jkVf1NBmAkavW6qdgo7esstLkEUeZ5JUj9IDqQMI
         rb9Je6YaMrrOe23gn2mz9V1PUMgwbic1eP0awqVAuOlb4bWjcti1/nvz7ZQ0Ya0e84tg
         98Ml6BC14qcPF1WYMlKrnJNIwBluVjoLjWMUPKB5Qa0Y1TUBRVKqCVB2VFcNpdSoCuo+
         vCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643003; x=1759247803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAZ4THQUhLp/jCSZc6k8pRe3JJ30LyWIBv7Rdm7k38s=;
        b=xT7L8HpK7P04iRHb4MsFHS3nhdcDqnnT9g3A3v4dzDzAWIEJBEt8FGybW/pjqhsqwX
         4bdKSsaxNo6mql5aBeAKysCAuMqVElLSChARX+1eYTOryaeTjrbZnyQAviGykBIKHOud
         5eaTc71PqHnBpqa7pUtc9y6ArpV7WGQjjMkBapuBfRkUhhUsChihd84S5FCX2q+LaRnG
         Tc9G8QKdz42VYRGGUoUrwJsIRGRRBTC7j142yFFhSS5xizhBv0F5K86TFVRSuHjfsFFs
         fqXj8Qng2a5MT02JB7gVjkWBW55vZCaJhHJXksJkLJ6gzsiVpP2D6a9q3HIBuH70vPgB
         DQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEI3BYRrKI+jyGfem7wki56FL9dQNaERl81X6M0iAPY5zuozLt/stqTu/958XZjFDrVe4l/cq3nNAAt3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6pTQTdq9GEP01PlIeolFYecOslOuc80kvnc0YdBECZxXHXWe
	8zwntAaidCahDwPlkMDU9anK75OPnJoRqb6SKfyST1UC/DVIxaOHLaH3
X-Gm-Gg: ASbGncufmkIoPtuoKTzKs+Ra2WMJPwScnwvPEHEXA2zggzJlhrH7SPrHt7R8GVhcDbK
	vSntLy8F7SKxuiMzfpsHvdzIgSSG+Q/9LKg7gJYgSZC+SD60wmGk3UksyTVDu3XdjBgQtBFr1uE
	Ww27qrEkYRLJSu1WdrooSS30CCjrn4pNsdSej76aqLguGzsB1m1r9juKJDf9D60f4OaetYRlu0V
	fSx2ukBub5kohuRGY4G9osWyWOyMTkseC0G6BPW1pB8N43JgoBqLtL7n6qa/hG6pLDH6Aiio1Vq
	q2/LokRAdRp0Vl1DGf80Mz+Odnsoq+uPGLSrPGCuzhCxX9+hpZZ1ioPGZMMqIteZIz+j2fR6ldl
	zS4uZLlFt/doPg8YWhJnckxJ2GsK+dl8iKu1ftAr7k3VL+YBD6NdeBqhf9yFI2RIdskx6
X-Google-Smtp-Source: AGHT+IF0O7ehdqAB1QQAuoqY6m+j/Uj2ZkmlzqIVAVJm6bomKNVnwhf+M+9Mh3XvnYTFUDYTzupMzQ==
X-Received: by 2002:a05:600c:3b93:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-46e1d975205mr31719315e9.1.1758643002051;
        Tue, 23 Sep 2025 08:56:42 -0700 (PDT)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac439sm284469705e9.5.2025.09.23.08.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:56:41 -0700 (PDT)
Date: Tue, 23 Sep 2025 16:56:40 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, damon@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	David Hildenbrand <david@redhat.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v6 05/15] mm/migrate_device: handle partially mapped folios
 during collection
Message-ID: <20250923155640.lbtvyi54ueyv2tjb@wrangler>
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-6-balbirs@nvidia.com>
 <3FE3F2B9-86F9-4EED-863A-093FE3959B1A@nvidia.com>
 <62fb7aca-cd30-4058-bfd1-d08f78d5c38d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62fb7aca-cd30-4058-bfd1-d08f78d5c38d@nvidia.com>

On Tue, Sep 23, 2025 at 01:44:20PM +1000, Balbir Singh wrote:
> On 9/23/25 12:23, Zi Yan wrote:
> > On 16 Sep 2025, at 8:21, Balbir Singh wrote:
> > 
> >> Extend migrate_vma_collect_pmd() to handle partially mapped large folios
> >> that require splitting before migration can proceed.
> >>
> >> During PTE walk in the collection phase, if a large folio is only
> >> partially mapped in the migration range, it must be split to ensure the
> >> folio is correctly migrated.
> >>
> >> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> Cc: Rakie Kim <rakie.kim@sk.com>
> >> Cc: Byungchul Park <byungchul@sk.com>
> >> Cc: Gregory Price <gourry@gourry.net>
> >> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> >> Cc: Alistair Popple <apopple@nvidia.com>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> >> Cc: Nico Pache <npache@redhat.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Dev Jain <dev.jain@arm.com>
> >> Cc: Barry Song <baohua@kernel.org>
> >> Cc: Lyude Paul <lyude@redhat.com>
> >> Cc: Danilo Krummrich <dakr@kernel.org>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> Cc: Ralph Campbell <rcampbell@nvidia.com>
> >> Cc: Mika Penttilä <mpenttil@redhat.com>
> >> Cc: Matthew Brost <matthew.brost@intel.com>
> >> Cc: Francois Dugast <francois.dugast@intel.com>
> >> ---
> >>  mm/migrate_device.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 82 insertions(+)
> >>
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index abd9f6850db6..70c0601f70ea 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -54,6 +54,53 @@ static int migrate_vma_collect_hole(unsigned long start,
> >>  	return 0;
> >>  }
> >>
> >> +/**
> >> + * migrate_vma_split_folio() - Helper function to split a THP folio
> >> + * @folio: the folio to split
> >> + * @fault_page: struct page associated with the fault if any
> >> + *
> >> + * Returns 0 on success
> >> + */
> >> +static int migrate_vma_split_folio(struct folio *folio,
> >> +				   struct page *fault_page)
> >> +{
> >> +	int ret;
> >> +	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
> >> +	struct folio *new_fault_folio = NULL;
> >> +
> >> +	if (folio != fault_folio) {
> >> +		folio_get(folio);
> >> +		folio_lock(folio);
> >> +	}
> >> +
> >> +	ret = split_folio(folio);
> >> +	if (ret) {
> >> +		if (folio != fault_folio) {
> >> +			folio_unlock(folio);
> >> +			folio_put(folio);
> >> +		}
> >> +		return ret;
> >> +	}
> >> +
> >> +	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
> >> +
> >> +	/*
> >> +	 * Ensure the lock is held on the correct
> >> +	 * folio after the split
> >> +	 */
> >> +	if (!new_fault_folio) {
> >> +		folio_unlock(folio);
> >> +		folio_put(folio);
> >> +	} else if (folio != new_fault_folio) {
> >> +		folio_get(new_fault_folio);
> >> +		folio_lock(new_fault_folio);
> >> +		folio_unlock(folio);
> >> +		folio_put(folio);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  				   unsigned long start,
> >>  				   unsigned long end,
> >> @@ -136,6 +183,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  			 * page table entry. Other special swap entries are not
> >>  			 * migratable, and we ignore regular swapped page.
> >>  			 */
> >> +			struct folio *folio;
> >> +
> >>  			entry = pte_to_swp_entry(pte);
> >>  			if (!is_device_private_entry(entry))
> >>  				goto next;
> >> @@ -147,6 +196,23 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  			    pgmap->owner != migrate->pgmap_owner)
> >>  				goto next;
> >>
> >> +			folio = page_folio(page);
> >> +			if (folio_test_large(folio)) {
> >> +				int ret;
> >> +
> >> +				pte_unmap_unlock(ptep, ptl);
> >> +				ret = migrate_vma_split_folio(folio,
> >> +							  migrate->fault_page);
> >> +
> >> +				if (ret) {
> >> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> >> +					goto next;
> >> +				}
> >> +
> >> +				addr = start;
> >> +				goto again;
> >> +			}
> > 
> > This does not look right to me.
> > 
> > The folio here is device private, but migrate_vma_split_folio()
> > calls split_folio(), which cannot handle device private folios yet.
> > Your change to split_folio() is in Patch 10 and should be moved
> > before this patch.
> > 
> 
> Patch 10 is to split the folio in the middle of migration (when we have
> converted the entries to migration entries). This patch relies on the
> changes in patch 4. I agree the names are confusing, I'll reword the
> functions

Hi Balbir,

I am still reviewing the patches, but I think I agree with Zi here.

split_folio() will replace the PMD mappings of the huge folio with PTE
mappings, but will also split the folio into smaller folios. The former
is ok with this patch, but the latter is probably not correct if the folio
is a zone device folio. The driver needs to know about the change, as
usually the driver will have some sort of mapping between GPU physical
memory chunks and their corresponding zone device pages.


