Return-Path: <linux-kernel+bounces-842543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40703BBCF87
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 03:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01113B1B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8201A2C11;
	Mon,  6 Oct 2025 01:50:52 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC46156678
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759715451; cv=none; b=fjQgDq+6/FpkfDQej1dj6qm7IiAd7yTD2qM7FHqwVP7ylSnHb6KD2h+rGxzFfAAGiFlealhMIRYm31aWO9wk3bi28n7BTARRrmDGa3D3asX1kyswbea9Vazh/oU8LzQrxnIlwL5qgOyL7oaR3gZQSnTknOSGYvL0dSX0FtxNu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759715451; c=relaxed/simple;
	bh=ILWD1LWe370UT5+8VaQ4mHUu39HdaoMxuv9K5XbForU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MEKjRBlvu9XCbxXbUE589epnOj7ME4HvQjgzd/hL4E0OET3EWA9Brysg90+p0cRTcWwtt9M+7MN5Q90nYvUQGj5KHq7z/OcJW4550HW3ICgbnkvC/UVhF6ryRm9oo13ZrMcN9aOO6C+n96hEWfoIq1CdamNL0FjluC3zO7Ld/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>, <david@redhat.com>,
	<mhocko@kernel.org>, <zhengqi.arch@bytedance.com>, <shakeel.butt@linux.dev>,
	<lorenzo.stoakes@oracle.com>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <weixugc@google.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH v2] mm/vmscan: Remove redundant __GFP_NOWARN
Date: Mon, 6 Oct 2025 09:49:48 +0800
Message-ID: <20251006014948.44695-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
remove the redundant __GFP_NOWARN flag.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2fc8b626d3d..e7ecf3b608cf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1054,7 +1054,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		 * When this happens, 'page' will likely just be discarded
 		 * instead of migrated.
 		 */
-		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
 			__GFP_NOMEMALLOC | GFP_NOWAIT,
 		.nid = target_nid,
 		.nmask = &allowed_mask,
-- 
2.36.1


