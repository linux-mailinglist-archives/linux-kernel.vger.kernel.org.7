Return-Path: <linux-kernel+bounces-764924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C39B22902
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014E7565B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ECA28541F;
	Tue, 12 Aug 2025 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0StdiRm/"
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDD284B37
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005502; cv=none; b=Bf8pV31dmIAwd/OfdceJuRQv0Pd9noQRaEaukgAJWkjwuO9lvOjZ0CUkYq5rSR0DbYjO44eAOscUcRhR8z9SuPAywdDfq6f0IFnBw0rR0ftXUEZZVQjhhhK0CFTrlkY349d+JXqoHypUzBQ5lkCLdzhDHv1mRS2L/FjITsaszd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005502; c=relaxed/simple;
	bh=DTJytrEsyDmsQYsQJfiriaENM+W5ULsMd/TN0GOJtX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmmLsCjnofA4iFKVaOkJPqeGGoQGFSTEO8FpFXzqqOLqR6ijt29lYpGgV7yqmyoSFHUUgUFp7bptiqXfYy8vGzAEQrjlEiVAPlqXU4qnGII3Z8MrETOPjWKYqPNi8Vz1KF4Qly2Y0ijGMhKPdvKZudBIwu2pbbgspPWXPpi8qeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0StdiRm/; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755005492;
	bh=YSL2GbgZMuZHJHKS6ymYjeXnaBje9y1R+MqEd0xyjtk=;
	h=From:Subject:Date:Message-ID;
	b=0StdiRm/1c40OTM/vVgRnTKHRwL3B9BYeO6I2l5HU4DbDQ1eyPwCIob5kvpUMGnFL
	 Pt252qc6j9Isw6lOMaDwBO8BfqlnKUQz8I8rlPyMKI6TUOHUBJnvFswa5E2Pb+yH0n
	 WPjD7nsE/P+dfS2ek2gL7SbUBAkV6DhGihKdzoa4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 689B422800003FC3; Tue, 12 Aug 2025 21:31:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3400736816239
X-SMAIL-UIID: D08979147C2B45BA81D82C6E8CE65BEC-20250812-213122-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
Date: Tue, 12 Aug 2025 21:31:10 +0800
Message-ID: <20250812133111.4277-1-hdanton@sina.com>
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
--

