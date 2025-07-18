Return-Path: <linux-kernel+bounces-736188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC7B099E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A55583270
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20601C2335;
	Fri, 18 Jul 2025 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMJJhMoB"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E53597A;
	Fri, 18 Jul 2025 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806460; cv=none; b=e+vXv1t34DgIIPvhg9x4NO2WqedIbh28Ki94uhgMftUV6TcKKVlItaZSFTunUS32EzrissHgoeVJCa2XUunauRhPKJ7U/ZHDkSCRtjGGxw+rPxs62CTkSgVQVp1gbQfxopCCutkOm8oylArQx8wI4GmRkCTMAhg9oteHs4fZg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806460; c=relaxed/simple;
	bh=zjbosixNEkJDrZS4fhH89B5+iWJQ1Qz46PNMyrUwLvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhjQJ8VKQg21AqldesNwbjNqDzyl2rHheofHH6SWNCOlK1BuVUOZ0pzSEGeTomMP4k5veyHWuUSTh8XCxaNHd5c5poxE7gIVNaTKLs+fr3+QgMm3rAh7AVJ+zMnaGH+BV5gQu69OrICuKvWQH9JkGDxupEbnH/tzCIE58zdq9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMJJhMoB; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7db5c13088so1488869276.1;
        Thu, 17 Jul 2025 19:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752806458; x=1753411258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ4LOAOob/LkHvQXROaayHmaWstTEeGGFVoz6Vy2ano=;
        b=dMJJhMoBJfcPQ2+GrWkyhq4Z74oshR2TAHnGFVb6EhGB/UdcjMkgrngIRluHwknu/Y
         p41OMH8NQflXcZKpvrdWmyFUVtVtcAV1FYtYcBlSivsB2zNTFxvlWuTdbfwiKOeATQLo
         mn7VO4Zl2a6es3QyTqk6DVR/SAumJxv/hqgp5C5IWp0KpG+37no6vW4GWq6GMCsSx1p3
         JKgfXs1CruE4jYGYIYXQep8PaRYVMhtTdaRyp1+imu380vszKUt9kkmYYdNWIHktzvDy
         ejuVyH1aqcI0n+rLvo69Lsfk1PPNU+BGx49WyHzB3+zsq2ob7gDTcv7ukkU4ZlbqOOUg
         3iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752806458; x=1753411258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ4LOAOob/LkHvQXROaayHmaWstTEeGGFVoz6Vy2ano=;
        b=pNEpaiLCaif5ZM6W3ugPjzGGHUf8q10rQbTN20+X625D4xbIfgCJ1HyAREF2SCJeSq
         ldru89dREb8ZM/uTSSJUsEl6YbNXeEZOSEHwfTSX5Td5hVOuwsYWSyyaRTXawamoNdQD
         8A7UUQx1XZLqFFl60/T10ZuXr7+Ks+5bz91rwSLLdEWF4vtfO8jYz45yyaw3LE6fay85
         vAfijv3v/CltKf0wjh/ulb5hwRpkg48i6RmFBjxOD/MFwsW8L1uyjGOTW4zZNUDtl2aQ
         v0w9Y9FaT6CUJyILzCVGbz5JMEnIE7IjLrQCpDR9UuLLTEHI613qyl5mFp2RCXuy7k1P
         Lzxg==
X-Forwarded-Encrypted: i=1; AJvYcCU+5T8x1jQceH72pa4/r5nPn7WF5HTFhEiklUcIJecHjH4ks1LwxfWh3Ee/GKhPfr3ixOKG/N/0MzJ/irg=@vger.kernel.org, AJvYcCXazVxknknbjr9LUUJ7Fr3EKudEAaZXiLztbloFLK7pW0Kq6HuWCoHPUGfQquz0eflA64Ye7XUdx4fN@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHDwKUHWcknZ8X33yJQiluxsyw+wEe0BUQG9ylonaKf4a17Ty
	CJ9kHui4aGrxoQsT+nbWKSlNZouiioVTP+AGUrcSaBGcvmSZYQU5x2UiDK9eXvCtcylAq0ni8uW
	cHi6sIktnVkzSOGsbEf85hrillNeWdxg=
X-Gm-Gg: ASbGnctFkavDbO0vE+j5VYZinkndnFE9ecAJHRKCo1fWRozUyMPUssUGlEKM7muJoVO
	Ql9oXkofW/cYRWxxMcBEfhwkq8rzrcmYjuoqwuiICNBT7QHEuQ2T4ZWnHX1X03EnH4cFgo1Ox4y
	eEOwZqR4OovDMpaLn/uRqcVaI7MJo7UeThbEKzrXvUTaXyInOsSKYUtmlLEW8auW/zxbJxp4Ynp
	ckDjw==
X-Google-Smtp-Source: AGHT+IEKuF2eXVE79POPFPZlufzwFWBFEWVpmYM9+tFdxFoyFYqRUyJB6LiV4dcR2b0kxchcYwJFwfqk8UWPfLUKsfQ=
X-Received: by 2002:a05:6902:1002:b0:e87:9825:dcd6 with SMTP id
 3f1490d57ef6-e8d773d20c2mr2445596276.15.1752806457445; Thu, 17 Jul 2025
 19:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUZTDm0KAfX_qziTrn6E3+sRksF5ormxhHConqTKWvHBQ@mail.gmail.com>
 <8033fcb7-e97d-4b6d-a3fb-a9a49f8b69f2@rowland.harvard.edu>
In-Reply-To: <8033fcb7-e97d-4b6d-a3fb-a9a49f8b69f2@rowland.harvard.edu>
From: cen zhang <zzzccc427@gmail.com>
Date: Fri, 18 Jul 2025 10:40:47 +0800
X-Gm-Features: Ac12FXyTLyuQ9Dqte1u6haTbiyn9BGIKe67yJvbbVcsMF8-GkbVYv5JqJWcs2tE
Message-ID: <CAFRLqsXoECbj6ffSvO9FhB2NAPE73j88DH7ES_e4vQYv1j4HeQ@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in xhci_hub_control
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-usb@vger.kernel.org, 
	gality365@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thank you for your guidance.

I've collected more specific information about the test environment
and the reproducer's behavior, which I believe provides a clearer
picture of the issue.

The C reproducer is hardcoded to target /dev/bus/usb/002/001, which
corresponds to the XHCI root hub on the USB 3.0 (5000M) bus.

Below is the cleaned-up version of the C reproducer used to trigger the iss=
ue:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <dirent.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <linux/usbdevice_fs.h>
#include <linux/usb/ch9.h>


int main(void)
{
    int fd =3D open("/dev/bus/usb/002/001", O_RDWR);
    if (fd < 0) {
        fprintf(stderr, "Could not find or open any USB hub device.
Aborting.\n");
        return EXIT_FAILURE;
    }
    printf("Successfully opened a hub device (fd=3D%d).\n", fd);

    struct usb_ctrlrequest ctrl;
    struct usbdevfs_urb urb;

    memset(&ctrl, 0, sizeof(ctrl));
    memset(&urb, 0, sizeof(urb));

    ctrl.bRequestType =3D USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_OTHER; //=
 0xa3
    ctrl.bRequest =3D 0;
    ctrl.wValue =3D 0;
    ctrl.wIndex =3D 0x8001; // This unusual value is preserved as it is
likely key to the bug
    ctrl.wLength =3D 0;

    urb.type =3D USBDEVFS_URB_TYPE_CONTROL; // Value is 2
    urb.endpoint =3D 0; // Control requests are always on endpoint 0
    urb.buffer =3D &ctrl; // Point the URB's data buffer to our control req=
uest
    urb.buffer_length =3D sizeof(ctrl); // The size of the control request =
data

    printf("Submitting control URB to the hub...\n");

    // Submit the URB via ioctl. The magic number 0x8038550a is
USBDEVFS_SUBMITURB.
    int ret =3D ioctl(fd, USBDEVFS_SUBMITURB, &urb);
    if (ret < 0) {
        perror("ioctl(USBDEVFS_SUBMITURB) failed");
    } else {
        printf("ioctl call succeeded.\n");
    }

    close(fd);
    return 0;
}

Here is the relevant lsusb -t output:

/:  Bus 03.Port 1: Dev 1, Class=3Droot_hub, Driver=3Ddummy_hcd/1p, 480M
/:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 5000M
    |__ Port 1: Dev 2, If 0, Class=3DMass Storage, Driver=3Dusb-storage, 50=
00M
/:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 480M

Below is the detailed QEMU configuration I used.

#!/bin/bash
qemu-system-x86_64 \
  -m 8192 \
  -smp 4 \
  -chardev socket,id=3DSOCKSYZ,server=3Don,wait=3Doff,host=3Dlocalhost,port=
=3D18878 \
  -mon chardev=3DSOCKSYZ,mode=3Dcontrol \
  -display none \
  -serial stdio \
  -no-reboot \
  -name VM-0 \
  -device virtio-rng-pci \
  -cpu host,migratable=3Doff \
  -enable-kvm \
  -snapshot \
  -drive if=3Dnone,id=3Dmy-usb-drive,file=3D/home/BASS/syzkaller/test/usb-d=
isk.img,format=3Draw
\
  -device qemu-xhci,id=3Dxhci \
  -device usb-storage,bus=3Dxhci.0,drive=3Dmy-usb-drive \
  -device e1000,netdev=3Dnet0 \
  -netdev user,id=3Dnet0,hostfwd=3Dtcp:127.0.0.1:50695-:22,hostfwd=3Dtcp::1=
2982-:6060
\
  -hda /home/BASS/syzkaller/test/bookworm.img \
  -hdb /home/BASS/syzkaller/test/disk_btrfs.qcow2 \
  -kernel /home/BASS/linux/arch/x86/boot/bzImage \
  -append "root=3D/dev/sda console=3DttyS0 net.ifnames=3D0"


Additionally, I=E2=80=99ve encountered other KASAN reports that may share t=
he
same root cause. I=E2=80=99ve attached them below in case they are helpful =
for
your analysis.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in xhci_get_port_status
drivers/usb/host/xhci-hub.c:1169 [inline]
BUG: KASAN: slab-use-after-free in xhci_hub_control+0x5c2b/0x5e20
drivers/usb/host/xhci-hub.c:1274
Read of size 8 at addr ffff88810501ce40 by task syz-executor.3/580811

CPU: 3 UID: 0 PID: 580811 Comm: syz-executor.3 Not tainted
6.16.0-rc6-00002-g155a3c003e55 #7 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xab/0xe0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcb/0x5f0 mm/kasan/report.c:480
 kasan_report+0xb8/0xf0 mm/kasan/report.c:593
 xhci_get_port_status drivers/usb/host/xhci-hub.c:1169 [inline]
 xhci_hub_control+0x5c2b/0x5e20 drivers/usb/host/xhci-hub.c:1274
 rh_call_control drivers/usb/core/hcd.c:656 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
 usb_hcd_submit_urb+0x165c/0x1d30 drivers/usb/core/hcd.c:1529
 usb_submit_urb+0x866/0x1650 drivers/usb/core/urb.c:581
 proc_do_submiturb+0x192c/0x3a60 drivers/usb/core/devio.c:1971
 proc_submiturb drivers/usb/core/devio.c:2003 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2703 [inline]
 usbdev_ioctl+0x2a6e/0x4000 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa8/0x270 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe79d10002d
Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe79c46f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe79d23bf80 RCX: 00007fe79d10002d
RDX: 0000000020000040 RSI: 000000008038550a RDI: 0000000000000003
RBP: 00007fe79d1614a6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe79d23bf80 R15: 00007fe79c44f000
 </TASK>

Allocated by task 580121:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x7f/0x90 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2333 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0xc7/0x380 mm/slub.c:4745
 exit_mmap+0x3dc/0x8f0 mm/mmap.c:1309
 __mmput kernel/fork.c:1121 [inline]
 mmput+0x6e/0x320 kernel/fork.c:1144
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x713/0x2740 kernel/exit.c:952
 do_group_exit+0xc7/0x280 kernel/exit.c:1105
 get_signal+0x1eed/0x1fb0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x80/0x780 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x77/0xc0 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x244/0x270 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 32:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x38/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x133/0x360 mm/slub.c:4842
 slab_free_after_rcu_debug+0x6f/0x270 mm/slub.c:4680
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0x5f3/0x1a20 kernel/rcu/tree.c:2832
 handle_softirqs+0x176/0x530 kernel/softirq.c:579
 run_ksoftirqd kernel/softirq.c:968 [inline]
 run_ksoftirqd+0x22/0x30 kernel/softirq.c:960
 smpboot_thread_fn+0x3fb/0x910 kernel/smpboot.c:164
 kthread+0x38c/0x6f0 kernel/kthread.c:464
 ret_from_fork+0x15e/0x240 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_record_aux_stack+0x8c/0xa0 mm/kasan/generic.c:548
 __call_rcu_common.constprop.0+0x70/0x930 kernel/rcu/tree.c:3094
 exit_mmap+0x3dc/0x8f0 mm/mmap.c:1309
 __mmput kernel/fork.c:1121 [inline]
 mmput+0x6e/0x320 kernel/fork.c:1144
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x713/0x2740 kernel/exit.c:952
 do_group_exit+0xc7/0x280 kernel/exit.c:1105
 get_signal+0x1eed/0x1fb0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x80/0x780 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x77/0xc0 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x244/0x270 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88810501ce40
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff88810501ce40, ffff88810501ce60)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000
index:0xffff88810501c0c0 pfn:0x10501c
flags: 0x200000000000200(workingset|node=3D0|zone=3D2)
page_type: f5(slab)
raw: 0200000000000200 ffff888100042780 ffffea0004494390 ffffea000418b210
raw: ffff88810501c0c0 0000000000400036 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810501cd00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88810501cd80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88810501ce00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                           ^
 ffff88810501ce80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88810501cf00: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 3 UID: 0 PID: 580811 Comm: syz-executor.3 Tainted: G    B
      6.16.0-rc6-00002-g155a3c003e55 #7 PREEMPT(voluntary)
Tainted: [B]=3DBAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:xhci_get_usb3_port_status drivers/usb/host/xhci-hub.c:1052 [inlin=
e]
RIP: 0010:xhci_get_port_status drivers/usb/host/xhci-hub.c:1195 [inline]
RIP: 0010:xhci_hub_control+0x6aa/0x5e20 drivers/usb/host/xhci-hub.c:1274
Code: fe 41 83 fc 3f 0f 8e 2e 25 00 00 e8 40 56 0b fe 48 8b 44 24 38
48 8d 78 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 60 50 00 00 48 8b 44 24 38 4c 8b 60 10 4c 89 e7
RSP: 0018:ffff88811b9bf900 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000200 RCX: ffffffffaf015c80
RDX: 0000000000000002 RSI: ffffc90007560000 RDI: 0000000000000010
RBP: ffff88810669e000 R08: 0000000000000001 R09: fffffbfff652da0c
R10: 0000000000000040 R11: 6e696c6261736944 R12: 0000000000000040
R13: 0000000000001203 R14: ffff88810669ac58 R15: ffff88810669a000
FS:  00007fe79c46f640(0000) GS:ffff888244878000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20f1bed988 CR3: 000000010cb68003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 rh_call_control drivers/usb/core/hcd.c:656 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
 usb_hcd_submit_urb+0x165c/0x1d30 drivers/usb/core/hcd.c:1529
 usb_submit_urb+0x866/0x1650 drivers/usb/core/urb.c:581
 proc_do_submiturb+0x192c/0x3a60 drivers/usb/core/devio.c:1971
 proc_submiturb drivers/usb/core/devio.c:2003 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2703 [inline]
 usbdev_ioctl+0x2a6e/0x4000 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa8/0x270 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe79d10002d
Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe79c46f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe79d23bf80 RCX: 00007fe79d10002d
RDX: 0000000020000040 RSI: 000000008038550a RDI: 0000000000000003
RBP: 00007fe79d1614a6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe79d23bf80 R15: 00007fe79c44f000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:xhci_get_usb3_port_status drivers/usb/host/xhci-hub.c:1052 [inlin=
e]
RIP: 0010:xhci_get_port_status drivers/usb/host/xhci-hub.c:1195 [inline]
RIP: 0010:xhci_hub_control+0x6aa/0x5e20 drivers/usb/host/xhci-hub.c:1274
Code: fe 41 83 fc 3f 0f 8e 2e 25 00 00 e8 40 56 0b fe 48 8b 44 24 38
48 8d 78 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 60 50 00 00 48 8b 44 24 38 4c 8b 60 10 4c 89 e7
RSP: 0018:ffff88811b9bf900 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000200 RCX: ffffffffaf015c80
RDX: 0000000000000002 RSI: ffffc90007560000 RDI: 0000000000000010
RBP: ffff88810669e000 R08: 0000000000000001 R09: fffffbfff652da0c
R10: 0000000000000040 R11: 6e696c6261736944 R12: 0000000000000040
R13: 0000000000001203 R14: ffff88810669ac58 R15: ffff88810669a000
FS:  00007fe79c46f640(0000) GS:ffff888244878000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20f1bed988 CR3: 000000010cb68003 CR4: 0000000000770ef0
PKRU: 55555554
note: syz-executor.3[580811] exited with irqs disabled
note: syz-executor.3[580811] exited with preempt_count 1
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 41 83 fc 3f           cmp    $0x3f,%r12d
   4: 0f 8e 2e 25 00 00     jle    0x2538
   a: e8 40 56 0b fe       call   0xfe0b564f
   f: 48 8b 44 24 38       mov    0x38(%rsp),%rax
  14: 48 8d 78 10           lea    0x10(%rax),%rdi
  18: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1f: fc ff df
  22: 48 89 fa             mov    %rdi,%rdx
  25: 48 c1 ea 03           shr    $0x3,%rdx
* 29: 80 3c 02 00           cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruct=
ion
  2d: 0f 85 60 50 00 00     jne    0x5093
  33: 48 8b 44 24 38       mov    0x38(%rsp),%rax
  38: 4c 8b 60 10           mov    0x10(%rax),%r12
  3c: 4c 89 e7             mov    %r12,%rdi



Best regards,
Cen Zhang

Alan Stern <stern@rowland.harvard.edu> =E4=BA=8E2025=E5=B9=B47=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=BA=94 10:05=E5=86=99=E9=81=93=EF=BC=9A

>
> On Thu, Jul 17, 2025 at 08:24:17PM +0800, cen zhang wrote:
> > Hi maintainers,
> >
> > I've encountered a kernel crash in the xhci driver, which was found by
> > Syzkaller on kernel version 6.16.0-rc6 (commit 155a3c003e55).
> >
> > The KASAN report points to a slab-use-after-free read within
> > xhci_hub_control. What we find puzzling is that the free operation
> > occurred in a completely different module, as indicated by the free
> > stack trace.
> >
> > We suspect this might not be a false positive, but rather a complex
> > bug whose root cause is not a simple UAF within the same driver. We've
> > tried to trace how this could happen but are struggling to understand
> > the connection.
> >
> > Could you possibly offer your expertise and help us understand if this
> > is a known issue or a new bug? Any insight you could provide would be
> > immensely helpful.
>
> My initial guess is that you're experiencing pointer corruption.  Such
> bugs are notoriously difficult to locate and pin down.
>
> Alan Stern

