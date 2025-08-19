Return-Path: <linux-kernel+bounces-775893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDFB2C610
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738F07BA603
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF8B341AB3;
	Tue, 19 Aug 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jecbLfCs"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4DC340DAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611235; cv=none; b=r9BOzTurmdLF8KCwZfu7mtCzLEif5NAHJzsPnQAVOo6AYIawYyrRnqE6819GnmpBK/ldkGMOTVht72/lEe7mpO4RPSDF2AIt4mUatSfBj+RNaA30lfgrWV85oXIc0VWVJYFRaxozcYjtu0uKhBbnGmmIKg9BqO/r+SlQ3JFkJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611235; c=relaxed/simple;
	bh=Ybm10wiHr5ulrJ9Frxyd1d5WckN8g1UtM/uNWu5yBvc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TPNz2tQWToGGhJNqP1+quLu06XCAzfBX/qbV4qU8xSrunwYq9hqLpPBO2yDjpHTsmJYmXztddCle6i55iNkeTU0e5zzMEgvSG5FZYx1QJKWpZN0LXZG3uLzasD6R9oiGvOYmRIaFGJQKIiXvMH8jRJY0elFQmOVpiIYWHy68o6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jecbLfCs; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755611229; bh=OlS3uc13OkAKUWAvQfgzjGpAgOq2p9mUY7KcYX8F/Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jecbLfCshlk5Tc/9PU9Uaabc5tVXwhVji0jT9/wJiZ0B7c1tIiqS/lgt3YdcZlHRq
	 MIyWzaq5AcLE8VLkv07vN4M0r9Kgenn2A3RZ1N6fXdv0gON6NZ1mgVj2I4RadCTZ82
	 kWJRQ4TOt/X/hnL5nMzhgJ1znrfaYUZlmnmKeYnk=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A4125023; Tue, 19 Aug 2025 21:41:01 +0800
X-QQ-mid: xmsmtpt1755610861tgji6fijw
Message-ID: <tencent_357489BEAEE4AED74CBD67D246DBD2C4C606@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69icZz1+1/hg2anVwN2QhvGYv5r2pepvoqBBCN9avGN9TkyFaypI
	 vqJpVlyz8Yxpck5Acd/0lWobT0QLdjmhWL1t2NjoCPoz7+GAngRuQCnidCX8HJoV0TaOTwZoComE
	 FSM7zbTCqE5TRl1CgC94WU2AfzqDFA7ydhBR1Cyf6bHLTb/DEYFefrWbOHa45cxDWr8IbLPplJcg
	 dCM1BqcIBNDKry8uu59aIWz9m00B+M3NxvVMQZ2Uj4HPHwN3WtSs6xqhk8DaqWUMGeW0cflEfQtU
	 RmZ7dEhaihzZT1GuREwC4guz7xdWBQpr5IgPrVE/vEBXQGotSjjeANFR8BUChtVO1A4va0uM1zvE
	 6HkWD+2+pieqrlFIwIv/vWOi05pk/VH6xZjiEvMcklfKukXJDqhbIGQfI3wynMO6MnpVhubpE6l8
	 NLo8xEFAu/RipUYyp9Vx6JeMUF2XLsWuBr+IQ8yEM9NACj2l1gFdSuue8y/MPlwnvjE8ZE59sNhl
	 vTSRIegk1NjhapaZdN3bAqlCHDH8biROvkYNzp9SCZKwqMeSzz6OGFBrPtHSVELcwij58DVDPVQA
	 31E7ZAzxJrIwXLbgQ2AMlnVyBuL9hJqPCdCPl/E0L36R9wQGjr8p8etjKlpIvjK8GKYupYRNNiRE
	 5WlE5O0XE8qeBl8StePDqOm9FFk5UAZ8957+E73Wl65D5pWyFmQY/ZwaVRJOKLR+zI1WThKWm4ZW
	 Oeu6hozxj/FmrubAzTaSv0D79tSqQhRNKCO4jFuspd2Bvxnz/zhbJ9Zjcul+TPIQIdgLozAineh3
	 ab5/G62fjbAXiSAzqtqcWvqaLfytGWRSbo2YMbQZVd0bOwxpBGVsHYh2DCZd5teebL5z4kcqLig5
	 tJ4cLxsKrOOjK6zykbbv1zv/+3FxY9ePp/3mxMTfddzm30OqzFwt95fBVYEKojqWRdo1/ZZ8TxKk
	 N2XQTUN7tVSiotz4KpmdiRiGklHDpu8PKRhgcIld4ZAjz25QVVZ8du4FRepfo1oogT4ko7+lGROB
	 IpieKRnjRkHNmdqCGygtBzwEJANlBRP6n8JfA1Ffos3jhlWrRNiaxzktsUc6mgMvCW1KA/6w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] ocfs2: prevent release journal inode after journal shutdown
Date: Tue, 19 Aug 2025 21:41:02 +0800
X-OQ-MSGID: <20250819134101.1271797-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <tencent_5E787A6C242FE96CC89454E856EC52CEC40A@qq.com>
References: <tencent_5E787A6C242FE96CC89454E856EC52CEC40A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before calling ocfs2_delete_osb(), ocfs2_journal_shutdown() has already
been executed in ocfs2_dismount_volume(), so osb->journal must be NULL.
Therefore, the following calltrace will inevitably fail when it reaches
jbd2_journal_release_jbd_inode().

ocfs2_dismount_volume()->
  ocfs2_delete_osb()->
    ocfs2_free_slot_info()->
      __ocfs2_free_slot_info()->
        evict()->
          ocfs2_evict_inode()->
            ocfs2_clear_inode()->
	      jbd2_journal_release_jbd_inode(osb->journal->j_journal,

Adding osb->journal checks will prevent null-ptr-deref during the above
execution path.

Reported-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=47d8cb2f2cc1517e515a
Tested-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: Corrected typos and comments.

 fs/ocfs2/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..6c4f78f473fb 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1281,6 +1281,9 @@ static void ocfs2_clear_inode(struct inode *inode)
 	 * the journal is flushed before journal shutdown. Thus it is safe to
 	 * have inodes get cleaned up after journal shutdown.
 	 */
+	if (!osb->journal)
+		return;
+
 	jbd2_journal_release_jbd_inode(osb->journal->j_journal,
 				       &oi->ip_jinode);
 }
-- 
2.43.0


