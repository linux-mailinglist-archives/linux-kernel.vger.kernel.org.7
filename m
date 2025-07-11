Return-Path: <linux-kernel+bounces-728254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD06B0257D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72D45C43AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10B1E47A8;
	Fri, 11 Jul 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FydgbDSH"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF02110E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263920; cv=none; b=WQg+O3cnV75oq20fjG8Ri5kTnAWLPlpGcn/yK262u5h/0DsqTHWB6fIWHSGQXm0WWcORZoLDth95EP83ItojYzQrx6Z5OchfOha7miG54lIx6nIH7+OBxC9cXZGBupYXA+inbNyaJmeyUYyTRZGOQ+HuQoNAqRgIex7mucGoHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263920; c=relaxed/simple;
	bh=AEr3GF5lSzNyqshXmGedkybJgaW/fKfj5uVB5kCYrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym2fC9FyMh8BimPvicW/ZrobFFUmDOG0QChLuOVc7psu5oHHLqosFPkVBsxHcFKjf5b/f6AYSjmAiRrjRDJFF+MHPcptwNpNe0bQjyvnfuesQYkNRiHSbWqOeyNr3lQ5tDpDFgoJ1fwt8pd3Cb6ZwvnzK5MZ1VNe8v2Hbi7S//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FydgbDSH; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752263913; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=odfWDvqu6DkbM3v/1M/WfbIdcwX+3SShHCrXamf+WSc=;
	b=FydgbDSH/qomYIepCytcSZ2PiMTGJwWeqRa8P12dig4I5j7+zsEsfvFaclw9xv3Mdj0zHfKnylmYfQihk7VgtumDj7F4I5C5xqVnTyjVqp3miwtmlWSXcvVRUfuaHxkZTWd2a4BP8qeOvhZIP3DoNegdIiG31NO4Fk3qITiciDk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wihw24S_1752263907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Jul 2025 03:58:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Axel Fontaine <axel@axelfontaine.com>
Subject: [PATCH v2] erofs: fix large fragment handling
Date: Sat, 12 Jul 2025 03:58:26 +0800
Message-ID: <20250711195826.3601157-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250711174257.3427562-1-hsiangkao@linux.alibaba.com>
References: <20250711174257.3427562-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fragments aren't limited by Z_EROFS_PCLUSTER_MAX_DSIZE. However, if
a fragment's logical length is larger than Z_EROFS_PCLUSTER_MAX_DSIZE
but the fragment is not the whole inode, it currently returns
-EOPNOTSUPP because m_flags has the wrong EROFS_MAP_ENCODED flag set.
It is not intended by design but should be rare, as it can only be
reproduced by mkfs with `-Eall-fragments` in a specific case.

Let's normalize fragment m_flags using the new EROFS_MAP_FRAGMENT.

Reported-by: Axel Fontaine <axel@axelfontaine.com>
Closes: https://github.com/erofs/erofs-utils/issues/23
Fixes: 7c3ca1838a78 ("erofs: restrict pcluster size limitations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - should replace the old EROFS_MAP_FRAGMENT checks too.

 fs/erofs/internal.h | 4 +++-
 fs/erofs/zdata.c    | 2 +-
 fs/erofs/zmap.c     | 9 ++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..06b867d2fc3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -315,10 +315,12 @@ static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	0x0010
+#define __EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
 #define EROFS_MAP_PARTIAL_REF	0x0020
 
+#define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
+
 struct erofs_map_blocks {
 	struct erofs_buf buf;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6f8402ed5b28..5e0240b7b7db 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1033,7 +1033,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
 			tight = false;
-		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		} else if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
 
 			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 431199452542..312ec54668aa 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -403,8 +403,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	    !vi->z_tailextent_headlcn) {
 		map->m_la = 0;
 		map->m_llen = inode->i_size;
-		map->m_flags = EROFS_MAP_MAPPED |
-			EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 		return 0;
 	}
 	initial_lcn = ofs >> lclusterbits;
@@ -468,7 +467,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			goto unmap_out;
 		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
-		map->m_flags |= EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 	} else {
 		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -596,7 +595,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	if (lstart < lend) {
 		map->m_la = lstart;
 		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-			map->m_flags |= EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+			map->m_flags = EROFS_MAP_FRAGMENT;
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
@@ -776,7 +775,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_flags & EROFS_MAP_FRAGMENT ?
+		iomap->addr = map.m_flags & __EROFS_MAP_FRAGMENT ?
 			      IOMAP_NULL_ADDR : map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;
-- 
2.43.5


