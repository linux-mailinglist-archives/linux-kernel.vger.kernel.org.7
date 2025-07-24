Return-Path: <linux-kernel+bounces-743378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66218B0FDDE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5FA5441F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C342259C;
	Thu, 24 Jul 2025 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e89npJSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9EBCA5E;
	Thu, 24 Jul 2025 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315344; cv=none; b=T7e7LPMHhaSASi+uXABpadGI12yyPLNuUD1WTxn2pSqliVpvM+hNSmaqyKXlkY6WxELXg7REOTa0empiR6jZRnYoDDHREfjVvYh3z3DF79blACeacZaGLGaeSEJqawnTtIyV+ueBow39/+yMRWidWlVYiWHBbId5/rAa1FN9pX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315344; c=relaxed/simple;
	bh=If3eMMsTRHX3NEqMggWK7U82WEV5nvVCHftqXxcqOHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kYqN0QcZtM5rORR95wQvVpxZeA8r/AXQMqBB3z+P9QPSNyhRfx2g4/B2moEmvCFkCDv/h4UrobPGnY7Xsf2JqHSXMTiNSgYrHBsNm1vl5iHLLT+cN49z5CeOpz8iZJ+6b4c8Dw0KgNGov0KnvS/yXY5GplE5WP7DthrMQ1s+zYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e89npJSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC68FC4CEE7;
	Thu, 24 Jul 2025 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753315344;
	bh=If3eMMsTRHX3NEqMggWK7U82WEV5nvVCHftqXxcqOHc=;
	h=Date:From:To:Cc:Subject:From;
	b=e89npJSGng21ydZMbsm0ZBH62G7pGel69kWUoiUvrAxTgzfj/JohzBPsUznlWy0YD
	 gx5sO1Tgs8MXRsYHsHaUvscReRS7jwMjL5sygK55sxJeKlpZUZrqj0dGL4ZT1CNTSG
	 u9Qj9G94detYnJYJiAPFOlyXqoGV/bjVVTA2Qcr7auyDYx99qaoYZ1doCnrq/rOtb7
	 RlFkPTJHMnRGb2fFjK/402rt94Wo+ZLfI+I+OIi0X+RB/jkCQsolfBVNrTpT2HqFVO
	 v9xETNL/XgdAaiistX6fewvYwhm/vpft96vPEEZLEu6RIg177RVsej8NiRUlIafHtH
	 bfABsYJD3u+8w==
Date: Wed, 23 Jul 2025 17:02:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Crash on QEMU shutdown with x86_64_defconfig+ThinLTO+CFI after LLVM
 commit 9878ef3abd2a
Message-ID: <20250724000219.GA2976491@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter C (as Peter Z is also on CC with other kCFI folks),

I bisected a crash I see when shutting down a QEMU virtual machine
booted with a kernel built with clang tip of tree and ThinLTO and kCFI
enabled on top of defconfig to your LLVM commit 9878ef3abd2a ("CodeGen:
Respect function align attribute if less than preferred alignment.") [1]

$ git show -s --format='%h ("%s")'
a933d3dc1968 ("Add linux-next specific files for 20250723")

$ clang --version | head -1
ClangBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-project.git e67f3237d6242d1c362fa52e782ddfd5ae54a8af)

$ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper defconfig

$ scripts/config -d LTO_NONE -d WERROR -e LTO_CLANG_THIN -e CFI_CLANG

$ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig bzImage

$ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20241120-044434/x86_64-rootfs.cpio.zst | zstd -d >rootfs.cpio

$ qemu-system-x86_64 \
    -display none \
    -nodefaults \
    -M q35 \
    -d unimp,guest_errors \
    -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
    -kernel arch/x86/boot/bzImage \
    -initrd rootfs.cpio \
    -cpu host \
    -enable-kvm \
    -m 512m \
    -smp 8 \
    -serial mon:stdio
[    0.000000] Linux version 6.16.0-rc7-next-20250723 (nathan@ax162) (ClangBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-project.git e67f3237d6242d1c362fa52e782ddfd5ae54a8af), ClangBuiltLinux LLD 22.0.0 (https://github.com/llvm/llvm-project.git e67f3237d6242d1c362fa52e782ddfd5ae54a8af)) #1 SMP PREEMPT_DYNAMIC Wed Jul 23 10:30:40 MST 2025
...
[    1.091342] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[    1.092163] CPU: 2 UID: 0 PID: 155 Comm: ifdown Not tainted 6.16.0-rc7-next-20250723 #1 PREEMPT(voluntary)
[    1.093631] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    1.095245] RIP: 0010:xfrm4_dst_lookup.llvm.2597333927409562488+0xac/0xc0
[    1.096294] Code: 12 8b 47 28 89 44 24 30 48 8b 3f 48 89 e6 31 d2 e8 d9 9e f6 ff 65 48 8b 0d 11 5f 63 01 48 3b 4c 24 38 75 0a 48 83 c4 40 e9 fc <ff> ff fe cc e8 3b d7 24 00 cc cc cc cc cc cc cc cc cc cc cc ba 4a
[    1.099091] RSP: 0018:ff422e64c03bfce0 EFLAGS: 00010246
[    1.099899] RAX: ff2413ab81e95710 RBX: ff2413ab81e95740 RCX: 0000000000000001
[    1.100961] RDX: ffffffff9e644197 RSI: 0000000000000000 RDI: ff2413ab81e95710
[    1.102001] RBP: ffffffff9e705850 R08: 0000000000000006 R09: ffffffff9f5523e4
[    1.103011] R10: 0000000000000000 R11: ffffffff9d28d270 R12: ff2413ab81857001
[    1.104031] R13: ff2413ab81e95830 R14: ffffffff9e705850 R15: ff2413ab81e957c0
[    1.105097] FS:  00007fc43bee46a0(0000) GS:ff2413abff95a000(0000) knlGS:0000000000000000
[    1.106204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.107050] CR2: 0000560f4233b1c8 CR3: 00000000028a2005 CR4: 0000000000771ef0
[    1.108058] PKRU: 55555554
[    1.108477] Call Trace:
[    1.108907]  <TASK>
[    1.109235]  shmem_destroy_inode+0x1e/0x40
[    1.109822]  evict+0x2c9/0x340
[    1.110248]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.110969]  ? fsnotify_grab_connector+0x50/0x75
[    1.111601]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.112349]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.113124]  ? _atomic_dec_and_lock+0x2c/0x50
[    1.113832]  __dentry_kill+0xb3/0x220
[    1.114393]  dput+0x47/0x8b
[    1.114871]  do_renameat2+0x492/0x650
[    1.115365]  __x64_sys_renameat2+0x47/0x60
[    1.115982]  do_syscall_64+0xc8/0x1f0
[    1.116508]  ? arch_exit_to_user_mode_prepare+0x9/0x60
[    1.117278]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.117973]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.118714] RIP: 0033:0x7fc43be4af2e
[    1.119304] Code: 08 00 f7 d8 64 89 02 48 83 c8 ff c3 49 89 f2 45 31 c0 48 89 fe b8 3c 01 00 00 48 c7 c2 9c ff ff ff 48 c7 c7 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 1b ef 08 00 f7 d8 64 89 02 48 83
[    1.122003] RSP: 002b:00007ffdc8a3f9d8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
[    1.123107] RAX: ffffffffffffffda RBX: 0000560f27b9e6f6 RCX: 00007fc43be4af2e
[    1.124056] RDX: ffffffffffffff9c RSI: 0000560f27b9e6f6 RDI: ffffffffffffff9c
[    1.125113] RBP: 0000560f27b9e51f R08: 0000000000000000 R09: 00007fc43bee32b0
[    1.126134] R10: 0000560f27b9e51f R11: 0000000000000246 R12: 0000560f27b9f2e3
[    1.127148] R13: 0000560f42338030 R14: 0000000000000000 R15: 0000560f27b1f389
[    1.128222]  </TASK>
[    1.128558] Modules linked in:
[    1.129114] ---[ end trace 0000000000000000 ]---
[    1.130101] RIP: 0010:xfrm4_dst_lookup.llvm.2597333927409562488+0xac/0xc0
[    1.131451] Code: 12 8b 47 28 89 44 24 30 48 8b 3f 48 89 e6 31 d2 e8 d9 9e f6 ff 65 48 8b 0d 11 5f 63 01 48 3b 4c 24 38 75 0a 48 83 c4 40 e9 fc <ff> ff fe cc e8 3b d7 24 00 cc cc cc cc cc cc cc cc cc cc cc ba 4a
[    1.134589] RSP: 0018:ff422e64c03bfce0 EFLAGS: 00010246
[    1.135360] RAX: ff2413ab81e95710 RBX: ff2413ab81e95740 RCX: 0000000000000001
[    1.136369] RDX: ffffffff9e644197 RSI: 0000000000000000 RDI: ff2413ab81e95710
[    1.137407] RBP: ffffffff9e705850 R08: 0000000000000006 R09: ffffffff9f5523e4
[    1.138442] R10: 0000000000000000 R11: ffffffff9d28d270 R12: ff2413ab81857001
[    1.139563] R13: ff2413ab81e95830 R14: ffffffff9e705850 R15: ff2413ab81e957c0
[    1.140673] FS:  00007fc43bee46a0(0000) GS:ff2413abff95a000(0000) knlGS:0000000000000000
[    1.142116] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.143131] CR2: 0000560f4233b1c8 CR3: 00000000028a2005 CR4: 0000000000771ef0
[    1.144199] PKRU: 55555554
```

If I add 'cfi=off' to the cmdline in the '-append' value when booting
the exact same kernel, I do not get a panic on shutdown. I initially
noticed that this only happened on linux-next but not mainline, so I
bisected Linux and landed on a seemingly innocuous change. Only once I
realized that LLVM 21.1.0-rc1 had no issue did I think to bisect LLVM
for the change, which landed me on 9878ef3abd2a.

I suspect that the run time patching of FineIBT / kCFI is involved,
given the way the Linux bisect went and the fact that turning off CFI at
run time results in no issues (hence CC'ing Peter Z). The fact this
requires LTO is suspect as well. I know little about the run time
patching that x86 does but it has had problems with the alignments of
functions changing such as when GCC would not respect
'-falign-functions' on __cold functions. Does this deviate from GCC's
behavior? I am not sure how to better uncover what is going on here.

[1]: https://github.com/llvm/llvm-project/commit/9878ef3abd2a48fcfb81357d581dac292b52ddb3

Cheers,
Nathan

