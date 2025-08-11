Return-Path: <linux-kernel+bounces-763575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C4B216D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C36B17DCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6FA2E2DC2;
	Mon, 11 Aug 2025 21:00:34 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E326D4C9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946034; cv=none; b=AiRtCJIqagjKgAo9AcnbeYfxp9FZz7ggJNLjs6ZMpDh1/tlCOMu9LeDpxo89SupqZncvh0SNE8zHBsNXFQaaMpxYd5CQLjAZOl2lQ1h3mApkcTNp1fRHLI6yEZktnGrZ2Uytj/ppssCwv0aRQ9oQUsqLqTXD7AWrWNcXVFFwGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946034; c=relaxed/simple;
	bh=BliJ/aFMsVsObj1bAaT4rhb6IYqJd4MzzlzzAnewbOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eTC+EOwOR70qAwxJbkP9B4xHmCD2VytlZpHJNugcMs8iyDv22e+oSELEn+q6UUjZ36lV8Td4BqU2UxEf1hU9Wl3U4FoOe2oGzChg3O/hBM2s8SK+dRcXpBMjfpWA6yOxuZ9tYrNOU6P3WxCaeQeym3SWqQzMZTlz+6V+5H63MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-884094b589bso158259239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946031; x=1755550831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXFzaeKPl7+ctt3lbtfJdopbGgowMVL1yAGROD7siBA=;
        b=S0EyDxfG2ZmiWfJ8gfEIGHDBWKXpLYaOJrUvU0pIx9ovGbImpNJmd1swXnxw+YKyqi
         XNJrajppcmpZQAW/4HK7VLiQtrGvi5K5bU727R1hhIpd85c3Xn7hXtWkUCV/s+LHuSKV
         VmVAuIm5Z1hTAWKaYX6v1eXadatMzt9VnFYRojJLl/HuyGiKJpiaFlvN0Tkth9QJDTGl
         bHIge5qSZuEcB0/jQpzdM6UcsaBQ1r11WR8rptrLdBH4yjJjYvFR3y5IrsYAYlE53QBw
         xPXJRfWZDrYpIGTIAxWrPvEltv0mn3h7bSja3C592tAuQdpGLAB9qCUgSPp3Ak3N1PcN
         zL3w==
X-Forwarded-Encrypted: i=1; AJvYcCW+ro7knmjhXBRcfuvjzz8W/zUyEuFfywGoM10SK1X2hBY78guxDIJclTWQ0Mr/cc/2WXlSa432rLGtpr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnpbW4c+sh7fgzoKbGG+5JJqvUan5bXmALRBuBzUQbsB8iZZM
	/DT60C+cArPKci+DdEOPkGHr8lUH3y/Z7MWFyeSyHCPIdOqdq5/gQ7kawWH7/TbNR/Ll5bqvzzB
	G1qS4f84XoybeWi/H3nfXCE1EEllf/a18k9J5SWkXSUrTNhUQPYbAVNGulBA=
X-Google-Smtp-Source: AGHT+IEqaQ6ThhXPMjKJO3iwlVj68PUka5EQw4Hm1CDaAUSRkIk+Vl3lnL+omIB/QmXBUSfd+Jh/JBA367CtP1U19f3aZe+IWq2K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:cb04:0:b0:881:8bc8:b02f with SMTP id
 ca18e2360f4ac-8841c29c334mr205685439f.2.1754946031506; Mon, 11 Aug 2025
 14:00:31 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:00:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689a59ef.050a0220.51d73.00a3.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tx_monitor (2)
From: syzbot <syzbot+e069674d5df1b877c490@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6e64f4580381 Merge tag 'input-for-v6.17-rc0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15aae434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c81a94587811e52
dashboard link: https://syzkaller.appspot.com/bug?extid=e069674d5df1b877c490
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6e64f458.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cefe2e59409f/vmlinux-6e64f458.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b76a96a3deca/bzImage-6e64f458.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e069674d5df1b877c490@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 54 at net/mac80211/status.c:908 ieee80211_tx_monitor+0x2017/0x2510 net/mac80211/status.c:908
Modules linked in:
CPU: 2 UID: 0 PID: 54 Comm: kworker/u32:3 Not tainted 6.16.0-syzkaller-11952-g6e64f4580381 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_tx_monitor+0x2017/0x2510 net/mac80211/status.c:908
Code: 0f 9e c2 84 c0 0f 95 c0 84 c2 0f 84 ab eb ff ff 48 8b 7c 24 18 be 02 00 00 00 e8 04 c7 22 f7 e9 97 eb ff ff e8 ba 6f bc f6 90 <0f> 0b 90 48 c7 c7 40 69 08 8d e8 3a 19 9b f6 4c 89 ff e8 92 82 68
RSP: 0018:ffffc90000648c88 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000000000d RCX: ffffffff8aff0fdd
RDX: ffff88801cfd2440 RSI: ffffffff8aff2366 RDI: 0000000000000004
RBP: ffffc90000648e00 R08: 0000000000000004 R09: 0000000000000000
R10: 000000000000000d R11: 0000000000000000 R12: ffff88805ecf7930
R13: 0000000000000000 R14: 000000000000000d R15: ffff88805ecf7900
FS:  0000000000000000(0000) GS:ffff8880d68c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555859de808 CR3: 0000000029c8d000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 __ieee80211_tx_status net/mac80211/status.c:1093 [inline]
 ieee80211_tx_status_ext+0x1e9b/0x2ad0 net/mac80211/status.c:1218
 ieee80211_tx_status_skb+0x132/0x2c0 net/mac80211/status.c:1116
 ieee80211_handle_queued_frames+0xf1/0x130 net/mac80211/main.c:457
 tasklet_action_common+0x281/0x400 kernel/softirq.c:829
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
 do_softirq kernel/softirq.c:480 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:467
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:407
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ieee80211_ibss_work+0x382/0x1480 net/mac80211/ibss.c:1658
 ieee80211_iface_work+0xe6d/0x1360 net/mac80211/iface.c:1775
 cfg80211_wiphy_work+0x2c7/0x580 net/wireless/core.c:435
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
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

