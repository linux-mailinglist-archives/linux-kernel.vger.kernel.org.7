Return-Path: <linux-kernel+bounces-860992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62211BF1888
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D43189E070
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01091A5B92;
	Mon, 20 Oct 2025 13:27:42 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8A19992C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966862; cv=none; b=HHzuArVMWkvXFyWR5kpduITe7Hlzjm2lPdZfQBQ0PNpLeaMrIf5a/JMH2S1KMbBcqCmy9R3fdScuM8wdbeldNiVygg7aWUrV5HCiYLA6PCoTFNvJHfInuIo11NL7GOTM8hnXxT+OHEmnXFYp/aiMNh3Ib4s6GZI5+q35mTGSvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966862; c=relaxed/simple;
	bh=8U5kTSgjAlQyRhN0BVNhalNdEU/HO5eay9DPI7c6MPI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tutFb78CnW2FjPD04PmGCIUt53huM2rbH0aBIRW0CKXCNcB2lldmkdprxQdLca0Xok1K8Drq3pJs8lshJ80xpmPiwge+EUc5/+iqz1MCg41n9h+PA+0lPzuy9LdPnbGXhIb3BTUlpaoEEUh8d9rZEwrG9GYs6/RAvMrrqQtHt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59KDRY2k075533;
	Mon, 20 Oct 2025 22:27:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59KDRYY4075524
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Oct 2025 22:27:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7b1f58cb-d42f-4357-816b-22d65792f041@I-love.SAKURA.ne.jp>
Date: Mon, 20 Oct 2025 22:27:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ext4?] [ocfs2?] possible deadlock in dqget
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <66fbae37.050a0220.6bad9.0050.GAE@google.com>
 <76a62d90-d13f-4657-8a38-2a07abc83c65@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <76a62d90-d13f-4657-8a38-2a07abc83c65@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529..bd50ac035342 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -60,6 +60,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ext4.h>
 
+static struct jbd2_lock_class_keys jbd2_ext4_lock_class_keys = { .name = "jbd2_ext4_handle" };
+
 static struct ext4_lazy_init *ext4_li_info;
 static DEFINE_MUTEX(ext4_li_mtx);
 static struct ratelimit_state ext4_mount_msg_ratelimit;
@@ -5859,7 +5861,7 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
 	if (IS_ERR(journal_inode))
 		return ERR_CAST(journal_inode);
 
-	journal = jbd2_journal_init_inode(journal_inode);
+	journal = jbd2_journal_init_inode(journal_inode, &jbd2_ext4_lock_class_keys);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "Could not load journal inode");
 		iput(journal_inode);
@@ -5964,7 +5966,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 		return ERR_CAST(bdev_file);
 
 	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
-					j_len, sb->s_blocksize);
+					j_len, sb->s_blocksize, &jbd2_ext4_lock_class_keys);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
 		errno = PTR_ERR(journal);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..821d440ce17a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1517,11 +1517,10 @@ static int journal_load_superblock(journal_t *journal)
  * superblock and initialize the journal_t object.
  */
 
-static journal_t *journal_init_common(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+static journal_t *journal_init_common(struct block_device *bdev, struct block_device *fs_dev,
+				      unsigned long long start, int len, int blocksize,
+				      struct jbd2_lock_class_keys *keys)
 {
-	static struct lock_class_key jbd2_trans_commit_key;
 	journal_t *journal;
 	int err;
 	int n;
@@ -1547,9 +1546,9 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
 	init_waitqueue_head(&journal->j_fc_wait);
-	mutex_init(&journal->j_abort_mutex);
-	mutex_init(&journal->j_barrier);
-	mutex_init(&journal->j_checkpoint_mutex);
+	mutex_init_with_key(&journal->j_abort_mutex, &keys->j_abort_mutex);
+	mutex_init_with_key(&journal->j_barrier, &keys->j_barrier);
+	mutex_init_with_key(&journal->j_checkpoint_mutex, &keys->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
 	spin_lock_init(&journal->j_list_lock);
 	spin_lock_init(&journal->j_history_lock);
@@ -1559,8 +1558,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_min_batch_time = 0;
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
-	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
+	lockdep_init_map(&journal->j_trans_commit_map, keys->name,
+			 &keys->jbd2_trans_commit_key, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1631,6 +1630,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  @start: Block nr Start of journal.
  *  @len:  Length of the journal in blocks.
  *  @blocksize: blocksize of journalling device
+ *  @keys: Pointer to struct jbd2_lock_class_keys for lockdep annotation
  *
  *  Returns: a newly created journal_t *
  *
@@ -1638,13 +1638,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  range of blocks on an arbitrary block device.
  *
  */
-journal_t *jbd2_journal_init_dev(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+				 unsigned long long start, int len, int blocksize,
+				 struct jbd2_lock_class_keys *keys)
 {
 	journal_t *journal;
 
-	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
+	journal = journal_init_common(bdev, fs_dev, start, len, blocksize, keys);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
@@ -1664,7 +1664,7 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
  * the journal.  The inode must exist already, must support bmap() and
  * must have all data blocks preallocated.
  */
-journal_t *jbd2_journal_init_inode(struct inode *inode)
+journal_t *jbd2_journal_init_inode(struct inode *inode, struct jbd2_lock_class_keys *keys)
 {
 	journal_t *journal;
 	sector_t blocknr;
@@ -1682,8 +1682,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
 	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
-			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
-			inode->i_sb->s_blocksize);
+				      blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
+				      inode->i_sb->s_blocksize, keys);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index e5f58ff2175f..e92746e3cb0b 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -43,6 +43,8 @@
 
 DEFINE_SPINLOCK(trans_inc_lock);
 
+static struct jbd2_lock_class_keys jbd2_ocfs2_lock_class_keys = { .name = "jbd2_ocfs2_handle" };
+
 #define ORPHAN_SCAN_SCHEDULE_TIMEOUT 300000
 
 static int ocfs2_force_read_journal(struct inode *inode);
@@ -968,7 +970,7 @@ int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
 				 OCFS2_I(inode)->ip_clusters);
 
 	/* call the kernels journal init function now */
-	j_journal = jbd2_journal_init_inode(inode);
+	j_journal = jbd2_journal_init_inode(inode, &jbd2_ocfs2_lock_class_keys);
 	if (IS_ERR(j_journal)) {
 		mlog(ML_ERROR, "Linux journal layer error\n");
 		status = PTR_ERR(j_journal);
@@ -1759,7 +1761,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 		goto done;
 	}
 
-	journal = jbd2_journal_init_inode(inode);
+	journal = jbd2_journal_init_inode(inode, &jbd2_ocfs2_lock_class_keys);
 	if (IS_ERR(journal)) {
 		mlog(ML_ERROR, "Linux journal layer error\n");
 		status = PTR_ERR(journal);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..7ecfc7f7be62 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1287,6 +1287,14 @@ struct journal_s
 	int (*j_bmap)(struct journal_s *journal, sector_t *block);
 };
 
+struct jbd2_lock_class_keys {
+	const char *name;
+	struct lock_class_key jbd2_trans_commit_key;
+	struct lock_class_key j_abort_mutex;
+	struct lock_class_key j_barrier;
+	struct lock_class_key j_checkpoint_mutex;
+};
+
 #define jbd2_might_wait_for_commit(j) \
 	do { \
 		rwsem_acquire(&j->j_trans_commit_map, 0, 0, _THIS_IP_); \
@@ -1523,10 +1531,10 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
 
-extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
-				struct block_device *fs_dev,
-				unsigned long long start, int len, int bsize);
-extern journal_t * jbd2_journal_init_inode (struct inode *);
+extern journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+					unsigned long long start, int len, int bsize,
+					struct jbd2_lock_class_keys *keys);
+extern journal_t *jbd2_journal_init_inode(struct inode *inode, struct jbd2_lock_class_keys *keys);
 extern int	   jbd2_journal_update_format (journal_t *);
 extern int	   jbd2_journal_check_used_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);


