Return-Path: <linux-kernel+bounces-882341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE617C2A388
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB7284EBDD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BFD296BC2;
	Mon,  3 Nov 2025 06:44:39 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935C27146B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152278; cv=none; b=tyR2Q4BW+jocKUN0n4MW2aMXGPLrmLtw3DDg2f/91WWxarayzxX9Xyrko/sIe8k4X3ED+0oAcqcwbbThnJMeetTysitbhQPIuR3OSLA3gS41lRfZAzMDsSHbCNCehPOJjlbSNu6U4d4cM5jSHjr2vRjkLgnTNYb8fIeo4ocb2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152278; c=relaxed/simple;
	bh=+KFj5rGnHv27vIKb5+keI4itoupavrQMKtAXgOjiUmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MGSvfBjiCt1CuthJ0N8kL9neGkosVm1EeXg3vrUwnY8SRlaRDe/rFoutilpykvWAsSyvlATNbRUQ/0KlDFvrRlHiCn9tNlJv2enzwuYBBmh9v4AsiD3HBSWCQinRzo9afSIF7EW10dQUEpbyWmRpMEpsVapkxMC/z1iX+7YE8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4333052501cso3970585ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762152276; x=1762757076;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWCdtFeRiTYHHo48qr1uxFIsc2bW5Uiytm2WAQQjOmg=;
        b=a52yVpRJn8cm7iCLRtVR3RQvA65FDmvQaXsRa39TptMn4RzLimNMPe6hnFso/qqgms
         Ck++/LDbGX7ggybg8jLoFN4fLfCW5S7VQYdPK/BcAQcs8uSt2Fz/7H5m1XvwX20iFmUH
         fHFP4wcxLbK/tMUP7qTKg9GSksEmLyn2uM0XUklm/Mo4TdVmsROergHJKWiMrJLYMQ9B
         VshudFBy2qJdKHoBHybEtEMtXRBrKNVZnHQmTukRqu0CkYZWQwqv4nRmMg1LsTO2xkNo
         mVFqbSlLo/VT224ZH5341MbSZFdfZcFz28BKZ0yvGhMKK2KBUyg07jwC9B0YdNddPUbz
         K0Vg==
X-Gm-Message-State: AOJu0Yx3QW/LRdpflyuqHfG9HaWaBG6WbdqZJ6AyYt1RQaKiY3qvIT6U
	bN8urOWAH9XLN3dNynnIXGITZFZ1Or7Rf/76dAASx9qQVTqHK1t1RZnQ0f6Lu2AvfHXb9bFlpEq
	kLllWPpAF59jXEUeFOI+7F2X8Gt8xc7XWo3/CXMGOM0G8UV543V2ah519x9U=
X-Google-Smtp-Source: AGHT+IG+wYbtFB2ChoAOLNJLgz7R4vSRCAT1mzcJEIH8VlcBzqofCD3lGOMQqxNEhnmtR2aQ9AvnOCHBA8I//K3VzPQG8/n67aRE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398a:b0:433:3315:e9ee with SMTP id
 e9e14a558f8ab-4333315eb15mr10845895ab.10.1762152276509; Sun, 02 Nov 2025
 22:44:36 -0800 (PST)
Date: Sun, 02 Nov 2025 22:44:36 -0800
In-Reply-To: <6907edce.a70a0220.37351b.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69084f54.a70a0220.37351b.0017.GAE@google.com>
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

