Return-Path: <linux-kernel+bounces-730943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902DEB04CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFC94A7054
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916614B959;
	Tue, 15 Jul 2025 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="E/meXjj8"
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4314AD20
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538928; cv=none; b=my8O8imja5MkmIDnPuqnFMWNn5fy6G+4kS5Zgj0aJOEhGo76zSYY3ulr+6SW1Zx0a9l2sw1OLktvGlKLp7G3f780hqGTvA7Qcze5+AZ28TvNa7Po2cfXDP+cmg49XjD7N8/xZ0vQhHlxrpTY6OAE1EFajoDdPcgPmsUVojGs6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538928; c=relaxed/simple;
	bh=Fon+973Kn2it/P/DjAvGLU8odvErfc+dnV1yIUJNsRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X91MYIDAV3KEsPNEAvmU1FB7MLj6Rn1me1wh3TkkuHLCOB656mLd65F+gPb6A8HsfJXlV5s/AsNyQFd+w2ZrgXqoszxWJ3A3MiPJAWnqoSMI2JdqJU7MkNGHPCZbW44vK9ha7pEKoODdYKet6hGZfXpcZcFbqt3c9Yo7O8NNiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=E/meXjj8; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752538923;
	bh=CQ8dZBKC3wf9X4bBCQImnZZcVjwOZaF6fHfCDmOk17Y=;
	h=From:Subject:Date:Message-ID;
	b=E/meXjj817hrWWrsKQA7stFRe066wYreJv3+LklRTBB8Zw3shzAY6lkVwzflUeKZm
	 Qbf4WuKuJYib/3ZAQqru6hWLqQkZv5/Qc51Y9WTSz5aiLxhNL9wKQI7PJg1WkRbddw
	 2A0/5V+qG/X69PvXM7V6ahE4U3wt9T8XpnvOyzuc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68759F2000006277; Tue, 15 Jul 2025 08:21:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3565916685134
X-SMAIL-UIID: 4D2B1738B10D4CFCA9486EC6A44F514F-20250715-082154-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in query_matching_vma
Date: Tue, 15 Jul 2025 08:21:39 +0800
Message-ID: <20250715002143.4033-1-hdanton@sina.com>
In-Reply-To: <68757288.a70a0220.5f69f.0003.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 14 Jul 2025 14:11:36 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    a62b7a37e6fc Add linux-next specific files for 20250711
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1422dd82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d42120e19faaef
> dashboard link: https://syzkaller.appspot.com/bug?extid=d4316c39e84f412115c9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1222dd82580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1205d0f0580000

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

