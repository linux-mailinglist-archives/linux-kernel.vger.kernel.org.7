Return-Path: <linux-kernel+bounces-722482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEDDAFDB28
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6F7582A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724A25A337;
	Tue,  8 Jul 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="eD+CN7dy"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82721B9F1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014145; cv=none; b=fh+2Kj9zEDUxaxKHQSz6wVlTSLMwaOe7j0y3PBtsBUthwXR/PuXbMWGKntiH2PsTYNrwyFeGPukeBQWZdN9V86sTr9U9W5BLMIONWSOVJstO7rC1MW5RdJU7vQUyLitbT/y1tgDYcXlDphgLD8OwsrviQZrYFHorEsDcfO0QzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014145; c=relaxed/simple;
	bh=Uw3P5pATGG2sohnbKTzV4ZbHbZx4Vj5bZe0g4ojHees=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbjo2fL6QyfQh4aF6yIXeJq6ZTgnKAaY9wCGrdpNJ+rTr781u6u7ke9PufCjnQ+v5LT9NanbDVWFlEMmPs/2miWPvaKzZQ7xYQBGcVOnAXJ4XdZlRcIqq9iENE0eCVQWbXqNcxyJSLXmSk+lvbDahDBGPamk5jXghQbGrjd73FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=eD+CN7dy; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752014140;
	bh=xESfFpWV/xhoQJW1X3B88U4/8BWKHV+N80jTCVVZS9o=;
	h=From:Subject:Date:Message-ID;
	b=eD+CN7dyn2L5+deY/M7tvNhNVpyjhiUTU98GVtzT8KiDeVjcVh4thMnBrWQnLakKP
	 JRFlo6r02JjzNWY3logc3pchnHzejadAEOFveuFogKVi09oJPPgs6CVQcSTKJ02WPa
	 B9CGpvc2RcwDFzRq9c9MAV6fIE84vRTf4M9cRSUs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686D9D3800004A74; Tue, 9 Jul 2025 06:35:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5128396685252
X-SMAIL-UIID: 15AC2DCC886B41B4ABF580884E0EFA08-20250709-063537-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
Date: Wed,  9 Jul 2025 06:35:24 +0800
Message-ID: <20250708223525.3029-1-hdanton@sina.com>
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
--

