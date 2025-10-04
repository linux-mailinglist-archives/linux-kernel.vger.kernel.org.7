Return-Path: <linux-kernel+bounces-842048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34513BB8D87
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20FC54E470C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569652741DA;
	Sat,  4 Oct 2025 13:08:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29127280E
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583315; cv=none; b=J+J9yfMdPWkEFl+FxkyvYDDC1+871oIa1AdQpSMG/x6rFSFRMdmf5oQN4MS+Z294DUsluDo3DIBWUToco005ChunO9ZsJipeorU7V7UwlfySH/vkbfveql4xIlRRkQqNeURIo+o8I75w6uUjjj8SAg/T+9drIl+dWOr6T8FQyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583315; c=relaxed/simple;
	bh=wDOJwHwrpUmQAe63c8qTnUw5LSwKIclt3+G7slOaYLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAgN9BFORoQq72j8S4x9U2AQyq/unRaJGDSLLxJOk0J0Stfe/32t0Wbxq3IBs5I8vhrZ1MuNV3Lg7LtHgkQhhlyrJdUSCx8hU1116kdh4IMowzDmAW2qLev7s7cAHYcbkupB2RO2svTCpntCrXSkolFdJ5Ei2WxmSqU4UMVgo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF89C153B;
	Sat,  4 Oct 2025 06:08:23 -0700 (PDT)
Received: from [10.163.66.97] (unknown [10.163.66.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800663F66E;
	Sat,  4 Oct 2025 06:08:29 -0700 (PDT)
Message-ID: <766f5a8a-851f-4178-8931-5355472d5558@arm.com>
Date: Sat, 4 Oct 2025 18:38:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: readahead: make thp readahead conditional to
 mmap_miss logic
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org
References: <20250930054815.132075-1-roman.gushchin@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250930054815.132075-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/09/25 11:18 am, Roman Gushchin wrote:
> Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> introduced a special handling for VM_HUGEPAGE mappings: even if the
> readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
> allocated.
>
> This change causes a significant regression for containers with a
> tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
> commit, mmap_miss logic would eventually lead to the readahead
> disablement, effectively reducing the memory pressure in the
> cgroup. With this change the kernel is trying to allocate 1-2 huge
> pages for each fault, no matter if these pages are used or not
> before being evicted, increasing the memory pressure multi-fold.
>
> To fix the regression, let's make the new VM_HUGEPAGE conditional
> to the mmap_miss check, but keep independent from the ra->ra_pages.
> This way the main intention of commit 4687fdbb805a ("mm/filemap:
> Support VM_HUGEPAGE for file mappings") stays intact, but the
> regression is resolved.
>
> The logic behind this changes is simple: even if a user explicitly
> requests using huge pages to back the file mapping (using VM_HUGEPAGE
> flag), under a very strong memory pressure it's better to fall back
> to ordinary pages.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> ---
>   mm/filemap.c | 40 +++++++++++++++++++++-------------------
>   1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a52dd38d2b4a..b67d7981fafb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3235,34 +3235,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>   	struct file *fpin = NULL;
>   	vm_flags_t vm_flags = vmf->vma->vm_flags;
> +	bool force_thp_readahead = false;
>   	unsigned short mmap_miss;
>   
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   	/* Use the readahead code, even if readahead is disabled */
> -	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
> -		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> -		ra->size = HPAGE_PMD_NR;
> -		/*
> -		 * Fetch two PMD folios, so we get the chance to actually
> -		 * readahead, unless we've been told not to.
> -		 */
> -		if (!(vm_flags & VM_RAND_READ))
> -			ra->size *= 2;
> -		ra->async_size = HPAGE_PMD_NR;
> -		ra->order = HPAGE_PMD_ORDER;
> -		page_cache_ra_order(&ractl, ra);
> -		return fpin;
> -	}
> -#endif
> -
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> +		force_thp_readahead = true;
>   	/*
>   	 * If we don't want any read-ahead, don't bother. VM_EXEC case below is
>   	 * already intended for random access.
>   	 */
>   	if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
>   		return fpin;
> -	if (!ra->ra_pages)
> +	if (!ra->ra_pages && !force_thp_readahead)
>   		return fpin;
>   
>   	if (vm_flags & VM_SEQ_READ) {
> @@ -3283,6 +3269,22 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   	if (mmap_miss > MMAP_LOTSAMISS)
>   		return fpin;
>   

You have moved the PMD-THP logic below the VM_SEQ_READ check, is that intentional?
So VMAs on which sequential read is expected will now use the common readahead algorithm,
instead of always benefitting from reduced TLB pressure through PMD mapping, if my understanding
is correct?

> +	if (force_thp_readahead) {
> +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> +		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> +		ra->size = HPAGE_PMD_NR;
> +		/*
> +		 * Fetch two PMD folios, so we get the chance to actually
> +		 * readahead, unless we've been told not to.
> +		 */
> +		if (!(vm_flags & VM_RAND_READ))
> +			ra->size *= 2;
> +		ra->async_size = HPAGE_PMD_NR;
> +		ra->order = HPAGE_PMD_ORDER;
> +		page_cache_ra_order(&ractl, ra);
> +		return fpin;
> +	}
> +
>   	if (vm_flags & VM_EXEC) {
>   		/*
>   		 * Allow arch to request a preferred minimum folio order for

