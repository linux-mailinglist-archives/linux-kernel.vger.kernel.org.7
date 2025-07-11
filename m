Return-Path: <linux-kernel+bounces-727541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F421AB01B96
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46569162304
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586EE28DB46;
	Fri, 11 Jul 2025 12:13:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D128B50A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235984; cv=none; b=TbEGLN+9hlld26hBIQFZPMWlZib5O4g1hbxmGwuOZZYoiDrZbh6+k2P4cYgRyxZMjEox/L5x3J7Y5pPRAMi/IC1gnTqI+b2C3QdHZIErLJ58ssAhM/tIWkhyQvBppJcOUP1V0D4ZeZ6TFLE3JWzxrPCmaV9do3T0byZPB8/4C/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235984; c=relaxed/simple;
	bh=v0OljHSnakCOhxpNTS3lTwHOWb2rp56iRLcP6Hj41Dk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ddUaQP1/WYgO+k4IwJPI4EQdnRROOSmEkOeX0i2V0X6jzPtMtEPISVoORD23bDJx3qaHwIfr9dmBtk1m8etmYfGW3kDeO1ApLDXnzTFPvfpWkLd5qyafEcQ6SZWuK8jPmb4Jrb0R6VZsGHxZzCld3Rl/SBXu2c5cc+jQFjhgFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-876a8bb06b0so384167539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235981; x=1752840781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLpdtuuPAWTV+G1U5ZHdkKu+NsbXKKQrMVwGFs9NFOU=;
        b=djeOsqxtM+w1iyea+NRGK4kEAkq+X2SpkJDY+CtfSRLYqDmwgB2uM332B4sCQRg06+
         lJUgQ7+/YqtkzrfUSLDqnZVGfR7828PPuwy7s9G1Fb8msBdo+5XSWJJU1SieGE4hJpCC
         7zOjqR1tXWb1n4Blu80ZqUv0xqXjRVb/ot/nRL6xr2c7FBH6Rj+VsCdaCKjtYCgjvlAu
         LpKSwypr740hKtYIszo0izkifqNC0TinNhITYX41Mnxh9vKXjvIeFXmTJ/d/BqHgRKBW
         2dTZdeRUJsTy2yE3+Pfh/OQKjdQ3N8RMyiRlvqzXtCYAyh0bCSrO9GQjkV+/DWl6fZFP
         p2Ug==
X-Gm-Message-State: AOJu0Yzb0IGNT0t8TCAc2lFjf/Qq7g9x8aboZ3dtwXr1HJlQIotEDPdV
	oPEH/n7BW/JkKvLGIBHmbXfxoNqWew9VLPBVaPkIEd0tBJWGfFM6y0Rs/aOSBMgaXlXPdhhrj/P
	ALE3onSYAceccmz/sruU+fjnMUVB+LMk2tA+IJsYeKKxwmab/zaf1zAB7Ph0=
X-Google-Smtp-Source: AGHT+IE2XpSocY7JmByDX6UwCcy967w4a7qAY2yCjpkuN22f3VDzOgWyYULZUZHTNtjUfJuDib4BYpaENNWNT2ejXFtD/xEQjcj5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7504:b0:864:a228:92b4 with SMTP id
 ca18e2360f4ac-87977f85cf1mr387135739f.7.1752235981570; Fri, 11 Jul 2025
 05:13:01 -0700 (PDT)
Date: Fri, 11 Jul 2025 05:13:01 -0700
In-Reply-To: <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6870ffcd.a00a0220.26a83e.0048.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in usbdev_ioctl

INFO: task syz.2.18:6951 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00121-gbc9ff192a6c9-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.18        state:D stack:26472 pid:6951  tgid:6949  ppid:6668   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x65d/0xc70 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:884 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2611 [inline]
 usbdev_ioctl+0x140/0x20c0 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b3f58d169
RSP: 002b:00007f8b3f3f7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8b3f7a5fa0 RCX: 00007f8b3f58d169


Tested on:

commit:         bc9ff192 Merge tag 'net-6.16-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8dbd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1166668c580000


