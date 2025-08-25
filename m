Return-Path: <linux-kernel+bounces-784783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9CB340ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7301789ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964C278146;
	Mon, 25 Aug 2025 13:39:13 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A33265CB3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129153; cv=none; b=hSxcaLWX1UP2g8Wwv0zuyoEOM12SEvvkoJG2obopV7vG3ARIVLSHSDylZMJjDKlNmA5UmlRbCJceSTKn6Mxj2DCKf0FbUlQ4OPpqSOzpYM+um3+aiofYdkkX8jKuLRS1PLS83lK2DK3hGUnsczv17jo7CCkvhmajl0/m5iwmeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129153; c=relaxed/simple;
	bh=1p2jpTVGNFS2EQACkqUgkD3BGqkqBt+R/ZdIMHBLkjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utKeajHNnBSABYkqhCucyfR3uwZspFAeR8eY5eimMsodTMk56CkEUDRNPOmRrSpIrKmI8MOAGd8snI9ePEBS4U4GjdX3myUVeBhCQpU17ka29O3T5LAoCVXhCSLuute9/akBbCnsyb9/U5CdPfygWFX9DhN0f+Go0m/FmlAAj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c9X1w3NcXzYkyN7;
	Mon, 25 Aug 2025 21:38:44 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 21:39:00 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 21:38:59 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<liam.howlett@oracle.com>, <lorenzo.stoakes@oracle.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v5 1/2] mm/oom_kill: Do not delay oom reaper when the victim is frozen
Date: Mon, 25 Aug 2025 21:38:54 +0800
Message-ID: <20250825133855.30229-2-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250825133855.30229-1-zhongjinji@honor.com>
References: <20250825133855.30229-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

The OOM reaper can quickly reap a process's memory when the system
encounters OOM, helping the system recover. If the victim process is
frozen and cannot be unfrozen in time, the reaper delayed by two seconds
will cause the system to fail to recover quickly from the OOM state.

When an OOM occurs, if the victim is not unfrozen, delaying the OOM reaper
will keep the system in a bad state for two seconds. Before scheduling the
oom_reaper task, check whether the victim is in a frozen state. If the
victim is frozen, do not delay the OOM reaper.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..4b4d73b1e00d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -683,6 +683,41 @@ static void wake_oom_reaper(struct timer_list *timer)
 	wake_up(&oom_reaper_wait);
 }
 
+/*
+ * When the victim is frozen, the OOM reaper should not be delayed, because
+ * if the victim cannot be unfrozen promptly, it may block the system from
+ * quickly recovering from the OOM state.
+ */
+static bool should_delay_oom_reap(struct task_struct *tsk)
+{
+	struct mm_struct *mm = tsk->mm;
+	struct task_struct *p;
+	bool ret;
+
+	if (!mm)
+		return true;
+
+	if (!frozen(tsk))
+		return true;
+
+	if (atomic_read(&mm->mm_users) <= 1)
+		return false;
+
+	rcu_read_lock();
+	for_each_process(p) {
+		if (!process_shares_mm(p, mm))
+			continue;
+		if (same_thread_group(tsk, p))
+			continue;
+		ret = !frozen(p);
+		if (ret)
+			break;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /*
  * Give the OOM victim time to exit naturally before invoking the oom_reaping.
  * The timers timeout is arbitrary... the longer it is, the longer the worst
@@ -694,13 +729,16 @@ static void wake_oom_reaper(struct timer_list *timer)
 #define OOM_REAPER_DELAY (2*HZ)
 static void queue_oom_reaper(struct task_struct *tsk)
 {
+	bool delay;
+
 	/* mm is already queued? */
 	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
 		return;
 
 	get_task_struct(tsk);
+	delay = should_delay_oom_reap(tsk);
 	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
-	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
+	tsk->oom_reaper_timer.expires = jiffies + (delay ? OOM_REAPER_DELAY : 0);
 	add_timer(&tsk->oom_reaper_timer);
 }
 
-- 
2.17.1


