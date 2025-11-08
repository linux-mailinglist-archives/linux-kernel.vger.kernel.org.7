Return-Path: <linux-kernel+bounces-891367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B97C6C428BA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEFC94E12A2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F932DFA46;
	Sat,  8 Nov 2025 07:14:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963D2C0293
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762586045; cv=none; b=b5do79ca1iUhPVAaqYRpRBPzYCGxelYPXUlBCIRjecOdiXu8DNHQmtvMtdb0yG6UnNDl6D2d46LACWs9HtQFzytaNTj4QEch6NzWJa2g1iZ45YFaFNczcDKYmUXIPxoMd/dkD7ETXRY2fRn4nKroNqN0Y5lYdlkOKKMWYO9Ke0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762586045; c=relaxed/simple;
	bh=QEXCJFRkPoqqwnzKOjnjC5x7WBWVwhbdpqHG6Xzz7FE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VTeuJ+7/bb/pN3tjou8ei7pzKn738XPlfJtB4Ac+874L1lcZAoQF7zIC6oev/FeZ4GA0IDfEW0yYw/ZcEy6QAGD1VziO1z6TCHkuQ5eJ0m/M7HhKWJBLwRdKdUMVE1PciSRWGKT8u2Hxa0dCI2GFEIflL5PQp/UTGxANio5iVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940f98b0d42so412957939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 23:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762586042; x=1763190842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLHjPQDn68pCHUKniARdq+TQuOXx3fBszvftaTbFDAI=;
        b=FMZVv71aJ2k0IuwLPrmLqgnrJuAI6ksNH5cJ2oB1fZTrIm+OUB8X3ptsXub+wwwUme
         VXHv+TXml3ajmj7H5MJbhFtd9LFT9+Q9rW1+JdTjGSs+QEw4pB0+A8tF7e2oR5u+vZm0
         Xb8glGa3BdsHsajxXwlQxEJ94dTY2tSfH4t1DbSjRVAcxOyjA6Lm9ZChiUWuCe+8Hjv7
         voLEzDEe+FAjYO2omG+UxQigNUwxO4yo1NkjQTO2wX2TaaBuSUk87UV9uttTRmjwEDiN
         AgxQbhbVN8j3jehubF8AyAOTIhxqT+H+vdofvCq7DHlXFKiLFJzrAChdyLXa076c/X5X
         CV2g==
X-Forwarded-Encrypted: i=1; AJvYcCX7n8vC667hsE5jzrDzbQi4fL3j7QVTJdB9QIdA9dha5tCdwRGTiKJnqGXnodZoX77187V0etSJK8QKwK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIENluDkxa6bgJxA6WWNJVc8tcPP832aDWn4La8LLSbGzRN6j3
	xKOpH/UIkCHTf4WMkrAoHS1JO0CR+5Czfc57ktTXB5psP8vR1CfedtnQCyEqHA3ObHBjU9uCNuK
	+NqQC5Ueh3ahYyPCbu10P2y4HAV+Eifbw5rBc8TUIBetKYljOxnicwHu9mfE=
X-Google-Smtp-Source: AGHT+IFTjc7t2UX3/MCEoLz40Tpj+tXFSoVtTHUSir0m5lcr1E/e/fH/2FUCB7gAF+MiHSz4SZPaWXQzxCRnZOaPJ9A16XNCoy4n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:433:481d:fd60 with SMTP id
 e9e14a558f8ab-43367e7a593mr30853765ab.17.1762586042480; Fri, 07 Nov 2025
 23:14:02 -0800 (PST)
Date: Fri, 07 Nov 2025 23:14:02 -0800
In-Reply-To: <20251108063831.8984-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690eedba.a70a0220.22f260.0075.GAE@google.com>
Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
From: syzbot <syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in destroy_super_work

------------[ cut here ]------------
WARNING: CPU: 0 PID: 22406 at ./include/linux/ns_common.h:261 __ns_ref_put include/linux/ns_common.h:261 [inline]
WARNING: CPU: 0 PID: 22406 at ./include/linux/ns_common.h:261 put_user_ns include/linux/user_namespace.h:189 [inline]
WARNING: CPU: 0 PID: 22406 at ./include/linux/ns_common.h:261 destroy_super_work+0x15c/0x1a0 fs/super.c:280
Modules linked in:
CPU: 0 UID: 0 PID: 22406 Comm: kworker/0:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events destroy_super_work
RIP: 0010:__ns_ref_put include/linux/ns_common.h:261 [inline]
RIP: 0010:put_user_ns include/linux/user_namespace.h:189 [inline]
RIP: 0010:destroy_super_work+0x15c/0x1a0 fs/super.c:280
Code: 4a 65 ff 48 81 c3 a8 fc ff ff 48 89 df e8 8c 4a 65 ff 4c 89 f7 5b 41 5c 41 5d 41 5e 41 5f 5d e9 6a 66 e2 ff e8 c5 48 88 ff 90 <0f> 0b 90 e9 6d ff ff ff e8 b7 48 88 ff 4c 89 e7 be 03 00 00 00 e8
RSP: 0018:ffffc90003b7fa28 EFLAGS: 00010293
RAX: ffffffff823893cb RBX: ffff88805ca22898 RCX: ffff88807b670000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffff8880277fc9e3 R09: 1ffff11004eff93c
R10: dffffc0000000000 R11: ffffed1004eff93d R12: ffff8880277fc9e0
R13: dffffc0000000000 R14: ffff88805ca22000 R15: ffff8880277fc850
FS:  0000000000000000(0000) GS:ffff888125cf2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4d20c10286 CR3: 000000000df38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         00f5a3b5 DO NOT MERGE - This is purely for testing a b..
git tree:       https://github.com/brauner/linux.git namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17a46a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31f5f45f87b6763
dashboard link: https://syzkaller.appspot.com/bug?extid=553c4078ab14e3cf3358
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

