Return-Path: <linux-kernel+bounces-722510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15CAFDB71
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5BD7B8111
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899122330F;
	Tue,  8 Jul 2025 22:57:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D21B4257
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015426; cv=none; b=NJK2V7cdbO66UhJuTFqChSluPwHqlwzPFuOSXJL2wfn5Fiu8jgnbD0FQOcy0+bC8E79eQLfwWwG3J8Upr27NC088JML9vNBckvba+zbwyV866TXYasSFIDwgxhpAPxld0JSTz6S037PjeIK03uedq23fjkN2zeJirUZZ6rztVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015426; c=relaxed/simple;
	bh=GbMBD734YBPdLhnECCYw3mooBvzxUe3rrmDyjR2l4m0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tUTNfyW5uhIBC5PO2NQLUJIJo3Lxx508Nw9BHjXmD65M1h+FkuaUdTOEqaYVXM3AHU1wRYE9JCcglwns+oUptv4KKnYGye1Bv2j/5rlhecg3lokpJ9K7foqzegY5WDEF0AX7CCII09z833fZuD2c1OE8tipQgZ+tD0XFZtzz2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cfea700daso427565139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752015422; x=1752620222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhv184HDALO8fFw/rEl/SW7vo8z/YJC+ZE8quW5DMc4=;
        b=PmG8Vxr11+jpYoc2yzCgQWJzyOSkFx0/zCP7K3sTJgerRJAHlAF6/mukdJBn858Vn/
         RMfU/E2L/ggyF3X9myQKObnzUEy7bwQsW1fNNcj/Pog6a+zIQwESHH10wF6MyQ5mEVZf
         fCvN5ZtbVGWoTR6YunC4/C/VuVQxtNqdIs/tByLjo4YXchptWxGCHwMLDB8taF18yASL
         CjvbueMwgMGGEISIjMWNHmldcmK9slIVc/3pXQEaTqXW2BLbFZqlsRRcaVzuua9h/vGh
         Nmck8KskX0bOCqHW3m5rTOpKjcciGjcY47l8H9PxJO2N8sktf6z3ZQUG0Gw++WPNc+a2
         +SSA==
X-Forwarded-Encrypted: i=1; AJvYcCUyY20ZKAHjaCh6QtzxhBeuGfcHdV9WwmtOFqEmlFbBoLoFnMIfbgSEZgFIj8WDY9alUx5eCB8XOf+nJyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rpQmb4V1p8cxwp2asVZzO4YQ1cSaeG4+MjYZdpGJlpmHxOrF
	mHVPCMqF2ysSZLqu4weeHjM/Eib6P6Fn5wk0jEImKjF+fw2D0olZ1eNIvmLUeiPvWzGXle3b+hT
	ojMo1m51P5iMutqRU3zliEeC67BRKcf9HVb+xMYcdzqBNZLX/vePJSSC/K50=
X-Google-Smtp-Source: AGHT+IEmQkcGNq/DLEfrzrrN4F9drEZmb8/SaODZKdh3M7VJxlBx7AndmhsgrC8lcUqL9MClqW3Sqt5xN5v+gXjLAcHofXobJwlW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:210e:b0:873:35c8:16f9 with SMTP id
 ca18e2360f4ac-8795b0f1021mr42561139f.8.1752015422642; Tue, 08 Jul 2025
 15:57:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 15:57:02 -0700
In-Reply-To: <20250708223525.3029-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686da23e.050a0220.1ffab7.0024.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
From: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in usbnet_status_start

sierra_net 4-1:0.11 wwan0: register 'sierra_net' at usb-dummy_hcd.3-1, Sierra Wireless USB-to-WWAN Modem, 00:00:00:00:01:0b
------------[ cut here ]------------
WARNING: CPU: 1 PID: 37 at drivers/net/usb/usbnet.c:268 usbnet_status_start+0x189/0x1e0 drivers/net/usb/usbnet.c:268
Modules linked in:
CPU: 1 UID: 0 PID: 37 Comm: kworker/1:1 Not tainted 6.16.0-rc4-syzkaller-00311-gd1b07cc0868f-dirty #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:usbnet_status_start+0x189/0x1e0 drivers/net/usb/usbnet.c:268
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 4e 48 8b bb 70 03 00 00 89 ee e8 25 95 0c 00 41 89 c5 e9 36 ff ff ff e8 a8 3f ec fc 90 <0f> 0b 90 45 31 ed e9 39 ff ff ff 4c 89 ff e8 d4 41 49 fd e9 e9 fe
RSP: 0018:ffffc90000277098 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888107f64d00 RCX: ffffffff84930727
RDX: ffff888105693a00 RSI: ffffffff84919188 RDI: ffff888107f64d00
RBP: 0000000000000cc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888107f65070
R13: ffffffff89be8f70 R14: ffff888116be6028 R15: ffff888116be6024
FS:  0000000000000000(0000) GS:ffff888269262000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e767f1d60 CR3: 000000011f9fc000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 sierra_net_probe drivers/net/usb/sierra_net.c:929 [inline]
 sierra_net_probe+0x70/0xb0 drivers/net/usb/sierra_net.c:921
 usb_probe_interface+0x303/0x9c0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1a70 drivers/base/core.c:3692
 usb_new_device+0xd07/0x1a20 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5866 [inline]
 hub_event+0x2f85/0x5030 drivers/usb/core/hub.c:5948
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         d1b07cc0 arm64: dts: s32g: Add USB device tree informa..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10ea6bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
dashboard link: https://syzkaller.appspot.com/bug?extid=3f89ec3d1d0842e95d50
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cc8a8c580000


