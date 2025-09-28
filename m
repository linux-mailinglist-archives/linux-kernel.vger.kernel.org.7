Return-Path: <linux-kernel+bounces-835179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8204BA672A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A441789A6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D325C802;
	Sun, 28 Sep 2025 03:42:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCF1CA84
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759030925; cv=none; b=bFYii9nDNoJ1indb6mEHyau50AYOG3Xo/hQu8yCTBLSZJFJTppWjABD+1/R9LPkhCFyfG84qDz0n5JJUyrCgoPxrefIirW8JIyf/JS1OXA6kPS9TRjN3sXESWX2juXuia8jAtSvR3gFoYxC3wZdqU4cM/V61CK0PrpoXVOOwh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759030925; c=relaxed/simple;
	bh=05RLO5G5596O0hNB7flsTd480xoyFswUGdEfxqVz6A8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KgP28vVYNIdFF1aaVRBo2vYc5TwXPAErPTre8o3r3fH/u8J3R6zeI6vEBPEkRg0uadKryRiawQjLQ/qa7yf1wdiLvSfoklGy7Qt4piXar0GIZs2FTt0d+1CdHmsx+RRAON08czXhVqqNmX/fFVaicdiqz9TE4+5J8TuwV/rvuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4294d3057ffso9335965ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759030922; x=1759635722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eLHh5jTKjgvE6uqr8daQoCdE2L0UxsUK0cc6BW9e4Y=;
        b=YEqKzvlIlyewzw/72V9cmdXdNlsrBoQCRrgp6iQR/pGqr7E3yCiMGRYzohyn5/AAZa
         XqS7xO99wYccLcknd1UuwLLSzXu3Omw/K9PopPAS8r/RsXUes3indGp6HGmeKudEFXOU
         K0Kdq9Ia70+sw7U77R2cz0CrPdfi1O3SP7tSQLOfo+ZtAaxWJLrgvIUIjPrNJhUOrciw
         WQMzH0hIbKv3dS196WpZFmX99lv50o/MlfdBKuH4IaEpdd3WhL/lHAjF9S6z6YB/ZpF4
         HJslb13hgA6+KuqPLN6cFkBCjAI/IGI6zSw9eB26xTrz/cyu5ZIQfoQ5QKPawXPUwGPe
         Ja/g==
X-Gm-Message-State: AOJu0YzuRFS+O0KUxWR7SmM8Ai96bDz0GDDB739gHQiFwh4LBddznPJ8
	cXA3XGlgNPsSkWbA2iWBU11h/trF8+HtEt8+0/8khavd0ddYe9fPWod9A8VmvtBEwqVJe+ZlaiW
	Uyb4t9uB4YiLsFoCeSnThL/XkHXRelan3+d+01OIlkurwBqGBcgry4z83u7I=
X-Google-Smtp-Source: AGHT+IGS10ksLJTwWZuO1xHlhUJdIVykFr5/6uwusAK6AIMgzH0za3mPBtCSf8PhtkWIUb7CAxHB11gLqk/ezHSsrqDKFMbLwpIo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:428:e746:8201 with SMTP id
 e9e14a558f8ab-428e7468ae0mr50665495ab.2.1759030922393; Sat, 27 Sep 2025
 20:42:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 20:42:02 -0700
In-Reply-To: <87o6qv2rch.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8ae8a.a00a0220.102ee.0025.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in jfs_statfs (3)
From: syzbot <syzbot+13ba7f3e9a17f77250fe@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in jfs_statfs

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/super.c:140:14
shift exponent 115 is too large for 64-bit type 's64' (aka 'long long')
CPU: 0 UID: 0 PID: 6430 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 jfs_statfs+0x4d1/0x550 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x144/0x2d0 fs/statfs.c:90
 ovl_check_namelen fs/overlayfs/super.c:387 [inline]
 ovl_lower_dir fs/overlayfs/super.c:403 [inline]
 ovl_get_lowerstack fs/overlayfs/super.c:1150 [inline]
 ovl_fill_super+0x9b8/0x35b0 fs/overlayfs/super.c:1416
 vfs_get_super fs/super.c:1325 [inline]
 get_tree_nodev+0xb8/0x150 fs/super.c:1344
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8070b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f80719a5038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8070db5fa0 RCX: 00007f8070b8e929
RDX: 0000200000000000 RSI: 0000200000000140 RDI: 0000000000000000
RBP: 00007f8070c10b39 R08: 00002000000003c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8070db5fa0 R15: 00007ffcaa757408
 </TASK>
---[ end trace ]---


Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178192e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54ce6cac29609b49
dashboard link: https://syzkaller.appspot.com/bug?extid=13ba7f3e9a17f77250fe
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

