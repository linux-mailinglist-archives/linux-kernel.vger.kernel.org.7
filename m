Return-Path: <linux-kernel+bounces-723827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9179FAFEB52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249BA547BF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9892E7F31;
	Wed,  9 Jul 2025 14:03:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D92E7F18
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069787; cv=none; b=rcl5c75tf4sfTMUWosEjTshLKGML5bL3mN8qqx71u5rCiQ9UDyxn2dasVrKb5QFFsA5Dz1/VBFy9Nz5rYBHqbYrD2CXqDKTirZDF+4uqSK+IA9XanhrktX14LAo1B46hDAET5hU6Kjvu8xFyND6ETIzmnvIhFP1HoyWlhlXMhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069787; c=relaxed/simple;
	bh=a34zGHu1I1jDa/GyCerCP9toe9Od/QE3keA07KZVL5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CsmVl81anknZh/HdyNKJgGff6IGpAp62Hw5vMcpxCrrxh10mSotqhctrWqOmhKhb1eZTlbMqAIYaV8QQNu+xLc+/vaiWCQCIK8CNH1/d/D6K1e1VCQH1SutEyFRTQobKYb+GCickMG1yA7SOQNTW3vEus3QDa8V0vTo94TnMn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cfff5669bso107525639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069784; x=1752674584;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyli3tgfMm7d+rWWytd5SPTdViDDSWPOumbLCY48DGs=;
        b=L0cm2N+l5sQbdgc1KLXTdJvwe9iXB1sMYXXcdjuYcpRobfVELn0Yk7QUkM9s9qPAwn
         TBgaeBTjMBkYXHvgDbQYyjV3Ev1HkfIa3pvXTR69B3DwmMmvIKtjCW0lEc+lmGYiVtMM
         CZjvzFhQ297KSqfO+F0/6HeoD4FaD4Lh4S7CDjYn7sPdtUFlqEMiXxax54uDZQ+h1Ja/
         1vJ1Fn8VjMrvYv6CFcuIuLVOI30zG1XXSfKsFVTVFzOVX/4OmD86PcxmiMwFHTkuHa1p
         ohoQglFpsQHAyIzbDr9QUD7WvypiOmVnzFbS/qf/n5vpdfEYU5RAMXfFtCJRIdFgADZY
         o6oA==
X-Gm-Message-State: AOJu0Yxq67RF+e7fQ8ND9EtqQaEyWT2vM1XlnY7nVPXjBqqdKZXA/SLq
	CTJMt+K1qjB6I0CMB3mAjx4jvjRZx4qTDsodD61WPeuil0JowUIK/2Dt+nOk0dty2K8x9/BpNu4
	bQPw0PYnis/1PPmJ5kqvubKSy/TwspjskhCTAMFKV8rWCKkeTAm4EPX7SQnI=
X-Google-Smtp-Source: AGHT+IFhhohkd59LiE4bnbh2uhusExTkzCcA1Oi2oRY7PvdBmGw3fUmUyqjHsner5wqmNltEXMo59kkYb7IIsy5Mj+a/3xu6yKR6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c08:b0:867:973:f2cb with SMTP id
 ca18e2360f4ac-8795c24ee1fmr254045839f.7.1752069784197; Wed, 09 Jul 2025
 07:03:04 -0700 (PDT)
Date: Wed, 09 Jul 2025 07:03:04 -0700
In-Reply-To: <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686e7698.050a0220.c28f5.0006.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

    T1] usbcore: registered new interface driver ssu100
[   12.803467][    T1] usbserial: USB Serial support registered for Quatech=
 SSU-100 USB to Serial Driver
[   12.813847][    T1] usbcore: registered new interface driver symbolseria=
l
[   12.822971][    T1] usbserial: USB Serial support registered for symbol
[   12.830470][    T1] usbcore: registered new interface driver ti_usb_3410=
_5052
[   12.838383][    T1] usbserial: USB Serial support registered for TI USB =
3410 1 port adapter
[   12.847393][    T1] usbserial: USB Serial support registered for TI USB =
5052 2 port adapter
[   12.856857][    T1] usbcore: registered new interface driver upd78f0730
[   12.864214][    T1] usbserial: USB Serial support registered for upd78f0=
730
[   12.872005][    T1] usbcore: registered new interface driver visor
[   12.878832][    T1] usbserial: USB Serial support registered for Handspr=
ing Visor / Palm OS
[   12.888619][    T1] usbserial: USB Serial support registered for Sony Cl=
ie 5.0
[   12.897025][    T1] usbserial: USB Serial support registered for Sony Cl=
ie 3.5
[   12.905181][    T1] usbcore: registered new interface driver wishbone_se=
rial
[   12.912848][    T1] usbserial: USB Serial support registered for wishbon=
e_serial
[   12.921084][    T1] usbcore: registered new interface driver whiteheat
[   12.928135][    T1] usbserial: USB Serial support registered for Connect=
 Tech - WhiteHEAT - (prerenumeration)
[   12.939389][    T1] usbserial: USB Serial support registered for Connect=
 Tech - WhiteHEAT
[   12.948619][    T1] usbcore: registered new interface driver xr_serial
[   12.955889][    T1] usbserial: USB Serial support registered for xr_seri=
al
[   12.963719][    T1] usbcore: registered new interface driver xsens_mt
[   12.972185][    T1] usbserial: USB Serial support registered for xsens_m=
t
[   12.980323][    T1] usbcore: registered new interface driver adutux
[   12.987512][    T1] usbcore: registered new interface driver appledispla=
y
[   12.995415][    T1] usbcore: registered new interface driver cypress_cy7=
c63
[   13.003293][    T1] usbcore: registered new interface driver cytherm
[   13.010571][    T1] usbcore: registered new interface driver emi26 - fir=
mware loader
[   13.019440][    T1] usbcore: registered new interface driver emi62 - fir=
mware loader
[   13.027806][    T1] usbcore: registered new device driver apple-mfi-fast=
charge
[   13.036824][    T1] usbcore: registered new interface driver ljca
[   13.044111][    T1] usbcore: registered new interface driver idmouse
[   13.052002][    T1] usbcore: registered new interface driver iowarrior
[   13.059704][    T1] usbcore: registered new interface driver isight_firm=
ware
[   13.067642][    T1] usbcore: registered new interface driver usblcd
[   13.074816][    T1] usbcore: registered new interface driver ldusb
[   13.082081][    T1] usbcore: registered new interface driver legousbtowe=
r
[   13.089958][    T1] usbcore: registered new interface driver usbtest
[   13.097300][    T1] usbcore: registered new interface driver usb_ehset_t=
est
[   13.105262][    T1] usbcore: registered new interface driver trancevibra=
tor
[   13.113543][    T1] usbcore: registered new interface driver uss720
[   13.120280][    T1] uss720: USB Parport Cable driver for Cables using th=
e Lucent Technologies USS720 Chip
[   13.130535][    T1] uss720: NOTE: this is a special purpose driver to al=
low nonstandard
[   13.138957][    T1] uss720: protocols (eg. bitbang) over USS720 usb to p=
arallel cables
[   13.147209][    T1] uss720: If you just want to connect to a printer, us=
e usblp instead
[   13.156564][    T1] usbcore: registered new interface driver usbsevseg
[   13.164290][    T1] usbcore: registered new interface driver yurex
[   13.172561][    T1] usbcore: registered new interface driver chaoskey
[   13.180124][    T1] usbcore: registered new interface driver sisusb
[   13.187445][    T1] usbcore: registered new interface driver lvs
[   13.194534][    T1] usbcore: registered new interface driver cxacru
[   13.201660][    T1] usbcore: registered new interface driver speedtch
[   13.209706][    T1] usbcore: registered new interface driver ueagle-atm
[   13.217258][    T1] xusbatm: malformed module parameters
[   13.236709][    T1] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, dri=
ver 02 May 2005
[   13.245196][    T1] dummy_hcd dummy_hcd.0: Dummy host controller
[   13.257875][    T1] dummy_hcd dummy_hcd.0: new USB bus registered, assig=
ned bus number 1
[   13.277863][    T1] usb usb1: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0002, bcdDevice=3D 6.16
[   13.288670][    T1] usb usb1: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[   13.296864][    T1] usb usb1: Product: Dummy host controller
[   13.303515][    T1] usb usb1: Manufacturer: Linux 6.16.0-rc5-syzkaller-0=
0038-g733923397fd9-dirty dummy_hcd
[   13.313553][    T1] usb usb1: SerialNumber: dummy_hcd.0
[   13.333561][    T1] hub 1-0:1.0: USB hub found
[   13.342305][    T1] hub 1-0:1.0: 1 port detected
[   13.350916][    T1] ------------[ cut here ]------------
[   13.356580][    T1] kernel BUG at ./include/linux/usb.h:1990!
[   13.362686][    T1] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[   13.368994][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
6.0-rc5-syzkaller-00038-g733923397fd9-dirty #0 PREEMPT(full)=20
[   13.372565][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[   13.372565][    T1] RIP: 0010:__create_pipe+0xa2/0xb0
[   13.372565][    T1] Code: 80 e1 07 80 c1 03 38 c1 7c a5 4c 89 f7 e8 56 8=
f 0a fb eb 9b e8 5f 33 a9 fa 90 0f 0b e8 57 33 a9 fa 90 0f 0b e8 4f 33 a9 f=
a 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
[   13.372565][    T1] RSP: 0000:ffffc90000066680 EFLAGS: 00010293
[   13.372565][    T1] RAX: ffffffff8716c411 RBX: 0000000000000081 RCX: fff=
f88801caf8000
[   13.372565][    T1] RDX: 0000000000000000 RSI: 0000000000000081 RDI: 000=
000000000000f
[   13.372565][    T1] RBP: 0000000000000001 R08: ffffc900000665c7 R09: 1ff=
ff9200000ccb8
[   13.372565][    T1] R10: dffffc0000000000 R11: fffff5200000ccb9 R12: 000=
00000000001f4
[   13.372565][    T1] R13: 1ffff11004fd0c37 R14: ffff888027e82000 R15: fff=
f888027e861b8
[   13.372565][    T1] FS:  0000000000000000(0000) GS:ffff8881261a1000(0000=
) knlGS:0000000000000000
[   13.372565][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.372565][    T1] CR2: 0000000000000000 CR3: 000000000dd38000 CR4: 000=
00000003526f0
[   13.372565][    T1] Call Trace:
[   13.372565][    T1]  <TASK>
[   13.372565][    T1]  hub_probe+0x2300/0x3840
[   13.372565][    T1]  ? __pfx_hub_probe+0x10/0x10
[   13.372565][    T1]  ? _raw_spin_unlock_irqrestore+0xad/0x110
[   13.372565][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   13.372565][    T1]  ? ktime_get_mono_fast_ns+0x2af/0x2d0
[   13.372565][    T1]  ? pm_runtime_enable+0x1f3/0x340
[   13.372565][    T1]  usb_probe_interface+0x644/0xbc0
[   13.372565][    T1]  ? __pfx_usb_probe_interface+0x10/0x10
[   13.372565][    T1]  really_probe+0x26a/0x9a0
[   13.372565][    T1]  __driver_probe_device+0x18c/0x2f0
[   13.372565][    T1]  driver_probe_device+0x4f/0x430
[   13.372565][    T1]  __device_attach_driver+0x2ce/0x530
[   13.372565][    T1]  bus_for_each_drv+0x251/0x2e0
[   13.372565][    T1]  ? __pfx___device_attach_driver+0x10/0x10
[   13.372565][    T1]  ? __pfx_bus_for_each_drv+0x10/0x10
[   13.372565][    T1]  __device_attach+0x2b8/0x400
[   13.372565][    T1]  ? __pfx___device_attach+0x10/0x10
[   13.372565][    T1]  ? do_raw_spin_unlock+0x122/0x240
[   13.372565][    T1]  bus_probe_device+0x185/0x260
[   13.372565][    T1]  device_add+0x7b6/0xb50
[   13.372565][    T1]  usb_set_configuration+0x1ab9/0x2120
[   13.372565][    T1]  usb_generic_driver_probe+0x8d/0x150
[   13.372565][    T1]  usb_probe_device+0x1c1/0x390
[   13.372565][    T1]  ? __pfx_usb_probe_device+0x10/0x10
[   13.372565][    T1]  really_probe+0x26a/0x9a0
[   13.372565][    T1]  __driver_probe_device+0x18c/0x2f0
[   13.372565][    T1]  driver_probe_device+0x4f/0x430
[   13.372565][    T1]  __device_attach_driver+0x2ce/0x530
[   13.372565][    T1]  bus_for_each_drv+0x251/0x2e0
[   13.372565][    T1]  ? __pfx___device_attach_driver+0x10/0x10
[   13.372565][    T1]  ? __pfx_bus_for_each_drv+0x10/0x10
[   13.372565][    T1]  __device_attach+0x2b8/0x400
[   13.372565][    T1]  ? __pfx___device_attach+0x10/0x10
[   13.372565][    T1]  ? do_raw_spin_unlock+0x122/0x240
[   13.372565][    T1]  bus_probe_device+0x185/0x260
[   13.372565][    T1]  device_add+0x7b6/0xb50
[   13.372565][    T1]  usb_new_device+0x9fd/0x1610
[   13.372565][    T1]  ? __pfx_usb_new_device+0x10/0x10
[   13.372565][    T1]  ? register_root_hub+0x153/0x590
[   13.372565][    T1]  ? kfree+0x18e/0x440
[   13.372565][    T1]  register_root_hub+0x275/0x590
[   13.372565][    T1]  ? usb_add_hcd+0xb90/0x1050
[   13.372565][    T1]  usb_add_hcd+0xba1/0x1050
[   13.372565][    T1]  dummy_hcd_probe+0x134/0x270
[   13.372565][    T1]  platform_probe+0x148/0x1d0
[   13.372565][    T1]  ? __pfx_platform_probe+0x10/0x10
[   13.372565][    T1]  really_probe+0x26a/0x9a0
[   13.372565][    T1]  __driver_probe_device+0x18c/0x2f0
[   13.372565][    T1]  driver_probe_device+0x4f/0x430
[   13.372565][    T1]  __device_attach_driver+0x2ce/0x530
[   13.372565][    T1]  bus_for_each_drv+0x251/0x2e0
[   13.372565][    T1]  ? __pfx___device_attach_driver+0x10/0x10
[   13.372565][    T1]  ? __pfx_bus_for_each_drv+0x10/0x10
[   13.372565][    T1]  __device_attach+0x2b8/0x400
[   13.372565][    T1]  ? __pfx___device_attach+0x10/0x10
[   13.372565][    T1]  ? do_raw_spin_unlock+0x122/0x240
[   13.372565][    T1]  bus_probe_device+0x185/0x260
[   13.372565][    T1]  device_add+0x7b6/0xb50
[   13.372565][    T1]  platform_device_add+0x4b4/0x820
[   13.372565][    T1]  ? deferred_probe_extend_timeout+0x79/0xb0
[   13.372565][    T1]  dummy_hcd_init+0x293/0x1070
[   13.372565][    T1]  ? __pfx_dummy_hcd_init+0x10/0x10
[   13.372565][    T1]  ? __pfx_add_device_randomness+0x10/0x10
[   13.372565][    T1]  ? configfs_register_subsystem+0x4ca/0x520
[   13.372565][    T1]  ? __pfx_dummy_hcd_init+0x10/0x10
[   13.372565][    T1]  do_one_initcall+0x233/0x820
[   13.372565][    T1]  ? __pfx_dummy_hcd_init+0x10/0x10
[   13.372565][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   13.372565][    T1]  ? rcu_is_watching+0x15/0xb0
[   13.372565][    T1]  ? trace_irq_disable+0x37/0x110
[   13.372565][    T1]  ? preempt_schedule_irq+0xde/0x150
[   13.372565][    T1]  ? __pfx_preempt_schedule_irq+0x10/0x10
[   13.372565][    T1]  ? irqentry_exit+0x74/0x90
[   13.372565][    T1]  ? lockdep_hardirqs_on+0x9c/0x150
[   13.372565][    T1]  ? irqentry_exit+0x74/0x90
[   13.372565][    T1]  ? lockdep_hardirqs_on+0x9c/0x150
[   13.372565][    T1]  ? next_arg+0x498/0x5e0
[   13.372565][    T1]  ? parameq+0x14d/0x170
[   13.372565][    T1]  ? parse_args+0x993/0xa70
[   13.372565][    T1]  ? __pfx_parse_args+0x10/0x10
[   13.372565][    T1]  ? rcu_is_watching+0x15/0xb0
[   13.372565][    T1]  do_initcall_level+0x137/0x1f0
[   13.372565][    T1]  do_initcalls+0x69/0xd0
[   13.372565][    T1]  kernel_init_freeable+0x3d9/0x570
[   13.372565][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   13.372565][    T1]  ? _raw_spin_unlock_irq+0x23/0x50
[   13.372565][    T1]  ? __pfx_kernel_init+0x10/0x10
[   13.372565][    T1]  kernel_init+0x1d/0x1d0
[   13.372565][    T1]  ? __pfx_kernel_init+0x10/0x10
[   13.372565][    T1]  ret_from_fork+0x3fc/0x770
[   13.372565][    T1]  ? __pfx_ret_from_fork+0x10/0x10
[   13.372565][    T1]  ? __switch_to_asm+0x39/0x70
[   13.372565][    T1]  ? __switch_to_asm+0x33/0x70
[   13.372565][    T1]  ? __pfx_kernel_init+0x10/0x10
[   13.372565][    T1]  ret_from_fork_asm+0x1a/0x30
[   13.372565][    T1]  </TASK>
[   13.372565][    T1] Modules linked in:
[   13.372565][    C1] vkms_vblank_simulate: vblank timer overrun
[   13.995865][    T1] ---[ end trace 0000000000000000 ]---
[   14.001889][    T1] RIP: 0010:__create_pipe+0xa2/0xb0
[   14.007135][    T1] Code: 80 e1 07 80 c1 03 38 c1 7c a5 4c 89 f7 e8 56 8=
f 0a fb eb 9b e8 5f 33 a9 fa 90 0f 0b e8 57 33 a9 fa 90 0f 0b e8 4f 33 a9 f=
a 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
[   14.026940][    T1] RSP: 0000:ffffc90000066680 EFLAGS: 00010293
[   14.033310][    T1] RAX: ffffffff8716c411 RBX: 0000000000000081 RCX: fff=
f88801caf8000
[   14.041768][    T1] RDX: 0000000000000000 RSI: 0000000000000081 RDI: 000=
000000000000f
[   14.049904][    T1] RBP: 0000000000000001 R08: ffffc900000665c7 R09: 1ff=
ff9200000ccb8
[   14.058174][    T1] R10: dffffc0000000000 R11: fffff5200000ccb9 R12: 000=
00000000001f4
[   14.066824][    T1] R13: 1ffff11004fd0c37 R14: ffff888027e82000 R15: fff=
f888027e861b8
[   14.074933][    T1] FS:  0000000000000000(0000) GS:ffff8881260a1000(0000=
) knlGS:0000000000000000
[   14.084097][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.090767][    T1] CR2: ffff88823ffff000 CR3: 000000000dd38000 CR4: 000=
00000003526f0
[   14.098809][    T1] Kernel panic - not syncing: Fatal exception
[   14.100723][    T1] Kernel Offset: disabled
[   14.100723][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build4116787073=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 6a8fcbc4a6
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D6a8fcbc4a6172c831c89c507007f59fba13408aa -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250226-150939'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"6a8fcbc4a6172c831c89c507007f59fba1=
3408aa\"
/usr/bin/ld: /tmp/ccrMQnbM.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D148c1a8c580000


Tested on:

commit:         73392339 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df481202e4ff2d13=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3D592e2ab8775dbe0bf=
09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13f27f705800=
00


