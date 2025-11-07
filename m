Return-Path: <linux-kernel+bounces-889827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C196C3E9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AAF44E5968
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6BB2D94A9;
	Fri,  7 Nov 2025 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="LG1YSPts"
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F053238178
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497194; cv=none; b=BQHkhkPCyHPUwfC3kPcoaKXlDzovUoBqrV1jy3aMRLI4vmu9PokFwsqwJbcYu4T3w+pxM5cRxBfFqSQMV5sA1eL/A/5fd57QqVsMXM2FLc7cz77p3Rm+lIa0FeAkQyB7H8Hs3Z5TTgZvvo/CtB/CAyWhJqD3dHY3meeEOsCx0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497194; c=relaxed/simple;
	bh=rTn06egdip5claoWF1dnzgQgfope/W82ei36zgzZIuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJm2IV+G17cti+/yMm3SDIGaL4AhFjpU65qbshF3wpilPjGRwaq4bgt+2Y3BQkwAy5hB1Y5BYL6QV0GDBE7eoEE1YkSnisK+fZdV5Uh4XYoqhV5NDrJSDrIyQeevjqzbUBqaiWZjJLmFPz0ok53bfKVyHBPoGf0JCMVwyC35P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=LG1YSPts; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eUq5DhLUNzIwJ7ckXy2d8jdi42eTB4J+AekOzS1QSkI=;
	b=LG1YSPts9TGTqAfppCmTm2PNhvc1OUZjVanF6fB5IWXg8/Cc0K+THrQaEdVaAldTBZa4kW6YP
	qpX61AnnaHC5m6XGf11SGG7mBdHv47u1MyX9pXBP8ZoqQsOkmhuXuTZ5OphLYfMIALYFZ9qDYg1
	HuTjGxf6pvW6STFQnzEl7g8=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d2q2r2fz7zpTJm;
	Fri,  7 Nov 2025 14:31:32 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D676180B69;
	Fri,  7 Nov 2025 14:33:06 +0800 (CST)
Received: from huawei.com (10.50.87.109) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 7 Nov
 2025 14:33:05 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>, <ben.horgan@arm.com>
CC: <sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <zengheng4@huawei.com>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH mpam mpam/snapshot+extras/v6.17-rc2 2/2] fs/resctrl: Migrate iommu_groups back when deleting the group
Date: Fri, 7 Nov 2025 14:33:00 +0800
Message-ID: <20251107063300.1580046-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251107063300.1580046-1-zengheng4@huawei.com>
References: <20251107063300.1580046-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100008.china.huawei.com (7.202.181.222)

When deleting a control group or unmounting the resctrl file system, it
is necessary to move its all iommu_groups back to the default group. When
removing a monitor group, need to move its iommu_groups back to the parent
control group.

Otherwise, these iommu_groups remain bound to the old PARTID and PMG, and
they will appear to "disappear" from the resctrl fs.

By the way, remove the redundant formal parameter 'of' in
rdtgroup_move_iommu().

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/resctrl/rdtgroup.c | 52 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 4f4468e11dca..e74e192e9876 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -773,8 +773,7 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
 	return ret;
 }
 
-static int rdtgroup_move_iommu(int iommu_group_id, struct rdtgroup *rdtgrp,
-			       struct kernfs_open_file *of)
+static int rdtgroup_move_iommu(int iommu_group_id, struct rdtgroup *rdtgrp)
 {
 	const struct cred *cred = current_cred();
 	struct iommu_group *iommu_group;
@@ -855,7 +854,7 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 
 		is_iommu = string_is_iommu_group(pid_str, &iommu_group_id);
 		if (is_iommu) {
-			ret = rdtgroup_move_iommu(iommu_group_id, rdtgrp, of);
+			ret = rdtgroup_move_iommu(iommu_group_id, rdtgrp);
 			if (ret) {
 				rdt_last_cmd_printf("Error while processing iommu_group %d\n",
 						     iommu_group_id);
@@ -3161,6 +3160,44 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	read_unlock(&tasklist_lock);
 }
 
+static int rdt_move_group_iommus(struct rdtgroup *from, struct rdtgroup *to)
+{
+	int err, iommu_group_id;
+	struct kset *iommu_groups;
+	struct iommu_group *group;
+	struct kobject *group_kobj = NULL;
+
+	if (!IS_ENABLED(CONFIG_RESCTRL_IOMMU))
+		return 0;
+
+	if (from == to)
+		return 0;
+
+	iommu_groups = iommu_get_group_kset();
+
+	while ((group_kobj = kset_get_next_obj(iommu_groups, group_kobj))) {
+		/* iommu_group_get_from_kobj() wants to drop a reference */
+		kobject_get(group_kobj);
+
+		group = iommu_group_get_from_kobj(group_kobj);
+		if (!group)
+			continue;
+
+		if (!from || iommu_matches_rdtgroup(group, from)) {
+			err = kstrtoint(group_kobj->name, 0, &iommu_group_id);
+			if (err)
+				break;
+
+			err = rdtgroup_move_iommu(iommu_group_id, to);
+			if (err)
+				break;
+		}
+	}
+
+	kset_put(iommu_groups);
+	return err;
+}
+
 static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 {
 	struct rdtgroup *sentry, *stmp;
@@ -3188,6 +3225,9 @@ static void rmdir_all_sub(void)
 	/* Move all tasks to the default resource group */
 	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
 
+	/* Move all iommu_groups to the default resource group */
+	rdt_move_group_iommus(NULL, &rdtgroup_default);
+
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
 		/* Free any child rmids */
 		free_all_child_rdtgrp(rdtgrp);
@@ -4050,6 +4090,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
+	/* Give any iommu_groups back to the parent group */
+	rdt_move_group_iommus(rdtgrp, prdtgrp);
+
 	/*
 	 * Update per cpu closid/rmid of the moved CPUs first.
 	 * Note: the closid will not change, but the arch code still needs it.
@@ -4097,6 +4140,9 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	/* Give any tasks back to the default group */
 	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
 
+	/* Give any iommu_groups back to the default group */
+	rdt_move_group_iommus(rdtgrp, &rdtgroup_default);
+
 	/* Give any CPUs back to the default group */
 	cpumask_or(&rdtgroup_default.cpu_mask,
 		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
-- 
2.25.1


