Return-Path: <linux-kernel+bounces-890224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05394C3F8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14ECF4EF49D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4062BE02D;
	Fri,  7 Nov 2025 10:42:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBF2BD015
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512126; cv=none; b=L5E+V3szKAZU0br84zF+nx3DKH9RsYTDUl3eiC/F9kU3oJybYBPwoK8W+0z+H0bz43S5vmt8lLnm+i35ylnG4EBGH/JC+L6Zx7O7kC5fSn/T4ig8N5uGsKjtDzBmt0pGa4MwS0ita953vc2yRJlCQyjHAL/FG4CgFlZVfWTenCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512126; c=relaxed/simple;
	bh=UwzNX5gtnosq5BPJI2D8ARsj73GqkPD9Iy/EIFiwA1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pfu3zE8JcXXDY8DONoxhr9f3kvslRuqpmIDY9huVMfN9IZsZnCPJaLx3eYLjfTP5lr5mv/Tj039VyhvOUPNQ8UvWXTEdIm2V9vH2rdWqglzAQtxtigSV8hLzy0xreZyht7Te+e794qQNCg/Ta440KtWGSX/8RUnbB+8BrfxfJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433154d39abso22201435ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512122; x=1763116922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2gJiFgpwGwBpB12E7bsJT/H8egDLqWQaD2OUO9Hlmk=;
        b=EOZr+Z4zpqtHI1LBLO4wQFu3UhXaXHA35WP1HUktRz3tc+A9CLKwxAaORsyWPfPZvF
         pA8pGABz+rIm9vs3Cpw3+4aPnN4Zfp9CDo+gLrvekTLMclpANvEVGJdduAjNc7I03Z1K
         O7h6WCYcBsnudeiJN76S/FNKdOt1cHWzyqwFbau8khTVMw1G3i0bQduE9RUpuANN5Fcv
         qgmPbDZvsm6gFYK2vFkEBOZ0thTxTChByhVRUKEoBJcHAeduRGMgLBM8gBJydzqIduSI
         +nd/j6yxr2Aa2diGYgRlBxOa5rSuaw2hfIw2ruFG2C77q8zzW91p2hmywpKidqIIyonJ
         xMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0YvwWywmceVPfAJ63aAhVlxnP5qsAp3jQIQPbJqcmT3fsO2slIQoyl16nAY9N2Zx9b6cVHonP8bQF444=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcyddcmleqSI/HFKySSoytrHeMHwR/eVD8/oGKHj3kXDd07IA
	3nHhcx2eN0BVUOvpU5vyHt3qDuhVOSSmSltSMdU3UZnFRSZIM8jPrluORfAaAvyEJSNwzFlJGhv
	JPfKP64QS08XwD00dg1b3Bt2Dq+GJtNhkgHPBm2shL33Y5wAcHbgIN4Nu7FU=
X-Google-Smtp-Source: AGHT+IH1jzOUVK60SJvlAUIWobqq/mllrrQrSknYb8JZ8ZWTzx0s2evme+8M8KXLFX+k3Pk45XNsB4IEI+phBKOxz5RE0nhXmed4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:430:bf89:f7f7 with SMTP id
 e9e14a558f8ab-4335f4a0f7dmr45779325ab.13.1762512122057; Fri, 07 Nov 2025
 02:42:02 -0800 (PST)
Date: Fri, 07 Nov 2025 02:42:02 -0800
In-Reply-To: <20251107101419.15312-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dccfa.a70a0220.22f260.0038.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in alloc_pid

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:288 at __ns_ref_active_get include/linux/ns_common.h:288 [inline], CPU#1: syz-executor/6396
WARNING: ./include/linux/ns_common.h:288 at alloc_pid+0xad6/0xc70 kernel/pid.c:285, CPU#1: syz-executor/6396
Modules linked in:
CPU: 1 UID: 0 PID: 6396 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_get include/linux/ns_common.h:288 [inline]
RIP: 0010:alloc_pid+0xad6/0xc70 kernel/pid.c:285
Code: cc e8 7e d6 34 00 be 02 00 00 00 eb 0a e8 72 d6 34 00 be 01 00 00 00 48 89 df e8 05 d8 0c 03 e9 84 fa ff ff e8 5b d6 34 00 90 <0f> 0b 90 e9 2c fd ff ff e8 4d d6 34 00 90 0f 0b 90 e9 5b fd ff ff
RSP: 0018:ffffc900035d79d8 EFLAGS: 00010293
RAX: ffffffff818cf9d5 RBX: ffff888075669998 RCX: ffff8880279b1e80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff888075cab901 R08: ffff88807566999b R09: 1ffff1100eacd333
R10: dffffc0000000000 R11: ffffed100eacd334 R12: dffffc0000000000
R13: 1ffff1100eb95751 R14: ffff888075669830 R15: dffffc0000000000
FS:  000055556cc43500(0000) GS:ffff888125b79000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7cfd1156c0 CR3: 00000000246e4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_process+0x18e7/0x3930 kernel/fork.c:2196
 kernel_clone+0x21e/0x840 kernel/fork.c:2609
 __do_sys_clone kernel/fork.c:2750 [inline]
 __se_sys_clone kernel/fork.c:2734 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2734
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cfc385e13
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffeab10e9d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7cfc385e13
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 000055556cc437d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 0000000000021378 R15: 00007ffeab10eb70
 </TASK>


Tested on:

commit:         9c0826a5 Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=162110b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f8fcc6438a785e7
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12afd812580000


