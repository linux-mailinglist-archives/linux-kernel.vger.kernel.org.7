Return-Path: <linux-kernel+bounces-737999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967DB0B301
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1066178B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE61E502;
	Sun, 20 Jul 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Q9RFh8dR"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21178746E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752971827; cv=none; b=doibifyW8cNXUbQsl+XrdbsEfWtNIZ8BPJIIRDSfwkRGO50sElBvlCbgpiDyOhjoiZMli1Ik1PtD2yG2Tri9iarNgHjTmuOwVm/6eQQg4yYueGcpL89pnKqfoEalAIOinGsq7WOIwok75LD/LoGfbfXtE/jf6c+Vm3cMrJZs6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752971827; c=relaxed/simple;
	bh=6qtrxPSjW9+vbUHBiMG+mLCpT57f2dPKkzB+oCglAHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaOm3Zkv9vr6hzsskI5sywN5s2SkUpfY3NHLOhSwzrXCkamsbYqh/7UPfVJfFXu9wEZm7bdfO4vdbyEXkfjzd4P6jaEnxSXyu1otlSwpVxM8X96JTLkCzOocbeb8wpsPisobTeP0MCp2xvM/riEdswc0R7XEC5FKBBrEUYmKZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Q9RFh8dR; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752971823;
	bh=gjPgjkO3MuXX+Ei7xYhvDfxh/tU/7TdFZmzj7UpwMT8=;
	h=From:Subject:Date:Message-ID;
	b=Q9RFh8dR9Aq7ASq3wLGhz9uprLnrNYdZk8fNALpNoq/HLv5NgqVYMU0oyyRrpQYz7
	 sUywKOmY8zcFRIka3N9WRqxb9kk4Nuh0bJnGvaDY4Wt3RbsOnIeBp2dE7dDKoxQc7s
	 76mFKSna5Ux/mYQzhdJt+eVji21Ldnm/8Qr76A1U=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 687C3A0200000D29; Sun, 20 Jul 2025 08:36:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7588014456948
X-SMAIL-UIID: 47463F883626433296F0ADDF9B64B419-20250720-083619-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_poll_remove_entries
Date: Sun, 20 Jul 2025 08:36:06 +0800
Message-ID: <20250720003607.2491-1-hdanton@sina.com>
In-Reply-To: <687bd5fe.a70a0220.693ce.0091.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 19 Jul 2025 10:29:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4871b7cb27f4 Merge tag 'v6.16-rc6-smb3-client-fixes' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1288c38c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa738a4418f051ee
> dashboard link: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1688c38c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166ed7d4580000

What is difficult to understand is why rcu failed to prevent the uaf.

#syz test

--- x/io_uring/poll.c
+++ y/io_uring/poll.c
@@ -143,6 +143,8 @@ static inline void io_poll_remove_entry(
 	struct wait_queue_head *head = smp_load_acquire(&poll->head);
 
 	if (head) {
+		if (list_empty(&poll->wait.entry))
+			return;
 		spin_lock_irq(&head->lock);
 		list_del_init(&poll->wait.entry);
 		poll->head = NULL;
@@ -416,7 +418,7 @@ static int io_poll_wake(struct wait_queu
 		/* optional, saves extra locking for removal in tw handler */
 		if (mask && poll->events & EPOLLONESHOT) {
 			list_del_init(&poll->wait.entry);
-			poll->head = NULL;
+			smp_store_release(&poll->head, NULL);
 			if (wqe_is_double(wait))
 				req->flags &= ~REQ_F_DOUBLE_POLL;
 			else
--

