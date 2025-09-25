Return-Path: <linux-kernel+bounces-832001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6CB9E1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE93B81E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF2277C8F;
	Thu, 25 Sep 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="i5CMwei5"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A02777FD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790222; cv=none; b=j5O7b+Oggwdde2ze0RoxU8Zrsm4+VQVjAWDZeiJcck95sXPQ0NoG3DQBxRm2sR6sCgGeyFoQsNmLBbu4DnRtB4gH34zf4PKrjvfb60e5pJSBQHAjYPtSrrU+3mLFd+1Cb9e9eSBnVI7eeHxNDF8JqYbccDcsorRgO/HXVY+NEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790222; c=relaxed/simple;
	bh=2S4j3j6BEShMO1XjCj28PgzXzyw1DQXfXQ+ymabDhkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEdi8CwK2MoiVp2oB3fBRBywYIEJweRnj4AgJCQVl5EwydP7fDd98KaesD81MIR0Atecemg9gVtsGYddOJssa4KXptLvdji0A75AytnOiuFfqN9F3fyQ0deSrjkMTFvkBFb/SIPZI/KGIf3T0P7k6hfCj3ng5Rw+tt8jEJ8USqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=i5CMwei5; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=oWazejXIX/ZUdm5NLVQBNS556FwM+MqcPhsfiU/gNew=;
	b=i5CMwei5/olzl8ncecz0XEYWq8sQNTIHv5SELuvOIhPo5wNkGugcfxNAPyQMHIBn6g2NwoadL
	aiT+fHJ4TjGWjmgORohmCgzw0btjgh38kLbZ6JTTAjGf2XznX3rvSqqvCU+6SdBlHC0RvVmvl47
	E6hzNzhhySYT0nkcHjQd1mU=
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cXS8C6cddzYl1nL;
	Thu, 25 Sep 2025 16:49:47 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Sep
 2025 16:50:11 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Sep
 2025 16:50:10 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <akpm@linux-foundation.org>
CC: <vbabka@suse.cz>, <surenb@google.com>, <mhocko@suse.com>,
	<jackmanb@google.com>, <hannes@cmpxchg.org>, <ziy@nvidia.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <liulu.liu@honor.com>,
	<feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v0] mm/page_alloc: Cleanup for  __del_page_from_free_list()
Date: Thu, 25 Sep 2025 16:50:06 +0800
Message-ID: <20250925085006.23684-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

It is unnecessary to set page->private in __del_page_from_free_list().

If the page is about to be allocated, page->private will be cleared by
post_alloc_hook() before the page is handed out. If the page is expanded
or merged, page->private will be reset by set_buddy_order, and no one
will retrieve the page's buddy_order without the PageBuddy flag being set.
If the page is isolated, it will also reset page->private when it
succeeds.

Since __del_page_from_free_list() is a hot path in the kernel, it would be
better to remove the unnecessary set_page_private().

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..1999eb7e7c14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -868,7 +868,6 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
 
 	list_del(&page->buddy_list);
 	__ClearPageBuddy(page);
-	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
 
 	if (order >= pageblock_order && !is_migrate_isolate(migratetype))
-- 
2.17.1


