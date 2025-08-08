Return-Path: <linux-kernel+bounces-760550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E4B1ECC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBC117FA40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B16287252;
	Fri,  8 Aug 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAg80rl6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96965286D72
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668925; cv=none; b=bPrJeo+oL3z0wIqg+4NX29glUYynIHgFYoTB2Ry78wxjN9m1GhZa9Sv5tRjEwvmcEcG2PkcXIlg10xyPWBbu6pxzcXm1oOHbIEfXaJEc71TtifZ0J2R8jMrI6kC5E0QRUaAbtNoQ62rtUz42+8fe0XV9n1+Wvt7AmT/9brqFieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668925; c=relaxed/simple;
	bh=2k5yEzfufKgnBRj8JIhZV7ZkaQdISnBdkqCuTW4/Dug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvjt484VMQcwvjp+/wsr+lrjviDY9xTfYb1Sj76hJ5AwcZxKmgx3neDxGvZrSBTKkl3jnu+PYA1fJ26EUPkcyMEmYMOQRZoWHhysT9GABWx6jRtmJ3aWiaehz4DJUgF+0yKiHebFqIi0cW4Zi5R+/UX8IxRsH52pvUg0dlbeBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAg80rl6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsaM/+IDmZbCwu63ppMgMMObFC3jn1+84pxM4xGsofk=;
	b=cAg80rl6A3mfLB07nY5l9I3LdRzNznxNg71yBuVMDYhaW2fXKMTg+SHtbBSdLdPy63F+9V
	wV/XJgbxIZ9WpAnlncPvRAK6DJRZcwd4GEEaHSkpCtSYXKVjJlvGusfH+g+uiYrZlbgjRP
	Q9bHLI1W+XhfGTiN5gUyG/NFQvBCIQw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-LG-XHt_4NSK0UgFaul4lnQ-1; Fri,
 08 Aug 2025 12:01:59 -0400
X-MC-Unique: LG-XHt_4NSK0UgFaul4lnQ-1
X-Mimecast-MFC-AGG-ID: LG-XHt_4NSK0UgFaul4lnQ_1754668918
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3577818004A7;
	Fri,  8 Aug 2025 16:01:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 596BA19560AD;
	Fri,  8 Aug 2025 16:01:55 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v11 2/8] timers: Rename tmigr 'online' bit to 'available'
Date: Fri,  8 Aug 2025 18:01:36 +0200
Message-ID: <20250808160142.103852-3-gmonaco@redhat.com>
In-Reply-To: <20250808160142.103852-1-gmonaco@redhat.com>
References: <20250808160142.103852-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The timer migration hierarchy excludes offline CPUs via the
tmigr_is_not_available function, which is essentially checking the
online bit for the CPU.

Rename the online bit to available and all references in function names
and tracepoint to generalise the concept of available CPUs.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/events/timer_migration.h |  4 ++--
 kernel/time/timer_migration.c          | 22 +++++++++++-----------
 kernel/time/timer_migration.h          |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

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
index 891891794b92..55b186fd146c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -427,7 +427,7 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
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
@@ -1432,19 +1432,19 @@ static long tmigr_trigger_active(void *unused)
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
@@ -1452,7 +1452,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_offline(tmc);
+	trace_tmigr_cpu_unavailable(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {
@@ -1463,7 +1463,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static int tmigr_cpu_online(unsigned int cpu)
+static int tmigr_set_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 
@@ -1472,11 +1472,11 @@ static int tmigr_cpu_online(unsigned int cpu)
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
@@ -1488,7 +1488,7 @@ static int tmigr_cpu_online(unsigned int cpu)
 static int __init tmigr_late_init(void)
 {
 	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				 tmigr_cpu_online, tmigr_cpu_offline);
+				 tmigr_set_cpu_available, tmigr_clear_cpu_available);
 }
 
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
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
2.50.1


