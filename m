Return-Path: <linux-kernel+bounces-738006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81160B0B311
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D102189FBBF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49213C47B;
	Sun, 20 Jul 2025 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="W6g82s/E"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5A3FFD
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752973975; cv=none; b=R/glr62MGzPa2MnFLFwXTpz/hcAUvdGPzjHdbQIgamtRAZfsc5hIVNGam+W6D+rjvC6rIIcZyWLRHl95kE6BY/PAtELiTtLWET1a26NeJ35gsXPL+WYsM+/Z0gTYk6LvqJAV6xfYJjevFNKpXgi1Zf0/sz6uyHLUpUzZWu80Tao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752973975; c=relaxed/simple;
	bh=paXC62P6QWVEW1VLTnqgOBUxIXMuYUuVqWCjJGrFDQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSKYJ0GgZP5Vp96zyCFniRS1vtvwXKn+qiPcexdZU+ypm9jHqakZuhIZzDACt8nBXVSS60e/rDLRanlozThaZXDltQdY5ne+U0limjHm85vUcBeEGccRhU8wMqsEpHU161Ylbn/mNo5hoHcMxiG+aKr/ssjHW6D6ZNTTl/fnNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=W6g82s/E; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752973971;
	bh=dpashuyWihVqUEDurTH/7VsgDKMORimAflKutLOrDyU=;
	h=From:Subject:Date:Message-ID;
	b=W6g82s/ErkJBbv64IAYVt6/XAiv9sM++jHuN8smmdlJ/m29wqVWAtR5sphN1Fu7oF
	 r3Ej8pgCcMqVaY7d91thhgZqOs1V78dF58PljBI2eBQLJ747u1qQlL/wvsLJfZ/l2y
	 z6+XUDcJq9AdYCm/Eo5EUhBeoQght6n7qIAauVTc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 687C428700000E12; Sun, 20 Jul 2025 09:12:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1997426685323
X-SMAIL-UIID: 4D23FED76E3B4BC3A4D3F77504A66E0D-20250720-091241-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_poll_remove_entries
Date: Sun, 20 Jul 2025 09:12:25 +0800
Message-ID: <20250720011228.2536-1-hdanton@sina.com>
In-Reply-To: <687bd5fe.a70a0220.693ce.0091.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 19 Jul 2025 10:29:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4871b7cb27f4 Merge tag 'v6.16-rc6-smb3-client-fixes' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1288c38c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa738a4418f051ee
> dashboard link: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1688c38c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166ed7d4580000

What is difficult to understand is why rcu failed to prevent the uaf.

#syz test

--- x/include/linux/comedi/comedidev.h
+++ y/include/linux/comedi/comedidev.h
@@ -364,6 +364,7 @@ struct comedi_async {
 	struct comedi_cmd cmd;
 	wait_queue_head_t wait_head;
 	unsigned int cb_mask;
+	struct rcu_head rcu;
 	int (*inttrig)(struct comedi_device *dev, struct comedi_subdevice *s,
 		       unsigned int x);
 };
--- l/drivers/comedi/drivers.c
+++ y/drivers/comedi/drivers.c
@@ -168,7 +168,7 @@ static void comedi_device_detach_cleanup
 			comedi_free_subdevice_minor(s);
 			if (s->async) {
 				comedi_buf_alloc(dev, s, 0);
-				kfree(s->async);
+				kfree_rcu(s->async, rcu);
 			}
 			kfree(s->readback);
 		}
--

