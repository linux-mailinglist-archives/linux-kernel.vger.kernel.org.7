Return-Path: <linux-kernel+bounces-827958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0CB93866
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99FC2A5EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AE22F0C6C;
	Mon, 22 Sep 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="UHSyUcIq"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A81246764
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581977; cv=none; b=d2aKhIe5gcWOJRwNEkHTRJL6ncf6OV5vEiEg+WgJBvhBYZoA+mPpbzdK1b8mhhshL/BnkycT4QBu/ySSoz8EHAlA/jrlfkSNud5i792A/2tVM6gZI5oYpSVYtkc/N0vKIRA5tMGMYCxNIF1XJMDrlf5DqYJ8Fkj5BMsJ+ZpN784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581977; c=relaxed/simple;
	bh=6JIKavNMsCVzCbTgEM7D4yYHPb5qWgUy33rt1dH4N7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw2gCNKvu2ZoBRWpMkbiz+td/QyDIbXp2P3TR4+A1omUM22fGn1IzuNDhBKQ7qLIg/CzBw2p9EE7RTLv0UvGdagnr9V5YiQdJab8Xw2HmMHm87xphxeMN+aMCwA6dYZ4CGaqhBg1XZH3xXeNhiBx+C8nSTdbSrD5bP36EffMWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=UHSyUcIq; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758581972;
	bh=63V+dCJdxqQLzgPfVm6yIkiMqBaRWnBqIIYzurwPefA=;
	h=From:Subject:Date:Message-ID;
	b=UHSyUcIqcXp2IPn0XR/k3rFV6dAtI9nG5BjmfJ2dszBNrhDhMG5yE6YYkwmQHgTLX
	 EI2dRKwQ8K+8aqOgtEJu0O3DfhvK2MOiixj6AH559DiN8+B/D+nuXdQHG/x2JMTDye
	 BJlZlHlipGuepVoUvXhiIklgnSp8Oc8DMLGZovss=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68D1D4A400001201; Mon, 23 Sep 2025 06:58:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5073724456663
X-SMAIL-UIID: 5494ED2ADE3642D8AEDA5531F6C1A036-20250923-065846-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
Date: Tue, 23 Sep 2025 06:58:33 +0800
Message-ID: <20250922225834.7386-1-hdanton@sina.com>
In-Reply-To: <68d1b079.a70a0220.1b52b.0000.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 22 Sep 2025 13:24:25 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c238e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
> dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e427c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb8142580000

#syz test linux-next  master

--- x/block/blk-mq-tag.c
+++ y/block/blk-mq-tag.c
@@ -565,6 +565,7 @@ struct blk_mq_tags *blk_mq_init_tags(uns
 	if (!tags)
 		return NULL;
 
+	INIT_LIST_HEAD(&tags->page_list);
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
--

