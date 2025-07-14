Return-Path: <linux-kernel+bounces-730085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AEB0401C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A4A3AB135
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9C25392B;
	Mon, 14 Jul 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McAiQOEE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8F253355
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499901; cv=none; b=WJGhBC+kkgjhhnOqB08QOFW2xDL/U0MYmfukKufyd9HFnkzvzFYmUB4JeOUxoz7ibApVXTOGoccHmYxxZy5yCH9fFHartiAhOOur7xDITW/sLeX29fAM4hKkJc1WPhjPAQ/FTp7HO3YG4zu+gf7io7HqzML4+qxozH+fHhdzbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499901; c=relaxed/simple;
	bh=XeR3NZnzEJKohf+OVTLlSRfcDeUpF8sJXusd/tzTygo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DL4fPBqk89FITlNjgujsFPHPDArh+s/q8eV1Z9EV3U9MDjh7IF19rUBc8dTq0L+11E1o1H0UJyJNeavweKVrKhGfYmL9RXSYvFT/JaAYve4uy7s6tdhggRNEESN48wYucj2+zCmb+V9KI+N6on96Q4cNsoJFjHSHlNqvnANtPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=McAiQOEE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZTPF3l0qa4HyWG5G3v3ZEYXFoCmq4Dm+Ob1JvupEs0=;
	b=McAiQOEEFrSHtT2G4nsJ7Q0MQ81t7juEy7qG0aF5GR7xlR3OTARebDVsXFNpEN9S7yot1H
	ve/VwIYpwYMcjykIHSkqU33aILCDrazaP0XY707yT65ReBdIy2nnnr4iqpJzqOkUc5Yrw1
	leh+o2V9gpbvU4bx0QPYrPygBcLfezE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-_AmWqVsEM3CXezJ0hhZM2g-1; Mon,
 14 Jul 2025 09:31:32 -0400
X-MC-Unique: _AmWqVsEM3CXezJ0hhZM2g-1
X-Mimecast-MFC-AGG-ID: _AmWqVsEM3CXezJ0hhZM2g_1752499890
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0872D180121B;
	Mon, 14 Jul 2025 13:31:30 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.225.215])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 245A219560A3;
	Mon, 14 Jul 2025 13:31:26 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v8 2/7] timers: Add the available mask in timer migration
Date: Mon, 14 Jul 2025 15:30:53 +0200
Message-ID: <20250714133050.193108-11-gmonaco@redhat.com>
In-Reply-To: <20250714133050.193108-9-gmonaco@redhat.com>
References: <20250714133050.193108-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Keep track of the CPUs available for timer migration in a cpumask. This
prepares the ground to generalise the concept of unavailable CPUs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/time/timer_migration.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 2c2c8810b8137..b4623ac3c2830 100644
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
 
@@ -1446,6 +1452,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	int migrator;
 	u64 firstexp;
 
+	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	tmc->available = false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
@@ -1459,7 +1466,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {
-		migrator = cpumask_any_but(cpu_online_mask, cpu);
+		migrator = cpumask_any(tmigr_available_cpumask);
 		work_on_cpu(migrator, tmigr_trigger_active, NULL);
 	}
 
@@ -1474,6 +1481,7 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	if (WARN_ON_ONCE(!tmc->tmgroup))
 		return -EINVAL;
 
+	cpumask_set_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	trace_tmigr_cpu_available(tmc);
 	tmc->idle = timer_base_is_idle();
@@ -1801,6 +1809,11 @@ static int __init tmigr_init(void)
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
2.50.1


