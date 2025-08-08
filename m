Return-Path: <linux-kernel+bounces-760552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5179FB1ECC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C3D7B6922
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0C2874E6;
	Fri,  8 Aug 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0HiSApT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042D28726C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668929; cv=none; b=Z+pxGTV+oRw4uzZQ46OWYBc5SIhd+fzh5xL+5KY8T9bRpSDkGYcD0REGu7/KROWp/3rOcYxBjyfz1PdflyRGiEd7t/G90HRo5mooQYjrv0yJ/QvxQnmXrxmMV/ed78bd7cltGIBu9Jkn6LQloFsBGxhZBemzeh02sJrz9wJEnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668929; c=relaxed/simple;
	bh=MiSGVhpIQjlXN9JkbotVzlfVE6k2035BwVIFbacwRoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZiT4O1//LBq/D5MPo9iJMWD5nTsAFe4UsvW8Y94rcuOL0onK6dMfY/3XSWq7CAIhHJH80VMYI1N8e+nzcnLbjeyqkeQkv9wcTPF3bwKM1X5frgM7p4tM1B/ICjNo0Y3m9ztgvlDA1AiheTBhEk5wdfm0IDNL6HKmcIhUjFYvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0HiSApT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teCf0CHCppIIE/YdmrDxUHZ2E2wZCqLiu68DZNCBVsI=;
	b=V0HiSApT3DWCyXjyFU3SlfQ5O5ZBO7L9qj4tEIENp4h7EkKJfbk/D/OVxw6Og3bAFXrvir
	b8JPMM3bhBFNPKKuqxzX1ydFDyGiUIGtCsal+xEYRdrd7pF5UAtiZJLZjEr7Qw4BihSbk7
	qgeAPa9NmOI1VgU9w4t0eoVXH2ZbWqg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450--E0U9YgENhabmx4Xl2NvYQ-1; Fri,
 08 Aug 2025 12:02:06 -0400
X-MC-Unique: -E0U9YgENhabmx4Xl2NvYQ-1
X-Mimecast-MFC-AGG-ID: -E0U9YgENhabmx4Xl2NvYQ_1754668925
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEB8B19560B7;
	Fri,  8 Aug 2025 16:02:04 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 570D619560B4;
	Fri,  8 Aug 2025 16:02:02 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v11 4/8] timers: Use scoped_guard when setting/clearing the tmigr available flag
Date: Fri,  8 Aug 2025 18:01:38 +0200
Message-ID: <20250808160142.103852-5-gmonaco@redhat.com>
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
2.50.1


