Return-Path: <linux-kernel+bounces-898065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D5C544FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95D14F5070
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFB934DB67;
	Wed, 12 Nov 2025 19:36:53 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8934DB54
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976213; cv=none; b=hK6YFW+Wd81qWJIEURFTiLRqeKaSZleeju0i2WFpcHOQ7+0E8wcPL63N/0qSTWRNuq4bz9vbMLX06NfWPjCRy4t3m57c1LdVmATUX/Y2eMOssUAo0+QTRVPKbQ1hrYJ+TfvT0hvRELAuYByfhU7u3cC3Y0DEoxgTVyTBtK6/9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976213; c=relaxed/simple;
	bh=DF+MVdRWcVUZ/4TkEyR6yaW+AaoXs/sGpAXtLMqbLGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CS8NC0amWpGPztCidmaRAAWCEZKo224Q6AiYR4N82VfAQgDcEBEk/p2KJ0z+Zk1ATc3k/TtfnIY3hj0k56BIK9bAHlYCyf1lc4Ev5Kq+eo3yuP1w7aPZb1DT//8VvnJMbA46+SbaLkx3K9kYRnkUFcVzFG4MG+KYFOFgYH0rvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3448521B61;
	Wed, 12 Nov 2025 19:36:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A3A73EA61;
	Wed, 12 Nov 2025 19:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJW8BcnhFGm+YgAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 12 Nov 2025 19:36:41 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v6 1/8] btrfs: disable various operations on encrypted inodes
Date: Wed, 12 Nov 2025 20:36:01 +0100
Message-ID: <20251112193611.2536093-2-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112193611.2536093-1-neelx@suse.com>
References: <20251112193611.2536093-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3448521B61
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

From: Omar Sandoval <osandov@osandov.com>

Initially, only normal data extents will be encrypted. This change
forbids various other bits:
- allows reflinking only if both inodes have the same encryption status
- disable inline data on encrypted inodes

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
v5 was 'Reviewed-by: Boris Burkov <boris@bur.io>' [1] but the rebase
changed the code a bit so dropping.

[1] https://lore.kernel.org/linux-btrfs/20240124195303.GC1789919@zen.localdomain/
---
 fs/btrfs/inode.c   | 4 ++++
 fs/btrfs/reflink.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8737914e8552..b810e831fc23 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -592,6 +592,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	if (size < i_size_read(&inode->vfs_inode))
 		return false;
 
+	/* Encrypted file cannot be inlined. */
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return false;
+
 	return true;
 }
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 775a32a7953a..3c9c570d6493 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/blkdev.h>
+#include <linux/fscrypt.h>
 #include <linux/iversion.h>
 #include "ctree.h"
 #include "fs.h"
@@ -789,6 +790,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		ASSERT(inode_in->vfs_inode.i_sb == inode_out->vfs_inode.i_sb);
 	}
 
+	/*
+	 * Can only reflink encrypted files if both files are encrypted.
+	 */
+	if (IS_ENCRYPTED(&inode_in->vfs_inode) != IS_ENCRYPTED(&inode_out->vfs_inode))
+		return -EINVAL;
+
 	/* Don't make the dst file partly checksummed */
 	if ((inode_in->flags & BTRFS_INODE_NODATASUM) !=
 	    (inode_out->flags & BTRFS_INODE_NODATASUM)) {
-- 
2.51.0


