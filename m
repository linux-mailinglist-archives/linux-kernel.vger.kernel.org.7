Return-Path: <linux-kernel+bounces-835186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55776BA675C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C29189AD75
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32027280B;
	Sun, 28 Sep 2025 03:56:51 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D402620C3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031811; cv=none; b=jK1SzFXkEAbHsouPhMt9xWfbvfaZDgobF6R6nsrMYdVWjx1/pXotennaJJv0i6S6jOn983ptTtQW3o2IJAFgxyiCWfdTpthwAqXNwBRGEyBmLPORFx90DqXjwEEwKNwPUUaEJqh5E5geRDP8TI3gEwTgUk3SW3BIIaL9WNnZlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031811; c=relaxed/simple;
	bh=FGLWsnAVv5Aj6MjN39dbCE9Exb3ZTFNWzQvf/jGpw0Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Avorx7XJGm3o9pNBbSmtjqirx8MjEKb1NLgIw6uVVh9UCj+7z+x25T1nqdOg4f4pGmtDT4C+Fi58GiWQ3gdaoTD94dFFN41Lhg9AJcmyr9olJ5OL5t/XG7ROcfB89HT0OcqTkXdLXj6g+MKuh6YjxK7cRHdQeReyrJuyU/uF4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-893dd6dfe1fso417798739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759031808; x=1759636608;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U0tOxIaXI1vvBldlMhbPERmExLIghOxguaVpH9JXXI=;
        b=B+qOmahIhjRrDXfjw4J/6xxGw+GJPH/Y+up6oGMk4bR3VslH1BQwqxNXfGE9r3ld59
         53VLWbmzsjYP7ZBpnBXKM39Sdb8F0Yqavtu2asJM6N6vyPkb8PM+DVUfJRCshF2/dQBb
         ejCXtEllYUrLJKSgMSCVuTOLxS53QTUEmfJy4YdIZeQFs/IRbbb3M7/vClH4HP/EkLMd
         ZDpHc3PErqL7k4LhfrFiVOxAFP+2cdb++SNa+czN39FY7+4Idizmi9sZO8LTWaa2m+QC
         Fom9PCfr80fimrKlwOdAXQfoDmjalBHpG1Ffy+0P9VXjhx+KWwyaAMTvkNaxySEk8aj0
         PhrA==
X-Forwarded-Encrypted: i=1; AJvYcCWpZnRa7++OzX0lF+julMYqqP2qhxE3avxf9F9BQgt4A937j4MvmDflHohQtHLV6FFZsqopwZEsmKrz2b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EqqA2Td0a4YkBV8kYbSF3qqCWSJrgOq0CaVuONqWYHuaTY+v
	8BRxrX61Rn1ALlkRFJxkAdROMBRRTg+KUEqRs9Co7p31e3iHPjSubobq/d8ODZX4ToUITNUCSSP
	Mwe2MTkmCJLFXOmFkSNPJltzl7k9pWEHnObERULny2inPqReW2RziCZfjQas=
X-Google-Smtp-Source: AGHT+IEjbS6eeWagEnmulUNYrDgllYAP9Te5FyenMzGsmdXICkCcNLjhit2J7+ya4gNRxC5pkazyihF7tmhuZ0ZyulR7vlDilOaC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:425:6f0b:a1db with SMTP id
 e9e14a558f8ab-4259560a54cmr198611325ab.9.1759031808550; Sat, 27 Sep 2025
 20:56:48 -0700 (PDT)
Date: Sat, 27 Sep 2025 20:56:48 -0700
In-Reply-To: <87ldlz2ps2.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8b200.a70a0220.10c4b.0017.GAE@google.com>
Subject: Re: [syzbot] [sctp?] UBSAN: shift-out-of-bounds in sctp_transport_update_rto
From: syzbot <syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com>
To: xandfury@gmail.com
Cc: xandfury@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> syzbot <syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com> writes:
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    6832a9317eee Merge tag =E2=80=99net-6.16-rc7=E2=80=99 of=
 git://git.kernel=E2=80=A6
>> git tree:       upstream
>> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D137d9d8c580=
000>
>> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D693e2f5eea4=
96864>
>> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D2e455dd90ca64=
8e48cea>
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
>>
>> Unfortunately, I don=E2=80=99t have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: <https://storage.googleapis.com/syzbot-assets/6a84ef6250f7/d=
isk-6832a931.raw.xz>
>> vmlinux: <https://storage.googleapis.com/syzbot-assets/454efb0534f6/vmli=
nux-6832a931.xz>
>> kernel image: <https://storage.googleapis.com/syzbot-assets/7a5841eb7e63=
/bzImage-6832a931.xz>
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com
>>
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
>> UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
>> shift exponent 237 is too large for 32-bit type =E2=80=99unsigned int=E2=
=80=99
>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc6-syzkaller-00=
121-g6832a9317eee #0 PREEMPT(full)=20
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 05/07/2025
>> Call Trace:
>>  <IRQ>
>>  __dump_stack lib/dump_stack.c:94 [inline]
>>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>>  ubsan_epilogue lib/ubsan.c:233 [inline]
>>  __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
>>  sctp_transport_update_rto.cold+0x1c/0x34b net/sctp/transport.c:509
>>  sctp_check_transmitted+0x11c4/0x1c30 net/sctp/outqueue.c:1502
>>  sctp_outq_sack+0x4ef/0x1b20 net/sctp/outqueue.c:1338
>>  sctp_cmd_process_sack net/sctp/sm_sideeffect.c:840 [inline]
>>  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1372 [inline]
>>  sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
>>  sctp_do_sm+0x36df/0x5c80 net/sctp/sm_sideeffect.c:1175
>>  sctp_assoc_bh_rcv+0x392/0x6f0 net/sctp/associola.c:1034
>>  sctp_inq_push+0x1db/0x270 net/sctp/inqueue.c:88
>>  sctp_rcv+0x14d8/0x3c60 net/sctp/input.c:243
>>  ip_protocol_deliver_rcu+0x447/0x4c0 net/ipv4/ip_input.c:205
>>  ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
>>  NF_HOOK include/linux/netfilter.h:317 [inline]
>>  NF_HOOK include/linux/netfilter.h:311 [inline]
>>  ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
>>  dst_input include/net/dst.h:469 [inline]
>>  ip_rcv_finish net/ipv4/ip_input.c:448 [inline]
>>  NF_HOOK include/linux/netfilter.h:317 [inline]
>>  NF_HOOK include/linux/netfilter.h:311 [inline]
>>  ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:568
>>  __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:5977
>>  __netif_receive_skb+0x1d/0x160 net/core/dev.c:6090
>>  process_backlog+0x442/0x15e0 net/core/dev.c:6442
>>  __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:7414
>>  napi_poll net/core/dev.c:7478 [inline]
>>  net_rx_action+0xa9f/0xfe0 net/core/dev.c:7605
>>  handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
>>  __do_softirq kernel/softirq.c:613 [inline]
>>  invoke_softirq kernel/softirq.c:453 [inline]
>>  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
>>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inl=
ine]
>>  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
>>  </IRQ>
>>  <TASK>
>>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry=
.h:702
>> RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
>> Code: 0b 6f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 77 25 00 fb f4 <e9> 8c fb 02 0=
0 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
>> RSP: 0018:ffffffff8e207e08 EFLAGS: 000002c6
>> RAX: 0000000000448811 RBX: 0000000000000000 RCX: ffffffff8b849c69
>> RDX: 0000000000000000 RSI: ffffffff8de2d10c RDI: ffffffff8c157960
>> RBP: fffffbfff1c52ef0 R08: 0000000000000001 R09: ffffed1017086645
>> R10: ffff8880b843322b R11: 0000000000000001 R12: 0000000000000000
>> R13: ffffffff8e297780 R14: ffffffff90a9a650 R15: 0000000000000000
>>  arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
>>  default_idle+0x13/0x20 arch/x86/kernel/process.c:749
>>  default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
>>  cpuidle_idle_call kernel/sched/idle.c:185 [inline]
>>  do_idle+0x391/0x510 kernel/sched/idle.c:325
>>  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:423
>>  rest_init+0x16b/0x2b0 init/main.c:745
>>  start_kernel+0x3ee/0x4d0 init/main.c:1102
>>  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:307
>>  x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:288
>>  common_startup_64+0x13e/0x148
>>  </TASK>
>> =E2=80=94[ end trace ]=E2=80=94
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-
>> Code disassembly (best guess):
>>    0:	0b 6f 02             	or     0x2(%rdi),%ebp
>>    3:	c3                   	ret
>>    4:	cc                   	int3
>>    5:	cc                   	int3
>>    6:	cc                   	int3
>>    7:	cc                   	int3
>>    8:	0f 1f 00             	nopl   (%rax)
>>    b:	90                   	nop
>>    c:	90                   	nop
>>    d:	90                   	nop
>>    e:	90                   	nop
>>    f:	90                   	nop
>>   10:	90                   	nop
>>   11:	90                   	nop
>>   12:	90                   	nop
>>   13:	90                   	nop
>>   14:	90                   	nop
>>   15:	90                   	nop
>>   16:	90                   	nop
>>   17:	90                   	nop
>>   18:	90                   	nop
>>   19:	90                   	nop
>>   1a:	90                   	nop
>>   1b:	f3 0f 1e fa          	endbr64
>>   1f:	66 90                	xchg   %ax,%ax
>>   21:	0f 00 2d d3 77 25 00 	verw   0x2577d3(%rip)        # 0x2577fb
>>   28:	fb                   	sti
>>   29:	f4                   	hlt
>> * 2a:	e9 8c fb 02 00       	jmp    0x2fbbb <=E2=80=93 trapping instructi=
on
>>   2f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>>   36:	00 00 00
>>   39:	66 90                	xchg   %ax,%ax
>>   3b:	90                   	nop
>>   3c:	90                   	nop
>>   3d:	90                   	nop
>>   3e:	90                   	nop
>>   3f:	90                   	nop
>>
>>
>> =E2=80=94
>> This report is generated by a bot. It may contain errors.
>> See <https://goo.gl/tpsmEJ> for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> <https://goo.gl/tpsmEJ#status> for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report=E2=80=99s subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master

This crash does not have a reproducer. I cannot test it.


