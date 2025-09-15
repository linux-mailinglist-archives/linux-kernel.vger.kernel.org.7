Return-Path: <linux-kernel+bounces-817251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0079B57FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389567A314D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EDC341ABA;
	Mon, 15 Sep 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1wk+RMp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADEC329F00
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948410; cv=none; b=TvccChzD7nA+t1cTbhauGWM2IZJqdVvhbpVcZqvw6hgzubFhhxZmjXGjm8S6Kiijz9ReM2k3DQdMSBfyrWMT+Bg16aqRu7LaEd6qzwajdGMwLwmCwo9KQ9RyAxh6jabVbVPhW4ag9+PHX01H83kbo1MO900GmX6TEE+7FO2bZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948410; c=relaxed/simple;
	bh=s6DRgB4ZQLXuz3fHRKmP5K1mXf4BGuPX0q56iGqgbA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfDoTnZzPteC9uoZglPCl9i+GMXPe5UUA3lDNue7pPyG8Q5k+gg7UW/hFNhLvAtfRoVmRfPb3u04/WsuDII6DnpsPb45byCyrdi65vGyPIuGv5BTuuF/xvsvt/kEbeA7ao0GJjjFVCB+qXzyj0DjC9oquAsDIBcIw9QpkTyEVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1wk+RMp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757948408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEaNsn6JuCXOUjQ0A/OCwJlHT770BY8Sx/uuyjZom0E=;
	b=A1wk+RMptX87SZas2YQFtFiHaFS/6BdzR0SlymtC3i4lZQM1IL3YGeNli6pCIkeJp1MNXm
	bFXal3OTI1Kv/N1lE9/298TqNScqaPvTJDYUJV3wevDRMPdGbK1TBtUgE3OQFazN1EzGJk
	4v45+7eKUxJVIq3ghRptWK0lOfsqdtg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-4INGbQaEObe7N7MYmbroIQ-1; Mon,
 15 Sep 2025 11:00:04 -0400
X-MC-Unique: 4INGbQaEObe7N7MYmbroIQ-1
X-Mimecast-MFC-AGG-ID: 4INGbQaEObe7N7MYmbroIQ_1757948403
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A91DF180029D;
	Mon, 15 Sep 2025 15:00:03 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 034681800446;
	Mon, 15 Sep 2025 15:00:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v12 3/9] timers: Add the available mask in timer migration
Date: Mon, 15 Sep 2025 16:59:24 +0200
Message-ID: <20250915145920.140180-14-gmonaco@redhat.com>
In-Reply-To: <20250915145920.140180-11-gmonaco@redhat.com>
References: <20250915145920.140180-11-gmonaco@redhat.com>
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
index 55b186fd146c..865071ab5062 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -422,6 +422,12 @@ static unsigned int tmigr_crossnode_level __read_mostly;
 
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
+/*
+ * CPUs available for timer migration.
+ * Protected by cpuset_mutex (with cpus_read_lock held) or cpus_write_lock.
+ */
+static cpumask_var_t tmigr_available_cpumask;
+
 #define TMIGR_NONE	0xFF
 #define BIT_CNT		8
 
@@ -1443,6 +1449,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	int migrator;
 	u64 firstexp;
 
+	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	tmc->available = false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
@@ -1456,7 +1463,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {
-		migrator = cpumask_any_but(cpu_online_mask, cpu);
+		migrator = cpumask_any(tmigr_available_cpumask);
 		work_on_cpu(migrator, tmigr_trigger_active, NULL);
 	}
 
@@ -1471,6 +1478,7 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	if (WARN_ON_ONCE(!tmc->tmgroup))
 		return -EINVAL;
 
+	cpumask_set_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	trace_tmigr_cpu_available(tmc);
 	tmc->idle = timer_base_is_idle();
@@ -1808,6 +1816,11 @@ static int __init tmigr_init(void)
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
2.51.0


