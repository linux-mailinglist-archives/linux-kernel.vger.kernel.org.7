Return-Path: <linux-kernel+bounces-896311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF7C50159
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3D4189BDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469DE2F3C32;
	Tue, 11 Nov 2025 23:44:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240E2BCF6C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904644; cv=none; b=W68zUBm/uRYtSfA1wCfS1s1pR1rChjRvkNf7ljaV1lqu5bXcmbepSqZZqhuqC7FuC6m+jMPHYVDZaG1sbJnDDBdlZ++0haaMT4YlOb/9gt7ipZkMWdJehjHDnPlX9mNJ9+dFcPz2oMWfxHk+IPHd9S0PrNSKO/y1WRc0mlKrP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904644; c=relaxed/simple;
	bh=CwEesEC/12X3OvDD5SaQkyfqiFr9S54g0smR3XV0R20=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EKmukC4s/yVJji/OxOcKssVx0WNYkehcznMSEiVktmf9LT68nXU0cu3SDCNgQpnXNUE+jaAnu+Zb9RGFvRUcAcC/eD+VYoURinGaDfVH0+OKzLJc7dBcnarLGpT6sJKVpLzNdp6/F2rgPAV8mlNkqeN6S7rlMbmcTT4NkPzymlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433770ba913so3699765ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904642; x=1763509442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kf9agNZFz/CvU62Ok8ffTm8G36mUe1l4lS+uQquTus=;
        b=gW5WObQ9Grmg1WiHYeVk9oIpkQZPTqks4hNVQDJ76lkVRYsbjgmlk/3ATnq5qzjwtV
         aWUz+rHLFNq9n/ODcpfF9iMzmZTWUZ8lT5aBQpvjKwnPex5fddrc17jjUo+n4aHlPSLv
         vn5TG9E1pxGN4QkkGFaRdFTcnCgbKfCTc6HV20PAnpmsnNTDgXqcWGYZaqgnA3HcHPuZ
         +3sjUk55L+A3KsGemj5GlD8phaD+1eKgy3ogdvcPyQq563ugPt/HVgwEJTPybeu3y2vz
         rY9aixXi3Bu585f1Pnj2QuMYFO4ZKWiPajsRBsEuJevMVkqVUT04ADH2OL16KBWGA5yB
         uJMg==
X-Forwarded-Encrypted: i=1; AJvYcCXrESrNC1e7iZa3S0tHl2Mk4SqKy/XXJfYObFvYOxpqDSmKMJIsCzveCGmNhxVDZQCNVB4yUAv3HODJ5Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2/NSoZryYcd3ttHXgkEkg9/4xoXqWhLuZajU+xWfUmzrxpPX
	DSF58SDdkaEdOVHvlE8Wxuo7SDWh3BtmC3UFg67/JLn9fDtKSRB4J5/hA++O46XEw99iSTBpd+0
	OFd/uoovytfABTx/iYmdB8TAGlYe52gPnVKxVmg/xEvYZ8VAsW99WvuhyJoM=
X-Google-Smtp-Source: AGHT+IGCqQNjL6d62SCIJF6kuJjEKm6niox1ofrOgRPZ67707RrEOTD14Pv8RgwMJjausvyhgTrnbAljHDtCiKsZXS8GhBCLvPFQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8f:b0:433:7a2f:a414 with SMTP id
 e9e14a558f8ab-43473dcf6bemr12526915ab.25.1762904642497; Tue, 11 Nov 2025
 15:44:02 -0800 (PST)
Date: Tue, 11 Nov 2025 15:44:02 -0800
In-Reply-To: <20251111232728.9139-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913ca42.a70a0220.22f260.014e.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (2)
From: syzbot <syzbot+a72c325b042aae6403c7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in tracing_buffers_mmap_close

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6465 at kernel/trace/trace.c:8780 tracing_buffers_mmap_close kernel/trace/trace.c:8780 [inline]
WARNING: CPU: 0 PID: 6465 at kernel/trace/trace.c:8780 tracing_buffers_mmap_close+0xdd/0x130 kernel/trace/trace.c:8775
Modules linked in:
CPU: 0 UID: 0 PID: 6465 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:tracing_buffers_mmap_close kernel/trace/trace.c:8780 [inline]
RIP: 0010:tracing_buffers_mmap_close+0xdd/0x130 kernel/trace/trace.c:8775
Code: 75 46 48 8b 7b 08 e8 92 94 ff ff 31 ff 89 c3 89 c6 e8 e7 4a fb ff 85 db 75 0a 48 83 c4 08 5b e9 99 4f fb ff e8 94 4f fb ff 90 <0f> 0b 90 48 83 c4 08 5b e9 86 4f fb ff e8 51 f9 62 00 eb 87 e8 7a
RSP: 0018:ffffc900033a7980 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffed RCX: ffffffff81c108d9
RDX: ffff88802f3b0000 RSI: ffffffff81c108ec RDI: 0000000000000005
RBP: ffffffff81c10810 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffed R11: 0000000000000000 R12: ffff888046203408
R13: dffffc0000000000 R14: ffffc900033a7a08 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124a0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f36505f5f98 CR3: 000000000e182000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vma_close mm/internal.h:190 [inline]
 remove_vma+0x88/0x160 mm/vma.c:464
 exit_mmap+0x50a/0xb90 mm/mmap.c:1305
 __mmput+0x12a/0x410 kernel/fork.c:1133
 mmput+0x62/0x70 kernel/fork.c:1156
 exit_mm kernel/exit.c:582 [inline]
 do_exit+0x7c7/0x2bf0 kernel/exit.c:954
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1107
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x85/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x426/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3650f8f6c9
Code: Unable to access opcode bytes at 0x7f3650f8f69f.
RSP: 002b:00007f36505f60e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f36511e5fa8 RCX: 00007f3650f8f6c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f36511e5fa8
RBP: 00007f36511e5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f36511e6038 R14: 00007ffdf110f910 R15: 00007ffdf110f9f8
 </TASK>


Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13370212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=a72c325b042aae6403c7
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135b560a580000


