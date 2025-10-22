Return-Path: <linux-kernel+bounces-865749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB7ABFDE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 849D14E0F36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D134FF50;
	Wed, 22 Oct 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQZ+o5oS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE334D4FE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158477; cv=none; b=Oaw9VjS18pVSSuJq6M+ZEVzQn6Kiw9JvkE9Z1JsePT4yOORdAyendUJQ9HnfVbvWoCGXDqWkFs7noKBwXbVrmnqgiud1ip45A9VVQq/BeoKKw2onli8mU3GOrZpMGhmeJiwbdG1Qytk/8o/0YLYeTQp2JohygBExk7MDKCZsPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158477; c=relaxed/simple;
	bh=Srdz0YdwKP8fBJdp00SvYH14YKC7endGqxbblYxmxmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQAltHM9MMwD4T0heDRATXVmynnIB3002C4JouYHX0l0hvTBiwOJN1I4882aEOnQm3oNmXdHWzBdk3HCe8CnNW+Wb+tisTGhSt5Xr+ZpXen9G5d8dpOq9+oHB/Y2OyVQfsqMJ4YrP5ZFWezSxlz+VbD8/+1PJZtDP1avUANLKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQZ+o5oS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698384978dso50009505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761158475; x=1761763275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MwSSsIMdPEv7A4eQ3QmSWhovEg7spF/mgUkKOL7vAOA=;
        b=WQZ+o5oScuY8GhK9TUDT+8rodUBgEbEDs1/ItuAbO1infVuX7KrbQedR7KH/BtGAkT
         2R/vvIIlAGIj4DW9+vD0YIC+NLAItoBnsurvN3W4kTeMfjQe3TRKNSVkQTc/WXBMlGC2
         DHH4HxAgmPLhltBL4NR3Ox6SybFeYNsZHrijZXvqTOnyMiyGUyd99p2JnA3U0WkV5MG4
         qqMqSnTfSefIpNDOL3H+JS41rM/6e2GuhtwZvvsgNZOR1f5ZcdhPv/xHOcOEc2Mu9m1+
         V2bxWmZ9fcAtKOQ8+lxsRWz0KLiEtu+cvZSETaTgU+3iGDQDxhJqM62QJPYfKHuLoaai
         zZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158475; x=1761763275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwSSsIMdPEv7A4eQ3QmSWhovEg7spF/mgUkKOL7vAOA=;
        b=V0MfGcsVka9ryVM0kf3Obo3nUhfqwP/SEJIIJS6lWeopujUcmUYHFfh8fs7YASN28U
         wcpRZQssZC97ilLIK/sO2TnJcqzIGONU2zRshAWKDCj05ee8Hw6h1T7DImkKsjnD8kMX
         gvEOKU31NQ5RTKQJvStoH/kk3w0A6s2FX3/woly4LLvK1aN637oVdzKWXs/m/7Z3Pm6v
         RwdkAqLlJOQS/DLDO+He64sBtEwt89Z679NdegVaxazTw/MOJwFfW7jdR/X9kmsvLa3k
         75/wTaALQ169IOkofno0YvuOZ5614x1mmlVJWGXB3PDnExeGDrB74N9ZaTgpjxT3icRQ
         ntXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvPKWoxG86OXqvthgchzcGLi9Xo0Qd7l85WancINTYelnsCGi6EV4nmoDKxj+JiODCo9qynjizvgymBjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCGeAceEXxBWY0Qv2ltsC1M+6fDY2rN5uQw2D4R8+hENvy0PG
	5eIGhHjKvZ8EzWHvu01SPXw7DANyTcZcQHU2DGwY1lwhtOQcnIlD1jBr
X-Gm-Gg: ASbGncvOJxA2/TnqQcQ0COWzO9k8+NLEE2Yl6Xb/meGzg8+U2uc0lzTIdo9FaWzNZCt
	vpoqtP40w7US8FJI+9N4qQTDuBRcUZIDPTCPZlNRSTtWPzXzvgPEyXKvKpDHPBdFaeyAunSqIL3
	fQWetVFoKPv3281jwgt0Rm4CORikO7lDKdbjQPxzqA/Z9cIs1jhJMIV/WUahUBnrX//+aZChkh4
	gaslihlaIg8kL+qGZ1GBjBgib5gX3J1147Mc1f/CkbEPVc5+d2WE0Ac1l0NDqCXq19u0XsqcVuZ
	LT5/xIFWzvBpEFP8HCpbAsxdmEveXn7osJMY5XFkG2I14dbVpBSSHFHCmsAYmm7/agppSC9zqzk
	11O6XE4Ic5RAnuY2zhp9LZ7W/PdQVmZ9BT/4iR+ZfCKyuu7duMtUL7cIZsj//dfu95DPwrG+dXF
	iNB9iA5YM8QJnMYDI=
X-Google-Smtp-Source: AGHT+IHzrkR8kQC2JkBfpPS5AblvPCgWlm5WoPllvAcMI7Ncjl9ri4KHEv/uC8RZ1oR6PgS00gPyww==
X-Received: by 2002:a17:902:e944:b0:290:a3b9:d4c6 with SMTP id d9443c01a7336-290caf831b6mr285229685ad.36.1761158474775;
        Wed, 22 Oct 2025 11:41:14 -0700 (PDT)
Received: from chandna.localdomain ([106.222.229.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm145578975ad.7.2025.10.22.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:41:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:10:59 +0530
From: Sahil Chandna <chandna.sahil@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, listout@listout.xyz,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Message-ID: <aPklOxw0W-xUbMEI@chandna.localdomain>
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>

On Wed, Oct 22, 2025 at 09:57:22AM -0700, Yonghong Song wrote:
>
>
>On 10/20/25 2:08 PM, syzbot wrote:
>>Hello,
>>
>>syzbot found the following issue on:
>>
>>HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 'off' as d..
>>git tree:       bpf
>>console output: https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
>>kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
>>dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
>>compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
>>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000
>>
>>Downloadable assets:
>>disk image: https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
>>vmlinux: https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
>>kernel image: https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz
>>
>>The issue was bisected to:
>>
>>commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
>>Author: Sahil Chandna <chandna.sahil@gmail.com>
>>Date:   Tue Oct 14 18:56:35 2025 +0000
>>
>>     bpf: Do not disable preemption in bpf_test_run().
>>
>>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
>>final oops:     https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
>>console output: https://syzkaller.appspot.com/x/log.txt?x=10afe492580000
>>
>>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
>>Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in bpf_test_run().")
>>
>>------------[ cut here ]------------
>>WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>
>Okay, the warning is due to the following WARN_ON_ONCE:
>
>static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
>static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>
>int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>{
>        int nest_level;
>
>        nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>        if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>                this_cpu_dec(bpf_bprintf_nest_level);
>                return -EBUSY;
>        }
>        *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>
>        return 0;
>}
>
>Basically without preempt disable, at process level, it is possible
>more than one process may trying to take bpf_bprintf_buffers.
>Adding softirq and nmi, it is totally likely to have more than 3
>level for buffers. Also, more than one process with bpf_bprintf_buffers
>will cause problem in releasing buffers, so we need to have
>preempt_disable surrounding bpf_try_get_buffers() and
>bpf_put_buffers().
Right, but using preempt_disable() may impact builds with
CONFIG_PREEMPT_RT=y, similar to bug[1]? Do you think local_lock() could be used here
as nest level is per cpu variable and local lock semantics can work
for both RT and non rt builds ?
>
>There are some kfuncs/helpers need such preempt_disable
>protection, e.g. bpf_stream_printk, bpf_snprintf,
>bpf_trace_printk, bpf_trace_vprintk, bpf_seq_printf.
>But please double check.
>
Sure, thanks!
>
[1] https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
>>Modules linked in:
>>CPU: 1 UID: 0 PID: 6145 Comm: syz.4.53 Not tainted syzkaller #0 PREEMPT(full)
>>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
>>RIP: 0010:bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>RIP: 0010:bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>>Code: ff e9 ce fe ff ff e8 10 ec e0 ff e9 be fe ff ff e8 06 ec e0 ff e9 b4 fe ff ff e8 fc eb e0 ff e9 aa fe ff ff e8 f2 eb e0 ff 90 <0f> 0b 90 65 ff 0d 27 fd b2 10 b8 f0 ff ff ff e9 17 ff ff ff e8 d8
>>RSP: 0018:ffffc90003797840 EFLAGS: 00010293
>>RAX: ffffffff81df57fe RBX: ffffc90003797a10 RCX: ffff888026493c80
>>RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
>>RBP: ffffc90003797970 R08: 0000000000585870 R09: 0000000000000005
>>R10: dffffc0000000000 R11: fffff520006f2f20 R12: dffffc0000000000
>>R13: 0000000000000004 R14: 0000000000000003 R15: 1ffff920006f2f42
>>FS:  00005555805f5500(0000) GS:ffff888125e0c000(0000) knlGS:0000000000000000
>>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>CR2: 0000000000000000 CR3: 000000007c04e000 CR4: 00000000003526f0
>>Call Trace:
>>  <TASK>
>>  ____bpf_trace_printk kernel/trace/bpf_trace.c:372 [inline]
>>  bpf_trace_printk+0xdb/0x190 kernel/trace/bpf_trace.c:362
>>  bpf_prog_bfbd7bf4bf171090+0x41/0x5a
>>  bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
>>  __bpf_prog_run include/linux/filter.h:721 [inline]
>>  bpf_prog_run include/linux/filter.h:728 [inline]
>>  bpf_prog_run_pin_on_cpu include/linux/filter.h:745 [inline]
>>  bpf_flow_dissect+0x225/0x720 net/core/flow_dissector.c:1024
>>  bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1414
>>  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4688
>>  __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6167
>>  __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
>>  __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
>>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6257
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>RIP: 0033:0x7f25b0f8efc9
>>Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>RSP: 002b:00007ffe036cd5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>>RAX: ffffffffffffffda RBX: 00007f25b11e5fa0 RCX: 00007f25b0f8efc9
>>RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
>>RBP: 00007f25b1011f91 R08: 0000000000000000 R09: 0000000000000000
>>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>R13: 00007f25b11e5fa0 R14: 00007f25b11e5fa0 R15: 0000000000000003
>>  </TASK>
>>
>>
>>---
>>This report is generated by a bot. It may contain errors.
>>See https://goo.gl/tpsmEJ for more information about syzbot.
>>syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>>syzbot will keep track of this issue. See:
>>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>
>>If the report is already addressed, let syzbot know by replying with:
>>#syz fix: exact-commit-title
>>
>>If you want syzbot to run the reproducer, reply with:
>>#syz test: git://repo/address.git branch-or-commit-hash
>>If you attach or paste a git patch, syzbot will apply it before testing.
>>
>>If you want to overwrite report's subsystems, reply with:
>>#syz set subsystems: new-subsystem
>>(See the list of subsystem names on the web dashboard)
>>
>>If the report is a duplicate of another one, reply with:
>>#syz dup: exact-subject-of-another-report
>>
>>If you want to undo deduplication, reply with:
>>#syz undup
>

