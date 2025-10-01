Return-Path: <linux-kernel+bounces-838519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA37BAF5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5795A3B1974
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFDE1F0E32;
	Wed,  1 Oct 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WDkaFP96"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9783770B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303237; cv=none; b=aLdmAPf9PrKFWtTMzb4+7JfCUTGBl/ithtCEAPjwif6fANZTTb4y6Hjtvr8Zab7sElHIVCC9FSQ/3PYhHlNbHOi/HNoTU7FMjCTyNO8t6RxRU0edukGk6m/GVtUVbGXBlUzogI4tBmVjJUR1AKASnuQn3CviKe/wvskTGtJN3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303237; c=relaxed/simple;
	bh=GGaGyEQVZnmWuUvgUbii8TiIZIFZx74E1l1xBnLN4qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX9yUV3tsBF+vP6sV3eqeEVZDzzfF5zUifcL6oRVNO3IjN6EmCOOxKT/GqahAP8+tFFsfPQs4e0Cxhj+y1GRG1coozvXnmKk902F2t9bOYhLYhPmVK2zttnB76hn2nsjAfLoUZap42T0VkTMIwBIV2xGujcc6Yjg2RmjGzsUqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WDkaFP96; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759303232;
	bh=k8MghiB8yRP6MpFBY5WeMtnLtbGm0C/Pb70Rx2gihz8=;
	h=From:Subject:Date:Message-ID;
	b=WDkaFP96Wwvn2q/axH0BEeDvLqzUroRlRlIHHJXzSQx/kK3X1id8mHLGX1q58ypQl
	 6deIN00jp1B5VmnhK7uhSJHXgRJOXgkOerUNhE7c9GaxOU4/be9iFdH/bShgQBGBXw
	 UhuF50YCspuzZVL8BzQqz0g+rqyw12mQTHEgUTnY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68DCD63900005E6A; Wed, 1 Oct 2025 15:20:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2432766816205
X-SMAIL-UIID: 2C8EC1E767034964B8C0B7ED2896E0B2-20251001-152028-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
Date: Wed,  1 Oct 2025 15:20:15 +0800
Message-ID: <20251001072016.7814-1-hdanton@sina.com>
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
--

