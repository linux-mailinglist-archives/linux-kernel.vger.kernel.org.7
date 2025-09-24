Return-Path: <linux-kernel+bounces-830353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564AB99748
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2EE324A42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B9F2DF71F;
	Wed, 24 Sep 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eoWRumnG"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AD2D8DD9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710426; cv=none; b=byF54DmBnCJNoJYkkiErgo1RzIcYmozrlGjQQeiAWNNv1zu+d+bNNWCOIt1pmeQfWAkafehEFfgYP3Q8KnLsmA58x2uCOG4QZFdKnNF9MQ+hKx/u9NuG0j4oY7ucnh0sPrBY+DHlKdbvwBu+bndIgFke+wfeKhOwZSyfUs+A2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710426; c=relaxed/simple;
	bh=jeX5ftDRwaX3cod3MHo6BdpMnAVXf/aMojH1iG4Eq5k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=R7Cq6oSvzQHonbQm8ivQi2oi7lPG1YqZj7wF5HXVkTgM8cltJAqiPuwAx2udAsIZjcmZ/m6E0TaDtLPAcIJ9Ek2Kc5m4Q9PWBfDCc8M9ovXLGQhijCtiH9UJl7ZSTdtnzAp5fVNh33Fwbtr9m+fcKQd9epGbpcu5/43rNEzQGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eoWRumnG; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758710410; bh=+kV5tWeWcuHHZcGTSmvtUTrsy6QbeKhRnlGtuBpvKfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eoWRumnG/EKwVbJISO3pjFzoXOS4XWTNoXegom200qOSSthFdCYhOMo9RxaD8/hL9
	 858cudoT0XCmlnVMU9dWKWtyPm0OqAVSq3K9UCbiRwGbfPtWo5/RJ35sYpnLKK0NDV
	 TB3NMD3zNlT3RCQ/XGyclke9kT8qh3OUZyOKs2po=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 9B68CA6C; Wed, 24 Sep 2025 18:38:54 +0800
X-QQ-mid: xmsmtpt1758710334taix0o0kg
Message-ID: <tencent_7784EEC92ECA4CBAE7CAC6F592CEC6728906@qq.com>
X-QQ-XMAILINFO: OSwzSWs0onYPe9WhMqeboiuAHU6+62/mKYdrPFoAn1LTOaMRwfU4pWJGtTEpoT
	 omKOTQntf3QusQKAS6IGUVudT0jGF/W5LVoNkHhXYyPiEaprMG0noDT5NhKfSm/q/nen0g6HxzIZ
	 PTW5ryAZduPDBE1e8ZQkcH5s7QpzBPk2Rv+i2qyZzrbSpORCe0fzwVd+StG5yxVXgu+CvRqpKzzG
	 tXh7w1XGIyZLNtA8NMXHmBcUyIhB6AMhFi6gpCcJHkt+EVavw4/a7/yvqotGmuyD82ntsaOi1oDO
	 ay1utbbbgvm5HbxCOK524y1mzpl5FBzvzRhL9q1cAsnDHqp0YUidVd0FZ+e3wwV+RXvKjRZx4jn7
	 42Duf3s7Rq2SqdAd4aSGRS6Y9qXReAyj+g+rxS6YoziEgUKIb9Y8Q7mU5f80/HnvR1AhAnZzHTnl
	 wnQmUKVfoUuPXkB48Ra+R9tMsXkrH8MHzGgvhuR3J1XXrLEbBi3/0AmPs+HRXAWNC2p/0QhJAF1t
	 rwAwDYCyC7WLXkVbmLvh0LMx71hcawjCZ3plV0u+YMCvlpkUYxld11M2ff7+CeLfIQsGqzo0g49O
	 As/h41TBr+Hq7L+zx+RymTI8MamU5c1F9MFk40lpimbL1ql0BONbjaSrUnfR7H/cBwclQon9M3U2
	 Usi5/PtTYJnuf3v+TiKOaAwTbZ0YKivqvkkhK8g8awP+CUTvukeDSbmti0+A1BhgUGMGUby+nAcI
	 dCT8EQ4BNk/LhtocXIT0ZMsh45FehuWXjvw08LsydEkveMMugZ32Q+uE9BGsyBk1GF9E7L+qNQir
	 bydZpV3z/hXXyfTjpfb4csxj3k++63p2aImj2WEcTN1F/u8/OdIpxdOU9dNrRhjpwWA3tkwPe6DQ
	 9G5Pf5aVDDmJdVO95na1QLLxEY4Z5ycPk0ni4EHJQfHQ1uO4TN1TeWF64ov+vLa1K+zOcD8K3/yv
	 2icCPgvbOO3rdjeD5S0kTqXrBfnOJgvtw3UD7QqHM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in hook_sb_delete
Date: Wed, 24 Sep 2025 18:38:53 +0800
X-OQ-MSGID: <20250924103852.1499403-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
References: <68d32659.a70a0220.4f78.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 4ed997f4a663..a18d53507210 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1484,7 +1484,6 @@ static void hook_sb_delete(struct super_block *const sb)
 			 * previous loop walk, which is not needed anymore.
 			 */
 			iput(prev_inode);
-			cond_resched();
 			spin_lock(&sb->s_inode_list_lock);
 		}
 		prev_inode = inode;
diff --git a/kernel/fork.c b/kernel/fork.c
index e9a7fb5c3e49..a0b8eeeb1d27 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2349,7 +2349,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (need_futex_hash_allocate_default(clone_flags)) {
 		retval = futex_hash_allocate_default();
 		if (retval)
-			goto bad_fork_core_free;
+			goto bad_fork_cancel_cgroup;
 		/*
 		 * If we fail beyond this point we don't free the allocated
 		 * futex hash map. We assume that another thread will be created


