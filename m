Return-Path: <linux-kernel+bounces-884612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0C4C3095C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B46189F114
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B62DAFAE;
	Tue,  4 Nov 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeAbVQKw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1D2D3755
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253305; cv=none; b=dk3dNnQXuD3vXVnLzeLxDvKwt90sW4F0frPs5sIniJLSmt0vkHEA9Y2oCsNsT3RLdsWwj76VvlTaGQELUpkxZb10RFbGU1QnIoQqB57qa1OPA74wHaCeliYv9ef9kIVrMGn1eERkN7aVK1Skl2Uvd/b0gPWBmIQH4U4hNZpIQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253305; c=relaxed/simple;
	bh=UdZrEQBNfVSuL5oJU5DsXZIaqdz4BTglc4rb2YVQ1l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrjv/3tNuJ5ijnLbSAL4t3dQiapYFBIR8h5w56crUsVSdbawA4yg/xV9Tm+oprVaeQIRb+Ke4ZchZX4LAKFpDjm0gtTevyeEyf/iJi0DFf7hbTHx6N0BXfMprnsjJuJkh3k1yWPUV6D+Xx+saaikhXoeYQfn8N0ExP7F4JyXoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeAbVQKw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762253301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkLNdHUD5n1+RkotxZadgogxcEkXIbgXh7NIwL2Goc0=;
	b=SeAbVQKwW491yvysIC30LfY5q1mNBl8d030DHP9+RfL3fe0OPaEZwZkdbtd1mEQj0uYiAt
	NUMgx3eEKGKEkAO8H/BBMslT5YfDaKhGeOtVtXSqtzd/1Lou4r+KuNolj7x6mIKCpW8u2O
	+czKsvOVRjw1OJaXDE9h0nqomIBLEzU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-nTvIQILyM2iTSQYJKgqlVQ-1; Tue,
 04 Nov 2025 05:48:18 -0500
X-MC-Unique: nTvIQILyM2iTSQYJKgqlVQ-1
X-Mimecast-MFC-AGG-ID: nTvIQILyM2iTSQYJKgqlVQ_1762253297
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DFED1956052;
	Tue,  4 Nov 2025 10:48:17 +0000 (UTC)
Received: from eda-pc.redhat.com (unknown [10.45.224.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F142180057B;
	Tue,  4 Nov 2025 10:48:14 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <llong@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v14 3/7] timers: Use scoped_guard when setting/clearing the tmigr available flag
Date: Tue,  4 Nov 2025 11:47:35 +0100
Message-ID: <20251104104740.70512-4-gmonaco@redhat.com>
In-Reply-To: <20251104104740.70512-1-gmonaco@redhat.com>
References: <20251104104740.70512-1-gmonaco@redhat.com>
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
index 39f734dbbb0fc..99503d34f151d 100644
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
2.43.0


