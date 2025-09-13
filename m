Return-Path: <linux-kernel+bounces-815149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 119BCB5604A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E0E1C82CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587EF2367A0;
	Sat, 13 Sep 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQZyTZbN"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5918E25
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757760035; cv=none; b=l7p78IIZ4SkZWEiMo2XBh/I4S8sVOrJL/wpg15mduOxCk6NHpbksNKH7tLTkatr0E9cZ8+BKLarG2adtFtoUTR/qJxGJYwwYwf5DXroBQfzacnEdD+XKwXAkvRZCz/MYaXNKSc1PVhaNSw01ghg9at+PvkPMtQP4RMPoyRHaXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757760035; c=relaxed/simple;
	bh=7kwY4K3spBa+KkC0kt2vnh741tWhEjIo0BO1Ky8KVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udROM4g2F1yolhHkFeW+roQ7tmAtEUSmzsSl93w+BhUehk/AQrAFRDUEQ30IRxnTgJBwdXvxg9R1okkY7D1z3/Xdt0ZTNTFk2mgwCgEcBycj2nXXO4z12utO/pVKf842wV6TDcQ2XJOPO+pf5TgdNUeF2t6osyL1YETcsF3jo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQZyTZbN; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757760021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bROeHm5yLYSDjWrQN66sseRBMeR9fQM3QsxmZdeOcXQ=;
	b=oQZyTZbNyW/V3QofscmZ36jTcOBrwoxdDW+F5I4yeeWfEE1HrGuUapma1InOUtDCIgIfgh
	yZSf1e8xOKvILCOIH80InZ9gQD48TeJYYVo9aT89UPE9YEvcYy3um3oqYKkSdqdyc+qrOK
	P7QFy8e6rOatT2OcdhZJs6RPaKzAZ1M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initrd: Fix logged Minix/Ext2 block numbers in identify_ramdisk_image()
Date: Sat, 13 Sep 2025 12:39:54 +0200
Message-ID: <20250913103959.1788193-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Both Minix and Ext2 filesystems are located at 'start_block + 1'. Update
the log messages to report the correct block numbers.

Replace printk(KERN_NOTICE) with pr_notice() to avoid checkpatch
warnings.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/do_mounts_rd.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..9283fdd605f0 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -148,9 +148,8 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	/* Try minix */
 	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
 	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
-		printk(KERN_NOTICE
-		       "RAMDISK: Minix filesystem found at block %d\n",
-		       start_block);
+		pr_notice("RAMDISK: Minix filesystem found at block %d\n",
+			  start_block + 1);
 		nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
 		goto done;
 	}
@@ -158,9 +157,8 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	/* Try ext2 */
 	n = ext2_image_size(buf);
 	if (n) {
-		printk(KERN_NOTICE
-		       "RAMDISK: ext2 filesystem found at block %d\n",
-		       start_block);
+		pr_notice("RAMDISK: ext2 filesystem found at block %d\n",
+			  start_block + 1);
 		nblocks = n;
 		goto done;
 	}
-- 
2.51.0


