Return-Path: <linux-kernel+bounces-800673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63304B43A57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B053AEA03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE642D8DB5;
	Thu,  4 Sep 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="adX/rMzW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C3199FAB;
	Thu,  4 Sep 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985900; cv=none; b=hUVCAzRtl7HaDzKPlRB88riRuks6TPJf6TzxReFzyai7+uIwm4MfLBFOOShtNpHrw8YRQ+i6FjSSo++qS9u7yXo9OtRbbyp0sA+IN2CperkL4LdGsVUsZYxJATaywKieS6/sPcxIwpjddB//tH9SI5vzIQIrxkEtuHRGfJ5j9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985900; c=relaxed/simple;
	bh=+sdubL2sz//XgqJOH/O/8qj3o9anyK769FGMz522nfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvBQv8Zx5h/pOJ3MiQ61yOLpWjgvqpTUK2hGDi5vnBySe1Jsn3Vg4qJ2jDQj54+A7IaOsGSz7uAe/yleWaKHKi0rhxFUmpSd9R/zpnvsThCdoBLYzVu2T/evNNhITL0RTKd+YZXIbHRLHcqsb2BOGZjV7nhO5i6PlzvY1DCmiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=adX/rMzW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9683640E0174;
	Thu,  4 Sep 2025 11:38:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KtBzlzr1wuqK; Thu,  4 Sep 2025 11:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756985887; bh=UtpuqoAguIqDPPidQVQjlxR00s+Lz+8UM0zle/F2qg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adX/rMzW/gHPhbmQsVUhGi1o0WUDx7cZEQ8m+ZlW6PKrlIiLpGqOACTUv2gRaW3Zy
	 XgTubeJJEIR5NxoqNlOoLRvHYgaDusYyKQN9k2G/XhDGCzjYLVpeLPHClZEs2Ck4vy
	 DZ5e0yxF34o+tEXUXDY/6z1JWGw7iOySld9B9KIaPkAjk2aX4rXg4sPk1xG/py1ILT
	 2FbDyjNIJUesWLfsXxl3qJxL1qvfCE13CDw3/KEY5UyByMO1Cnu+ww8+81JKlUMuwS
	 86sUVQnrBtjuhb5W9GtreJosE+HyF3m6a0g9nrXqDVBo14XcMG1fZFE+QIf1yVNegd
	 61r0svuJV1mycV/zIAd6v/9IwrZjbzrsrQRyJr5eawEGo48+vi33jngyL2if3LlEmq
	 c0qC+WkuQOM9IZk3YbIdNz5w6x7Bjo9/evBr3HzWsVU1ji811UKJMUZz5xnONuAHj1
	 k5jFokL+W5tP5oENX9dmYIL3ncrjej5MBTPzjt+Z9jA17/eDE8tpaehZBnqc6Lxjsh
	 1469eQSw9yOUcs3lZzYndRcSyXSdBOQ/hSzNvRLxHCn5dswPwPGJ8WmDq91v2c1YK6
	 Tb40UWITvYsdKoQ61z9NP/jb1BMp/XfJCilKFXauYPT+7y3825ICyg6Ff1nj9WQ+3f
	 vouM+00HJ8AXAIQzvPDiU9Xc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8C8A740E019E;
	Thu,  4 Sep 2025 11:37:57 +0000 (UTC)
Date: Thu, 4 Sep 2025 13:37:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <oliver.sang@intel.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Borislav Petkov <bp@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	X86 ML <x86@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing
Message-ID: <20250904113752.GDaLl6ELJRd3LZYBQl@fat_crate.local>
References: <20250820135043.19048-2-bp@kernel.org>
 <202509021646.bc78d9ef-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202509021646.bc78d9ef-lkp@intel.com>

+ Nathan for the clang weirdness below...

On Tue, Sep 02, 2025 at 04:45:12PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> 
> this could be a noise, we didn't see the relation between the patch with the
> issue we observed. however, we rebuild the kernels for both this commit and
> parent 3 times.
> (
> our bot chose 894af4a1cde61c as the parent as below
> * 19f370d45aceea x86/microcode: Add microcode= cmdline parsing
> * 894af4a1cde61c (tip/x86/core, peterz-queue/x86/core) objtool: Validate kCFI calls
> )
> 
> and for each rerun of both this commit and parent, we run more times, but the
> issue is still quite persistent while parent keeps clean:
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
>   vm-snb/trinity/debian-11.1-i386-20220923.cgz/x86_64-randconfig-006-20250826/clang-20/300s/group-01/5
> 
> 894af4a1cde61c34 19f370d45aceea5ab4c52e3afa0
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :200         74%         149:200   last_state.is_incomplete_run
>            :200         74%         147:200   last_state.running
>            :200         75%         150:200   dmesg.CFI_failure_at_kobj_attr_show
>            :200         75%         150:200   dmesg.Kernel_panic-not_syncing:Fatal_exception
>            :200         75%         150:200   dmesg.Oops:invalid_opcode:#[##]KASAN
>            :200         75%         150:200   dmesg.RIP:kobj_attr_show
>            :200         75%         150:200   dmesg.boot_failures
> 
> so we just follow our report rule to still report this results FYI.
> 
> if it's really irrelevant, sorry maybe our env issues (though we still cannot
> figure out for now). and if you can help us to figure out the potential problem
> from our dmesg in below link, it will be very apprecidated!

Yeah, I don't know what you did here but building with that .config, I can't
even boot that kernel in a VM because doing:

qemu-... -kernel bzImage ...

sends me into grub and asks me to select the default kernel.

And my qemu script boots arbitrary kernels just fine.

Also, I used clang-20 from here:

https://mirrors.edge.kernel.org/pub/tools/llvm/

and version 20.1.8 took something like ~10(!) minutes to link vmlinux with
that config. Just FYI for Nathan, maybe something's weird there.

> below is full report.

Leaving it in.

> 
> 
> kernel test robot noticed "CFI_failure_at_kobj_attr_show" on:
> 
> commit: 19f370d45aceea5ab4c52e3afa00226fb99c3fc8 ("[PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing")
> url: https://github.com/intel-lab-lkp/linux/commits/Borislav-Petkov/x86-microcode-Add-microcode-cmdline-parsing/20250820-215624
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 894af4a1cde61c3401f237184fb770f72ff12df8
> patch link: https://lore.kernel.org/all/20250820135043.19048-2-bp@kernel.org/
> patch subject: [PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing
> 
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-01
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-randconfig-006-20250826
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509021646.bc78d9ef-lkp@intel.com
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250902/202509021646.bc78d9ef-lkp@intel.com
> 
> 
> [  453.382281][ T7761] CFI failure at kobj_attr_show+0x59/0x80 (target: nilfs_feature_revision_show+0x0/0x30; expected type: 0x1b8aae92)
> [  453.386793][ T7761] Oops: invalid opcode: 0000 [#1] KASAN
> [  453.388638][ T7761] CPU: 0 UID: 65534 PID: 7761 Comm: trinity-c2 Not tainted 6.17.0-rc2-00017-g19f370d45ace #1 NONE 
> [  453.391831][ T7761] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  453.395231][ T7761] RIP: 0010:kobj_attr_show+0x59/0x80
> [  453.397175][ T7761] Code: 08 00 74 08 4c 89 e7 e8 75 90 d2 fb 4d 8b 1c 24 4d 85 db 74 1f 4c 89 ff 4c 89 f6 48 89 da 41 ba 6e 51 75 e4 45 03 53 f1 74 02 <0f> 0b 2e e8 ef d7 08 00 eb 07 48 c7 c0 fb ff ff ff 5b 41 5c 41 5e
> [  453.403170][ T7761] RSP: 0018:ffffc90002b57a48 EFLAGS: 00010287
> [  453.405399][ T7761] RAX: 1ffffffff11d2fe9 RBX: ffff8881255ce000 RCX: dffffc0000000000
> [  453.408012][ T7761] RDX: ffff8881255ce000 RSI: ffffffff88e97f20 RDI: ffff888106a5e250
> [  453.410593][ T7761] RBP: ffffc90002b57a68 R08: ffff8881255cefff R09: 0000000000000000
> [  453.413717][ T7761] R10: 0000000082bfb03f R11: ffffffff82621360 R12: ffffffff88e97f48
> [  453.416820][ T7761] R13: 1ffff110295a3e80 R14: ffffffff88e97f20 R15: ffff888106a5e250
> [  453.419944][ T7761] FS:  0000000000000000(0000) GS:0000000000000000(0063) knlGS:00000000f7ed7280
> [  453.422938][ T7761] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [  453.425060][ T7761] CR2: 00000000f7795414 CR3: 000000015b1cc000 CR4: 00000000000406b0
> [  453.427781][ T7761] Call Trace:
> [  453.429070][ T7761]  <TASK>
> [  453.430222][ T7761]  sysfs_kf_seq_show+0x2a9/0x390
> [  453.431885][ T7761]  ? __cfi_kobj_attr_show+0x10/0x10
> [  453.433693][ T7761]  kernfs_seq_show+0x107/0x15b
> [  453.435360][ T7761]  seq_read_iter+0x55d/0xdeb
> [  453.436971][ T7761]  ? kernfs_fop_read_iter+0x14c/0x4a0
> [  453.438770][ T7761]  kernfs_fop_read_iter+0x14c/0x4a0
> [  453.440385][ T7761]  ? __import_iovec+0x31b/0x3db
> [  453.441900][ T7761]  do_iter_readv_writev+0x3de/0x590
> [  453.443609][ T7761]  vfs_readv+0x15d/0x3f5
> [  453.445305][ T7761]  ? trace_sys_enter+0x54/0xe5
> [  453.447044][ T7761]  do_readv+0xde/0x190
> [  453.448551][ T7761]  __ia32_sys_readv+0x80/0x90
> [  453.450192][ T7761]  ia32_sys_call+0x2dbd/0x2efb
> [  453.451877][ T7761]  __do_fast_syscall_32+0xaa/0x2a5
> [  453.453640][ T7761]  do_fast_syscall_32+0x36/0x8b
> [  453.455342][ T7761]  do_SYSENTER_32+0x1f/0x3b
> [  453.456962][ T7761]  entry_SYSENTER_compat_after_hwframe+0x78/0x82
> [  453.459058][ T7761] RIP: 0023:0xf7ede539
> [  453.460559][ T7761] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [  453.466394][ T7761] RSP: 002b:00000000ffa4237c EFLAGS: 00000292 ORIG_RAX: 0000000000000091
> [  453.469176][ T7761] RAX: ffffffffffffffda RBX: 00000000000000f5 RCX: 00000000571a6370
> [  453.471897][ T7761] RDX: 00000000000000af RSI: 0000000000000013 RDI: 0000000000000002
> [  453.474598][ T7761] RBP: 00000000201a2903 R08: 0000000000000000 R09: 0000000000000000
> [  453.477296][ T7761] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  453.479969][ T7761] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  453.482612][ T7761]  </TASK>
> [  453.483846][ T7761] Modules linked in:
> [  453.485501][ T7761] ---[ end trace 0000000000000000 ]---
> [  453.487396][ T7761] RIP: 0010:kobj_attr_show+0x59/0x80
> [  453.489298][ T7761] Code: 08 00 74 08 4c 89 e7 e8 75 90 d2 fb 4d 8b 1c 24 4d 85 db 74 1f 4c 89 ff 4c 89 f6 48 89 da 41 ba 6e 51 75 e4 45 03 53 f1 74 02 <0f> 0b 2e e8 ef d7 08 00 eb 07 48 c7 c0 fb ff ff ff 5b 41 5c 41 5e
> [  453.495522][ T7761] RSP: 0018:ffffc90002b57a48 EFLAGS: 00010287
> [  453.497663][ T7761] RAX: 1ffffffff11d2fe9 RBX: ffff8881255ce000 RCX: dffffc0000000000
> [  453.500363][ T7761] RDX: ffff8881255ce000 RSI: ffffffff88e97f20 RDI: ffff888106a5e250
> [  453.503133][ T7761] RBP: ffffc90002b57a68 R08: ffff8881255cefff R09: 0000000000000000
> [  453.505897][ T7761] R10: 0000000082bfb03f R11: ffffffff82621360 R12: ffffffff88e97f48
> [  453.508738][ T7761] R13: 1ffff110295a3e80 R14: ffffffff88e97f20 R15: ffff888106a5e250
> [  453.511482][ T7761] FS:  0000000000000000(0000) GS:0000000000000000(0063) knlGS:00000000f7ed7280
> [  453.514551][ T7761] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [  453.516790][ T7761] CR2: 00000000f7795414 CR3: 000000015b1cc000 CR4: 00000000000406b0
> [  453.519505][ T7761] Kernel panic - not syncing: Fatal exception
> [  453.521564][ T7761] Kernel Offset: disabled
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

