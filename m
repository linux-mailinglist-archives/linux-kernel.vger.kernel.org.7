Return-Path: <linux-kernel+bounces-726843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7FB011E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6898A17C1C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8C719FA8D;
	Fri, 11 Jul 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ewpgLj6U"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A958F7D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206600; cv=none; b=N/Wf44A85Xg3/BBLC/vJ/Viij/SKJsVU8bewt0+C+4QoiN+x4mzGYzHXgyKMsni/kIwnS81Cv5sHiD40r/DWTWQEiUjH3rDBol3Im+f7u37YLyPOif5xMwKx/HRY1IXI8+ATOrmOIyZLBMc7NozqaP2BHI8rQ7LQZ1Gd3BMArlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206600; c=relaxed/simple;
	bh=1gG4IPAq7uADg5KkY2I4EhZKpKzZQFTsP87scFhXPro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isRGy96ph9FecBwKz3sjHR/xIga513B3uYmRVY3VPzXdoSl4Axl5jmtFyoq43XQFEgoJUTPgWG8Tn8nG/YOC6t3j5UaD5cDBJcw6ymOW6HFlkeYJYDy+miTyX3m4FfWdnk9b7gI+btiWe7UQJpjnkfMnbMs+9YfCynM01O2UoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ewpgLj6U; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752206595;
	bh=4qEtXxND/0mv7+V/Njnespdq4rfFmAzmO4I3Wj6cjSo=;
	h=From:Subject:Date:Message-ID;
	b=ewpgLj6Ujr9XI4z2z8kmYuaGE5V5x9QLhR1OxZRln7/1it/DIs+OXJ1oKc297W3bP
	 dF++lEgElLBIyBapUOfiEmU91CrX59zixFP2vTjTWP1DN3MOgEaX/SzWlelvKDgi9r
	 DZwjZliBPvaIZTKL5N5rO0hrRRAt0kwRCS4kPX/Q=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68708CFF00002901; Fri, 11 Jul 2025 12:03:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8137956685235
X-SMAIL-UIID: 21823BB94C8A4D529DD1E5B5F879188F-20250711-120312-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
Date: Fri, 11 Jul 2025 12:03:01 +0800
Message-ID: <20250711040302.3352-1-hdanton@sina.com>
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

