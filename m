Return-Path: <linux-kernel+bounces-766719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF0B24A58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B2C7B875E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB582E7F2E;
	Wed, 13 Aug 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="l9pDbMel"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86802E765B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090915; cv=none; b=kuyA9oBow3OfzSkLXw1FCSn278rD9z5rOB4SBabSIC0ZZIFUiCDbSfk2XuV8vLd707b2PA9Z9eu8NB7J9zB7x/s1UMwv9oRo8NU4T5kbi4VbNTLxxuD1g+bzEtiqH+llNJ0QYn+miGicR10Af9IxXnCa1PgtdlmpEdCNqcwdoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090915; c=relaxed/simple;
	bh=6TtCLEWwEuhxE/cgXgywLouKE7LVMgcpkmgFl1fnfKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWVmqQA70iEAOahqE1I6cECryqf2WXNaHpWwRr+6zOeDtNzpHcSZT9NY0fCDdfMB5Y0tHNYvoO7MR1rvs8jFadZxVt8+NxJOm1O6PsDiDs3EJwpCVylo9MpHTwTdbZtxmkBpvVGb34MrZyE5Haj6CL215ZNrCdLMvytLbVsMeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=l9pDbMel; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755090903;
	bh=JmrNKa4AQr65hMZLlQdZOUYRF0IiBgFU9/xCUsr2Rro=;
	h=From:Subject:Date:Message-ID;
	b=l9pDbMelFJOLkJgJSQc9K/n6dxUdA6Jr1gr0UEWMb9d7Dk03tHyeszmKxclWUx6Kr
	 tmuTZgSSppOwkFouAiUXGtcpiy4WeKZ/TySTCnOS7MNzfgTTARwkqPu1Wjzx4oWcJB
	 SVBHi3ANUaBR4X/Gc0tOZubLFNCkT0ojE9BEgGvM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689C8FD200000C29; Wed, 13 Aug 2025 21:14:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7730234456618
X-SMAIL-UIID: ABDB8E76FE0A4D5ABF6B8B916BEF2FBA-20250813-211459-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
Date: Wed, 13 Aug 2025 21:14:48 +0800
Message-ID: <20250813131449.4491-1-hdanton@sina.com>
In-Reply-To: <689bb893.050a0220.7f033.013a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 12 Aug 2025 14:56:35 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=165fe9a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14172842580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b04c34580000

#syz test

--- x/include/linux/sched.h
+++ y/include/linux/sched.h
@@ -2152,6 +2152,8 @@ static inline struct mutex *__get_task_b
 
 static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
+	struct mutex *blocked_on = READ_ONCE(p->blocked_on);
+
 	WARN_ON_ONCE(!m);
 	/* The task should only be setting itself as blocked */
 	WARN_ON_ONCE(p != current);
@@ -2162,8 +2164,8 @@ static inline void __set_task_blocked_on
 	 * with a different mutex. Note, setting it to the same
 	 * lock repeatedly is ok.
 	 */
-	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
-	p->blocked_on = m;
+	WARN_ON_ONCE(blocked_on && blocked_on != m);
+	WRITE_ONCE(p->blocked_on, m);
 }
 
 static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
@@ -2174,16 +2176,19 @@ static inline void set_task_blocked_on(s
 
 static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	WARN_ON_ONCE(!m);
-	/* Currently we serialize blocked_on under the mutex::wait_lock */
-	lockdep_assert_held_once(&m->wait_lock);
-	/*
-	 * There may be cases where we re-clear already cleared
-	 * blocked_on relationships, but make sure we are not
-	 * clearing the relationship with a different lock.
-	 */
-	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
-	p->blocked_on = NULL;
+	if (m) {
+		struct mutex *blocked_on = READ_ONCE(p->blocked_on);
+
+		/* Currently we serialize blocked_on under the mutex::wait_lock */
+		lockdep_assert_held_once(&m->wait_lock);
+		/*
+		 * There may be cases where we re-clear already cleared
+		 * blocked_on relationships, but make sure we are not
+		 * clearing the relationship with a different lock.
+		 */
+		WARN_ON_ONCE(blocked_on && blocked_on != m);
+	}
+	WRITE_ONCE(p->blocked_on, NULL);
 }
 
 static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
--- x/kernel/locking/ww_mutex.h
+++ y/kernel/locking/ww_mutex.h
@@ -342,8 +342,12 @@ static bool __ww_mutex_wound(struct MUTE
 			 * When waking up the task to wound, be sure to clear the
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
+			 *
+			 * NOTE: We pass NULL here instead of lock, because we
+			 * are waking the mutex owner, who may be currently
+			 * blocked on a different mutex.
 			 */
-			__clear_task_blocked_on(owner, lock);
+			__clear_task_blocked_on(owner, NULL);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
--- x/mm/mremap.c
+++ y/mm/mremap.c
@@ -592,6 +592,7 @@ static bool move_pgt_entry(struct pageta
 
 	switch (entry) {
 	case NORMAL_PMD:
+		*new_entry = NULL;
 		moved = move_normal_pmd(pmc, old_entry, new_entry);
 		break;
 	case NORMAL_PUD:
--

