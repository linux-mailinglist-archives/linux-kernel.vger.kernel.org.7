Return-Path: <linux-kernel+bounces-803295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3EB45D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6846D1884DF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1E31D737;
	Fri,  5 Sep 2025 15:53:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AD31D72F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087587; cv=none; b=F0aG7RGYnshV1y793uWaBhRec034xyhM/QL92tqEkwixA0AohPeppeHiAT+5y2NuJoIyMbaqpgaoAoIWB6hwbYgxRuQ8cuzUXnyw0r7FsJ8Af8nW5h7HKz8gT4ZzUu3P7ocZ16c6D0gbC1pZBkS3f7PydoJB3fc5FYgzjaJN6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087587; c=relaxed/simple;
	bh=WofJ5no8Utx/cozQdAPB2Sacn3ZKvV2bQOoGTZQaNYg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LLtYR6eWXu6dRBrTBcuvlgbvVa68egt2S//ZqimGfrz5pR7pY1wHrvuqUwuVWGJsnK3xN/5QEWlQNl2MgD+6cscYbG9yS/ny+RfiGZodx2HR40eD+qLIsKXO2E2IQcwnTaYkG4J1EY2zJYE+XdImAI24PbhUAJX0TlS9SDCRBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f761116867so36335725ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087585; x=1757692385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrr6QE7UOToxR+nSj8CaDtGkQd91sqbubClmOf/CDkw=;
        b=VaLaNR2eKQ1YQDY756TM+JthmMXRqXyWyDHbk0X6gd8aKp2rxwcairmR24oj/lMH4t
         VxgMoXfhkQNVbySgX/6P3X2p1kjaPfMal+SkcUZUrftG/jJmCeg4KndJRo2VudQ0g4dt
         wUcJrg0BiTabJ1Uh4s9BU2hSMIFuzm0ILbn/e985bA+H4F6TfXoaoe6DqBK/SCVY5L7N
         VnudtITIgkf6FuUATogyKBcz2ao3TJYZSLd2W2p7Q9DEbdiaJZlSGTttEf9nQtfdtIoF
         /4piFvSTmHvzj16iIxLk//AKQ3Eg0alsHWN6u+fbfu/h3MAu4/YqQMZxIxTqX0Dq3az6
         qkZw==
X-Forwarded-Encrypted: i=1; AJvYcCVsUj3ArlfAlcvafPjs5s5gh3ygrTq4SE7u1zvEpTMndCMo/dWKQ2+D8hV3b9mSFxLpQAbQUA/Wh/iAKTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXZBS/3QBn/yVJXkTR4CpGOaxwPKi937jenAFiBmOcSyuINaD
	DUUadfDvfzh+S44SRaNz6/amwakdCTRC9VhH9fATsiy+BDn5xww9fLmQdCKyRBnhlTWffHeS2Mx
	1mrJkJds2Grl1LyMPWlqNDsCgYTMbHJpkVlfshLuxcXdjgOS5L81h35CyIMo=
X-Google-Smtp-Source: AGHT+IECAha6YGgRIuQuiFBkQzgqOSzTAt4jXEZuoTCyIoHVKS/YglXvLTXmIRpdmEvb5J+Or2FWK9d6rMHSNsS74Nq5FdZXRrv3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:3e5:4b2e:3aeb with SMTP id
 e9e14a558f8ab-3f3ffe9cbc9mr333856365ab.5.1757087585008; Fri, 05 Sep 2025
 08:53:05 -0700 (PDT)
Date: Fri, 05 Sep 2025 08:53:04 -0700
In-Reply-To: <20250905142535.4117869-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bb0760.a00a0220.eb3d.0017.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in az6007_identify_state

usb 2-1: config 0 descriptor??
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 10 at kernel/locking/mutex.c:577 __mutex_lock_common kernel/locking/mutex.c:577 [inline]
WARNING: CPU: 0 PID: 10 at kernel/locking/mutex.c:577 __mutex_lock+0x3a2/0x1060 kernel/locking/mutex.c:760
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:577 [inline]
RIP: 0010:__mutex_lock+0x3a2/0x1060 kernel/locking/mutex.c:760
Code: 08 84 d2 0f 85 7e 0c 00 00 44 8b 0d 78 89 1a 05 45 85 c9 75 19 90 48 c7 c6 20 57 ad 8b 48 c7 c7 60 56 ad 8b e8 ff 11 ea f5 90 <0f> 0b 90 90 90 e9 b5 fd ff ff 48 8d 85 60 ff ff ff 48 89 df 48 89
RSP: 0018:ffffc900000f6de0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888032d9c000 RCX: ffffffff817a2388
RDX: ffff88801e2c8000 RSI: ffffffff817a2395 RDI: 0000000000000001
RBP: ffffc900000f6f30 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000000 R14: 1ffff9200001edc8 R15: ffffffff8800f287
FS:  0000000000000000(0000) GS:ffff8881246e3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ac14aafab0 CR3: 000000007d1e6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 az6007_read drivers/media/usb/dvb-usb-v2/az6007.c:138 [inline]
 az6007_identify_state+0x97/0x310 drivers/media/usb/dvb-usb-v2/az6007.c:865
 dvb_usbv2_probe+0x4cc/0x3e50 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:947
 usb_probe_interface+0x300/0xa40 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         d69eb204 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112dc962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b271b97d244fd0a
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c9c962580000


