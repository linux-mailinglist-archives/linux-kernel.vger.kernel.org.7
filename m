Return-Path: <linux-kernel+bounces-722577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83906AFDC79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CF01BC20E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35F7DA95;
	Wed,  9 Jul 2025 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="n/YhKZEP"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804304317D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021709; cv=none; b=RzhduaDZDB3oRZRAlUxtK04C7SpLdsVDHxBYL76V1MlCrdL4AUC769gHMAaQn6sNUlwY0IgN+6WADhLx15/UOLnG9XBd7IXbiJGzAci0Jzfv3i4Xr72a53H90c2Gr4R2xnvwwklRmveXnse8fLrZYfhyOab/zrtHhfIATQw6mls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021709; c=relaxed/simple;
	bh=pDaXh/XIEPLTmyi+OQSPDfytIXzJPUeLg3/LXE4Xg2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duSaizs7f+autmIR8ff10pCTF72G0oycnaS9igMNzSvXWpToWPX1vQ+AhNBcSRh1MDk0DblD6xrA53tf4OKPPV7Cbjp0nYGhFsl9Mdj1MYi4B0gFbQMQlHm1w4n5R+pgT0C1fAKu1ZOS4BThKVm+evTwtixrnyx3R3aNNVDkmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=n/YhKZEP; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752021700;
	bh=91xE5/KEixZml9Zzeldg+MkwQeJWB2y/xspKaBw7jeo=;
	h=From:Subject:Date:Message-ID;
	b=n/YhKZEPkIPirMUGDxDjgTdOh4dHZCXHek+noZvfhITsARMFTYB5bpxAI8CPaBQhx
	 u2t02CEErXG+kDPaOU+C2x912q2a4jc5xqRxrzsTy0zTC16eoHWQbZeYlQ6f7XVCp4
	 2OLLbVKt9hdNDPhq7J2slu68VFs/HOrw6ylArUEE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 686DBABF00000B3B; Wed, 9 Jul 2025 08:41:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7048064456971
X-SMAIL-UIID: 44761E51540F489D8368DB35841328D1-20250709-084137-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
Date: Wed,  9 Jul 2025 08:41:24 +0800
Message-ID: <20250709004125.3049-1-hdanton@sina.com>
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
@@ -254,6 +254,8 @@ static int init_status (struct usbnet *d
 				"status ep%din, %d bytes period %d\n",
 				usb_pipeendpoint(pipe), maxp, period);
 		}
+	} else {
+		return -ENOMEM;
 	}
 	return 0;
 }
@@ -1812,7 +1814,7 @@ usbnet_probe (struct usb_interface *udev
 		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
 			status = -EINVAL;
 	}
-	if (status >= 0 && dev->status)
+	if (status >= 0)
 		status = init_status (dev, udev);
 	if (status < 0)
 		goto out3;
--

