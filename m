Return-Path: <linux-kernel+bounces-851968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910FCBD7D67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CD8189E909
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA72D8393;
	Tue, 14 Oct 2025 07:17:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAFF23B62B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426224; cv=none; b=u08O0dr5/h8OIiurJSPxnmumDjqWocpnQTKyLCPoE0hDwTiYqa3fdR/RGpwtzvnwnyA4lcuWX6ewxy1PR3HMpe2HCDZfG/BqE7pynJ4Lqkm1zrzf3MA+/ucJRiC5sRhaV60nTX6rh1HM0Rg5P7YBLzhG8CwvX6oHbFQepeenzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426224; c=relaxed/simple;
	bh=GyYtf0C8605fPY7hE4vnD3ega9HPVfbMLdQGUP8xyN8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PTCxuFNbdJP91t/pQDPdfDq9Jb71XftTdMfUuGyVn8C9SBDXiL9ZabaZTCIWuqmuwRB1z0yXXNMgr6ZQRvXh8cnOJSGuZBlDIp+Vy68LEtQes5+OdM+mkFX2mQufXUIGxysd9GLpruJC+w4riv4mv2bnou9JvCJUMF7P/n8bv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-92d4dbf9b51so2764498339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426222; x=1761031022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlj45AuqCjInOTRmT6qgJKLQo77GaODlw7K+Q73uUFk=;
        b=OI2cyckTd8hjxYfzhALQHVaGj7fLVNNaPODB4prhcjBIYzZQUWyZFPB120+XCfFP6H
         hSmsN/yo38OSxM4n8aGv8VcEgqrb8PsP14HJ0qzKdc6v4sKgOts65k9xMfSqwThY5/MN
         WrxCXu1HK6vHYLUxV68XjiY8v7E8QCMzzAeZVhDpnwpyJ92Ca/fOjdUE/Qdp2APmJyST
         A4UZDatPzJHdXvI2fzUdfmWNLUHb61lh0ii3zflcMyuytNNrOqcRGVW3pZoNhs/JZr3R
         2HTmIbajjWhG7zUxsTVMVByHtoSTf47UdLJyPWv+SKKIMBaYkkPQqu/8aIhR03ZHfa94
         zaXA==
X-Forwarded-Encrypted: i=1; AJvYcCWzCEG4RogOikgd2JmDuhapliifWhOaHcggrtUEXXeuijAAcWJ3e3zle4IIjE4ADsuhrl7sqj8MZn9Blts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPN1SB/j6DSkFtZHb7M4v3RQLzXwKkD/ygZXf7UznOk4GaBUNO
	7gay1PRFyEZkwnWt3BZvHVTlH9yjES3t+xrwq3HmdlXnNYvvY/2BLrPveiPNHhNH1SXxPJ/VrcI
	S8YAKK/4HkRe4z5ni6c2heuysmIFnT8NmvruEPsFygn+M2v20btKI4QuBB2Y=
X-Google-Smtp-Source: AGHT+IFn0vccWGyxkBFxX0gTOOBWAOeRBlHXTzzLEYahqY7tp9eZSONM7BJel0HP29uSSn2Go3L80gscRcQBvw+sI7MC3terG642
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6cc4:b0:920:87f9:5da8 with SMTP id
 ca18e2360f4ac-93bd196672amr2940938239f.13.1760426222588; Tue, 14 Oct 2025
 00:17:02 -0700 (PDT)
Date: Tue, 14 Oct 2025 00:17:02 -0700
In-Reply-To: <20251014064114.10250-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edf8ee.050a0220.91a22.01ff.GAE@google.com>
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
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6530 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
 ntfs_setattr+0x70e/0xbe0 fs/ntfs3/file.c:806
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
RIP: 0033:0x7fd37967eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd378cee038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fd3798d5fa0 RCX: 00007fd37967eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007fd379701f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd3798d6038 R14: 00007fd3798d5fa0 R15: 00007ffe10a7c298
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1140bb34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1569467c580000


