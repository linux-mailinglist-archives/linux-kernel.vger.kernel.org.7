Return-Path: <linux-kernel+bounces-748715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D8B14539
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE4017998F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FB211C;
	Tue, 29 Jul 2025 00:11:03 +0000 (UTC)
Received: from venus.cs.northwestern.edu (venus.cs.northwestern.edu [129.105.2.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4738B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.105.2.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753747863; cv=none; b=ss5dDoP8ydC7WS91XNLRe4tGobqNoH3i5x+0JWGWbhuEPNRv6NiiStXMr8dJU6Z6vBqcfqQM7exTAXxVAdxfEzjWeP0VSrVQqmn+o5xBV9hhWy5EsNb76X1Zu6eC9SRZZaYoHH+fh4bp1T5JUyAjBnGMhyOQq1Jt60zy0D+l0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753747863; c=relaxed/simple;
	bh=bTBaGoVcB+oGNwmqze64PMLBMQYGbnZRuCZ7LabksSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUkORylsWiSG/8Pd1IMsGJ8bibvAIAD2eNN8qvJFya/s49FfHG+lOhmAbZ/uj6mX674SIW10EToDZV/VaqllYUYo6bLJZK3mAJhbYUF8brRqFTfVUV2fhgoxYv/VGy8zl/qs0iqZATvntv/B2KH6Ucx7rb8UX1GgFpm5M1BULfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=northwestern.edu; spf=fail smtp.mailfrom=northwestern.edu; arc=none smtp.client-ip=129.105.2.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=northwestern.edu
Received: from venus.cs.northwestern.edu (localhost [127.0.0.1])
	by venus.cs.northwestern.edu (Postfix) with ESMTP id 1870F181B06;
	Mon, 28 Jul 2025 19:05:10 -0500 (CDT)
From: Zheng Yu <zheng.yu@northwestern.edu>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: Edward Adam Davis <eadavis@qq.com>,
	Rand Deeb <rand.sec96@gmail.com>,
	Jeongjun Park <aha310510@gmail.com>,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	Zheng Yu <zheng.yu@northwestern.edu>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: fix metapage reference count leak in dbAllocCtl
Date: Tue, 29 Jul 2025 00:05:08 +0000
Message-ID: <20250729000508.3517823-1-zheng.yu@northwestern.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dbAllocCtl(), read_metapage() increases the reference count of the
metapage. However, when dp->tree.budmin < 0, the function returns -EIO
without calling release_metapage() to decrease the reference count,
leading to a memory leak.

Add release_metapage(mp) before the error return to properly manage
the metapage reference count and prevent the leak.

Fixes: 51a203470f502a64a3da8dcea51c4748e8267a6c ("jfs: fix shift-out-of-bounds in dbSplit")

Signed-off-by: Zheng Yu <zheng.yu@northwestern.edu>
---
 fs/jfs/jfs_dmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 35e063c9f3a4..5a877261c3fe 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1809,8 +1809,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 			return -EIO;
 		dp = (struct dmap *) mp->data;
 
-		if (dp->tree.budmin < 0)
+		if (dp->tree.budmin < 0) {
+			release_metapage(mp);
 			return -EIO;
+		}
 
 		/* try to allocate the blocks.
 		 */
-- 
2.43.0


