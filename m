Return-Path: <linux-kernel+bounces-692705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824BAADF5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450973BDD85
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182DF2F49F6;
	Wed, 18 Jun 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4oxmgZr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9CC224FA
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270893; cv=none; b=qEiPDrqyW/FX5eEqdSBREc2/KsW2ZlsyFSTPRLkbDF/nuj8LGLSOuRXWkGNGBDXI8ZydAMTy0PYrckyZXKBsXf0mH8Iq5B8Y/FSM1WnFvtDCYd4O5CCsKctTb6VLadjXpSe3vKhb1+i+rqZktxFd/D+rR/pbzF/Xig0NXnLLKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270893; c=relaxed/simple;
	bh=baQPbCFRFTU7VDbd0g52anT8DmQ0+BXHu0odvpVybR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hJYhHZu43o1dfr9CRtPHurFSqD6vcRQvpxE0jIMukB69P3vmeZs7qARcyXSP7+o/0ilFiPVb0mGv+X221xamI4UdoNTPo6QmPY8aMRorKrdQ9UXyRVO8yPxhabAotJbrlEJLkhrRAKg/Pn4kGCDtflKRV4//AcgjSZGYKqyHLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4oxmgZr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750270891; x=1781806891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=baQPbCFRFTU7VDbd0g52anT8DmQ0+BXHu0odvpVybR8=;
  b=M4oxmgZroz5RD0kTIqQf5q32BidhZxOpWBPr67cn+mcVsjLhmL1YC5vt
   02hOuCfRpmdzyDRi1NzbFmlkozcSZWFzQXzLD/MgwsDbZzDIwsw5Hskt/
   Xzji10BCpjHSB5MQ/Iduc4olCoTZlGrIWoYTZgBkw2xgGCzhFetLBCfCr
   U+6BUFfh0G8KcGoGFaM0LPGX7tAVHX5TcfDAtMwoxod5rRzx67cs0soze
   32M6MoRFzZKT0x55ps4t8RjLB7eKNdJcqxT58A0qXEy5U4hNLQbnlT+8o
   vDZdP5xFmR0/NnC1FLAfsG3tZTNzjEaknvVsvXK0C6+6H1a0gKcPxoBeh
   w==;
X-CSE-ConnectionGUID: mLt2yXJXTn+VaWMQClWTaw==
X-CSE-MsgGUID: cYLX6NSwS7mb4wkhY958Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63931314"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63931314"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 11:21:30 -0700
X-CSE-ConnectionGUID: rVY7EyRaTq+9iM/hgUlmlw==
X-CSE-MsgGUID: BiS/fOfgSxeJay+hS4Uw/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="180959367"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jun 2025 11:21:29 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [RFC patch v3 00/20] Cache aware scheduling
Date: Wed, 18 Jun 2025 11:27:48 -0700
Message-Id: <cover.1750268218.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the third revision of the cache aware scheduling patches,
based on the original patch proposed by Peter[1].
 
The goal of the patch series is to aggregate tasks sharing data
to the same cache domain, thereby reducing cache bouncing and
cache misses, and improve data access efficiency. In the current
implementation, threads within the same process are considered
as entities that potentially share resources.
 
In previous versions, aggregation of tasks were done in the
wake up path, without making load balancing paths aware of
LLC (Last-Level-Cache) preference. This led to the following
problems:

1) Aggregation of tasks during wake up led to load imbalance
   between LLCs
2) Load balancing tried to even out the load between LLCs
3) Wake up tasks aggregation happened at a faster rate and
   load balancing moved tasks in opposite directions, leading
   to continuous and excessive task migrations and regressions
   in benchmarks like schbench.

In this version, load balancing is made cache-aware. The main
idea of cache-aware load balancing consists of two parts:

1) Identify tasks that prefer to run on their hottest LLC and
   move them there.
2) Prevent generic load balancing from moving a task out of
   its hottest LLC.

By default, LLC task aggregation during wake-up is disabled.
Conversely, cache-aware load balancing is enabled by default.
For easier comparison, two scheduler features are introduced:
SCHED_CACHE_WAKE and SCHED_CACHE_LB, which control cache-aware
wake up and cache-aware load balancing, respectively. By default,
NO_SCHED_CACHE_WAKE and SCHED_CACHE_LB are set, so tasks aggregation
is only done on load balancing.

With above default settings, task migrations occur less frequently
and no longer happen in the latency-sensitive wake-up path.

The load balancing and migration policy are now implemented in
a single location within the function _get_migrate_hint().
Debugfs knobs are also introduced to fine-tune the
_get_migrate_hint() function. Please refer to patch 7 for
detail.

Improvements in performance for hackbench are observed in the
lower load ranges when tested on a 2 socket sapphire rapids with
30 cores per socket. The DRAM interleaving is enabled in the
BIOS so it essential has one NUMA node with two last level
caches. Hackbench benefits from having all the threads
in the process running in the same LLC. There are some small
regressions for the heavily loaded case when not all threads can
fit in a LLC.

Hackbench is run with one process, and pairs of threads ping
ponging message off each other via command with increasing number
of thread pairs, each test runs for 10 cycles:

hackbench -g 1 --thread --pipe(socket) -l 1000000 -s 100 -f <pairs>

case                    load            baseline(std%)  compare%( std%)
threads-pipe-8          1-groups         1.00 (  2.70)  +24.51 (  0.59)
threads-pipe-15         1-groups         1.00 (  1.42)  +28.37 (  0.68)
threads-pipe-30         1-groups         1.00 (  2.53)  +26.16 (  0.11)
threads-pipe-45         1-groups         1.00 (  0.48)  +35.38 (  0.18)
threads-pipe-60         1-groups         1.00 (  2.13)  +13.46 ( 12.81)
threads-pipe-75         1-groups         1.00 (  1.57)  +16.71 (  0.20)
threads-pipe-90         1-groups         1.00 (  0.22)   -0.57 (  1.21)
threads-sockets-8       1-groups         1.00 (  2.82)  +23.04 (  0.83)
threads-sockets-15      1-groups         1.00 (  2.57)  +21.67 (  1.90)
threads-sockets-30      1-groups         1.00 (  0.75)  +18.78 (  0.09)
threads-sockets-45      1-groups         1.00 (  1.63)  +18.89 (  0.43)
threads-sockets-60      1-groups         1.00 (  0.66)  +10.10 (  1.91)
threads-sockets-75      1-groups         1.00 (  0.44)  -14.49 (  0.43)
threads-sockets-90      1-groups         1.00 (  0.15)   -8.03 (  3.88)

Similar tests were also experimented on schbench on the system.
Overall latency improvement is observed when underloaded and
regression when overloaded. The regression is significantly
smaller than the previous version because cache aware aggregation
is in load balancing rather than in wake up path. Besides, it is
found that the schbench seems to have large run-to-run variance,
so the result of schbench might be only used as reference.

schbench:
                                   baseline              nowake_lb
Lat 50.0th-qrtle-1          5.00 (   0.00%)        5.00 (   0.00%)
Lat 90.0th-qrtle-1          9.00 (   0.00%)        8.00 (  11.11%)
Lat 99.0th-qrtle-1         15.00 (   0.00%)       15.00 (   0.00%)
Lat 99.9th-qrtle-1         32.00 (   0.00%)       23.00 (  28.12%)
Lat 20.0th-qrtle-1        267.00 (   0.00%)      266.00 (   0.37%)
Lat 50.0th-qrtle-2          8.00 (   0.00%)        4.00 (  50.00%)
Lat 90.0th-qrtle-2          9.00 (   0.00%)        7.00 (  22.22%)
Lat 99.0th-qrtle-2         18.00 (   0.00%)       11.00 (  38.89%)
Lat 99.9th-qrtle-2         26.00 (   0.00%)       25.00 (   3.85%)
Lat 20.0th-qrtle-2        535.00 (   0.00%)      537.00 (  -0.37%)
Lat 50.0th-qrtle-4          6.00 (   0.00%)        4.00 (  33.33%)
Lat 90.0th-qrtle-4          8.00 (   0.00%)        5.00 (  37.50%)
Lat 99.0th-qrtle-4         13.00 (   0.00%)       10.00 (  23.08%)
Lat 99.9th-qrtle-4         20.00 (   0.00%)       14.00 (  30.00%)
Lat 20.0th-qrtle-4       1066.00 (   0.00%)     1050.00 (   1.50%)
Lat 50.0th-qrtle-8          5.00 (   0.00%)        4.00 (  20.00%)
Lat 90.0th-qrtle-8          7.00 (   0.00%)        5.00 (  28.57%)
Lat 99.0th-qrtle-8         11.00 (   0.00%)        8.00 (  27.27%)
Lat 99.9th-qrtle-8         17.00 (   0.00%)       18.00 (  -5.88%)
Lat 20.0th-qrtle-8       2140.00 (   0.00%)     2156.00 (  -0.75%)
Lat 50.0th-qrtle-16         6.00 (   0.00%)        4.00 (  33.33%)
Lat 90.0th-qrtle-16         7.00 (   0.00%)        6.00 (  14.29%)
Lat 99.0th-qrtle-16        11.00 (   0.00%)       11.00 (   0.00%)
Lat 99.9th-qrtle-16        18.00 (   0.00%)       18.00 (   0.00%)
Lat 20.0th-qrtle-16      4296.00 (   0.00%)     4216.00 (   1.86%)
Lat 50.0th-qrtle-32         6.00 (   0.00%)        4.00 (  33.33%)
Lat 90.0th-qrtle-32         7.00 (   0.00%)        5.00 (  28.57%)
Lat 99.0th-qrtle-32        11.00 (   0.00%)        9.00 (  18.18%)
Lat 99.9th-qrtle-32        17.00 (   0.00%)       14.00 (  17.65%)
Lat 20.0th-qrtle-32      8496.00 (   0.00%)     8624.00 (  -1.51%)
Lat 50.0th-qrtle-64         5.00 (   0.00%)        5.00 (   0.00%)
Lat 90.0th-qrtle-64         7.00 (   0.00%)        7.00 (   0.00%)
Lat 99.0th-qrtle-64        11.00 (   0.00%)       11.00 (   0.00%)
Lat 99.9th-qrtle-64        17.00 (   0.00%)       18.00 (  -5.88%)
Lat 20.0th-qrtle-64     17120.00 (   0.00%)    15728.00 (   8.13%)
Lat 50.0th-qrtle-128        6.00 (   0.00%)        6.00 (   0.00%)
Lat 90.0th-qrtle-128        9.00 (   0.00%)        8.00 (  11.11%)
Lat 99.0th-qrtle-128       13.00 (   0.00%)       14.00 (  -7.69%)
Lat 99.9th-qrtle-128       20.00 (   0.00%)       26.00 ( -30.00%)
Lat 20.0th-qrtle-128    19488.00 (   0.00%)    18784.00 (   3.61%)
Lat 50.0th-qrtle-239        8.00 (   0.00%)        8.00 (   0.00%)
Lat 90.0th-qrtle-239       16.00 (   0.00%)       14.00 (  12.50%)
Lat 99.0th-qrtle-239       45.00 (   0.00%)       41.00 (   8.89%)
Lat 99.9th-qrtle-239      137.00 (   0.00%)      225.00 ( -64.23%)
Lat 20.0th-qrtle-239    30432.00 (   0.00%)    29920.00 (   1.68%)

AMD Milan is also tested. There are 4 Nodes and 32 CPUs per node.
Each node has 4 CCX(shared LLC) and each CCX has 8 CPUs. Hackbench
with 1 group test scenario benefits from cache aware load balance
too:

hackbench(1 group and fd ranges in [1,6]:
case                    load            baseline(std%)  compare%( std%)
threads-pipe-1          1-groups         1.00 (  1.22)   +2.84 (  0.51)
threads-pipe-2          1-groups         1.00 (  5.82)  +42.82 ( 43.61)
threads-pipe-3          1-groups         1.00 (  3.49)  +17.33 ( 18.68)
threads-pipe-4          1-groups         1.00 (  2.49)  +12.49 (  5.89)
threads-pipe-5          1-groups         1.00 (  1.46)   +8.62 (  4.43)
threads-pipe-6          1-groups         1.00 (  2.83)  +12.73 (  8.94)
threads-sockets-1       1-groups         1.00 (  1.31)  +28.68 (  2.25)
threads-sockets-2       1-groups         1.00 (  5.17)  +34.84 ( 36.90)
threads-sockets-3       1-groups         1.00 (  1.57)   +9.15 (  5.52)
threads-sockets-4       1-groups         1.00 (  1.99)  +16.51 (  6.04)
threads-sockets-5       1-groups         1.00 (  2.39)  +10.88 (  2.17)
threads-sockets-6       1-groups         1.00 (  1.62)   +7.22 (  2.00)

Besides a single instance of hackbench, four instances of hackbench are
also tested on Milan. The test results show that different instances of
hackbench are aggregated to dedicated LLCs, and performance improvement
is observed.

schbench mmtests(unstable)
                                  baseline              nowake_lb
Lat 50.0th-qrtle-1         9.00 (   0.00%)        8.00 (  11.11%)
Lat 90.0th-qrtle-1        12.00 (   0.00%)       10.00 (  16.67%)
Lat 99.0th-qrtle-1        16.00 (   0.00%)       14.00 (  12.50%)
Lat 99.9th-qrtle-1        22.00 (   0.00%)       21.00 (   4.55%)
Lat 20.0th-qrtle-1       759.00 (   0.00%)      759.00 (   0.00%)
Lat 50.0th-qrtle-2         9.00 (   0.00%)        7.00 (  22.22%)
Lat 90.0th-qrtle-2        12.00 (   0.00%)       12.00 (   0.00%)
Lat 99.0th-qrtle-2        16.00 (   0.00%)       15.00 (   6.25%)
Lat 99.9th-qrtle-2        22.00 (   0.00%)       21.00 (   4.55%)
Lat 20.0th-qrtle-2      1534.00 (   0.00%)     1510.00 (   1.56%)
Lat 50.0th-qrtle-4         8.00 (   0.00%)        9.00 ( -12.50%)
Lat 90.0th-qrtle-4        12.00 (   0.00%)       12.00 (   0.00%)
Lat 99.0th-qrtle-4        15.00 (   0.00%)       16.00 (  -6.67%)
Lat 99.9th-qrtle-4        21.00 (   0.00%)       23.00 (  -9.52%)
Lat 20.0th-qrtle-4      3076.00 (   0.00%)     2860.00 (   7.02%)
Lat 50.0th-qrtle-8        10.00 (   0.00%)        9.00 (  10.00%)
Lat 90.0th-qrtle-8        12.00 (   0.00%)       13.00 (  -8.33%)
Lat 99.0th-qrtle-8        17.00 (   0.00%)       17.00 (   0.00%)
Lat 99.9th-qrtle-8        22.00 (   0.00%)       24.00 (  -9.09%)
Lat 20.0th-qrtle-8      6232.00 (   0.00%)     5896.00 (   5.39%)
Lat 50.0th-qrtle-16        9.00 (   0.00%)        9.00 (   0.00%)
Lat 90.0th-qrtle-16       13.00 (   0.00%)       13.00 (   0.00%)
Lat 99.0th-qrtle-16       17.00 (   0.00%)       18.00 (  -5.88%)
Lat 99.9th-qrtle-16       23.00 (   0.00%)       26.00 ( -13.04%)
Lat 20.0th-qrtle-16    10096.00 (   0.00%)    10352.00 (  -2.54%)
Lat 50.0th-qrtle-32       15.00 (   0.00%)       15.00 (   0.00%)
Lat 90.0th-qrtle-32       25.00 (   0.00%)       26.00 (  -4.00%)
Lat 99.0th-qrtle-32       49.00 (   0.00%)       50.00 (  -2.04%)
Lat 99.9th-qrtle-32      945.00 (   0.00%)     1005.00 (  -6.35%)
Lat 20.0th-qrtle-32    11600.00 (   0.00%)    11632.00 (  -0.28%)

Netperf/Tbench have not been tested yet. As they are single-process
benchmarks that are not the target of this cache-aware scheduling.
Additionally, client and server components should be tested on
different machines or bound to different nodes. Otherwise,
cache-aware scheduling might harm their performance: placing client
and server in the same LLC could yield higher throughput due to
improved cache locality in the TCP/IP stack, whereas cache-aware
scheduling aims to place them in dedicated LLCs.

This patch set is applied on v6.15 kernel.
 
There are some further work needed for future versions in this
patch set.  We will need to align NUMA balancing with LLC aggregations
such that LLC aggregation will align with the preferred NUMA node.

Comments and tests are much appreciated.

[1] https://lore.kernel.org/all/20250325120952.GJ36322@noisy.programming.kicks-ass.net/

The patches are grouped as follow:
Patch 1:     Peter's original patch.
Patch 2-5:   Various fixes and tuning of the original v1 patch.
Patch 6-12:  Infrastructure and helper functions for load balancing to be cache aware.
Patch 13-18: Add logic to load balancing for preferred LLC aggregation.
Patch 19:    Add process LLC aggregation in load balancing sched feature.
Patch 20:    Add Process LLC aggregation in wake up sched feature (turn off by default).

v1:
https://lore.kernel.org/lkml/20250325120952.GJ36322@noisy.programming.kicks-ass.net/
v2:
https://lore.kernel.org/lkml/cover.1745199017.git.yu.c.chen@intel.com/


Chen Yu (3):
  sched: Several fixes for cache aware scheduling
  sched: Avoid task migration within its preferred LLC
  sched: Save the per LLC utilization for better cache aware scheduling

K Prateek Nayak (1):
  sched: Avoid calculating the cpumask if the system is overloaded

Peter Zijlstra (1):
  sched: Cache aware load-balancing

Tim Chen (15):
  sched: Add hysteresis to switch a task's preferred LLC
  sched: Add helper function to decide whether to allow cache aware
    scheduling
  sched: Set up LLC indexing
  sched: Introduce task preferred LLC field
  sched: Calculate the number of tasks that have LLC preference on a
    runqueue
  sched: Introduce per runqueue task LLC preference counter
  sched: Calculate the total number of preferred LLC tasks during load
    balance
  sched: Tag the sched group as llc_balance if it has tasks prefer other
    LLC
  sched: Introduce update_llc_busiest() to deal with groups having
    preferred LLC tasks
  sched: Introduce a new migration_type to track the preferred LLC load
    balance
  sched: Consider LLC locality for active balance
  sched: Consider LLC preference when picking tasks from busiest queue
  sched: Do not migrate task if it is moving out of its preferred LLC
  sched: Introduce SCHED_CACHE_LB to control cache aware load balance
  sched: Introduce SCHED_CACHE_WAKE to control LLC aggregation on wake
    up

 include/linux/mm_types.h       |  44 ++
 include/linux/sched.h          |   8 +
 include/linux/sched/topology.h |   3 +
 init/Kconfig                   |   4 +
 init/init_task.c               |   3 +
 kernel/fork.c                  |   5 +
 kernel/sched/core.c            |  25 +-
 kernel/sched/debug.c           |   4 +
 kernel/sched/fair.c            | 859 ++++++++++++++++++++++++++++++++-
 kernel/sched/features.h        |   3 +
 kernel/sched/sched.h           |  23 +
 kernel/sched/topology.c        |  29 ++
 12 files changed, 982 insertions(+), 28 deletions(-)

-- 
2.32.0


