Return-Path: <linux-kernel+bounces-852541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F74BD949C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648CF3A8F65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1115312814;
	Tue, 14 Oct 2025 12:14:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F429DB88
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444049; cv=none; b=lMy4m8s1AE0P3uZBkxz9kEJsyNJTbJ+fGuE7XlhvAMfJGQGPisbQgyX4tAfwB72/9qqjQb1xYAu/xu3869Y67S+E5liEcJCVLnlAp4EEhzxaiclY2FcnQMIQIEBlXN6nvIEoIJM4BGSTITU3kUf/cggBF5Nu2O/1zHwovd5NEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444049; c=relaxed/simple;
	bh=2sSzVoEej2jW/r3/sRECPAdU09GWnha+jUjMSPgGpZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J4YgU6DND4t/wr9OMVm0/Wb9S0iLlDuIC6v1ntEw/KwpJDtF4qwDXjueA5V8EQot1R88nowzQZMcINxH9EjVXFU13nmPDD4zbD6ehOnOR05CLFqroJOzAkhh+KNRkdjQDqHtZfGsIHT7VxWe95ufYfMH99lriCIXICHJ93o1XYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430a442092eso10847455ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444045; x=1761048845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoFDoaL6Dny4O13nxDAFTs6LxNfFNcAJkU1AQIBFb4M=;
        b=lXPur97zVA9PZzuuG0/PVX2SbBsFzZ/gDxMwCqOxhBabcT2F3sRUzux1+zs2gnKAmk
         RvpgSlqAYzBL6Oty4mMCtuGaPxRiJ/Pp/ip2hGNc5w8V2EsxoHy1a2opjnsMC3Aw7eec
         cL6nvmRF0a1Y6H+tE72kSqgB2sjQ6x6eTHQ1/BFKKDhmBYhcN5ZuRDc9pXyLQf685jOY
         tfmxfVE2052nSkFUvPvsA6as44nk0VHe7At6nQDCmI1lKkkt3zlanBJn/OZJeVn+/MmO
         RkSgWKFJ73zatQFsn/+oN8VSXs9xX6zFZAQBzsiW4K3kMzLrTkWMAR4tmZ9yBHi/eW1o
         /0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUi/sV9tnvNlGHeHf+2lHJKLQj4Ot/Ko3TP3c1SuhdjwZXtPVb9ovXIv27BPdNF/pTKdNailxFBc2lkieY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywff/tMa4nZWasaNBhkgmIzgevAewPoY7NCURR8FHMdl2RvR198
	UfFjp/hmyhnzlyq5YdupWwOAUubBSAZ1ePSzXK1FqK/9/gmxn5tncQoLl0+L/DirRdbR3rz1eYs
	ound9u65tnPTVkzI6Cg4al3S9ooqNf0N4/+fK+pPHUGdGHXGcdvQORsqlH3g=
X-Google-Smtp-Source: AGHT+IHzZ0ogkTIwD0h60rNR8VkQBVClhXt8Laj15gUpzClb6v6lVi5STVmyvQHeTGoIJ4rS3fsa/WRf/7GuSI64r95czHxJNKPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4910:b0:430:a65c:a833 with SMTP id
 e9e14a558f8ab-430a65ccde8mr10076475ab.31.1760444045096; Tue, 14 Oct 2025
 05:14:05 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:14:05 -0700
In-Reply-To: <20251014114858.637382-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee3e8d.050a0220.91a22.020a.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in ntfs_setattr

DEEPANSHU: ntfs_read_mft ENTERED for inode 25
DEEPANSHU: inode 25 reached end_enum, mode=00
DEEPANSHU: inode 25 is EXTEND record
DEEPANSHU: inode 25 - SUCCESS, about to unlock_new_inode
DEEPANSHU: ntfs_iget5 START for inode 25
DEEPANSHU: After iget5_locked for inode 25, I_NEW=0, i_state=0x0
DEEPANSHU: inode 25 found in CACHE, skipping ntfs_read_mft!
ntfs_setattr: testing by deepanshu 
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6686 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
RIP: 0033:0x7faadec4eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faade2be038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007faadeea5fa0 RCX: 00007faadec4eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007faadecd1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faadeea6038 R14: 00007faadeea5fa0 R15: 00007ffe8c5e50a8
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133915e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bb467c580000


