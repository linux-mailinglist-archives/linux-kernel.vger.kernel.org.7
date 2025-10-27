Return-Path: <linux-kernel+bounces-872609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B9C11910
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0007C3533A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F81328627;
	Mon, 27 Oct 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rR+bjFln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A72F25E5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600791; cv=none; b=VB/X9QtEaUeZDEbxU89fLGHApQe9MEeH3U213V6IOM3dyb2oCeeM1Go/RuSxWpBDtpruE0IG4fh3Q+BiRVFfzLjVwYVrwbrXyy9Yr+/fk4jVXzXoWNlO5Jfr/4zFYeiwMtB5c5qbCEg2BJw2Op7YF2RO4roz8WrfNKHXvwU9Jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600791; c=relaxed/simple;
	bh=8GggW/uCYLmuf2ftOvfd6WSM03QRKgQBORqkMrFcff8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=flROZ0TTMQvHC+vFg236kQHCGOwRFFQ7wy0gZH3PYoNKIWMirEzXW0u3QG1ksXgFQgl77i2KnGw9Oqbn47E0F9Jk+zmjexXnNzJ9cPR67ZkglG/Von4cWdbzVrOMqavs6uZye73WSbNCwjEXras8Ha/KXrPNNZlTnW1T77/hb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rR+bjFln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC190C4CEFD;
	Mon, 27 Oct 2025 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761600790;
	bh=8GggW/uCYLmuf2ftOvfd6WSM03QRKgQBORqkMrFcff8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rR+bjFlni2Cty7mzb7s4chDTQ2uLP+zOUAUbVoQR2VAUDLjacPhceY1ugFXPI1+pe
	 vHS5yGwrQjCNfRGrzMKDbiDNpn0Dy+CINCttVGv2synAWVbnhLSH0wUaaAEdVE7A9s
	 PU9RbBDofsXM3sKyM2CAnpZrjKDSFMGSUlyOEoNk=
Date: Mon, 27 Oct 2025 14:33:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
 acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 willy@infradead.org, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v8 0/7] mm: folio_zero_user: clear contiguous pages
Message-Id: <20251027143309.4331a65f38f05ea95d9e46ad@linux-foundation.org>
In-Reply-To: <20251027202109.678022-1-ankur.a.arora@oracle.com>
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 13:21:02 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:

> This series adds clearing of contiguous page ranges for hugepages,
> improving on the current page-at-a-time approach in two ways:
> 
>  - amortizes the per-page setup cost over a larger extent
>  - when using string instructions, exposes the real region size
>    to the processor.
> 
> A processor could use a knowledge of the extent to optimize the
> clearing. AMD Zen uarchs, as an example, elide allocation of
> cachelines for regions larger than L3-size.
> 
> Demand faulting a 64GB region shows performance improvements:
> 
>  $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5
> 
>                        baseline              +series             change
> 
>                   (GB/s  +- %stdev)     (GB/s  +- %stdev)
> 
>    pg-sz=2MB       12.92  +- 2.55%        17.03  +-  0.70%       + 31.8%	preempt=*
> 
>    pg-sz=1GB       17.14  +- 2.27%        18.04  +-  1.05% [#]   +  5.2%	preempt=none|voluntary
>    pg-sz=1GB       17.26  +- 1.24%        42.17  +-  4.21%       +144.3%	preempt=full|lazy
> 
> [#] Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
> allocation, which is higher than the maximum extent used on x86
> (ARCH_CONTIG_PAGE_NR=8MB), so preempt=none|voluntary sees no improvement
> with pg-sz=1GB.

I wasn't understanding this preemption thing at all, but then I saw this
in the v4 series changelogging:

: [#] Only with preempt=full|lazy because cooperatively preempted models
: need regular invocations of cond_resched(). This limits the extent
: sizes that can be cleared as a unit.

Please put this back in!!

It's possible that we're being excessively aggressive with those
cond_resched()s.  Have you investigating tuning their frequency so we
can use larger extent sizes with these preemption models?

> The anon-w-seq test in the vm-scalability benchmark, however, does show
> worse performance with utime increasing by ~9%:
> 
>                          stime                  utime
> 
>   baseline         1654.63 ( +- 3.84% )     811.00 ( +- 3.84% )
>   +series          1630.32 ( +- 2.73% )     886.37 ( +- 5.19% )
> 
> In part this is because anon-w-seq runs with 384 processes zeroing
> anonymously mapped memory which they then access sequentially. As
> such this is a likely uncommon pattern where the memory bandwidth
> is saturated while also being cache limited because we access the
> entire region.
> 
> Raghavendra also tested previous version of the series on AMD Genoa [1].

I suggest you paste Raghavendra's results into this [0/N] - it's
important material.  

> 
> ...
>
>  arch/alpha/include/asm/page.h      |  1 -
>  arch/arc/include/asm/page.h        |  2 +
>  arch/arm/include/asm/page-nommu.h  |  1 -
>  arch/arm64/include/asm/page.h      |  1 -
>  arch/csky/abiv1/inc/abi/page.h     |  1 +
>  arch/csky/abiv2/inc/abi/page.h     |  7 ---
>  arch/hexagon/include/asm/page.h    |  1 -
>  arch/loongarch/include/asm/page.h  |  1 -
>  arch/m68k/include/asm/page_mm.h    |  1 +
>  arch/m68k/include/asm/page_no.h    |  1 -
>  arch/microblaze/include/asm/page.h |  1 -
>  arch/mips/include/asm/page.h       |  1 +
>  arch/nios2/include/asm/page.h      |  1 +
>  arch/openrisc/include/asm/page.h   |  1 -
>  arch/parisc/include/asm/page.h     |  1 -
>  arch/powerpc/include/asm/page.h    |  1 +
>  arch/riscv/include/asm/page.h      |  1 -
>  arch/s390/include/asm/page.h       |  1 -
>  arch/sparc/include/asm/page_32.h   |  2 +
>  arch/sparc/include/asm/page_64.h   |  1 +
>  arch/um/include/asm/page.h         |  1 -
>  arch/x86/include/asm/page.h        |  6 ---
>  arch/x86/include/asm/page_32.h     |  6 +++
>  arch/x86/include/asm/page_64.h     | 64 ++++++++++++++++++-----
>  arch/x86/lib/clear_page_64.S       | 39 +++-----------
>  arch/xtensa/include/asm/page.h     |  1 -
>  include/linux/highmem.h            | 29 +++++++++++
>  include/linux/mm.h                 | 69 +++++++++++++++++++++++++
>  mm/memory.c                        | 82 ++++++++++++++++++++++--------
>  mm/util.c                          | 13 +++++
>  30 files changed, 247 insertions(+), 91 deletions(-)

I guess this is an mm.git thing, with x86 acks (please).

The documented review activity is rather thin at this time so I'll sit
this out for a while.  Please ping me next week and we can reassess,

Thanks.

