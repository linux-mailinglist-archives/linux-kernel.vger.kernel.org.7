Return-Path: <linux-kernel+bounces-817249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFCDB57FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804281887EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DED01DF755;
	Mon, 15 Sep 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxEuTA62"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CB3376BC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948400; cv=none; b=FRFEI3PpKariggqVuQiK1RT4rR9JkaR9JXp+WcHPk0fG5HHtM0cnviH0/JaYLc5Ay+yldYPsTly/fq6ZxxuZXUd8owggb1cQbX972rAYDyKIhJjv0iJ9V9TMeCEMP8egOI2rkN6FQfaGy8cB0Vz8XkbmPy7jycweb8X1zronnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948400; c=relaxed/simple;
	bh=W5HeOLn53bkMXvyginmPkrpggXzunizSPk+ErNBEFcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfukrODS/Kl3lvPhuLesVv1w90EDqqsb1rv+kNLc7rn4RVq88Bq4xsNit9/tMxPWdKNLE+C0pTGx/hB6xX3ed/TH+MfkJlvivsNW229/68KO7ogoYNTtAENr8X/yghUNHcQTjIqG1FYaVzRsXUGMTeWqyAh7Ccsl/XH46dGl3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxEuTA62; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757948398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqHoqHbNdw3xd89Dbu+aPXkrTjTEf+IBAZgrCZ/KQ7A=;
	b=ZxEuTA62N8mXVfCRIr1zpDZZqrkww7gtBtCqOSjsjioDD8zb46rgwaLT8MBoyjzGmO7i0j
	h5JAEEOPrWdrRfqqQHxcFB8OQBrZSf0ceplSeA9tgUMR7RvwiyGyZqZ40FZqA7en0isR+n
	Wwmlk1/PXWoaWNYU7GZJjMBghyM8ow4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-P7BWnZZBME22xg8ozkWN_A-1; Mon,
 15 Sep 2025 10:59:56 -0400
X-MC-Unique: P7BWnZZBME22xg8ozkWN_A-1
X-Mimecast-MFC-AGG-ID: P7BWnZZBME22xg8ozkWN_A_1757948395
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70F2219560BD;
	Mon, 15 Sep 2025 14:59:55 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 096371800447;
	Mon, 15 Sep 2025 14:59:52 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v12 1/9] timers/migration: Postpone online/offline callbacks registration to late initcall
Date: Mon, 15 Sep 2025 16:59:22 +0200
Message-ID: <20250915145920.140180-12-gmonaco@redhat.com>
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

From: Frederic Weisbecker <frederic@kernel.org>

During the early boot process, the default clocksource used for
timekeeping is the jiffies. Better clocksources can only be selected
once clocksource_done_booting() is called as an fs initcall.

NOHZ can only be enabled after that stage, making global timer migration
irrelevant up to that point.

The tree remains inactive before NOHZ is enabled anyway. Therefore it
makes sense to enable each CPUs to the tree only once that is setup.

Make the CPUs available to the tree on late initcall, after the right
clocksource had a chance to be selected. This will also simplify the
handling of domain isolated CPUs on further patches.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/time/timer_migration.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c..891891794b92 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1481,6 +1481,16 @@ static int tmigr_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * NOHZ can only be enabled after clocksource_done_booting(). Don't
+ * bother trashing the cache in the tree before.
+ */
+static int __init tmigr_late_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
+				 tmigr_cpu_online, tmigr_cpu_offline);
+}
+
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 			     int node)
 {
@@ -1843,18 +1853,10 @@ static int __init tmigr_init(void)
 
 	ret = cpuhp_setup_state(CPUHP_TMIGR_PREPARE, "tmigr:prepare",
 				tmigr_cpu_prepare, NULL);
-	if (ret)
-		goto err;
-
-	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				tmigr_cpu_online, tmigr_cpu_offline);
-	if (ret)
-		goto err;
-
-	return 0;
-
 err:
-	pr_err("Timer migration setup failed\n");
+	if (ret)
+		pr_err("Timer migration setup failed\n");
 	return ret;
 }
 early_initcall(tmigr_init);
+late_initcall(tmigr_late_init);
-- 
2.51.0


