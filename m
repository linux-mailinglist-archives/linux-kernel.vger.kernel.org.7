Return-Path: <linux-kernel+bounces-831912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64110B9DDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2362D4A7D32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041672222A1;
	Thu, 25 Sep 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mCXiM7IS"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839F1D8E1A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785558; cv=none; b=SRgXzRbVB8zLQh7P4KTbNOcQtUB9Esl31Ql/EAracx6P3DEkq7+kYPIMhgNPWB2TXQ1O1JNfI3xq1DjjVKq0jEH1Q8T9nP19ufOqVLFDhv48ZXFQmICFfEn445S+5oZKMx9hegZka+BdzXXpQB+vssU0bcocTc22ZHY2cdTaTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785558; c=relaxed/simple;
	bh=0v4EotF9tFS7KF7OrGbB8Pb2OZ7/8ArnH5iZPH6RbW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6vrCavFUH4Ia8EJ90QzloCv2x4Q+M36ugnTGN8cfh57LhA7M+28AP+whitGUlMRj0Vj+ZgFxFOGI/qL2VmLQi9Kq13dUAVAMpjw14xqPFE5TYSns3zZxztYWIKsxIHESZSlVKUrmNuKtgVZkKFKEoWWL8OVTxF9G5MWEtJ2qvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mCXiM7IS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758785553; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=A9IKn1FbYkXB/xz9fK/2Kq+b1V04wQVNgo/lxGPqv2I=;
	b=mCXiM7ISTavEt2svzXt2oF+Eh8eTxc19eVZUPr03+k0fVEDxdZeQHRsNpNHT9HzcNZghuxTEiS8jG/XLoHffPT9fTdaZ6i469lU/Xl7cpInNjKm57k19o+2qhIGr7ovGVzlOnuSlhLjdT4gHgWRfkTMtdmiBJJRTHfLheEoS8wU=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Womw6o6_1758785551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 15:32:32 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	hughd@google.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: vmscan: filter out the dirty file folios for node_reclaim()
Date: Thu, 25 Sep 2025 15:32:11 +0800
Message-ID: <d3560ced59af0b32b5eeae53c0b9569ebd3170db.1758785194.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1758785194.git.baolin.wang@linux.alibaba.com>
References: <cover.1758785194.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 6b0dfabb3555 ("fs: Remove aops->writepage"), we no longer
attempt to write back filesystem folios in pageout(), and only tmpfs/shmem
folios and anonymous swapcache folios can be written back. Therefore,
we should also filter out the dirty filesystem folios for node_reclaim()
to avoid unnecessary LRU scans.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index aadbee50a851..f347865edc70 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7601,9 +7601,11 @@ static unsigned long node_pagecache_reclaimable(struct pglist_data *pgdat)
 	else
 		nr_pagecache_reclaimable = node_unmapped_file_pages(pgdat);
 
-	/* If we can't clean pages, remove dirty pages from consideration */
-	if (!(node_reclaim_mode & RECLAIM_WRITE))
-		delta += node_page_state(pgdat, NR_FILE_DIRTY);
+	/*
+	 * Since we can't clean folios through reclaim, remove dirty file
+	 * folios from consideration.
+	 */
+	delta += node_page_state(pgdat, NR_FILE_DIRTY);
 
 	/* Watch for any possible underflows due to delta */
 	if (unlikely(delta > nr_pagecache_reclaimable))
-- 
2.43.7


