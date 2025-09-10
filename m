Return-Path: <linux-kernel+bounces-809368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E6B50C81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35A11C62C75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA82673AA;
	Wed, 10 Sep 2025 04:04:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338A19CC27
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477040; cv=none; b=fdIHOxh4K2ZWZFX+tr44pQe8NOtswOuNQz3VL+2QsRtjfgWjdlZQJU93gD4GvvAZuJSU3ITjFshB833JzkMPrpQRqk5JIYgsFNpBXv0Ao2I3X7oRrM9OwUfbFDC8s3WAtte3J1DKyQIyFdxp64LOtSzQxWQ5jOJ7ZnblMMB3aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477040; c=relaxed/simple;
	bh=wxYqy5HBNoeNK3TA7QmrWmGP9lTcJ2jSXPqmA3wLHHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBUQPxsBneRnSLBH+QEMIZ/nF0u3FshLPPSXBRUGHeurrjJ5e5qNLPugH7AJK7mZu3odUYKUUCqO4XrSdTIuNn8sHgSKSpruuNLovFeAw1DOux3u3Hrjel0jN52dce8x9nor16xFDKTtgAfeGrxchNnUKDHiLc977P+G2v8jEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0324C1596;
	Tue,  9 Sep 2025 21:03:49 -0700 (PDT)
Received: from [10.163.41.55] (unknown [10.163.41.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAB133F66E;
	Tue,  9 Sep 2025 21:03:48 -0700 (PDT)
Message-ID: <8381d07d-f669-4e9e-8dd8-5951a4e5727b@arm.com>
Date: Wed, 10 Sep 2025 09:33:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: Enable khugepaged anonymous collapse on
 non-writable regions
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 kas@kernel.org, willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, richard.weiyang@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250908075028.38431-1-dev.jain@arm.com>
 <20250908075028.38431-2-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250908075028.38431-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/25 1:20 PM, Dev Jain wrote:
> Currently khugepaged does not collapse an anonymous region which does not
> have a single writable pte. This is wasteful since a region mapped with
> non-writable ptes, for example, non-writable VMAs mapped by the
> application, won't benefit from THP collapse.
> 
> An additional consequence of this constraint is that MADV_COLLAPSE does not
> perform a collapse on a non-writable VMA, and this restriction is nowhere
> to be found on the manpage - the restriction itself sounds wrong to me
> since the user knows the protection of the memory it has mapped, so
> collapsing read-only memory via madvise() should be a choice of the
> user which shouldn't be overridden by the kernel.

Agreed. Dropping this constraint makes sense both for MAD_COLLAPSE
system call and khugepaged based collapse as well.
> 
> Therefore, remove this restriction by not honouring SCAN_PAGE_RO.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  mm/khugepaged.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4ec324a4c1fe..a0f1df2a7ae6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  			writable = true;
>  	}
>  
> -	if (unlikely(!writable)) {
> -		result = SCAN_PAGE_RO;
> -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
> +	if (unlikely(cc->is_khugepaged && !referenced)) {
>  		result = SCAN_LACK_REFERENCED_PAGE;
>  	} else {
>  		result = SCAN_SUCCEED;
> @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  		     mmu_notifier_test_young(vma->vm_mm, _address)))
>  			referenced++;
>  	}
> -	if (!writable) {
> -		result = SCAN_PAGE_RO;
> -	} else if (cc->is_khugepaged &&
> +	if (cc->is_khugepaged &&
>  		   (!referenced ||
>  		    (unmapped && referenced < HPAGE_PMD_NR / 2))) {
>  		result = SCAN_LACK_REFERENCED_PAGE;
> @@ -2830,7 +2826,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  		case SCAN_PMD_NULL:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:
> -		case SCAN_PAGE_RO:
>  		case SCAN_LACK_REFERENCED_PAGE:
>  		case SCAN_PAGE_NULL:
>  		case SCAN_PAGE_COUNT:


