Return-Path: <linux-kernel+bounces-765092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4EFB22B44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E027416474B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D42ED167;
	Tue, 12 Aug 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="tFFO+7rH"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D85184
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010636; cv=none; b=uoL+WptqW87+ZMYSqz3LlRIcksWAclOUwH+CT5alCK7LhaGNEU3Rk1c/4V9AXVN6bG1m1UB+EPBL/ClvGlBkDupf70KHeVS0gGBB5ZnQy77erYesiZHyMvBxqzs7AHaL4BNeYjzgvK2LMl5xBrWTkhokPPBEEF3KTmckVUQgZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010636; c=relaxed/simple;
	bh=xpU3v7NRK6yEBI/4cSkXapJ9FiycVuvBE6/Z6qs1xeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1IX0Ozrdwlcjo5sLyqbpGBRwcrQ+x+Z9lKJX3jXaS5gRP4xGvZF93OnepWSroHJljrN3BQ9PDsODQdDb1yode7AqkJGlsD/45WO275YTUlzaWDLrfoxqt7P7TemkOCConsaMBz4+KE5brzD2P6lSaVGPDNb/Hce3qV6pNF1ZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=tFFO+7rH; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755010629;
	bh=ljim8K8H9HpOPQA//CjcNWiJEPPngBxmUYz6bMj+1WI=;
	h=From:Subject:Date:Message-ID;
	b=tFFO+7rHyj+lrUrxfOefHknZN+K3PB2l0G3+M6ZvrEMcBbWEaIiteWpWsl3S2r550
	 XfA/dqb1emoWhDMi5aYn9HY4uTqB6eZCPL/MiqqiUwN1ZFFPqhH3x3v7lF9gO/nAC2
	 urK91PoKIsgDaOQFF7XrqIGM6XEKab3oj8zvqHzw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689B563A00000C21; Tue, 12 Aug 2025 22:56:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7941594456628
X-SMAIL-UIID: 2780363561E44E29BDE95771D08913C2-20250812-225659-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
Date: Tue, 12 Aug 2025 22:56:47 +0800
Message-ID: <20250812145648.4310-1-hdanton@sina.com>
In-Reply-To: <689b1044.050a0220.7f033.011b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 12 Aug 2025 02:58:28 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c415a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151be9a2580000

#syz test

--- x/drivers/net/netdevsim/netdev.c
+++ y/drivers/net/netdevsim/netdev.c
@@ -709,10 +709,14 @@ static struct nsim_rq *nsim_queue_alloc(
 
 static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
 {
+	struct netdevsim *ns = netdev_priv(dev);
+
 	hrtimer_cancel(&rq->napi_timer);
-	local_bh_disable();
-	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
-	local_bh_enable();
+	if (ns->registed) {
+		local_bh_disable();
+		dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
+		local_bh_enable();
+	}
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }
@@ -981,6 +985,7 @@ err_free_prev:
 	while (i--)
 		kfree(ns->rq[i]);
 	kfree(ns->rq);
+	ns->rq = NULL;
 	return -ENOMEM;
 }
 
@@ -989,6 +994,8 @@ static void nsim_queue_uninit(struct net
 	struct net_device *dev = ns->netdev;
 	int i;
 
+	if (!ns->rq)
+		return;
 	for (i = 0; i < dev->num_rx_queues; i++)
 		nsim_queue_free(dev, ns->rq[i]);
 
@@ -1001,6 +1008,7 @@ static int nsim_init_netdevsim(struct ne
 	struct mock_phc *phc;
 	int err;
 
+	ns->registed = 0;
 	phc = mock_phc_create(&ns->nsim_bus_dev->dev);
 	if (IS_ERR(phc))
 		return PTR_ERR(phc);
@@ -1038,6 +1046,7 @@ static int nsim_init_netdevsim(struct ne
 							&ns->nn))
 			ns->nb.notifier_call = NULL;
 	}
+	ns->registed = 1;
 
 	return 0;
 
--- x/drivers/net/netdevsim/netdevsim.h
+++ y/drivers/net/netdevsim/netdevsim.h
@@ -106,6 +106,7 @@ struct netdevsim {
 	struct mock_phc *phc;
 	struct nsim_rq **rq;
 
+	int registed;
 	int rq_reset_mode;
 
 	struct nsim_bus_dev *nsim_bus_dev;
--- x/net/ipv4/udp_tunnel_nic.c
+++ y/net/ipv4/udp_tunnel_nic.c
@@ -733,7 +733,8 @@ static void udp_tunnel_nic_device_sync_w
 	struct udp_tunnel_nic *utn =
 		container_of(work, struct udp_tunnel_nic, work);
 
-	rtnl_lock();
+	if (!rtnl_trylock())
+		return;
 	mutex_lock(&utn->lock);
 
 	utn->work_pending = 0;
@@ -782,6 +783,8 @@ static void udp_tunnel_nic_free(struct u
 
 	for (i = 0; i < utn->n_tables; i++)
 		kfree(utn->entries[i]);
+	disable_work(&utn->work);
+	cancel_work_sync(&utn->work);
 	kfree(utn);
 }
 
--

