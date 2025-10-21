Return-Path: <linux-kernel+bounces-863743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C2BF8FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981DD408538
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E89628000F;
	Tue, 21 Oct 2025 22:02:26 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D231C2EA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084145; cv=none; b=n2svWo2PcpLLR4iO+zcMbjcU6GV0wMk0FfMvLMqkdmfUkNWE7RrAF/A03NzEHRrnRhqBSQyxAEHTzcDqtbu2hbKkTU1xxg5i5I/O/Q1gQsVsb9jgekrHMZYcMqTzsIouOM5INNMhgrL9XgR39VdjZEp1pC6B8QFYz2MAdjgxIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084145; c=relaxed/simple;
	bh=sHc2rjrGW8k6XG97o94ZY9cMInSA3ZLNFCD5INZ/s1o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=nMyiLE8m/aI+AspHY0TyubZwlv8ji9IyuXcOFMV+5aUmUfp4p4xUHDfJJxgjVt2jSDvAumYoa92cQoQ3M1+mlSiXQr0M0BgubHvDPi9kgskRb5qT2SXApPSRwPMcJ0y05Ft3ypnDYDEbmMhtMGxLbKaPpc4qiTrfI33ZKS+PQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59LM2BE7059567;
	Wed, 22 Oct 2025 07:02:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59LM2Bsf059562
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Oct 2025 07:02:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <541945e3-c836-42d6-a3ed-64714167186a@I-love.SAKURA.ne.jp>
Date: Wed, 22 Oct 2025 07:02:08 +0900
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
 <8950a6e1-287c-43c7-b36a-cc42ca7e267c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <8950a6e1-287c-43c7-b36a-cc42ca7e267c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..f43474002f50 100644
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
@@ -1530,6 +1529,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal)
 		return ERR_PTR(-ENOMEM);
 
+	lockdep_register_key(&journal->jbd2_trans_commit_key);
 	journal->j_blocksize = blocksize;
 	journal->j_dev = bdev;
 	journal->j_fs_dev = fs_dev;
@@ -1560,7 +1560,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
 	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
+			 &journal->jbd2_trans_commit_key, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1611,6 +1611,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	kfree(journal->j_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	journal_fail_superblock(journal);
+	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
 	kfree(journal);
 	return ERR_PTR(err);
 }
@@ -2187,6 +2188,7 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
+	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
 	kfree(journal);
 
 	return err;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..f5eaf76198f3 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1253,6 +1253,12 @@ struct journal_s
 	 */
 	struct lockdep_map	j_trans_commit_map;
 #endif
+	/**
+	 * @jbd2_trans_commit_key:
+	 *
+	 * "struct lock_class_key" for @j_trans_commit_map
+	 */
+	struct lock_class_key	jbd2_trans_commit_key;
 
 	/**
 	 * @j_fc_cleanup_callback:


