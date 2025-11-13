Return-Path: <linux-kernel+bounces-898915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895BC564DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 597B9341704
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87308333438;
	Thu, 13 Nov 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egswddKi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EF332EA4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022827; cv=none; b=JUacuSUIGV1sb82WfwaeCy/z0qHqrzqKopxS3PbNRkkAVQO3MdK/wLNFjEqb8QOp2XVgqepKVso/1k0DeGTR2TXqo+6AoUofOU22EfKj3hZDw0KIIWsDpcviZTd9KRZboAl1Z7MfIyET9AqmTUok5a7XIQSzu5CHe74+9A1FRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022827; c=relaxed/simple;
	bh=O1KLHjYyILsWNv0K23ER9A6a+JvFFdfln/M3/tEcAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ0Gwjc2Nf5lxhvD9eu5EmSF7y2vfR6e4YVAQvcTqRj8Mc5zNW29S8i7fksIg0eowkheV1IU+q/ogulI3HPcLuepgTJH5mDkUL57DXHSBY+owD5TSOuyMd2Vmt/Ug5KFcyEpUgkSBIT0GlD5wDm+soH69Zd6Fn44Rh6S9IBynOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egswddKi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763022824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXhcZhl0rUC9KYFyXlp7d+uvpM1hOj1o/nbf926Nj30=;
	b=egswddKiypYw4ZDq3pUHBNzIURTAPGT6v+v0OfqzHbeCEOGPye/Z9+NKrxeh312hhxQ+Kh
	SpsKWkHI8kiwT6ZnBhUjUYrudZANV3z/D1zcgF073CCPwnfZI7aNcyWakwVCGn9BX7pt63
	shYvbA89tEJF5q5Aajfi9JMDIbf7HLA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-yH7VvIzhPB2Ny0d2-tj1qw-1; Thu,
 13 Nov 2025 03:33:40 -0500
X-MC-Unique: yH7VvIzhPB2Ny0d2-tj1qw-1
X-Mimecast-MFC-AGG-ID: yH7VvIzhPB2Ny0d2-tj1qw_1763022819
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA46B180045C;
	Thu, 13 Nov 2025 08:33:39 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10E511800451;
	Thu, 13 Nov 2025 08:33:36 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v15 2/7] timers: Add the available mask in timer migration
Date: Thu, 13 Nov 2025 09:33:19 +0100
Message-ID: <20251113083324.33490-3-gmonaco@redhat.com>
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

Keep track of the CPUs available for timer migration in a cpumask. This
prepares the ground to generalise the concept of unavailable CPUs.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/time/timer_migration.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d50514062a06..b8f07e4f59a6 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -424,6 +424,12 @@ static struct tmigr_group *tmigr_root;
 
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
+/*
+ * CPUs available for timer migration.
+ * Protected by cpuset_mutex (with cpus_read_lock held) or cpus_write_lock.
+ */
+static cpumask_var_t tmigr_available_cpumask;
+
 #define TMIGR_NONE	0xFF
 #define BIT_CNT		8
 
@@ -1433,6 +1439,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	int migrator;
 	u64 firstexp;
 
+	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	tmc->available = false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
@@ -1446,7 +1453,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {
-		migrator = cpumask_any_but(cpu_online_mask, cpu);
+		migrator = cpumask_any(tmigr_available_cpumask);
 		work_on_cpu(migrator, tmigr_trigger_active, NULL);
 	}
 
@@ -1461,6 +1468,7 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	if (WARN_ON_ONCE(!tmc->tmgroup))
 		return -EINVAL;
 
+	cpumask_set_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	trace_tmigr_cpu_available(tmc);
 	tmc->idle = timer_base_is_idle();
@@ -1805,6 +1813,11 @@ static int __init tmigr_init(void)
 	if (ncpus == 1)
 		return 0;
 
+	if (!zalloc_cpumask_var(&tmigr_available_cpumask, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	/*
 	 * Calculate the required hierarchy levels. Unfortunately there is no
 	 * reliable information available, unless all possible CPUs have been
-- 
2.51.1


