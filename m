Return-Path: <linux-kernel+bounces-882296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A637DC2A172
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655DE3ACECE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3162882DB;
	Mon,  3 Nov 2025 05:49:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A1145355
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762148966; cv=none; b=fnKZecIhl91nsatohQRQ9hDkZieI7U4tzafxxZykDzeoxGUJDxUGr5LaWnvW8zExRdweWFQf+V+sf9NxowYK2VWigABPPvoIJKIXXgvJCfDu8KVVmsRQc5yFeQ0xsb7RapSQgCFdublgOMtFbEMREu3qPVy7y7r9zyoEBtG1x+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762148966; c=relaxed/simple;
	bh=+KFj5rGnHv27vIKb5+keI4itoupavrQMKtAXgOjiUmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RQc7hZwBdaVXSHFwedQZnQjB1BPeiCzRkfBwRQquSrSRggIbrYRohK/gIW/SG7ZeHQzmwPNWDVXwbEmcfI/l8pxEXAS1RVbZLc5PlGhjWkJ6whB30V9q66mYwqTN3ffjqT3Kv/oFwdZvnsO/ceg4xeUN+b2vSNB5JnOjVKA7QkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4330ead8432so26459585ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762148964; x=1762753764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWCdtFeRiTYHHo48qr1uxFIsc2bW5Uiytm2WAQQjOmg=;
        b=L1XAVZbPASDqbQeCsmSoWOEb0xcXX9DbOClWa1EjqsHaWUUCYa44GK7U3vd07aopLS
         rKZS5EZ1ncSsxdp83kg48oS+zhM4CrDhcKxlv0fb8wNS8zJXDXO54OQQeoGWs13N0hOH
         fIwB2CF7vLTCQTVeKcYlr716jSIB6HrEX3A8tXQ8oyll7gqxpalZFpCy9UUszv1BpOT6
         lnbaf7NEBh4L3OYFGAoWtkvDUPoTtsdMxjcHiAXtQmNSTcHP2n37kkjG+IUZspVtBw2O
         TFI4nxWDaa4MQB5R+hwtsnZSXfyah/pxP9qRK5b70q5rbtBtuBZ/PjXrS7bSksySwC6D
         Em2w==
X-Gm-Message-State: AOJu0YzV+uez1YY0pMBxf6KNyIrqgk2qrvB5HfDdQR0gN7aLRqPyGSIp
	Iunt3+F/2e27lbQZzDoidRvVsrFxPATjHYl6Kpp6s1CZttJbrFLOKDccxuplOm9KJhBCnzUDjbD
	9PMGlrKynexFZMu4wt04/DzgEuF29lFAMo071pQQtGxin6GD/OiRFY69vgFY=
X-Google-Smtp-Source: AGHT+IHaKhOyfP00wH32DhPeXxAXQpubqqgptzhFctVL7oDnEfLQdgvsmU1tHW/9H+v+BGNNa2Eg3ONeAIu72b66cE0OCq9rD4A8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398e:b0:433:290f:c201 with SMTP id
 e9e14a558f8ab-433290fc2c0mr58954985ab.11.1762148964051; Sun, 02 Nov 2025
 21:49:24 -0800 (PST)
Date: Sun, 02 Nov 2025 21:49:24 -0800
In-Reply-To: <6907edce.a70a0220.37351b.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69084264.050a0220.29fc44.0033.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in
 recv_work (3)
From: syzbot <syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work (3)
Author: lizhi.xu@windriver.com

#syz test

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a853c65ac65d..d5de9bac68f1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1024,9 +1024,9 @@ static void recv_work(struct work_struct *work)
 	nbd_mark_nsock_dead(nbd, nsock, 1);
 	mutex_unlock(&nsock->tx_lock);
 
-	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
+	nbd_config_put(nbd);
 	kfree(args);
 }
 
@@ -1540,7 +1540,10 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
-	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
+	error = nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
+	if (error)
+		flush_workqueue(nbd->recv_workq);
+	return error;
 }
 
 static int nbd_start_device_ioctl(struct nbd_device *nbd)
@@ -2355,6 +2358,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	}
 	mutex_unlock(&nbd_index_mutex);
 
+	mutex_lock(&nbd->config_lock);
 	config = nbd_get_config_unlocked(nbd);
 	if (!config) {
 		dev_err(nbd_to_dev(nbd),
@@ -2363,7 +2367,6 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	mutex_lock(&nbd->config_lock);
 	if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) ||
 	    !nbd->pid) {
 		dev_err(nbd_to_dev(nbd),

