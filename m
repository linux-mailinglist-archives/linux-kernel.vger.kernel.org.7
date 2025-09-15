Return-Path: <linux-kernel+bounces-817254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11CFB57FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFDE1888098
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39AD343D8D;
	Mon, 15 Sep 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw/uQZm+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2534321A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948424; cv=none; b=TYa+sdxjnrFPkbgcrVp5xIGET+YHk03vQkyGvLSvJl1LuOxPO++fV7BsK+A0HpTndQn04jFwbAh1/Dk9E5XxbIYNotuVU+OwJ5rcusklgCetj3RR5m+7Npj47DDg05Mly0Myfmc+hOt4tjhG0/50Q6ewvbZy1Um49WqwAUZd0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948424; c=relaxed/simple;
	bh=orl97ADICI4ifLLSRLAlatiFb35y7EONMQ1cCnXv80k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGOLc92cN1+h2Bq8wW/jEbjYHlpa41LlY6/IE+knDp+2irtoOir6I8bevDi3KWHkppQ4q6jljFGY+bPLl+GAZiOLutVLNK6iFxJC2eHcnWoEapyslR2HCaPiJROoOK/72X1hpEu0t4mEHWN1yNYJ8MkslQ7eBTMQ5Sya0i5LXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw/uQZm+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757948421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYezNvw2JXA2eYKqYkaBQbpJb87hLMjOLjuBiAHIOFM=;
	b=gw/uQZm+J6Ns2m/RLDIymcbBkNrc07JU7NDhVdrOPMA82qcZvUjrwxfi28+tuz8MJn4lyw
	B1vdNKYemHHAWkobvBaxdsKEixYhQ+/QJD25ILsGEQPAAI+xGDQOzknCInXKFtQIfiGFf3
	x5+DAEQwdTtrfpEp1KUXAaI7jbmPo6E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-a8maHv_bMTi7j2ShgmnP9w-1; Mon,
 15 Sep 2025 11:00:17 -0400
X-MC-Unique: a8maHv_bMTi7j2ShgmnP9w-1
X-Mimecast-MFC-AGG-ID: a8maHv_bMTi7j2ShgmnP9w_1757948415
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BCCE180057A;
	Mon, 15 Sep 2025 15:00:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F66B1800447;
	Mon, 15 Sep 2025 15:00:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v12 6/9] sched/isolation: Force housekeeping if isolcpus and nohz_full don't leave any
Date: Mon, 15 Sep 2025 16:59:27 +0200
Message-ID: <20250915145920.140180-17-gmonaco@redhat.com>
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

Currently the user can set up isolcpus and nohz_full in such a way that
leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
nor nohz full). This can be a problem for other subsystems (e.g. the
timer wheel imgration).

Prevent this configuration by invalidating the last setting in case the
union of isolcpus (domain) and nohz_full covers all CPUs.

Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/isolation.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b1fab0..3ad0d6df6a0a 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -167,6 +167,29 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 			}
 		}
 
+		/*
+		 * Check the combination of nohz_full and isolcpus=domain,
+		 * necessary to avoid problems with the timer migration
+		 * hierarchy. managed_irq is ignored by this check since it
+		 * isn't considered in the timer migration logic.
+		 */
+		iter_flags = housekeeping.flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN);
+		type = find_first_bit(&iter_flags, HK_TYPE_MAX);
+		/*
+		 * Pass the check if none of these flags were previously set or
+		 * are not in the current selection.
+		 */
+		iter_flags = flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN);
+		first_cpu = (type == HK_TYPE_MAX || !iter_flags) ? 0 :
+			    cpumask_first_and_and(cpu_present_mask,
+				    housekeeping_staging, housekeeping.cpumasks[type]);
+		if (first_cpu >= min(nr_cpu_ids, setup_max_cpus)) {
+			pr_warn("Housekeeping: must include one present CPU "
+				"neither in nohz_full= nor in isolcpus=domain, "
+				"ignoring setting %s\n", str);
+			goto free_housekeeping_staging;
+		}
+
 		iter_flags = flags & ~housekeeping.flags;
 
 		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
-- 
2.51.0


