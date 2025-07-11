Return-Path: <linux-kernel+bounces-726783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF9B01131
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FD11C810EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57817A2EA;
	Fri, 11 Jul 2025 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="T5kFbgUs"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B98BA33
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200784; cv=none; b=oj7hsACML2hoPxEUmXY9IoMCLvU4DskbBIrD0rkUF3mDQ4bmJ7VDitMH6PUgFQfdtTuEGwJQyxgXEQsvv63B7+6GhIT+Km/8JWqvHM0ousj2x+q9svMGPNVdjerx/cUo1L43mdQBvPdexhVf2QZaws7A0kiSUD2ZnI+lmYJavSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200784; c=relaxed/simple;
	bh=Y47rhL8xyJ9DzXpEfTdYdNIEnnW46db9c2IaK8aLQwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIsF0A+AwiQ/FWIypTFZSSifOXlTkEkX7E9qP6wh3+9vvf8qeNWiR6vKhlW6ua6r1iR8AyUX8C38MIxtBCWVYRgPNfETJtJutVn6PEG3esoAVdzSQUBcmHcWmWNDFVGEnYPHMeihXAHdunuMF66xBmpZuUydasF2nteIPDg11Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=T5kFbgUs; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752200779;
	bh=vQIoLh+80jQJwPEenqKBAd+xMaJswXv6iYeJ9wnQs6Y=;
	h=From:Subject:Date:Message-ID;
	b=T5kFbgUsfyuGPEoCLY9Tx98xLycvc5VpGnuUAIJJD5mi78YBExYL0Up10R5zF8fbb
	 4xOKSR0fleawMtiQtLEp38vPQO0RrwArFjeQGuefRUNvetS4XBg6pJWpUoWnsvGTYA
	 nJYsDpJrSQ+vlOf1xbbX1d3siZzjLLStjBgM7sSI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6870763F000063EF; Fri, 11 Jul 2025 10:26:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2982066291949
X-SMAIL-UIID: 061A13F0293D4579902304146A7D1837-20250711-102609-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
Date: Fri, 11 Jul 2025 10:25:57 +0800
Message-ID: <20250711022558.3290-1-hdanton@sina.com>
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
@@ -586,6 +586,7 @@ no_vma:
 	return ERR_PTR(-ENOENT);
 }
 
+static DEFINE_MUTEX(query_mutex);
 static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 {
 	struct procmap_query karg;
@@ -630,6 +631,7 @@ static int do_procmap_query(struct proc_
 		return -ENOMEM;
 	}
 
+	mutex_lock(&query_mutex);
 	err = query_vma_setup(priv);
 	if (err)
 		goto fail_vma_setup;
@@ -712,6 +714,7 @@ static int do_procmap_query(struct proc_
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
 	query_vma_teardown(priv);
+	mutex_unlock(&query_mutex);
 	mmput(mm);
 
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
@@ -733,6 +736,7 @@ static int do_procmap_query(struct proc_
 out:
 	query_vma_teardown(priv);
 fail_vma_setup:
+	mutex_unlock(&query_mutex);
 	mmput(mm);
 	kfree(name_buf);
 	return err;
--

