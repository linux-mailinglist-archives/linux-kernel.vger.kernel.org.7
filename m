Return-Path: <linux-kernel+bounces-581280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609CA75CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336F57A33ED
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4C1E4110;
	Sun, 30 Mar 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6lGQepH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF21E32D6
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371644; cv=none; b=cDQ4XQhuW9letUFc40Ce+BiQhExZMd8B7XCuXDhYvLieedgMPLghHnGH8f3BcGwOYr16qpUsFqcbx9WWELq4GecYmuYcUDZq5Dft7Z19TBVgDBNakbWiBBjfXmScAKGJpbjtONLnRYoxPUi+RtCO3qfLsRC2TUcct1oyuGU/e6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371644; c=relaxed/simple;
	bh=CHAsas/BbprCZxXzPAs5unpJr0eUmZhnlPG5geiavLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6S5/5AvSRAmL5qZLjimleZJQslGYPR+73VsthGW/zMAkIpbYdCaGXxkRBgBKiVvFNoOONT4IpTrVt392WqnyfEwrTdzbp8zuUJVXTCeKBma2U4hNxMDH+sG7Gi7gYE3Dw13RdfU+0M1jSVCCeDYARv7gkGd6tI5vi+oWf+bT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6lGQepH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpzEwWppfFUpl+usZQp9RiaPhN5BC5g1VDK4gYP19N0=;
	b=H6lGQepHPQlGMFsX08vEB704uwl6OwDzFshhBxTklAqra1ZVqhjMo/40ELdH1U6cD/D/X0
	QEz8vQZ0ny4eEzGwv5XLnR2rAXF3BqQaN4vDbjI+2k7GhpsI2Hl9xXB9uNwY83AUORRoji
	tNwlUmtm2/87VUuS0RDHhTxibPxTVCs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-tcMHF3SPMi2MRATFLKX7YQ-1; Sun,
 30 Mar 2025 17:53:55 -0400
X-MC-Unique: tcMHF3SPMi2MRATFLKX7YQ-1
X-Mimecast-MFC-AGG-ID: tcMHF3SPMi2MRATFLKX7YQ_1743371633
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEE41190308B;
	Sun, 30 Mar 2025 21:53:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 148CA1801750;
	Sun, 30 Mar 2025 21:53:50 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 06/10] cgroup/cpuset: Code cleanup and comment update
Date: Sun, 30 Mar 2025 17:52:44 -0400
Message-ID: <20250330215248.3620801-7-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Rename partition_xcpus_newstate() to isolated_cpus_update(),
update_partition_exclusive() to update_partition_exclusive_flag() and
the new_xcpus_state variable to isolcpus_updated to make their meanings
more explicit. Also add some comments to further clarify the code.
No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 61 ++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f26f791e9323..aa529b2dbf56 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -65,7 +65,13 @@ static const char * const perr_strings[] = {
 };
 
 /*
- * Exclusive CPUs distributed out to sub-partitions of top_cpuset
+ * For local partitions, update to subpartitions_cpus & isolated_cpus is done
+ * in update_parent_effective_cpumask(). For remote partitions, it is done in
+ * the remote_partition_*() and remote_cpus_update() helpers.
+ */
+/*
+ * Exclusive CPUs distributed out to local or remote sub-partitions of
+ * top_cpuset
  */
 static cpumask_var_t	subpartitions_cpus;
 
@@ -1089,9 +1095,14 @@ void cpuset_reset_sched_domains(void)
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
  * effective cpuset's.  As this function is called with cpuset_mutex held,
- * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mask()
- * is used instead of effective_cpus to make sure all offline CPUs are also
- * included as hotplug code won't update cpumasks for tasks in top_cpuset.
+ * cpuset membership stays stable.
+ *
+ * For top_cpuset, task_cpu_possible_mask() is used instead of effective_cpus
+ * to make sure all offline CPUs are also included as hotplug code won't
+ * update cpumasks for tasks in top_cpuset.
+ *
+ * As task_cpu_possible_mask() can be task dependent in arm64, we have to
+ * do cpu masking per task instead of doing it once for all.
  */
 void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 {
@@ -1151,7 +1162,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
  *
  * Return: 0 if successful, an error code otherwise
  */
-static int update_partition_exclusive(struct cpuset *cs, int new_prs)
+static int update_partition_exclusive_flag(struct cpuset *cs, int new_prs)
 {
 	bool exclusive = (new_prs > PRS_MEMBER);
 
@@ -1234,12 +1245,12 @@ static void reset_partition_data(struct cpuset *cs)
 }
 
 /*
- * partition_xcpus_newstate - Exclusive CPUs state change
+ * isolated_cpus_update - Update the isolated_cpus mask
  * @old_prs: old partition_root_state
  * @new_prs: new partition_root_state
  * @xcpus: exclusive CPUs with state change
  */
-static void partition_xcpus_newstate(int old_prs, int new_prs, struct cpumask *xcpus)
+static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus)
 {
 	WARN_ON_ONCE(old_prs == new_prs);
 	if (new_prs == PRS_ISOLATED)
@@ -1273,8 +1284,8 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
 
 	isolcpus_updated = (new_prs != parent->partition_root_state);
 	if (isolcpus_updated)
-		partition_xcpus_newstate(parent->partition_root_state, new_prs,
-					 xcpus);
+		isolated_cpus_update(parent->partition_root_state, new_prs,
+				     xcpus);
 
 	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
 	return isolcpus_updated;
@@ -1304,8 +1315,8 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 
 	isolcpus_updated = (old_prs != parent->partition_root_state);
 	if (isolcpus_updated)
-		partition_xcpus_newstate(old_prs, parent->partition_root_state,
-					 xcpus);
+		isolated_cpus_update(old_prs, parent->partition_root_state,
+				     xcpus);
 
 	cpumask_and(xcpus, xcpus, cpu_active_mask);
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
@@ -1634,8 +1645,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
 	int subparts_delta = 0;
-	struct cpumask *xcpus;		/* cs effective_xcpus */
 	int isolcpus_updated = 0;
+	struct cpumask *xcpus = user_xcpus(cs);
 	bool nocpu;
 
 	lockdep_assert_held(&cpuset_mutex);
@@ -1647,7 +1658,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 */
 	adding = deleting = false;
 	old_prs = new_prs = cs->partition_root_state;
-	xcpus = user_xcpus(cs);
 
 	if (cmd == partcmd_invalidate) {
 		if (is_prs_invalid(old_prs))
@@ -1861,7 +1871,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * CPU lists in cs haven't been updated yet. So defer it to later.
 	 */
 	if ((old_prs != new_prs) && (cmd != partcmd_update))  {
-		int err = update_partition_exclusive(cs, new_prs);
+		int err = update_partition_exclusive_flag(cs, new_prs);
 
 		if (err)
 			return err;
@@ -1899,7 +1909,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
-		update_partition_exclusive(cs, new_prs);
+		update_partition_exclusive_flag(cs, new_prs);
 
 	if (adding || deleting) {
 		cpuset_update_tasks_cpumask(parent, tmp->addmask);
@@ -2829,7 +2839,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
-	bool new_xcpus_state = false;
+	bool isolcpus_updated = false;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -2843,7 +2853,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
-	err = update_partition_exclusive(cs, new_prs);
+	err = update_partition_exclusive_flag(cs, new_prs);
 	if (err)
 		goto out;
 
@@ -2884,8 +2894,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
+		 * Need to update isolated_cpus.
 		 */
-		new_xcpus_state = true;
+		isolcpus_updated = true;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -2909,7 +2920,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 */
 	if (err) {
 		new_prs = -new_prs;
-		update_partition_exclusive(cs, new_prs);
+		update_partition_exclusive_flag(cs, new_prs);
 	}
 
 	spin_lock_irq(&callback_lock);
@@ -2917,14 +2928,18 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
-	else if (new_xcpus_state)
-		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
+	else if (isolcpus_updated)
+		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(new_xcpus_state);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
 
-	/* Force update if switching back to member */
+	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
 
+	/* A newly created partition must have effective_xcpus set */
+	WARN_ON_ONCE(!old_prs && (new_prs > 0)
+			      && cpumask_empty(cs->effective_xcpus));
+
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
 
-- 
2.48.1


