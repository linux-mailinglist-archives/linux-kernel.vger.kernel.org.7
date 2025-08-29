Return-Path: <linux-kernel+bounces-791231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB611B3B3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3497E16F8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24179263C9E;
	Fri, 29 Aug 2025 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="efQSuI55"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB3260590
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450570; cv=none; b=WznsY254cXFcWPM4fNwRacuIQSMW0p5dPxUfZ7bKMpVkwbdgV/n0E6REQe46hqjKNjcqFshQeRXefydAxdFFzdf3/63b5lYmo2Ac1Eb0BWD9bDgs2Vy5bjg73HKN2FZNq37mvmQrIlPyjVPRfboxmsN+H4xNZTS0m48po7HdO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450570; c=relaxed/simple;
	bh=KG/7twUkQWo224PrkroO9mfMaZC393EpvmJz7SsJLnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DExQjeSHP59dQXigXU5qvVpHTZTtcF51tSIagO2i1TaqWAlsB3s0nbKV8yBB4dTMMQnzXym+cbm9VgNbXUhIXNnnBwbAwy+5L5CgpyBC8GyYl5xLvjphCbzk9sG7Y8gaDK6iOZ4KaGj3dbUcTyfwBLi5i0SjEySWPXzUQxfKrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=efQSuI55; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=8XiR1glQQMxhqQ2yDLpSdiuzwavHhKmoaPSOcnK0KdY=;
	b=efQSuI55EPjgLOtZF/+TWbBl7H2uPLBno5fBnBEbi0eDgbrTmxcsUnMTthMNoOuiSBljLKS92
	OGmO1TBaHImgiEk8jygM5rUKBWLAHHOmR4ZWgRVkM8kePlPezdVw+RGN2A9jHHWcvpEe42orskY
	8ICPSxcIwqcZfnNe8ukdS9Y=
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cCpv369CkzYlbJG;
	Fri, 29 Aug 2025 14:55:43 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 29 Aug
 2025 14:55:56 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 29 Aug
 2025 14:55:54 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<liam.howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <surenb@google.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <tianxiaobin@honor.com>,
	<fengbaopeng@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the victim is frozen
Date: Fri, 29 Aug 2025 14:55:49 +0800
Message-ID: <20250829065550.29571-2-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250829065550.29571-1-zhongjinji@honor.com>
References: <20250829065550.29571-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a018.hihonor.com
 (10.68.17.250)

The oom reaper is a mechanism to guarantee a forward process during OOM
situation when the oom victim cannot terminate on its own (e.g. being
blocked in uninterruptible state or frozen by cgroup freezer). In order
to give the victim some time to terminate properly the oom reaper is
delayed in its invocation. This is particularly beneficial when the oom
victim is holding robust futex resources as the anonymous memory tear
down can break those. [1]

On the other hand deliberately frozen tasks by the freezer cgroup will
not wake up until they are thawed in the userspace and delay is
effectively pointless. Therefore opt out from the delay for cgroup
frozen oom victims.

Reference:
[1] https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..a5e9074896a1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -700,7 +700,14 @@ static void queue_oom_reaper(struct task_struct *tsk)
 
 	get_task_struct(tsk);
 	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
-	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
+	tsk->oom_reaper_timer.expires = jiffies;
+
+	/*
+	 * If the task is frozen by the cgroup freezer, the delay is unnecessary
+	 * because it cannot exit until thawed. Skip the delay for frozen victims.
+	 */
+	if (!frozen(tsk))
+		tsk->oom_reaper_timer.expires += OOM_REAPER_DELAY;
 	add_timer(&tsk->oom_reaper_timer);
 }
 
-- 
2.17.1


