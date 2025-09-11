Return-Path: <linux-kernel+bounces-812675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009FB53B51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F69D3BFB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64C368083;
	Thu, 11 Sep 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEIpqAl0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F411DA55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615044; cv=none; b=FJ8/1hcroT1PUoRoH7AWQojMgE0dn78m5nCt9BNBRrUA+ocB3IpUjry8BFWyIRVx+wED4wdb2rvhjHDaKA5hpo2mhsO2iqdLPaA2Yx9RQsagEzvYJO2WvhtUlWKkAndQaVyZiNgcYOMPW5k5HwFES5Vy91Dn2NXLSTY7eEUkLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615044; c=relaxed/simple;
	bh=CXnuhkfK+uwg885kqdXtUcY5ZhAHGMIw7hGXcJi6Frw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxulAAfeAeV3qm/azoW5fXF8HB8z4o5YLh+7gseLaO3B5fdLEteUMJz9+Sm4IcXgP0CX1/8cJ/NEoE+UP1KDrtkKgs0nVoXf8dnDopssQFi/yLgqgFDGpkzGSL/53cybNF6vt5Mmdh1QFtcQXeu1whF0MfwVcFwILQuzjDCbWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEIpqAl0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757615042; x=1789151042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CXnuhkfK+uwg885kqdXtUcY5ZhAHGMIw7hGXcJi6Frw=;
  b=jEIpqAl0sIF8vwirIQfZjKMqJXARaNfjzP2QkzBjkO2Et8seSHyw8V6z
   RVdKFFW8fBYEhZXM0fpew8nP9mYMreYX1+sDeK2AkbqdJ4TWAIoQgDgrt
   dEw1Ig9Jwpswb23dyxqe9jDaKxGv65VDPp18GXRm6fbcMM+H6cWFLX/1E
   CbJec2KnN31v5i/CNxN/3o7nhE7GdA3NnTFOydaA/ZsFSbae5hSfEdBUn
   Eodedyb2M0/FgZR+IFDYuHIW5YN8i7IQNub8cYRTmKVdvWzoT/aIRD9ZG
   Wa2wRd4Fcs49bQBoETE2t7p4/YtKyFi7heRkpqCnqW6HRfGJB3J7DaXRB
   Q==;
X-CSE-ConnectionGUID: SBwBiYpoRxS2CtmZyi9/Vg==
X-CSE-MsgGUID: xLb7DjJ8R0+46Q/B9xesGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77413621"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="77413621"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:24:02 -0700
X-CSE-ConnectionGUID: UafFj3t9RA6q71it5dqINw==
X-CSE-MsgGUID: 07eMOzuMRAe9Lar6ziTlrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173058302"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2025 11:24:02 -0700
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
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH v3 0/2] Fix NUMA sched domain build errors for GNR and CWF 
Date: Thu, 11 Sep 2025 11:30:55 -0700
Message-Id: <cover.1757614784.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing Granite Rapids (GNR) and Clearwater Forest (CWF) in
SNc-3 mode, we encountered sched domain build errors reported in dmesg.
Asymmetric node distances from local node to nodes in remote package
was not expected by the scheduler domain code and also led to excessive
number of sched domain hierarchy levels.

Simplify the remote node distances for the purpose of building sched
domains for GNR and CWF to fix the domain build errors and reduce
the number of NUMA sched domain levels.

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
  sched: Fix sched domain build error for GNR, CWF in SNC-3 mode

 arch/x86/kernel/smpboot.c      |  28 ++++++++
 include/linux/sched/topology.h |   2 +
 kernel/sched/topology.c        | 114 ++++++++++++++++++++++++++++-----
 3 files changed, 127 insertions(+), 17 deletions(-)

-- 
2.32.0


