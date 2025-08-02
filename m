Return-Path: <linux-kernel+bounces-754239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161FBB1907A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E2176897
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394742192F9;
	Sat,  2 Aug 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0UH9qvM/"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC01519B4
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754176210; cv=none; b=AB64bPn8Dn/sp4utZFhYdGRxJ0l6rLIiT53SoAZX0ulQEiGFQtBBm07GKVItPK0Dl+ZYQQYuPKOM6tTWO5RAPInF/vfAEsHUD1qVXGM1ran/O8UABuK2OR+ULSJJCQepQrBfm0bLr+i5CWFXlU619ROW0Gk1qNNbTi2V3YsI5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754176210; c=relaxed/simple;
	bh=ecv75cz1vvUpvjRO/ENalaa8NUjMlT8WMeXj/uJWeck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwxuLrhToqzRQbp7WPtn9S3iDJW6hGIhRzooNSBY+rCjJVbdso8XTTvCkWlUuiJDyE2yXeqI3Xx908j9nIK/SUo5efqEqkhUBxyVYs3yD0ByKlYBK3PrlCQ9YRf0xS/odep8AJ0XTf744eBThpZg/3SFx4gnfVIPavYe+k5o52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0UH9qvM/; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754176201;
	bh=aK6Co4MMS7+4PiAIzvtkvog2d4GcEH0tdVBjGvUG0Rs=;
	h=From:Subject:Date:Message-ID;
	b=0UH9qvM/Lr30/oart5+Oto4ptcbt4sUaxc7DR4355Irf+yH1ahFR956EdqjOtiI8i
	 rOqvc7q+NOibT596uPTPdl3l/HhXKjsQCpEY+R7Zx+kuVR0VzlDdfsMHskPS/pBvGf
	 eMijUg95PydReGfXPAGMgstIbXIlwjvIirrMYuJ8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 688E9ABE00004CC5; Sat, 3 Aug 2025 07:09:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9403936685163
X-SMAIL-UIID: 3ABA3BC4265A4D1D9197D97D80F9FFC1-20250803-070951-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
Date: Sun,  3 Aug 2025 07:09:39 +0800
Message-ID: <20250802230940.3712-1-hdanton@sina.com>
In-Reply-To: <684c8a60.050a0220.be214.02a6.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 1 Jun 2025 13:30:24 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    27605c8c0f69 Merge tag 'net-6.16-rc2' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bb9d70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e5a54165d499a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a7b9d4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1421310c580000

#syz test upstream master

--- x/drivers/net/bonding/bond_main.c
+++ y/drivers/net/bonding/bond_main.c
@@ -2968,7 +2968,6 @@ static void bond_mii_monitor(struct work
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers = false;
 	bool commit;
 	unsigned long delay;
 	struct slave *slave;
@@ -2978,46 +2977,29 @@ static void bond_mii_monitor(struct work
 
 	if (!bond_has_slaves(bond))
 		goto re_arm;
+	/* Race avoidance with bond_close cancel of workqueue */
+	if (!rtnl_trylock()) {
+		delay = 1;
+		goto re_arm;
+	}
 
 	rcu_read_lock();
-	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
-	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
-	}
+	if (bond->send_peer_notif)
+		bond->send_peer_notif--;
+	rcu_read_unlock();
 
 	if (commit) {
-		/* Race avoidance with bond_close cancel of workqueue */
-		if (!rtnl_trylock()) {
-			delay = 1;
-			should_notify_peers = false;
-			goto re_arm;
-		}
-
 		bond_for_each_slave(bond, slave, iter) {
 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 		}
 		bond_miimon_commit(bond);
-
-		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
+	rtnl_unlock();
 
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
-
-	if (should_notify_peers) {
-		if (!rtnl_trylock())
-			return;
-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
-		rtnl_unlock();
-	}
 }
 
 static int bond_upper_dev_walk(struct net_device *upper,
--

