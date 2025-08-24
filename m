Return-Path: <linux-kernel+bounces-783478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491AAB32E1E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFB67AAB44
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A4A2566E7;
	Sun, 24 Aug 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="eg/x5u7K"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75115245021
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756022983; cv=none; b=u+Nt6Jm5FNJ624WxVCNzQTCrhjb+PbUrQGWNWiCv0Am+g+f/Z/tPttEcXSsieboxNacNVykyx2TxKWezc2JtWbsOL80Xw9A82j1+4dJd9H8axfwazdsrS5O3OPxdni1sdG4LWQUw6pm2z+LeWoLyQSbBAICeYruIM6RaJLnz2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756022983; c=relaxed/simple;
	bh=qOac4q+/F3Tv0D9k6q2U9aBtmfT33bqNHsrBBnc1GgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dshY3OfuIVk8ucIA3EDKhee6k+cMFP8GzZwKk6/XOgYkOKQHHNKvHkGZ737o24nrOcQCoUxFWGIn3B2Ca9ZjWUrCt/nLzqSLRdCJN5jN8+hfWLjnxzAOF7Qz+9pDkyaAbel5ph5IAk/KMdeJjCVwfdDIVSGuCVzKvkERZm+qmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=eg/x5u7K; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756022977;
	bh=tP53oDkScK96De1KBNJ3EFrOcqSfqEtQvJTTaqhv5eM=;
	h=From:Subject:Date:Message-ID;
	b=eg/x5u7K8nkvVTcmg8P0odfD1HZpXLd+G0DiiaUijKOcfyrEgrKZ9xKsn2KMnoLSx
	 RcjlkAL/Kp6uNo8TL+rdpFXjIx9we3ZRepSA+aKHIJ7KyJAV0fBd3oxYUUhSCxwiIn
	 UujUa+Fx/fGsE1fmfTrcbspl0cxQvsLyacd/yszQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68AAC8B500006E1C; Sun, 24 Aug 2025 16:09:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2920256292106
X-SMAIL-UIID: 5C7005CECBC04299B6E7991493C2D2BE-20250824-160927-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a658d41cf8564471775e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] [usb?] KASAN: slab-use-after-free Read in v4l2_release (2)
Date: Sun, 24 Aug 2025 16:09:16 +0800
Message-ID: <20250824080918.5312-1-hdanton@sina.com>
In-Reply-To: <68aaae76.050a0220.37038e.006e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 23 Aug 2025 23:17:26 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f37062580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
> dashboard link: https://syzkaller.appspot.com/bug?extid=a658d41cf8564471775e
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c267bc580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a8c862580000

#syz test

--- x/drivers/media/usb/hackrf/hackrf.c
+++ y/drivers/media/usb/hackrf/hackrf.c
@@ -1345,7 +1345,7 @@ static int hackrf_probe(struct usb_inter
 		const struct usb_device_id *id)
 {
 	struct hackrf_dev *dev;
-	int ret;
+	int ret, registered = 0;
 	u8 u8tmp, buf[BUF_SIZE];
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1487,6 +1487,7 @@ static int hackrf_probe(struct usb_inter
 			"Failed to register as video device (%d)\n", ret);
 		goto err_v4l2_device_unregister;
 	}
+	registered++;
 	dev_info(dev->dev, "Registered as %s\n",
 		 video_device_node_name(&dev->rx_vdev));
 
@@ -1520,7 +1521,8 @@ err_v4l2_ctrl_handler_free_tx:
 err_v4l2_ctrl_handler_free_rx:
 	v4l2_ctrl_handler_free(&dev->rx_ctrl_handler);
 err_kfree:
-	kfree(dev);
+	if (!registered)
+		kfree(dev);
 err:
 	dev_dbg(&intf->dev, "failed=%d\n", ret);
 	return ret;
--

