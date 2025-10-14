Return-Path: <linux-kernel+bounces-852326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5EBD8AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4791921646
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294042F1FDF;
	Tue, 14 Oct 2025 10:12:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653E16F265
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436724; cv=none; b=WfsLUmnWvue2BAWYejqvRtdVHgQtfb2Vw5sOK59dVVM2cgD0BRFjQrZYgU45HP0Loba2IUZ53KVZ8Q3+1oIIjQTbx1nLap+SxKbTBE1zIK0ilJuODgn2qG6FQpPX3dhHtfOG4GG+lI/WuV4WUeryOhpMl3pGFNJRMbV16VTNlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436724; c=relaxed/simple;
	bh=x61QW4kzmftxBHmAc6TdG6TS9yjRvO05UBAv0qm3sOs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FnTA+dRDpZDZOh48uGZXEZclUR4mStjqyAZUl9hWB31lrTj7vALSGhXVmKUFjrls27/Jtqv3s6oSsgASJanmQTG+e+UBRb7fKQyNHj19TCNtLD5X6gf58K1q6S+ZWGZo2Ha3BboC2w2EKFXuJ+SywXQE/DhMLiNEoigqWqijoG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so136387585ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436722; x=1761041522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+qAupZMIqHmt08Kkm4jQVLtpL8YEkNSn+2yelvzKqg=;
        b=ojfZeOY8DpNKdlzhmO8GqP6b5v68MXf4xI+5e46rD/mmCfjdKS1ajYuOS6SxNlLCx1
         aeDtDnskxw5/urfcAYldDSE4mB8ETbUdjHAQHc+twzg/9i1gF3TQfaAM8RyXLlxTFu6l
         jnLUkwuemQ822lFYtAxJz+zVFa/pEKGlEcnOjQbv/BiW9DERnndiuG/icZXfH0+BNwnO
         RlmXEkKaecC2JhLTvRhFpvpAfpu2v2LEWB+YfvAAkHGYZjotRdJNiz0bjtPsWYLHENU3
         zrXbCWfDUPxDUlHj42m51EnA32oC+6Zc+05eOwU+b+0yXnWIfhXKpTF740DOQPfB8njo
         RUvg==
X-Forwarded-Encrypted: i=1; AJvYcCV5I/6g0AWMrMgLmWyYa6yRgurAfowq3LFvUW32M9wJh3w3WX2Iv2SSRAKCf1O7Zhl/xtbweLlf8woW34o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2L35i7ulcvuyi56PS8HLLwv10ekJwTtLGcoo1/TElpayyR6Dc
	R+GYdBb+06Xd6aL3AnuqzAWs9KhEDw6SfYO+HFWnxTqq8SwJoECC9QVSt0YIGhvoTyfRmz7LBSO
	15fS7DH7SezIhd81XTk+cVWFBYRrcx2x3wO7fvuucv5blNPi+N44bNoXgndg=
X-Google-Smtp-Source: AGHT+IG/r8b+nU4EVrwP64HnbS/kpRxkeFCltahAWnKjQDxZ6kYv8aH8eKEK99rtjDNN8qGu1IUtLEHl8ec9mS1ytT0bB4cWyKR7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:42f:9e92:a448 with SMTP id
 e9e14a558f8ab-42f9e92bb89mr141617255ab.7.1760436722398; Tue, 14 Oct 2025
 03:12:02 -0700 (PDT)
Date: Tue, 14 Oct 2025 03:12:02 -0700
In-Reply-To: <20251014094307.630590-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee21f2.050a0220.91a22.0204.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in ntfs_setattr

ntfs3(loop0): DEBUG: deepanshu  Read inode 2, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 6, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 8, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 4, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 10, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 9, S_ISREG=1, run_lock_init=1
ntfs_setattr: testing by deepanshu 
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6558 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
 ntfs_truncate fs/ntfs3/file.c:483 [inline]
 ntfs_setattr+0x71a/0xbf0 fs/ntfs3/file.c:807
 notify_change+0xc18/0xf60 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 vfs_truncate+0x493/0x520 fs/open.c:118
 do_sys_truncate+0xdb/0x190 fs/open.c:141
 __do_sys_truncate fs/open.c:153 [inline]
 __se_sys_truncate fs/open.c:151 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:151
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8c2e81eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c2de86038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f8c2ea75fa0 RCX: 00007f8c2e81eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007f8c2e8a1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8c2ea76038 R14: 00007f8c2ea75fa0 R15: 00007fff37c0d8a8
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10785542580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d905e2580000


