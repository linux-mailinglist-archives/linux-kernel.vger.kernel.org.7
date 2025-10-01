Return-Path: <linux-kernel+bounces-838328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA7BAEF94
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D077AB30C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CECD24DD15;
	Wed,  1 Oct 2025 01:52:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88E46B5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759283524; cv=none; b=Yi65Hi0RJ5wn6DFnt+aPot8R+XazA/dMiJtqOTuBie4ojIklT5ZzbvrzXLZno38DCyaoOxvnJ27ztj0hklPIQcqGQYqjiyceDla3bTfpEN4mWwDXFl5z3eyg5rl0bcx1HZHk9W/MB1CAXqAq5cYPzccisPBf+MAaaiZ9Vm1+pm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759283524; c=relaxed/simple;
	bh=mkp5lbWPtC0CxqHXWnlRIOVnssYptbl43A+nX+UmIog=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T0DSltaW0ZpUmRqwHTBEqdztWiVnU9ajJ7tgdTXB9Mh+zQPImqrbDorW8QreYA71qoj3xkCV5K/meFz5CcGxDkN+NAOOA78f24obMrrA0uk7Ad5/HConyEFBokAIl1uAAqPaRkKn1kpx6KESJyu7lvPA9sLupHJsjh5DGFV54sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88c2f1635e1so689577239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759283522; x=1759888322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oe07uDamqXdlJDM4UE71BIRm9aaPF/4XNmdMEiXOIj8=;
        b=Vf0Y1dGV2QosgNmni8KKXh74ll2rGjq30YMwjkMu+NJMKUteef93+06CFg0iJoJvDf
         1TnOuX6Rvm+qcMY7Q+8/qxXX+PihkDNHxkywEUqMtYmb/dLQGL19KyUCnbbgsBPxrrPG
         HQUTapGEdsogbUx4CgDygvgB583mfy18UOx3kVnknb4Fj6pQvqh3QtcVd2AKrBe/xJHS
         BpYdXgyfnw2zS69kd/TydrQjuUJevfQ91MAfjoL0gNaUHWjVcFYlhTynEMGuaWzEzgoN
         fbb6Vumt7ru/C00VaiUKKLQZ+RfSv2sezp/HLl/68AVpJBDoIkmMHicLdgfa/fCHbew8
         I/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUr8Fy05J9EjcYW7pXzbO51J+N6VZiGJ8lmJzT8sRwl2k38zJEgMCSpkfLoxRISYwq0azFQPzZsHunU3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGASvKZ4/EiIWDHq1BckJv4UuVgiBuXAJA2UpKSQsX/Ehx73m
	R/w3J6kSkusMlSGeiSsdNtGR1Jzt0hUD88FGmhkPZqytQ8AW1AKTsCgzAbwQ34gszY5zO10DaJN
	lBuuDdC/cHkwqXvclSo4aKsK/hG7s4V0Oj3e1ZG5oxdtT0YaT33zcAG2NnX4=
X-Google-Smtp-Source: AGHT+IFTKlAxHdJ+M5tS4J7QHaZIreHoZVIF2RVhH+LBqhs0IUbr43CnRukOA3JW8jSd1vI60WKsy/YgxSaxsq/0SqXlaXoVt7wt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640a:b0:901:98a7:59b7 with SMTP id
 ca18e2360f4ac-937a947322cmr297350739f.8.1759283522286; Tue, 30 Sep 2025
 18:52:02 -0700 (PDT)
Date: Tue, 30 Sep 2025 18:52:02 -0700
In-Reply-To: <20251001004317.7786-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc8942.a00a0220.102ee.0051.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in free_mnt_ns

------------[ cut here ]------------
ida_free called for id=1124 which is not allocated.
WARNING: CPU: 1 PID: 6583 at lib/idr.c:592 ida_free+0x1f9/0x2e0 lib/idr.c:592
Modules linked in:
CPU: 1 UID: 0 PID: 6583 Comm: syz.2.30 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ida_free+0x1f9/0x2e0 lib/idr.c:592
Code: 78 f6 41 83 fe 3e 76 72 e8 c4 76 78 f6 48 8b 7c 24 28 4c 89 ee e8 07 39 0d 00 90 48 c7 c7 60 c7 cf 8c 89 ee e8 d8 51 37 f6 90 <0f> 0b 90 90 e8 9e 76 78 f6 48 b8 00 00 00 00 00 fc ff df 48 01 c3
RSP: 0018:ffffc90003b6f980 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff9200076df31 RCX: ffffffff81796158
RDX: ffff888026349e40 RSI: ffffffff81796165 RDI: 0000000000000001
RBP: 0000000000000464 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880216dd000
R13: 0000000000000293 R14: 0000000000000064 R15: ffff8880216dd008
FS:  0000000000000000(0000) GS:ffff888124f7e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d63fff CR3: 000000007d92a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_mnt_ns+0x121/0x160 fs/namespace.c:4099
 namespace_unlock+0x542/0x920 fs/namespace.c:1701
 put_mnt_ns fs/namespace.c:6139 [inline]
 put_mnt_ns+0xf5/0x120 fs/namespace.c:6130
 free_nsproxy+0x3a/0x400 kernel/nsproxy.c:188
 put_nsproxy include/linux/nsproxy.h:107 [inline]
 switch_task_namespaces+0xeb/0x100 kernel/nsproxy.c:241
 do_exit+0x86a/0x2bf0 kernel/exit.c:960
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x7a/0x100 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x419/0x4b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4240f8eec9
Code: Unable to access opcode bytes at 0x7f4240f8ee9f.
RSP: 002b:00007f4241e1e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: fffffffffffffff4 RBX: 00007f42411e5fa0 RCX: 00007f4240f8eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000020000
RBP: 00007f4241011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f42411e6038 R14: 00007f42411e5fa0 R15: 00007fff77993fb8
 </TASK>


Tested on:

commit:         4b81e2eb Merge tag 'timers-vdso-2025-09-29' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f53858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b28601618dc289ee
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16153858580000


