Return-Path: <linux-kernel+bounces-792372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9617CB3C322
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5CC7BFD46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A662EBB87;
	Fri, 29 Aug 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bC/4Q9vn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83D259CBC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496047; cv=none; b=EnPdGud2lwb93ksTOqx8y/ycQY7Gbj0REZMaMkvQuUSQvHTVHvVLHDPxoSNWuBRmFIA6xv8igwKt1+DravxEGir/MD1RNlAa15Bj9N65jZMysgffCtUnj4n81qEPOvqR23iHCwjDulfetNT2aymcy+Rp7jkU+LMzqOfNC5ylo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496047; c=relaxed/simple;
	bh=8Iu0QPtvruTdWjl0MWMNxRM+tyqkNM4NG++5QMDhrPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB46WCfr9nkA2pfoPGOAin/Nbh4EXLTrA84ezANMGQFZ4WBb6KH8VREw2gGrsCmSmE8W75iMUs5EDTz3ItvdxEPcmTqo0YP1OBwzv4DhXNMf9j0GgHqv8NFLlk6LUukERuMtAwTd28gbdJ5/oBc54pnZfdfx9n2yfQioledq1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bC/4Q9vn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496045; x=1788032045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Iu0QPtvruTdWjl0MWMNxRM+tyqkNM4NG++5QMDhrPs=;
  b=bC/4Q9vnws/Urf0BXwTE0457FaHNnNUFNaECx7ef8UBQ40KYsyhGWB50
   CSOll3qb9U99zc3IjEfhHXUqdQAUA213iAB8d0uEz6kqxhZwCMOCIfCkA
   FXjIO4sROvJrFNebz+yCHzPhb1FmRW4SnnIL9brxm6W7+AGPNbNjvTgT2
   5+jdzVtg8T0DgSdCsff7Lbh5RdED1HVgYlXBXgtHI95tQ6c8EPRTeTrtH
   uNBXDloe2w+UVADK4kR0vftK9IHEe9X+/XzNYduuOViVjgRafJlzzjIdn
   qc9tdIcMi/PempLPUwKkF2lRahMvCTCfP+k7X0uasWv515ykUYBVspl0R
   w==;
X-CSE-ConnectionGUID: zjLlYlX9Q/OODsFFn59D6Q==
X-CSE-MsgGUID: dGo69+UUQpC23ka5MANJew==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625266"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625266"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:55 -0700
X-CSE-ConnectionGUID: PMcvsBPUQV+motC7+i5v/w==
X-CSE-MsgGUID: SjW52UWATl+0MYhDUR9vYA==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:55 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 15/31] x86,fs/resctrl: Add an architectural hook called for each mount
Date: Fri, 29 Aug 2025 12:33:27 -0700
Message-ID: <20250829193346.31565-16-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829193346.31565-1-tony.luck@intel.com>
References: <20250829193346.31565-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enumeration of Intel telemetry events is an asynchronous process involving
several mutually dependent drivers added as auxiliary devices during
the device_initcall() phase of Linux boot. The process finishes after
the probe functions of these drivers completes. But this happens after
resctrl_arch_late_init() is executed.

Tracing the enumeration process shows that it does complete a full seven
seconds before the earliest possible mount of the resctrl file system
(when included in /etc/fstab for automatic mount by systemd).

Add a hook at the beginning of the mount code that will be used
to check for telemetry events and initialize if any are found.

Call the hook on every attempted mount. Expectations are that
most actions (like enumeration) will only need to be performed
on the first call.

resctrl filesystem calls the hook with no locks held. Architecture code
is responsible for any required locking.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            | 6 ++++++
 arch/x86/kernel/cpu/resctrl/core.c | 9 +++++++++
 fs/resctrl/rdtgroup.c              | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index fe39bdbcd46f..f29a602d1b71 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -459,6 +459,12 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
 void resctrl_online_cpu(unsigned int cpu);
 void resctrl_offline_cpu(unsigned int cpu);
 
+/*
+ * Architecture hook called at beginning of each file system mount attempt.
+ * No locks are held.
+ */
+void resctrl_arch_pre_mount(void);
+
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
  *			      for this resource and domain.
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8bc533ae896b..5ff0db08e132 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -718,6 +718,15 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
+void resctrl_arch_pre_mount(void)
+{
+	static atomic_t only_once = ATOMIC_INIT(0);
+	int old = 0;
+
+	if (!atomic_try_cmpxchg(&only_once, &old, 1))
+		return;
+}
+
 enum {
 	RDT_FLAG_CMT,
 	RDT_FLAG_MBM_TOTAL,
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index f98f34e75f35..abefdda245dd 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2585,6 +2585,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	struct rdt_resource *r;
 	int ret;
 
+	resctrl_arch_pre_mount();
+
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 	/*
-- 
2.50.1


