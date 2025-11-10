Return-Path: <linux-kernel+bounces-893347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F53AC47208
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C6094E290E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904EC305040;
	Mon, 10 Nov 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c+nNSTHm"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117E309EF9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784305; cv=none; b=YpVnoXTScGfKb/fRgCxP11fOCT62UHeumQSeTZTbjnW+BaI6d23z680s3/+zKm+oohy7IOT5x/0NlAI4iti8qb26KlxR8nGjTyqaHLzffVMKZHYECMoD6TE129n0A+5rhO4WCC1RdPmvQP4Kd3HtQIp5yydpzRL2LalfD+/35Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784305; c=relaxed/simple;
	bh=TBulgHUmGgHcU6g30OL52i5zw4w9JS+dsapqF+rgFIA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sf2DGJX6+AZ/Zwz1HCSc6MTPFR6CbdgIwzWHG0RLQCcyTfbwLcnge6gw0G34j7SftrkOHgCNgTtJ3HSFcCjQHQ3iJBD6Vk7frYDWWMmZqUjgh3CSyFMGT+oO7upmsEBhNB7u8eSS22Fmz38il3sT2iYlxgqczfElEUFxHiOu9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c+nNSTHm; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762784300; bh=R0x9DhiVDf7Dz005eIZelTEs/yFHWQKK4/txoXmSkMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+nNSTHmUMlqP72xmHFSYiafliKlfVPGzuFmIKKzzZCa1QQjoYqAmhO6Ck6iuHbTA
	 Kpm81Vl29XTE/NMtGxmrCcAdxvsxu55iaP7b6nnTNanpPWG+LG7MhItwq3F1rF8W+3
	 6wOGeT9TXwrCulMmGjT/4z4Io3ILQKWeq0HqFut0=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 49226690; Mon, 10 Nov 2025 22:18:18 +0800
X-QQ-mid: xmsmtpt1762784298t368eb5v1
Message-ID: <tencent_89E8A2ED9ECDEC7B1E6C242E516C24970C0A@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/5q6TsBkwa9ZXDvTX4t5vEkMifuC6Gq2BlE26QOlhu43RCP9VHQ
	 eTHdeoCJUVroevWk8CRQ2JTtpqFnS73htWrv4ZIzELeEAOWxtHfSbCd0MmBgBLyLZ2T5BpVM5ozX
	 hXXDNihYMoCRJEuvWrnb/P1puGyPKpEa5oJPyv4vTfIV3UcyqFjaNTN7QaRi+5Uajyi2vYhgfiLX
	 oPsF7jpQOrvGfFwHMB+wJkmyk7PzMMfZ5NUiHLruH8YY4dkQhBlcriQ/0aSvp/fRVFf4ge454AZa
	 19aKYtafCeujeWEF4ZepVVwBUTdFT9q7XEi1lMx0zspeeQjFGir3p9FGHFOcd1GgYCT3gZpdXibi
	 OSjMn+XFkfquZZy9UU6UdQCl8UEA0YoALLRNjK9SxwrR1afSh+yGOMc5UnjkcF8H2hUZlNDxvOfS
	 1hCLU4FFsvpYhIswwwMNAlsAwBc8K83w8Qk7o8qDcplRIBQbE6ZbKl5xl5sbyjPOuqLYaL6krdjb
	 S2aU6nbAC54zBGWeYOqVRKLLMbjTg0fFoXnyKoAmrvJQ9SoKtknoX+h3sJJo3TSkaFDxtMs/yQ7K
	 iZDnsSX6iILSbDFBWAOggepfgnoc5a3tWWMY3nldaKn78NmkZzhL/kXt302pul06qbbW16XUVvaR
	 yqpqtEJFGe0bqyqMR3TAjvUn4HQeRXHC9rpXBoFYnEAHj2cYzl5vM9oDgOQfkDzZ3DqNqlJXsyb+
	 jk7VURDFk2exV7FgaGipLu742Mj/N6fRrtX3t0qv+FdIJDGhZxRqMimFDSGAKw03LUA6cE+nkbb5
	 iqbcnSFD6yx/7nKuhyKZnqbChpjhdmlxpTqgwC2f6nrSaSerNJVUQQqHo1rLgBp5Z19XviKN/9AI
	 PhlkipHrpaG0/j7AKz5Zf3MX8e5UFmObODBM4iisSlhCr4/fNyFalE1ziNdI8u+siTkyWYz0IYEM
	 soQqE9t4IYatwVgep6SkCsdr1xtd8FA9HV/jKAHgsWM9owfD4yql/klI9FvlM3
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
Date: Mon, 10 Nov 2025 22:18:19 +0800
X-OQ-MSGID: <20251110141818.1553137-2-eadavis@qq.com>
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
+			schedule_timeout_idle(HZ*10);	\
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
 


