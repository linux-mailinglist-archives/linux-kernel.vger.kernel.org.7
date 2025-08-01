Return-Path: <linux-kernel+bounces-753616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A64B18553
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6753B1D90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E6286438;
	Fri,  1 Aug 2025 15:57:11 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF318285C91
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063830; cv=none; b=i3W2In7kaQi795XOpFLU0B+Sp1PcJtEe2Te2ySj1YElhuJG441/KCGftHKORdr8wBZKrAklUzRCP32S90V7CaPRmiR8w9zFk14qrhwNQNc9U2dK7ysY0FXdg6mbycPiEvWShGG1XWr79UZOcd5AMr7j/0ivMEC8Ui55Ykmrwq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063830; c=relaxed/simple;
	bh=Q5dU1rqvjfMzw7Os4fhyVtY9ZTVLB+/utaAuGRjH04I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOiq5ntNJkLA+DMLM2W9mBqmUCwZaDZz3P+FmPDmJZCOW9fJdtk9cYppplU36kbuttvX4ftiw5u5ZQJCk24OWci5t4PxmLfUHOE9k69+P/T+xPFUDoJagTmEiJUGoTKqWjsFX9k47B7caepcqicHMC+SUdsfnt3DjSMwuUz9D4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4btqkB3KDJzYm1CN;
	Fri,  1 Aug 2025 23:34:10 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Aug
 2025 23:36:53 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Aug
 2025 23:36:53 +0800
From: <zhongjinji@honor.com>
To: <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <npache@redhat.com>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, <liulu.liu@honor.com>, <feng.han@honor.com>
Subject: [[PATCH v2] 1/2] futex: Add check_robust_futex to verify process usage of robust_futex
Date: Fri, 1 Aug 2025 23:36:48 +0800
Message-ID: <20250801153649.23244-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a018.hihonor.com
 (10.68.17.250)

From: zhongjinji <zhongjinji@honor.com>

The check_robust_futex function is added to detect whether a process uses
robust_futex.

According to the patch discussion
(https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u),
executing the OOM reaper too early on processes using robust_futex may cause
the lock holder to wait indefinitely.

Therefore, this patch introduces check_robust_futex to identify such
processes during OOM reaper execution, and delays the OOM reaper specifically
for processes using robust_futex.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 include/linux/futex.h | 11 ++++++++++-
 kernel/futex/core.c   | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f04980..b3ce7424609d 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -81,7 +81,8 @@ void futex_exec_release(struct task_struct *tsk);
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
-
+bool check_robust_futex(struct task_struct *p);
+bool __check_robust_futex(struct task_struct *p);
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
@@ -108,6 +109,14 @@ static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsig
 {
 	return -EINVAL;
 }
+static inline bool check_robust_futex(struct task_struct *p)
+{
+	return false;
+}
+static inline bool __check_robust_futex(struct task_struct *p)
+{
+	return false;
+}
 static inline int futex_hash_allocate_default(void)
 {
 	return 0;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d9bb5567af0c..6cd385a62455 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1513,6 +1513,31 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
 
+bool __check_robust_futex(struct task_struct *p)
+{
+	struct task_struct *t;
+
+	for_each_thread(p, t) {
+		if (unlikely(t->robust_list))
+			return true;
+#ifdef CONFIG_COMPAT
+		if (unlikely(t->compat_robust_list))
+			return true;
+#endif
+	}
+	return false;
+}
+
+bool check_robust_futex(struct task_struct *p)
+{
+	bool has_robust;
+
+	rcu_read_lock();
+	has_robust = __check_robust_futex(p);
+	rcu_read_unlock();
+	return has_robust;
+}
+
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 				   struct futex_private_hash *fph)
 {
-- 
2.17.1


