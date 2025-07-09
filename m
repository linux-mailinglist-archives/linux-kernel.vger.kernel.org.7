Return-Path: <linux-kernel+bounces-722640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81332AFDD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5698568044
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368A01A315C;
	Wed,  9 Jul 2025 02:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="RZMF+Z3f"
Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410F149C41
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027225; cv=none; b=DEypn5UYP+ebYM85GBfarC7odKxJt2xRzPMVvtSpL92sOgiT7yukGIpKk83WvIPUshn/9uyelFivk1VUFIubpPLj3TXU4rX3Vb39KE6gSPH3YCZWmy31nVdxmmCS2lB5JDJYDPIiLTniKIfQ5AYad62CL+j4WkZPk80wAU6Irao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027225; c=relaxed/simple;
	bh=DAbAPJqTk4RLxhR5u/dfbhKYuppSUwvMFxKfYMlzCpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icL1H2fNSbzVOQ1C1KmUXsFQKK9CO7n/h2D8oL6SvEdvoFLSInNohsR24AioMvoBCbItuCYj47BkIimIxT+sqy2okUfre/szd506im7KCQGTt3hDpSD9k3QgIYn0nPEnZ6L99l70f79Em1PNGUD5R7Cov17uz7t62g+86GTz8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=RZMF+Z3f; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752027220;
	bh=f6Sw4qdPunDUVwAwItmHtx7NFCD0Zv9o7/bvQ+7zaxo=;
	h=From:Subject:Date:Message-ID;
	b=RZMF+Z3fXLpaj1ibnN9hIIQ8lpz5uV7WoY6zsypgOjTT0yH1Dw0EfCNbOknr4PBFq
	 4kDFnOZViKzQsZ35gujL8NmN7I0by22vwiiZkGsVY5yZK22SUsjRs0miUBw0fe0pfD
	 5JbQo639LjugB4vSZCqbIb1XkJWQBxBtCoLp4rCc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686DD04800006183; Wed, 9 Jul 2025 10:13:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4062766685210
X-SMAIL-UIID: 469CE6DAAC734DBDB594369FB1033FDB-20250709-101330-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
Date: Wed,  9 Jul 2025 10:13:17 +0800
Message-ID: <20250709021318.3100-1-hdanton@sina.com>
In-Reply-To: <686d5a9f.050a0220.1ffab7.0017.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 10:51:27 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d1b07cc0868f arm64: dts: s32g: Add USB device tree informa..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=1554d582580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f89ec3d1d0842e95d50
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11680a8c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c9abd4580000

#syz test

--- x/drivers/net/usb/usbnet.c
+++ y/drivers/net/usb/usbnet.c
@@ -231,6 +231,8 @@ static int init_status (struct usbnet *d
 	if (!dev->driver_info->status)
 		return 0;
 
+	if (!dev->status)
+		return -EINVAL;
 	pipe = usb_rcvintpipe (dev->udev,
 			dev->status->desc.bEndpointAddress
 				& USB_ENDPOINT_NUMBER_MASK);
@@ -254,6 +256,8 @@ static int init_status (struct usbnet *d
 				"status ep%din, %d bytes period %d\n",
 				usb_pipeendpoint(pipe), maxp, period);
 		}
+	} else {
+		return -ENOMEM;
 	}
 	return 0;
 }
@@ -1812,7 +1816,7 @@ usbnet_probe (struct usb_interface *udev
 		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
 			status = -EINVAL;
 	}
-	if (status >= 0 && dev->status)
+	if (status >= 0)
 		status = init_status (dev, udev);
 	if (status < 0)
 		goto out3;
--

