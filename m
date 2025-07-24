Return-Path: <linux-kernel+bounces-743790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C14B1035D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49799AA4527
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED4D274B40;
	Thu, 24 Jul 2025 08:19:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB989274B31
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345166; cv=none; b=bZsjf6NHPTMPKeeSq8Vbge8xqOSMzNPjBebpoxzNkDSntqxAmi4XDYu5X69oO3J1Zx6JsGUnhh75DacDA6f5NVTW9bv632Ra8koDtc9LZINV9OWmPlJe2cCJl+eAnEij/gb8uEtb6Y36nXkPmZG8BE8H0SFinn1aAaHgEQNst1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345166; c=relaxed/simple;
	bh=RchZuciUm15G2zS8s9K4K+9fE6DfAZHQhlTLOwwAHFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4JPAmyF13bCHUxzGhh4jBd8Gq1yKm/uCwBdCn/jdAHGDNpMSaJK3sIwR/0pXCQgaWR1rfgObLpJj7M0FM1+WgCpLzNTevgdYZrEkQ7XPyWm7dCVkEj13eBBdkGI5h4pESQn4/LI+Ru0GJ/vHXehY4HgqX/V2LndgtlWtTgjUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D28C4CEED;
	Thu, 24 Jul 2025 08:19:23 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:19:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, will@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	suzuki.poulose@arm.com, steven.price@arm.com, gshan@redhat.com,
	linux-arm-kernel@lists.infradead.org, yang@os.amperecomputing.com,
	ryan.roberts@arm.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v4] arm64: Enable permission change on arm64 kernel block
 mappings
Message-ID: <aIHsiPtG0Ycm2DTe@arm.com>
References: <20250703151441.60325-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703151441.60325-1-dev.jain@arm.com>

On Thu, Jul 03, 2025 at 08:44:41PM +0530, Dev Jain wrote:
> This patch paves the path to enable huge mappings in vmalloc space and
> linear map space by default on arm64. For this we must ensure that we can
> handle any permission games on the kernel (init_mm) pagetable. Currently,
> __change_memory_common() uses apply_to_page_range() which does not support
> changing permissions for block mappings. We attempt to move away from this
> by using the pagewalk API, similar to what riscv does right now;

RISC-V seems to do the splitting as well and then use
walk_page_range_novma().

> however,
> it is the responsibility of the caller to ensure that we do not pass a
> range overlapping a partial block mapping or cont mapping; in such a case,
> the system must be able to support range splitting.

How does the caller know what the underlying mapping is? It can't really
be its responsibility, so we must support splitting at least at the
range boundaries. If you meant the caller of the internal/static
update_range_prot(), that's an implementation detail where a code
comment would suffice. But you can't require such awareness from the
callers of the public set_memory_*() API.

> This patch is tied with Yang Shi's attempt [1] at using huge mappings
> in the linear mapping in case the system supports BBML2, in which case
> we will be able to split the linear mapping if needed without
> break-before-make. Thus, Yang's series, IIUC, will be one such user of my
> patch; suppose we are changing permissions on a range of the linear map
> backed by PMD-hugepages, then the sequence of operations should look
> like the following:
> 
> split_range(start)
> split_range(end);
> __change_memory_common(start, end);

This makes sense if that's the end goal but it's not part of this patch.

> However, this patch can be used independently of Yang's; since currently
> permission games are being played only on pte mappings (due to
> apply_to_page_range not supporting otherwise), this patch provides the
> mechanism for enabling huge mappings for various kernel mappings
> like linear map and vmalloc.

Does this patch actually have any user without Yang's series?
can_set_direct_map() returns true only if the linear map uses page
granularity, so I doubt it can even be tested on its own. I'd rather see
this patch included with the actual user or maybe add it later as an
optimisation to avoid splitting the full range.

> ---------------------
> Implementation
> ---------------------
> 
> arm64 currently changes permissions on vmalloc objects locklessly, via
> apply_to_page_range, whose limitation is to deny changing permissions for
> block mappings. Therefore, we move away to use the generic pagewalk API,
> thus paving the path for enabling huge mappings by default on kernel space
> mappings, thus leading to more efficient TLB usage. However, the API
> currently enforces the init_mm.mmap_lock to be held. To avoid the
> unnecessary bottleneck of the mmap_lock for our usecase, this patch
> extends this generic API to be used locklessly, so as to retain the
> existing behaviour for changing permissions.

Is it really a significant bottleneck if we take the lock? I suspect if
we want to make this generic and allow splitting, we'll need a lock
anyway (though maybe for shorter intervals if we only split the edges).

-- 
Catalin

