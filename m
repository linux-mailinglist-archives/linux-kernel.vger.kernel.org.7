Return-Path: <linux-kernel+bounces-883396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F30C2D536
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DF51898715
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10331B80C;
	Mon,  3 Nov 2025 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5oNCpeX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5531B11F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189051; cv=none; b=AjIB67qfayRC95Sc1LC7grykXMFy4rwDS2shk+2yhhmY0PRo6D1qht/zDNRvSNf7I6iN7LogK5UzfIfyERYjduuIAN8tMokrCC2NPgxtmD29RO/R9VvW4T2rFX1+SVQJWnrkAfM3dd0rVJlzUvd64CiAD0jsHvtSMHZX01CxNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189051; c=relaxed/simple;
	bh=UXbyL0c4gAKXyaDUG6J01Z7qz3xy2A7gPJAePIXHk4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/uOhCZi0LuUdci/vPStyoLsAt4O1raO4ELUBP9dETkaY8aY76rcDM7qoOS6pu3NYJYA77Ft8UN7bo2aIxA6Nw89k7lffIdMNPGE/47D00WBlnfETqpft5IHPpkXTkOyPUvvXT1i4q2/IH694+JTL/BkGOAlvapJkonQFDBoefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5oNCpeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D7C4CEE7;
	Mon,  3 Nov 2025 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189051;
	bh=UXbyL0c4gAKXyaDUG6J01Z7qz3xy2A7gPJAePIXHk4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5oNCpeXpk2uZyGZqBHEsvT/hu0avc8wvFDKDf/GNIctuNY4LZzu7oKF3BcrtP152
	 krdL00sj+nAvuQJ7luVVgQZBHtZLG+ESOvSYRXYtd9okIy9M1kuE4DJ8+BtrrOcay0
	 hxJtbn+ZQSFnv5Dk4evrInz5BKWwCvw9qLMCNPM5TgR9adqRa0ua75zNlC15uhXUyq
	 arfewDLc70AnhMi5JT+O/G3ShaUUNkej4oHy9sxxYAunMtwrAlnlKxfiC9kME8LDXe
	 wpfQqZFeNAEnF+mJNTKDYKMtOdbaWXl14nGiYny7DOAMOLe9+1892E8GGaFEn7AtvV
	 C8V3fDWrEBf9g==
Date: Mon, 3 Nov 2025 18:57:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix out-of-bounds access of vmalloc chunk
Message-ID: <aQje9CFnTymbkUlM@kernel.org>
References: <20251103110159.8399-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103110159.8399-1-pratyush@kernel.org>

On Mon, Nov 03, 2025 at 12:01:57PM +0100, Pratyush Yadav wrote:
> The list of pages in a vmalloc chunk is NULL-terminated. So when looping
> through the pages in a vmalloc chunk, both kho_restore_vmalloc() and
> kho_vmalloc_unpreserve_chunk() rightly make sure to stop when
> encountering a NULL page. But when the chunk is full, the loops do not
> stop and go past the bounds of chunk->phys, resulting in out-of-bounds
> memory access, and possibly the restoration or unpreservation of an
> invalid page.
> 
> Fix this by making sure the processing of chunk stops at the end of the
> array.
> 
> Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Commit 89a3ecca49ee8 ("kho: make sure page being restored is actually
>     from KHO") was quite helpful in catching this since kho_restore_page()
>     errored out due to missing magic number, instead of "restoring" a random
>     page and causing errors at other random places.
> 
>  kernel/kexec_handover.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 76f0940fb4856..cc5aaa738bc50 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -869,7 +869,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
>  
>  	__kho_unpreserve(track, pfn, pfn + 1);
>  
> -	for (int i = 0; chunk->phys[i]; i++) {
> +	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
>  		pfn = PHYS_PFN(chunk->phys[i]);
>  		__kho_unpreserve(track, pfn, pfn + 1);
>  	}
> @@ -992,7 +992,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  	while (chunk) {
>  		struct page *page;
>  
> -		for (int i = 0; chunk->phys[i]; i++) {
> +		for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
>  			phys_addr_t phys = chunk->phys[i];
>  
>  			if (idx + contig_pages > total_pages)
> 
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

