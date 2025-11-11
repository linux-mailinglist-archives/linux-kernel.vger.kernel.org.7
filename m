Return-Path: <linux-kernel+bounces-896298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EAC500D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 844C24E9B97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F432F3C09;
	Tue, 11 Nov 2025 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Eb7Y946H"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A662D6E5B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903670; cv=none; b=n8+NnlC1KFw9iy/6968nASWQeL69rMFgksdsFAcpwFj4ZDLfYXrOvF6V5ZruJd6qpCfi1SXbEU+EJHhMLgdMyzFrWaiAD17QViNf0i+kVK+U0vnkDxLWTAeafCosa2hBnF7ZagzXpGOh6bhY/k32EF9tu2aTWi+oQp1qJ7yCVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903670; c=relaxed/simple;
	bh=eZjTmwtz+7Q+Isk/XxtEXZJV8VFvkeLCo6yPTZFlPw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVS7t6OeLN0sFRC2rXxukJHpNHyMaTcyLYrph5cYJh9AGvS7tgqrzK/kyvdNBKIkivK4cSz+h4PN7iq5e4vqGMwRsidUgZeJlPVa5wbw+JlUxvqDepcw4IT503APPEUZBPLY2RAB8XNvqs3p2yHwxm1p+Hk1qZP7ASO+TFtS9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Eb7Y946H; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762903665;
	bh=6dssGtoxFvrdWgfTT2kXaA+5BFhRRsYwUSv5NHT99RY=;
	h=From:Subject:Date:Message-ID;
	b=Eb7Y946HZhuectGR39zvoskGoEsjrZgXcsAqIaCGFaKDe52bGVvlvpCgkMY0VQxaQ
	 a2tZVwtpCgkvAEot146/marl3LVUsTZoFHtGLyCHdrR70jKUipF8cYI2tptwKYDpxH
	 Xu1gI4piPL0nqmi5Dma9CFfkWurpi0Zf2NNK+K+w=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.33) with ESMTP
	id 6913C66700003DCE; Tue, 12 Nov 2025 07:27:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7485146684944
X-SMAIL-UIID: 31B521ED859D4A49A9E8A77A33A889AA-20251112-072736-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a72c325b042aae6403c7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (2)
Date: Wed, 12 Nov 2025 07:27:26 +0800
Message-ID: <20251111232728.9139-1-hdanton@sina.com>
In-Reply-To: <69136cdb.a70a0220.22f260.0142.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 11 Nov 2025 09:05:31 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4a0c9b339199 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=127c3bcd980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
> dashboard link: https://syzkaller.appspot.com/bug?extid=a72c325b042aae6403c7
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fb5342580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167c3bcd980000

#syz test

--- x/mm/mmap_lock.c
+++ y/mm/mmap_lock.c
@@ -240,6 +240,7 @@ retry:
 		/* Check if the VMA got isolated after we found it */
 		if (PTR_ERR(vma) == -EAGAIN) {
 			count_vm_vma_lock_event(VMA_LOCK_MISS);
+			mas_set(&mas, address);
 			/* The area was replaced with another one */
 			goto retry;
 		}
--

