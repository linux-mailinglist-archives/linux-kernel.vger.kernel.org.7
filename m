Return-Path: <linux-kernel+bounces-821318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DFBB80FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F96C54617D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3C2FABE6;
	Wed, 17 Sep 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3SIiAcf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62C34BA44
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126035; cv=none; b=LGBOkYZAw5WS+BkfsDgg7OFvuuZRe0Xj3ydz7qPmlRNFCCHUhr7nK8K51saFiN+9ub2uARckj4eb4ZL47dXGn+rv6ZDkdtiauAKraZPt8IQRO7uhmn8dd9pQydQEeQy8ZtnE2uNhDR1vsqn5dk/ClRQjOYop/0KqUt9QWkvulPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126035; c=relaxed/simple;
	bh=orl97ADICI4ifLLSRLAlatiFb35y7EONMQ1cCnXv80k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7EHyywKtdYfTR5eY3WDlW2JlExGwX2ZERl6PARFvseEiXWHDH0laS5RiAdlzDTaGw/reqJ8TeEJgKD0WR4JRhehSsAuk3ksyHZShmncfkAjJWLw6HPCfr27OmyP+WAlZEDpWt4Hhi2WCGN81fJsV2UM/0AzOxuW0w9yhynXghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3SIiAcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYezNvw2JXA2eYKqYkaBQbpJb87hLMjOLjuBiAHIOFM=;
	b=b3SIiAcfQ6KH5SB6+NEUNThMuxgIOes9/tqrSI5gpqHF6GacudCJOGS7O7y8+kWilUE1os
	i3byjqfiW1XT12/9CLskEg7kiy5bb2Ad9o8+8WMSPUusmZpYTjU+uRMSBDJ37bsgImuOuk
	GuczUIaMr8l70uMmNHdQpBe7QJztL/M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-gzkUgrX_PCe2YqokXdMzmw-1; Wed,
 17 Sep 2025 12:20:29 -0400
X-MC-Unique: gzkUgrX_PCe2YqokXdMzmw-1
X-Mimecast-MFC-AGG-ID: gzkUgrX_PCe2YqokXdMzmw_1758126028
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BBDC19560B0;
	Wed, 17 Sep 2025 16:20:28 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.34.168])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7DC51800446;
	Wed, 17 Sep 2025 16:20:25 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v13 6/9] sched/isolation: Force housekeeping if isolcpus and nohz_full don't leave any
Date: Wed, 17 Sep 2025 18:19:55 +0200
Message-ID: <20250917161958.178925-7-gmonaco@redhat.com>
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


