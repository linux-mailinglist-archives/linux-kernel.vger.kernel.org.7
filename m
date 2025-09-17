Return-Path: <linux-kernel+bounces-821313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28009B80F97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C639154426A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B2334BA3F;
	Wed, 17 Sep 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBtu2n49"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136C34BA28
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126015; cv=none; b=THTVgMOdj1D2H2aNqyd1Mg3/eCbqba7/EZdRRuHHdG4dXFWVzBkppShPT57CqZo1xllhQe2gHbTZc/5SN9gA7kpI2MdelUhl1Su2aZseXCb9JqXgX9TgR9HCSqjajlcq12crhWqCIy+pDLW5AA6EeeXKSSdgVP00U0U9ayFHspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126015; c=relaxed/simple;
	bh=W5HeOLn53bkMXvyginmPkrpggXzunizSPk+ErNBEFcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCk4HE7QM13wjXJNurCf5M6Iy+t3EO9jbDOnufZQGtYnmJyYkoUByWkPWbxhI3opkBTgEUwDZNKFZuRn406WuZPQqCHyB+a3BfevPU+taoq1+oEZ1dUK71EbvoqL9ZwzuZNRqLGb+BDkm2me/Pzssa7WYrznuq3o7iXEjxJwWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBtu2n49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqHoqHbNdw3xd89Dbu+aPXkrTjTEf+IBAZgrCZ/KQ7A=;
	b=IBtu2n49ue7CxLymFzZbpZwjuZ8wq6JpL+6Aeb15r6el2GS+G/MyGSrqEu/5sm5MoQUrU2
	/3Yw7sfSo9Bc/zjNU695DgZrXUybk5xIh9hdEozEXp/QTliCuY6GvyjRn2iHVI0eA5zLrs
	p2s51o78GsWvLVnSk5eALAcXyemWeGw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-PbY6nd8ANyO0UQubl0KB9Q-1; Wed,
 17 Sep 2025 12:20:11 -0400
X-MC-Unique: PbY6nd8ANyO0UQubl0KB9Q-1
X-Mimecast-MFC-AGG-ID: PbY6nd8ANyO0UQubl0KB9Q_1758126011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E212E1956061;
	Wed, 17 Sep 2025 16:20:10 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.34.168])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E2731800446;
	Wed, 17 Sep 2025 16:20:07 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v13 1/9] timers/migration: Postpone online/offline callbacks registration to late initcall
Date: Wed, 17 Sep 2025 18:19:50 +0200
Message-ID: <20250917161958.178925-2-gmonaco@redhat.com>
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


