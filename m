Return-Path: <linux-kernel+bounces-738720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C403B0BC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6147179EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126CA21C9E9;
	Mon, 21 Jul 2025 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJ4z8IOf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC41F0995
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077974; cv=none; b=MJRsJow+GcVpMbLLgQ/5lvFSEY3OJYkewxxH+EgCc4amZR4s2SjE6FhAslKtBIdes/3kAPscqxI+QPURFDLRv4+lyGOP/QiHhkoG7oZZUdcT8i/Va2qO49ljLp9HLC7u/jmL92F55YdJWIWXAx5DzS85hqRbKxgoBd2y26aS83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077974; c=relaxed/simple;
	bh=lZIfNbG5gYCJqFKLlL7F3ZUhgc9Nfs6nJKoboi4NOww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jD4oGYGeO3pGxPLNX8GxNRAUDetMcaWP18UYwZPqoufnYXRBlBXO+9lxc/fZHuU3P1aPUgboKoUgJSg7p87erBXf+m7OrxbqWv+CxTFuEmVjHWkz34Qm6u4GWYxNr9PZCQ6bnlHc3qvr6BV+nv0kYBEeOBkg2qWPDYZc369lm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJ4z8IOf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753077973; x=1784613973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lZIfNbG5gYCJqFKLlL7F3ZUhgc9Nfs6nJKoboi4NOww=;
  b=FJ4z8IOfV6Puf6ntpjyVrD0vy+fPQ4/jC90K3AzvhbQwEKpLojEGiB+4
   pOrkUki8x5yAGOmCjl3WRtMn6IONziFI0n6XaVhAZ5tYqi3kGU1sK1imU
   cKJd6ob2PtyAJifxLXQCx6xJmBOzH/VFpnNAkDjvm5gegVAvFM/y67x8o
   c9s4Ll7KvNTS4xHZfeuOkgYxgZSd052+WZsJtKLsRtgH/oelydcSoDt0q
   p6RAqiICYmf80d+2yKN0cjNSvF9EXjseL2znY5lWW9gGwH1ihruFa0xRJ
   oiKS4RTzg9UdNFIuq5DwqqrUHf1Pr28TsJtJtssdZkYc0juHeevkY1Gqd
   w==;
X-CSE-ConnectionGUID: Cd5gA0f5Qoa8o0vLrGv6ag==
X-CSE-MsgGUID: 0FZknWR5R2iGrZniPS9daw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="54994950"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="54994950"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:06:12 -0700
X-CSE-ConnectionGUID: 9RoLbe63TTCNjv2Z9rvP7A==
X-CSE-MsgGUID: /LGUpcXIShmHsCvZiNaslg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="189696119"
Received: from linux-pnp-server-17.sh.intel.com ([10.239.166.49])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jul 2025 23:06:10 -0700
From: Pan Deng <pan.deng@intel.com>
To: peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	pan.deng@intel.com
Subject: [PATCH v2 1/4] sched/rt: Optimize cpupri_vec layout to mitigate cache line contention
Date: Mon, 21 Jul 2025 14:10:23 +0800
Message-ID: <24c460fb48d86a5b990acbb42d0d29d91dfc427c.1753076363.git.pan.deng@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1753076363.git.pan.deng@intel.com>
References: <cover.1753076363.git.pan.deng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running a multi-instance FFmpeg workload on an HCC system, significant
cache line contention is observed around `cpupri_vec->count` and `mask` in
struct root_domain.

The SUT is a 2-socket machine with 240 physical cores and 480 logical
CPUs. 60 FFmpeg instances are launched, each pinned to 4 physical cores
(8 logical CPUs) for transcoding tasks. Sub-threads use RT priority 99
with FIFO scheduling. FPS is used as score.

perf c2c tool reveals:
root_domain cache line 3:
- `cpupri->pri_to_cpu[0].count` (offset 0x38) is heavily loaded/stored
   and contends with other fields, since counts[0] is more frequently
   updated than others along with a rt task enqueues an empty runq or
   dequeues from a non-overloaded runq.
- cycles per load: ~10K to 59K

cpupri's last cache line:
- `cpupri_vec->count` and `mask` contends. The transcoding threads use
  rt pri 99, so that the contention occurs in the end.
- cycles per load: ~1.5K to 10.5K

This change mitigates `cpupri_vec->count`, `mask` related contentions by
separating each count and mask into different cache lines.

As a result:
- FPS improves by ~11%
- Kernel cycles% drops from ~20% to ~11%
- `count` and `mask` related cache line contention is mitigated, perf c2c
  shows root_domain cache line 3 `cycles per load` drops from ~10K-59K
  to ~0.5K-8K, cpupri's last cache line no longer appears in the report.
- stress-ng cyclic benchmark is improved ~31.4%, command:
  stress-ng/stress-ng --cyclic $(nproc) --cyclic-policy fifo   \
                      --timeout 30 --minimize --metrics
- rt-tests/pi_stress is improved ~76.5%, command:
  rt-tests/pi_stress -D 30 -g $(($(nproc) / 2))

Appendix:
1. Current layout of contended data structure:
struct root_domain {
    ...
    struct irq_work            rto_push_work;        /*   120    32 */
    /* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
    raw_spinlock_t             rto_lock;             /*   152     4 */
    int                        rto_loop;             /*   156     4 */
    int                        rto_cpu;              /*   160     4 */
    atomic_t                   rto_loop_next;        /*   164     4 */
    atomic_t                   rto_loop_start;       /*   168     4 */
    /* XXX 4 bytes hole, try to pack */
    cpumask_var_t              rto_mask;             /*   176     8 */
    /* --- cacheline 3 boundary (192 bytes) was 8 bytes hence --- */
    struct cpupri              cpupri;               /*   184  1624 */
    /* --- cacheline 28 boundary (1792 bytes) was 16 bytes ago --- */
    struct perf_domain *       pd;                   /*  1808     8 */
    /* size: 1816, cachelines: 29, members: 21 */
    /* sum members: 1802, holes: 3, sum holes: 14 */
    /* forced alignments: 1 */
    /* last cacheline: 24 bytes */
} __attribute__((__aligned__(8)));

2. Perf c2c report of root_domain cache line 3:
-------  -------  ------  ------  ------  ------  ------------------------
 Rmt      Lcl     Store   Data    Load    Total    Symbol
Hitm%    Hitm%   L1 Hit%  offset  cycles  records
-------  -------  ------  ------  ------  ------  ------------------------
 353       44       62    0xff14d42c400e3880
-------  -------  ------  ------  ------  ------  ------------------------
 0.00%    2.27%    0.00%  0x0     21683   6     __flush_smp_call_function_
 0.00%    2.27%    0.00%  0x0     22294   5     __flush_smp_call_function_
 0.28%    0.00%    0.00%  0x0     0       2     irq_work_queue_on
 0.28%    0.00%    0.00%  0x0     27824   4     irq_work_single
 0.00%    0.00%    1.61%  0x0     28151   6     irq_work_queue_on
 0.57%    0.00%    0.00%  0x18    21822   8     native_queued_spin_lock_sl
 0.28%    2.27%    0.00%  0x18    16101   10    native_queued_spin_lock_sl
 0.57%    0.00%    0.00%  0x18    33199   5     native_queued_spin_lock_sl
 0.00%    0.00%    1.61%  0x18    10908   32    _raw_spin_lock
 0.00%    0.00%    1.61%  0x18    59770   2     _raw_spin_lock
 0.00%    0.00%    1.61%  0x18    0       1     _raw_spin_unlock
 1.42%    0.00%    0.00%  0x20    12918   20    pull_rt_task
 0.85%    0.00%   25.81%  0x24    31123   199   pull_rt_task
 0.85%    0.00%    3.23%  0x24    38218   24    pull_rt_task
 0.57%    4.55%   19.35%  0x28    30558   207   pull_rt_task
 0.28%    0.00%    0.00%  0x28    55504   10    pull_rt_task
18.70%   18.18%    0.00%  0x30    26438   291   dequeue_pushable_task
17.28%   22.73%    0.00%  0x30    29347   281   enqueue_pushable_task
 1.70%    2.27%    0.00%  0x30    12819   31    enqueue_pushable_task
 0.28%    0.00%    0.00%  0x30    17726   18    dequeue_pushable_task
34.56%   29.55%    0.00%  0x38    25509   527   cpupri_find_fitness
13.88%   11.36%   24.19%  0x38    30654   342   cpupri_set
 3.12%    2.27%    0.00%  0x38    18093   39    cpupri_set
 1.70%    0.00%    0.00%  0x38    37661   52    cpupri_find_fitness
 1.42%    2.27%   19.35%  0x38    31110   211   cpupri_set
 1.42%    0.00%    1.61%  0x38    45035   31    cpupri_set

3. Perf c2c report of cpupri's last cache line
-------  -------  ------  ------  ------  ------  ------------------------
 Rmt      Lcl     Store   Data    Load    Total    Symbol
Hitm%    Hitm%   L1 Hit%  offset  cycles  records
-------  -------  ------  ------  ------  ------  ------------------------
 149       43       41    0xff14d42c400e3ec0
-------  -------  ------  ------  ------  ------  ------------------------
 8.72%   11.63%    0.00%  0x8     2001    165   cpupri_find_fitness
 1.34%    2.33%    0.00%  0x18    1456    151   cpupri_find_fitness
 8.72%    9.30%   58.54%  0x28    1744    263   cpupri_set
 2.01%    4.65%   41.46%  0x28    1958    301   cpupri_set
 1.34%    0.00%    0.00%  0x28    10580   6     cpupri_set
69.80%   67.44%    0.00%  0x30    1754    347   cpupri_set
 8.05%    4.65%    0.00%  0x30    2144    256   cpupri_set

Signed-off-by: Pan Deng <pan.deng@intel.com>
Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
Note: The side effect of this change is that struct cpupri size is
increased from 26 cache lines to 203 cache lines.

An alternative implementation of this patch could be separating `counts`
and `masks` into 2 vectors in cpupri_vec (counts[] and masks[]), and
add two paddings:
1. Between counts[0] and counts[1], since counts[0] is more frequently
   updated than others.
2. Between the two vectors, since counts[] is read-write access  while
   masks[] is read access when it stores pointers.

The alternative introduces the complexity of 31+/21- LoC changes,
it achieves almost the same performance, at the same time, struct cpupri
size is reduced from 26 cache lines to 21 cache lines.
---
 kernel/sched/cpupri.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index d6cba0020064..245b0fa626be 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -9,7 +9,7 @@
 
 struct cpupri_vec {
 	atomic_t		count;
-	cpumask_var_t		mask;
+	cpumask_var_t		mask	____cacheline_aligned;
 };
 
 struct cpupri {
-- 
2.43.5


