Return-Path: <linux-kernel+bounces-801246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C2B44299
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5821C175E28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4A224B04;
	Thu,  4 Sep 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HzpJyk0Y"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EF163
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002994; cv=none; b=alQKrWPU8smGoeMbSW1bxY51f1fZmhClGxnulpuiKbcp3zBibeQvgxYFipN8wxz0l1QVTIOQ0euzrac4kH+F9CwpRD/o52ZmCfissEyl+l52r1DgQODf8qo91R9795/r1pT3hI1WicF6WSDIFZTAcRK9aqBvBjkcNO6ZqBEyggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002994; c=relaxed/simple;
	bh=kOSJRzlq31p9goyMdzFyTfciHM4AtiRH9rV+jNCVACg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=icxPSXppvSfcgcVVkBY9fgJZlRR4+03pVw/prZ8EjzXSsukCcI7GekEvzhTS6nS+AxI4KHlGn6T9DvCfUmFgv8WYk8Ao1E9IzZHTAG6Xe1btZkt2gIrWDSisN4wWHh2cmloBhaZtd6kil58LK0YxlkhgPMtC+bbb+IawVPeKGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HzpJyk0Y; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757002678;
	bh=mKGfRAvbvXf3bMQ6oNHWZ2vAK77Q635WqynSct7rlEU=;
	h=From:To:Cc:Subject:Date;
	b=HzpJyk0YIvfq8qfm1M8uiu9jH7TTWw5F2TbX4w4wBdXrH4nEa3yMGsI8AziewjSyW
	 mh3O6mRIWccEZ3kUTiNSM+QfOrSVCSnFciPJgPe0Y7zuKsGieOsvcwu7yO9Ej5D1or
	 I84jXk4KJsZ6fYpjRtGpkMynZ4bRk4b/DoiXq2LY=
Received: from zm.. ([2408:8340:a2e:f9b0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 47924CA4; Fri, 05 Sep 2025 00:17:57 +0800
X-QQ-mid: xmsmtpt1757002677t02xkli6l
Message-ID: <tencent_C19E4D9448D8514A505A9FE439D01C333B08@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb59NM42ui9HbnHAvDkQw2FZ43LFzwbw+FOSJFGNwUveuDCrLYyVO
	 U8nq//JUMwyQ6RO3By6P+bNvEjBpqDqg68VZ3HKs1KQqQBpajEpWXKXEmB+LQ/3duguBavcnCXT7
	 t5Fouzo4AW8tb5x147WbGlUWPbEjql93cuWGPTvsWz+7xEvzVipjfRUQXl76Wvtt20zCCszB/PPG
	 9up6jP0a56L8gOQODLYiVtE/sUJraU4A0a4sBBEDUmK3TYc+KUK+cH4LPNIdQUTtGwTjqbch3XfY
	 a4WegQHPI+lGNf0REOAM36enAcC//Ep6IA/qRJmp4AwBjy/grOh8zfTFzpx+IZD7bsR4KoOM1moH
	 EvdSpLVYTkQRMi1H+xxgWSPWIfZ1G9Gsf8NBr55au5nybipwPDIVUiZk5nqRfhT4UFzlwArBso/u
	 grn7CXOQ//MUIqoxx28kdJhIe/VV06cdYdkFof/GIEAd+QNnvmZno2P5dDg3WkfHOqMmz7bSUb+o
	 Sdk+JnHJRSyMZAnYPMDZ/PAP1eNDu4Z/0CGCavTi5y5jwHPnKimYTJqjBiSe7oUZ0F2q4aI9o6mg
	 D+MnCiADvii9DlKX/+a2pTxIiznnfX+GitjqM0DyXsU/Ij2mA8Q7M4UASJbWuQtpjWzPG6MRNFmv
	 6A7K5r4tO5PXrrZgbgh56+MfxOLdXUYuGztIFg4O3w/jZmzeUCnAKa5qkTLQiTTlKUd53C7IPN2i
	 7Rjby/BSXG3D54EPCMgOWariA6G0lQM6UwOrGIiQ1Hr4jnX7o5MquTZUucnzHRzp3Pf7CpSBC9OC
	 H7ObwZQDYhBOMdPkJI11OLh1/Ty5dJgdcHDD0UfON3e51Gn5nB6Jpg6oKsg5JXkb8FHovKaZtpx8
	 LuFfa7+o775SNiLraKRzBkBlR3ZWz7bmXSL+YmfkBSHplrlVcyXMeLv/BHoIusB3e4Xmw5g/j/O9
	 Ou/0O6+D60kQWlC/frL68jXn5Gzmj1w6uHSvBdP4ZY8t1Dgf9f1gSnqomGo/EzL2QmNfQzrzG6H2
	 N++xCVPzeAnCcNkSXzeXXZfGUYPenNP2RXA1Lk8+WDC/ZTPtHcB7WHtZx/Ten1pjY18ARTFZ/Wyr
	 7ZHtcCZlriuql/dl4=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: zhoumin <teczm@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	zhoumin <teczm@foxmail.com>
Subject: [RFC PATCH] vfat:avoid unnecessary check
Date: Fri,  5 Sep 2025 00:17:54 +0800
X-OQ-MSGID: <20250904161754.137467-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant and unreachable name check code in dir.c.

Remove flags check in fat_update_time since fat does not support
inode version.

Optimize fat_truncate_time to return a meaningful value, allowing
the removal of redundant inode checks in fat_update_time. This
ensures non-root inodes are validated only once.

Signed-off-by: zhoumin <teczm@foxmail.com>
---
 fs/fat/dir.c  | 12 ++++--------
 fs/fat/misc.c | 11 ++++-------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd521..4f1be9939292 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -337,11 +337,11 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
 		if (ds->alias_checksum != alias_checksum)
 			goto parse_long;
 	}
-	if ((*de)->name[0] == DELETED_FLAG)
+	if (IS_FREE((*de)->name))
 		return PARSE_INVALID;
 	if ((*de)->attr == ATTR_EXT)
 		goto parse_long;
-	if (IS_FREE((*de)->name) || ((*de)->attr & ATTR_VOLUME))
+	if ((*de)->attr & ATTR_VOLUME)
 		return PARSE_INVALID;
 	if (fat_checksum((*de)->name) != alias_checksum)
 		*nr_slots = 0;
@@ -491,12 +491,10 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
 			goto end_of_dir;
 parse_record:
 		nr_slots = 0;
-		if (de->name[0] == DELETED_FLAG)
+		if (IS_FREE(de->name))
 			continue;
 		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))
 			continue;
-		if (de->attr != ATTR_EXT && IS_FREE(de->name))
-			continue;
 		if (de->attr == ATTR_EXT) {
 			int status = fat_parse_long(inode, &cpos, &bh, &de,
 						    &unicode, &nr_slots);
@@ -608,12 +606,10 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 	 * need to parse long filename.
 	 */
 	if (isvfat && !short_only) {
-		if (de->name[0] == DELETED_FLAG)
+		if (IS_FREE(de->name))
 			goto record_end;
 		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))
 			goto record_end;
-		if (de->attr != ATTR_EXT && IS_FREE(de->name))
-			goto record_end;
 	} else {
 		if ((de->attr & ATTR_VOLUME) || IS_FREE(de->name))
 			goto record_end;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index c7a2d27120ba..41f6362a0428 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -335,7 +335,7 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 		inode_set_mtime_to_ts(inode,
 				      inode_set_ctime_to_ts(inode, fat_truncate_mtime(sbi, now)));
 
-	return 0;
+	return 1;
 }
 EXPORT_SYMBOL_GPL(fat_truncate_time);
 
@@ -343,18 +343,15 @@ int fat_update_time(struct inode *inode, int flags)
 {
 	int dirty_flags = 0;
 
-	if (inode->i_ino == MSDOS_ROOT_INO)
-		return 0;
-
-	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
-		fat_truncate_time(inode, NULL, flags);
+	if (fat_truncate_time(inode, NULL, flags)) {
 		if (inode->i_sb->s_flags & SB_LAZYTIME)
 			dirty_flags |= I_DIRTY_TIME;
 		else
 			dirty_flags |= I_DIRTY_SYNC;
+
+		__mark_inode_dirty(inode, dirty_flags);
 	}
 
-	__mark_inode_dirty(inode, dirty_flags);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fat_update_time);
-- 
2.43.0


