Return-Path: <linux-kernel+bounces-815095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01EB55F96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9926C5842FB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADF2E7F00;
	Sat, 13 Sep 2025 08:58:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131682DC763
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753887; cv=none; b=MhDItoql3CoasbQvxjlOoTZY6svo2XXTNeuHeC90F2l8bfjSxpMKCvxxfoZrr7jW2fzmFQlRCa6KLaOzSkkvyuplyBS/EpM+PtYnvyWVXgdpsbdXfCkjnQMXl8hCImCka+9qCB6zj/iD+V7FZIHxYJkJr+QbRNDbNkLUVRwOiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753887; c=relaxed/simple;
	bh=5kHGoYkpnSQeKF31+q4OuksuNwEzZBh6016UXuuyEgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y7+fT9nY23Ln2Ep+cujgkvQzz04PHfVgGurKYijjobRwa38iSPYY9pvWT6ei3sT8/+OGcT+DxQZrb30Qtp5oCr6E3nsps2VsG3Mq3za7en48mBUBq0xkXZGBrXR7a1gzDUVtxzvl3VO0XGNKEMAeorFaxkuO5/uB0i9lgqIFafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-401eba8efecso37598345ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757753884; x=1758358684;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h57cpashpX+C0NXSKchj7nSWU6XGYKZ/nvCYt1dmNU=;
        b=YjbxFs6wlg7O37GOMSaQUWvU5bPleZay7sqTEWzRzur15oUf/c8VjDNiIlM+7wS64x
         UYYhoGcE6FYjIDqEJd3HuhAtETfJyzWzawVzzt+2moss/+En6qdZ+pwHJAlDwq8bUBxA
         3qkJVIcFJdjzriQOTVjTwDhnn/2izxlqqTGztirpuQCd59N7C8g3l19qhGtJmaoEzNxP
         pv/CMADRP5LWS814C00yorJMS5Wzv6caRFKeA+7kOOyd2aPYHFXb3q/H3jUF0BozP9+p
         /kbFpSbUc+dN7wIFUkhtsanZlWvG4XcyolmZ657CUhFDUbjwZT6DYIW7v3X48zUq5MCa
         /xVA==
X-Forwarded-Encrypted: i=1; AJvYcCVdhmiF5w4u3h5eWWZQExhHcFnKZR5lBpffFbOmm5COxkanQSMDFpIdJeeitPQBSY9Fe9CUbmTkNd4A0JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuz6HOXnEGNK9GBit7nAY5AqF9S9p0pTs5pTH1+x7dPPqWpoqY
	g47wSVYRE5B1abm0YnZeSSYtPjEi/G8KhlaAlDLT2Z1QcLXtodVY74CpJYcmvA04x7Y+nN188MB
	CTntn4AwTbkWPH5ksKd/o9J4MmhZxLJXpoTLt2jfbPk/1E9iJAwOQ1ISyxP4=
X-Google-Smtp-Source: AGHT+IGTx+5eB2OJIxioXpKwWtrB3r5QTqqsRJEKtVURB6N06X2PEFhlgkdGfuM5tplAW1J/LSiekdkDObif+ioOymFHChK/fdkH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:422:a9aa:7ff4 with SMTP id
 e9e14a558f8ab-422a9aaa667mr48997155ab.11.1757753884155; Sat, 13 Sep 2025
 01:58:04 -0700 (PDT)
Date: Sat, 13 Sep 2025 01:58:04 -0700
In-Reply-To: <20250913073552.192945-1-chandna.linuxkernel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5321c.050a0220.2ff435.0374.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in change_page_attr_set_clr
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: chandna.linuxkernel@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 0.117687][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.118945][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.191858][    T0] On node 0, zone Normal: 3 pages in unavailable range=
s
[    0.591055][    T0] KernelAddressSanitizer initialized (generic)
[    0.592543][    T0] ACPI: PM-Timer IO Port: 0xb008
[    0.593237][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.594216][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.595248][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.596231][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.597251][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.598341][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.599361][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation
[    0.600305][    T0] CPU topo: Max. logical packages:   1
[    0.601019][    T0] CPU topo: Max. logical dies:       1
[    0.601741][    T0] CPU topo: Max. dies per package:   1
[    0.602451][    T0] CPU topo: Max. threads per core:   2
[    0.603170][    T0] CPU topo: Num. cores per package:     1
[    0.604190][    T0] CPU topo: Num. threads per package:   2
[    0.605342][    T0] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPU=
s
[    0.607146][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
000000-0x00000fff]
[    0.608518][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
09f000-0x000fffff]
[    0.609600][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf=
ffd000-0xffffffff]
[    0.610790][    T0] [mem 0xc0000000-0xfffbbfff] available for PCI device=
s
[    0.611783][    T0] Booting paravirtualized kernel on KVM
[    0.612589][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.710223][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:2 nr_cpu_ids=
:2 nr_node_ids:2
[    0.713115][    T0] percpu: Embedded 70 pages/cpu s246472 r8192 d32056 u=
1048576
[    0.714761][    T0] kvm-guest: PV spinlocks enabled
[    0.715870][    T0] PV qspinlock hash table entries: 256 (order: 0, 4096=
 bytes, linear)
[    0.717508][    T0] Kernel command line: earlyprintk=3Dserial net.ifname=
s=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-con=
ntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.p=
orts=3D20000 nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000=
 binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cp=
utime=3D1 no_hash_pointers page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysct=
l.vm.nr_overcommit_hugepages=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_=
to_panic=3D1 msr.allow_writes=3Doff coredump_filter=3D0xffff root=3D/dev/sd=
a console=3DttyS0 vsyscall=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 sp=
ec_store_bypass_disable=3Dprctl nopcid vivid.n_devs=3D64 vivid.multiplanar=
=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,=
1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D3=
2 rose.rose_ndevs=3D32 smp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 w=
orkqueue.watchdog_thresh=3D140 sysctl.net.core.netdev_unregister_timeout_se=
cs=3D140 dummy_hcd.num=3D32 max_loop=3D32 nbds_max=3D32 comedi.comedi
[    0.721851][    T0] Unknown kernel command line parameters "spec_store_b=
ypass_disable=3Dprctl nbds_max=3D32", will be passed to user space.
[    0.740391][    T0] random: crng init done
[    0.741353][    T0] printk: log buffer data + meta data: 262144 + 917504=
 =3D 1179648 bytes
[    0.743154][    T0] software IO TLB: area num 2.
[    0.774274][    T0] Fallback order for Node 0: 0 1=20
[    0.774296][    T0] Fallback order for Node 1: 1 0=20
[    0.774309][    T0] Built 2 zonelists, mobility grouping on.  Total page=
s: 2097051
[    0.777680][    T0] Policy zone: Normal
[    0.778999][    T0] mem auto-init: stack:all(zero), heap alloc:on, heap =
free:off
[    0.780853][    T0] stackdepot: allocating hash table via alloc_large_sy=
stem_hash
[    0.782531][    T0] stackdepot hash table entries: 1048576 (order: 12, 1=
6777216 bytes, linear)
[    0.789345][    T0] stackdepot: allocating space for 8192 stack pools vi=
a memblock
[    1.500850][    T0] ****************************************************=
******
[    1.502043][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **
[    1.503166][    T0] **                                                  =
    **
[    1.504232][    T0] ** This system shows unhashed kernel memory addresse=
s   **
[    1.505248][    T0] ** via the console, logs, and other interfaces. This=
    **
[    1.506238][    T0] ** might reduce the security of your system.        =
    **
[    1.507271][    T0] **                                                  =
    **
[    1.508232][    T0] ** If you see this message and you are not debugging=
    **
[    1.509932][    T0] ** the kernel, report this immediately to your syste=
m   **
[    1.511161][    T0] ** administrator!                                   =
    **
[    1.512178][    T0] **                                                  =
    **
[    1.513153][    T0] ** Use hash_pointers=3Dalways to force this mode off=
      **
[    1.514361][    T0] **                                                  =
    **
[    1.515322][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **
[    1.516374][    T0] ****************************************************=
******
[    1.519323][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D2
[    1.641406][    T0] allocated 167772160 bytes of page_ext
[    1.642504][    T0] Node 0, zone      DMA: page owner found early alloca=
ted 0 pages
[    1.658376][    T0] Node 0, zone    DMA32: page owner found early alloca=
ted 21222 pages
[    1.665126][    T0] Node 0, zone   Normal: page owner found early alloca=
ted 0 pages
[    1.677811][    T0] Node 1, zone   Normal: page owner found early alloca=
ted 19843 pages
[    1.680062][    T0] Kernel/User page tables isolation: enabled
[    1.681474][    T0] ------------[ cut here ]------------
[    1.682278][    T0] WARNING: arch/x86/mm/pat/set_memory.c:308 at __chang=
e_page_attr_set_clr+0x493/0x27d0, CPU#0: swapper/0
[    1.685037][    T0] Modules linked in:
[    1.685814][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted syzka=
ller #0 PREEMPT(undef)=20
[    1.687198][    T0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/18/2025
[    1.688616][    T0] RIP: 0010:__change_page_attr_set_clr+0x493/0x27d0
[    1.689528][    T0] Code: 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f=
7 e8 72 05 ae 00 49 c1 e7 0c 4d 03 3e 4d 89 fe e9 84 00 00 00 e8 4e 83 49 0=
0 90 <0f> 0b 90 45 31 f6 eb 76 e8 40 83 49 00 48 8b 84 24 d0 00 00 00 42
[    1.692899][    T0] RSP: 0000:ffffffff8e2079c0 EFLAGS: 00010093
[    1.694082][    T0] RAX: ffffffff817689f2 RBX: ffffffff8e207da0 RCX: fff=
fffff8e2951c0
[    1.695136][    T0] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fff=
fffff8e207940
[    1.696263][    T0] RBP: ffffffff8e207c70 R08: 0000000000000003 R09: 000=
0000000000004
[    1.697533][    T0] R10: dffffc0000000000 R11: fffffbfff1c40f28 R12: dff=
ffc0000000000
[    1.698807][    T0] R13: ffffffff8e207d68 R14: ffffffff8e207d80 R15: 000=
0000000000000
[    1.700400][    T0] FS:  0000000000000000(0000) GS:ffff8881257a7000(0000=
) knlGS:0000000000000000
[    1.701650][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.702993][    T0] CR2: ffff88823ffff000 CR3: 000000000e338000 CR4: 000=
00000000000b0
[    1.704598][    T0] Call Trace:
[    1.705070][    T0]  <TASK>
[    1.705835][    T0]  ? rcu_is_watching+0x15/0xb0
[    1.706667][    T0]  ? _vm_unmap_aliases+0x747/0x7b0
[    1.707668][    T0]  ? _vm_unmap_aliases+0x1b2/0x7b0
[    1.708569][    T0]  ? __pfx___change_page_attr_set_clr+0x10/0x10
[    1.709581][    T0]  ? __pfx_get_page_from_freelist+0x10/0x10
[    1.710500][    T0]  ? 0xffffffff81000000
[    1.711200][    T0]  change_page_attr_set_clr+0x37f/0x1140
[    1.712132][    T0]  ? __alloc_frozen_pages_noprof+0x1d6/0x370
[    1.713012][    T0]  ? __pfx_change_page_attr_set_clr+0x10/0x10
[    1.713991][    T0]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[    1.714991][    T0]  ? pti_user_pagetable_walk_p4d+0x392/0x3c0
[    1.716094][    T0]  ? 0xffffffff81000000
[    1.716884][    T0]  set_memory_nonglobal+0x8c/0xd0
[    1.717658][    T0]  ? __pfx_set_memory_nonglobal+0x10/0x10
[    1.719436][    T0]  ? pti_user_pagetable_walk_pte+0x12c/0x1f0
[    1.720219][    T0]  ? 0xffffffff81000000
[    1.720849][    T0]  ? pti_clone_user_shared+0xe7/0x260
[    1.721561][    T0]  pti_init+0x7b/0xb0
[    1.722159][    T0]  mm_core_init+0x60/0x70
[    1.722884][    T0]  start_kernel+0x16c/0x410
[    1.723747][    T0]  x86_64_start_reservations+0x24/0x30
[    1.724587][    T0]  x86_64_start_kernel+0x143/0x1c0
[    1.725381][    T0]  common_startup_64+0x13e/0x147
[    1.726093][    T0]  </TASK>
[    1.726518][    T0] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    1.727483][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted syzka=
ller #0 PREEMPT(undef)=20
[    1.728683][    T0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/18/2025
[    1.729972][    T0] Call Trace:
[    1.730396][    T0]  <TASK>
[    1.730934][    T0]  dump_stack_lvl+0x99/0x250
[    1.731550][    T0]  ? __asan_memcpy+0x40/0x70
[    1.732221][    T0]  ? __pfx_dump_stack_lvl+0x10/0x10
[    1.733092][    T0]  ? __pfx__printk+0x10/0x10
[    1.733749][    T0]  vpanic+0x237/0x6d0
[    1.734283][    T0]  ? __pfx_vpanic+0x10/0x10
[    1.734950][    T0]  ? is_bpf_text_address+0x292/0x2b0
[    1.735846][    T0]  ? is_bpf_text_address+0x26/0x2b0
[    1.736715][    T0]  panic+0xb9/0xc0
[    1.737552][    T0]  ? __pfx_panic+0x10/0x10
[    1.738251][    T0]  ? common_startup_64+0x13e/0x147
[    1.739224][    T0]  __warn+0x334/0x4c0
[    1.739919][    T0]  ? __change_page_attr_set_clr+0x493/0x27d0
[    1.740968][    T0]  ? __change_page_attr_set_clr+0x493/0x27d0
[    1.742023][    T0]  report_bug+0x2be/0x4f0
[    1.742881][    T0]  ? __change_page_attr_set_clr+0x493/0x27d0
[    1.743797][    T0]  ? __change_page_attr_set_clr+0x493/0x27d0
[    1.744810][    T0]  ? __change_page_attr_set_clr+0x495/0x27d0
[    1.745668][    T0]  handle_bug+0x84/0x160
[    1.746373][    T0]  exc_invalid_op+0x1a/0x50
[    1.747033][    T0]  asm_exc_invalid_op+0x1a/0x20
[    1.747839][    T0] RIP: 0010:__change_page_attr_set_clr+0x493/0x27d0
[    1.748968][    T0] Code: 89 f0 48 c1 e8 0serialport: Connected to syzka=
ller.us-central1-c.ci-upstream-rust-kasan-gce-test-job-parallel-1 port 1 (s=
ession ID: 3978b10c74a07ae5fe60c93b7c11c75e17aef18e4a4f5fae07a6404b7404a6d6=
, active connections: 1).
3 42 80 3c 20 00 74 08 4c 89 f7 e8 72 05 ae 00 49 c1 e7 0c 4d 03 3e 4d 89 f=
e e9 84 00 00 00 e8 4e 83 49 00 90 <0f> 0b 90 45 31 f6 eb 76 e8 40 83 49 00=
 48 8b 84 24 d0 00 00 00 42
[    1.751892][    T0] RSP: 0000:ffffffff8e2079c0 EFLAGS: 00010093
[    1.753993][    T0] RAX: ffffffff817689f2 RBX: ffffffff8e207da0 RCX: fff=
fffff8e2951c0
[    1.755939][    T0] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fff=
fffff8e207940
[    1.757076][    T0] RBP: ffffffff8e207c70 R08: 0000000000000003 R09: 000=
0000000000004
[    1.758228][    T0] R10: dffffc0000000000 R11: fffffbfff1c40f28 R12: dff=
ffc0000000000
[    1.759282][    T0] R13: ffffffff8e207d68 R14: ffffffff8e207d80 R15: 000=
0000000000000
[    1.761464][    T0]  ? __change_page_attr_set_clr+0x492/0x27d0
[    1.762846][    T0]  ? rcu_is_watching+0x15/0xb0
[    1.763703][    T0]  ? _vm_unmap_aliases+0x747/0x7b0
[    1.764626][    T0]  ? _vm_unmap_aliases+0x1b2/0x7b0
[    1.765487][    T0]  ? __pfx___change_page_attr_set_clr+0x10/0x10
[    1.766404][    T0]  ? __pfx_get_page_from_freelist+0x10/0x10
[    1.767363][    T0]  ? 0xffffffff81000000
[    1.767965][    T0]  change_page_attr_set_clr+0x37f/0x1140
[    1.769234][    T0]  ? __alloc_frozen_pages_noprof+0x1d6/0x370
[    1.770220][    T0]  ? __pfx_change_page_attr_set_clr+0x10/0x10
[    1.771366][    T0]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[    1.772390][    T0]  ? pti_user_pagetable_walk_p4d+0x392/0x3c0
[    1.773669][    T0]  ? 0xffffffff81000000
[    1.774543][    T0]  set_memory_nonglobal+0x8c/0xd0
[    1.775459][    T0]  ? __pfx_set_memory_nonglobal+0x10/0x10
[    1.776456][    T0]  ? pti_user_pagetable_walk_pte+0x12c/0x1f0
[    1.777710][    T0]  ? 0xffffffff81000000
[    1.778487][    T0]  ? pti_clone_user_shared+0xe7/0x260
[    1.779634][    T0]  pti_init+0x7b/0xb0
[    1.780784][    T0]  mm_core_init+0x60/0x70
[    1.781379][    T0]  start_kernel+0x16c/0x410
[    1.782159][    T0]  x86_64_start_reservations+0x24/0x30
[    1.782881][    T0]  x86_64_start_kernel+0x143/0x1c0
[    1.783781][    T0]  common_startup_64+0x13e/0x147
[    1.784601][    T0]  </TASK>
[    1.785269][    T0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build4080916303=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at 96a211bca8b
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D96a211bca8bcc72de621f8990d476177d3463857 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20250902-105110"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D96a211bca8bcc72de621f8990d476177d3463857 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20250902-105110"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D96a211bca8bcc72de621f8990d476177d3463857 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250902-105110"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"96a211bca8bcc72de621f8990d476177d3=
463857\"
/usr/bin/ld: /tmp/ccVWXFPq.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12e65934580000


Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9134e501f17b95a=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3De34177f6091df113e=
f20
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D100dd6425800=
00


