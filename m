Return-Path: <linux-kernel+bounces-730991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B84B04D43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6511A67CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2724A1B042E;
	Tue, 15 Jul 2025 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ESt1EEuu"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FA2AF1D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542334; cv=none; b=qB+9BYugn734UGBr5KQxrSNlHA2RzLsY3sKWKwr/tBjYo7xHlBzB9O4+0dkGYwS4jv4hk9AOE/vkj3KaBzakNADO1kDXkLWifCtayie+NjDPK+egPSRT1DL7bluFgwuCnxRN7Y/UpcqUJt9TOQm5RTT+Q3NcSI0pYrp+gllZHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542334; c=relaxed/simple;
	bh=aMjIxYoT7xO+9/F+IlZXzDk2GENDJW+CLd2et7YyNOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAfjhCvJcnJS6bLb/jbNVppkKXX1y8XzikqD6XhulJR62+nPu5cCBd/4WL0Ru8229BENeNXUGEIGXys7kfDDKjTYEFb867/DaYrRbVPEifcDgKj1dYBiP87KYfa3dcSHSclIvPRXT4/hnRWNglOeZ3h3HVG2VkYRgUAweexMEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ESt1EEuu; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752542325;
	bh=x314NQqJMFduOHJcDHDV5bVdMyAfeSKTHSqoZYHPGj8=;
	h=From:Subject:Date:Message-ID;
	b=ESt1EEuuEYptgg4a+Iz3i4jScpGcqHJaQJuEPHiTUoGKAMw2WtPX0Naop02BzBH1h
	 VFVqH9NwCY7tY/rK8lkeZdkwIg2PdY0QW4YCijFGo8+CVSgQgkmXdO/FstpGyGd6o6
	 f92fuWo4AtmbPGWX1tEh6HT3BAmJDlmxnzwr9DtE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6875AC6B00001C1D; Tue, 15 Jul 2025 09:18:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8973704457243
X-SMAIL-UIID: AAE4C46FE94A43CB9875072F20BBE61B-20250715-091836-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ffe421482ad9d307c03f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in mas_start
Date: Tue, 15 Jul 2025 09:18:25 +0800
Message-ID: <20250715011826.4093-1-hdanton@sina.com>
In-Reply-To: <687539cb.a70a0220.18f9d4.0004.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 14 Jul 2025 10:09:31 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a62b7a37e6fc Add linux-next specific files for 20250711
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d45d82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb4e3ec360fcbd0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=ffe421482ad9d307c03f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1177018c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1577018c580000

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

