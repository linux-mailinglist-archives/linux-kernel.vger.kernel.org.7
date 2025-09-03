Return-Path: <linux-kernel+bounces-798142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677DAB419F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2228F680B02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AEE2853F7;
	Wed,  3 Sep 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="cQw7X1Jq"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2890221DB0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891658; cv=none; b=hgpWznWvjaUWegR+r3jUID7+OMwNXORnbT3sdk1FpgxYpehoc2xWUG5EdQgBVMm+v3+Bjk52q8OFx+RhemVtA+8NHJHp6H2wrDypaKyXF5GC6dOhLOZC9sDkQ9GQf+Dv5TDyUmAJsHkhVh+LL4c9c7zQrjT3lbqS2RmkobQG7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891658; c=relaxed/simple;
	bh=qgbsyweIz0AfflDUBDRZEvg2PL8Y2IvPqdgBGb0n6Zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8+ZqVExQA73WPUL4K9xAm1qJeZhyvGGvBYqFBmk/grWMljuut0fEf+CJMISR46OBRN67JwZmlAT3fK0tCp7JKyqh/Ii1H7LDH8un3shkJlHtccI0SGhlHY7CAqVPkL7GtpMM+Ag17NJaJRvdKAKMHwZQlZSt/Ey/nbh64jkuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=cQw7X1Jq; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=r/uDUbzgtgsxWzj8Cop4+zLnEzwH2RYL27BPHIa6ZCs=;
	b=cQw7X1Jq2Xu+J4D6Zyt/8T0P6nCWF3oej7qVCUJgXulRFneyvMt5DR7J9q1t7nYhpz2Wm9EBP
	6gG0WS87WbWdNEYsQyIc42Zg052Z5ZThHtm32MGNDnQxj1RmzoeYVNKu1otjb8W4WmimcZcD/7+
	Cq7kReGDau7TK7hFwkUtTM8=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cGy1g4kKqzYnw7d;
	Wed,  3 Sep 2025 17:27:19 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 17:27:34 +0800
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
Subject: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Wed, 3 Sep 2025 17:27:29 +0800
Message-ID: <20250903092729.10611-3-zhongjinji@honor.com>
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

Although the oom_reaper is delayed and it gives the oom victim chance to
clean up its address space this might take a while especially for
processes with a large address space footprint. In those cases
oom_reaper might start racing with the dying task and compete for shared
resources - e.g. page table lock contention has been observed.

Reduce those races by reaping the oom victim from the other end of the
address space.

It is also a significant improvement for process_mrelease(). When a process
is killed, process_mrelease is used to reap the killed process and often
runs concurrently with the dying task. The test data shows that after
applying the patch, lock contention is greatly reduced during the procedure
of reaping the killed process.

Without the patch:
|--99.74%-- oom_reaper
|  |--76.67%-- unmap_page_range
|  |  |--33.70%-- __pte_offset_map_lock
|  |  |  |--98.46%-- _raw_spin_lock
|  |  |--27.61%-- free_swap_and_cache_nr
|  |  |--16.40%-- folio_remove_rmap_ptes
|  |  |--12.25%-- tlb_flush_mmu
|  |--12.61%-- tlb_finish_mmu

With the patch:
|--98.84%-- oom_reaper
|  |--53.45%-- unmap_page_range
|  |  |--24.29%-- [hit in function]
|  |  |--48.06%-- folio_remove_rmap_ptes
|  |  |--17.99%-- tlb_flush_mmu
|  |  |--1.72%-- __pte_offset_map_lock
|  |--30.43%-- tlb_finish_mmu

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3caaafc896d4..540b1e5e0e46 100644
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
@@ -526,7 +526,13 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
-	for_each_vma(vmi, vma) {
+	/*
+	 * It might start racing with the dying task and compete for shared
+	 * resources - e.g. page table lock contention has been observed.
+	 * Reduce those races by reaping the oom victim from the other end
+	 * of the address space.
+	 */
+	mas_for_each_rev(&mas, vma, 0) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
-- 
2.17.1


