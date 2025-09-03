Return-Path: <linux-kernel+bounces-798143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37AB419F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62A81BA3853
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA02F1FE2;
	Wed,  3 Sep 2025 09:27:44 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042D221DB0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891664; cv=none; b=pTnjEfP0os0I7oTww702KfPv2HIQ09f7j/ebUJEwS17dAOfeBUnzDpyYFQY1uUviqyM8s5y7jSep67Xb3ZWxJ20vEm6ho2todBqxdt9iKCo/EVVRifh6rHAGwCFgxfwwPgJTaADdHtNSINVf0WAgph5CBh6cGhZODm28FGrDHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891664; c=relaxed/simple;
	bh=2TDTI2DLCHGnqpyU8fQGydM2aIdUyXchqVmxGSuJAKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCtepFtn3JZpcBE1gWFjAJE9b+RVlH9S/7zj1qZCNgn6xWbzR12r1gcZeaxJV1L72IYc2FH105ZKdsXbU4u8tBZLvFNxyQssVmG08H5RzD4EAJKHYohJQhrQSPKqUwxw6eGxO7eI/0Ed6iPmmpK53ZM8wuDsDyQCKQD/SboPqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cGy1X44FPzYlBd5;
	Wed,  3 Sep 2025 17:27:12 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 17:27:33 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 17:27:33 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<liam.howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <surenb@google.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v7 1/2] mm/oom_kill: Thaw victim on a per-process basis instead of per-thread
Date: Wed, 3 Sep 2025 17:27:28 +0800
Message-ID: <20250903092729.10611-2-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250903092729.10611-1-zhongjinji@honor.com>
References: <20250903092729.10611-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

OOM killer is a mechanism that selects and kills processes when the system
runs out of memory to reclaim resources and keep the system stable.
However, the oom victim cannot terminate on its own when it is frozen,
because __thaw_task() only thaws one thread of the victim, while
the other threads remain in the frozen state.

This change will thaw the entire victim process when OOM occurs,
ensuring that the oom victim can terminate on its own.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..3caaafc896d4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -747,6 +747,19 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
 }
 #endif /* CONFIG_MMU */
 
+static void thaw_oom_process(struct task_struct *tsk)
+{
+	struct task_struct *t;
+
+	/* protects against  __exit_signal() */
+	read_lock(&tasklist_lock);
+	for_each_thread(tsk, t) {
+		set_tsk_thread_flag(t, TIF_MEMDIE);
+		__thaw_task(t);
+	}
+	read_unlock(&tasklist_lock);
+}
+
 /**
  * mark_oom_victim - mark the given task as OOM victim
  * @tsk: task to mark
@@ -772,12 +785,12 @@ static void mark_oom_victim(struct task_struct *tsk)
 		mmgrab(tsk->signal->oom_mm);
 
 	/*
-	 * Make sure that the task is woken up from uninterruptible sleep
+	 * Make sure that the process is woken up from uninterruptible sleep
 	 * if it is frozen because OOM killer wouldn't be able to free
 	 * any memory and livelock. freezing_slow_path will tell the freezer
-	 * that TIF_MEMDIE tasks should be ignored.
+	 * that TIF_MEMDIE threads should be ignored.
 	 */
-	__thaw_task(tsk);
+	thaw_oom_process(tsk);
 	atomic_inc(&oom_victims);
 	cred = get_task_cred(tsk);
 	trace_mark_victim(tsk, cred->uid.val);
-- 
2.17.1


