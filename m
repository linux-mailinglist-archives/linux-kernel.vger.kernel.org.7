Return-Path: <linux-kernel+bounces-849466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A6BD02FC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96EF64E622F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321FB274B2F;
	Sun, 12 Oct 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hUaCxwTE"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09461273D92
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277583; cv=none; b=Gmzmz/np2jkFubJFL51o8dW8YoBvDjOSWLCZPMxOZrsbJgizKUvGt4CJfk2G+jQv4TPsmiP/5LBkstT8FFY/sjacLhSssWSYmE8LpNR8MzB3BoVhhi4MAoeiNWIVC8RZpo5hx+gkvG17SegDa5s+UjiECZV5ypDOsTXw61xTz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277583; c=relaxed/simple;
	bh=jUoRj4nRpgoKVitt3E1LSM2fS3sjHejPEksGoT//Rc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEuJIL0K9EGIS/KcMaI7cGrf6twjn6YvW0xy90OLjs67XI9+Cv8greDbpiLXl8/fu1+52GvGz9chkhJShbc25affRHl5fQJ+JPhSKWw1jSsOK93dkfTKzxxDUMicPE2pwSLfoUGo6F+m3gAvLhC1XnJyq7FYh8qS1GQWbGU+g5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hUaCxwTE; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760277571; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=C+3m6uNElGJ0/qN5ibv3cED1GoNXw5FqkHWx83H4/tg=;
	b=hUaCxwTEseCknDJ0EnAyj69839n/ffBYM1zYy5zeIaIojlX9j6NfnLo3IKwkqzjEhEpcPdsAmH7U4VedQ1othBzLpgeiCsb3CSDjA0KDXPC9XCnNnLvsUmSzMnlaNVWcq6FnWu/X6t5u1EjLjJmAlnR9gknMVBDoXefRYJqwyiY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wpypp5T_1760277566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 12 Oct 2025 21:59:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Robert Morris <rtm@mit.edu>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH v2] erofs: fix crafted invalid cases for encoded extents
Date: Sun, 12 Oct 2025 21:59:25 +0800
Message-ID: <20251012135925.158921-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2cda3cc5-f837-4627-9587-051ed10839b9@linux.alibaba.com>
References: <2cda3cc5-f837-4627-9587-051ed10839b9@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Robert recently reported two corrupted images that can cause system
crashes, which are related to the new encoded extents introduced
in Linux 6.15:

  - The first one [1] has plen != 0 (e.g. plen == 0x2000000) but
    (plen & Z_EROFS_EXTENT_PLEN_MASK) == 0. It is used to represent
    special extents such as sparse extents (!EROFS_MAP_MAPPED), but
    previously only plen == 0 was handled;

  - The second one [2] has pa 0xffffffffffdcffed and plen 0xb4000,
    then "cur [0xfffffffffffff000] += bvec.bv_len [0x1000]" in
    "} while ((cur += bvec.bv_len) < end);" wraps around, causing an
    out-of-bound access of pcl->compressed_bvecs[] in
    z_erofs_submit_queue().  EROFS only supports 48-bit physical block
    addresses (up to 1EiB for 4k blocks), so add a sanity check to
    enforce this.

Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/75022.1759355830@localhost
Closes: https://lore.kernel.org/r/80524.1760131149@localhost
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - `pend` should be converted to blocks and then be compared.

 fs/erofs/zmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 798223e6da9c..87032f90fe84 100644
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
+	/* Filesystems beyond 48-bit physical block addresses are invalid */
+	if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
+		     (pend >> sbi->blkszbits) >= BIT_ULL(48)))
+		return -EFSCORRUPTED;
 	return 0;
 }
 
-- 
2.43.5


