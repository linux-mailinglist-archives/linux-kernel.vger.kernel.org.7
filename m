Return-Path: <linux-kernel+bounces-787430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07889B37629
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD246360EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93619CC0A;
	Wed, 27 Aug 2025 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JktGW+kl"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449FF9D6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255256; cv=none; b=CBr6VUQSNhkQQq0B7DnW8mTKQ0jBW+nszCcrXFu2voiMQhiupeQhWTl8ZuLD7m5U30BZ5j4kOc423RYWB363QGvWC3RcavYLp7ULwuaiDtp2uv4Z5hxvpz2l/uNRNb5By3JekMxBrbsn+Nc5Qp5d40VUl8rV48vF5CeI4t3Lc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255256; c=relaxed/simple;
	bh=ZIP8hF44M6IJGIjSSyGjYXXnwuLdQmO35En6HJGa/XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhRqN/Xg6rS2TIhI1bAKThWZ/BSNhEtu9USRWBVEXFC36ZQaF8T+OBkMmmRJ0QTWqwa3yGMyP0K6C/4xju0rinBVkkeoBxaV84sxDpJ1hplrgRrN6ueWX//gGCEDp0FBiZ5atlHi9q0ckDd0SjLJ9Tu/HgcjvNhaeZlCjO1Wlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JktGW+kl; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756255251;
	bh=Gl6tAbUq+DzbydUTHpVw8ebckTFWUFP6T43SjEnyiKU=;
	h=From:Subject:Date:Message-ID;
	b=JktGW+klaIKEaACDrVfNASGPTCtgEBgfG4HzpKDOslAhCWHTGVWGzubfgdgvi2rog
	 /Vp4CeLpAJuP11yPROWSm7HuVSUkux8j+OZBuY7Gc3BxAUOQuRZgfXqVyZbfbtN4ix
	 FccT9H9f67o75YmecMddTH44CmYnDQxyMNrC7WmA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68AE540E00007EC1; Wed, 27 Aug 2025 08:40:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6469054456922
X-SMAIL-UIID: 754A451A8BA24684912915226A503815-20250827-084048-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 08:40:36 +0800
Message-ID: <20250827004037.5728-1-hdanton@sina.com>
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

--- x/include/net/xfrm.h
+++ y/include/net/xfrm.h
@@ -202,6 +202,7 @@ struct xfrm_state {
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
+	int deleted;
 
 	u32			pcpu_num;
 	struct xfrm_id		id;
--- x/net/xfrm/xfrm_state.c
+++ y/net/xfrm/xfrm_state.c
@@ -615,6 +615,7 @@ static void xfrm_state_gc_destroy(struct
 		put_page(x->xfrag.page);
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
+	xfrm_state_delete(x);
 	xfrm_state_free(x);
 }
 
@@ -812,10 +813,16 @@ int __xfrm_state_delete(struct xfrm_stat
 	struct net *net = xs_net(x);
 	int err = -ESRCH;
 
-	if (x->km.state != XFRM_STATE_DEAD) {
-		x->km.state = XFRM_STATE_DEAD;
+	for (;;) {
+		if (x->km.state != XFRM_STATE_DEAD)
+			x->km.state = XFRM_STATE_DEAD;
 
 		spin_lock(&net->xfrm.xfrm_state_lock);
+		if (x->deleted) {
+			spin_unlock(&net->xfrm.xfrm_state_lock);
+			return 0;
+		}
+		x->deleted++;
 		list_del(&x->km.all);
 		hlist_del_rcu(&x->bydst);
 		hlist_del_rcu(&x->bysrc);
--

