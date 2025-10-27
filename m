Return-Path: <linux-kernel+bounces-871810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A43C0E6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A37E9502162
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6318E309F17;
	Mon, 27 Oct 2025 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [147.136.157.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFA308F3A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574783; cv=none; b=j8wM4t5kvvTHI0ID32rkmbDtDRndY+0kvXGQGFGNPyTc+qT/OQORuM92PIrawUrio+G8oPRmDNAgv5AEdsQwvnigBHiChP6xDLr+2jLXI9KCn7O6jtQYKMBpW5xzRrhTYUK7Y3ccwzkMvof65DD7r89WNXFm/xUJlfgtVlDb+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574783; c=relaxed/simple;
	bh=h5vrd06F5wdd50uAGN5xhnolsU2F9RSc5TE8hWh2dl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPi+RebF2gCokihEzxCg55WiClVwAtCyJkd6tLv/Wj+aUqhnq9zGFAwCWo9crAX8NSp4np4gD5OvA4eLo+wvn1hMV1KbawN/Qbk1OrrOSwww5YLwgTZpGx5kSLXn6fbfdeNuYts6MVNg8Dum7BcRmTkV+0suz7gaV2qKj570eQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 0F3C38B2A0C; Mon, 27 Oct 2025 22:19:34 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm: vmstat: output reserved_highatomic and free_highatomic in zoneinfo
Date: Mon, 27 Oct 2025 22:18:17 +0800
Message-ID: <20251027141818.283587-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nr_free_highatomic is a key factor in calculating watermarks as it
affects the free pages count. Adding this metric, along with
nr_reserved_highatomic, to /proc/zoneinfo facilitates easier diagnosis
memory watermark calculations and memory pressure states.

Sample output:
cat /proc/zoneinfo
......
pagesets
cpu: 0
		  count:    52069
		  high:     52675
		  batch:    63
		  high_min: 13971
		  high_max: 62284
vm stats threshold: 10
node_unreclaimable:  0
start_pfn:           4096
reserved_highatomic: 5120
free_highatomic:     2081

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 mm/vmstat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index f226942db746..b53b07aa29e8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1852,9 +1852,13 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	}
 	seq_printf(m,
 		   "\n  node_unreclaimable:  %u"
-		   "\n  start_pfn:           %lu",
+		   "\n  start_pfn:           %lu"
+		   "\n  reserved_highatomic: %lu"
+		   "\n  free_highatomic:     %lu",
 		   atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES,
-		   zone->zone_start_pfn);
+		   zone->zone_start_pfn,
+		   zone->nr_reserved_highatomic,
+		   zone->nr_free_highatomic);
 	seq_putc(m, '\n');
 }
 
-- 
2.43.0


