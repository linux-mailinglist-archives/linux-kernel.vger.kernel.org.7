Return-Path: <linux-kernel+bounces-852365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E98BD8C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 503824FD197
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E532D248E;
	Tue, 14 Oct 2025 10:30:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E02EFD88
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437807; cv=none; b=ZHItoizy/QrndMHeoqmQu9EXCz/G0pNblj+TNauUz0Qdl0zQZKvUqeiAi88Dk6fZEly+GKQdX4/f5nbJwCzDGbZFrE+Pgpv02BzYTdicDZlo6knn60Fna409R/8gB8bpiGn3+abkjOvnKKVaXTL94b8EqmwATCQBqQYvwUv5BFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437807; c=relaxed/simple;
	bh=1vIra1mm0mDhoaK8D9LL4naUD17ZaI1yiDmiXcvd5+k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UpTGK5hDRdYSWCM2BFPMXnpbfzj4NoZAT9/Bf9fP4T4IXCI7hWI4Ej3Fx55td08iNG+p8uD2M0mrlq99ocRFwMrkNWEaB8+u4KXDAZDKylldmVrC5/ei73ExEMC+zpcRid2AR9guuqA8MpSojQMHTfBLqGZlNsrkUpjjlACIhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f86e96381so143238305ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437805; x=1761042605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sm+iAyGR48fjgzp4tYN5hqjsiCQ5ox6kNAx7zNJCp6U=;
        b=KXIr3Eumx0Uo8GXoE+i247rROxwHEz+hGguoOHDAuVOJ4UBX7xMsWumPUNg8uaAfUo
         /WiubWRgo1nGgI42agoOZdfHG7sNJ0WVWC3r3YzMoB3FTMvy6hED6J0ea3iZGqYTgdmW
         wnmFwBNjro8yEjAmIRlmo1Y3M9MCTjSqjjvLjrnrNuByFDNgfPnCGdLJ94lxUt6I6i85
         Y/slWMwdpEBn03KkZwf8TFqj1SRdUPUhoKqTNmjp5ID2x+QOtpFTYNFfYYYM2Q5b7tx8
         AITn5NtKPDU1967F0IPdZBWINNrHT2wNVfBuP+xIGhVaKIBrN2c969VK3nH8nrfffPUX
         h+AA==
X-Forwarded-Encrypted: i=1; AJvYcCVd7gFm79FhsLSWrpglSF+vxgE/7BugMbElNGIJRngQZiUWfRwxyDu40TvNuqhLr6NCkoKtg8jtyU3Yz9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvf1iLmqdIsR0tvIEMJ71QgCu6KM152jTjOT6W8xVsjWRJJ5sF
	Bo7OFSjGXfWsH/CSSKeZYOL1SYXhgtmA1DrG1GpCRl2MRcWAPnZrFgADEjAbFRhu2KDU4uKvQCJ
	oPUIAdpnbDwbOoi0782tlUaw0y24I4F+Oa2c2qbwaP13/7ATTQriwx0xxVQ0=
X-Google-Smtp-Source: AGHT+IGbr/M9Z9VEoYqj0F3vdXWkl7NRbeZPxz+EivLB0t2DRaTLbLuZZEWBBqVOPBwC1tW4sC2rZVDBZ77hMUYP3osBe+RFxMPy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:42f:9db5:26d0 with SMTP id
 e9e14a558f8ab-42f9db52b1cmr151869505ab.1.1760437803917; Tue, 14 Oct 2025
 03:30:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 03:30:03 -0700
In-Reply-To: <20251014100933.632340-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee262b.050a0220.91a22.0206.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in ntfs_setattr

RSP: 002b:00007f1742abe038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f17436a5fa0 RCX: 00007f174344eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007f17434d1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f17436a6038 R14: 00007f17436a5fa0 R15: 00007ffe27f6bb68
 </TASK>
ntfs_setattr: testing by deepanshu 
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6674 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
RIP: 0033:0x7f174344eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1742abe038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f17436a5fa0 RCX: 00007f174344eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007f17434d1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f17436a6038 R14: 00007f17436a5fa0 R15: 00007ffe27f6bb68
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fbcc58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dbcc58580000


