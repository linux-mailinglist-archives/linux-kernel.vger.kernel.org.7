Return-Path: <linux-kernel+bounces-728858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8C6B02E34
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 01:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3CB4E2C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBB22F74B;
	Sat, 12 Jul 2025 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="qFOG3GYs"
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB71EC014
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752364478; cv=none; b=QDncxeDLHxcs095xeHjbQ4rTkb47hm6nVq1LWUVBm23ldNsvol/7h1ossQLx5lNb8n+J7OM8aiJCtj/LAS2k9vB4GYYPQB58586+Yh2ci/F4/BQImdp8kn2nBcjEE3KqGbx/mp2vTr32ORMcB1Pi3WaVzMCKqxBRZG8s2jXixLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752364478; c=relaxed/simple;
	bh=45KC8eO6x+YyouVdXBsSi2YzGQxoFIzZplDcpHfEnSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2kAWVxxdpeqzFZtzCdu1HNbezB/SZnKEOkZ5NYeDaAJtFS5cLAMlXsEWMJrgTzlIG8+xzZq3S8yB/XyGZaQVe+WHWFo1LbYzIhw5hZcznP7cm0FeOdZ/oqw22Ly/Q48kbjE1ZL+FqpQclwYJhxv7drRw6zZ9V60GV5cg1UYEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=qFOG3GYs; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752364473;
	bh=87MbLWWaCUWdLjGKw1WWNbh43Sy+70oCHYTqmP4zDZk=;
	h=From:Subject:Date:Message-ID;
	b=qFOG3GYsY1yq5nPk3bW57H5btSsgZ6W8ueDVM6AJ/KRhPE1tt78JcwgNuRsPStNYg
	 Hlf2irjO0D5IHGfKkDpsGSObUdGVR7Xn7+YW3QU7QSm3aAKrWD9Ee5wHOhpfTamdCm
	 bxdWll08NDZvRIq1bpDm8/ziIHeZJQn2Noq1RNzE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6872F5AD00004B0C; Sat, 13 Jul 2025 07:54:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6257596816253
X-SMAIL-UIID: 28E6019430E24289A79DC38EA5093FE1-20250713-075424-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sun, 13 Jul 2025 07:54:10 +0800
Message-ID: <20250712235411.3747-1-hdanton@sina.com>
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
@@ -984,6 +984,7 @@ int netlbl_sock_setattr(struct sock *sk,
 	int ret_val;
 	struct netlbl_dom_map *dom_entry;
 
+	sockopt_lock_sock(sk);
 	rcu_read_lock();
 	dom_entry = netlbl_domhsh_getentry(secattr->domain, family);
 	if (dom_entry == NULL) {
@@ -1033,6 +1034,7 @@ int netlbl_sock_setattr(struct sock *sk,
 
 socket_setattr_return:
 	rcu_read_unlock();
+	sockopt_release_sock(sk);
 	return ret_val;
 }
 
@@ -1047,6 +1049,7 @@ socket_setattr_return:
  */
 void netlbl_sock_delattr(struct sock *sk)
 {
+	sockopt_lock_sock(sk);
 	switch (sk->sk_family) {
 	case AF_INET:
 		cipso_v4_sock_delattr(sk);
@@ -1057,6 +1060,7 @@ void netlbl_sock_delattr(struct sock *sk
 		break;
 #endif /* IPv6 */
 	}
+	sockopt_release_sock(sk);
 }
 
 /**
@@ -1137,6 +1141,7 @@ int netlbl_conn_setattr(struct sock *sk,
 #endif
 	struct netlbl_dommap_def *entry;
 
+	sockopt_lock_sock(sk);
 	rcu_read_lock();
 	switch (addr->sa_family) {
 	case AF_INET:
@@ -1199,6 +1204,7 @@ int netlbl_conn_setattr(struct sock *sk,
 
 conn_setattr_return:
 	rcu_read_unlock();
+	sockopt_release_sock(sk);
 	return ret_val;
 }
 
--

