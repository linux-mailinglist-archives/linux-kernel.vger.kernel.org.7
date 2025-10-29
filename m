Return-Path: <linux-kernel+bounces-876614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9350C1C22F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01A3665C35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC24345754;
	Wed, 29 Oct 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoRYsDaE"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2233431F6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753539; cv=none; b=Xa6MRL5HkOiBYN2mDmiNdW+JPGWMfmgZZypUWHZebjfy3e4o3g4ewp6AKzB8M/qT22u3Oeho+LjpW4xh/tQHwGvpbcmaObB3BfmDQTy2tp07gdrEfURtkTgLmTYG7H6tXSnMrnNT9EK1gxRfCn1IXG6vlm/rxyY0eq7WrPp4ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753539; c=relaxed/simple;
	bh=lanE6j+OtvdBS5VQKaj7U/XyuZIu04joKMLp43+/hZ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oVuqT5k/0m+DPPs2LOSoMtBpLcWKtuLyTWVc5J8LARjStpAmPfUw2jQAe+Ouh3RNjoKj8Ee5xLFP80ItMELMS94zbOR8I1gVWMy4e+JTDUYCvWdNDfPWC99EC5pyzL3UYnpOqBki50XuzhKyf2ReQpnrSxjKbeWiAytC+rzTCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoRYsDaE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33be037cf73so70394a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753537; x=1762358337; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp6UONa4RQroT/DFseWBOqeBQbwX964QzeqYggw97rk=;
        b=QoRYsDaEsvNp4NUT+pxtnj7Wt1JIPvqksLDzfXuoBsh4p8jqSTvproiU/uziC6kx3F
         6egDYFeociKiIRtBl5/Jnxj4gq5jtOqp7QhI2qmjNW4XDEGh8Y91Ts44zI8mYuBw8nYt
         iXFBE9H//DTpml9MDDepjEzotbN1jzZ1K2B+10uIp9eEhN0ObbrTnU5qXrPw8eEDNlLt
         kXO3ye7eXVCtrIhW90lTdRpA28Po0VOxsDodebiZJpBxqyWVQ+RcwMGLd785pQfDRJEG
         s56FBEyutVrjQHL8Ct/c3W94f2OyafIyCDaCgX+IqCjTbn0NzGe3zwIeBAia0uy6tjst
         WKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753537; x=1762358337;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp6UONa4RQroT/DFseWBOqeBQbwX964QzeqYggw97rk=;
        b=RnHtelrsXyFA9Fr9YdGCASWHlIlJMg5ZurzpmNjc8kEVetb3wY7JV04TJJgBaDnx95
         o4OjCdlr4LnxdwCY/UcMvqe6N6g1P31J6ltFuaagi0LX752rBz8Hw6ApaOoMWX47bjxO
         Nz8gbthwiYmlHheklr6Slyo+/zQQkr4amYYBK0Dl4ZH7Uo7cSjfBl8D4EmAjw9pU6Ebl
         EiU9ZLnLGnWyRVJtINmgCdmOp5A57yNQC2NhwMKhjnsFPX0oLZ/gLirDrenN19FB4Zl9
         T2Gh5T/V5tpud+DfdJLJcxw5sPEX6B5qrvJBH07nu7XFD1s4FArg5eyVSoWJb9787KoS
         ePSA==
X-Forwarded-Encrypted: i=1; AJvYcCXzt+XbdHnTUlLAhS9VC9dFIvfliL2tSf7wj1w6Z0skvIurUxV6K/uRYdpOb1rY0pG6Fu7y/AeCSTg6xog=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLUsHEzBCywlHBklgeERXbgQ0EPirMKBnDE87C+bx9VJeJxIr
	o4HY/hLYxle0RrmOabvXW2Ge0NQagJpKyOVPJ5/OvihJJX9zllm08n2Bg8GBjxaH0pw=
X-Gm-Gg: ASbGncuzysvaO4dz2BTsHleRXLehPDwIXm2Ib2pN0RQ+YUGgfowZSZL2qBp/SqNCjzS
	E7S1Z0EQ+ebyUsV7jJQpe0d4hBAMNUrUe7qKg/Gp/PfhnaLKeHxnNueY2KonM76W96Exc3ohPCZ
	AiQPc/pGEniV9S2CVvg8hW6qaV9GBRCtLF2hXh1WGO34Q3ldJFZcLfV67NlqE8F0DRAx5HJLz0g
	jSTqcCZtMpOWnZAEc7KbvchJaqRvy0feX9VF1S4i3hCgIccJ2g+zp3yeBpnUATwB5XkrQ0tGv6b
	OPXNNqQEVe/xkEuFeow+DCUER27a4V/gLeOgmUjsS26X3HQ5+C1tlA137CnKE4nXWZiAW1/0p6h
	FNfyo8t2dwE37S05utWBgjZrodR+hoWfx6pw6kTENbp8/GET31mG7tnAT7MZV6s7Lz8Dboz8RST
	KXyGHiOT1I3A==
X-Google-Smtp-Source: AGHT+IENxrO2rFfWZghD173MYTy/76Go4Z1vLaGV7TWb3mCr4J57kgcgIdVFq3BvAFIGNQG/Gx7HsQ==
X-Received: by 2002:a17:90b:2dc9:b0:33b:bf8d:616f with SMTP id 98e67ed59e1d1-3403a2a202bmr4241835a91.20.1761753537047;
        Wed, 29 Oct 2025 08:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:58:56 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH 00/19] mm, swap: never bypass swap cache and cleanup flags
 (swap table phase II)
Date: Wed, 29 Oct 2025 23:58:26 +0800
Message-Id: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKI5AmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNz3eLyxALdksSknFTdAiNd8xRjAwuzVNNkY4tEJaCegqLUtMwKsHn
 RsbW1ANdUNh5fAAAA
X-Change-ID: 20251007-swap-table-p2-7d3086e5c38a
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3

This series removes the SWP_SYNCHRONOUS_IO swap cache bypass code and
special swap bits including SWAP_HAS_CACHE, along with many historical
issues. The performance is about ~20% better for some workloads, like
Redis with persistence. This also cleans up the code to prepare for
later phases, some patches are from a previously posted series.

Swap cache bypassing and swap synchronization in general had many
issues. Some are solved as workarounds, and some are still there [1]. To
resolve them in a clean way, one good solution is to always use swap
cache as the synchronization layer [2]. So we have to remove the swap
cache bypass swap-in path first. It wasn't very doable due to
performance issues, but now combined with the swap table, removing
the swap cache bypass path will instead improve the performance,
there is no reason to keep it.

Now we can rework the swap entry and cache synchronization following
the new design. Swap cache synchronization was heavily relying on
SWAP_HAS_CACHE, which is the cause of many issues. By dropping the usage
of special swap map bits and related workarounds, we get a cleaner code
base and prepare for merging the swap count into the swap table in the
next step.

Test results:

Redis / Valkey bench:
=====================

Testing on a ARM64 VM 1.5G memory:
Server: valkey-server --maxmemory 2560M
Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get

        no persistence              with BGSAVE
Before: 460475.84 RPS               311591.19 RPS
After:  451943.34 RPS (-1.9%)       371379.06 RPS (+19.2%)

Testing on a x86_64 VM with 4G memory (system components takes about 2G):
Server:
Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get

        no persistence              with BGSAVE
Before: 306044.38 RPS               102745.88 RPS
After:  309645.44 RPS (+1.2%)       125313.28 RPS (+22.0%)

The performance is a lot better when persistence is applied. This should
apply to many other workloads that involve sharing memory and COW. A
slight performance drop was observed for the ARM64 Redis test: We are
still using swap_map to track the swap count, which is causing redundant
cache and CPU overhead and is not very performance-friendly for some
arches. This will be improved once we merge the swap map into the swap
table (as already demonstrated previously [3]).

vm-scabiity
===========
usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
simulated PMEM as swap), average result of 6 test run:

                           Before:         After:
System time:               282.22s         283.47s
Sum Throughput:            5677.35 MB/s    5688.78 MB/s
Single process Throughput: 176.41 MB/s     176.23 MB/s
Free latency:              518477.96 us    521488.06 us

Which is almost identical.

Build kernel test:
==================
Test using ZRAM as SWAP, make -j48, defconfig, on a x86_64 VM
with 4G RAM, under global pressure, avg of 32 test run:

                Before            After:
System time:    1379.91s          1364.22s (-0.11%)

Test using ZSWAP with NVME SWAP, make -j48, defconfig, on a x86_64 VM
with 4G RAM, under global pressure, avg of 32 test run:

                Before            After:
System time:    1822.52s          1803.33s (-0.11%)

Which is almost identical.

MySQL:
======
sysbench /usr/share/sysbench/oltp_read_only.lua --tables=16
--table-size=1000000 --threads=96 --time=600 (using ZRAM as SWAP, in a
512M memory cgroup, buffer pool set to 3G, 3 test run and 180s warm up).

Before: 318162.18 qps
After:  318512.01 qps (+0.01%)

In conclusion, the result is looking better or identical for most cases,
and it's especially better for workloads with swap count > 1 on SYNC_IO
devices, about ~20% gain in above test. Next phases will start to merge
swap count into swap table and reduce memory usage.

One more gain here is that we now have better support for THP swapin.
Previously, the THP swapin was bound with swap cache bypassing, which
only works for single-mapped folios. Removing the bypassing path also
enabled THP swapin for all folios. It's still limited to SYNC_IO
devices, though, this limitation can will be removed later. This may
cause more serious thrashing for certain workloads, but that's not an
issue caused by this series, it's a common THP issue we should resolve
separately.

Link: https://lore.kernel.org/linux-mm/CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+2i_mhuP5CQPSOPrmQ@mail.gmail.com/ [1]
Link: https://lore.kernel.org/linux-mm/20240326185032.72159-1-ryncsn@gmail.com/ [2]
Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [3]

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
Kairui Song (18):
      mm/swap: rename __read_swap_cache_async to swap_cache_alloc_folio
      mm, swap: split swap cache preparation loop into a standalone helper
      mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO
      mm, swap: always try to free swap cache for SWP_SYNCHRONOUS_IO devices
      mm, swap: simplify the code and reduce indention
      mm, swap: free the swap cache after folio is mapped
      mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO
      mm, swap: swap entry of a bad slot should not be considered as swapped out
      mm, swap: consolidate cluster reclaim and check logic
      mm, swap: split locked entry duplicating into a standalone helper
      mm, swap: use swap cache as the swap in synchronize layer
      mm, swap: remove workaround for unsynchronized swap map cache state
      mm, swap: sanitize swap entry management workflow
      mm, swap: add folio to swap cache directly on allocation
      mm, swap: check swap table directly for checking cache
      mm, swap: clean up and improve swap entries freeing
      mm, swap: drop the SWAP_HAS_CACHE flag
      mm, swap: remove no longer needed _swap_info_get

Nhat Pham (1):
      mm/shmem, swap: remove SWAP_MAP_SHMEM

 arch/s390/mm/pgtable.c |   2 +-
 include/linux/swap.h   |  77 ++---
 kernel/power/swap.c    |  10 +-
 mm/madvise.c           |   2 +-
 mm/memory.c            | 270 +++++++---------
 mm/rmap.c              |   7 +-
 mm/shmem.c             |  75 ++---
 mm/swap.h              |  69 +++-
 mm/swap_state.c        | 341 +++++++++++++-------
 mm/swapfile.c          | 849 +++++++++++++++++++++----------------------------
 mm/userfaultfd.c       |  10 +-
 mm/vmscan.c            |   1 -
 mm/zswap.c             |   4 +-
 13 files changed, 840 insertions(+), 877 deletions(-)
---
base-commit: f30d294530d939fa4b77d61bc60f25c4284841fa
change-id: 20251007-swap-table-p2-7d3086e5c38a

Best regards,
-- 
Kairui Song <kasong@tencent.com>


