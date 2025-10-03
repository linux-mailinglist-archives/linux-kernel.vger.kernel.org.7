Return-Path: <linux-kernel+bounces-841676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51112BB7F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047623A9E45
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FEB223DDA;
	Fri,  3 Oct 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0hCT4T4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB2221269
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519478; cv=none; b=F+eADZZH9wxIoZZLKXgqB9+57bfJRfkjReI3N9uSn02iyUQyXeM8HhqorQ9VY9PB8bShS00UirUEcGpfd87mPm92UPjXkaDVCFId+UMwpmm2j1+yAl63zSvTpAlkeoL55Xh0EZA8ZXaA7NuaAc1w+5Uzmf4G8HPmydsr7xJwPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519478; c=relaxed/simple;
	bh=xnoKFarGDa0EkTy2aMRk4AsT5G7n4mlUnh+Ekfx29gs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o/scxxIjbvJnnuC1vieLrIcU+fUUMjfAmk0zCLLFsscFUkKdbVRAFRYQ+5KlSgPYD/rhBQakBDdPD/jKRXFtcatMCb4+EvAVbuBNveK6F/ISj2Ngx5N8trhDH9K/+7Opjsr7o/t5zzFzMNYtlVQciuoH4LxrWCTE/BjDLPCivGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0hCT4T4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759519476; x=1791055476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xnoKFarGDa0EkTy2aMRk4AsT5G7n4mlUnh+Ekfx29gs=;
  b=k0hCT4T4P7Pr5nErd0aA0rNfnR55rtCk0HsD5l/CP+/ouYjApPbYMa0e
   97C+CCPbEYN0gfkPYtnH++l2hxNkpZqqDYYW9oWAbSHg3YuzAoAFlOSQA
   YmCijqDb3XKNLHe4ixw1RW9tFikmZpimhVmPn/naFHSJLCHBRBWJ2vPbP
   R7HE52R5IXuD1m//NrR7qyrOglvCuhzCKhaZGI5UK5JRce4Z43CFbWPIR
   KdQ8Xk8GKx0LempokHITROnuhOxpNM0NnP2j0GbR5DkXDvtT8lo7nuUrF
   SoARi+W+5szB7JnGFSpS7AjHV86TZzucYswGqiBKV8JPMEDYR97aujoQV
   w==;
X-CSE-ConnectionGUID: W//pR0QwSAOBquX8J6gY0Q==
X-CSE-MsgGUID: U8S4r8v2ToSaQem2eTXURg==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="60840862"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="60840862"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 12:24:35 -0700
X-CSE-ConnectionGUID: sSBsfdzQQD6Y6gzm9weNpw==
X-CSE-MsgGUID: 6KA+hElLSouXKJrCxPxb6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="179784171"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa009.fm.intel.com with ESMTP; 03 Oct 2025 12:24:34 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH v5 0/2] Fix NUMA sched domain build errors for GNR and CWF
Date: Fri,  3 Oct 2025 12:31:26 -0700
Message-Id: <cover.1759515405.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While testing Granite Rapids (GNR) and Clearwater Forest (CWF) systems
in SNC-3 mode, we encountered sched domain build errors in dmesg.
The scheduler domain code did not expect asymmetric node distances
from a local node to multiple nodes in a remote package. As a result,
remote nodes ended up being grouped partially with local nodes with
asymemtric groupings, and creating too many levels in the NUMA sched
domain hierarchy.

To address this, we simplify remote node distances for the purpose of
sched domain construction on GNR and CWF. Specifically, we replace the
individual distances to nodes within the same remote package with their
average distance. This resolves the domain build errors and reduces the
number of NUMA sched domain levels.

The actual SLIT NUMA node distances are still preserved separately, in
case they are needed when building sched domains. NUMA balancing
continues to use the true distances when selecting a closer remote node
for a task’s numa_group.

This version also revises the detection of arch_sched_node_distance()
substitution with a cleaner implementation, thanks to Chen Yu’s
suggestion.  Much appreciation as well to Pratek for reviewing earlier
versions.  Pratek, if this revision looks good to you, please consider
adding your Reviewed-by.

Thanks,
Tim

Changes in v5:
- Reise detection of arch_sched_node_distance() replacement with a
  cleaner implementtion.
- Link to v4: https://lore.kernel.org/lkml/cover.1758234869.git.tim.c.chen@linux.intel.com/ 

Changes in v4:
- Move average node distance computation to x86 specific code
- Put all the changes under CONFIG_NUMA.
- Use __free() to simplify code.
- Allocate separate distance array only if node distances are
  modified.
- Assert that we don't have more than 2 packages for GNR/CWF
  when replacing remote node distances with average remote node
  distance.
- Comments and code style clean ups.
- Link to v3:
  https://lore.kernel.org/lkml/cover.1757614784.git.tim.c.chen@linux.intel.com/

Changes in v3:
- Simplify sched_record_numa_dist() by getting rid of max distance
  computation. 
- minor clean ups.
- Link to v2:
  https://lore.kernel.org/lkml/61a6adbb845c148361101e16737307c8aa7ee362.1757097030.git.tim.c.chen@linux.intel.com/

Changes in v2:
- Allow modification of NUMA distances by architecture to be the
  sched domain NUMA distances for building sched domains to
  simplify NUMA domains.
  Maintain separate NUMA distances for the purpose of building
  sched domains from actual NUMA distances.
- Use average remote node distance as the distance to nodes in remote
  packages for GNR and CWF.
- Remove the original fix for topology_span_sane() that's superseded
  by better fix from Pratek.
  https://lore.kernel.org/lkml/175688671425.1920.13690753997160836570.tip-bot2@tip-bot2/.
- Link to v1: https://lore.kernel.org/lkml/cover.1755893468.git.tim.c.chen@linux.intel.com/


Tim Chen (2):
  sched: Create architecture specific sched domain distances
  sched/topology: Fix sched domain build error for GNR, CWF in SNC-3
    mode

 arch/x86/kernel/smpboot.c      |  70 +++++++++++++++++++++
 include/linux/sched/topology.h |   1 +
 kernel/sched/topology.c        | 108 ++++++++++++++++++++++++++-------
 3 files changed, 157 insertions(+), 22 deletions(-)

-- 
2.32.0


