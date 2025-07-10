Return-Path: <linux-kernel+bounces-726620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC429B00F55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CFD547887
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FCE2BEC52;
	Thu, 10 Jul 2025 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="loS9hw5K"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC12BE7B0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189023; cv=none; b=XioASOngqyVUrzckbumpkRugi4EntkHqRWdLstfdjQmUm3BiGlW5UKUIgOJ2WTKmbv5D+pBrqqgKdb72SD/DZw7qr81+CdfH2if1Dd7kP4a6+X8qcbwEc7UJ9C/F85X3VIycn23VVcOHSEaBpwDVn3jRPWkDu9h/ggLl39ZwZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189023; c=relaxed/simple;
	bh=gJXg27jM3dtNo58bvL/wyJvdIwDKMd12uZZgP0khWoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOiFPKYzMSxLorYKSx8DFRaCfUUaUcaYuUvgzVqMHeZKiqiQvCY5Xe7wZ+LkDOnWfDVsIo6ZUSywCcqlaBUUiiTZWXg/nblvT36r73MkpxjSm9cj53kBs9Gi4hdwY0PQAJ6Qi9Nn1QA1J9PgmsYWfToJ9xHzzvynLtOvrlIOJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=loS9hw5K; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752189017;
	bh=scMGScdEyyL/SdjxNz6/leh7ASjx1NNSaetWrkz6Wt0=;
	h=From:Subject:Date:Message-ID;
	b=loS9hw5K5SwMf0iWjEaxXuYxMUZxoC+ivvIpnaMsOoqjBkRd/sFuZG3JMRrkqo/ZC
	 Cp32CxGz+v09AGT3v99R+W3Ds/b7T1uOzaEUq3x7uQG4aWhU2s15V7b0wo9z+4Ke0d
	 4qeVWCJ5ufQE17Eu0BJHG0r/N7UCRH2E8gYf/+YM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6870482A0000369B; Thu, 11 Jul 2025 07:09:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5966936816264
X-SMAIL-UIID: 598792E4F57A457BB45C0487F5B424C0-20250711-070932-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Fri, 11 Jul 2025 07:09:08 +0800
Message-ID: <20250710230921.3225-1-hdanton@sina.com>
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
@@ -1910,6 +1912,7 @@ int cipso_v4_sock_setattr(struct sock *s
 		sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
 	}
 	rcu_assign_pointer(sk_inet->inet_opt, opt);
+	spin_unlock(&setattr_spinlock);
 	if (old)
 		kfree_rcu(old, rcu);
 
--

