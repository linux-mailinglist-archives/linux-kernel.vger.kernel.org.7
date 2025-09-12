Return-Path: <linux-kernel+bounces-813362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8BB54428
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6104A010D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78232D24AE;
	Fri, 12 Sep 2025 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXVSxDXT"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944E2D1301
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663262; cv=none; b=HPvhOXSMViwT1lOuMyqLImq33yJOanp8/qIoiLM6Piks8mSx1k/BVefkhEsUFicL3NrCotvt8bTgYVBRdBz3lKY21uXJ1Rj13WbDQBMBpjwzY4zx03FI0IMELdnk1A4Sw8damt2B2OrCmtEsbkCvlbPvaceSzcdJUiYptaBouqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663262; c=relaxed/simple;
	bh=fQi2v+MB49anetEhl4DSJd7wULC36mH6t0k3cOI1Tds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKpB/gIvi5g/EemnAE3CBqDD3CW4NI2nnxBx5SOAdrW6XLCmteoTk1xtaiQDvBe9ARTqzTuxpmRaPNr8abAEVGiI06/zo4FJXEzSLUzR2LEHQylPg5gfHXUgLurTuz/sZMGxT7nFFleMGyK3AysXuoOaNcjWz2UyMo95zO4y67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXVSxDXT; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757663248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iYsUYaRyho+OODOc4wNp3ZLTlTz6bMF4CaAzL0A2w/k=;
	b=kXVSxDXT2qVpHv3f+F1BbVcSRGFTsrYbGoJJLRZo9jswrg/oYhfXQ5mo5qv0MlSHQk9CRf
	+IBXISmawk2XRyBVDl1lgqNDplsdM+5Kfnt+pxtwin35dwh9qSAwYMvahefjs5+rr36Y+u
	s9JsBrhjHXFl7iJ55P5Hy0PTuimseGY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initrd: Use str_plural() in rd_load_image()
Date: Fri, 12 Sep 2025 09:46:52 +0200
Message-ID: <20250912074651.1487588-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the local variable 'nr_disks' and replace the manual ternary "s"
pluralization with the standardized str_plural() helper function.

Use pr_notice() instead of printk(KERN_NOTICE) to silence a checkpatch
warning.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/do_mounts_rd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..b8fccc7ffb7d 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -7,6 +7,7 @@
 #include <uapi/linux/cramfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/slab.h>
 
 #include "do_mounts.h"
@@ -186,7 +187,7 @@ static unsigned long nr_blocks(struct file *file)
 int __init rd_load_image(char *from)
 {
 	int res = 0;
-	unsigned long rd_blocks, devblocks;
+	unsigned long rd_blocks, devblocks, nr_disks;
 	int nblocks, i;
 	char *buf = NULL;
 	unsigned short rotate = 0;
@@ -244,8 +245,9 @@ int __init rd_load_image(char *from)
 		goto done;
 	}
 
-	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
-		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
+	nr_disks = (nblocks - 1) / devblocks + 1;
+	pr_notice("RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
+		  nblocks, nr_disks, str_plural(nr_disks));
 	for (i = 0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
 			pr_cont("done disk #1.\n");
-- 
2.51.0


