Return-Path: <linux-kernel+bounces-728990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E7B0303D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE861891EFF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70934241CB7;
	Sun, 13 Jul 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0AJ7b7xa"
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A4242D90
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396215; cv=none; b=RBtcbqKq9sj2q1jpUvcflgdIZX9S7jsL3LmV5zYlHxiOR3zLWDOrhCk5PZwV1atYKLKjzFcAOCbZIzPxl9jeZ92lMfliluOnF7pcygLEHy+oEyyCQciD23UOv8j3OrpUMnNif6rtSByJ6Iga42A/a8q0tX5r/HZ5k8YPyvE99a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396215; c=relaxed/simple;
	bh=X4Cm1zy/G2u7mBx/2cRRmndUCP3vQCFU5w2PVmt4oWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAwv5Kii3seHeHKbizxmIdU9kg4wxc3F/s8sGE7AG7tI5PYw/3LH83UahqdPmzB1Uvo+2DLHxxOGA6Qsl5IFgk9Wb0223nco4Gyqcq/EiA4WTnCqe5IyxgwV9ru7kcRLqXi2fj7Wdgd4hwuJd0N8+42SYQ2q8cZMXghLBohdrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0AJ7b7xa; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752396210;
	bh=oA4nwM9YD19Q13EYG+RJQgYdlq44mtA0kClOFWAwmkI=;
	h=From:Subject:Date:Message-ID;
	b=0AJ7b7xafsAnINk+TCFlOztKYmnXP6ERVypAwejoXfEgwtAg5fONS1frv89agbp3H
	 06F6+7Izcg0kjJ5nJE6JysXpSQJtQneejl7k6HKW9ZGTtb4TUnmhXXciiGNtyNH6S9
	 wl9K5d4galt0mJF1+P+YsQo7JzTYlTzWC1qua4zU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 687371A700000EA5; Sun, 13 Jul 2025 16:43:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6916046292070
X-SMAIL-UIID: ED3EA54AEC4C4180B4A3DE02682D5C30-20250713-164320-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sun, 13 Jul 2025 16:43:08 +0800
Message-ID: <20250713084309.3912-1-hdanton@sina.com>
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

--- x/net/ipv4/ip_sockglue.c
+++ y/net/ipv4/ip_sockglue.c
@@ -1087,6 +1087,8 @@ int do_ip_setsockopt(struct sock *sk, in
 		err = ip_options_get(sock_net(sk), &opt, optval, optlen);
 		if (err)
 			break;
+		sockopt_release_sock(sk);
+		bh_lock_sock(sk);
 		old = rcu_dereference_protected(inet->inet_opt,
 						lockdep_sock_is_held(sk));
 		if (inet_test_bit(IS_ICSK, sk)) {
@@ -1109,6 +1111,8 @@ int do_ip_setsockopt(struct sock *sk, in
 		rcu_assign_pointer(inet->inet_opt, opt);
 		if (old)
 			kfree_rcu(old, rcu);
+		bh_unlock_sock(sk);
+		sockopt_lock_sock(sk);
 		break;
 	}
 	case IP_CHECKSUM:
--- x/net/netlabel/netlabel_kapi.c
+++ y/net/netlabel/netlabel_kapi.c
@@ -1149,9 +1149,11 @@ int netlbl_conn_setattr(struct sock *sk,
 		}
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CIPSOV4:
+			bh_lock_sock(sk);
 			ret_val = cipso_v4_sock_setattr(sk,
 							entry->cipso, secattr,
 							netlbl_sk_lock_check(sk));
+			bh_unlock_sock(sk);
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
--

