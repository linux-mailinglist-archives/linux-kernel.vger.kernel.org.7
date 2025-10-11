Return-Path: <linux-kernel+bounces-849159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC60EBCF4FF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 340A94E5590
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3526E703;
	Sat, 11 Oct 2025 12:14:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5F25A341
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184849; cv=none; b=nV2+WN+Zp1UlQopdOAKbFlarDzmdMZigDFQhPjnPF79ErPxKJCz0q7DEeazDbm3hEV3CwDkpKn0fT/jJibvH9I4epN36QG3TqtuXDLBDFUkKLjyoWjdiaK+ZygwzOMTxFVdPbekj/RiJE80X1wnHtT6iJmTUIAosCj77lh3zCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184849; c=relaxed/simple;
	bh=I83F9V5VIqbMSQpBHpapT0keh4blZrNPM0QbwjF4L1o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S4Z7gFgTP6bvSsEMNjguPBG5wP2uNJDFGnOFEYp+eD3UoEj/mA/0ON8iXaqp0QCD5u6X/gamTnk7m9CO6iexxPkQs5k8oqJfs9ycJcGgXeGwOyijXn+1BsZmdJC0Azf/N/diD5Hm14VQdiddlvI21QGsyqghiN4SXOihr1g4d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42e71d1a064so112007375ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760184842; x=1760789642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhdvdAIKmb7EyDvB1NfLmZRsfzM9p7ea1YK3oXkXXZE=;
        b=rT9a72S8y0zbLEV2PnZDkoOi+TE/wq1ftTKbc8FDQKSRTQT01RVL16k/PB2O+1lF7/
         8uK/1KNjdW3ivPgbzY9tPFzbTMNuzAhbkliCl8SSFXiLehJchmxrCXSnjLPuohutSyZV
         TgqKky98JKo8TycGZIRcBkaiXaiuFNwcTbvb52SyZpQOmc8kbQX3Ez+6wJC27oUTO8+A
         DtrdlVlKm4ETT9iWaLTB5+dbrGoIX0VRGCkdNwPqIB8t5DvPzBVrYpWRFtup4o2E/3Ny
         zWqE9iGO+oGJFhHK2J/Q67KpPnDdJ6WlFfZTyt6W0Ix5cXN5jrvTVnD3yBpJANfPac31
         IFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFX2x7T5XkCPo4MKIz8LKb2XJEIAVoJW0KcHZeGSdlQyiaBMXrwCp5ef7X8ThOUVrCrZPwYA+xOquQ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrE1XX2ni67DxAk1awNccgcyuP2g0C8YKecwpekQ4/+yy9GVP8
	223My9ieKUq5p5xBW8eK7tk5VK0kNPwNglQsf5mBxtLwFd9DpFykM4FKu2I5C944UF82msBoyZ0
	ig513F7mjdbELFTesziyP8BQ/GOY3VLX+JwVqsvHcdzFxpBi4REYvm5vOgxg=
X-Google-Smtp-Source: AGHT+IH1MDthq3EMrDnp8OvYUq701u0npKQ2sXSPoI3Z3+UBzuuJuoOb+hae+yKBPaq/ZkYhLiVzfxXVqXlwqK4Q14nXTamiaOnW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:425:e850:b2e3 with SMTP id
 e9e14a558f8ab-42f874537cemr167780825ab.32.1760184842592; Sat, 11 Oct 2025
 05:14:02 -0700 (PDT)
Date: Sat, 11 Oct 2025 05:14:02 -0700
In-Reply-To: <CAHxc4btH53u7Y3DRFmaiF3-pqumZi1swOgEi0r2_4=bTnKfjSw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea4a0a.050a0220.1186a4.0012.GAE@google.com>
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
CPU: 0 UID: 0 PID: 15521 Comm: syz-executor273 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__readahead_folio include/linux/pagemap.h:1398 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1424 [inline]
RIP: 0010:mpage_readahead+0x399/0x590 fs/mpage.c:367
Code: 24 84 c0 74 08 3c 03 0f 8e 61 01 00 00 44 8b 7b 20 89 ef 44 89 fe e8 f6 a2 72 ff 41 39 ef 0f 83 9f fd ff ff e8 68 a8 72 ff 90 <0f> 0b e8 60 a8 72 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc9000e897640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000e897af8 RCX: ffffffff8248e65a
RDX: ffff888078074880 RSI: ffffffff8248e668 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc9000e897b1c R14: fffff52001d12f63 R15: 0000000000000001
FS:  0000555574632380(0000) GS:ffff8881246b5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbdedf84130 CR3: 00000000697eb000 CR4: 00000000003526f0
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
RIP: 0033:0x7fbdeded986d
Code: 03 00 b9 03 10 12 00 45 31 c0 48 ba 80 00 00 00 00 20 00 00 48 b8 2f 64 65 76 2f 6e 75 6c 48 c7 c6 9c ff ff ff bf 01 01 00 00 <48> 89 02 48 b8 88 00 00 00 00 20 00 00 c7 00 6c 62 30 00 31 c0 e8
RSP: 002b:00007ffc828830a0 EFLAGS: 00010246
RAX: 6c756e2f7665642f RBX: 0000000000000000 RCX: 0000000000121003
RDX: 0000200000000080 RSI: ffffffffffffff9c RDI: 0000000000000101
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000002000
R10: 0000000000000013 R11: 0000000000000206 R12: 0000000000078a5d
R13: 00007ffc828830bc R14: 00007ffc828830d0 R15: 00007ffc828830c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__readahead_folio include/linux/pagemap.h:1398 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1424 [inline]
RIP: 0010:mpage_readahead+0x399/0x590 fs/mpage.c:367
Code: 24 84 c0 74 08 3c 03 0f 8e 61 01 00 00 44 8b 7b 20 89 ef 44 89 fe e8 f6 a2 72 ff 41 39 ef 0f 83 9f fd ff ff e8 68 a8 72 ff 90 <0f> 0b e8 60 a8 72 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc9000e897640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000e897af8 RCX: ffffffff8248e65a
RDX: ffff888078074880 RSI: ffffffff8248e668 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc9000e897b1c R14: fffff52001d12f63 R15: 0000000000000001
FS:  0000555574632380(0000) GS:ffff8881246b5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbdedf84130 CR3: 00000000697eb000 CR4: 00000000003526f0


Tested on:

commit:         9dd1835e Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17224dcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c53bac41b8ca5327
dashboard link: https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124659e2580000


