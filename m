Return-Path: <linux-kernel+bounces-852077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F561BD81DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FD33E2136
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900D30F80F;
	Tue, 14 Oct 2025 08:13:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF330F801
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429585; cv=none; b=FYqWJ6WMnDTC/JUmC4tFldS0g2t2ct4f/yOjeqZ2tS9PkBNYX7lFWvR3G9BqYNTu6QgRo9jqS1qk+d+jpEMacLylKPIcxctYaDrIsTH+iuwwXtHRziLIHfisubO486ic388fqgpRNTgBYrVm4BzvoB4DLC3cxNeLgnz597gWu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429585; c=relaxed/simple;
	bh=6N513xROsvvh5e2e0DAoKgDt1Oq7bPviK7zr9uVEMQM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DWDIgke/kX7pNytzr0emJtLsmcwsmLklo5YuuSKXrKOHouZtzghroigpGQBILi6Cww0LZ+2m5BPwp8+uNHes2WCD+SaULpLqBtuv6Y+IAd6tHvmAT0H2civ4nuP4uJtSMYmJsctS/5S+7IWlBF0xPs+i2/hDPblL5TLkz2KKlvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8ea63b6f262so2646514739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429583; x=1761034383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0DUz0ob4uGKY9YXX7HYDMmrHVIhWb1oSkG5Sfxx0o8=;
        b=AELPlj9dkTgaRbPLKJwIq43QRyNBJpeIGIgiI3FJEnwn19uH47xiPLbaOZ9euTVEA2
         UFT/ZmqbDU4Bt16AsZz2/hE9n6BaI5W6KSlTTKPwPEb6/P0JSyXTefVMAJZFOaqOvrn5
         WPugENnfc2NDXgyy+3Re4J/kbiLD0Y5ZfT2BQquxkNzGNb8Vwr8XsztuDu+cDCdoP68R
         HPA3+MjM1udjEJB1V0VStD7aiWoyMcdZjB5VF3KwgE4uJBYw4md/TqAF0Kg+TDHuum3T
         jWJlR+XamvLKMkp/FDWAUoKn0aCqBstBEJCzXrmiUzBmjqdXlR5wwyggeXEv39vVhh/w
         uOMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhFdK17EWEzzTZFQHu41lK/LPBxESMnus/lGRRhoZzRmqZ7n+mJ/CQD4LzYH4r44wfw9A8Ef3Zl4Opjwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaB0KOqY/W5s7WDgeYiDIxyzufUk+XH96/vnA2OShCtsLbGYUB
	4/dOyJDtPy7xG+FmFB8JrvYZlzJs/XLfstQfFlNAZipsm16A5c/Tmx0zU/4RBoFC03FRQfDNwDq
	6NUwKZ3McluaCtL0TDG9alFVfx0eRBaqy+e9YdWLkwoSAQzH+eocM6TPwuGk=
X-Google-Smtp-Source: AGHT+IE1+7ibkaPyMYsehzU79A6Sh1WuqR281OsSnBQdY1BCxVC0DF26q0SrtFcOEYD3pnltTGL2YBZBNP7033LuLvbNPq57u9Zw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:42f:8b46:bc5f with SMTP id
 e9e14a558f8ab-42f8b46bf0emr272969455ab.17.1760429583456; Tue, 14 Oct 2025
 01:13:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 01:13:03 -0700
In-Reply-To: <20251014073834.12992-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee060f.050a0220.ac43.00cd.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in ntfs_setattr

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (4096) and media sector size (512).
ntfs3(loop0): DEBUG: Truncating inode 25 (MFT_REC_MFT is 0)
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6662 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
 ntfs_setattr+0x72e/0xbb0 fs/ntfs3/file.c:812
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
RIP: 0033:0x7fedf2b5eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedf21c6038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fedf2db5fa0 RCX: 00007fedf2b5eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007fedf2be1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fedf2db6038 R14: 00007fedf2db5fa0 R15: 00007ffc4a35b2f8
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c615e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161c25e2580000


