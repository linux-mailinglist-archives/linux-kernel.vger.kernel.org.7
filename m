Return-Path: <linux-kernel+bounces-890332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1982BC3FD19
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809E318945C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412E13254BB;
	Fri,  7 Nov 2025 11:50:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CA3203BA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516209; cv=none; b=SG+om0UBjlj6/ByhPE/8umNO354o0MVuFaJ4iHKsScbjLAzm+bJQbs6FFc65hltyRNcsnDjUOg2wcP+UlZ1UARq88fBWMFZl0RP8xwuJbNWYREmd1Spdiag0d6ItWK4/Shv2CPKkoC9kv/3yOVG0z5D8qCuA2wY2T/xR5/gFLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516209; c=relaxed/simple;
	bh=+Vb1XqMOIDo2wK5fIqOX7gVhC9WfcpmkCIETlptO+q4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FoQ5SSe6QUolPCDviKEL1IZzODB8aFs4jexyvcy/0JiZUHBOgCekWwfURCqFKa94QjaiUZ9aTmZXchy2/0FT+E9wbHqiAjx4IluO6BhosK8A6uJ5EGcn20HJPB88pt2sCcbwZQtinjHvjs8yDYX5HvXMs07qDqBAINudKSkr8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4332987de75so18109915ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516206; x=1763121006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkTKtVvumQ9VHLgfkVM1oltuk3RhnNLtrzn38k9I4T8=;
        b=L4eFAOtcT7jkmlI97OuV7KNX+n4InxuEjthkGUAifNO8wozouIUjXOavnu4L0hF/J+
         5+OZ1DDFaqIKxmR62+dXouytG+oTyACjcOBP1AJm6iRC0S/4H8UvL5GBapFGnJx3AGHV
         YDVDRQtXS3Hj/xa/98habhNkaSHPWnYPrXBdg4cmlJmY0EWZ7dZzM6D+hE6b+/nOa3ks
         pfst9nsJYVf/ojWZdVf7iaw/OASE7x3P1Xw3hN097n8C0dlSSO8Idkp18G2nMKM/Sy0F
         9oYT5NBOOj0nT3O8z/kKXtvW21dmSrmVkbxPMHpNDDUFcDgoN0lxjCiyKVKCEvVlu6Ea
         gzFA==
X-Forwarded-Encrypted: i=1; AJvYcCXVqUTNbikZp1MHPg0rMbpHgImeb7D+LNHUJBBByz4gnN0W1Y+2yZPyE8aIa+NKajgBwqt66hkaFi++OLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYlz8INhvwXeyWkrnRSRWs+kYjnzgwFz7rlSJC+Nl3RWXaWcj
	jm6ApNEF2Sq1Ua7Vg8i80e3qUnv3ivs54ncna/VibDQjXg11S3IV6nF5/naLd67NjNwDA/+2Tsg
	5jssX2iO3khq1l/7oYkSYxWNIT63vRdKfhpGY/YmbuGwfpRqKfywWfhTP4qM=
X-Google-Smtp-Source: AGHT+IFlqNJAkKGhEBli9RpoLqoKtDjQVoI9lF128YggLzFI9DUpe2uEyAiBa3oGh4c3M+QF8m6Zy6p1PHJwfrcLgEqeJJDG72Un
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:433:56ed:b839 with SMTP id
 e9e14a558f8ab-4335f4612b2mr42380685ab.4.1762516206230; Fri, 07 Nov 2025
 03:50:06 -0800 (PST)
Date: Fri, 07 Nov 2025 03:50:06 -0800
In-Reply-To: <20251107111638.19373-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ddcee.a70a0220.22f260.0047.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in alloc_pid

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:288 at __ns_ref_active_get include/linux/ns_common.h:288 [inline], CPU#1: syz-executor/6382
WARNING: ./include/linux/ns_common.h:288 at alloc_pid+0xad6/0xc70 kernel/pid.c:285, CPU#1: syz-executor/6382
Modules linked in:
CPU: 1 UID: 0 PID: 6382 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_get include/linux/ns_common.h:288 [inline]
RIP: 0010:alloc_pid+0xad6/0xc70 kernel/pid.c:285
Code: cc e8 3e d8 34 00 be 02 00 00 00 eb 0a e8 32 d8 34 00 be 01 00 00 00 48 89 df e8 65 da 0c 03 e9 84 fa ff ff e8 1b d8 34 00 90 <0f> 0b 90 e9 2c fd ff ff e8 0d d8 34 00 90 0f 0b 90 e9 5b fd ff ff
RSP: 0018:ffffc9000213f9d8 EFLAGS: 00010293
RAX: ffffffff818cfa95 RBX: ffff888074ae5998 RCX: ffff88802a181e80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff888024e7a701 R08: ffff888074ae599b R09: 1ffff1100e95cb33
R10: dffffc0000000000 R11: ffffed100e95cb34 R12: dffffc0000000000
R13: 1ffff110049cf511 R14: ffff888074ae5830 R15: dffffc0000000000
FS:  000055558ad86500(0000) GS:ffff888125b79000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f201af156c0 CR3: 0000000078776000 CR4: 00000000003526f0
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
RIP: 0033:0x7f201a185e13
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffe79514908 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f201a185e13
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 000055558ad867d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 00000000000271be R15: 00007ffe79514aa0
 </TASK>


Tested on:

commit:         9c0826a5 Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f67012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f8fcc6438a785e7
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1755ca92580000


