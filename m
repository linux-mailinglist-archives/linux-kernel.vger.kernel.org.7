Return-Path: <linux-kernel+bounces-728903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E387CB02EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A3F189B318
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD21953BB;
	Sun, 13 Jul 2025 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="flQyTD9Z"
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAEB7F9
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752383456; cv=none; b=AxgbrGjQ+uCPfNtmwF/UTk2VhxeuAPYUicEql89KzTZojk6Gv5qUSEMBS/dySYR6WZ78ZFkkej61mtAuYsCNSWBxOC/618evQiu8hz1ADdsaZthOMOUEGCcutAiVxXk+RcqPkeQIoCkolVU4St4nR1Dk1y2ikuXklg2BGgM2974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752383456; c=relaxed/simple;
	bh=nAj3xuAflunqdzBOhjl/913c3qqF08MHFVtpqBOvUwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCyy6aR3vCx6lerffJABSGVLJW3JMh037X+k/jSY5MP0ycMgHlkTRktvc9DYhww2Cpw8NMeGoSF1OccaCGTMqUmsgeW0FVcqS1vFpbHipC3x5DquTmhgBnQIpRBxEBSfHsu8LNNxv9ngQuYpIGMBTtDem777psKYC8sxtYqISLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=flQyTD9Z; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752383447;
	bh=l4D8OQlPEXwA0uaWv0Wrg9Y19k0KH/MmUNazFwV7x+4=;
	h=From:Subject:Date:Message-ID;
	b=flQyTD9Z2F6xzFe0vipI6zLsBZAHeDkL3XO+jbPcalEbVX7PIrspjqtTTyelR18Cd
	 4btTiSH9T7paSOoAiEG7lJERWVIMuEt33kXOAHJ8P7OzoAEh40F/RhHzjtZr4TvDkV
	 Egg1BJWgqi+1Dqk5bcvYp7ueVWR5Ia4xybVUjsfs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68733FCC00001438; Sun, 13 Jul 2025 13:10:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2977156816230
X-SMAIL-UIID: 89FD9360CCCF4456BA3AF34B64A88742-20250713-131038-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sun, 13 Jul 2025 13:10:25 +0800
Message-ID: <20250713051026.3829-1-hdanton@sina.com>
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

--- x/include/net/inet_sock.h
+++ y/include/net/inet_sock.h
@@ -227,6 +227,7 @@ struct inet_sock {
 	__be16			inet_sport;
 	struct ip_options_rcu __rcu	*inet_opt;
 	atomic_t		inet_id;
+	spinlock_t		inet_lock;
 
 	__u8			tos;
 	__u8			min_ttl;
--- x/net/ipv4/af_inet.c
+++ y/net/ipv4/af_inet.c
@@ -351,6 +351,7 @@ lookup_protocol:
 		inet->pmtudisc = IP_PMTUDISC_WANT;
 
 	atomic_set(&inet->inet_id, 0);
+	spin_lock_init(&inet->inet_lock);
 
 	sock_init_data(sock, sk);
 
--- x/net/ipv4/ip_sockglue.c
+++ y/net/ipv4/ip_sockglue.c
@@ -1087,6 +1087,7 @@ int do_ip_setsockopt(struct sock *sk, in
 		err = ip_options_get(sock_net(sk), &opt, optval, optlen);
 		if (err)
 			break;
+		spin_lock(&inet->inet_lock);
 		old = rcu_dereference_protected(inet->inet_opt,
 						lockdep_sock_is_held(sk));
 		if (inet_test_bit(IS_ICSK, sk)) {
@@ -1109,6 +1110,7 @@ int do_ip_setsockopt(struct sock *sk, in
 		rcu_assign_pointer(inet->inet_opt, opt);
 		if (old)
 			kfree_rcu(old, rcu);
+		spin_unlock(&inet->inet_lock);
 		break;
 	}
 	case IP_CHECKSUM:
--- x/net/ipv4/cipso_ipv4.c
+++ y/net/ipv4/cipso_ipv4.c
@@ -1900,6 +1900,7 @@ int cipso_v4_sock_setattr(struct sock *s
 	buf = NULL;
 
 	sk_inet = inet_sk(sk);
+	spin_lock(&sk_inet->inet_lock);
 
 	old = rcu_dereference_protected(sk_inet->inet_opt, sk_locked);
 	if (inet_test_bit(IS_ICSK, sk)) {
@@ -1912,6 +1913,7 @@ int cipso_v4_sock_setattr(struct sock *s
 	rcu_assign_pointer(sk_inet->inet_opt, opt);
 	if (old)
 		kfree_rcu(old, rcu);
+	spin_unlock(&sk_inet->inet_lock);
 
 	return 0;
 
@@ -2059,7 +2061,9 @@ void cipso_v4_sock_delattr(struct sock *
 
 	sk_inet = inet_sk(sk);
 
+	spin_lock(&sk_inet->inet_lock);
 	hdr_delta = cipso_v4_delopt(&sk_inet->inet_opt);
+	spin_unlock(&sk_inet->inet_lock);
 	if (inet_test_bit(IS_ICSK, sk) && hdr_delta > 0) {
 		struct inet_connection_sock *sk_conn = inet_csk(sk);
 		sk_conn->icsk_ext_hdr_len -= hdr_delta;
--

