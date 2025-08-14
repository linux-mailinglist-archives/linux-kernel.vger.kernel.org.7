Return-Path: <linux-kernel+bounces-768573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4EB262C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EB2563D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC67301018;
	Thu, 14 Aug 2025 10:24:15 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E22FB99E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167055; cv=none; b=oErBEh4HNyM70Wn70D00GyJ45GOeKlVdyBeC9kPok8HT1msyyvaClPhxQUJawNUMD43TfR2zzCH74dsw9rVQNUvj9MkgyuwyavfCvpK6R8eDiC4pNGooMvoX3i4CT689Ckx2hq3F3ivSoUyeTXL7eH2VvLvatGtxEpW2Y7PZvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167055; c=relaxed/simple;
	bh=IK6LVUsg/KB3VEB3xwNqQvU6PgFkaANaDoqj6Mh+JjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvL/j60cV3SOQiCZwmNOVzXSJCKXwZFasAFbOsQSF8v4gYvu+PJbY8pzBUOeGm44HNA9dpKa5gy/9NLQf3UH30nkCX0RL4aV1ubt6dhqfvBcXUM0UiK7N7pJdpOBKEpEulB1iQA3tmkXAeGvgQgJ+nHN8QbswnoOv0Bdpw6UClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] mm/hugetlb: early exit from hugetlb_pages_alloc_boot() when max_huge_pages=0
Date: Thu, 14 Aug 2025 18:23:33 +0800
Message-ID: <20250814102333.4428-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Optimize hugetlb_pages_alloc_boot() to return immediately when
max_huge_pages is 0, avoiding unnecessary CPU cycles and the below
log message when hugepages aren't configured in the kernel command
line.
[    3.702280] HugeTLB: allocation took 0ms with hugepage_allocation_threads=32

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff with v1: adding the reduced log messages in commit header 

 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b..514fab5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3654,6 +3654,9 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		return;
 	}
 
+	if (!h->max_huge_pages)
+		return;
+
 	/* do node specific alloc */
 	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
 		return;
-- 
2.9.4


