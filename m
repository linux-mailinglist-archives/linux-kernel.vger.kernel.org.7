Return-Path: <linux-kernel+bounces-824359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC96B88C45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6B0C4E2E57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078A2ED85D;
	Fri, 19 Sep 2025 10:10:55 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BB21254D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276654; cv=none; b=KdkXrJOHaPqsV5LnkemNJ4EXu9H96iNmdFrDLUVPN5n+BH92/LP0yqkymP5u/vVp8XVMB8zmJVgmSS0Fizfz3U/gYx4D4aCGxx7RyaRD4zqGvpwSUCRKBq1Qm2CA7Tx7XxD5AB3sf1kHpuFNUXZFd8mGEvIthL2tCqL7EgxhwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276654; c=relaxed/simple;
	bh=tG9dujoDJ7uvYQMvf2U2Q5OldvlWlrL3TY2JA+ksGhg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Qe46m6uJNI+HuT7fi4RsusQeYqqkIHe6iwLFYE0MRCGLgzaUIKiihVVmKHH0sN0qfZtWiD7q6mT64vT+6uUIHtAYfI4iOYA2PTLKiUf2X/XlOXZ2ZiQlW9s2SlatYb8P5Q7zo0mTP3OVkbJV6PxKkZfca0qpTPiB4M6R8rv0fF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-424048cbe07so27732075ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758276652; x=1758881452;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0iL4gam6jy/j+Q1w1Wozm+FmZ2/+1+dtAyUrkE2lBk=;
        b=Wxs36Lzx0Z9HOcE25abu7hBdiD5bxtyBmA7q845N6alVF9shRSNo9d+4YZydDhvTGo
         aT5krtxDRhskNUUHCeXaxHmyEHaHvRfUW5qSiZSHjTjTolcVmE1NLs1b1Ewhib40Maqs
         ISKBvGH6aSIY/zgvQ7j2dGmFZyFl8MCt2dNkrIFR4s5LLSvu14ajy7bCpcUCjIOuu//A
         eHv6YVe6eFUjSLdwGBYahV8wVsbsIiK43Q4l9y7nFueU+CpnSheT0MhdTz1HCy3ckwer
         Ku09ns1yO0iSc6xjusbQuBDfEOM1VLXwqnUsxZsd9J4FVwdGs4rIUpRlEozZL/o5eBAG
         MniQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJnoBF1b4mVo5sabKE5s5bINQHhn12qFYkLk5C+9Ni86y082qxuDgbPL7q10VHcj3u9WPm4PtLYy2IDKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBkP00TrkL757ahgRPNqBj7CJKTOAAbrii0vV2XMDLlGFgjHu
	2n6vI3uWVBEHdLLXu5qwgLiMskB1+OPruUxIGo0UWlRzzgicZmor6Bb99x2tciP647/huB2cjKS
	D9hK0sa6Gzgjkmbryr6eB9OZrnc3pxMp6iIl4EWxnuYRQ7QqwZe6vtAm4QMM=
X-Google-Smtp-Source: AGHT+IEydYfL6yv9HwG5VYgb+FBhHRzUkvTIcN6Lm+clEXUkyuuYyrC7hJyHRrmbjZo4+BPh3aN4tJYkRMIBe6lzWBeRycfQT/uQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2509:b0:423:51e8:366c with SMTP id
 e9e14a558f8ab-4248192a6cemr41508645ab.9.1758276651826; Fri, 19 Sep 2025
 03:10:51 -0700 (PDT)
Date: Fri, 19 Sep 2025 03:10:51 -0700
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd2c2b.a00a0220.37dadf.001a.GAE@google.com>
Subject: [syzbot ci] Re: kernel: Introduce multikernel architecture support
From: syzbot ci <syzbot+ci5a8560c05ff0980d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bhe@redhat.com, changyuanl@google.com, 
	cwang@multikernel.io, graf@amazon.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	rppt@kernel.org, xiyou.wangcong@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] kernel: Introduce multikernel architecture support
https://lore.kernel.org/all/20250918222607.186488-1-xiyou.wangcong@gmail.com
* [RFC Patch 1/7] kexec: Introduce multikernel support via kexec
* [RFC Patch 2/7] x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
* [RFC Patch 3/7] x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
* [RFC Patch 4/7] kernel: Introduce generic multikernel IPI communication framework
* [RFC Patch 5/7] x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
* [RFC Patch 6/7] kexec: Implement dynamic kimage tracking
* [RFC Patch 7/7] kexec: Add /proc/multikernel interface for kimage tracking

and found the following issue:
WARNING in note_page

Full report is available here:
https://ci.syzbot.org/series/9ca759c7-776a-4d45-a2f9-5e6ca245e989

***

WARNING in note_page

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      f83ec76bf285bea5727f478a68b894f5543ca76e
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/645f543b-aa06-4977-81f2-45a0b44a2133/config

Key type fscrypt-provisioning registered
kAFS: Red Hat AFS client v0.1 registering.
Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
Key type big_key registered
Key type encrypted registered
AppArmor: AppArmor sha256 policy hashing enabled
ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 75e3f237904f24df4a2b6e4eae1a8f34effb6643'
ima: Allocated hash algorithm: sha256
ima: No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux (disabled)
evm: security.SMACK64 (disabled)
evm: security.SMACK64EXEC (disabled)
evm: security.SMACK64TRANSMUTE (disabled)
evm: security.SMACK64MMAP (disabled)
evm: security.apparmor
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
PM:   Magic number: 9:738:504
usb usb41-port1: hash matches
usb usb40-port2: hash matches
netconsole: network logging started
gtp: GTP module loaded (pdp ctx size 128 bytes)
rdma_rxe: loaded
cfg80211: Loading compiled-in X.509 certificates for regulatory database
Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
clk: Disabling unused clocks
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
check access for rdinit=/init failed: -2, ignoring
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT4-fs (sda1): mounted filesystem b4773fba-1738-4da0-8a90-0fe043d0a496 ro with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 26168K
Write protecting the kernel read-only data: 210944k
Freeing unused kernel image (text/rodata gap) memory: 104K
Freeing unused kernel image (rodata/data gap) memory: 300K
------------[ cut here ]------------
x86/mm: Found insecure W+X mapping at address 0xffff888000096000
WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:248 note_page+0x12a5/0x14a0
Modules linked in:
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:note_page+0x12a5/0x14a0
Code: d5 49 00 c6 05 bd 7d 17 0e 01 90 43 80 3c 2e 00 74 08 4c 89 ff e8 9b 47 ad 00 49 8b 37 48 c7 c7 40 98 88 8b e8 1c 53 0d 00 90 <0f> 0b 90 90 49 bd 00 00 00 00 00 fc ff df e9 5a f1 ff ff 44 89 f9
RSP: 0000:ffffc90000047678 EFLAGS: 00010246
RAX: 0829288c8ce4fa00 RBX: ffffc90000047cf0 RCX: ffff88801c2d0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa274 R12: ffffffffffffffff
R13: dffffc0000000000 R14: 1ffff92000008fb2 R15: ffffc90000047d90
FS:  0000000000000000(0000) GS:ffff8881a3c09000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000df36000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ptdump_pte_entry+0xc6/0xe0
 walk_pte_range_inner+0x1ba/0x380
 walk_pgd_range+0x1467/0x1d40
 walk_page_range_debug+0x312/0x3d0
 ptdump_walk_pgd+0x126/0x320
 ptdump_walk_pgd_level_core+0x260/0x3e0
 kernel_init+0x53/0x1d0
 ret_from_fork+0x439/0x7d0
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

