Return-Path: <linux-kernel+bounces-765735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF95B23D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939B21AA7DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BE16FF44;
	Wed, 13 Aug 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="tybRA9pJ"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1E8634C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047454; cv=none; b=fu6pDCL3FGWOp60hJD4nwUZWwFGbHRqoD1Sd7zPm+7H83Y8Zpqs4OHRMAbei952Py3ttsGtaRC/i20iAh69JKjzvt/Zzv28YETqH8/chSZkqgaWmiSnQPnWwWPc3kOCd+Jekc3pG6KDGkMOP0kwg9bik/EURag/MEHe8j3zBpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047454; c=relaxed/simple;
	bh=t6I4ozczFHLGh3H3oHM3NAMy8Ot3L6g8vxA5gIX1ne4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl6HRqZULU5fuTyz6AP76Kj/GQzP6uepB2FM20ExU1sQ88hrgzLxwUK1oIU2GsenSosFoP1wq2nbyP4hiAbV8Ff1V9WtdoCamnXFVue6d9JKMpIWpH1l8YwM7JhT9Z4j1mUNRUrXL1Ei7wCLV+prARloq86aL9MPmt5+0g9uMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=tybRA9pJ; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755047445;
	bh=Vb8Ss+6aJkY35s5dpOku2pEFwVYiDG36i7D8ed8WvXw=;
	h=From:Subject:Date:Message-ID;
	b=tybRA9pJeCdXQybBVAx6fptJZUPzTyMQROs1qPZkzt+EDaKsglX/naabDAmbg1coo
	 8pJmslLoiYU1WLFz+krEM3xJz4vS1Yp2W53rLh/jAg3/GoZLzsdiC1CtOMJ5yI7SO/
	 QmOAQp9S+MNvwkzmbD+SFJJlSDok/0mQU2Yq3eBg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 689BE608000016E3; Wed, 13 Aug 2025 09:10:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5552836292173
X-SMAIL-UIID: C0287501DA404E9EBE000C5726F1E6CE-20250813-091034-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
Date: Wed, 13 Aug 2025 09:10:22 +0800
Message-ID: <20250813011023.4357-1-hdanton@sina.com>
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
 
@@ -901,12 +904,6 @@ udp_tunnel_nic_unregister(struct net_dev
 	udp_tunnel_nic_flush(dev, utn);
 	udp_tunnel_nic_unlock(dev);
 
-	/* Wait for the work to be done using the state, netdev core will
-	 * retry unregister until we give up our reference on this device.
-	 */
-	if (utn->work_pending)
-		return;
-
 	udp_tunnel_nic_free(utn);
 release_dev:
 	dev->udp_tunnel_nic = NULL;
@@ -940,7 +937,7 @@ udp_tunnel_nic_netdevice_event(struct no
 
 	if (event == NETDEV_UNREGISTER) {
 		udp_tunnel_nic_unregister(dev, utn);
-		return NOTIFY_OK;
+		return NOTIFY_DONE;
 	}
 
 	/* All other events only matter if NIC has to be programmed open */
--

