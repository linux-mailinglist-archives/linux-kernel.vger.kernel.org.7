Return-Path: <linux-kernel+bounces-732530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F6B06829
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73481897A77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E242BE639;
	Tue, 15 Jul 2025 20:55:34 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B126D4F6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612934; cv=none; b=rql341jC3YG1aqLUGVu06eV8UNVnIHO31k29zHPKiy9WKrGR3ljQmlWxiqQ6yarXr5NsWyhztwhZefb0EQt/WOb2wUoUEOkap4JKq6Vb/G006j6U98BVsjWZb55Ka3yNjx2bHi2ApxQ7AqRc75tkeHSAJs1dFMDZWqNqNEvWmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612934; c=relaxed/simple;
	bh=9CNoR++wDZH7NsfjU8OM+KHOVHW57lf73ByuG1G6U60=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SNIoKnqG2Vu97DsSDlN27I4W5spF8L2ftWiitM6F2XKtiXzUyTuR7oCZrIyy/6Oxil100rRvlgSs4U4AyU36VYTnL3AXdFuEdfoWGGaBdeZdKyurBQ0xVi91bg6frmu8jxUir7P4oNCl8poPECNsSx1O2sJz5vhzBDKYD2y+Pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso1023208239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612931; x=1753217731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vHveuGolym5EQhvmtNqG6g0knqcjvQnZGLJgsJjMjQ=;
        b=F61yHYSef5NTcLRvMJuQ0l+g2M9O8cPt+4KrheEfdbgHutHPhLOYmfp4nH6vtno17L
         WNdZSKybdZrj+GIQMAvorlyADbitnnJshNyCsAFBlHMHx31fu/DQaqLdT8+5l2NautxJ
         lwnXFgwfNawAsE2idIps9D/ZcPF2C34cI/VeBWZ/VGpC3tczXDRwLH+2Yz7HOzIuIQ+o
         yM4vdVgM8iEMVvyntG60NgiWwawMnL2Ei3ovcW+WOjvyQyhxMIvXCXx5pDv4PQW5Cw2F
         T1jcsQ9Olw3+FOzPkHxI1aHpAckNfrUr2Qj6HKfatP9rXZLbmPoRIyd09JR/n5i31JCj
         beew==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7tIGjUy3bmFWOqFiUhpuHnupS2ODY0X89urbnr9ONLmJyK9vNsgJAr0ofAY9pAlHdcmVt35LOZWelSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXYBQ/Z4boTE4NsbP+c/dIk6hHzmM7aApNU1CtQokA1kBPR13
	uzReOUkd2rsKQk99i+26E0rDQpE2dzGXDrcvfgd8p1o+fywN0YUpRTmr7s5i456mFhS4vWQf2Jj
	0iz8VElk6/2zXIQClCCxt4k6rjZQV/D15keSCW/wsJUprc3ZJMfiaHuqK6vo=
X-Google-Smtp-Source: AGHT+IH41fXInBQhUVFmEC3BYpBSmFe7XYx0t5+7O+tY1xbSuO+MoSFA7uJ2u4Qx5gs1goSDakuSQ0X0NWold4XDloeyf2ZNnLbF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f0b:b0:85b:3c49:8811 with SMTP id
 ca18e2360f4ac-879c0842721mr125977339f.4.1752612930955; Tue, 15 Jul 2025
 13:55:30 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:55:30 -0700
In-Reply-To: <676d25b2.050a0220.2f3838.0464.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6876c042.a00a0220.3af5df.0009.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in inet_rtm_newaddr
From: syzbot <syzbot+adeb8550754921fece20@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17c3e98c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
dashboard link: https://syzkaller.appspot.com/bug?extid=adeb8550754921fece20
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d1098c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b08f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/13b5be5048fe/disk-0be23810.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d2b3b2ceddf/vmlinux-0be23810.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7e5fbf3efa6/bzImage-0be23810.xz

The issue was bisected to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10de9adf980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12de9adf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14de9adf980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adeb8550754921fece20@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

INFO: task syz-executor:6015 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc6-next-20250714-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26920 pid:6015  tgid:6015  ppid:1      task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5314 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6697
 __schedule_loop kernel/sched/core.c:6775 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6790
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6847
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:979


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

