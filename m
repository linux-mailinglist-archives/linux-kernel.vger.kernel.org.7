Return-Path: <linux-kernel+bounces-825043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0DB8ACB7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99811C2312D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B0322546;
	Fri, 19 Sep 2025 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7kdC0P7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882B1DD543
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303817; cv=none; b=EMcijjAYJn/QSvQ1nBq2tVHyQkSZE9OSedXdqkQAidIcsl0qpttHVqG/gL4ig505XV0SVqWjwp4kOKSGAkqRJAXdw7cH5NXE+kBh4ckMFvyFaHb4mE4uT1LHYmiC0I0mvQNxbcmlCEVFlFy7TtWj0Ham+W25Xvy3DL3OlCCmMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303817; c=relaxed/simple;
	bh=XkODLLS4R2uPab6N43MV3zv6zV8taRIWd2FXjkDHAJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcOp9nWego9SvhpJCW0gDv+brqqL8vJT7bAvlqzE1SgyD8JADjMa4nzpMB34GSDCGvF8WPCkrIxKYoshWyLcaFA1X3SxltgGlLLaGB/X5rdaZKR6B/ELBzNTv3YKKTAQnVHfwZA2sX+Wbet7wDBU3GY1Wjz5e52cwiRb70Dx/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7kdC0P7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758303815; x=1789839815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XkODLLS4R2uPab6N43MV3zv6zV8taRIWd2FXjkDHAJk=;
  b=G7kdC0P7Gr+OmvaGBIo2ZtsBiMlQwb5DjVRLnPcsDiKetvt1bcknlEWd
   sHJ3IP39Otaa+iHsOWM/9IHNAnLSbb9z/SxZnlSLg6zBBYVFCs7hBUGsI
   3sQ3sbGHt/zPLVqNHCdbt8bLVuZtSPmzedwJADBbb3ZDfvemYNGx6jN/S
   QA5EeZZTC1/p38Uhtrm8YQI3B/09URLHuDrAtRYJUauNmc/VEkTQnts8O
   9W/8mb22K2JKJ1sI3L8QJCuJqqgMHxWKg3TLSVQ0MLxnl8OVrDpYZ+93s
   zek1KGQmokXO6eLEAerhDdTdc1PNG8idU1CR99B6AmJrsWTFu2Tl0aO0F
   A==;
X-CSE-ConnectionGUID: BSRtSwoARVaNwoD3XWDv0w==
X-CSE-MsgGUID: l4EVQILoQc2Ewyp68HbZkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60769809"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60769809"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:43:35 -0700
X-CSE-ConnectionGUID: m/Y+Z0xaSDSkO7u+pF65fA==
X-CSE-MsgGUID: q1h5Z+3qQzekZTitlu4Dtg==
X-ExtLoop1: 1
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa003.fm.intel.com with ESMTP; 19 Sep 2025 10:43:34 -0700
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
Subject: [PATCH v4 0/2] Fix NUMA sched domain build errors for GNR and CWF
Date: Fri, 19 Sep 2025 10:50:10 -0700
Message-Id: <cover.1758234869.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing Granite Rapids (GNR) and Clearwater Forest (CWF) in
SNC-3 mode, we encountered sched domain build errors in dmesg.
Asymmetric node distances from local node to nodes in remote package
was not expected by the scheduler domain code. Multiple distances
to different remote nodes led to multiple grouping of partial remote nodes
with local nodes, and too many sched domain hierarchy levels.

Simplify the remote node distances for the purpose of building sched
domains for GNR and CWF. Replace remote distance to nodes in the same
remote package with average distance to the remote node.  This fixed the
domain build errors and reduced the number of NUMA sched domain levels.

The actual SLIT NUMA node distances are kept separately should the node
distances be modified for building sched domains. NUMA balancing still
need to use the actual distance to locate remote node that is closer to
a task numa_group.

Thanks to Pratek, Chen Yu and Peter from reviewing previous
versions of the patches and providing valuable feedbacks.
Please add your Reviewed-by if this version looks okay to you.

Thanks.

Tim

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

 arch/x86/kernel/smpboot.c      |  70 ++++++++++++++++++++
 include/linux/sched/topology.h |   1 +
 kernel/sched/topology.c        | 117 ++++++++++++++++++++++++++-------
 3 files changed, 166 insertions(+), 22 deletions(-)

-- 
2.32.0


