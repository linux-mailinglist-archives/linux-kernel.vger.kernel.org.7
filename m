Return-Path: <linux-kernel+bounces-776002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C368B2C74C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E528E189AC61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264F027B321;
	Tue, 19 Aug 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCfMjn7s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C942773E8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614486; cv=none; b=mgm99Xaan/6CwEFisp4mJbx/6tnUo1EijoNZ0eGZFQPCGPo9j739qUOJsml4lz8PTSc8nGrBHnQaZFY2E7dOK9Z5iQsqlJw4YKVwOp6hqUJwIDgXFzEIK0slBPAdPUShTIfG8+t2JHCs/WZwpl0gatMUTL5B5IULY4M1BUo+Qa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614486; c=relaxed/simple;
	bh=3X8zskgg23YAXa6oY8662gl/iTxu3eC1dGiEIV+n4s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dahGRsOf9QDsUFeBRvlif/GVGswlFk7p3fxG4WWQoNpCI/v9TuHCHDiiaHnsxTy9topS8a0av47pIPq5OeIg2uYVggV8KRqxa+t0b3e5iFpLVCONxTzPZNgI0WgrVeQiYnBYm90ny6WjbioU4vVesxk23+AMXpF4zekOOVIezmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCfMjn7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE949C113CF;
	Tue, 19 Aug 2025 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614486;
	bh=3X8zskgg23YAXa6oY8662gl/iTxu3eC1dGiEIV+n4s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCfMjn7s4k/a8u+2sH91mo7APwnnaq4c+tiHUj9PTg+ebiFwcY1wovT5m1yG4o137
	 YqC5RbMH4I5oABysVVgDVTqVYI0T4ZFLh2Yea71cyqndBAUKrKlbwT9boPUjqZT8nv
	 lDzoRsqW1wNB6/QdBOwXFDu1Df6L5PlFR24403b/Hvcsi0nbC0Pdr2vqiaG9TatPhs
	 LL2u3u5WsfLoO7AZ7mdXM7VnnUWYg613D/+y0POq2BKmiARB0CszpH/ueagejOqsxQ
	 fzze3HqsaAKmAqRDk9CuXR1t99o6SYvXh1t1MOy5zSdvmETYsbNDN4RM3vcn5ooUFM
	 9+djfdNDkPFXw==
Date: Tue, 19 Aug 2025 17:41:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: pratyush.brahma@oss.qualcomm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/numa_memblks: Use SZ_1M macro to denote bytes to MB
 conversion
Message-ID: <aKSNED01R-AaclOT@kernel.org>
References: <20250819-numa-memblks-refac-v1-1-936b4fd35000@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-numa-memblks-refac-v1-1-936b4fd35000@oss.qualcomm.com>

On Tue, Aug 19, 2025 at 02:21:44PM +0530, pratyush.brahma@oss.qualcomm.com wrote:
> From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> 
> Replace the manual bitwise conversion of bytes to MB with
> SZ_1M macro, a standard macro used within the mm subsystem,
> to improve readability.

There are few others:

$ git grep '>> 20' mm/
mm/memblock.c:          mem_size_mb = memblock_phys_mem_size() >> 20;
mm/memblock.c:                 (nr_pages << PAGE_SHIFT) >> 20, mem_size_mb);
mm/numa_emulation.c:           nid, eb->start, eb->end - 1, (eb->end - eb->start) >> 20);
mm/numa_emulation.c:                    size >> 20, min_size >> 20);

It makes sense to replace all of them in one patch.
 
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> ---
>  mm/numa_memblks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 541a99c4071a67e5b0ef66f4136dee268a880003..a47aa262a33366337c38ccc7c7064da818523dd2 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -427,9 +427,9 @@ static int __init numa_register_meminfo(struct numa_meminfo *mi)
>  		unsigned long pfn_align = node_map_pfn_alignment();
>  
>  		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
> -			unsigned long node_align_mb = PFN_PHYS(pfn_align) >> 20;
> +			unsigned long node_align_mb = PFN_PHYS(pfn_align) / SZ_1M;
>  
> -			unsigned long sect_align_mb = PFN_PHYS(PAGES_PER_SECTION) >> 20;
> +			unsigned long sect_align_mb = PFN_PHYS(PAGES_PER_SECTION) / SZ_1M;
>  
>  			pr_warn("Node alignment %luMB < min %luMB, rejecting NUMA config\n",
>  				node_align_mb, sect_align_mb);
> 
> ---
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> change-id: 20250819-numa-memblks-refac-7b4b5017b598
> 
> Best regards,
> -- 
> Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> 

-- 
Sincerely yours,
Mike.

