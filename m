Return-Path: <linux-kernel+bounces-818204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED65B58E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BBC3AF30D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1D82DCF62;
	Tue, 16 Sep 2025 05:59:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB7AD2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002346; cv=none; b=XhPiz7am/3ePyalkaX/P14gS2y95rjeAs+BsPfnjnFGtG8xSYDrF4PmIuQ97/m4Ld/3/qHC0t4iSg1KZLElSITuPD8+XVSX9uSxKNeqf+OKTWQpItpupZuPyuKsbfjxSD8xNyXZvTeo5+6QcJ9WA6S7ZnyfOS0HAmNK6pCkHOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002346; c=relaxed/simple;
	bh=MWfdbzgpU8/9GBR6cLeUg3tQ9SK2I5/GBE1TBepnshs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KEM/Ki8nVmNkUvM1YlvBbq1kDUzE8V5IhubWZa12Xi/gYhZ5U11XDofA6w09l4FSHiLSUiFNWVLv68MFBLR4bNez6YSkiVsMixDLeUzPPJeg8YszbsT8hws3r1NrKV9lbdXoDnD4vU3V+O2YQe4x853qYLf04cLOj1VkLip29sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-423feb240a7so60072725ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758002344; x=1758607144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn1WXMN90WN84KblkMUwtHEVkm9nS34GsVkttjfa3dk=;
        b=kxjzpPR+9tCvUBTBgb3Z4iYeNNKRHfqKeBFll7CajLPSBVwrF12HU5W2uepHbLOeaA
         CLAR/NPuzIfe5a4Ob25AMk0+TPTIn4OKposY+eEoEjaqgVHwXv1KgAxExC3aeJKIZRN4
         uZJty3Q2xLQkWuJYyQc2DkOLyhhz1GiY8oXkigpFfB3D3GnwY+aq9s8ANS0CXxGI9QD7
         YUCo04Y57wCjWegG5mwYB3BIRHqTqaN4+V8WFlytHvYN+gZlkrTTzT6KEbRSiLzYChk9
         JuRXFmmMMt02/o4zwoVv5xrkst17FlQtKAvXKKlRCLvB9G3YycvZqS9bshAa/uHq5/nO
         i0JA==
X-Forwarded-Encrypted: i=1; AJvYcCXoFz+IVOGkU58bDSAMZBhCJG+AWYsKRKzonI78Fs9SkKJ3qwjJdQ2J5s33KzhoZEOvcHoNS24AUINzgng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JfUsXEVZeFCJofql8juMLsnrWO1jnZnmQjfyqlN9X3x40flY
	yO5V2AZXhbyYL7hG9d6xUjvcf8dCYeKkW7g2F4iOi41l8JsehzE355vw4nAXGuYLAgQAoEMOgd3
	NYyJWI/us9/6jcXFPnWatBfJk+Dy3kE46wLdoCWbiZoHaAJLBlOMix0BoNYI=
X-Google-Smtp-Source: AGHT+IEbOfS+sZRFRzFD/UiZLmZu+y4ZY7rjXTAj9z4GM1gVzg6AffcPSP3y4OT9AFl/qh5Oiz6b9tt/4Old2Ss9T9c/XlUNIg9K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:415:fe45:3dfe with SMTP id
 e9e14a558f8ab-4209d7e0f1bmr180407605ab.3.1758002344454; Mon, 15 Sep 2025
 22:59:04 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:59:04 -0700
In-Reply-To: <a3dcd664-b39c-47ff-a61c-f834ba130a16@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8fca8.050a0220.3c6139.0d2b.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=391, state: 3
WARNING: CPU: 0 PID: 36 at drivers/infiniband/core/cache.c:813 release_gid_table drivers/infiniband/core/cache.c:810 [inline]
WARNING: CPU: 0 PID: 36 at drivers/infiniband/core/cache.c:813 gid_table_release_one+0x34e/0x4f0 drivers/infiniband/core/cache.c:890
Modules linked in:
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:810 [inline]
RIP: 0010:gid_table_release_one+0x34e/0x4f0 drivers/infiniband/core/cache.c:890
Code: 4c 89 f0 48 c1 e8 03 42 0f b6 04 20 84 c0 75 64 45 8b 06 48 c7 c7 60 4b 71 8c 48 8b 74 24 20 44 89 fa 89 e9 e8 13 81 fa f8 90 <0f> 0b 90 90 e9 ab fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90000ac78f8 EFLAGS: 00010246
RAX: 4a34fa8552892100 RBX: ffff888031fba0d8 RCX: ffff88801d6f3c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000187 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa24c R12: dffffc0000000000
R13: ffff888031fba000 R14: ffff8880744f8990 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888125c16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f44957d5fa4 CR3: 000000002849e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         067ce8f1 RDMA/rxe: Add logs to find out the root cause
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=16304e42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

