Return-Path: <linux-kernel+bounces-899328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88831C576BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5B04E5434
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184C34E741;
	Thu, 13 Nov 2025 12:26:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9A34DCE0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036763; cv=none; b=rDdIO67//4P4ZOBBegqSTGZe75Q1kNpv7J6euQMrZOL6KG4GoKYTz3E9S9uc+MWXRJcxYOajDCNBj0FX4tXT0vThTGaCiR4L9EV6DsoeXMraDU2gXQMqgfl/xs6svlMqKZQaYWz9xQUgzXSo/QuRJwYRY6y6Ow8CrnTTUiC/KQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036763; c=relaxed/simple;
	bh=fute6TaNXaa96N5LBgsyUYlG0kWD0BLv3He7E9N66h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQ7VW5EmI0fDi//5fvpqFXOV1rkBrhzsW9P1DASZSZZGdQE+mPIxvBDGzfSsTVplrLCHcKK2xi+z3LgIdM1M+ndOKzGyEW1Wmgl8JOa0tm5sKFMCPeJcjSAovgITeOh39vNFqcA2o6cKPfInj33Qz+vwtmzVolHzxZwu9VqTVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4303812FC;
	Thu, 13 Nov 2025 04:25:51 -0800 (PST)
Received: from [10.57.88.12] (unknown [10.57.88.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99CE33F5A1;
	Thu, 13 Nov 2025 04:25:57 -0800 (PST)
Message-ID: <40682e84-edc1-4861-b078-a5067259cd73@arm.com>
Date: Thu, 13 Nov 2025 12:25:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/mm: Document why linear map split failure upon
 vm_reset_perms is not problematic
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: rppt@kernel.org, shijie@os.amperecomputing.com,
 yang@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251112062716.64801-1-dev.jain@arm.com>
 <20251112062716.64801-3-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251112062716.64801-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2025 06:27, Dev Jain wrote:
> Consider the following code path:
> 
> (1) vmalloc -> (2) set_vm_flush_reset_perms -> (3) set_memory_ro/set_memory_rox
> -> .... (4) use the mapping .... -> (5) vfree -> (6) vm_reset_perms
> -> (7) set_area_direct_map.
> Or, it may happen that we encounter failure at (3) and directly jump to (5).
> 
> In both cases, (7) may fail due to linear map split failure. But, we care
> about its success *only* for the region which got successfully changed by
> (3). Such a region is guaranteed to be pte-mapped.

I keep tripping over this bit because I keep forgetting that even if the vmalloc
region whose permissions are being changed contains a huge mapping, we still
change the linear map page-by-page. So the portion of the linear map is
guarranteed to be pte-mapped.

> 
> The TLDR is that (7) will surely succeed for the regions we care about.

Appologies, we have definitely discussed this before, but I still can't quite
convince myself. Consider this:

static void vm_reset_perms(struct vm_struct *area)
{
	...

	/*
	 * Set direct map to something invalid so that it won't be cached if
	 * there are any accesses after the TLB flush, then flush the TLB and
	 * reset the direct map permissions to the default.
	 */
	set_area_direct_map(area, set_direct_map_invalid_noflush);
	_vm_unmap_aliases(start, end, flush_dmap);
	set_area_direct_map(area, set_direct_map_default_noflush);
}

If we have a situation where a region of 4M is allocated with vmalloc, which is
PMD-mapped, then only the second 2M has its permissions changed by
set_memory_ro[x], we end up with the first 2M not pte-mapped in the linear map
with default permissions and the second 2M pte-mapped in the linear with
non-default permissions.

The above code tries to set the whole vm area to invalid in the linear map
before issuing a TLB flush. This could fail for the first half of the area if we
are unable to allocate the PTE table to split to PTE (since
set_direct_map_default_noflush() is called page-by-page). So we end up with the
first half of the region valid with default permissions in the linear map and
the second half invalid when we do the TLB flush.

(The above code does it this way to a) reduce the number of TLB flushes to the
minimum  - the same one covers both the linear map and the vmalloc invalidation,
and b) to ensure there is no window when memory has both X and W aliases.

Given it is guarranteed that if any of the linear map is still valid, then it's
permissions are the default ones and the vmalloc alias was never changed to
non-default permissions for that part, then I agree this is safe.

I've convinced myself that this is all safe and correct. Sorry for the babble:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  arch/arm64/mm/pageattr.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index b4ea86cd3a71..dc05f06a47f2 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -185,6 +185,15 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	 */
>  	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>  			    pgprot_val(clear_mask) == PTE_RDONLY)) {
> +		/*
> +		 * Note: One may wonder what happens if the calls to
> +		 * set_area_direct_map() in vm_reset_perms() fail due ENOMEM on
> +		 * linear map split failure. Observe that we care about those
> +		 * calls to succeed *only* for the region whose permissions
> +		 * are not default. Such a region is guaranteed to be
> +		 * pte-mapped, because the below call can change those
> +		 * permissions to non-default only after splitting that region.
> +		 */
>  		for (i = 0; i < area->nr_pages; i++) {
>  			ret = __change_memory_common((u64)page_address(area->pages[i]),
>  					       PAGE_SIZE, set_mask, clear_mask);


