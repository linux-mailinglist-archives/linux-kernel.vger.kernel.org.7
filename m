Return-Path: <linux-kernel+bounces-772312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0530B2911F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68820485A50
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 02:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D31A316E;
	Sun, 17 Aug 2025 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="jcblASF5"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7B38F80
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755396544; cv=none; b=N/WW52a5rk43AQGXen6v11KCoL3SNxWudb63ZTiCGyAmsXauztuGYrjzdqPLiQ9qNwQ4Bx79cUpaLkhCzL9dG5dhxKM183kZFroHVFeWQ1BpErks5Y13wN+/kkmqKesbdO4RXCFGzqP4k7C9NU8hGpYQcTV78YAXjpmmGKRC38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755396544; c=relaxed/simple;
	bh=sn6Ma67MjR10z0241vZVJtlBs2yUz3uk4rbJEDBfsSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBQi5PaGvv29ZF1mxPYtZo4+pHjARFsL3GA06QsKrbLJnG4UPS8Omx+cu96NWgx+oPRFslLUaQ1gF8ghkpRAuR5NmQO4dNcdsqeSZgMi9aBioclL8zkgNVo5bEECs3XSwaoU1eSfNakYxvFOvfPH9SALA0DB/ulkMBBlJBUBSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=jcblASF5; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755396536;
	bh=4psIGG+A/EzzJmGJeRDXlskfaP6zKa+nNyqiE8y2QSE=;
	h=From:Subject:Date:Message-ID;
	b=jcblASF5mRlhAFA6hvY1ACDY2J3zDyTOhkuchij+99PlZP0VU8uU2EUYF4uIwBu4z
	 3oKDnC48fSCGVnzG53/hnpDFJEtLNfE+31H90UlF//XBJX872h2wWsIV+6hwL3DP2b
	 KDijVMU7B94AP6C6Nb2khvCBWFMiVxhXGk4XM4TQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68A139AE00006A25; Sun, 17 Aug 2025 10:08:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1802696291955
X-SMAIL-UIID: 7A5BE0A7EAC14B3F88618C557834C679-20250817-100848-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
Date: Sun, 17 Aug 2025 10:08:35 +0800
Message-ID: <20250817020836.4788-1-hdanton@sina.com>
In-Reply-To: <689ff5f6.050a0220.e29e5.0032.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 15 Aug 2025 20:07:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ef65a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a99842580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17108da2580000

#syz test

--- x/drivers/usb/class/usbtmc.c
+++ y/drivers/usb/class/usbtmc.c
@@ -2365,6 +2365,7 @@ static void usbtmc_free_int(struct usbtm
 	if (!data->iin_ep_present || !data->iin_urb)
 		return;
 	usb_kill_urb(data->iin_urb);
+	usb_kill_urb(data->iin_urb);
 	kfree(data->iin_buffer);
 	data->iin_buffer = NULL;
 	usb_free_urb(data->iin_urb);
--

