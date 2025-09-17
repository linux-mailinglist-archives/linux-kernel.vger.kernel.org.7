Return-Path: <linux-kernel+bounces-821316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B38B80F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EA51C8244A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C12F99BD;
	Wed, 17 Sep 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsB7WWaG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C42F8BD5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126028; cv=none; b=TttGIfF+qDYhEZL4EcOPvMoi1LvB1TWL33yFxUnKxDjn+Zu1o7UWgLHt9/CpHor/lUprS+dhvvUAx2FriseH9rHhY6FMalfsJz+IvauYmkkKToCxDZfvXP+MyIdmT01l8k7ECFxUq9RXLdZbRPB2KrIIU6YmZ0of+qL3SNh81SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126028; c=relaxed/simple;
	bh=UMsHu+w8EEtkyNcFKkFqgEeOYSGG/E/cfqNjj48Uvek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQSp4xCVrE59comZY3jclsTYsB8ozHXKpXZyZGcGARykCIBkziba2w/2h6qoOZ4CbKbtxI/HbVvbSUtXejJoM+iolniMudKIYS+348TmzGEdyWRo3E2cAFeyo9cOgveMIi08Yj9xdlV92B+R1hIpqybEImqwz5f0bosOQ5eM7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsB7WWaG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nneiESOQSRs1JNr8iGSFvq05p9vDY3T+UnNzRYLtsEk=;
	b=BsB7WWaGkc1kkjjwZ1XyE892BiLxG6Ca3EwCMbhyaFySYbEHvS59vhyb5qENCe18LBNP9g
	3ydC3ripujmHVgPLih1ro0ApGcG2btqK73teIz1Vxf2LyVeA5/DfwmwpL6nlvASGVFC01z
	Yz4pPWYnuefPK/MRt9sfaZBVOp5LO6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-2_IcMWv8PmuBCsgvQEWQyQ-1; Wed,
 17 Sep 2025 12:20:22 -0400
X-MC-Unique: 2_IcMWv8PmuBCsgvQEWQyQ-1
X-Mimecast-MFC-AGG-ID: 2_IcMWv8PmuBCsgvQEWQyQ_1758126021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7712119560AA;
	Wed, 17 Sep 2025 16:20:21 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.34.168])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A80361800446;
	Wed, 17 Sep 2025 16:20:18 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v13 4/9] timers: Use scoped_guard when setting/clearing the tmigr available flag
Date: Wed, 17 Sep 2025 18:19:53 +0200
Message-ID: <20250917161958.178925-5-gmonaco@redhat.com>
In-Reply-To: <20250917161958.178925-1-gmonaco@redhat.com>
References: <20250917161958.178925-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Cleanup tmigr_clear_cpu_available() and tmigr_set_cpu_available() to
prepare for easier checks on the available flag.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/time/timer_migration.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 865071ab5062..0a3a26e766d0 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1450,17 +1450,17 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
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
@@ -1479,13 +1479,13 @@ static int tmigr_set_cpu_available(unsigned int cpu)
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
2.51.0


