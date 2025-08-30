Return-Path: <linux-kernel+bounces-792743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C288B3C85A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558D2201DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026182264AD;
	Sat, 30 Aug 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWMFUg3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008153363
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532686; cv=none; b=ChcLutiWtBEr4AhU5JDwv5qRPqX2M3sE0i0W7Xb7F/YxC9Rsh1YApCMejRPY2ix2ae1DLdhKqlEILAuNkOiCL7z3csUQ9niBg8hMcqxiQ3Mu1pfmts0RzKSi+RrjcVVptvKVxa04xJYfEtSilr8oGCEMsplsXGZfXtImWj1iRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532686; c=relaxed/simple;
	bh=JAAgjpGY4LnD9qHCp/eEXth+zGJ3X56KEMZZTsLikNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCBpScv+SePdVRECecC0W7tKd+jK3eli2PdafXpB111eiY1qxbNem/8XxNuExcFWIl9rRXy46kfIFKF0lZcg35jpE1GXdzYWtOuKfxXN1zClhWNJgPZ+hi+HT+t2L+R2hhg2U/MjHmdANKYJhyQT20c1RPn4/5FL8LWINtbbeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWMFUg3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB0EC4CEFB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 05:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756532685;
	bh=JAAgjpGY4LnD9qHCp/eEXth+zGJ3X56KEMZZTsLikNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UWMFUg3LJOwiLkQtHgLpbR/s0jbiatVR4D+gEOR7haxdgVCpziFB8wP+Ezbggx2Tw
	 fVEOfO9g3X5TGA8+fxFM0KU/Q4eFjPZvqDcL0szvTRRml9x+eIiaw5XBuLhm9kkNH6
	 zfbnMGJI+x4uU7xcuEpIKdnxNKiF93xP4cNf/G66QmnaGnpYxF4GrO1Zs9+vKm05jX
	 +hdepNRAbFWIYjEDqj3aRCJkLTidqpz7pb76d9Mh8NL5x2TXJjIMTSPFoU2GZc8UNI
	 udcDM3aFuWu8Dd4F0zpxQ/HuOj78LD3yj2T9Vl3ZazSAkZwf2mbv7vw48RmRn9RDqd
	 nvhXVNcXNl55g==
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so2306721276.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwHPoupE+OsI5NyupFVXb1d8TzGAapvizBHxFufrGQkUgwBhs4aNeAefvluxPUaLtHOyeDppSD1kzIBHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRj3bgKsvSvCZK7Xuaizm52ogb4zPYYVmoGtNjKDrvRFAtudJ
	GYVUI4YvUmdorGzGnEK1TuYb8AxIhOa1dJFLuLWjbyVQPdbY35VTbRqjO0MHOr2Ap5FDx9i3ilY
	PMYWSY/GPOpx5PIqYNGxuXm8DWgmQLZCquFnknFohAQ==
X-Google-Smtp-Source: AGHT+IGBuw0zUEaS/k3FaNLIrAlUM66nz8Ry+tT0hWwVrbIuk4oM2OkbRh/ItCe5ADh3CHqQFbIabVR8pVK5iOSWh2I=
X-Received: by 2002:a05:690c:7010:b0:722:6a6c:c018 with SMTP id
 00721157ae682-722764144a2mr13000437b3.22.1756532684812; Fri, 29 Aug 2025
 22:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-1-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 22:44:33 -0700
X-Gmail-Original-Message-ID: <CACePvbWG85YJFpLDoFnz05tX2trUJFTzyuELMGYSYr5ye_hQ6w@mail.gmail.com>
X-Gm-Features: Ac12FXyc2t-Od0jf3RsI5Vjrf0kkIxGnlpzePUlvZXp-qWCwaxbjAyMPCKLD-jo
Message-ID: <CACePvbWG85YJFpLDoFnz05tX2trUJFTzyuELMGYSYr5ye_hQ6w@mail.gmail.com>
Subject: Re: [PATCH 0/9] mm, swap: introduce swap table as swap cache (phase I)
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

I give one pass of review on your series already. I Ack a portion of
it. I expect some clarification or update on the rest.

I especially want to double check the swap cache atomic set a range of
swap entries to folio.
I want to make sure this bug does not happen to swap table:
https://lore.kernel.org/linux-mm/5bee194c-9cd3-47e7-919b-9f352441f855@kerne=
l.dk/

I just double checked, the swap table should be fine in this regard.
The bug is triggered by memory allocation failure in the middle of
insert folio. Swap tables already populated the table when the swap
entry is allocated and handed out to the caller. We don't do memory
allocation when inserting folio into swap cache, which is a good
thing. We should not have that bug.

I also want some extra pair of eyes on those subtle behavior change
patches, I expect you to split them out in the next version.
I will need to go through the split out subtle patch one more time as
well. This pass I only catch the behavior change, haven't got a chance
to reason those behavior changes patches are indeed fine. If you can
defer those split out patches, that will save me some time to reason
them on the next round. Your call.

Oh, I also want to write a design document for the swap table idea. I
will send it your way to incorporate into your next version of the
series.

Thanks for the great work! I am very excited about this.

Chris

On Fri, Aug 22, 2025 at 12:20=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> This is the first phase of the bigger series implementing basic
> infrastructures for the Swap Table idea proposed at the LSF/MM/BPF
> topic "Integrate swap cache, swap maps with swap allocator" [1].
>
> This phase I contains 9 patches, introduces the swap table infrastructure
> and uses it as the swap cache backend. By doing so, we have up to ~5-20%
> performance gain in throughput, RPS or build time for benchmark and
> workload tests. This is based on Chris Li's idea of using cluster size
> atomic arrays to implement swap cache. It has less contention on the swap
> cache access. The cluster size is much finer-grained than the 64M address
> space split, which is removed in this phase I. It also unifies and cleans
> up the swap code base.
>
> Each swap cluster will dynamically allocate the swap table, which is an
> atomic array to cover every swap slot in the cluster. It replaces the swa=
p
> cache back by Xarray. In phase I, the static allocated swap_map still
> co-exists with the swap table. The memory usage is about the same as the
> original on average. A few exception test cases show about 1% higher in
> memory usage. In the following phases of the series, swap_map will merge
> into the swap table without additional memory allocation. It will result
> in net memory reduction compared to the original swap cache.
>
> Testing has shown that phase I has a significant performance improvement
> from 8c/1G ARM machine to 48c96t/128G x86_64 servers in many practical
> workloads.
>
> The full picture with a summary can be found at [2]. An older bigger
> series of 28 patches is posted at [3].
>
> vm-scability test:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Test with:
> usemem --init-time -O -y -x -n 31 1G (4G memcg, PMEM as swap)
>                 Before:         After:
> System time:    220.86s         160.42s      (-27.36%)
> Throughput:     4775.18 MB/s    6381.43 MB/s (+33.63%)
> Free latency:   174492 us       132122 us    (+24.28%)
>
> usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
> PMEM as swap)
>                 Before:         After:
> System time:    355.23s         295.28s      (-16.87%)
> Throughput:     4659.89 MB/s    5765.80 MB/s (+23.73%)
> Free latency:   500417 us       477098 us     (-4.66%)
>
> This shows an improvement of more than 20% improvement in most readings.
>
> Build kernel test:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Building kernel with defconfig on tmpfs with ZSWAP / ZRAM is looking
> good. The results below show a test matrix using different memory
> pressure and setups. Tests are done with shmem as filesystem and
> using the same build config, measuring sys and real time in seconds
> (user time is almost identical as expected):
>
>  -j<NR> / Mem  | Sys before / after  | Real before / after
> Using 16G ZRAM with memcg limit:
>      12 / 256M | 6475 / 6232  -3.75% | 814 / 793   -2.58%
>      24 / 384M | 5904 / 5560  -5.82% | 413 / 397   -3.87%
>      48 / 768M | 4762 / 4242  -10.9% | 187 / 179   -4.27%
> With 64k folio:
>      24 / 512M | 4196 / 4062  -3.19% | 325 / 319   -1.84%
>      48 / 1G   | 3622 / 3544  -2.15% | 148 / 146   -1.37%
> With ZSWAP with 3G memcg (using higher limit due to kmem account):
>      48 / 3G   |  605 /  571  -5.61% |  81 /  79   -2.47%
>
> For extremely high pressure global pressure, using ZSWAP with 32G
> NVMEs in a 48c VM that has 4G memory globally, no memcg limit, system
> components take up about 1.5G so the pressure is high, using make -j48:
>
> Before:  sys time: 2061.72s            real time: 135.61s
> After:   sys time: 1990.96s (-3.43%)   real time: 134.03s (-1.16%)
>
> All cases are faster, and no regression even under heavy global
> memory pressure.
>
> Redis / Valkey bench:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The test machine is a ARM64 VM with 1.5G memory, redis is set to
> use 2.5G memory:
>
> Testing with:
> redis-benchmark -r 2500000 -n 2500000 -d 1024 -c 12 -P 32 -t get
>
>                 no BGSAVE                with BGSAVE
> Before:         433015.08 RPS            271421.15 RPS
> After:          431537.61 RPS (-0.34%)   290441.79 RPS (+7.0%)
>
> Testing with:
> redis-benchmark -r 2000000 -n 2000000 -d 1024 -c 12 -P 32 -t get
>                 no BGSAVE                with BGSAVE
> Before:         446339.45 RPS            274845.19 RPS
> After:          442697.29 RPS (-0.81%)   293053.59 RPS (+6.6%)
>
> With BGSAVE enabled, most Redis memory will have a swap count > 1 so
> swap cache is heavily in use. We can see a >5% performance. No BGSAVE
> is very slightly slower (<1%) due to the higher memory pressure of the
> co-existence of swap_map and swap table. This will be optimzed into a
> net gain and up to 20% gain in BGSAVE case in the following phases.
>
> Link: https://lore.kernel.org/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXHGBnf=
isCAb8VA@mail.gmail.com [1]
> Link: https://github.com/ryncsn/linux/tree/kasong/devel/swap-table [2]
> Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmai=
l.com/ [3]
>
> Kairui Song (9):
>   mm, swap: use unified helper for swap cache look up
>   mm, swap: always lock and check the swap cache folio before use
>   mm, swap: rename and move some swap cluster definition and helpers
>   mm, swap: tidy up swap device and cluster info helpers
>   mm/shmem, swap: remove redundant error handling for replacing folio
>   mm, swap: use the swap table for the swap cache and switch API
>   mm, swap: remove contention workaround for swap cache
>   mm, swap: implement dynamic allocation of swap table
>   mm, swap: use a single page for swap table when the size fits
>
>  MAINTAINERS          |   1 +
>  include/linux/swap.h |  42 ----
>  mm/filemap.c         |   2 +-
>  mm/huge_memory.c     |  16 +-
>  mm/memory-failure.c  |   2 +-
>  mm/memory.c          |  30 +--
>  mm/migrate.c         |  28 +--
>  mm/mincore.c         |   3 +-
>  mm/page_io.c         |  12 +-
>  mm/shmem.c           |  56 ++----
>  mm/swap.h            | 268 +++++++++++++++++++++----
>  mm/swap_state.c      | 404 +++++++++++++++++++-------------------
>  mm/swap_table.h      | 136 +++++++++++++
>  mm/swapfile.c        | 456 ++++++++++++++++++++++++++++---------------
>  mm/userfaultfd.c     |   5 +-
>  mm/vmscan.c          |  20 +-
>  mm/zswap.c           |   9 +-
>  17 files changed, 954 insertions(+), 536 deletions(-)
>  create mode 100644 mm/swap_table.h
>
> ---
>
> I was trying some new tools like b4 for branch management, and it seems
> a draft version was sent out by accident, but seems got rejected. I'm
> not sure if anyone is seeing duplicated or a malformed email. If so,
> please accept my apology and use this series for review, discussion
> or merge.
>
> --
> 2.51.0
>

