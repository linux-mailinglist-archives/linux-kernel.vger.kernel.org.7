Return-Path: <linux-kernel+bounces-728449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9FB0283C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FBEA4125A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A721805B;
	Sat, 12 Jul 2025 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Xfze/kXE"
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CECEED7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279677; cv=none; b=kA4TQ/YMJEhKLmlQrEahJK7YOTVPz7OcQaukOc/QUEbVOWM69b+O/IVRn/nkd3oR7fJjD1xVaSq7CifNEzWCMaqsDzpCY0XtrXJoClukWJHXEVzwkxXl332BasJrG7lVHvF78e60p27GibQSR6kJqjtUAyHbqA6n5n3ROm/sFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279677; c=relaxed/simple;
	bh=oFtmpYOH0kqS+S6EVqtlBBKkoRqz6ahOX6XadTkhtFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvYk5sImkMN7Tes//5dmL09pONTBN9A4V1uticlfMiSlkCKrhyBWegH850gUp0Ro55qLS10lyNfc6J4u0u+d39AU1++AUjOu40ow7dP9tpTGHRYfCzGhd6FCnqIcXOC/tYDQmgcRO8WMdZOduDB/o5aXiih3v3bKmZecPR73eTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Xfze/kXE; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752279672;
	bh=IcHfYnAyDbfI7ncFpwQYGQ+h0TVbm+tA9WMbo2YS4lU=;
	h=From:Subject:Date:Message-ID;
	b=Xfze/kXEF9DMMYlCEnilAI2FiD8BIr8afxyEpyUbmXuyAjI+kKkyUHnSR8io56nyL
	 7pJephyIp00uwyitas9zyPz1mS2ob8SQ0SyUQWeCmZ+r2dD//ePBfXFW10BlYpdZE4
	 P0eJXU3eAWAwzAzExZcW1YnKYq5IycQdJAFu5KZU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 6871AA6D00000ECF; Sat, 12 Jul 2025 08:21:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7706806685131
X-SMAIL-UIID: FBD3EA6C9D4142A5ABB108CEB8AE1023-20250712-082103-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sat, 12 Jul 2025 08:20:51 +0800
Message-ID: <20250712002052.3539-1-hdanton@sina.com>
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

--- x/net/ipv4/cipso_ipv4.c
+++ y/net/ipv4/cipso_ipv4.c
@@ -1848,6 +1848,7 @@ static int cipso_v4_get_actual_opt_len(c
  * values on failure.
  *
  */
+static DEFINE_SPINLOCK(setattr_spinlock);
 int cipso_v4_sock_setattr(struct sock *sk,
 			  const struct cipso_v4_doi *doi_def,
 			  const struct netlbl_lsm_secattr *secattr,
@@ -1899,6 +1900,7 @@ int cipso_v4_sock_setattr(struct sock *s
 	kfree(buf);
 	buf = NULL;
 
+	spin_lock(&setattr_spinlock);
 	sk_inet = inet_sk(sk);
 
 	old = rcu_dereference_protected(sk_inet->inet_opt, sk_locked);
@@ -1912,6 +1914,7 @@ int cipso_v4_sock_setattr(struct sock *s
 	rcu_assign_pointer(sk_inet->inet_opt, opt);
 	if (old)
 		kfree_rcu(old, rcu);
+	spin_unlock(&setattr_spinlock);
 
 	return 0;
 
@@ -1975,10 +1978,12 @@ int cipso_v4_req_setattr(struct request_
 	kfree(buf);
 	buf = NULL;
 
+	spin_lock(&setattr_spinlock);
 	req_inet = inet_rsk(req);
 	opt = unrcu_pointer(xchg(&req_inet->ireq_opt, RCU_INITIALIZER(opt)));
 	if (opt)
 		kfree_rcu(opt, rcu);
+	spin_unlock(&setattr_spinlock);
 
 	return 0;
 
@@ -2057,9 +2062,11 @@ void cipso_v4_sock_delattr(struct sock *
 	struct inet_sock *sk_inet;
 	int hdr_delta;
 
+	spin_lock(&setattr_spinlock);
 	sk_inet = inet_sk(sk);
 
 	hdr_delta = cipso_v4_delopt(&sk_inet->inet_opt);
+	spin_unlock(&setattr_spinlock);
 	if (inet_test_bit(IS_ICSK, sk) && hdr_delta > 0) {
 		struct inet_connection_sock *sk_conn = inet_csk(sk);
 		sk_conn->icsk_ext_hdr_len -= hdr_delta;
@@ -2077,7 +2084,9 @@ void cipso_v4_sock_delattr(struct sock *
  */
 void cipso_v4_req_delattr(struct request_sock *req)
 {
+	spin_lock(&setattr_spinlock);
 	cipso_v4_delopt(&inet_rsk(req)->ireq_opt);
+	spin_unlock(&setattr_spinlock);
 }
 
 /**
--

