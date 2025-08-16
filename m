Return-Path: <linux-kernel+bounces-771743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF48B28AF2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6157E7BDA01
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45320E005;
	Sat, 16 Aug 2025 06:20:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDBF3176F0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755325205; cv=none; b=js7Ru3xyIjF6lxBNsYqW/Xk7AWMnjx4+TRJgZ+Kd+iYZJQU/p9Iln79DO4yejSIjKlmyk28p3fAW8dfQAE1QYA8aYRnBubGGYJugVPjiN46icz9W0bfss0M6fRDVrhXquG/n1FzH4ZiNCW7cWlBXtGkfuFoEvmi1C7JUOcWym38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755325205; c=relaxed/simple;
	bh=uImpyxic1DlGJHDXqBUbKJ8bgm90bhKpYTNCMGsBV34=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q/qSFHw9FneJTB9f+OYZ7sSKb6wadxYw71lKnLvx9KUTUQnIV0Re2vI6DIIVk6x2CEM3ZLT4eC8fW1iYECnPU5UofXiV/itTfNjGcB08okU8JFeqLmjIctzBYvULNmJ1ldGftHdF76OZ6D7TbH8zi+SLpff+/8X7GaBGqOjS1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432a2583bso331712439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755325203; x=1755930003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+qpFamrdBfcTqGZrg9oRF3aCj2RHnxdMey6rPIA67A=;
        b=ruQTcpgbgM7WGE82xYIqL8YLGidifUmD1YJeZ/3S6iWBbD1ZTBbSWXq6WXfVAVGBCQ
         Vnxmuim8VUbSZ16X7IZeh2rMkVWsGksLwx7u+gxEhIFfU/11He0CwMR2cmPdDVrAL/58
         3LVqSVN6SOX97XnE9Pt6yXDVfV6XR7+hsHI8LNq80XbDeYQQqJBx1Rx/rNOM6DttSBTK
         jU6gCkGmkwBl7XETCdVjeFMWfgFzgzFk9dX83cRQ5v/0tXxhh5i4TGhM8htF/jxUQw5B
         URckNUxEdtfGI/rK2+MYX+zr3CtI1JIkVi8ugtSBCnQGkjTU6lxV7LoUbu6Z+c5bTTbO
         po7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFww5cXR67fx9F0f+n+uapBlGVrtGscBjDD3ITxCAecswT8iCKf/c8O4HUiIDJn/pOcrieuidQq2x+++Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahhQb4ZbNG60HvfBoOxlbIPqdqacj2KWi9MjA4BBQz28pp8vY
	y5bRV2a0HPJAkp0hdAIe9POGishRkk+WwWOlE9gT0KcCmDO7qETZbccjvOZ6Ja3lTN139g2Tylv
	yrRE9oUqVsaMX0TC9A3XYTE4oEGdWRhy00RBOyZeZI8jtWr+jWcvmQ+IVRog=
X-Google-Smtp-Source: AGHT+IEBhBlseZMn+McFIQ+tcO7GOlNRaSMsFI7K/iI47R9XYqG5lxWLTAVj0YkOThJHxsPwxng8bnzxv+AI0RhBM7MX4Jiz1p3R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6402:b0:883:ee57:93b7 with SMTP id
 ca18e2360f4ac-884343033e8mr1727949139f.0.1755325203317; Fri, 15 Aug 2025
 23:20:03 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:20:03 -0700
In-Reply-To: <20250816054208.4763-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a02313.050a0220.e29e5.003f.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in shmem_unlink
From: syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in shmem_unlink

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8916 at fs/inode.c:417 drop_nlink+0xc5/0x110 fs/inode.c:417
Modules linked in:
CPU: 0 UID: 0 PID: 8916 Comm: syz.3.1059 Tainted: G        W           6.17.0-rc1-syzkaller-00199-gdfd4b508c8c6-dirty #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: c8 08 00 00 be 08 00 00 00 e8 b7 90 ec ff f0 48 ff 83 c8 08 00 00 5b 41 5c 41 5e 41 5f 5d e9 82 bf c8 08 cc e8 dc 5a 8d ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc9000dc77600 EFLAGS: 00010293
RAX: ffffffff82310064 RBX: ffff8880269664e0 RCX: ffff888034871dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52001b8eeb5 R12: 1ffff11004d2cca5
R13: 0000000068a021d6 R14: ffff888026966528 R15: dffffc0000000000
FS:  00007fe36dd9e6c0(0000) GS:ffff8881268c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 0000000028cea000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 shmem_unlink+0x1f5/0x2d0 mm/shmem.c:4041
 vfs_unlink+0x39a/0x660 fs/namei.c:4586
 ovl_do_unlink fs/overlayfs/overlayfs.h:218 [inline]
 ovl_cleanup_locked fs/overlayfs/dir.c:36 [inline]
 ovl_cleanup+0x151/0x230 fs/overlayfs/dir.c:56
 ovl_check_rename_whiteout fs/overlayfs/super.c:607 [inline]
 ovl_make_workdir fs/overlayfs/super.c:704 [inline]
 ovl_get_workdir+0xae2/0x1800 fs/overlayfs/super.c:829
 ovl_fill_super+0x1365/0x35b0 fs/overlayfs/super.c:1408
 vfs_get_super fs/super.c:1325 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1344
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe36e72ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe36dd9e038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe36e955fa0 RCX: 00007fe36e72ebe9
RDX: 0000200000000200 RSI: 0000200000000000 RDI: 0000000000000000
RBP: 00007fe36e7b1e19 R08: 0000200000000140 R09: 0000000000000000
R10: 00000000000000d4 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe36e956038 R14: 00007fe36e955fa0 R15: 00007ffe0cf24ac8
 </TASK>


Tested on:

commit:         dfd4b508 Merge tag 'drm-fixes-2025-08-16' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129cf3a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9fab8b7f0386b98a17
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170cf3a2580000


