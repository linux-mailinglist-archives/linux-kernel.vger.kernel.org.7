Return-Path: <linux-kernel+bounces-763316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3ACB2131B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3597ACCFF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E392D3221;
	Mon, 11 Aug 2025 17:26:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E529BDB8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933173; cv=none; b=nGmjhwyyMUF+EZrhCP5xIlU+R79ttQdXns6FlkuKoeymWj6B8PLYYP37ZG+P0RwiLM8tqpZN29JBUwcjVGYvQSfZ83ShjnijglHUlrwVnSXiYcC9WnkX2NbPJ8j6jyfzdoS+vTl0uV8EDTVIfzkRN3W60C3udprc8b9vx/3L3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933173; c=relaxed/simple;
	bh=uICC0HmUS6u193dRdy5ircuYP9/0Oy60iDOHPl7W5Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWOCftMmKp22LsWcyl+N5aOcdAUnv/r+G4SBHjIj6WfZcdqbywVpeBUcInKeJ/3zpNGSMkLJd64N0btcvN3jVaw8LNQnRTT1W8cGjw2bRBYQO28ru5bZXBHUESQpnhXqyPLKcUONloGUMdkM1Q/YNsUtAWNR/IpBjzSIfeY1Qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111EB1A32;
	Mon, 11 Aug 2025 10:26:02 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFE693F63F;
	Mon, 11 Aug 2025 10:26:07 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:26:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>,
	Mike Rapoport <rppt@kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
	Jason Sequeira <jsequeira@nvidia.com>, Dev Jain <dev.jain@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [RESEND PATCH 1/2] dma/pool: Use vmap() address for memory
 encryption helpers on ARM64
Message-ID: <aJonrTrr6nW7qdLI@arm.com>
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-2-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811005036.714274-2-sdonthineni@nvidia.com>

On Sun, Aug 10, 2025 at 07:50:34PM -0500, Shanker Donthineni wrote:
> In atomic_pool_expand(), set_memory_encrypted()/set_memory_decrypted()
> are currently called with page_to_virt(page). On ARM64 with
> CONFIG_DMA_DIRECT_REMAP=y, the atomic pool is mapped via vmap(), so
> page_to_virt(page) does not reference the actual mapped region.
> 
> Using this incorrect address can cause encryption attribute updates to
> be applied to the wrong memory region. On ARM64 systems with memory
> encryption enabled (e.g. CCA), this can lead to data corruption or
> crashes.
> 
> Fix this by using the vmap() address ('addr') on ARM64 when invoking
> the memory encryption helpers, while retaining the existing
> page_to_virt(page) usage for other architectures.
> 
> Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  kernel/dma/pool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 7b04f7575796b..ba08a301590fd 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  {
>  	unsigned int order;
>  	struct page *page = NULL;
> +	void *vaddr;
>  	void *addr;
>  	int ret = -ENOMEM;
>  
> @@ -113,8 +114,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>  	 * shrink so no re-encryption occurs in dma_direct_free().
>  	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> +	vaddr = IS_ENABLED(CONFIG_ARM64) ? addr : page_to_virt(page);
> +	ret = set_memory_decrypted((unsigned long)vaddr, 1 << order);

At least with arm CCA, there are two aspects to setting the memory
encrypted/decrypted: an RMM (realm management monitor) call and setting
of the attributes of the stage 1 mapping. The RMM call doesn't care
about the virtual address, only the (intermediate) physical address, so
having page_to_virt(page) here is fine.

The second part is setting the (fake) attribute for this mapping (top
bit of the IPA space). Can we not instead just call:

	addr = dma_common_contiguous_remap(page, pool_size,
					   pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
					   __builtin_return_address(0));

in the atomic pool code? The advantage is that we keep the
set_memory_decrypted() call on the linear map so that we change its
attributes as well.

I want avoid walking the page tables for vmap regions if possible in the
arm64 set_memory_* implementation. At some point I was proposing a
GFP_DECRYPTED flag for allocations but never got around to post a patch
(and implement vmalloc() support):

https://lore.kernel.org/linux-arm-kernel/ZmNJdSxSz-sYpVgI@arm.com/

-- 
Catalin

