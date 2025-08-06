Return-Path: <linux-kernel+bounces-757551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1F7B1C37A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8918A2EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BAE28B3FD;
	Wed,  6 Aug 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKTAAhR4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2728A1E6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473166; cv=none; b=Em93K9/qgPoLEQ4EkGq31VPGyDKFPqA+O62h2812pxy7fEh4Mo7JA+YRj0vfHopQ2UYPuluIQQX0UjoeihMvZB/+SxdIQx2BZkMaO3ADbRzDtkYSFTO24hbh545IFA9ZtLgRfyWThSa2HslIbPskcCp2JBxkUtunN2BUVCvroLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473166; c=relaxed/simple;
	bh=MiSGVhpIQjlXN9JkbotVzlfVE6k2035BwVIFbacwRoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFjMVDUZtN8FyVgQB68HVMGFDWWcBmoTauAns0sw6ihzuMDzyRq9Pc36/I/aff81oefBWPnizX5pVB/Cs2bH8bLPjZF+2RGVkAu1fdEaQqIgSvWs1pXBzd1u/8AowXRK5buvr+MFM+vQwgPisxsKJ9+24o8hUufKO5Fv09k8w1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKTAAhR4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754473163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teCf0CHCppIIE/YdmrDxUHZ2E2wZCqLiu68DZNCBVsI=;
	b=YKTAAhR4CAK2eSlQcm6SXBgpIngNCnQluIXffy3Zo0JYsBb3OFbru+nQGzLo4ARJgl4Hnb
	crcKnMwqmdQNBpbhUe8hJmdbMepDcc0o7cCf+kO1UPd9hV8wK6yQsaEt3E+Kgl5wQRN4KV
	7bHsrZJe6Zl1SKjPg8iD0Pk7Ix0nWUw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-KJAH6uKYPkCeHPKYTQ2Xrg-1; Wed,
 06 Aug 2025 05:39:20 -0400
X-MC-Unique: KJAH6uKYPkCeHPKYTQ2Xrg-1
X-Mimecast-MFC-AGG-ID: KJAH6uKYPkCeHPKYTQ2Xrg_1754473159
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94D2619560AA;
	Wed,  6 Aug 2025 09:39:19 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AA981800446;
	Wed,  6 Aug 2025 09:39:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v10 4/8] timers: Use scoped_guard when setting/clearing the tmigr available flag
Date: Wed,  6 Aug 2025 11:38:51 +0200
Message-ID: <20250806093855.86469-5-gmonaco@redhat.com>
In-Reply-To: <20250806093855.86469-1-gmonaco@redhat.com>
References: <20250806093855.86469-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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


