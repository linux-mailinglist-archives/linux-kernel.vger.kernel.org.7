Return-Path: <linux-kernel+bounces-898914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C91BC564D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 503D7342A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3BA33291F;
	Thu, 13 Nov 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI65z6HC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3003328EA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022824; cv=none; b=GG1Oa6Lfu58v5gcMbwIY0/W12y0pU0yCYSSC1W6ZLnhPKMUP/Ha29TxS+TlrGk4Up0xhirpglxfkuYbj9lv1G8qTYqWhBDQZE+UWVDs1DqMywfRrbl6Kn2CCtStkEEU5wBGbG8foHGnXDd7EKp049ONvy/jbSBQXJpIHmrHVRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022824; c=relaxed/simple;
	bh=DwwQ8b3yQGrFClzdqKLDQh4KSE0qwmN0Yiqz8rg2ABk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfYvvVknpE8n2ZGeMyFRppacu4RNZoIbefQ8Z1/oSEO+NVCp7rQep3M71QZM3NcCUlOV6/aJvS1DvONSg8lNL9G3mvlsFNLxFqR2J61ymaGhldK30AZmvHICn7x75p1XVYGQLBXkvPzFUleYfGYJb962t3+x5mF0kqDUDUlsBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XI65z6HC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763022821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwepi/jU4wzGm9j+tWiO7NXXFDq58TitqC8JYOnk5vQ=;
	b=XI65z6HCC53udFKijWhdQNFcPAAUtmPFDidwQlsfDiQiSn5N8NFAteAhO8v2LvuAKyLAbk
	KN7vYclXNYi/Na8kydU1pMa33VkrPF8mHZKCBc8iUDAfSOthsENoa5kzLdZ1WkdivtGhVm
	ibgRw66w+YSEapabsF5eE7wOWtxwy14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-EEees9ldMe2km62ZIwSv7A-1; Thu,
 13 Nov 2025 03:33:37 -0500
X-MC-Unique: EEees9ldMe2km62ZIwSv7A-1
X-Mimecast-MFC-AGG-ID: EEees9ldMe2km62ZIwSv7A_1763022816
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F129180047F;
	Thu, 13 Nov 2025 08:33:36 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 410DE1800451;
	Thu, 13 Nov 2025 08:33:32 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v15 1/7] timers: Rename tmigr 'online' bit to 'available'
Date: Thu, 13 Nov 2025 09:33:18 +0100
Message-ID: <20251113083324.33490-2-gmonaco@redhat.com>
In-Reply-To: <20251113083324.33490-1-gmonaco@redhat.com>
References: <20251113083324.33490-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The timer migration hierarchy excludes offline CPUs via the
tmigr_is_not_available function, which is essentially checking the
online bit for the CPU.

Rename the online bit to available and all references in function names
and tracepoint to generalise the concept of available CPUs.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/events/timer_migration.h |  4 ++--
 kernel/time/timer_migration.c          | 24 ++++++++++++------------
 kernel/time/timer_migration.h          |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
index 47db5eaf2f9a..61171b13c687 100644
--- a/include/trace/events/timer_migration.h
+++ b/include/trace/events/timer_migration.h
@@ -173,14 +173,14 @@ DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
 	TP_ARGS(tmc)
 );
 
-DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_available,
 
 	TP_PROTO(struct tmigr_cpu *tmc),
 
 	TP_ARGS(tmc)
 );
 
-DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_unavailable,
 
 	TP_PROTO(struct tmigr_cpu *tmc),
 
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 19ddfa96b9df..d50514062a06 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -429,7 +429,7 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
 static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
 {
-	return !(tmc->tmgroup && tmc->online);
+	return !(tmc->tmgroup && tmc->available);
 }
 
 /*
@@ -926,7 +926,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 	 * updated the event takes care when hierarchy is completely
 	 * idle. Otherwise the migrator does it as the event is enqueued.
 	 */
-	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
+	if (!tmc->available || tmc->remote || tmc->cpuevt.ignore ||
 	    now < tmc->cpuevt.nextevt.expires) {
 		raw_spin_unlock_irq(&tmc->lock);
 		return;
@@ -973,7 +973,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 	 * (See also section "Required event and timerqueue update after a
 	 * remote expiry" in the documentation at the top)
 	 */
-	if (!tmc->online || !tmc->idle) {
+	if (!tmc->available || !tmc->idle) {
 		timer_unlock_remote_bases(cpu);
 		goto unlock;
 	}
@@ -1422,19 +1422,19 @@ static long tmigr_trigger_active(void *unused)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 
-	WARN_ON_ONCE(!tmc->online || tmc->idle);
+	WARN_ON_ONCE(!tmc->available || tmc->idle);
 
 	return 0;
 }
 
-static int tmigr_cpu_offline(unsigned int cpu)
+static int tmigr_clear_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 	int migrator;
 	u64 firstexp;
 
 	raw_spin_lock_irq(&tmc->lock);
-	tmc->online = false;
+	tmc->available = false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
 	/*
@@ -1442,7 +1442,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_offline(tmc);
+	trace_tmigr_cpu_unavailable(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {
@@ -1453,7 +1453,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static int tmigr_cpu_online(unsigned int cpu)
+static int tmigr_set_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 
@@ -1462,11 +1462,11 @@ static int tmigr_cpu_online(unsigned int cpu)
 		return -EINVAL;
 
 	raw_spin_lock_irq(&tmc->lock);
-	trace_tmigr_cpu_online(tmc);
+	trace_tmigr_cpu_available(tmc);
 	tmc->idle = timer_base_is_idle();
 	if (!tmc->idle)
 		__tmigr_cpu_activate(tmc);
-	tmc->online = true;
+	tmc->available = true;
 	raw_spin_unlock_irq(&tmc->lock);
 	return 0;
 }
@@ -1758,7 +1758,7 @@ static int tmigr_add_cpu(unsigned int cpu)
 		 * The (likely) current CPU is expected to be online in the hierarchy,
 		 * otherwise the old root may not be active as expected.
 		 */
-		WARN_ON_ONCE(!per_cpu_ptr(&tmigr_cpu, raw_smp_processor_id())->online);
+		WARN_ON_ONCE(!per_cpu_ptr(&tmigr_cpu, raw_smp_processor_id())->available);
 		ret = tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
 	}
 
@@ -1854,7 +1854,7 @@ static int __init tmigr_init(void)
 		goto err;
 
 	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				tmigr_cpu_online, tmigr_cpu_offline);
+				tmigr_set_cpu_available, tmigr_clear_cpu_available);
 	if (ret)
 		goto err;
 
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index ae19f70f8170..70879cde6fdd 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -97,7 +97,7 @@ struct tmigr_group {
  */
 struct tmigr_cpu {
 	raw_spinlock_t		lock;
-	bool			online;
+	bool			available;
 	bool			idle;
 	bool			remote;
 	struct tmigr_group	*tmgroup;
-- 
2.51.1


