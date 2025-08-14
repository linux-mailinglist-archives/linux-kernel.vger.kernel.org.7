Return-Path: <linux-kernel+bounces-768166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240EDB25DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038425A1923
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCD2690D9;
	Thu, 14 Aug 2025 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gPNbLCku"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD5265CAB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157108; cv=none; b=nUC9xW7kYS2M7Br+tnEKwvdoo014JmAG0dVtMramfghmV10L8qQpAb9vXLWTNPSE/P3EvKRlhPNhfSmzdvBaVf3JEfKhQ1Pmq2rmmLfK4bWKvb8RQkXYUP/dVKR0VaOLmmktxQHW3fYmH1Yf12VsYidnXFu7O1jqV4g6FOyyWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157108; c=relaxed/simple;
	bh=PuQmcaPEUVbGG1gx2yYyNMXoVhPDh2c46IXC3Nn2nYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9DZlIAJD3NMpXELvy7/RfzzhyCvIy1Rtivd5rfR3kxIqozGp2v+u0lquSvm3XDoDTR9hYphF1WvcS/gYHb4meIk76qrI8m/Mvrj/dExqkttJifdeFVtSDrofyWq+pddDPQzybL9cKkFHOHazjLEg1pi9uoBT53ee6l6e+JKpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gPNbLCku; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755157104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Up7LN5pRzzuJ/r68Q6CcBRepJ9T84L2u1jpkC+lZmQ=;
	b=gPNbLCkuG4AgXYU6MmRUxyf21L4YUDuC6QJRvH4xEOxg1KY8TblsTk2iQ4WBFLHA9DiK80
	Ntki8FRNYVS3Jd46hHeLeCA8WFnPt/Ru0usafdN7z0cnzXtcJAnaJ4QcX/lToQzve+O3aO
	4seSCVe/Fcpcce9VEQj6+alAxzDP2h0=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix typos in VMA comments
Date: Thu, 14 Aug 2025 15:37:59 +0800
Message-ID: <20250814073800.13617-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Fixed the following typos in VMA-related files:
1. "operationr" -> "operation" in mm/vma.h
2. "initialisaing" -> "initializing" in mm/vma_init.c

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/vma.h      | 2 +-
 mm/vma_init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index b123a9cdedb0..bcdc261c5b15 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -145,7 +145,7 @@ struct vma_merge_struct {
 	 */
 	bool __remove_middle :1;
 	/*
-	 * Internal flag used during the merge operationr to indicate we will
+	 * Internal flag used during the merge operation to indicate we will
 	 * remove vmg->next.
 	 */
 	bool __remove_next :1;
diff --git a/mm/vma_init.c b/mm/vma_init.c
index 8e53c7943561..d847c6557261 100644
--- a/mm/vma_init.c
+++ b/mm/vma_init.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 /*
- * Functions for initialisaing, allocating, freeing and duplicating VMAs. Shared
+ * Functions for initializing, allocating, freeing and duplicating VMAs. Shared
  * between CONFIG_MMU and non-CONFIG_MMU kernel configurations.
  */
 
-- 
2.43.0


