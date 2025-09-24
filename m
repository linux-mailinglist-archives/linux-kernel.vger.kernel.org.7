Return-Path: <linux-kernel+bounces-829799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157A3B97E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935784A27C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32ACA4E;
	Wed, 24 Sep 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="T7D83T0g"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61D23AD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673801; cv=none; b=UOlkmh4MMhzk2ZVcchKiP0+m+UdPNV7170lGnDj8eRQ+WbfFnA+9O97ePireZeUw7cnlp71Jc9itWevt1nicZdFndAX4PY2r92KeRWmyO0KnV936QeDQQZn8bbocq3kauEjz2FuBARlzbIJFtulzzjK0eNTZNbs+Ts/q20jUd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673801; c=relaxed/simple;
	bh=Jr8qp6D8jCDVbd/gL52+QtRJEnPeEDmXcMkEpz1hqcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueORJ/vi3OqnQ4Y1qSOjJksvBlfqsxijnmt8VOst9JbYjhGI7/asw9zsjF0mHQbg4Lub78e9jDYxWs19VK67I2kmgZL4XLBp2/jeQ5gDlyxaThJz2I/ddbI24o11OFz/jVTsa8J2H65G/asYPBxLJbfn1YtkZzwIvyR8ni7PuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=T7D83T0g; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758673795;
	bh=q4oY5e0UxjyciVujIgig5cDXs9qUjv/AP1fQAPRIzcE=;
	h=From:Subject:Date:Message-ID;
	b=T7D83T0gwtrKpedd4utLAwPL4u7gppaqPoDFJlXjIfUn6TXoq2nffMxoCT/Ka6oZS
	 c0AQnpLnFmCH6pDHS75Tp19dCPNz0eX6yA5nTmS9mhhp+A/1aSt9ZKTYrSelnIu2Ow
	 AQZ/2j1RqKTAopaMXrAMa4fSRhNxKa0lvtkNYoC4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68D33B4C00003A4D; Wed, 24 Sep 2025 08:29:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9040246685402
X-SMAIL-UIID: 7D64F090728B4EE3AF3CA3D94E191243-20250924-082903-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in hook_sb_delete
Date: Wed, 24 Sep 2025 08:28:49 +0800
Message-ID: <20250924002850.7530-1-hdanton@sina.com>
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 23 Sep 2025 15:59:37 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ce7f1a983b07 Add linux-next specific files for 20250923
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=118724e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
> dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1376e27c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e78e2580000

#syz test

--- x/security/landlock/fs.c
+++ y/security/landlock/fs.c
@@ -1434,8 +1434,6 @@ static void hook_sb_delete(struct super_
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
 
 		/*
@@ -1457,15 +1455,6 @@ static void hook_sb_delete(struct super_
 			 * It is therefore not necessary to lock inode->i_lock.
 			 */
 			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
-			/*
-			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore the following call to iput() will
-			 * not sleep nor drop the inode because there is now at
-			 * least two references to it.
-			 */
-			iput(inode);
 		} else {
 			spin_unlock(&object->lock);
 			rcu_read_unlock();
@@ -1479,12 +1468,7 @@ static void hook_sb_delete(struct super_
 			 * disappear from under us until the next loop walk.
 			 */
 			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
 			iput(prev_inode);
-			cond_resched();
 			spin_lock(&sb->s_inode_list_lock);
 		}
 		prev_inode = inode;
--

