Return-Path: <linux-kernel+bounces-749083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3892B149DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619EF188C22B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A35275AE2;
	Tue, 29 Jul 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Zs5d4WG/"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883027587C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776830; cv=none; b=b5j+AZy/jl06xsKuLU1jACJMCCjWcR+WAQgZS5QetTVLydEYpKnBfaE7p4HOHMbYRQ2g5N7xpi9UMUvv29dxKTyYrkOM70uDLO1DKGz4BrSoX/p576v3hSqffWvkmZFHvVFXJWGukdwe8VKC+j6wSwiNFP9vj0oAGHE0yEHOQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776830; c=relaxed/simple;
	bh=bTVis9kXI9NJ5AMMPQl/m/DgBVEW4i+Dn9IbG5ShGhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svZ7OPBjg6wrToJIDjLN4XgZpG/gXD1k9Qs3hjDk9p8wrG+XyaxQlK/PuQRGX2d9yKwJcNB8uImBUBXmeYVImGzgwPeXANuLam6pfzzhRxxyiQF7w+IpffA67hP/HYm1vAmqu027M3ygX2ZRVOxaCeSRfSDVU0n2lUVVS+Ik2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Zs5d4WG/; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753776826;
	bh=SWvW986VIfCgOeED+XUhYOqhmJAH1RayIrmKf7opFuE=;
	h=From:Subject:Date:Message-ID;
	b=Zs5d4WG/JtxDtkfWU39QtPhXZgsx+c5VnblyJA3iyOEv1K7LhJBprXoBQNcJQKumI
	 utrHPvJd64XuxzZWXFj/yGsAGZgcNv0aZERqIX9rA7IPKeSbfx10pYdyIetvkZbTs4
	 bt7idGP5ciagqHktqKAaqFONPU/VVjU7uMRFovnc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 6888822500004B64; Tue, 29 Jul 2025 16:11:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3795496685557
X-SMAIL-UIID: 50290A6A4FB8409E8B6A8661B93DCF47-20250729-161119-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
Date: Tue, 29 Jul 2025 16:11:08 +0800
Message-ID: <20250729081109.3381-1-hdanton@sina.com>
In-Reply-To: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 29 Jul 2025 00:08:31 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    038d61fd6422 Linux 6.16
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b88cf0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4066f1c76cfbc4fe
> dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ca1782580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140194a2580000

#syz test

--- x/net/xfrm/xfrm_state.c
+++ y/net/xfrm/xfrm_state.c
@@ -615,6 +615,15 @@ static void xfrm_state_gc_destroy(struct
 		put_page(x->xfrag.page);
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
+	spin_lock_bh(&x->lock);
+	do {
+		struct net *net = xs_net(x);
+
+		spin_lock(&net->xfrm.xfrm_state_lock);
+		list_del_init(&x->km.all);
+		spin_unlock(&net->xfrm.xfrm_state_lock);
+	} while (0);
+	spin_unlock_bh(&x->lock);
 	xfrm_state_free(x);
 }
 
@@ -816,7 +825,7 @@ int __xfrm_state_delete(struct xfrm_stat
 		x->km.state = XFRM_STATE_DEAD;
 
 		spin_lock(&net->xfrm.xfrm_state_lock);
-		list_del(&x->km.all);
+		list_del_init(&x->km.all);
 		hlist_del_rcu(&x->bydst);
 		hlist_del_rcu(&x->bysrc);
 		if (x->km.seq)
--

