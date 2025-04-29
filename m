Return-Path: <linux-kernel+bounces-624066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE1A9FE56
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB41A88427
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992C1E9B0E;
	Tue, 29 Apr 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+1a6PpM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1A3987D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886862; cv=none; b=mkhEHy3WUzUnK7JaXMHq29RZGwxU/k4KRGX+JxW5FsOuyPIOxWVHmRrUMxrDdMDkMIANiy8pJqtD2dOVqZyBM/F/lzXu9fblWIRAKaq38I5BbMnRFhopv75P4/XCOVFjVIr+KCr7LGHTaJBhYs/RTBfvBXv2trblZk7fUl+Ipuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886862; c=relaxed/simple;
	bh=ClI/LqjKobUz8Hh4f9zIJCDGblt0kOvF3kyNeyzacvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGpvnfSeVTTnxoiUGStRH50mQCSEEvyDRLq4qJGUjcI0742OKA4IDIsb9FZ7aXeStblVKz5YqtuAql7ft+ECuMWl7y5E5yadHhii9a/pSQlAemVXkSzexYck3UtJ/eui0jYsuKOJFTcZF83+jY8DPYDRi3K5e12e7qT0XQV3NOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+1a6PpM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886861; x=1777422861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ClI/LqjKobUz8Hh4f9zIJCDGblt0kOvF3kyNeyzacvU=;
  b=Z+1a6PpMOqiIFj/810FdRnUCwuBFKYmnoY5lFCv+cK3Fdvm2hXdV7j2C
   vrunRPzFoozqFZGDnc6q7/c7Q8VA3sam+gx3ifJRYXoLHrCQE5aNAQJuc
   MZWSwg8hQ8qV8bo5CEWpE94V5ViGugQMBjoDpbEx1re02XeLujtmdrg+o
   m8fHRkOWkeTB8z65WkN7vqTBm75YKyZbmIsmTSp/kl05/y037EQlWhld0
   vPGUXS/aS9wyxElYvRV0u4JQaFi9bUz+HwDB2Zu9VNPOkkwJvXdEewnkJ
   a3RpAz5lyv0RQJyhz/hMSOfXaucgM4iEYKCL2IZ5Ms1ZtKhGYxwMXoQRV
   Q==;
X-CSE-ConnectionGUID: Wjeo1LAOQ3+w9y5m9E8ODw==
X-CSE-MsgGUID: NPoqonCAReq3WOp2WDhP3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58148166"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58148166"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:15 -0700
X-CSE-ConnectionGUID: SzhiGjUERGWTP2OUMQY9MQ==
X-CSE-MsgGUID: Qyv1VzjWSMCYxBbdPVchUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133394012"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:14 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 14/31] fs/resctrl: Add an architectural hook called for each mount
Date: Mon, 28 Apr 2025 17:33:40 -0700
Message-ID: <20250429003359.375508-15-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429003359.375508-1-tony.luck@intel.com>
References: <20250429003359.375508-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enumeration of Intel telemetry events is not complete when the
resctrl "late_init" code is executed.

Add a hook at the beginning of the mount code that will be used
to check for telemetry events and initialize if any are found.

The hook is called on every attempted mount. But expectations are that
most actions (like enumeration) will only need to be performed
on the first call.

The call is made with no locks held. Architecture code is responsible
for any required locking.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            | 6 ++++++
 arch/x86/kernel/cpu/resctrl/core.c | 8 ++++++++
 fs/resctrl/rdtgroup.c              | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 4af5e8d30193..6f424fffa083 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -450,6 +450,12 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
 void resctrl_online_cpu(unsigned int cpu);
 void resctrl_offline_cpu(unsigned int cpu);
 
+/*
+ * Architecture hook called for each attempted file system mount
+ * No locks are held.
+ */
+void resctrl_arch_pre_mount(void);
+
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
  *			      for this resource and domain.
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 58bc218070e2..2f3efc4b1816 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -707,6 +707,14 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
+void resctrl_arch_pre_mount(void)
+{
+	static atomic_t only_once;
+
+	if (atomic_cmpxchg(&only_once, 0, 1))
+		return;
+}
+
 enum {
 	RDT_FLAG_CMT,
 	RDT_FLAG_MBM_TOTAL,
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index d16bb05fafe8..da71057f3ff4 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2581,6 +2581,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	struct rdt_resource *r;
 	int ret;
 
+	resctrl_arch_pre_mount();
+
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 	/*
-- 
2.48.1


