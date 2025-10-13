Return-Path: <linux-kernel+bounces-851072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D0BD55F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DCF18A2108
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A92BF3DF;
	Mon, 13 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/7+jZzI"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340E2BE638
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375309; cv=none; b=A7PgDSIM3dKMNFunwWRa5QGJFxSFc4v2plwt+kbT+WrR54XJ+7FP9Qci9Lzd5i0mlTNMxVfdquNETvfYP9/6lv+fveUAsjI5uf5NT4W1J6blFVH41mSoyTh2SbXoE/+I8xWCqAdD1YxOmhavnioXiLB4vMoXc4/B28xYobIZ1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375309; c=relaxed/simple;
	bh=DCy5/CgJwRiFtBH13G5e+tpTtOcFYMJzRR2a7I7YD1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLSDrXP8lFvVQvHoZAg6svikfOgTP/ik85X+HeZse5njSfUuJPooMRiZQNzWXagjMdyZj6QtzpJFMiDnSXw76FWLtCtJ/hd2T2gKHLPT9Bedt0s40zqxjJb4lM/2h56n2BbddxVPDvAn5E5rhR0pUEZSkb5Lm/GRZmbcAyWFlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/7+jZzI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782bfd0a977so3796905b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760375306; x=1760980106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7K/H0CMz1Ss8pt14TQwJbzmzCBNY3+1YMNkY4DuP58=;
        b=c/7+jZzIlGBCnSr8ZMcAQ3qKBryrfUVQy7G0hTqrP7ghqmM92Le+Jwl0A3cCPo5oPD
         ShaOoki1tHIcF8QZ5x3YxuVizxnSZ4On7AggiqM7A11h/wp9StbOzK/JctO5oFKNBTj0
         O1KnUJZrFQoEwji5gBAEwO843HJRHZh1uz0+dj6p+QJ+qoBj1vfl1ApKYAaIP55WifOO
         m59qxwZvC3j8Z7Y52APHUzW+4de35P5RP97YDt4KfVLt2pAgaZjBqdZ0GfDrkuO5ACeI
         ezjNjtXFILt3UUNknXqGLXjIRHXcE2FUyUz9a7M91hYv6sqwZO7Bb9lrN4ZS34I2DKAD
         5/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760375306; x=1760980106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7K/H0CMz1Ss8pt14TQwJbzmzCBNY3+1YMNkY4DuP58=;
        b=pin7LAMBUmfUR17BOKIHzc7VqX6rjFYZpmt+nTLCMrIM6CfROgTI1Axm1MTfPZueQj
         JElv0R6nAo1h2xdAO56Xo8VIFxn8WWD2wN2nEieboDJxI75AuQ4kpk69ySqBz86tf3oJ
         dF0aBpKNJcXZzdwRvcDYxXm552gM6NRcCZj6JY66jQ1NgUEla4UpO/WQVc4WMmv2LyB1
         tWSSIbDgwGWRbWXsI5zkWPAY/FXVGiNninc0ZcndImY8eAZ8kLIoKjdijhygwoPgBHTi
         cJJuuqhYce8Hmv7YHVMXKWOWs4G5Mj+GLkAn+bphx9Y4TVAMp8DsF/6KeFfFQ9nIpK1J
         0QkA==
X-Gm-Message-State: AOJu0Yxxc7n/nsm3YpI8+u8fGgpY3fQ37fzyQej4hWOcJt52eZ7WUQnS
	YiCzxVCjmkmzBbclGfiau6EmiMZOtk2IKORAvEeRCGJFajqvenUpdO00
X-Gm-Gg: ASbGncvZRrgd94ytn+NY3JsS7AWNO+IlKe0IrGlHq5xkHErGlJgjqsAv6n8Tuy7mdC0
	KiiK9o0onayk55oig9fJdkqFf15uUmCMvKrHBAzskaaP4q7WecyCqvrtfFszOyE1JC5VCqnMlv1
	QVjTNjIvB/wjmuDbu+v8x2nDMzERdUHJpGmik0cbbrjkWiQDHqvnvA/3iOC7HWhjFQleZHhtN52
	o4kh14uTe3NsLItOWNcbzb711vkqwN4rQsh17d7WE8/MB5iVV9BKRYBpol/6d6w6M8fMyY53kOX
	ttBhv0FEAErzq4zvSn6z29Pyk9eW6kJja7xDZRs0qvmbfiSR4XHGQzpIC8YcTtQaCKAthopbltj
	G74XIb6RM9L7pq3y9KuSYfuhBfsZz4A/1FVWMxw/j+ZggPXnFYQNHIImRVRyMZPRb
X-Google-Smtp-Source: AGHT+IH2ggmu+V8XIeTE9T5IxsLfd9HqeJGJ8kORvN4S+/OlFRc/sQDfFHhCR7O3Mjj6vtDUqEEEvg==
X-Received: by 2002:a17:903:1a2b:b0:268:5892:6a2e with SMTP id d9443c01a7336-290272ff539mr276879115ad.56.1760375306329;
        Mon, 13 Oct 2025 10:08:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f07253sm139659945ad.62.2025.10.13.10.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:08:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Oct 2025 10:08:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Feng Chen <feng.chen@amlogic.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: Linux 6.18-rc1
Message-ID: <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>

On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
> Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
> 
> Things look fairly normal: size-wise this is pretty much right in the
> middle of the pack, and nothing particular stands out in the shortlog
> of merges this merge window appended below. About half the diff is
> drivers, with the res being all over: vfs and filesystems, arch
> updates (although much of that is actually devicetree stuff, so it's
> arguably more driver-related), tooling, rust support etc etc.
> 
> This was one of the good merge windows where I didn't end up having to
> bisect any particular problem on nay of the machines I was testing.
> Let's hope that success mostly translates to the bigger picture too.
> 

Test results don't look that good, unfortunately.:

Build results:
	total: 163 pass: 149 fail: 14
Failed builds:
	arm:allmodconfig
	csky:defconfig
	csky:allnoconfig
	csky:tinyconfig
	csky:allmodconfig
	i386:allyesconfig
	mips:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	powerpc:skiroot_defconfig
	riscv32:allmodconfig
	riscv64:allmodconfig
	sparc64:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 609 pass: 581 fail: 28
Failed tests:
	alpha:clipper:defconfig:devtmpfs:pci-bridge:usb-xhci:net=pcnet:rootfs
	alpha:clipper:defconfig:devtmpfs:pci-bridge:scsi[AM53C974]:net=tulip:rootfs
	arm:quanta-q71l-bmc:aspeed_g4_defconfig:mtd32:net=nic:aspeed-bmc-quanta-q71l:ext2
	arm:palmetto-bmc:aspeed_g4_defconfig:mtd32:net=nic:aspeed-bmc-opp-palmetto:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:net=nic:aspeed-bmc-facebook-fuji:initrd
	arm:fuji-bmc:aspeed_g5_defconfig:sd2:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:usb1:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128,0,8,1:net=nic:aspeed-bmc-facebook-fuji:f2fs
	mips:malta:malta_defconfig:nocd:smp:net=pcnet:ide:rootfs
	mips:malta:malta_defconfig:nocd:nosmp:ide:net=pcnet:rootfs
	mips64:malta:malta_defconfig:nocd:smp:net=e1000-82544gc:ide:ext2
	mips64:malta:malta_defconfig:nocd:nosmp:net=pcnet:ide:ext2
	mipsel:malta:24Kf:malta_defconfig:nocd:smp:net=i82550:ide:rootfs
	mipsel:malta:mips32r6-generic:malta_32r6_defconfig:nocd:smp:net=pcnet:ide:rootfs
	mipsel:malta:24Kf:malta_defconfig:nosmp:ide:net=rtl8139:rootfs
	mipsel64:malta:malta_defconfig:r1:nosmp:ide:net=e1000:ext2
	mipsel64:malta:malta_defconfig:r1:smp:ide:net=i82550:ext2
	mipsel64:malta:malta_defconfig:r1:smp:ide:net=i82558a:cd
	parisc:B160L:net=virtio-net:nvme:ext4
	parisc:B160L:net=usb-ohci:sata-cmd646:btrfs
	parisc:B160L:net=rtl8139:scsi[DC395]:ext4
	parisc:C3700:net=pcnet:usb-xhci:ext4
	parisc:C3700:net=usb-ohci:usb-uas-ehci:btrfs
	parisc:C3700:net=rtl8139:usb-uas-xhci:f2fs
	sheb:rts7751r2dplus_defconfig:initrd
	sheb:rts7751r2dplus_defconfig:ata:ext2
	sheb:rts7751r2dplus_defconfig:usb:ext2
Unit test results:
	pass: 655208 fail: 0

I did not have time to analyze the qemu test failures.
Build test failure analysis is below. Patch authors copied to this e-mail.

Guenter

---
Build reference:

Build reference: v6.18-rc1
Compiler version: gcc (GCC) 14.3.0
Assembler version: GNU assembler (GNU Binutils) 2.44

General notes:

arm64be is no longer tested.
microblaze (build, boot) is no longer tested.
nommu images are no longer tested (arm, xtensa). 

========================================

arm
---

Building arm:allmodconfig ... failed
--------------
Error log:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefined!

The problem is the use of __bf_shf() which introduces calls to __ffsdi2().
I have no idea why that is the case.

Commit 4670db6f32e9 ("spi: amlogic: Fix error checking on regmap_write call"). 

Author: Feng Chen <feng.chen@amlogic.com>

=====================================

csky
----
Building csky:defconfig ... failed
--------------
Error log:
In file included from include/linux/thread_info.h:27,
                 from include/asm-generic/current.h:6,
                 from ./arch/csky/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from include/linux/sched/affinity.h:1,
                 from kernel/sched/sched.h:8,
                 from kernel/sched/rq-offsets.c:5:
arch/csky/abiv2/inc/abi/cacheflush.h: In function 'flush_dcache_folio':
arch/csky/abiv2/inc/abi/cacheflush.h:23:39: error: passing argument 2 of 'const_test_bit' from incompatible pointer type

bisect log:
# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# bad: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect bad bed0653fe2aacb0ca8196075cffc9e7062e74927
# good: [be812ace0378a9db86344ad637c5ed2a5d11f216] Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings
git bisect good be812ace0378a9db86344ad637c5ed2a5d11f216
# bad: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 8804d970fab45726b3c7cd7f240b31122aa94219
# good: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag 'media/v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good f79e772258df311c2cb21594ca0996318e720d28
# good: [a488ba3124c82d704963fcd760fe653df1987b13] huge_memory: return -EINVAL in folio split functions when THP is disabled
git bisect good a488ba3124c82d704963fcd760fe653df1987b13
# good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good 07fdad3a93756b872da7b53647715c48d0f4a2d0
# good: [af6703838ecb1513efdd2502a8f7bb6472c5ce96] mm: specify separate file and vm_file params in vm_area_desc
git bisect good af6703838ecb1513efdd2502a8f7bb6472c5ce96
# good: [b9120619246d733a27e5e93c29e86f2e0401cfc5] Merge series "SLUB percpu sheaves"
git bisect good b9120619246d733a27e5e93c29e86f2e0401cfc5
# good: [0efdedfa537eb534c251a5b4794caaf72cc55869] drivers/base/node: fix double free in register_one_node()
git bisect good 0efdedfa537eb534c251a5b4794caaf72cc55869
# good: [1acc369373008b9eeb930fbb47847c0693055553] mm/khugepaged: use start_addr/addr for improved readability
git bisect good 1acc369373008b9eeb930fbb47847c0693055553
# good: [7612833192d56af86061de8ab51989b75daf5b0d] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
git bisect good 7612833192d56af86061de8ab51989b75daf5b0d
# good: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect good 24d9e8b3c9c8a6f72c8b4c196a703e144928d919
# good: [1367da7eb875d01102d2ed18654b24d261ff5393] mm: swap: check for stable address space before operating on the VMA
git bisect good 1367da7eb875d01102d2ed18654b24d261ff5393
# first bad commit: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Actual: Commit 53fbef56e07df ("mm: introduce memdesc_flags_t") which
changes the definition of folio->flags.

Author: Matthew Wilcox (Oracle) <willy@infradead.org>

=============================================

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

================================================

mips
----

Building mips:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefined!

See above (arm:allmodconfig).

===============================================

openrisc
--------

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

bisect:

# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# bad: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect bad bed0653fe2aacb0ca8196075cffc9e7062e74927
# good: [be812ace0378a9db86344ad637c5ed2a5d11f216] Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings
git bisect good be812ace0378a9db86344ad637c5ed2a5d11f216
# good: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 8804d970fab45726b3c7cd7f240b31122aa94219
# good: [b3fee71e6673393d04476fbe0f4f03f97765e32d] Merge tag 'v6.18rc1-part1-ksmbd-server-fixes' of git://git.samba.org/ksmbd
git bisect good b3fee71e6673393d04476fbe0f4f03f97765e32d
# good: [944df7a31452f75bbc15b1e7215e1aacee8cd1b4] docs: update the guidance for Link: tags
git bisect good 944df7a31452f75bbc15b1e7215e1aacee8cd1b4
# bad: [50647a1176b7abd1b4ae55b491eb2fbbeef89db9] Merge tag 'pull-f_path' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad 50647a1176b7abd1b4ae55b491eb2fbbeef89db9
# bad: [c817248fc831f5494d076421672b70a6ec1a92dc] nfs/localio: add proper O_DIRECT support for READ and WRITE
git bisect bad c817248fc831f5494d076421672b70a6ec1a92dc
# bad: [4b7c3b4c673d40e4b98cdaf642495929f43787e6] NFS: Update the flexfilelayout driver to use xdr_set_scratch_folio()
git bisect bad 4b7c3b4c673d40e4b98cdaf642495929f43787e6
# bad: [bf75ad096820fee5da40e671ebb32de725a1c417] NFSv4.1: fix mount hang after CREATE_SESSION failure
git bisect bad bf75ad096820fee5da40e671ebb32de725a1c417
# good: [64dd8022245038109826c0e2a778f16618d88600] nfs: cleanup tracepoint declarations
git bisect good 64dd8022245038109826c0e2a778f16618d88600
# bad: [be390f95242785adbf37d7b8a5101dd2f2ba891b] NFSv4: handle ERR_GRACE on delegation recalls
git bisect bad be390f95242785adbf37d7b8a5101dd2f2ba891b
# bad: [ec7d8e68ef0ec5c635c8f9e93cd881673445a397] sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer
git bisect bad ec7d8e68ef0ec5c635c8f9e93cd881673445a397
# good: [9082aae154be2d9e208b56e249cb886612f7c6cf] sunrpc: remove dfprintk_cont() and dfprintk_rcu_cont()
git bisect good 9082aae154be2d9e208b56e249cb886612f7c6cf
# first bad commit: [ec7d8e68ef0ec5c635c8f9e93cd881673445a397] sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer

I did not try to understand why that patch triggers the build failure,
but reverting it fixes the problem (not that it is a good idea to have
a variable named 'strlen').

Author: Jeff Layton <jlayton@kernel.org>

=============================================================

parisc
------

Building parisc:allmodconfig ... failed
--------------
Error log:
In file included from arch/parisc/include/asm/bug.h:5,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/parisc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:79,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/slab.h:16,
                 from fs/nfsd/nfs4xdr.c:37:
fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
include/linux/kernel.h:334:46: error: called object 'strlen' is not a function or function pointer

Same as openrisc.

============================================================

powerpc
-------

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

==========================================================

riscv32
-------

Building riscv32:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefined!

See above.

=========================================================

riscv64
-------

Building riscv64:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefined!

See above.

========================================================

sparc64
-------

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

See above.

=======================================================

xtensa
------

Building xtensa:allmodconfig ... failed
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

See above.

