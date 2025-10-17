Return-Path: <linux-kernel+bounces-857523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55976BE7037
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655DB5E81B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DED2609DC;
	Fri, 17 Oct 2025 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CeFEqUky"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2425A2A4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687628; cv=none; b=H6rdsgLBOhGOfz+oC/zuuJ0k5erDRRGFGus9v+2ndYH8MYq8FLmTFenrXm/rKLKaTPKaNNcOYOzuczM6/47Ngye4241odLwQVRajJWe27oPPLa24s1Plp0bsoCiVcWyxydAL9nc4g2Z8vxxFMHWT1FfOsWnWGbNl56t/YazgpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687628; c=relaxed/simple;
	bh=jmTav0LD6uHB/CeeFFtp58fzJPAWJOfH/X2W35DCJ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTZ4lkaKIF1vq7Nd5Tff2JUfGtBZetyU4wVyyXnMVzzfg0WrMsJYQyL0o4oLC8ycFYihrgUIyB8tINVvrFXO/niGBNLefXl/U9tnb4LpHzXaaFZeXsd42dYNYiS9fwWkcX7N1l2/cfM7hUrxNiJPte1UVcQbkcrgUJHsz/+Xe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CeFEqUky; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760687623; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D0OKcU2IWVvgxpGGM/x3bGo2RcncD8hKQxZ9riDYf6c=;
	b=CeFEqUkyPd2kh2S8BKbobenqkv0L0goNojPFTGtOV+2u7dvOdt2r3Wos/kNaHltYt+f4oNt655wmqnIGcZL2noiOJrY7iMYetqTIerSM+x/J7DyCdvfO6pcjQ3sP4sfexPTabtnE0o/VVH8TSjdlDnCHJq5f45Wyk/jAltw7B7s=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqPAmKl_1760687621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 15:53:42 +0800
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
Subject: [PATCH v2 1/2] mm: vmscan: filter out the dirty file folios for node_reclaim()
Date: Fri, 17 Oct 2025 15:53:06 +0800
Message-ID: <c91f5ecc5152b647904c7503618a01885d913928.1760687075.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1760687075.git.baolin.wang@linux.alibaba.com>
References: <cover.1760687075.git.baolin.wang@linux.alibaba.com>
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
index c80fcae7f2a1..65f299e4b8f0 100644
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


