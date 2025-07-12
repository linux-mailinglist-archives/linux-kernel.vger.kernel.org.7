Return-Path: <linux-kernel+bounces-728488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C9B028DA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19B81C40B78
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242BB155389;
	Sat, 12 Jul 2025 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="OF7CZM8Q"
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B32AE6A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752285324; cv=none; b=AhzASNvVYemFRdFYTcLhcG6avVAxhsjyeis+4k+E0mZOPaqPioVaMYaqCs/kLX7qYTlqzKWNgcSu1QE1TcP2DD+2lZzDazPZ0mCre18rggxo3BEWxzMaeRtI+veCUs6pFpqMynfGjGsi/hbwFWLqRVk0nnIhvZVa4Zs1kAsOJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752285324; c=relaxed/simple;
	bh=asm6o7Q/8NUr3ItmqAUcOm8bw+IKGW+ZElEb7wPwKLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP2/bEUlTdtpBWjwZB6tyxpNkUj4emEQ5ByvVzr2ha5pMmoH0FbPgNxZVAST/4XMSs+4NkzNkXIczdzA8kmjxn+HJSx6j2fVoZQUkmKMHDdKU2n5PZB8EMkb0fRUTsf7DZ15XbrMEcWhztstTP60JRsdl0BSdKZjXykpH1Bhwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=OF7CZM8Q; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752285315;
	bh=gNqaHLhfvOjbVIXd+fUqoQ9cSOmgg3zsF6lN/Gv0y9U=;
	h=From:Subject:Date:Message-ID;
	b=OF7CZM8Q0Mc0AeJf5x0TJfYG8mL8CtPPj3Sj/UatsBa+a/zBuSFNbS94jU/dpnrLg
	 BGp/Jp0PPg9yfU4/MmPNrj0zmmXLAratv9E98Hs8jX31ncOa3RhsYgr3GfqmZB9uYy
	 zsQoJkEUyk9nnHNMXo/ySGOFpVxZOcF7Sd/9bFzk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6871C07800007186; Sat, 12 Jul 2025 09:55:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8969516816231
X-SMAIL-UIID: F39B097E887647A9904A6DCF4EA56214-20250712-095505-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sat, 12 Jul 2025 09:54:54 +0800
Message-ID: <20250712015455.3638-1-hdanton@sina.com>
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
+DEFINE_SPINLOCK(setattr_spinlock);
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
--- x/include/net/sock.h
+++ y/include/net/sock.h
@@ -2922,6 +2922,7 @@ extern __u32 sysctl_rmem_max;
 
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
+extern spinlock_t setattr_spinlock;
 
 #define SKB_FRAG_PAGE_ORDER	get_order(32768)
 DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
--- x/net/ipv4/ip_sockglue.c
+++ y/net/ipv4/ip_sockglue.c
@@ -1087,6 +1087,7 @@ int do_ip_setsockopt(struct sock *sk, in
 		err = ip_options_get(sock_net(sk), &opt, optval, optlen);
 		if (err)
 			break;
+		spin_lock(&setattr_spinlock);
 		old = rcu_dereference_protected(inet->inet_opt,
 						lockdep_sock_is_held(sk));
 		if (inet_test_bit(IS_ICSK, sk)) {
@@ -1109,6 +1110,7 @@ int do_ip_setsockopt(struct sock *sk, in
 		rcu_assign_pointer(inet->inet_opt, opt);
 		if (old)
 			kfree_rcu(old, rcu);
+		spin_unlock(&setattr_spinlock);
 		break;
 	}
 	case IP_CHECKSUM:
--

