Return-Path: <linux-kernel+bounces-827654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF029B92519
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A7A2A668E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D13126C2;
	Mon, 22 Sep 2025 16:55:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFBC31195A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560129; cv=none; b=mWHPvD4mw2ZN9Y3Z9XCWgCL/vRnWkwbk5nOGxjZUbD0/bCBwarGu7iXJvp29bj6Tn2gWQYILooLrFQ+qeBJRlFWDQhQKGPsoavJStTB7VbcN8QLsOYvpFgY2kGaC22PsVWcfNIm8QnR5RCI3xxgzhjtyreIc0atS7m1sCXIcRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560129; c=relaxed/simple;
	bh=WGz81dxzLgz6WlDdNAAF0u1pcsmKYkC6Q8jmjfOPbDg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cz98yGt1oX1Vje/6A3XVmmj3JVZjb7mzQzjukbHFLLfT8zvd1c32Tx+AHGGeUmS+SL50cGnwoUl0/jfybgOmCWq9AJbCun/CaynePMl0vczzuox95T2yjKyOCn4o6Yq8Wl2STcW1Cz/393wSLd/DEp41b31GIYQi6ZDfVggl1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42571c700d2so34443515ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560126; x=1759164926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0xb9NIAsGdDYlhda5LzLSBSNAiH4BEU4TqqsL4QFio=;
        b=RkUxeU4u3m4BFWw+5e3QpQuEnrk/KE+IlfRT+lZswZznVsLMAsst2TlSjHVorbk8+7
         S+Gw7+yo9Dt1uwPzHTwvm1Ox14AkGtUaBpMGCoVGVrtq6mlw4ptPrekDGI9TA11AxhV8
         9nGztDxHz/OQEvyUvZBzKXuIDBZmjXdOG8r73woQre+5uUm4+tZ0+WDurklEqcOjz2Z4
         MbpKCCvVHhz0ezYV4MUKanD4YRfGUTd7BsD6G7DwFffhxya/t/oUJGiEn1PXXr8NHOV8
         buRNQfnOwG2Q1How1VGTYzadFrDUOJkOkUxORh+MvDrm9z7ySBikWAVG88Za7zbhTmiJ
         B6MA==
X-Forwarded-Encrypted: i=1; AJvYcCUBu4BBheCaV32ZZjz1gnXbmGtQ1sQF+JAHoZfJ+lPDrqtr5L0Um4Goqi4nVU1AaXKgH+YtahgSmAUJJ8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoaz0SsEmChFmhnow/ZPRAJRQgq93dhh1xWGe9Gh/os0hw+tor
	aO1AoCg3x4D34V3FjiecHhsZVo8XhkchBFpZi02UXB/XvEmw6kMfTE2yCIju25N+7AOy+JvT4Z4
	uD+QtuAmfLHp3CkoRzG2PrFV3bQ6xZ4cGPS3VKLCKLKj205R2DUPutHmobL4=
X-Google-Smtp-Source: AGHT+IHZMXNl6ibNCnaPXXCi0Be+/BLAnYUz9Ds25+23JrLCCKe49CO6IY1ji2dsM/+ZArPBU4cARqK2oztPBdI+9syvDTyXQyle
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:425:7291:22f with SMTP id
 e9e14a558f8ab-42572910296mr82160385ab.32.1758560125759; Mon, 22 Sep 2025
 09:55:25 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:55:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d17f7d.050a0220.13cd81.05b8.GAE@google.com>
Subject: [syzbot] [iommu?] WARNING in intel_iommu_map_pages
From: syzbot <syzbot+6e970ad52c1b9e57e6b1@syzkaller.appspotmail.com>
To: baolu.lu@linux.intel.com, dwmw2@infradead.org, iommu@lists.linux.dev, 
	joro@8bytes.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b08f56fbbb9 Merge tag 'x86-urgent-2025-09-20' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142d3c7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=6e970ad52c1b9e57e6b1
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1740fe42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1037a712580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3b08f56f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f981dad47cf/vmlinux-3b08f56f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/031397abeebd/bzImage-3b08f56f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e970ad52c1b9e57e6b1@syzkaller.appspotmail.com

DMAR: ERROR: DMA PTE for vPFN 0xbe300 already set (to 55400003 not 51800003)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6199 at drivers/iommu/intel/iommu.c:1679 __domain_mapping drivers/iommu/intel/iommu.c:1679 [inline]
WARNING: CPU: 0 PID: 6199 at drivers/iommu/intel/iommu.c:1679 intel_iommu_map drivers/iommu/intel/iommu.c:3593 [inline]
WARNING: CPU: 0 PID: 6199 at drivers/iommu/intel/iommu.c:1679 intel_iommu_map_pages+0xaa7/0x1520 drivers/iommu/intel/iommu.c:3612
Modules linked in:
CPU: 0 UID: 0 PID: 6199 Comm: syz.2.40 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__domain_mapping drivers/iommu/intel/iommu.c:1679 [inline]
RIP: 0010:intel_iommu_map drivers/iommu/intel/iommu.c:3593 [inline]
RIP: 0010:intel_iommu_map_pages+0xaa7/0x1520 drivers/iommu/intel/iommu.c:3612
Code: ba 26 fc 8b 2d 1a e5 be 09 31 ff 89 ee e8 b1 06 48 fc 85 ed 74 0e e8 68 0b 48 fc 83 ed 01 89 2d ff e4 be 09 e8 5a 0b 48 fc 90 <0f> 0b 90 e9 da fa ff ff e8 4c 0b 48 fc 4c 8b 7c 24 40 48 8d 43 ff
RSP: 0018:ffffc900038575e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803b24e800 RCX: ffffffff8573920f
RDX: ffff88802577c880 RSI: ffffffff85739226 RDI: 0000000000000005
RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000000 R12: 00000000000ffb00
R13: 0000000000000001 R14: 0000000051800003 R15: 0000000000000002
FS:  0000555564edf500(0000) GS:ffff8880d66b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555884bf808 CR3: 000000005203d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 iommu_map_nosync+0x337/0x700 drivers/iommu/iommu.c:2505
 iommu_map_sg+0x1c1/0x9d0 drivers/iommu/iommu.c:2677
 iommu_dma_map_sg+0x88c/0xde0 drivers/iommu/dma-iommu.c:1483
 __dma_map_sg_attrs+0x293/0x590 kernel/dma/mapping.c:216
 dma_map_sgtable+0x78/0x100 kernel/dma/mapping.c:294
 system_heap_map_dma_buf+0x66/0xf0 drivers/dma-buf/heaps/system_heap.c:124
 dma_buf_map_attachment+0x15e/0x5f0 drivers/dma-buf/dma-buf.c:1126
 dma_buf_map_attachment_unlocked+0x9e/0x150 drivers/dma-buf/dma-buf.c:1196
 drm_gem_prime_import_dev drivers/gpu/drm/drm_prime.c:999 [inline]
 drm_gem_prime_import_dev+0x166/0x440 drivers/gpu/drm/drm_prime.c:971
 virtgpu_gem_prime_import+0x16c/0x800 drivers/gpu/drm/virtio/virtgpu_prime.c:316
 drm_gem_prime_fd_to_handle+0x1a6/0x5f0 drivers/gpu/drm/drm_prime.c:317
 drm_prime_fd_to_handle_ioctl+0xd6/0x110 drivers/gpu/drm/drm_prime.c:375
 drm_ioctl_kernel+0x1f1/0x3e0 drivers/gpu/drm/drm_ioctl.c:796
 drm_ioctl+0x5c9/0xc30 drivers/gpu/drm/drm_ioctl.c:893
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f377a58ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfa8b0f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f377a7d5fa0 RCX: 00007f377a58ec29
RDX: 00002000000000c0 RSI: 00000000c00c642e RDI: 0000000000000005
RBP: 00007ffdfa8b0fd0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f377a7d5fa0 R14: 00007f377a7d5fa0 R15: 0000000000000003
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

