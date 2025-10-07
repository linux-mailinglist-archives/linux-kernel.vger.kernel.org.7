Return-Path: <linux-kernel+bounces-844862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CDDBC2F51
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4BA63477A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41125B687;
	Tue,  7 Oct 2025 23:32:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9823F42D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879951; cv=none; b=sKJBWMGBUkvso+ON8C/dos4zsqpUoq+tE11gtR+zWvOWJTD/rI/JJyAzLc8uD3jH+ri8TQIedD4NtGFAprHRnC9kL7NYHpnWXevyL/Y1MJ35zoqjxj2mXyzAHGiIIfYjd8M0TOOQfe3Xn29Wx5kwQ5lCqAvC45hSkeNSXRv47sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879951; c=relaxed/simple;
	bh=oHFqVz1jq1oi6phvuAR2XlAJXCsaRdNNF0HwkIN+Do4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kaLFhYGQW+ZW6/lS+SvxkGlLKM6JCPUUXSzcVHKIzg3zpuq34PRYk39/KIBTSiYAPnWY1fjJ2jGJ1v/jwgp6oIj//Zc8hInGjiCLBGdE8tN0oVuBgf2s+dlZslIqwk8Jub9FN8lxaHiFVC4VxmVWAr/FzLXt1usuGAE10h4BN+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8ea63b6f262so1421313439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759879949; x=1760484749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+V4BB0SYrSnQNgVu+nCSW9roKQJL9Ev+We4fb/qOTk=;
        b=ZCeDyM8cJS+AQwbXemYjrJW2YqM2lnxt0APRv0QRvQZhmTbrEIzMM2iouUSndgkEps
         zbdG0w6062OVi/3xYv1pZlmHcW6D3pRjBPaPL3j6mRn39nL08cCzgZn67YW8sgAAcp2p
         GVCOy5OhMcLfopm6VJtbO9egWRqgSLBEPkabC6NI31W+6vphYnBeAkPwOy3ekFYvyN2C
         o1zx5c49CQCyXM/In4RTvcnQ0rlacGsuuzMAZ7VXBjLAPe9Mb/daLKCzCciAQTq03Ge4
         WlF9YTqsk389ljQREXxupCdgWMB5kYAfRbSm7AhCiA0K+HJCSnmrnZihPo41rcyPFToY
         P4+A==
X-Forwarded-Encrypted: i=1; AJvYcCWO9yLjrf/Ny9wiz66YsHOsipKpmofmCf/dcbIBc6ZiUlHtz6+irZMTkdfX4nERqdzdpjQz6wRg4js1TB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+8uVGl16Fh/mlC42m6GwGUxpIRzPrl7dFlP/vg10cIJwQcht
	ISiKvo77E9rgD81L9mcOLEfjA4Xq0CrfKSrMlcMBbGvtZJs7l/7X9R3dRRa/VUByVGIZBtT6Vw4
	I2xAeyTwh9vzFtbKhzxFipEk0QxSktW3wlKZPGoxUTVZKU6IVtNhiBaErpz0=
X-Google-Smtp-Source: AGHT+IE33uGQahccdyFgAdtwOojge90eBwTzHM4KgfC2NY/iYVmYRWSbUa0fG79ZfIzcVswvk/KkggMQiaCTdll9rjeV8AtcFEzj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1490:b0:8dd:d9c5:140d with SMTP id
 ca18e2360f4ac-93bd193c6b1mr115736039f.12.1759879949109; Tue, 07 Oct 2025
 16:32:29 -0700 (PDT)
Date: Tue, 07 Oct 2025 16:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5a30d.050a0220.256323.002e.GAE@google.com>
Subject: [syzbot] [iommu?] divide error in iova_bitmap_alloc
From: syzbot <syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    971199ad2a0f Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1570f92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87fcad19f7d09298
dashboard link: https://syzkaller.appspot.com/bug?extid=093a8a8b859472e6c257
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16286304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1370f92f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-971199ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4f2f91ba510/vmlinux-971199ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8fa7552ebcd0/bzImage-971199ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 6098 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:iova_bitmap_offset_to_index drivers/iommu/iommufd/iova_bitmap.c:135 [inline]
RIP: 0010:iova_bitmap_alloc+0xe8/0x350 drivers/iommu/iommufd/iova_bitmap.c:259
Code: e8 3d ad 7e fc 48 83 fd 3f 0f 87 c0 8c e9 fb e8 be b1 7e fc 89 e9 b8 08 00 00 00 31 d2 48 d3 e0 48 8d 7b 40 48 89 c1 4c 89 e0 <48> f7 f1 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 48 83
RSP: 0018:ffffc900034ffba8 EFLAGS: 00010246
RAX: ffffffffffffffff RBX: ffff888032636100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff853dc2d2 RDI: ffff888032636140
RBP: 000000000000003f R08: 0000000000000007 R09: 000000000000003f
R10: 000000000000003f R11: 0000000000000000 R12: ffffffffffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8c065aa0
FS:  000055558b0da500(0000) GS:ffff8880d6bdf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f463fff CR3: 000000004ee7c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 iommu_read_and_clear_dirty drivers/iommu/iommufd/io_pagetable.c:543 [inline]
 iopt_read_and_clear_dirty_data+0x271/0x4c0 drivers/iommu/iommufd/io_pagetable.c:603
 iommufd_hwpt_get_dirty_bitmap+0x1c3/0x340 drivers/iommu/iommufd/hw_pagetable.c:485
 iommufd_fops_ioctl+0x34d/0x540 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f705598eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeac4d43a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7055be5fa0 RCX: 00007f705598eec9
RDX: 0000200000000300 RSI: 0000000000003b8c RDI: 0000000000000003
RBP: 00007f7055a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7055be5fa0 R14: 00007f7055be5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iova_bitmap_offset_to_index drivers/iommu/iommufd/iova_bitmap.c:135 [inline]
RIP: 0010:iova_bitmap_alloc+0xe8/0x350 drivers/iommu/iommufd/iova_bitmap.c:259
Code: e8 3d ad 7e fc 48 83 fd 3f 0f 87 c0 8c e9 fb e8 be b1 7e fc 89 e9 b8 08 00 00 00 31 d2 48 d3 e0 48 8d 7b 40 48 89 c1 4c 89 e0 <48> f7 f1 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 48 83
RSP: 0018:ffffc900034ffba8 EFLAGS: 00010246
RAX: ffffffffffffffff RBX: ffff888032636100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff853dc2d2 RDI: ffff888032636140
RBP: 000000000000003f R08: 0000000000000007 R09: 000000000000003f
R10: 000000000000003f R11: 0000000000000000 R12: ffffffffffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8c065aa0
FS:  000055558b0da500(0000) GS:ffff8880d6cdf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558b0da808 CR3: 000000004ee7c000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	e8 3d ad 7e fc       	call   0xfc7ead42
   5:	48 83 fd 3f          	cmp    $0x3f,%rbp
   9:	0f 87 c0 8c e9 fb    	ja     0xfbe98ccf
   f:	e8 be b1 7e fc       	call   0xfc7eb1d2
  14:	89 e9                	mov    %ebp,%ecx
  16:	b8 08 00 00 00       	mov    $0x8,%eax
  1b:	31 d2                	xor    %edx,%edx
  1d:	48 d3 e0             	shl    %cl,%rax
  20:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
  24:	48 89 c1             	mov    %rax,%rcx
  27:	4c 89 e0             	mov    %r12,%rax
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  34:	fc ff df
  37:	48 89 f9             	mov    %rdi,%rcx
  3a:	48 c1 e9 03          	shr    $0x3,%rcx
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


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

