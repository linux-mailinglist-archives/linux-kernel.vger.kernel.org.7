Return-Path: <linux-kernel+bounces-784697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106CCB33FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C0316FDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F925A340;
	Mon, 25 Aug 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JyX6TjbP"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F74625
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125905; cv=none; b=MbjcAd9LZ++5Q279Vk+25+ZNKB7LFNkgFcJFfVZQFYWmwiRJSWvKOHv8tbMhUQpz6HUpy32FKUS5kyBvtfiOzFiQezAnjAA+QjjSXGL2z+Y/LqSyCpbirna4xR9CQUtRDY7wIrUSG1W01q3bWgmRQGidHcMdSyMCiDvi+rDUZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125905; c=relaxed/simple;
	bh=/JbjbrhVDVkUyw1YvInRbr6tGZdpT+oUI3QZ7pWUu/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNczv5++y8zwDmOP8AraIr4llikikmz7aeVYcjW+eDpeAOzzFk4eSJNiRpea10i6hCjQng97YjmF1QHMMbUT6Tw1PA2OIU7RG+qJF1LR5lVuG0MuO/SyGZnhtsYKPLHsxaPBAGoYwKdTGaP1kPxjTI6if6oxIwohmCXCyBRz020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JyX6TjbP; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756125900;
	bh=3sZPd77q5KVVinFJmwZ+jxwQSxIoFVivZawfo2e4vng=;
	h=From:Subject:Date:Message-ID;
	b=JyX6TjbPDcifpYGfs641FFhyDiTwOkIecvchYger7iinraEDGvVnV8ajzJbO2Ieut
	 Oa6f45OgwGGRT/5QyJ8IgqKXKBrnhfjzr/5xZ/zBmq0CBk6/xgn6M78BtMnGEKwzah
	 lwKONBHiTz0CqjH5PZmTPtVzD8MZboczVjCBgiBQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68AC5AC0000075E5; Mon, 25 Aug 2025 20:44:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7647576816250
X-SMAIL-UIID: 7327EC2BC30A4B91906D41C871624B80-20250825-204450-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Mon, 25 Aug 2025 20:44:37 +0800
Message-ID: <20250825124438.5472-1-hdanton@sina.com>
In-Reply-To: <68ab6633.050a0220.37038e.0079.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sun, 24 Aug 2025 12:21:23 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b1c92cdf5af3 Merge branch 'net-wangxun-complete-ethtool-co..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1411b062580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
> dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14221862580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159fba34580000

#syz test

--- x/net/xfrm/xfrm_state.c
+++ y/net/xfrm/xfrm_state.c
@@ -615,6 +615,8 @@ static void xfrm_state_gc_destroy(struct
 		put_page(x->xfrag.page);
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
+	x->km.state++;
+	xfrm_state_delete(x);
 	xfrm_state_free(x);
 }
 
@@ -816,7 +818,11 @@ int __xfrm_state_delete(struct xfrm_stat
 		x->km.state = XFRM_STATE_DEAD;
 
 		spin_lock(&net->xfrm.xfrm_state_lock);
-		list_del(&x->km.all);
+		if (list_empty(&x->km.all)) {
+			spin_unlock(&net->xfrm.xfrm_state_lock);
+			return 0;
+		}
+		list_del_init(&x->km.all);
 		hlist_del_rcu(&x->bydst);
 		hlist_del_rcu(&x->bysrc);
 		if (x->km.seq)
--

