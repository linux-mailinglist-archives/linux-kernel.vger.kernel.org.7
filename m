Return-Path: <linux-kernel+bounces-838840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F396EBB0417
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576481C6187
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899632E6CC0;
	Wed,  1 Oct 2025 11:56:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C22E6CB5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319765; cv=none; b=eX8GE7lU0Uujg26EHHOKNDjKvYhMJqexutaNi6UY+otprETdopXBP1a6wsv7zsljFg589xPPiEVgVShG9JQZwfSUYMkrBRSYrKjk96zzqhdfv7cEAJPcXv+UuS82lHS8o41AcNqXdazkQpYYzY5LuxpOo0tAOMcLtEQYq3NpzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319765; c=relaxed/simple;
	bh=hQpF1Iqn3WI6D3mtWlGaWw4TQCpOGsrjtU/m50nTA1k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FpxtLHzEjevKxbTwubOB4RBOfZquJ3gG4v0TMq/8p+kdHOp0Nfcbz4NznQl7p3izVnIbHSoYgaK2gSXj/MuzC2BWg7oAG1L2SJY5xzFPFRu4XREIPWezYtG3L1O0OCp50CSJavGzrcTerNdaTEmV8oT5Yy+sICZqwqaVnD4q39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-426d38c1e8fso65484065ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319762; x=1759924562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCLzBHJe2tcPS2MXQSPvQiBSPpx7UXQuJ6D7zzszeUM=;
        b=mWYICxwidMmWlQotAv3t7DgKLftUOgEvcghoiQsOoEzLCpHXG+GePaymla1+KBM7n7
         crBIbZppct5/F/2g6f6nDWysjHHHKDwS5ZL/I/1CFu4V0vFhmOUJjqg0CZzkrm45yV39
         THR8pZYr7FMryLPJdaFOtJdRlx31fhljnfMRnBZ3Bgk5Y8YIRwkiQUvttYKn0ncjnzoB
         rP3daNRBcz2ZNW92+j2h1dtKA8C5bRoc1sIVy8Dm8JxiOgPR8qXFCMrVQhpkGkWCTAI5
         5Upg1HfIuiryVxRJ0448EqF+GyyA15WmdO7irxPzvMuN7iA3A6P/0B6iKVRk1aTZrSjT
         4+yg==
X-Forwarded-Encrypted: i=1; AJvYcCVYj/ehaKz7uWGfMTTitKr7Cr/3r9i0MfFctYTc+hKeAuAmyD9Kaa5C81JTI97sDnGkDybxg24Y653LG9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuheZgzax978RQFoeZ5bC16vP6KIy/g1MHjYS5Ptiaf6MX1UM
	AOoRtmOB+m1p3+hwkXLcyp4aG/pd4qr0h4xpgR8IqwLOmu7rpeoptgvrWmyaw3+b9/RVPVICR3t
	rA2RnO+FCb9JXBH4I+EDyo11kgC816w3hU4R5ntpM/+e3F8eN3znIO2L+JrA=
X-Google-Smtp-Source: AGHT+IFveMTsVpkAlSbv6DKc3s1n83Wb3r0QG0NA3r5uVlqM5OyOQhqs6Y+xrWV8wyAVkAZPkzN+u2F6ZBWn3rz/r3RQJrBavM6W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180b:b0:42d:89e7:7f94 with SMTP id
 e9e14a558f8ab-42d89e780demr2643605ab.28.1759319762634; Wed, 01 Oct 2025
 04:56:02 -0700 (PDT)
Date: Wed, 01 Oct 2025 04:56:02 -0700
In-Reply-To: <20251001113745.7851-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd16d2.050a0220.25d7ab.0775.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __ns_common_free

------------[ cut here ]------------
ida_free called for id=986 which is not allocated.
WARNING: CPU: 0 PID: 6550 at lib/idr.c:592 ida_free+0x1f9/0x2e0 lib/idr.c:592
Modules linked in:
CPU: 0 UID: 0 PID: 6550 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ida_free+0x1f9/0x2e0 lib/idr.c:592
Code: 77 f6 41 83 fe 3e 76 72 e8 d4 eb 77 f6 48 8b 7c 24 28 4c 89 ee e8 07 39 0d 00 90 48 c7 c7 e0 cf cf 8c 89 ee e8 a8 c5 36 f6 90 <0f> 0b 90 90 e8 ae eb 77 f6 48 b8 00 00 00 00 00 fc ff df 48 01 c3
RSP: 0018:ffffc90003f0f990 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff920007e1f33 RCX: ffffffff81796528
RDX: ffff8880272cdac0 RSI: ffffffff81796535 RDI: 0000000000000001
RBP: 00000000000003da R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88801e6db000
R13: 0000000000000293 R14: 00000000000003da R15: ffff88801e6db078
FS:  0000000000000000(0000) GS:ffff888124e79000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2984627286 CR3: 000000007e5e2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __ns_common_free+0x7d/0xa0 kernel/nscommon.c:80
 free_mnt_ns fs/namespace.c:4096 [inline]
 namespace_unlock+0x7f9/0xa30 fs/namespace.c:1701
 put_mnt_ns fs/namespace.c:6135 [inline]
 put_mnt_ns+0xf5/0x120 fs/namespace.c:6126
 free_nsproxy+0x3a/0x400 kernel/nsproxy.c:188
 put_nsproxy include/linux/nsproxy.h:107 [inline]
 switch_task_namespaces+0xeb/0x100 kernel/nsproxy.c:241
 do_exit+0x86a/0x2bf0 kernel/exit.c:960
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x7a/0x100 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x419/0x4b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc7c378eec9
Code: Unable to access opcode bytes at 0x7fc7c378ee9f.
RSP: 002b:00007fc7c461c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: fffffffffffffff4 RBX: 00007fc7c39e5fa0 RCX: 00007fc7c378eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000020000
RBP: 00007fc7c3811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc7c39e6038 R14: 00007fc7c39e5fa0 R15: 00007ffe2b65def8
 </TASK>


Tested on:

commit:         50c19e20 Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d95d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b28601618dc289ee
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1292e942580000


