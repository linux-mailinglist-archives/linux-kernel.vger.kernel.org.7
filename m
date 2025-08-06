Return-Path: <linux-kernel+bounces-757548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F59B1C377
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077AC7A419D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E18328A706;
	Wed,  6 Aug 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9G+LHXp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0428A406
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473158; cv=none; b=Y/t5+hYgOxyw2kcE2BoYMW4iK5/1Dr6wfNmBTDjMSndJHcPt28omEe2qRRz4H/8laTBpnLOtpNY3ReZbUsEmHkwy/vyZUW5L4+osavo7gZev/amEl6yzIkyBGHvpajbHdjC4emE27cCB3+PZcji6Qt7p3aHMURoiRxQqW7W0F9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473158; c=relaxed/simple;
	bh=dzphjO/XH5mpfwewleznZjBQDK2wTt9cJNxDCg1iR2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwSsoSMCftl0OjCXiIO1pl4NAR0bDyJW0OSotE8ED3uWP+SF2eTHzgtFDANUQ8VY3FEh/qIWs2HfReWK3y80VtDVP3xB1ZvQ1Wn49cz4skndvjf5TBdwLq4Q/I1e1yMIntkdfrXIpINCKwDAMMnlRtr62LmHTnHIKnJv9UTHDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9G+LHXp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754473154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dFmTBAK5e28d1SFufaXHR10WXD/bQd9Cmo3nhugP2Y=;
	b=K9G+LHXp9e7vfeSCn6YpvyEpIDOV5QemU9WHwiA5aauMX9YYQkctqGnaBxVMxyqfzG0mH0
	P5WjjqYYyM3rqLKy/Hi4Nl4Zj+P6mOBIDm41FnEwQe8zcirNMNY2DJZ4VvzJuDRtLxr6rN
	pqDGjXj+11oi+2ox3iyXGCvun4Ih1Yo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-wvIf0g3mO--YY-sjZ_o_eA-1; Wed,
 06 Aug 2025 05:39:11 -0400
X-MC-Unique: wvIf0g3mO--YY-sjZ_o_eA-1
X-Mimecast-MFC-AGG-ID: wvIf0g3mO--YY-sjZ_o_eA_1754473150
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 008D1195608F;
	Wed,  6 Aug 2025 09:39:10 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69BB11800446;
	Wed,  6 Aug 2025 09:39:07 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v10 1/8] timers/migration: Postpone online/offline callbacks registration to late initcall
Date: Wed,  6 Aug 2025 11:38:48 +0200
Message-ID: <20250806093855.86469-2-gmonaco@redhat.com>
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

From: Frederic Weisbecker <frederic@kernel.org>

During the early boot process, the default clocksource used for
timekeeping is the jiffies. Better clocksources can only be selected
once clocksource_done_booting() is called as an fs initcall.

NOHZ can only be enabled after that stage, making global timer migration
irrelevant up to that point.

Therefore, don't bother with trashing the cache within that tree from
the SMP bootup until NOHZ even matters.

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


