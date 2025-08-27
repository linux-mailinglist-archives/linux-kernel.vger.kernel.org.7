Return-Path: <linux-kernel+bounces-787662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796DB3794F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C15E4E3405
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA22D0C7B;
	Wed, 27 Aug 2025 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="v9bbcb2h"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AA199230
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270324; cv=none; b=IatkZ4GN+50M6JqQpLiNC4Y0iMo3UXTtNYZLU8gTF88a3Ncc8B1UmnmfFuWBYBdzoLklVqBpcL4fqQZT+sOk7OTvXpYGrPA8MOyyrWeppD2YrGWa4x7mAYVAJmlghQVrg0D40/Er2MfPl2aU7Vbt5zz2XH094rcq65a+jwOI+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270324; c=relaxed/simple;
	bh=/qYoDGBtnw4ckGEXt/AK2ZPwmy5CaDeJO5F3AfsoASs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6YPyy2nE7QjbxdO4MnwtvZ3lhgm38Hn2OYcT6wJj4bJiPMb7/7HW8QfFoTjJmSS5hQ5TpYUfU8M4KmKHeSP/yppgj19dEyy3eUn4g7JDoothlbGpgaN29QoRKVZL7iXmRVyQrJ78M4qp+ZRSdUgw8SfNc2oNrxPzeDuNXoq1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=v9bbcb2h; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756270319;
	bh=6q268Qudx0gel35M84h7rX1qgPWchuXyE5T7CruliKg=;
	h=From:Subject:Date:Message-ID;
	b=v9bbcb2h/ShUEicM2KJM/WG8JMGXShvH9ACECiGaq1VC2lHauMFkkOJqTljZPoXc1
	 nFtbX73vSN8W/644XPmaqiFVQk4sLmsKsdEcWZXSbMARPwmn/W2YVPPm4UNCVOslaj
	 eCX2yHtlg9igxQsFvS4T5IC8sPgWNy3PMtAjaNpw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68AE8EE3000068FE; Wed, 27 Aug 2025 12:51:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6810666816254
X-SMAIL-UIID: F1C4C5F7C2A942379DF3965E0F5A8C92-20250827-125148-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 12:51:37 +0800
Message-ID: <20250827045138.5764-1-hdanton@sina.com>
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
@@ -931,15 +938,16 @@ int xfrm_state_flush(struct net *net, u8
 		struct xfrm_state *x;
 restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
-			if (!xfrm_state_kern(x) &&
+			if (!xfrm_state_kern(x) && x->km.state != XFRM_STATE_DEAD &&
 			    xfrm_id_proto_match(x->id.proto, proto)) {
 				xfrm_state_hold(x);
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
-				err = xfrm_state_delete(x);
+				err = 0;
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);
+				xfrm_state_put(x);
 				if (!err)
 					cnt++;
 
--

