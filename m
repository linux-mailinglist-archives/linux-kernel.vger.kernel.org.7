Return-Path: <linux-kernel+bounces-813068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CBB54060
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE851C86CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ABB1D5146;
	Fri, 12 Sep 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp183D52"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268E41C62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644245; cv=none; b=FYxrGhKzGciAA6BrCwTx7vyjB6xJzDO+9XESzHLTA6qNVrOBdyRDBDQqIhA7xSrLsVoI9j4ZIA3LzdCsz3Nx1VXbwVN2sKJxdIDI/+4XtEHVYCXuRpuyaaWe1Bgebw8+I1Hb71wpW6swwmU4PsA0E41QquyXxkyY7OmQ83+lkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644245; c=relaxed/simple;
	bh=C+wNWmDXpY+mqph3f3/pewOaqICR6pNRFqoYooFy4qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afJhRWQDHKjf2KD51I8l+93Tn31alJoMeEg9mbWEXLbErx61XC7ezVFPpnw5CkIUQhQ+Uw0VmBV4hQEO/bQP9+iAvq6WZEwGz8KLLR6Yz1BB8/GdSDh9bWSLWD0+hsvy42YAOebPTy+kHuaCbcTx5wMr3GwFES6L+Sv8OU4XGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp183D52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2157C4CEF0;
	Fri, 12 Sep 2025 02:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644244;
	bh=C+wNWmDXpY+mqph3f3/pewOaqICR6pNRFqoYooFy4qU=;
	h=From:To:Cc:Subject:Date:From;
	b=Jp183D52hb3Fg+eQA/Q8cKVt3Zg2IoKO3k4ZEUZxBn8ebXAEnjksfbJDvv+sbemb1
	 XvN4Wpwq1VMzvtVZOT6Jr2EwBbnZXlbGrq3JIfTmA7GbmEt926mjTmzVHjo6io6LyS
	 BlaREY9jqUwC7VCizg0hWHLcQZbgFC1+UOTBOvASEgU7xBrkSYXCk5Z6eJifojiSsp
	 49enosMPW7zilJWOSpaBT6R0x5rpOeW6Jnpj7ewpPDrEs8XeC08kxZeXi0vZps1fhA
	 AlzTLpC5Ak4XhOj3U/F2WejEeem99OtctI8bwkpy6xLcLtH8KjjkSg6K6P85vHmWtA
	 ub+0ukBXndACQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to update map->m_next_extent correctly in f2fs_map_blocks()
Date: Fri, 12 Sep 2025 10:30:27 +0800
Message-ID: <20250912023027.2526939-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkfs.f2fs -O extra_attr,compression /dev/vdb -f
mount /dev/vdb /mnt/f2fs -o mode=lfs,noextent_cache
cd /mnt/f2fs
f2fs_io write 1 0 1024 rand dsync testfile
xfs_io testfile -c "fsync"
f2fs_io write 1 0 512 rand dsync testfile
xfs_io testfile -c "fsync"
cd /
umount /mnt/f2fs
mount /dev/vdb /mnt/f2fs
f2fs_io precache_extents /mnt/f2fs/testfile
umount /mnt/f2fs

         f2fs_io-760     [028] .....   407.418603: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 0, len = 512, blkaddr = 1055744, c_len = 0
         f2fs_io-760     [028] .....   407.418613: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 513, len = 351, blkaddr = 17921, c_len = 0
         f2fs_io-760     [028] .....   407.418770: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 864, len = 160, blkaddr = 18272, c_len = 0

During precache_extents, there is off-by-one issue, we should update
map->m_next_extent to pgofs rather than pgofs + 1, if last blkaddr is
valid and not contiguous to previous extent.

Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c4d80bffb559..35408f8c3d1c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1788,8 +1788,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 				start_pgofs, map->m_pblk + ofs,
 				map->m_len - ofs);
 		}
-		if (map->m_next_extent)
-			*map->m_next_extent = pgofs + 1;
+		if (map->m_next_extent) {
+			*map->m_next_extent = pgofs;
+			if (!__is_valid_data_blkaddr(blkaddr))
+				*map->m_next_extent += 1;
+		}
 	}
 	f2fs_put_dnode(&dn);
 unlock_out:
-- 
2.49.0


