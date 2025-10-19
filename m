Return-Path: <linux-kernel+bounces-859594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10DBEE0BC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0797E189A20F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974529D276;
	Sun, 19 Oct 2025 08:33:31 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAE29CB3A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760862811; cv=none; b=qfY4hFwmW8teuXRVwobh3QsgshV3FRdmNe2uydfiu8xhN32ksAl5zfAmz7X5sTvOpUK2hp69SGcMfVZf6ODh2q6WDoDNN++C0pyM4yJGpIbBLBaX77DOmI0o7n0QGCimJB3z8HfBb72k30fhM1tTtdikiPSvKmbriNVaEPmCmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760862811; c=relaxed/simple;
	bh=R+OYe+QE2MzZ1LQPfmsKrjbz2yVZS/QtUsqHWnkQDIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nSiwXSi6+udGcBtnQvG/TREEB16YL33B/3DhUwRV+MzRICkyzyngIIlnHZ/bYdVqlyTHeeVnPAvnsXqxRFhBXxG+bfwQzUJwJgh/tYlToiHQt9WfCAZVA1PfRlxBEIo1NZDEEkbd2AAU58iKUABvJyK68o0IfNqMnySN+XOCFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59J8XJjU046805;
	Sun, 19 Oct 2025 17:33:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59J8XIKi046802
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 19 Oct 2025 17:33:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <76a62d90-d13f-4657-8a38-2a07abc83c65@I-love.SAKURA.ne.jp>
Date: Sun, 19 Oct 2025 17:33:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ext4?] [ocfs2?] possible deadlock in dqget
To: syzbot <syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <66fbae37.050a0220.6bad9.0050.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <66fbae37.050a0220.6bad9.0050.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 699c15db28a8..71c1cb792e2d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5956,7 +5956,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 		return ERR_CAST(bdev_file);
 
 	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
-					j_len, sb->s_blocksize);
+					j_len, sb->s_blocksize, EXT4_SUPER_MAGIC);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
 		errno = PTR_ERR(journal);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..2f4fbd74cf76 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1517,11 +1517,13 @@ static int journal_load_superblock(journal_t *journal)
  * superblock and initialize the journal_t object.
  */
 
-static journal_t *journal_init_common(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+static journal_t *journal_init_common(struct block_device *bdev, struct block_device *fs_dev,
+				      unsigned long long start, int len, int blocksize,
+				      unsigned long fsmagic)
 {
-	static struct lock_class_key jbd2_trans_commit_key;
+	static struct lock_class_key jbd2_trans_commit_key_ext4;
+	static struct lock_class_key jbd2_trans_commit_key_ocfs2;
+	static struct lock_class_key jbd2_trans_commit_key_unknown;
 	journal_t *journal;
 	int err;
 	int n;
@@ -1547,20 +1549,49 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
 	init_waitqueue_head(&journal->j_fc_wait);
-	mutex_init(&journal->j_abort_mutex);
-	mutex_init(&journal->j_barrier);
-	mutex_init(&journal->j_checkpoint_mutex);
-	spin_lock_init(&journal->j_revoke_lock);
-	spin_lock_init(&journal->j_list_lock);
-	spin_lock_init(&journal->j_history_lock);
-	rwlock_init(&journal->j_state_lock);
+	if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
+	    fsmagic == EXT4_SUPER_MAGIC) {
+		mutex_init(&journal->j_abort_mutex);
+		mutex_init(&journal->j_barrier);
+		mutex_init(&journal->j_checkpoint_mutex);
+		spin_lock_init(&journal->j_revoke_lock);
+		spin_lock_init(&journal->j_list_lock);
+		spin_lock_init(&journal->j_history_lock);
+		rwlock_init(&journal->j_state_lock);
+	} else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
+		   fsmagic == OCFS2_SUPER_MAGIC) {
+		mutex_init(&journal->j_abort_mutex);
+		mutex_init(&journal->j_barrier);
+		mutex_init(&journal->j_checkpoint_mutex);
+		spin_lock_init(&journal->j_revoke_lock);
+		spin_lock_init(&journal->j_list_lock);
+		spin_lock_init(&journal->j_history_lock);
+		rwlock_init(&journal->j_state_lock);
+	} else {
+		mutex_init(&journal->j_abort_mutex);
+		mutex_init(&journal->j_barrier);
+		mutex_init(&journal->j_checkpoint_mutex);
+		spin_lock_init(&journal->j_revoke_lock);
+		spin_lock_init(&journal->j_list_lock);
+		spin_lock_init(&journal->j_history_lock);
+		rwlock_init(&journal->j_state_lock);
+	}
 
 	journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
 	journal->j_min_batch_time = 0;
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
-	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
+	if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
+	    fsmagic == EXT4_SUPER_MAGIC)
+		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ext4",
+				 &jbd2_trans_commit_key_ext4, 0);
+	else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
+		 fsmagic == OCFS2_SUPER_MAGIC)
+		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ocfs2",
+				 &jbd2_trans_commit_key_ocfs2, 0);
+	else
+		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_unknown",
+				 &jbd2_trans_commit_key_unknown, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1631,6 +1662,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  @start: Block nr Start of journal.
  *  @len:  Length of the journal in blocks.
  *  @blocksize: blocksize of journalling device
+ *  @fsmagic: filesystem magic number for lockdep annotation
  *
  *  Returns: a newly created journal_t *
  *
@@ -1638,13 +1670,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  range of blocks on an arbitrary block device.
  *
  */
-journal_t *jbd2_journal_init_dev(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+				 unsigned long long start, int len, int blocksize,
+				 unsigned long fsmagic)
 {
 	journal_t *journal;
 
-	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
+	journal = journal_init_common(bdev, fs_dev, start, len, blocksize, fsmagic);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
@@ -1682,8 +1714,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
 	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
-			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
-			inode->i_sb->s_blocksize);
+				      blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
+				      inode->i_sb->s_blocksize, inode->i_sb->s_magic);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..a5d6f6ae5a35 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1523,9 +1523,9 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
 
-extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
-				struct block_device *fs_dev,
-				unsigned long long start, int len, int bsize);
+extern journal_t * jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+					 unsigned long long start, int len, int bsize,
+					 unsigned long fsmagic);
 extern journal_t * jbd2_journal_init_inode (struct inode *);
 extern int	   jbd2_journal_update_format (journal_t *);
 extern int	   jbd2_journal_check_used_features


