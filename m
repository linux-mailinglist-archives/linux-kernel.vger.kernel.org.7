Return-Path: <linux-kernel+bounces-874462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C34C1664F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D54FE8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A934C820;
	Tue, 28 Oct 2025 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxhjmmrw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8623D2A3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674776; cv=none; b=X5gahGY8zcbD04nYDwjy0f5dr5Iv20dAioINn1Fv06eFzieSDpoch/R5l0HEoV456iI4kLJHw7VtRqcN1wCnnzABFDigeqp5iDXlCOWblI0GF1KlH8/+7hw5oayG+O2ZRdLzGBkKhpPRBuFdM8eDNruucpRuv8I1b1EDZ67DxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674776; c=relaxed/simple;
	bh=gqjXzQwjIIkD9IpQ+kDj6XXKiUnNxxmvMSC7CWvzBxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3fEMKfm+DDmAG6KFf4hRJrtaeYWYSx1SAqx3OHW5O5EhKxuQHi7DumNvK9DCa0yvzYF+VynSCPr3UggkRmEhG0CygrkEWNU0SVFkkOD7fs9JxGQSIdFkniDEA5AR2GKKsrZLYXRUQRv4VPbUPeKo9jUIhq8YL10H+mD5wJJzHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxhjmmrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E352C4CEE7;
	Tue, 28 Oct 2025 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761674775;
	bh=gqjXzQwjIIkD9IpQ+kDj6XXKiUnNxxmvMSC7CWvzBxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rxhjmmrw912PiJlxFLwH5DJOyDz3ys0GYWZNsprPyAAGeB6C0A92jzRmRn3O+pIbn
	 lfyfD4q36CIfQmPEIcaGV/WfIy/5krYJlPQixHK3vKPJ59GF0JkeUWCS7RkLzTO2/O
	 87BKSS6mdwGAJztEBwwqHfdddOmbRI2uTpupc70+7ykqadWARbBFJObIBvF3Pp7h8/
	 /xBP8MDm21BzmsAqWwlJcAAnbFqKpcWSjugm0cADiu0WSJRfOCjtlcrdbJsSlVTLlf
	 H5Vlk63FBktZPKW4yEPgjtfBeXOzi0JtMYnLc7DYHRgxIbZOjEcZ/qUdzUHUAiKL/2
	 N/WBTxsg6WTJQ==
Date: Tue, 28 Oct 2025 18:06:13 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Jan Prusakowski <jprusakowski@google.com>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: ensure node page reads complete before
 f2fs_put_super() finishes
Message-ID: <aQEGFWy7AmP2RcVM@google.com>
References: <20251006084615.2585252-1-jprusakowski@google.com>
 <c4643bb6-882a-4229-b938-e94398294905@kernel.org>
 <aOkuA_Ffq2klE5g6@google.com>
 <ac1bcf67-cc5f-4288-a2f3-c4fb6013c38a@kernel.org>
 <aPEvpeM_cXWcxcZe@google.com>
 <b4a0af34-bd8b-4130-a96f-6aacbe0fb576@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a0af34-bd8b-4130-a96f-6aacbe0fb576@kernel.org>

Testing this patch:

Xfstests generic/335, generic/336 sometimes crash with the following message:

F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
------------[ cut here ]------------
kernel BUG at fs/f2fs/super.c:1939!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:f2fs_put_super+0x3b3/0x3c0
Call Trace:
 <TASK>
 generic_shutdown_super+0x7e/0x190
 kill_block_super+0x1a/0x40
 kill_f2fs_super+0x9d/0x190
 deactivate_locked_super+0x30/0xb0
 cleanup_mnt+0xba/0x150
 task_work_run+0x5c/0xa0
 exit_to_user_mode_loop+0xb7/0xc0
 do_syscall_64+0x1ae/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
---[ end trace 0000000000000000 ]---

It appears that sometimes it is possible that f2fs_put_super() is called before
all node page reads are completed.
Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.

Fixes: 20872584b8c0b ("f2fs: fix to drop all dirty meta/node pages during umount()")
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bdb5ddb4f966..0b0ef8ba243b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1989,14 +1989,6 @@ static void f2fs_put_super(struct super_block *sb)
 		truncate_inode_pages_final(META_MAPPING(sbi));
 	}
 
-	for (i = 0; i < NR_COUNT_TYPE; i++) {
-		if (!get_pages(sbi, i))
-			continue;
-		f2fs_err(sbi, "detect filesystem reference count leak during "
-			"umount, type: %d, count: %lld", i, get_pages(sbi, i));
-		f2fs_bug_on(sbi, 1);
-	}
-
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
 	f2fs_destroy_compress_inode(sbi);
@@ -2007,6 +1999,15 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	/* Should check the page counts after dropping all node/meta pages */
+	for (i = 0; i < NR_COUNT_TYPE; i++) {
+		if (!get_pages(sbi, i))
+			continue;
+		f2fs_err(sbi, "detect filesystem reference count leak during "
+			"umount, type: %d, count: %lld", i, get_pages(sbi, i));
+		f2fs_bug_on(sbi, 1);
+	}
+
 	/*
 	 * iput() can update stat information, if f2fs_write_checkpoint()
 	 * above failed with error.
-- 
2.51.1.851.g4ebd6896fd-goog


