Return-Path: <linux-kernel+bounces-809202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0119B509F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890294E79DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8A1B4223;
	Wed, 10 Sep 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ttaq5tP0"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872433D8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465269; cv=none; b=Rt6BLueI13c4OmeC7New09c1LFWko63rrVGqeSpfw2oLkurNREdsk3OuPU0k2fhDETbv0+grS1Ss4MF9ZLL23TwD/WEnpgDSBIliuh/qzUkbqY7ZmMNDpefSTkIA0j/195UGPcOhjcvip+541/uf9tZ7YxiMieYIkNa+UZ4+Ioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465269; c=relaxed/simple;
	bh=+BPCJ3e/nHwrnVIs3M+4aZ6LQBQFSPBkujPLvw8ZNkg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iHIEQzN/x8XeXGWwcx8jmwJ+RB4lIB3AzW3VOzQFpzD13lesYECnkLz6l651QSTAa8HwcFIvyVrIbSZDqk1KqHJ8A2cuO73Z4mmUAdAzihCWuvB7IhAdwUbW1nl3wjqCZCe/HPmWp68rArp4/3R1c8QuwDeeWWu0oil4LEFCLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ttaq5tP0; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757464955; bh=JdPPkqFIlah7yqBewhHjXZUTieriMQhN1EOl8I3Oawk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ttaq5tP05cUcFUfyvemlXRujqZNrwhKvisEqaV/E1MMswQbS3CEi3zSQ7O1/d7fEo
	 rn9dTZNusYMS6UASu1tQW5c5FTCyjuMWvM4RU1nGwSZtR76x+tA9OaamZZevch+EK3
	 spwUA0a06apbCyNhUT4nUSJhjCEJq1bKd+kjaul8=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id AA132ED7; Wed, 10 Sep 2025 08:42:33 +0800
X-QQ-mid: xmsmtpt1757464953t5vwxqfur
Message-ID: <tencent_D2897063A84456F7739765A6C3B375836505@qq.com>
X-QQ-XMAILINFO: NvWYEgjCCjcV7ic6QQ7wIZzVXmFcu04knj2n6SWvghjEzg7QxLsf4lwTH1UrKj
	 gBsB6oYjF6w7NQ9jnp3BEmQnWk8bae5+TjtJQoB9BM54Ht7VwW9llSRdxN+afC35wJSlB1E0M5yQ
	 5s8KqFB1LSt9S+lW62/2zjA0gFUS2WFxZs2ABOTrf8FMryNSRVuprv7VEKPhocMcs33L2WGFUuLq
	 8ojedcihAH3NfQgupCby+/G9UXoSFzpngykUTaO+aqMRthPaBfsuVRBIUh5i5wVuO/tWqFKxvhLj
	 SeL4Secm63GFvrLSL1tNRX/yyqYSPiZCqYCddRhW9wsmqj8iCrNO2SipxkqjFBE6cdRbIDKpw4/g
	 buhODi1+xwwlewdAwy2yrh/H63PsNn0ZZHpljNvDw/dbRAH89FfdIBSG0VyzXU9Z8j+xI5VlnDzZ
	 YdbS9qEbe7OugqKq4hPumZHeD631lZZi51nAfU4QI/zpkqPjHsKhLu49jSMmnO1+A49ZrfYtIJoa
	 dGM9s3SQsiVNMuTuPYt35a64lNPJHkVu74+uRMkZqSABXrvoPmthm2034sO1/lVhbP9TD5QMQhBh
	 YyyVD+oysNNWXh/hOS/Kyl9t+ECCfDILDCgqXkf3kSXSCmULPNijRR5WGAV6F5I4MrRpAne/Xt1P
	 W68e2pQUXbuh5ye4ifOQA+ADjjl0eqhNZ4ncCB8rRDBqZ0UveziIl1+z95YX75W4YAbZcVeYZZPh
	 sj0FOnraJXJs29u7WKq9BxDgpIuAUHk4b1/5fSpjGWHf6+oa/4bDZj7jzRubtrxO+tdQ0fNDBdzU
	 3gEUwX1cbyWrKQWd1lteInhNGa1XKSZ+0BanG1rGcUe3BNW//jb5cMm0Ux4qm2hv3Y0rzRVuhqvw
	 8plKqCugNFR5+ELVFZCK1QqFQUwuCqx6mDQGTiySTFXAgbDEpG60VgCZS21xMvapnrZeCz4z04w1
	 swsBBvZHjjCFYsAifM7cVKfgyiBNBE
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] KASAN: slab-use-after-free Read in media_devnode_unregister
Date: Wed, 10 Sep 2025 08:42:31 +0800
X-OQ-MSGID: <20250910004230.947042-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68c097c5.050a0220.3c6139.000a.GAE@google.com>
References: <68c097c5.050a0220.3c6139.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 0d01cbae98f2..6daa7aa99442 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -276,13 +276,10 @@ void media_devnode_unregister(struct media_devnode *devnode)
 	/* Delete the cdev on this minor as well */
 	cdev_device_del(&devnode->cdev, &devnode->dev);
 	devnode->media_dev = NULL;
+	clear_bit(devnode->minor, media_devnode_nums);
 	mutex_unlock(&media_devnode_lock);
 
 	put_device(&devnode->dev);
-
-	mutex_lock(&media_devnode_lock);
-	clear_bit(devnode->minor, media_devnode_nums);
-	mutex_unlock(&media_devnode_lock);
 }
 
 /*


