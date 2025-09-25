Return-Path: <linux-kernel+bounces-831858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61878B9DB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06A41728B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EE2E9755;
	Thu, 25 Sep 2025 06:37:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7B2E8E00
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782225; cv=none; b=GKveaDPGUP6ZuP+Hx17Gha6YhvFu1kpj7Q/jiPrM9g1O+1D3AquwZB80OGSbfLjdVgnIMzN1Wx1RNTQfrO5sPe4h/dcIgUOoEuO2HJ5jyS2R3oFq56X8BwDMr2Pw27EN5aC7sXwDVpLjHkkGgjIPrC6xCIlgHjqIyZqYPtkm3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782225; c=relaxed/simple;
	bh=demE953k/8g6Z1oErixQujhA/+098OWzGalYq0k+DqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=akdud2pmyIDNOFat+/NCfw6KbNjGC9SpPj4cqyCbO0/ZpK8niXJWCEaoL+339zqhC/jOX1PO0kWHtXSimC53uYh2+krScgbaLhwg3z3RTAiIDjwDlqNFbjy2pnzFdKvrRZRDCLdR8p+ZHY0iJzm1ElatdnENXR4+kWy0C7NfnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88d4b38d080so83053539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782222; x=1759387022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUIzH4w/M6SeRGtE882Vrxlub9oDlAhxIZZsUTGk2kw=;
        b=UE86+BjHjIn7vh+ln07AE98KXRaqxicLWmlECcqbCQhRqwZM0g8FuvRZy2qxmQO1pj
         9sV3U/LocvNnM2iLkfLCvh+JYYhSZ5Jth3uXIK89P7c3Yfi7ZkLZYlakvgIXC7U/zT2e
         k86uUOqcyiTGJDWQZP+X4i9XlUuT8a/q0MWMbm0L/iT6dDqtR0w4eU4fu2u9oBmyagRA
         WFpkh5yk1PQ2o5BoepdzTFtxPcter6oRWk6WnrrDFDgruSySHXRCXkVfveR0uIR+qqkC
         VXnwC3c8MeMbOrJ+7bSwf0hxyG2w8dWjadqcF1TZXSBDO19qrkKfZvIiqlQY3xQigImu
         iRvQ==
X-Gm-Message-State: AOJu0Yx67oFRF7TsQg1kRjEfJNs8Gf5h4VPMPt5gWKwPq4uFY0l+wEwb
	0vAhy8vXOmi+DwBk6YdmqQn7rarxZ68Rbt6/2OqDhybuN/6jjA0U9MBF9fXY9oZIaWSJWzbz6g3
	YFTCuXBTPsVAjhgTm7ti3rZux47fs5Sc4lrNEao2yUrCgKXdetZQ7T7UkTRc=
X-Google-Smtp-Source: AGHT+IEkbVFNGeCLw3SwVyD1EtFv4RoeC6RthcErlkhLdEdS0t89XM5NJGDfdPhEt+w6Plsehk5Mroyf2rNgSX3IuhFvdNsqBtd9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c06:b0:8d4:2004:ce3 with SMTP id
 ca18e2360f4ac-901527eefecmr344328739f.4.1758782222413; Wed, 24 Sep 2025
 23:37:02 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:37:02 -0700
In-Reply-To: <CABPJ0viXDF2o1MjbsUBC=0aaBx+CxArAr5rkt961TrVibqLLPQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4e30e.050a0220.3a612a.0005.GAE@google.com>
Subject: Re: [syzbot] [serial?] KMSAN: uninit-value in n_tty_receive_buf_closing
 (3)
From: syzbot <syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rampxxxx@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: use-after-free in n_tty_receive_buf_standard

=====================================================
BUG: KMSAN: use-after-free in variable_test_bit arch/x86/include/asm/bitops.h:227 [inline]
BUG: KMSAN: use-after-free in arch_test_bit arch/x86/include/asm/bitops.h:239 [inline]
BUG: KMSAN: use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
BUG: KMSAN: use-after-free in n_tty_receive_buf_standard+0xafd/0x98a0 drivers/tty/n_tty.c:1587
 variable_test_bit arch/x86/include/asm/bitops.h:227 [inline]
 arch_test_bit arch/x86/include/asm/bitops.h:239 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
 n_tty_receive_buf_standard+0xafd/0x98a0 drivers/tty/n_tty.c:1587
 __receive_buf drivers/tty/n_tty.c:1624 [inline]
 n_tty_receive_buf_common+0x198b/0x2470 drivers/tty/n_tty.c:1723
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1769
 tty_ldisc_receive_buf+0xc3/0x2c0 drivers/tty/tty_buffer.c:387
 tty_port_default_receive_buf+0xd7/0x1a0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x43e/0xe30 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa2d/0x1b80 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x230/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 n_tty_receive_buf_standard+0xaf6/0x98a0 arch/x86/include/asm/bitops.h:-1
 __receive_buf drivers/tty/n_tty.c:1624 [inline]
 n_tty_receive_buf_common+0x198b/0x2470 drivers/tty/n_tty.c:1723
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1769
 tty_ldisc_receive_buf+0xc3/0x2c0 drivers/tty/tty_buffer.c:387
 tty_port_default_receive_buf+0xd7/0x1a0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x43e/0xe30 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa2d/0x1b80 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x230/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_free_hook mm/slub.c:2348 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x252/0xec0 mm/slub.c:4894
 ieee80211_inform_bss+0x12f8/0x1420 net/mac80211/scan.c:160
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x1bd1/0x3460 net/wireless/scan.c:2380
 cfg80211_inform_bss_data+0x28e/0x8c70 net/wireless/scan.c:3235
 cfg80211_inform_bss_frame_data+0x6cd/0xaa0 net/wireless/scan.c:3326
 ieee80211_bss_info_update+0x8a4/0xaa0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0xa23/0xd70 net/mac80211/scan.c:355
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5186 [inline]
 ieee80211_rx_list+0x464e/0x6630 net/mac80211/rx.c:5423
 ieee80211_rx_napi+0x84/0x400 net/mac80211/rx.c:5446
 ieee80211_rx include/net/mac80211.h:5210 [inline]
 ieee80211_handle_queued_frames+0x14f/0x350 net/mac80211/main.c:453
 ieee80211_tasklet_handler+0x25/0x30 net/mac80211/main.c:472
 tasklet_action_common+0x35f/0xd70 kernel/softirq.c:829
 tasklet_action+0x2d/0x40 kernel/softirq.c:855
 handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0x84/0x90 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702

CPU: 0 UID: 0 PID: 4256 Comm: kworker/u8:23 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: events_unbound flush_to_ldisc
=====================================================


Tested on:

commit:         bf40f4b8 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14572ce2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7564f7873be81d2
dashboard link: https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12499ce2580000


