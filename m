Return-Path: <linux-kernel+bounces-783358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC23DB32C56
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 00:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7291F5A4DB3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764A24677B;
	Sat, 23 Aug 2025 22:36:39 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE71E2307
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755988598; cv=none; b=MZIq88eVgf001DQ/BPHswjpQZac51XKCOuEm3u8k7F76pf46JrrBsYjTRlPz0pZo2HdyCeHZ5upxzTzWVfdMDSnpL9lY5uwiBbTT4jgLauiw1HFUwlYksXRHYwezkLZwDCVP+Qp53cRJcVFTmGi/fJboL0gy4dL+3CiL7NBsACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755988598; c=relaxed/simple;
	bh=4vZvK+dCmANA/RFO7QkzaPe0zgL9xeR5G3FAgTORd9Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sI0b7oS6WHDn4i7qYSkPfiT7ybkQNeLtuw0AbykEev1SaWDU+VnNOmu59+RyOxlBeL3SaTWwIRH8S5EJWx0LKsm3MVFQc+7uP/W0lbHLExrjutwPaySUpXa3BqkqxMtP2mD5ZYeQugCHhCgQP3ieJ9av/4s5lfy+MgMdrXE4bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e6649d783bso75891975ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755988596; x=1756593396;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGwLocbnTDAXfm5VG1sZW4oHyeZ0bJWUIcJzJBTSFY0=;
        b=UY9YXoXhRJqLZHJWdFnRuRHvsDY3tIC89lOCTAHERMrzZgnD86RsxjFpQUYXn7XY2e
         gOUOQinP/Qbk75hNXXAZxemcvoFoyezmB8whpD/d0kugKjcRIZVJdBerXdYrFPIPgmj3
         phbOpDjhqfdMqlbrfALNDTRnEVAh6Obv1TkbKo130bci/P5Hh6eQpZW6UD9NWEaOE4+o
         r3tHU1mgCD1eeVm1ATPFucDZrotXfvZjxO1rY4HduMgUT3gFMyns+BQcc+NHqdgxj1Sk
         0pnAXgXTaZSlKxbE9ci9QF2n0tvhnjXDyio9Qjhtf4Enml0KLZzlFCAIFGdyjNH/EW8r
         Lo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoRTZNdfN0WICg4+DqkwYYRdfe1VMqli+nYnAkHYHOCQlnSEtFVil+TE2pUJ5x0uxm4lqrAocbxlqr07Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mBpmVy/75er/pgFVaDR3GhfaLvl7vZ+2cXG/+v2HnANwKNaP
	RueVG1Nbx4qLPLJeY8j+NB/B4KjXi4RdjzMJ2A72U74QWpEMxD5LHTWgWkAE/LhWw7l5dT6JRHu
	UeMaXqrr2JaHpPjSxlLPrcaoLFRLyMo2enabzUJdL/9pbLqWiOY1NOhX3KGw=
X-Google-Smtp-Source: AGHT+IEVSRCkgjphjsoFwRrDqgtFP+NSFEK2+JqlkQKo0P6FrozDfloNFRLvI373a8BRXjG+K1ac5jTraz7SrTE/f0nHs1+eIcKK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3087:b0:3e9:8a9f:ba7a with SMTP id
 e9e14a558f8ab-3e98a9fbb99mr83546825ab.21.1755988596443; Sat, 23 Aug 2025
 15:36:36 -0700 (PDT)
Date: Sat, 23 Aug 2025 15:36:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aa4274.a00a0220.33401d.03a0.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_do_stop (3)
From: syzbot <syzbot+e9989956db9dfeabc44c@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    da114122b831 net: ethernet: stmmac: dwmac-rk: Make the clk..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=106aa6f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b2fdcd062d798f6
dashboard link: https://syzkaller.appspot.com/bug?extid=e9989956db9dfeabc44c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/944cb9a1ee86/disk-da114122.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c92fb70ac1fc/vmlinux-da114122.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e6dc0d53003/bzImage-da114122.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9989956db9dfeabc44c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at net/mac80211/iface.c:510 ieee80211_do_stop+0x1a36/0x1fb0 net/mac80211/iface.c:510
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events cfg80211_rfkill_block_work
RIP: 0010:ieee80211_do_stop+0x1a36/0x1fb0 net/mac80211/iface.c:510
Code: 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 27 05 00 00 41 ff 0c 24 e9 49 f5 ff ff e8 55 a1 d0 f6 e9 3f f5 ff ff e8 4b a1 d0 f6 90 <0f> 0b 90 e9 a3 e9 ff ff e8 3d a1 d0 f6 90 43 0f b6 04 2f 84 c0 0f
RSP: 0018:ffffc900000e7520 EFLAGS: 00010293
RAX: ffffffff8aef0ae5 RBX: 0000000000000001 RCX: ffff88801ce90000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900000e7730 R08: 0000000000000000 R09: ffffffff8ae88b42
R10: 0000096c00000000 R11: ffff88807acfb338 R12: ffffc900000e7690
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff888053b6a9d0
FS:  0000000000000000(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4e87977e9c CR3: 0000000075150000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_stop+0x1b1/0x240 net/mac80211/iface.c:814
 __dev_close_many+0x364/0x6f0 net/core/dev.c:1755
 netif_close_many+0x225/0x410 net/core/dev.c:1780
 netif_close+0x158/0x210 net/core/dev.c:1797
 dev_close+0x10a/0x220 net/core/dev_api.c:220
 cfg80211_shutdown_all_interfaces+0xd4/0x220 net/wireless/core.c:277
 cfg80211_rfkill_set_block net/wireless/core.c:307 [inline]
 cfg80211_rfkill_block_work+0x21/0x30 net/wireless/core.c:319
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

