Return-Path: <linux-kernel+bounces-729296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF9B03489
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121F93AF391
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7FD1D6DB6;
	Mon, 14 Jul 2025 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="MLiP0MFN"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3518D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460635; cv=none; b=QZIxixexU4o16Lvo/0k0ltDvWmrLMrwR5/OmzAJiRHxvDV3wEtUNMHnNo+MOflxpXuhEOWh0m1uNK+8UL1LfILfgcqKWqzjaKrVUkXZYZ0rHOOGQjhcJ8KrXf/tp8t1WMhoj5jEigu/KGGBOVfNrhmaPShR00YqGZwniPjUf/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460635; c=relaxed/simple;
	bh=X5ol0HZRR84Xx/of8kM+0XXzXrWatPyPgKsLbuR7mE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAwjXK5AFu3jniwxnPYs85XhNJovW+FwYs5PINqQqnCp4PfYhAsM9qq2Ch7fK3NEJmufqQ2QM5pWczdhGoH7DEy9SPfQKLIF89UJg5T8JcHHMEajUBSvcZH+wxh4clSszPVDI8Pk2wM2qIreaj9iJfTd9/GVGj5nn3KwyhZ67N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=MLiP0MFN; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752460626;
	bh=crfn74PFhOnaJHfTD50sqiS6Wzgnxv9ORpJiI78GfUQ=;
	h=From:Subject:Date:Message-ID;
	b=MLiP0MFNOy1VS9/xZtlFAopuje9bOq/OuCcPvQfEOoqjVVQMvEWjbujNlzXmkshon
	 Nv+taCd3HeBnXnOSIDQfIJzhUIhnrDH3IuwtkMzrwmMm57r0kHpvNXmRJesmJxn8be
	 3aKzIJAIPwVA1kQK9ctLYg7HWD3EpB2D9S6JK9F8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68746D4600001371; Mon, 14 Jul 2025 10:36:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4403626685188
X-SMAIL-UIID: 197F34C45FA24CBF99CDE5C760DFEC85-20250714-103656-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Mon, 14 Jul 2025 10:36:44 +0800
Message-ID: <20250714023645.3950-1-hdanton@sina.com>
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

--- x/security/smack/smack_lsm.c
+++ y/security/smack/smack_lsm.c
@@ -2575,6 +2575,7 @@ static int smack_netlbl_add(struct sock
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
+	sock_hold(sk);
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
@@ -2591,6 +2592,7 @@ static int smack_netlbl_add(struct sock
 	}
 
 	bh_unlock_sock(sk);
+	sock_put(sk);
 	local_bh_enable();
 
 	return rc;
@@ -2612,10 +2614,12 @@ static void smack_netlbl_delete(struct s
 	if (ssp->smk_state != SMK_NETLBL_LABELED)
 		return;
 
+	sock_hold(sk);
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 	netlbl_sock_delattr(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 	local_bh_enable();
 	ssp->smk_state = SMK_NETLBL_UNLABELED;
 }
--

