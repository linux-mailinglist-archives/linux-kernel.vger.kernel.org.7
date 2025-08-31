Return-Path: <linux-kernel+bounces-793257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA74B3D140
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E17117FC6D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7923D7C2;
	Sun, 31 Aug 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Xaw+phyO"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181A38DF9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756625728; cv=none; b=ATSWirWKVsTmacbqw4Qlp9HI/FzTks018X5/u3xhiygJ5y3sbZZ2zhzT3y7P8LdXCAPh0ckUtp35xVk+j4W3N9YcMNpwUdGJJ3rnOtHdGyMcwftJsJOTz7hj2JMjfamevnDYm/J1q/dA5x2jEIaaeDSWAiyLR/Y4Ff71HjbvmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756625728; c=relaxed/simple;
	bh=54ZcqTxbjRF/GUrSW27XJo4bQ9eFq5N76RS34fN24mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCxk8MvNniADb9N8q4/vvuLKylFd9VSft+TTNs7A68e7Q3XYxsIixKtFDdyUtaBzNmMLkx2xuM1Pz7UTwS5gv4Gnm69xOPh9004bZpc92l5oxAfAUGWfS7bPIvyE4zcucJ+LFMZakmXQIvVYAFBYw0geOg9tSaHFKnnh4sdadf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Xaw+phyO; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756625719;
	bh=D3JMiHMJt+hlYzkkSj/A+L6/r3z7BdOAei/uu00rQWI=;
	h=From:Subject:Date:Message-ID;
	b=Xaw+phyOIbF2gOliKcxCjO2xFDPPRSqTx/sXzdiZ4ZooyOAfRJVod6PBMNH/Y1xsS
	 YKIaieMbpRbFqyGmWNzXLwl2hVhukldun5n3+wGLl1EQaPfcVY8Fs81O5Mz8In+7UV
	 x3KNIcnnSiua7l9+bA2YI48u67lQ0VW8/vV1m0TU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68B3FB2C00003254; Sun, 31 Aug 2025 15:35:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1078774456683
X-SMAIL-UIID: 676ECD85FBBD4AEFA660F67C697207E5-20250831-153510-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net] [virt] INFO: task hung in __vhost_worker_flush
Date: Sun, 31 Aug 2025 15:34:57 +0800
Message-ID: <20250831073458.6191-1-hdanton@sina.com>
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

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -440,7 +440,9 @@ static bool vhost_run_work_list(void *da
 	struct vhost_worker *worker = data;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
+	bool did = false;
 
+again:
 	node = llist_del_all(&worker->work_list);
 	if (node) {
 		__set_current_state(TASK_RUNNING);
@@ -455,9 +457,11 @@ static bool vhost_run_work_list(void *da
 			kcov_remote_stop();
 			cond_resched();
 		}
+		did = true;
+		goto again;
 	}
 
-	return !!node;
+	return did;
 }
 
 static void vhost_worker_killed(void *data)
--

