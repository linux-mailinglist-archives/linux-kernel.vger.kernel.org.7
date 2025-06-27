Return-Path: <linux-kernel+bounces-705689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD84AEAC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4E37B5CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C32F1FEA;
	Fri, 27 Jun 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8a8zCYP"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF85282EE
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750987288; cv=none; b=M7LqIWomEAwwDCsr4ZGvkWdg+YkfKXUI3bHLDcWHrKfyCvsg9XjTaRbAcec0uZsRz1WTzwg/YVMEGzi+1sjLwe3We8aZo/Evm6O4xvTpIwjwqagKMHcfDEoD7PKeiHTLN5T11dQEM+xeN5GgbBr3ucLLjpiAuBsVD65ggFgNgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750987288; c=relaxed/simple;
	bh=fPUzTfP9AgnATrog7EDpS7gKbjel/qnt8w+oAxXMY+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBq1TdhmRuXmkqfqCMll6SAGroLlBThQfXrEsHEh5pR74xoNZl00ZpF0zylk3Kbdorn5bqQbzpdNaZ8sh36HT0SQz8KVnuNXgTqg41OAphNnCd8GynYqT3jt6bPrlva4W8FlK7ngAH0v1UPH3/hHjGBQDLgfnIpoqWXVaPQrFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8a8zCYP; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750987284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA29GrET1XqH1NOTP93DlTk+g6RUVBFJPRRDoDl6g8k=;
	b=n8a8zCYPlXqoQ8QL6UOng+/XX80d/a6klRRhLvP2o5mDqkk9n9MGsdxX72mQqVo5UsfZ/B
	JGtcPcvipIDcYcsezxKiM4Ge76f2kvJ5sfkwI9h+YHEylOXMf+w5mABmWGsoQapc6rzJSl
	4Y+xcNTgyz+zvOhrC2X1VXf75biU/2E=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 2/3] bcachefs: Refactor the handling logic of fallocate mode  in bch2_fallocate_dispatch()
Date: Fri, 27 Jun 2025 09:21:03 +0800
Message-Id: <20250627012104.222703-2-youling.tang@linux.dev>
In-Reply-To: <20250627012104.222703-1-youling.tang@linux.dev>
References: <20250627012104.222703-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

The mode parameter of the fallocate system call is divided into exclusive
mode (FALLOC_FL_MODE_MASK) and optional flag (FALLOC_FL_KEEP_SIZE).

Use FALLOC_FL_MODE_MASK and FALLOC_FL_ALLOCATE_RANGE makes the code more
readable.

Some of the logic has been handled in vfs_fallocate:
- FALLOC_FL_PUNCH_HOLE must exist simultaneously with FALLOC_FL_KEEP_SIZE.
- FALLOC_FL_COLLAPSE_RANGE and FALLOC_FL_INSERT_RANGE cannot exist
  simultaneously with FALLOC_FL_KEEP_SIZE.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs-io.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index 74841b1dc8ca..69d3ddd4c6a1 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -814,6 +814,12 @@ static noinline long bchfs_fallocate(struct bch_inode_info *inode, int mode,
 	return ret ?: ret2;
 }
 
+#define BCH2_FALLOC_FL_SUPPORTED					\
+		(FALLOC_FL_KEEP_SIZE |					\
+		 FALLOC_FL_ALLOCATE_RANGE | FALLOC_FL_PUNCH_HOLE |	\
+		 FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |	\
+		 FALLOC_FL_INSERT_RANGE)
+
 long bch2_fallocate_dispatch(struct file *file, int mode,
 			     loff_t offset, loff_t len)
 {
@@ -824,6 +830,9 @@ long bch2_fallocate_dispatch(struct file *file, int mode,
 	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_fallocate))
 		return -EROFS;
 
+	if (mode & ~BCH2_FALLOC_FL_SUPPORTED)
+		return bch2_err_class(bch_err_throw(c, unsupported_fallocate_mode));
+
 	inode_lock(&inode->v);
 	inode_dio_wait(&inode->v);
 	bch2_pagecache_block_get(inode);
@@ -832,16 +841,24 @@ long bch2_fallocate_dispatch(struct file *file, int mode,
 	if (ret)
 		goto err;
 
-	if (!(mode & ~(FALLOC_FL_KEEP_SIZE|FALLOC_FL_ZERO_RANGE)))
+	switch (mode & FALLOC_FL_MODE_MASK) {
+	case FALLOC_FL_ALLOCATE_RANGE:
+	case FALLOC_FL_ZERO_RANGE:
 		ret = bchfs_fallocate(inode, mode, offset, len);
-	else if (mode == (FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE))
+		break;
+	case FALLOC_FL_PUNCH_HOLE:
 		ret = bchfs_fpunch(inode, offset, len);
-	else if (mode == FALLOC_FL_INSERT_RANGE)
+		break;
+	case FALLOC_FL_INSERT_RANGE:
 		ret = bchfs_fcollapse_finsert(inode, offset, len, true);
-	else if (mode == FALLOC_FL_COLLAPSE_RANGE)
+		break;
+	case FALLOC_FL_COLLAPSE_RANGE:
 		ret = bchfs_fcollapse_finsert(inode, offset, len, false);
-	else
+		break;
+	default:
 		ret = bch_err_throw(c, unsupported_fallocate_mode);
+		break;
+	}
 err:
 	bch2_pagecache_block_put(inode);
 	inode_unlock(&inode->v);
-- 
2.34.1


