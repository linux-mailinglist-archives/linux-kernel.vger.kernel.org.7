Return-Path: <linux-kernel+bounces-733294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA61B072CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE5B1883323
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946F2F2C73;
	Wed, 16 Jul 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6MuuFJ5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCE2F237C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660693; cv=none; b=ROjTAokrg0abDmohEnZOmZ694qux/bHxS+D/zz2QvAlQaBX5j2NrvRzKFH3rq2YNP3bveBZhtL5y1it5hkFpsdhjxsX2FJw46LrDSVH+obIp7q1Rej0jCDl/5pcrHZWms6fQWLsM4ZhmIXKi8IcL3Wt1CA/ghAVqLMkBPzG3238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660693; c=relaxed/simple;
	bh=o1/AKsAod3qhHfWeqSNpW0eXQWlwOb6RTPxwPMJ9Zf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ritSFAPSF8TvFtsrPRcF/5i3SB7Ty/mpxHLB/L/HRVzKa+4NTdncX/RCq5ztitPQoB9rSL76rZ5u6MowOGV0a838M7CMhsIPYGl4TuJvh8hVUKCp1gVzQJModgSRX0oIGiUQsem6WG9KdKOn6WqOYtxaVQYlXeJcii0QrE6ElMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6MuuFJ5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G2Yjcn021407;
	Wed, 16 Jul 2025 10:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qlVMBSoAKAV3ZLCq/
	elqR8ug2aXypYqt0+SoYH1BTfo=; b=P6MuuFJ58ikkuwHCg99lwut2Oe8QOQorx
	ZKXvBg3HXiUyAQzU6ldNHNwXq/cl5QZJn5dJlahJsfS3SoE0DfOiHx8PoOXB48H3
	WMwvZ6JahofMdnRdOZYV7sZ1mNG5r9YjNpPIDgqw6DHh4yCeMMLINkH/PiANBCl/
	JS1sevwpWXc25MtmQySPz4x7u5ukh+ZroP4dFJPA6a5P4cZK3B/XWUXzuy7SgdLO
	ixw9pZ+a34gDH+l+v9vReUl8jVo2rlcQQs75DQY5H2OTzirxAI7dW/pXDWFt5PKm
	hGpegPU6ET9b1SSu0hv8irOYoGX6MBB6L2vT1ou/ete55VYjkxQKw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmqauv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:10:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G8655W021906;
	Wed, 16 Jul 2025 10:10:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r36hkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:10:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GAAnkX45744638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:10:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 842D62047A;
	Wed, 16 Jul 2025 09:48:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4920620482;
	Wed, 16 Jul 2025 09:48:17 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.218.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 09:48:17 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        maddy@linux.ibm.com, will@kernel.org
Cc: sshegde@linux.ibm.com, mark.rutland@arm.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/1] sched: preempt: Move dynamic keys into kernel/sched
Date: Wed, 16 Jul 2025 15:17:45 +0530
Message-ID: <20250716094745.2232041-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250716094745.2232041-1-sshegde@linux.ibm.com>
References: <20250716094745.2232041-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gq97XSCKcToF5b6WRzBPRAVHPG_-14_x
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=68777ab1 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=0m2VAjjhUuEpGUOKPk8A:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: gq97XSCKcToF5b6WRzBPRAVHPG_-14_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4NyBTYWx0ZWRfXw7ndK0ZQXDH2 ghCKkgp5E/Dae8Xrw4l24Emp4ArfkcBCFm6gQYLqE0W+ruZ3hRwjSsPg+igxNkQTLfLZheDA0RZ lL2GvmWAvhvo+7v/ffD2MPgCX8NS7mej/gcbpg0iwEFnJU0uGUrKe/0AXJMf9zECM21tt9mUSnB
 HUqfOwnPscEYsakoEI3+9vm1CxjeQAi+HaZ8lcFg3JJGsknP6iCGCzSmMLWdZh9B7FiOkNIt+70 IQ52wU0OHcVZj+BNI+dG2uoo3vYgk5NLD3BNd1lHLOO0DPjmDrlFFN18tCRCEfZ+WGDyH5j866S OLodTOvz/FgzzFI7hvCrx+KPVs/n915DYdQLl9V8n+BC3YOyvUOr8x9Vy6gjaZpyi5N+nxziGem
 ffZvirmUkqSHa3r1l+WpVoBNjEhwtXDjCxsPtvphtKyObScTYUAspie9DwAB63/9RHx3ZjDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160087

Dynamic preemption can be static key or static call based.
Static key is used to check kernel preemption depending on
the current preemption model. i.e enable for lazy, full. 

Code is currently spread across entry/common.c, arm64 and latest being
powerpc. There is little arch specific to it. arm64, powerpc have the
same code. It is better to move it into kernel/sched since preemption 
is more closely associated with scheduler.  

Plus, Any new arch that wants dynamic preemption enabled need to have 
only HAVE_PREEMPT_DYNAMIC_KEY. 

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 arch/arm64/include/asm/preempt.h   |  1 -
 arch/arm64/kernel/entry-common.c   |  8 --------
 arch/powerpc/include/asm/preempt.h | 16 ----------------
 arch/powerpc/kernel/interrupt.c    |  4 ----
 include/linux/irq-entry-common.h   |  1 -
 include/linux/sched.h              |  8 ++++++++
 kernel/entry/common.c              |  1 -
 kernel/sched/core.c                |  4 ++++
 8 files changed, 12 insertions(+), 31 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/preempt.h

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 0159b625cc7f..a9348e65d75e 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -87,7 +87,6 @@ void preempt_schedule_notrace(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_preempt_schedule(void);
 #define __preempt_schedule()		dynamic_preempt_schedule()
 void dynamic_preempt_schedule_notrace(void);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 7c1970b341b8..f4985ae4d8a9 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -259,14 +259,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#define need_irq_preemption() \
-	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-#else
-#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
-#endif
-
 static void __sched arm64_preempt_schedule_irq(void)
 {
 	if (!need_irq_preemption())
diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
deleted file mode 100644
index 000e2b9681f3..000000000000
--- a/arch/powerpc/include/asm/preempt.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_POWERPC_PREEMPT_H
-#define __ASM_POWERPC_PREEMPT_H
-
-#include <asm-generic/preempt.h>
-
-#if defined(CONFIG_PREEMPT_DYNAMIC)
-#include <linux/jump_label.h>
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#define need_irq_preemption() \
-	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-#else
-#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
-#endif
-
-#endif /* __ASM_POWERPC_PREEMPT_H */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index e0c681d0b076..4d62d785ad26 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -25,10 +25,6 @@
 unsigned long global_dbcr0[NR_CPUS];
 #endif
 
-#if defined(CONFIG_PREEMPT_DYNAMIC)
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#endif
-
 #ifdef CONFIG_PPC_BOOK3S_64
 DEFINE_STATIC_KEY_FALSE(interrupt_exit_not_reentrant);
 static inline bool exit_must_hard_disable(void)
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 8af374331900..5bb752f0a69c 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -343,7 +343,6 @@ void raw_irqentry_exit_cond_resched(void);
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_irqentry_exit_cond_resched(void);
 #define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 54a91261e99b..df9a87de0f83 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2076,6 +2076,14 @@ static inline int _cond_resched(void)
 
 #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
 
+#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+#define need_irq_preemption() \
+	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+#else
+#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
+#endif
+
 #define cond_resched() ({			\
 	__might_resched(__FILE__, __LINE__, 0);	\
 	_cond_resched();			\
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index b82032777310..0ffe3d5a6c44 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -157,7 +157,6 @@ void raw_irqentry_exit_cond_resched(void)
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_irqentry_exit_cond_resched(void)
 {
 	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c73c9ca6ca01..8425008c99f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6999,6 +6999,10 @@ EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
 
 #endif /* CONFIG_PREEMPTION */
 
+#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+#endif
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of IRQ context.
-- 
2.43.0


