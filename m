Return-Path: <linux-kernel+bounces-839656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE64BB2183
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCACB4C2504
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47D12C0279;
	Thu,  2 Oct 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="MSZg9afm"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25232222B4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363202; cv=none; b=iEhbrnHCbUm0gJDdqZBh347KxFjHJQ8d/tWvhP7mzVsh2ZBioILiHTEc/zhOecQq/o+C6JrINPfqJ91H9MTe5Jel6uWZMpMrnv9ZaRF8Y5GZdOXAXeQPWI7DlnBxBlvtrPP43bUqvkOnoj61YwKRUFq+4h5AwNxgsB6aRe18QCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363202; c=relaxed/simple;
	bh=kDVN7NEc77u5p2/8Xciih/KFEsgCBxZeXnJ+93hHjtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZJhmfx6Q2cYpA+aKTeueFcUjjUE/NYqHiBc8+0+XvkzVrGnkRRWAMWaj8gzi7F/obvgMPPFmRbgB8pZF0d9s+2PHmDfr6fdfuRIu0rijFRWjTfAZBsBONhMormT1hISbJ1nEYQGZZm4icduzMIKSjuiWKWP3/EITxkaoRKLRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=MSZg9afm; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759363198;
	bh=/dKUB7WzrzQhodNBQ6CbbEvPwX0m4fmPYYuywnV3MHA=;
	h=From:Subject:Date:Message-ID;
	b=MSZg9afmGXzLcfMspSkbOelbaGfmdOaM/csNHfbbvtvAuecThEY3iDy3TjkIJjsTW
	 ePMAbC70Wtv3vHtHHti4M7tNE+vbUqKNlNatfe5xZI7uOcIIFOUj6kszrYjSS8wBii
	 KiWI0F0JYDF6GdJSx+z1lTccYAeFL8CwehnAKGgU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68DDC056000056D8; Wed, 2 Oct 2025 07:59:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6818906291919
X-SMAIL-UIID: 103C4C24568348F887DB0AD87A76A84C-20251002-075919-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
Date: Thu,  2 Oct 2025 07:58:56 +0800
Message-ID: <20251001235909.7921-1-hdanton@sina.com>
In-Reply-To: <68dc3ade.a70a0220.10c4b.015c.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 30 Sep 2025 13:17:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    449c2b302c8e Merge tag 'vfs-6.18-rc1.async' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b43858580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c9ad04580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160bf27c580000

#syz test

--- l/include/linux/ns_common.h
+++ n/include/linux/ns_common.h
@@ -38,7 +38,7 @@ extern const struct proc_ns_operations t
 extern const struct proc_ns_operations timens_for_children_operations;
 
 struct ns_common {
-	u32 ns_type;
+	u32 ns_type, gi;
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
--- l/kernel/nscommon.c
+++ n/kernel/nscommon.c
@@ -57,6 +57,7 @@ int __ns_common_init(struct ns_common *n
 	ns->ops = ops;
 	ns->ns_id = 0;
 	ns->ns_type = ns_type;
+	ns->gi = 0;
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
 
@@ -66,6 +67,7 @@ int __ns_common_init(struct ns_common *n
 
 	if (inum) {
 		ns->inum = inum;
+		ns->gi++;
 		return 0;
 	}
 	return proc_alloc_inum(&ns->inum);
@@ -73,5 +75,7 @@ int __ns_common_init(struct ns_common *n
 
 void __ns_common_free(struct ns_common *ns)
 {
+	if (ns->gi)
+		return;
 	proc_free_inum(ns->inum);
 }
--- l/fs/namespace.c
+++ n/fs/namespace.c
@@ -3026,7 +3026,7 @@ static struct file *open_detached_copy(s
 	mnt = __do_loopback(path, recursive);
 	if (IS_ERR(mnt)) {
 		namespace_unlock();
-		free_mnt_ns(ns);
+		put_mnt_ns(ns);
 		return ERR_CAST(mnt);
 	}
 
@@ -4165,7 +4165,6 @@ struct mnt_namespace *copy_mnt_ns(u64 fl
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
-		ns_common_free(ns);
 		dec_mnt_namespaces(new_ns->ucounts);
 		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
--

