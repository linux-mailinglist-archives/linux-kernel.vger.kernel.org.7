Return-Path: <linux-kernel+bounces-722139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF7AFD5BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9752B541C55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B4A2E5B30;
	Tue,  8 Jul 2025 17:52:30 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1D2E613A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997150; cv=none; b=BO5LRSvEX3mm274M7QJvLtKupHf3BVvwWI7UiWeRnbWVnXootlzdXIkl1yGwC6iyIcUYK38k5HcH622vg5M4FXxNeZTvNO3/EcLRuQqH6QXyACWRwxOi17WkDAsJirIXfYYomi9yMZuHbIddIqQvmagofw0UeTVJfUqVKqm+mqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997150; c=relaxed/simple;
	bh=CiJWS3iWVRrWIe11cv8KGCItiSrxDoGAUl/+0XJoNhU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lccbLKd6HCzv+JjJNAz5mWCtee1lPvEyUTEG1PJKwO2H6FNT9L+gUBlsrG5713bRNtrklyHLTw0U2fpNSZUWgqf6ZUSGZOGkpkBV0Fh6dZzFFIhnnYT6bOlW6BSEQEZHzbSpsmzPOf6f1IMMl8/EXlDpEWX4RmQpY0JUUbgsCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso48365405ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997147; x=1752601947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKUG9adbTZmFQWFPUi/8mG5E2xpUEJpWKtOgs6gtaqQ=;
        b=BoE2k7V7Q89KxDJVOiT11atwg2G6ZhIH3a8NThn3zr49wwuSyRUWPSPiPQkhNLpeZ+
         I+SFZe+DCM4xK/3Iwqs9gCbS2MsQ0VKgxSiGUEruF7XIz0qVTezz+MMVXQJZcn+9oi51
         3iZEs/kyvA++pVvzoCF8UBqjECN9PB832tCExoL0PjogYQHfZOLhlVZ0gXEsr15mJtEL
         P02qn/cnemIlaf48OVZxi4Q7CRkXuI+iUQU+nF6ur9HwEAnEePlyUtruuVe/UmDvKMcY
         1itCowtnehVCaoI2LxRZxlKPcohYZofpdpqA2lHk/a+Kkaf0MhMVv7S1j46wDLE+N1rL
         uz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeeiNzMP9qqJjG4bBfSyhe69f2Kf010SW1XsLbsXQGQ/T91pbqyP20O20fqUW5Ale0NQ3x2ZbLg/hoEbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweqUMa8QeP4T0/gTa4T4Z9fzn2cFEIYXv4dcglXJA2b4oo9KPD
	SY7IVpf9RUpp0DKELz8h/5+kWew6YVV7VKcBXHJHUj6xKThk5655WdzDrXAs6JbYEcAaTmZdlFg
	fdhdlO/rBlNK3fDO7XiOFgj7j0SnF8euVlS1CtallGgfcjhXi5AWgBiSF7Ac=
X-Google-Smtp-Source: AGHT+IEq+VJkjYwGsXH4LRnEW+DIhvGlcjAN7Cu8iEz+fpCj1iU2sOPHvrSLjb/z95FC4i2tGqzc6fVKq8lqrJz55kTtXsm0nz3w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2591:b0:3de:119f:5261 with SMTP id
 e9e14a558f8ab-3e136ea06f0mr150746675ab.3.1751997147432; Tue, 08 Jul 2025
 10:52:27 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:52:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
Subject: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
From: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1719df70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1124abd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099df70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/disk-26ffb3d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmlinux-26ffb3d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1/bzImage-26ffb3d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com

================================================
WARNING: lock held when returning to user space!
6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
------------------------------------------------
syz.0.22/6068 is leaving the kernel with locks still held!
1 lock held by syz.0.22/6068:
 #0: ffff8880792a3588 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

