Return-Path: <linux-kernel+bounces-749106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05084B14A30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CBF1AA0116
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145B28540B;
	Tue, 29 Jul 2025 08:36:35 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861426AAB7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778194; cv=none; b=SPbkGVPP1rLBka7uM9jeLXXM4U3ekJeGC+bGDxdRrXBQj3Ygx5kuHBZMHdzeJrmrbe0fYyLPNG5JCCSB4wXezJw2cwkbzeImcGE7xILB65+3daYCws1qm5J2baiJRHw94JKXS6TwqbH4hvJtn/+NM0AUZasTMk3P2ZrEM7S48rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778194; c=relaxed/simple;
	bh=uCrJ+Iqbg5bbX+oCl5/x8BkXkWH6MwITKwrKsxfuTA8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HZ7GaDNg4cjIf4hSMHy6Tp6vkIEYJBpj49rxp6TDLJkMbGqCjv2L5vhoYoY7bmbG84xILFSHgu0Vq45Vu2qy/9K9bE0P+peceeAncV6xASco3n2SBFxoLMlUrMMeV/A31ZJ3drbvIH9cW2kTu+u2rXn8CpclVUI7d8uNw8CuDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddbec809acso62724785ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753778192; x=1754382992;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzeBGpjHSeszF/CW4rczNpxcYtUulLTjlrinCLimUgo=;
        b=Umy3lVBhreSXIxCMOBFzs5YcYV1TU215KiIE1+tY+6SL7F/Tgo7t7MLUoTgnE9scc2
         p6woBmCTUiJBe9UtvVf3r5cMjm1gpGL2Vf+imu+sKsSBelqqafLM7PEQDsJKpR1+b4ew
         8d63jtzAcJmaXdXTdEYw7tEH0sl3inscrKXgdgTEdyiNMiSF0Jbvt/Rc5WNbaN+uhDZT
         kQ7an/KxUdpF/oLW/5WklYY3mA26SSv5oPyF3NsiswRnp9fRsDcUsWFxxvs5iKKPMtOW
         oZVl4vFaHfKQfCMZmn57r5jWvabfYMLsdSt7UvFPwzKxbkkVgzzrzVStRlnmG4h6Fy84
         LLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpGyE3qXgMD7jHCuoRslUeGkZoxJGsIOPbLouavJLSPPu1vUAkYcW/vFVY207BCd73iWoYbGldAWZKdVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdepzd91Nb1WrRoW+IarIYt569xweIy/JMGDL3yYp9GYA6DzS2
	dXC5uS3YAbsOK8uqBqA9Jj8ZjlsD+T4bwJCKj6CPoV4kX6f945GwdpCvX/JVI8mabJv1aZ1taGi
	ASuYe60I2irpRqKDke95dXBs87Z/eykYTtGY95u2nMEV/4H7gQf3nhGjMe78=
X-Google-Smtp-Source: AGHT+IFhMAyYMoR3RdUP8l3Zi5v8mT3oE9q+69ki7bK73e+G54JA13PhrfXiFN/Ae6VgEeIlazaqNYY/dKIxqWUCL5kHonGwdr5W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3e3:d63c:3a35 with SMTP id
 e9e14a558f8ab-3e3d63c3f36mr161172835ab.22.1753778192366; Tue, 29 Jul 2025
 01:36:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:36:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68888810.a00a0220.34d93b.0001.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in wiphy_register (2)
From: syzbot <syzbot+e79f3349c93df8969402@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94ce1ac2c9b4 Merge tag 'pci-v6.16-fixes-4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14127b82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=e79f3349c93df8969402
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12127b82580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-94ce1ac2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2cc0fa87aefd/vmlinux-94ce1ac2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48c3cfe50b21/bzImage-94ce1ac2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e79f3349c93df8969402@syzkaller.appspotmail.com

INFO: task syz-executor:5486 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc7-syzkaller-00093-g94ce1ac2c9b4 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21640 pid:5486  tgid:5486  ppid:1      task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6936
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 wiphy_register+0x1980/0x26b0 net/wireless/core.c:1003
 ieee80211_register_hw+0x33e1/0x4120 net/mac80211/main.c:1589
 mac80211_hwsim_new_radio+0x2f0e/0x5340 drivers/net/wireless/virtual/mac80211_hwsim.c:5565
 hwsim_new_radio_nl+0xea4/0x1b10 drivers/net/wireless/virtual/mac80211_hwsim.c:6249
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 __sys_sendto+0x3bd/0x520 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7c09d9083c


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

