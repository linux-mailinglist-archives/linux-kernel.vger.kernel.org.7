Return-Path: <linux-kernel+bounces-760549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B370B1ECBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B6D3B3BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03CA286D73;
	Fri,  8 Aug 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/+OEdTI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E25286D4C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668923; cv=none; b=QMQIdOfs9cxecKvWEseXh62SZXtIu6oyq3OOnrukCyUASsUd6gEp7Q2ZS/ZVKiGrHr1y0347ushCDQBZfFOf55XsoYWiFVcPEvnkUjJI821jeuZ8WQZmitVWQO4LxhcpxH2huXDb4B/Z/K97A/H9m9PHyk41O+KsVt18yK3dN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668923; c=relaxed/simple;
	bh=pLkk/xB0dwo+lNyUQVEDrFt25PvjFPrhzyY2G2IQp0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ay1eHYpk5ji5n6JqtmzWnu0gKMVV774iFsTv27iQfi7FffcCP5x5dnFhSp5ql5oPHFHXO2YkQZZrJMoPcI2rV82kcs8HiX8CiaAqUt/TJ4xBeGZYJFpcslTMjWTURR2ypCS169JmEme2S4kMuu/ERcNW3UOwQ75QYLnWZ3lQKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/+OEdTI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754668920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBP+YEyXnVSx7jUIe5PVTnEUQI1eAU0N4X7j80FcQNs=;
	b=R/+OEdTIfSV+gY4l1hLQq2tFdCOQjmX9DsiijTU8/+ywro4pvbAPXIGlMf0EZH9ji7RTSc
	ih2/ZzAQcJrYX8PK0ukaKyWh9VBXOydJQwcM8JNKd6wCvuYTAexSAKi7AVozyzVW+YtkMR
	pMVlUV//bJIw4tTmaLPD1cQfAWYTOCk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-1EtG_xG8NTO_0EQyw3dhlA-1; Fri,
 08 Aug 2025 12:01:56 -0400
X-MC-Unique: 1EtG_xG8NTO_0EQyw3dhlA-1
X-Mimecast-MFC-AGG-ID: 1EtG_xG8NTO_0EQyw3dhlA_1754668914
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B557219560B1;
	Fri,  8 Aug 2025 16:01:54 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AE2119560AD;
	Fri,  8 Aug 2025 16:01:51 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v11 1/8] timers/migration: Postpone online/offline callbacks registration to late initcall
Date: Fri,  8 Aug 2025 18:01:35 +0200
Message-ID: <20250808160142.103852-2-gmonaco@redhat.com>
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
2.50.1


