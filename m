Return-Path: <linux-kernel+bounces-755840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C2B1AC69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3003A8E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE341A23A9;
	Tue,  5 Aug 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="htZkPieC"
Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E2179BD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754360932; cv=none; b=IReGloFd8wqUtLHd9t/Q/iPezlRcD9QNU+3wXUIOjpVKADky4/YvWf2RwMW7ceCqeMi/iKYxe8ycO73XDqZlQdT3OpvIlxyOTGbGPAVczXTIxPai3wRF6nyyIS3lVVNjc1nZsOYcLuW7nmhox7zQOERYBzfUeMbq67ME6P8w89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754360932; c=relaxed/simple;
	bh=sT8772EE7hv0HYnPqlBuhg4oI96t7ktCGAsGhlXbRAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIvxabMUi6DQPTnVijgNNlHo31FSAXKKlFNcIHi028zIGlvh6bJSCMvZ4jMm61zeueuaeiHgOffbllAkuqyNbauSgpmOaRN4e6K0oXiQZzk7mCwtXLj7HkmgA9Ca+FZCpu04s2SQniQv82C+8BWOXK5yuJ7MECi6GOXhVKyVKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=htZkPieC; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754360923;
	bh=9q4FNEh98n8QGO3XD+Gs9WYlWB8rKX/mHEa4vJlnv58=;
	h=From:Subject:Date:Message-ID;
	b=htZkPieCZyrE6iB/SNwOuUCZXwzUIkxV3ourIkqzpxmE7GZ4oTmXpjKCV/taxZEqx
	 JOVvWev1cZkMybjurotAxO8zBmYcL4rZJRWixvzQgkb+1JvX8kbLkxhaMLn5JuToOw
	 174ouomgg+ZABy0695ILEERPE5+Ccl3UzwL/pmT8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68916C3200005072; Tue, 5 Aug 2025 10:28:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1119176685383
X-SMAIL-UIID: 3ADC1206759D4182BDB67B0028505019-20250805-102805-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
Date: Tue,  5 Aug 2025 10:27:52 +0800
Message-ID: <20250805022753.3917-1-hdanton@sina.com>
In-Reply-To: <6890f71a.050a0220.7f033.0010.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 04 Aug 2025 11:08:26 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    759dfc7d04ba netlink: avoid infinite retry looping in netl..
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11332f82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0888b9ad46cd69
> dashboard link: https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1136d9bc580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536d9bc580000

#syz test upstream master

--- x/fs/kernfs/mount.c
+++ y/fs/kernfs/mount.c
@@ -303,9 +303,7 @@ static int kernfs_fill_super(struct supe
 	sb->s_shrink->seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
--

