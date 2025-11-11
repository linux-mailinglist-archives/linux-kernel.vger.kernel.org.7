Return-Path: <linux-kernel+bounces-894721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E56B4C4BAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF28F4E2E87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A132D6E74;
	Tue, 11 Nov 2025 06:38:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444A28031D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843084; cv=none; b=ACWTo7uI+LdCPOM4WCn0apljByjp0ivwSipFoJ61mEdk9S9JrN8JpCSoYHshXNQJq3aXkLEUtlBrnrUeMFV4ks+FmpMtbrybq+c0JHmekLc9CdnEdtbtHB6eGTCsPvzhtfR4Oq7BAQbDEWTi4x+m0Ql6g4w5yW0T1m0i7cA0DcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843084; c=relaxed/simple;
	bh=EUE0tSIeUkqTe0uubIifNRYGjRyKsnJUPUUuHXKwnkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YZjqurdzxiJNarYDKsmLBBMaxPbzOdzsxgmviIYN6jQLfjiCGkl8HyPIjiZbNjc+hpiW9tCqVbG/N1dPA8wcD2rlsfP0bwtmBuTt0LjivtxlKW1ak4FqZwPn6W8dJOwdlOEjCNu2HXE/pdbwcnAzVLgDtmVeoM6zx4yyxcRpApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43376637642so27291585ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843082; x=1763447882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5TwnobHm+AJHSM3uutDHRIdI+BLiOD6yaks9pALk5Y=;
        b=BG2nngouixtTglOwhTOLphd5h3pUjOh+XOUNezfto+EhsamNnSkZo5XFoWiNewtmJf
         2E0Ykx5wEaJN74VKu66Tu4hCj1A/NyTv+Gis4JxDLPHZBKZc1vW6Kc3gkQh2n6BqINNe
         ZWMpt6fBRUsIwnDEUihnhhUatvsW75z6OociojiU1OUgOlQmXhmI5QhgiOZhA9pQijxp
         ZhfdV6tmcwFfYKSE/m0olUx+M3IFChhH4bu+0ILAN25Df49zE2132K45CIs5xhj7a6qh
         IywaEG8Ke7a/aPC8m5dksrmGfFXToWEhmtcYBx1nz6zXnrJ6xiyQuKSytor+5CQZVtSM
         P62g==
X-Forwarded-Encrypted: i=1; AJvYcCVfgn8JSNx56bie4QjX8p3zzSnPAsZ1Y5pQ6DN78c9vMdqv/HDMrB4cTCoUjC8UUNzXRjYT3S1PakRZB98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfHYNT+pbIeMFrQgd+dUAh2QKrZVmNbDGQL6DmTPWWjNkI3Nn
	nyKnAkYunz8f+rTpJGqqrYrsAJquBzaCFDK0khIlmLC/d3QqvgKsIWqFeaiCjV6DExqVg7or8cc
	sqlhz/VqARH6+EQ3LBKdm4Sj8Dw8W4naf3228wdvRFrYCPLcdV9YBdFve3rQ=
X-Google-Smtp-Source: AGHT+IEAESKeXPkc9BcSPei1vRYm0woJ/+RwN6F1yKrKG30QZS6eG3o1Kqw5Hjm/G5sU1B5hQztW1sIZIYe0p6jDlrSX0NeMosLI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156a:b0:433:2aad:9869 with SMTP id
 e9e14a558f8ab-43367e7a659mr143492275ab.30.1762843081813; Mon, 10 Nov 2025
 22:38:01 -0800 (PST)
Date: Mon, 10 Nov 2025 22:38:01 -0800
In-Reply-To: <CADfthj2kwRdbSo1PJPFnztaSv2hXC+Oo9q2PCTNDEwSKknoLkg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912d9c9.a70a0220.22f260.012b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_dirty_folio

------------[ cut here ]------------
WARNING: CPU: 1 PID: 19829 at fs/ext4/inode.c:3964 ext4_dirty_folio+0x172/0x1b0 fs/ext4/inode.c:3964
Modules linked in:
CPU: 1 UID: 0 PID: 19829 Comm: syz-executor822 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ext4_dirty_folio+0x172/0x1b0 fs/ext4/inode.c:3964
Code: 74 7f 47 ff 4c 89 e7 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3f 2b d0 ff e8 5a 7f 47 ff 90 0f 0b 90 eb e0 e8 4f 7f 47 ff 90 <0f> 0b 90 eb a7 e8 44 7f 47 ff 48 89 df 48 c7 c6 60 a3 5e 8b e8 a5
RSP: 0018:ffffc9000d1d7368 EFLAGS: 00010293
RAX: ffffffff82782371 RBX: ffffea0001557e80 RCX: ffff888024e5dac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffffd40002aafd0 R08: ffffea0001557e87 R09: 1ffffd40002aafd0
R10: dffffc0000000000 R11: fffff940002aafd1 R12: ffff88806060ede8
R13: 1ffffd40002aafd1 R14: 0000000000000000 R15: ffffea0001557e88
FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa65112e498 CR3: 000000005edfa000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 zap_present_folio_ptes mm/memory.c:1629 [inline]
 zap_present_ptes mm/memory.c:1709 [inline]
 do_zap_pte_range mm/memory.c:1810 [inline]
 zap_pte_range mm/memory.c:1854 [inline]
 zap_pmd_range mm/memory.c:1946 [inline]
 zap_pud_range mm/memory.c:1975 [inline]
 zap_p4d_range mm/memory.c:1996 [inline]
 unmap_page_range+0x17c9/0x4370 mm/memory.c:2017
 unmap_single_vma mm/memory.c:2060 [inline]
 unmap_vmas+0x399/0x580 mm/memory.c:2104
 exit_mmap+0x240/0xb40 mm/mmap.c:1280
 __mmput+0x118/0x430 kernel/fork.c:1133
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:954
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa6510dab89
Code: Unable to access opcode bytes at 0x7fa6510dab5f.
RSP: 002b:00007fa65106d178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fa651163718 RCX: 00007fa6510dab89
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa651163718
RBP: 00007fa651163710 R08: 00007fa65106d6c0 R09: 00007fa65106d6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa65116371c
R13: 000000000000006e R14: 00007ffc0f4ff620 R15: 00007ffc0f4ff708
 </TASK>


Tested on:

commit:         4427259c Merge tag 'riscv-for-linus-6.18-rc6' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1044b0b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1771a7cd980000


