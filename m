Return-Path: <linux-kernel+bounces-891373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADEEC428E2
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094F2188D9C1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B729CB48;
	Sat,  8 Nov 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="eedvzjVk"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA7423504B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762587846; cv=none; b=IWMfnbRoBlTkp+C+3PQRRf73gFxKVHEUKkaeCdogiKuDjYeXea0BPqNWxgZ3/V/XqvjhZL1YIUBxL8+ri2E3R5bvhfC9A7G4lNtPhwvgYIpUZN6rk3v81zWTOf7MDc90UWIOD4LZN337xaacEJzBmbHs3ww37en/j2UJFglcM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762587846; c=relaxed/simple;
	bh=xbCc9RB40LUkQCMPmi1P7YFj579Hplx5PaqbKfYNZXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+G81SuYs+684Dftw/O6z1tgnBTluvK7ozF+zMkIBWljUtwoYtrf1iMgxQxS1D2/jPAC27TH28OLmxXnOCB3/p4GXFFGqAPVygsLRwYDADxbGIddjwQZ03qCSWB31dJz5Ng4r9zHGsr+BmplNPjTz8gb5PGOzSd5trYAtymbgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=eedvzjVk; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762587841;
	bh=k4NY+SAMlfgB4wCA0VuLXjUPbpVKAN2pvWyhgV2cH4A=;
	h=From:Subject:Date:Message-ID;
	b=eedvzjVkWTUr+JLz1t7KNAIOh4ugfHPMpwdj2M1P9907Jp66HsKseUQV/2I+XpEut
	 hHBjBH+Zg4r3tcVhQJOEJiX5DCZaUHrDcRo7S3dQ+hBMXwcscl3PyCD5vBWz+722OP
	 W1VAg4Fy8YmnNGJNThdGO4UqCTgDAUAhu1Zwr1aY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.34) with ESMTP
	id 690EF4B5000008EB; Sat, 8 Nov 2025 15:43:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1130636291952
X-SMAIL-UIID: E807FABFF86849E68C4B2FF1C6661CF2-20251108-154351-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
Date: Sat,  8 Nov 2025 15:43:30 +0800
Message-ID: <20251108074339.9025-1-hdanton@sina.com>
In-Reply-To: <690ec096.a70a0220.22f260.0070.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 07 Nov 2025 20:01:26 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    da32d155f4a8 Merge tag 'gpio-fixes-for-v6.18-rc5' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=118faa58580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
> dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103d4412580000

#syz test

--- x/fs/jfs/jfs_logmgr.c
+++ y/fs/jfs/jfs_logmgr.c
@@ -149,6 +149,7 @@ do {						\
 				 * of log page
 				 */
 #define lbmDIRECT	0x0100
+#define lbmInflight	0x0200
 
 /*
  * Global list of active external journals
@@ -1861,6 +1862,8 @@ static void lbmLogShutdown(struct jfs_lo
 	while (lbuf) {
 		struct lbuf *next = lbuf->l_freelist;
 		__free_page(lbuf->l_page);
+		while (lbuf->l_flag & lbmInflight)
+			schedule_timeout_idle(HZ);
 		kfree(lbuf);
 		lbuf = next;
 	}
@@ -2130,6 +2133,7 @@ static void lbmStartIO(struct lbuf * bp)
 		bio->bi_iter.bi_size = 0;
 		lbmIODone(bio);
 	} else {
+		bp->l_flag |= lbmInflight;
 		submit_bio(bio);
 		INCREMENT(lmStat.submitted);
 	}
@@ -2226,6 +2230,7 @@ static void lbmIODone(struct bio *bio)
 	if (bp->l_flag & lbmDIRECT) {
 		LCACHE_WAKEUP(&bp->l_ioevent);
 		LCACHE_UNLOCK(flags);
+		bp->l_flag &= ~lbmInflight;
 		return;
 	}
 
@@ -2305,6 +2310,7 @@ static void lbmIODone(struct bio *bio)
 
 		LCACHE_UNLOCK(flags);	/* unlock+enable */
 	}
+	bp->l_flag &= ~lbmInflight;
 }
 
 int jfsIOWait(void *arg)
--

