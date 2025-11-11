Return-Path: <linux-kernel+bounces-895547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22996C4E421
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2373B0E12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E94359713;
	Tue, 11 Nov 2025 13:54:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23F357728
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869246; cv=none; b=Qb7eHq0vWyAvC43m6/RsRHehGd/jl61OkVQOkqHWy+wJfLJLNR7dA2kD5RssJLw4W3YTvDpD06s4f6uOtgU5DPx0TpyuSNqiKya8UUbIV8qWxXWfP1guGJSLGouxiOfbZ9U4ZUG+D0xxf3tK1g3MJ6HZdclS9Z7WGjb0Sfhdh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869246; c=relaxed/simple;
	bh=X8WUj/UUE/HaiXs8ucnfUOYo7hXxYs7nkqqAARyDUCw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QGyn1zVuW6SXCgi9cRqjxy56iCX5Hcp0w1TU4i/inEGymAU2YD2JV9s6xugvvP7ygvncVOK9wLNOEMPsySiboAVtKFQcnofVe+k/0OfGSAkaKq5yEQG2Rkf0idpLyrdgYEHd9kZkMdZGwXmL4j/GZ6Dq6B0Pw7HZT/TLqXKfJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43321627eabso143391135ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869243; x=1763474043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrLMaRQ/hBpd55way1lE7BPz/NQrzKA1qbuKTrOT6kg=;
        b=bPyvcvWoRq6sazHSGTFPVVxZxYLiP2IuOG6OilDL8dlgnXHYmwbsqdH76OO12voSBX
         2iedqxMrEhHPrxctdYy7NHf6v+LkN0SKSmB97A3vz0iDMairAsUGptUVa3ojsG4CmC1F
         X1BDaJ+InhZ9yJw/w4RI/m4vSFOiKo1y6QxPJHCAT2Sd4Bw9GQ+uXLp44NA1na++jXoL
         ejnuhI80JnVWU+wP2P2Ui0bZf72TG8boPTA5UitIR8AAJX9DM9ODHrdoBND7KhTXqWO+
         pLU1Ykm3EqKcIKV4DhTzjUFWeKvtly/Pc5HL4oNA4M6wX33U2JX31esmhoI4/p29B0Zp
         Nu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVob8KPgzoMHgzw3mkNSqEuY8OldXaRqYVi5wNmd/28qUPrX+PHa6kDrSNlrk7cG9AD+C+SxbYwhLSHQW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGNDbQeSAIAkEYdxOHxPO1SMypGMHCqIlHPPYMhFi57W8mPoy
	tvSyPQIh0aLwKSuqrD6hbGkL98bSkJTB/TKlgKYgVPbbeBXHnhboj2/AZsSqyzH7yk6/vpc8SKn
	v2b8EvXFShcu6By+vn/jy/Vy4glg0AiBXFwt2WmerHhg44NvJhM1y2SGJMHA=
X-Google-Smtp-Source: AGHT+IEXkE2G6QwYJ+3X3rDvjPn84FiKipnvhlr8SNan8kdkQwAY+qxHrQzY2Y2cKGdKCVDkCGYarxUrNvCfY9e+fel2SDu90b4o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:433:7a5f:9439 with SMTP id
 e9e14a558f8ab-4337a5f9550mr101056925ab.24.1762869242560; Tue, 11 Nov 2025
 05:54:02 -0800 (PST)
Date: Tue, 11 Nov 2025 05:54:02 -0800
In-Reply-To: <20251111-komponente-verprellen-a5ba489f5830@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69133ffa.a70a0220.22f260.0139.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_get
From: syzbot <syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __ns_ref_active_put

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6510 at kernel/nscommon.c:171 __ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Modules linked in:
CPU: 0 UID: 0 PID: 6510 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Code: 4d 8b 3e e9 1b fd ff ff e8 76 62 32 00 90 0f 0b 90 e9 29 fd ff ff e8 68 62 32 00 90 0f 0b 90 e9 59 fd ff ff e8 5a 62 32 00 90 <0f> 0b 90 e9 72 ff ff ff e8 4c 62 32 00 90 0f 0b 90 e9 64 ff ff ff
RSP: 0018:ffffc900038dfa60 EFLAGS: 00010293
RAX: ffffffff818e5946 RBX: 00000000ffffffff RCX: ffff88802f641e40
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc900038dfc00 R08: ffff88807dbaac6b R09: 1ffff1100fb7558d
R10: dffffc0000000000 R11: ffffed100fb7558e R12: dffffc0000000000
R13: 1ffff1100fb7558c R14: ffff88807dbaac60 R15: ffff88807dbaac68
FS:  0000000000000000(0000) GS:ffff888125cf3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555674424a8 CR3: 000000000df38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nsproxy_ns_active_put+0x87/0x200 fs/nsfs.c:702
 free_nsproxy kernel/nsproxy.c:80 [inline]
 put_nsproxy include/linux/nsproxy.h:110 [inline]
 switch_task_namespaces+0xc2/0x120 kernel/nsproxy.c:223
 do_exit+0x6b0/0x2300 kernel/exit.c:966
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1108
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc6318f6c9
Code: Unable to access opcode bytes at 0x7efc6318f69f.
RSP: 002b:00007efc63f910e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007efc633e5fa8 RCX: 00007efc6318f6c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007efc633e5fa8
RBP: 00007efc633e5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efc633e6038 R14: 00007fff3109d6b0 R15: 00007fff3109d798
 </TASK>


Tested on:

commit:         cc719c88 nsproxy: fix free_nsproxy() and simplify crea..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=147c8658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0a8655a80e189278487e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

