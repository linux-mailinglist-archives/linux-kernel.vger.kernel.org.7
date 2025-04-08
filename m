Return-Path: <linux-kernel+bounces-592760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3BEA7F127
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 01:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48B01893D95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE6722D782;
	Mon,  7 Apr 2025 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZQwfZ8S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1322A4EE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069251; cv=none; b=Anyoa0Zn7hiwRaKYg3O3X2bC+VmCWmcsz95zKm254HZlIg9hus8RHdLgLo4qzSf/NM4bnz4GpbFH0L2VC7x6SwYHeF50jzgiHJnPDAJ2QMFu5zWTTqxgmwZ/bO0BUaAAAkKrqxUBTefk5Yvhh2daHly5WZxbIidnRLAOOUSu3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069251; c=relaxed/simple;
	bh=vIVE737/XLTgSW+CksKOEBZ9uQoVTZtL1sfcscGRMRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+PvI+pP+EcR3L7XuV+cyCNdGCjKTqwO6J9RqVQ5KITb4VnQvX1v0GDFqu4GWET91oUy+LSeKdD3agIFfCqzhwr2bCbb9PIryjrimec5iUHn2KYPOERpuKxPFKBIXY6jBO1Etql2j346e6nnhwxwrqjneIWJn91VxDyocn0Frv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZQwfZ8S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744069249; x=1775605249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vIVE737/XLTgSW+CksKOEBZ9uQoVTZtL1sfcscGRMRY=;
  b=ZZQwfZ8SnnLbiXnK7PlTcLqPMvGjgJAxmjqQQVs3WlSOoOI+yt6SUGjE
   UkN/NRo+8MRg33rEisrbFtlaI/W/HdQCNgOfJ1LTQT6p1MQAmmzFEQUH6
   SbckvzUvnyKJgaHNKJbSMRoc0nM0gAHhjAsVeBZFv/VwE/WyKlQEz5CDe
   kJlPhkSnyAAXXiXNlYhKnCBuAS12Ue9ZqCv/4N8yoAKaYND6pdU1jDVVA
   J5GToducV9SdFAB3kXZ9nYnXALpx/d+eE9CfrmYhS+q3cP+wdwt511vYB
   HsmamHAEXU+0nGlkRXA4F/Y/ngnU4XwptDmV5/PLVGTt+z1KxacEW2nLg
   Q==;
X-CSE-ConnectionGUID: Yc1/HRXyTLm9ixU5EW2A1A==
X-CSE-MsgGUID: sxVfP5M7TGWDQ6nfrCGdXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48193143"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="48193143"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:47 -0700
X-CSE-ConnectionGUID: QYB/SaEcS+68bNZvBTmQqw==
X-CSE-MsgGUID: 31o7XXgsRNCvV4VOvayxaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="165315459"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:46 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 05/26] x86/rectrl: Fake OOBMSM interface
Date: Mon,  7 Apr 2025 16:40:07 -0700
Message-ID: <20250407234032.241215-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407234032.241215-1-tony.luck@intel.com>
References: <20250407234032.241215-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real version is coming soon ... this is here so the remaining parts
will build (and run ... assuming a 2 socket system that supports RDT
monitoring ... only missing part is that the event counters just
report fixed values).

Just for ease of testing and RFC discussion.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../cpu/resctrl/fake_intel_aet_features.h     | 73 ++++++++++++++++
 .../cpu/resctrl/fake_intel_aet_features.c     | 87 +++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/Makefile          |  1 +
 3 files changed, 161 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.h
 create mode 100644 arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.c

diff --git a/arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.h b/arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.h
new file mode 100644
index 000000000000..c835c4108abc
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Bits stolen from OOBMSM VSEC discovery code */
+
+enum pmt_feature_id {
+	FEATURE_INVALID			= 0x0,
+	FEATURE_PER_CORE_PERF_TELEM	= 0x1,
+	FEATURE_PER_CORE_ENV_TELEM	= 0x2,
+	FEATURE_PER_RMID_PERF_TELEM	= 0x3,
+	FEATURE_ACCEL_TELEM		= 0x4,
+	FEATURE_UNCORE_TELEM		= 0x5,
+	FEATURE_CRASH_LOG		= 0x6,
+	FEATURE_PETE_LOG		= 0x7,
+	FEATURE_TPMI_CTRL		= 0x8,
+	FEATURE_RESERVED		= 0x9,
+	FEATURE_TRACING			= 0xA,
+	FEATURE_PER_RMID_ENERGY_TELEM	= 0xB,
+	FEATURE_MAX			= 0xB,
+};
+
+/**
+ * struct oobmsm_plat_info - Platform information for a device instance
+ * @cdie_mask:       Mask of all compute dies in the partition
+ * @package_id:      CPU Package id
+ * @partition:       Package partition id when multiple VSEC PCI devices per package
+ * @segment:         PCI segment ID
+ * @bus_number:      PCI bus number
+ * @device_number:   PCI device number
+ * @function_number: PCI function number
+ *
+ * Structure to store platform data for a OOBMSM device instance.
+ */
+struct oobmsm_plat_info {
+	u16 cdie_mask;
+	u8 package_id;
+	u8 partition;
+	u8 segment;
+	u8 bus_number;
+	u8 device_number;
+	u8 function_number;
+};
+
+enum oobmsm_supplier_type {
+	OOBMSM_SUP_PLAT_INFO,
+	OOBMSM_SUP_DISC_INFO,
+	OOBMSM_SUP_S3M_SIMICS,
+	OOBMSM_SUP_TYPE_MAX
+};
+
+struct oobmsm_mapping_supplier {
+	struct device *supplier_dev[OOBMSM_SUP_TYPE_MAX];
+	struct oobmsm_plat_info plat_info;
+	unsigned long features;
+};
+
+struct telemetry_region {
+	struct oobmsm_plat_info	plat_info;
+	void __iomem		*addr;
+	size_t			size;
+	u32			guid;
+	u32			num_rmids;
+};
+
+struct pmt_feature_group {
+	enum pmt_feature_id	id;
+	int			count;
+	struct kref		kref;
+	struct telemetry_region	regions[];
+};
+
+struct pmt_feature_group *intel_pmt_get_regions_by_feature(enum pmt_feature_id id);
+
+void intel_pmt_put_feature_group(struct pmt_feature_group *feature_group);
diff --git a/arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.c b/arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.c
new file mode 100644
index 000000000000..5a16db67c7b8
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/fake_intel_aet_features.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/cleanup.h>
+#include <linux/minmax.h>
+#include <linux/slab.h>
+#include "fake_intel_aet_features.h"
+#include <linux/intel_vsec.h>
+#include <linux/resctrl.h>
+
+#include "internal.h"
+
+/* Amount of memory for each fake MMIO space */
+#define ENERGY_QWORDS	((576 * 2) + 3)
+#define ENERGY_SIZE	(ENERGY_QWORDS * 8)
+#define PERF_QWORDS	((576 * 7) + 3)
+#define PERF_SIZE	(PERF_QWORDS * 8)
+
+static long pg[4 * ENERGY_QWORDS + 2 * PERF_QWORDS];
+
+/*
+ * Fill the fake MMIO space with all different values,
+ * all with BIT(63) set to indicate valid entries.
+ */
+static int __init fill(void)
+{
+	u64 val = 0;
+
+	for (int i = 0; i < sizeof(pg); i += sizeof(val)) {
+		pg[i / sizeof(val)] = BIT_ULL(63) + val;
+		val++;
+	}
+	return 0;
+}
+device_initcall(fill);
+
+#define PKG_REGION(_entry, _guid, _addr, _size, _pkg, _num_rmids)	\
+	[_entry] = { .guid = _guid, .addr = (void __iomem *)_addr, \
+		     .num_rmids = _num_rmids, \
+		     .size = _size, .plat_info = { .package_id = _pkg }}
+
+/*
+ * Set up a fake return for call to:
+ *   intel_pmt_get_regions_by_feature(FEATURE_PER_RMID_ENERGY_TELEM);
+ * Pretend there are two aggregators on each of the sockets to test
+ * the code that sums over multiple aggregators.
+ */
+static struct pmt_feature_group fake_energy = {
+	.count = 4,
+	.regions = {
+		PKG_REGION(0, 0x26696143, &pg[0 * ENERGY_QWORDS], ENERGY_SIZE, 0, 64),
+		PKG_REGION(1, 0x26696143, &pg[1 * ENERGY_QWORDS], ENERGY_SIZE, 0, 64),
+		PKG_REGION(2, 0x26696143, &pg[2 * ENERGY_QWORDS], ENERGY_SIZE, 1, 64),
+		PKG_REGION(3, 0x26696143, &pg[3 * ENERGY_QWORDS], ENERGY_SIZE, 1, 64)
+	}
+};
+
+/*
+ * Fake return for:
+ *   intel_pmt_get_regions_by_feature(FEATURE_PER_RMID_PERF_TELEM);
+ */
+static struct pmt_feature_group fake_perf = {
+	.count = 2,
+	.regions = {
+		PKG_REGION(0, 0x26557651, &pg[4 * ENERGY_QWORDS + 0 * PERF_QWORDS], PERF_SIZE, 0, 576),
+		PKG_REGION(1, 0x26557651, &pg[4 * ENERGY_QWORDS + 1 * PERF_QWORDS], PERF_SIZE, 1, 576)
+	}
+};
+
+struct pmt_feature_group *
+intel_pmt_get_regions_by_feature(enum pmt_feature_id id)
+{
+	switch (id) {
+	case FEATURE_PER_RMID_ENERGY_TELEM:
+		return &fake_energy;
+	case FEATURE_PER_RMID_PERF_TELEM:
+		return &fake_perf;
+	default:
+		return ERR_PTR(-ENOENT);
+	}
+	return ERR_PTR(-ENOENT);
+}
+
+/*
+ * Nothing needed for the "put" function.
+ */
+void intel_pmt_put_feature_group(struct pmt_feature_group *feature_group)
+{
+}
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 909be78ec6da..c56d3acf8ac7 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= core.o rdtgroup.o monitor.o
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= ctrlmondata.o
+obj-$(CONFIG_INTEL_AET_RESCTRL)		+= fake_intel_aet_features.o
 obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
 
 # To allow define_trace.h's recursive include:
-- 
2.48.1


