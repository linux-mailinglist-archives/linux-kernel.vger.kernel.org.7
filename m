Return-Path: <linux-kernel+bounces-887616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6971C38B78
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53F21A2355F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DE1D130E;
	Thu,  6 Nov 2025 01:36:32 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805B1EF36E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392992; cv=none; b=b7tzmTfr+RIoub+y53rhFSg/5W44zJn8PslIoV2fK1kBdN/608Boept1PPoeVFO53pLc7osZzDhFz2jch7/HGV/6RAmNmGoh4yVF8Cpmla5wBc9LReV9tFqY/NovJQp0JP0nuQh7RD5DkdjqFmv5fsdaMOr03Mj0B7mJfYiTfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392992; c=relaxed/simple;
	bh=ji9DEGwLGnha8J+WeoMZ5HkWgPZh+7ycy0WAEwuT2fA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T7WQW/0dgcoyIhKSzbtDn9mWMo9+3MvLuWpV8Jyqb65eamQqRSqXHJTppg/HoaZgHkmBbuC4Bb6hG+E9uIU/e+qmqBUvqKA9OR+lWIQu9dxtig+KcoPvlQGmS++IaLxLGLkYe13Z1JNIXRuXx9N6itE09qKjsE59j8KSmCLgDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9486f0954daso85653739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762392990; x=1762997790;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R340o1UiR9B+9AGjn2uABaVNuldshx+jNJCovlLrrGw=;
        b=XeSedLRmvlzexh3lHVp/ZrhP1zOr8hgThSb1NNlrmT7QpendA8mpQZxi7L2JlmAyNb
         gNJK6OMnK9Qf5Um6+rLpn/F60K5Qd+o+CZB6TI4NGvFNmCX01BCag/nYqKJ1ferJv0ek
         xYV55m1IVYiPc7bVHgwddVMMUd4ygqVmbW4daGJBXVB52p1yjFg0r4KRcoPSCY8AIZPV
         TwvrDsNZx7jzHqz6O8icdZ3ZSD/Zob9YpxVMQTRTjJQGGi74h//VLNOR4fcztC4pac3Z
         gn69s/31EhN4R/6LLbFOuEiJ5tEjKbSY3vEidOkQn32q32R1rQ7RNznVDZ03Avlpcy/s
         N4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWlV2Wu3ytsjVpGAnZDr3TBWbEJpmQ62dSK81gEEVcq1n+oVu0q9PjkuPAgxZ/F96Bln0G3MoixjauKwzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBlFY/L5Vk7+RkLzkeUFlQSmesF8GUKRbVTDY9XuDFqQ1g5JN
	4fraV8xu44o7C7vPcilGrDr30l7QX3pGNzPUDaoUSZy6YUpJCgghQIHQ1F9jNXc2FiY61QCJer5
	iLzeR5A/pxg5hs6acAVUpn9vsG8TgTQYvMGQy9FyXTfrES3pJ4OkgZBx4hUA=
X-Google-Smtp-Source: AGHT+IFReihuyYU4BCH+Ov1aj7W1fIb5L6lil8IpnBef5+mq3JWw0Audvts4uztlVvgQjx2NnhLa2cE8XHwMHFSWWAJ08PZPoG1h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1606:b0:433:34b5:37bc with SMTP id
 e9e14a558f8ab-433407d4e88mr76669285ab.30.1762392990098; Wed, 05 Nov 2025
 17:36:30 -0800 (PST)
Date: Wed, 05 Nov 2025 17:36:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84d39fb9d529 Add linux-next specific files for 20251105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122ec0b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=413cf24e78b667b9
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e09342580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14126114580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49de85e8d717/disk-84d39fb9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4fd90ea7659f/vmlinux-84d39fb9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/235e0ee874fe/bzImage-84d39fb9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:311 at __ns_ref_active_put include/linux/ns_common.h:311 [inline], CPU#0: syz.2.29/6060
WARNING: ./include/linux/ns_common.h:311 at nsproxy_ns_active_put+0xa19/0xd30 fs/nsfs.c:707, CPU#0: syz.2.29/6060
Modules linked in:
CPU: 0 UID: 0 PID: 6060 Comm: syz.2.29 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_put include/linux/ns_common.h:311 [inline]
RIP: 0010:nsproxy_ns_active_put+0xa19/0xd30 fs/nsfs.c:707
Code: 0f 0b 90 e9 71 fc ff ff e8 54 52 77 ff 90 0f 0b 90 e9 ab fc ff ff e8 46 52 77 ff 90 0f 0b 90 e9 41 fd ff ff e8 38 52 77 ff 90 <0f> 0b 90 e9 64 fd ff ff e8 2a 52 77 ff 90 0f 0b 90 e9 98 fd ff ff
RSP: 0018:ffffc900033f7d38 EFLAGS: 00010293

RAX: ffffffff824a1b88 RBX: ffff88805876a750 RCX: ffff88807e148000
RDX: 0000000000000000 RSI: 00000000effffff8 RDI: 00000000effffff8
RBP: 00000000effffff8 R08: ffffffff8e36cb4b R09: 1ffffffff1c6d969
R10: dffffc0000000000 R11: fffffbfff1c6d96a R12: dffffc0000000000
R13: 1ffffffff1c6d955 R14: ffffffff8e36ca80 R15: ffffffff8e36caa8
FS:  00005555653d3500(0000) GS:ffff888125a8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30163fff CR3: 0000000076924000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_nsproxy+0x26/0x560 kernel/nsproxy.c:190
 put_nsset kernel/nsproxy.c:341 [inline]
 __do_sys_setns kernel/nsproxy.c:594 [inline]
 __se_sys_setns+0x1268/0x17d0 kernel/nsproxy.c:559
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

