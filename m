Return-Path: <linux-kernel+bounces-738719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D299B0BC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C190C3B3360
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5D21D3C6;
	Mon, 21 Jul 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAGdKrMr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2E1F0995
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077968; cv=none; b=VrgxZ2bxfwBX6gTkXaoinJTVgkxtwmobzz6U4JoT+xMS+jsCDRJmiKxsk49E0Cjsvryxn8sxcLr2blpGX2jt7aAvMhKjg/uZsQfs04pqx+jZArd0Hu00UZx/jmweaiCOq78YyhnN0GsXO1pZxxWMQ4RZKjGBcANxJpTmjMmbSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077968; c=relaxed/simple;
	bh=8+6LOKq7hVq9ezykO9+tgu9iTYFTVPyF6s2HFLqW+Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hDHt7DU/cr8NQclBqqJ1tuJG+TjS5cCacrakFD25yC95pd/i+2KaqW3TliKYLlbMUQ4AO/Tx85oi91BQDsGPldRRAdKSYNfuHQuHo4Ya3ttb6FQFNDGwi9YynsAIwHsQyOuik4L6vS4AoUwhOmwPhs6tSwCrJtSUsuCCEhxCk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAGdKrMr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753077966; x=1784613966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8+6LOKq7hVq9ezykO9+tgu9iTYFTVPyF6s2HFLqW+Zk=;
  b=NAGdKrMrZZzP3zu3iAWt003/T2b0EyVhJig6NqCDlguHm+dwMqRnMtz7
   sHfwHlYSbXiu6cfka18TykaxJU7C4YLE80lP/EYw06HMXdnDMx0FO4xP0
   DyvbQs7Rc6vmddYcq4cqINAdRwou61lFtmVLswzcxYch+XKpqioHmlKC4
   8c2mVpsnPz87yt/Tr/Kkb9I4B8RUhxZ9pd0gkt/6tt7epn5Pnvqt55qw0
   ZkTJybt+jHFbum7JDExo3H9DmRF1MZv9+SJlrySltOTEsFMbSyJmxYSLM
   Nm0zkb3YAt+1+KRaPlS/OggPzgfzFA6gMkDRxeCqOVo6ISup1Utf/dGmE
   Q==;
X-CSE-ConnectionGUID: 46C3VEIhQk6dY7MOUr/Y9w==
X-CSE-MsgGUID: eyONE1/XRSONmssilN1Wjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="54994912"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="54994912"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:05:56 -0700
X-CSE-ConnectionGUID: FR/9Eg0CR6a6FCuo6C7u5w==
X-CSE-MsgGUID: 6jA7WmgvRyiwF4nXSIC8SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="189696079"
Received: from linux-pnp-server-17.sh.intel.com ([10.239.166.49])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jul 2025 23:05:54 -0700
From: Pan Deng <pan.deng@intel.com>
To: peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	pan.deng@intel.com
Subject: [PATCH v2 0/4] sched/rt: mitigate root_domain cache line contention
Date: Mon, 21 Jul 2025 14:10:22 +0800
Message-ID: <cover.1753076363.git.pan.deng@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running multi-instance FFmpeg workload in cloud environment,
cache line contention is severe during the access to root_domain data
structures, which significantly degrades performance.

The SUT is a 2-socket machine with 240 physical cores and 480 logical
CPUs. 60 FFmpeg instances are launched, each pinned to 4 physical cores
(8 logical CPUs) for transcoding tasks. Sub-threads use RT priority 99
with FIFO scheduling. FPS(frame per second) is used as score.

Profiling shows the kernel consumes ~20% of CPU cycles, which is
excessive in this scenario. The overhead primarily comes from RT task
scheduling functions like `cpupri_set`, `cpupri_find_fitness`,
`dequeue_pushable_task`, `enqueue_pushable_task`, `pull_rt_task`,
`__find_first_and_bit`, and `__bitmap_and`. This is due to read/write
contention on root_domain cache lines.

The `perf c2c` report, sorted by contention severity, reveals:

root_domain cache line 3:
- `cpupri->pri_to_cpu[0].count` is heavily loaded/stored,
   since counts[0] is more frequently updated than others along with a
   rt task enqueues an empty runq or dequeues from a non-overloaded runq.
- `rto_mask` is heavily loaded
- `rto_loop_next` and `rto_loop_start` are frequently stored
- `rto_push_work` and `rto_lock` are lightly accessed
- cycles per load: ~10K to 59K.

root_domain cache line 1:
- `rto_count` is frequently loaded/stored
- `overloaded` is heavily loaded
- cycles per load: ~2.8K to 44K

cpumask (bitmap) cache line of cpupri_vec->mask:
- bits are loaded during cpupri_find
- bits are stored during cpupri_set
- cycles per load: ~2.2K to 8.7K

The end cache line of cpupri:
- `cpupri_vec->count` and `mask` contends. The transcoding threads use
  rt pri 99, so that the contention occurs in the end.
- cycles per load: ~1.5K to 10.5K

According to above, we propose 4 patches to mitigate the contention,
each patch resolves part of above issues:
Patch 1: Reorganize `cpupri_vec`, separate `count`, `mask` fields,
         reducing contention on root_domain cache line 3 and cpupri's
         last cache line. This patch has an alternative implementation,
         which is described in the patch commit message, welcome any
         comments.
Patch 2: Restructure `root_domain` structure to minimize contention of
         root_domain cache line 1 and 3 by reordering fields.
Patch 3: Split `root_domain->rto_count` to per-NUMA-node counters,
         reducing the contention on root_domain cache line 1.
Patch 4: Split `cpupri_vec->cpumask` to per-NUMA-node bitmaps, reducing
         load/store contention on the cpumask bitmap cache line.

Evaluation:
The patches are tested non-cumulatively, I'm happly to provide additional
data as needed.

FFmpeg benchmark:
Performance changes (FPS):
- Baseline:             100.0%
- Baseline + Patch 1:   111.0%
- Baseline + Patch 2:   105.0%
- Baseline + Patch 3:   104.0%
- Baseline + Patch 4:   103.8%

Kernel CPU cycle usage(lower is better):
- Baseline:              20.0%
- Baseline + Patch 1:    11.0%
- Baseline + Patch 2:    17.7%
- Baseline + Patch 3:    18.6%
- Baseline + Patch 4:    18.7%

Cycles per load reduction (by perf c2c report):
- Patch 1:
  - `root_domain` cache line 3:    10K–59K    ->  0.5K–8K
  - `cpupri` last cache line:      1.5K–10.5K ->  eliminated
- Patch 2:
  - `root_domain` cache line 1:    2.8K–44K   ->  2.1K–2.7K
  - `root_domain` cache line 3:    10K–59K    ->  eliminated
- Patch 3:
  - `root_domain` cache line 1:    2.8K–44K   ->  eliminated
- Patch 4:
  - `cpupri_vec->mask` cache line: 2.2K–8.7K  ->  0.5K–2.2K

stress-ng rt cyclic benchmark:
Command:
stress-ng/stress-ng --cyclic $(nproc) --cyclic-policy fifo   \
                    --timeout 30 --minimize --metrics

Performance changes (bogo ops/s, real time):
- Baseline:             100.0%
- Baseline + Patch 1:   131.4%
- Baseline + Patch 2:   118.6%
- Baseline + Patch 3:   150.4%
- Baseline + Patch 4:   105.9%

rt-tests pi_stress benchmark:
Command:
rt-tests/pi_stress -D 30 -g $(($(nproc) / 2))

Performance changes (Total inversions performed):
- Baseline:             100.0%
- Baseline + Patch 1:   176.5%
- Baseline + Patch 2:   104.7%
- Baseline + Patch 3:   105.1%
- Baseline + Patch 4:   109.3%

Changes since v1:
 - Patch 3: Fixed non CONFIG_SMP build issue.
 - Patch 1-4: Added stress-ng/cyclic and rt-tests/pi_stress test result.

Comments are appreciated, I'm looking forward to hearing feedback
making revisions, thanks a lot!

Pan Deng (4):
  sched/rt: Optimize cpupri_vec layout to mitigate cache line contention
  sched/rt: Restructure root_domain to reduce cacheline contention
  sched/rt: Split root_domain->rto_count to per-NUMA-node counters
  sched/rt: Split cpupri_vec->cpumask to per NUMA node to reduce
    contention

 kernel/sched/cpupri.c   | 200 ++++++++++++++++++++++++++++++++++++----
 kernel/sched/cpupri.h   |   6 +-
 kernel/sched/rt.c       |  56 ++++++++++-
 kernel/sched/sched.h    |  61 ++++++------
 kernel/sched/topology.c |   7 ++
 5 files changed, 282 insertions(+), 48 deletions(-)

--
2.43.5


