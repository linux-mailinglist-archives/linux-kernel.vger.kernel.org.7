Return-Path: <linux-kernel+bounces-852470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99933BD9100
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1524B1880293
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1230DEA4;
	Tue, 14 Oct 2025 11:36:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FA30C342
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441766; cv=none; b=qZ6nv7kNimU1WMovb/6QoZIAeasUzQxR/IEgSZr8CPwlLxgMrh1wyXpIOZfxOS8vz3QWABKc2fLun/PHt+7KXzlfaiQwzlIG+JzbRTejISOwIsC4p6NcEMoHk4ZmjF/3ozKsy9zoVPA2wY+GDojiyousqVykoI9gNFcgDQN9Sew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441766; c=relaxed/simple;
	bh=d09OMsT8pJ7O/avmZF3EzJlTeodXZS0qnYua8IT6fTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pmCK7C6UHP+D2IPPDXTvKTjlyqEd7mKfU0Sfl7z+l0AGGn0JKeHdJ1kXN60SoAv2Yrz3Po7ckN1O32ADppab1dpRHOqlSkIejykkXUXbHt1rYaEhcFvZiw5SysLt+a5w0cHJ4R8N3njqbcHTb21EomhZMe34sFzranl2q5syQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f7adbd951so302017825ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441764; x=1761046564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9THQb8ZvEJPdk8cXqgk/BWXWDfIu5WPSTCLXPzMF1bc=;
        b=lh5vzYsXble4bow7I1xlDycOZOmAKTXJH1Q75D4kGeBO6/47FjMHQWlpeakweG8F06
         h5a0GQgiJywXWsTgumZcWTn+SVEM32WVxmu6qWHshbIB0ZRLuP0QCFd7rqtgmjsndYUC
         dh8BfeKF/8X6WLD8ewFa02aXLQoBBmbP04sexIq8PRISAt4bxsOqVkP91U97rHinwvbM
         a8I0HkNNOSpA7fVN4HyRl1dQjPFOMXDUaILutqlqVMWp3bDjlQs7IWADjzD7ECh1KCTO
         dhHoxIl+R1z85fiXrOkOTklI719Z9trnMzfQMh0HTS6wGl5xgsR81rcIGA9OZIEK/vPd
         2J6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt2JiAaBrNBkLR/2qc4l4H85qsboySYLUbvs25W4U2eccv4X2kA2QZAVaf4iNv3mHDMB3wlV0BiQeI/5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJa0OTm9KhSwC0aNAppavwRxz8GakWZhggdNxVXbHDZf/QSUi
	oY5ZcBQbfvCkyiqyUX2oik3O224p0qp3wbVYe7FYMR32ofOHB45+VsRSE6g/+eWASI7E0AK0c+M
	oZUMmj7htquIdpztLai0FGmLyVgf2VpGCPUJS/iB1STVoWjkUyeMFfVF+/YU=
X-Google-Smtp-Source: AGHT+IEH0Yaupk0fNtfHcvchWBe/jBRaQp3lByWNvstegAx7DY61SPZI/9ecVgna6rwbnqVRoHPvC2MV4bhgcqcL/jP+qBrB1bhx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:427:5e1d:4200 with SMTP id
 e9e14a558f8ab-42f87411d8cmr281884895ab.29.1760441764093; Tue, 14 Oct 2025
 04:36:04 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:36:04 -0700
In-Reply-To: <20251014110217.635610-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee35a4.050a0220.ac43.00fb.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in ntfs_setattr

DEEPANSHU: ntfs_iget5 START for inode 25
DEEPANSHU: After iget5_locked for inode 25, I_NEW=1, i_state=0x1
DEEPANSHU: Calling ntfs_read_mft for inode 25
ntfs3(loop0): DEBUG: ntfs_read_mft ENTERED for inode 25
DEEPANSHU: ntfs_iget5 START for inode 25
DEEPANSHU: After iget5_locked for inode 25, I_NEW=0, i_state=0x0
DEEPANSHU: inode 25 found in CACHE, skipping ntfs_read_mft!
ntfs_setattr: testing by deepanshu 
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 6475 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
RIP: 0033:0x7f9d5ed0eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9d5e37e038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f9d5ef65fa0 RCX: 00007f9d5ed0eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007f9d5ed91f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9d5ef66038 R14: 00007f9d5ef65fa0 R15: 00007fffa6e46398
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170e25e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d505e2580000


