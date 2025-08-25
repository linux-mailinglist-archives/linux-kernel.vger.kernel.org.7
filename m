Return-Path: <linux-kernel+bounces-784781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6BB340EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6862D3B9ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7A272811;
	Mon, 25 Aug 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="VlsDG2Id"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2A21257E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129151; cv=none; b=B0wB+BN48jxxdAQaZdyTBElCeFaN6WlGtEXkn2F9m7YjBvMoE0GKRehRia2SDd6vgRWdfPXoDxPEi3Zi4/zbiH9yRGaW8xOwv4kXuL2ngUbr/D8S+y/RfwlBYdxrnjF/jbgAujlHIDwvg+WJ7ThAswZB6lmEm+kmcOpyOsfy/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129151; c=relaxed/simple;
	bh=qVrwTRMzbhTLZFTNdYyUte8sJMxlT3Z3KdDa9Fqp9oM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ME7pKxIrYTf2PS1aDWl6Tt7u/Mbfv8OIOab0FAHYUryrt7q/uJUsFC/BgBhK/xZK62VKYMmES1ONu3KBWP6QIMvS7eIklsjV5s3MJt9hgyZz2DmjiEqQ/FFujxCgZbR1mLpa103oNal0ll5QMrCmSahfH7vskwo8s5+y+6BJnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=VlsDG2Id; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=e01QAR5JDTSQnGFTtnf/BBtTF0FubM4Lr4gx30e0yhI=;
	b=VlsDG2IdtAp/2hZRJLYa/Soo4y4Mt+Q+DsvVy3NkT4QDTVovF8ZwtjyYebt3Ukp/hh6zQTr7V
	rp/sWixZspUkFeZa96Q+7HKRIcPxBJWExNPi4yQFnHUonoxJcnf1BjKlzDBSRIEzWz2n9xbWCpJ
	PPCTuy3Z1XiVPexTiHP2WKk=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c9X213dMPzYkxf9;
	Mon, 25 Aug 2025 21:38:49 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 21:39:00 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 21:39:00 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<liam.howlett@oracle.com>, <lorenzo.stoakes@oracle.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap() traverse the maple tree in opposite order
Date: Mon, 25 Aug 2025 21:38:55 +0800
Message-ID: <20250825133855.30229-3-zhongjinji@honor.com>
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

When a process is OOM killed without reaper delay, the oom reaper and the
exit_mmap() thread likely run simultaneously. They traverse the vma's maple
tree along the same path and may easily unmap the same vma, causing them to
compete for the pte spinlock.

When a process exits, exit_mmap() traverses the vma's maple tree from low
to high addresses. To reduce the chance of unmapping the same vma
simultaneously, the OOM reaper should traverse the vma's tree from high to
low address.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 4b4d73b1e00d..a0650da9ec9c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
-	VMA_ITERATOR(vmi, mm, 0);
+	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, 0);
 
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -526,7 +526,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
-	for_each_vma(vmi, vma) {
+	/*
+	 * When two tasks unmap the same vma at the same time, they may contend for the
+	 * pte spinlock. To reduce the probability of them unmapping the same vma, the
+	 * oom reaper traverse the vma maple tree in reverse order.
+	 */
+	while ((vma = mas_find_rev(&mas, 0)) != NULL) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
-- 
2.17.1


