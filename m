Return-Path: <linux-kernel+bounces-759675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E17CFB1E0F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB10418C0BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCF1B0413;
	Fri,  8 Aug 2025 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpceniDh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877163FE4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754623601; cv=none; b=r3Rp9omVEk1Ru2cDjGNqhNSt7A1MDhLQET7fX6VWwJnUbj8reQvvR054vNHMvev3yO5j9zgEjaRzqko/ty8flAS1VxVVAUdBexpO5pkfVwKramBHsqbtRxJMnBr64PYWHFeHZG2nKYNfAg9QkcA6YW3h9nBnmnj+2Da3k561oQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754623601; c=relaxed/simple;
	bh=h9PgmOanRvp04ripQ8qrKgE+HBsrA6Yms5eh0zoPYUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoapJYUQs6dVIRD4iDGdmXvTWLXXS9E76SA5LZuGX/pnWxd/46hd/McykdACtVzRfJPD29OlejsLZULEzHh/N4EjNkKcyan7HX89hR6Q1tmSHCwx8/i3aJu7w4xdTNCKVdoegve/Tts0GXqmp3rn9rZfsh5m6JfvIf5+mzmjzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpceniDh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754623600; x=1786159600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h9PgmOanRvp04ripQ8qrKgE+HBsrA6Yms5eh0zoPYUg=;
  b=VpceniDhj/m9FJO+ILb0OCVbQcC7O9zQ3CtkGzsk94rESBgk6MrG28JY
   iZENwz6NFoH3u8QEyrv5At6OTmbolVwF9Q74pVphg6gWUwlwHGh4S8OCw
   OBcxmwHF8vnUmgD4IKEe8fZ1eWTFAu5SNv2/U4vKWX7aU/PyRYvDgn82e
   Qw/USXl6TO2kaYEkheLoDcYYPjX4B2kgVGb+62rH0oPqsS8LADcdcLjYo
   i2DiKaR6VwH2Z6SiodfetuvJ8Qbhn1tATzzHJvNBDH0XIIX9NPBapjSa5
   pc6N59tMhbjy7ZcDBL477Pnh9gwosJSuu0nJypKCjl3KWoCXm3EJ+aXzM
   w==;
X-CSE-ConnectionGUID: rFoq3ySNQye6zzDYMz4LBQ==
X-CSE-MsgGUID: jTZktTRsQEqToCHNCP9OrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56891130"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56891130"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 20:26:37 -0700
X-CSE-ConnectionGUID: YQClsxpuRIW1B/UdTJqCcQ==
X-CSE-MsgGUID: bdzqe2tsRxGi97+7mdj3BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196217908"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.53])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 20:26:32 -0700
Date: Fri, 8 Aug 2025 11:26:29 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Brian Gerst <brgerst@gmail.com>, Eric Biggers <ebiggers@google.com>,
	Kees Cook <kees@kernel.org>, Chao Gao <chao.gao@intel.com>,
	Fushuai Wang <wangfushuai@baidu.com>, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: Re: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Message-ID: <aJVuZZgYjEMxiUYq@ly-workstation>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
 <20250724013422.307954-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724013422.307954-2-sohil.mehta@intel.com>

Resent the report to LKML.

Hi Sohil,

I used Syzkaller and found that there is WARNING in x86_task_fpu in v6.16 kernel.

After bisection and the first bad commit is this patch - x86/fpu: Update the debug flow for x86_task_fpu()

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250806_033745_x86_task_fpu
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250806_033745_x86_task_fpu/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250806_033745_x86_task_fpu/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250806_033745_x86_task_fpu/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250806_033745_x86_task_fpu/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250806_033745_x86_task_fpu/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250806_033745_x86_task_fpu/bzImage_9efb9ebfb1faa8aa0315b86eacebee9ba825aa97
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250806_033745_x86_task_fpu/9efb9ebfb1faa8aa0315b86eacebee9ba825aa97_dmesg.log

"
test login: [   17.470482] repro[731]: segfault at 0 ip 000000000040157d sp 00007ffeb0762f00 error 6 in repro[157d,401000+1000] likely on CPU 0 (core 0, socket 0)
[   17.471251] Code: 8b 55 dc 8b 45 d0 41 b9 00 00 00 00 41 89 d0 b9 01 80 00 00 ba 03 00 00 00 48 89 c6 bf 00 00 00 00 e8 57 fb ff ff 48 8b 55 e8 <48> 89 02 48 8b 45 f0 8b 00 c1 e0 06 89 45 cc 8b 55 dc 8b 45 cc 41
[   17.474495] ------------[ cut here ]------------
[   17.474769] WARNING: CPU: 1 PID: 731 at arch/x86/kernel/fpu/core.c:61 x86_task_fpu+0x76/0x90
[   17.475245] Modules linked in:
[   17.475440] CPU: 1 UID: 0 PID: 731 Comm: repro Not tainted 6.16.0-9efb9ebfb1fa+ #1 PREEMPT(voluntary) 
[   17.475909] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.476478] RIP: 0010:x86_task_fpu+0x76/0x90
[   17.476710] Code: 40 20 00 44 89 e6 e8 49 fe 54 00 45 85 e4 75 15 e8 8f 03 55 00 48 8d 83 40 20 00 00 5b 41 5c 5d c3 cc cc cc cc e8 7a 03 55 00 <0f> 0b eb e2 e8 d1 4a c1 00 eb c1 66 66 2e 0f 1f 84 00 00 00 00 00
[   17.477627] RSP: 0018:ffff88801794f408 EFLAGS: 00010293
[   17.477905] RAX: 0000000000000000 RBX: ffff88801dc1ca80 RCX: ffffffff813246a7
[   17.478274] RDX: ffff88800ed32540 RSI: ffffffff813246c6 RDI: 0000000000000005
[   17.478655] RBP: ffff88801794f418 R08: 0000000000000400 R09: ffff88806b8f8650
[   17.479024] R10: 0000000000004000 R11: 000000000000000e R12: 0000000000004000
[   17.479391] R13: ffff88801dc1ca80 R14: 0000000000000200 R15: 0000000000000200
[   17.479756] FS:  00007f49bfd9e740(0000) GS:ffff8880e3653000(0000) knlGS:0000000000000000
[   17.480165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.480464] CR2: 00007f13183cc088 CR3: 0000000011fb0000 CR4: 0000000000750ef0
[   17.480831] PKRU: 55555554
[   17.480983] Call Trace:
[   17.481120]  <TASK>
[   17.481244]  xfpregs_get+0x9c/0x1e0
[   17.481436]  ? __kvmalloc_node_noprof+0x448/0x660
[   17.481698]  ? __pfx_xfpregs_get+0x10/0x10
[   17.481917]  ? regset_get_alloc+0xf8/0x200
[   17.482150]  regset_get_alloc+0x137/0x200
[   17.482374]  elf_core_dump+0x10e3/0x3800
[   17.482613]  ? stack_depot_save_flags+0x445/0xa40
[   17.482884]  ? __pfx_regset_xregset_fpregs_active+0x10/0x10
[   17.483178]  ? __pfx_elf_core_dump+0x10/0x10
[   17.483407]  ? irqentry_exit_to_user_mode+0x125/0x1e0
[   17.483687]  ? exc_page_fault+0xee/0x1b0
[   17.483896]  ? asm_exc_page_fault+0x2b/0x30
[   17.484119]  ? __this_cpu_preempt_check+0x21/0x30
[   17.484372]  ? ___slab_alloc+0x2f0/0x12c0
[   17.484593]  ? lock_is_held_type+0xef/0x150
[   17.484814]  ? ___slab_alloc+0x2ff/0x12c0
[   17.485043]  ? lock_release+0x14f/0x2c0
[   17.485304]  do_coredump+0x370e/0x5060
[   17.485539]  ? do_coredump+0x370e/0x5060
[   17.485749]  ? stack_depot_save_flags+0x445/0xa40
[   17.486018]  ? __pfx_do_coredump+0x10/0x10
[   17.486251]  ? stack_depot_save_flags+0x445/0xa40
[   17.486519]  ? kasan_save_stack+0x40/0x60
[   17.486738]  ? kasan_save_stack+0x2c/0x60
[   17.486957]  ? kasan_save_track+0x18/0x40
[   17.487169]  ? kasan_save_free_info+0x3f/0x60
[   17.487401]  ? __kasan_slab_free+0x3d/0x60
[   17.487618]  ? kmem_cache_free+0x2ea/0x520
[   17.487836]  ? __sigqueue_free+0xcc/0x140
[   17.488053]  ? get_signal+0xbca/0x2430
[   17.488257]  ? arch_do_signal_or_restart+0x8d/0x7d0
[   17.488519]  ? irqentry_exit_to_user_mode+0x125/0x1e0
[   17.488784]  ? irqentry_exit+0x6f/0xa0
[   17.488986]  ? exc_page_fault+0xee/0x1b0
[   17.489195]  ? asm_exc_page_fault+0x2b/0x30
[   17.489424]  ? percpu_ref_put_many.constprop.0+0x80/0x1d0
[   17.489718]  ? __memcg_slab_free_hook+0xed/0x570
[   17.489966]  ? __memcg_slab_free_hook+0xed/0x570
[   17.490217]  ? __this_cpu_preempt_check+0x21/0x30
[   17.490469]  ? lock_release+0x14f/0x2c0
[   17.490707]  ? __this_cpu_preempt_check+0x21/0x30
[   17.490956]  ? _raw_spin_unlock_irq+0x2c/0x60
[   17.491194]  get_signal+0x1ae2/0x2430
[   17.491394]  ? get_signal+0x1ae2/0x2430
[   17.491610]  ? __pfx_get_signal+0x10/0x10
[   17.491824]  ? __pfx_force_sig_fault+0x10/0x10
[   17.492067]  arch_do_signal_or_restart+0x8d/0x7d0
[   17.492319]  ? trace_irq_disable+0xd1/0x110
[   17.492547]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[   17.492819]  ? trace_hardirqs_off+0x3e/0x50
[   17.493047]  ? __bad_area_nosemaphore+0x377/0x650
[   17.493304]  ? __this_cpu_preempt_check+0x21/0x30
[   17.493563]  ? irqentry_exit_to_user_mode+0xf0/0x1e0
[   17.493889]  irqentry_exit_to_user_mode+0x125/0x1e0
[   17.494220]  irqentry_exit+0x6f/0xa0
[   17.494460]  exc_page_fault+0xee/0x1b0
[   17.494741]  asm_exc_page_fault+0x2b/0x30
[   17.495005] RIP: 0033:0x40157d
[   17.495220] Code: 8b 55 dc 8b 45 d0 41 b9 00 00 00 00 41 89 d0 b9 01 80 00 00 ba 03 00 00 00 48 89 c6 bf 00 00 00 00 e8 57 fb ff ff 48 8b 55 e8 <48> 89 02 48 8b 45 f0 8b 00 c1 e0 06 89 45 cc 8b 55 dc 8b 45 cc 41
[   17.496346] RSP: 002b:00007ffeb0762f00 EFLAGS: 00010207
[   17.496682] RAX: 00007f49bfc7d000 RBX: 0000000000000000 RCX: 00007f49bfb47fe7
[   17.497128] RDX: 0000000000000000 RSI: 0000000000120040 RDI: 0000000000000000
[   17.497571] RBP: 00007ffeb0762f60 R08: 0000000000000003 R09: 0000000000000000
[   17.498013] R10: 0000000000008001 R11: 0000000000000246 R12: 00007ffeb07630f8
[   17.498460] R13: 0000000000401d31 R14: 0000000000403e08 R15: 00007f49bfdeb000
[   17.498924]  </TASK>
[   17.499080] irq event stamp: 1637
[   17.499297] hardirqs last  enabled at (1645): [<ffffffff81651e25>] __up_console_sem+0x95/0xb0
[   17.499829] hardirqs last disabled at (1652): [<ffffffff81651e0a>] __up_console_sem+0x7a/0xb0
[   17.500357] softirqs last  enabled at (1546): [<ffffffff8147fa1e>] __irq_exit_rcu+0x10e/0x170
[   17.500892] softirqs last disabled at (1541): [<ffffffff8147fa1e>] __irq_exit_rcu+0x10e/0x170
[   17.501420] ---[ end trace 0000000000000000 ]---
[   17.903446] repro[736]: segfault at 0 ip 000000000040157d sp 00007ffeb0762f00 error 6 in repro[157d,401000+1000] likely on CPU 0 (core 0, socket 0)
[   17.904173] Code: 8b 55 dc 8b 45 d0 41 b9 00 00 00 00 41 89 d0 b9 01 80 00 00 ba 03 00 00 00 48 89 c6 bf 00 00 00 00 e8 57 fb ff ff 48 8b 55 e8 <48> 89 02 48 8b 45 f0 8b 00 c1 e0 06 89 45 cc 8b 55 dc 8b 45 cc 41
[   18.214869] repro[744]: segfault at 0 ip 000000000040157d sp 00007ffeb0762f00 error 6 in repro[157d,401000+1000] likely on CPU 1 (core 1, socket 0)
[   18.215750] Code: 8b 55 dc 8b 45 d0 41 b9 00 00 00 00 41 89 d0 b9 01 80 00 00 ba 03 00 00 00 48 89 c6 bf 00 00 00 00 e8 57 fb ff ff 48 8b 55 e8 <48> 89 02 48 8b 45 f0 8b 00 c1 e0 06 89 45 cc 8b 55 dc 8b 45 cc 41
[   18.527142] repro[752]: segfault at 0 ip 000000000040157d sp 00007ffeb0762f00 error 6 in repro[157d,401000+1000] likely on CPU 1 (core 1, socket 0)
[   18.528028] Code: 8b 55 dc 8b 45 d0 41 b9 00 00 00 00 41 89 d0 b9 01 80 00 00 ba 03 00 00 00 48 89 c6 bf 00 00 00 00 e8 57 fb ff ff 48 8b 55 e8 <48> 89 02 48 8b 45 f0 8b 00 c1 e0 06 89 45 cc 8b 55 dc 8b 45 cc 41
[   18.899276] repro[761]: segfault at 0 ip 000000000040157d sp 00007ffeb0762f00 error 6 in repro[157d,401000+1000] likely on CPU 1 (core 1, socket 0)
[   18.899991] Code: 8b 55 dc 8b 45 d0 41 b9 00 00 00 00 41 89 d0 b9 01 80 00 00 ba 03 00 00 00 48 89 c6 bf 00 00 00 00 e8 57 fb ff ff 48 8b 55 e8 <48> 89 02 48 8b 45 f0 8b 00 c1 e0 06 89 45 cc 8b 55 dc 8b 45 cc 41
[   19.225731] repro[769]: segfault at 0 ip 000000000040157d sp 00007ffeb0762f00 error 6 in repro[157d,401000+1000] likely on CPU 1 (core 1, socket 0)
[   19.226868] Code: 8b 55 dc 8b 45 d0 41 b9 00 00 00 00 41 89 d0 b9 01 80 00 00 ba 03 00 00 00 48 89 c6 bf 00 00 00 00 e8 57 fb ff ff 48 8b 55 e8 <48> 89 02 48 8b 45 f0 8b 00 c1 e0 06 89 45 cc 8b 55 dc 8b 45 cc 41
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git cd qemu git checkout -f v7.1.0 mkdir build cd build yum install -y ninja-build.x86_64 yum -y install libslirp-devel.x86_64 ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp make make install 

On Wed, Jul 23, 2025 at 06:34:22PM -0700, Sohil Mehta wrote:
> Kernel threads aren't expected to directly access struct fpu using
> x86_task_fpu(). They typically access the FPU state using pairs of
> kernel_fpu_begin()/kernel_fpu_end().
> 
> When CONFIG_X86_DEBUG_FPU is set, any usage of x86_task_fpu() by kernel
> threads is flagged with a WARN_ON_ONCE(). However, along with the
> warning, x86_task_fpu() returns a NULL pointer, which deviates from the
> flow without the debug config.
> 
> Changing the return value could make failures harder to debug by masking
> problems or introducing its own set of issues. Keep the behavior of
> x86_task_fpu() consistent across debug and non-debug configurations,
> except for the warning.
> 
> Also, update the warning to include PF_USER_WORKER, as these tasks are
> treated as equivalent to kernel threads during FPU state management as
> well as context switch.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v3: Improve commit message
> v2: New patch
> 
> This patch is less urgent than Patch 1, which fixes the real issue.
> ---
>  arch/x86/kernel/fpu/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index ea138583dd92..ba16dda697b1 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -58,8 +58,7 @@ DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
>  #ifdef CONFIG_X86_DEBUG_FPU
>  struct fpu *x86_task_fpu(struct task_struct *task)
>  {
> -	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
> -		return NULL;
> +	WARN_ON_ONCE(task->flags & (PF_KTHREAD | PF_USER_WORKER));
>  
>  	return (void *)task + sizeof(*task);
>  }
> -- 
> 2.43.0
> 

