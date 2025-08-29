Return-Path: <linux-kernel+bounces-791229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C7B3B3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7037B3999
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B12609E3;
	Fri, 29 Aug 2025 06:56:06 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454D260569
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450566; cv=none; b=R5rb4kiN80ZDEI92n/zZNXaw4DDgdNGFA8ZRpCMWfFRiO/ND1aDobPQSUVLsj86R1YW/saXpOIweJTR5E/TUw9vVB1amOEVsZNiBdQINPGAftoIu0hV8+CUesX8eWno2Nixf5BYU/LuRU2lUlb31/tMZKLFVEZc4mf9YRzOT2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450566; c=relaxed/simple;
	bh=zaLRGrfm2rVJ5FM30v0HBC/REj93fkh++zzN1nEPBR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az1/PZSY8EwzwBxa9EyYxHA/T4864dDMwrFZV3f2tfI3X0ZKdX+mqseGg724wISBpJM+oczwSwmUAnWdDit3PtXp1g9gHzDb7mCVvIuGAgDeaGk2AbQpbqAfFCBzBQw5l92wXIGQN2nOx6nyUUVGhDNfbelDfCreDYPjKzaBVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cCptx6T7YzYnQcn;
	Fri, 29 Aug 2025 14:55:37 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 29 Aug
 2025 14:55:56 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 29 Aug
 2025 14:55:55 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<liam.howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <surenb@google.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <tianxiaobin@honor.com>,
	<fengbaopeng@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v6 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Fri, 29 Aug 2025 14:55:50 +0800
Message-ID: <20250829065550.29571-3-zhongjinji@honor.com>
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

When a process is OOM killed without reaper delay, the oom reaper and the
exit_mmap() thread likely run simultaneously. They traverse the vma's maple
tree along the same path and may easily unmap the same vma, causing them to
compete for the pte spinlock.

When a process exits, exit_mmap() traverses the vma's maple tree from low
to high addresses. To reduce the chance of unmapping the same vma
simultaneously, the OOM reaper should traverse the vma's tree from high to
low address.

Reported-by: tianxiaobin <tianxiaobin@honor.com>
Reported-by: fengbaopeng <fengbaopeng@honor.com>

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index a5e9074896a1..01665a666bf1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
-	VMA_ITERATOR(vmi, mm, 0);
+	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
 
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -526,7 +526,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
-	for_each_vma(vmi, vma) {
+	/*
+	 * When two tasks unmap the same vma at the same time, they may contend
+	 * for the pte spinlock. To reduce the probability of unmapping the same vma
+	 * as exit_mmap, the OOM reaper traverses the vma maple tree in reverse order.
+	 */
+	mas_for_each_rev(&mas, vma, 0) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
-- 
2.17.1


