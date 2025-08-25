Return-Path: <linux-kernel+bounces-784516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB728B33CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9665172839
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320D2DBF47;
	Mon, 25 Aug 2025 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="foC8Z5Si"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726152D1931
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117634; cv=none; b=rcLEtljJ4UMrmwOKQ+xCpoe5r7W18k0aaqBWbeobHRcvkX1xSQDFQvcVdGSmRlR8EMRtlVyuP4zT324ZsW9eeULocpWQNxWqvnE+3xTtVgngDhKKcSSRb6kaRmBIMnjRT/5NhF/C/utQoot60tjgexBDBX2OJSjrKYm3rVHkyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117634; c=relaxed/simple;
	bh=0OoKtBQyROQb+wHZaoS2xQjm0u3KufOUrctGDHpMTEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8bSg2M3wCwglc6+GBbSGlI/ePIS/QmEvidn+55+QfbaAeOg7K9dugGnxxsPyuKt1gDjsG3DX2AvlMFZp+nI3qSSTEGjtf638HU3fXNeLJUUP7gNmHEQ0QTrTpjRtymcrDEm39OJQo3b8eFuPM82TwzaWh2jAQJviab/4fF1mu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=foC8Z5Si; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756117629;
	bh=P61WosoPHPtnoxj7FVD5erEyWez+JC5PpUgmmeZ3l54=;
	h=From:Subject:Date:Message-ID;
	b=foC8Z5SipFWANmgGYAiyZDvkRImVMPLJyN99OlEzq0rdCCum5E7+URffKaIwN6mBI
	 siF2u6ZIvPmZqERNt//RjsxWBLb0XRHLVvosCFGndVpB1X3XPJQ/tAF7ZpwilEKD2h
	 dEhagPioWw3uVdw4w7U6n8hen2PrtHGOJovkBD9w=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68AC3A71000047B2; Mon, 25 Aug 2025 18:27:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1528594456687
X-SMAIL-UIID: A07B069CEBB34C44824FF4479A57219D-20250825-182700-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] BUG: sleeping function called from invalid context in dummy_dequeue
Date: Mon, 25 Aug 2025 18:26:46 +0800
Message-ID: <20250825102648.5395-1-hdanton@sina.com>
In-Reply-To: <68ac2411.050a0220.37038e.0087.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 25 Aug 2025 01:51:29 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e42062580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8baacc4139f12fa77909
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13317062580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5ea34580000

#syz test

--- x/drivers/usb/gadget/udc/dummy_hcd.c
+++ y/drivers/usb/gadget/udc/dummy_hcd.c
@@ -765,8 +765,7 @@ static int dummy_dequeue(struct usb_ep *
 	if (!dum->driver)
 		return -ESHUTDOWN;
 
-	local_irq_save(flags);
-	spin_lock(&dum->lock);
+	spin_lock_irqsave(&dum->lock, flags);
 	list_for_each_entry(iter, &ep->queue, queue) {
 		if (&iter->req != _req)
 			continue;
--

