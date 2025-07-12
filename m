Return-Path: <linux-kernel+bounces-728529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BDB0298C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DF17F730
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488E21504E;
	Sat, 12 Jul 2025 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="HUqQVoPo"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913953C3C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752300496; cv=none; b=VDTRR5XbXfJfjCkyuIIOkwHXXR26+nb+DsEDtYZ6MoNPoo7kwJEd2iE3B7mgrlCjhkPfWgEdDFUboSUXFQ3ecmEEM4i3Oel3v87DVMU8zy07paqNXKsZoOxGBi1ACrmlLTT7GrF+JsqUVzp3AgW3XXriDxIMQB4KyxiZAUaxuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752300496; c=relaxed/simple;
	bh=5i8bJMrF3fwWuuYQpm/ujYMRh5p/o74Log03OTV87AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuMC0r4NnkxYLA8LvlKcQ/DNw9GPgx9uIRiHFkh02S2lwDDqLLHNJKkqcKLzUTcDdApUh75VUXN4tDUXEeriViWA4q8ch0qMT2jimS4GwWwngnkpsSNUdsXQUyuhOtYRvwiNx2cvkJt08hJxJl0/u4ANaJhmGzOFzWloZkEIzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=HUqQVoPo; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752300485;
	bh=AynR89EmYqJTVbh+FPzfKLjNhZDAvFlMajC7AvUURSg=;
	h=From:Subject:Date:Message-ID;
	b=HUqQVoPoKhyJYPIHL4N8twHEm5TkgH2klSakRzb75TehDSlP+8eoS9F6hJ80lTuC0
	 1HIzQJ2Es6orv97auODg9ahLYB5jmNbAO/W4nR5dIpdhQnUpbbfnRvKAk9cXVyvLhG
	 bWYkPcXMVEdcnLRa1OUvStlAVQF2zN48BwiK79DI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6871FB9500001739; Sat, 12 Jul 2025 14:07:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6259534456998
X-SMAIL-UIID: E9D500A5620E490DB8E06B65925E4BB9-20250712-140720-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Sat, 12 Jul 2025 14:07:07 +0800
Message-ID: <20250712060708.3708-1-hdanton@sina.com>
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
@@ -960,6 +960,7 @@ int netlbl_enabled(void)
 	return (atomic_read(&netlabel_mgmt_protocount) > 0);
 }
 
+static DEFINE_SPINLOCK(setattr_spinlock);
 /**
  * netlbl_sock_setattr - Label a socket using the correct protocol
  * @sk: the socket to label
@@ -997,9 +998,11 @@ int netlbl_sock_setattr(struct sock *sk,
 			ret_val = -EDESTADDRREQ;
 			break;
 		case NETLBL_NLTYPE_CIPSOV4:
+			spin_lock(&setattr_spinlock);
 			ret_val = cipso_v4_sock_setattr(sk,
 							dom_entry->def.cipso,
 							secattr, sk_locked);
+			spin_unlock(&setattr_spinlock);
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			ret_val = 0;
@@ -1049,7 +1052,9 @@ void netlbl_sock_delattr(struct sock *sk
 {
 	switch (sk->sk_family) {
 	case AF_INET:
+		spin_lock(&setattr_spinlock);
 		cipso_v4_sock_delattr(sk);
+		spin_unlock(&setattr_spinlock);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
@@ -1149,9 +1154,11 @@ int netlbl_conn_setattr(struct sock *sk,
 		}
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CIPSOV4:
+			spin_lock(&setattr_spinlock);
 			ret_val = cipso_v4_sock_setattr(sk,
 							entry->cipso, secattr,
 							netlbl_sk_lock_check(sk));
+			spin_unlock(&setattr_spinlock);
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
--

