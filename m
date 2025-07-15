Return-Path: <linux-kernel+bounces-731004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD1B04D69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8435C1AA0F63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0121B4231;
	Tue, 15 Jul 2025 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="cfuRApg6"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260439FD9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542857; cv=none; b=K8lz8Jbd0yM18TU9yztaPVzNA5NkyHWPWkuPlkVWUaAY1XgXo/wV3eFribZyL1toIjwDlbfQh1mgZDLwp2+b2PTgdNHEjCyAc9rvyGsUUVm7M496PQOsvYj4VjBPaVWPEo1SJ3hwxljWFwrJmp2XmFx4R03r8gkxpnkj2i4qsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542857; c=relaxed/simple;
	bh=KKSKBPaFVwWh9FIXXGc1pxHABF0fgloFS21N6HeQ5Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMk3yB2ETFeDYROGSl7VbigqQoMWoxJ1A7O0tmqCG7B9dCTE3NMXWgg9mHlzhZ/PF6HjLV22sHx2TFzew6N2QDIXOdKRVWO/j/VwZWsI7vgS+9ln82zWUgg82rTeX95+edoEc0Qy3DpDWmbB0RPO6kPd0seTwnOiFY+uNdMQaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=cfuRApg6; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752542851;
	bh=e6OHsS6QCRPQrXNp7h/GBesAVekxJtH4MShEsA17cxk=;
	h=From:Subject:Date:Message-ID;
	b=cfuRApg6KYLlu9XsoCWb96BgkJyc8MCmu/Lq6gCTGnU+aqeygt1m336Ea951j811+
	 H97HYr03aLi/fCnhBNuJk2KsvTlNpUhTkNFwuE9T/VIupXZ3Rv3ArCbFiVsBqrkjw8
	 lEH0fzkBfd15zYos0mTZIWaMJ4nxqCrDHcT0WWOM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6875AE7E0000570E; Tue, 15 Jul 2025 09:27:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5603044456923
X-SMAIL-UIID: A76B33F8BC094CBA8FA67617EAA02A24-20250715-092727-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
Date: Tue, 15 Jul 2025 09:27:16 +0800
Message-ID: <20250715012717.4112-1-hdanton@sina.com>
In-Reply-To: <68753289.a70a0220.18f9d4.0003.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 14 Jul 2025 09:38:33 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15cfb0f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=be9e2082003f81ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1003b18c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11437d82580000

#syz test

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

