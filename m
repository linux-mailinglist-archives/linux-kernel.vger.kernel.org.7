Return-Path: <linux-kernel+bounces-809838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3EB5129E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16381C822E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597C3148D8;
	Wed, 10 Sep 2025 09:34:50 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CD3148D2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496890; cv=none; b=YMZnymj6DsDZAWxd9qlOUodMKnqoECFYJ9kAyeLkauEy02Z/DHqOGPHfh+i/onF1vdfa4iQi94i38QDea3u1b6uKjQ9dmVHLvp7Lmagorz/rwj6ZwzlRVNGfYzhWVM74iCiQJFIbW5126gKPRTADd7XCU2/aS5HNUWS7hsNkCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496890; c=relaxed/simple;
	bh=UYbTyEDlIXQLDxIepbmwJXpzFXuBrDjLh6lYtOUZwtQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QafNA57P4F4ZyggYoSNBI1yFTyqNKvE5Q3e2NJo4rsj0bsXxuJulYH0vTwvu/K6cqnBOG5QxVJ6wKATvBgz0CTsMujghWg5flr8rguXquwqsqRTJaPrW3Drkn9oXkpDwnDXHBeiI6JSP0mLzU5alZUYsWprHJbyvVslWoTDpzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] mm/hugetlb: skip report_hugepages() output when no hugepages configured
Date: Wed, 10 Sep 2025 17:03:16 +0800
Message-ID: <20250910090316.3406-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com> 

Avoid unnecessary report_hugepages() output and processing when
max_huge_pages is 0. This eliminates redundant log messages for
unconfigured hugepage sizes and saves CPU cycles during boot.

Before this change, the kernel would always print registration messages
even for hugepage sizes with zero pre-allocated pages:

[    4.118953] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    4.122920] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    4.126920] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    4.130920] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page

Now these messages are suppressed when no pages are configured.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index af7c36f..9fb9311 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3733,6 +3733,9 @@ static void __init report_hugepages(void)
 	for_each_hstate(h) {
 		char buf[32];
 
+		if (!h->max_huge_pages)
+			continue;
+
 		nrinvalid = hstate_boot_nrinvalid[hstate_index(h)];
 		h->max_huge_pages -= nrinvalid;
 
-- 
2.9.4


