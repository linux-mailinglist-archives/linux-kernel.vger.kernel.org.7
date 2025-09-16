Return-Path: <linux-kernel+bounces-819198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED29B59CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48552A5E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30212475D0;
	Tue, 16 Sep 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyaWtIkc"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC78221F2D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038475; cv=none; b=G7qndcOp7+T/rgWF6GRi7IRbeT27lKSHltkixSNShDqESjG5ZfXj1pfmfgBSXRAIXBTxg/CwmLtQpaEAYYVf9knFCumJTYmb7YvkhmVZBl7sR1P6XL+QQ9V1py0mUE467lNgbtBrTAB8AsfBsNYtBWF2TGzqSvzjUihqR+QqFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038475; c=relaxed/simple;
	bh=ehh+x7F82YnbhP8wpgEKD23l4G1leFHW/MgDFkUnTY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADh4qa2eg/sUj7W4OJwwDGtIuTOQehI8fUlEGAAUf91bzNmbdfZ/o7y/Tv7HqqDXzcLY+MPAziykug/X9m6iV4+uKOSQHs2/IN9BIRIWmf/W4iaQli2XV2kMmIkOyn/kVBeR/ZmAiprpZbhlnaDRA/HAecuF2NldQ7SQGSXMCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyaWtIkc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80bdff6d1e4so569477185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038472; x=1758643272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roSrBUiptUqCvo81j/12CQVCTZ4voh4/ricWVmOwqGg=;
        b=GyaWtIkcPv+U7oqHm3aGHrCgAfj461VB3Sg/67flR8ZeOcWEjIVwUhpDx9bJ4GQ5Dr
         Ua45HYACF2dOxIgGMhwYvoPGexa42+2uRX/EkYeZ65bzcFJlzECjNO5eDvJLXa/N0qgs
         82gNcI1bEIbta2pLH72j02sxnv8uH+KJ+dRjTVIU1e/7qa41qkweSn67QcA5qKnaNUXs
         lv7sIQh1SwTzj0lsRtBixLLLz5sZ1KxwGGDacT7t6NwZVrv92kECdVhXqtA3HXMO5XUa
         FjKbvWMZ6Cvcv22VW0I9gT0U6sSL8slHqzgyuTSL+CIUKwHzXoFC+6KoOLfKGPH94eEK
         FRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038472; x=1758643272;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roSrBUiptUqCvo81j/12CQVCTZ4voh4/ricWVmOwqGg=;
        b=pR7rgNLe2YXh6nGJ7PlgnOYB0HIrK9NXDc0Kq3PKZ+UJMkTGfQvNBlpMXJeWkIjFWY
         ITNwEWZfKojUvW0EV0m+9OinrOKjL+nWJVwUiyRFCid7gIlrVjhUMam3E4ZQB4+C08Z8
         m1nI8fLthQUFAZgpc3k3aRa3XWr40HqK0Dzlm2bfK29WIJ/qIS2GePdb1kETxrnjs0JS
         39F4zCRXTxT07sY2QjlQuC/4B3K0SZuJhQIGnsBHkE48+fV83xo5bavT3kCohxVy1Q5N
         iEwqwghADB4Y4vzPGccGsbdGcbbH1PouqPYaFSmq5u9T/oF37niWvTtuYpyNnpZt50od
         WYAw==
X-Forwarded-Encrypted: i=1; AJvYcCXZe85TybFiTCAwxkr9lio5HSDvftF5ztJyv75YR+kDFk/mtPKZXe3M5AxN0f0jbusB6Vz6dO0U8Ukxt5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuipBJNSfj9N59eT73W27Fp/HCG/NNfZCNsxfCEpSiCPTv1i3/
	fGCnolAed1M6cmyshKIggJKWDqYg+bLs2bpXt40cVtxyEnE6iOFe3ydy
X-Gm-Gg: ASbGncsmrGXWY6qMaV9w9fSkzDLyFEj0kXRuWL9yHoaLW5CPDYslNxZIxxFf4Jvj2zp
	sT4fCrzlUqFoNnYdsuB/huFBRG2FJYyPyVJJVGZWCnSbKojT1YNenbw14VC9TMuHfKWg/6LkS5y
	5qwDkL33wSpWxtmDDRdc6d3v7iqYiH5X1o5DYr7Z4F7pXIQJ6FJvk3ckXyb4IpptDXOVd+UTMz/
	iNwSVF/ItQiUhjdPrTU8ecuGKV9KzHjDPwqhsOZdKh3wUXjyYP4RdNMxNsvHiItXLlmg1kGCLeP
	xMrqIQkc5BWSWF6C3t4qSxOf3R+VDfr2duvOfucVl3HUGZGfFFk5tWKVdClW5bTDkJF2WZXmS8R
	BG3H7Mty/8rNDq+aSS9oyYepliFS54h3JlyMpJz433fLEmVc=
X-Google-Smtp-Source: AGHT+IHHaxQRdPG3/CL6pIcL2Su+yiJOc4pkV6nWx4yNEubxZJ6DzR4Gs7mcPWzKwFbdZ0zJmcQH9w==
X-Received: by 2002:a05:620a:1910:b0:827:3b4:181a with SMTP id af79cd13be357-82703b418afmr1490008985a.55.1758038471264;
        Tue, 16 Sep 2025 09:01:11 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.01.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:01:10 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 00/15] mm, swap: introduce swap table as swap cache (phase I)
Date: Wed, 17 Sep 2025 00:00:45 +0800
Message-ID: <20250916160100.31545-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This is the first phase of the bigger series implementing basic
infrastructures for the Swap Table idea proposed at the LSF/MM/BPF
topic "Integrate swap cache, swap maps with swap allocator" [1].
To give credit where it is due, this is based on Chris Li's
idea and a prototype of using cluster size atomic arrays to
implement swap cache.

This phase I contains 15 patches, introduces the swap table infrastructure
and uses it as the swap cache backend. By doing so, we have up to ~5-20%
performance gain in throughput, RPS or build time for benchmark and
workload tests. The speed up is due to less contention on the swap
cache access and shallower swap cache lookup path. The cluster size
is much finer-grained than the 64M address space split, which is removed
in this phase I. It also unifies and cleans up the swap code base.

Each swap cluster will dynamically allocate the swap table, which is an
atomic array to cover every swap slot in the cluster. It replaces the swap
cache backed by XArray. In phase I, the static allocated swap_map still
co-exists with the swap table. The memory usage is about the same as the
original on average. A few exception test cases show about 1% higher in
memory usage. In the following phases of the series, swap_map will merge
into the swap table without additional memory allocation. It will result
in net memory reduction compared to the original swap cache.

Testing has shown that phase I has a significant performance improvement
from 8c/1G ARM machine to 48c96t/128G x86_64 servers in many practical
workloads.

The full picture with a summary can be found at [2]. An older bigger
series of 28 patches is posted at [3].

vm-scability test:
==================
Test with:
usemem --init-time -O -y -x -n 31 1G (4G memcg, PMEM as swap)
                           Before:         After:
System time:               219.12s         158.16s        (-27.82%)
Sum Throughput:            4767.13 MB/s    6128.59 MB/s   (+28.55%)
Single process Throughput: 150.21 MB/s     196.52 MB/s    (+30.83%)
Free latency:              175047.58 us    131411.87 us   (-24.92%)

usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
PMEM as swap)
                           Before:         After:
System time:               356.16s         284.68s      (-20.06%)
Sum Throughput:            4648.35 MB/s    5453.52 MB/s (+17.32%)
Single process Throughput: 141.63 MB/s     168.35 MB/s  (+18.86%)
Free latency:              499907.71 us    484977.03 us (-2.99%)

This shows an improvement of more than 20% improvement in most readings.

Build kernel test:
==================
The following result matrix is from building kernel with defconfig on
tmpfs with ZSWAP / ZRAM, using different memory pressure and setups.
Measuring sys and real time in seconds, less is better
(user time is almost identical as expected):

 -j<NR> / Mem  | Sys before / after  | Real before / after
Using 16G ZRAM with memcg limit:
     6  / 192M | 9686 / 9472  -2.21% | 2130  / 2096   -1.59%
     12 / 256M | 6610 / 6451  -2.41% |  827  /  812   -1.81%
     24 / 384M | 5938 / 5701  -3.37% |  414  /  405   -2.17%
     48 / 768M | 4696 / 4409  -6.11% |  188  /  182   -3.19%
With 64k folio:
     24 / 512M | 4222 / 4162  -1.42% |  326  /  321   -1.53%
     48 / 1G   | 3688 / 3622  -1.79% |  151  /  149   -1.32%
With ZSWAP with 3G memcg (using higher limit due to kmem account):
     48 / 3G   |  603 /  581  -3.65% |  81   /   80   -1.23%

Testing extremely high global memory and schedule pressure: Using ZSWAP
with 32G NVMEs in a 48c VM that has 4G memory, no memcg limit, system
components take up about 1.5G already, using make -j48 to build
defconfig:

Before:  sys time: 2069.53s            real time: 135.76s
After:   sys time: 2021.13s (-2.34%)   real time: 134.23s (-1.12%)

On another 48c 4G memory VM, using 16G ZRAM as swap, testing make
-j48 with same config:

Before:  sys time: 1756.96s            real time: 111.01s
After:   sys time: 1715.90s (-2.34%)   real time: 109.51s (-1.35%)

All cases are more or less faster, and no regression even under
extremely heavy global memory pressure.

Redis / Valkey bench:
=====================
The test machine is a ARM64 VM with 1536M memory 12 cores, Redis
is set to use 2500M memory, and ZRAM swap size is set to 5G:

Testing with:
redis-benchmark -r 2000000 -n 2000000 -d 1024 -c 12 -P 32 -t get

                no BGSAVE                with BGSAVE
Before:         487576.06 RPS            280016.02 RPS
After:          487541.76 RPS (-0.01%)   300155.32 RPS (+7.19%)

Testing with:
redis-benchmark -r 2500000 -n 2500000 -d 1024 -c 12 -P 32 -t get
                no BGSAVE                with BGSAVE
Before:         466789.59 RPS            281213.92 RPS
After:          466402.89 RPS (-0.08%)   298411.84 RPS (+6.12%)

With BGSAVE enabled, most Redis memory will have a swap count > 1 so
swap cache is heavily in use. We can see a about 6% performance gain.
No BGSAVE is very slightly slower (<0.1%) due to the higher memory
pressure of the co-existence of swap_map and swap table. This will be
optimzed into a net gain and up to 20% gain in BGSAVE case in the
following phases.

HDD swap is also ~40% faster with usemem because we removed an old
contention workaround.

Link: https://lore.kernel.org/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXHGBnfisCAb8VA@mail.gmail.com [1]
Link: https://github.com/ryncsn/linux/tree/kasong/devel/swap-table [2]
Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [3]

Suggested-by: Chris Li <chrisl@kernel.org>

---
V4 changes:
- Patch 14: fix potential cluster leak when attemp a sleep allocation of
  swap table: Just remove the logic that check and return the percpu
  cluster, it was trying to avoid fragmentation, which wasn't very
  successfully and may not work at all if there are multiple devices.
  The fragmentation is not a serious issue and given the chance of
  hitting that race is extremely low, let's just ignore that [ Chris Meson ].
- Patch 8 & 9: move some changes from Patch 9 to Patch 8 to avoid build
  error, no code change. [ Baolin Wang ]
- Patch 9: Fix locking section issue, should protect the shmem statistic
  update with spin lock irq. Also fix an warn on condition.
Link to V3:
- https://lore.kernel.org/linux-mm/20250910160833.3464-1-ryncsn@gmail.com/

V3 changes:
There is basically no code change, mostly clean up and comment changes.
- Renames a few variable and functions [ David Hildenbrand, Chris Li ]
- Move the folio_matches_swap_entry check under unuse_pte in patch 5
  [ David Hildenbrand ].
- Remove two redundant function params for the folio replace helper in
  patch 10, and add comment about folio setup [ David Hildenbrand ].
- Move the shmem clean up patch after the API rename patch to fix build
  error, no code change. [ Baolin Wang ]
- Fix build error with !SWAP and !SHMEM config. [ Klara Modin, SeongJae Park ]
- Fix a few typo and blank lines [ David Hildenbrand ]
- Minor code style change [ Chris Li ].
- Fix documentation warning from bot. [ Chris Li ]
Link to V2:
- https://lore.kernel.org/linux-mm/20250905191357.78298-1-ryncsn@gmail.com/

V2 main updates:
- Added some more non-debug atomic sanity checks, which very slightly
  slow down the performance by a bit compared to V1 for some tests. But
  let's be more cautious in phase I, in case there is any hidden bug in
  swap, since it has a rather complex historical baggage. And phase I is
  a critical step for follow up swap table series [ Chris Li ].
  These sanity checks can be removed very easily later or wrapped with
  a DEBUG_VM_SWAP as more swap table features land in.
- The code is basically same as V1, except one missing shmem statistic
  fixed thanks to [ Baolin Wang ]
- Added a lot of kernel docs, and more constify of sturct folio
  arguments, and better function names, thanks to [ David Hildenbrand ]
  and [ Chris Li ].
- Removed the arguable readahead change thanks to [ Chris Li ].
- Add an IRQ sanity check, have been testing with this check on for a
  long time but forgot to include it in V1.
Other updates:
- One VM_WARN_ON_ONCE to VM_WARN_ON_ONCE_FOLIO and minor adjust [ Barry Song ]
- Split out 4 patches from the old patches. The end result is still
  the same but should be easier to review [ Chris Li, David Hildenbrand ]
- Avoid some trivial blank line or variable name changes and comment fix
  [ Baoquan He, Chris Li, David Hildenbrand ]
- Added HDD test benchmark result [ Chris Li ]
- Rename and simplified folio_matches_swap_entry a little bit.
Link to V1:
- https://lore.kernel.org/linux-mm/20250822192023.13477-1-ryncsn@gmail.com/


Chris Li (1):
  docs/mm: add document for swap table

Kairui Song (14):
  mm, swap: use unified helper for swap cache look up
  mm, swap: fix swap cache index error when retrying reclaim
  mm, swap: check page poison flag after locking it
  mm, swap: always lock and check the swap cache folio before use
  mm, swap: rename and move some swap cluster definition and helpers
  mm, swap: tidy up swap device and cluster info helpers
  mm, swap: cleanup swap cache API and add kerneldoc
  mm/shmem, swap: remove redundant error handling for replacing folio
  mm, swap: wrap swap cache replacement with a helper
  mm, swap: use the swap table for the swap cache and switch API
  mm, swap: mark swap address space ro and add context debug check
  mm, swap: remove contention workaround for swap cache
  mm, swap: implement dynamic allocation of swap table
  mm, swap: use a single page for swap table when the size fits

 Documentation/mm/index.rst      |   1 +
 Documentation/mm/swap-table.rst |  72 +++++
 MAINTAINERS                     |   2 +
 include/linux/swap.h            |  42 ---
 mm/filemap.c                    |   2 +-
 mm/huge_memory.c                |  15 +-
 mm/memory-failure.c             |   2 +-
 mm/memory.c                     |  27 +-
 mm/migrate.c                    |  28 +-
 mm/mincore.c                    |   3 +-
 mm/page_io.c                    |  12 +-
 mm/shmem.c                      |  59 ++---
 mm/swap.h                       | 311 +++++++++++++++++++---
 mm/swap_state.c                 | 450 ++++++++++++++++---------------
 mm/swap_table.h                 | 130 +++++++++
 mm/swapfile.c                   | 451 +++++++++++++++++++++-----------
 mm/userfaultfd.c                |   5 +-
 mm/vmscan.c                     |  20 +-
 mm/zswap.c                      |   9 +-
 19 files changed, 1106 insertions(+), 535 deletions(-)
 create mode 100644 Documentation/mm/swap-table.rst
 create mode 100644 mm/swap_table.h

-- 
2.51.0


