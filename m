Return-Path: <linux-kernel+bounces-793636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE96B3D654
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75423B68B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574C1B4F0A;
	Mon,  1 Sep 2025 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Fhy9asR+"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C4C2FB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756690708; cv=none; b=ISmXAWwuFPypHzC3ew2kk39GXHX7WuTlhlEw46vgfQyUdN2d2Y2Zz1PGlAP74Dt8/a9HF+M5TSSgPJ8Wpl0XsWkCq31gM+SwUwgGXVFHcG2GwB2OPkjHHUlnwahZEIdZ55qArQUqkBcDyXEW5ehdnfAygYY6bANySeOmjmc4o/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756690708; c=relaxed/simple;
	bh=u/FqhjA1/sXtx7E5fPiSH8R1tbd6kUMljTqj9A7RDdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ6PDBp6MUrBk0Ttj7nvmBPsXmvaACHQeE+2mSNKQRXv0M0ipt/nST80XuSc/eHAhMYDjek+dpyppD1V1F3N9C31IfLDbPyzxPRpWQNmcswz/TKijfwkaNY0aTv3Oje2NNtYSmF9kyzFhaB3Qj59ffVdmpJB3fVLJL1L+fjD3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Fhy9asR+; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756690698;
	bh=41Hj+4QZoJwX4JXyxqOCAg0MsefGVY5tWO7IDIjXO0s=;
	h=From:Subject:Date:Message-ID;
	b=Fhy9asR+V4aD3aiQ7n3fJ2wQM5ajlZ3Nz63SD6FUh14bI0GZDbmXyp9Cc70pGQAvx
	 Qk5tFQwfYXhA5vZQFNFPWdXpM6w8N7GFx2XaexrqY7G32XPiqtr+v9q0hDertBmlFp
	 al7PUWSI/peXsjjzcabFbZYI4LGKrFXennfbLc58=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68B4F8FF00005039; Mon, 1 Sep 2025 09:38:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5566196685393
X-SMAIL-UIID: 444AB87BC62E4F0D9EDA304FB75BDCEF-20250901-093809-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
Date: Mon,  1 Sep 2025 09:37:57 +0800
Message-ID: <20250901013758.6300-1-hdanton@sina.com>
In-Reply-To: <68b3b1ac.a70a0220.1c57d1.028b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 30 Aug 2025 19:21:32 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    11e7861d680c Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17c5c242580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1671ba62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1685aa62580000

#syz test

--- x/drivers/vhost/vhost.c
+++ y/drivers/vhost/vhost.c
@@ -407,16 +407,14 @@ static int vhost_run_work_kthread_list(v
 	kthread_use_mm(dev->mm);
 
 	for (;;) {
-		/* mb paired w/ kthread_stop */
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (kthread_should_stop()) {
-			__set_current_state(TASK_RUNNING);
-			break;
-		}
 		node = llist_del_all(&worker->work_list);
-		if (!node)
+		if (!node) {
+			if (kthread_should_stop())
+				break;
+			__set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+			continue;
+		}
 
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
--

