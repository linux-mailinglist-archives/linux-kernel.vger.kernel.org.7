Return-Path: <linux-kernel+bounces-871602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD83C0DB75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F031898EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16303255248;
	Mon, 27 Oct 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqHOB+Mi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F30246BB2;
	Mon, 27 Oct 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569700; cv=none; b=quDOwU3p0eR7mVs7uGHcbvUhe9sfbcy5JGXWOS3LchtBmoZAlUVgZoLrQt1zYfV1iXQ+hh7tuPt3uiENv+Wc2qUoDlhud1f+yWW60QTcswmE+W5sdsEdz9jyf77ZhruxNAKHALJlUWNgSTQZCFuTyrwYxJUM2/yHICY36Gl6ZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569700; c=relaxed/simple;
	bh=Zo3WzSvN0e3ILn9HzIXd8XWmjxIogwS7WwLULDxDHsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbGT3UAjZ3uHvpI+qV0x9z7QE0aCTxJlqHF+zAMDikVrvQqyMuu0cxiiW8u7vQKSIeqDhD/4ikRvKZRu4vMINKZe2aR4aH4gbgOi9O/QAct+fbBXsYwZTjKOJiFGcSbxtvVnJb86Wck7+yvjPUCbY1LnE537ATDCB3xURhAsddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UqHOB+Mi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1/pRdP1OS0w6bkRPnJhijcyXdYtZEIPUwdPKV+esprE=; b=UqHOB+MiMuBkxJANZU/HyRKI1n
	8crzelEU+yzNOd7HGbPK7ZEcIeUI0Hs2AZjtW6MBLaFwp2VEw4LWuBHK24FkZyZaN9GRvB34QeBpq
	NIKTrwa1rwykvbj9tlqgBH8unTFCIZYbzUtiWAsnMZuLaWcWd1JG6iS9+GtjZw4iSGV/yGtq9q7DQ
	gFHsC2lwArZ74tnNw0+D396/1tNaWczlzBaHcnN3XvF2uIH5JrdeJbW5egTqTESEl/GSv1VF0uF+5
	EC3LDeqBAvLcS74Y9lpP/1ZtaBwZgfUt9Z+EtzD/MR+S9LosNuwHVvgAW48Es1gCzmnNGaa2SW5c2
	+RXiETsA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLsg-000000026fn-20JA;
	Mon, 27 Oct 2025 11:59:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA89C30049D; Mon, 27 Oct 2025 13:54:53 +0100 (CET)
Date: Mon, 27 Oct 2025 13:54:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched/fair]  79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251021110449.GO3245006@noisy.programming.kicks-ass.net>

On Tue, Oct 21, 2025 at 01:04:49PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 21, 2025 at 01:14:36PM +0800, kernel test robot wrote:
> >=20
> >=20
> > Hello,
> >=20
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address"=
 on:
> >=20
> > commit: 79104becf42baeeb4a3f2b106f954b9fc7c10a3c ("sched/fair: Forfeit =
vruntime on yield")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> >=20
> > [test failed on linux-next/master 606da5bb165594c052ee11de79bf05bc38bc1=
aa6]
> >=20
> > in testcase: trinity
> > version:=20
> > with following parameters:
> >=20
> > 	runtime: 300s
> > 	group: group-04
> > 	nr_groups: 5
> >=20
> >=20
> >=20
> > config: x86_64-randconfig-121-20251020
> > compiler: gcc-13
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >=20
>=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-=
lkp@intel.com
>=20
>=20
> I'm failing at running the kernel as described in:
>=20
>   https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-=
lkp@intel.com/reproduce
>=20
>=20
> I then start the test as:
>=20
> root@spr:/usr/local/src/lkp-tests# bin/lkp qemu -k /usr/src/linux-2.6/tmp=
-build/arch/x86/boot/bzImage -m /usr/src/linux-2.6/tmp-build/modules.cgz /u=
sr/src/linux-2.6/tmp-build/job-script
> result_root: /root/.lkp//result/trinity/group-04-5-300s/vm-snb/quantal-i3=
86-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/79104becf42baeeb=
4a3f2b106f954b9fc7c10a3c/4
> downloading initrds ...
> use local modules: /root/.lkp/cache/modules.cgz
> skip downloading /root/.lkp/cache/osimage/quantal/quantal-i386-core-20190=
426.cgz
> 153636 blocks
> skip downloading /root/.lkp/cache/osimage/pkg/quantal-i386-core.cgz/trini=
ty-static-i386-x86_64-f93256fb_2019-08-28.cgz
> 48101 blocks
> exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev loca=
l,id=3Dtest_dev,path=3D/root/.lkp//result/trinity/group-04-5-300s/vm-snb/qu=
antal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/79104bec=
f42baeeb4a3f2b106f954b9fc7c10a3c/4,security_model=3Dnone -device virtio-9p-=
pci,fsdev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel /usr/src/linux-2.6=
/tmp-build/arch/x86/boot/bzImage -append root=3D/dev/ram0 RESULT_ROOT=3D/re=
sult/trinity/group-04-5-300s/vm-snb/quantal-i386-core-20190426.cgz/x86_64-r=
andconfig-121-20251020/gcc-13/79104becf42baeeb4a3f2b106f954b9fc7c10a3c/1 BO=
OT_IMAGE=3D/pkg/linux/x86_64-randconfig-121-20251020/gcc-13/79104becf42baee=
b4a3f2b106f954b9fc7c10a3c/vmlinuz-6.18.0-rc1-00001-g79104becf42b branch=3Dl=
inux-devel/devel-hourly-20251019-154855 job=3D/lkp/jobs/scheduled/vm-meta-2=
91/trinity-group-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig=
-121-20251020-79104becf42b-20251020-124904-8548hu-1.yaml user=3Dlkp ARCH=3D=
x86_64 kconfig=3Dx86_64-randconfig-121-20251020 commit=3D79104becf42baeeb4a=
3f2b106f954b9fc7c10a3c intremap=3Dposted_msi vmalloc=3D256M initramfs_async=
=3D0 page_owner=3Don carrier_timeout=3D60 rcupdate.rcu_self_test=3D0 max_up=
time=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_e=
nabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=
=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic loa=
d_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3De=
rr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS=
0,115200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount -initr=
d /root/.lkp/cache/final_initrd -smp 2 -m 16384M -no-reboot -device i6300es=
b -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0 =
-display none -monitor null -serial stdio

> [    5.650807][    T1] Starting init: /bin/sh exists but couldn't execute=
 it (error -8)
> [    5.651481][    T1] Kernel panic - not syncing: No working init found.=
  Try passing init=3D option to kernel. See Linux Documentation/admin-guide=
/init.rst for guidance.
> [    5.652784][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6=
=2E18.0-rc2-00182-gbab99e58f91f #35 PREEMPT=20
> [    5.653668][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    5.654582][    T1] Call Trace:
> [    5.654873][    T1]  <TASK>
> [    5.655137][    T1]  dump_stack_lvl+0x3a/0x70
> [    5.655536][    T1]  dump_stack+0x10/0x20
> [    5.655911][    T1]  vpanic+0x104/0x2c0
> [    5.656256][    T1]  ? rest_init+0x140/0x140
> [    5.656652][    T1]  panic+0x51/0x60
> [    5.656989][    T1]  kernel_init+0x111/0x120
> [    5.657360][    T1]  ret_from_fork+0x25/0x140
> [    5.657741][    T1]  ? rest_init+0x140/0x140
> [    5.658130][    T1]  ret_from_fork_asm+0x11/0x20
> [    5.658563][    T1]  </TASK>
> [    5.658841][    T1] Kernel Offset: disabled
>=20

Any clues how I can get this thing to actually run the trinity required
to reproduce instead of panic?

