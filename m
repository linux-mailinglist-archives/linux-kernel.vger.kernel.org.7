Return-Path: <linux-kernel+bounces-835557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BEBA76D9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3071898437
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EEA25C802;
	Sun, 28 Sep 2025 19:26:12 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069D202F65
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759087572; cv=none; b=kbeM2l/uuLeJbu8OV5YEjXBLvt5lH2F3UbsJX4FW/Rvyr3R1+zAwuf+ESh1r1N4eE7Wc4jSEspF7DFaP4VexMHG5SYnJGWRLIzl6OBg1+b/AaNlJxyZZYe7Eg3FaeZerHGJyQfE7ZtEHfP/OdM36+35pWpuh+wDxseKEpak61e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759087572; c=relaxed/simple;
	bh=PGWEbSzH97FzbHmEaqKEepeMZnNG75kU0P5YkLhNOIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PWAoBXinoLsB36POPnT7RCoH2d29w3Lb+Wnh0mvctEAN/mVhDkM5BgV6AEa1MpEdhWrGYn15R2RA2YNVL1FPlPpkPrNbD4XXHhujOVvUgIPwA9Mh89I9ouf6qpOYGCADmB49fBNBmq0/n13reH79LdBWuyzN3lV0wngvVS4LUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-91e1d4d0976so299288139f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759087569; x=1759692369;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovJEN8HNIDROjgdisDtShLYrROt/sH1RNCUDuQ5O8og=;
        b=FzPvcFwNBL0X3YktGu8xEyngqDp2yeUt7Lqw0Bq9xuUdDNgFwgA7iR/jFfHtKh7ky5
         zaFnv5QoQavJ1fqOZUt0pga38YcWehcx5bssWwE2v7p+LGYiXLUhCC4nP5ZELRrebvfQ
         R17V1H5MeWyDe9prOPPMwJiDJHiIOxCs6V6Z5CTnO5piX1H4R2dQAENIVCXJhThq/hh2
         e3bz2nUefbcFq/onQvVryv07/hm2oA3wytbNYzCmqiZqU1UeijRwuxviQ5hbFuhHR9oP
         msDzWKEnzzW6/XEkeM3Fy+Lqezmk9y7E2Twgw66AKUFdqhpLu+9NEPoyKPut26y9Dy5p
         SRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzHCYtbou4nrZDq7gXw2uSSCsuCYJgK3q2expFgrzO6BjYnThfiU0nE0I2gHhws2xX/na1n5essQ41djQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ec2NdtmzYNOgLyIaW9zvIb7fH2cYGDu1Z9PuNo88tHSnywpg
	z6u5f9h2p9APt0fhichAJlh5KfeRoZwOjpT7QEuhyQjlxBAqAEj+AoDjoZ1YVIIvgE50ij00WlL
	jRPC4S1N/QbUmDJa8VX1iwvcMP86AHRbhLeN8ZI2RHeS6++VKdmk19yipL1A=
X-Google-Smtp-Source: AGHT+IHPFCHkRfIzH3/YBYM7u5DrIolPkG0j00HjJxMFTglKGsm5tDZWNvuPuiuLzzIcbcXdLSc4JgJl7HpyXcRjRSwn+6SjOrg2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:424:57d:1a50 with SMTP id
 e9e14a558f8ab-425955ed837mr244344335ab.11.1759087569615; Sun, 28 Sep 2025
 12:26:09 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:26:09 -0700
In-Reply-To: <87cy7a2xbl.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d98bd1.a00a0220.102ee.002f.GAE@google.com>
Subject: Re: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in comedi_device_attach
From: syzbot <syzbot+c7e121cdcbe0b0bce98e@syzkaller.appspotmail.com>
To: xandfury@gmail.com
Cc: xandfury@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> syzbot <syzbot+c7e121cdcbe0b0bce98e@syzkaller.appspotmail.com> writes:
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    155a3c003e55 Merge tag =E2=80=99for-6.16/dm-fixes-2=E2=
=80=99 of git://git=E2=80=A6
>> git tree:       upstream
>> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D11196382580=
000>
>> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D693e2f5eea4=
96864>
>> dashboard link: <https://syzkaller.appspot.com/bug?extid=3Dc7e121cdcbe0b=
0bce98e>
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
>> userspace arch: i386
>>
>> Unfortunately, I don=E2=80=99t have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): <https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-155a3c00.raw.xz>
>> vmlinux: <https://storage.googleapis.com/syzbot-assets/a8464683662c/vmli=
nux-155a3c00.xz>
>> kernel image: <https://storage.googleapis.com/syzbot-assets/e74dc5d462a7=
/bzImage-155a3c00.xz>
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+c7e121cdcbe0b0bce98e@syzkaller.appspotmail.com
>>
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
>> UBSAN: shift-out-of-bounds in drivers/comedi/drivers/pcl812.c:1152:10
>> shift exponent 1029 is too large for 32-bit type =E2=80=99int=E2=80=99
>> CPU: 3 UID: 0 PID: 6168 Comm: syz.0.33 Not tainted 6.16.0-rc6-syzkaller-=
00002-g155a3c003e55 #0 PREEMPT(full)=20
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1=
.16.3-2~bpo12+1 04/01/2014
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:94 [inline]
>>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>>  ubsan_epilogue lib/ubsan.c:233 [inline]
>>  __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
>>  comedi_device_attach+0x3b3/0x900 drivers/comedi/drivers.c:996
>>  do_devconfig_ioctl+0x1a7/0x580 drivers/comedi/comedi_fops.c:855
>>  comedi_unlocked_ioctl+0x15bb/0x2e90 drivers/comedi/comedi_fops.c:2136
>>  comedi_compat_ioctl+0x1d0/0x910 drivers/comedi/comedi_fops.c:3201
>>  __do_compat_sys_ioctl fs/ioctl.c:1005 [inline]
>>  __se_compat_sys_ioctl fs/ioctl.c:948 [inline]
>>  __ia32_compat_sys_ioctl+0x23f/0x370 fs/ioctl.c:948
>>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>>  __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
>>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
>>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>> RIP: 0023:0xf7f15579
>> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 =
00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 9=
0 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>> RSP: 002b:00000000f503655c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000040946400
>> RDX: 00000000800000c0 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>  </TASK>
>> =E2=80=94[ end trace ]=E2=80=94
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-
>> Code disassembly (best guess), 2 bytes skipped:
>>    0:	10 06                	adc    %al,(%rsi)
>>    2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>>    6:	10 07                	adc    %al,(%rdi)
>>    8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>>    c:	10 08                	adc    %cl,(%rax)
>>    e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>>   1e:	00 51 52             	add    %dl,0x52(%rcx)
>>   21:	55                   	push   %rbp
>>   22:	89 e5                	mov    %esp,%ebp
>>   24:	0f 34                	sysenter
>>   26:	cd 80                	int    $0x80
>> * 28:	5d                   	pop    %rbp <=E2=80=93 trapping instruction
>>   29:	5a                   	pop    %rdx
>>   2a:	59                   	pop    %rcx
>>   2b:	c3                   	ret
>>   2c:	90                   	nop
>>   2d:	90                   	nop
>>   2e:	90                   	nop
>>   2f:	90                   	nop
>>   30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>>   37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
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


