Return-Path: <linux-kernel+bounces-870911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E096C0BF76
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725EF1898503
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606E262D27;
	Mon, 27 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSk+gYhF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7423A98D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546942; cv=none; b=tbW7pXql1pfCnXNHLLkc5dooVMIwVqVcFXqdyH0n0A5+74ngHRGcEV39ED/RxeRWwJdfUxVGOMSanPpBqpAyxoJT5edtBxfe/UyDLPh0O362xLSaMsJ4N5/SarOZt2Hp6jCQFhngPehnuTiD3wm1I7TeR8nXjfoWKzR4WXd1gg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546942; c=relaxed/simple;
	bh=cnBqocTIBv8pGbbaja/xhKcMkS3FBNsTkcmNkQBJ9wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcsNbe9x+ixU99jn1mTrXn8q/ABO99COD9VzPgPBYhem2+1UI0Q5wEe2NQlbWhorj0P499zVPByYMUIYsMEereFnDs3Ui4G6z3WBRyv1ZqeFiYwadM7r5R3z84rBBPX22xRWm/OPZeyq2uAcd1wypBxb9KaWXwhwA3dSFaB1NZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSk+gYhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8DFC4CEF1;
	Mon, 27 Oct 2025 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761546941;
	bh=cnBqocTIBv8pGbbaja/xhKcMkS3FBNsTkcmNkQBJ9wo=;
	h=From:To:Cc:Subject:Date:From;
	b=qSk+gYhFG82ig+uHN6equxn0vON1oq5UwEol69lKu85esFFMCbEPfaGf8bK/uL68h
	 /5R23loauus+AfHU/d8aNaUGl/nQ/W2OoQioWCrpqsE0K7RLPaLebjhSgV36J0L27C
	 EjOBO6ivOiI1q0hrD7n6Zy22pIJ1gtJZdoujtlpQuvO1+fWyfPtaVDLIzx+6fZ/7+m
	 FVmcgnYeBpsadN057saAUWyf7KVQZgw6JjWuPFLzO95h8gJO7Yc0OpJzmnc8p4ZCVA
	 alm3vRVwLvsAU69N3wZqUdW3U+6lM6H7oNdUgr/XCQ0vogUYMdMa0hoAbsm/w3hC60
	 UQD1xwjTI/XKA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org
Subject: [PATCH 1/2] f2fs: fix to propagate error from f2fs_enable_checkpoint()
Date: Mon, 27 Oct 2025 14:35:33 +0800
Message-ID: <20251027063534.103963-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to let userspace detect such error rather than suffering
silent failure.

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6e52e36c1f1a..65b6269ca1dc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2633,10 +2633,11 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
+static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
 	long long start, writeback, end;
+	int ret;
 
 	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
 					get_pages(sbi, F2FS_DIRTY_META),
@@ -2670,7 +2671,9 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write(&sbi->gc_lock);
 
-	f2fs_sync_fs(sbi->sb, 1);
+	ret = f2fs_sync_fs(sbi->sb, 1);
+	if (ret)
+		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
 
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
@@ -2680,6 +2683,7 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_info(sbi, "f2fs_enable_checkpoint() finishes, writeback:%llu, sync:%llu",
 					ktime_ms_delta(writeback, start),
 					ktime_ms_delta(end, writeback));
+	return ret;
 }
 
 static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
@@ -2893,7 +2897,9 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 				goto restore_discard;
 			need_enable_checkpoint = true;
 		} else {
-			f2fs_enable_checkpoint(sbi);
+			err = f2fs_enable_checkpoint(sbi);
+			if (err)
+				goto restore_discard;
 			need_disable_checkpoint = true;
 		}
 	}
@@ -2936,7 +2942,8 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	return 0;
 restore_checkpoint:
 	if (need_enable_checkpoint) {
-		f2fs_enable_checkpoint(sbi);
+		if (f2fs_enable_checkpoint(sbi))
+			f2fs_warn(sbi, "checkpoint has not been enabled");
 	} else if (need_disable_checkpoint) {
 		if (f2fs_disable_checkpoint(sbi))
 			f2fs_warn(sbi, "checkpoint has not been disabled");
@@ -5258,13 +5265,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto sync_free_meta;
 
-	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+	if (test_opt(sbi, DISABLE_CHECKPOINT))
 		err = f2fs_disable_checkpoint(sbi);
-		if (err)
-			goto sync_free_meta;
-	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
-		f2fs_enable_checkpoint(sbi);
-	}
+	else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG))
+		err = f2fs_enable_checkpoint(sbi);
+	if (err)
+		goto sync_free_meta;
 
 	/*
 	 * If filesystem is not mounted as read-only then
-- 
2.49.0


