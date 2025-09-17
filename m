Return-Path: <linux-kernel+bounces-821438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FFB813D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CD9627BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05F2F6593;
	Wed, 17 Sep 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcN9R/Tr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14202FE048
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131559; cv=none; b=erCkmDhvHM+fdi+flyCq+cO37w0Fdc8QrDfC2FLbANlu4fmmDCwf913GsbI2rTawItCjKkpAxCtY6RzkzEYyUzO+EJ75wcaPdpKlGzfdP+4PK8J/EcyV1BEi2FRBT7wqZQpJgaUCXO9gfcKobctXemkYzu1PXZkfdN5bmjLjp9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131559; c=relaxed/simple;
	bh=0SeyaT8+bz/I8XaOI5kg2LZdHBHQvUyjeoTzR45r53g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iaxk6yhOJeJ/V1K1GDREtkG9vU4qDpQZgKvXNTnEMMzqHdcjxXV4u8tthVy3OmA7GuoniJf2mnAsJAHSPKaPXbRKRBAilEuSowLricZULbDYf/PN5HgZ7N+yPGwgIGJwwhFcR0Y39VXx7U0Nzu9JeCQNb0DCj0eXZmSmwWsY9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcN9R/Tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E5C4CEF7;
	Wed, 17 Sep 2025 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758131559;
	bh=0SeyaT8+bz/I8XaOI5kg2LZdHBHQvUyjeoTzR45r53g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcN9R/TroM+76zuwCRHHlFotgG8u6yNOacYJ/E+M27GlY7UvbEFph9bmCBH5FY0Wv
	 ZaetVpZzXhfM+zYpEfmtcfxYS0uojPUXq16GufgOBUnOKp1t4oZ6g6zdFECD5yYs2c
	 TjQAAv1NiqWkSOmcfxuDp77119G5Xmvkk7UTllZwFnb1hMs6maVdA+Ia5SyiG2HllO
	 qAIFTvFFaiwGIndHs9Jc5s3HK2CNXQ91I+1JQKbrigfQd4RsYibZTPUDIB3luJhX9E
	 eWhX6/q5eaaai/G5QCu5V4R8p7dFvt5w7NkodxOBhMkEYZomBskwmVV090EUefDbsT
	 8we5SSr+BgiwQ==
Date: Wed, 17 Sep 2025 20:52:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 2/4] kho: Adopt KHO page tables and remove serialization
Message-ID: <aMr1XAKmyfzM8RCc@kernel.org>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <20250917025019.1585041-3-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917025019.1585041-3-jasonmiu@google.com>

Hi Jason,

On Tue, Sep 16, 2025 at 07:50:17PM -0700, Jason Miu wrote:
> Transition the KHO system to use the new page table data structures
> for managing preserved memory, replacing the previous xarray-based
> approach. Remove the serialization process and the associated
> finalization and abort logic.
> 
> Update the methods for marking memory to be preserved to use the KHO
> page table hierarchy. Remove the former system of tracking preserved
> pages using an xarray-based structure.
> 
> Change the method of passing preserved memory information to the next
> kernel to be direct. Instead of serializing the memory map, place the
> physical address of the `kho_order_table`, which holds the roots of
> the KHO page tables for each order, in the FDT. Remove the explicit
> `kho_finalize()` and `kho_abort()` functions and the logic supporting
> the finalize and abort states, as they are no longer needed. This
> simplifies the KHO lifecycle.
> 
> Enable the next kernel's initialization process to read the
> `kho_order_table` address from the FDT. The kernel will then traverse
> the KHO page table structures to discover all preserved memory
> regions, reserving them to prevent early boot-time allocators from
> overwriting them.
> 
> This architectural shift to using a shared page table structure
> simplifies the KHO design and eliminates the overhead of serializing
> and deserializing the preserved memory map.
> 
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> ---
>  include/linux/kexec_handover.h |  17 --
>  kernel/kexec_handover.c        | 532 +++++----------------------------
>  2 files changed, 71 insertions(+), 478 deletions(-)
>  
> -/*
> - * TODO: __maybe_unused is added to the functions:
> - * kho_preserve_page_table()
> - * kho_walk_tables()
> - * kho_memblock_reserve()
> - * since they are not actually being called in this change.
> - * __maybe_unused will be removed in the next patch.
> - */
> -static __maybe_unused int kho_preserve_page_table(unsigned long pfn, int order)
> +static int kho_preserve_page_table(unsigned long pfn, int order)

Just merge this and the previous patch so that the patch will replace the
current preservation mechanism with a new one.

>  {
>  	unsigned long pa = PFN_PHYS(pfn);
>  
> @@ -365,8 +357,8 @@ static int __kho_walk_page_tables(int order, int level,
>  	return 0;
>  }
>  

...

> @@ -1023,12 +752,8 @@ int kho_preserve_folio(struct folio *folio)
>  {
>  	const unsigned long pfn = folio_pfn(folio);
>  	const unsigned int order = folio_order(folio);
> -	struct kho_mem_track *track = &kho_out.ser.track;
> -
> -	if (kho_out.finalized)
> -		return -EBUSY;
>  
> -	return __kho_preserve_order(track, pfn, order);
> +	return kho_preserve_page_table(pfn, order);

I don't think we should "rename" __kho_preserve_order() to
kho_preserve_page_table(). __kho_preserve_order() could use the new data
structure, or call the new implementation, but I don't see a reason to
replace it.

-- 
Sincerely yours,
Mike.

