Return-Path: <linux-kernel+bounces-728938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2727B02F3E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C1B189C37A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF71DED5F;
	Sun, 13 Jul 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FrVXrhYK"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98881D86C6
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752392509; cv=none; b=UGmkUTxbI5sXq1lkFPFgxl7swWV2rgTbo6py1DJ8tU3xm5atn6PlQNajHwk1/wpVM5QmLlGgOr8LtHBJTPaUv6RMwz7NZeTVzHfbdB5fI3Likyzzyfe4GaXddxbqs75vQOkV6EQp8z8PfR6BWxQwFtlKf90t6WfrI+HpH3Msh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752392509; c=relaxed/simple;
	bh=JKmW36pcDtX+M7wwzJ7Ik9LBn2C5vWVOZmEKcrYWq48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5ubgsCPoEczkVbUlgUgCmcbGPbglIvQl37HGUJc/Dq+tHL97zT+adJbhiHVYVg+SGLIonbrvHpzeawOf2r/9eB73hc9BdYTLgb6uoaqYzCJSeAjlIL1P/3aEF1+M5irETV0/jDXxKq5XuuKkHM7j6kFzpHjq2gaK1wu8TYWZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FrVXrhYK; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752392499;
	bh=oUqnBDZhD8BF/xhnIkMpWT5+MtU1+ov4aOTvEYvN8BY=;
	h=From:Subject:Date:Message-ID;
	b=FrVXrhYKMpJMUsDF5P+zRSsSF6qPryKT21mvEI0thUrXIeW8A0oKFx/iLCaroKjRT
	 lD2yRIM3aIhkGVvqgh1mipksZdgCKdhJHtjo6dprkz1oh43UYH8LEZAEHEaWcWi0E6
	 j32i4RQK/NP8BE+Mmvw6I088j5VfWHV8ISusSJl4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6873629800007BD8; Sun, 13 Jul 2025 15:39:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5406684456921
X-SMAIL-UIID: E5DCD609CCC64DAFA9E4578C080637A4-20250713-153906-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sun, 13 Jul 2025 15:38:53 +0800
Message-ID: <20250713073854.3864-1-hdanton@sina.com>
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
--

