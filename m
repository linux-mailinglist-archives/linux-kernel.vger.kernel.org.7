Return-Path: <linux-kernel+bounces-766198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B473EB243B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5931889D27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884D2EA490;
	Wed, 13 Aug 2025 08:00:41 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4462BCF67
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072040; cv=none; b=XINKXXzuRzD/grH3hXFXE5E82/0cTJHlZ2ZwrWBCNKO07OV+62fuhWS8pzQlod6boXn39t7oC3WUQud80KOR/WA7MqbpxknPCNDkzr676mzURsfvBCTWZCd54ZuSr+FeOYTKaRxxAU1iqLs3CnlLj64ePWj/5EKcT8u+5fEekgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072040; c=relaxed/simple;
	bh=Cy1GWWDMHLkePeNdZmg6sD8ncrhXRngMBR8t6TyJxqQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S+I8FxVB1ZxgVuR+Iul1oet2f0nrlrafov0cgV3YZM1lziXyxvNOPFZSMt9xFKDSV/WRToptrtrI18ODW7zPzCaX86U0/bJBPKAyDSm2GOpgFgRdm6KDGAoVwIV/ATnlj1OnneIS3CJaf1E9MicOdeXMC5UniFrEp4j8+uad2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88174f2d224so625977439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755072038; x=1755676838;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9SyPMIf9WPm9Uar843pT5BCzaWI4QvvZ1WxW3gzybo=;
        b=qxwWSuOSPzbYvKjnD3VmCt8WDnnFBVIh3mtz84giHrWTOO0P2eTyJk1lxMs1ySAORi
         PR/U7NDUjrh+puId2VuofhJv/YhdnOwj2FEe3TkR0gCbDmys1bz70Nv4sXaxcj/IuuDX
         uHMlUkkp3YjiLOIGmSqqgY2tffhNzsNEvLMeN0fd65AugbPla84Tl18Y1lbSyV5sXN2e
         W4tJEVHjKVH2mWhHIn0/HO+OpYYX4RLn8VtUGHN5NxqcWgUI6X+gkOfuk4tPezqegWtl
         nT4IMbG5JI+ZqKwNMsJAkEDYVe+m54/7EAF6Ur98ZRvTxvhEct7y3ErQh6JZ9sdw4QyU
         nbrQ==
X-Gm-Message-State: AOJu0Yyswpvg12TcIL8gj4K3TfEmLh9dTujICollxaTF2aYJUDsEzTNJ
	UrJtjpGrcGxZmlxw902Ch7iGEEqayaijhYKFQcsosWK1Y6xwi6WMZ9GyuZzS58+ZkjcLQ4kKgK5
	l68UBHLfd96Y539oRp+85uoDv9wApk7N/4jSe29Avo2lr7TY9tkJaKjxt09uRFg==
X-Google-Smtp-Source: AGHT+IGdX9TMmhxEPvNIz33M/FJrkfOa4Q7jVayiBfHHVLr/b+W9lr7z7vpufAEqxahUoiHAhC8rsyEpxI+78FeOGD8fiMCbeujU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4f10:b0:876:19b9:1aaa with SMTP id
 ca18e2360f4ac-88429694fe9mr325900939f.9.1755072037972; Wed, 13 Aug 2025
 01:00:37 -0700 (PDT)
Date: Wed, 13 Aug 2025 01:00:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689c4625.050a0220.51d73.00ba.GAE@google.com>
Subject: [syzbot] [sound?] linux-next test error: general protection fault in snd_seq_oss_midi_check_new_port
From: syzbot <syzbot+51c1105d06b79f38316d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43c3c17f0c80 Add linux-next specific files for 20250813
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c02c34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9952dc295dad7ea
dashboard link: https://syzkaller.appspot.com/bug?extid=51c1105d06b79f38316d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8911961a91d3/disk-43c3c17f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2f0ab430eb7/vmlinux-43c3c17f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a0d0d7fc76a/bzImage-43c3c17f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51c1105d06b79f38316d@syzkaller.appspotmail.com

device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
device-mapper: multipath round-robin: version 1.2.0 loaded
device-mapper: multipath queue-length: version 0.2.0 loaded
device-mapper: multipath service-time: version 0.3.0 loaded
Bluetooth: HCI UART driver ver 2.3
Bluetooth: HCI UART protocol H4 registered
Bluetooth: HCI UART protocol BCSP registered
Bluetooth: HCI UART protocol LL registered
Bluetooth: HCI UART protocol Three-wire (H5) registered
Bluetooth: HCI UART protocol QCA registered
Bluetooth: HCI UART protocol AG6XX registered
Bluetooth: HCI UART protocol Marvell registered
usbcore: registered new interface driver bcm203x
usbcore: registered new interface driver bpa10x
usbcore: registered new interface driver bfusb
usbcore: registered new interface driver btusb
usbcore: registered new interface driver ath3k
Modular ISDN core version 1.1.29
NET: Registered PF_ISDN protocol family
DSP module 2.0
mISDN_dsp: DSP clocks every 80 samples. This equals 1 jiffies.
mISDN: Layer-1-over-IP driver Rev. 2.00
0 virtual devices registered
usbcore: registered new interface driver HFC-S_USB
intel_pstate: CPU model not supported
VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
usbcore: registered new interface driver vub300
usbcore: registered new interface driver ushc
iscsi: registered transport (iser)
SoftiWARP attached
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
usbcore: registered new interface driver es2_ap_driver
comedi: version 0.7.76 - http://www.comedi.org
comedi comedi4: comedi_test: 1000000 microvolt, 100000 microsecond waveform attached
comedi comedi4: driver 'comedi_test' has successfully auto-configured 'comedi_test'.
usbcore: registered new interface driver dt9812
usbcore: registered new interface driver ni6501
usbcore: registered new interface driver usbdux
usbcore: registered new interface driver usbduxfast
usbcore: registered new interface driver usbduxsigma
usbcore: registered new interface driver vmk80xx
greybus: registered new driver hid
greybus: registered new driver gbphy
gb_gbphy: registered new driver usb
asus_wmi: ASUS WMI generic driver loaded
gnss: GNSS driver registered with major 493
usbcore: registered new interface driver gnss-usb
usbcore: registered new interface driver hdm_usb
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc1-next-20250813-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:snd_seq_oss_midi_check_new_port+0x4a9/0x770 sound/core/seq/oss/seq_oss_midi.c:196
Code: 2d 4c 51 d3 10 4c 8b 2c 24 4c 89 e8 48 c1 e8 03 48 bb 00 00 00 00 00 fc ff df 0f b6 04 18 84 c0 0f 85 7f 02 00 00 45 89 65 00 <0f> b6 03 84 c0 0f 85 8e 02 00 00 4c 63 3c 25 00 00 00 00 bf 20 00
RSP: 0000:ffffc90000067038 EFLAGS: 00010046
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff88801ce90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000001f
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200000cde4 R12: 0000000000000000
R13: ffff88802e92b400 R14: 0000000000000a02 R15: ffff88802e92b438
FS:  0000000000000000(0000) GS:ffff888125d10000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000df36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 receive_announce+0x22f/0x300 sound/core/seq/oss/seq_oss_init.c:132
 __snd_seq_deliver_single_event sound/core/seq/seq_clientmgr.c:599 [inline]
 _snd_seq_deliver_single_event sound/core/seq/seq_clientmgr.c:645 [inline]
 snd_seq_deliver_single_event+0x8dd/0xc90 sound/core/seq/seq_clientmgr.c:660
 __deliver_to_subscribers sound/core/seq/seq_clientmgr.c:707 [inline]
 deliver_to_subscribers sound/core/seq/seq_clientmgr.c:735 [inline]
 snd_seq_deliver_event+0x538/0x9c0 sound/core/seq/seq_clientmgr.c:785
 snd_seq_kernel_client_dispatch+0x2c0/0x400 sound/core/seq/seq_clientmgr.c:2407
 snd_seq_system_broadcast+0x11d/0x170 sound/core/seq/seq_system.c:88
 snd_seq_ioctl_create_port+0x733/0x950 sound/core/seq/seq_clientmgr.c:1313
 create_port+0x258/0x360 sound/core/seq/seq_dummy.c:146
 register_client+0x5d/0x190 sound/core/seq/seq_dummy.c:198
 do_one_initcall+0x233/0x820 init/main.c:1281
 do_initcall_level+0x104/0x190 init/main.c:1343
 do_initcalls+0x59/0xa0 init/main.c:1359
 kernel_init_freeable+0x334/0x4b0 init/main.c:1591
 kernel_init+0x1d/0x1d0 init/main.c:1481
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:snd_seq_oss_midi_check_new_port+0x4a9/0x770 sound/core/seq/oss/seq_oss_midi.c:196
Code: 2d 4c 51 d3 10 4c 8b 2c 24 4c 89 e8 48 c1 e8 03 48 bb 00 00 00 00 00 fc ff df 0f b6 04 18 84 c0 0f 85 7f 02 00 00 45 89 65 00 <0f> b6 03 84 c0 0f 85 8e 02 00 00 4c 63 3c 25 00 00 00 00 bf 20 00
RSP: 0000:ffffc90000067038 EFLAGS: 00010046
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff88801ce90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000001f
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200000cde4 R12: 0000000000000000
R13: ffff88802e92b400 R14: 0000000000000a02 R15: ffff88802e92b438
FS:  0000000000000000(0000) GS:ffff888125d10000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000df36000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	2d 4c 51 d3 10       	sub    $0x10d3514c,%eax
   5:	4c 8b 2c 24          	mov    (%rsp),%r13
   9:	4c 89 e8             	mov    %r13,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  17:	fc ff df
  1a:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
  1e:	84 c0                	test   %al,%al
  20:	0f 85 7f 02 00 00    	jne    0x2a5
  26:	45 89 65 00          	mov    %r12d,0x0(%r13)
* 2a:	0f b6 03             	movzbl (%rbx),%eax <-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	0f 85 8e 02 00 00    	jne    0x2c3
  35:	4c 63 3c 25 00 00 00 	movslq 0x0,%r15
  3c:	00
  3d:	bf                   	.byte 0xbf
  3e:	20 00                	and    %al,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

