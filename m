Return-Path: <linux-kernel+bounces-612010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C91AA94968
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 21:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E121891CE0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C71A00FE;
	Sun, 20 Apr 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6jmHEzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCE1C3308;
	Sun, 20 Apr 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178037; cv=none; b=t5Ovv08u0XsevC5saMnwNXM1zMwD9+3gxo60bDaL2ajxe+iqDssjRdYUoAO4Jz6Y3xyhy7sxMIFHsCwHYWQlWZMqR/m0f6kX2lWIwtTmpKmXEyWwRrQ3h5VPckIlvve0kzO/S7rpAY8k0ucp25MZ1fkiGjZ/x+f3ODubiHzanE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178037; c=relaxed/simple;
	bh=WER3yiCxSUNd35waDmXna/DAdssXo1TLxiXerC/7Nck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=indOLxMFzp8TZR+sjvSoMC1rRcLdWBx3R2qfghnos5suw1Fq60L47amXMwLI88hl4ZK1DZ2Z+dXHteG+H6AFOhBtXhHRQG+bl9ifrdHk1MwjHP4gIc73WPtmthE8RErIWxFGHEMto8yXNxfDeYpbrd7tX8Z5mA3Ma0esCUotpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6jmHEzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567A5C4CEE2;
	Sun, 20 Apr 2025 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178036;
	bh=WER3yiCxSUNd35waDmXna/DAdssXo1TLxiXerC/7Nck=;
	h=From:To:Cc:Subject:Date:From;
	b=K6jmHEzIOiu3Gkb1+XUhXWZ6n7Ym7IK2GVGTrScD1whM3g2Pyto2dm76dl4sG0Brr
	 7KlEDHEzWsQ9b3nOXiaAO0dWdeDF1C0WIk8ttOtez7m9OVujYqPIBPb4yxgK4k/ido
	 CRsWO2EJa+5iZBgWf8tovo630V4Gh3HGhsigDNemlbsuepMUHKiogczSis8+1OPJWK
	 k5yV2XDmrHaEZGAZI68eIwueRyE2q395NIyishiRshlqWxmIdTMCT4eCcGksk4CXxz
	 9Z79alc6LaLiI3dmQuVGnqwuXXhtrr3FLudw4WRVa6kviLvAYS6e8TeSpk+dNHk3fa
	 1T1S5ng/bqyag==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] mm/damon: auto-tune DAMOS for NUMA setups including tiered memory
Date: Sun, 20 Apr 2025 12:40:23 -0700
Message-Id: <20250420194030.75838-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilizing DAMON for memory tiering usually requires manual tuning and/or
tedious controls.  Let it self-tune hotness and coldness thresholds for
promotion and demotion aiming high utilization of high memory tiers, by
introducing new DAMOS quota goal metrics representing the used and the
free memory ratios of specific NUMA nodes.  And introduce a sample DAMON
module that demonstrates how the new feature can be used for memory
tiering use cases.

Backgrounds
===========

A type of tiered memory system exposes the memory tiers as NUMA nodes.
A straightforward pages placement strategy for such systems is placing
access-hot and cold pages on upper and lower tiers, reespectively,
pursuing higher utilization of upper tiers.  Since access temperature
can be dynamic, periodically finding and migrating hot pages and cold
pages to proper tiers (promoting and demoting) is also required.  Linux
kernel provides several features for such dynamic and transparent pages
placement.

Page Faults and LRU
-------------------

One widely known way is using NUMA balancing in tiering mode (a.k.a
NUMAB-2) and reclaim-based demotion features.  In the setup, NUMAB-2
finds hot pages using access check-purpose page faults (a.k.a prot_none)
and promote those inside each process' context, until there is no more
pages to promote, or the upper tier is filled up and memory pressure
happens.  In the latter case, LRU-based reclaim logic wakes up as a
response to the memory pressure and demotes cold pages to lower tiers in
asynchronous (kswapd) and/or synchronous ways (direct reclaim).

DAMON
-----

Yet another available solution is using DAMOS with migrate_hot and
migrate_cold DAMOS actions for promotions and demotions, respectively.
To make it optimum, users need to specify aggressiveness and access
temperature thresholds for promotions and demotions in a good balance
that results in high utilization of upper tiers.  The number of
parameters is not small, and optimum parameter values depend on
characteristics of the underlying hardware and the workload.  As a
result, it often requires manual, time consuming and repetitive tuning
of the DAMOS schemes for given workloads and systems combinations.

Self-tuned DAMON-based Memory Tiering
=====================================

To solve such manual tuning problems, DAMOS provides aim-oriented
feedback-driven quotas self-tuning.  Using the feature, we design a
self-tuned DAMON-based memory tiering for general multi-tier memory
systems.

For each memory tier node, if it has a lower tier, run a DAMOS scheme
that demotes cold pages of the node, auto-tuning the aggressiveness
aiming an amount of free space of the node.  The free space is for
keeping the headroom that avoids significant memory pressure during
upper tier memory usage spike, and promoting hot pages from the lower
tier.

For each memory tier node, if it has an upper tier, run a DAMOS scheme
that promotes hot pages of the current node to the upper tier,
auto-tuning the aggressiveness aiming a high utilization ratio of the
upper tier.  The target ratio is to ensure higher tiers are utilized as
much as possible.  It should match with the headroom for demotion
scheme, but have slight overlap, to ensure promotion and demotion are
not entirely stopped.

The aim-oriented aggressiveness auto-tuning of DAMOS is already
available.  Hence, to make such tiering solution implementation, only
new quota goal metrics for utilization and free space ratio of specific
NUMA node need to be developed.

Discussions
===========

The design imposes below discussion points.

Expected Behaviors
------------------

The system will let upper tier memory node accommodates as many hot data
as possible.  If total amount of the data is less than the top tier
memory's promotion/demotion target utilization, entire data will be just
placed on the top tier.  Promotion scheme will do nothing since there is
no data to promote.  Demotion scheme will also do nothing since the free
space ratio of the top tier is higher than the goal.

Only if the amount of data is larger than the top tier's utilization
ratio, demotion scheme will demote cold pages and ensure the headroom
free space.  Since the promotion and demotion schemes for a single node
has small overlap at their target utilization and free space goals,
promotions and demotions will continue working with a moderate
aggressiveness level.  It will keep all data is placed on access hotness
under dynamic access pattern, while minimizing the migration overhead.

In any case, each node will keep headroom free space and as many upper
tiers are utilized as possible.

Ease of Use
-----------

Users still need to set the target utilization and free space ratio, but
it will be easier to set.  We argue 99.7 % utilization and 0.5 % free
space ratios can be good default values.  It can be easily adjusted
based on desired headroom size of given use case.  Users are also still
required to answer the minimum coldness and hotness thresholds.
Together with monitoring intervals auto-tuning[2], DAMON will always
show meaningful amount of hot and cold memory.  And DAMOS quota's
prioritization mechanism will make good decision as long as the source
information is that colorful.  Hence, users can very naively set the
minimum criterias.  We believe any access observation and no access
observation within last one aggregation interval is enough for minimum
hot and cold regions criterias.

General Tiered Memory Setup Applicability
-----------------------------------------

The design can be applied to any number of tiers having any performance
characteristics, as long as they can be hierarchical.  Hence, applying
the system to different tiered memory system will be straightforward.
Note that this assumes only single CPU NUMA node case.  Because today's
DAMON is not aware of which CPU made each access, applying this on
systems having multiple CPU NUMA nodes can be complicated.  We are
planning to extend DAMON for the use case, but that's out of the scope
of this patch series.

How To Use
----------

Users can implement the auto-tuned DAMON-based memory tiering using
DAMON sysfs interface.  It can be easily done using DAMON user-space
tool like user-space tool.  Below evaluation results section shows an
example DAMON user-space tool command for that.

For wider and simpler deployment, having a kernel module that sets up
and run the DAMOS schemes via DAMON kernel API can be useful.  The
module can enable the memory tiering at boot time via kernel command
line parameter or at run time with single command.  This patch series
implements a sample DAMON kernel module that shows how such module can
be implemented.

Comparison To Page Faults and LRU-based Approaches
--------------------------------------------------

The existing page faults based promotion (NUMAB-2) does hot pages
detection and migration in the process context.  When there are many
pages to promote, it can block the progress of the application's real
works.  DAMOS works in asynchronous worker thread, so it doesn't block
the real works.

NUMAB-2 doesn't provide a way to control aggressiveness of promotion
other than the maximum amount of pages to promote per given time widnow.
If hot pages are found, promotions can happen in the upper-bound speed,
regardless of upper tier's memory pressure.  If the maximum speed is not
well set for the given workload, it can result in slow promotion or
unnecessary memory pressure.  Self-tuned DAMON-based memory tiering
alleviates the problem by adjusting the speed based on current
utilization of the upper tier.

LRU-based demotion can be triggered in both asynchronous (kswapd) and
synchronous (direct reclaim) ways.  Other than the way of finding cold
pages, asynchronous LRU-based demotion and DAMON-based demotion has no
big difference.  DAMON-based demotion can make a better balancing with
DAMON-based promotion, though.  The LRU-based demotion can do better
than DAMON-based demotion when the tier is having significant memory
pressure.  It would be wise to use DAMON-based demotion as a proactive
and primary one, but utilizing LRU-based demotions together as a fast
backup solution.

Evaluation
==========

In short, under a setup that requires fast and frequent promotions,
self-tuned DAMON-based memory tiering's hot pages promotion improves
performance about 4.42 %.  We believe this shows self-tuned DAMON-based
promotion's effectiveness.  Meanwhile, NUMAB-2's hot pages promotion
degrades the performance about 7.34 %.  We suspect the degradation is
mostly due to NUMAB-2's synchronous nature that can block the
application's progress, which highlights the advantage of DAMON-based
solution's asynchronous nature.

Note that the test was done with the RFC version of this patch series.
We don't run it again since this patch series got no meaningful change
after the RFC, while the test takes pretty long time.

Setup
-----

Hardware.  Use a machine that equips 250 GiB DRAM memory tier and 50 GiB
CXL memory tier.  The tiers are exposed as NUMA nodes 0 and 1,
respectively.

Kernel.  Use Linux kernel v6.13 that modified as following.  Add all
DAMON patches that available on mm tree of 2025-03-15, and this patch
series.  Also modify it to ignore mempolicy() system calls, to avoid bad
effects from application's traditional NUMA systems assumed
optimizations.

Workload.  Use a modified version of Taobench benchmark[3] that
available on DCPerf benchmark suite.  It represents an in-memory caching
workload.  We set its 'memsize', 'warmup_time', and 'test_time'
parameter as 340 GiB, 2,500 seconds and 1,440 seconds.  The parameters
are chosen to ensure the workload uses more than DRAM memory tier.  Its
RSS under the parameter grows to 270 GiB within the warmup time.

It turned out the workload has a very static access pattrn.  Only about
13 % of the RSS is frequently accessed from the beginning to end.  Hence
promotion shows no meaningful performance difference regardless of
different design and implementations.  We therefore modify the kernel to
periodically demote up to 10 GiB hot pages and promote up to 10 GiB cold
pages once per minute.  The intention is to simulate periodic access
pattern changes.  The hotness and coldness threshold is very naively set
so that it is more like random access pattern change rather than strict
hot/cold pages exchange.  This is why we call the workload as
"modified".  It is implemented as two DAMOS schemes each running on an
asynchronous thread.  It can be reproduced with DAMON user-space tool
like below.

    # ./damo start \
        --ops paddr --numa_node 0 --monitoring_intervals 10s 200s 200s \
            --damos_action migrate_hot 1 \
            --damos_quota_interval 60s --damos_quota_space 10G \
        --ops paddr --numa_node 1 --monitoring_intervals 10s 200s 200s \
            --damos_action migrate_cold 0 \
            --damos_quota_interval 60s --damos_quota_space 10G \
        --nr_schemes 1 1 --nr_targets 1 1 --nr_ctxs 1 1

System configurations.  Use below variant system configurations.

- Baseline.  No memory tiering features are turned on.
- Numab_tiering.  On the baseline, enable NUMAB-2 and relcaim-based
  demotion.  In detail, following command is executed:
  echo 2 > /proc/sys/kernel/numa_balancing;
  echo 1 > /sys/kernel/mm/numa/demotion_enabled;
  echo 7 > /proc/sys/vm/zone_reclaim_mode
- DAMON_tiering.  On the baseline, utilize self-tuned DAMON-based memory
  tiering implementation via DAMON user-space tool.  It utilizes two
  kernel threads, namely promotion thread and demotion thread.  Demotion
  thread monitors access pattern of DRAM node using DAMON with
  auto-tuned monitoring intervals aiming 4% DAMON-observed access ratio,
  and demote coldest pages up to 200 MiB per second aiming 0.5% free
  space of DRAM node.  Promotion thread monitors CXL node using same
  intervals auto-tuning, and promote hot pages in same way but aiming
  for 99.7% utilization of DRAM node.  Because DAMON provides only
  best-effort accuracy, add young page DAMOS filters to allow only and
  reject all young pages at promoting and demoting, respectively.  It
  can be reproduced with DAMON user-space tool like below.

    # ./damo start \
        --numa_node 0 --monitoring_intervals_goal 4% 3 5ms 10s \
            --damos_action migrate_cold 1 --damos_access_rate 0% 0% \
            --damos_apply_interval 1s \
            --damos_quota_interval 1s --damos_quota_space 200MB \
            --damos_quota_goal node_mem_free_bp 0.5% 0 \
            --damos_filter reject young \
        --numa_node 1 --monitoring_intervals_goal 4% 3 5ms 10s \
            --damos_action migrate_hot 0 --damos_access_rate 5% max \
            --damos_apply_interval 1s \
            --damos_quota_interval 1s --damos_quota_space 200MB \
            --damos_quota_goal node_mem_used_bp 99.7% 0 \
            --damos_filter allow young \
            --damos_nr_quota_goals 1 1 --damos_nr_filters 1 1 \
        --nr_targets 1 1 --nr_schemes 1 1 --nr_ctxs 1 1

Measurment Results
------------------

On each system configuration, run the modified version of Taobench and
collect 'score'.  'score' is a metric that calculated and provided by
Taobench to represents the performance of the run on the  system.  To
handle the measurement errors, repeat the measurement five times.  The
results are as below.

    Config         Score   Stdev   (%)     Normalized
    Baseline       1.6165  0.0319  1.9764  1.0000
    Numab_tiering  1.4976  0.0452  3.0209  0.9264
    DAMON_tiering  1.6881  0.0249  1.4767  1.0443

'Config' column shows the system config of the measurement.  'Score'
column shows the 'score' measurement in average of the five runs on the
system config.  'Stdev' column shows the standsard deviation of the five
measurements of the scores.  '(%)' column shows the 'Stdev' to 'Score'
ratio in percentage.  Finally, 'Normalized' column shows the averaged
score values of the configs that normalized to that of 'Baseline'.

The periodic hot pages demotion and cold pages promotion that was
conducted to simulate dynamic access pattern was started from the
beginning of the workload.  It resulted in the DRAM tier utilization
always under the watermark, and hence no real demotion was happened for
all test runs.  This means the above results show no difference between
LRU-based and DAMON-based demotions.  Only difference between NUMAB-2
and DAMON-based promotions are represented on the results.

Numab_tiering config degraded the performance about 7.36 %.  We suspect
this happened because NUMAB-2's synchronous promotion was blocking the
Taobench's real work progress.

DAMON_tiering config improved the performance about 4.43 %.  We believe
this shows effectiveness of DAMON-based promotion that didn't block
Taobench's real work progress due to its asynchronous nature.  Also this
means DAMON's monitoring results are accurate enough to provide visible
amount of improvement.

Evaluation Limitations
----------------------

As mentioned above, this evaluation shows only comparison of promotion
mechanisms.  DAMON-based tiering is recommended to be used together with
reclaim-based demotion as a faster backup under significant memory
pressure, though.

From some perspective, the modified version of Taobench may seems making
the picture distorted too much.  It would be better to evaluate with
more realistic workload, or more finely tuned micro benchmarks.

Patch Sequence
==============

The first patch (patch 1) implements two new quota goal metrics on core
layer and expose it to DAMON core kernel API.  The second and third ones
(patches 2 and 3) further link it to DAMON sysfs interface.  Three
following patches (patches 4-6) document the new feature and sysfs file
on design, usage, and ABI documents.  The final one (patch 7) implements
a working version of a self-tuned DAMON-based memory tiering solution in
an incomplete but easy to understand form as a kernel module under
samples/damon/ directory.

References
==========

[1] https://lore.kernel.org/20231112195602.61525-1-sj@kernel.org/
[2] https://lore.kernel.org/20250303221726.484227-1-sj@kernel.org
[3] https://github.com/facebookresearch/DCPerf/blob/main/packages/tao_bench/README.md

SeongJae Park (7):
  mm/damon/core: introduce damos quota goal metrics for memory node
    utilization
  mm/damon/sysfs-schemes: implement file for quota goal nid parameter
  mm/damon/sysfs-schemes: connect damos_quota_goal nid with core layer
  Docs/mm/damon/design: document node_mem_{used,free}_bp
  Docs/admin-guide/mm/damon/usage: document 'nid' file
  Docs/ABI/damon: document nid file
  samples/damon: implement a DAMON module for memory tiering

 .../ABI/testing/sysfs-kernel-mm-damon         |   6 +
 Documentation/admin-guide/mm/damon/usage.rst  |  12 +-
 Documentation/mm/damon/design.rst             |  13 +-
 include/linux/damon.h                         |   6 +
 mm/damon/core.c                               |  27 +++
 mm/damon/sysfs-schemes.c                      |  40 ++++-
 samples/damon/Kconfig                         |  13 ++
 samples/damon/Makefile                        |   1 +
 samples/damon/mtier.c                         | 167 ++++++++++++++++++
 9 files changed, 274 insertions(+), 11 deletions(-)
 create mode 100644 samples/damon/mtier.c


base-commit: 449d17baba9648a901928d38eee56f914b39248e
-- 
2.39.5

