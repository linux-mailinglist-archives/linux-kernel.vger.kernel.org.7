Return-Path: <linux-kernel+bounces-860740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE3BF0D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A24F3158
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02A2FB967;
	Mon, 20 Oct 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PedvWSxZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0F2F83C3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959698; cv=none; b=D2s9PZqt+FkjG7+EL9FAZxhDD/NfulNAGp9v6wGmDBvU6EelgcGSV2wahOlWqkbndYComrXRKKWV2mkPfj5TbixEoNWVHF6DpDVr+VP7vqr6+SjjVxZBBZNGyrWmjIiGgQqAo0uPEBZS765TV7+QGRCcHqMDkEjwJz8IDs2F23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959698; c=relaxed/simple;
	bh=W5HeOLn53bkMXvyginmPkrpggXzunizSPk+ErNBEFcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB7oy6FeUKBos9sdDIlAEuONcIHAiZhHaWjMuY6u714tsy9q2pOzCdX+94ecPDAvdJcjm+iZIeJM3JzL1m6a53mutwTY3jCIrqpEICtubuLuI1NrFKtDoD5LyVFDKIOUXRVIHOCkcRHj788cx++qJ3t9oq7NDnO173EYAjCmPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PedvWSxZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760959696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqHoqHbNdw3xd89Dbu+aPXkrTjTEf+IBAZgrCZ/KQ7A=;
	b=PedvWSxZ5cQiFuzfKGVMMehcDNzXOnISjQFibmbAUFSFpfKab+41JuGRG/P/PsEQh8LB1f
	Zvek4O9Qj4ckPf0rj9di+OEjU1FgaF0jhdKT/AEgpXYSp+lRPbt59ipljiFB95ts2jpj+Y
	rKmRvl2H322Z4USes/HBHDOk26Gc3JE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-5ryGBWUBOmizyaOEvgBxHA-1; Mon,
 20 Oct 2025 07:28:12 -0400
X-MC-Unique: 5ryGBWUBOmizyaOEvgBxHA-1
X-Mimecast-MFC-AGG-ID: 5ryGBWUBOmizyaOEvgBxHA_1760959691
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF19B19560B5;
	Mon, 20 Oct 2025 11:28:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BF311955F1B;
	Mon, 20 Oct 2025 11:28:08 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [RESEND PATCH v13 1/9] timers/migration: Postpone online/offline callbacks registration to late initcall
Date: Mon, 20 Oct 2025 13:27:54 +0200
Message-ID: <20251020112802.102451-2-gmonaco@redhat.com>
In-Reply-To: <20251020112802.102451-1-gmonaco@redhat.com>
References: <20251020112802.102451-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


