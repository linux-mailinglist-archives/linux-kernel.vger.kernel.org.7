Return-Path: <linux-kernel+bounces-726835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11FB011CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831E47AC1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299841A0BE0;
	Fri, 11 Jul 2025 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="o+F6YC8d"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD305195B1A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206113; cv=none; b=FZOiU+zvAcfq219e0x/vRpitgG2feTo6LE58qZCLUq9cc4C55zkedpfKAmEboEnVUnW7+QTcaqu8jNGWCn64voXzi3pV0a74Gqi8iKJIqezjYBhfa2ZIE7iwboLypgATbZ208liICBtzDMB7E67k+Nf7MACd0g7te1pmXHFzhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206113; c=relaxed/simple;
	bh=6bdAnwuN8BS383GciLQbI8R29hrj0ilgaVD+Yu4QGwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mtv2FVcxLxlu4EWxj4eOM7gUOartwRgk9DkejC1HT5JfpDfpGTUhppbFn3wVbqhmvTowaoKiR8LU8OkWeZQ79gsLs360IWxE/l7M1VNX02ZWJp8Kx9Wppuh2L9ymq9ZajNIXXrDIR2+ldjpEFHtZhMQN93vjixkUCsq+mfJZat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=o+F6YC8d; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752206108;
	bh=btaaLwHaWfqJx6O4EiNBmfuGeqGj11I6HyaouZXxYpk=;
	h=From:Subject:Date:Message-ID;
	b=o+F6YC8dugR02RihzDrlGYtNxeo7nr2TRpI4uwqd4wkLvVW3jN4x/Dw4EdnDK5KRy
	 dbDrDfvJA8w2wyhb0/RQl+XzJU+AC6yjrspYpQWAwhdar+MrkRRTFAqlEPLJRALde+
	 UB+J6ps4Idm1Lu4KNdiWBXzjTFS3v9hdRt2Tuaug=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68708AF3000066A9; Fri, 11 Jul 2025 11:54:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 911916291982
X-SMAIL-UIID: B35AAB7E816841508AD72BC7F1FEB922-20250711-115429-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
Date: Fri, 11 Jul 2025 11:54:17 +0800
Message-ID: <20250711035418.3336-1-hdanton@sina.com>
In-Reply-To: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 10:52:27 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1719df70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
> dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1124abd4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099df70580000

#syz test https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  master

--- x/fs/proc/task_mmu.c
+++ y/fs/proc/task_mmu.c
@@ -585,6 +585,7 @@ no_vma:
 	return ERR_PTR(-ENOENT);
 }
 
+static DEFINE_MUTEX(query_mutex);
 static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 {
 	struct procmap_query karg;
@@ -620,8 +621,10 @@ static int do_procmap_query(struct proc_
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
+	mutex_lock(&query_mutex);
 	err = query_vma_setup(priv);
 	if (err) {
+		mutex_unlock(&query_mutex);
 		mmput(mm);
 		return err;
 	}
@@ -712,6 +715,7 @@ static int do_procmap_query(struct proc_
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
 	query_vma_teardown(priv);
+	mutex_unlock(&query_mutex);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -732,6 +736,7 @@ static int do_procmap_query(struct proc_
 
 out:
 	query_vma_teardown(priv);
+	mutex_unlock(&query_mutex);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
--

