Return-Path: <linux-kernel+bounces-745406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA6B11973
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABCA5A1176
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E32BE7DC;
	Fri, 25 Jul 2025 08:00:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AED2BD5BC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430407; cv=none; b=P/PTJ4uXWqnnDdjSYn+MhLZqwHXEXTf2wMKdKrHqMa4ucIzkhp+buvEUBaMHO/02IiSRuxyco+zZe9HSJfyRSQrjG48HIKP0fUg6msNeFjQF6o9IU1mWfaQhrYJ37NOfGfSsfer/Bfq/tbz6KLby4j3kdMzJZTvVPbru+4pt+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430407; c=relaxed/simple;
	bh=JvkhmTDCdPG1xv4tzQH2A4Nj4Z8EfcMJExO9GYEP5SY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NhM2bZkpttdr4mMtdOrRyQLdGn7cQledDIDtDxNB9s9X3VxSQc8NyOX8KL49k5gIUmEX2MS22DSN4c/tqezdgJ3v//VVTU9xzcJwrGm2espqo4GhY+PXuBWkW8LnhHQ7k9Fdxr2a/aqBJAB0xH3Up1J7aByG+4tT7wGTaG5r6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c30329a56so378604439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753430404; x=1754035204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKYnQelmgpEIMDshRR7DJ4dh89NnU9mmLSZGNHWaT0I=;
        b=FHlI6X6GWSQEDCh5GTVwUUYyAEICUsmjM1fV7l/YLQwK+mIxCVHVL/NeXH4Bfi1mO7
         SCTW1x+wP06EdRTs8OHpyJXaP+boEkvr5DaVKNX8iHaYRv26M1xdsa0xfIkYIlVGPXhZ
         IUh9zr3YjJNj9JrXPwOVYldrwkeNjQ0l4YM/Yz7xQ+88FizvaBA4eVLYyIUGrkQKbkYb
         boDMuHepqfWQFo8UqQMnPQ7dcvUOOfUg+sjJqsfRzQH/i8mgPaljdbTARiDogXRomJLe
         z6FP7PBreSlH3aIo6/vkVPRjrionmaXcsL7WpZhtsTl3gNFCakkxzYr6W8SHI/ISqQyF
         iIRw==
X-Gm-Message-State: AOJu0YxgWcRBTfrI1m3Ja9b+ln1v2gxG0q1iUXcL2WGCWWhP8AvvzJO9
	O/w4H+0+8csK2VPIgJne9aLW54z+J9ZEtdkfK0lV3WDf3V6QpSTYgAHU1CPBI5C/uikrukg3pgK
	C0mRKY93c6tN63SAABOB0GfjFcvkuvnXM4QbqdE/WURT4NJEUvwkD1XZqJRw=
X-Google-Smtp-Source: AGHT+IFejj2GI1OiYVfnlmOv6lFjv8Mtq1niH0azHye/ORHtFnejr7oiuCKAZ0nwqj0qV8GQC2zwaEY718t+D2C8UvqbLP6Ra13b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1405:b0:873:1cc3:29d6 with SMTP id
 ca18e2360f4ac-88022977926mr163229039f.8.1753430404610; Fri, 25 Jul 2025
 01:00:04 -0700 (PDT)
Date: Fri, 25 Jul 2025 01:00:04 -0700
In-Reply-To: <20250725074710.1498616-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68833984.a00a0220.2f88df.0041.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in ucma_cleanup_mc_events

syz1: rxe_newlink: already configured on syz_tun
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000083: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000418-0x000000000000041f]
CPU: 1 UID: 0 PID: 6579 Comm: syz.0.24 Not tainted 6.16.0-rc7-syzkaller-g2942242dde89-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:581 [inline]
RIP: 0010:__mutex_lock+0x14f/0xb90 kernel/locking/mutex.c:747
Code: d0 7c 08 84 d2 0f 85 ab 07 00 00 8b 35 1a 59 56 0f 85 f6 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 93 07 00 00 48 3b 5b 60 0f 85 e0 01 00 00 bf 01
RSP: 0018:ffffc900016df8b0 EFLAGS: 00010202

RAX: dffffc0000000000 RBX: 00000000000003b8 RCX: 1ffffffff35c0a00
RDX: 0000000000000083 RSI: 0000000000000000 RDI: 0000000000000418
RBP: ffffc900016df9f0 R08: ffffffff889fb8fd R09: fffff520002dbf35
R10: ffffc900016dfa10 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffc900016df930 R14: 0000000000000000 R15: 1ffff920002dbf20
FS:  00007f6bbe81d6c0(0000) GS:ffff8880d6812000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002a054000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ucma_cleanup_mc_events+0x5d/0x490 drivers/infiniband/core/ucma.c:518
 ucma_process_join+0x966/0xad0 drivers/infiniband/core/ucma.c:1519
 ucma_join_multicast+0xe8/0x160 drivers/infiniband/core/ucma.c:1567
 ucma_write+0x1fb/0x330 drivers/infiniband/core/ucma.c:1748
 vfs_write+0x29d/0x1150 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6bbd98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6bbe81d038 EFLAGS: 00000246
 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6bbdbb5fa0 RCX: 00007f6bbd98e929
RDX: 00000000000000a0 RSI: 0000200000000900 RDI: 0000000000000004
RBP: 00007f6bbda10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6bbdbb5fa0 R15: 00007fff295a4748
 </TASK>
Modules linked in:

---[ end trace 0000000000000000 ]---
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:581 [inline]
RIP: 0010:__mutex_lock+0x14f/0xb90 kernel/locking/mutex.c:747
Code: d0 7c 08 84 d2 0f 85 ab 07 00 00 8b 35 1a 59 56 0f 85 f6 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 93 07 00 00 48 3b 5b 60 0f 85 e0 01 00 00 bf 01
RSP: 0018:ffffc900016df8b0 EFLAGS: 00010202

RAX: dffffc0000000000 RBX: 00000000000003b8 RCX: 1ffffffff35c0a00
----------------
Code disassembly (best guess):
   0:	d0 7c 08 84          	sarb   -0x7c(%rax,%rcx,1)
   4:	d2 0f                	rorb   %cl,(%rdi)
   6:	85 ab 07 00 00 8b    	test   %ebp,-0x74fffff9(%rbx)
   c:	35 1a 59 56 0f       	xor    $0xf56591a,%eax
  11:	85 f6                	test   %esi,%esi
  13:	75 29                	jne    0x3e
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 7b 60          	lea    0x60(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 93 07 00 00    	jne    0x7c7
  34:	48 3b 5b 60          	cmp    0x60(%rbx),%rbx
  38:	0f 85 e0 01 00 00    	jne    0x21e
  3e:	bf                   	.byte 0xbf
  3f:	01                   	.byte 0x1


Tested on:

commit:         2942242d Merge tag 'mm-hotfixes-stable-2025-07-24-18-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133490a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c445d2891161cc81
dashboard link: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f994f0580000


