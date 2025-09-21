Return-Path: <linux-kernel+bounces-825963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E81B8D385
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 04:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D76482825
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6719597F;
	Sun, 21 Sep 2025 02:14:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C21519AC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758420845; cv=none; b=Q3v+5eapF7feGnXcQY+b+DQ2p7sHCcdCNFdPN/a75K2K7KadbqeWCgf8jnARmbCoIwKbFsxwPIMqnoDB/oUDd45YpMTsMJdvJ2aWGDC0LXaL0QCMsh9AdB9qCxNmXwNxFGZ0wxjIQs/yq9OGvNfJIXDcZhFxpQQxXvYCvrF4myY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758420845; c=relaxed/simple;
	bh=hf7muTCUqbRksybhCo1gbTg9UWQmA650h/pgK7sj2xE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I6DUuQrx4Lnz/16C9Wk+5steQzxtzSYf01Tv/PFg1ORrosztdLS/ouqwc3R0iM9z178ap0MYZOS31oMcfcz1iUD4Z3L9os476Ll3yPi3u/gEEh2zLlyfI6gHquwfhjoPYalca/7br05ORqj8wkE3Zpi5ln4FqYkkKsuZjVGNR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42574804553so1582315ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758420842; x=1759025642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBth2xJBkE/XNRiK0yQ6sDHQX9eT1PGzxZiWjJqzGac=;
        b=KPzcTU2eUGYlidqJSE7nR3t5VxsweeWUlmAIUDFMZcyJrTfE9ytQZ/vf27wJ6N51rP
         nCDBfHznvkJ8Iv2eN76ZdTXDxkhr2BehcuaR690UH086ls0Bxz51pB/pCnfGcWXzog38
         mMA17BltNjT+G+mXPpQMGS/a98ASIdoaFms2vrbBJJb8ygv49wmni5o0sLdkS6cbqLFJ
         Do65NVVhbCkOYXVTDF4jQbqkwEsMsstOXwBmFsxxDO00HE7touU4H5OiSyWfN/lKmUwQ
         zWCALrjcCe8tHRvwYnWRP8wS1KYrjQAmufcPuGzaL2ajJuG5CtdzmYUGQRayRlXPTd0h
         YpwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdl+RFm9WKfOxfLGO+CEo93totG7tg0liR+L+E/cjjQg/6kSr5Pwy0fIUfa/4TiaNrgT3zkNUKAYA3n6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvS5s5YAg9wtBSducWhICAgJJTkf4dqeJDJJl8P62f7uoDWc2g
	o0CKTOReA367U+Vf+thwf9Hj1WFulStkbgWq0LchMS+i6wFA8t+PkJzzttWG+Wm8eCksqUDSCLF
	RbSXuH0Zk0pF1A3zNHUuCnsi2p7hKBo6kEe76hcSXvWjK0xj0XJM0lZSUcWQ=
X-Google-Smtp-Source: AGHT+IGzL/P+MXCmkEGi5cX0/1+LSqaFnYHTJyxEupR/WHMul8DDTVtRC/by3Ty0MagQaBrokA8YuabbCzv0rW/mr7hPkMR2/XhQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1093:b0:424:8535:6512 with SMTP id
 e9e14a558f8ab-42485356581mr82612545ab.23.1758420842606; Sat, 20 Sep 2025
 19:14:02 -0700 (PDT)
Date: Sat, 20 Sep 2025 19:14:02 -0700
In-Reply-To: <20250921005357.786637-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf5f6a.050a0220.13cd81.0027.GAE@google.com>
Subject: Re: [syzbot] [nfs?] WARNING in nsfs_fh_to_dentry
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in nsfs_fh_to_dentry

------------[ cut here ]------------
WARNING: fs/nsfs.c:502 at nsfs_fh_to_dentry+0xcde/0xe00 fs/nsfs.c:502, CPU#0: syz.0.17/6525
Modules linked in:
CPU: 0 UID: 0 PID: 6525 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:nsfs_fh_to_dentry+0xcde/0xe00 fs/nsfs.c:502
Code: 5c 24 60 e9 08 f8 ff ff e8 2f 01 79 ff 90 0f 0b 90 e9 72 f6 ff ff e8 21 01 79 ff 90 0f 0b 90 e9 da f6 ff ff e8 13 01 79 ff 90 <0f> 0b 90 e9 1a f7 ff ff e8 c5 88 46 09 e8 00 01 79 ff 31 db e9 cd
RSP: 0018:ffffc90003007a20 EFLAGS: 00010293
RAX: ffffffff8247180d RBX: 00000000effffffd RCX: ffff88801bba5ac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000effffffd
RBP: ffffc90003007b10 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
R10: dffffc0000000000 R11: fffffbfff1fc9b6f R12: dffffc0000000000
R13: ffff888027365694 R14: ffffffff8e3df738 R15: 0000000000000000
FS:  00007f46068b46c0(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30363fff CR3: 00000000706b4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 exportfs_decode_fh_raw+0x178/0x6e0 fs/exportfs/expfs.c:456
 do_handle_to_path+0xa4/0x1a0 fs/fhandle.c:276
 handle_to_path fs/fhandle.c:400 [inline]
 do_handle_open+0x6b4/0x8f0 fs/fhandle.c:415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f460598ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f46068b4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007f4605bd5fa0 RCX: 00007f460598ec29
RDX: 0000000000400040 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f4605a11e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4605bd6038 R14: 00007f4605bd5fa0 R15: 00007ffed9ea2cf8
 </TASK>


Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ef70e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=9eefe09bedd093f156c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e888e2580000


