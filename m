Return-Path: <linux-kernel+bounces-848961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF0BCEE9F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 04:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E50F64E47B2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C264817C21C;
	Sat, 11 Oct 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZLjXNwgv"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78990FC1D
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760151192; cv=none; b=b/uiQ5i+zOgauHml3VtRptUcMHaZ0rf6PwYXHxYV9BT4f8pfgCDULmLJZWHEXGDlOCt9kFgeEsUdUN/VVn+KHIO9eBeO1uqcMuFP9fFj1wccACerbg2uTfliitOayGN9VgBE5qQDgxuz0n3GXww7rfK69mDkEkPLTx2zKr3ZPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760151192; c=relaxed/simple;
	bh=cBm6NUhIHQ7sZbnXgvxx9dknXxp3ohTkLs2KYGfr/gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMPBRRkcCSWW91U3Z1uEYt2AAavkvikLflYsRvpnLPVCVOOGUOIo0HHGpaHfuss107GC8ZY0aNUVAJdGsH7skCuPtX/jM9ECe1ZvCE22Mj+bHj9MhxSgkN9SFLYKX0pO2jAyHISdDCXFd/vb9XxvZ0TnPTXTgdubnn66K/W3x0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZLjXNwgv; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760151177; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=/XH6O+w/vLkIKzDZCp4JPxCPSxFkrEmYd0YC6ui49Po=;
	b=ZLjXNwgv4VKcDsh+ZuXnK3vOGK3jcvWymmVm06Vl8ojlXO5bYCPgcYidbruccP1Is6MlzM+Bb5rkVqwlDalkb4IViwhvVjeWZFRDMDwVB9VAVGeRjjuI1zTx8G2UyHg9yPkSITcqr/kk+HXX5e2j5E0vqy3ZIXqMMRno+X20sew=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wpv64J9_1760151173 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 10:52:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Robert Morris <rtm@mit.edu>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH] erofs: fix crafted invalid cases for encoded extents
Date: Sat, 11 Oct 2025 10:52:52 +0800
Message-ID: <20251011025252.1714898-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Robert recently reported two corrupted images that can cause system
crashes, which are related to the new encoded extents introduced
in Linux 6.15:

  - The first one [1] has plen != 0 (e.g. plen == 0x2000000) but
    (plen & Z_EROFS_EXTENT_PLEN_MASK) == 0. It is used to represent
    special extents such as sparse extents (!EROFS_MAP_MAPPED), but
    previously only plen == 0 was handled;

  - The second one [2] has pa 0xffffffffffdcffed and plen 0xb4000,
    then "cur [fffffffffffff000] += bvec.bv_len [0x1000]" in
    "} while ((cur += bvec.bv_len) < end);" wraps around, causing an
    out-of-bound access of pcl->compressed_bvecs[] in
    z_erofs_submit_queue().  EROFS only supports 48‑bit physical
    addresses (up to 1 EiB), so add a sanity check to enforce this.

Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/75022.1759355830@localhost
Closes: https://lore.kernel.org/r/80524.1760131149@localhost
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e5581dbeb4c2..c346397dc859 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -596,7 +596,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
-		} else if (map->m_plen) {
+		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
 			map->m_flags |= EROFS_MAP_MAPPED |
 				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
 			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
@@ -715,6 +715,7 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 				    struct erofs_map_blocks *map)
 {
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	u64 pend;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED))
 		return 0;
@@ -732,6 +733,10 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 	if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
 		     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
 		return -EOPNOTSUPP;
+	/* Filesystems beyond 48-bit physical addresses are invalid */
+	if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
+		     pend >= BIT_ULL(48)))
+		return -EFSCORRUPTED;
 	return 0;
 }
 
-- 
2.43.5


