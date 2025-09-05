Return-Path: <linux-kernel+bounces-803642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DDBB4634F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0571AA0E58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E210315D2E;
	Fri,  5 Sep 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6W8zTXS"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23A272811
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099652; cv=none; b=ZFzgvXiO+ZVLtz/TF/neT6NG42leeGn3BcKI69x0rJVT3HF3JBJDu0wmT9E9ytwcRtnwK/fN35iysp0vow6l8nxVr+34//XXR9AmCQm5+rU9NSmPCIwLjWa7sOP556LZj+9PRbKnS/0PsEcJ++U/mfYolzXoKqKeHYV+8LIrB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099652; c=relaxed/simple;
	bh=3EcpyLYJ9V4dxbi5piYxMkm2E8WxoySn3NxX54/jCpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8xhtp3k9jQiJpo+WtJQHsZXghMzQ57Jzu+UFw4WB0qVV7mIMljVCrwJipA75tuypJZfjLT+1kD6/P7dQWTUQvfIVZvhWjsPaKHUok28nffWV8jyI6Lz73LJViooNCvCWMNkX4r7JXxPCcJfEj50o0Lb89KvjxSy5ym121awoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6W8zTXS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772488c78bcso2456075b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099650; x=1757704450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJovH7BGKwzLbQneMLSnavadbg6bHImsXLuOy/W6UYw=;
        b=a6W8zTXS/Yjq6XBypib0ykuruhvqBc/MuDWYhRF5a54MkTw5JQDEIbZi0GenxBqi66
         A4meVzzjdv67Iw+aJWAht9jiwHJGvoMWp1a9obqDie9hCSSQez4splvDzb1+UAw0p/BD
         bQE0tUKlGuMSxZA6x8CvwnI9HaKcyw3yUvGBlPytZVroAK9TGYMNvMT77R/P0tDVFRpz
         eLUT+Iv3u0jZRngQJy1ZTIAcCbNhvHxK5W93YcTWYctiuW/wuV7MktgLjEf+ze0XWJdl
         t5Y2WVRBbfsoa6TkFakammSLOOcGLpJ9pI5VskrUSa2kWnbZMg46WDZGjnXhsPKdu8rM
         WKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099650; x=1757704450;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJovH7BGKwzLbQneMLSnavadbg6bHImsXLuOy/W6UYw=;
        b=beMwpI3Hu3vBjZCYVurDMFVARQv4FC4PEpMjFuR9eDbifp0HT1EZ53dkW5JU+ukqP1
         U14s8pi6bBVVOB7GuC90qGUZ3KUAyHoKVXR9kOrXPjANegm907twQXLRUFRn8FFSgfXj
         UkUpsLBVBPwrbZIoSuml2nL3f0JiPe+gsLpgh+47WUd9DSBg8wPk74id/VNyvyN/cZyC
         CojO1ZMw/gO9PN8V9Qfu26IgS7uTKkNdIg1HZCdec59g83v7ZQKReMH/PCmx1mlZ1OAe
         q6N6WGu9c9qLps7LL4JK+pLIISuqxGX6DCsu9sPCN10lTniwblsXAq+PepRjPKAGDqMq
         dg0A==
X-Forwarded-Encrypted: i=1; AJvYcCXB63TNNCdf1ZIgQTlm5V4wD2oIzv6ssBzc3p/JiwvdH8iB+twHMpARMXoMMR5KOB7plGUU+mSRKBgQDCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5g59Pc/pnTgbf+hTg4xA0D6dBxpk0gvf91JZ4Rd55MO90Nm8
	Jl6SGpRPBsIz3+P3OsUW7tlTjZ00xQTG/kLSr6YVqIrbXgJXjKwskJJi
X-Gm-Gg: ASbGnctg/a8UDe7nB7e+J1yE0EzxVHCnp8T73HDsqtf4q9gGZne5ldR0RuFC9DBOtFe
	QkQ0MlTeUDaH4BaZfXNk7vE+3JhoNwBOPlKlnEHMtQIeUQxAr9IGmRekkYjb68auldy5a+VKrO9
	SmmYjQ+1JG1vJoRmMBgX2OQRxZVP8dhoMvzBfG726uH1Rf9A7YftEax2QOr4HNMaQ7cYQw1+Tqx
	wthPUP9v4qyZRqDXJMmXhqC/8IovzCf6guVZtX776dLg/7fvM9MLN6fI7Nmjk7OMpCnOfT1JAb3
	h7ot8dNPtXG2pCNMLOVlobNnrCmK/TgCiuDW7e5uC+rX2dqJBlQj1Gtp/yP0jK6Tx84UPZPSkVR
	jj08LLUtogsJQFWFS44NBcJTXz8paWVbRwpQzB2dLIr2QgjTmSIE8Z07KuQ==
X-Google-Smtp-Source: AGHT+IGyvxYr1hMzzyJx2gtIDT81iIW8zy4IPomcHCY8jfhXERmURHLEOrxKdOJnEf/IWo0lgx5umg==
X-Received: by 2002:a05:6a00:3d4d:b0:76b:e868:eedd with SMTP id d2e1a72fcca58-7723e3c3156mr37125086b3a.24.1757099649704;
        Fri, 05 Sep 2025 12:14:09 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:14:09 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v2 00/15] mm, swap: introduce swap table as swap cache (phase I)
Date: Sat,  6 Sep 2025 03:13:42 +0800
Message-ID: <20250905191357.78298-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
Reply-To: Kairui Song <kasong@tencent.com>
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
is set to use 2500M memory, and ZRAM swapfile size is set to 5G:

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

HDD swap is also about 40% faster with usemem test because we removed
an old contention workaround.

Link: https://lore.kernel.org/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXHGBnfisCAb8VA@mail.gmail.com [1]
Link: https://github.com/ryncsn/linux/tree/kasong/devel/swap-table [2]
Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [3]

Suggested-by: Chris Li <chrisl@kernel.org>

Chris Li (1):
  docs/mm: add document for swap table

Kairui Song (14):
  mm, swap: use unified helper for swap cache look up
  mm, swap: fix swap cahe index error when retrying reclaim
  mm, swap: check page poison flag after locking it
  mm, swap: always lock and check the swap cache folio before use
  mm, swap: rename and move some swap cluster definition and helpers
  mm, swap: tidy up swap device and cluster info helpers
  mm/shmem, swap: remove redundant error handling for replacing folio
  mm, swap: cleanup swap cache API and add kerneldoc
  mm, swap: wrap swap cache replacement with a helper
  mm, swap: use the swap table for the swap cache and switch API
  mm, swap: mark swap address space ro and add context debug check
  mm, swap: remove contention workaround for swap cache
  mm, swap: implement dynamic allocation of swap table
  mm, swap: use a single page for swap table when the size fits

 Documentation/mm/swap-table.rst |  72 +++++
 MAINTAINERS                     |   2 +
 include/linux/swap.h            |  42 ---
 mm/filemap.c                    |   2 +-
 mm/huge_memory.c                |  16 +-
 mm/memory-failure.c             |   2 +-
 mm/memory.c                     |  27 +-
 mm/migrate.c                    |  28 +-
 mm/mincore.c                    |   3 +-
 mm/page_io.c                    |  12 +-
 mm/shmem.c                      |  58 ++--
 mm/swap.h                       | 307 ++++++++++++++++++---
 mm/swap_state.c                 | 447 +++++++++++++++++--------------
 mm/swap_table.h                 | 130 +++++++++
 mm/swapfile.c                   | 455 +++++++++++++++++++++-----------
 mm/userfaultfd.c                |   5 +-
 mm/vmscan.c                     |  20 +-
 mm/zswap.c                      |   9 +-
 18 files changed, 1103 insertions(+), 534 deletions(-)
 create mode 100644 Documentation/mm/swap-table.rst
 create mode 100644 mm/swap_table.h

-- 
2.51.0


