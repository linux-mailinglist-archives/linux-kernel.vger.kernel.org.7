Return-Path: <linux-kernel+bounces-775887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D797B2C629
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508FD526200
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24B33043A6;
	Tue, 19 Aug 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnPLCy8o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A826419C540
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611136; cv=none; b=unjf8w4hEpavf7bRK8QFtGE+zUXNnVe0CwTTa1YIt05RJgroABPJv1358OjWj1qMvtf3OZau/ToHOyzNhv5VD2Q0m86Zm4RUKDjWNy1c24EM++tIVQuRwj+BhCy64wpmu/JJWWTbiQKa7hceDd7Br1+02OQJWX110Q9CfW+0vTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611136; c=relaxed/simple;
	bh=BcBkd2ONu3qEsJ8amjqoMv8e03xJ7JS1NkQC4inL7hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9X9/0t3LZ9TcLkaMVTSbSWT8jMAykfcl/7uGbKVa3VA0U5vltUOWcg7Der9g9BWbRbzjUJ1wwr/dGNUoSLW7z5RFy2i0IYLZh/MPJcJwcamuXUGMw68QSEMGlPpWxFzgoD90/1KJyBNQHa7qCt1V6NKWGEFoNbhiULqqdM/MHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnPLCy8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755611133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5DchuEmH6POX8OSi9R3/H3ulGAsujcIoqxqs5qQqIk=;
	b=OnPLCy8oZZm4CHdrwQmQ0xCdYeAl6pCIvzOCqwASk8IR/EF4718WqaUdBgerHc3kPLrucy
	qpCRIR4vKv8zZJtoiteFjQZoaMCb5lHb+e8DCqyb6AgIPHbBLhyZHNzrks4nBra8ZPSZNB
	KA+3n0xEUEqBVwJbN+oCmB/tWy7yzYc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-kyYq5qvsNpunGuM_q3lK-Q-1; Tue,
 19 Aug 2025 09:45:31 -0400
X-MC-Unique: kyYq5qvsNpunGuM_q3lK-Q-1
X-Mimecast-MFC-AGG-ID: kyYq5qvsNpunGuM_q3lK-Q_1755611126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8979F180034D;
	Tue, 19 Aug 2025 13:45:26 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.137])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C00D19560BC;
	Tue, 19 Aug 2025 13:45:08 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	willy@infradead.org,
	peterx@redhat.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org,
	hughd@google.com
Subject: [PATCH v10 08/13] khugepaged: avoid unnecessary mTHP collapse attempts
Date: Tue, 19 Aug 2025 07:42:00 -0600
Message-ID: <20250819134205.622806-9-npache@redhat.com>
In-Reply-To: <20250819134205.622806-1-npache@redhat.com>
References: <20250819134205.622806-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6a4cf7e4a7cc..7d9b5100bea1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1389,10 +1389,39 @@ static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
 			ret = collapse_huge_page(mm, address, referenced, unmapped,
 						 cc, mmap_locked, order,
 						 offset * KHUGEPAGED_MIN_MTHP_NR);
-			if (ret == SCAN_SUCCEED) {
+
+			/*
+			 * Analyze failure reason to determine next action:
+			 * - goto next_order: try smaller orders in same region
+			 * - continue: try other regions at same order
+			 * - break: stop all attempts (system-wide failure)
+			 */
+			switch (ret) {
+			/* Cases were we should continue to the next region */
+			case SCAN_SUCCEED:
 				collapsed += (1 << order);
+			case SCAN_PAGE_RO:
+			case SCAN_PTE_MAPPED_HUGEPAGE:
 				continue;
+			/* Cases were lower orders might still succeed */
+			case SCAN_LACK_REFERENCED_PAGE:
+			case SCAN_EXCEED_NONE_PTE:
+			case SCAN_EXCEED_SWAP_PTE:
+			case SCAN_EXCEED_SHARED_PTE:
+			case SCAN_PAGE_LOCK:
+			case SCAN_PAGE_COUNT:
+			case SCAN_PAGE_LRU:
+			case SCAN_PAGE_NULL:
+			case SCAN_DEL_PAGE_LRU:
+			case SCAN_PTE_NON_PRESENT:
+			case SCAN_PTE_UFFD_WP:
+			case SCAN_ALLOC_HUGE_PAGE_FAIL:
+				goto next_order;
+			/* All other cases should stop collapse attempts */
+			default:
+				break;
 			}
+			break;
 		}
 
 next_order:
-- 
2.50.1


