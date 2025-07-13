Return-Path: <linux-kernel+bounces-728883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B7B02E69
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 04:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743421899E47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8113632B;
	Sun, 13 Jul 2025 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Ag5IG2vU"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3842E3705
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374359; cv=none; b=DCtNbee9TKcjjhKu1Hm2pBG/5llonJJ7WjgCClX7YfIJUKM+p6YcZRlxMZl6sBe/Y+5hQbwxye2WXjGbWPICMKxw3NLHVyOycTlyetLysczF5bMv0gPJN4FbraoxWH6lNftrdtvO943LFSc3eD7mOuHmS96RjseFBiZzFLcDWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374359; c=relaxed/simple;
	bh=4bfQ9NGYOFxjguEIYmMmgLP1p7tMdt5YxX25gWYk1tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVJ7Ixd9KHBbxhDNC8HgIaM9Hxe8JGHWnmscuzxoSUBOaB2epkXWfPBeHnOtBPOGHW2FDGIIAhSZkJiR5Q61irU2hTsslf1ao9el3D3lvYs08WubkmYaXbtDiEtGfj9vnwahVSYio0CJKonM+5HfjtFxU72ccxy0jAI7Qe5Knnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Ag5IG2vU; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752374353;
	bh=RbcLypr1sZSy5UBA3wtFDJ4oxqxQlsDKbq11QaYGNeo=;
	h=From:Subject:Date:Message-ID;
	b=Ag5IG2vUJNC0eW8fyAC6tw4EaTd89NYCXD/ytiIAk6HzNe+K4hZG7MJSnNaZM8t9f
	 00EHhDulght+OtUrs9BU1x3Hufc+BHV+1LI/57iFgMMh5c/TWrnK3o5mOPHMcStZ6N
	 HbQedJwHeIw2j6VZQtV7kGlwkFKVZzciS4f6tGOs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68731C4700005218; Sun, 13 Jul 2025 10:39:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5151044457026
X-SMAIL-UIID: 1B0C7C9CE3D845E486D5A8AC6EC2EFBA-20250713-103904-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sun, 13 Jul 2025 10:38:50 +0800
Message-ID: <20250713023853.3772-1-hdanton@sina.com>
In-Reply-To: <686d9b50.050a0220.1ffab7.0020.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 15:27:28 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=130c528c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1257428c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fe9582580000

#syz test

--- x/net/netlabel/netlabel_kapi.c
+++ y/net/netlabel/netlabel_kapi.c
@@ -1047,6 +1047,7 @@ socket_setattr_return:
  */
 void netlbl_sock_delattr(struct sock *sk)
 {
+	sockopt_lock_sock(sk);
 	switch (sk->sk_family) {
 	case AF_INET:
 		cipso_v4_sock_delattr(sk);
@@ -1057,6 +1058,7 @@ void netlbl_sock_delattr(struct sock *sk
 		break;
 #endif /* IPv6 */
 	}
+	sockopt_release_sock(sk);
 }
 
 /**
@@ -1137,6 +1139,7 @@ int netlbl_conn_setattr(struct sock *sk,
 #endif
 	struct netlbl_dommap_def *entry;
 
+	sockopt_lock_sock(sk);
 	rcu_read_lock();
 	switch (addr->sa_family) {
 	case AF_INET:
@@ -1199,6 +1202,7 @@ int netlbl_conn_setattr(struct sock *sk,
 
 conn_setattr_return:
 	rcu_read_unlock();
+	sockopt_release_sock(sk);
 	return ret_val;
 }
 
--

