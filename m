Return-Path: <linux-kernel+bounces-727608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE894B01CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B13189A003
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3312D9797;
	Fri, 11 Jul 2025 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="jKE0drOe"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A72D9788
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239144; cv=none; b=U4NLxF5seWbz+Y59iN2mVI6oO9jtMpus2P46saQyRHfoev5xH/tgYMCVBrd85BUgrWK51wMcz0sGemiBOSNC0XTGS7yxrHgduBxCL8IVLsgzlxbPou3HHtefszXu9baB8Y3us05RYBHbe8ZexV6eb1d0l6OlqcHnD/66LmPvBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239144; c=relaxed/simple;
	bh=2Thi8tcRuPyskRWxEmAqkMvxWYfp5D0TF7qSCfbJqNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afn8YhNmtk1eh4hifBPgBqXqZGXN1/opfDJV015i2zz0Tja+Zthc7q351MsOGqfLUEN+sdpEzH2Z7VWUdgBP7dNhuMugaAV1KjV+llwLT9MrpTs3axN7AQCaWMeVR4Fzb1J+xpnnaG+jzGrQ8h7eTTLpd1ZRfeiBoPFv4I5UeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=jKE0drOe; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752239140;
	bh=1omNYjJ6riU6ByMU5McbKDW2Vi0lR2stv3vFtfP43g4=;
	h=From:Subject:Date:Message-ID;
	b=jKE0drOe9hFALVwymap8kbbtguT6BEt98RP0LWUqmo/KEo1Hrevjc2qMNzfLu0NOt
	 RtJfg0kYO2Xl8ZKL33rS3E86b8gd+H9vGOAHyZSND5gXu6d924cRX3TyHHkGtkdxGW
	 EHpfs2flOkrTJ8/Hvd8b298t7F/fBW/gOecBT18M=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68710BFB00001401; Fri, 11 Jul 2025 21:05:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1085316816205
X-SMAIL-UIID: 72D3A27834DA402ABCAB73B010231145-20250711-210501-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Fri, 11 Jul 2025 21:04:48 +0800
Message-ID: <20250711130450.3505-1-hdanton@sina.com>
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
 
@@ -1998,13 +2003,19 @@ req_setattr_failure:
  * values on failure.
  *
  */
-static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
+static int cipso_v4_delopt(struct sock *sk)
 {
-	struct ip_options_rcu *opt = rcu_dereference_protected(*opt_ptr, 1);
+	struct ip_options_rcu *opt;
+	struct inet_sock *sk_inet;
 	int hdr_delta = 0;
 
-	if (!opt || opt->opt.cipso == 0)
+	spin_lock(&setattr_spinlock);
+	sk_inet = inet_sk(sk);
+	opt = rcu_dereference_protected(sk_inet->inet_opt, 1);
+	if (!opt || opt->opt.cipso == 0) {
+		spin_unlock(&setattr_spinlock);
 		return 0;
+	}
 	if (opt->opt.srr || opt->opt.rr || opt->opt.ts || opt->opt.router_alert) {
 		u8 cipso_len;
 		u8 cipso_off;
@@ -2036,10 +2047,11 @@ static int cipso_v4_delopt(struct ip_opt
 	} else {
 		/* only the cipso option was present on the socket so we can
 		 * remove the entire option struct */
-		*opt_ptr = NULL;
+		rcu_assign_pointer(sk_inet->inet_opt, NULL);
 		hdr_delta = opt->opt.optlen;
 		kfree_rcu(opt, rcu);
 	}
+	spin_unlock(&setattr_spinlock);
 
 	return hdr_delta;
 }
@@ -2054,12 +2066,9 @@ static int cipso_v4_delopt(struct ip_opt
  */
 void cipso_v4_sock_delattr(struct sock *sk)
 {
-	struct inet_sock *sk_inet;
 	int hdr_delta;
 
-	sk_inet = inet_sk(sk);
-
-	hdr_delta = cipso_v4_delopt(&sk_inet->inet_opt);
+	hdr_delta = cipso_v4_delopt(sk);
 	if (inet_test_bit(IS_ICSK, sk) && hdr_delta > 0) {
 		struct inet_connection_sock *sk_conn = inet_csk(sk);
 		sk_conn->icsk_ext_hdr_len -= hdr_delta;
@@ -2077,7 +2086,7 @@ void cipso_v4_sock_delattr(struct sock *
  */
 void cipso_v4_req_delattr(struct request_sock *req)
 {
-	cipso_v4_delopt(&inet_rsk(req)->ireq_opt);
+	cipso_v4_delopt(req_to_sk(req));
 }
 
 /**
--

