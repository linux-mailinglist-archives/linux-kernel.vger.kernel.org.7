Return-Path: <linux-kernel+bounces-842276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FCBB964F
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C83A18969A9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE325B1CE;
	Sun,  5 Oct 2025 12:45:37 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B715C0
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759668337; cv=none; b=Mp+LTOsKiVLvCBiv3fGGtLBP7Iprfw3rSMb6jlLAXkZBjJPLPmVAGhYa8BqylEW6siDdUMnUZxRCTiI6N4Uvpf6Ej6lAlFBZtDs/rZV0fdqfRiW986/jo/mCae87PXKgX1UD4391v7VggB1nbmsHzcjqNz25dt+eE4YiuU7X3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759668337; c=relaxed/simple;
	bh=w1BpAmbaN86iwXR0QDTwBRG1kpMTbin8invXAcvJTcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+YH/CUUYeVo3JFt3rquZBMGXrc2RKJQZyIoVXzIlEf8vXUcW1uF9P38N1fGSgGOB5BcHsAPRVT9d8xAVRxcVi8FMou8eonBsVrcgAterdsFlWEDyk2+ch3Rgt7V0at1cIhSRR4q85LOMH6jt/nPyzmc89P4yEHhsCCgUzoGUeU=
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
Subject: [PATCH] mm/vmscan: Remove redundant __GFP_NOWARN
Date: Sun, 5 Oct 2025 20:43:29 +0800
Message-ID: <20251005124329.28708-1-wangfushuai@baidu.com>
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
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2fc8b626d3d..2acb3c09fe0d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1054,8 +1054,8 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		 * When this happens, 'page' will likely just be discarded
 		 * instead of migrated.
 		 */
-		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
-			__GFP_NOMEMALLOC | GFP_NOWAIT,
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOMEMALLOC |
+			GFP_NOWAIT,
 		.nid = target_nid,
 		.nmask = &allowed_mask,
 		.reason = MR_DEMOTION,
-- 
2.36.1


