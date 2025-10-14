Return-Path: <linux-kernel+bounces-851803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138EBD74DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8C9D4EE7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E759D30C374;
	Tue, 14 Oct 2025 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPAVMCpd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77798635C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417207; cv=none; b=f03b/I16WNLUiy1gvS+NaUFkkXp6kle77zxyymHIpqlSJAaNj4bZYZG6sQ5/wWnKmB7uWgM6CR4ad2K90PoG0Q0WcdfFuzli5PkG5V4/TdQsONhkOsnicGbxXi1sTqHsL+yYpnSaeIPdGopM3AbBSqu2s77rQ+aODJHI/ayBkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417207; c=relaxed/simple;
	bh=zRxBz3CY0F9Aj4PqlhOkHbK8jYEw5v59bbvGjLYVRQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4bwlTx8WRh8e4/30E/Mvdr1ZwX9kDEDY5h+wkYCV/J1WUYVry9uwvRlzcQF5uYNq1+KamoRnONb98s5mSUOq+RL0ljgYjUZW9NNuGqccBgARI2wJAVg/pwYNm3fjNdJ2qpAW03d3oGG1EDA1qE8UIqj0CE4YKV8XVkqiX/MOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPAVMCpd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2897522a1dfso45764325ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760417205; x=1761022005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehNTmByAh6XBmAKgtfp2GEARftZLxRM2d7Wgjs9gun4=;
        b=iPAVMCpdsUwg1TBqoaoxQjmQ8YJm/w0nI/rkOPnqlTUCIV7PO/So+sG2+09giWwnuB
         A64cG9XMyIMRrrBuMhDAFHl6cet4ZiU9IQiA0tGAA8b1wCw1PadScfaoNU5YOQ6USBNv
         3LOgUoNmC73BNUOTQeZSCbpaXyD+MeB15FADb1NKE3LsYuxfLPyhGeO2FwTDyiHqEL9z
         kl4eROKeUY2/EZ3B1/4kndps8tuM+VyvWpcRbHJljkUvA/xURd0Gq08kSoLYa1IRnsco
         kWuT7Bub+92hCJpbI7KpsFJI4ZckG4JF36JIn6Fwh1+a8ykj5Bczp0K30IfuL0DkLR3N
         ZKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760417205; x=1761022005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehNTmByAh6XBmAKgtfp2GEARftZLxRM2d7Wgjs9gun4=;
        b=GpKhBY/E0q0oA39YUZ7tPCMQ/RVS/T27m1Vbt9N8vIEFi7c1Rtdaqij3FyzthR8Iqi
         v8wcNbDg0PIUbHapqmVZMAmZXh3nCtT0N5G4UAO7NhfDWJ8Tm5Pty/7OFUYVHuDEhd9C
         uX8iXTXrN9rwjA1mYX0DuCviWk5NpPKNdzKbXbTduwBqWuSHHPDMZbPHajncVKzt2kcM
         6g2DE9M2pMcdNGS4alG5jLVAkBzuOOv5nETUPJZ1uoRwCdaS9qLNH//1NIC84yh1DsKn
         tkBfbt/kB1W/KaoU5IqbRg8BlxxT/w/SaGGnO7AHLNyEiT1T5nuH8YPwVOIFAvsOKYMZ
         DJIA==
X-Gm-Message-State: AOJu0YwnBX2SxqMJoV5t1ar6l5S02ZGY3J8wpEkfvYn5jR5zqPUaA/VN
	tfhyjvBfKaMpjjrVhx6IpngS3/d+RNXOUkzsa80WIr/9HGy9YgT+TC58
X-Gm-Gg: ASbGncvZ4wyHfZzyEtMaLZfeDUZxJl+ouJvPxWHfrO8hn73pSVGYgkdYXRQc6Vri8Pl
	MdpZPdJmsK41dSrGEQ/WnPqmNp2BXBvGCJGS5LFNuszKmmKACOaIqNwpSI7dLRxIAwVQ7uTDJp6
	sMUXjp/mmUSHrwC0jMTpdygDBMQ09Njb+Knu2V4b49BBb40mOI3S8iqYTxFkDTTfCadffmzkFPY
	Mc968OE9y7W4p7VpaBb5E4FnGlLN5IYActnuS3JEkPeizDMwL70UE/CrWPwj/RKoM6aJQzawbZd
	3d9Q0lmS+5m39cp47GSTbyxzMHfASRstnuCE8IpsUm89mAhur+w820wi6Xfv+Mt8rAZ14wwREis
	p5SoZkhE3pCTTX1//G4AE19lQDJdn1S5EyppkKdlq/VpO3vxKvtzeZ0888yLASrPc
X-Google-Smtp-Source: AGHT+IGCa70t/sdoJiRO+Q/yA5Qf9uB11H05TkVBSj4F/RdMGlk4Ei3IYeml/dCvMeWeDtLH0S+AgQ==
X-Received: by 2002:a17:902:f708:b0:272:dee1:c137 with SMTP id d9443c01a7336-29027238ee0mr295874015ad.13.1760417204733;
        Mon, 13 Oct 2025 21:46:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f06c82sm150836625ad.81.2025.10.13.21.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:46:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Oct 2025 21:46:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Feng Chen <feng.chen@amlogic.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Tao Ren <rentao.bupt@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: Linux 6.18-rc1
Message-ID: <c45a8502-3af2-4d5c-a660-2922b4e040bb@roeck-us.net>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>

On Mon, Oct 13, 2025 at 10:08:26AM -0700, Guenter Roeck wrote:
> On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
> > Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
> > 
> > Things look fairly normal: size-wise this is pretty much right in the
> > middle of the pack, and nothing particular stands out in the shortlog
> > of merges this merge window appended below. About half the diff is
> > drivers, with the res being all over: vfs and filesystems, arch
> > updates (although much of that is actually devicetree stuff, so it's
> > arguably more driver-related), tooling, rust support etc etc.
> > 
> > This was one of the good merge windows where I didn't end up having to
> > bisect any particular problem on nay of the machines I was testing.
> > Let's hope that success mostly translates to the bigger picture too.
> > 
> 
> Test results don't look that good, unfortunately.:
> 
...
> Qemu test results:
> 	total: 609 pass: 581 fail: 28
> Failed tests:
> 	alpha:clipper:defconfig:devtmpfs:pci-bridge:usb-xhci:net=pcnet:rootfs
> 	alpha:clipper:defconfig:devtmpfs:pci-bridge:scsi[AM53C974]:net=tulip:rootfs
> 	arm:quanta-q71l-bmc:aspeed_g4_defconfig:mtd32:net=nic:aspeed-bmc-quanta-q71l:ext2
> 	arm:palmetto-bmc:aspeed_g4_defconfig:mtd32:net=nic:aspeed-bmc-opp-palmetto:ext2
> 	arm:fuji-bmc:aspeed_g5_defconfig:net=nic:aspeed-bmc-facebook-fuji:initrd
> 	arm:fuji-bmc:aspeed_g5_defconfig:sd2:net=nic:aspeed-bmc-facebook-fuji:ext2
> 	arm:fuji-bmc:aspeed_g5_defconfig:usb1:net=nic:aspeed-bmc-facebook-fuji:ext2
> 	arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128:net=nic:aspeed-bmc-facebook-fuji:ext2
> 	arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128,0,8,1:net=nic:aspeed-bmc-facebook-fuji:f2fs
> 	mips:malta:malta_defconfig:nocd:smp:net=pcnet:ide:rootfs
> 	mips:malta:malta_defconfig:nocd:nosmp:ide:net=pcnet:rootfs
> 	mips64:malta:malta_defconfig:nocd:smp:net=e1000-82544gc:ide:ext2
> 	mips64:malta:malta_defconfig:nocd:nosmp:net=pcnet:ide:ext2
> 	mipsel:malta:24Kf:malta_defconfig:nocd:smp:net=i82550:ide:rootfs
> 	mipsel:malta:mips32r6-generic:malta_32r6_defconfig:nocd:smp:net=pcnet:ide:rootfs
> 	mipsel:malta:24Kf:malta_defconfig:nosmp:ide:net=rtl8139:rootfs
> 	mipsel64:malta:malta_defconfig:r1:nosmp:ide:net=e1000:ext2
> 	mipsel64:malta:malta_defconfig:r1:smp:ide:net=i82550:ext2
> 	mipsel64:malta:malta_defconfig:r1:smp:ide:net=i82558a:cd
> 	parisc:B160L:net=virtio-net:nvme:ext4
> 	parisc:B160L:net=usb-ohci:sata-cmd646:btrfs
> 	parisc:B160L:net=rtl8139:scsi[DC395]:ext4
> 	parisc:C3700:net=pcnet:usb-xhci:ext4
> 	parisc:C3700:net=usb-ohci:usb-uas-ehci:btrfs
> 	parisc:C3700:net=rtl8139:usb-uas-xhci:f2fs
> 	sheb:rts7751r2dplus_defconfig:initrd
> 	sheb:rts7751r2dplus_defconfig:ata:ext2
> 	sheb:rts7751r2dplus_defconfig:usb:ext2
> Unit test results:
> 	pass: 655208 fail: 0
> 

Here is an update for the qemu test failures. Note that there may be
secondary failures. I reported all problems except for the sheb boot
failure to the patch authors.

Guenter

---

alpha
-----

alpha:clipper:defconfig:devtmpfs:pci-bridge:usb-xhci:net=pcnet:rootfs
alpha:clipper:defconfig:devtmpfs:pci-bridge:scsi[AM53C974]:net=tulip:rootfs

No root file system. Bisect log:

# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect good bed0653fe2aacb0ca8196075cffc9e7062e74927
# good: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good 6a74422b9710e987c7d6b85a1ade7330b1e61626
# bad: [522ba450b56fff29f868b1552bdc2965f55de7ed] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad 522ba450b56fff29f868b1552bdc2965f55de7ed
# bad: [256e3417065b2721f77bcd37331796b59483ef3b] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 256e3417065b2721f77bcd37331796b59483ef3b
# bad: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect bad 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
# bad: [531abff0fa53bc3a2f7f69b2693386eb6bda96e5] Merge branch 'pci/controller/qcom'
git bisect bad 531abff0fa53bc3a2f7f69b2693386eb6bda96e5
# bad: [fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3] Merge branch 'pci/resource'
git bisect bad fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3
# good: [0bb65e32495e6235a069b60e787140da99e9c122] Merge branch 'pci/p2pdma'
git bisect good 0bb65e32495e6235a069b60e787140da99e9c122
# good: [ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd] PCI: Use pbus_select_window_for_type() during IO window sizing
git bisect good ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd
# good: [15c5867b0ae6a47914b45daf3b64e2d2aceb4ee5] PCI: Don't print stale information about resource
git bisect good 15c5867b0ae6a47914b45daf3b64e2d2aceb4ee5
# good: [dc32e9346b26ba33e84ec3034a1e53a9733700f9] PCI/pwrctrl: Fix device leak at device stop
git bisect good dc32e9346b26ba33e84ec3034a1e53a9733700f9
# good: [4c5cd8d64172de3730056366dc61392a3f2f003a] Merge branch 'pci/pm'
git bisect good 4c5cd8d64172de3730056366dc61392a3f2f003a
# bad: [a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd] PCI: Set up bridge resources earlier
git bisect bad a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd
# first bad commit: [a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd] PCI: Set up bridge resources earlier

Reverting the offending patch fixes the problem.

Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

========================================

arm
---

arm:quanta-q71l-bmc:aspeed_g4_defconfig:mtd32:net=nic:aspeed-bmc-quanta-q71l:ext2
arm:palmetto-bmc:aspeed_g4_defconfig:mtd32:net=nic:aspeed-bmc-opp-palmetto:ext2

The above problems are due to commit d6ace46c82fd ("ext4: remove obsolete EXT3
config options") and are resolved by explicitly enabling EXT4_FS. More on that
below.

arm:fuji-bmc:aspeed_g5_defconfig:net=nic:aspeed-bmc-facebook-fuji:initrd
arm:fuji-bmc:aspeed_g5_defconfig:sd2:net=nic:aspeed-bmc-facebook-fuji:ext2
arm:fuji-bmc:aspeed_g5_defconfig:usb1:net=nic:aspeed-bmc-facebook-fuji:ext2
arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128:net=nic:aspeed-bmc-facebook-fuji:ext2
arm:fuji-bmc:aspeed_g5_defconfig:mem1G:mtd128,0,8,1:net=nic:aspeed-bmc-facebook-fuji:f2fs

Bisect log:

# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# bad: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [a8253f807760e9c80eada9e5354e1240ccf325f9] Merge tag 'soc-newsoc-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good a8253f807760e9c80eada9e5354e1240ccf325f9
# bad: [e1b1d03ceec343362524318c076b110066ffe305] Merge tag 'for-6.18/block-20250929' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
git bisect bad e1b1d03ceec343362524318c076b110066ffe305
# bad: [57cff2159b4a067097fb7aef471f1f9db54244d9] Merge tag 'ti-k3-dt-for-v6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
git bisect bad 57cff2159b4a067097fb7aef471f1f9db54244d9
# bad: [a3ef7cad8b533ae82b1c86917defe280750a509e] Merge tag 'qcom-arm64-for-6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
git bisect bad a3ef7cad8b533ae82b1c86917defe280750a509e
# bad: [4c4457342a12d7b971481de9cbf11b3ed4774b80] Merge tag 'lpc32xx-dt-for-6.18' of https://github.com/vzapolskiy/linux-lpc32xx into soc/dt
git bisect bad 4c4457342a12d7b971481de9cbf11b3ed4774b80
# bad: [46cb19e52ac79d184e1b159ccbb2153dff1aab26] Merge tag 'v6.18-rockchip-dts64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
git bisect bad 46cb19e52ac79d184e1b159ccbb2153dff1aab26
# bad: [4e501327bf68883e96a056abb71f9256e205b709] Merge tag 'renesas-dts-for-v6.18-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
git bisect bad 4e501327bf68883e96a056abb71f9256e205b709
# bad: [921e41c4465ebc1b658f1d883e8fa9e2bd09dfbe] Merge tag 'nuvoton-arm-6.18-devicetree-0' of https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux into soc/dt
git bisect bad 921e41c4465ebc1b658f1d883e8fa9e2bd09dfbe
# bad: [608e2990e67c0e367cc87a86301f2e57b9fffc7e] ARM: dts: aspeed: Add missing "ibm,spi-fsi" compatibles
git bisect bad 608e2990e67c0e367cc87a86301f2e57b9fffc7e
# good: [83656699ba3ab61a86b83daf4579cb5598d68c55] dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
git bisect good 83656699ba3ab61a86b83daf4579cb5598d68c55
# bad: [b0f294fdfc3e472839a9bc0dc91f2322e27e38ef] ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
git bisect bad b0f294fdfc3e472839a9bc0dc91f2322e27e38ef
# good: [fe0e2fbb6a7801883df3567b1e89b834c0969998] ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
git bisect good fe0e2fbb6a7801883df3567b1e89b834c0969998
# good: [1bc26258369e020d27ef11d1efd7ff82b0a9192f] ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
git bisect good 1bc26258369e020d27ef11d1efd7ff82b0a9192f
# first bad commit: [b0f294fdfc3e472839a9bc0dc91f2322e27e38ef] ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts

The "first bad" commit disables the Ethernet interface on bmc-facebook-fuji.
According to the patch author this was done on purpose, leaving the system
without enabled Ethernet interface. I'll stop testing it.

Author: Tao Ren <rentao.bupt@gmail.com>

========================================

mips
----

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

Bisect log:

# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect good bed0653fe2aacb0ca8196075cffc9e7062e74927
# good: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good 6a74422b9710e987c7d6b85a1ade7330b1e61626
# bad: [522ba450b56fff29f868b1552bdc2965f55de7ed] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad 522ba450b56fff29f868b1552bdc2965f55de7ed
# bad: [256e3417065b2721f77bcd37331796b59483ef3b] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 256e3417065b2721f77bcd37331796b59483ef3b
# bad: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect bad 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
# bad: [531abff0fa53bc3a2f7f69b2693386eb6bda96e5] Merge branch 'pci/controller/qcom'
git bisect bad 531abff0fa53bc3a2f7f69b2693386eb6bda96e5
# bad: [fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3] Merge branch 'pci/resource'
git bisect bad fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3
# good: [0bb65e32495e6235a069b60e787140da99e9c122] Merge branch 'pci/p2pdma'
git bisect good 0bb65e32495e6235a069b60e787140da99e9c122
# bad: [ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd] PCI: Use pbus_select_window_for_type() during IO window sizing
git bisect bad ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd
# bad: [2ee33aa14d3f2e92ba8ae80443f2cd9b575f08cb] PCI: Always claim bridge window before its setup
git bisect bad 2ee33aa14d3f2e92ba8ae80443f2cd9b575f08cb
# good: [2657a0c982239fecc41d0df5a69091ca4297647c] m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
git bisect good 2657a0c982239fecc41d0df5a69091ca4297647c
# bad: [ae81aad5c2e17fd1fafd930e75b81aedc837f705] MIPS: PCI: Use pci_enable_resources()
git bisect bad ae81aad5c2e17fd1fafd930e75b81aedc837f705
# good: [754babaaf33349d9ef27bb1ac6f5d9d5a503a2a6] sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
git bisect good 754babaaf33349d9ef27bb1ac6f5d9d5a503a2a6
# first bad commit: [ae81aad5c2e17fd1fafd930e75b81aedc837f705] MIPS: PCI: Use pci_enable_resources()

Reverting the offending patch fixes the problem.

Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

========================================

parisc
------

parisc:B160L:net=virtio-net:nvme:ext4
parisc:B160L:net=usb-ohci:sata-cmd646:btrfs
parisc:B160L:net=rtl8139:scsi[DC395]:ext4
parisc:C3700:net=pcnet:usb-xhci:ext4
parisc:C3700:net=usb-ohci:usb-uas-ehci:btrfs
parisc:C3700:net=rtl8139:usb-uas-xhci:f2fs

Bisect log:

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
# bad: [b3fee71e6673393d04476fbe0f4f03f97765e32d] Merge tag 'v6.18rc1-part1-ksmbd-server-fixes' of git://git.samba.org/ksmbd
git bisect bad b3fee71e6673393d04476fbe0f4f03f97765e32d
# good: [829745b75a1af25bfb0c7dc36640548c98c57169] Merge tag 'pull-finish_no_open' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 829745b75a1af25bfb0c7dc36640548c98c57169
# bad: [65989db7f88456273d0913d8d21f6097fa6aad19] Merge tag 'ext4_for_linus-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect bad 65989db7f88456273d0913d8d21f6097fa6aad19
# good: [6238729bfce13f94b701766996a5d116d2df8bff] Merge tag 'fuse-update-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
git bisect good 6238729bfce13f94b701766996a5d116d2df8bff
# bad: [12c84dd4d308551568d85203fd6ed2685e861fda] ext4: add support for 32-bit default reserved uid and gid values
git bisect bad 12c84dd4d308551568d85203fd6ed2685e861fda
# bad: [46e75c56dfeafb6756773b71cabe187a6886859a] ext4: increase IO priority of fastcommit
git bisect bad 46e75c56dfeafb6756773b71cabe187a6886859a
# good: [d8b90e6387a74bcb1714c8d1e6a782ff709de9a9] ext4: add ext4_sb_bread_nofail() helper function for ext4_free_branches()
git bisect good d8b90e6387a74bcb1714c8d1e6a782ff709de9a9
# good: [0f3b05c12158ec7545fb336469ccce38c31c7f9f] jbd2: increase IO priority of checkpoint
git bisect good 0f3b05c12158ec7545fb336469ccce38c31c7f9f
# bad: [d6ace46c82fd2d3bdb58c35e3dd5cb9e83e136bf] ext4: remove obsolete EXT3 config options
git bisect bad d6ace46c82fd2d3bdb58c35e3dd5cb9e83e136bf
# first bad commit: [d6ace46c82fd2d3bdb58c35e3dd5cb9e83e136bf] ext4: remove obsolete EXT3 config options

"config EXT3_FS" was removed, but lots of config files still set it. Since
EXT3_FS used to select EXT4_FS, that is now disabled on all configurations
which used to set EXT3_FS.

I'll set EXT4_FS in my tests explicitly, so I won't see or report this
anymore, but others may be affected.

Update: Theodore Ts'o <tytso@mit.edu> already submitted a fix, so
hopefully this will be fixed in -rc2.

Author: Lukas Bulwahn <lukas.bulwahn@redhat.com>

========================================

sheb
----

sheb:rts7751r2dplus_defconfig:initrd
sheb:rts7751r2dplus_defconfig:ata:ext2
sheb:rts7751r2dplus_defconfig:usb:ext2

No console output. Bisect log:

# bad: [ba9dac987319d4f3969691dcf366ef19c9ed8281] Merge tag 'libnvdimm-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# bad: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 8804d970fab45726b3c7cd7f240b31122aa94219
# good: [30c3055f9c0d84a67b8fd723bdec9b1b52b3c695] xsk: wrap generic metadata handling onto separate function
git bisect good 30c3055f9c0d84a67b8fd723bdec9b1b52b3c695
# good: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag 'media/v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good f79e772258df311c2cb21594ca0996318e720d28
# good: [f1455695d2d99894b65db233877acac9a0e120b9] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good f1455695d2d99894b65db233877acac9a0e120b9
# good: [a16c46c2402026162111ed9fd1fc28d25223443e] dma-remap: drop nth_page() in dma_common_contiguous_remap()
git bisect good a16c46c2402026162111ed9fd1fc28d25223443e
# good: [a5883fa94295f1ef2473eadd84cc1e24dab9ae18] selftests/mm: gup_tests: option to GUP all pages in a single call
git bisect good a5883fa94295f1ef2473eadd84cc1e24dab9ae18
# good: [08498be43ee676d8a5eefb22278266322578a3e0] mm/ksm: get mm_slot by mm_slot_entry() when slot is !NULL
git bisect good 08498be43ee676d8a5eefb22278266322578a3e0
# good: [719a42e563bb087758500e43e67a57b27f303c4c] maple_tree: Convert forking to use the sheaf interface
git bisect good 719a42e563bb087758500e43e67a57b27f303c4c
# good: [b9120619246d733a27e5e93c29e86f2e0401cfc5] Merge series "SLUB percpu sheaves"
git bisect good b9120619246d733a27e5e93c29e86f2e0401cfc5
# bad: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect bad 24d9e8b3c9c8a6f72c8b4c196a703e144928d919
# good: [83382af9ddc3cb0ef43f67d049b461720ad785e6] slab: Make slub local_(try)lock more precise for LOCKDEP
git bisect good 83382af9ddc3cb0ef43f67d049b461720ad785e6
# good: [af92793e52c3a99b828ed4bdd277fd3e11c18d08] slab: Introduce kmalloc_nolock() and kfree_nolock().
git bisect good af92793e52c3a99b828ed4bdd277fd3e11c18d08
# good: [ca74b8cadaad4b179f77f1f4dc3d288be9a580f1] Merge series "slab: Re-entrant kmalloc_nolock()"
git bisect good ca74b8cadaad4b179f77f1f4dc3d288be9a580f1
# good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good 07fdad3a93756b872da7b53647715c48d0f4a2d0
# first bad commit: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab

Not yet analyzed.

