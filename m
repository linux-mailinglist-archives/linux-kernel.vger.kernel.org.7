Return-Path: <linux-kernel+bounces-863007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6041BF6C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0877483EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E733710F;
	Tue, 21 Oct 2025 13:30:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCE33711A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053405; cv=none; b=L8vDG+HoAuw6FotlG1Cdk+Cef89yc9rUa3bvIPFS8HAVTOkKv9yQrclcRL6nXZ0bqx7iTxg2uLKTt9U05eu7P4GeuxkGqsdMdnVZq+6rTO+TtHVbdqWtUqktZzGXR93Tg4Ou/MkMmF8xzJ7zvCj2qXAdrd9DUSKzzWOAACuGuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053405; c=relaxed/simple;
	bh=8r9s5VaMVi0LkFqbWphRqsKjx6SKI8baV25BhO77uHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rlu/29qCR3xIjCI50R0GepL1yAlVLLsjAzTvEmqHclvhUx15X5TNuk1PoM9eWX5vnWHiwqn+1DoJPvsXk4KqBCXEkHo870uuWI31ksnqGn7DujAVZalEeFBB4ZtDQWLgddAnSjVF6NmbLT/jgFwx6gpq79+3nCnK26JFRyQyysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430db5635d6so33202325ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053403; x=1761658203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6m3/kDqzJS8oJ4W3kr/oqW9+2fk3OqJtY5sAro2z6FQ=;
        b=ccMbaMB+kzNPrxjem3g/0wLnx8AOCvEn2bNjWpR6eQ/M3HVqs4WEKUkjWTP3mJ/gXw
         KwkYYrb219ZePM8/jmgvo+7YCav+EiJ3Gm4K1ZK3ZbDojm6oemaw58XqjRYJ/9RNCTBd
         nnlc1c4Z4IfsLKdltlXNqrPnPPe1j41Oy523sj79giJt1cmgWSZi7BsruXzzCwPV2NkG
         qY0c2etXazWYAzTsO7CnqDGiwhGcYv/cq/TRDnq+F9HF+fNwHTr9oeNDc0iGWKskcpOl
         qIBwDm6ZcJULZfZXvklzRGXkwxeMrUfEmLbRm2wqveE9HKBscqFp1euXtW0PzMk6Bv7G
         zGQw==
X-Gm-Message-State: AOJu0YwySPd5w7pQyymHWX7qwJy9t1zFgw9UULQiVp8AfipTnZLfgZvB
	QfxvKEwOP/FcxBHw7bDa7DaHHues17E8/i51SQtBsh/rxU4ICPcLTqbROwk7ZjD82DaNaH7135K
	zf3BEOH3nI/dHC8a8YIU6OKGdCy9ISoWprSGIYm7Z58+uA4fETyPMiWmE+ng=
X-Google-Smtp-Source: AGHT+IHMIQHW4qgkaJC1nc359VQVW3txjoHPGEANzCDrms2T/yPzsMzJi3eVLgEC/9DoOJXD/jkEmbH/Tt+eOvERGahsoTW7Q4aK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:42e:2c30:2835 with SMTP id
 e9e14a558f8ab-430c519b57cmr262623275ab.0.1761053402744; Tue, 21 Oct 2025
 06:30:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 06:30:02 -0700
In-Reply-To: <4r32bnxsz725hnafeqqabxx2fcc7z2s7tfleu2bjwrcshvmn5y@nigyy2bomc5z>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f78ada.050a0220.346f24.0019.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in bpf_bprintf_prepare

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6960 at kernel/bpf/helpers.c:781 bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
WARNING: CPU: 0 PID: 6960 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
Modules linked in:
CPU: 0 UID: 0 PID: 6960 Comm: syz.1.124 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
RIP: 0010:bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
Code: ff e9 ce fe ff ff e8 10 ec e0 ff e9 be fe ff ff e8 06 ec e0 ff e9 b4 fe ff ff e8 fc eb e0 ff e9 aa fe ff ff e8 f2 eb e0 ff 90 <0f> 0b 90 65 ff 0d 27 ed b2 10 b8 f0 ff ff ff e9 17 ff ff ff e8 d8
RSP: 0018:ffffc9000501f840 EFLAGS: 00010293
RAX: ffffffff81df57fe RBX: ffffc9000501fa10 RCX: ffff88802a138000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: ffffc9000501f970 R08: 0000000000585870 R09: 0000000000000005
R10: dffffc0000000000 R11: fffff52000a03f20 R12: dffffc0000000000
R13: 0000000000000004 R14: 0000000000000003 R15: 1ffff92000a03f42
FS:  00007f8beda4a6c0(0000) GS:ffff888125d0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007dee8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ____bpf_trace_printk kernel/trace/bpf_trace.c:372 [inline]
 bpf_trace_printk+0xdb/0x190 kernel/trace/bpf_trace.c:362
 bpf_prog_bfbd7bf4bf171090+0x41/0x5a
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:745 [inline]
 bpf_flow_dissect+0x225/0x720 net/core/flow_dissector.c:1024
 bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1416
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4688
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6167
 __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6257
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8becb8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8beda4a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f8becde5fa0 RCX: 00007f8becb8efc9
RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
RBP: 00007f8becc11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8becde6038 R14: 00007f8becde5fa0 R15: 00007ffeba5c25f8
 </TASK>


Tested on:

commit:         1c64efcb Merge tag 'rust-rustfmt' of git://git.kernel...
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=156d0d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13110d2f980000


