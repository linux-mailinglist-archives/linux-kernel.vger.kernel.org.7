Return-Path: <linux-kernel+bounces-743735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D550B102A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B713A3ABC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C73272E5C;
	Thu, 24 Jul 2025 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8owUmmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B2272813
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344128; cv=none; b=UnSIokRDQ1w7EoB1zLXwSQXm9DQeB2YY0Pkz888TpAhx4m49KaeTH8x/9CNafNZ1ZzwKdgFrW7Eony6SArW3F40iP7cfR8rlFYyOXyBpQ78NXJoF+pLmHIYvnDwqlu/JCIwuXKqOOO0M7ZMX5S4FTYCrMrnABofuZOMriq+uEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344128; c=relaxed/simple;
	bh=fRw8i8MgDaa/zzz+GjX6hF/zrmeBnpKlxypHhTvVhO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5VxBD3VOulvBK6Y7NQZk5gPW4QJAx99ptD/x9/r+XZGWGbyLTIhGliCB1mK/VXiHj8CcMDuatWH2bD/ByDd7h8vjBi6ju8ACSOy5iQ0JhRYEiZJpltxW8GsWPR5hTyASqGi71hmVpXpNQqdoDylrKjWdTf17Xm59gp9gxQXLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8owUmmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52509C4CEED;
	Thu, 24 Jul 2025 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753344127;
	bh=fRw8i8MgDaa/zzz+GjX6hF/zrmeBnpKlxypHhTvVhO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8owUmmZeNt0ePvr/wi77YEo5E8/bYUnl+kURZ0+4axx0KbSmu9x5yuiujJ7UvAL1
	 dDoSrXB1uP4fxehiuINAymABYtwBx1iCWpuJ+SmXM2KkyNj/xuL41IZ27zfC1+DHwG
	 q2EHIKeGagVkTjtAy2SPYhxSC91aR6gc5iqP5mijB0tGij3XCQZMdxfELyxHqmrlIG
	 b9xap2n3JOpcgltjDowCCOLkoS5q6coidBwV6Z3lN6HAczyne/mUj+SNAauOEaeUGm
	 EutRU5qSLDoViVWC3iSBWKitB2gWiwzO8NbgnHOiJtLwvva6TE3oolmSAU8oAfndqG
	 20bNrQDNWO3xg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 3/3] f2fs: fix to trigger foreground gc during f2fs_map_blocks() in lfs mode
Date: Thu, 24 Jul 2025 16:01:44 +0800
Message-ID: <20250724080144.3689181-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250724080144.3689181-1-chao@kernel.org>
References: <20250724080144.3689181-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w/ "mode=lfs" mount option, generic/299 will cause system panic as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2835!
Call Trace:
 <TASK>
 f2fs_allocate_data_block+0x6f4/0xc50
 f2fs_map_blocks+0x970/0x1550
 f2fs_iomap_begin+0xb2/0x1e0
 iomap_iter+0x1d6/0x430
 __iomap_dio_rw+0x208/0x9a0
 f2fs_file_write_iter+0x6b3/0xfa0
 aio_write+0x15d/0x2e0
 io_submit_one+0x55e/0xab0
 __x64_sys_io_submit+0xa5/0x230
 do_syscall_64+0x84/0x2f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0010:new_curseg+0x70f/0x720

The root cause of we run out-of-space is: in f2fs_map_blocks(), f2fs may
trigger foreground gc only if it allocates any physical block, it will be
a little bit later when there is multiple threads writing data w/
aio/dio/bufio method in parallel, since we always use OPU in lfs mode, so
f2fs_map_blocks() does block allocations aggressively.

In order to fix this issue, let's give a chance to trigger foreground
gc in prior to block allocation in f2fs_map_blocks().

Fixes: 36abef4e796d ("f2fs: introduce mode=lfs mount option")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e62f7f00b70..ffcaf91c1703 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1573,8 +1573,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	end = pgofs + maxblocks;
 
 next_dnode:
-	if (map->m_may_create)
+	if (map->m_may_create) {
+		if (f2fs_lfs_mode(sbi))
+			f2fs_balance_fs(sbi, true);
 		f2fs_map_lock(sbi, flag);
+	}
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-- 
2.49.0


