Return-Path: <linux-kernel+bounces-620790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D1A9CFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E7E16E5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ACA20E003;
	Fri, 25 Apr 2025 17:38:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79681F76A8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602735; cv=none; b=n4YGE3WfVt/kyFZ7htRCvIzUi+yqEpUUk7VhPb5byTFx9n6ZCHdTNd/nxOcKFCxJK9uH4D/TIiPi/dUDG8MqYaLiu8e/wLHo1Oi4RPYP19j/d+iuZRChIYN0wCK+rnR8Pbw8AhqxfxtWz4h2sX3P/JrrBJJGjWoxBffDWmiSR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602735; c=relaxed/simple;
	bh=lYhxNXRh6n1jNB2abmPSEwmIElsJMOtSac49XACxBAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJgEpnvYIhWBgRvU78yZo/UdzCEtNL80ZGpGaaqTjbKSAgP+F8FmtH0grsQ00AzNuPQnWV7OKY+JUxr86I2Aba9cXG7nTLaVe+Z9PVe2Kl7SYuID0PrvMjpQRkqDKq+SLeOvz6QFR5fE3ShmpfwZiUG1dQAPALZ5bSTDc3D11p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85DD71A2D;
	Fri, 25 Apr 2025 10:38:46 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1D363F59E;
	Fri, 25 Apr 2025 10:38:47 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v9 01/27] x86/resctrl: Remove the limit on the number of CLOSID
Date: Fri, 25 Apr 2025 17:37:43 +0000
Message-Id: <20250425173809.5529-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250425173809.5529-1-james.morse@arm.com>
References: <20250425173809.5529-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amit Singh Tomar <amitsinght@marvell.com>

Resctrl allocates and finds free CLOSID values using the bits of a u32.
This restricts the number of control groups that can be created by
user-space.

MPAM has an architectural limit of 2^16 CLOSID values, Intel x86 could
be extended beyond 32 values. There is at least one MPAM platform which
supports more than 32 CLOSID values.

Replace the fixed size bitmap with calls to the bitmap API to allocate
an array of a sufficient size.

ffs() returns '1' for bit 0, hence the existing code subtracts 1 from
the index to get the CLOSID value. find_first_bit() returns the bit
number which does not need adjusting.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
[ morse: fixed the off-by-one in the allocator and the wrong
 not-found value. Removed the limit. Rephrase the commit message. ]
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v8:
 * Added check for closid_init() on monitor only platforms.

Changes since v7:
 * Moved closid_exit() earlier in rdt_kill_sb() to match what
   rdt_get_tree() does.

Changes since v6:
 * Set variable to NULL after kfree()ing it.
 * Call closid_exit() from rdt_kill_sb() to prevent a memory leak.

Changes since v5:
 * This patch got pulled into this series.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 51 ++++++++++++++++++--------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cc4a54145c83..53213cae30ec 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -130,8 +130,8 @@ static bool resctrl_is_mbm_event(int e)
 }
 
 /*
- * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
- * we can keep a bitmap of free CLOSIDs in a single integer.
+ * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
+ * of free CLOSIDs.
  *
  * Using a global CLOSID across all resources has some advantages and
  * some drawbacks:
@@ -144,7 +144,7 @@ static bool resctrl_is_mbm_event(int e)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static unsigned long closid_free_map;
+static unsigned long *closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -152,20 +152,35 @@ int closids_supported(void)
 	return closid_free_map_len;
 }
 
-static void closid_init(void)
+static int closid_init(void)
 {
 	struct resctrl_schema *s;
-	u32 rdt_min_closid = 32;
+	u32 rdt_min_closid = ~0;
+
+	/* Monitor only platforms still call closid_init() */
+	if (list_empty(&resctrl_schema_all))
+		return 0;
 
 	/* Compute rdt_min_closid across all resources */
 	list_for_each_entry(s, &resctrl_schema_all, list)
 		rdt_min_closid = min(rdt_min_closid, s->num_closid);
 
-	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
+	closid_free_map = bitmap_alloc(rdt_min_closid, GFP_KERNEL);
+	if (!closid_free_map)
+		return -ENOMEM;
+	bitmap_fill(closid_free_map, rdt_min_closid);
 
 	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
-	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
+	__clear_bit(RESCTRL_RESERVED_CLOSID, closid_free_map);
 	closid_free_map_len = rdt_min_closid;
+
+	return 0;
+}
+
+static void closid_exit(void)
+{
+	bitmap_free(closid_free_map);
+	closid_free_map = NULL;
 }
 
 static int closid_alloc(void)
@@ -182,12 +197,11 @@ static int closid_alloc(void)
 			return cleanest_closid;
 		closid = cleanest_closid;
 	} else {
-		closid = ffs(closid_free_map);
-		if (closid == 0)
+		closid = find_first_bit(closid_free_map, closid_free_map_len);
+		if (closid == closid_free_map_len)
 			return -ENOSPC;
-		closid--;
 	}
-	__clear_bit(closid, &closid_free_map);
+	__clear_bit(closid, closid_free_map);
 
 	return closid;
 }
@@ -196,7 +210,7 @@ void closid_free(int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	__set_bit(closid, &closid_free_map);
+	__set_bit(closid, closid_free_map);
 }
 
 /**
@@ -210,7 +224,7 @@ bool closid_allocated(unsigned int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	return !test_bit(closid, &closid_free_map);
+	return !test_bit(closid, closid_free_map);
 }
 
 /**
@@ -2765,20 +2779,22 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_ctx;
 	}
 
-	closid_init();
+	ret = closid_init();
+	if (ret)
+		goto out_schemata_free;
 
 	if (resctrl_arch_mon_capable())
 		flags |= RFTYPE_MON;
 
 	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
-		goto out_schemata_free;
+		goto out_closid_exit;
 
 	kernfs_activate(rdtgroup_default.kn);
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
-		goto out_schemata_free;
+		goto out_closid_exit;
 
 	if (resctrl_arch_mon_capable()) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
@@ -2829,6 +2845,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
+out_closid_exit:
+	closid_exit();
 out_schemata_free:
 	schemata_list_destroy();
 out_ctx:
@@ -3076,6 +3094,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	closid_exit();
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
 	if (resctrl_arch_alloc_capable())
-- 
2.39.5


