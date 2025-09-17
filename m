Return-Path: <linux-kernel+bounces-821337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF7B80FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEC5189E385
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53112F39DA;
	Wed, 17 Sep 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Efgoo/3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D82BE655
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126562; cv=none; b=mVoWCEHGX94Zu9YKu076v1UwzFTL5g57/eLOTkhsRhsdtidYuhcJAD/MQ9xWVU+aNnEylYU3dlzyR2qxkLxhK9RAO6sYQnai1xblhSUTQXpiLsmZgarEs/Iw9lkDEdCEwfbcVfV0AlJKAftH2dNqhz3CfwyeNklaQ4JtF84Nw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126562; c=relaxed/simple;
	bh=2OcN4+QE4vB9KSX+x87Cdk3l913EKng1ECYM1XJ4iNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQwFzDDvrvWV37vk2MfOzRXR+Bp3J2kxw8ePCtDH3coQMdDa/bhnlto0FwQ92Dj86vB+Wgb5q8GovVNR2JpqJZVS1+zP2/cL/O/sxge2Whi9R8tb+ZQD4FDBX/q34r0F0ZlD4GhwAUjtwCjfdiArNmnfOqXZQebWzZ5TuJ9VQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Efgoo/3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591F7C4CEE7;
	Wed, 17 Sep 2025 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758126560;
	bh=2OcN4+QE4vB9KSX+x87Cdk3l913EKng1ECYM1XJ4iNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Efgoo/3O0LeCmXH1rE1DrgEshaiVcNwoiGdG8gPR/qVy13CnvZhy67MLqQDbd1Nwu
	 enTVAYHlzhaquq3xtN8aHEQJ43+ZMLVMdsXkEZIa+HcUfpRIV1k0dv2gdUGFQ4LcPp
	 MLXKrgn89SIv2BNKLnINxK6b+AQdHaO1/9YvsrzW1bPzB0zZ+PH9NwTAvEnOWPivsk
	 e1H/U0OCmG9hQDwRJ7dblDd0FZeTJpXJgS/cWqhzztqV2KHa56zWXi5lbfUt7zGwOX
	 qsfIETUK9/JSo5CI5A/DO3GDqdyjekXMCAuVzOxn4Llo0FK3St0PJRf7PEYyzQJCps
	 sptrXw5WzO+QA==
Date: Wed, 17 Sep 2025 13:29:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	namhyung@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v7 00/16] mm: folio_zero_user: clear contiguous pages
Message-ID: <aMrh3h1gCIyYz873@x1>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>

On Wed, Sep 17, 2025 at 08:24:02AM -0700, Ankur Arora wrote:
> This series adds clearing of contiguous page ranges for hugepages,
> improving on the current page-at-a-time approach in two ways:
> 
>  - amortizes the per-page setup cost over a larger extent
> 
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
>                  mm/folio_zero_user    x86/folio_zero_user       change
>                   (GB/s  +- %stdev)     (GB/s  +- %stdev)
> 
>    pg-sz=2MB       11.82  +- 0.67%        16.48  +-  0.30%       + 39.4%	preempt=*
> 
>    pg-sz=1GB       17.14  +- 1.39%        17.42  +-  0.98% [#]   +  1.6%	preempt=none|voluntary
>    pg-sz=1GB       17.51  +- 1.19%        43.23  +-  5.22%       +146.8%	preempt=full|lazy
> 
> [#] Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
> allocation, which is higher than the maximum extent used on x86
> (ARCH_CONTIG_PAGE_NR=8MB), so preempt=none|voluntary sees no improvement
> with pg-sz=1GB.

I'm picking up the tools/perf part for perf-tools-next (v6.18), already
almost 100% reviewed by Namhyung.

Thanks,

- Arnaldo
 
> Raghavendra also tested v3/v4 on AMD Genoa and sees similar improvements [1].
> 
> Changelog:
> 
> v7:
>  - interface cleanups, comments for clear_user_highpages(), clear_user_pages(),
>    clear_pages().
>  - fixed build errors flagged by kernel test robot
>  - move all x86 patches to the tail end
> 
> v6:
>  - perf bench mem: update man pages and other cleanups (Namhyung Kim)
>  - unify folio_zero_user() for HIGHMEM, !HIGHMEM options instead of
>    working through a new config option (David Hildenbrand).
>    - cleanups and simlification around that.
>  (https://lore.kernel.org/lkml/20250902080816.3715913-1-ankur.a.arora@oracle.com/)
> 
> v5:
>  - move the non HIGHMEM implementation of folio_zero_user() from x86
>    to common code (Dave Hansen)
>  - Minor naming cleanups, commit messages etc
>  (https://lore.kernel.org/lkml/20250710005926.1159009-1-ankur.a.arora@oracle.com/)
> 
> v4:
>  - adds perf bench workloads to exercise mmap() populate/demand-fault (Ingo)
>  - inline stosb etc (PeterZ)
>  - handle cooperative preemption models (Ingo)
>  - interface and other cleanups all over (Ingo)
>  (https://lore.kernel.org/lkml/20250616052223.723982-1-ankur.a.arora@oracle.com/)
> 
> v3:
>  - get rid of preemption dependency (TIF_ALLOW_RESCHED); this version
>    was limited to preempt=full|lazy.
>  - override folio_zero_user() (Linus)
>  (https://lore.kernel.org/lkml/20250414034607.762653-1-ankur.a.arora@oracle.com/)
> 
> v2:
>  - addressed review comments from peterz, tglx.
>  - Removed clear_user_pages(), and CONFIG_X86_32:clear_pages()
>  - General code cleanup
>  (https://lore.kernel.org/lkml/20230830184958.2333078-1-ankur.a.arora@oracle.com/)
> 
> Comments appreciated!
> 
> Also at:
>   github.com/terminus/linux clear-pages.v7
> 
> [1] https://lore.kernel.org/lkml/fffd4dad-2cb9-4bc9-8a80-a70be687fd54@amd.com/
> 
> Ankur Arora (16):
>   perf bench mem: Remove repetition around time measurement
>   perf bench mem: Defer type munging of size to float
>   perf bench mem: Move mem op parameters into a structure
>   perf bench mem: Pull out init/fini logic
>   perf bench mem: Switch from zalloc() to mmap()
>   perf bench mem: Allow mapping of hugepages
>   perf bench mem: Allow chunking on a memory region
>   perf bench mem: Refactor mem_options
>   perf bench mem: Add mmap() workloads
>   mm: define clear_pages(), clear_user_pages()
>   mm/highmem: introduce clear_user_highpages()
>   arm: mm: define clear_user_highpages()
>   mm: memory: support clearing page ranges
>   x86/mm: Simplify clear_page_*
>   x86/clear_page: Introduce clear_pages()
>   x86/clear_pages: Support clearing of page-extents
> 
>  arch/arm/include/asm/page.h                  |   7 +
>  arch/x86/include/asm/page_32.h               |   6 +
>  arch/x86/include/asm/page_64.h               |  72 +++-
>  arch/x86/lib/clear_page_64.S                 |  39 +-
>  include/linux/highmem.h                      |  18 +
>  include/linux/mm.h                           |  44 +++
>  mm/memory.c                                  |  82 +++-
>  tools/perf/Documentation/perf-bench.txt      |  58 ++-
>  tools/perf/bench/bench.h                     |   1 +
>  tools/perf/bench/mem-functions.c             | 390 ++++++++++++++-----
>  tools/perf/bench/mem-memcpy-arch.h           |   2 +-
>  tools/perf/bench/mem-memcpy-x86-64-asm-def.h |   4 +
>  tools/perf/bench/mem-memset-arch.h           |   2 +-
>  tools/perf/bench/mem-memset-x86-64-asm-def.h |   4 +
>  tools/perf/builtin-bench.c                   |   1 +
>  15 files changed, 560 insertions(+), 170 deletions(-)
> 
> -- 
> 2.43.5

