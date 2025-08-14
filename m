Return-Path: <linux-kernel+bounces-768254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05095B25EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7207BAE74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709782E7F02;
	Thu, 14 Aug 2025 08:30:52 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020E134A8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160252; cv=none; b=d+WUH4MdogXCbemH0Sqx0cmIKXRtSXQkzS+PlYpbiuU8LaprncY5vweBSY1yjxv/qR6FfV0EVXQguIT95qfPgRLV+oV+i4ugVNEjq3g89kaJ0DS4wYX/E8sNOGcDp2iejpDxot1/Y1tAYUMSHw48QnVo0D8eKL7UgndZbAu5D8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160252; c=relaxed/simple;
	bh=f8zVS4Q8JqSHQ+wA/RVUUaCIPVam32ikQJKx/Wn0OeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c1tpmt6dKsRqbdHMJmvORIB7pOzYpp5aVCLOX+QpYdn7v+HeXnpnqS6It1COrtqrsMJYObEH3CvTYeb8EN0i3Iq/efAzjemqwjQgVhJ1I7BF+8EBhGVNP7NFF0CaPnGSAy7GsbzJ60XpYA9WoB8qUPcsams1QCM9K/paXWm1gGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] mm/hugetlb: early exit from hugetlb_pages_alloc_boot() when max_huge_pages=0
Date: Thu, 14 Aug 2025 16:29:50 +0800
Message-ID: <20250814082950.2888-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Optimize hugetlb_pages_alloc_boot() to return immediately when
max_huge_pages is 0, saving cycles when hugepages aren't configured
in the kernel command line.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
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


