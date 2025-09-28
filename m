Return-Path: <linux-kernel+bounces-835282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF1BA6A21
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB673C0C99
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249202C159E;
	Sun, 28 Sep 2025 07:29:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E02BDC2C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044549; cv=none; b=rWTX0lLgZ7/GBHYY+J0ZTGUFI9eXb61Bmurr7j5TGgknWlYuxe46K1pfwrvrrfhKEwJoDjVvm60+neMdFZ3dHQ5cnsJGgGmmcIt4Eud8TE49IwBfkK4usprhmmiKPWb/w/bF/kBqVr2UDpYm//qxuVwXMCR8cfyt6Nlnw1yTa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044549; c=relaxed/simple;
	bh=IAs/lO4cm/XSZWDjMQ3kkD62j7v2MO+jHOJcO6PbYJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUa8YcM9gs8hgjEX1dJSm8Ti/W2WMl2QJKPInHexLnBDNyAz1tpHMl1OWTjzdBss6epQHmuDvtpMav+GobX8ixbq5Xed7M6004Yt6FUne7f9Jduq7abeWH0PJSYmPKzJ51njwZoALD+h9UPhz4NgkgoP1rZXhZt27vYQkBF5wXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCF1CGdzYQvf1;
	Sun, 28 Sep 2025 15:28:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 10B8C1A1012;
	Sun, 28 Sep 2025 15:28:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S11;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 09/16] cpuset: introduce local_partition_update()
Date: Sun, 28 Sep 2025 07:12:59 +0000
Message-Id: <20250928071306.3797436-10-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250928071306.3797436-1-chenridong@huaweicloud.com>
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S11
X-Coremail-Antispam: 1UD129KBjvAXoW3uw48Kw4kAF4fWF4rKrWUXFb_yoW8Ar4xKo
	W3JF48A3s3Jw1UWFs0ywn2kFWkWw4vy343t3Wqvr9rur13Aw1DK3W3J3Zav34fXrWrtr98
	XF9aq3y8Cry7AF4Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Extend the partition_update() infrastructure to handle local partition
updates.

The local_partition_update() function replaces the command partcmd_update
previously handled within update_parent_effective_cpumask(). The update
logic follows a state-based approach:

1. Validation check: First verify if the local partition is currently valid
2. Invalidation handling: If the partition is invalid, trigger invalidation
3. State transition: If an invalid partition has no errors, transition to
   valid
4. cpus updates: For local partition that only cpu maks changes, use
   partition_update() to handle partition change.

With the introduction of this function, update_parent_effective_cpumask()
function is removed, simplifying the partition update code path and
creating a cleaner separation between local and remote partition
operations.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 376 +++++++++++++----------------------------
 1 file changed, 122 insertions(+), 254 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e460d03286ba..d0217db04b69 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1622,12 +1622,14 @@ static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
 	bool isolcpus_updated;
 	bool excl_updated;
 	struct cpuset *parent;
+	int old_prs;
 
 	lockdep_assert_held(&cpuset_mutex);
 	WARN_ON_ONCE(!cpuset_v2());
 	WARN_ON_ONCE(prs <= 0);
 
 	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
+	old_prs = cs->partition_root_state;
 	excl_updated = !cpumask_empty(tmp->addmask) ||
 			!cpumask_empty(tmp->delmask);
 
@@ -1645,6 +1647,8 @@ static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 	if (excl_updated)
 		cpuset_force_rebuild();
+	update_partition_exclusive_flag(cs, prs);
+	notify_partition_change(cs, old_prs);
 }
 
 /*
@@ -1790,6 +1794,27 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
+static bool cpuset_user_cpus_exclusive(struct cpuset *cs)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	struct cgroup_subsys_state *css;
+	struct cpuset *child;
+	bool exclusive = true;
+
+	rcu_read_lock();
+	cpuset_for_each_child(child, css, parent) {
+		if (child == cs)
+			continue;
+		if (!cpusets_are_exclusive(cs, child)) {
+			exclusive = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return exclusive;
+}
+
 /**
  * validate_partition - Validate a cpuset partition configuration
  * @cs: The cpuset to validate
@@ -1818,6 +1843,39 @@ static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
 	return PERR_NONE;
 }
 
+/**
+ * local_partition_check - Validate for local partition
+ * @cs: Target cpuset to validate
+ * @new_prs: New partition root state to validate
+ * @excpus: New exclusive effectuve CPUs mask to validate
+ * @excl_check: Flag to enable exclusive CPUs ownership validation
+ *
+ * Return: PERR_NONE if validation passes, appropriate error code otherwise
+ *
+ * Important: The caller must ensure that @cs's cpu mask is updated before
+ * invoking this function when exclusive CPU validation is required.
+ */
+static enum prs_errcode local_partition_check(struct cpuset *cs, int new_prs,
+							 struct cpumask *excpus, bool excl_check)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	/*
+	 * The parent must be a partition root.
+	 * The new cpumask, if present, or the current cpus_allowed must
+	 * not be empty.
+	 */
+	if (!is_partition_valid(parent)) {
+		return is_partition_invalid(parent)
+			? PERR_INVPARENT : PERR_NOTPART;
+	}
+
+	if (excl_check && !cpuset_user_cpus_exclusive(cs))
+		return PERR_NOTEXCL;
+
+	return validate_partition(cs, new_prs, excpus);
+}
+
 /**
  * local_partition_enable - Enable local partition for a cpuset
  * @cs: Target cpuset to become a local partition root
@@ -1945,280 +2003,85 @@ static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
 }
 
 /**
- * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
- * @cs:      The cpuset that requests change in partition root state
- * @cmd:     Partition root state change command
- * @newmask: Optional new cpumask for partcmd_update
- * @tmp:     Temporary addmask and delmask
- * Return:   0 or a partition root state error code
- *
- * For partcmd_enable*, the cpuset is being transformed from a non-partition
- * root to a partition root. The effective_xcpus (cpus_allowed if
- * effective_xcpus not set) mask of the given cpuset will be taken away from
- * parent's effective_cpus. The function will return 0 if all the CPUs listed
- * in effective_xcpus can be granted or an error code will be returned.
- *
- * For partcmd_disable, the cpuset is being transformed from a partition
- * root back to a non-partition root. Any CPUs in effective_xcpus will be
- * given back to parent's effective_cpus. 0 will always be returned.
+ * __local_partition_update - Update local CPU partition configuration
+ * @cs: Target cpuset to update
+ * @xcpus: New exclusive CPU mask
+ * @excpus: New effective exclusive CPU mask
+ * @tmp: Temporary mask storage for intermediate calculations
+ * @excl_check: Flag to enable exclusivity validation
  *
- * For partcmd_update, if the optional newmask is specified, the cpu list is
- * to be changed from effective_xcpus to newmask. Otherwise, effective_xcpus is
- * assumed to remain the same. The cpuset should either be a valid or invalid
- * partition root. The partition root state may change from valid to invalid
- * or vice versa. An error code will be returned if transitioning from
- * invalid to valid violates the exclusivity rule.
+ * Handles updates to local CPU partition configurations by validating
+ * changes, managing state transitions, and propagating updates through
+ * the cpuset hierarchy.
  *
- * For partcmd_invalidate, the current partition will be made invalid.
+ * Note on exclusivity checking: Exclusivity validation is required when
+ * transitioning from an invalid to valid partition state. However, when
+ * updating cpus_allowed or exclusive_cpus, exclusivity should have already
+ * been verified by validate_change(). In such cases, excl_check must be
+ * false since the cs cpumasks are not yet updated.
  *
- * The partcmd_enable* and partcmd_disable commands are used by
- * update_prstate(). An error code may be returned and the caller will check
- * for error.
- *
- * The partcmd_update command is used by update_cpumasks_hier() with newmask
- * NULL and update_cpumask() with newmask set. The partcmd_invalidate is used
- * by update_cpumask() with NULL newmask. In both cases, the callers won't
- * check for error and so partition_root_state and prs_err will be updated
- * directly.
+ * Return: Partition error code (PERR_NONE indicates success)
  */
-static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
-					   struct cpumask *newmask,
-					   struct tmpmasks *tmp)
+static int __local_partition_update(struct cpuset *cs, struct cpumask *xcpus,
+				  struct cpumask *excpus, struct tmpmasks *tmp,
+				  bool excl_check)
 {
 	struct cpuset *parent = parent_cs(cs);
-	int adding;	/* Adding cpus to parent's effective_cpus	*/
-	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
-	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
-	int subparts_delta = 0;
-	int isolcpus_updated = 0;
-	struct cpumask *xcpus = user_xcpus(cs);
-	bool nocpu;
+	int old_prs, new_prs;
+	bool cpumask_updated = false;
 
 	lockdep_assert_held(&cpuset_mutex);
-	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
+	/* For local partition only */
+	if (WARN_ON_ONCE(is_remote_partition(cs) || cs_is_member(cs)))
+		return PERR_NONE;
 
+	old_prs = cs->partition_root_state;
 	/*
-	 * new_prs will only be changed for the partcmd_update and
-	 * partcmd_invalidate commands.
+	 * If new_prs < 0, it might transition to valid partition state.
+	 * Use absolute value for validation checks.
 	 */
-	adding = deleting = false;
-	old_prs = new_prs = cs->partition_root_state;
-
-	/*
-	 * The parent must be a partition root.
-	 * The new cpumask, if present, or the current cpus_allowed must
-	 * not be empty.
-	 */
-	if (!is_partition_valid(parent)) {
-		return is_partition_invalid(parent)
-		       ? PERR_INVPARENT : PERR_NOTPART;
-	}
-	if (!newmask && xcpus_empty(cs))
-		return PERR_CPUSEMPTY;
-
-	nocpu = tasks_nocpu_error(parent, cs, xcpus);
-
-	if (newmask) {
-		/*
-		 * Empty cpumask is not allowed
-		 */
-		if (cpumask_empty(newmask)) {
-			part_error = PERR_CPUSEMPTY;
-			goto write_error;
-		}
-
-		/* Check newmask again, whether cpus are available for parent/cs */
-		nocpu |= tasks_nocpu_error(parent, cs, newmask);
-
-		/*
-		 * partcmd_update with newmask:
-		 *
-		 * Compute add/delete mask to/from effective_cpus
-		 *
-		 * For valid partition:
-		 *   addmask = exclusive_cpus & ~newmask
-		 *			      & parent->effective_xcpus
-		 *   delmask = newmask & ~exclusive_cpus
-		 *		       & parent->effective_xcpus
-		 *
-		 * For invalid partition:
-		 *   delmask = newmask & parent->effective_xcpus
-		 */
-		if (is_partition_invalid(cs)) {
-			adding = false;
-			deleting = cpumask_and(tmp->delmask,
-					newmask, parent->effective_xcpus);
-		} else {
-			cpumask_andnot(tmp->addmask, xcpus, newmask);
-			adding = cpumask_and(tmp->addmask, tmp->addmask,
-					     parent->effective_xcpus);
-
-			cpumask_andnot(tmp->delmask, newmask, xcpus);
-			deleting = cpumask_and(tmp->delmask, tmp->delmask,
-					       parent->effective_xcpus);
-		}
-		/*
-		 * The new CPUs to be removed from parent's effective CPUs
-		 * must be present.
-		 */
-		if (deleting) {
-			cpumask_and(tmp->new_cpus, tmp->delmask, cpu_active_mask);
-			WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
-		}
-
-		/*
-		 * Make partition invalid if parent's effective_cpus could
-		 * become empty and there are tasks in the parent.
-		 */
-		if (nocpu && (!adding ||
-		    !cpumask_intersects(tmp->addmask, cpu_active_mask))) {
-			part_error = PERR_NOCPUS;
-			deleting = false;
-			adding = cpumask_and(tmp->addmask,
-					     xcpus, parent->effective_xcpus);
-		}
-	} else {
-		/*
-		 * partcmd_update w/o newmask
-		 *
-		 * delmask = effective_xcpus & parent->effective_cpus
-		 *
-		 * This can be called from:
-		 * 1) update_cpumasks_hier()
-		 * 2) cpuset_hotplug_update_tasks()
-		 *
-		 * Check to see if it can be transitioned from valid to
-		 * invalid partition or vice versa.
-		 *
-		 * A partition error happens when parent has tasks and all
-		 * its effective CPUs will have to be distributed out.
-		 */
-		if (nocpu) {
-			part_error = PERR_NOCPUS;
-			if (is_partition_valid(cs))
-				adding = cpumask_and(tmp->addmask,
-						xcpus, parent->effective_xcpus);
-		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
-			   cpumask_subset(xcpus, parent->effective_xcpus)) {
-			struct cgroup_subsys_state *css;
-			struct cpuset *child;
-			bool exclusive = true;
-
-			/*
-			 * Convert invalid partition to valid has to
-			 * pass the cpu exclusivity test.
-			 */
-			rcu_read_lock();
-			cpuset_for_each_child(child, css, parent) {
-				if (child == cs)
-					continue;
-				if (!cpusets_are_exclusive(cs, child)) {
-					exclusive = false;
-					break;
-				}
-			}
-			rcu_read_unlock();
-			if (exclusive)
-				deleting = cpumask_and(tmp->delmask,
-						xcpus, parent->effective_cpus);
-			else
-				part_error = PERR_NOTEXCL;
-		}
-	}
-
-write_error:
-	if (part_error)
-		WRITE_ONCE(cs->prs_err, part_error);
-
-	if (cmd == partcmd_update) {
-		/*
-		 * Check for possible transition between valid and invalid
-		 * partition root.
-		 */
-		switch (cs->partition_root_state) {
-		case PRS_ROOT:
-		case PRS_ISOLATED:
-			if (part_error) {
-				new_prs = -old_prs;
-				subparts_delta--;
-			}
-			break;
-		case PRS_INVALID_ROOT:
-		case PRS_INVALID_ISOLATED:
-			if (!part_error) {
-				new_prs = -old_prs;
-				subparts_delta++;
-			}
-			break;
-		}
+	new_prs = old_prs < 0 ? -old_prs : old_prs;
+	part_error = local_partition_check(cs, new_prs, excpus, excl_check);
+	if (part_error) {
+		local_partition_invalidate(cs, tmp);
+		return part_error;
 	}
 
-	if (!adding && !deleting && (new_prs == old_prs))
-		return 0;
+	/* Nothing changes, return PERR_NONE */
+	if (new_prs == old_prs && cpumask_equal(excpus, cs->effective_xcpus))
+		return PERR_NONE;
 
 	/*
-	 * Transitioning between invalid to valid or vice versa may require
-	 * changing CS_CPU_EXCLUSIVE. In the case of partcmd_update,
-	 * validate_change() has already been successfully called and
-	 * CPU lists in cs haven't been updated yet. So defer it to later.
+	 * If partition was previously invalid but now passes checks,
+	 * enable it and update related flags
 	 */
-	if ((old_prs != new_prs) && (cmd != partcmd_update))  {
-		int err = update_partition_exclusive_flag(cs, new_prs);
-
-		if (err)
-			return err;
+	if (is_partition_invalid(cs) && !part_error) {
+		partition_enable(cs, parent, new_prs, excpus);
+		update_partition_exclusive_flag(cs, new_prs);
+		update_partition_sd_lb(cs, old_prs);
+		return part_error;
 	}
 
+	cpumask_updated = cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
+	cpumask_updated |= cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
+	partition_update(cs, new_prs, xcpus, excpus, tmp);
 	/*
-	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
-	 * only).
-	 *
-	 * Newly added CPUs will be removed from effective_cpus and
-	 * newly deleted ones will be added back to effective_cpus.
-	 */
-	spin_lock_irq(&callback_lock);
-	if (old_prs != new_prs) {
-		cs->partition_root_state = new_prs;
-		if (new_prs <= 0)
-			cs->nr_subparts = 0;
-	}
-	/*
-	 * Adding to parent's effective_cpus means deletion CPUs from cs
-	 * and vice versa.
+	 * Propagate changes in parent's effective_cpus down the hierarchy.
 	 */
-	if (adding)
-		isolcpus_updated += partition_xcpus_del(old_prs, parent,
-							tmp->addmask);
-	if (deleting)
-		isolcpus_updated += partition_xcpus_add(new_prs, parent,
-							tmp->delmask);
-
-	if (is_partition_valid(parent)) {
-		parent->nr_subparts += subparts_delta;
-		WARN_ON_ONCE(parent->nr_subparts < 0);
-	}
-	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
-
-	if ((old_prs != new_prs) && (cmd == partcmd_update))
-		update_partition_exclusive_flag(cs, new_prs);
-
-	if (adding || deleting) {
+	if (cpumask_updated) {
 		cpuset_update_tasks_cpumask(parent, tmp->addmask);
 		update_sibling_cpumasks(parent, cs, tmp);
 	}
+	return part_error;
+}
 
-	/*
-	 * For partcmd_update without newmask, it is being called from
-	 * cpuset_handle_hotplug(). Update the load balance flag and
-	 * scheduling domain accordingly.
-	 */
-	if ((cmd == partcmd_update) && !newmask)
-		update_partition_sd_lb(cs, old_prs);
+static int local_partition_update(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	struct cpuset *parent = parent_cs(cs);
 
-	notify_partition_change(cs, old_prs);
-	return 0;
+	cpumask_and(tmp->new_cpus, user_xcpus(cs), parent->effective_xcpus);
+	return __local_partition_update(cs, NULL, tmp->new_cpus, tmp, true);
 }
 
 /**
@@ -2419,9 +2282,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if (!css_tryget_online(&cp->css))
 			continue;
 		rcu_read_unlock();
+		/*
+		 * The tmp->new_cpus may by modified.
+		 * Update effective_cpus before passing tmp to other functions.
+		 */
+		spin_lock_irq(&callback_lock);
+		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
+		spin_unlock_irq(&callback_lock);
 
 		if (update_parent) {
-			update_parent_effective_cpumask(cp, partcmd_update, NULL, tmp);
+			local_partition_update(cp, tmp);
 			/*
 			 * The cpuset partition_root_state may become
 			 * invalid. Capture it.
@@ -2430,7 +2300,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		}
 
 		spin_lock_irq(&callback_lock);
-		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
 		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
 			compute_excpus(cp, cp->effective_xcpus);
@@ -2610,8 +2479,8 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 		if (trialcs->prs_err)
 			local_partition_invalidate(cs, tmp);
 		else
-			update_parent_effective_cpumask(cs, partcmd_update,
-							trialcs->effective_xcpus, tmp);
+			__local_partition_update(cs, trialcs->exclusive_cpus,
+						trialcs->effective_xcpus, tmp, false);
 	}
 }
 
@@ -4063,9 +3932,8 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
 		 !cpumask_empty(user_xcpus(cs))) {
 		partcmd = partcmd_update;
-		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
+		local_partition_update(cs, tmp);
 	}
-
 	if (partcmd >= 0) {
 		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
 			compute_partition_effective_cpumask(cs, &new_cpus);
-- 
2.34.1


