Return-Path: <linux-kernel+bounces-786153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A1B355B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64657A71B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A821F4168;
	Tue, 26 Aug 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="fEX+twPH"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6759460
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193529; cv=none; b=Y9jieb+hOLLqSDHMGQ5615de4wKuDXXkq3tweFPA5YtmYEog+cTDUMyAozt1liWOA9n7W4FQZOA21bnTJBZzg+Jl7MwPLO9aK7RtFuCClsARH4seth1B+3K2UUtYYOK5KF5nVPOVCGTMgOjH3gioAhOkNnwxb/RLmQH0rMF2h5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193529; c=relaxed/simple;
	bh=MhYvDM59kVtwBcKyly+o1hWGzVvcOwVourwoGiwe4+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFAceVlSLQtWvcwMDQl3ddGgUj84qUYE0QkZnjPWCtEcqcENRTObEB8LAexk3jb48pPnqRAJOUx3M11c4tz/8B/DBerz6l8Bg/EW/MTiSZfUJPdvm6mbW1cED21FxmVzfa++kNJveeyVpBuvYsbhdU2iJx7xvRTL8t5V1+/5Gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=fEX+twPH; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756193523;
	bh=DVNNUJi/bngRL8Ee9uGfpw3GPY0lyCC5ZlN38bY3/Qw=;
	h=From:Subject:Date:Message-ID;
	b=fEX+twPHULegua3sBh352CSoqA9G4Di9fSu95Xh6KNa0hi2qKleMQvQQvfgUuRT/B
	 OWQK5c0ooQXqVtAociS7nVjFJ7bmuMjB6KcVxgUFUiHz56bZ14sqPYi8OIj0Uu2v+6
	 KpttCTgW91nbqiRlDh9a93m1a/hYy6NvSHaJaIsc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68AD62EE00005499; Tue, 26 Aug 2025 15:32:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6101416291986
X-SMAIL-UIID: 5B23880CDFD7400B8BA19EA4864FECC9-20250826-153200-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Tue, 26 Aug 2025 15:31:47 +0800
Message-ID: <20250826073149.5659-1-hdanton@sina.com>
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
 
--

