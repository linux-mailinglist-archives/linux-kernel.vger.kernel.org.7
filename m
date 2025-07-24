Return-Path: <linux-kernel+bounces-745068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02046B1146F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029101C88101
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406A23F40D;
	Thu, 24 Jul 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="VPyiieR2"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049B222564
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399376; cv=none; b=rlOMALCeGwJLv7uLIiI6boJgSdDJnuOynLF5nJu1MQnJrwMmeIQKFvPHn2TGym4Poh9YdY21Qh8GyuvHIMv5b3ZwEfmwOltzUvok8BqrwMcFKWH5MbuKl8umYPRglBim8gORMX3kELimPlY+kt3MpXU6YMu+8nLm0yxl8iYSv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399376; c=relaxed/simple;
	bh=7x5IVRe43wkd/FdVkgLtGDETjMB+Fd65NveZPdn2FiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY2cRjcWj0BWXdsND/vVmNqx4efaF+YiDJo5hTUdlpBZpQ+YRP/5FHJT6j+Y1pM/TL6OtboqGa3HbvNcJQHOn8UMxf2NSipEjMEy3KvnxEcUQZPRBa7OjkTLoFnsW8XhCF1S+FnjnSsANLXdfc4OoqPT6izg1ojEGP0SL5wMIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=VPyiieR2; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753399367;
	bh=F7kUQa8Uzw6/LY3njzYUAxONZo3TFQsqJSDkPEnNeZc=;
	h=From:Subject:Date:Message-ID;
	b=VPyiieR28VohwmRBbKoDou8haXupI70uffXHST3rPzsOfHSinorF3s46MyOP950ew
	 oTUbvtbmaoZTrxUoVEej8taTa9BZZ8So+hnaMAySIw7WpUTAcIl7tReUH8ROswkBoK
	 PfID7ZPww35wPIheEhjw5Orgf5cE+rcAH/fmjslM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6882C03D000027C0; Thu, 25 Jul 2025 07:22:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8919596291936
X-SMAIL-UIID: 1D8E34A3E13F46238A82A37F7B42C323-20250725-072238-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0fc08dad8f34563208d5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_new_lci
Date: Fri, 25 Jul 2025 07:22:09 +0800
Message-ID: <20250724232226.3104-1-hdanton@sina.com>
In-Reply-To: <6881ff19.a00a0220.2f88df.001e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 24 Jul 2025 02:38:33 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d086c886ceb9 Add linux-next specific files for 20250718
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1517af22580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=69896dd7b8c4e81e
> dashboard link: https://syzkaller.appspot.com/bug?extid=0fc08dad8f34563208d5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1317af22580000

#syz test

--- x/include/net/rose.h
+++ y/include/net/rose.h
@@ -98,6 +98,7 @@ struct rose_neigh {
 	unsigned short		count;
 	unsigned short		use;
 	unsigned int		number;
+	atomic_t		ref;
 	char			restarted;
 	char			dce_mode;
 	char			loopback;
@@ -214,6 +215,7 @@ void rose_link_device_down(struct net_de
 struct net_device *rose_dev_first(void);
 struct net_device *rose_dev_get(rose_address *);
 struct rose_route *rose_route_free_lci(unsigned int, struct rose_neigh *);
+void rose_put_neigh(struct rose_neigh *);
 struct rose_neigh *rose_get_neigh(rose_address *, unsigned char *,
 				  unsigned char *, int);
 int rose_rt_ioctl(unsigned int, void __user *);
--- x/net/rose/af_rose.c
+++ y/net/rose/af_rose.c
@@ -171,6 +171,7 @@ void rose_kill_by_neigh(struct rose_neig
 		if (rose->neighbour == neigh) {
 			rose_disconnect(s, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
 			rose->neighbour->use--;
+			rose_put_neigh(rose->neighbour);
 			rose->neighbour = NULL;
 		}
 	}
@@ -383,8 +384,10 @@ void rose_destroy_socket(struct sock *sk
 		timer_setup(&sk->sk_timer, rose_destroy_timer, 0);
 		sk->sk_timer.expires  = jiffies + 10 * HZ;
 		add_timer(&sk->sk_timer);
-	} else
+	} else {
+		rose_put_neigh(rose_sk(sk)->neighbour);
 		sock_put(sk);
+	}
 }
 
 /*
--- x/net/rose/rose_route.c
+++ y/net/rose/rose_route.c
@@ -97,6 +97,7 @@ static int __must_check rose_add_node(st
 		rose_neigh->dce_mode  = 0;
 		rose_neigh->loopback  = 0;
 		rose_neigh->number    = rose_neigh_no++;
+		atomic_set(&rose_neigh->ref, 1);
 		rose_neigh->restarted = 0;
 
 		skb_queue_head_init(&rose_neigh->queue);
@@ -237,7 +238,7 @@ static void rose_remove_neigh(struct ros
 		if (rose_neigh->ax25)
 			ax25_cb_put(rose_neigh->ax25);
 		kfree(rose_neigh->digipeat);
-		kfree(rose_neigh);
+		rose_put_neigh(rose_neigh);
 		return;
 	}
 
@@ -247,7 +248,7 @@ static void rose_remove_neigh(struct ros
 			if (rose_neigh->ax25)
 				ax25_cb_put(rose_neigh->ax25);
 			kfree(rose_neigh->digipeat);
-			kfree(rose_neigh);
+			rose_put_neigh(rose_neigh);
 			return;
 		}
 
@@ -265,8 +266,10 @@ static void rose_remove_route(struct ros
 	if (rose_route->neigh1 != NULL)
 		rose_route->neigh1->use--;
 
-	if (rose_route->neigh2 != NULL)
+	if (rose_route->neigh2 != NULL) {
 		rose_route->neigh2->use--;
+		rose_put_neigh(rose_route->neigh2);
+	}
 
 	if ((s = rose_route_list) == rose_route) {
 		rose_route_list = rose_route->next;
@@ -667,6 +670,11 @@ struct rose_route *rose_route_free_lci(u
 	return NULL;
 }
 
+void rose_put_neigh(struct rose_neigh *n)
+{
+	if (n && atomic_dec_and_test(&n->ref))
+		kfree(n);
+}
 /*
  *	Find a neighbour or a route given a ROSE address.
  */
@@ -712,6 +720,8 @@ struct rose_neigh *rose_get_neigh(rose_a
 	}
 
 out:
+	if (res)
+		atomic_inc(&res->ref);
 	if (!route_frame) spin_unlock_bh(&rose_node_list_lock);
 	return res;
 }
@@ -1061,6 +1071,7 @@ int rose_route_frame(struct sk_buff *skb
 	rose_route->neigh1    = rose_neigh;
 	rose_route->lci2      = new_lci;
 	rose_route->neigh2    = new_neigh;
+	new_neigh = NULL;
 
 	rose_route->neigh1->use++;
 	rose_route->neigh2->use++;
@@ -1076,6 +1087,8 @@ int rose_route_frame(struct sk_buff *skb
 	res = 1;
 
 out:
+	if (new_neigh)
+		rose_put_neigh(new_neigh);
 	spin_unlock_bh(&rose_route_list_lock);
 	spin_unlock_bh(&rose_neigh_list_lock);
 
--- x/net/unix/af_unix.c
+++ y/net/unix/af_unix.c
@@ -1750,12 +1750,6 @@ restart:
 		goto out_unlock;
 	}
 
-	err = security_unix_stream_connect(sk, other, newsk);
-	if (err) {
-		unix_state_unlock(sk);
-		goto out_unlock;
-	}
-
 	/* The way is open! Fastly set all the necessary fields... */
 
 	sock_hold(sk);
@@ -1804,6 +1798,11 @@ restart:
 	smp_mb__after_atomic();	/* sock_hold() does an atomic_inc() */
 	unix_peer(sk)	= newsk;
 
+	err = security_unix_stream_connect(sk, other, newsk);
+	if (err) {
+		unix_state_unlock(sk);
+		goto out_unlock;
+	}
 	unix_state_unlock(sk);
 
 	/* take ten and send info to listening sock */
--

