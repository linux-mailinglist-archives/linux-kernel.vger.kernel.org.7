Return-Path: <linux-kernel+bounces-768963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F977B26863
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18E15E5D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792973002CA;
	Thu, 14 Aug 2025 13:56:11 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2726AA93
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179771; cv=none; b=noW1bhCZizOx0GJx60RWPWcqs5aglbs73JfRlyYtPNB62rzv+ISPPf0DLok2eu1HIGfntBy5wS+8s2RslEa/Asfk3OImx1SIfjq5dW3G5cuCAWeNmyxM6WPXt68ldM6dh4aFChz7UArUibrLpWDdvdTY2wxQXxeIwwUjAMsLaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179771; c=relaxed/simple;
	bh=A/0/kbVQAaKBR0zTMyp75SlhUpDVp+77Akx0dyB+U6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVcs365RJyNNynqrY6IZXo0JVA8XrSM9nOqi7xv2L9YpNL84hcMamZwWGehcxhSsRiFbRlF5FUu6I4XICF+pGkeGyWP+uP+LbVFEXNJk+FH5fBCUiL39iJnZAcKFrbDoQbyHM19mCH1BSBBhetIWiUSJYWs6HR9QH3tlTfkRGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c2mwm4GfqzYl3br;
	Thu, 14 Aug 2025 21:55:52 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:56:00 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:56:00 +0800
From: <zhongjinji@honor.com>
To: <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <npache@redhat.com>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, <liam.howlett@oracle.com>, <liulu.liu@honor.com>,
	<feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap() traverse the maple tree in opposite orders
Date: Thu, 14 Aug 2025 21:55:55 +0800
Message-ID: <20250814135555.17493-4-zhongjinji@honor.com>
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

When a process is OOM killed, if the OOM reaper and the thread running
exit_mmap() execute at the same time, both will traverse the vma's maple
tree along the same path. They may easily unmap the same vma, causing them
to compete for the pte spinlock. This increases unnecessary load, causing
the execution time of the OOM reaper and the thread running exit_mmap() to
increase.

When a process exits, exit_mmap() traverses the vma's maple tree from low to high
address. To reduce the chance of unmapping the same vma simultaneously,
the OOM reaper should traverse vma's tree from high to low address. This reduces
lock contention when unmapping the same vma.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 include/linux/mm.h | 3 +++
 mm/oom_kill.c      | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0c44bb8ce544..b665ea3c30eb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -923,6 +923,9 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
 #define for_each_vma_range(__vmi, __vma, __end)				\
 	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
 
+#define for_each_vma_reverse(__vmi, __vma)					\
+	while (((__vma) = vma_prev(&(__vmi))) != NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7ae4001e47c1..602d6836098a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -517,7 +517,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
-	VMA_ITERATOR(vmi, mm, 0);
+	VMA_ITERATOR(vmi, mm, ULONG_MAX);
 
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -527,7 +527,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
-	for_each_vma(vmi, vma) {
+	/*
+	 * When two tasks unmap the same vma at the same time, they may contend for the
+	 * pte spinlock. To avoid traversing the same vma as exit_mmap unmap, traverse
+	 * the vma maple tree in reverse order.
+	 */
+	for_each_vma_reverse(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
-- 
2.17.1


