Return-Path: <linux-kernel+bounces-581983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E06A767D8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2391889932
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C0D214213;
	Mon, 31 Mar 2025 14:28:27 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10686213E6A
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431306; cv=none; b=k9S+kYedQ2AjRj/F835x+SxlBoMwXKQ75022Zqw6lMMEVygN+1PJZggNH3hRMMMVIVl7PTgFlLzpF4GeyJha660K4toz+2/DiTYia8eW6FGmuDYAHg2aaa5e3stC/lMCWYiE5qYN6XDpEy7feCw/6zCBH8g7UbKOjMGF3aQ6zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431306; c=relaxed/simple;
	bh=ZzkiXXn42kQLm+AeupOqLsN1hoor69FujEmlUSHdTEs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lziyvSuzNq+AWi+gQ23d3KI9QeT51N0vY4fQbnUjyxAGUv7NJt9wAD/O5cTO0cHqMCK88hv7MTC6xICzU6BTX+yH26lsglvrNM90uN4uYNfl79aMfe9XaJbdQzjV6cRHb4KjWD4/6uZtRSFVQNOQRg2tkVHh/pwTTMXgsU5snt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso50140775ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 07:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431304; x=1744036104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOboF1VqiyOWrqOVlRtUfXDsHfrUgLNrZ4C7SELmtCw=;
        b=XjkuyNwlkiPO5OLwJZ/TsHXVC+TDTFCzeNiw1B9QuZx2aymhY75Nh+DWxTnkWYs8rU
         hTFMrktkGxfIg9sHZQBYM/ompH+1StH90FgA0Is97RaEkAnyO8zkmPW4bUhpKMJHhqMq
         2xPqSSun3zQpov2ymUqC/IGJixUVqRZudsrT8E9ResPdZXndzzJ6ksFUrjndAjcrdw4d
         XlDish4hROPKm2FaJGS6J+91Pv1lPDg4tN0MZmXF9Tsysgmd6iSoKJflXTFiAX4f9itY
         a8hhClaT6dC5PkqhwzAWS7zInodAY+18WLRMAlDLLNnzJRl81CD0hmzcZDaYf4DMt9b3
         1n4A==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZDwNUvIBln6HcCvSPdczda4oizm88/RPdXMbGEwCzjF0IZT9TGVZqNbBqPPMeUd2OqkX3OKGZnue7PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbo+Zg7klc8rWF6U5wiS1ZM7F2QWjhUETBBWWzm3wZUGzsFBu
	LVKNt+wcb0WXzU8Ut63hU2M9JaL/HL9e1FEOuZvbmhE+b5KJyykvgspO5MW0iOXc5Bnjb2PtJtq
	EqXOm5ygayKgvIle+1wOwP8zK/Qrwej4C6dCT5HDvKNZV5eNn0N2Es58=
X-Google-Smtp-Source: AGHT+IHokRbR5Vv8AVU/qDS+yOFdsWBXdmYDkOPKWvTwa1q0CavVsWfcTYGnq1ci/jpzdYqQYZs5ob2gIlG6SuB5XpsrTof49PSf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b03:b0:3d5:df34:b21c with SMTP id
 e9e14a558f8ab-3d5e0907411mr77349565ab.6.1743431304209; Mon, 31 Mar 2025
 07:28:24 -0700 (PDT)
Date: Mon, 31 Mar 2025 07:28:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eaa688.050a0220.1547ec.014a.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
From: syzbot <syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4e82c87058f4 Merge tag 'rust-6.15' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17454e4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f51da9763f36e4c7
dashboard link: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a9052db6d173/disk-4e82c870.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9398a2c8040b/vmlinux-4e82c870.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8589baa292f3/bzImage-4e82c870.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in skb_put_data include/linux/skbuff.h:2752 [inline]
BUG: KASAN: vmalloc-out-of-bounds in hci_devcd_dump+0x142/0x240 net/bluetooth/coredump.c:258
Read of size 140 at addr ffffc90004ed5000 by task kworker/u9:2/5844

CPU: 1 UID: 0 PID: 5844 Comm: kworker/u9:2 Not tainted 6.14.0-syzkaller-10892-g4e82c87058f4 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: hci0 hci_devcd_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 skb_put_data include/linux/skbuff.h:2752 [inline]
 hci_devcd_dump+0x142/0x240 net/bluetooth/coredump.c:258
 hci_devcd_timeout+0xb5/0x2e0 net/bluetooth/coredump.c:413
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address ffffc90004ed5000 belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc90004ed4f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004ed4f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90004ed5000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90004ed5080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004ed5100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


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

