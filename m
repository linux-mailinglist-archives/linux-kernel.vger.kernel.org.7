Return-Path: <linux-kernel+bounces-728863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E06B02E3D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B9E481570
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54232E36E9;
	Sun, 13 Jul 2025 00:18:13 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3B1853
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752365893; cv=none; b=FFfqFJMJlj1xdL3j+Av3A2HJE0KiawDAk/aHDDOjGsqw3MFLCryKZE9Sf8AoFgSmwSSBhU2WRPaZ1/Gppt2hgBllb1GMiN1T79cvYwUzF9YaliZ08k9e5HKMgyVNRor5EwusBiBptlmLe1X8W6wQ+M9xrhOJVlcSQMfhorAtcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752365893; c=relaxed/simple;
	bh=Hthcfaca7PpK8Z8xLt3lxHGkCe2s2agXQlmvOZ21HlQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nJ+3eIGB1g88EwJDJPowPqL06jYMj8O2ODlF4Z8Xx1ieiHcNYzeXo5TzIn/3QO+VOGUK5W5mktt13CPjhKu5fSZjle4fpv27kXKXH7grzaW4aWx/95iIc3tewhp8Gqh8u9RqjnjRgkeZx0KYDFO/ip9LCns+4X0vh00nCgHjtwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e059add15eso37465275ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752365891; x=1752970691;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoaGY1MZeQMxHNowKjU6To2/aSYirdx65b9Zfjncv9Y=;
        b=c3MekMd2rNhBr7YT4sVWjoAWaAVJOeqBLqYP7wqLXptqFvTzGoqqK3nba4XpquypT0
         QP4H0qgNCtvgyv940QE5sTEeR69eFE6gaJYHif5f3W8Mu6F7Hy7wJd/SEbWp+a3HkiuR
         TarCMpmSICa5u/4407FCkNeRR0VhrpXGh5IqU/+iy3cSON8DAMtxos4xbXvSbbLNprz+
         4/i1WtISzh96JorA2aWJGAEnzrRvqA+qkEsDnuISCOl835mJsiXbVrkm/144RGQq51b1
         zF/fmJmnD6U1deHRR94BySGgvnSEugi9OqaF/MQPTKt5OVy1hHalpIoPCtud5tfWMJ2r
         PVtQ==
X-Gm-Message-State: AOJu0YwD22j7ysRIBEcu4ygsTHN3CzWl1I307SAmp7JGTyiVmrYyLfFx
	ZdNAGdjB7jxq/bKE5qidnXUku94RoB0+feiNO5ec7768TYEUFM3Sqz6TJv64kNuPcsn27Cihjjc
	uo4uIUoXnfyej7HJ0Zcm8BgCUKRQEH8drkI9xDBAq+dFBWrmjyYuYjuAF5THtvQ==
X-Google-Smtp-Source: AGHT+IFYYP4paa5lmwhURS8tFyxMZTMJ4LsS279zsrl+IV6tJtA/jaGUjUPh3xui9aNNiOk73jA8qvg8B/9xBvGsk411eMstdUZF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:3de:12ff:3617 with SMTP id
 e9e14a558f8ab-3e253325ab9mr83392975ab.15.1752365890706; Sat, 12 Jul 2025
 17:18:10 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:18:10 -0700
In-Reply-To: <6872f886.a70a0220.3b380f.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872fb42.a70a0220.3b380f.0010.GAE@google.com>
Subject: Forwarded: Private message regarding: [syzbot] [kvmarm?] WARNING in pend_serror_exception
From: syzbot <syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Private message regarding: [syzbot] [kvmarm?] WARNING in pend_serror_exception
Author: kapoorarnav43@gmail.com

#syz test

From: Arnav Kapoor <kapoorarnnav43@gmail.com>
Date: Fri, 27 Dec 2024 02:35:00 +0000
Subject: [PATCH] arm64: KVM: Fix SError ESR validation to only allow ISS 
field

The current validation in __kvm_arm_vcpu_set_events incorrectly allows
userspace to set the ISV bit (bit 24) in the SError ESR when injecting
a SError through KVM_SET_VCPU_EVENTS. According to the ARM ARM and the
KVM API documentation, userspace should only be able to control the ISS
field (bits 23:0) of the ESR, not the ISV bit which is managed by hardware.

The problematic check:
  if (!((events->exception.serror_esr) & ~ESR_ELx_ISS_MASK))
      kvm_set_sei_esr(vcpu, events->exception.serror_esr);
  else
      return -EINVAL;

allows the ISV bit because ESR_ELx_ISS_MASK includes bit 24 (GENMASK(24,0)).
However, the ISV bit should be set only by KVM itself when calling 
kvm_set_sei_esr(), and userspace should not be able to control it.

Fix this by changing the validation to only allow bits 23:0 (the actual
ISS field without the ISV bit):

  if (events->exception.serror_esr & ~GENMASK(23, 0))
      return -EINVAL;

This prevents userspace from setting reserved bits and the ISV bit while
still allowing control over the intended ISS field. The condition is
simplified since we now have a straightforward check for invalid bits.

Reported-by: syzbot+92be0215d467e7deb043@syzkaller.appspotmail.com
Fixes: 0e5b9065dcf3 ("KVM: arm64: Inject SError exception into guest")
Signed-off-by: Arnav Kapoor <kapoorarnnav43@gmail.com>
---
 arch/arm64/kvm/guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 123456..789012 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -843,7 +843,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
  if (serror_pending && has_esr) {
  if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
  return -EINVAL;
- if (!((events->exception.serror_esr) & ~ESR_ELx_ISS_MASK))
+ if (events->exception.serror_esr & ~GENMASK(23, 0))
+ return -EINVAL;
+
+ kvm_set_sei_esr(vcpu, events->exception.serror_esr);


On Sunday, 13 July 2025 at 05:36:31 UTC+5:30 syzbot wrote:

Hello, 

syzbot found the following issue on: 

HEAD commit: 15724a984643 Merge branch 'kvm-arm64/doublefault2' into kv.. 
git tree: git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git 
next 
console output: https://syzkaller.appspot.com/x/log.txt?x=123090f0580000 
kernel config: https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314 
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565 
compiler: Debian clang version 20.1.7 
(++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 
20.1.7 
userspace arch: arm64 
syz repro: https://syzkaller.appspot.com/x/repro.syz?x=1324fe8c580000 
C reproducer: https://syzkaller.appspot.com/x/repro.c?x=1206ed82580000 

Downloadable assets: 
disk image (non-bootable): 
https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-15724a98.raw.xz 
vmlinux: 
https://storage.googleapis.com/syzbot-assets/ec0f03d375a1/vmlinux-15724a98.xz 
kernel image: 
https://storage.googleapis.com/syzbot-assets/a36232f8c6dd/Image-15724a98.gz.xz 

IMPORTANT: if you fix the issue, please add the following tag to the 
commit: 
Reported-by: syzbot+1f6f09...@syzkaller.appspotmail.com 

------------[ cut here ]------------ 
WARNING: CPU: 0 PID: 3603 at arch/arm64/kvm/inject_fault.c:71 
pend_serror_exception+0x19c/0x5ac arch/arm64/kvm/inject_fault.c:71 
Modules linked in: 
CPU: 0 UID: 0 PID: 3603 Comm: syz.2.16 Not tainted 
6.16.0-rc3-syzkaller-g15724a984643 #0 PREEMPT 
Hardware name: linux,dummy-virt (DT) 
pstate: 81402009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--) 
pc : pend_serror_exception+0x19c/0x5ac arch/arm64/kvm/inject_fault.c:71 
lr : pend_serror_exception+0x19c/0x5ac arch/arm64/kvm/inject_fault.c:71 
sp : ffff80008e807930 
x29: ffff80008e807930 x28: d7f0000016ae8028 x27: 0000000000000001 
x26: 0000000000000000 x25: 0000000000000001 x24: 00000000000000d7 
x23: d7f0000016ae82a8 x22: 00000000000000d7 x21: d7f0000016ae8e81 
x20: 0000000000000007 x19: efff800000000000 x18: 0000000000000000 
x17: 000000000000005a x16: ffff800080011d9c x15: 0000000020000200 
x14: ffffffffffffffff x13: 0000000000000028 x12: 0000000000000081 
x11: 81f000001f049564 x10: 0000000000ff0100 x9 : 0000000000000000 
x8 : 81f000001f048000 x7 : ffff800080b08704 x6 : ffff80008e807a88 
x5 : ffff80008e807a88 x4 : 0000000000000001 x3 : ffff8000801a2e80 
x2 : 0000000000000000 x1 : 0000000000000002 x0 : 0000000000000000 
Call trace: 
pend_serror_exception+0x19c/0x5ac arch/arm64/kvm/inject_fault.c:71 (P) 
kvm_inject_serror_esr+0x274/0xe40 arch/arm64/kvm/inject_fault.c:330 
__kvm_arm_vcpu_set_events+0x1d4/0x238 arch/arm64/kvm/guest.c:-1 
kvm_arm_vcpu_set_events arch/arm64/kvm/arm.c:1698 [inline] 
kvm_arch_vcpu_ioctl+0xed8/0x16b0 arch/arm64/kvm/arm.c:1810 
kvm_vcpu_ioctl+0x5c4/0xc2c virt/kvm/kvm_main.c:4632 
vfs_ioctl fs/ioctl.c:51 [inline] 
__do_sys_ioctl fs/ioctl.c:907 [inline] 
__se_sys_ioctl fs/ioctl.c:893 [inline] 
__arm64_sys_ioctl+0x18c/0x244 fs/ioctl.c:893 
__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline] 
invoke_syscall+0x90/0x2b4 arch/arm64/kernel/syscall.c:49 
el0_svc_common+0x180/0x2f4 arch/arm64/kernel/syscall.c:132 
do_el0_svc+0x58/0x74 arch/arm64/kernel/syscall.c:151 
el0_svc+0x58/0x160 arch/arm64/kernel/entry-common.c:767 
el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786 
el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600 
irq event stamp: 2728 
hardirqs last enabled at (2727): [<ffff80008653cb88>] 
__raw_read_unlock_irqrestore include/linux/rwlock_api_smp.h:241 [inline] 
hardirqs last enabled at (2727): [<ffff80008653cb88>] 
_raw_read_unlock_irqrestore+0x44/0xbc kernel/locking/spinlock.c:268 
hardirqs last disabled at (2728): [<ffff800086517e08>] el1_dbg+0x24/0x80 
arch/arm64/kernel/entry-common.c:511 
softirqs last enabled at (2702): [<ffff8000800c988c>] 
local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32 
softirqs last disabled at (2700): [<ffff8000800c9858>] 
local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19 
---[ end trace 0000000000000000 ]--- 


--- 
This report is generated by a bot. It may contain errors. 
See https://goo.gl/tpsmEJ for more information about syzbot. 
syzbot engineers can be reached at syzk...@googlegroups.com. 

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


