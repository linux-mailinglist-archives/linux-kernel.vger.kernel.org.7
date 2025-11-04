Return-Path: <linux-kernel+bounces-884514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884AEC304E4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EF518937A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FAC31280A;
	Tue,  4 Nov 2025 09:40:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117128C00C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249205; cv=none; b=ksDc/auQL2sa8T5YKpLWokIYCSPcldk+cMHS/bf4IySn+9rVkaanJNqu+gQ434cCF0jn2IEbcYgc+fwdE3RCcqxLc5g2F073vP1c1ZAcpMMgqS4OUZD8R+NQ+JE8/duDHzNKrCyCofijRbyY57E31P29RqIESvlkaCoIady7+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249205; c=relaxed/simple;
	bh=E7nZ6GFUkTVgFUABAsx92gyYzYnFgkBlu9Wr6cL/pgE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VE8BnQxVSzYZ4svNWozh7TwRSTp4+DDIHap3lgYJkDWISoDQVCH1fkg4nuxjsbaucRC0rKfV2CtHElOIzHRkr+TaRYZMkChc2d2ZAUxTBCpsw/E4Vnm81pyYkRr/DJ/2Jxjl9ZVepTwLPt99kPlKO4nebE4+vueMY6/rJGPA2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so772028239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249203; x=1762854003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGAR11hiufJhG3sRlRo7j8oVrQ4L/QaQQgz3dJ+Dk98=;
        b=GOS1NUAtpLkMF7cr9UChjfNKyFT4/4SkgCLhbcPCElMN6nHSypDTNxw+NNorfH+lg0
         XrwtJa89s2bw2Fcb0D4dhOkD/ol4MN/r+x/7suMPFDkv0IHkAbXmLJbdbWFLoyl53593
         L7eIOyFkxAmm5KLHxkkPCgdLhJMe18ixw+ycTNkfJThzQkty97Rs3Bhk5+NJe5pPb1u4
         NSr9mu4/4+6qVm2KDyzULeWbVesNfmfvl4F22wfEks2ia5TBrXy97Mx57bTGDswZQick
         pZjUInhAc+562rtkdoYxBbYjXcFk9LAv1E+tzw1aozgUBZlcKevAleBCi4/dNX+YrldA
         iuDw==
X-Forwarded-Encrypted: i=1; AJvYcCXysUClsb06jkgwRbJuC0Si1MmJtwizyoRWfg/peTjHKnBmVAQUtiXx5OntTw3NBfzozxQgfmsuD77K9Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55/h9dsMCKmd3HsG7075B2gWli5RzCW+4oGY3pauDzKMgI5SX
	kkx76Er5NHH2fExBorlMMzywajngnjfOeB/qKIvREwtIriUATfYos2FYSWDLBOUEueqbNiRvRO1
	eXqOxNU0yi5oHd2hbDjroPE98qbx6cJb6nQrS/0UUUTLGoG6ATcjR9KPdsME=
X-Google-Smtp-Source: AGHT+IEEjxm+5s+rJ33H49gIcqLRRy7fZeSJDjg856dE443DCHslRdWsmIAMOyoKDRPzVjKRdAJApbOyzf5fe9MH1jsAYNVEnOOo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b10:b0:948:3ec6:7813 with SMTP id
 ca18e2360f4ac-9483ec67ad0mr1251363639f.12.1762249203297; Tue, 04 Nov 2025
 01:40:03 -0800 (PST)
Date: Tue, 04 Nov 2025 01:40:03 -0800
In-Reply-To: <CAHxc4buC59r-8V89TqXQPT-PnfSed4YU17Okc8jnX5hek22bwA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6909c9f3.050a0220.98a6.00aa.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] kernel BUG in __filemap_add_folio
From: syzbot <syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com>
To: dileepsankhla.ds@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in mpage_readahead

------------[ cut here ]------------
kernel BUG at ./include/linux/pagemap.h:1398!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 15896 Comm: syz.2.4490 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__readahead_folio include/linux/pagemap.h:1398 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1424 [inline]
RIP: 0010:mpage_readahead+0x399/0x590 fs/mpage.c:367
Code: 24 84 c0 74 08 3c 03 0f 8e 61 01 00 00 44 8b 7b 20 89 ef 44 89 fe e8 f6 a2 72 ff 41 39 ef 0f 83 9f fd ff ff e8 68 a8 72 ff 90 <0f> 0b e8 60 a8 72 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc90010c6f640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90010c6faf8 RCX: ffffffff8248e65a
RDX: ffff888029b1c880 RSI: ffffffff8248e668 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90010c6fb1c R14: fffff5200218df63 R15: 0000000000000001
FS:  000055555fc7a500(0000) GS:ffff8881246b5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2dc63fff CR3: 0000000029c5c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 read_pages+0x1c4/0xc70 mm/readahead.c:160
 page_cache_ra_unbounded+0x5d2/0x7d0 mm/readahead.c:264
 do_page_cache_ra mm/readahead.c:327 [inline]
 page_cache_ra_order+0xa28/0xd60 mm/readahead.c:532
 do_sync_mmap_readahead mm/filemap.c:3304 [inline]
 filemap_fault+0x152e/0x2930 mm/filemap.c:3445
 __do_fault+0x10d/0x490 mm/memory.c:5152
 do_shared_fault mm/memory.c:5637 [inline]
 do_fault mm/memory.c:5711 [inline]
 do_pte_missing+0x1a6/0x3ba0 mm/memory.c:4234
 handle_pte_fault mm/memory.c:6052 [inline]
 __handle_mm_fault+0x152a/0x2a50 mm/memory.c:6195
 handle_mm_fault+0x589/0xd10 mm/memory.c:6364
 do_user_addr_fault+0x60c/0x1370 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7ffbdbb58088
Code: 66 89 74 17 02 88 0f c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 0f 1f 44 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 62 e1 fe 28 6f 54 16 ff 62 e1 fe 28 6f
RSP: 002b:00007fff9dac8778 EFLAGS: 00010202
RAX: 0000200000000080 RBX: 0000000000000004 RCX: 0030626c6c756e2f
RDX: 000000000000000c RSI: 6c756e2f7665642f RDI: 0000200000000080
RBP: 00007ffbdbdd7da0 R08: 0000001b2eb20000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 00007ffbdbdd5fac
R13: 00007ffbdbdd5fa0 R14: fffffffffffffffe R15: 00007fff9dac8890
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__readahead_folio include/linux/pagemap.h:1398 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1424 [inline]
RIP: 0010:mpage_readahead+0x399/0x590 fs/mpage.c:367
Code: 24 84 c0 74 08 3c 03 0f 8e 61 01 00 00 44 8b 7b 20 89 ef 44 89 fe e8 f6 a2 72 ff 41 39 ef 0f 83 9f fd ff ff e8 68 a8 72 ff 90 <0f> 0b e8 60 a8 72 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc90010c6f640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90010c6faf8 RCX: ffffffff8248e65a
RDX: ffff888029b1c880 RSI: ffffffff8248e668 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90010c6fb1c R14: fffff5200218df63 R15: 0000000000000001
FS:  000055555fc7a500(0000) GS:ffff8881246b5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555704e95c8 CR3: 0000000029c5c000 CR4: 00000000003526f0


Tested on:

commit:         9dd1835e Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10cdc114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c53bac41b8ca5327
dashboard link: https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103ee342580000


