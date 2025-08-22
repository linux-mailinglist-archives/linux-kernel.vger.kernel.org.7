Return-Path: <linux-kernel+bounces-782664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC5B3235F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A80B63B15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D942B2D660E;
	Fri, 22 Aug 2025 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cW75YYBH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD224679A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893243; cv=none; b=oYr42AQuiQDaPyubWfbYiSCqOiyI4ZXn7/pWNwnEI5c+sHxAto/jAUMw3SvmfTGopErVJYaFxriMLpV5kuM9UUz50Zzofu6FF+3nARLmiDCqHm07IGTaWszAWULpGEy8GP/9gIYvcvXRAmhEztgHVFV/0rVg/4eOzdj86N6lo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893243; c=relaxed/simple;
	bh=ozE1cSoy/uNFxRcyYjqiBF7w8Pa9CgIf75tou4tbpp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWwUgBQeKjnAfhdRctutswE8VHij1jIMXRkYnTj0h7oFbEg2ZIAyKJDUyedPHtOKm/I2kHa2puAADoOFlxgxg0fJP28jiwDlPbqJrx5d64toGkhWSmUXZDZq8sQAh844ddthIjZq4HIXkCcLOA7BQxJpQH36o6s1Hhcq8CignIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cW75YYBH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755893241; x=1787429241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ozE1cSoy/uNFxRcyYjqiBF7w8Pa9CgIf75tou4tbpp8=;
  b=cW75YYBHSh9t5bSG2JNWpygqDKpn/C6U3CJruhHq4B12ynWZjGploIHj
   Hc7dkupqUSpQw+ihSsGn09HuArVMs3tYVHD2Nk2e2U783MxdQHrn036DS
   iQeA90NJKeBQUDG7JlZJywUTBZxFjMNcOfZhW29aqkHJLl9HbSaDxUmGO
   2B0pvvS+jUxihQPDl1oMNi6GFhDrdzM6cMpv161xKnGQ1VZ/RH+Wdz691
   u5pMdYfnCQi6I7FeObersxNNiOzZKZXK121KqXaL2/dHh5/IhspXSZlSN
   nWW4vtnSWhXNk64Tenh91LYuhM74W2c9yeh5HeLu4cxKSEtpn4IcV4jzf
   A==;
X-CSE-ConnectionGUID: ZFlQpre+STWrZXe4saQDwA==
X-CSE-MsgGUID: 2OO7riPCRdqccvFiKtJoXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57224555"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57224555"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:07:20 -0700
X-CSE-ConnectionGUID: 9WgPgvd/Qa+gHZzcQdHGZA==
X-CSE-MsgGUID: 6xZgs99RQQaFjaUORP9k/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169145735"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2025 13:07:19 -0700
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
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH 0/2] Fix NUMA sched domain build errors for GNR-X and CWF-X
Date: Fri, 22 Aug 2025 13:14:13 -0700
Message-Id: <cover.1755893468.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing Granite Rapids X (GNR-X) and Clearwater Forest X (CWF-X) in
SNc-3 mode, we encountered sched domain build errors reported in dmesg.
Asymmetric node distances from local node to to nodes in remote package
was not expected by the scheduler domain code and also led to excessive
number of sched domain hierachy levels.

Fix the missing NUMA domain level set in topology_span_sane() check and
also simplify the distance to nodes in remote package to retain distance
symmetry and make the NUMA topology sane for GNR-X and CWF-X.

Tim Chen (1):
  sched: Fix sched domain build error for GNR-X, CWF-X in SNC-3 mode

Vinicius Costa Gomes (1):
  sched: topology: Fix topology validation error

 arch/x86/kernel/smpboot.c      | 28 ++++++++++++++++++++++++++++
 include/linux/sched/topology.h |  1 +
 kernel/sched/topology.c        | 33 +++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 6 deletions(-)

-- 
2.32.0


