Return-Path: <linux-kernel+bounces-803549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B0B4623F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E897BDAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2526D4D4;
	Fri,  5 Sep 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mn5NAlHZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21F33E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096970; cv=none; b=MmQnAEEu7noK2nHpGxxYE1gB2Mt1y/pB/LhY/hf13lq0d8alE5BzCgRjtsg/XLQK/umTPSZT2CWu35tWFRDOvjZV7gGeJv+9IUQk78vMxa6oH9TKvEH4WkGCs/QkCuqhF9Ibl+6OiwV+2MxVVPHzWGKK7aO3hryIwrCLuE9V56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096970; c=relaxed/simple;
	bh=OsCha0WSPRCVzjhlzDk50ryNk87V4w0EeLPg1L75in8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ccQJA30UPiQlcG86evT1X6AIVo04SyL+xqOQ6uE14liuvPDzUDzNuYJdKlNCwWAyoxLzNO4zvV16I7thhDnzis0WWSWsaafD3AM05P2BR/C265LXPcmaWmku904x2xenyMIrtsCKyhhiRTq8jn28jEzdKc3UHigW3xckpGO5DcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mn5NAlHZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757096968; x=1788632968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OsCha0WSPRCVzjhlzDk50ryNk87V4w0EeLPg1L75in8=;
  b=mn5NAlHZJJ4OklQ7LTxGcHjl2AslnYpdNDwX8FvEdJKP5s/426GcaU3M
   vUdmEyJylEUavOitj1SmzW9lu5kQsdFM21fUdhU0Iie6K4yVyOThJNnU7
   92sfhp39/RO/4WEmKedlfz3fIrikb8eR4mvuy/zWMpZN+1htI9wzpwxK2
   DVlGHIa72RCHnvJnROlLEXvX+f0lTEwPLPOVf/s4AtmoEL829iWVAVgCz
   tVmnhdZ92pCKId5KhfWB3yAXrUv/GYWy5W+sqIEXxCtWutJgCBZQpY+Ct
   S+R/amxm/xcoZqOEE38HnbirA565eYUxK1zCoIrvYCp4tHqYj898CRnz2
   Q==;
X-CSE-ConnectionGUID: 9wZeHtKwRASriWghqjO+Yg==
X-CSE-MsgGUID: 8mMhgfMiQdmgD6ORL7M4Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63281066"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="63281066"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:29:28 -0700
X-CSE-ConnectionGUID: xoYm6PBxTUSSlai+FjdW1Q==
X-CSE-MsgGUID: IYMRjKFyTZ+rHVR8nbfPxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="177456527"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa005.jf.intel.com with ESMTP; 05 Sep 2025 11:29:28 -0700
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
Subject: [PATCH v2 0/2] Fix NUMA sched domain build errors for GNR and CWF
Date: Fri,  5 Sep 2025 11:36:23 -0700
Message-Id: <cover.1757097030.git.tim.c.chen@linux.intel.com>
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
Asymmetric node distances from local node to to nodes in remote package
was not expected by the scheduler domain code and also led to excessive
number of sched domain hierarchy levels.

Simplify the remote node distances for the purpose of building sched
domains for GNR and CWF to fix the domain build errors and reduce
the number of NUMA sched domain levels.

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
 kernel/sched/topology.c        | 118 ++++++++++++++++++++++++++++-----
 3 files changed, 131 insertions(+), 17 deletions(-)

-- 
2.32.0


