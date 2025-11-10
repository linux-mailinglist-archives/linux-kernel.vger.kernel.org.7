Return-Path: <linux-kernel+bounces-893430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F9C475EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E53B30C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2FD303A0B;
	Mon, 10 Nov 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w/WWhxpf"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E302EA755
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786553; cv=none; b=gqv5ZTiJ2n5t26iLJ4g+0Jm5I4vZ+Nwk+Rm5kppJdn0RunUCQqGFEN2cOBU54jGRmwr+AhFRkg3oZN3fadMuRZalGe7mCxfN1sx8w8OnDcTwwvnfwX4romsF7NghEkWAnhg4o+Guf30gSJaoahH7hX1fsXJ1dwodJnc7ZBzRNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786553; c=relaxed/simple;
	bh=oQxI3t2kGK7me1VfX7U5M6w2q43EKnI7jbkKpZqk5/U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Tw+s50GPe/PTg6jZsbmAN1a6yQ/ohbCTR9px9Uir20/rB5tcdlkwDuMf0dFF8QW7I+Bv8/8Ljhn+/f91BA72LuhaTbvWgKNShZqGnRohxhZVqnW6aEoAvILS/cgPxMYcFrGlUt6tay67wnfXl41OhouUXYFSDgV9ObEaaWS5Wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w/WWhxpf; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762786245; bh=CevAv9dXwnrxkz6QLEjCwdwMUcKew+4c76u/8Vt6yr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w/WWhxpfDnOWiPwUD7heEcZNM/el+yO6hLpq5X9dS46SlI+cBh9WwRhQzgXgusyo7
	 h0S7lsqcr1j09QO/6buwiVDsdCEd3AyOtU+bkD1e5l/Az7e1IiL2xyEHNF0/Ac4aEW
	 uRk7ey4T7fqp9QMClbdPAnc9WyX2dbYq4oja0PTc=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id CAB90273; Mon, 10 Nov 2025 22:50:43 +0800
X-QQ-mid: xmsmtpt1762786243tml3qfiij
Message-ID: <tencent_D1BC2D0D6C889484EB5AEC9ECC9C78766C0A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GIo417eizgj/eMEN9um80WIgvCHBDOnEhGjJSv5CAmZ0Q5a5fBj
	 MI3m9gohPtr7tufJKwWTi8gOAFLfstNc0xFmcttt7hA9wRc/kH6cA8xE8oKB+uPF0C4OP/JJP0OF
	 A67j/iTYvjWZNwzeZw6CgSA5CGzp3oUJXaIRskqFT78bpvD5qSmd/klaYmjxA1998vZmrDBiKIOH
	 cJVBgDFQbaBep6n6JV/VANUz3jdH1HBrZgzQU8K+nCu2+ZOCP4X+w/MCYfAtYdEs8r2a1f8QuDrT
	 FvsGuwBB/CE/wFTOjpfdkFgXHfIxD9FmWBMOSI/jtL0aoOimduhbMk6TzfL1DuMNOqfoirYf0a3h
	 7DxKMFWNcCykp86fynEs0qcBuK7GNFLIBIZ3zarp4R9X7RkpB45wezJ+EW7lSOr40lP8U4m2qTQV
	 CJ/e9m5yDcEw5yVsTBixDpnvKPd86ZM2x9K+ibqgHkf2iYnK7cNbsdsIKz5LszoyMvjfHn/v7NVi
	 1cN/+M+i9MqEnMNozvrN96sRNND+zaX6ipaOTOq9IZZ9b1f0g+mCWVc169nOc7w1q1khE7ms3xrP
	 fZ26p/olCe+oXr79MPA7nhyPBALchnvQfW+j1z4vuHw92wZgqq+Qj4KGns1Kv53eJlNpkhjc3nip
	 dXY/M6ms8MpnVv5jZ84QXD7Tke9auJ+t2WetVIXvjlGH7z/2dpxMEsnagkGZhcfRbTkifR9NtWaR
	 5KMYI9WkM7gFGRfxroa5CLCvWoEjtIMuTb5SJT6lEZCOnHWy1WctCDKwBhBAa4FKrHIkDWETZWv+
	 XanQpmORcdEcxw28iLpPSvZUqNX6VS75I3fvqjTFWMrDWLHaKkizMCXKEzDSOdJWGKBhWgIoqA8v
	 KtI4U6jcYVFQqDZTxqTZXLvPSxq7TW+0x5IhqB8lkKGSKrtHuxM/jnv+OzxCEc9oujRpWE5PsSKQ
	 Qffyb3T1GYcaXw0VmOOlsnHhUMwxxbXXWParS41hUGk+4xNjbOGyihVSrG/oxXXbn/u7EsTV8NdW
	 WZOzk6w7LavToD4bTcmu2u/0NNQdr5nLvqUpBR0A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
Date: Mon, 10 Nov 2025 22:50:44 +0800
X-OQ-MSGID: <20251110145043.1580882-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <690ec096.a70a0220.22f260.0070.GAE@google.com>
References: <690ec096.a70a0220.22f260.0070.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/jfs/jfs_lock.h b/fs/jfs/jfs_lock.h
index feb37dd9debf..6aa5ff62ca7c 100644
--- a/fs/jfs/jfs_lock.h
+++ b/fs/jfs/jfs_lock.h
@@ -19,7 +19,7 @@
  *
  * lock_cmd and unlock_cmd take and release the spinlock
  */
-#define __SLEEP_COND(wq, cond, lock_cmd, unlock_cmd)	\
+#define __SLEEP_COND(wq, cond, lock_cmd, unlock_cmd, idle)	\
 do {							\
 	DECLARE_WAITQUEUE(__wait, current);		\
 							\
@@ -29,7 +29,10 @@ do {							\
 		if (cond)				\
 			break;				\
 		unlock_cmd;				\
-		io_schedule();				\
+		if (idle)				\
+			schedule_timeout_idle(HZ);	\
+		else					\
+			io_schedule();			\
 		lock_cmd;				\
 	}						\
 	__set_current_state(TASK_RUNNING);			\
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b343c5ea1159..e70bde3b7f40 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -113,11 +113,11 @@ static DEFINE_SPINLOCK(jfsLCacheLock);
 /*
  * See __SLEEP_COND in jfs_locks.h
  */
-#define LCACHE_SLEEP_COND(wq, cond, flags)	\
+#define LCACHE_SLEEP_COND(wq, cond, flags, idle)	\
 do {						\
 	if (cond)				\
 		break;				\
-	__SLEEP_COND(wq, cond, LCACHE_LOCK(flags), LCACHE_UNLOCK(flags)); \
+	__SLEEP_COND(wq, cond, LCACHE_LOCK(flags), LCACHE_UNLOCK(flags), idle); \
 } while (0)
 
 #define	LCACHE_WAKEUP(event)	wake_up(event)
@@ -711,7 +711,7 @@ int lmGroupCommit(struct jfs_log * log, struct tblock * tblk)
 	tblk->flag |= tblkGC_READY;
 
 	__SLEEP_COND(tblk->gcwait, (tblk->flag & tblkGC_COMMITTED),
-		     LOGGC_LOCK(log), LOGGC_UNLOCK(log));
+		     LOGGC_LOCK(log), LOGGC_UNLOCK(log), 0);
 
 	/* removed from commit queue */
 	if (tblk->flag & tblkGC_ERROR)
@@ -1860,6 +1860,7 @@ static void lbmLogShutdown(struct jfs_log * log)
 	lbuf = log->lbuf_free;
 	while (lbuf) {
 		struct lbuf *next = lbuf->l_freelist;
+		lbmIOWait(lbuf, 0);
 		__free_page(lbuf->l_page);
 		kfree(lbuf);
 		lbuf = next;
@@ -1881,7 +1882,7 @@ static struct lbuf *lbmAllocate(struct jfs_log * log, int pn)
 	 * recycle from log buffer freelist if any
 	 */
 	LCACHE_LOCK(flags);
-	LCACHE_SLEEP_COND(log->free_wait, (bp = log->lbuf_free), flags);
+	LCACHE_SLEEP_COND(log->free_wait, (bp = log->lbuf_free), flags, 0);
 	log->lbuf_free = bp->l_freelist;
 	LCACHE_UNLOCK(flags);
 
@@ -2148,7 +2149,8 @@ static int lbmIOWait(struct lbuf * bp, int flag)
 
 	LCACHE_LOCK(flags);		/* disable+lock */
 
-	LCACHE_SLEEP_COND(bp->l_ioevent, (bp->l_flag & lbmDONE), flags);
+	LCACHE_SLEEP_COND(bp->l_ioevent, (bp->l_flag & lbmDONE), flags,
+			  bp->l_flag & (lbmWRITE | lbmSYNC | lbmDIRECT));
 
 	rc = (bp->l_flag & lbmERROR) ? -EIO : 0;
 


