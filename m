Return-Path: <linux-kernel+bounces-587466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F57A7AD30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128C73BCCB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFE25A334;
	Thu,  3 Apr 2025 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGNQAdTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B929B218;
	Thu,  3 Apr 2025 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707378; cv=none; b=suJgHC1pxC1lFfSe7FAdj/Vt4TXbozHzV/QcPEgk5watyR4SQ5ZoTt+UNkDr3kI1U1raR9idXZ2j1dpNLXKVf3g2Uo9V4TbfjZZSokCViaNjFhNY13XaXDi5HfvZd46cWMOUGkf3fgA6BJro2gpkltuxXMShQ8MIyDTi6sY5o90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707378; c=relaxed/simple;
	bh=CwZLU19IRL+MU974j79ornqyCBjoz4krsOIAQ+1GE7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWQUUa/o2qegvzdaWie70OzQYKnw8pQz94rwgldzu6EbtKsEBl2jWclCBtLbEHmdqHQPEWkgOhV6ZSZFCjpwNzB7ETJFgJYh6fmn8h9Fh5oRTAzykObwmTMcTw031srGVUcd2rZ4whbLZlp1HKARVnwQvbGYtrW57M1qBJtT6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGNQAdTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A00DC4CEE3;
	Thu,  3 Apr 2025 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707378;
	bh=CwZLU19IRL+MU974j79ornqyCBjoz4krsOIAQ+1GE7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGNQAdTQSF8KRmsDEM4vmL2Z46bIVCNzYLzoUyo9Nk6NNLPKwoY1FRl859+H4ewsW
	 /tlc4RdlHdZbY7pFzbZrZIxLltjxCUjhHH9zwNTwxgqlRnrDkbskTx6qbU8GlM1fJz
	 qL38uF0yhYoSzfRukRoJUx1PkDRUAZ7Zc+I8ZgS78pf3UWnRSA92bDxAIs0SGUQWrt
	 mMUAYyOqAAOs3VYTqe7w/x4zHKpFtAmquUAEaalC139xcwQVW8qOHnR71CAsvgoOGc
	 tZQ1KnQPQ88fAZXOvnGDj5MMX7sMliUS3yLOs8KenyzhsyGsGo67DPd8ZSyUQDs/f7
	 DVGiumFSFzCNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	ghanshyam1898@gmail.com,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 04/16] fs/jfs: Prevent integer overflow in AG size calculation
Date: Thu,  3 Apr 2025 15:09:12 -0400
Message-Id: <20250403190924.2678291-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190924.2678291-1-sashal@kernel.org>
References: <20250403190924.2678291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 7fcbf789629cdb9fbf4e2172ce31136cfed11e5e ]

The JFS filesystem calculates allocation group (AG) size using 1 <<
l2agsize in dbExtendFS(). When l2agsize exceeds 31 (possible with >2TB
aggregates on 32-bit systems), this 32-bit shift operation causes undefined
behavior and improper AG sizing.

On 32-bit architectures:
- Left-shifting 1 by 32+ bits results in 0 due to integer overflow
- This creates invalid AG sizes (0 or garbage values) in
sbi->bmap->db_agsize
- Subsequent block allocations would reference invalid AG structures
- Could lead to:
  - Filesystem corruption during extend operations
  - Kernel crashes due to invalid memory accesses
  - Security vulnerabilities via malformed on-disk structures

Fix by casting to s64 before shifting:
bmp->db_agsize = (s64)1 << l2agsize;

This ensures 64-bit arithmetic even on 32-bit architectures. The cast
matches the data type of db_agsize (s64) and follows similar patterns in
JFS block calculation code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 38319be806e10..99e9885cbb444 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3469,7 +3469,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
-- 
2.39.5


