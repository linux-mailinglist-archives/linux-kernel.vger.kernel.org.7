Return-Path: <linux-kernel+bounces-694668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30DEAE0F45
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F871BC62C7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 22:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A62609F1;
	Thu, 19 Jun 2025 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuGGa88K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902D260585;
	Thu, 19 Jun 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370429; cv=none; b=LWEzlf00wPCRY8lsUEWOjlO2aS4FxT9R2uwu91m8OqaxQLTrjTsZIfjhhNRmRRgAhxCShH4ftY0V6Sa45b0PA9zm/4rqBRYYxtm+D9OoOtKYgTVPVm0jChm8VYuoFE81rnr2LeCsK/VwxzIIGJ9mpI2e6WYmcHdhhqNDNcr4REo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370429; c=relaxed/simple;
	bh=5g5pUhqvWHwQSLawpYczRGjcwfcL9SX0YIQIZ57Gx8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HcYGdHkdUcfIj7Ep4OJTiTQkdBDg2nuNS0INaRPF5Ai1ynAIH0tfc7OS47jPezVKpt7ekqquHJlf82JnGpsj9bjUm+tWllFmx7fR2hIondNeMKF0VHvm72NbP09reehYXisRebCQyEEGRKWyLBcY0dAnT91NqtPlUCmm5lQSkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuGGa88K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8F2C4CEEA;
	Thu, 19 Jun 2025 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370428;
	bh=5g5pUhqvWHwQSLawpYczRGjcwfcL9SX0YIQIZ57Gx8g=;
	h=From:To:Cc:Subject:Date:From;
	b=TuGGa88KuXOVz6iWjTf81ofhhF665Wx//Sh0u89ALls9+wODDNAPfGY9xmRnvBVKU
	 vWWDtCoyudkO8IJ1nAuucgzryAjRKJWvBuFkQwHLLXAJESZzgHekW1UWsV5rE7yJX7
	 wR6SbCLrMc8iaxZ09D9vzyWHfCiLCBIjLcbCQgsjrHPtznCdWKGCjxCQF4czNxPsqL
	 VQpAwWaNLq+2wzhIW3KjO2adpFwEPwyqzuo5q/JduXTU7nrpXSnCNCFcE5m8X+hF74
	 u4brTSgyXDZx1H15WZTK4hSaffiYbqWIbkR+n8RZVGdktlSYq7ABDqrF9DWAX5SzbN
	 TIwHg9qsBe0ag==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/11] mm/damon: allow DAMOS auto-tuned for per-memcg per-node memory usage
Date: Thu, 19 Jun 2025 15:00:12 -0700
Message-Id: <20250619220023.24023-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduce two new DAMOS quota auto-tuning target
metrics for per-cgroup per-node memory usage.  Those are assumed to be
useful for various cgroup-aware case including memory tiering on
cgroup-based multi-tenant systems.

Background
----------

DAMOS' aim-oriented aggressiveness auto-tuning feature is a highly
recommended way for modern DAMOS use cases.  Using it, users can specify
what system status they want to achive with what access-aware system
operations.  For example, reclaim cold memory aiming 0.5 % of memory
pressure (proactive reclaim), or migrate hot and cold memory between
NUMA nodes having different speed (memory tiering).  Then DAMOS
automatically adjusts the aggressiveness of the system operation (e.g.,
increase/decrease reclaim target coldness threshold) based on current
status of the system.

The use case is hence limited by the supported system status metrics for
specifying the target system status.  Two new system metrics for
per-node memory usage ratio, namely DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP,
were recently added to extend the use cases for access-aware NUMA nodes
management, such as memory tiering.

Limitation
~~~~~~~~~~

The per-node memory usage based auto-tuning can be applied only
system-wide.  For cgroups-based multi tenant systems, it could harm the
fairness.  For example, even if the cgroups have their own memory.low
values for protecting their memory, it could result in a cgroup having
more hot pages using more portion of fast tier NUMA node.  Depending on
the definition and promise of the fairness, this could be suboptimum.

DAMOS supports cgroup-aware system operations via DAMOS filter.  But
quota auto-tuning system is not aware of cgroups.

New DAMOS Quota Tuning Metrics for Per-Cgroup Per-NUMA Memory Usage
-------------------------------------------------------------------

To overcome the limitation, this patch series introduces two new DAMOS
quota auto-tuning goal metrics, namely
DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP.  Those can be thought of as a
variant of DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP that extended for
cgroups.

The two metrics specifies per-cgroup, per-node amount of used and unused
memory in ratio to the total memory of the node.  For example, let's
assume a system has two NUMA nodes of size 100 GiB and 50 GiB.  And two
cgroups are using 40 and 60 GiB of node 0, 20 and 10 GiB of node 1,
respectively.

                     node-0    node-1
    Total memory     100 GiB   50 GiB
    Cgroup A usage   40 GiB    20 GiB
    Cgroup B usage   60 GiB    10 GiB

Then, DAMOS_QUOTA_NODE_MEMCG_USED_BP for the cgroups for the first node
are, 40 GiB / 100 GiB = 4000 bp and 60 GiB / 100 GiB = 6000 bp,
respectively.  Those for the second node are, 20 GiB / 50 GiB = 4000 bp
and 10 GiB / 50 GiB = 2000 bp, respectively.

DAMOS_QUOTA_NODE_MEMCG_FREE_BP for the four cases are, 60 GiB /100 GiB =
6000 bp, 40 GiB / 100 GiB = 4000 bp, 30 GiB / 50 GiB = 6000 bp, and 40
GiB / 50 GiB = 8000 bp, respectively.

    DAMOS_QUOTA_NODE_MEMCG_USED_BP for cgroup A node-0: 4000 bp
    DAMOS_QUOTA_NODE_MEMCG_USED_BP for cgroup B node-0: 6000 bp
    DAMOS_QUOTA_NODE_MEMCG_USED_BP for cgroup A node-1: 4000 bp
    DAMOS_QUOTA_NODE_MEMCG_USED_BP for cgroup B node-1: 2000 bp

    DAMOS_QUOTA_NODE_MEMCG_FREE_BP for cgroup A node-0: 6000 bp
    DAMOS_QUOTA_NODE_MEMCG_FREE_BP for cgroup B node-0: 4000 bp
    DAMOS_QUOTA_NODE_MEMCG_FREE_BP for cgroup A node-1: 6000 bp
    DAMOS_QUOTA_NODE_MEMCG_FREE_BP for cgroup B node-1: 8000 bp

Using these, users can specify how much [un]used amount of memory for
per-cgroup and per-node DAMOS should make as a result of the
auto-tuning.

Example Usecase: Cgroup-aware Memory Tiering
--------------------------------------------

Let's suppose a system having two NUMA nodes.  The first node (node 0)
is CPU-attached and fast.  The second node (node 1) is CPU-unattached
and slow.  It runs two cgroups, hoping to use 30 percent and 70 percent
of system memory, respectively.  Then, we can implement memory tiering
for the system using DAMOS to let the cgroups use 30 percent and 70
percent of each nodes preferring more of node 0, like below, using DAMON
user-space tool.

    # ./damo start \
    	\ # kdamond for node 1 (slow)
        --numa_node 1 --monitoring_intervals_goal 4% 3 5ms 10s \
	    \ # promotion scheme for cgroup a
            --damos_action migrate_hot 0 --damos_access_rate 5% max \
            --damos_apply_interval 1s \
	    --damos_filter allow memcg /workloads/a \
            --damos_filter allow young \
            --damos_quota_interval 1s --damos_quota_space 200MB \
            --damos_quota_goal node_memcg_used_bp 29.7% 0 /workloads/a \
	    \
	    \ # promotion scheme for cgroup b
            --damos_action migrate_hot 0 --damos_access_rate 5% max \
            --damos_apply_interval 1s \
	    --damos_filter allow memcg /workloads/b \
            --damos_filter allow young \
            --damos_quota_interval 1s --damos_quota_space 200MB \
            --damos_quota_goal node_memcg_used_bp 69.7% 0 workloads/b \
	    \
    	\ # kdamond for node 0 (fast)
        --numa_node 0 --monitoring_intervals_goal 4% 3 5ms 10s \
            \ # demotion scheme for cgroup a
            --damos_action migrate_cold 1 --damos_access_rate 0% 0% \
            --damos_apply_interval 1s \
	    --damos_filter allow memcg /workloads/a \
            --damos_filter reject young \
            --damos_quota_interval 1s --damos_quota_space 200MB \
            --damos_quota_goal node_memcg_free_bp 70.5% 0 \
	    \
            \ # demotion scheme for cgroup b
            --damos_action migrate_cold 1 --damos_access_rate 0% 0% \
            --damos_apply_interval 1s \
	    --damos_filter allow memcg /workloads/a \
            --damos_filter reject young \
            --damos_quota_interval 1s --damos_quota_space 200MB \
            --damos_quota_goal node_memcg_free_bp 30.5% 0 \
	    \
            --damos_nr_quota_goals 1 1 1 1 --damos_nr_filters 1 1 1 1 \
        --nr_targets 1 1 --nr_schemes 2 2 --nr_ctxs 1 1

With the command, the user-space tool will ask DAMON to spawn two kernel
threads, monitoring access to node 1 (slow) and node 0 (fast),
respectively.  It installs two DAMOS schemes on each threads.  Let's
call them "promotion scheme for cgroup a", "promotion scheme for cgroup
b", "demotion scheme for cgroup a", "demotion scheme for cgroup b", in
the order.  The promotion schemes are installed on the DAMON thread for
node 1 (slow), and demotion schemes are installed on the DAMON thrad for
node 0 (fast).

Cgroup-aware Hot Pages Migration (Promotion)
--------------------------------------------

Promotion schemes will find memory regions on node 1 (slow), that any
access was detected.  The schemes will then migrate the found memory to
node 0 (fast), hottest pages first.

For accurate and effective migration, these schemes use two page level
filters.  First, the migration will be filtered for only cgroup A and
cgroup B.  That is, promotion scheme for cgroup B will not do the
migration if the page is for cgroup A.  Secondly, the schemes will
filter out pages that having unset page table's Accessed bit for those.
The per-page Accessed bit check will also unset the bit for next check.

For controlled amount of system resource consumption and aiming on the
target memory usage, the schemes use quotas setup.  The migration is
limited to be done only up to 200 MiB per second, to limit the system
resource usage.  And DAMOS_QUOTA_NODE_MEMCG_USED_BP target is set for
29.7% and 69.7% of node 0 (fast), respectively.  The target value is
lower than the high level goal (30% and 70% system memory), to give a
headroom on node 0 (fast).  DAMOS will adjust the speed of the pages
migration based on the target and current memory usage.  For example, if
cgroup A is utilizing only 10% of node 0, DAMOS will try to migrate more
of cgroup A hot pages from node 1, up to 200 MiB per second.  If cgroup
A utilizes more than 29.7% of node 0 memory, the cgroup A hot pages
migration from node 1 to node 0 will be slowered and eventually stopped.

Cgroup-aware Cold Pages Migration (Demotion)
--------------------------------------------

Demotion schemes are similar to promotion schemes, but differ in
filtering setup and quota tuning setup.  Those filters out pages having
page table Accessed bit set.  And set 70.5% and 30.5% of node 0 memory
free rate for the cgroup A and B, respectively.  Hence, if promotion
schemes or something made cgroup A and/or B uses more than 29.5% and
69.5% of node 0, demotion schemes will start migrating cold pages of
appropriate cgroups in node 0 to node 1, under the 200 MiB per second
speed cap, while adjusting the speed based on how much more than wanted
memory is being used.

Future Works for Dropping RFC tag
---------------------------------

This is an RFC.  Only build test is done.  More testing should be
essential for dropping the RFC tag.  Patches sequence and commit
messages might also be changed.

Also, this patch series is based on the tip of DAMON development tree
(damon/next), which contains a few patches that not yet merged in mm-new
or even not yet posted.  Proper rebase should be made for non-RFC
version.

SeongJae Park (11):
  mm/damon: document damos_quota_goal->nid use case
  mm/damon: add a new DAMOS quota goal metric for cgroup on node memory
    usage
  mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP
  mm/damon/sysfs-schemes: implement path file under quota goal directory
  mm/damon/sysfs-schemes: connect quota goal path file to DAMON core
  Docs/mm/damon/design: document DAMOS_QUOTA_NODE_MEMCG_USED_BP
  Docs/admin-guide/mm/damon/usage: document DAMOS quota goal path file
  mm/damon: add DAMOS_QUOTA_NODE_MEMCG_FREE_BP quota tuning goal metric
  mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_FREE_BP
  mm/damon/sysfs-schemes: support DAMOS_QUOTA_NODE_MEMCG_FREE_BP
  Docs/mm/damon/design: document DAMOS_QUOTA_NODE_MEMCG_FREE_BP

 Documentation/admin-guide/mm/damon/usage.rst |  8 +--
 Documentation/mm/damon/design.rst            | 18 ++++--
 include/linux/damon.h                        | 16 +++++-
 mm/damon/core.c                              | 37 +++++++++++++
 mm/damon/sysfs-schemes.c                     | 58 +++++++++++++++++++-
 5 files changed, 124 insertions(+), 13 deletions(-)


base-commit: b7471357d2a80aeeb77f49a4e8fcaf037d5c3aee
-- 
2.39.5

