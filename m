Return-Path: <linux-kernel+bounces-729529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F30B037FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1513189C390
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92AF1CD1F;
	Mon, 14 Jul 2025 07:29:31 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A6226CF1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478171; cv=none; b=WXO8b7FSifekRjUHZtNmDL59oLnMFEHgnPTEx2YtKKw74kjm17cRuXBL8nYL1xAtmGI2HPGSnZpi/qIhghfezxxPyZUJjgQ2ZJeSG+o1xHTt1mueZ4xlkuxwCYdip8eOb/TbW2EJrPlx1So1qmLONjLGCMpPRjxYODAaxuqBx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478171; c=relaxed/simple;
	bh=QH1Jhej0FzVPznPIYzddw1W8EAKLzgdh7BWu6DGYLUY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Th6GnqZb7sk4qwvk7Biqfr7lFJnWkw2TsxBxC6PH/k8C9UftgacOtfdvPgmewTFSocYLSImkArPfu9sgyAeKn8291ziGYsHxEtFcxZBlP0ZlPQaUGUBx8KqzdCPrOKWd6UBR2dd1zgracJn7rZvLEJ5w6cHOCdHszGw3sIy95JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so407858739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752478169; x=1753082969;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH5zph4Aa8oUh/nc9g75ZN2VbOgnEtXQu3zZzhdoh1s=;
        b=qYR08PPuDKWcx251EQ4mggTGG9b/0oytmYTLf3ZFiwbvoYmpM1Ydv2TD4SWpCuYyzt
         S+vqss4IEHkaLjoVNuhjsRKXFsfszxPKxxHZiCzlRB50cybzCID3wXaT+WjwjcihYhOv
         PNGmACiRrSalXp3sQ1MggrCt5wJNRAaGojOPA65WNzf7/vGjh5RhsGoKuOyAEQUtJ1WP
         do6jkU7j+Wi4MWPiIGtIHe6lTJEImdKIlES10EXep2MPXGyfdG+XozEXDupM9pem1cmq
         IH4/fB4UwfFduT01NMQg1tYEpEVNfEJXLHU3uVwqnnsFvXlHNS4vGh0yWAyQXGMQhH22
         C92Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdGEn46pf/94xvcdR4ElnuIDgf6KNxrR7iufK88ch60U6Rm5X7vzthj157owPWItQpPb/GCfPdgl0N+ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWQ/MBHZng0gAKVrKD2fm2EULtx11tlA5WdeQa/Oxsgo5SMR5
	C8j0CMBvY1bFGrAu78NmCgfXz/slmnNeO3YB2R9rA83N4Hgvm21xLgPtYyeLZX4LHBXa4ySfhYy
	02vI73+to51Xug5qAO5iSB1F/MiiEiWBD0o7kWMFXB6xqwEzSE3ZF80SzQZ8=
X-Google-Smtp-Source: AGHT+IHvLH6ReDSIQEoy4p4zFIDgnNtY1ZeV4HdKb3HQjHfScbwlrlrGfrxqkxwIShGbKe+YDOeXtRNshuKNsb1G5NX2so7LgbtG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1481:b0:876:bb73:b709 with SMTP id
 ca18e2360f4ac-87977fa3ab0mr1384963239f.11.1752478168979; Mon, 14 Jul 2025
 00:29:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:29:28 -0700
In-Reply-To: <684c5802.a00a0220.279073.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, inwardvessel@gmail.com, 
	linux-kernel@vger.kernel.org, mkoutny@suse.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5d5d62298b8b Merge tag 'x86_urgent_for_v6.16_rc6' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dabd82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c47d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d2d0d46a0e87/disk-5d5d6229.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0bf6381177a8/vmlinux-5d5d6229.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f3ae8f165f2/bzImage-5d5d6229.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at kernel/cgroup/rstat.c:497 css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.16.0-rc5-syzkaller-00276-g5d5d62298b8b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: cgroup_destroy css_free_rwork_fn
RIP: 0010:css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
Code: 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 0e 01 00 00 49 c7 85 70 05 00 00 00 00 00 00 e9 00 ff ff ff e8 d9 09 07 00 90 <0f> 0b 90 e9 3e ff ff ff e8 cb 09 07 00 90 0f 0b 90 e9 30 ff ff ff
RSP: 0018:ffffc900000e7bc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8881404a4e00 RCX: ffff888124720000
RDX: ffff88801e298000 RSI: ffffffff81b45507 RDI: ffffffff8df37da0
RBP: ffff8881404a4e08 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881404a4e20
R13: 0000000000000000 R14: 0000000000000003 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124720000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000034892000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 css_free_rwork_fn+0x80/0x12e0 kernel/cgroup/cgroup.c:5449
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

