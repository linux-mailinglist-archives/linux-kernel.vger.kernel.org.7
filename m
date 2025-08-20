Return-Path: <linux-kernel+bounces-777269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5F2B2D796
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377B95A09F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A62DCF6A;
	Wed, 20 Aug 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iB7/AV63"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E342DAFB7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680867; cv=none; b=j7ee77FTuOAD6mH9M1EVp++YEVyHcKPsnBrti/d4bJCmIweC8iP8sWuy1lrMLRY+QT7W/2FClDFKPemEIgdYoBZak4fRVUhUPEvyvU2y5n1DZlffM45jM2iXwmI7D6VbdWnCmEpsgLlI2t3/TH6uOww5RTSSfYg9g+6m/Q2xe5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680867; c=relaxed/simple;
	bh=NPPvPHUtxPXBykCwhCQYDRz9k9AoGUbT6RH07W58r2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/eqgNRxE2Z+aO5SFhwC2Egk8hPNfidUjS1MA5OjYZ6uQblojmYBcNB25c+jsOQsN5U/ON3YgA0NFDc4ZNFCw667kImI6NfOn88poTxFgUjEQGX73dTHFU2G99NL2909syYguKqJu588Q1Xw/VtXmvKBibXYbBsHySCBtHnkRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iB7/AV63; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680862; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hp0aqN5MfkEUvcDi4Uu976xMEqVAADqjDiv9jyT1Mvs=;
	b=iB7/AV63AA8lqUQIyEjavD5wmP0B6PLbj63ZW1wb+rpqlwVk1YiXck6nRJZa9FFB0ktYW8lirdxxY8XMuOTtcq+2tVvBJcmAvHrW+wNG+aznypDdmesU2Bd7Bcg7mC4WnW4TiNyT/3uF7035qX8UtlcLhosu3O1jMklZ3ivbbgs=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBEsC-_1755680860 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:41 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/11] mm: khugepaged: allow khugepaged to check all shmem/file large orders
Date: Wed, 20 Aug 2025 17:07:17 +0800
Message-ID: <4cad4cded3f19c667442ae4d89ec03452c42a7b5.1755677674.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
References: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are now ready to enable shmem/file mTHP collapse, allowing
thp_vma_allowable_orders() to check all permissible file large orders.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eb0b433d6ccb..d5ae2e6c4107 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -496,7 +496,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
 	    hugepage_enabled()) {
 		unsigned long orders = vma_is_anonymous(vma) ?
-					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
+				THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE_DEFAULT;
 
 		if (thp_vma_allowable_orders(vma, vm_flags, TVA_KHUGEPAGED,
 					    orders))
@@ -2780,7 +2780,7 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
 	vma_iter_init(&vmi, mm, khugepaged_scan.address);
 	for_each_vma(vmi, vma) {
 		unsigned long orders = vma_is_anonymous(vma) ?
-					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
+				THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE_DEFAULT;
 		unsigned long hstart, hend;
 
 		cond_resched();
-- 
2.43.5


