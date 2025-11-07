Return-Path: <linux-kernel+bounces-889634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2662DC3E1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C6F188AE92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D42F5487;
	Fri,  7 Nov 2025 01:19:02 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C892F531A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478342; cv=none; b=BVMhf2csJ0+Sc6PfVOfEVhJKEjRwj37pqSoQ8b5f4F7kA0yR+WDMoYhUsyTRWZvY5iV7qgNaIobfj83HOAhWoj77S1T/yPP0CFsusK0JrOSOgDyliEokKrXweZfeQkrv+69mXMvFARXK3SEX/WMF7WkPmLqmJDp8Tgmn3nPDibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478342; c=relaxed/simple;
	bh=+KFj5rGnHv27vIKb5+keI4itoupavrQMKtAXgOjiUmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=szhnX4NTaL8euSMSpNMU0UIFLsZ5w4tFNw07FkMTn9r+EigzWMqwx3dvJRIHJw3CYDlNC8Xzt7rUo9lBsA6oHTX4xt9mWGOvkDw9NKxoZCHaMmhs9Ed2oyUjWLgv9loO/+Wa/wZQ0lmpQxZxlW3O2aPkkKMpXTzoyzfh68fCJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso68026039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762478340; x=1763083140;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWCdtFeRiTYHHo48qr1uxFIsc2bW5Uiytm2WAQQjOmg=;
        b=f1iEqKnlX90pqhJHQWI24HNnbtVLXmCvQUFLwuhpIl0PRQ7kQw6xR9LwYI84EV4rb0
         G03Ftbv3mlmdVB71NkQNT8HNw4E0cEyeRmTfqf2HVZNzHUVYPwNg0iX96yt1Ts4SpweY
         vVpYDP4RBhQJhKqSSMnGSTuNw8ugBJkO4BpQQi1tMnits0X533ReVpamPmIijfNxRAFR
         MoQcPWatHp05A09/02yc83cpMJmwICGdo+I2LLY2ro0HQZUow9aQPWfMY8W4P66dCI98
         5tBqegh5vWYzOooRnvMcSr9GGEkAbOeNyCizdO69eLeKqOCl7aH8HulKTCVTY6kNcHCd
         JAnw==
X-Gm-Message-State: AOJu0YzETR6yIT+4V2LcBfJV+x2Ym+L9SKRDmpeCm1mV9gCHfIHEv9UI
	ELt5F0Sb3p5lk0LCCFVfKAekrQCQhqE2NKEawDtaEnZIjHoqvaVZRM9ZVKDqEHYoqc/QgR2ZSCW
	CJlmbbPPVmlX8nUaBYhz3YokKCw7eGAgsouV1rTTGlmNDPs8SUfImPzGbYOQ=
X-Google-Smtp-Source: AGHT+IFysJ+Exr5l6lqZ0/zaCMJKXcFqlE+3sTsiBUsIQiz3UNq5mIAgOktC+R6wT9isOCCyqS0o2zHdzh8u2TetVON7miUgGSGg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216d:b0:431:d721:266d with SMTP id
 e9e14a558f8ab-4335f4a7c75mr23445405ab.31.1762478340096; Thu, 06 Nov 2025
 17:19:00 -0800 (PST)
Date: Thu, 06 Nov 2025 17:19:00 -0800
In-Reply-To: <6907edce.a70a0220.37351b.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d4904.a70a0220.22f260.0015.GAE@google.com>
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

