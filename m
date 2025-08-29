Return-Path: <linux-kernel+bounces-792082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27959B3BFF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29716564BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392C3451D5;
	Fri, 29 Aug 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD8acBty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB6345741
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482584; cv=none; b=sPlrLnwlUYuVJOGhE3kU37K7HdyTxQlBxk6ML70md92sy+VjjluqKXWdmBotf0CHvYcgf85kDHdTM8NDlVWa/yfT3Zsl3e1upAJQGCdJ1NwKc4bMSLAQNtIITLj8yEMC9+S+27Mk/kr2uDpE3NFGh2CaWjbd7o3xhVvEsE235/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482584; c=relaxed/simple;
	bh=tmme1GHCRZttEH0fzbesyJQ/RQ0GFTr99io8B0/CrOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh+36ly9G9O6bMyGpBw5eYsuoiRz8nAj5lP7ZOHkIbu1NJ9FOg/U4PZUiLxfHjpeybGtV+OaoTTCkGwWbslOF3R6IgyKiqU9RdRHzmRmDVnuXkFIRPk2TpTOi+bmlVnMN9AqnGCFdthH7rTCdVh1W8QiPitH+s90QgNtrYS4R6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD8acBty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CE1C4CEF0;
	Fri, 29 Aug 2025 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482583;
	bh=tmme1GHCRZttEH0fzbesyJQ/RQ0GFTr99io8B0/CrOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YD8acBty7uTe7lkSuCFwOxAFRxYC5vf1qSBSyYfi9nuYsNCz00UrngZDNNcqK3V9U
	 yIoIfAd26AaLADYX44IpcqZfR0Hl/v0/yPPzOiBoSqDJfi2+4M9mw2/rT8NIUA2s74
	 nGys6NvCAR+TnGTIZe48AVOU6jQo+632thLRetDWZzANMdXHvvhGSDp635jVK90gPp
	 P2/geXdYLXNwNvet6/gvEwe4j4/hrdyt7hqyE46adZxVBU8BnLOZYaRg9kM/p25E3J
	 7c2ANkdQfiq6lD5HrtoUxYHMBtBrGZXCA6FajhotONZnjOx6lDeIhAkeLoA0H55UvP
	 b3Yhb81AeUJQQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 30/33] kthread: Add API to update preferred affinity on kthread runtime
Date: Fri, 29 Aug 2025 17:48:11 +0200
Message-ID: <20250829154814.47015-31-frederic@kernel.org>
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

Kthreads can apply for a preferred affinity upon creation but they have
no means to update that preferred affinity after the first wake up.
kthread_affine_preferred() is optimized by assuming the kthread
is sleeping while applying the allowed cpumask.

Therefore introduce a new API to further update the preferred affinity.

It will be used by IRQ kthreads.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 55 +++++++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c92c1149ee6e..a06cae7f2c55 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -86,6 +86,7 @@ void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask);
+int kthread_affine_preferred_update(struct task_struct *p, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 int kthread_stop_put(struct task_struct *k);
 bool kthread_should_stop(void);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index d36bdfbd004e..f3397cf7542a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -322,17 +322,16 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 void __noreturn kthread_exit(long result)
 {
 	struct kthread *kthread = to_kthread(current);
+	struct cpumask *to_free = NULL;
 	kthread->result = result;
-	if (!list_empty(&kthread->affinity_node)) {
-		mutex_lock(&kthread_affinity_lock);
-		list_del(&kthread->affinity_node);
-		mutex_unlock(&kthread_affinity_lock);
 
-		if (kthread->preferred_affinity) {
-			kfree(kthread->preferred_affinity);
-			kthread->preferred_affinity = NULL;
-		}
+	scoped_guard(mutex, &kthread_affinity_lock) {
+		if (!list_empty(&kthread->affinity_node))
+			list_del_init(&kthread->affinity_node);
+		to_free = kthread->preferred_affinity;
+		kthread->preferred_affinity = NULL;
 	}
+	kfree(to_free);
 	do_exit(0);
 }
 EXPORT_SYMBOL(kthread_exit);
@@ -900,6 +899,46 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
 }
 EXPORT_SYMBOL_GPL(kthread_affine_preferred);
 
+/**
+ * kthread_affine_preferred_update - update a kthread's preferred affinity
+ * @p: thread created by kthread_create().
+ * @cpumask: new mask of CPUs (might not be online, must be possible) for @k
+ *           to run on.
+ *
+ * Update the cpumask of the desired kthread's affinity that was passed by
+ * a previous call to kthread_affine_preferred(). This can be called either
+ * before or after the first wakeup of the kthread.
+ *
+ * Returns 0 if the affinity has been applied.
+ */
+int kthread_affine_preferred_update(struct task_struct *p,
+				    const struct cpumask *mask)
+{
+	struct kthread *kthread = to_kthread(p);
+	cpumask_var_t affinity;
+	int ret = 0;
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	scoped_guard(mutex, &kthread_affinity_lock) {
+		if (WARN_ON_ONCE(!kthread->preferred_affinity ||
+				 list_empty(&kthread->affinity_node))) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		cpumask_copy(kthread->preferred_affinity, mask);
+		kthread_fetch_affinity(kthread, affinity);
+		set_cpus_allowed_ptr(p, affinity);
+	}
+out:
+	free_cpumask_var(affinity);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kthread_affine_preferred_update);
+
 static int kthreads_update_affinity(bool force)
 {
 	cpumask_var_t affinity;
-- 
2.51.0


