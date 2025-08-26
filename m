Return-Path: <linux-kernel+bounces-785940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A7B352B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6B8173514
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77672D6401;
	Tue, 26 Aug 2025 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ljScmyOW"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6F2D663F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756181840; cv=none; b=JQ83PN6ktfmc3T4krvrcSEq8A49Aw3tBaC21EfH4U9zEX7uincPlr5TzkNAJY9MUI6jqIM4/H4xas8W63xoZRVaOhy55BN8GmAg+JfW5NWJyQvw/s7EwJ146g8U8h0z1/wouwlaKnUKz9FsYWgyFwnsjjYlfpGUUhHZwdx/jYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756181840; c=relaxed/simple;
	bh=tLRs7cyM4zOL8Iw9xxqOATKXUGiKj+/sNuj1KqZJxk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmzmFTM6Puew++Ma2rMgLawZZE1R5Fk9KaYa2xi2yAzytXJP53iCdxGVoI7KCAL6Njr8iAzhS9NmGJrLXqEIq6KEW9N5vcOIN6Drndiu+Qxz/y2M80dBImvP1eDQyUKHBuMbLO9r7E/yi/49XIfw1EfAVXXvgYyRmgSzIRjB7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ljScmyOW; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756181835;
	bh=KguVyi6io1xREaWG1OM4ABL8lJlBLqOiLBBo1JR22UU=;
	h=From:Subject:Date:Message-ID;
	b=ljScmyOWMn/eOwTT64hel5JaOEWnzcr1I2tRxuxBO2uzJx5mCdqW9vWZ6MQRloQqc
	 72zhaGzbnrNWWDsLjKHok50Zz5tyHLv9aLG8TLPR+r6FPAKj+PF/w116V836xjYJ3B
	 ie9SrLWWg7PJ9WfK3T1yoRcR1898yK2i59JTiwrY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68AD3541000005DA; Tue, 26 Aug 2025 12:17:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8502844456963
X-SMAIL-UIID: 69A7D3480C994A7B898C9939D0E62007-20250826-121706-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Tue, 26 Aug 2025 12:16:54 +0800
Message-ID: <20250826041656.5633-1-hdanton@sina.com>
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
@@ -798,6 +798,7 @@ void xfrm_dev_state_free(struct xfrm_sta
 void __xfrm_state_destroy(struct xfrm_state *x)
 {
 	WARN_ON(x->km.state != XFRM_STATE_DEAD);
+	WARN_ON(!hlist_unhashed(&x->bydst));
 
 	spin_lock_bh(&xfrm_state_gc_lock);
 	hlist_add_head(&x->gclist, &xfrm_state_gc_list);
@@ -934,14 +935,15 @@ restart:
 			if (!xfrm_state_kern(x) &&
 			    xfrm_id_proto_match(x->id.proto, proto)) {
 				xfrm_state_hold(x);
+				if (x->km.state == XFRM_STATE_DEAD)
+					x->km.state++;
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 				err = xfrm_state_delete(x);
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);
-				if (!err)
-					cnt++;
+				cnt++;
 
 				spin_lock_bh(&net->xfrm.xfrm_state_lock);
 				goto restart;
--

