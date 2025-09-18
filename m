Return-Path: <linux-kernel+bounces-822204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3CB8348E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EEF3B441B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358E2DF714;
	Thu, 18 Sep 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m3iQCM2T"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4123315A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179878; cv=none; b=oD03RY6yAOwbh8Bmdsb/1qtDBHAO5mZIvj9ESX7OaaVhSmDbV+EfgjqR0Xn6WTo7ItIiPKUNSqrOWvBqOwYHemyonEgux24JKu6EogPbWqQtqKJcOIjTxVVzzDL8oqJAL2NY6wrlsgPUY7zmAG9PhjYICkkdQ6pCsS4RPnuAJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179878; c=relaxed/simple;
	bh=g6KpOQLmw0L2SyJnoN9qB9ROZzSlgYe341rQrO83gjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxkXX4BB1MkdgHtLjAjTi0xBI61YsYk+s5LfWrrdbn/sdpq/2OtEY/b2VEeke2UlLUzTs4p33tpPMBwcwWsCKFMQCnPJb6Rtdg67JjXSMKsKF2l8+u1sc3O3fZnqjRArokSLC7KEw4CEGbvnNRLAzedggQEgLJsUcZzAWux17DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m3iQCM2T; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758179874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=njN97PvBPLC4bDZRs8q/T0cTu4eF2v+Wk3jFZfVWHnw=;
	b=m3iQCM2TOJA+kmwLLav6k0tpHUtNL0IBO87TXdQfOVw4AG2EYcVb6OGbJ0WG7CRdyF/bFr
	a51psNoJIanaLFs9imtLLnJBQyM03SrVwmYeQ+MxEPlJkoyH4IjcuBBbQqECJAbWNNzNYr
	MvZH82gNkKZ0m2BkQ1C43r9Tpr8o7ec=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmstat: add header line to /proc/buddyinfo output
Date: Thu, 18 Sep 2025 15:17:40 +0800
Message-ID: <20250918071741.526280-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Add a header line to /proc/buddyinfo that shows the order numbers
for better readability and clarity.

Before:
Node 0, zone      DMA      0      0      0      0      0      0      0 ...
Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
Node 0, zone   Normal   1113    351    138     65     38     31     25 ...

After:
Free pages per order       0      1      2      3      4      5      6 ...
Node 0, zone      DMA      0      0      0      0      0      0      0 ...
Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
Node 0, zone   Normal   1113    351    138     65     38     31     25 ...

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/vmstat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index bb09c032eecf..e9606457ab91 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1574,7 +1574,14 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
  */
 static int frag_show(struct seq_file *m, void *arg)
 {
+	int order;
 	pg_data_t *pgdat = (pg_data_t *)arg;
+	/* Print header */
+	seq_printf(m, "%-21s ", "Free pages per order");
+	for (order = 0; order < NR_PAGE_ORDERS; ++order)
+		seq_printf(m, "%6d ", order);
+	seq_putc(m, '\n');
+
 	walk_zones_in_node(m, pgdat, true, false, frag_show_print);
 	return 0;
 }
-- 
2.43.0


