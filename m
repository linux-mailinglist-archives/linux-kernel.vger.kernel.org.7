Return-Path: <linux-kernel+bounces-757553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563EB1C37F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DC2188BDAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B128B511;
	Wed,  6 Aug 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQX9ISRL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6F28B7C2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473174; cv=none; b=j3GqFdvmWHaHeObaYHztDHL2YL7BLV7culVOcVARHUaKTuFfq020Ypb7d0S5wkBZPHyr5Yscph/zFdI4h4h1iTtx2P5ROxjsYanRva5u+64Sur+XCwvnrpQQt2DqW1zolJ66OPFA3jk5OMVMCozARYBGQyjlc7DQ94g65UrW/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473174; c=relaxed/simple;
	bh=h8XNOggJ4J79JZ6BAnaBb7IQ4FdUTQtcb4Y9fTXyj+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prINFqCq8+kP1eRcCfUzCBnK/m0kXO6Brq0yQEudcFzWznC3tcDxGNrcb7Ua6DYk1TF9VSXhRlrm5VnhnkCTxzCQ6Mv18Bgxepe9TR43e++SuxxV/+ZXA6DN6mgSnvYB30VMdDE+gwZxme2h9XlyCYnhPwPn+9bUqGJYrbYzUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQX9ISRL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754473171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/iy7OCh32FBZCNmBHQsT+SwnOX4MJIRF8yuLtEQGIc=;
	b=OQX9ISRLLds23FbaaBDcvaEkYZvYtT+O7Tw1iZj4WBUw89f8MMCgYSSslTLcmFNQvW5l0+
	pqichj97DbK+uq0jx1PHwYQa458UI9q2mLL39a0qLUVAtz7buQ0e3gE0enqLyJgTFZooGq
	LFHAn9wPOFyzS0zoOdNZt8+KslM+7o4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-_J_7cYq0N_ayUCpTlgbCdQ-1; Wed,
 06 Aug 2025 05:39:28 -0400
X-MC-Unique: _J_7cYq0N_ayUCpTlgbCdQ-1
X-Mimecast-MFC-AGG-ID: _J_7cYq0N_ayUCpTlgbCdQ_1754473167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62BC81800293;
	Wed,  6 Aug 2025 09:39:27 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C57D91800280;
	Wed,  6 Aug 2025 09:39:23 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v10 6/8] sched/isolation: Force housekeeping if isolcpus and nohz_full don't leave any
Date: Wed,  6 Aug 2025 11:38:53 +0200
Message-ID: <20250806093855.86469-7-gmonaco@redhat.com>
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

Currently the user can set up isolcpus and nohz_full in such a way that
leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
nor nohz full). This can be a problem for other subsystems (e.g. the
timer wheel imgration).

Prevent this configuration by invalidating the last setting in case the
union of isolcpus (domain) and nohz_full covers all CPUs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/isolation.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b1fab0..0bf7b91684c0 100644
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
+		first_cpu = type == HK_TYPE_MAX || !iter_flags ? 0 :
+			    cpumask_first_and_and(cpu_present_mask,
+				    housekeeping_staging, housekeeping.cpumasks[type]);
+		if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
+			pr_warn("Housekeeping: must include one present CPU "
+				"neither in nohz_full= nor in isolcpus=domain, "
+				"ignoring setting %s\n", str);
+			goto free_housekeeping_staging;
+		}
+
 		iter_flags = flags & ~housekeeping.flags;
 
 		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
-- 
2.50.1


