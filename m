Return-Path: <linux-kernel+bounces-770037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E9B27626
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428DF189DB07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57052874ED;
	Fri, 15 Aug 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mYJHcHKS"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86218FC91
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225316; cv=none; b=tgB6hqhU7cmuADaTrzbtMiv/uW+k++86HzCIGhGDMOpdy9rUXXQ3FgXusQJ9NvOMPpd/6Au2dEOXjRkOVAa6hJVCGN/6Utjiw8h1fzVwR5nxQ9g2hiUi+wq2+o+qzKhIKG1sXrglqZBT20855VK5SFyb0g5T4FEqfRw4wAadlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225316; c=relaxed/simple;
	bh=k6gycqIN8rqOWrZmcMYGbAztEUnrcz0Ck7pe4fgO5LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMdjyNAyXBcOFa2oz06gnnCZ0CukdUWm3BouwVzkvpcWQ8s5+Ur9QJn5C14aFdvgx9wgBrqjvgJVPt2pf/nEwmEDyPW6cvGZYb3NxEC6mcA+zstJFrwDXdwKDB4PURGRszHSp6htqWiXCZhbteiOFu7bs1i9hmFLF75nCMIolcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mYJHcHKS; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755225311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I3OfKRQ9kR8yywxEX4JYhqedZi/JoNJ9IgE4wWghJgI=;
	b=mYJHcHKSACHhcXhwvjCuKD4K746qCqm1M/+qN0J263/FLzzf4yzl4OWbgaO9H/W9LtjXRS
	JGIkZLQrAN9jVqgN/TGJw4yi4MkCTTyPDYvYwW1dopDmqRMyk8PoAqLbZO5ZohAgs947RC
	3QvJhPq1fq/wpFQsroWdJFo01HEkz1s=
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
Subject: [PATCH v2] mm/page_alloc: simplify lowmem_reserve max calculation
Date: Fri, 15 Aug 2025 10:34:59 +0800
Message-ID: <20250815023500.36893-1-ye.liu@linux.dev>
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

Changes in v2:
- Drop unnecessary braces
- Replace "if (max > managed_pages)" with min_t()
- Link to v1:https://lore.kernel.org/all/20250814090053.22241-1-ye.liu@linux.dev/
---
 mm/page_alloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 64872214bc7d..2617fd2f4b73 100644
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
+			min_t(unsigned long, max, managed_pages);
 
 			pgdat->totalreserve_pages += max;
 
-- 
2.43.0


