Return-Path: <linux-kernel+bounces-815240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF200B56198
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7618FAA3B09
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6012A2EE294;
	Sat, 13 Sep 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="buvBGjOW"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831C1E515
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774055; cv=none; b=H/cNj6H+hLiEpejd25+kWgkdPXvrm8yv3VwaRiJ1sLtKB4AtaGUK93GkJ8FDBDJ+pL30qYSwjPlImv4N6AaGzf/RbLfANtE7sV87bRCzjmzecIEJxL0xd/9RYSSuPd6ynKj0o3acNFsx7sIqqltpbjGMfOH/wPmg/QIbJBK5IIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774055; c=relaxed/simple;
	bh=a1haQ6Fet/rTCQhy4Gs2PNfYQlgB/s6f3z2AhrX0E3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNW4hmI2VSpD95vCdAo/hOVmK54oknQZbTXMwvYMCa2Uwu1hU64+HeGCvuBdR4CFd3HGzdj9/XYM3IDsaSdmH6ZQQv/RBsEJCZdegxmYdgCmKePNWy6LluC3ao4X055+0Niv3y6SEhTtg/g5rOQkDS3jbxNYt0wRYZ2QsDjYl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=buvBGjOW; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757774049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=38c0O4DHueNfAwuKXk6VkV6MVbgVvv01gGk4jrB3i9c=;
	b=buvBGjOWYZM5PY8vjnlXTFHSW7X+4XiObpo/Q+26eYQKiMRcSewVluLHf0lpN+uE935p9x
	QyzpKFDZT/GqrJGw4aCHDQhRZcHu/+gcNfdGNfqUZauZmHzbeSRmFbzs9k2Ua/14c9YSBe
	xdrZketrH4I3VUp7ilIJDtLokZu+Q2E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initrd: Remove unused parameter 'pos' from identify_ramdisk_image()
Date: Sat, 13 Sep 2025 16:33:02 +0200
Message-ID: <20250913143300.1796122-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit bef173299613 ("initrd: switch initrd loading to struct file based
APIs") added the parameter 'loff_t pos' to the identify_ramdisk_image()
function and passed 'in_pos' from rd_load_image(). However, the passed
value is immediately overwritten inside identify_ramdisk_image() and
therefore never used.

Replace the function parameter with a local variable and update the call
site accordingly.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/do_mounts_rd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 9283fdd605f0..2085c864e9ca 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -55,8 +55,7 @@ static int __init crd_load(decompress_fn deco);
  *	lz4
  */
 static int __init
-identify_ramdisk_image(struct file *file, loff_t pos,
-		decompress_fn *decompressor)
+identify_ramdisk_image(struct file *file, decompress_fn *decompressor)
 {
 	const int size = 512;
 	struct minix_super_block *minixsb;
@@ -68,6 +67,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	const char *compress_name;
 	unsigned long n;
 	int start_block = rd_image_start;
+	loff_t pos;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
@@ -202,7 +202,7 @@ int __init rd_load_image(char *from)
 		goto noclose_input;
 
 	in_pos = rd_image_start * BLOCK_SIZE;
-	nblocks = identify_ramdisk_image(in_file, in_pos, &decompressor);
+	nblocks = identify_ramdisk_image(in_file, &decompressor);
 	if (nblocks < 0)
 		goto done;
 
-- 
2.51.0


