Return-Path: <linux-kernel+bounces-750793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9AB1611D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0315A27C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFC29AB00;
	Wed, 30 Jul 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxVBk9AZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FC298987
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881149; cv=none; b=ESHA1V27BtACTyw+tXOQLqLuOuEX76kSzSqugcA/S1PK4HLaEODlkA8aBBSkSOPdhF0ON2gh2mc4mzsXKMObMtCX0o9KCO0a+jxzBE4yqtWW+UWhs9A2PnXG9WMtwy96qj/+nuLzOvmDk9Kjr7ZDt3tuiNqQ6fQ7lRflctuE2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881149; c=relaxed/simple;
	bh=BS3ySg0mBW7E6/RTvIrpHJNhD38uGFfTvbx5bxYRNos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HV1NzCcMemqRh0/ZHjJnRm+jgMMcOhsHksUHVZ0KUReTFu4zHRXmNw9t2hApAo7114flxLDcEc/6wMotqHvVZ43BruTxYxsNRrLQYDRoSy+4t/6U7f6fKpfZQLoMrZi6LS7g9Njn/sM35ITj38Qer/3w9S8XcY4Ri7Sai9htM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxVBk9AZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753881147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QNhru3mCOwLI7ftBk1RkkcO9EVRYRaVXe0cAWR0Vds=;
	b=CxVBk9AZfh/HRR8E23zZVtVZY028eWYKPfyoP5lxYrmjJwC+/IGMLL5pPT8snaIZg25ucP
	V0eZjqFwFqhbAZOaUAC3AGEvIXw+I0CX04k5vcEvpq0haHEZWsDtz67XuIlSol9z5FcK4I
	Wh128tQPqtRCtXz4NX6mHqc+wco+eZU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-IV4WiupvN56z_qfCXRK9og-1; Wed,
 30 Jul 2025 09:12:25 -0400
X-MC-Unique: IV4WiupvN56z_qfCXRK9og-1
X-Mimecast-MFC-AGG-ID: IV4WiupvN56z_qfCXRK9og_1753881144
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F5819560B3;
	Wed, 30 Jul 2025 13:12:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A5BC19560A2;
	Wed, 30 Jul 2025 13:12:21 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v9 4/8] timers: Use scoped_guard when setting/clearing the tmigr available flag
Date: Wed, 30 Jul 2025 15:11:54 +0200
Message-ID: <20250730131158.101668-5-gmonaco@redhat.com>
In-Reply-To: <20250730131158.101668-1-gmonaco@redhat.com>
References: <20250730131158.101668-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Cleanup tmigr_clear_cpu_available() and tmigr_set_cpu_available() to
prepare for easier checks on the available flag.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/time/timer_migration.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 57abdef7d0f8..36e7f784ec60 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1453,17 +1453,17 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	u64 firstexp;
 
 	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
-	raw_spin_lock_irq(&tmc->lock);
-	tmc->available = false;
-	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		tmc->available = false;
+		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
-	/*
-	 * CPU has to handle the local events on his own, when on the way to
-	 * offline; Therefore nextevt value is set to KTIME_MAX
-	 */
-	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_unavailable(tmc);
-	raw_spin_unlock_irq(&tmc->lock);
+		/*
+		 * CPU has to handle the local events on his own, when on the way to
+		 * offline; Therefore nextevt value is set to KTIME_MAX
+		 */
+		firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
+		trace_tmigr_cpu_unavailable(tmc);
+	}
 
 	if (firstexp != KTIME_MAX) {
 		migrator = cpumask_any(tmigr_available_cpumask);
@@ -1482,13 +1482,13 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 		return -EINVAL;
 
 	cpumask_set_cpu(cpu, tmigr_available_cpumask);
-	raw_spin_lock_irq(&tmc->lock);
-	trace_tmigr_cpu_available(tmc);
-	tmc->idle = timer_base_is_idle();
-	if (!tmc->idle)
-		__tmigr_cpu_activate(tmc);
-	tmc->available = true;
-	raw_spin_unlock_irq(&tmc->lock);
+	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		trace_tmigr_cpu_available(tmc);
+		tmc->idle = timer_base_is_idle();
+		if (!tmc->idle)
+			__tmigr_cpu_activate(tmc);
+		tmc->available = true;
+	}
 	return 0;
 }
 
-- 
2.50.1


