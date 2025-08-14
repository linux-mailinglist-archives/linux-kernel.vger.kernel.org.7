Return-Path: <linux-kernel+bounces-768964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9AB26860
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35195E5FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7DF301479;
	Thu, 14 Aug 2025 13:56:12 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3252FE054
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179772; cv=none; b=DuscrF2OdqQ6eJfBorRSyPxF/uK8hPqmRq+BLXIDYGcX9fsvjA/SgkUXFTLT6HdDnV78eJyMImDsLbgtGegKWRd0krE88YF2VyFZBzk0YmeQWcEoOX/bRSxJYEPPp9t7+98WikOG/idexAS7LmrQzm9XncpbDpaqhukIUVltDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179772; c=relaxed/simple;
	bh=2qSTqKgAiQDfLqRBh2lVVrFNo/uyUMPLEYEWg2jiGM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhBV/IZO0LA2eRJig7UHzHsnsRlABdNua8tzBb0PV3p0uUEegXW62kCaDjEdgS8Chz0bZ49ifRrOdV/WiEPJfDqGNffcgxH7lFn1bbukgjZJn50vjTnmapPOUt5J2WZa3Oqu/8Lhlus6eOca1AZiq4+b2De30thBjGj93NQln00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c2mwm1WGfzYl2mK;
	Thu, 14 Aug 2025 21:55:52 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:56:00 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:55:59 +0800
From: <zhongjinji@honor.com>
To: <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <npache@redhat.com>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, <liam.howlett@oracle.com>, <liulu.liu@honor.com>,
	<feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v4 1/3] futex: Introduce function process_has_robust_futex()
Date: Thu, 14 Aug 2025 21:55:53 +0800
Message-ID: <20250814135555.17493-2-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250814135555.17493-1-zhongjinji@honor.com>
References: <20250814135555.17493-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

From: zhongjinji <zhongjinji@honor.com>

When the holders of robust futexes are OOM killed but the waiters on robust
futexes are still alive, the robust futexes might be reaped before
futex_cleanup() runs. This can cause the waiters to block indefinitely [1].
To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1].
However, the OOM reaper now rarely runs since many killed processes exit
within 2 seconds.

Because robust futex users are few, delay the reaper's execution only for
processes holding robust futexes to improve the performance of the OOM
reaper.

Introduce the function process_has_robust_futex() to detect whether a process
uses robust futexes. If each thread's robust_list in a process is NULL, it
means the process holds no robust futexes. Conversely, it means the process
holds robust futexes.

Link: https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u [1]

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 include/linux/futex.h |  5 +++++
 kernel/futex/core.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f04980..39540b7ae2a1 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -81,6 +81,7 @@ void futex_exec_release(struct task_struct *tsk);
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
+bool process_has_robust_futex(struct task_struct *tsk);
 
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
@@ -108,6 +109,10 @@ static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsig
 {
 	return -EINVAL;
 }
+static inline bool process_has_robust_futex(struct task_struct *tsk)
+{
+	return false;
+}
 static inline int futex_hash_allocate_default(void)
 {
 	return 0;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d9bb5567af0c..01b6561ab4f6 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1961,6 +1961,36 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 	return ret;
 }
 
+/*
+ * process_has_robust_futex() - check whether the given task hold robust futexes.
+ * @p: task struct of which task to consider
+ *
+ * If any thread in the task has a non-NULL robust_list or compat_robust_list,
+ * it indicates that the task holds robust futexes.
+ */
+bool process_has_robust_futex(struct task_struct *tsk)
+{
+	struct task_struct *t;
+	bool ret = false;
+
+	rcu_read_lock();
+	for_each_thread(tsk, t) {
+		if (unlikely(t->robust_list)) {
+			ret = true;
+			break;
+		}
+#ifdef CONFIG_COMPAT
+		if (unlikely(t->compat_robust_list)) {
+			ret = true;
+			break;
+		}
+#endif
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static int __init futex_init(void)
 {
 	unsigned long hashsize, i;
-- 
2.17.1


