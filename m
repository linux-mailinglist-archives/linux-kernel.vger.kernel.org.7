Return-Path: <linux-kernel+bounces-786697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B54DBB36374
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345DC188681C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113BF3469EC;
	Tue, 26 Aug 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WbrARSbo"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5D27EFE7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214555; cv=none; b=KcwihXaQ7MoJq+H5hsYsCHl91+mHEhue7z0UCIV4czP7mbd70mwkHB3REsA9qXm01di41JoTO4g1s/u2/Qa6o1bZ2/lh5PwMck39G0yNmVb+HFwjKk2/qWNnHG+eEoqOC6WEujF2UTSqYjonoxkEu3K9mYRa2eB/K7tFHD50l2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214555; c=relaxed/simple;
	bh=/bUTtuG5ASC7nLis+2EsxDiem6Htm8MIjuzimlc0ApA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1ygvzOJwrAj/JW7xzsS2XoGiUi/Zvkal35lckNOEK9XGoDLDfWgfZJF3vBdjilGQXaHHqG5LgNXXTl6O7qbsH+C2sIHJh8+/4JBueioWcjp3Y4AgtuD7wc0EMs5SbA1SScBNgRU4Z3R9YLV5RqlkgpW7xpeep1zSLOuIB0R9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WbrARSbo; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756214550;
	bh=maQWOxyz2B2L/d7hXPTcaki3eKtd5axsYpqfgZGhZ8E=;
	h=From:Subject:Date:Message-ID;
	b=WbrARSbo8ByXxEXr+sfHeiSCsx0tujftgnqN+unbCZtR1h9PIJQjCg8fJROBd4wTc
	 mWJSqGFPuBrMnnI8RcPRuVjMUAqfVHKqk+e6N4pdOpwI1AE52xcUK1mCSJ0JZkCFA9
	 oZpbY0Iigmks4YXvOrW/fiTvhU/Bx6Mr90NcntnQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68ADB50B00005BD4; Tue, 26 Aug 2025 21:22:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6661386816355
X-SMAIL-UIID: 5E6DD957E5624C1187DE1679E393F3BA-20250826-212221-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Tue, 26 Aug 2025 21:22:09 +0800
Message-ID: <20250826132210.5681-1-hdanton@sina.com>
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
@@ -618,6 +618,8 @@ static void xfrm_state_gc_destroy(struct
 	xfrm_state_free(x);
 }
 
+static DEFINE_MUTEX(notify_mutex);
+
 static void xfrm_state_gc_task(struct work_struct *work)
 {
 	struct xfrm_state *x;
@@ -630,8 +632,10 @@ static void xfrm_state_gc_task(struct wo
 
 	synchronize_rcu();
 
+	mutex_lock(&notify_mutex);
 	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
 		xfrm_state_gc_destroy(x);
+	mutex_unlock(&notify_mutex);
 }
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
@@ -921,6 +925,7 @@ int xfrm_state_flush(struct net *net, u8
 {
 	int i, err = 0, cnt = 0;
 
+	mutex_lock(&notify_mutex);
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	err = xfrm_state_flush_secctx_check(net, proto, task_valid);
 	if (err)
@@ -950,6 +955,7 @@ restart:
 	}
 out:
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	mutex_unlock(&notify_mutex);
 	if (cnt)
 		err = 0;
 
@@ -2569,6 +2575,8 @@ int xfrm_alloc_spi(struct xfrm_state *x,
 	u32 range = high - low + 1;
 	__be32 newspi = 0;
 
+	if (!mutex_trylock(&notify_mutex))
+		return err;
 	spin_lock_bh(&x->lock);
 	if (x->km.state == XFRM_STATE_DEAD) {
 		NL_SET_ERR_MSG(extack, "Target ACQUIRE is in DEAD state");
@@ -2612,6 +2620,7 @@ int xfrm_alloc_spi(struct xfrm_state *x,
 
 unlock:
 	spin_unlock_bh(&x->lock);
+	mutex_unlock(&notify_mutex);
 
 	return err;
 }
--

