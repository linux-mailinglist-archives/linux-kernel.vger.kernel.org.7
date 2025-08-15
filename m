Return-Path: <linux-kernel+bounces-771111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC238B28301
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0908117651D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E72D0281;
	Fri, 15 Aug 2025 15:34:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27428B7F9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272073; cv=none; b=Tjc80in+ozaUII/yhzW9zUkAfXfPYNyCT649iVcJDwpAx4LB+GKf3IZySKbR4owtXEkDA1qNaR/sjWAWD/+f/3KAU0bYNKoWl8r/ea9Aoxrn2Ub3ta/sKEnQ51QB9YU/i6BNm/HdyfYn3znxa3ONBrXjFSS7ssK6x9G0mC8Czz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272073; c=relaxed/simple;
	bh=v1WKoz9xUGwYHrvTBjW5q7JHZzJGq7yhgX2nxSlbwsI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B86U/bPKAQrBVZKTQ5WYt2/YpuxY9Yx4sJVsnE+EyaUemMYmM2R4WwRoFY6kfEVwynnW2d2rFrPeC7MNBmfwq2FkzXxWmrSG4gv+pLwps2SjkjG5c1+XAQqoWc4X9so1RMkQ0nAoeVW7Dpjss91khQaxZ+4H1CCIbH2wBR0GIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e580be9806so4994265ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272071; x=1755876871;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UBBw7L5NC+UoNNtVsBVt3nBBNgpwnO+Xo1HV/zu+i4=;
        b=mTv3wL8zUiCDgiu00xUjYzYCyC/iWfb1oCV9gw3osIv1QlSxJPpgJPyGExynR2T8YN
         zJ4XXfoOFxw8DxhJs6GxMXHLBjoEmdkZwV3bPsg4OfZnWqPutSOmyBPfT++3mpTYcNov
         eSDFm0r118it8Hr37ctPlKE91qB1TYQVrhY0/bW2lkupfbg8GkPxWqDDDwlvbvVZOS6F
         bvTCxgJJrnzaKb5x4M+mz6IpwS4iDe3YwItG0c/B99crfXes6NYK3+mfTrBGE49EJ8YK
         DkUf5BXEiM1kfYCp0b0O2Z3A+SnbY5PncHvSRA8/s5Ogr/2qXGmXrGlVWEZA+up3nNg5
         yPBg==
X-Forwarded-Encrypted: i=1; AJvYcCW0I9fhGK+BJ6ie+00/VXcWpKnYF3brJHDEJgVIundoXucg8qAvB7QTZcqjBPFRRsjwPmeBisahV9OjUnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cFPHHemEgPKaBzT51Q8Rvn8K6aLKdrBxszXkUZ/uBzgc+1ju
	vNrybLvVhDiI1WiI2X5aRrW2FbNuFUDlDq6o5KIplXBNybGGczzY89F/6U/20pWZ7VFz4b6cLuY
	1VSctIOprLPV594wrIUxhEK3xqHYVt+GclOMBR7wTP+nMp4CopHVfJmG3zuw=
X-Google-Smtp-Source: AGHT+IHQoo+abLPqcmAewudmcI5c1OLdi/lygZI83wNwmtArrInvX3MFB19TPtHHNoFldZzz+xEf4PrZB5oaDLrBzd/gWznEyRxm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:3e5:4eb2:73db with SMTP id
 e9e14a558f8ab-3e57e80df84mr41721855ab.5.1755272066506; Fri, 15 Aug 2025
 08:34:26 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:34:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689f5382.050a0220.e29e5.001b.GAE@google.com>
Subject: [syzbot] [kernel?] KMSAN: uninit-value in process_timeout
From: syzbot <syzbot+2a895bf937943f1666cc@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0cc53520e68b Merge tag 'probes-fixes-v6.17-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168dbc34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80850d07adb04ea2
dashboard link: https://syzkaller.appspot.com/bug?extid=2a895bf937943f1666cc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cad3c74a9bc2/disk-0cc53520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b87febcb296/vmlinux-0cc53520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0dd5c054303b/bzImage-0cc53520.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a895bf937943f1666cc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in process_timeout+0x59/0x60 kernel/time/sleep_timeout.c:27
 process_timeout+0x59/0x60 kernel/time/sleep_timeout.c:27
 call_timer_fn+0x4c/0x520 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x80f/0xd90 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0x3a/0x80 kernel/time/timer.c:2403
 handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0x84/0x90 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 __nr_to_section include/linux/mmzone.h:1937 [inline]
 __pfn_to_section include/linux/mmzone.h:2079 [inline]
 pfn_valid include/linux/mmzone.h:2161 [inline]
 kmsan_virt_addr_valid arch/x86/include/asm/kmsan.h:94 [inline]
 virt_to_page_or_null+0x99/0x180 mm/kmsan/shadow.c:75
 kmsan_get_metadata+0xfb/0x160 mm/kmsan/shadow.c:141
 kmsan_get_shadow_origin_ptr+0x4a/0xb0 mm/kmsan/shadow.c:102
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
 __msan_metadata_ptr_for_load_8+0x24/0x40 mm/kmsan/instrumentation.c:94
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:409 [inline]
 batadv_nc_worker+0x11f/0x1aa0 net/batman-adv/network-coding.c:719
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:463
 ret_from_fork+0x1e3/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Local variable timer created at:
 schedule_timeout+0x44/0x240 kernel/time/sleep_timeout.c:63
 kcompactd+0x470/0x2340 mm/compaction.c:3187

CPU: 1 UID: 0 PID: 3876 Comm: kworker/u8:20 Tainted: G        W           6.17.0-rc1-syzkaller-00038-g0cc53520e68b #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: bat_events batadv_nc_worker

=====================================================


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

