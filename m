Return-Path: <linux-kernel+bounces-863448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC89BF7DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B434819C5031
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD0353AC4;
	Tue, 21 Oct 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MOaQ/3qd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAE34D4F2;
	Tue, 21 Oct 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067151; cv=none; b=Hctj6yj41MT0fRsxNRv+u6uc0WicWkW9R5ukF5zuJm/0d6g3isWg5gHgwgt+NFv2oAWziue/R6DPRJlkMandKXrQvCwKB8gnExm73HgRXjweRSocWpauiD6HVrtfijh/pOFgz0C9T9jsYVw/mW8Sazs4nzugJjUHAlSVGVOJZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067151; c=relaxed/simple;
	bh=Yd9yi6LTJyZ6mLTv/a9rxmxTW1f2EfOigSssZflsK4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiTAwODD9b/lOF72IAfpj3JoWhl9PO1WD5KKXh/1oE55avUPo8693yXfsBHABAFo8QMMBMWl6Rou3nTlXH2sb2XM4wtsVwgJB+f76QDYR1uANde1GwLDpshKo/nMewl88RDCN7rNaRMaHOKDgy8lGQdxtxXA7MD7W0t3GtlCbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MOaQ/3qd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SYMuY83eK9wWsss6zwvtSbGD7+iFFp7WhpACLrAHkpQ=; b=MOaQ/3qdCsX2xs4upJx/vFuNTU
	Uc4x9g5svJcgdmxsGBshHkN6ryCAD2FV6kTGbH997ArfYheWOEZvk0cB5tYFIOE6LhIDOD400umGR
	ZdLqKoFHfHwrXjxtIhjrSvqieVBCWjnTnJT/syHJu9Zhs2ijWFvIS8b76mB3brTqAbLJ8UKcRREG7
	yXg+rFAcsSTyfvD52hX2fy/e5Q+wuji3DYkCf/qLUNTeyDsfLP5tAu4whN9MRkVUonGoUBBHcCbNI
	FD7tbK+iGVKaDfeGPSQQVB+jeQQ1+HcvZJRnhaglKA19Ljak/6+cqb5g20w8cDE3QerxYYLXOzY+D
	lK4Cd1MA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBF8x-00000000tCA-2jTR;
	Tue, 21 Oct 2025 16:23:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E075303175; Tue, 21 Oct 2025 13:04:49 +0200 (CEST)
Date: Tue, 21 Oct 2025 13:04:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched/fair]  79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
References: <202510211205.1e0f5223-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202510211205.1e0f5223-lkp@intel.com>

On Tue, Oct 21, 2025 at 01:14:36PM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" o=
n:
>=20
> commit: 79104becf42baeeb4a3f2b106f954b9fc7c10a3c ("sched/fair: Forfeit vr=
untime on yield")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
>=20
> [test failed on linux-next/master 606da5bb165594c052ee11de79bf05bc38bc1aa=
6]
>=20
> in testcase: trinity
> version:=20
> with following parameters:
>=20
> 	runtime: 300s
> 	group: group-04
> 	nr_groups: 5
>=20
>=20
>=20
> config: x86_64-randconfig-121-20251020
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>=20

> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lk=
p@intel.com


I'm failing at running the kernel as described in:

  https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lk=
p@intel.com/reproduce


I then start the test as:

root@spr:/usr/local/src/lkp-tests# bin/lkp qemu -k /usr/src/linux-2.6/tmp-b=
uild/arch/x86/boot/bzImage -m /usr/src/linux-2.6/tmp-build/modules.cgz /usr=
/src/linux-2.6/tmp-build/job-script
result_root: /root/.lkp//result/trinity/group-04-5-300s/vm-snb/quantal-i386=
-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/79104becf42baeeb4a=
3f2b106f954b9fc7c10a3c/4
downloading initrds ...
use local modules: /root/.lkp/cache/modules.cgz
skip downloading /root/.lkp/cache/osimage/quantal/quantal-i386-core-2019042=
6.cgz
153636 blocks
skip downloading /root/.lkp/cache/osimage/pkg/quantal-i386-core.cgz/trinity=
-static-i386-x86_64-f93256fb_2019-08-28.cgz
48101 blocks
exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev local,=
id=3Dtest_dev,path=3D/root/.lkp//result/trinity/group-04-5-300s/vm-snb/quan=
tal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/79104becf4=
2baeeb4a3f2b106f954b9fc7c10a3c/4,security_model=3Dnone -device virtio-9p-pc=
i,fsdev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel /usr/src/linux-2.6/t=
mp-build/arch/x86/boot/bzImage -append root=3D/dev/ram0 RESULT_ROOT=3D/resu=
lt/trinity/group-04-5-300s/vm-snb/quantal-i386-core-20190426.cgz/x86_64-ran=
dconfig-121-20251020/gcc-13/79104becf42baeeb4a3f2b106f954b9fc7c10a3c/1 BOOT=
_IMAGE=3D/pkg/linux/x86_64-randconfig-121-20251020/gcc-13/79104becf42baeeb4=
a3f2b106f954b9fc7c10a3c/vmlinuz-6.18.0-rc1-00001-g79104becf42b branch=3Dlin=
ux-devel/devel-hourly-20251019-154855 job=3D/lkp/jobs/scheduled/vm-meta-291=
/trinity-group-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig-1=
21-20251020-79104becf42b-20251020-124904-8548hu-1.yaml user=3Dlkp ARCH=3Dx8=
6_64 kconfig=3Dx86_64-randconfig-121-20251020 commit=3D79104becf42baeeb4a3f=
2b106f954b9fc7c10a3c intremap=3Dposted_msi vmalloc=3D256M initramfs_async=
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
early console in setup code=0D
No EFI environment detected.=0D
early console in extract_kernel=0D
input_data: 0x00000000046022cc=0D
input_len: 0x0000000000ecebe2=0D
output: 0x0000000001000000=0D
output_len: 0x000000000446b5e8=0D
kernel_total_size: 0x0000000003c28000=0D
needed_size: 0x0000000004600000=0D
trampoline_32bit: 0x0000000000000000=0D
=0D
Decompressing Linux... No EFI environment detected.=0D
Parsing ELF... done.=0D
Booting the kernel (entry_offset: 0x000000000296dbe0).=0D
[    0.000000][    T0] Linux version 6.18.0-rc2-00182-gbab99e58f91f (root@s=
pr) (gcc (Debian 14.2.0-23) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) =
#35 PREEMPT Tue Oct 21 13:00:08 CEST 2025=0D
[    0.000000][    T0] Command line: root=3D/dev/ram0 RESULT_ROOT=3D/result=
/trinity/group-04-5-300s/vm-snb/quantal-i386-core-20190426.cgz/x86_64-randc=
onfig-121-20251020/gcc-13/79104becf42baeeb4a3f2b106f954b9fc7c10a3c/1 BOOT_I=
MAGE=3D/pkg/linux/x86_64-randconfig-121-20251020/gcc-13/79104becf42baeeb4a3=
f2b106f954b9fc7c10a3c/vmlinuz-6.18.0-rc1-00001-g79104becf42b branch=3Dlinux=
-devel/devel-hourly-20251019-154855 job=3D/lkp/jobs/scheduled/vm-meta-291/t=
rinity-group-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig-121=
-20251020-79104becf42b-20251020-124904-8548hu-1.yaml user=3Dlkp ARCH=3Dx86_=
64 kconfig=3Dx86_64-randconfig-121-20251020 commit=3D79104becf42baeeb4a3f2b=
106f954b9fc7c10a3c intremap=3Dposted_msi vmalloc=3D256M initramfs_async=3D0=
 page_owner=3Don carrier_timeout=3D60 rcupdate.rcu_self_test=3D0 max_uptime=
=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_enabl=
ed rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don=
 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ram=
disk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 sys=0D
[    0.000000][    T0] KERNEL supported cpus:=0D
[    0.000000][    T0]   AMD AuthenticAMD=0D
[    0.000000][    T0]   Hygon HygonGenuine=0D
[    0.000000][    T0]   Centaur CentaurHauls=0D
[    0.000000][    T0] CPU: vendor_id 'GenuineIntel' unknown, using generic=
 init.=0D
[    0.000000][    T0] CPU: Your system may be unstable.=0D
[    0.000000][    T0] mce: unknown CPU type - not enabling MCE support=0D
[    0.000000][    T0] BIOS-provided physical RAM map:=0D
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f] usable=0D
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdfff=
f] usable=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bffffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000fefffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000fffffff=
f] reserved=0D
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000043ffffff=
f] usable=0D
[    0.000000][    T0] printk: debug: ignoring loglevel setting.=0D
[    0.000000][    T0] printk: legacy bootconsole [earlyser0] enabled=0D
[    0.000000][    T0] NX (Execute Disable) protection: active=0D
[    0.000000][    T0] APIC: Static calls initialized=0D
[    0.000000][    T0] SMBIOS 2.8 present.=0D
[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
16.3-debian-1.16.3-2 04/01/2014=0D
[    0.000000][    T0] DMI: Memory slots populated: 1/1=0D
[    0.000000][    T0] Hypervisor detected: KVM=0D
[    0.000000][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000=0D
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00=0D
[    0.000001][    T0] kvm-clock: using sched offset of 202642555 cycles=0D
[    0.000633][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns=0D
[    0.002517][    T0] tsc: Detected 2500.000 MHz processor=0D
[    0.003879][    T0] e820: update [mem 0x00000000-0x00000fff] usable =3D=
=3D> reserved=0D
[    0.004668][    T0] e820: remove [mem 0x000a0000-0x000fffff] usable=0D
[    0.005338][    T0] last_pfn =3D 0x440000 max_arch_pfn =3D 0x400000000=0D
[    0.005997][    T0] x86/PAT: PAT support disabled because CONFIG_X86_PAT=
 is disabled in the kernel.=0D
[    0.006958][    T0] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT=
  UC- UC  =0D
[    0.007765][    T0] last_pfn =3D 0xbffe0 max_arch_pfn =3D 0x400000000=0D
[    0.009691][    T0] RAMDISK: [mem 0xbd741000-0xbffdffff]=0D
[    0.010263][    T0] ACPI: Early table checksum verification disabled=0D
[    0.010942][    T0] ACPI: RSDP 0x00000000000F5280 000014 (v00 BOCHS )=0D
[    0.011634][    T0] ACPI: RSDT 0x00000000BFFE239C 000034 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.012617][    T0] ACPI: FACP 0x00000000BFFE2248 000074 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.013606][    T0] ACPI: DSDT 0x00000000BFFE0040 002208 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.014592][    T0] ACPI: FACS 0x00000000BFFE0000 000040=0D
[    0.015156][    T0] ACPI: APIC 0x00000000BFFE22BC 000080 (v03 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.016137][    T0] ACPI: HPET 0x00000000BFFE233C 000038 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.017119][    T0] ACPI: WAET 0x00000000BFFE2374 000028 (v01 BOCHS  BXP=
C     00000001 BXPC 00000001)=0D
[    0.018102][    T0] ACPI: Reserving FACP table memory at [mem 0xbffe2248=
-0xbffe22bb]=0D
[    0.018921][    T0] ACPI: Reserving DSDT table memory at [mem 0xbffe0040=
-0xbffe2247]=0D
[    0.019743][    T0] ACPI: Reserving FACS table memory at [mem 0xbffe0000=
-0xbffe003f]=0D
[    0.020558][    T0] ACPI: Reserving APIC table memory at [mem 0xbffe22bc=
-0xbffe233b]=0D
[    0.021384][    T0] ACPI: Reserving HPET table memory at [mem 0xbffe233c=
-0xbffe2373]=0D
[    0.022215][    T0] ACPI: Reserving WAET table memory at [mem 0xbffe2374=
-0xbffe239b]=0D
[    0.023064][    T0] Mapped APIC to ffffffffff5fd000 (        fee00000)=0D
[    0.023798][    T0] Zone ranges:=0D
[    0.024141][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]=0D
[    0.024881][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]=0D
[    0.025626][    T0]   Normal   [mem 0x0000000100000000-0x000000043ffffff=
f]=0D
[    0.026366][    T0] Movable zone start for each node=0D
[    0.026899][    T0] Early memory node ranges=0D
[    0.027357][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]=0D
[    0.028107][    T0]   node   0: [mem 0x0000000000100000-0x00000000bffdff=
ff]=0D
[    0.028856][    T0]   node   0: [mem 0x0000000100000000-0x000000043fffff=
ff]=0D
[    0.029612][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0043fffffff]=0D
[    0.030657][    T0] On node 0, zone DMA: 1 pages in unavailable ranges=0D
[    0.031391][    T0] On node 0, zone DMA: 97 pages in unavailable ranges=
=0D
[    0.082973][    T0] On node 0, zone Normal: 32 pages in unavailable rang=
es=0D
[    0.083995][    T0] ACPI: PM-Timer IO Port: 0x608=0D
[    0.084500][    T0] CPU topo: CPU limit of 1 reached. Ignoring further C=
PUs=0D
[    0.085233][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])=0D
[    0.085973][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23=0D
[    0.086794][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)=0D
[    0.087554][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID =
0, APIC INT 02=0D
[    0.088409][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)=0D
[    0.089195][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID =
0, APIC INT 05=0D
[    0.090053][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)=0D
[    0.090838][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID =
0, APIC INT 09=0D
[    0.091693][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)=0D
[    0.092499][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID =
0, APIC INT 0a=0D
[    0.093350][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)=0D
[    0.094168][    T0] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID =
0, APIC INT 0b=0D
[    0.095021][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID =
0, APIC INT 01=0D
[    0.095872][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID =
0, APIC INT 03=0D
[    0.096725][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID =
0, APIC INT 04=0D
[    0.097576][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID =
0, APIC INT 06=0D
[    0.098429][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID =
0, APIC INT 07=0D
[    0.099279][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID =
0, APIC INT 08=0D
[    0.100131][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID =
0, APIC INT 0c=0D
[    0.100982][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID =
0, APIC INT 0d=0D
[    0.101905][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID =
0, APIC INT 0e=0D
[    0.102765][    T0] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID =
0, APIC INT 0f=0D
[    0.103621][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation=0D
[    0.104392][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000=0D
[    0.105027][    T0] TSC deadline timer available=0D
[    0.105872][    T0] CPU topo: Max. logical packages:   1=0D
[    0.106441][    T0] CPU topo: Max. logical dies:       1=0D
[    0.107010][    T0] CPU topo: Max. dies per package:   1=0D
[    0.107580][    T0] CPU topo: Max. threads per core:   1=0D
[    0.108148][    T0] CPU topo: Num. cores per package:     1=0D
[    0.108744][    T0] CPU topo: Num. threads per package:   1=0D
[    0.109340][    T0] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPU=
s=0D
[    0.110078][    T0] CPU topo: Rejected CPUs 1=0D
[    0.110550][    T0] mapped IOAPIC to ffffffffff5fc000 (fec00000)=0D
[    0.111220][    T0] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_=
eoi_write()=0D
[    0.112073][    T0] [mem 0xc0000000-0xfeffbfff] available for PCI device=
s=0D
[    0.112818][    T0] Booting paravirtualized kernel on KVM=0D
[    0.113413][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 7645519600211568 ns=0D
[    0.114650][    T0] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768=0D
[    0.115320][    T0] pcpu-alloc: [0] 0 =0D
[    0.115739][    T0] Kernel command line: root=3D/dev/ram0 RESULT_ROOT=3D=
/result/trinity/group-04-5-300s/vm-snb/quantal-i386-core-20190426.cgz/x86_6=
4-randconfig-121-20251020/gcc-13/79104becf42baeeb4a3f2b106f954b9fc7c10a3c/1=
 BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-121-20251020/gcc-13/79104becf42b=
aeeb4a3f2b106f954b9fc7c10a3c/vmlinuz-6.18.0-rc1-00001-g79104becf42b branch=
=3Dlinux-devel/devel-hourly-20251019-154855 job=3D/lkp/jobs/scheduled/vm-me=
ta-291/trinity-group-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randco=
nfig-121-20251020-79104becf42b-20251020-124904-8548hu-1.yaml user=3Dlkp ARC=
H=3Dx86_64 kconfig=3Dx86_64-randconfig-121-20251020 commit=3D79104becf42bae=
eb4a3f2b106f954b9fc7c10a3c intremap=3Dposted_msi vmalloc=3D256M initramfs_a=
sync=3D0 page_owner=3Don carrier_timeout=3D60 rcupdate.rcu_self_test=3D0 ma=
x_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_alwa=
ys_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devk=
msg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic =
load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_coun=0D
[    0.115953][    T0] sysrq: sysrq always enabled.=0D
[    0.126476][    T0] ignoring the deprecated load_ramdisk=3D option=0D
[    0.127244][    T0] Unknown kernel command line parameters "RESULT_ROOT=
=3D/result/trinity/group-04-5-300s/vm-snb/quantal-i386-core-20190426.cgz/x8=
6_64-randconfig-121-20251020/gcc-13/79104becf42baeeb4a3f2b106f954b9fc7c10a3=
c/1 branch=3Dlinux-devel/devel-hourly-20251019-154855 job=3D/lkp/jobs/sched=
uled/vm-meta-291/trinity-group-04-5-300s-quantal-i386-core-20190426.cgz-x86=
_64-randconfig-121-20251020-79104becf42b-20251020-124904-8548hu-1.yaml user=
=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-121-20251020 commit=3D7910=
4becf42baeeb4a3f2b106f954b9fc7c10a3c intremap=3Dposted_msi vmalloc=3D256M m=
ax_uptime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 prompt_ramdisk=3D0 vga=3Dnor=
mal result_service=3D9p/virtfs_mount", will be passed to user space.=0D
[    0.134040][    T0] printk: log buffer data + meta data: 1048576 + 36700=
16 =3D 4718592 bytes=0D
[    0.136891][    T0] Dentry cache hash table entries: 2097152 (order: 12,=
 16777216 bytes, linear)=0D
[    0.138842][    T0] Inode-cache hash table entries: 1048576 (order: 11, =
8388608 bytes, linear)=0D
[    0.139832][    T0] software IO TLB: area num 1.=0D
[    0.151743][    T0] Built 1 zonelists, mobility grouping on.  Total page=
s: 4194174=0D
[    0.152570][    T0] mem auto-init: stack:off, heap alloc:on, heap free:o=
ff=0D
[    0.153300][    T0] stackdepot: allocating hash table via alloc_large_sy=
stem_hash=0D
[    0.154112][    T0] stackdepot hash table entries: 1048576 (order: 12, 1=
6777216 bytes, linear)=0D
[    0.157072][    T0] stackdepot: allocating space for 8192 stack pools vi=
a memblock=0D
[    0.609556][    T0] SLUB: HWalign=3D64, Order=3D0-1, MinObjects=3D0, CPU=
s=3D1, Nodes=3D1=0D
[    0.712011][    T0] allocated 335544320 bytes of page_ext=0D
[    0.712595][    T0] Node 0, zone      DMA: page owner found early alloca=
ted 0 pages=0D
[    0.713807][    T0] Node 0, zone    DMA32: page owner found early alloca=
ted 0 pages=0D
[    0.733725][    T0] Node 0, zone   Normal: page owner found early alloca=
ted 82012 pages=0D
[    0.734631][    T0] =0D
[    0.734854][    T0] ****************************************************=
******=0D
[    0.735604][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **=0D
[    0.736352][    T0] **                                                  =
    **=0D
[    0.737097][    T0] ** trace_printk() being used. Allocating extra memor=
y.  **=0D
[    0.737858][    T0] **                                                  =
    **=0D
[    0.738601][    T0] ** This means that this is a DEBUG kernel and it is =
    **=0D
[    0.739350][    T0] ** unsafe for production use.                       =
    **=0D
[    0.740100][    T0] **                                                  =
    **=0D
[    0.740844][    T0] ** If you see this message and you are not debugging=
    **=0D
[    0.741596][    T0] ** the kernel, report this immediately to your vendo=
r!  **=0D
[    0.742345][    T0] **                                                  =
    **=0D
[    0.743195][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **=0D
[    0.744148][    T0] ****************************************************=
******=0D
[    0.746086][    T0] Running RCU self tests=0D
[    0.746635][    T0] Running RCU synchronous self tests=0D
[    0.747311][    T0] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.748149][    T0] rcu: 	RCU event tracing is enabled.=0D
[    0.748869][    T0] rcu: 	RCU lockdep checking is enabled.=0D
[    0.749600][    T0] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_=
stall_timeout).=0D
[    0.750692][    T0] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.751440][    T0] 	Rude variant of Tasks RCU enabled.=0D
[    0.752135][    T0] 	Tracing variant of Tasks RCU enabled.=0D
[    0.752864][    T0] rcu: RCU calculated value of scheduler-enlistment de=
lay is 25 jiffies.=0D
[    0.753923][    T0] Running RCU synchronous self tests=0D
[    0.754484][    T0] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_=
cb_adjust=3D1 rcu_task_cpu_ids=3D1.=0D
[    0.755458][    T0] RCU Tasks Rude: Setting shift to 0 and lim to 1 rcu_=
task_cb_adjust=3D1 rcu_task_cpu_ids=3D1.=0D
[    0.756477][    T0] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu=
_task_cb_adjust=3D1 rcu_task_cpu_ids=3D1.=0D
[    0.762676][    T0] NR_IRQS: 4352, nr_irqs: 48, preallocated irqs: 16=0D
[    0.763593][    T0] rcu: srcu_init: Setting srcu_struct sizes based on c=
ontention.=0D
[    0.764491][    T0] printk: legacy console [ttyS0] enabled=0D
[    0.764491][    T0] printk: legacy console [ttyS0] enabled=0D
[    0.765654][    T0] printk: legacy bootconsole [earlyser0] disabled=0D
[    0.765654][    T0] printk: legacy bootconsole [earlyser0] disabled=0D
[    0.766985][    T0] Lock dependency validator: Copyright (c) 2006 Red Ha=
t, Inc., Ingo Molnar=0D
[    0.767885][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.768398][    T0] ... MAX_LOCK_DEPTH:          48=0D
[    0.768922][    T0] ... MAX_LOCKDEP_KEYS:        8192=0D
[    0.769467][    T0] ... CLASSHASH_SIZE:          4096=0D
[    0.770012][    T0] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.770563][    T0] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.771111][    T0] ... CHAINHASH_SIZE:          32768=0D
[    0.771659][    T0]  memory used by lock dependency info: 6941 kB=0D
[    0.772309][    T0]  memory used for stack traces: 4224 kB=0D
[    0.772888][    T0]  per task-struct memory footprint: 2688 bytes=0D
[    0.773532][    T0] ACPI: Core revision 20250807=0D
[    0.774193][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 19112604467 ns=0D
[    0.775447][    T0] APIC: Switch to symmetric I/O mode setup=0D
[    0.776246][    T0] x2apic enabled=0D
[    0.776961][    T0] APIC: Switched APIC routing to: physical x2apic=0D
[    0.777652][    T0] Masked ExtINT on CPU#0=0D
[    0.778876][    T0] ENABLING IO-APIC IRQs=0D
[    0.779317][    T0] Init IO_APIC IRQs=0D
[    0.779730][    T0] apic 0 pin 0 not connected=0D
[    0.780235][    T0] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1=
 Level:0 ActiveLow:0)=0D
[    0.781162][    T0] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0=
 Level:0 ActiveLow:0)=0D
[    0.782088][    T0] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3=
 Level:0 ActiveLow:0)=0D
[    0.783006][    T0] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4=
 Level:0 ActiveLow:0)=0D
[    0.783952][    T0] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5=
 Level:1 ActiveLow:0)=0D
[    0.784874][    T0] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6=
 Level:0 ActiveLow:0)=0D
[    0.785809][    T0] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7=
 Level:0 ActiveLow:0)=0D
[    0.786752][    T0] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8=
 Level:0 ActiveLow:0)=0D
[    0.787731][    T0] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9=
 Level:1 ActiveLow:0)=0D
[    0.788677][    T0] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ =
10 Level:1 ActiveLow:0)=0D
[    0.789648][    T0] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ =
11 Level:1 ActiveLow:0)=0D
[    0.790620][    T0] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ =
12 Level:0 ActiveLow:0)=0D
[    0.791592][    T0] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ =
13 Level:0 ActiveLow:0)=0D
[    0.792555][    T0] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ =
14 Level:0 ActiveLow:0)=0D
[    0.793514][    T0] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ =
15 Level:0 ActiveLow:0)=0D
[    0.794473][    T0] apic 0 pin 16 not connected=0D
[    0.794977][    T0] apic 0 pin 17 not connected=0D
[    0.795490][    T0] apic 0 pin 18 not connected=0D
[    0.795994][    T0] apic 0 pin 19 not connected=0D
[    0.796497][    T0] apic 0 pin 20 not connected=0D
[    0.796998][    T0] apic 0 pin 21 not connected=0D
[    0.797499][    T0] apic 0 pin 22 not connected=0D
[    0.798007][    T0] apic 0 pin 23 not connected=0D
[    0.798651][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1=
 pin2=3D-1=0D
[    0.799418][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max=
_cycles: 0x240939f1bb2, max_idle_ns: 440795263295 ns=0D
[    0.800652][    T0] Calibrating delay loop (skipped) preset value.. 5000=
=2E00 BogoMIPS (lpj=3D10000000)=0D
[    0.801722][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.802386][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=
=0D
[    0.803120][    T0] CPU: GenuineIntel Intel Xeon E312xx (Sandy Bridge) (=
family: 0x6, model: 0x2a, stepping: 0x1)=0D
[    0.804660][    T0] mitigations: Enabled attack vectors: user_kernel, us=
er_user, SMT mitigations: auto=0D
[    0.805677][    T0] Speculative Store Bypass: Vulnerable=0D
[    0.806270][    T0] Spectre V2 : Vulnerable=0D
[    0.806737][    T0] MDS: Vulnerable=0D
[    0.807124][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers an=
d __user pointer sanitization=0D
[    0.808664][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floati=
ng point registers'=0D
[    0.809589][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regist=
ers'=0D
[    0.810374][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regist=
ers'=0D
[    0.811168][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  2=
56=0D
[    0.811936][    T0] x86/fpu: Enabled xstate features 0x7, context size i=
s 832 bytes, using 'standard' format.=0D
[    0.843536][    T0] pid_max: default: 4096 minimum: 301=0D
[    0.844159][    T0] LSM: initializing lsm=3Dcapability=0D
[    0.844746][    T0] Mount-cache hash table entries: 32768 (order: 6, 262=
144 bytes, linear)=0D
[    0.845695][    T0] Mountpoint-cache hash table entries: 32768 (order: 6=
, 262144 bytes, linear)=0D
[    0.847038][    T0] Running RCU synchronous self tests=0D
[    0.847616][    T0] Running RCU synchronous self tests=0D
[    0.848694][    T1] Performance Events: no PMU driver, software events o=
nly.=0D
[    0.849518][    T1] signal: max sigframe size: 1776=0D
[    0.850120][    T1] rcu: Hierarchical SRCU implementation.=0D
[    0.850733][    T1] rcu: 	Max phase no-delay instances is 1000.=0D
[    0.851682][    T1] dyndbg: Ignore empty _ddebug table in a CONFIG_DYNAM=
IC_DEBUG_CORE build=0D
[    0.852629][    T1] NMI watchdog: Perf NMI watchdog permanently disabled=
=0D
[    0.852770][    T1] Memory: 15971668K/16776696K available (17029K kernel=
 code, 9458K rwdata, 14160K rodata, 1712K init, 17332K bss, 473328K reserve=
d, 0K cma-reserved)=0D
[    0.855980][    T1] devtmpfs: initialized=0D
[    0.857608][    T1] Running RCU synchronous self tests=0D
[    0.858203][    T1] Running RCU synchronous self tests=0D
[    0.858874][    T1] Running RCU Tasks wait API self tests=0D
[    0.960685][    T1] Running RCU Tasks Rude wait API self tests=0D
[    0.961386][    T1] Running RCU Tasks Trace wait API self tests=0D
[    0.962092][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645041785100000 ns=0D
[    0.963279][    T1] posixtimers hash table entries: 512 (order: 3, 40960=
 bytes, linear)=0D
[    0.964181][    T1] futex hash table entries: 16 (1664 bytes on 1 NUMA n=
odes, total 1 KiB, linear).=0D
[    0.964988][    T1] regulator-dummy: 2147483647 mW budge, enabled=0D
[    0.967103][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family=
=0D
[    0.968751][    T1] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomi=
c allocations=0D
[    0.969796][    T1] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool f=
or atomic allocations=0D
[    0.970900][    T1] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool=
 for atomic allocations=0D
[    0.972331][    T1] thermal_sys: Registered thermal governor 'step_wise'=
=0D
[    0.972333][    T1] thermal_sys: Registered thermal governor 'power_allo=
cator'=0D
[    0.972683][    T1] cpuidle: using governor ladder=0D
[    0.974126][    T1] NET: Registered PF_QIPCRTR protocol family=0D
[    0.975207][    T1] PCI: Using configuration type 1 for base access=0D
[    0.976194][    T1] kprobes: kprobe jump-optimization is enabled. All kp=
robes are optimized if possible.=0D
[    0.976698][    T1] workqueue: round-robin CPU selection forced, expect =
performance impact=0D
[    0.980935][    T1] gpio-f7188x: Unsupported Fintek device 0xffff=0D
[    0.981634][    T1] gpio-f7188x: Unsupported Fintek device 0xffff=0D
[    0.982495][    T1] ACPI: Added _OSI(Module Device)=0D
[    0.983039][    T1] ACPI: Added _OSI(Processor Device)=0D
[    0.983609][    T1] ACPI: Added _OSI(Processor Aggregator Device)=0D
[    0.991782][    T1] ACPI: 1 ACPI AML tables successfully acquired and lo=
aded=0D
[    0.998251][    T1] ACPI: Interpreter enabled=0D
[    0.998778][    T1] ACPI: PM: (supports S0 S3 S5)=0D
[    0.999303][    T1] ACPI: Using IOAPIC for interrupt routing=0D
[    1.000425][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug=0D
[    1.004649][    T1] PCI: Using E820 reservations for host bridge windows=
=0D
[    1.005674][    T1] ACPI: Enabled 2 GPEs in block 00 to 0F=0D
[    1.024049][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])=0D
[    1.028653][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments HPX-Type3]=0D
[    1.029543][    T1] acpi PNP0A03:00: PCIe port services disabled; not re=
questing _OSC control=0D
[    1.030482][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge=0D
[    1.032168][    T1] PCI host bridge to bus 0000:00=0D
[    1.036658][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]=0D
[    1.037490][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]=0D
[    1.038314][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]=0D
[    1.039223][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfffff window]=0D
[    1.040123][    T1] pci_bus 0000:00: root bus resource [mem 0x440000000-=
0x4bfffffff window]=0D
[    1.042965][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]=0D
[    1.043711][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint=0D
[    1.045348][    T1] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=
 conventional PCI endpoint=0D
[    1.047259][    T1] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=
 conventional PCI endpoint=0D
[    1.048680][    T1] pci 0000:00:01.1: BAR 4 [io  0xc080-0xc08f]=0D
[    1.049354][    T1] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy =
IDE quirk=0D
[    1.050158][    T1] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE qui=
rk=0D
[    1.050913][    T1] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy =
IDE quirk=0D
[    1.051718][    T1] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE qui=
rk=0D
[    1.052847][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint=0D
[    1.054088][    T1] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed=
 by PIIX4 ACPI=0D
[    1.054955][    T1] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed=
 by PIIX4 SMB=0D
[    1.056204][    T1] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=
 conventional PCI endpoint=0D
[    1.058175][    T1] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff p=
ref]=0D
[    1.058967][    T1] pci 0000:00:02.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]=
=0D
[    1.059712][    T1] pci 0000:00:02.0: ROM [mem 0xfebe0000-0xfebeffff pre=
f]=0D
[    1.060524][    T1] pci 0000:00:02.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]=0D
[    1.061142][    T1] pci 0000:00:03.0: [1af4:1009] type 00 class 0x000200=
 conventional PCI endpoint=0D
[    1.063556][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]=0D
[    1.064269][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfebf1000-0xfebf1fff]=
=0D
[    1.064683][   T19] Callback from call_rcu_tasks_trace() invoked.=0D
[    1.065639][    T1] pci 0000:00:03.0: BAR 4 [mem 0xfe000000-0xfe003fff 6=
4bit pref]=0D
[    1.068769][    T1] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000=
 conventional PCI endpoint=0D
[    1.070216][    T1] pci 0000:00:04.0: BAR 0 [mem 0xfebf2000-0xfebf200f]=
=0D
[    1.072890][    T1] pci 0000:00:05.0: [8086:100e] type 00 class 0x020000=
 conventional PCI endpoint=0D
[    1.077149][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfebc0000-0xfebdffff]=
=0D
[    1.077900][    T1] pci 0000:00:05.0: BAR 1 [io  0xc040-0xc07f]=0D
[    1.078575][    T1] pci 0000:00:05.0: ROM [mem 0xfeb80000-0xfebbffff pre=
f]=0D
[    1.081262][    T1] pci_bus 0000:00: on NUMA node 0=0D
[    1.082818][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10=
=0D
[    1.083870][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10=
=0D
[    1.084809][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11=
=0D
[    1.085893][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11=
=0D
[    1.087126][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9=
=0D
[    1.089536][    T1] iommu: Default domain type: Translated=0D
[    1.090445][    T1] iommu: DMA domain TLB invalidation policy: lazy mode=
=0D
[    1.092159][    T1] mc: Linux media interface: v0.10=0D
[    1.092725][    T1] videodev: Linux video capture interface: v2.00=0D
[    1.093690][    T1] pps_core: LinuxPPS API ver. 1 registered=0D
[    1.094472][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>=0D
[    1.095560][    T1] PTP clock support registered=0D
[    1.096124][    T1] EDAC MC: Ver: 3.0.0=0D
[    1.097219][    T1] FPGA manager framework=0D
[    1.097815][    T1] Advanced Linux Sound Architecture Driver Initialized=
=2E=0D
[    1.099568][    T1] nfc: nfc_init: NFC Core ver 0.1=0D
[    1.100469][    T1] NET: Registered PF_NFC protocol family=0D
[    1.100654][    T1] mctp: management component transport protocol core=0D
[    1.101793][    T1] NET: Registered PF_MCTP protocol family=0D
[    1.102786][    T1] PCI: Using ACPI for IRQ routing=0D
[    1.103618][    T1] PCI: pci_cache_line_size set to 64 bytes=0D
[    1.104721][    T1] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]=
=0D
[    1.105883][    T1] e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]=
=0D
[    1.107193][    T1] pci 0000:00:02.0: vgaarb: setting as boot VGA device=
=0D
[    1.108333][    T1] pci 0000:00:02.0: vgaarb: bridge control possible=0D
[    1.108646][    T1] pci 0000:00:02.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone=0D
[    1.108661][    T1] vgaarb: loaded=0D
[    1.109573][    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=0D
[    1.110515][    T1] hpet0: 3 comparators, 64-bit 100.000000 MHz counter=
=0D
[    1.114844][    T1] clocksource: Switched to clocksource kvm-clock=0D
[    1.116646][    T1] netfs: FS-Cache loaded=0D
[    1.116646][    T1] pnp: PnP ACPI init=0D
[    1.116646][    T1] pnp 00:02: [dma 2]=0D
[    1.117919][    T1] pnp: PnP ACPI: found 6 devices=0D
[    1.124946][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns=0D
[    1.126928][    T1] NET: Registered PF_INET protocol family=0D
[    1.128044][    T1] IP idents hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)=0D
[    1.130987][    T1] tcp_listen_portaddr_hash hash table entries: 8192 (o=
rder: 7, 655360 bytes, linear)=0D
[    1.132242][    T1] Table-perturb hash table entries: 65536 (order: 6, 2=
62144 bytes, linear)=0D
[    1.133426][    T1] TCP established hash table entries: 131072 (order: 8=
, 1048576 bytes, linear)=0D
[    1.136232][    T1] TCP bind hash table entries: 65536 (order: 11, 10485=
760 bytes, vmalloc hugepage)=0D
[    1.139050][    T1] TCP: Hash tables configured (established 131072 bind=
 65536)=0D
[    1.140539][    T1] UDP hash table entries: 8192 (order: 8, 1572864 byte=
s, linear)=0D
[    1.142143][    T1] UDP-Lite hash table entries: 8192 (order: 8, 1572864=
 bytes, linear)=0D
[    1.143345][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    1.144375][    T1] RPC: Registered named UNIX socket transport module.=
=0D
[    1.145158][    T1] RPC: Registered udp transport module.=0D
[    1.145817][    T1] RPC: Registered tcp transport module.=0D
[    1.146470][    T1] RPC: Registered tcp-with-tls transport module.=0D
[    1.147243][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.=0D
[    1.148120][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]=0D
[    1.148926][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]=0D
[    1.149778][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]=0D
[    1.150701][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfff=
ff window]=0D
[    1.151659][    T1] pci_bus 0000:00: resource 8 [mem 0x440000000-0x4bfff=
ffff window]=0D
[    1.152710][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release=0D
[    1.153506][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers=
=0D
[    1.154396][    T1] PCI: CLS 0 bytes, default 64=0D
[    1.155183][   T21] Unpacking initramfs...=0D
[    1.280503][   T17] Callback from call_rcu_tasks() invoked.=0D
[    1.907393][   T21] Freeing initrd memory: 41596K=0D
[    1.907954][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)=0D
[    1.908868][    T1] software IO TLB: mapped [mem 0x00000000b9741000-0x00=
000000bd741000] (64MB)=0D
[    1.910164][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x240939f1bb2, max_idle_ns: 440795263295 ns=0D
[    1.911763][    T1] AVX2 instructions are not detected.=0D
[    1.912442][    T1] AVX2 or AES-NI instructions are not detected.=0D
[    1.913208][    T1] sm3_avx_x86_64: BMI2 instruction are not detected.=0D
[    1.914031][    T1] AVX2 or AES-NI instructions are not detected.=0D
[    1.914815][    T1] AVX512/GFNI instructions are not detected.=0D
[    1.924643][    T1] Key type blacklist registered=0D
[    1.925286][    T1] workingset: timestamp_bits=3D62 max_order=3D22 bucke=
t_order=3D0=0D
[    1.926574][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 =
Red Hat, Inc.=0D
[    1.927611][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.=0D
[    1.928384][    T1] fuse: init (API version 7.45)=0D
[    1.929159][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:=0D
[    1.930178][    T1] orangefs_init: module version upstream loaded=0D
[    1.930880][    T1] 9p: Installing v9fs 9p2000 file system support=0D
[    1.931728][    T1] cryptd: max_cpu_qlen set to 1000=0D
[    1.937438][    T1] NET: Registered PF_ALG protocol family=0D
[    1.938100][    T1] Key type asymmetric registered=0D
[    1.939341][    T1] gpio_it87: no device=0D
[    1.940144][    T1] gpio_winbond: chip ID at 2e is ffff=0D
[    1.940765][    T1] gpio_winbond: not an our chip=0D
[    1.941340][    T1] gpio_winbond: chip ID at 4e is ffff=0D
[    1.941968][    T1] gpio_winbond: not an our chip=0D
[    1.943244][    T1] ledtrig-cpu: registered to indicate activity on CPUs=
=0D
[    1.944565][    T1] hgafb: HGA card not detected.=0D
[    1.945118][    T1] hgafb hgafb.0: probe with driver hgafb failed with e=
rror -22=0D
[    1.946374][    T1] uvesafb: failed to execute /sbin/v86d=0D
[    1.947006][    T1] uvesafb: make sure that the v86d helper is installed=
 and executable=0D
[    1.947961][    T1] uvesafb: Getting VBE info block failed (eax=3D0x4f00=
, err=3D-2)=0D
[    1.948839][    T1] uvesafb: vbe_init() failed with -22=0D
[    1.949460][    T1] uvesafb uvesafb.0: probe with driver uvesafb failed =
with error -22=0D
[    1.950502][    T1] IPMI message handler: version 39.2=0D
[    1.951145][    T1] ipmi device interface=0D
[    1.951701][    T1] ipmi_si: IPMI System Interface driver=0D
[    1.952506][    T1] ipmi_si: Unable to find any System Interface(s)=0D
[    1.953244][    T1] IPMI Watchdog: driver initialized=0D
[    1.953842][    T1] IPMI poweroff: Copyright (C) 2004 MontaVista Softwar=
e - IPMI Powerdown via sys_reboot=0D
[    1.955719][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0=0D
[    1.960372][    T1] ACPI: button: Power Button [PWRF]=0D
[    1.999202][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing disa=
bled=0D
[    2.000462][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A=0D
[    2.003204][    T1] Non-volatile memory driver v1.3=0D
[    2.003886][    T1] telclk_interrupt =3D 0xf non-mcpbl0010 hw.=0D
[    2.004592][    T1] Hangcheck: starting hangcheck timer 0.9.1 (tick is 1=
80 seconds, margin is 60 seconds).=0D
[    2.006137][    T1] ACPI: bus type drm_connector registered=0D
[    2.007143][    T1] [drm] Initialized vgem 1.0.0 for vgem on minor 0=0D
[    2.008565][    T1] [drm] Initialized vkms 1.0.0 for vkms on minor 1=0D
[    2.009512][    T1] Error: Driver 'efi-framebuffer' is already registere=
d, aborting...=0D
[    2.010474][    T1] Error: Driver 'vesa-framebuffer' is already register=
ed, aborting...=0D
[    2.011495][    T1] dummy-irq: no IRQ given.  Use irq=3DN=0D
[    2.012247][    T1] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Ro=
dolfo Giometti=0D
[    2.014307][    T1] mtdoops: mtd device (mtddev=3Dname/number) must be s=
upplied=0D
[    2.015138][    T1] L440GX flash mapping: failed to find PIIX4 ISA bridg=
e, cannot continue=0D
[    2.016171][    T1] SBC-GXx flash: IO:0x258-0x259 MEM:0xdc000-0xdffff=0D
[    2.017268][    T1] CAN device driver interface=0D
[    2.017793][    T1] e1000: Intel(R) PRO/1000 Network Driver=0D
[    2.018464][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.=0D
[    2.021728][    T1] ACPI: \_SB_.LNKA: Enabled at IRQ 10=0D
[    2.343558][    T1] e1000 0000:00:05.0 eth0: (PCI:33MHz:32-bit) 52:54:00=
:12:34:56=0D
[    2.344370][    T1] e1000 0000:00:05.0 eth0: Intel(R) PRO/1000 Network C=
onnection=0D
[    2.345248][    T1] YAM driver version 0.8 by F1OAT/F6FBB=0D
[    2.346947][    T1] AX.25: bpqether driver version 004=0D
[    2.347486][    T1] baycom_ser_hdx: (C) 1996-2000 Thomas Sailer, HB9JNX/=
AE4WA=0D
[    2.347486][    T1] baycom_ser_hdx: version 0.10=0D
[    2.349966][    T1] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA=0D
[    2.350666][    T1] hdlcdrv: version 0.8=0D
[    2.351297][    T1] VFIO - User Level meta-driver version: 0.3=0D
[    2.352038][    T1] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU=
] at 0x60,0x64 irq 1,12=0D
[    2.353708][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    2.354560][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[    2.355669][    T1] mousedev: PS/2 mouse device common for all mice=0D
[    2.357207][    T1] i2c_dev: i2c /dev entries driver=0D
[    2.359063][    T1] ir_imon_decoder: IR iMON protocol handler initialize=
d=0D
[    2.359963][    T1] IR JVC protocol handler initialized=0D
[    2.361074][    T6] input: AT Translated Set 2 keyboard as /devices/plat=
form/i8042/serio0/input/input1=0D
[    2.362480][    T1] IR MCE Keyboard/mouse protocol handler initialized=0D
[    2.363266][    T1] IR RC5(x/sz) protocol handler initialized=0D
[    2.363968][    T1] IR RC6 protocol handler initialized=0D
[    2.364633][    T1] IR RCMM protocol handler initialized=0D
[    2.365274][    T1] IR SANYO protocol handler initialized=0D
[    2.365947][    T1] IR Sharp protocol handler initialized=0D
[    2.366837][    T1] serial_ir serial_ir.0: port 03f8 already in use=0D
[    2.367599][    T1] serial_ir serial_ir.0: use 'setserial /dev/ttySX uar=
t none'=0D
[    2.368537][    T1] serial_ir serial_ir.0: or compile the serial port dr=
iver as module and=0D
[    2.369543][    T1] serial_ir serial_ir.0: make sure this module is load=
ed first=0D
[    2.370463][    T1] serial_ir serial_ir.0: probe with driver serial_ir f=
ailed with error -16=0D
[    2.371592][    T1] Registered IR keymap rc-empty=0D
[    2.372279][    T1] rc rc0: rc-core loopback device as /devices/virtual/=
rc/rc0=0D
[    2.373264][    T1] rc rc0: lirc_dev: driver rc-loopback registered at m=
inor =3D 0, raw IR receiver, raw IR transmitter=0D
[    2.374721][    T1] input: rc-core loopback device as /devices/virtual/r=
c/rc0/input4=0D
[    2.376188][    T1] dvbdev: DVB: registering new adapter (dvb_vidtv_brid=
ge)=0D
[    2.377482][    T1] i2c i2c-0: DVB: registering adapter 0 frontend 0 (Du=
mmy demod for DVB-T/T2/C/S/S2)...=0D
[    2.378693][    T1] dvbdev: dvb_create_media_entity: media entity 'Dummy=
 demod for DVB-T/T2/C/S/S2' registered.=0D
[    2.381169][    T1] dvbdev: dvb_create_media_entity: media entity 'dvb-d=
emux' registered.=0D
[    2.382701][    T1] vidtv vidtv.0: Successfully initialized vidtv!=0D
[    2.383750][    T1] vim2m vim2m.0: Device registered as /dev/video0=0D
[    2.387934][    T1] Driver for 1-wire Dallas network protocol.=0D
[    2.390286][    T1] f71882fg: Not a Fintek device=0D
[    2.390879][    T1] f71882fg: Not a Fintek device=0D
[    2.392884][    T1] sch56xx_common: Unsupported device id: 0xff=0D
[    2.393603][    T1] sch56xx_common: Unsupported device id: 0xff=0D
[    2.395738][    T1] acquirewdt: WDT driver for Acquire single board comp=
uter initialising=0D
[    2.396891][    T1] acquirewdt: I/O address 0x0043 already in use=0D
[    2.397635][    T1] acquirewdt acquirewdt: probe with driver acquirewdt =
failed with error -5=0D
[    2.398772][    T1] advantechwdt: WDT driver for Advantech single board =
computer initialising=0D
[    2.400002][    T1] advantechwdt: initialized. timeout=3D60 sec (nowayou=
t=3D0)=0D
[    2.412197][    T1] eurotechwdt: can't misc_register on minor=3D130=0D
[    2.413024][    T1] it87_wdt: no device=0D
[    2.413488][    T1] pc87413_wdt: Version 1.1 at io 0x2E=0D
[    2.414129][    T1] pc87413_wdt: cannot register miscdev on minor=3D130 =
(err=3D-16)=0D
[    2.415055][    T1] machzwd: MachZ ZF-Logic Watchdog driver initializing=
=0D
[    2.415874][    T1] machzwd: no ZF-Logic found=0D
[    2.416417][    T1] sbc_epx_c3: cannot register miscdev on minor=3D130 (=
err=3D-16)=0D
[    2.417614][    T1] watchdog: Software Watchdog: cannot register miscdev=
 on minor=3D130 (err=3D-16).=0D
[    2.418656][    T1] watchdog: Software Watchdog: a legacy watchdog modul=
e is probably present.=0D
[    2.419879][    T1] softdog: initialized. soft_noboot=3D0 soft_margin=3D=
60 sec soft_panic=3D0 (nowayout=3D0)=0D
[    2.420948][    T1] softdog:              soft_reboot_cmd=3D<not set> so=
ft_active_on_boot=3D0=0D
[    2.422438][    T1] comedi: version 0.7.76 - http://www.comedi.org=0D
[    2.423334][    T1] gpib_common: GPIB core driver=0D
[    2.425229][    T1] fujitsu_tablet: Unknown (using defaults)=0D
[    2.426021][    T1] hdaps: supported laptop not found!=0D
[    2.426656][    T1] hdaps: driver init failed (ret=3D-19)!=0D
[    2.427750][    T1] No DMI match for this platform=0D
[    2.429041][    T1] cros_ec_lpcs: unsupported system.=0D
[    2.434915][    T1] gnss: GNSS driver registered with major 234=0D
[    2.441081][    T1] snd_mtpav snd_mtpav: Motu MidiTimePiece on parallel =
port irq: 7 ioport: 0x378=0D
[    2.446929][    T1] NET: Registered PF_INET6 protocol family=0D
[    2.448076][    T1] Segment Routing with IPv6=0D
[    2.448635][    T1] In-situ OAM (IOAM) with IPv6=0D
[    2.449216][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver=
=0D
[    2.450431][    T1] NET: Registered PF_PACKET protocol family=0D
[    2.451110][    T1] NET: Registered PF_X25 protocol family=0D
[    2.451773][    T1] X25: Linux Version 0.2=0D
[    2.452289][    T1] NET: Registered PF_AX25 protocol family=0D
[    2.452962][    T1] can: controller area network core=0D
[    2.453595][    T1] NET: Registered PF_CAN protocol family=0D
[    2.454260][    T1] can: raw protocol=0D
[    2.454712][    T1] can: broadcast manager protocol=0D
[    2.455303][    T1] can: isotp protocol (max_pdu_size 8300)=0D
[    2.456029][    T1] NET: Registered PF_PHONET protocol family=0D
[    2.456737][    T1] 8021q: 802.1Q VLAN Support v1.8=0D
[    2.457350][    T1] 9pnet: Installing 9P2000 support=0D
[    2.457986][    T1] Key type dns_resolver registered=0D
[    2.458678][    T1] batman_adv: B.A.T.M.A.N. advanced 2025.4 (compatibil=
ity version 15) loaded=0D
[    2.459855][    T1] NET: Registered PF_VSOCK protocol family=0D
[    2.460856][    T1] mce: Unable to init MCE device (rc: -5)=0D
[    2.461768][    T1] microcode: no support for this CPU vendor=0D
[    2.462511][    T1] ... APIC ID:      00000000 (0)=0D
[    2.463112][    T1] ... APIC VERSION: 00050014=0D
[    2.463655][    T1] 0000000000000000000000000000000000000000000000000000=
000000000000=0D
[    2.464541][    T1] 0000000000000000000000000000000000000000000000000000=
000000000000=0D
[    2.464541][    T1] 0000000000000000000000000000000000000000000000000000=
000000001000=0D
[    2.464541][    T1] =0D
[    2.466807][    T1] number of MP IRQ sources: 15.=0D
[    2.467383][    T1] number of IO-APIC #0 registers: 24.=0D
[    2.468041][    T1] testing the IO APIC.......................=0D
[    2.468791][    T1] IO APIC #0......=0D
[    2.469222][    T1] .... register #00: 00000000=0D
[    2.469763][    T1] .......    : physical APIC id: 00=0D
[    2.470380][    T1] .......    : Delivery Type: 0=0D
[    2.470943][    T1] .......    : LTS          : 0=0D
[    2.471515][    T1] .... register #01: 00170011=0D
[    2.472062][    T1] .......     : max redirection entries: 17=0D
[    2.472769][    T1] .......     : PRQ implemented: 0=0D
[    2.473368][    T1] .......     : IO APIC version: 11=0D
[    2.473976][    T1] .... register #02: 00000000=0D
[    2.474515][    T1] .......     : arbitration: 00=0D
[    2.475081][    T1] .... IRQ redirection table:=0D
[    2.475632][    T1] IOAPIC 0:=0D
[    2.476019][    T1]  pin00, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.477083][    T1]  pin01, enabled , edge , high, V(22), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.478143][    T1]  pin02, enabled , edge , high, V(30), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.479184][    T1]  pin03, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.480223][    T1]  pin04, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.481273][    T1]  pin05, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.482314][    T1]  pin06, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.483370][    T1]  pin07, enabled , edge , high, V(23), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.488270][    T1]  pin08, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.489341][    T1]  pin09, enabled , level, high, V(20), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.490433][    T1]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.491504][    T1]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.492560][    T1]  pin0c, enabled , edge , high, V(21), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.493609][    T1]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.494654][    T1]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.495692][    T1]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.496744][    T1]  pin10, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.497794][    T1]  pin11, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.498857][    T1]  pin12, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.499909][    T1]  pin13, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.500966][    T1]  pin14, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.502024][    T1]  pin15, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.503110][    T1]  pin16, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.504190][    T1]  pin17, disabled, edge , high, V(00), IRR(0), S(0), =
physical, D(0000), M(0)=0D
[    2.505248][    T1] IRQ to pin mappings:=0D
[    2.505732][    T1] IRQ0 -> 0:2=0D
[    2.506139][    T1] IRQ1 -> 0:1=0D
[    2.506536][    T1] IRQ3 -> 0:3=0D
[    2.506928][    T1] IRQ4 -> 0:4=0D
[    2.507326][    T1] IRQ5 -> 0:5=0D
[    2.507717][    T1] IRQ6 -> 0:6=0D
[    2.508121][    T1] IRQ7 -> 0:7=0D
[    2.508526][    T1] IRQ8 -> 0:8=0D
[    2.508919][    T1] IRQ9 -> 0:9=0D
[    2.509320][    T1] IRQ10 -> 0:10=0D
[    2.509734][    T1] IRQ11 -> 0:11=0D
[    2.510157][    T1] IRQ12 -> 0:12=0D
[    2.510574][    T1] IRQ13 -> 0:13=0D
[    2.510985][    T1] IRQ14 -> 0:14=0D
[    2.511407][    T1] IRQ15 -> 0:15=0D
[    2.511812][    T1] .................................... done.=0D
[    2.533822][    T1] sched_clock: Marking stable (2500002375, 32254821)->=
(2543852578, -11595382)=0D
[    2.535171][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers=0D
[    2.536686][    T1] Key type .fscrypt registered=0D
[    2.537234][    T1] Key type fscrypt-provisioning registered=0D
[    2.538002][    T1] Key type big_key registered=0D
[    2.538558][    T1] Key type encrypted registered=0D
[    2.542418][    T1] 8021q: adding VLAN 0 to HW filter on device eth0=0D
[    4.576698][    T6] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Fl=
ow Control: RX=0D
[    4.596268][    T1] Sending DHCP requests ., OK=0D
[    5.580817][    T1] IP-Config: Got DHCP answer from 10.0.2.2, my address=
 is 10.0.2.15=0D
[    5.581792][    T1] IP-Config: Complete:=0D
[    5.582279][    T1]      device=3Deth0, hwaddr=3D52:54:00:12:34:56, ipad=
dr=3D10.0.2.15, mask=3D255.255.255.0, gw=3D10.0.2.2=0D
[    5.583515][    T1]      host=3D10.0.2.15, domain=3D, nis-domain=3D(none=
)=0D
[    5.584311][    T1]      bootserver=3D10.0.2.2, rootserver=3D10.0.2.2, r=
ootpath=3D=0D
[    5.584313][    T1]      nameserver0=3D10.0.2.3=0D
[    5.585969][    T1] ALSA device list:=0D
[    5.586415][    T1]   #0: Dummy 1=0D
[    5.586818][    T1]   #1: Loopback 1=0D
[    5.587279][    T1]   #2: Virtual MIDI Card 1=0D
[    5.587839][    T1]   #3: PCM-Test virtual driver=0D
[    5.588620][    T1]   #4: MTPAV on parallel port at 0x378=0D
[    5.591211][    T1] Freeing unused decrypted memory: 2036K=0D
[    5.592786][    T1] Freeing unused kernel image (initmem) memory: 1712K=
=0D
[    5.593380][    T1] Write protecting the kernel read-only data: 32768k=0D
[    5.595203][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 1400K=0D
[    5.595969][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 176K=0D
[    5.597087][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.=0D
[    5.597704][    T1] Run /init as init process=0D
[    5.598100][    T1]   with arguments:=0D
[    5.598430][    T1]     /init=0D
[    5.598702][    T1]   with environment:=0D
[    5.599058][    T1]     HOME=3D/=0D
[    5.599349][    T1]     TERM=3Dlinux=0D
[    5.599662][    T1]     RESULT_ROOT=3D/result/trinity/group-04-5-300s/vm=
-snb/quantal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/7=
9104becf42baeeb4a3f2b106f954b9fc7c10a3c/1=0D
[    5.601145][    T1]     branch=3Dlinux-devel/devel-hourly-20251019-15485=
5=0D
[    5.601729][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-291/trinity-gr=
oup-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig-121-20251020=
-79104becf42b-20251020-124904-8548hu-1.yaml=0D
[    5.603202][    T1]     user=3Dlkp=0D
[    5.603493][    T1]     ARCH=3Dx86_64=0D
[    5.603823][    T1]     kconfig=3Dx86_64-randconfig-121-20251020=0D
[    5.604357][    T1]     commit=3D79104becf42baeeb4a3f2b106f954b9fc7c10a3=
c=0D
[    5.604957][    T1]     intremap=3Dposted_msi=0D
[    5.605340][    T1]     vmalloc=3D256M=0D
[    5.605669][    T1]     max_uptime=3D7200=0D
[    5.606031][    T1]     LKP_LOCAL_RUN=3D1=0D
[    5.606374][    T1]     selinux=3D0=0D
[    5.606686][    T1]     prompt_ramdisk=3D0=0D
[    5.607036][    T1]     vga=3Dnormal=0D
[    5.607355][    T1]     result_service=3D9p/virtfs_mount=0D
[    5.607966][    T1] 32-bit emulation disabled. You can reenable with ia3=
2_emulation=3Don=0D
[    5.608710][    T1] Failed to execute /init (error -8)=0D
[    5.609167][    T1] Run /sbin/init as init process=0D
[    5.609590][    T1]   with arguments:=0D
[    5.609918][    T1]     /sbin/init=0D
[    5.610225][    T1]   with environment:=0D
[    5.610567][    T1]     HOME=3D/=0D
[    5.610848][    T1]     TERM=3Dlinux=0D
[    5.611155][    T1]     RESULT_ROOT=3D/result/trinity/group-04-5-300s/vm=
-snb/quantal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/7=
9104becf42baeeb4a3f2b106f954b9fc7c10a3c/1=0D
[    5.612624][    T1]     branch=3Dlinux-devel/devel-hourly-20251019-15485=
5=0D
[    5.613210][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-291/trinity-gr=
oup-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig-121-20251020=
-79104becf42b-20251020-124904-8548hu-1.yaml=0D
[    5.614672][    T1]     user=3Dlkp=0D
[    5.614971][    T1]     ARCH=3Dx86_64=0D
[    5.615289][    T1]     kconfig=3Dx86_64-randconfig-121-20251020=0D
[    5.615802][    T1]     commit=3D79104becf42baeeb4a3f2b106f954b9fc7c10a3=
c=0D
[    5.616405][    T1]     intremap=3Dposted_msi=0D
[    5.616769][    T1]     vmalloc=3D256M=0D
[    5.617094][    T1]     max_uptime=3D7200=0D
[    5.617439][    T1]     LKP_LOCAL_RUN=3D1=0D
[    5.617781][    T1]     selinux=3D0=0D
[    5.618086][    T1]     prompt_ramdisk=3D0=0D
[    5.618433][    T1]     vga=3Dnormal=0D
[    5.618749][    T1]     result_service=3D9p/virtfs_mount=0D
[    5.619299][    T1] Starting init: /sbin/init exists but couldn't execut=
e it (error -8)=0D
[    5.620023][    T1] Run /etc/init as init process=0D
[    5.620470][    T1]   with arguments:=0D
[    5.620802][    T1]     /etc/init=0D
[    5.621108][    T1]   with environment:=0D
[    5.621445][    T1]     HOME=3D/=0D
[    5.621730][    T1]     TERM=3Dlinux=0D
[    5.622050][    T1]     RESULT_ROOT=3D/result/trinity/group-04-5-300s/vm=
-snb/quantal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/7=
9104becf42baeeb4a3f2b106f954b9fc7c10a3c/1=0D
[    5.623473][    T1]     branch=3Dlinux-devel/devel-hourly-20251019-15485=
5=0D
[    5.624069][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-291/trinity-gr=
oup-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig-121-20251020=
-79104becf42b-20251020-124904-8548hu-1.yaml=0D
[    5.625535][    T1]     user=3Dlkp=0D
[    5.625819][    T1]     ARCH=3Dx86_64=0D
[    5.626136][    T1]     kconfig=3Dx86_64-randconfig-121-20251020=0D
[    5.626647][    T1]     commit=3D79104becf42baeeb4a3f2b106f954b9fc7c10a3=
c=0D
[    5.627222][    T1]     intremap=3Dposted_msi=0D
[    5.627595][    T1]     vmalloc=3D256M=0D
[    5.627929][    T1]     max_uptime=3D7200=0D
[    5.628299][    T1]     LKP_LOCAL_RUN=3D1=0D
[    5.628643][    T1]     selinux=3D0=0D
[    5.628943][    T1]     prompt_ramdisk=3D0=0D
[    5.629291][    T1]     vga=3Dnormal=0D
[    5.629605][    T1]     result_service=3D9p/virtfs_mount=0D
[    5.630074][    T1] Starting init: /etc/init exists but couldn't execute=
 it (error -13)=0D
[    5.630768][    T1] Run /bin/init as init process=0D
[    5.631183][    T1]   with arguments:=0D
[    5.631518][    T1]     /bin/init=0D
[    5.631824][    T1]   with environment:=0D
[    5.632178][    T1]     HOME=3D/=0D
[    5.632472][    T1]     TERM=3Dlinux=0D
[    5.632786][    T1]     RESULT_ROOT=3D/result/trinity/group-04-5-300s/vm=
-snb/quantal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/7=
9104becf42baeeb4a3f2b106f954b9fc7c10a3c/1=0D
[    5.634236][    T1]     branch=3Dlinux-devel/devel-hourly-20251019-15485=
5=0D
[    5.634816][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-291/trinity-gr=
oup-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig-121-20251020=
-79104becf42b-20251020-124904-8548hu-1.yaml=0D
[    5.636292][    T1]     user=3Dlkp=0D
[    5.636582][    T1]     ARCH=3Dx86_64=0D
[    5.636901][    T1]     kconfig=3Dx86_64-randconfig-121-20251020=0D
[    5.637420][    T1]     commit=3D79104becf42baeeb4a3f2b106f954b9fc7c10a3=
c=0D
[    5.638008][    T1]     intremap=3Dposted_msi=0D
[    5.638377][    T1]     vmalloc=3D256M=0D
[    5.638682][    T1]     max_uptime=3D7200=0D
[    5.639039][    T1]     LKP_LOCAL_RUN=3D1=0D
[    5.639383][    T1]     selinux=3D0=0D
[    5.639682][    T1]     prompt_ramdisk=3D0=0D
[    5.640039][    T1]     vga=3Dnormal=0D
[    5.640352][    T1]     result_service=3D9p/virtfs_mount=0D
[    5.640822][    T1] Run /bin/sh as init process=0D
[    5.641222][    T1]   with arguments:=0D
[    5.641545][    T1]     /bin/sh=0D
[    5.641831][    T1]   with environment:=0D
[    5.642177][    T1]     HOME=3D/=0D
[    5.642458][    T1]     TERM=3Dlinux=0D
[    5.642764][    T1]     RESULT_ROOT=3D/result/trinity/group-04-5-300s/vm=
-snb/quantal-i386-core-20190426.cgz/x86_64-randconfig-121-20251020/gcc-13/7=
9104becf42baeeb4a3f2b106f954b9fc7c10a3c/1=0D
[    5.644180][    T1]     branch=3Dlinux-devel/devel-hourly-20251019-15485=
5=0D
[    5.644777][    T1]     job=3D/lkp/jobs/scheduled/vm-meta-291/trinity-gr=
oup-04-5-300s-quantal-i386-core-20190426.cgz-x86_64-randconfig-121-20251020=
-79104becf42b-20251020-124904-8548hu-1.yaml=0D
[    5.646205][    T1]     user=3Dlkp=0D
[    5.646496][    T1]     ARCH=3Dx86_64=0D
[    5.646811][    T1]     kconfig=3Dx86_64-randconfig-121-20251020=0D
[    5.647318][    T1]     commit=3D79104becf42baeeb4a3f2b106f954b9fc7c10a3=
c=0D
[    5.647914][    T1]     intremap=3Dposted_msi=0D
[    5.648300][    T1]     vmalloc=3D256M=0D
[    5.648620][    T1]     max_uptime=3D7200=0D
[    5.648969][    T1]     LKP_LOCAL_RUN=3D1=0D
[    5.649321][    T1]     selinux=3D0=0D
[    5.649628][    T1]     prompt_ramdisk=3D0=0D
[    5.649983][    T1]     vga=3Dnormal=0D
[    5.650291][    T1]     result_service=3D9p/virtfs_mount=0D
[    5.650807][    T1] Starting init: /bin/sh exists but couldn't execute i=
t (error -8)=0D
[    5.651481][    T1] Kernel panic - not syncing: No working init found.  =
Try passing init=3D option to kernel. See Linux Documentation/admin-guide/i=
nit.rst for guidance.=0D
[    5.652784][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
8.0-rc2-00182-gbab99e58f91f #35 PREEMPT =0D
[    5.653668][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[    5.654582][    T1] Call Trace:=0D
[    5.654873][    T1]  <TASK>=0D
[    5.655137][    T1]  dump_stack_lvl+0x3a/0x70=0D
[    5.655536][    T1]  dump_stack+0x10/0x20=0D
[    5.655911][    T1]  vpanic+0x104/0x2c0=0D
[    5.656256][    T1]  ? rest_init+0x140/0x140=0D
[    5.656652][    T1]  panic+0x51/0x60=0D
[    5.656989][    T1]  kernel_init+0x111/0x120=0D
[    5.657360][    T1]  ret_from_fork+0x25/0x140=0D
[    5.657741][    T1]  ? rest_init+0x140/0x140=0D
[    5.658130][    T1]  ret_from_fork_asm+0x11/0x20=0D
[    5.658563][    T1]  </TASK>=0D
[    5.658841][    T1] Kernel Offset: disabled=0D


