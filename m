Return-Path: <linux-kernel+bounces-788079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B292B37F82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD79F1897347
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A03090F4;
	Wed, 27 Aug 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="a+OEcKte"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725528312E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289333; cv=none; b=WBJC4aTQEOPXerCAi8cE3JSBr3Nh+Q9ErIAPMV5E6xj7iJEMG1jI/SctfGm8XAIV8X4OHKLW9dfptkEcpXu3OpcRnPGH+XX1zC/a+zp85ye9MOz0jVMvLX84Bc26wRqYTqrRRhTD0lDhySUSxcTUBtMhGnXy/jo7GJgnGSL3TjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289333; c=relaxed/simple;
	bh=5j+zv/LW29Fwq0Et5XGu7e4Lv33X89RXoND/awpP0DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui1F5/E+DI4Vk/S4Qjq9HZQJfsaVV0GBW1tBmBlRJGtSZuRpP5xuyX98KsrHtvwKOoLuq93dYqYc96H1yCjqppgCuHjT4fygG+VJ0y+wrrahp2HBbCgo4MTvIWkgSfUymSxqh0/2O+pSM2sxLualihv08zp7xTzxy7ghxDtphMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=a+OEcKte; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756289326;
	bh=6eLyljDPHXcoUhbmlspSlqR/53Enef0kRgnhwegeozM=;
	h=From:Subject:Date:Message-ID;
	b=a+OEcKte+SNUR/qwaeuuBktPhrdolviF835wuhlO+i4ezgrIsRo7rWvnF0B5c11NU
	 K5tPMejRpeflgLyJfekdR1b4LuHu+iorAUbjApglW7c/+ViIkzwLaaZe6ZMsvz0Tci
	 hIXqJHU2dD7I/8dPhuE6lozpzMv2Ba/kOqo7ZgaM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68AED90600002823; Wed, 27 Aug 2025 18:08:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3905734457092
X-SMAIL-UIID: 88015A7633A4428FAC62E7093CE52033-20250827-180808-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 18:07:55 +0800
Message-ID: <20250827100757.5864-1-hdanton@sina.com>
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
@@ -833,14 +840,7 @@ int __xfrm_state_delete(struct xfrm_stat
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
 		xfrm_dev_state_delete(x);
-
 		xfrm_state_delete_tunnel(x);
-
-		/* All xfrm_state objects are created by xfrm_state_alloc.
-		 * The xfrm_state_alloc call gives a reference, and that
-		 * is what we are dropping here.
-		 */
-		xfrm_state_put(x);
 		err = 0;
 	}
 
@@ -929,22 +929,29 @@ int xfrm_state_flush(struct net *net, u8
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
+		bool dead;
 restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			if (!xfrm_state_kern(x) &&
 			    xfrm_id_proto_match(x->id.proto, proto)) {
-				xfrm_state_hold(x);
+				dead = x->km.state == XFRM_STATE_DEAD;
+				x->km.state = XFRM_STATE_DEAD;
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
-				err = xfrm_state_delete(x);
+				if (dead) {
+			flush:
+					schedule_work(&xfrm_state_gc_work);
+					flush_work(&xfrm_state_gc_work);
+					spin_lock_bh(&net->xfrm.xfrm_state_lock);
+					goto restart;
+				}
+				err = 0;
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);
 				if (!err)
 					cnt++;
-
-				spin_lock_bh(&net->xfrm.xfrm_state_lock);
-				goto restart;
+				goto flush;
 			}
 		}
 	}
@@ -1863,6 +1870,7 @@ static struct xfrm_state *__find_acq_cor
 		x->mark.m = m->m;
 		x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
 		xfrm_state_hold(x);
+		xfrm_state_hold(x);
 		hrtimer_start(&x->mtimer,
 			      ktime_set(net->xfrm.sysctl_acq_expires, 0),
 			      HRTIMER_MODE_REL_SOFT);
--

