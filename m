Return-Path: <linux-kernel+bounces-862649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D5BF5D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F52188F420
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2627E2DFA21;
	Tue, 21 Oct 2025 10:38:42 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B729ACD7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043121; cv=none; b=X8A6DVOmQ9YAY9ZoAvA7Bt8d8cRjMsitbPzfCnHfl6pp3CXNFpwEjdw6xzDNyFLTFzodRqCvgiaIvEMovE33A+SfI99h2jy/i53dxTCHNHFhCwU33/qMtykiBxngfcRbnEdN4fZVQQsBEr/BJlKrQ2Sm49IeAssY+vMJtEbbBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043121; c=relaxed/simple;
	bh=m6LtaOPjDuKE9+CIi+VZ0gDP2hqWyqRiXZ2VT+5Db/k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=dIvulyxchBXdS+/Sfda8yJuZaSW8zZQpH4DAJb1Mb8KJrY7pCOTP3gKD6Y5PKLejYo1s/C00dtdhQx8mUJD4thkdrBiEYjJxMqxqzUwUA9w7nzqhLUd7ajM4UnoSEstVDrpFlZ21Xk6yK4DK95j2yJRhCnRSewCZhU5hqOmpY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59LAcXs6002071;
	Tue, 21 Oct 2025 19:38:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59LAcXEI002068
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 21 Oct 2025 19:38:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8950a6e1-287c-43c7-b36a-cc42ca7e267c@I-love.SAKURA.ne.jp>
Date: Tue, 21 Oct 2025 19:38:29 +0900
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
 <7b1f58cb-d42f-4357-816b-22d65792f041@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <7b1f58cb-d42f-4357-816b-22d65792f041@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..097c0dd24000 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1521,7 +1521,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
 			struct block_device *fs_dev,
 			unsigned long long start, int len, int blocksize)
 {
-	static struct lock_class_key jbd2_trans_commit_key;
 	journal_t *journal;
 	int err;
 	int n;
@@ -1530,6 +1529,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal)
 		return ERR_PTR(-ENOMEM);
 
+	lockdep_register_key(&journal->jbd2_trans_commit_key);
+	lockdep_register_key(&journal->j_abort_mutex_key);
+	mutex_init_with_key(&journal->j_abort_mutex, &journal->j_abort_mutex_key);
+	lockdep_register_key(&journal->j_barrier_key);
+	mutex_init_with_key(&journal->j_barrier, &journal->j_barrier_key);
+	lockdep_register_key(&journal->j_checkpoint_mutex_key);
+	mutex_init_with_key(&journal->j_checkpoint_mutex, &journal->j_checkpoint_mutex_key);
 	journal->j_blocksize = blocksize;
 	journal->j_dev = bdev;
 	journal->j_fs_dev = fs_dev;
@@ -1547,9 +1553,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
 	init_waitqueue_head(&journal->j_fc_wait);
-	mutex_init(&journal->j_abort_mutex);
-	mutex_init(&journal->j_barrier);
-	mutex_init(&journal->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
 	spin_lock_init(&journal->j_list_lock);
 	spin_lock_init(&journal->j_history_lock);
@@ -1560,7 +1563,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
 	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
+			 &journal->jbd2_trans_commit_key, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1611,6 +1614,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	kfree(journal->j_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	journal_fail_superblock(journal);
+	mutex_destroy(&journal->j_abort_mutex);
+	lockdep_unregister_key(&journal->j_abort_mutex_key);
+	mutex_destroy(&journal->j_barrier);
+	lockdep_unregister_key(&journal->j_barrier_key);
+	mutex_destroy(&journal->j_checkpoint_mutex);
+	lockdep_unregister_key(&journal->j_checkpoint_mutex_key);
+	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
 	kfree(journal);
 	return ERR_PTR(err);
 }
@@ -2187,6 +2197,13 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
+	mutex_destroy(&journal->j_abort_mutex);
+	lockdep_unregister_key(&journal->j_abort_mutex_key);
+	mutex_destroy(&journal->j_barrier);
+	lockdep_unregister_key(&journal->j_barrier_key);
+	mutex_destroy(&journal->j_checkpoint_mutex);
+	lockdep_unregister_key(&journal->j_checkpoint_mutex_key);
+	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
 	kfree(journal);
 
 	return err;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..c6d497219e1c 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1253,6 +1253,30 @@ struct journal_s
 	 */
 	struct lockdep_map	j_trans_commit_map;
 #endif
+	/**
+	 * @jbd2_trans_commit_key:
+	 *
+	 * "struct lock_class_key" for @j_trans_commit_map
+	 */
+	struct lock_class_key	jbd2_trans_commit_key;
+	/**
+	 * @j_abort_mutex_key:
+	 *
+	 * "struct lock_class_key" for @j_abort_mutex
+	 */
+	struct lock_class_key	j_abort_mutex_key;
+	/**
+	 * @j_barrier_key:
+	 *
+	 * "struct lock_class_key" for @j_barrier
+	 */
+	struct lock_class_key	j_barrier_key;
+	/**
+	 * @j_checkpoint_mutex_key:
+	 *
+	 * "struct lock_class_key" for @j_checkpoint_mutex
+	 */
+	struct lock_class_key	j_checkpoint_mutex_key;
 
 	/**
 	 * @j_fc_cleanup_callback:


