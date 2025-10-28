Return-Path: <linux-kernel+bounces-872992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF075C12CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B8464011
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBF283CAF;
	Tue, 28 Oct 2025 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAmm2afQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1328000B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623069; cv=none; b=E2WfV5CNpsugEL5DpvwTVzKy5EcGIxl6F8xTeK4itacCqmOIG0INM1Yyt2bcCX7H92DmH7BjRGl4Fg8ZpYwyv9rL2DnNc+DnuLZ3DzThkxAFyxLQnm6Oy3W8xfqNOCAWyaodg8xfKnQZ16jVJq6wgLyKWc+m4vlxg1UiqMU6E74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623069; c=relaxed/simple;
	bh=DrgFTN5SAKh1Fi518Ox7qnPVRMAh1FKtSR4SGg3S7ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHf3j2h9lLbXJUDW1TdWJfTeLnEtS//yEI4bbyeEgq+5bM9gAmpoMZflusHSVHptNF5VyJAIbucCn1NJ/OI1VC8kNZisjgySgg3juCd7o1WVDwTCGkzdxe8cwWp7zkA2q8MXA/yBmP1dBtNTldkp934BJ5J2mk3tobnoNpLgQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAmm2afQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761623066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YbJLFPX9piCwEK2blMA45kr+K/vXcoXA84QV3H2W/so=;
	b=iAmm2afQP29hBk69S0u+/Vu876+l2mZg97xWtzL/r30FDwr57NhnKage3eMdm/R0eu90C2
	TyRjHmULSx0YReEWWdfJoN3N1b+Yk7lQTjPWiFXgJFBn5toMymabeYjDmSRfjtqgkVEPdU
	k0P1pugDckbWcwjn4cKk2lDXFGpCrOA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-P8pfH06LM26kc7LKxAegMA-1; Mon,
 27 Oct 2025 23:44:24 -0400
X-MC-Unique: P8pfH06LM26kc7LKxAegMA-1
X-Mimecast-MFC-AGG-ID: P8pfH06LM26kc7LKxAegMA_1761623063
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B167119541AD;
	Tue, 28 Oct 2025 03:44:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08EE81800451;
	Tue, 28 Oct 2025 03:44:18 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCHv4 1/2] sched/isolation: Split out the housekeeping part
Date: Tue, 28 Oct 2025 11:43:55 +0800
Message-ID: <20251028034357.11055-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A later patch will introduce a function in cpuset.h that refers to
definitions in isolation.h. This would cause a circular header file
inclusion issue.  To break the cycle, move the definitions into a
dedicated file called 'housekeeping.h'."

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
To: linux-kernel@vger.kernel.org
---
 include/linux/sched/housekeeping.h | 67 ++++++++++++++++++++++++++++++
 include/linux/sched/isolation.h    | 65 +----------------------------
 2 files changed, 68 insertions(+), 64 deletions(-)
 create mode 100644 include/linux/sched/housekeeping.h

diff --git a/include/linux/sched/housekeeping.h b/include/linux/sched/housekeeping.h
new file mode 100644
index 0000000000000..99cfc8821a814
--- /dev/null
+++ b/include/linux/sched/housekeeping.h
@@ -0,0 +1,67 @@
+#ifndef _LINUX_SCHED_HOUSEKEEPING_H
+#define _LINUX_SCHED_HOUSEKEEPING_H
+
+enum hk_type {
+	HK_TYPE_DOMAIN,
+	HK_TYPE_MANAGED_IRQ,
+	HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_MAX,
+
+	/*
+	 * The following housekeeping types are only set by the nohz_full
+	 * boot commandline option. So they can share the same value.
+	 */
+	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
+};
+
+#ifdef CONFIG_CPU_ISOLATION
+DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
+extern int housekeeping_any_cpu(enum hk_type type);
+extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
+extern bool housekeeping_enabled(enum hk_type type);
+extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
+extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
+extern void __init housekeeping_init(void);
+
+#else
+
+static inline int housekeeping_any_cpu(enum hk_type type)
+{
+	return smp_processor_id();
+}
+
+static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
+{
+	return cpu_possible_mask;
+}
+
+static inline bool housekeeping_enabled(enum hk_type type)
+{
+	return false;
+}
+
+static inline void housekeeping_affine(struct task_struct *t,
+				       enum hk_type type) { }
+
+static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
+{
+	return true;
+}
+
+static inline void housekeeping_init(void) { }
+#endif /* CONFIG_CPU_ISOLATION */
+
+static inline bool housekeeping_cpu(int cpu, enum hk_type type)
+{
+#ifdef CONFIG_CPU_ISOLATION
+	if (static_branch_unlikely(&housekeeping_overridden))
+		return housekeeping_test_cpu(cpu, type);
+#endif
+	return true;
+}
+#endif
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d8501f4709b58..e07b2c439365d 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -5,70 +5,7 @@
 #include <linux/cpuset.h>
 #include <linux/init.h>
 #include <linux/tick.h>
-
-enum hk_type {
-	HK_TYPE_DOMAIN,
-	HK_TYPE_MANAGED_IRQ,
-	HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_MAX,
-
-	/*
-	 * The following housekeeping types are only set by the nohz_full
-	 * boot commandline option. So they can share the same value.
-	 */
-	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
-};
-
-#ifdef CONFIG_CPU_ISOLATION
-DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
-extern int housekeeping_any_cpu(enum hk_type type);
-extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
-extern bool housekeeping_enabled(enum hk_type type);
-extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
-extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
-extern void __init housekeeping_init(void);
-
-#else
-
-static inline int housekeeping_any_cpu(enum hk_type type)
-{
-	return smp_processor_id();
-}
-
-static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
-{
-	return cpu_possible_mask;
-}
-
-static inline bool housekeeping_enabled(enum hk_type type)
-{
-	return false;
-}
-
-static inline void housekeeping_affine(struct task_struct *t,
-				       enum hk_type type) { }
-
-static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
-{
-	return true;
-}
-
-static inline void housekeeping_init(void) { }
-#endif /* CONFIG_CPU_ISOLATION */
-
-static inline bool housekeeping_cpu(int cpu, enum hk_type type)
-{
-#ifdef CONFIG_CPU_ISOLATION
-	if (static_branch_unlikely(&housekeeping_overridden))
-		return housekeeping_test_cpu(cpu, type);
-#endif
-	return true;
-}
+#include <linux/sched/housekeeping.h>
 
 static inline bool cpu_is_isolated(int cpu)
 {
-- 
2.49.0


