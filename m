Return-Path: <linux-kernel+bounces-785812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F6B3515B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222F41B275B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D71DB13A;
	Tue, 26 Aug 2025 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="gSYW04sP"
Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC151FC3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173866; cv=none; b=ORLYpI7tD/2KLZgl/Fw0EktIz3MTlGT4KzZwDDqFJoqzmGnI8dpWON6wn9jY7FKw6JLCJ+rv+Iq8P7oRV8Ae83/3vu+IROTcC3QYnKQRUo/HQDPBQfBRhBVnNL79FibaBA7KWeS4CvETJgpUcu9BT5JAC7zOInMdDTLxAWIB1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173866; c=relaxed/simple;
	bh=YxPQTuvnfSzXbWjvnqZP7SpKh7eZtWOq6EcnyldZEsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV7c+B0TToIf3fw83HEfrPGsqUpJ3Dik/icLfnJrU6nbQf5mO2bQDQVIQiibtSNXKFnWb+2dL3j2YVa0s1I4T10fV/+KiwwLbbkJ+MMYr/5PvLpd4QTlTIs3v7xU0S4mJU0cqXCYewedZGcJnBLySni7gAcB/eW65CDuQPbibac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=gSYW04sP; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756173857;
	bh=te1bMbU726RjafT3N8pkBxQHLlgRUcBsPByWOwnabyI=;
	h=From:Subject:Date:Message-ID;
	b=gSYW04sP4UUNLOjBVAHlItrDRBhiz+5uIqT/sAhe+tZADR5pHoBXc3DXJrZ3y7L5c
	 uQH5+PwKy4yz0j4xxLIRYrZR9o2d/nauTnUQT4XWg5y5/WWgafNOf4XPvKAEhUcsFq
	 v4sUn5cSRR6zXKuALnmRXWhyRMvWfT9TKmg3rUIM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68AD14D80000124E; Tue, 26 Aug 2025 09:58:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2070016685037
X-SMAIL-UIID: 1C3D58F420D9448D996E379732FD0CB9-20250826-095850-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] BUG: sleeping function called from invalid context in dummy_dequeue
Date: Tue, 26 Aug 2025 09:58:38 +0800
Message-ID: <20250826015839.5533-1-hdanton@sina.com>
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
@@ -784,7 +783,9 @@ static int dummy_dequeue(struct usb_ep *
 				req, _ep->name, _req->length, _req->buf);
 		usb_gadget_giveback_request(_ep, _req);
 	}
-	local_irq_restore(flags);
+	spin_lock(&dum->lock);
+	spin_unlock_irqrestore(&dum->lock, flags);
+
 	return retval;
 }
 
--

