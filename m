Return-Path: <linux-kernel+bounces-764683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20FB225F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17EE3A8BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A742ECD1D;
	Tue, 12 Aug 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="EgOy6/UK"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8422EA17E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998539; cv=none; b=RyyCY0oemUYcv16ijtPVh9cX5GLJ2C164ysNJgQIbyDb7435cKGPtwwvCQh5vTmWmdSctURvXNGOlGHwRdBiU9vQST01cICJ1b1bO4Vn0Q9WJMAfi0XL8SIU0JF8w4k67CemcjLRqkZF4hEWFTiU8xHI8+2Tsv3fT+HyqEA5V24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998539; c=relaxed/simple;
	bh=S4OSf4OLLnPhrS+9baEzL6auKKSYIeSwYGF5FSLs7NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/AB767dCbWAITQbhicFxYlhGTRCjEfzrDMhclfXAFtubYkBC2F1UbFdEfIt7aT8WKKvPVFSKdIl3mXx0jBfcpOJ3r8SP7FAt2upCqT69QoLMsHeKSlBQHs4xMbU5ATmF9EnCqM+6+/PAS1rjQNc8blu3CDBRfDXAohzvUpT8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=EgOy6/UK; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754998533;
	bh=cY5FNKG+dp2iGkvjxWjeNL1KFSRXetyAlo9/faOlXlw=;
	h=From:Subject:Date:Message-ID;
	b=EgOy6/UKPOkpx0+hovhBs1599QnBi70G9m3SNH9xbnSpAFvZaYCh4A5NuPhipPumm
	 ZCbifWjWNyxAbxCypEjFGtaagmU+SHPjTkLD8kHx2L3gHvDV0MiGeMl6um3N6DIoJi
	 MwVcN+1pDg/5aHN7AHnZeCaPL2PxkLTBbvGnnPz8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 689B27000000390F; Tue, 12 Aug 2025 19:35:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6305256816260
X-SMAIL-UIID: F0CDF043CC1A4D4F8B98E50C1C0F75C2-20250812-193529-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
Date: Tue, 12 Aug 2025 19:35:17 +0800
Message-ID: <20250812113518.4238-1-hdanton@sina.com>
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
@@ -981,6 +981,7 @@ err_free_prev:
 	while (i--)
 		kfree(ns->rq[i]);
 	kfree(ns->rq);
+	ns->rq = NULL;
 	return -ENOMEM;
 }
 
@@ -989,6 +990,8 @@ static void nsim_queue_uninit(struct net
 	struct net_device *dev = ns->netdev;
 	int i;
 
+	if (!ns->rq)
+		return;
 	for (i = 0; i < dev->num_rx_queues; i++)
 		nsim_queue_free(dev, ns->rq[i]);
 
--

