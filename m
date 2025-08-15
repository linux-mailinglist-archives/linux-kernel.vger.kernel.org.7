Return-Path: <linux-kernel+bounces-770056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B47B27652
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261803B914F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5A2BCF72;
	Fri, 15 Aug 2025 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sXcGpxlG"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466629E0FD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225928; cv=none; b=Jn0OahRnOeCwHk58UdpSpo8vYDe6f/rGA8Dd2BiJYKtqC4PdyOiAXeE7rCTfmgWYgHRWdTVrOz7pt6nM56v6sgJQRIw431m8okVmpXDx09lBwRR7Bc3xrX5s9bnp4Tql3Wi31nkHvvGzGjyJHLrYkl05N7Czd1bbMtP9mibbSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225928; c=relaxed/simple;
	bh=jPvp5/YLdaw2kJJwikTj6C2nTsjRlvlI0ZFrhUimsDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vf0Inu4y5AOPbRey3LlGmLe21BECjdzXF1VxXashY3A4HPDDxjKFa5VGu3l7ra0ZljSFWMl9qWqTk24wLl1TYykO8vbH+ymSXJ9O1QJqoU8oWkc04N/yw+UPSt9DD3GCUKQIszbtdx+I+3X+d18eygUhFH7jIfpVb3evZ5Nh8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sXcGpxlG; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755225923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ied7X9jQgR3h26+VkaXChRgVV0OEH9AE3P2+5XZf8hg=;
	b=sXcGpxlGLJlXlGMqaGdOaOw37qJdpzNs2klMzvD3Lg2noAzkvPpfC87kjEHPgG9ynR8rGy
	YUD+zNGUbmZZj/dzvZ2fvCpymFoYONIvIiTkPdK12DLRa8FsJA5Hm0fKB82xu/gF74MqKJ
	ZFioUKEWLNxNYjOXPp3e0uSYYNz2eW4=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Ye Liu <liuye@kylinos.cn>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/page_alloc: simplify lowmem_reserve max calculation
Date: Fri, 15 Aug 2025 10:45:09 +0800
Message-ID: <20250815024509.37900-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Use max() to find the maximum lowmem_reserve value and min_t() to
cap it to managed_pages in calculate_totalreserve_pages(), instead
of open-coding the comparisons. No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Zi Yan <ziy@nvidia.com>

Changes in v3:
- max = min_t(unsigned long, max, managed_pages);
- Link to v2:https://lore.kernel.org/all/20250815023500.36893-1-ye.liu@linux.dev/

Changes in v2:
- Drop unnecessary braces
- Replace "if (max > managed_pages)" with min_t()
- Link to v1:https://lore.kernel.org/all/20250814090053.22241-1-ye.liu@linux.dev/
---
 mm/page_alloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 64872214bc7d..eff07323987c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6235,16 +6235,13 @@ static void calculate_totalreserve_pages(void)
 			unsigned long managed_pages = zone_managed_pages(zone);
 
 			/* Find valid and maximum lowmem_reserve in the zone */
-			for (j = i; j < MAX_NR_ZONES; j++) {
-				if (zone->lowmem_reserve[j] > max)
-					max = zone->lowmem_reserve[j];
-			}
+			for (j = i; j < MAX_NR_ZONES; j++)
+				max = max(max, zone->lowmem_reserve[j]);
 
 			/* we treat the high watermark as reserved pages. */
 			max += high_wmark_pages(zone);
 
-			if (max > managed_pages)
-				max = managed_pages;
+			max = min_t(unsigned long, max, managed_pages);
 
 			pgdat->totalreserve_pages += max;
 
-- 
2.43.0


