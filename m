Return-Path: <linux-kernel+bounces-838891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9100BB05DB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCED16D833
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87492E92D0;
	Wed,  1 Oct 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqPgKp8L"
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41451C84DC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322136; cv=none; b=kxa3JtFpDZ+3g5IfHNr5y5km6GKfMGl/T0SjI3gRzsxJ61ry27UkYcGnuj0/WhuLaD29TccT0cVqzQdrHHaCS72N1Kki2nwz/qob3zod6nJvs7fuaF5by2ijKeS5bt36im8oNtW8zAFtS6cmYm5QWlY9zJy3nuLwUtVfVuCIfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322136; c=relaxed/simple;
	bh=FZoE4/uzj7IoteEjS8xaFMH3OLzn5CI66U1IU6JpBZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOWB/zprBk8+9TpLkrD5aVLUxiJJTlSKZpoGP7tb9lBWl8Gl5sTKadGg+vqppmvUQ1gt529b5wMo/XZ7nm3uUx1LzYdtHKSp7ow3RtbcA98x7/aVRY37krjO+8Y5/+NfQ5FvCEpIRiRNCvA4bPO/8M+8L6UZrP4hFWfIkxqKN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqPgKp8L; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-77636fb28f6so36172387b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759322134; x=1759926934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OJTyCbCWaylu3zzN8/+lDYrlD8PE/4kgfS91leMv2U=;
        b=YqPgKp8Ls5lsd90jVlUS5KdU7utmMW3y71dfCHIbggjuoDY/lBcKR1GadGD+f6h+ww
         zFxXjnHjVcLmx+3qGPD9eekhQ3O0ZTc4r1WmWEMPqVr4VgYcmmGuCHbaBDwh6vS4rAWH
         2txa+FFAePXlikU0YNU5XILK0K4AMT6GoYnOvitIQJVmKxQaTyRbWrLlSxKoRCR1tcPx
         VVnQ/U0lwvcVRrROwjNqsZdG88j/iqhR9bsN0HD0+DBHZkBqMZ1N9CVhjOzqAiG/BRdu
         pCqi27cPD+trGb0rL8zlZuFqDpV7oRt2xK4clMmfrr90I8yvAhmumcjrjS0wLECtAsya
         PdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759322134; x=1759926934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OJTyCbCWaylu3zzN8/+lDYrlD8PE/4kgfS91leMv2U=;
        b=EJ40l7j0rAjnB2eazjKMngp/1UcyVZa8rOK9lnLxco/sbXE164OddLGMbicc+JYuEb
         9U1XRDClw4kO4dnTpbBgG1fm+fWcgb20kZVehG+aUvkwp73I0EENPpRvBoYz1Xyf60Kp
         egIEx91ZrcBmTThO2TaONGoktwuhTDBX38vG3jgj1mZpN+lDw/Vv+KR6P69c+uvHQNnk
         DkyRDlHY6dxJTNrQE1QgeGwY/MYr3Hw5KNpj97dfg2CrgIz/m5jDgTZpAfQ6rvtQzJi8
         YFHJHfCWIllm7msszXjZqu9dR0AHEh2WljLsE428EYofpDYRdS5XGJlEhwLmB6NpRJ2v
         7a4w==
X-Forwarded-Encrypted: i=1; AJvYcCVzoU9q5Kp7nnOahLSHURV3LMBAYP7aHr6sqdQdKz/jIk27nFxS2g/fqT8ret258TCJd56ycJShqUW1pQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmWhrcZ8XVc0kwYvBq6HTsa6W9EOeoLcPxDTkpwA2Ux7h/QK1
	Bk7cg3Tp4zZVFMJFOmbj65LHIAd5y3W8i4O6ytkLO7p9CjyuqB0QmgrrpfZQM9RMgc7gCcvF/jp
	S4e3zXTIEGRrYev33GkfIir7b01z6C7p1JuZIBS4RW1II
X-Gm-Gg: ASbGncujAQhySyfONSZ7T2Fyx4E8fBhnW41VqZbS23vQDvlSR8/vcM/F16BY+Tv04Oi
	oEDSL9LKkU9dVgviH720Dl2JaQv0ycXQS+b6azAnM95gzbC4slZshQgr6DZ3L6uyzRR7z7Hz2bF
	LA0RUznNJH5J4DEX8rCj67F6ZHnajA7jh4JK5k1YfdWwkyVGEeYPUcSZ+lIJhmbi60ECHz8cXlc
	7vy/4UWaa1OLhWFWQxbIHNnOoj47hMpIISUJajOtw==
X-Google-Smtp-Source: AGHT+IE6KamGztv2Xt5PHPnx0a0LZ3CZ2ZAyoAvX37IXeRJtUhxUMLuzk9Nd8AK4sT5Ig4L63y3kLhz5qrkwlQUBRqY=
X-Received: by 2002:a53:d016:0:b0:631:ffe7:5925 with SMTP id
 956f58d0204a3-63b6ff7e767mr4511024d50.32.1759322133690; Wed, 01 Oct 2025
 05:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509301440.be4b3631-lkp@intel.com>
In-Reply-To: <202509301440.be4b3631-lkp@intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 1 Oct 2025 20:35:22 +0800
X-Gm-Features: AS18NWAaFB7VypLe-kOC6DuizTI5uWWChH9dUxfLG7LSWUsfk4lFDSPotkYett8
Message-ID: <CADxym3YTYTf186M6VSnzAdikKvFt_iyfAXA=ysKLGyZsD=9ynA@mail.gmail.com>
Subject: Re: [linux-next:master] [tracing] e5a4cc28a0: BUG:spinlock_bad_magic_on_CPU
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Masami Hiramatsu <mhiramat@kernel.org>, Menglong Dong <dongml2@chinatelecom.cn>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:48=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "BUG:spinlock_bad_magic_on_CPU" on:
>
> commit: e5a4cc28a052369b6e56b0a9ac05d9b9d5607b06 ("tracing: fprobe: use r=
hltable for fprobe_ip_table")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: boot
>
> config: x86_64-randconfig-072-20250929
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@intel.=
com
>
>
> [   30.894986][   T66] BUG: spinlock bad magic on CPU#0, modprobe/66
> [ 30.896030][ T66] lock: fprobe_ip_table+0x110/0x180, .magic: 00000000, .=
owner: <none>/-1, .owner_cpu: 0
> [   30.898263][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted 6=
.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537e1=
528f
> [   30.898799][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   30.898799][   T66] Call Trace:
> [   30.898799][   T66]  <TASK>
> [ 30.898799][ T66] show_stack (arch/x86/kernel/dumpstack.c:319)
> [ 30.898799][ T66] dump_stack_lvl (lib/dump_stack.c:122)
> [ 30.898799][ T66] dump_stack (lib/dump_stack.c:130)
> [ 30.898799][ T66] spin_dump (kernel/locking/spinlock_debug.c:71)
> [ 30.898799][ T66] do_raw_spin_lock.cold (kernel/locking/spinlock_debug.c=
:78 kernel/locking/spinlock_debug.c:86 kernel/locking/spinlock_debug.c:115)
> [ 30.898799][ T66] _raw_spin_lock (kernel/locking/spinlock.c:155)
> [ 30.898799][ T66] ? rhashtable_walk_enter (lib/rhashtable.c:687)
> [ 30.898799][ T66] rhashtable_walk_enter (lib/rhashtable.c:687)

Hmm, it's weird. I'm on vacation now, and I'll focus on this
warning after I come back.

Thanks!
Menglong Dong

> [ 30.898799][ T66] fprobe_module_callback (kernel/trace/fprobe.c:478)
> [ 30.898799][ T66] ? _mutex_trylock_nest_lock (kernel/locking/mutex.c:916=
)
> [ 30.898799][ T66] ? fprobe_addr_list_add+0x4a0/0x4a0
> [ 30.898799][ T66] ? mutex_unlock (kernel/locking/mutex.c:537)
> [ 30.898799][ T66] notifier_call_chain (kernel/notifier.c:85)
> [ 30.898799][ T66] blocking_notifier_call_chain (kernel/notifier.c:381 ke=
rnel/notifier.c:368)
> [ 30.898799][ T66] do_init_module (kernel/module/main.c:3134)
> [ 30.898799][ T66] ? free_module (kernel/module/main.c:3011)
> [ 30.898799][ T66] load_module (kernel/module/main.c:3509)
> [ 30.898799][ T66] init_module_from_file (kernel/module/main.c:3701)
> [ 30.898799][ T66] ? __ia32_sys_init_module (kernel/module/main.c:3677)
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53=
 kernel/trace/trace_branch.c:223)
> [ 30.898799][ T66] ? do_raw_spin_unlock (kernel/locking/spinlock_debug.c:=
103 (discriminator 4) kernel/locking/spinlock_debug.c:141 (discriminator 4)=
)
> [ 30.898799][ T66] idempotent_init_module (kernel/module/main.c:3636 kern=
el/module/main.c:3714)
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643=
)
> [ 30.898799][ T66] ? init_module_from_file (kernel/module/main.c:3705)
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53=
 kernel/trace/trace_branch.c:223)
> [ 30.898799][ T66] __x64_sys_finit_module (include/linux/file.h:62 (discr=
iminator 3) include/linux/file.h:83 (discriminator 3) kernel/module/main.c:=
3736 (discriminator 3) kernel/module/main.c:3723 (discriminator 3) kernel/m=
odule/main.c:3723 (discriminator 3))
> [ 30.898799][ T66] x64_sys_call (arch/x86/entry/syscall_64.c:41)
> [ 30.898799][ T66] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discrim=
inator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> [ 30.898799][ T66] ? ksys_read (fs/read_write.c:705)
> [ 30.898799][ T66] ? vfs_write (fs/read_write.c:705)
> [ 30.898799][ T66] ? build_open_flags (fs/open.c:1420)
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53=
 kernel/trace/trace_branch.c:223)
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643=
)
> [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.=
c:4678)
> [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> [ 30.898799][ T66] ? __x64_sys_openat (fs/open.c:1461)
> [ 30.898799][ T66] ? __x64_sys_open (fs/open.c:1461)
> [ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53=
 kernel/trace/trace_branch.c:223)
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643=
)
> [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.=
c:4678)
> [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> [ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643=
)
> [ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.=
c:4678)
> [ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
> [ 30.898799][ T66] ? irqentry_exit (kernel/entry/common.c:210)
> [ 30.898799][ T66] ? exc_page_fault (arch/x86/mm/fault.c:1536)
> [ 30.898799][ T66] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_6=
4.S:130)
> [   30.898799][   T66] RIP: 0033:0x7f46bce10719
> [ 30.898799][ T66] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 =
90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
>    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
>    d:   00 00 00
>   10:   90                      nop
>   11:   48 89 f8                mov    %rdi,%rax
>   14:   48 89 f7                mov    %rsi,%rdi
>   17:   48 89 d6                mov    %rdx,%rsi
>   1a:   48 89 ca                mov    %rcx,%rdx
>   1d:   4d 89 c2                mov    %r8,%r10
>   20:   4d 89 c8                mov    %r9,%r8
>   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
>   28:   0f 05                   syscall
>   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <=
-- trapping instruction
>   30:   73 01                   jae    0x33
>   32:   c3                      ret
>   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06f=
1
>   3a:   f7 d8                   neg    %eax
>   3c:   64 89 01                mov    %eax,%fs:(%rcx)
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
>    6:   73 01                   jae    0x9
>    8:   c3                      ret
>    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06c=
7
>   10:   f7 d8                   neg    %eax
>   12:   64 89 01                mov    %eax,%fs:(%rcx)
>   15:   48                      rex.W
> [   30.898799][   T66] RSP: 002b:00007ffc679745b8 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000139
> [   30.898799][   T66] RAX: ffffffffffffffda RBX: 00005640c34b9160 RCX: 0=
0007f46bce10719
> [   30.898799][   T66] RDX: 0000000000000000 RSI: 00005640aa9b74a0 RDI: 0=
000000000000004
> [   30.898799][   T66] RBP: 00005640aa9b74a0 R08: 0000000000000000 R09: 0=
0005640c34ba430
> [   30.898799][   T66] R10: 0000000000000004 R11: 0000000000000246 R12: 0=
000000000040000
> [   30.898799][   T66] R13: 0000000000000000 R14: 00005640c34b83a0 R15: 0=
000000000000000
> [   30.898799][   T66]  </TASK>
> [   30.963748][   T66] Oops: general protection fault, probably for non-c=
anonical address 0xdffffc0000000002: 0000 [#1] KASAN
> [   30.964694][   T66] KASAN: null-ptr-deref in range [0x0000000000000010=
-0x0000000000000017]
> [   30.964694][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted 6=
.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537e1=
528f
> [   30.964694][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [ 30.964694][ T66] RIP: 0010:rhashtable_walk_enter (include/linux/list.h:=
169 lib/rhashtable.c:688)
> [ 30.964694][ T66] Code: c1 ea 03 80 3c 02 00 0f 85 2b 02 00 00 4d 89 77 =
28 4d 8d 6e 10 48 b8 00 00 00 00 00 fc ff df 4d 8d 67 18 4c 89 ea 48 c1 ea =
03 <80> 3c 02 00 0f 85 f7 01 00 00 49 8b 5e 10 48 8d 43 08 48 89 c2 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   c1 ea 03                shr    $0x3,%edx
>    3:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    7:   0f 85 2b 02 00 00       jne    0x238
>    d:   4d 89 77 28             mov    %r14,0x28(%r15)
>   11:   4d 8d 6e 10             lea    0x10(%r14),%r13
>   15:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   1c:   fc ff df
>   1f:   4d 8d 67 18             lea    0x18(%r15),%r12
>   23:   4c 89 ea                mov    %r13,%rdx
>   26:   48 c1 ea 03             shr    $0x3,%rdx
>   2a:*  80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)               <=
-- trapping instruction
>   2e:   0f 85 f7 01 00 00       jne    0x22b
>   34:   49 8b 5e 10             mov    0x10(%r14),%rbx
>   38:   48 8d 43 08             lea    0x8(%rbx),%rax
>   3c:   48 89 c2                mov    %rax,%rdx
>   3f:   48                      rex.W
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    4:   0f 85 f7 01 00 00       jne    0x201
>    a:   49 8b 5e 10             mov    0x10(%r14),%rbx
>    e:   48 8d 43 08             lea    0x8(%rbx),%rax
>   12:   48 89 c2                mov    %rax,%rdx
>   15:   48                      rex.W
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250930/202509301440.be4b3631-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

