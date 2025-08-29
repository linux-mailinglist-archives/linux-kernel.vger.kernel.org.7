Return-Path: <linux-kernel+bounces-792073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E642CB3BFE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A643163A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891F2341660;
	Fri, 29 Aug 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJZNBgew"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E8340DBA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482563; cv=none; b=kGSJi5MpqSjuEG3qe2RyNR4Io0VUM3vKM9IkTOcG0vut7hi1sSFU0RWGNWexBk0caZ3eaZaNPiUHSV+DQ43V/eqA6uLOjjs16SSwLx+5kr+PFZBETsQj+52Ehk+CYBHRdr7FUdRJn+KLzdygfI8ShOr5T5Oxhk3ELtBKY+JVwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482563; c=relaxed/simple;
	bh=W/GX3bsXC+QdFnHRurPxesapj10VViVlroe7jMIjDmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FT8mnqd5jPBpWnB+0UsIqhI9XqVMekKrNDhkn2EdYZeMmTQr4ZKzYv7nFWDQndNSWraG/YYGZ6+q95O2MezC6OBSy1kEaC4W73wJn5bI4RLcgeQYiL6tjIiDJHjOmZFevPeJ9zdKneSME3xV0gyi/DGePiWCqZ6K41y2Fk7qbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJZNBgew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5816C4CEF5;
	Fri, 29 Aug 2025 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482562;
	bh=W/GX3bsXC+QdFnHRurPxesapj10VViVlroe7jMIjDmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJZNBgewpL77YxM3jxrHKjGe0QrhlNbtg/f6NjjS8o5c8k7TN7sN/NwsiSOCL7MEH
	 D6AkZMIZs54V29bmez7t2snQovRau9reM42B21F6a5b3nkYvf3wIOv6jJHcjvChMKf
	 jpoVjfDTLBpOWdlt9AcNfX0wfqKqS9no8pUb2Vzj5RqJ8J6JnnpM4GyJG8NMbZEHUv
	 kRE2InDeDFERwOxAl7qCJlF2nFJoblULX6tl8PvzbHAB+vM5qFm3h1Pm1Ukw9xDU9r
	 YVla9w+yZG7HUe59MqepeC28fwKbI5Mylw5huaLec8B5HTGfX+44p99sQ5wbF+iOoV
	 Yt/q1iLuXue6g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 22/33] kthread: Include unbound kthreads in the managed affinity list
Date: Fri, 29 Aug 2025 17:48:03 +0200
Message-ID: <20250829154814.47015-23-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The managed affinity list currently contains only unbound kthreads that
have affinity preferences. Unbound kthreads globally affine by default
are outside of the list because their affinity is automatically managed
by the scheduler (through the fallback housekeeping mask) and by cpuset.

However in order to preserve the preferred affinity of kthreads, cpuset
will delegate the isolated partition update propagation to the
housekeeping and kthread code.

Prepare for that with including all unbound kthreads in the managed
affinity list.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 59 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index c4dd967e9e9c..cba3d297f267 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -365,9 +365,10 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
 	if (kthread->preferred_affinity) {
 		pref = kthread->preferred_affinity;
 	} else {
-		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
-			return;
-		pref = cpumask_of_node(kthread->node);
+		if (kthread->node == NUMA_NO_NODE)
+			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
+		else
+			pref = cpumask_of_node(kthread->node);
 	}
 
 	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
@@ -380,32 +381,29 @@ static void kthread_affine_node(void)
 	struct kthread *kthread = to_kthread(current);
 	cpumask_var_t affinity;
 
-	WARN_ON_ONCE(kthread_is_per_cpu(current));
+	if (WARN_ON_ONCE(kthread_is_per_cpu(current)))
+		return;
 
-	if (kthread->node == NUMA_NO_NODE) {
-		housekeeping_affine(current, HK_TYPE_KTHREAD);
-	} else {
-		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
-			WARN_ON_ONCE(1);
-			return;
-		}
-
-		mutex_lock(&kthread_affinity_lock);
-		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
-		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
-		/*
-		 * The node cpumask is racy when read from kthread() but:
-		 * - a racing CPU going down will either fail on the subsequent
-		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
-		 *   afterwards by the scheduler.
-		 * - a racing CPU going up will be handled by kthreads_online_cpu()
-		 */
-		kthread_fetch_affinity(kthread, affinity);
-		set_cpus_allowed_ptr(current, affinity);
-		mutex_unlock(&kthread_affinity_lock);
-
-		free_cpumask_var(affinity);
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	mutex_lock(&kthread_affinity_lock);
+	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
+	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
+	/*
+	 * The node cpumask is racy when read from kthread() but:
+	 * - a racing CPU going down will either fail on the subsequent
+	 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
+	 *   afterwards by the scheduler.
+	 * - a racing CPU going up will be handled by kthreads_online_cpu()
+	 */
+	kthread_fetch_affinity(kthread, affinity);
+	set_cpus_allowed_ptr(current, affinity);
+	mutex_unlock(&kthread_affinity_lock);
+
+	free_cpumask_var(affinity);
 }
 
 static int kthread(void *_create)
@@ -924,8 +922,11 @@ static int kthreads_online_cpu(unsigned int cpu)
 			ret = -EINVAL;
 			continue;
 		}
-		kthread_fetch_affinity(k, affinity);
-		set_cpus_allowed_ptr(k->task, affinity);
+
+		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
+			kthread_fetch_affinity(k, affinity);
+			set_cpus_allowed_ptr(k->task, affinity);
+		}
 	}
 
 	free_cpumask_var(affinity);
-- 
2.51.0


