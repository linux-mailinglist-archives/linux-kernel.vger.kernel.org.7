Return-Path: <linux-kernel+bounces-693630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA9AE01A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 11:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA52D189AACB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B230261581;
	Thu, 19 Jun 2025 09:27:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804F2192F1
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325226; cv=none; b=n0c+89HH8XJmmSIBaEV+xGz8ba/XX5Z79t572A5NdGYDenQCHxqerT3DOdqG5k4kPzIL/naftH5Akx1KWgGJfrQx4bf3t3kQLkriivkxXSpWgkZaghs4kdp2ptbfyxWI6D1UI8hf/Sx+i8U8UHHpAWvedUGSpN9eWe86R6xLmyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325226; c=relaxed/simple;
	bh=YzqEdqnXtrRl14tLFzXaR9Gr1jJtHMs6o1cKsBfqSi8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tekvYkqjLV95SWO5bIKJT58fN0sIqfzNv93h1BWIfecHtIPnH8A1U5NOG8/gm3+CaoFvGTmuqCmmj4tPhQ5IxCLVryVFK10UYw9l8id7W/2Ug3ERuUtR0ql2sfh7bV4wkIgELkrjLRgFplWfCr6CjyRw4cHv0M+AgSYfQ52hCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddc1af1e5bso14101025ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 02:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750325224; x=1750930024;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usI3AhJh3HV1QbPsuvHEWSxJ+AJq7a9rLQxp846bUQo=;
        b=VI3Ri1s9kCkIhKoR14nun+tp/hz+EsSOGryEm2e0HnFf/gN397diAbEit8ePCHNqGx
         0rYEQlWpzarEnP8UTjJxzQPtnAZk5hFMRQ8O6ArrB7wKy+U+n4uuHmQNoFHPJTlx2kWE
         Xa+qPxxB1zqjQkwH0fwJzRqLjxIzP38jOGQivNjiJlXo9gS1NDe6ZZnN/bpUGqLhaREF
         uu7Y/tYdyLyzNBtb0huXTzkzxZN4Vrsq8IgZpLX+fz29HxANy+1aq9bBNZdN9eBlO+2a
         pVw8imrsMcZRS6uHa0G7UsO6LfX0ZCdxCpOFd6GFZ+ypyDyXRO4nFN3lmdE8+LkzX0FD
         zoTg==
X-Forwarded-Encrypted: i=1; AJvYcCWzUuH5Jd/r3Mg0v2hOjceZ2jil99sFuEIXmDLCpI29633RFHAAaqVkOvL7fZUMLsmqXdq4yZgxehas6Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1oDdReLj6HFPX4pQIk6RecJIbqEsY9F4JlYlfT+HhGOdf/E5
	GIL4e5DE3k/YD8tTbX7EMuvd+5m8+GtzqqVeAx9wzcW0ELra9xz7PMl2DNCG/+XyaUpwkyNAVot
	o8oXMZSqF9LpDYnl8wHuT5oGvYn2qI5K9PkvhEIEYGW76I0znWV+7PsRGz70=
X-Google-Smtp-Source: AGHT+IFataWPQJtowWCtcVUJA/G0sSgKnX9tDkgNttd5BgJPwMfto83OZyIpGNA14AvNeXriyNyBK9sMErhjLA93XPFghIfs7J+h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440d:20b0:3de:2032:a2cb with SMTP id
 e9e14a558f8ab-3de2032a747mr97872535ab.19.1750325223670; Thu, 19 Jun 2025
 02:27:03 -0700 (PDT)
Date: Thu, 19 Jun 2025 02:27:03 -0700
In-Reply-To: <20250619082423.1156-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6853d7e7.050a0220.216029.01e6.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in do_sync_mmap_readahead
From: syzbot <syzbot+8e4be574cb8c40140a2a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

[    T1] NET: Registered PF_CAIF protocol family
[   24.858546][    T1] NET: Registered PF_IEEE802154 protocol family
[   24.865885][    T1] Key type dns_resolver registered
[   24.871090][    T1] Key type ceph registered
[   24.876288][    T1] libceph: loaded (mon/osd proto 15/24)
[   24.884263][    T1] batman_adv: B.A.T.M.A.N. advanced 2025.2 (compatibil=
ity version 15) loaded
[   24.894245][    T1] openvswitch: Open vSwitch switching datapath
[   24.903135][    T1] NET: Registered PF_VSOCK protocol family
[   24.909310][    T1] mpls_gso: MPLS GSO support
[   24.940272][    T1] IPI shorthand broadcast: enabled
[   26.791823][    T1] sched_clock: Marking stable (26730019966, 52777718)-=
>(26793217984, -10420300)
[   26.807012][    T1] registered taskstats version 1
[   26.827752][    T1] Loading compiled-in X.509 certificates
[   26.863200][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: b0b377692fc411d7236ea8f3768d6795102ecba9'
[   27.236170][    T1] zswap: loaded using pool 842/zsmalloc
[   27.245377][    T1] Demotion targets for Node 0: null
[   27.250727][    T1] Demotion targets for Node 1: null
[   27.256079][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   30.066600][    T1] Key type .fscrypt registered
[   30.071493][    T1] Key type fscrypt-provisioning registered
[   30.086084][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   30.117948][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   30.126712][    T1] Key type big_key registered
[   30.131565][    T1] Key type encrypted registered
[   30.136642][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   30.143441][    T1] ima: No TPM chip found, activating TPM-bypass!
[   30.149878][    T1] Loading compiled-in module X.509 certificates
[   30.182451][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: b0b377692fc411d7236ea8f3768d6795102ecba9'
[   30.193491][    T1] ima: Allocated hash algorithm: sha256
[   30.199640][    T1] ima: No architecture policies found
[   30.205622][    T1] evm: Initialising EVM extended attributes:
[   30.211605][    T1] evm: security.selinux (disabled)
[   30.216747][    T1] evm: security.SMACK64 (disabled)
[   30.222132][    T1] evm: security.SMACK64EXEC (disabled)
[   30.227790][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   30.233738][    T1] evm: security.SMACK64MMAP (disabled)
[   30.239331][    T1] evm: security.apparmor
[   30.243617][    T1] evm: security.ima
[   30.247628][    T1] evm: security.capability
[   30.252479][    T1] evm: HMAC attrs: 0x1
[   30.259868][    T1] PM:   Magic number: 13:101:273
[   30.265655][    T1] usb usb13: hash matches
[   30.270343][    T1] usb usb1-port1: hash matches
[   30.275292][    T1] tty ttyy1: hash matches
[   30.279826][    T1] tty tty10: hash matches
[   30.284210][    T1] net lo: hash matches
[   30.288574][    T1] netconsole: network logging started
[   30.294945][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   30.308726][    T1] rdma_rxe: loaded
[   30.313912][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   30.325214][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   30.334078][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   30.343538][    T1] clk: Disabling unused clocks
[   30.345985][    T9] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   30.348482][    T1] ALSA device list:
[   30.358089][    T9] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   30.364326][    T1]   #0: Dummy 1
[   30.374437][    T1]   #1: Loopback 1
[   30.378185][    T1]   #2: Virtual MIDI Card 1
[   30.386515][    T1] md: Waiting for all devices to be available before a=
utodetect
[   30.394317][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   30.400836][    T1] md: Autodetecting RAID arrays.
[   30.405881][    T1] md: autorun ...
[   30.409516][    T1] md: ... autorun DONE.
[   30.575909][    T1] EXT4-fs (sda1): orphan cleanup on readonly fs
[   30.585025][    T1] EXT4-fs (sda1): mounted filesystem 4f91c6db-4997-4bb=
4-91b8-7e83a20c1bf1 ro with ordered data mode. Quota mode: none.
[   30.597892][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   30.624198][    T1] devtmpfs: mounted
[   30.704264][    T1] Freeing unused kernel image (initmem) memory: 26212K
[   30.715021][    T1] Write protecting the kernel read-only data: 210944k
[   30.733240][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 1172K
[   30.745123][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 508K
[   30.875501][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   30.883698][    T1] x86/mm: Checking user space page tables
[   30.994480][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   31.007496][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   31.017701][    T1] Run /sbin/init as init process
[   31.590358][ T5171] mount (5171) used greatest stack depth: 24104 bytes =
left
[   31.661528][ T5172] EXT4-fs (sda1): re-mounted 4f91c6db-4997-4bb4-91b8-7=
e83a20c1bf1 r/w.
mount: mounting devtmpfs on /dev failed: Device or resource busy
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   31.817727][ T5177] modprobe (5177) used greatest stack depth: 23416 byt=
es left
[   31.830101][ T5176] mount (5176) used greatest stack depth: 21736 bytes =
left
Starting syslogd: OK
Starting acpid: [   32.410716][ T5191] acpid (5191) used greatest stack dep=
th: 21096 bytes left
OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   33.188666][ T5206] udevd[5206]: starting ve=
rsion 3.2.14
[   33.492691][ T5207] udevd[5207]: starting eudev-3.2.14
[   33.501115][ T5206] udevd (5206) used greatest stack depth: 20056 bytes =
left
[   33.915611][ T5207] ------------[ cut here ]------------
[   33.921482][ T5207] WARNING: ./include/linux/rwsem.h:203 at remove_vma+0=
x21e/0x290, CPU#1: udevd/5207
[   33.931072][ T5207] Modules linked in:
[   33.935154][ T5207] CPU: 1 UID: 0 PID: 5207 Comm: udevd Not tainted 6.16=
.0-rc2-next-20250618-syzkaller-03311-g6e5ab6fee68d-dirty #0 PREEMPT(full)=
=20
[   33.948955][ T5207] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[   33.959417][ T5207] RIP: 0010:remove_vma+0x21e/0x290
[   33.964649][ T5207] Code: 2e ab ff 4c 89 f7 e8 81 b4 0b 00 eb 05 e8 8a 2=
e ab ff 48 89 df 5b 41 5c 41 5d 41 5e 41 5f 5d e9 98 e5 f4 ff e8 73 2e ab f=
f 90 <0f> 0b 90 e9 83 fe ff ff 48 c7 c1 30 9e a1 8f 80 e1 07 80 c1 03 38
[   33.984690][ T5207] RSP: 0018:ffffc90002fa7a28 EFLAGS: 00010293
[   33.990797][ T5207] RAX: ffffffff821528cd RBX: ffff88802ec31b40 RCX: fff=
f8880618b3c00
[   33.998843][ T5207] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   34.006900][ T5207] RBP: 0000000000000000 R08: ffff8880618b3c00 R09: 000=
0000000000002
[   34.014952][ T5207] R10: 0000000000000003 R11: 0000000000000000 R12: dff=
ffc0000000000
[   34.022997][ T5207] R13: 1ffff1100c116063 R14: ffff88802ec31b50 R15: fff=
fc90002fa7c50
[   34.031175][ T5207] FS:  00007f5f52b67880(0000) GS:ffff888125d3d000(0000=
) knlGS:0000000000000000
[   34.040218][ T5207] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.046903][ T5207] CR2: 00007f5f52b8bd00 CR3: 0000000060c72000 CR4: 000=
00000003526f0
[   34.054963][ T5207] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   34.063269][ T5207] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   34.071278][ T5207] Call Trace:
[   34.074654][ T5207]  <TASK>
[   34.077614][ T5207]  vms_complete_munmap_vmas+0x54c/0x7c0
[   34.083363][ T5207]  do_vmi_align_munmap+0x358/0x420
[   34.088517][ T5207]  ? __pfx_filemap_map_pages+0x10/0x10
[   34.094109][ T5207]  ? __pfx_do_vmi_align_munmap+0x10/0x10
[   34.099837][ T5207]  do_vmi_munmap+0x253/0x2e0
[   34.104743][ T5207]  __vm_munmap+0x23b/0x3d0
[   34.109213][ T5207]  ? __pfx___vm_munmap+0x10/0x10
[   34.114279][ T5207]  __x64_sys_munmap+0x60/0x70
[   34.119000][ T5207]  do_syscall_64+0xfa/0x3b0
[   34.123691][ T5207]  ? lockdep_hardirqs_on+0x9c/0x150
[   34.128925][ T5207]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   34.135178][ T5207]  ? clear_bhb_loop+0x60/0xb0
[   34.139894][ T5207]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   34.145879][ T5207] RIP: 0033:0x7f5f5251e097
[   34.150327][ T5207] Code: 73 01 c3 48 8b 0d 61 2d 0d 00 f7 d8 64 89 01 4=
8 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 31 2d 0d 00 f7 d8 64 89 01 48
[   34.170167][ T5207] RSP: 002b:00007ffde341e0a8 EFLAGS: 00000206 ORIG_RAX=
: 000000000000000b
[   34.178753][ T5207] RAX: ffffffffffffffda RBX: 00005648cc15fbf0 RCX: 000=
07f5f5251e097
[   34.187010][ T5207] RDX: 0000000000000000 RSI: 00000000009480e8 RDI: 000=
07f5f51a00000
[   34.195088][ T5207] RBP: 00005648cc15f910 R08: 00005648cc161670 R09: 000=
0000000000006
[   34.203334][ T5207] R10: 3fffffffffffffff R11: 0000000000000206 R12: 000=
056488f485588
[   34.211336][ T5207] R13: 000056488f486100 R14: 0000000000000001 R15: 000=
0000000000000
[   34.219830][ T5207]  </TASK>
[   34.222964][ T5207] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   34.230367][ T5207] CPU: 1 UID: 0 PID: 5207 Comm: udevd Not tainted 6.16=
.0-rc2-next-20250618-syzkaller-03311-g6e5ab6fee68d-dirty #0 PREEMPT(full)=
=20
[   34.243855][ T5207] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[   34.254037][ T5207] Call Trace:
[   34.257344][ T5207]  <TASK>
[   34.260296][ T5207]  dump_stack_lvl+0x99/0x250
[   34.264939][ T5207]  ? __asan_memcpy+0x40/0x70
[   34.269568][ T5207]  ? __pfx_dump_stack_lvl+0x10/0x10
[   34.274902][ T5207]  ? __pfx__printk+0x10/0x10
[   34.279553][ T5207]  panic+0x2db/0x790
[   34.283606][ T5207]  ? __pfx_panic+0x10/0x10
[   34.288088][ T5207]  __warn+0x334/0x4c0
[   34.292128][ T5207]  ? remove_vma+0x21e/0x290
[   34.296682][ T5207]  ? remove_vma+0x21e/0x290
[   34.301229][ T5207]  report_bug+0x2be/0x4f0
[   34.305594][ T5207]  ? remove_vma+0x21e/0x290
[   34.310140][ T5207]  ? remove_vma+0x21e/0x290
[   34.314684][ T5207]  ? remove_vma+0x220/0x290
[   34.319221][ T5207]  handle_bug+0x84/0x160
[   34.323513][ T5207]  exc_invalid_op+0x1a/0x50
[   34.328064][ T5207]  asm_exc_invalid_op+0x1a/0x20
[   34.332947][ T5207] RIP: 0010:remove_vma+0x21e/0x290
[   34.338093][ T5207] Code: 2e ab ff 4c 89 f7 e8 81 b4 0b 00 eb 05 e8 8a 2=
e ab ff 48 89 df 5b 41 5c 41 5d 41 5e 41 5f 5d e9 98 e5 f4 ff e8 73 2e ab f=
f 90 <0f> 0b 90 e9 83 fe ff ff 48 c7 c1 30 9e a1 8f 80 e1 07 80 c1 03 38
[   34.358023][ T5207] RSP: 0018:ffffc90002fa7a28 EFLAGS: 00010293
[   34.364200][ T5207] RAX: ffffffff821528cd RBX: ffff88802ec31b40 RCX: fff=
f8880618b3c00
[   34.372181][ T5207] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   34.380153][ T5207] RBP: 0000000000000000 R08: ffff8880618b3c00 R09: 000=
0000000000002
[   34.388132][ T5207] R10: 0000000000000003 R11: 0000000000000000 R12: dff=
ffc0000000000
[   34.396124][ T5207] R13: 1ffff1100c116063 R14: ffff88802ec31b50 R15: fff=
fc90002fa7c50
[   34.404130][ T5207]  ? remove_vma+0x21d/0x290
[   34.408657][ T5207]  ? remove_vma+0x21d/0x290
[   34.413179][ T5207]  vms_complete_munmap_vmas+0x54c/0x7c0
[   34.418772][ T5207]  do_vmi_align_munmap+0x358/0x420
[   34.423913][ T5207]  ? __pfx_filemap_map_pages+0x10/0x10
[   34.429479][ T5207]  ? __pfx_do_vmi_align_munmap+0x10/0x10
[   34.435182][ T5207]  do_vmi_munmap+0x253/0x2e0
[   34.439810][ T5207]  __vm_munmap+0x23b/0x3d0
[   34.444593][ T5207]  ? __pfx___vm_munmap+0x10/0x10
[   34.449596][ T5207]  __x64_sys_munmap+0x60/0x70
[   34.454304][ T5207]  do_syscall_64+0xfa/0x3b0
[   34.458917][ T5207]  ? lockdep_hardirqs_on+0x9c/0x150
[   34.464131][ T5207]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   34.470645][ T5207]  ? clear_bhb_loop+0x60/0xb0
[   34.475341][ T5207]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   34.481330][ T5207] RIP: 0033:0x7f5f5251e097
[   34.485760][ T5207] Code: 73 01 c3 48 8b 0d 61 2d 0d 00 f7 d8 64 89 01 4=
8 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 31 2d 0d 00 f7 d8 64 89 01 48
[   34.505485][ T5207] RSP: 002b:00007ffde341e0a8 EFLAGS: 00000206 ORIG_RAX=
: 000000000000000b
[   34.513924][ T5207] RAX: ffffffffffffffda RBX: 00005648cc15fbf0 RCX: 000=
07f5f5251e097
[   34.521924][ T5207] RDX: 0000000000000000 RSI: 00000000009480e8 RDI: 000=
07f5f51a00000
[   34.530022][ T5207] RBP: 00005648cc15f910 R08: 00005648cc161670 R09: 000=
0000000000006
[   34.538134][ T5207] R10: 3fffffffffffffff R11: 0000000000000206 R12: 000=
056488f485588
[   34.546199][ T5207] R13: 000056488f486100 R14: 0000000000000001 R15: 000=
0000000000000
[   34.554295][ T5207]  </TASK>
[   34.557640][ T5207] Kernel Offset: disabled
[   34.561960][ T5207] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.=
1-go1.23.7.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0=
.0.1-go1.23.7.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.7'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build4033099088=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 0e8da31f2d4
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
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0e8da31f2d4312fc3ad5c1e2e221075831885e0e -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250613-131303"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0e8da31f2d4312fc3ad5c1e2e221075831=
885e0e\"
/usr/bin/ld: /tmp/ccK7dhHx.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1726fe82580000


Tested on:

commit:         6e5ab6fe Add linux-next specific files for 20250618
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D70c73b370b13235=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D8e4be574cb8c40140=
a2a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-=
1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D120afe825800=
00


