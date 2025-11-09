Return-Path: <linux-kernel+bounces-891918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DDC43CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5258A4E5B74
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3F2DF151;
	Sun,  9 Nov 2025 11:56:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36634D381
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689365; cv=none; b=lfAZ4cFM5/yMKEwFZ/TtwR4ILY0Ks0XuSHjUQXMsaOJA1Frl6VQRX/K6LloaWeT1/8RIacI0qawXg9b51Xjj+TvdIme9jYh6cRQlh7bVWXnKxhtm7qan1TsnrNcm593mo7u699fEYBDNUHAK1YP4qS5BdDt9CeupxXlxiSbDVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689365; c=relaxed/simple;
	bh=/bj3qEqN31FjR/c27t+2EUaE/KpO0NS/K7YM+caLCWY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UzLIt/9iT2AFCJwC0/fGNXNIBqB8+ZbUsg8F/VafDCDAdfnjETwEVrF+TYF+3QGL8TLQvvvxcp203nb2q5yG7O0XIKE/zpPUN5QYmp9biY2+v+pYu3iivLRyNiwBMDxBu+DebnOEF4Ec7yvRJvW2mw54scL5o+G6jxc0pOMsP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e8092427aso188361239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762689363; x=1763294163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvUMklVDCGDNC01F3/2s9iTMy6YaK3hCreJGjiWo9cQ=;
        b=Pw3sdlD+p5G71HzPpbnNm2KM4ROZVRkhEMjWmfVurwUYxgF1Zc5rbX2tYUVSn5NZ95
         HIQtFH61LEMricmUmi3oPNMKuCzgZKbqq0C/OJpaic1qimLVd7X4E3+Ep5v6xPCPI+qq
         C3fcoOPWQMrDsvJaQIOx2QxGEZDxo4oWtoFfcj7nt1prP/ntuE4hVacuSvbZ5Zc+Svoq
         cQWD6k61GqkeZ74sSmjCv9DcR6bxk3C6RVPWt32dUrDluVoCoq02V2aIDM2mFT11SwR5
         boC7/3FGwiyty4wooAb3Hp1Yhus8Hh2zutoIiCcVC8tTwASsnwspQkN6nMmFrr6w2Oz2
         LFbg==
X-Forwarded-Encrypted: i=1; AJvYcCXuD1+9ZPOhWQLJiEyNDU2T83GcrBOxquYzeiU6cu7cvXaRGvExNluUrTvL/ylrxPQuszX2yL/lD6ha0As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72KCVwCMj3O/cNiwvp9cB9ZFu700W5jO3A+KFSTZ46EiIMmh0
	+k1ZgeTOr4dzvcVgW7AAWq8CP8BSQ75aft+ZRpuzTLzcPY8p3H0uoXf/n/2QG0Ym0ytenypNpV7
	+HDw/ZDbgS/CBCHKwOG5fcJmo/mbeKV1x0fnD8E+tBOwfEksjXTyDjjuJSds=
X-Google-Smtp-Source: AGHT+IGfYEFzAO3GhCHg63mIv6z5JkB/fsaEJyxQSNzkOsc4b5Myse2sD/FXS/pdFhlHl89VSWZwJsts/9L0xGJz+VLmCX0CLoY4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:433:2943:3a78 with SMTP id
 e9e14a558f8ab-43367e70f05mr64555895ab.31.1762689362878; Sun, 09 Nov 2025
 03:56:02 -0800 (PST)
Date: Sun, 09 Nov 2025 03:56:02 -0800
In-Reply-To: <20251109114011.1100867-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69108152.a70a0220.22f260.00ae.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in swap_cache_get_folio

------------[ cut here ]------------
WARNING: mm/swap.h:87 at __swap_offset_to_cluster mm/swap.h:87 [inline], CPU#0: syz-executor/5541
WARNING: mm/swap.h:87 at __swap_entry_to_cluster mm/swap.h:93 [inline], CPU#0: syz-executor/5541
WARNING: mm/swap.h:87 at swap_cache_get_folio+0x365/0x530 mm/swap_state.c:94, CPU#0: syz-executor/5541
Modules linked in:
CPU: 0 UID: 0 PID: 5541 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__swap_offset_to_cluster mm/swap.h:87 [inline]
RIP: 0010:__swap_entry_to_cluster mm/swap.h:93 [inline]
RIP: 0010:swap_cache_get_folio+0x365/0x530 mm/swap_state.c:94
Code: ff 31 ed e9 2a ff ff ff e8 98 22 a1 ff 90 0f 0b 90 e9 3d fd ff ff e8 8a 22 a1 ff 90 0f 0b 90 e9 44 fd ff ff e8 7c 22 a1 ff 90 <0f> 0b 90 e9 6b fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 3e
RSP: 0018:ffffc9000cb6fa40 EFLAGS: 00010293
RAX: ffffffff82206d54 RBX: 00000000000001ff RCX: ffff8880003da4c0
RDX: 0000000000000000 RSI: 0000000000007a12 RDI: 0003ffffffffffff
RBP: ffffffff99a78920 R08: 0000000000000000 R09: ffffffff82158099
R10: dffffc0000000000 R11: fffff9400023d3cf R12: ffff88801a839800
R13: dffffc0000000000 R14: 0000000000007a12 R15: 0003ffffffffffff
FS:  0000555569d2f500(0000) GS:ffff88808d2b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555569d49300 CR3: 000000004ffac000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 unuse_pte_range mm/swapfile.c:2282 [inline]
 unuse_pmd_range mm/swapfile.c:2332 [inline]
 unuse_pud_range mm/swapfile.c:2352 [inline]
 unuse_p4d_range mm/swapfile.c:2372 [inline]
 unuse_vma mm/swapfile.c:2393 [inline]
 unuse_mm mm/swapfile.c:2411 [inline]
 try_to_unuse+0xd6f/0x2ce0 mm/swapfile.c:2488
 __do_sys_swapoff mm/swapfile.c:2884 [inline]
 __se_sys_swapoff+0x431/0xa10 mm/swapfile.c:2824
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f728438eeb7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc54ebd478 EFLAGS: 00000202 ORIG_RAX: 00000000000000a8
RAX: ffffffffffffffda RBX: 0000555569d492c0 RCX: 00007f728438eeb7
RDX: 000000000000002f RSI: 00007f728442e70b RDI: 00007f7284412bc1
RBP: 00007f7284412bc1 R08: 00007f72845b7d20 R09: 0000000000000060
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f72845b1270
R13: 00007f72843ec1a0 R14: 00007f72845b1240 R15: 00007f728442e698
 </TASK>


Tested on:

commit:         9c0826a5 Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11fe3084580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3983c6ffb8f8b6b5
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15356a92580000


