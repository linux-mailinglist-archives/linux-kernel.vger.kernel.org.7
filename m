Return-Path: <linux-kernel+bounces-620793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EC4A9CFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD079E551E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565F20F09A;
	Fri, 25 Apr 2025 17:39:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF42C20E330
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602748; cv=none; b=vEQs9wpTXiFJDkOj+NFlwN2Q8KbVY3GE/drV4s6CBoIfra5tosQJrF01GvKy7OCWvIb5FR0U+uGcjYdQjRjPjy4krEStmPAVYJ2tszL3q/lphP32kqiFSdTs5fIql6ULMp2vl0U+/EZcD0ZBnJRbvnFzLulXjeYC6twk1SJCcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602748; c=relaxed/simple;
	bh=VQBkSWQK90xlROz0SEFp355P8iwi0BShLNzE7Bc6g8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=un7HE6s9mB9BwSoYQGfPtJH+bl5Mr4JQSt1+tJ/daXnMh8vb4dojutoJSgJi+uf1fl1lxBbpYIxiBpx4/gNzVhJ4qvzLSI6k94H6NTwvMtowzCYFpU9pqMQ6/63b8D/pyZQaKWqYSs1BgD27YQkQs55J7J2mcWzPkw1yfChfEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C71B71F37;
	Fri, 25 Apr 2025 10:39:00 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1E323F59E;
	Fri, 25 Apr 2025 10:39:01 -0700 (PDT)
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
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 04/27] x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
Date: Fri, 25 Apr 2025 17:37:46 +0000
Message-Id: <20250425173809.5529-5-james.morse@arm.com>
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

resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
resctrl can't be built as a module, and the kernfs helpers are not exported
so this is unlikely to change. MPAM has an error interrupt which indicates
the MPAM driver has gone haywire. Should this occur tasks could run with
the wrong control values, leading to bad performance for important tasks.
In this scenario the MPAM driver will reset the hardware, but it needs
a way to tell resctrl that no further configuration should be attempted.

In particular, moving tasks between control or monitor groups does not
interact with the architecture code, so there is no opportunity for the
arch code to indicate that the hardware is no-longer functioning.

Using resctrl_exit() for this leaves the system in a funny state as
resctrl is still mounted, but cannot be un-mounted because the sysfs
directory that is typically used has been removed. Dave Martin suggests
this may cause systemd trouble in the future as not all filesystems
can be unmounted.

Add calls to remove all the files and directories in resctrl, and
remove the sysfs_remove_mount_point() call that leaves the system
in a funny state. When triggered, this causes all the resctrl files
to disappear. resctrl can be unmounted, but not mounted again.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Changes since v8:
 * Call resctrl_fs_teardown() under cpuhp lock, for good measure.
 * Set debugfs_resctrl to NULL to be robust against a second call.
 * Added more documentation commentary.
 * Moved some words around to change the tone.

Changes since v7:
 * Moved kernfs cleanup functions to resctrl_fs_teardown(), and call this
   from rescrl_exit().
 * Added description of MPAM resetting the hardware to the commit message.

Changes since v6:
 * Added kdoc and comment to resctrl_exit().

Changes since v5:
 * Serialise rdtgroup_destroy_root() against umount().
 * Check rdtgroup_default.kn to protect against duplicate calls.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 48 +++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f617ac97758b..3d105b546842 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3078,6 +3078,22 @@ static void rmdir_all_sub(void)
 	kernfs_remove(kn_mondata);
 }
 
+static void resctrl_fs_teardown(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* Cleared by rdtgroup_destroy_root() */
+	if (!rdtgroup_default.kn)
+		return;
+
+	rmdir_all_sub();
+	rdt_pseudo_lock_release();
+	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	closid_exit();
+	schemata_list_destroy();
+	rdtgroup_destroy_root();
+}
+
 static void rdt_kill_sb(struct super_block *sb)
 {
 	struct rdt_resource *r;
@@ -3091,12 +3107,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	for_each_alloc_capable_rdt_resource(r)
 		resctrl_arch_reset_all_ctrls(r);
 
-	rmdir_all_sub();
-	rdt_pseudo_lock_release();
-	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
-	closid_exit();
-	schemata_list_destroy();
-	rdtgroup_destroy_root();
+	resctrl_fs_teardown();
 	if (resctrl_arch_alloc_capable())
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
@@ -4127,6 +4138,8 @@ static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
 
 static void rdtgroup_destroy_root(void)
 {
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	kernfs_destroy_root(rdt_root);
 	rdtgroup_default.kn = NULL;
 }
@@ -4432,23 +4445,42 @@ static bool __exit resctrl_online_domains_exist(void)
 	return false;
 }
 
-/*
+/**
  * resctrl_exit() - Remove the resctrl filesystem and free resources.
  *
+ * Called by the architecture code in response to a fatal error.
+ * Removes resctrl files and structures from kernfs to prevent further
+ * configuration.
+ *
  * When called by the architecture code, all CPUs and resctrl domains must be
  * offline. This ensures the limbo and overflow handlers are not scheduled to
  * run, meaning the data structures they access can be freed by
  * resctrl_mon_resource_exit().
+ *
+ * After this function has returned, the architecture code should return an
+ * from all resctrl_arch_ functions that can do this.
+ * resctrl_arch_get_resource() must continue to return struct rdt_resources
+ * with the correct rid field to ensure the filesystem can be unmounted.
  */
 void __exit resctrl_exit(void)
 {
 	cpus_read_lock();
 	WARN_ON_ONCE(resctrl_online_domains_exist());
+
+	mutex_lock(&rdtgroup_mutex);
+	resctrl_fs_teardown();
+	mutex_unlock(&rdtgroup_mutex);
+
 	cpus_read_unlock();
 
 	debugfs_remove_recursive(debugfs_resctrl);
+	debugfs_resctrl = NULL;
 	unregister_filesystem(&rdt_fs_type);
-	sysfs_remove_mount_point(fs_kobj, "resctrl");
+
+	/*
+	 * Do not remove the sysfs mount point added by resctrl_init() so that
+	 * it can be used to umount resctrl.
+	 */
 
 	resctrl_mon_resource_exit();
 }
-- 
2.39.5


