Return-Path: <linux-kernel+bounces-765777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38912B23E23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DE668585F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB851DD0C7;
	Wed, 13 Aug 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="X9cMFHo+"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC0273FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051600; cv=none; b=OwdZsQc8qckn54YDY7/624ZpWZKPz/BC6UzcJAu/mryx4DAeLS4X9P9qra3qyEjTDVc6XFF0gmEBGAttpWdDYzC2Gk+9psBPwyJ8m8wpAfu2MutQm8pgnY3x5pZ/xnEAPlvcLd9NF98/47GoiFS6FSFr3XK++QsPceP56tgqjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051600; c=relaxed/simple;
	bh=Tmcf38SAMuWRTp5/pG4zyOpadieUZ3W94t2I1RDBk4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnv7y0GHhw5IQJvUafiL9SFYnt9wdAi+v2lkEd4aLrBHizyCLhmdEeUk3WPRfS4aC/D+MSAHvYmXRlyfBXptqpg5Sz0oAWUGxDfqF+KrcybA2r8Ktgp+BrxCjAG17Z2ry8tyVd+n2KU7fc3IYcIx4TI2kiaQsLF+ctsF42Wjrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=X9cMFHo+; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755051595;
	bh=XGubnkrj1lRcpkjQTJL5eHoPcMY+ufdMMxJjIprqyoM=;
	h=From:Subject:Date:Message-ID;
	b=X9cMFHo+kXXS89qBKBGcICCUo3rtyH+rsfZqSCGBsTvyA2mOa/OcpXQVPVBoKCulh
	 76BDSbOUHCQ+npaLntPCfeAVkRgQY5tGUgHFbv/Bb2kpY3cSs/Q8rT5/ea5trh4HGu
	 rD2UHR5eCqld1e+/ULZmTXhDoyfmx+7qtrqzsEXM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689BF64600003B28; Wed, 13 Aug 2025 10:19:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7484284456953
X-SMAIL-UIID: FACDE02A821D4C56B555776F5ACC773F-20250813-101951-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
Date: Wed, 13 Aug 2025 10:19:40 +0800
Message-ID: <20250813021941.4438-1-hdanton@sina.com>
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

--- x/mm/mremap.c
+++ y/mm/mremap.c
@@ -837,7 +837,6 @@ unsigned long move_page_tables(struct pa
 		new_pmd = alloc_new_pmd(mm, pmc->new_addr);
 		if (!new_pmd)
 			break;
-again:
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
@@ -856,8 +855,9 @@ again:
 			continue;
 		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
+		/* bail out to avoid clearing new_pmd */
 		if (move_ptes(pmc, extent, old_pmd, new_pmd) < 0)
-			goto again;
+			break;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
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
--

