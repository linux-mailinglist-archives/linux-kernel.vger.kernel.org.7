Return-Path: <linux-kernel+bounces-873994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028FC1540E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5201A18921E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0F257852;
	Tue, 28 Oct 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZggjeA/F"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB60248166
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663054; cv=none; b=aNUte2HYWH8UQ20Faj9OJAGcticddFwJqp8bU6NjTvLSX6sOKHzt9KbAOup5XbwRuE3Df4TV4CCvlc9VHdrUh5ORsy7jgiMWvG1jLY0nKVbaGNrW/9jWqM3zI8b2vMpcjjoLsjkCBZySqPJMM81d0YQ+oxvL46rvXCBddpmfOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663054; c=relaxed/simple;
	bh=ylk4WcQkqjZfltQVLR4W/bXLPwt6wmv1FStYQxJ7YQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtZz/kNhCs30ekHircf3gqc3a31dJ1VWS189aSHu4CgDuG7rQCVG830lgl3EB/eI+4e1nCXPNhTJ/i2lXgeJRrfbGoCdk7O0Q9DkF5hlzrW5CMoopMJ4YYJoRjkh1xEniRm8JDO8mDBGwBeb0nKux4ZPe1yr8uW9jpeAzXYa0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZggjeA/F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5823632a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761663049; x=1762267849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X12gSo5A5/T9ek8mJS6rvu06xPzZbNZHTuwM01k5bg=;
        b=ZggjeA/FKXcCiJl/zZUcKQbKGqsd7QV+g+T6uh5v2hjSoJI+pEaXHcOArWKwgzZiW0
         ULCAsgLEDkEm0e8LEothTMkTERHiTu+Ufkl7hq21b7SwFe31nuKoW/KN775Cl4/WzPly
         /qydp9b3aBB7EejkHCJ4DK+T40Bt06/+Xq6NJay8+trjbsWj1Z9EEP+dYwporVNH+163
         CKKYiGcoRNvLpsAo7T8vpkZplX3fsYLd3nuymAJ335csnvMdQz6ao3iIdHDrB4/qFhC+
         cZuCAbPIB9id2pJ31CIh2CAAthZSQytAuVqlk1lsJ7/yTFH1y9q0+63XWmlQtu/3UtUP
         aqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663049; x=1762267849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+X12gSo5A5/T9ek8mJS6rvu06xPzZbNZHTuwM01k5bg=;
        b=SmYEFVObXl3SpXR7bbEEh6ZQVV+A5HZ20OqLCmsKEsJW6am8RYp9z3XMefXCbG26ZL
         FH4a4y5RsPjOFWKe+XcTGY0zmf9oDZBoog++RJMFxeJnANdidruzPG2IoFLV2id+QVFt
         EWxRVhFXiS1KfHg7ZIVr8qU2xGmAgJW5RjuYF1SUNm0ZQmN+wnIoxU4KXVQbKTQKfHvi
         w+2z5dTxngcTE8NKmG1x7kuMI5cMJ6JbgHHUXGxESNEysgDes8NYwxWW65iHePr+3RDU
         qUFll3FOF062fF722J3t2MQY93riHWKkplM+Kb2fK8GAudnDJ5hCc3Lf81yzVxWpPodb
         x02A==
X-Gm-Message-State: AOJu0YzU/N7TvBk6/T7Qyhe1A6g365Ct35vott/OrKhdaODJJCyhhYHM
	PYyjEvsPz09PYwkEobHt2QyVAUSKC6fSOZ0YyUfOzWYiuDkrF/Aewmvz
X-Gm-Gg: ASbGncsoRYQGuf1WZBuYkBo/xDEHcb8mVGfyXDyJZRhb/IU/xVeSh1QtgFZSd/VJSHQ
	TRudx7trU/uWEiHPcs9z2UwF1QLNWD3moe9aIfA7a6qn6bq0Q4IWlSRyE+TfdHPV2n1ZOs+8cXu
	rsAEB4+HbzQkUA9je8fKt6+cCHmDzRHE09+vktzcx5ygGjbSeb7zjrOdT0wao8eW1/zuf6eGUgv
	opBEyElhMoH7mFbTx8PZszfqK/DrXnbNtSrCIyaLPWDwaVsvVYjrk7eW0/ieZNr4OQwLdlSQ7Aa
	/QkqYCZAQyXgkuLKO4IMMgXqFvtWqwWWkkF+XGf4T2DcS94zv3sl+Kec/j282TMhS7x5Qm5tN73
	nQSiNyLSEZUWOOTwQhYEQMInVb5PI1c4jGjSCU8N6n9D3dnrS3xOwj75bQVWEAWxTSTwz/bGq+W
	QOP//brQqH6d+F
X-Google-Smtp-Source: AGHT+IHxx+HgxIvPOZtXdrZwYmrkl0rPTJNN4stYbZjjylBXC86AJvzVT3Hciol77VWFqM6+Xzy5TA==
X-Received: by 2002:a17:90b:3ecc:b0:327:e59d:2cc2 with SMTP id 98e67ed59e1d1-34027a06fa8mr4722841a91.10.1761663049103;
        Tue, 28 Oct 2025 07:50:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f3aeesm12317557a91.14.2025.10.28.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:50:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 28 Oct 2025 07:50:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tao Ren <rentao.bupt@gmail.com>, Helge Deller <deller@gmx.de>,
	Han Gao <rabenda.cn@gmail.com>, Rob Herring <robh@kernel.org>
Subject: Re: Linux 6.18-rc3
Message-ID: <44478467-d4c8-4ef1-882f-53e2c5172374@roeck-us.net>
References: <CAHk-=whBupL1jY0k4ZcPkGw6XZr9+SBG75b181XenzwFJuHD-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whBupL1jY0k4ZcPkGw6XZr9+SBG75b181XenzwFJuHD-A@mail.gmail.com>

On Sun, Oct 26, 2025 at 04:13:14PM -0700, Linus Torvalds wrote:
> Things feel fairly normal, and in fact the numbers say it's been a bit
> calmer than usual, but that's likely just the usual fluctuation in
> pull request timing rather than anything else. The diffstat certainly
> is pretty short and flat, I think the biggest change is from some
> smbdirect fixes (both client and server side), the rest really looks
> pretty minimal.
> 
> The high-level stats look very normal too, with half the patches being
> drivers (counting devicetree bindings there too), and the rest being
> pretty random and spread out. So we have the aforementioned smb fixes,
> some xfs fixes, and then random noise elsewhere. See the shortlog
> below for details.
> 

Test results:

Build results:
	total: 160 pass: 153 fail: 7
Failed builds:
	csky:allmodconfig
	i386:allyesconfig
	mips:loongson2k_defconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	powerpc:skiroot_defconfig
	sparc64:allmodconfig
Qemu test results:
	total: 611 pass: 603 fail: 8
Failed tests:
	arm:fuji-bmc:aspeed_g5_defconfig:net=nic:aspeed-bmc-facebook-fuji:initrd
	arm:fuji-bmc:aspeed_g5_defconfig:sd2:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:usb1:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128,0,8,1:net=nic:aspeed-bmc-facebook-fuji:f2fs
	parisc:B160L:net=virtio-net:nvme:ext4
	parisc:B160L:net=usb-ohci:sata-cmd646:btrfs
	parisc:C3700:net=usb-ohci:usb-uas-ehci:btrfs
Unit test results:
	pass: 665967 fail: 4

Details below.

Guenter

---
Build reference:

Build reference: v6.18-rc2
Compiler version: gcc (GCC) 14.3.0
Assembler version: GNU assembler (GNU Binutils) 2.44

========================================

i386
----

Building i386:allyesconfig ... failed
--------------
Error log:
x86_64-linux-ld: drivers/power/supply/intel_dc_ti_battery.o: in function `dc_ti_battery_get_voltage_and_current_now':
intel_dc_ti_battery.c:(.text+0x5c): undefined reference to `__udivdi3'
x86_64-linux-ld: intel_dc_ti_battery.c:(.text+0x96): undefined reference to `__udivdi3'

Commit 8c5795fe55278 ("power: supply: Add new Intel Dollar Cove TI
battery driver") introduces various 64 bit divide operations.

Submitter: Hans de Goede <hansg@kernel.org>

Status: Fix available ("power: supply: intel_dc_ti_battery: fix 64bit divisions")

===============================================

csky, openrisc, parisc, sparc64
-------------------------------

Building openrisc:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/cpumask.h:11,
                 from include/linux/smp.h:13,
                 from include/linux/lockdep.h:14,
                 from include/linux/spinlock.h:63,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/slab.h:16,
                 from fs/nfsd/nfs4xdr.c:37:
fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
include/linux/kernel.h:334:46: error: called object 'strlen' is not a function or function pointer

# first bad commit: [ec7d8e68ef0ec5c635c8f9e93cd881673445a397] sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer

Author: Jeff Layton <jlayton@kernel.org>

Status: Fix available ("Avoid strlen conflict in nfsd4_encode_components_esc()")

=============================================================

mips, powerpc
-------------

Building mips:loongson2k_defconfig ... failed
Building powerpc:skiroot_defconfig ... failed
--------------
Error log:
drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c: In function 'ixgbe_fwlog_init':
drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:3938:40: error: 'struct ixgbe_adapter' has no member named 'ixgbe_dbg_adapter'
 3938 |                 .debugfs_root = adapter->ixgbe_dbg_adapter,

struct ixgbe_adapter only provides ixgbe_dbg_adapter if CONFIG_DEBUG_FS=y,
but commit 641585bc978e0 ("ixgbe: fwlog support for e610") uses it
unconditionally.

Author: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Status: Fix available ("libie: depend on DEBUG_FS when building LIBIE_FWLOG")

==========================================================

qemu test failures

arm
---

arm:fuji-bmc:aspeed_g5_defconfig:net=nic:aspeed-bmc-facebook-fuji:initrd
arm:fuji-bmc:aspeed_g5_defconfig:sd2:net=nic:aspeed-bmc-facebook-fuji:ext2
arm:fuji-bmc:aspeed_g5_defconfig:usb1:net=nic:aspeed-bmc-facebook-fuji:ext2
arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128:net=nic:aspeed-bmc-facebook-fuji:ext2
arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128,0,8,1:net=nic:aspeed-bmc-facebook-fuji:f2fs

# first bad commit: [b0f294fdfc3e472839a9bc0dc91f2322e27e38ef] ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts

The "first bad" commit disables the Ethernet interface on bmc-facebook-fuji.

Author: Tao Ren <rentao.bupt@gmail.com>

Status: Fix available ("ARM: dts: aspeed: fuji-data64: Enable mac3 controller")

========================================

parisc
------

parisc:B160L:net=virtio-net:nvme:ext4
parisc:B160L:net=usb-ohci:sata-cmd646:btrfs
parisc:C3700:net=usb-ohci:usb-uas-ehci:btrfs

Spinlock recursion:

Starting network: udhcpc: started, v1.36.1
[   66.118113] Backtrace:
[   66.118272]  [<104320d4>] unwind_once+0x1c/0x5c
[   66.118272]  [<10434a00>] walk_stackframe.isra.0+0x74/0xb8
[   66.118272]  [<10434a6c>] arch_stack_walk+0x28/0x38
[   66.118272]  [<104e5efc>] stack_trace_save+0x48/0x5c
[   66.118272]  [<105d1bdc>] set_track_prepare+0x44/0x6c
[   66.118272]  [<105d9c80>] ___slab_alloc+0xfc4/0x1024
[   66.118272]  [<105d9d38>] __slab_alloc.isra.0+0x58/0x90
[   66.118272]  [<105dc80c>] kmem_cache_alloc_noprof+0x2ac/0x4a0
[   66.118272]  [<105b8e54>] __anon_vma_prepare+0x60/0x280
[   66.118272]  [<105a823c>] __vmf_anon_prepare+0x68/0x94
[   66.118272]  [<105a8b34>] do_wp_page+0x8cc/0xf10
[   66.118272]  [<105aad88>] handle_mm_fault+0x6c0/0xf08
[   66.118272]  [<10425568>] do_page_fault+0x110/0x440
[   66.118272]  [<10427938>] handle_interruption+0x184/0x748
[   66.118272]  [<11178398>] schedule+0x4c/0x190
[   66.118272] BUG: spinlock recursion on CPU#0, ifconfig/2420
[   66.118272]  lock: terminate_lock.2+0x0/0x1c, .magic: dead4ead, .owner: ifconfig/2420, .owner_cpu: 0

Bisect log:

# bad: [d9043c79ba68a089f95bb4344ab0232c3585f9f1] Merge tag 'sched_urgent_for_v6.18_rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [7dbec0bbc3b468310be172f1ce6ddc9411c84952] Merge tag 'for-6.18/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
git bisect good 7dbec0bbc3b468310be172f1ce6ddc9411c84952
# good: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect good 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
# good: [37bfdbc11b245119210ac9924a192aec8bd07d16] Merge tag 'pci-v6.18-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect good 37bfdbc11b245119210ac9924a192aec8bd07d16
# bad: [ae13bd23102805383bf04f26e0b043f3d02c9b15] Merge tag 'mm-nonmm-stable-2025-10-10-15-03' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad ae13bd23102805383bf04f26e0b043f3d02c9b15
# good: [18a7e218cfcdca6666e1f7356533e4c988780b57] Merge tag 'net-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 18a7e218cfcdca6666e1f7356533e4c988780b57
# bad: [1b1391b9c4bfadcaeb89a87edf6c3520dd349e35] Merge tag 'block-6.18-20251009' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
git bisect bad 1b1391b9c4bfadcaeb89a87edf6c3520dd349e35
# good: [9976831f401eeb302d699b2d37624153d7cd2892] Merge tag 'gpio-fixes-for-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect good 9976831f401eeb302d699b2d37624153d7cd2892
# good: [fdfa38e95e1229ec2fb2f18540987c97f861d470] Merge tag 'sound-fix-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good fdfa38e95e1229ec2fb2f18540987c97f861d470
# bad: [8cc8ea228c4199482cf087fc6ed2d6e31b7a49e2] Merge tag 'parisc-for-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect bad 8cc8ea228c4199482cf087fc6ed2d6e31b7a49e2
# good: [912b9fd7c7775060900ad315f0ceb616f9381bc3] parisc: Report software alignment faults via perf
git bisect good 912b9fd7c7775060900ad315f0ceb616f9381bc3
# bad: [44ac7f5c6d4c7fd62784bb2700245dbc4ac7e102] parisc: Firmware: Fix returned path for PDC_MODULE_FIND on older machines
git bisect bad 44ac7f5c6d4c7fd62784bb2700245dbc4ac7e102
# bad: [610cb23bcc75bcd9fead3e41cbd867cccd0eb229] parisc: Add initial kernel-side perf_event support
git bisect bad 610cb23bcc75bcd9fead3e41cbd867cccd0eb229
# first bad commit: [610cb23bcc75bcd9fead3e41cbd867cccd0eb229] parisc: Add initial kernel-side perf_event support

Reverting the offending patch fixes the problem.

This is a new failure, previously masked by the ext3 problem.

Author: Helge Deller <deller@gmx.de>

Status: Reported to author

========================================

sheb
----

sheb:rts7751r2dplus_defconfig:initrd
sheb:rts7751r2dplus_defconfig:ata:ext2
sheb:rts7751r2dplus_defconfig:usb:ext2

Status: This was an emulation and/or compiler problem. Worked around
by switching to gcc 13.4.

======================================

Unit tests:

riscv64

[   42.166966]     # Subtest: of_dtb
[   42.167075]     # module: of_test
[   42.167151]     1..2
[   42.168661]     # of_dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/of/of_test.c:21
[   42.168661]     Expected np is not null, but is
[   42.171310]     # of_dtb_root_node_found_by_path: pass:0 fail:1 skip:0 total:1
[   42.171408]     not ok 1 of_dtb_root_node_found_by_path
[   42.172553]     # of_dtb_root_node_populates_of_root: EXPECTATION FAILED at drivers/of/of_test.c:31
[   42.172553]     Expected of_root is not null, but is
[   42.175122]     # of_dtb_root_node_populates_of_root: pass:0 fail:1 skip:0 total:1
[   42.175215]     not ok 2 of_dtb_root_node_populates_of_root
[   42.175445] # of_dtb: pass:0 fail:2 skip:0 total:2
[   42.175634] # Totals: pass:0 fail:2 skip:0 total:2

Caused by commit 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by probing
DT devices when ACPI is used"), affecting riscv boots with ACPI enabled.

Status: Patch fixing the problem submitted.
	"of: Skip devicetree kunit tests when RISCV+ACPI doesn't populate root node"
	Rejected; affected tests will be disabled in my test bed going forward.

Author: Han Gao <rabenda.cn@gmail.com>
Maintainer: Rob Herring <robh@kernel.org>

