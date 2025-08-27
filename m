Return-Path: <linux-kernel+bounces-787949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B21B37DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65A41BA3F34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060F33EB0E;
	Wed, 27 Aug 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Bpqpc9Ef"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A132144A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284023; cv=none; b=QIntVxYlLRYX2gOt2do/lok/75nsWBGlQRRy831ZsG9oq1sA8ilpN2xeyZQzyxlRsqcIFxLJF8Eu1k6YTCo82+VmDwvg99nkj8bJJge4GxX1VqyokCw4EqhwctyF56PKBtTCcSo9UR8rx0esnGe6T2+3ocv7grQI/ohpc4xWN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284023; c=relaxed/simple;
	bh=58NRymQVg7NsIQsRZ2aLUfXeoxNg8hH1OoHwfDlL6gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSPvFhLP0RNdWkCtff8LzkjdxZ4/XoE5pzKKr6NcOAxrQubOTkVjImfQYLvBDNCt/vTO/AB3kPfxmqQzFu1xDYjSPOl+C6M/tSg8gIyKKfu3D86XIk78wyydSEPH3HtKkbi5RBHrSI1RcBvZmPlAtraEMCqVVKTMH5FETtVbeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Bpqpc9Ef; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756284018;
	bh=eVySssy1AFb+VmYC6wb2P1MAC3Rg/6eCSDrgrn/+5q4=;
	h=From:Subject:Date:Message-ID;
	b=Bpqpc9EfFf3/YMk5/XYvCfzN0VuKYKwsKlI7wKAqhCDAU2O86BEk+3sawccoHlhx5
	 WZJFMrpEpJ/gi+LIJyflV5Wx7X/4VMxFo+M9gk4gO48zsMPKwW1wgvTwnSZVmDiiWY
	 rFEfvmQQvdYD6ynLF1PWdgZK/hGDPbzNL9OSDXMA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68AEC4440000723C; Wed, 27 Aug 2025 16:39:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3154034456979
X-SMAIL-UIID: 997BBF7603684137B46250A64C15AF71-20250827-163934-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 16:39:21 +0800
Message-ID: <20250827083923.5840-1-hdanton@sina.com>
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
--

