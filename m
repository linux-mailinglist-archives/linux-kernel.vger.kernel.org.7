Return-Path: <linux-kernel+bounces-755030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4923AB1A051
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE25F1895B67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA1253B67;
	Mon,  4 Aug 2025 11:12:40 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DE2517AC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305959; cv=none; b=ODDZP693SoL/WBAZrl1T0ILbXiZv0k+/yQbdW6Dgclnsg5mbyvnB4JMaE3lmt6Zt/k74u6KeLkpoxCrSDL59WQ1bW08SeTIafSxn0PXztVMw7Zbsa8Hfi94apoq4X23Gq6EgpT5GZbWYkgqWF65x3MvEKB+aAc0IisSGniYi/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305959; c=relaxed/simple;
	bh=sS1YT27CJtLoZAmprfV76F5Z1H4mkr6BMsHwJXvAoaE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tqofbKrPBw73lS2jZoiCQlT7942zPzG9fVHSpkP6Ek8NJGnFj+znj9JHivKzMpHYnZ47vtSsn7oMQyP8wymZwPKA6YmjCcrHHWo+KHV3yVE/OOMKCxn2Lx9TWaByZ0UNLPefPq2WbCsc6rjHCq5F7dRZzrcQONxRBLdfwjHGJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88177c70d63so111116739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754305957; x=1754910757;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZC4QBhhXxtpdVYVwy1WTCm0gMYAELnv1sLEfnwbWNs=;
        b=xQQhfJDVz65CQDb/wqrhWP286nS4GP8vKLb68waW/P9LBYux1XYT1SE+d99jHIbfoz
         RUCwiMpNRoHzU0/LJFFjW3vfbhtLo0RtV5l+SFQDRBzo5Q43FKCF81qQQlHoKBFle430
         pPPvt9kUwENwwrZ8Y/e2BDvM+oV4Rdq9nkXIeYmXBwsOpPqL/5FBdnRQeeSWSetpU5XT
         EwM7p+LAcxOhiohd0AXBsqzuv3ZLB0Kn4btLTIQSDkmHsLl0SPZIwnqNg+3LOqaUdVar
         BurNRBrN3FgDDPMQldWoR4kmiKyt10a1r/EJDZ3Zms/T5+zUyvk7xUTpOv+48Lbj9u+u
         eqpw==
X-Forwarded-Encrypted: i=1; AJvYcCVH3DZ/3mb7BcQGA5yBHvBVSYtF/W3zAOoJxk58rb2E/LGO4RdZHfP64bpQjfHHtRpRjlZ0fbMJEo71Qwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UMt8Jsy29q/IncwpPZ0wFoSGhDq32C4r34TRSDNTQu9SfSgr
	C38c0zOsn1c2AApXRRVj4KNnPQLlbHsp59rD3+Vq6nc94BCose/BGdkq9z4j7W68uQEtZYT2Vqt
	/37EexkbqSg9zLp9CGvHAceXAUbBguxXMVh6P8OkUwLQqn0iOs3MLo9cQNcY=
X-Google-Smtp-Source: AGHT+IFs9AdaOr2KbRyq2uBDNXmOAIq8TzhwKVvLOht03tvjs458CeoUQyq9O7YmYPMbVMr1ReGGRU26aXBDZrwwvDoEz4HNoivk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f0d:b0:3e3:f1db:d352 with SMTP id
 e9e14a558f8ab-3e41616f18amr165903325ab.15.1754305957281; Mon, 04 Aug 2025
 04:12:37 -0700 (PDT)
Date: Mon, 04 Aug 2025 04:12:37 -0700
In-Reply-To: <67f66c9c.050a0220.25d1c8.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689095a5.050a0220.1fc43d.0009.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: null-ptr-deref Write in rcuref_put (4)
From: syzbot <syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5c5a10f0be96 Add linux-next specific files for 20250804
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f23aa2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4ccbd076877954b
dashboard link: https://syzkaller.appspot.com/bug?extid=27d7cfbc93457e472e00
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1628faa2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12490434580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb2134de7be8/disk-5c5a10f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe8a36605e0c/vmlinux-5c5a10f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12df22603d55/bzImage-5c5a10f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffdb
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD df3b067 P4D df3b067 PUD df3d067 PMD 0 
Oops: Oops: 0002 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6346 Comm: syz.0.336 Not tainted 6.16.0-next-20250804-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:85 [inline]
RIP: 0010:raw_atomic_sub_return_release include/linux/atomic/atomic-arch-fallback.h:846 [inline]
RIP: 0010:atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:327 [inline]
RIP: 0010:__rcuref_put include/linux/rcuref.h:109 [inline]
RIP: 0010:rcuref_put+0x172/0x210 include/linux/rcuref.h:173
Code: c7 c7 80 72 94 8c be 68 00 00 00 48 c7 c2 c0 72 94 8c e8 21 f7 35 f8 48 89 df be 04 00 00 00 e8 84 90 bb f8 41 be ff ff ff ff <f0> 44 0f c1 33 41 8d 76 ff bf ff ff ff ff e8 ab 27 58 f8 41 ff ce
RSP: 0018:ffffc9000431f960 EFLAGS: 00010256
RAX: ffffffff89678f01 RBX: ffffffffffffffdb RCX: ffffffff89678fdc
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffffffffdb
RBP: ffffc9000431f9f8 R08: ffffffffffffffde R09: 1ffffffffffffffb
R10: dffffc0000000000 R11: fffffbfffffffffc R12: dffffc0000000000
R13: dffffc0000000000 R14: 00000000ffffffff R15: 1ffff92000863f2c
FS:  0000555583637500(0000) GS:ffff888125d17000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffdb CR3: 000000002465a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 dst_release+0x24/0x1b0 net/core/dst.c:167
 ip_rt_put include/net/route.h:285 [inline]
 pptp_xmit+0x14b/0x1a90 drivers/net/ppp/pptp.c:267
 __ppp_channel_push+0xf2/0x1c0 drivers/net/ppp/ppp_generic.c:2166
 ppp_channel_push+0x123/0x660 drivers/net/ppp/ppp_generic.c:2198
 ppp_write+0x2b0/0x400 drivers/net/ppp/ppp_generic.c:544
 vfs_write+0x27b/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda7098eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb2fc7658 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fda70bb5fa0 RCX: 00007fda7098eb69
RDX: 0000000000000013 RSI: 00002000000002c0 RDI: 0000000000000004
RBP: 00007fda70a11df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fda70bb5fa0 R14: 00007fda70bb5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
CR2: ffffffffffffffdb
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:85 [inline]
RIP: 0010:raw_atomic_sub_return_release include/linux/atomic/atomic-arch-fallback.h:846 [inline]
RIP: 0010:atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:327 [inline]
RIP: 0010:__rcuref_put include/linux/rcuref.h:109 [inline]
RIP: 0010:rcuref_put+0x172/0x210 include/linux/rcuref.h:173
Code: c7 c7 80 72 94 8c be 68 00 00 00 48 c7 c2 c0 72 94 8c e8 21 f7 35 f8 48 89 df be 04 00 00 00 e8 84 90 bb f8 41 be ff ff ff ff <f0> 44 0f c1 33 41 8d 76 ff bf ff ff ff ff e8 ab 27 58 f8 41 ff ce
RSP: 0018:ffffc9000431f960 EFLAGS: 00010256
RAX: ffffffff89678f01 RBX: ffffffffffffffdb RCX: ffffffff89678fdc
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffffffffdb
RBP: ffffc9000431f9f8 R08: ffffffffffffffde R09: 1ffffffffffffffb
R10: dffffc0000000000 R11: fffffbfffffffffc R12: dffffc0000000000
R13: dffffc0000000000 R14: 00000000ffffffff R15: 1ffff92000863f2c
FS:  0000555583637500(0000) GS:ffff888125d17000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffdb CR3: 000000002465a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	c7 c7 80 72 94 8c    	mov    $0x8c947280,%edi
   6:	be 68 00 00 00       	mov    $0x68,%esi
   b:	48 c7 c2 c0 72 94 8c 	mov    $0xffffffff8c9472c0,%rdx
  12:	e8 21 f7 35 f8       	call   0xf835f738
  17:	48 89 df             	mov    %rbx,%rdi
  1a:	be 04 00 00 00       	mov    $0x4,%esi
  1f:	e8 84 90 bb f8       	call   0xf8bb90a8
  24:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
* 2a:	f0 44 0f c1 33       	lock xadd %r14d,(%rbx) <-- trapping instruction
  2f:	41 8d 76 ff          	lea    -0x1(%r14),%esi
  33:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  38:	e8 ab 27 58 f8       	call   0xf85827e8
  3d:	41 ff ce             	dec    %r14d


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

