Return-Path: <linux-kernel+bounces-760923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA09B1F200
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436911892ED7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4F274651;
	Sat,  9 Aug 2025 03:18:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319422087
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754709485; cv=none; b=ulz1iWsvN/PO1xCLDxJETtHuztYcubNHCRwOjd+lW0F7On8tn6gotWtqfB611dWFaEhdJhSBbDTvFi1M8dEp4kUykCNTZ6tcT/qUvB02z/C6M+H09aVb/L793ajrLDeExM4jG+XNnXN2XpXp+gGqZ2tb+87efI6+R0CZWFzv1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754709485; c=relaxed/simple;
	bh=3FZp5rDyfmN5HVIj8s741xNkcHpfuZpEMUhXbadOT+4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J8rb1c855B2MRGENRBgokGr8cvydAHvu+Ktoekf/FpOqTTNeKi1bZSlokNz28I1ZiBEFGTIQCeautzoEhSa77mOuLuRK9faXwVXFiGPRtrMrKLkDA8CczIG3HVeeJUxDA4Bdjqr/3B+fcdqMv15RyTwVc7eI3ugSx99awETQpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-881776a2c22so601626039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 20:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754709483; x=1755314283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipDCZ8/JVfJbp10hTtQp1cTN91n5NPZ5QeW3sOUlr4w=;
        b=BDrWY3vil4uO84B6txzr+JFts3o/uLh4UxrfFh+9LPs/ueDGsCjkm0qh/EhEnz/f+k
         JIplMHDtC6AL/vLzA/YYuzSMT5+oDG7ztns/9Brpku4QmQAwysKV9CZB6i3qNgemy94k
         TQaYFCH5G4FHY8/Ww9VZjPUfs4Kf3/t/xcg5JUJbvFDqvdKyqtcLynMIPPcJkJt9snMB
         arJuWcHaZx+SOX4P9cIVgjLKWjONHUhihKrn9dvs/8sh0KylWqicPYb1WpCixoVkYBH9
         pTYfm/lciP0wgHwVwMfo/f6Ohlxq2s0cWvusKIeCSmST/d+KaCdWi6BHuTLHz7Ohr18z
         IIhA==
X-Forwarded-Encrypted: i=1; AJvYcCWeHHZuYtBsHxtx/0wKiyC19u+RoVWJe2LsW1ZKb+JfMqf89Vk2mL9JO2EzUQ3AsHaDBd1vNoLKnGrHLkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKePFItSzvoPrw6vavAh91PK/0iIESLrPF3ED+Z6omdVmEGHQ0
	QPJ+okVhGmCmoWi3p1LJa/Tm74WyqQpUT/WlkLrhojXOKyKsYVfgOAcq4p3jGaUYzOBxi8mXkuj
	gbyXiLpd627i6RrO6Wn4ez+Mg2zuIa2RwNod4fFcbdId8TFTYf++iwpRVEMY=
X-Google-Smtp-Source: AGHT+IHArtR2UooE+sXzaGWqiHLNq5Lyjq2tG5kEsZv8FjpmJKTIt8zWJGbK5bFHf0S+TZ43Be+wHBbiHbWUHx9U1a0fT9NAOoFn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c8:b0:881:8d1f:1a7c with SMTP id
 ca18e2360f4ac-883f127739bmr1051703039f.12.1754709483491; Fri, 08 Aug 2025
 20:18:03 -0700 (PDT)
Date: Fri, 08 Aug 2025 20:18:03 -0700
In-Reply-To: <20250809025317.4045-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6896bdeb.050a0220.7f033.00a2.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
From: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in __sk_destruct

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff8880777a8d68 object type: work_struct hint: kcm_tx_work+0x0/0x1e0 net/kcm/kcmsock.c:-1
WARNING: CPU: 0 PID: 7359 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 7359 Comm: syz.0.134 Not tainted 6.16.0-syzkaller-12063-g37816488247d-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 e7 9b 53 fd 4d 8b 0f 48 c7 c7 20 30 e3 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 aa cf b3 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 e7 fd d3 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc900035d7b30 EFLAGS: 00010296
RAX: 3388542328802800 RBX: dffffc0000000000 RCX: ffff888026a89e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: ffffffff8aa80950
R13: ffffffff8be331a0 R14: ffff8880777a8d68 R15: ffffffff8b89d380
FS:  00007f2fe43246c0(0000) GS:ffff888125c21000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fe4323f98 CR3: 0000000033878000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x3a2/0x470 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2348 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x113/0x400 mm/slub.c:4782
 sk_prot_free net/core/sock.c:2276 [inline]
 __sk_destruct+0x4d2/0x660 net/core/sock.c:2373
 kcm_release+0x528/0x5c0 net/kcm/kcmsock.c:1738
 __sock_release net/socket.c:649 [inline]
 sock_close+0xc0/0x240 net/socket.c:1439
 __fput+0x44c/0xa70 fs/file_table.c:468
 fput_close_sync+0x119/0x200 fs/file_table.c:573
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1572
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2fe358e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2fe4324038 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f2fe37b6160 RCX: 00007f2fe358e9a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f2fe3610d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2fe37b6160 R15: 00007ffd637a7ad8
 </TASK>


Tested on:

commit:         37816488 Merge tag 'net-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ddd5bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1652b2f0580000


