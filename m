Return-Path: <linux-kernel+bounces-782612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFAFB322BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6101CC85F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F42C327D;
	Fri, 22 Aug 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdUrT8cs"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A84A1A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890446; cv=none; b=pzKCOtWRarMWl/WVppaLBc9Uxm4CkSKv/QMVAvx4R01OSI0ebMW59gL53KujrLXuZFetyDQj2BRXe+4gzsk1YqLJRuKwBI6q37dQw7yRljdCehrf1t7W3p+moAP8MgvwX9MQ0oQFiLZGKR81XM0g0CfrKD1Ticlp1HPeEwkg7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890446; c=relaxed/simple;
	bh=nypOmFFQp4VlUrTIYthFdJ/IAdWtaePT953A7qFoIxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAXYoyjcofH7PNUDSuuSaazkwBNayg0IJiF/HOlhZijwEIkTaQKh0uHlzt2WnZeqcO0NWcraK0IHQ68J2TZJP2KJcjdAvEAYcI/yHeqp8byE9l/jWYRV6S01WLKMI4yX+MxyLTsd+HDYT79IAvDr0XxB8TJzNOzGPMhygTxLC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdUrT8cs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70bb007a821so30365406d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890443; x=1756495243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBT9IPxJlhEe/9ODi5VB1eJFvWjsYuA43z30BW89zH0=;
        b=JdUrT8csiV3IqelqMf9OQho21yiQWGB4g9DRnFFztAC/djArJUV7SBh23cs/uTmkh4
         TRbRZDIUeMLJd144CLtg4hr11R7ewbu2zoKpdYm8I7mo0MW6x07xTk/pRo2+U/WhhCCB
         6UTCgQvNvTPNf0IhDJ39BQ8AWSUTbMpFtzsPrWSnRsIPLgiop/avGJkg6jlZjGwq5OCI
         rlmuDJxrv4To1DcxRmZdsD++I42h3SE9wgdz5KHLD7uzVhNtT4cuis6NfTPn8kLmBJ50
         zshdW96aN6qknMOcZZ1Uh8h6oZWBM19RgdjD/DpXpuBOI6EZzMmON4LEkNQy6vZ5Oszn
         uK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890443; x=1756495243;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBT9IPxJlhEe/9ODi5VB1eJFvWjsYuA43z30BW89zH0=;
        b=cQSsM5IktWU/qAsi1yxCJRdqFzEw5hY4S99S6IH8CglMdS+MUWXWmM3b2GcfBAZCMQ
         3glod2Be8qPoombG74RwXS7EG4hfWxsn6sH8ouBd3SzDVbqk1DW9JIuSDDnHRY/rVQgc
         sXKfrKK4f51qDfgPAhBkCmFjJWzEsz4mAUG4q56ouM5cTTjzGNak/811JwmkZhX0WluN
         H3mi6Ar2mnS5f7CPoFFEUV49wvbYaufk4YuZIBuLvXW6YX9X4quq5revmDgJQmRyajRW
         6V/p9y+VdogDcrpxLuwDdNCg1uq7T17uHjnmcoITs/lRnXflkEsowB0zDp2aApjINn1X
         Ty9w==
X-Forwarded-Encrypted: i=1; AJvYcCVjkKbewhKBig45iCAQs9bouN/7+J8bgeYSc0X3V2hw2BlaDbXuhGIHCby83BKXEVl0wFOSe33ltnI9P7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3i4CTgsvnTMaWLE3hlBbWMuC5/E5XR1JrrK7KgIa9/1upixp
	QFy+u1YBXL56yw3gtYK5l5F+kIv8CoSHOzQyX5F0cAN/bdsFhLqPeIPB
X-Gm-Gg: ASbGncsKrj+goqF1bYrMGzLacFL5GdFLx0vh7/aj7QzoXMIj+40+bygXTGZ99z+hpuO
	+Len0TnkUFutx8INpyfCIhxiQBr4SnfoIEo5m9tb/eFrMhwE4qzCykaMFMp+lwlTya+JEmo6eBA
	I+Ar3nATBuTpz+pnJzJtSLKbWlbV1sbp5uYdTj5nIJON/UHvNdNv6ypeG8yMzBLK35KfJhXfYTT
	0+0u2ngh9FipZzD4VlVkjTlCRDls2ii4FSkFMIbkaklqwQekgfmvEBBSThsj4NPO5pldu5VRZpZ
	flWIjpAV4/injUJdkG+T4EeWdIxS1CjmYXuhAgzwwozgMt8GJfCszd+lFZlV3zAho6vJZXsQgWJ
	TjXInR/xD+56AimYOzfprCjPUvA5no87/1/BQvF7ycbc=
X-Google-Smtp-Source: AGHT+IEvSelBiYusSXrYhQrgrUecjMX8dnA1XU5GX3LCuNjuniYo4XrWcavNpwySuxjAVSqXeuwwVQ==
X-Received: by 2002:a05:6214:2a84:b0:70b:afb5:9743 with SMTP id 6a1803df08f44-70d97245bffmr47189646d6.8.1755890443301;
        Fri, 22 Aug 2025 12:20:43 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.20.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:20:42 -0700 (PDT)
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
Subject: [PATCH 0/9] mm, swap: introduce swap table as swap cache (phase I)
Date: Sat, 23 Aug 2025 03:20:14 +0800
Message-ID: <20250822192023.13477-1-ryncsn@gmail.com>
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

This phase I contains 9 patches, introduces the swap table infrastructure
and uses it as the swap cache backend. By doing so, we have up to ~5-20%
performance gain in throughput, RPS or build time for benchmark and
workload tests. This is based on Chris Li's idea of using cluster size
atomic arrays to implement swap cache. It has less contention on the swap
cache access. The cluster size is much finer-grained than the 64M address
space split, which is removed in this phase I. It also unifies and cleans
up the swap code base.

Each swap cluster will dynamically allocate the swap table, which is an
atomic array to cover every swap slot in the cluster. It replaces the swap
cache back by Xarray. In phase I, the static allocated swap_map still
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
System time:    220.86s         160.42s      (-27.36%)
Throughput:     4775.18 MB/s    6381.43 MB/s (+33.63%)
Free latency:   174492 us       132122 us    (+24.28%)

usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
PMEM as swap)
                Before:         After:
System time:    355.23s         295.28s      (-16.87%)
Throughput:     4659.89 MB/s    5765.80 MB/s (+23.73%)
Free latency:   500417 us       477098 us     (-4.66%)

This shows an improvement of more than 20% improvement in most readings.

Build kernel test:
==================
Building kernel with defconfig on tmpfs with ZSWAP / ZRAM is looking
good. The results below show a test matrix using different memory
pressure and setups. Tests are done with shmem as filesystem and
using the same build config, measuring sys and real time in seconds
(user time is almost identical as expected):

 -j<NR> / Mem  | Sys before / after  | Real before / after
Using 16G ZRAM with memcg limit:
     12 / 256M | 6475 / 6232  -3.75% | 814 / 793   -2.58%
     24 / 384M | 5904 / 5560  -5.82% | 413 / 397   -3.87%
     48 / 768M | 4762 / 4242  -10.9% | 187 / 179   -4.27%
With 64k folio:
     24 / 512M | 4196 / 4062  -3.19% | 325 / 319   -1.84%
     48 / 1G   | 3622 / 3544  -2.15% | 148 / 146   -1.37%
With ZSWAP with 3G memcg (using higher limit due to kmem account):
     48 / 3G   |  605 /  571  -5.61% |  81 /  79   -2.47%

For extremely high pressure global pressure, using ZSWAP with 32G
NVMEs in a 48c VM that has 4G memory globally, no memcg limit, system
components take up about 1.5G so the pressure is high, using make -j48:

Before:  sys time: 2061.72s            real time: 135.61s
After:   sys time: 1990.96s (-3.43%)   real time: 134.03s (-1.16%)

All cases are faster, and no regression even under heavy global
memory pressure.

Redis / Valkey bench:
=====================
The test machine is a ARM64 VM with 1.5G memory, redis is set to
use 2.5G memory:

Testing with:
redis-benchmark -r 2500000 -n 2500000 -d 1024 -c 12 -P 32 -t get

                no BGSAVE                with BGSAVE
Before:         433015.08 RPS            271421.15 RPS
After:          431537.61 RPS (-0.34%)   290441.79 RPS (+7.0%)

Testing with:
redis-benchmark -r 2000000 -n 2000000 -d 1024 -c 12 -P 32 -t get
                no BGSAVE                with BGSAVE
Before:         446339.45 RPS            274845.19 RPS
After:          442697.29 RPS (-0.81%)   293053.59 RPS (+6.6%)

With BGSAVE enabled, most Redis memory will have a swap count > 1 so
swap cache is heavily in use. We can see a >5% performance. No BGSAVE
is very slightly slower (<1%) due to the higher memory pressure of the
co-existence of swap_map and swap table. This will be optimzed into a
net gain and up to 20% gain in BGSAVE case in the following phases.

Link: https://lore.kernel.org/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXHGBnfisCAb8VA@mail.gmail.com [1]
Link: https://github.com/ryncsn/linux/tree/kasong/devel/swap-table [2]
Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [3]

Kairui Song (9):
  mm, swap: use unified helper for swap cache look up
  mm, swap: always lock and check the swap cache folio before use
  mm, swap: rename and move some swap cluster definition and helpers
  mm, swap: tidy up swap device and cluster info helpers
  mm/shmem, swap: remove redundant error handling for replacing folio
  mm, swap: use the swap table for the swap cache and switch API
  mm, swap: remove contention workaround for swap cache
  mm, swap: implement dynamic allocation of swap table
  mm, swap: use a single page for swap table when the size fits

 MAINTAINERS          |   1 +
 include/linux/swap.h |  42 ----
 mm/filemap.c         |   2 +-
 mm/huge_memory.c     |  16 +-
 mm/memory-failure.c  |   2 +-
 mm/memory.c          |  30 +--
 mm/migrate.c         |  28 +--
 mm/mincore.c         |   3 +-
 mm/page_io.c         |  12 +-
 mm/shmem.c           |  56 ++----
 mm/swap.h            | 268 +++++++++++++++++++++----
 mm/swap_state.c      | 404 +++++++++++++++++++-------------------
 mm/swap_table.h      | 136 +++++++++++++
 mm/swapfile.c        | 456 ++++++++++++++++++++++++++++---------------
 mm/userfaultfd.c     |   5 +-
 mm/vmscan.c          |  20 +-
 mm/zswap.c           |   9 +-
 17 files changed, 954 insertions(+), 536 deletions(-)
 create mode 100644 mm/swap_table.h

---

I was trying some new tools like b4 for branch management, and it seems
a draft version was sent out by accident, but seems got rejected. I'm
not sure if anyone is seeing duplicated or a malformed email. If so,
please accept my apology and use this series for review, discussion
or merge.

-- 
2.51.0


