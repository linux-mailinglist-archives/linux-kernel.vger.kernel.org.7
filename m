Return-Path: <linux-kernel+bounces-815018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D35B55E35
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C12AA57E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 04:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422211E9B0B;
	Sat, 13 Sep 2025 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Q3gQjR+W"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF135968
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757736519; cv=none; b=e2JEPbWZoKg9BfNzo0He2LvWfWX2k5xsjXhordncpIGe/hds83UXlkfmAjkozNLJlno8D0rZuUQd0A1OKd3nOyNuVjCt2YqFsReD+aSVm4Ned7YSLC76a9kh5hZA4eh9+P333OO0w1mIWUpi8o7udvNRj0jDQQMPI2YzFXJ7mj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757736519; c=relaxed/simple;
	bh=Jt33AzfLQIuLqIBPvJLVZ9RYYyN0qYenLlVwz0XaD+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDY6LQkTN8jSZrTIXoHrjxADPCRZqWQ2KiK5vUVL+sExjiZHegmsG1R3jcTIoXXXIAIUS1x2fv0lng40MNQ4LHic5JwBCs0cUpAk2mpcuxEIZaksaCJwiy59yk9dTpHGXv43O4l7NFxGAdazFiGdpZRvzIxE0FagJ/QwAJmqaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Q3gQjR+W; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757736514;
	bh=gGYwm0LRjTr770IHkOLO2QN58gYe1BuaylrhdxrBUiU=;
	h=From:Subject:Date:Message-ID;
	b=Q3gQjR+Wz13M42ATzfcdkYzaL2UmFXogvkquqzbNl5n4M7H5+uz5fZDozeaLDPQNb
	 Sq1Uw19sLUE+O+Ne/Y7ZjTTXn71FNr0xk/7r0zRWDMQL+CVn8t7iJ1aSZE8YmiHQF4
	 OlBhhlSTAaQoZOMgtVMlTo5tia/+u3RRwFcO3bl0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68C4ECF9000008D9; Sat, 13 Sep 2025 12:03:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3389216685357
X-SMAIL-UIID: 7CECBC62C76742E69A6671562AC2546A-20250913-120307-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: wild-memory-access Read in l2cap_connect_cfm
Date: Sat, 13 Sep 2025 12:02:51 +0800
Message-ID: <20250913040256.6972-1-hdanton@sina.com>
In-Reply-To: <68c44056.a70a0220.3543fc.0036.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 12 Sep 2025 08:46:30 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    590b221ed425 Add linux-next specific files for 20250912
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=161d1934580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9134e501f17b95a4
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111d1934580000

#syz test

--- x/include/net/bluetooth/l2cap.h
+++ y/include/net/bluetooth/l2cap.h
@@ -938,6 +938,7 @@ static inline long l2cap_chan_no_get_snd
 
 extern bool disable_ertm;
 extern bool enable_ecred;
+extern struct mutex cfm_mutex;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
--- x/net/bluetooth/l2cap_sock.c
+++ y/net/bluetooth/l2cap_sock.c
@@ -1411,6 +1411,7 @@ shutdown_already:
 	return err;
 }
 
+DEFINE_MUTEX(cfm_mutex);
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1422,9 +1423,11 @@ static int l2cap_sock_release(struct soc
 	if (!sk)
 		return 0;
 
+	mutex_lock(&cfm_mutex);
 	lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 	l2cap_sock_cleanup_listen(sk);
 	release_sock(sk);
+	mutex_unlock(&cfm_mutex);
 
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
--- x/net/bluetooth/l2cap_core.c
+++ y/net/bluetooth/l2cap_core.c
@@ -7301,7 +7301,9 @@ next:
 		pchan = next;
 	}
 
+	mutex_lock(&cfm_mutex);
 	l2cap_conn_ready(conn);
+	mutex_unlock(&cfm_mutex);
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
--

