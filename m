Return-Path: <linux-kernel+bounces-871744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60679C0E3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5AB74F8DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3353074BA;
	Mon, 27 Oct 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCsE5OHu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F92F6930;
	Mon, 27 Oct 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573326; cv=none; b=JA3PZzg5P9Uvzx3l4KNr/rPSwYcPKNcD9sHqLQjZEmuYxGi6PTfcFMfGQEUNvXNw57QYJAEu6uBpej1Cxqx2Y+vHOivHGVB29BHi9RFMXvaJptE2bAgQFKkRGzwxCU1JyPqik1U+LOSvkYufwUFNu0i5AUuLGxea2cpw84D2NQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573326; c=relaxed/simple;
	bh=uNuzt4sI/7gSdeF5rBBeurWIt2USb8zRgOBcfzdnqlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyDphW5a3AW6miKHTVChYyQGJmQR9MWJ1s51E9IZhGzKGfenojNhzkG9aj8NMIehnOlOrMfMwhdYVds8UxIj34RcCM0wRTHefPYKM4kmLROBykXKVRbL9vTNWWUZwP1w3ZQbPOlKiJndBGJ8pxo0UEDVawUgBlOay2/zhVCq7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UCsE5OHu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tuoWsyF3k1rY8bEizWOFF+gtTs3L1nUIJSu8iXvHcU0=; b=UCsE5OHuW8VHFHm+JtpNwsPfJI
	SiIAJrGn0cfe2m5odPe6obJcHHbpw9DBgdByWExvnn+OTpBXjKH4VBEYPDyNJcMpbMSLE13vu4a7K
	RncbJ2kJV1xGCtfxnnrtwiLT44LCH6WmzhvD3pJP88TGoPMeRsDOY2OP6g0J1hPtl5BAmwHXEa7Nf
	gcmu+1YVACqM11RV6LINJnsuAPKG3I6JXHIRwoShytEmqPQW7Fn56bXM4i2G4WOIP7/DO3/ja7eZD
	odDdxHxxNwpIFFAtFftJHRV3cwTTFZkhqSkokGFSIFECicE5zYAGhz7saR9qHC/XU9LD5mm/hVQE6
	wAYTfDGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDMp7-00000002Ejz-2h2b;
	Mon, 27 Oct 2025 12:59:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 928F2300323; Mon, 27 Oct 2025 14:55:16 +0100 (CET)
Date: Mon, 27 Oct 2025 14:55:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>

On Mon, Oct 27, 2025 at 09:14:11PM +0800, Chen, Yu C wrote:
> On 10/27/2025 8:54 PM, Peter Zijlstra wrote:
> > On Tue, Oct 21, 2025 at 01:04:49PM +0200, Peter Zijlstra wrote:
> > > On Tue, Oct 21, 2025 at 01:14:36PM +0800, kernel test robot wrote:
> > > >=20
> > > >=20
> > > > Hello,
> > > >=20
> > > > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,addr=
ess" on:
> > > >=20
> > > > commit: 79104becf42baeeb4a3f2b106f954b9fc7c10a3c ("sched/fair: Forf=
eit vruntime on yield")
> > > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> > > >=20
> > > > [test failed on linux-next/master 606da5bb165594c052ee11de79bf05bc3=
8bc1aa6]
> > > >=20
> > > > in testcase: trinity
> > > > version:
> > > > with following parameters:
> > > >=20
> > > > 	runtime: 300s
> > > > 	group: group-04
> > > > 	nr_groups: 5
> > > >=20
> > > >=20
> > > >=20
> > > > config: x86_64-randconfig-121-20251020
> > > > compiler: gcc-13
> > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp =
2 -m 16G
> > > >=20
> > >=20
> > > > The kernel config and materials to reproduce are available at:
> > > > https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5=
223-lkp@intel.com
> > >=20
> > >=20
> > > I'm failing at running the kernel as described in:
> > >=20
> > >    https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f=
5223-lkp@intel.com/reproduce
> > >=20
> > >=20
> > > I then start the test as:
> > >=20
> > > root@spr:/usr/local/src/lkp-tests# bin/lkp qemu -k /usr/src/linux-2.6=
/tmp-build/arch/x86/boot/bzImage -m /usr/src/linux-2.6/tmp-build/modules.cg=
z /usr/src/linux-2.6/tmp-build/job-script
> > > result_root: /root/.lkp//result/trinity/group-04-5-300s/vm-snb/quanta=
l-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/79104becf42b=
aeeb4a3f2b106f954b9fc7c10a3c/4
> > > downloading initrds ...
> > > use local modules: /root/.lkp/cache/modules.cgz
> > > skip downloading /root/.lkp/cache/osimage/quantal/quantal-i386-core-2=
0190426.cgz
> > > 153636 blocks
> > > skip downloading /root/.lkp/cache/osimage/pkg/quantal-i386-core.cgz/t=
rinity-static-i386-x86_64-f93256fb_2019-08-28.cgz
> > > 48101 blocks
> > > exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev =
local,id=3Dtest_dev,path=3D/root/.lkp//result/trinity/group-04-5-300s/vm-sn=
b/quantal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/7910=
4becf42baeeb4a3f2b106f954b9fc7c10a3c/4,security_model=3Dnone -device virtio=
-9p-pci,fsdev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel /usr/src/linux=
-2.6/tmp-build/arch/x86/boot/bzImage -append root=3D/dev/ram0 RESULT_ROOT=
=3D/result/trinity/group-04-5-300s/vm-snb/quantal-i386-core-20190426.cgz/x8=
6_64-randconfig-121-20251020/gcc-13/79104becf42baeeb4a3f2b106f954b9fc7c10a3=
c/1 BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-121-20251020/gcc-13/79104becf=
42baeeb4a3f2b106f954b9fc7c10a3c/vmlinuz-6.18.0-rc1-00001-g79104becf42b bran=
ch=3Dlinux-devel/devel-hourly-20251019-154855 job=3D/lkp/jobs/scheduled/vm-=
meta-291/trinity-group-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-rand=
config-121-20251020-79104becf42b-20251020-124904-8548hu-1.yaml user=3Dlkp A=
RCH=3Dx86_64 kconfig=3Dx86_64-randconfig-121-20251020 commit=3D79104becf42b=
aeeb4a3f2b106f954b9fc7c10a3c intremap=3Dposted_msi vmalloc=3D256M initramfs=
_async=3D0 page_owner=3Don carrier_timeout=3D60 rcupdate.rcu_self_test=3D0 =
max_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_al=
ways_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.de=
vkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpani=
c load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_leve=
l=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=
=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount=
 -initrd /root/.lkp/cache/final_initrd -smp 2 -m 16384M -no-reboot -device =
i6300esb -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=
=3Dnet0 -display none -monitor null -serial stdio
> >=20
> > > [    5.650807][    T1] Starting init: /bin/sh exists but couldn't exe=
cute it (error -8)
>=20
> May I know if you are using the kernel config 0day attached?
> I found that the config 0day attached
> (https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-l=
kp@intel.com/config-6.18.0-rc1-00001-g79104becf42b)
> has
> CONFIG_IA32_EMULATION=3Dy
> CONFIG_IA32_EMULATION_DEFAULT_DISABLED=3Dy
> CONFIG_COMPAT_32=3Dy
> CONFIG_COMPAT=3Dy
>=20
> It is suspected that the filesystem provided by lkp is 32bits, might
> need Oliver's confirm.

It was certainly meant to be that config -- let be double check that.

