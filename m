Return-Path: <linux-kernel+bounces-825569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37DB8C3F2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F28D585B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B907279DAE;
	Sat, 20 Sep 2025 08:36:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6626E16E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357368; cv=none; b=ZR09Ra5yX93y3XMBYbIUHbjgnL7dg/HooZW9q9CUKzv3UUyCLUvSlsvBE7cDm8OhpMhAx8yjDhwHHAMm08trpDcISDStx02b1zrSsiBN3LBnzPYduzjVPQCOVUHrH3/rvW+BnN2/3XkmCNw9k+zT58ZGwcZBZtI2q21qYSjWEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357368; c=relaxed/simple;
	bh=WtO4BQ4XzaiKH9+tSbiy/KNwIU/ONqEUDyyTJC80NMU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bx2M7tGsM/a6WjH/v8Jg+Kcx3n/DAQiCDVy2B7U1x/XmVDp0Cd3RRmMzYe65dNo8HLJoOZkEo/LInOZdHlQrW4Qo6MfmzDQDhhezzBApjVTsADk8miPCraQ2fM4HlGu/ziUX9TT3O5Dzfdagxtfz6blPqVEY3lnkqXqvzx4TQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42404e7bc94so73113105ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758357366; x=1758962166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fa7S1j3nxvIIuHyHZje/UMThnEpT6+k/joXB5GB8W5Y=;
        b=dEItdljRn4Vz7Ib5f8ushPrdnDFb/ngjPd6ry0fQ8OSVShvSnFuPdet9N/+YlV+4CU
         GecfTVkY7ULHKcKT0uzYLzquATtYjCtiRHSbW/D53VKsMRtdFF5qg8LYrIb+U7zKACjH
         ZU5X9CKuglnmTlZQh1YYpPZQprrzQ/dU0rNwce+wjsDOTZPHkjBbsebuiXRwLBp+jpMg
         BDAZBapLrYfnJ/rWaG+NVEKHeS2jCz5p7k6XBz90PwsDGQxQK9qG6uSUAs67k8opUcA+
         +IN3g7juHWWgoF10IXYGzXGnkgnXuI1gdZTFUB3RhkSwmB/Pz/RfgdvP+tGMVW9qsVnI
         BmEg==
X-Forwarded-Encrypted: i=1; AJvYcCU5TJyv171LgAwl7ds1/WtqJFPINAPiP+TTVqpqA824vDxd9ig+CnCemt88bf6MzmZYeS0/iCZQ4jAPcRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0MAYjsp0h8bYQlKSHKiLYy4MFRCedqSRCNYARMg7cyDMB1CB
	M7HNi2nqgXONfL7GY6zot/JoGzxSDhEQxANE9/IA4dhNLeFv5HUOxQzJkOTaC/KmjrQt8mKBg5m
	32l6a/q6vVbF2b4kb5NjTuYuiWOT8TAZ3AmOSHPNI0CUsE0IK/wjZCvh9UUc=
X-Google-Smtp-Source: AGHT+IFxr2211ej0Wcq9mt5AXnHFZV24VB7uSkblL/31YT9b7+1Z27yoKk42BfAR/77Qr9FWQgwenXdi7/QWATf2Q2f50Kz8ospy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348b:b0:424:8b85:d2f6 with SMTP id
 e9e14a558f8ab-4248b85e3bamr33738945ab.31.1758357365738; Sat, 20 Sep 2025
 01:36:05 -0700 (PDT)
Date: Sat, 20 Sep 2025 01:36:05 -0700
In-Reply-To: <20250920081133.778997-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce6775.050a0220.139b6.0011.GAE@google.com>
Subject: Re: [syzbot] [nfs?] WARNING in nsfs_fh_to_dentry
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in nsfs_fh_to_dentry

------------[ cut here ]------------
WARNING: fs/nsfs.c:495 at nsfs_fh_to_dentry+0xc56/0xd60 fs/nsfs.c:495, CPU#0: syz.0.17/6508
Modules linked in:
CPU: 0 UID: 0 PID: 6508 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:nsfs_fh_to_dentry+0xc56/0xd60 fs/nsfs.c:495
Code: 5c 24 60 e9 28 f8 ff ff e8 b7 01 79 ff 90 0f 0b 90 e9 1d f6 ff ff e8 a9 01 79 ff 90 0f 0b 90 e9 96 f6 ff ff e8 9b 01 79 ff 90 <0f> 0b 90 e9 ea f6 ff ff e8 8d 01 79 ff 31 db 4c 8d 74 24 70 e9 ed
RSP: 0018:ffffc90003b3fa20 EFLAGS: 00010293
RAX: ffffffff82471785 RBX: 00000000effffffd RCX: ffff88807de45ac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000effffffd
RBP: ffffc90003b3fb10 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
R10: dffffc0000000000 R11: fffffbfff1fc9b6f R12: 1ffff92000767f4c
R13: ffff88802e1605d4 R14: ffffc90003b3fa90 R15: 0000000000000000
FS:  00007fccf554a6c0(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cd63fff CR3: 00000000334e0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 exportfs_decode_fh_raw+0x178/0x6e0 fs/exportfs/expfs.c:456
 do_handle_to_path+0xa4/0x1a0 fs/fhandle.c:276
 handle_to_path fs/fhandle.c:400 [inline]
 do_handle_open+0x6b4/0x8f0 fs/fhandle.c:415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fccf478ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fccf554a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007fccf49d5fa0 RCX: 00007fccf478ec29
RDX: 0000000000400040 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007fccf4811e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fccf49d6038 R14: 00007fccf49d5fa0 R15: 00007ffd8bdc2758
 </TASK>


Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f8dc7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=9eefe09bedd093f156c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147e4d04580000


