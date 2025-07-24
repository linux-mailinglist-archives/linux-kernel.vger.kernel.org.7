Return-Path: <linux-kernel+bounces-743726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5FB1027F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123EA1CC381F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850FE22AE75;
	Thu, 24 Jul 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="HidRybBZ"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3426738D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343873; cv=none; b=NS3Cze+EORxnwRSVYhiCIfaPunmX5erh7VaPgKrjMAwVMKYrNqe3BluaT6z9fnSFfPftVcHz593RsDLw/V95jHNg6o6dOp0/gOjBS2IyLOcVC6zBYxLgc+mgcaGp7i632JXUBmMpW5B5dKj/GxoRzAGFRdFi+bXHqXjxNl9KFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343873; c=relaxed/simple;
	bh=skJFSxKEG/pwFuZkOKK0XpEUYTLn+CJ+0MH23r8xvhs=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=pHHRaw1fuIer4EmPvWro7/btDN0RqZ0wRYwSfijExqADB7BexjeljmY6AbE1+ZIeAF0SQ15Ct+wOsYQpcM6/bhFaLFWMW2MEVrZC44kcAvvGzfc91+SiUpH3JXjaXDG0wOZC/qHtwgJpVp4bNFCC4BsDWLJ45HbsfHHxeFZy1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=HidRybBZ; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1753343763;
	bh=lQrwJoCpgl2/BAXpT3pNpBMlKBiTVuq62JQ+xefCnIs=;
	h=From:Message-Id:Mime-Version:Subject:Date:To;
	b=HidRybBZ4YwvW5IH7jquac1FR7R+pVSCo1MhrfunnoX6NKl573OQdt3We/1hMdfxo
	 Otwhw1NJB6ufB2XE/NV1Jr+l00IEgO7NVrgHMHl6zAdS5b7JTVBpzd3zjQXNrFrXoJ
	 RKA1ZeAu3D35MATv2lSgweEFjS9ZzNXQKk+e4BJY=
X-QQ-mid: zesmtpsz2t1753343761t7b9299ff
X-QQ-Originating-IP: ta+opYQ+rXwwJ6CQms5Njlfo+P19jwPxilOkxkaRtPE=
Received: from smtpclient.apple ( [202.120.235.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Jul 2025 15:55:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12530290682153853686
EX-QQ-RecipientCnt: 5
From: =?utf-8?B?6IOh54Sc?= <huk23@m.fudan.edu.cn>
Message-Id: <C0FEC6BF-BCC8-4301-BBE6-8A49A05D50D6@m.fudan.edu.cn>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_544FB0F3-7181-41A1-B559-5F64E0DD7181"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: possible deadlock in smp_call_function_many_cond
Date: Thu, 24 Jul 2025 15:55:47 +0800
In-Reply-To: <877c02vejr.ffs@tglx>
Cc: =?utf-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>,
 Peter Zijlstra <peterz@infradead.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
References: <758991c1.13f67.197f9cccf9b.Coremail.baishuoran@hrbeu.edu.cn>
 <877c02vejr.ffs@tglx>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ntdq2DfHmxsu4NwQtNhOnjjU8UCnBEGYkPyulTJ5rKBtjoPoF1e9bUM2
	NCDOcl/6Ke+q8xNtsNOBsuB2M8c6aggMN6y35AQlev5SjBgZvePQqTJgEtosElCfNJC0N2S
	nNdqgx+IMqAZ8vKIl2CTi+24XE7WXuKrAqVAaE7XjPqcYAz24FYl4INmI+Pc06cSy9C3SwM
	V9oQ5Hcxbv8SLnPwTMI3z+PTWYfYOmNc3W6FLdcHclR3CLGgEQYq1qv1EJTCXw1d6MRYdzC
	ZQmJuNi+K2oJ66oDTWphD2z9cAmUUoCOnI30pnLISJQz5i1WU7wj9bHBBpLbgzrFM2kmo7i
	c2qJB3TTa+aAjgAh/mPrTpEs1e2Xnj7lPHxLWxvHN9EtMogKAhbElYX+qWAAVdL03ixp4zO
	6Gaii5tkTxJAcqBpAfz2ZKE593gr42E4of81xAAy+dLmupql08FDXKz4NsC8xh13OElvmIc
	rvS63ah2e+GdcMfhyYi+UCMUubtER+fuidKG8CsMltH/ndSsKvBaIsOlNFxqZne67jcZvka
	/DFXs0J7E95J01Mkz5Mu/ib1hfbVNpuXCvJOYAnmnJCOcA/fku7ALpVU0ff6wI45Pkpn7l9
	Yqx8+6f6g3PoPQGacKYD9RQZMN5z6wXNABnEUiODB8t6cfZV3OKp9FQoGIf0huikaDIW843
	yOpvm0ZCej5knDm3GwPL86rq7tQasLebmC9zBfN732B2oWJFACZ5+iZo0KTARHL87IcRZ/l
	zke28zIK4wfCWs9JnGBqRZoDFss5BlFaPIf9Rg4SU+dYyGceu6yxJuLm/aOj3NJGHJjNviC
	/+q+CPBU/i/DeZTcOErpgDEkxsD4rBSp9qQj0gBHaGNuF8hddHhV2qb6mTwbL4J5wr3+XC6
	GVnG9h0KktlL+xM4Gd75aG186eeJ3AkN5I0fvRx/5yvcs7k8mOX4ZQ+l0S9xfRgJbSp8fjc
	x6rEWIRGPVqg9ristUWObtZVAKF+SI6KRBhXgJdgHh7/OjGPDNpzrVBtvrmqxfeCaRni0cp
	o5aCApWDjb8S5nQgCVV7un90r71eWQvkDKErJKT9ZPuWK0dTkB
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0


--Apple-Mail=_544FB0F3-7181-41A1-B559-5F64E0DD7181
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Thomas:

We've reproduced the issue on multiple kernels (6.16-rc4, etc.), but =
just noticed that the latest tree has been updated to rc7, so we're =
still verifying.

Per your suggestion, we turned on multiple options to print these =
details, including: ftrace_dump_on_oops hrtimer_expire_entry =
hrtimer_expire_exit trace_event=3Dipi_entry,ipi_exit,irq_handler_ =
entry,irq_handler_exit. also turned on CONFIG_CSD LOCK WAIT DEBUG.

My guess is that the crash point might be csd_lock_wait(csd) in =
~/kernel/smp.c on line 885. Here the other CPUs are notified via IPI to =
execute flush_tlb_mm_range and enter spin wait. However, it has not yet =
been determined which CPU performed the operation that caused the IPI to =
return a timeout.

I'll first provide the log that was reproduced in 6.16-rc4. we'll =
re-verify it on rc7.

thanks,
Kun=20

> 2025=E5=B9=B47=E6=9C=8821=E6=97=A5 03:38=EF=BC=8CThomas Gleixner =
<tglx@linutronix.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 11 2025 at 22:03, =E7=99=BD=E7=83=81=E5=86=89 wrote:
>> When using our customized Syzkaller to fuzz the latest Linux kernel,
>> the following crash (122th)was triggered.
>>=20
>> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
>> git tree: upstream
>=20
> That's not the latest kernel.
>=20
>> =
Output:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/INFO%3A%20=
rcu%20detected%20stall%20in%20sys_select/122report.txt
>> Kernel =
config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.14rc3/config.=
txt
>> C =
reproducer:https:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/=
INFO%3A%20rcu%20detected%20stall%20in%20sys_select/122repro.c
>> Syzlang reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/INFO%3A%20rcu%20d=
etected%20stall%20in%20sys_select/122repro.txt
>>=20

--Apple-Mail=_544FB0F3-7181-41A1-B559-5F64E0DD7181
Content-Disposition: attachment;
	filename=122log.txt
Content-Type: text/plain;
	x-unix-mode=0444;
	name="122log.txt"
Content-Transfer-Encoding: quoted-printable


[    0.000000][    T0] Linux version 6.16.0-rc4 =
(qjj@qjj-Standard-PC-Q35-ICH9-2009) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) =
9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP PREEMPT_DYNAMIC Wed =
Jul  2 09:53:03 CST 2025

[    0.000000][    T0] Command line: root=3D/dev/sda console=3DttyS0 =
ftrace_dump_on_oops hrtimer_expire_entry hrtimer_expire_exit =
trace_event=3Dipi_entry,ipi_exit,irq_handler_entry,irq_handler_exit

[    0.000000][    T0] KERNEL supported cpus:

[    0.000000][    T0]   Intel GenuineIntel

[    0.000000][    T0]   AMD AuthenticAMD

[    0.000000][    T0] BIOS-provided physical RAM map:

[    0.000000][    T0] BIOS-e820: [mem =
0x0000000000000000-0x000000000009fbff] usable

[    0.000000][    T0] BIOS-e820: [mem =
0x000000000009fc00-0x000000000009ffff] reserved

[    0.000000][    T0] BIOS-e820: [mem =
0x00000000000f0000-0x00000000000fffff] reserved

[    0.000000][    T0] BIOS-e820: [mem =
0x0000000000100000-0x000000007ffdffff] usable

[    0.000000][    T0] BIOS-e820: [mem =
0x000000007ffe0000-0x000000007fffffff] reserved

[    0.000000][    T0] BIOS-e820: [mem =
0x00000000feffc000-0x00000000feffffff] reserved

[    0.000000][    T0] BIOS-e820: [mem =
0x00000000fffc0000-0x00000000ffffffff] reserved

[    0.000000][    T0] printk: legacy bootconsole [earlyser0] enabled

[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used

[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used

[    0.000000][    T0] =
**********************************************************

[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE =
NOTICE   **

[    0.000000][    T0] **                                                =
      **

[    0.000000][    T0] ** This system shows unhashed kernel memory =
addresses   **

[    0.000000][    T0] ** via the console, logs, and other interfaces. =
This    **

[    0.000000][    T0] ** might reduce the security of your system.      =
      **

[    0.000000][    T0] **                                                =
      **

[    0.000000][    T0] ** If you see this message and you are not =
debugging    **

[    0.000000][    T0] ** the kernel, report this immediately to your =
system   **

[    0.000000][    T0] ** administrator!                                 =
      **

[    0.000000][    T0] **                                                =
      **

[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE =
NOTICE   **

[    0.000000][    T0] =
**********************************************************

[    0.000000][    T0] Malformed early option 'vsyscall'

[    0.000000][    T0] nopcid: PCID feature disabled

[    0.000000][    T0] NX (Execute Disable) protection: active

[    0.000000][    T0] APIC: Static calls initialized

[    0.000000][    T0] SMBIOS 2.8 present.

[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014

[    0.000000][    T0] DMI: Memory slots populated: 1/1

[    0.000000][    T0] Hypervisor detected: KVM

[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00

[    0.000004][    T0] kvm-clock: using sched offset of 1705530923 =
cycles

[    0.002847][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff =
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns

[    0.011456][    T0] tsc: Detected 2249.996 MHz processor

[    0.026856][    T0] last_pfn =3D 0x7ffe0 max_arch_pfn =3D =
0x10000000000

[    0.030205][    T0] MTRR map: 4 entries (3 fixed + 1 variable; max =
19), built from 8 variable MTRRs

[    0.034521][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  =
WP  UC- WT =20

[    0.043411][    T0] found SMP MP-table at [mem 0x000f5c50-0x000f5c5f]

[    0.046546][    T0] Using GB pages for direct mapping

[    0.051862][    T0] ACPI: Early table checksum verification disabled

[    0.054902][    T0] ACPI: RSDP 0x00000000000F59B0 000014 (v00 BOCHS )

[    0.058014][    T0] ACPI: RSDT 0x000000007FFE1685 000030 (v01 BOCHS  =
BXPCRSDT 00000001 BXPC 00000001)

[    0.062490][    T0] ACPI: FACP 0x000000007FFE1549 000074 (v01 BOCHS  =
BXPCFACP 00000001 BXPC 00000001)

[    0.066867][    T0] ACPI: DSDT 0x000000007FFE0040 001509 (v01 BOCHS  =
BXPCDSDT 00000001 BXPC 00000001)

[    0.071203][    T0] ACPI: FACS 0x000000007FFE0000 000040

[    0.073661][    T0] ACPI: APIC 0x000000007FFE15BD 000090 (v01 BOCHS  =
BXPCAPIC 00000001 BXPC 00000001)

[    0.077963][    T0] ACPI: HPET 0x000000007FFE164D 000038 (v01 BOCHS  =
BXPCHPET 00000001 BXPC 00000001)

[    0.082271][    T0] ACPI: Reserving FACP table memory at [mem =
0x7ffe1549-0x7ffe15bc]

[    0.085845][    T0] ACPI: Reserving DSDT table memory at [mem =
0x7ffe0040-0x7ffe1548]

[    0.089439][    T0] ACPI: Reserving FACS table memory at [mem =
0x7ffe0000-0x7ffe003f]

[    0.093028][    T0] ACPI: Reserving APIC table memory at [mem =
0x7ffe15bd-0x7ffe164c]

[    0.096659][    T0] ACPI: Reserving HPET table memory at [mem =
0x7ffe164d-0x7ffe1684]

[    0.102559][    T0] No NUMA configuration found

[    0.104733][    T0] Faking a node at [mem =
0x0000000000000000-0x000000007ffdffff]

[    0.108229][    T0] Faking node 0 at [mem =
0x0000000000001000-0x0000000040000fff] (1024MB)

[    0.112056][    T0] Faking node 1 at [mem =
0x0000000040001000-0x000000007ffdffff] (1023MB)

[    0.116497][    T0] NODE_DATA(0) allocated [mem =
0x3fffb400-0x40000fff]

[    0.120039][    T0] NODE_DATA(1) allocated [mem =
0x7ffd9400-0x7ffdefff]

[    0.128106][    T0] Zone ranges:

[    0.129678][    T0]   DMA      [mem =
0x0000000000001000-0x0000000000ffffff]

[    0.132886][    T0]   DMA32    [mem =
0x0000000001000000-0x000000007ffdffff]

[    0.136105][    T0]   Normal   empty

[    0.137798][    T0]   Device   empty

[    0.139540][    T0] Movable zone start for each node

[    0.141934][    T0] Early memory node ranges

[    0.143980][    T0]   node   0: [mem =
0x0000000000001000-0x000000000009efff]

[    0.147276][    T0]   node   0: [mem =
0x0000000000100000-0x0000000040000fff]

[    0.150636][    T0]   node   1: [mem =
0x0000000040001000-0x000000007ffdffff]

[    0.153973][    T0] Initmem setup node 0 [mem =
0x0000000000001000-0x0000000040000fff]

[    0.157720][    T0] Initmem setup node 1 [mem =
0x0000000040001000-0x000000007ffdffff]

[    0.161536][    T0] On node 0, zone DMA: 1 pages in unavailable =
ranges

[    0.165034][    T0] On node 0, zone DMA: 97 pages in unavailable =
ranges

[    0.205371][    T0] On node 1, zone DMA32: 32 pages in unavailable =
ranges

[    0.267153][    T0] kasan: KernelAddressSanitizer initialized

[    0.271673][    T0] ACPI: PM-Timer IO Port: 0x608

[    0.273981][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])

[    0.277145][    T0] IOAPIC[0]: apic_id 0, version 17, address =
0xfec00000, GSI 0-23

[    0.280772][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 =
dfl dfl)

[    0.284051][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 =
high level)

[    0.287522][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 =
high level)

[    0.290951][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 =
high level)

[    0.294433][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 =
high level)

[    0.297923][    T0] ACPI: Using ACPI (MADT) for SMP configuration =
information

[    0.301281][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000

[    0.304053][    T0] TSC deadline timer available

[    0.306228][    T0] CPU topo: Max. logical packages:   4

[    0.308692][    T0] CPU topo: Max. logical dies:       4

[    0.311236][    T0] CPU topo: Max. dies per package:   1

[    0.313787][    T0] CPU topo: Max. threads per core:   1

[    0.316335][    T0] CPU topo: Num. cores per package:     1

[    0.318994][    T0] CPU topo: Num. threads per package:   1

[    0.321628][    T0] CPU topo: Allowing 4 present CPUs plus 0 hotplug =
CPUs

[    0.324920][    T0] kvm-guest: APIC: eoi() replaced with =
kvm_guest_apic_eoi_write()

[    0.328707][    T0] kvm-guest: KVM setup pv remote TLB flush

[    0.331442][    T0] kvm-guest: setup PV sched yield

[    0.333811][    T0] PM: hibernation: Registered nosave memory: [mem =
0x00000000-0x00000fff]

[    0.337727][    T0] PM: hibernation: Registered nosave memory: [mem =
0x0009f000-0x000fffff]

[    0.341633][    T0] [mem 0x80000000-0xfeffbfff] available for PCI =
devices

[    0.344851][    T0] Booting paravirtualized kernel on KVM

[    0.347409][    T0] clocksource: refined-jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns

[    0.406325][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:4 =
nr_cpu_ids:4 nr_node_ids:2

[    0.410962][    T0] percpu: Embedded 70 pages/cpu s247304 r8192 =
d31224 u1048576

[    0.414809][    T0] kvm-guest: PV spinlocks enabled

[    0.417147][    T0] PV qspinlock hash table entries: 256 (order: 0, =
4096 bytes, linear)

[    0.420989][    T0] Kernel command line: earlyprintk=3Dserial =
net.ifnames=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 =
ima_policy=3Dtcb nf-conntrack-ftp.ports=3D20000 =
nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000 =
nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000 =
binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 =
rcupdate.rcu_cpu_stall_cputime=3D1 no_hash_pointers page_owner=3Don =
sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4 =
secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1 =
msr.allow_writes=3Doff coredump_filter=3D0xffff root=3D/dev/sda =
console=3DttyS0 vsyscall=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 =
spec_store_bypass_disable=3Dprctl nopcid vivid.n_devs=3D64 =
vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,=
2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 =
netrom.nr_ndevs=3D32 rose.rose_ndevs=3D32 smp.csd_lock_timeout=3D100000 =
watchdog_thresh=3D55 workqueue.watchdog_thresh=3D140 =
sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.num=3D32 =
max_loop=3D32 nbds_max=3D32 panic_on_warn

[    0.427302][    T0] Unknown kernel command line parameters =
"hrtimer_expire_entry hrtimer_expire_exit =
spec_store_bypass_disable=3Dprctl nbds_max=3D32", will be passed to user =
space.

[    0.480111][    T0] random: crng init done

[    0.482201][    T0] printk: log buffer data + meta data: 262144 + =
917504 =3D 1179648 bytes

[    0.486680][    T0] Fallback order for Node 0: 0 1=20

[    0.486698][    T0] Fallback order for Node 1: 1 0=20

[    0.486713][    T0] Built 2 zonelists, mobility grouping on.  Total =
pages: 524158

[    0.495204][    T0] Policy zone: DMA32

[    0.497416][    T0] mem auto-init: stack:off, heap alloc:on, heap =
free:off

[    0.500856][    T0] stackdepot: allocating hash table via =
alloc_large_system_hash

[    0.504552][    T0] stackdepot hash table entries: 1048576 (order: =
12, 16777216 bytes, linear)

[    0.595325][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, =
CPUs=3D4, Nodes=3D2

[    0.616839][    T0] allocated 41943040 bytes of page_ext

[    0.619573][    T0] Node 0, zone      DMA: page owner found early =
allocated 0 pages

[    0.637519][    T0] Node 0, zone    DMA32: page owner found early =
allocated 5853 pages

[    0.644823][    T0] Node 1, zone    DMA32: page owner found early =
allocated 4483 pages

[    0.653194][    T0] Dynamic Preempt: full

[    0.656174][    T0] Running RCU self tests

[    0.658190][    T0] Running RCU synchronous self tests

[    0.660686][    T0] rcu: Preemptible hierarchical RCU implementation.

[    0.663834][    T0] rcu: 	RCU lockdep checking is enabled.

[    0.666510][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to =
nr_cpu_ids=3D4.

[    0.670048][    T0] rcu: 	RCU callback double-/use-after-free =
debug is enabled.

[    0.673442][    T0] rcu: 	RCU debug extended QS entry/exit.

[    0.676156][    T0] 	All grace periods are expedited (rcu_expedited).

[    0.679313][    T0] 	Trampoline variant of Tasks RCU enabled.

[    0.682128][    T0] 	Tracing variant of Tasks RCU enabled.

[    0.684775][    T0] rcu: RCU calculated value of scheduler-enlistment =
delay is 10 jiffies.

[    0.688833][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D4

[    0.692523][    T0] Running RCU synchronous self tests

[    0.695049][    T0] RCU Tasks: Setting shift to 2 and lim to 1 =
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.

[    0.699649][    T0] RCU Tasks Trace: Setting shift to 2 and lim to 1 =
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.

[    0.875439][    T0] NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: =
16

[    0.879694][    T0] rcu: srcu_init: Setting srcu_struct sizes based =
on contention.

[    0.883863][    T0] kfence: initialized - using 2097152 bytes for 255 =
objects at 0xff1100007de00000-0xff1100007e000000

[    0.919893][    T0] Console: colour VGA+ 80x25

[    0.922234][    T0] printk: legacy console [ttyS0] enabled

[    0.922234][    T0] printk: legacy console [ttyS0] enabled

[    0.927401][    T0] printk: legacy bootconsole [earlyser0] disabled

[    0.927401][    T0] printk: legacy bootconsole [earlyser0] disabled

[    0.933264][    T0] Lock dependency validator: Copyright (c) 2006 Red =
Hat, Inc., Ingo Molnar

[    0.937218][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8

[    0.939498][    T0] ... MAX_LOCK_DEPTH:          48

[    0.941806][    T0] ... MAX_LOCKDEP_KEYS:        8192

[    0.944353][    T0] ... CLASSHASH_SIZE:          4096

[    0.946749][    T0] ... MAX_LOCKDEP_ENTRIES:     1048576

[    0.949270][    T0] ... MAX_LOCKDEP_CHAINS:      1048576

[    0.951821][    T0] ... CHAINHASH_SIZE:          524288

[    0.954338][    T0]  memory used by lock dependency info: 106625 kB

[    0.957256][    T0]  memory used for stack traces: 8320 kB

[    0.959912][    T0]  per task-struct memory footprint: 1920 bytes

[    0.962888][    T0] mempolicy: Enabling automatic NUMA balancing. =
Configure with numa_balancing=3D or the kernel.numa_balancing sysctl

[    0.968407][    T0] ACPI: Core revision 20250404

[    0.971622][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 19112604467 ns

[    0.976753][    T0] APIC: Switch to symmetric I/O mode setup

[    0.980703][    T0] x2apic enabled

[    0.983892][    T0] APIC: Switched APIC routing to: physical x2apic

[    0.987021][    T0] kvm-guest: APIC: send_IPI_mask() replaced with =
kvm_send_ipi_mask()

[    0.990710][    T0] kvm-guest: APIC: send_IPI_mask_allbutself() =
replaced with kvm_send_ipi_mask_allbutself()

[    0.995267][    T0] kvm-guest: setup PV IPIs

[    1.003745][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 =
apic2=3D-1 pin2=3D-1

[    1.007036][    T0] tsc: Marking TSC unstable due to TSCs =
unsynchronized

[    1.010173][    T0] Calibrating delay loop (skipped) preset value.. =
4499.99 BogoMIPS (lpj=3D22499960)

[    1.015208][    T0] x86/cpu: User Mode Instruction Prevention (UMIP) =
activated

[    1.020963][    T0] Last level iTLB entries: 4KB 512, 2MB 255, 4MB =
127

[    1.024192][    T0] Last level dTLB entries: 4KB 512, 2MB 255, 4MB =
127, 1GB 0

[    1.027861][    T0] Speculative Store Bypass: Mitigation: Speculative =
Store Bypass disabled via prctl

[    1.030172][    T0] Speculative Return Stack Overflow: IBPB-extending =
microcode not applied!

[    1.034182][    T0] Speculative Return Stack Overflow: WARNING: See =
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for =
mitigation options.

[    1.034193][    T0] Spectre V2 : Mitigation: Retpolines

[    1.042794][    T0] Speculative Return Stack Overflow: Vulnerable: =
Safe RET, no microcode

[    1.050168][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers =
and __user pointer sanitization

[    1.054757][    T0] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB =
on context switch and VMEXIT

[    1.060168][    T0] Spectre V2 : Enabling Restricted Speculation for =
firmware calls

[    1.064007][    T0] Spectre V2 : mitigation: Enabling conditional =
Indirect Branch Prediction Barrier

[    1.068761][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 =
floating point registers'

[    1.070169][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE =
registers'

[    1.073340][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX =
registers'

[    1.080167][    T0] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 =
opmask'

[    1.083395][    T0] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 =
Hi256'

[    1.086589][    T0] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 =
ZMM_Hi256'

[    1.089896][    T0] x86/fpu: Supporting XSAVE feature 0x200: =
'Protection Keys User registers'

[    1.090171][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]: =
 256

[    1.093293][    T0] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]: =
  64

[    1.096290][    T0] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]: =
 512

[    1.100169][    T0] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: =
1024

[    1.103187][    T0] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]: =
   8

[    1.106264][    T0] x86/fpu: Enabled xstate features 0x2e7, context =
size is 2440 bytes, using 'compacted' format.

[    1.698016][    T0] Freeing SMP alternatives memory: 128K

[    1.700227][    T0] pid_max: default: 32768 minimum: 301

[    1.703502][    T0] LSM: initializing =
lsm=3Dlockdown,capability,landlock,yama,safesetid,tomoyo,selinux,bpf,ima,e=
vm

[    1.709298][    T0] landlock: Up and running.

[    1.710223][    T0] Yama: becoming mindful.

[    1.712850][    T0] TOMOYO Linux initialized

[    1.714943][    T0] SELinux:  Initializing.

[    1.725876][    T0] LSM support for eBPF active

[    1.731017][    T0] Dentry cache hash table entries: 262144 (order: =
9, 2097152 bytes, vmalloc hugepage)

[    1.739962][    T0] Inode-cache hash table entries: 131072 (order: 8, =
1048576 bytes, vmalloc)

[    1.740682][    T0] Mount-cache hash table entries: 4096 (order: 3, =
32768 bytes, vmalloc)

[    1.744750][    T0] Mountpoint-cache hash table entries: 4096 (order: =
3, 32768 bytes, vmalloc)

[    1.761127][    T0] Running RCU synchronous self tests

[    1.763501][    T0] Running RCU synchronous self tests

[    1.767711][    T1] smpboot: CPU0: AMD EPYC 9754 128-Core Processor =
(family: 0x19, model: 0xa0, stepping: 0x2)

[    1.772213][    T1] Performance Events: Fam17h+ core perfctr, AMD PMU =
driver.

[    1.775945][    T1] ... version:                0

[    1.778153][    T1] ... bit width:              48

[    1.780189][    T1] ... generic registers:      6

[    1.782437][    T1] ... value mask:             0000ffffffffffff

[    1.785214][    T1] ... max period:             00007fffffffffff

[    1.788064][    T1] ... fixed-purpose events:   0

[    1.790190][    T1] ... event mask:             000000000000003f

[    1.794746][    T1] signal: max sigframe size: 3376

[    1.797982][    T1] rcu: Hierarchical SRCU implementation.

[    1.800188][    T1] rcu: 	Max phase no-delay instances is 1000.

[    1.804617][    T1] Timer migration: 2 hierarchy levels; 8 children =
per group; 1 crossnode level

[    1.970812][    T1] smp: Bringing up secondary CPUs ...

[    1.987490][    T1] smpboot: x86: Booting SMP configuration:

[    1.990256][    T1] .... node  #1, CPUs:      #1

[    2.013232][    T1] .... node  #0, CPUs:   #2

[    2.062992][    T1] .... node  #1, CPUs:   #3

[    2.070654][    T1] smp: Brought up 2 nodes, 4 CPUs

[    2.080191][    T1] smpboot: Total of 4 processors activated =
(17999.96 BogoMIPS)

[    2.090724][    T1] Memory: 1224800K/2096632K available (171889K =
kernel code, 41437K rwdata, 40136K rodata, 27612K init, 121544K bss, =
812008K reserved, 0K cma-reserved)

[    2.101415][    T1] devtmpfs: initialized

[    2.105671][    T1] x86/mm: Memory block size: 128MB

[    2.185446][    T1] Running RCU synchronous self tests

[    2.187961][    T1] Running RCU synchronous self tests

[    2.191638][    T1] Running RCU Tasks wait API self tests

[    2.192792][    T1] Running RCU Tasks Trace wait API self tests

[    2.250260][    T1] clocksource: jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns

[    2.261115][    T1] posixtimers hash table entries: 2048 (order: 5, =
147456 bytes, vmalloc)

[    2.265239][    T1] futex hash table entries: 512 (65536 bytes on 2 =
NUMA nodes, total 128 KiB, linear).

[    2.277626][    T1] PM: RTC time: 00:47:38, date: 2025-07-24

[    2.315912][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol =
family

[    2.320232][   T44] Callback from call_rcu_tasks_trace() invoked.

[    2.342140][    T1] audit: initializing netlink subsys (disabled)

[    2.345175][   T45] audit: type=3D2000 audit(1753318058.334:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1

[    2.352275][    T1] thermal_sys: Registered thermal governor =
'step_wise'

[    2.352657][    T1] cpuidle: using governor menu

[    2.355965][    T1] NET: Registered PF_QIPCRTR protocol family

[    2.384071][    T1] dca service started, version 1.12.1

[    2.387198][    T1] PCI: Using configuration type 1 for base access

[    2.390188][    T1] PCI: Using configuration type 1 for extended =
access

[    2.412058][   T43] Callback from call_rcu_tasks() invoked.

[    2.422326][    T1] HugeTLB: allocation took 0ms with =
hugepage_allocation_threads=3D1

[    2.430603][    T1] HugeTLB: registered 1.00 GiB page size, =
pre-allocated 0 pages

[    2.436881][    T1] HugeTLB: 16380 KiB vmemmap can be freed for a =
1.00 GiB page

[    2.440209][    T1] HugeTLB: registered 2.00 MiB page size, =
pre-allocated 0 pages

[    2.446957][    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 =
MiB page

[    2.472828][    T1] raid6: skipped pq benchmark and selected avx512x4

[    2.476504][    T1] raid6: using avx512x2 recovery algorithm

[    2.487274][    T1] ACPI: Added _OSI(Module Device)

[    2.490042][    T1] ACPI: Added _OSI(Processor Device)

[    2.490209][    T1] ACPI: Added _OSI(Processor Aggregator Device)

[    2.611176][    T1] ACPI: 1 ACPI AML tables successfully acquired and =
loaded

[    2.648947][    T1] ACPI: Interpreter enabled

[    2.650820][    T1] ACPI: PM: (supports S0 S3 S4 S5)

[    2.653236][    T1] ACPI: Using IOAPIC for interrupt routing

[    2.656489][    T1] PCI: Using host bridge windows from ACPI; if =
necessary, use "pci=3Dnocrs" and report a bug

[    2.660187][    T1] PCI: Using E820 reservations for host bridge =
windows

[    2.670378][    T1] ACPI: Enabled 2 GPEs in block 00 to 0F

[    2.926931][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus =
00-ff])

[    2.930296][    T1] acpi PNP0A03:00: _OSC: OS supports =
[ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]

[    2.940688][    T1] PCI host bridge to bus 0000:00

[    2.942914][    T1] pci_bus 0000:00: Unknown NUMA node; performance =
will be reduced

[    2.946857][    T1] pci_bus 0000:00: root bus resource [io  =
0x0000-0x0cf7 window]

[    2.950212][    T1] pci_bus 0000:00: root bus resource [io  =
0x0d00-0xffff window]

[    2.953733][    T1] pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000bffff window]

[    2.957623][    T1] pci_bus 0000:00: root bus resource [mem =
0x80000000-0xfebfffff window]

[    2.960222][    T1] pci_bus 0000:00: root bus resource [mem =
0x100000000-0x17fffffff window]

[    2.964142][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]

[    2.968024][    T1] pci 0000:00:00.0: [8086:1237] type 00 class =
0x060000 conventional PCI endpoint

[    2.980080][    T1] pci 0000:00:01.0: [8086:7000] type 00 class =
0x060100 conventional PCI endpoint

[    2.988295][    T1] pci 0000:00:01.1: [8086:7010] type 00 class =
0x010180 conventional PCI endpoint

[    2.991936][    T1] pci 0000:00:01.1: BAR 4 [io  0xc060-0xc06f]

[    2.994855][    T1] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: =
legacy IDE quirk

[    2.998427][    T1] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE =
quirk

[    3.000203][    T1] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: =
legacy IDE quirk

[    3.003743][    T1] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE =
quirk

[    3.010211][    T1] pci 0000:00:01.3: [8086:7113] type 00 class =
0x068000 conventional PCI endpoint

[    3.016164][    T1] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] =
claimed by PIIX4 ACPI

[    3.019951][    T1] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] =
claimed by PIIX4 SMB

[    3.026801][    T1] pci 0000:00:02.0: [1234:1111] type 00 class =
0x030000 conventional PCI endpoint

[    3.034672][    T1] pci 0000:00:02.0: BAR 0 [mem =
0xfd000000-0xfdffffff pref]

[    3.038443][    T1] pci 0000:00:02.0: BAR 2 [mem =
0xfebb0000-0xfebb0fff]

[    3.040325][    T1] pci 0000:00:02.0: ROM [mem 0xfeba0000-0xfebaffff =
pref]

[    3.044498][    T1] pci 0000:00:02.0: Video device with shadowed ROM =
at [mem 0x000c0000-0x000dffff]

[    3.056001][    T1] pci 0000:00:03.0: [1af4:1005] type 00 class =
0x00ff00 conventional PCI endpoint

[    3.063299][    T1] pci 0000:00:03.0: BAR 0 [io  0xc040-0xc05f]

[    3.066223][    T1] pci 0000:00:03.0: BAR 4 [mem =
0xfe000000-0xfe003fff 64bit pref]

[    3.078249][    T1] pci 0000:00:04.0: [8086:100e] type 00 class =
0x020000 conventional PCI endpoint

[    3.082873][    T1] pci 0000:00:04.0: BAR 0 [mem =
0xfeb80000-0xfeb9ffff]

[    3.086032][    T1] pci 0000:00:04.0: BAR 1 [io  0xc000-0xc03f]

[    3.089070][    T1] pci 0000:00:04.0: ROM [mem 0xfeb00000-0xfeb7ffff =
pref]

[    3.130906][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ =
10

[    3.140887][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ =
10

[    3.150674][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ =
11

[    3.160459][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ =
11

[    3.166255][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ =
9

[    3.192533][    T1] iommu: Default domain type: Translated

[    3.192921][    T1] iommu: DMA domain TLB invalidation policy: lazy =
mode

[    3.208328][    T1] SCSI subsystem initialized

[    3.213089][    T1] ACPI: bus type USB registered

[    3.216550][    T1] usbcore: registered new interface driver usbfs

[    3.220722][    T1] usbcore: registered new interface driver hub

[    3.223849][    T1] usbcore: registered new device driver usb

[    3.229665][    T1] mc: Linux media interface: v0.10

[    3.230673][    T1] videodev: Linux video capture interface: v2.00

[    3.234784][    T1] pps_core: LinuxPPS API ver. 1 registered

[    3.237486][    T1] pps_core: Software ver. 5.3.6 - Copyright =
2005-2007 Rodolfo Giometti <giometti@linux.it>

[    3.240354][    T1] PTP clock support registered

[    3.243722][    T1] EDAC MC: Ver: 3.0.0

[    3.255334][    T1] Advanced Linux Sound Architecture Driver =
Initialized.

[    3.268054][    T1] Bluetooth: Core ver 2.22

[    3.270509][    T1] NET: Registered PF_BLUETOOTH protocol family

[    3.273361][    T1] Bluetooth: HCI device and connection manager =
initialized

[    3.276756][    T1] Bluetooth: HCI socket layer initialized

[    3.279500][    T1] Bluetooth: L2CAP socket layer initialized

[    3.280294][    T1] Bluetooth: SCO socket layer initialized

[    3.283035][    T1] NET: Registered PF_ATMPVC protocol family

[    3.285762][    T1] NET: Registered PF_ATMSVC protocol family

[    3.288972][    T1] NetLabel: Initializing

[    3.290187][    T1] NetLabel:  domain hash size =3D 128

[    3.292604][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 =
CALIPSO

[    3.296311][    T1] NetLabel:  unlabeled traffic allowed by default

[    3.302041][    T1] nfc: nfc_init: NFC Core ver 0.1

[    3.304946][    T1] NET: Registered PF_NFC protocol family

[    3.307775][    T1] PCI: Using ACPI for IRQ routing

[    3.311489][    T1] pci 0000:00:02.0: vgaarb: setting as boot VGA =
device

[    3.313521][    T1] pci 0000:00:02.0: vgaarb: bridge control possible

[    3.316464][    T1] pci 0000:00:02.0: vgaarb: VGA device added: =
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone

[    3.320649][    T1] vgaarb: loaded

[    3.339854][    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0

[    3.340186][    T1] hpet0: 3 comparators, 64-bit 100.000000 MHz =
counter

[    3.348670][    T1] clocksource: Switched to clocksource kvm-clock

[    3.361032][    T1] VFS: Disk quotas dquot_6.6.0

[    3.363495][    T1] VFS: Dquot-cache hash table entries: 512 (order =
0, 4096 bytes)

[    3.372151][    T1] netfs: FS-Cache loaded

[    3.376124][    T1] CacheFiles: Loaded

[    3.378896][    T1] TOMOYO: 2.6.0

[    3.380490][    T1] Mandatory Access Control activated.

[    3.383547][    T1] pnp: PnP ACPI init

[    3.411206][    T1] pnp: PnP ACPI: found 6 devices

[    3.516889][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: =
0xffffff, max_idle_ns: 2085701024 ns

[    3.522795][    T1] NET: Registered PF_INET protocol family

[    3.527417][    T1] IP idents hash table entries: 32768 (order: 6, =
262144 bytes, vmalloc)

[    3.554208][    T1] tcp_listen_portaddr_hash hash table entries: 1024 =
(order: 4, 73728 bytes, vmalloc)

[    3.560941][    T1] Table-perturb hash table entries: 65536 (order: =
6, 262144 bytes, vmalloc)

[    3.565873][    T1] TCP established hash table entries: 16384 (order: =
5, 131072 bytes, vmalloc)

[    3.574793][    T1] TCP bind hash table entries: 16384 (order: 9, =
2359296 bytes, vmalloc hugepage)

[    3.581379][    T1] TCP: Hash tables configured (established 16384 =
bind 16384)

[    3.587764][    T1] MPTCP token hash table entries: 2048 (order: 5, =
180224 bytes, vmalloc)

[    3.593449][    T1] UDP hash table entries: 1024 (order: 6, 262144 =
bytes, vmalloc)

[    3.598870][    T1] UDP-Lite hash table entries: 1024 (order: 6, =
262144 bytes, vmalloc)

[    3.604274][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family

[    3.612276][    T1] RPC: Registered named UNIX socket transport =
module.

[    3.615435][    T1] RPC: Registered udp transport module.

[    3.617970][    T1] RPC: Registered tcp transport module.

[    3.620454][    T1] RPC: Registered tcp-with-tls transport module.

[    3.623252][    T1] RPC: Registered tcp NFSv4.1 backchannel transport =
module.

[    3.633779][    T1] NET: Registered PF_XDP protocol family

[    3.636408][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 =
window]

[    3.639787][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff =
window]

[    3.643081][    T1] pci_bus 0000:00: resource 6 [mem =
0x000a0000-0x000bffff window]

[    3.646702][    T1] pci_bus 0000:00: resource 7 [mem =
0x80000000-0xfebfffff window]

[    3.650389][    T1] pci_bus 0000:00: resource 8 [mem =
0x100000000-0x17fffffff window]

[    3.655792][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release

[    3.659057][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI =
transfers

[    3.662904][    T1] PCI: CLS 0 bytes, default 64

[    3.667242][    T1] ACPI: bus type thunderbolt registered

[    3.678148][   T81] kworker/u20:0 (81) used greatest stack depth: =
27944 bytes left

[    3.681878][   T80] kworker/u20:0 (80) used greatest stack depth: =
27032 bytes left

[    3.691870][    T1] kvm_intel: VMX not supported by CPU 3

[    3.695009][    T1] kvm_amd: Nested Virtualization enabled

[    3.697749][    T1] kvm_amd: Nested Paging enabled

[   25.323851][    T1] Initialise system trusted keyrings

[   25.329032][    T1] workingset: timestamp_bits=3D40 max_order=3D19 =
bucket_order=3D0

[   25.340805][    T1] DLM installed

[   25.347900][    T1] squashfs: version 4.0 (2009/01/31) Phillip =
Lougher

[   25.359324][    T1] NFS: Registering the id_resolver key type

[   25.362322][    T1] Key type id_resolver registered

[   25.364685][    T1] Key type id_legacy registered

[   25.368050][    T1] nfs4filelayout_init: NFSv4 File Layout Driver =
Registering...

[   25.371639][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout =
Driver Registering...

[   25.391920][    T1] Key type cifs.spnego registered

[   25.394522][    T1] Key type cifs.idmap registered

[   25.401042][    T1] ntfs3: Enabled Linux POSIX ACLs support

[   25.403692][    T1] ntfs3: Read-only LZX/Xpress compression included

[   25.407200][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/

[   25.409995][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 =
2001-2006 Red Hat, Inc.

[   25.416989][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.

[   25.419816][    T1] QNX4 filesystem 0.2.3 registered.

[   25.422339][    T1] qnx6: QNX6 filesystem 1.0.0 registered.

[   25.426243][    T1] fuse: init (API version 7.44)

[   25.432894][    T1] orangefs_debugfs_init: called with debug mask: =
:none: :0:

[   25.438113][    T1] orangefs_init: module version upstream loaded

[   25.441937][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536

[   25.489874][    T1] SGI XFS with ACLs, security attributes, realtime, =
quota, no debug enabled

[   25.500045][    T1] 9p: Installing v9fs 9p2000 file system support

[   25.503676][    T1] NILFS version 2 loaded

[   25.505637][    T1] befs: version: 0.9.3

[   25.508499][    T1] ocfs2: Registered cluster interface o2cb

[   25.512366][    T1] ocfs2: Registered cluster interface user

[   25.515977][    T1] OCFS2 User DLM kernel interface loaded

[   25.542151][    T1] gfs2: GFS2 installed

[   25.562154][    T1] ceph: loaded (mds proto 32)

[   25.579162][    T1] cryptd: max_cpu_qlen set to 1000

[   25.638161][    T1] NET: Registered PF_ALG protocol family

[   25.641423][    T1] xor: automatically using best checksumming =
function   avx      =20

[   25.645153][    T1] async_tx: api initialized (async)

[   25.647845][    T1] Key type asymmetric registered

[   25.650187][    T1] Asymmetric key parser 'x509' registered

[   25.652867][    T1] Asymmetric key parser 'pkcs8' registered

[   25.655548][    T1] Key type pkcs7_test registered

[   25.659173][    T1] Block layer SCSI generic (bsg) driver version 0.4 =
loaded (major 238)

[   25.664615][    T1] io scheduler mq-deadline registered

[   25.667175][    T1] io scheduler kyber registered

[   25.669829][    T1] io scheduler bfq registered

[   25.685321][    T1] input: Power Button as =
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0

[   25.698302][    T1] ACPI: button: Power Button [PWRF]

[   25.723635][    T1] ioatdma: Intel(R) QuickData Technology Driver =
5.00

[   31.755990][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11

[   32.483519][    T1] N_HDLC line discipline registered with =
maxframe=3D4096

[   32.487390][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing =
enabled

[   32.497431][    T1] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D=
 115200) is a 16550A

[   32.548472][    T1] Non-volatile memory driver v1.3

[   32.556245][    T1] Linux agpgart interface v0.103

[   32.566348][    T1] usbcore: registered new interface driver xillyusb

[   32.576958][    T1] ACPI: bus type drm_connector registered

[   32.590263][    T1] [drm] Initialized vgem 1.0.0 for vgem on minor 0

[   32.603361][    T1] [drm] Initialized vkms 1.0.0 for vkms on minor 1

[   32.713705][    T1] Console: switching to colour frame buffer device =
128x48

[   32.738548][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer =
device

[   32.743178][    T1] usbcore: registered new interface driver udl

[   32.748677][    T1] bochs-drm 0000:00:02.0: vgaarb: deactivate vga =
console

[   32.762817][    T1] [drm] Found bochs VGA, ID 0xb0c0.

[   32.765273][    T1] [drm] Framebuffer size 16384 kB @ 0xfd000000, =
mmio @ 0xfebb0000.

[   32.776041][    T1] [drm] Initialized bochs-drm 1.0.0 for =
0000:00:02.0 on minor 2

[   32.821261][    T1] fbcon: bochs-drmdrmfb (fb1) is primary device

[   32.821295][    T1] fbcon: Remapping primary device, fb1, to tty 1-63

[   34.923804][    T1] bochs-drm 0000:00:02.0: [drm] fb1: bochs-drmdrmfb =
frame buffer device

[   34.930541][    T1] usbcore: registered new interface driver gm12u320

[   34.934153][    T1] usbcore: registered new interface driver gud

[   35.089158][    T1] brd: module loaded

[   35.421537][    T1] loop: module loaded

[   35.758101][    T1] zram: Added device: zram0

[   35.778428][    T1] null_blk: disk nullb0 created

[   35.780698][    T1] null_blk: module loaded

[   35.786783][    T1] Guest personality initialized and is inactive

[   35.791536][    T1] VMCI host device registered (name=3Dvmci, =
major=3D10, minor=3D265)

[   35.795014][    T1] Initialized host personality

[   35.798397][    T1] usbcore: registered new interface driver rtsx_usb

[   35.806011][    T1] usbcore: registered new interface driver =
viperboard

[   35.811906][    T1] usbcore: registered new interface driver dln2

[   35.817154][    T1] usbcore: registered new interface driver =
pn533_usb

[   35.828832][    T1] nfcsim 0.2 initialized

[   35.831544][    T1] usbcore: registered new interface driver port100

[   35.835181][    T1] usbcore: registered new interface driver nfcmrvl

[   35.847133][    T1] Loading iSCSI transport class v2.0-870.

[   35.866223][    T1] st: Version 20160209, fixed bufsize 32768, s/g =
segs 256

[   35.939252][    T1] scsi host0: ata_piix

[   35.950360][    T1] scsi host1: ata_piix

[   35.955552][    T1] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma =
0xc060 irq 14 lpm-pol 0

[   35.959628][    T1] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma =
0xc068 irq 15 lpm-pol 0

[   35.971222][    T1] Rounding down aligned max_sectors from 4294967295 =
to 4294967288

[   35.975917][    T1] db_root: cannot open: /etc/target

[   35.980118][    T1] slram: not enough parameters.

[   35.992329][    T1] ftl_cs: FTL header not found.

[   36.050110][    T1] wireguard: WireGuard 1.0.0 loaded. See =
www.wireguard.com for information.

[   36.054205][    T1] wireguard: Copyright (C) 2015-2019 Jason A. =
Donenfeld <Jason@zx2c4.com>. All Rights Reserved.

[   36.061475][    T1] eql: Equalizer2002: Simon Janes (simon@ncm.com) =
and David S. Miller (davem@redhat.com)

[   36.083597][    T1] MACsec IEEE 802.1AE

[   36.107428][    T1] usbcore: registered new interface driver =
mvusb_mdio

[   36.111109][    T1] tun: Universal TUN/TAP device driver, 1.6

[   36.116968][    T1] vcan: Virtual CAN interface driver

[   36.118745][ T1088] ata2: found unknown device (class 0)

[   36.119576][    T1] vxcan: Virtual CAN Tunnel driver

[   36.125207][    T1] slcan: serial line CAN interface driver

[   36.125230][ T1083] ata1: found unknown device (class 0)

[   36.128249][    T1] CAN device driver interface

[   36.133419][ T1088] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100

[   36.134631][    T1] usbcore: registered new interface driver usb_8dev

[   36.139429][ T1083] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100

[   36.140863][    T1] usbcore: registered new interface driver ems_usb

[   36.143869][ T1083] ata1.00: 4194304 sectors, multi 16: LBA48=20

[   36.147609][    T1] usbcore: registered new interface driver esd_usb

[   36.154663][    T1] usbcore: registered new interface driver =
etas_es58x

[   36.158625][    T1] usbcore: registered new interface driver f81604

[   36.162399][    T1] usbcore: registered new interface driver gs_usb

[   36.162770][   T39] scsi 0:0:0:0: Direct-Access     ATA      QEMU =
HARDDISK    2.5+ PQ: 0 ANSI: 5

[   36.166608][    T1] usbcore: registered new interface driver =
kvaser_usb

[   36.173388][    T1] usbcore: registered new interface driver mcba_usb

[   36.177179][    T1] usbcore: registered new interface driver peak_usb

[   36.180927][    T1] usbcore: registered new interface driver ucan

[   36.183900][   T39] sd 0:0:0:0: Attached scsi generic sg0 type 0

[   36.184737][    T1] e100: Intel(R) PRO/100 Network Driver

[   36.188751][   T79] sd 0:0:0:0: [sda] 4194304 512-byte logical =
blocks: (2.15 GB/2.00 GiB)

[   36.189540][    T1] e100: Copyright(c) 1999-2006 Intel Corporation

[   36.194478][   T79] sd 0:0:0:0: [sda] Write Protect is off

[   36.197084][    T1] e1000: Intel(R) PRO/1000 Network Driver

[   36.198866][ T1029] scsi 1:0:0:0: CD-ROM            QEMU     QEMU =
DVD-ROM     2.5+ PQ: 0 ANSI: 5

[   36.201745][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.

[   36.206457][   T79] sd 0:0:0:0: [sda] Write cache: enabled, read =
cache: enabled, doesn't support DPO or FUA

[   36.214540][   T79] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 =
bytes

[   36.422552][   T79] sd 0:0:0:0: [sda] Attached SCSI disk

[   36.609740][ T1029] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw =
xa/form2 tray

[   36.613350][ T1029] cdrom: Uniform CD-ROM driver Revision: 3.20

[   36.740896][ T1029] sr 1:0:0:0: Attached scsi generic sg1 type 5

[   42.426433][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10

[   42.919073][    T1] e1000 0000:00:04.0 eth0: (PCI:33MHz:32-bit) =
52:54:00:12:34:56

[   42.922739][    T1] e1000 0000:00:04.0 eth0: Intel(R) PRO/1000 =
Network Connection

[   42.928143][    T1] e1000e: Intel(R) PRO/1000 Network Driver

[   42.930773][    T1] e1000e: Copyright(c) 1999 - 2015 Intel =
Corporation.

[   42.936943][    T1] mkiss: AX.25 Multikiss, Hans Albas PE1AYX

[   42.939846][    T1] AX.25: bpqether driver version 004

[   42.942327][    T1] PPP generic driver version 2.4.2

[   42.947318][    T1] PPP BSD Compression module registered

[   42.949944][    T1] PPP Deflate Compression module registered

[   42.952730][    T1] PPP MPPE Compression module registered

[   42.955350][    T1] NET: Registered PF_PPPOX protocol family

[   42.958330][    T1] PPTP driver version 0.8.5

[   42.962989][    T1] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic =
channels, max=3D256) (6 bit encapsulation enabled).

[   42.968374][    T1] CSLIP: code copyright 1989 Regents of the =
University of California.

[   42.972170][    T1] SLIP linefill/keepalive option.

[   42.974528][    T1] hdlc: HDLC support module revision 1.22

[   42.977577][    T1] LAPB Ethernet driver version 0.02

[   42.982702][    T1] usbcore: registered new interface driver =
ath9k_htc

[   42.987132][    T1] usbcore: registered new interface driver carl9170

[   42.991046][    T1] usbcore: registered new interface driver =
ath6kl_usb

[   42.994930][    T1] usbcore: registered new interface driver ar5523

[   43.000127][    T1] usbcore: registered new interface driver =
ath10k_usb

[   43.004297][    T1] usbcore: registered new interface driver plfxlc

[   43.008243][    T1] mac80211_hwsim: initializing netlink

[   43.066954][    T1] usbcore: registered new interface driver atusb

[   43.093983][    T1] mac802154_hwsim mac802154_hwsim: Added 2 =
mac802154 hwsim hardware radios

[   43.099416][    T1] VMware vmxnet3 virtual NIC driver - version =
1.9.0.0-k-NAPI

[   43.103848][    T1] usbcore: registered new interface driver catc

[   43.108510][    T1] usbcore: registered new interface driver kaweth

[   43.111366][    T1] pegasus: Pegasus/Pegasus II USB Ethernet driver

[   43.115540][    T1] usbcore: registered new interface driver pegasus

[   43.119072][    T1] usbcore: registered new interface driver rtl8150

[   43.122326][    T1] usbcore: registered new device driver =
r8152-cfgselector

[   43.126088][    T1] usbcore: registered new interface driver r8152

[   43.130313][    T1] usbcore: registered new interface driver hso

[   43.134136][    T1] usbcore: registered new interface driver lan78xx

[   43.138325][    T1] usbcore: registered new interface driver asix

[   43.142206][    T1] usbcore: registered new interface driver =
ax88179_178a

[   43.146326][    T1] usbcore: registered new interface driver =
cdc_ether

[   43.150753][    T1] usbcore: registered new interface driver cdc_eem

[   43.154919][    T1] usbcore: registered new interface driver dm9601

[   43.158897][    T1] usbcore: registered new interface driver sr9700

[   43.162826][    T1] usbcore: registered new interface driver =
CoreChips

[   43.166965][    T1] usbcore: registered new interface driver smsc75xx

[   43.170994][    T1] usbcore: registered new interface driver smsc95xx

[   43.175526][    T1] usbcore: registered new interface driver gl620a

[   43.180668][    T1] usbcore: registered new interface driver net1080

[   43.184896][    T1] usbcore: registered new interface driver plusb

[   43.189059][    T1] usbcore: registered new interface driver =
rndis_host

[   43.193710][    T1] usbcore: registered new interface driver =
cdc_subset

[   43.198608][    T1] usbcore: registered new interface driver zaurus

[   43.202457][    T1] usbcore: registered new interface driver MOSCHIP =
usb-ethernet driver

[   43.207907][    T1] usbcore: registered new interface driver int51x1

[   43.213157][    T1] usbcore: registered new interface driver =
cdc_phonet

[   43.218806][    T1] usbcore: registered new interface driver kalmia

[   43.223413][    T1] usbcore: registered new interface driver ipheth

[   43.227497][    T1] usbcore: registered new interface driver =
sierra_net

[   43.232665][    T1] usbcore: registered new interface driver =
cx82310_eth

[   43.237592][    T1] usbcore: registered new interface driver cdc_ncm

[   43.242538][    T1] usbcore: registered new interface driver =
huawei_cdc_ncm

[   43.247487][    T1] usbcore: registered new interface driver lg-vl600

[   43.252415][    T1] usbcore: registered new interface driver qmi_wwan

[   43.257082][    T1] usbcore: registered new interface driver cdc_mbim

[   43.260946][    T1] usbcore: registered new interface driver ch9200

[   43.265227][    T1] usbcore: registered new interface driver aqc111

[   43.269734][    T1] usbcore: registered new interface driver =
r8153_ecm

[   43.284827][    T1] VFIO - User Level meta-driver version: 0.3

[   43.300994][    T1] aoe: AoE v85 initialised.

[   43.325325][    T1] usbcore: registered new interface driver cdc_acm

[   43.331613][    T1] cdc_acm: USB Abstract Control Model driver for =
USB modems and ISDN adapters

[   43.336543][    T1] usbcore: registered new interface driver usblp

[   43.340710][    T1] usbcore: registered new interface driver cdc_wdm

[   43.344865][    T1] usbcore: registered new interface driver usbtmc

[   43.349676][    T1] usbcore: registered new interface driver uas

[   43.353734][    T1] usbcore: registered new interface driver =
usb-storage

[   43.358048][    T1] usbcore: registered new interface driver =
ums-alauda

[   43.361779][    T1] usbcore: registered new interface driver =
ums-cypress

[   43.365429][    T1] usbcore: registered new interface driver =
ums-datafab

[   43.369310][    T1] usbcore: registered new interface driver =
ums_eneub6250

[   43.373637][    T1] usbcore: registered new interface driver =
ums-freecom

[   43.377493][    T1] usbcore: registered new interface driver =
ums-isd200

[   43.381154][    T1] usbcore: registered new interface driver =
ums-jumpshot

[   43.384885][    T1] usbcore: registered new interface driver =
ums-karma

[   43.389239][    T1] usbcore: registered new interface driver =
ums-onetouch

[   43.393586][    T1] usbcore: registered new interface driver =
ums-realtek

[   43.400204][    T1] usbcore: registered new interface driver =
ums-sddr09

[   43.404444][    T1] usbcore: registered new interface driver =
ums-sddr55

[   43.408828][    T1] usbcore: registered new interface driver =
ums-usbat

[   43.413399][    T1] usbcore: registered new interface driver mdc800

[   43.416418][    T1] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek =
MDC800 Digital Camera

[   43.421594][    T1] usbcore: registered new interface driver =
microtekX6

[   43.427010][    T1] usbcore: registered new interface driver =
usbserial_generic

[   43.432118][    T1] usbserial: USB Serial support registered for =
generic

[   43.437400][    T1] usbcore: registered new interface driver aircable

[   43.441437][    T1] usbserial: USB Serial support registered for =
aircable

[   43.445500][    T1] usbcore: registered new interface driver ark3116

[   43.449538][    T1] usbserial: USB Serial support registered for =
ark3116

[   43.453816][    T1] usbcore: registered new interface driver =
belkin_sa

[   43.457942][    T1] usbserial: USB Serial support registered for =
Belkin / Peracom / GoHubs USB Serial Adapter

[   43.463706][    T1] usbcore: registered new interface driver ch341

[   43.467731][    T1] usbserial: USB Serial support registered for =
ch341-uart

[   43.472165][    T1] usbcore: registered new interface driver cp210x

[   43.476025][    T1] usbserial: USB Serial support registered for =
cp210x

[   43.483293][    T1] usbcore: registered new interface driver =
cyberjack

[   43.486855][    T1] usbserial: USB Serial support registered for =
Reiner SCT Cyberjack USB card reader

[   43.492297][    T1] usbcore: registered new interface driver =
cypress_m8

[   43.496356][    T1] usbserial: USB Serial support registered for =
DeLorme Earthmate USB

[   43.501078][    T1] usbserial: USB Serial support registered for =
HID->COM RS232 Adapter

[   43.505740][    T1] usbserial: USB Serial support registered for =
Nokia CA-42 V2 Adapter

[   43.510691][    T1] usbcore: registered new interface driver =
usb_debug

[   43.514675][    T1] usbserial: USB Serial support registered for =
debug

[   43.518784][    T1] usbserial: USB Serial support registered for =
xhci_dbc

[   43.523089][    T1] usbcore: registered new interface driver =
digi_acceleport

[   43.527337][    T1] usbserial: USB Serial support registered for Digi =
2 port USB adapter

[   43.532076][    T1] usbserial: USB Serial support registered for Digi =
4 port USB adapter

[   43.537091][    T1] usbcore: registered new interface driver =
io_edgeport

[   43.541162][    T1] usbserial: USB Serial support registered for =
Edgeport 2 port adapter

[   43.546128][    T1] usbserial: USB Serial support registered for =
Edgeport 4 port adapter

[   43.550373][    T1] usbserial: USB Serial support registered for =
Edgeport 8 port adapter

[   43.554559][    T1] usbserial: USB Serial support registered for EPiC =
device

[   43.559258][    T1] usbcore: registered new interface driver io_ti

[   43.563116][    T1] usbserial: USB Serial support registered for =
Edgeport TI 1 port adapter

[   43.567958][    T1] usbserial: USB Serial support registered for =
Edgeport TI 2 port adapter

[   43.573054][    T1] usbcore: registered new interface driver empeg

[   43.576938][    T1] usbserial: USB Serial support registered for =
empeg

[   43.581031][    T1] usbcore: registered new interface driver =
f81534a_ctrl

[   43.584825][    T1] usbcore: registered new interface driver f81232

[   43.589583][    T1] usbserial: USB Serial support registered for =
f81232

[   43.593487][    T1] usbserial: USB Serial support registered for =
f81534a

[   43.597681][    T1] usbcore: registered new interface driver f81534

[   43.601421][    T1] usbserial: USB Serial support registered for =
Fintek F81532/F81534

[   43.606025][    T1] usbcore: registered new interface driver ftdi_sio

[   43.609824][    T1] usbserial: USB Serial support registered for FTDI =
USB Serial Device

[   43.613973][    T1] usbcore: registered new interface driver =
garmin_gps

[   43.617638][    T1] usbserial: USB Serial support registered for =
Garmin GPS usb/tty

[   43.621611][    T1] usbcore: registered new interface driver ipaq

[   43.624709][    T1] usbserial: USB Serial support registered for =
PocketPC PDA

[   43.628552][    T1] usbcore: registered new interface driver ipw

[   43.631662][    T1] usbserial: USB Serial support registered for =
IPWireless converter

[   43.635653][    T1] usbcore: registered new interface driver ir_usb

[   43.639245][    T1] usbserial: USB Serial support registered for IR =
Dongle

[   43.643395][    T1] usbcore: registered new interface driver =
iuu_phoenix

[   43.647304][    T1] usbserial: USB Serial support registered for =
iuu_phoenix

[   43.651466][    T1] usbcore: registered new interface driver keyspan

[   43.655162][    T1] usbserial: USB Serial support registered for =
Keyspan - (without firmware)

[   43.660098][    T1] usbserial: USB Serial support registered for =
Keyspan 1 port adapter

[   43.664532][    T1] usbserial: USB Serial support registered for =
Keyspan 2 port adapter

[   43.669050][    T1] usbserial: USB Serial support registered for =
Keyspan 4 port adapter

[   43.673687][    T1] usbcore: registered new interface driver =
keyspan_pda

[   43.677634][    T1] usbserial: USB Serial support registered for =
Keyspan PDA

[   43.681631][    T1] usbserial: USB Serial support registered for =
Keyspan PDA - (prerenumeration)

[   43.686540][    T1] usbcore: registered new interface driver =
kl5kusb105

[   43.690425][    T1] usbserial: USB Serial support registered for =
KL5KUSB105D / PalmConnect

[   43.695148][    T1] usbcore: registered new interface driver =
kobil_sct

[   43.699937][    T1] usbserial: USB Serial support registered for =
KOBIL USB smart card terminal

[   43.704790][    T1] usbcore: registered new interface driver mct_u232

[   43.708658][    T1] usbserial: USB Serial support registered for MCT =
U232

[   43.712728][    T1] usbcore: registered new interface driver =
metro_usb

[   43.716500][    T1] usbserial: USB Serial support registered for =
Metrologic USB to Serial

[   43.721249][    T1] usbcore: registered new interface driver mos7720

[   43.724937][    T1] usbserial: USB Serial support registered for =
Moschip 2 port adapter

[   43.729587][    T1] usbcore: registered new interface driver mos7840

[   43.733306][    T1] usbserial: USB Serial support registered for =
Moschip 7840/7820 USB Serial Driver

[   43.737937][    T1] usbcore: registered new interface driver mxuport

[   43.741693][    T1] usbserial: USB Serial support registered for MOXA =
UPort

[   43.745873][    T1] usbcore: registered new interface driver navman

[   43.749656][    T1] usbserial: USB Serial support registered for =
navman

[   43.753666][    T1] usbcore: registered new interface driver omninet

[   43.757408][    T1] usbserial: USB Serial support registered for =
ZyXEL - omni.net usb

[   43.761925][    T1] usbcore: registered new interface driver opticon

[   43.765613][    T1] usbserial: USB Serial support registered for =
opticon

[   43.769278][    T1] usbcore: registered new interface driver option

[   43.772377][    T1] usbserial: USB Serial support registered for GSM =
modem (1-port)

[   43.776306][    T1] usbcore: registered new interface driver oti6858

[   43.780152][    T1] usbserial: USB Serial support registered for =
oti6858

[   43.784229][    T1] usbcore: registered new interface driver pl2303

[   43.787948][    T1] usbserial: USB Serial support registered for =
pl2303

[   43.791929][    T1] usbcore: registered new interface driver qcaux

[   43.795578][    T1] usbserial: USB Serial support registered for =
qcaux

[   43.799585][    T1] usbcore: registered new interface driver qcserial

[   43.803317][    T1] usbserial: USB Serial support registered for =
Qualcomm USB modem

[   43.810255][    T1] usbcore: registered new interface driver quatech2

[   43.813985][    T1] usbserial: USB Serial support registered for =
Quatech 2nd gen USB to Serial Driver

[   43.819165][    T1] usbcore: registered new interface driver =
safe_serial

[   43.823023][    T1] usbserial: USB Serial support registered for =
safe_serial

[   43.827278][    T1] usbcore: registered new interface driver sierra

[   43.830930][    T1] usbserial: USB Serial support registered for =
Sierra USB modem

[   43.835314][    T1] usbcore: registered new interface driver =
usb_serial_simple

[   43.839448][    T1] usbserial: USB Serial support registered for =
carelink

[   43.843337][    T1] usbserial: USB Serial support registered for =
flashloader

[   43.846871][    T1] usbserial: USB Serial support registered for =
funsoft

[   43.850722][    T1] usbserial: USB Serial support registered for =
google

[   43.854540][    T1] usbserial: USB Serial support registered for hp4x

[   43.858373][    T1] usbserial: USB Serial support registered for =
kaufmann

[   43.862353][    T1] usbserial: USB Serial support registered for =
libtransistor

[   43.866440][    T1] usbserial: USB Serial support registered for =
moto_modem

[   43.870511][    T1] usbserial: USB Serial support registered for =
motorola_tetra

[   43.874718][    T1] usbserial: USB Serial support registered for =
nokia

[   43.878599][    T1] usbserial: USB Serial support registered for =
novatel_gps

[   43.882581][    T1] usbserial: USB Serial support registered for owon

[   43.886601][    T1] usbserial: USB Serial support registered for =
siemens_mpi

[   43.890215][    T1] usbserial: USB Serial support registered for =
suunto

[   43.893464][    T1] usbserial: USB Serial support registered for =
vivopay

[   43.897954][    T1] usbserial: USB Serial support registered for zio

[   43.901882][    T1] usbcore: registered new interface driver spcp8x5

[   43.905579][    T1] usbserial: USB Serial support registered for =
SPCP8x5

[   43.909678][    T1] usbcore: registered new interface driver ssu100

[   43.913377][    T1] usbserial: USB Serial support registered for =
Quatech SSU-100 USB to Serial Driver

[   43.918593][    T1] usbcore: registered new interface driver =
symbolserial

[   43.922496][    T1] usbserial: USB Serial support registered for =
symbol

[   43.926480][    T1] usbcore: registered new interface driver =
ti_usb_3410_5052

[   43.930796][    T1] usbserial: USB Serial support registered for TI =
USB 3410 1 port adapter

[   43.935402][    T1] usbserial: USB Serial support registered for TI =
USB 5052 2 port adapter

[   43.940317][    T1] usbcore: registered new interface driver =
upd78f0730

[   43.946490][    T1] usbserial: USB Serial support registered for =
upd78f0730

[   43.950800][    T1] usbcore: registered new interface driver visor

[   43.954483][    T1] usbserial: USB Serial support registered for =
Handspring Visor / Palm OS

[   43.958671][    T1] usbserial: USB Serial support registered for Sony =
Clie 5.0

[   43.962230][    T1] usbserial: USB Serial support registered for Sony =
Clie 3.5

[   43.965979][    T1] usbcore: registered new interface driver =
wishbone_serial

[   43.970171][    T1] usbserial: USB Serial support registered for =
wishbone_serial

[   43.974606][    T1] usbcore: registered new interface driver =
whiteheat

[   43.978540][    T1] usbserial: USB Serial support registered for =
Connect Tech - WhiteHEAT - (prerenumeration)

[   43.983910][    T1] usbserial: USB Serial support registered for =
Connect Tech - WhiteHEAT

[   43.988754][    T1] usbcore: registered new interface driver =
xr_serial

[   43.993159][    T1] usbserial: USB Serial support registered for =
xr_serial

[   43.998113][    T1] usbcore: registered new interface driver xsens_mt

[   44.002636][    T1] usbserial: USB Serial support registered for =
xsens_mt

[   44.007807][    T1] usbcore: registered new interface driver adutux

[   44.012678][    T1] usbcore: registered new interface driver =
appledisplay

[   44.017211][    T1] usbcore: registered new interface driver =
cypress_cy7c63

[   44.021637][    T1] usbcore: registered new interface driver cytherm

[   44.025707][    T1] usbcore: registered new interface driver emi26 - =
firmware loader

[   44.030495][    T1] usbcore: registered new interface driver emi62 - =
firmware loader

[   44.034902][    T1] usbcore: registered new device driver =
apple-mfi-fastcharge

[   44.039411][    T1] usbcore: registered new interface driver ljca

[   44.043337][    T1] usbcore: registered new interface driver idmouse

[   44.047696][    T1] usbcore: registered new interface driver =
iowarrior

[   44.051942][    T1] usbcore: registered new interface driver =
isight_firmware

[   44.056357][    T1] usbcore: registered new interface driver usblcd

[   44.060495][    T1] usbcore: registered new interface driver ldusb

[   44.064483][    T1] usbcore: registered new interface driver =
legousbtower

[   44.068839][    T1] usbcore: registered new interface driver usbtest

[   44.072956][    T1] usbcore: registered new interface driver =
usb_ehset_test

[   44.077406][    T1] usbcore: registered new interface driver =
trancevibrator

[   44.082070][    T1] usbcore: registered new interface driver uss720

[   44.084995][    T1] uss720: USB Parport Cable driver for Cables using =
the Lucent Technologies USS720 Chip

[   44.089438][    T1] uss720: NOTE: this is a special purpose driver to =
allow nonstandard

[   44.093105][    T1] uss720: protocols (eg. bitbang) over USS720 usb =
to parallel cables

[   44.096796][    T1] uss720: If you just want to connect to a printer, =
use usblp instead

[   44.101615][    T1] usbcore: registered new interface driver =
usbsevseg

[   44.105745][    T1] usbcore: registered new interface driver yurex

[   44.113329][    T1] usbcore: registered new interface driver chaoskey

[   44.117100][    T1] usbcore: registered new interface driver sisusb

[   44.121171][    T1] usbcore: registered new interface driver lvs

[   44.125105][    T1] usbcore: registered new interface driver cxacru

[   44.129269][    T1] usbcore: registered new interface driver speedtch

[   44.133404][    T1] usbcore: registered new interface driver =
ueagle-atm

[   44.136466][    T1] xusbatm: malformed module parameters

[   44.148004][    T1] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.151840][    T1] dummy_hcd dummy_hcd.0: Dummy host controller

[   44.158780][    T1] dummy_hcd dummy_hcd.0: new USB bus registered, =
assigned bus number 1

[   44.165549][    T1] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.170172][    T1] usb usb1: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.174026][    T1] usb usb1: Product: Dummy host controller

[   44.176871][    T1] usb usb1: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.180073][    T1] usb usb1: SerialNumber: dummy_hcd.0

[   44.190786][    T1] hub 1-0:1.0: USB hub found

[   44.193558][    T1] hub 1-0:1.0: 1 port detected

[   44.209158][    T1] dummy_hcd dummy_hcd.1: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.213098][    T1] dummy_hcd dummy_hcd.1: Dummy host controller

[   44.218119][    T1] dummy_hcd dummy_hcd.1: new USB bus registered, =
assigned bus number 2

[   44.223656][    T1] usb usb2: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.228016][    T1] usb usb2: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.231769][    T1] usb usb2: Product: Dummy host controller

[   44.234482][    T1] usb usb2: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.238180][    T1] usb usb2: SerialNumber: dummy_hcd.1

[   44.246831][    T1] hub 2-0:1.0: USB hub found

[   44.249364][    T1] hub 2-0:1.0: 1 port detected

[   44.259788][    T1] dummy_hcd dummy_hcd.2: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.263788][    T1] dummy_hcd dummy_hcd.2: Dummy host controller

[   44.269572][    T1] dummy_hcd dummy_hcd.2: new USB bus registered, =
assigned bus number 3

[   44.275610][    T1] usb usb3: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.280681][    T1] usb usb3: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.284805][    T1] usb usb3: Product: Dummy host controller

[   44.287620][    T1] usb usb3: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.291343][    T1] usb usb3: SerialNumber: dummy_hcd.2

[   44.300862][    T1] hub 3-0:1.0: USB hub found

[   44.303385][    T1] hub 3-0:1.0: 1 port detected

[   44.313657][    T1] dummy_hcd dummy_hcd.3: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.317685][    T1] dummy_hcd dummy_hcd.3: Dummy host controller

[   44.322108][    T1] dummy_hcd dummy_hcd.3: new USB bus registered, =
assigned bus number 4

[   44.328272][    T1] usb usb4: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.332538][    T1] usb usb4: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.336284][    T1] usb usb4: Product: Dummy host controller

[   44.339175][    T1] usb usb4: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.342301][    T1] usb usb4: SerialNumber: dummy_hcd.3

[   44.351436][    T1] hub 4-0:1.0: USB hub found

[   44.354203][    T1] hub 4-0:1.0: 1 port detected

[   44.364451][    T1] dummy_hcd dummy_hcd.4: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.368418][    T1] dummy_hcd dummy_hcd.4: Dummy host controller

[   44.373493][    T1] dummy_hcd dummy_hcd.4: new USB bus registered, =
assigned bus number 5

[   44.379111][    T1] usb usb5: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.383358][    T1] usb usb5: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.387246][    T1] usb usb5: Product: Dummy host controller

[   44.389995][    T1] usb usb5: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.393137][    T1] usb usb5: SerialNumber: dummy_hcd.4

[   44.402279][    T1] hub 5-0:1.0: USB hub found

[   44.404820][    T1] hub 5-0:1.0: 1 port detected

[   44.415847][    T1] dummy_hcd dummy_hcd.5: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.420611][    T1] dummy_hcd dummy_hcd.5: Dummy host controller

[   44.425034][    T1] dummy_hcd dummy_hcd.5: new USB bus registered, =
assigned bus number 6

[   44.430641][    T1] usb usb6: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.434911][    T1] usb usb6: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.438773][    T1] usb usb6: Product: Dummy host controller

[   44.441486][    T1] usb usb6: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.444606][    T1] usb usb6: SerialNumber: dummy_hcd.5

[   44.453996][    T1] hub 6-0:1.0: USB hub found

[   44.456528][    T1] hub 6-0:1.0: 1 port detected

[   44.467670][    T1] dummy_hcd dummy_hcd.6: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.471562][    T1] dummy_hcd dummy_hcd.6: Dummy host controller

[   44.475828][    T1] dummy_hcd dummy_hcd.6: new USB bus registered, =
assigned bus number 7

[   44.481484][    T1] usb usb7: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.485792][    T1] usb usb7: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.489669][    T1] usb usb7: Product: Dummy host controller

[   44.492395][    T1] usb usb7: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.495502][    T1] usb usb7: SerialNumber: dummy_hcd.6

[   44.507713][    T1] hub 7-0:1.0: USB hub found

[   44.510274][    T1] hub 7-0:1.0: 1 port detected

[   44.519928][    T1] dummy_hcd dummy_hcd.7: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.523849][    T1] dummy_hcd dummy_hcd.7: Dummy host controller

[   44.529211][    T1] dummy_hcd dummy_hcd.7: new USB bus registered, =
assigned bus number 8

[   44.534806][    T1] usb usb8: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.539191][    T1] usb usb8: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.542946][    T1] usb usb8: Product: Dummy host controller

[   44.545646][    T1] usb usb8: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.548835][    T1] usb usb8: SerialNumber: dummy_hcd.7

[   44.558089][    T1] hub 8-0:1.0: USB hub found

[   44.561074][    T1] hub 8-0:1.0: 1 port detected

[   44.572064][    T1] dummy_hcd dummy_hcd.8: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.575917][    T1] dummy_hcd dummy_hcd.8: Dummy host controller

[   44.580852][    T1] dummy_hcd dummy_hcd.8: new USB bus registered, =
assigned bus number 9

[   44.587027][    T1] usb usb9: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.591306][    T1] usb usb9: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.595071][    T1] usb usb9: Product: Dummy host controller

[   44.597882][    T1] usb usb9: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.601014][    T1] usb usb9: SerialNumber: dummy_hcd.8

[   44.610113][    T1] hub 9-0:1.0: USB hub found

[   44.612656][    T1] hub 9-0:1.0: 1 port detected

[   44.623018][    T1] dummy_hcd dummy_hcd.9: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.627014][    T1] dummy_hcd dummy_hcd.9: Dummy host controller

[   44.631866][    T1] dummy_hcd dummy_hcd.9: new USB bus registered, =
assigned bus number 10

[   44.637531][    T1] usb usb10: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.641786][    T1] usb usb10: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.645527][    T1] usb usb10: Product: Dummy host controller

[   44.648368][    T1] usb usb10: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.651523][    T1] usb usb10: SerialNumber: dummy_hcd.9

[   44.660733][    T1] hub 10-0:1.0: USB hub found

[   44.664356][    T1] hub 10-0:1.0: 1 port detected

[   44.674882][    T1] dummy_hcd dummy_hcd.10: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.679277][    T1] dummy_hcd dummy_hcd.10: Dummy host controller

[   44.683964][    T1] dummy_hcd dummy_hcd.10: new USB bus registered, =
assigned bus number 11

[   44.689843][    T1] usb usb11: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.694235][    T1] usb usb11: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.698596][    T1] usb usb11: Product: Dummy host controller

[   44.701418][    T1] usb usb11: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.704674][    T1] usb usb11: SerialNumber: dummy_hcd.10

[   44.713643][    T1] hub 11-0:1.0: USB hub found

[   44.716310][    T1] hub 11-0:1.0: 1 port detected

[   44.727353][    T1] dummy_hcd dummy_hcd.11: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.731392][    T1] dummy_hcd dummy_hcd.11: Dummy host controller

[   44.735919][    T1] dummy_hcd dummy_hcd.11: new USB bus registered, =
assigned bus number 12

[   44.741610][    T1] usb usb12: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.745917][    T1] usb usb12: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.750134][    T1] usb usb12: Product: Dummy host controller

[   44.752918][    T1] usb usb12: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.756074][    T1] usb usb12: SerialNumber: dummy_hcd.11

[   44.764624][    T1] hub 12-0:1.0: USB hub found

[   44.767262][    T1] hub 12-0:1.0: 1 port detected

[   44.778027][    T1] dummy_hcd dummy_hcd.12: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.781934][    T1] dummy_hcd dummy_hcd.12: Dummy host controller

[   44.786862][    T1] dummy_hcd dummy_hcd.12: new USB bus registered, =
assigned bus number 13

[   44.792497][    T1] usb usb13: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.796870][    T1] usb usb13: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.800675][    T1] usb usb13: Product: Dummy host controller

[   44.803426][    T1] usb usb13: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.806596][    T1] usb usb13: SerialNumber: dummy_hcd.12

[   44.816305][    T1] hub 13-0:1.0: USB hub found

[   44.818975][    T1] hub 13-0:1.0: 1 port detected

[   44.829559][    T1] dummy_hcd dummy_hcd.13: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.833523][    T1] dummy_hcd dummy_hcd.13: Dummy host controller

[   44.838446][    T1] dummy_hcd dummy_hcd.13: new USB bus registered, =
assigned bus number 14

[   44.844668][    T1] usb usb14: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.849138][    T1] usb usb14: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.853042][    T1] usb usb14: Product: Dummy host controller

[   44.855830][    T1] usb usb14: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.859122][    T1] usb usb14: SerialNumber: dummy_hcd.13

[   44.868347][    T1] hub 14-0:1.0: USB hub found

[   44.870923][    T1] hub 14-0:1.0: 1 port detected

[   44.881125][    T1] dummy_hcd dummy_hcd.14: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.885094][    T1] dummy_hcd dummy_hcd.14: Dummy host controller

[   44.890122][    T1] dummy_hcd dummy_hcd.14: new USB bus registered, =
assigned bus number 15

[   44.896132][    T1] usb usb15: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.900564][    T1] usb usb15: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.904412][    T1] usb usb15: Product: Dummy host controller

[   44.907257][    T1] usb usb15: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.910438][    T1] usb usb15: SerialNumber: dummy_hcd.14

[   44.919525][    T1] hub 15-0:1.0: USB hub found

[   44.923027][    T1] hub 15-0:1.0: 1 port detected

[   44.933220][    T1] dummy_hcd dummy_hcd.15: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.937258][    T1] dummy_hcd dummy_hcd.15: Dummy host controller

[   44.941901][    T1] dummy_hcd dummy_hcd.15: new USB bus registered, =
assigned bus number 16

[   44.948188][    T1] usb usb16: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   44.952542][    T1] usb usb16: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   44.956396][    T1] usb usb16: Product: Dummy host controller

[   44.959362][    T1] usb usb16: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   44.962574][    T1] usb usb16: SerialNumber: dummy_hcd.15

[   44.971864][    T1] hub 16-0:1.0: USB hub found

[   44.974449][    T1] hub 16-0:1.0: 1 port detected

[   44.984924][    T1] dummy_hcd dummy_hcd.16: USB Host+Gadget Emulator, =
driver 02 May 2005

[   44.988944][    T1] dummy_hcd dummy_hcd.16: Dummy host controller

[   44.993837][    T1] dummy_hcd dummy_hcd.16: new USB bus registered, =
assigned bus number 17

[   44.999542][    T1] usb usb17: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.003881][    T1] usb usb17: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.007840][    T1] usb usb17: Product: Dummy host controller

[   45.010618][    T1] usb usb17: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.013814][    T1] usb usb17: SerialNumber: dummy_hcd.16

[   45.023088][    T1] hub 17-0:1.0: USB hub found

[   45.026116][    T1] hub 17-0:1.0: 1 port detected

[   45.036241][    T1] dummy_hcd dummy_hcd.17: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.040243][    T1] dummy_hcd dummy_hcd.17: Dummy host controller

[   45.044737][    T1] dummy_hcd dummy_hcd.17: new USB bus registered, =
assigned bus number 18

[   45.050546][    T1] usb usb18: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.054909][    T1] usb usb18: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.058852][    T1] usb usb18: Product: Dummy host controller

[   45.061694][    T1] usb usb18: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.064907][    T1] usb usb18: SerialNumber: dummy_hcd.17

[   45.074139][    T1] hub 18-0:1.0: USB hub found

[   45.077398][    T1] hub 18-0:1.0: 1 port detected

[   45.086625][    T1] dummy_hcd dummy_hcd.18: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.091366][    T1] dummy_hcd dummy_hcd.18: Dummy host controller

[   45.096642][    T1] dummy_hcd dummy_hcd.18: new USB bus registered, =
assigned bus number 19

[   45.102477][    T1] usb usb19: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.107052][    T1] usb usb19: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.110900][    T1] usb usb19: Product: Dummy host controller

[   45.113687][    T1] usb usb19: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.116916][    T1] usb usb19: SerialNumber: dummy_hcd.18

[   45.125982][    T1] hub 19-0:1.0: USB hub found

[   45.128686][    T1] hub 19-0:1.0: 1 port detected

[   45.139156][    T1] dummy_hcd dummy_hcd.19: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.143008][    T1] dummy_hcd dummy_hcd.19: Dummy host controller

[   45.148258][    T1] dummy_hcd dummy_hcd.19: new USB bus registered, =
assigned bus number 20

[   45.154095][    T1] usb usb20: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.158675][    T1] usb usb20: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.162200][    T1] usb usb20: Product: Dummy host controller

[   45.164771][    T1] usb usb20: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.167764][    T1] usb usb20: SerialNumber: dummy_hcd.19

[   45.176681][    T1] hub 20-0:1.0: USB hub found

[   45.179224][    T1] hub 20-0:1.0: 1 port detected

[   45.189168][    T1] dummy_hcd dummy_hcd.20: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.192814][    T1] dummy_hcd dummy_hcd.20: Dummy host controller

[   45.197888][    T1] dummy_hcd dummy_hcd.20: new USB bus registered, =
assigned bus number 21

[   45.203232][    T1] usb usb21: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.207458][    T1] usb usb21: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.210996][    T1] usb usb21: Product: Dummy host controller

[   45.213566][    T1] usb usb21: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.216489][    T1] usb usb21: SerialNumber: dummy_hcd.20

[   45.225509][    T1] hub 21-0:1.0: USB hub found

[   45.228089][    T1] hub 21-0:1.0: 1 port detected

[   45.238290][    T1] dummy_hcd dummy_hcd.21: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.241928][    T1] dummy_hcd dummy_hcd.21: Dummy host controller

[   45.246316][    T1] dummy_hcd dummy_hcd.21: new USB bus registered, =
assigned bus number 22

[   45.251788][    T1] usb usb22: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.255792][    T1] usb usb22: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.259431][    T1] usb usb22: Product: Dummy host controller

[   45.262110][    T1] usb usb22: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.265052][    T1] usb usb22: SerialNumber: dummy_hcd.21

[   45.274178][    T1] hub 22-0:1.0: USB hub found

[   45.276638][    T1] hub 22-0:1.0: 1 port detected

[   45.284155][    T1] dummy_hcd dummy_hcd.22: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.288408][    T1] dummy_hcd dummy_hcd.22: Dummy host controller

[   45.293059][    T1] dummy_hcd dummy_hcd.22: new USB bus registered, =
assigned bus number 23

[   45.298721][    T1] usb usb23: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.302833][    T1] usb usb23: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.306367][    T1] usb usb23: Product: Dummy host controller

[   45.309850][    T1] usb usb23: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.312801][    T1] usb usb23: SerialNumber: dummy_hcd.22

[   45.322038][    T1] hub 23-0:1.0: USB hub found

[   45.324496][    T1] hub 23-0:1.0: 1 port detected

[   45.334742][    T1] dummy_hcd dummy_hcd.23: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.338528][    T1] dummy_hcd dummy_hcd.23: Dummy host controller

[   45.342911][    T1] dummy_hcd dummy_hcd.23: new USB bus registered, =
assigned bus number 24

[   45.349122][    T1] usb usb24: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.353241][    T1] usb usb24: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.356923][    T1] usb usb24: Product: Dummy host controller

[   45.359538][    T1] usb usb24: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.362735][    T1] usb usb24: SerialNumber: dummy_hcd.23

[   45.372246][    T1] hub 24-0:1.0: USB hub found

[   45.374725][    T1] hub 24-0:1.0: 1 port detected

[   45.384556][    T1] dummy_hcd dummy_hcd.24: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.388413][    T1] dummy_hcd dummy_hcd.24: Dummy host controller

[   45.392903][    T1] dummy_hcd dummy_hcd.24: new USB bus registered, =
assigned bus number 25

[   45.398912][    T1] usb usb25: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.402951][    T1] usb usb25: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.406548][    T1] usb usb25: Product: Dummy host controller

[   45.409301][    T1] usb usb25: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.412433][    T1] usb usb25: SerialNumber: dummy_hcd.24

[   45.421604][    T1] hub 25-0:1.0: USB hub found

[   45.424182][    T1] hub 25-0:1.0: 1 port detected

[   45.433696][    T1] dummy_hcd dummy_hcd.25: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.438659][    T1] dummy_hcd dummy_hcd.25: Dummy host controller

[   45.443380][    T1] dummy_hcd dummy_hcd.25: new USB bus registered, =
assigned bus number 26

[   45.449273][    T1] usb usb26: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.453625][    T1] usb usb26: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.458304][    T1] usb usb26: Product: Dummy host controller

[   45.461098][    T1] usb usb26: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.464275][    T1] usb usb26: SerialNumber: dummy_hcd.25

[   45.473078][    T1] hub 26-0:1.0: USB hub found

[   45.475676][    T1] hub 26-0:1.0: 1 port detected

[   45.485360][    T1] dummy_hcd dummy_hcd.26: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.490119][    T1] dummy_hcd dummy_hcd.26: Dummy host controller

[   45.495064][    T1] dummy_hcd dummy_hcd.26: new USB bus registered, =
assigned bus number 27

[   45.500940][    T1] usb usb27: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.505322][    T1] usb usb27: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.509279][    T1] usb usb27: Product: Dummy host controller

[   45.512077][    T1] usb usb27: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.515247][    T1] usb usb27: SerialNumber: dummy_hcd.26

[   45.524884][    T1] hub 27-0:1.0: USB hub found

[   45.527574][    T1] hub 27-0:1.0: 1 port detected

[   45.538059][    T1] dummy_hcd dummy_hcd.27: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.541982][    T1] dummy_hcd dummy_hcd.27: Dummy host controller

[   45.548596][    T1] dummy_hcd dummy_hcd.27: new USB bus registered, =
assigned bus number 28

[   45.554237][    T1] usb usb28: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.558483][    T1] usb usb28: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.562311][    T1] usb usb28: Product: Dummy host controller

[   45.564995][    T1] usb usb28: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.568156][    T1] usb usb28: SerialNumber: dummy_hcd.27

[   45.577121][    T1] hub 28-0:1.0: USB hub found

[   45.579662][    T1] hub 28-0:1.0: 1 port detected

[   45.589459][    T1] dummy_hcd dummy_hcd.28: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.593143][    T1] dummy_hcd dummy_hcd.28: Dummy host controller

[   45.597856][    T1] dummy_hcd dummy_hcd.28: new USB bus registered, =
assigned bus number 29

[   45.603812][    T1] usb usb29: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.608282][    T1] usb usb29: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.611825][    T1] usb usb29: Product: Dummy host controller

[   45.614386][    T1] usb usb29: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.617401][    T1] usb usb29: SerialNumber: dummy_hcd.28

[   45.626674][    T1] hub 29-0:1.0: USB hub found

[   45.629202][    T1] hub 29-0:1.0: 1 port detected

[   45.639655][    T1] dummy_hcd dummy_hcd.29: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.643337][    T1] dummy_hcd dummy_hcd.29: Dummy host controller

[   45.647930][    T1] dummy_hcd dummy_hcd.29: new USB bus registered, =
assigned bus number 30

[   45.654200][    T1] usb usb30: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.658372][    T1] usb usb30: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.661989][    T1] usb usb30: Product: Dummy host controller

[   45.664559][    T1] usb usb30: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.667579][    T1] usb usb30: SerialNumber: dummy_hcd.29

[   45.677264][    T1] hub 30-0:1.0: USB hub found

[   45.680124][    T1] hub 30-0:1.0: 1 port detected

[   45.689697][    T1] dummy_hcd dummy_hcd.30: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.693366][    T1] dummy_hcd dummy_hcd.30: Dummy host controller

[   45.697801][    T1] dummy_hcd dummy_hcd.30: new USB bus registered, =
assigned bus number 31

[   45.703100][    T1] usb usb31: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.707684][    T1] usb usb31: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.711247][    T1] usb usb31: Product: Dummy host controller

[   45.713833][    T1] usb usb31: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.716830][    T1] usb usb31: SerialNumber: dummy_hcd.30

[   45.725156][    T1] hub 31-0:1.0: USB hub found

[   45.728216][    T1] hub 31-0:1.0: 1 port detected

[   45.737998][    T1] dummy_hcd dummy_hcd.31: USB Host+Gadget Emulator, =
driver 02 May 2005

[   45.741643][    T1] dummy_hcd dummy_hcd.31: Dummy host controller

[   45.745913][    T1] dummy_hcd dummy_hcd.31: new USB bus registered, =
assigned bus number 32

[   45.751481][    T1] usb usb32: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.755478][    T1] usb usb32: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.759206][    T1] usb usb32: Product: Dummy host controller

[   45.761796][    T1] usb usb32: Manufacturer: Linux 6.16.0-rc4 =
dummy_hcd

[   45.764738][    T1] usb usb32: SerialNumber: dummy_hcd.31

[   45.773824][    T1] hub 32-0:1.0: USB hub found

[   45.776255][    T1] hub 32-0:1.0: 1 port detected

[   45.949009][    T1] SPI driver max3420-udc has no spi_device_id for =
maxim,max3421-udc

[   45.955941][    T1] gadgetfs: USB Gadget filesystem, version 24 Aug =
2004

[   45.964488][    T1] vhci_hcd vhci_hcd.0: USB/IP Virtual Host =
Controller

[   45.970058][    T1] vhci_hcd vhci_hcd.0: new USB bus registered, =
assigned bus number 33

[   45.975210][    T1] vhci_hcd: created sysfs vhci_hcd.0

[   45.980539][    T1] usb usb33: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   45.984806][    T1] usb usb33: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   45.988782][    T1] usb usb33: Product: USB/IP Virtual Host =
Controller

[   45.991924][    T1] usb usb33: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   45.995101][    T1] usb usb33: SerialNumber: vhci_hcd.0

[   46.004806][    T1] hub 33-0:1.0: USB hub found

[   46.007615][    T1] hub 33-0:1.0: 8 ports detected

[   46.027997][    T1] vhci_hcd vhci_hcd.0: USB/IP Virtual Host =
Controller

[   46.033375][    T1] vhci_hcd vhci_hcd.0: new USB bus registered, =
assigned bus number 34

[   46.038166][    T1] usb usb34: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.044074][    T1] usb usb34: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.048473][    T1] usb usb34: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.052336][    T1] usb usb34: Product: USB/IP Virtual Host =
Controller

[   46.055520][    T1] usb usb34: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.058735][    T1] usb usb34: SerialNumber: vhci_hcd.0

[   46.068420][    T1] hub 34-0:1.0: USB hub found

[   46.071166][    T1] hub 34-0:1.0: 8 ports detected

[   46.096212][    T1] vhci_hcd vhci_hcd.1: USB/IP Virtual Host =
Controller

[   46.101189][    T1] vhci_hcd vhci_hcd.1: new USB bus registered, =
assigned bus number 35

[   46.107300][    T1] usb usb35: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.111626][    T1] usb usb35: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.115474][    T1] usb usb35: Product: USB/IP Virtual Host =
Controller

[   46.118851][    T1] usb usb35: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.122020][    T1] usb usb35: SerialNumber: vhci_hcd.1

[   46.139058][    T1] hub 35-0:1.0: USB hub found

[   46.141724][    T1] hub 35-0:1.0: 8 ports detected

[   46.160973][    T1] vhci_hcd vhci_hcd.1: USB/IP Virtual Host =
Controller

[   46.166371][    T1] vhci_hcd vhci_hcd.1: new USB bus registered, =
assigned bus number 36

[   46.170828][    T1] usb usb36: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.176453][    T1] usb usb36: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.180782][    T1] usb usb36: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.184485][    T1] usb usb36: Product: USB/IP Virtual Host =
Controller

[   46.187565][    T1] usb usb36: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.190611][    T1] usb usb36: SerialNumber: vhci_hcd.1

[   46.200019][    T1] hub 36-0:1.0: USB hub found

[   46.202536][    T1] hub 36-0:1.0: 8 ports detected

[   46.227262][    T1] vhci_hcd vhci_hcd.2: USB/IP Virtual Host =
Controller

[   46.232605][    T1] vhci_hcd vhci_hcd.2: new USB bus registered, =
assigned bus number 37

[   46.238366][    T1] usb usb37: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.242558][    T1] usb usb37: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.246265][    T1] usb usb37: Product: USB/IP Virtual Host =
Controller

[   46.249394][    T1] usb usb37: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.252436][    T1] usb usb37: SerialNumber: vhci_hcd.2

[   46.261495][    T1] hub 37-0:1.0: USB hub found

[   46.264038][    T1] hub 37-0:1.0: 8 ports detected

[   46.282446][    T1] vhci_hcd vhci_hcd.2: USB/IP Virtual Host =
Controller

[   46.288541][    T1] vhci_hcd vhci_hcd.2: new USB bus registered, =
assigned bus number 38

[   46.293007][    T1] usb usb38: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.299757][    T1] usb usb38: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.303951][    T1] usb usb38: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.307714][    T1] usb usb38: Product: USB/IP Virtual Host =
Controller

[   46.310759][    T1] usb usb38: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.313797][    T1] usb usb38: SerialNumber: vhci_hcd.2

[   46.322363][    T1] hub 38-0:1.0: USB hub found

[   46.324885][    T1] hub 38-0:1.0: 8 ports detected

[   46.349469][    T1] vhci_hcd vhci_hcd.3: USB/IP Virtual Host =
Controller

[   46.354207][    T1] vhci_hcd vhci_hcd.3: new USB bus registered, =
assigned bus number 39

[   46.359751][    T1] usb usb39: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.363937][    T1] usb usb39: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.367719][    T1] usb usb39: Product: USB/IP Virtual Host =
Controller

[   46.370775][    T1] usb usb39: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.373812][    T1] usb usb39: SerialNumber: vhci_hcd.3

[   46.383338][    T1] hub 39-0:1.0: USB hub found

[   46.386014][    T1] hub 39-0:1.0: 8 ports detected

[   46.405627][    T1] vhci_hcd vhci_hcd.3: USB/IP Virtual Host =
Controller

[   46.411186][    T1] vhci_hcd vhci_hcd.3: new USB bus registered, =
assigned bus number 40

[   46.415699][    T1] usb usb40: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.421430][    T1] usb usb40: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.425727][    T1] usb usb40: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.429584][    T1] usb usb40: Product: USB/IP Virtual Host =
Controller

[   46.432696][    T1] usb usb40: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.435804][    T1] usb usb40: SerialNumber: vhci_hcd.3

[   46.445070][    T1] hub 40-0:1.0: USB hub found

[   46.447727][    T1] hub 40-0:1.0: 8 ports detected

[   46.471212][    T1] vhci_hcd vhci_hcd.4: USB/IP Virtual Host =
Controller

[   46.477340][    T1] vhci_hcd vhci_hcd.4: new USB bus registered, =
assigned bus number 41

[   46.482825][    T1] usb usb41: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.487205][    T1] usb usb41: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.490998][    T1] usb usb41: Product: USB/IP Virtual Host =
Controller

[   46.494141][    T1] usb usb41: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.497307][    T1] usb usb41: SerialNumber: vhci_hcd.4

[   46.513811][    T1] hub 41-0:1.0: USB hub found

[   46.516384][    T1] hub 41-0:1.0: 8 ports detected

[   46.535843][    T1] vhci_hcd vhci_hcd.4: USB/IP Virtual Host =
Controller

[   46.541259][    T1] vhci_hcd vhci_hcd.4: new USB bus registered, =
assigned bus number 42

[   46.545697][    T1] usb usb42: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.551480][    T1] usb usb42: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.555777][    T1] usb usb42: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.559625][    T1] usb usb42: Product: USB/IP Virtual Host =
Controller

[   46.562816][    T1] usb usb42: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.565930][    T1] usb usb42: SerialNumber: vhci_hcd.4

[   46.575162][    T1] hub 42-0:1.0: USB hub found

[   46.577829][    T1] hub 42-0:1.0: 8 ports detected

[   46.598891][    T1] vhci_hcd vhci_hcd.5: USB/IP Virtual Host =
Controller

[   46.603688][    T1] vhci_hcd vhci_hcd.5: new USB bus registered, =
assigned bus number 43

[   46.609592][    T1] usb usb43: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.613901][    T1] usb usb43: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.617799][    T1] usb usb43: Product: USB/IP Virtual Host =
Controller

[   46.620909][    T1] usb usb43: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.624014][    T1] usb usb43: SerialNumber: vhci_hcd.5

[   46.632897][    T1] hub 43-0:1.0: USB hub found

[   46.635433][    T1] hub 43-0:1.0: 8 ports detected

[   46.661231][    T1] vhci_hcd vhci_hcd.5: USB/IP Virtual Host =
Controller

[   46.667109][    T1] vhci_hcd vhci_hcd.5: new USB bus registered, =
assigned bus number 44

[   46.671527][    T1] usb usb44: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.677083][    T1] usb usb44: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.681283][    T1] usb usb44: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.684989][    T1] usb usb44: Product: USB/IP Virtual Host =
Controller

[   46.688813][    T1] usb usb44: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.691848][    T1] usb usb44: SerialNumber: vhci_hcd.5

[   46.701050][    T1] hub 44-0:1.0: USB hub found

[   46.703548][    T1] hub 44-0:1.0: 8 ports detected

[   46.728261][    T1] vhci_hcd vhci_hcd.6: USB/IP Virtual Host =
Controller

[   46.733643][    T1] vhci_hcd vhci_hcd.6: new USB bus registered, =
assigned bus number 45

[   46.739227][    T1] usb usb45: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.743515][    T1] usb usb45: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.747690][    T1] usb usb45: Product: USB/IP Virtual Host =
Controller

[   46.750831][    T1] usb usb45: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.753933][    T1] usb usb45: SerialNumber: vhci_hcd.6

[   46.762983][    T1] hub 45-0:1.0: USB hub found

[   46.765557][    T1] hub 45-0:1.0: 8 ports detected

[   46.784983][    T1] vhci_hcd vhci_hcd.6: USB/IP Virtual Host =
Controller

[   46.791226][    T1] vhci_hcd vhci_hcd.6: new USB bus registered, =
assigned bus number 46

[   46.795697][    T1] usb usb46: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.801476][    T1] usb usb46: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.805774][    T1] usb usb46: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.809643][    T1] usb usb46: Product: USB/IP Virtual Host =
Controller

[   46.812772][    T1] usb usb46: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.815875][    T1] usb usb46: SerialNumber: vhci_hcd.6

[   46.825877][    T1] hub 46-0:1.0: USB hub found

[   46.828576][    T1] hub 46-0:1.0: 8 ports detected

[   46.852331][    T1] vhci_hcd vhci_hcd.7: USB/IP Virtual Host =
Controller

[   46.857437][    T1] vhci_hcd vhci_hcd.7: new USB bus registered, =
assigned bus number 47

[   46.862945][    T1] usb usb47: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.867358][    T1] usb usb47: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.871187][    T1] usb usb47: Product: USB/IP Virtual Host =
Controller

[   46.874322][    T1] usb usb47: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.877538][    T1] usb usb47: SerialNumber: vhci_hcd.7

[   46.887227][    T1] hub 47-0:1.0: USB hub found

[   46.889969][    T1] hub 47-0:1.0: 8 ports detected

[   46.908650][    T1] vhci_hcd vhci_hcd.7: USB/IP Virtual Host =
Controller

[   46.914496][    T1] vhci_hcd vhci_hcd.7: new USB bus registered, =
assigned bus number 48

[   46.919264][    T1] usb usb48: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   46.924899][    T1] usb usb48: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   46.929296][    T1] usb usb48: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   46.933100][    T1] usb usb48: Product: USB/IP Virtual Host =
Controller

[   46.936222][    T1] usb usb48: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   46.939502][    T1] usb usb48: SerialNumber: vhci_hcd.7

[   46.948794][    T1] hub 48-0:1.0: USB hub found

[   46.951370][    T1] hub 48-0:1.0: 8 ports detected

[   46.984030][    T1] vhci_hcd vhci_hcd.8: USB/IP Virtual Host =
Controller

[   46.989078][    T1] vhci_hcd vhci_hcd.8: new USB bus registered, =
assigned bus number 49

[   46.995289][    T1] usb usb49: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   46.999719][    T1] usb usb49: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.003560][    T1] usb usb49: Product: USB/IP Virtual Host =
Controller

[   47.006672][    T1] usb usb49: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.009868][    T1] usb usb49: SerialNumber: vhci_hcd.8

[   47.019242][    T1] hub 49-0:1.0: USB hub found

[   47.022216][    T1] hub 49-0:1.0: 8 ports detected

[   47.042605][    T1] vhci_hcd vhci_hcd.8: USB/IP Virtual Host =
Controller

[   47.047436][    T1] vhci_hcd vhci_hcd.8: new USB bus registered, =
assigned bus number 50

[   47.052802][    T1] usb usb50: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   47.058666][    T1] usb usb50: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   47.062961][    T1] usb usb50: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.066858][    T1] usb usb50: Product: USB/IP Virtual Host =
Controller

[   47.069989][    T1] usb usb50: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.073107][    T1] usb usb50: SerialNumber: vhci_hcd.8

[   47.082840][    T1] hub 50-0:1.0: USB hub found

[   47.085451][    T1] hub 50-0:1.0: 8 ports detected

[   47.111346][    T1] vhci_hcd vhci_hcd.9: USB/IP Virtual Host =
Controller

[   47.116920][    T1] vhci_hcd vhci_hcd.9: new USB bus registered, =
assigned bus number 51

[   47.122785][    T1] usb usb51: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   47.127169][    T1] usb usb51: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.131039][    T1] usb usb51: Product: USB/IP Virtual Host =
Controller

[   47.134185][    T1] usb usb51: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.137370][    T1] usb usb51: SerialNumber: vhci_hcd.9

[   47.146650][    T1] hub 51-0:1.0: USB hub found

[   47.149808][    T1] hub 51-0:1.0: 8 ports detected

[   47.169503][    T1] vhci_hcd vhci_hcd.9: USB/IP Virtual Host =
Controller

[   47.174886][    T1] vhci_hcd vhci_hcd.9: new USB bus registered, =
assigned bus number 52

[   47.179437][    T1] usb usb52: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   47.185118][    T1] usb usb52: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   47.189576][    T1] usb usb52: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.193392][    T1] usb usb52: Product: USB/IP Virtual Host =
Controller

[   47.196509][    T1] usb usb52: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.199707][    T1] usb usb52: SerialNumber: vhci_hcd.9

[   47.209184][    T1] hub 52-0:1.0: USB hub found

[   47.211816][    T1] hub 52-0:1.0: 8 ports detected

[   47.237927][    T1] vhci_hcd vhci_hcd.10: USB/IP Virtual Host =
Controller

[   47.242891][    T1] vhci_hcd vhci_hcd.10: new USB bus registered, =
assigned bus number 53

[   47.248649][    T1] usb usb53: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   47.252977][    T1] usb usb53: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.256872][    T1] usb usb53: Product: USB/IP Virtual Host =
Controller

[   47.259996][    T1] usb usb53: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.263181][    T1] usb usb53: SerialNumber: vhci_hcd.10

[   47.273062][    T1] hub 53-0:1.0: USB hub found

[   47.275621][    T1] hub 53-0:1.0: 8 ports detected

[   47.296205][    T1] vhci_hcd vhci_hcd.10: USB/IP Virtual Host =
Controller

[   47.301393][    T1] vhci_hcd vhci_hcd.10: new USB bus registered, =
assigned bus number 54

[   47.306554][    T1] usb usb54: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   47.312355][    T1] usb usb54: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   47.316657][    T1] usb usb54: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.320547][    T1] usb usb54: Product: USB/IP Virtual Host =
Controller

[   47.323653][    T1] usb usb54: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.326846][    T1] usb usb54: SerialNumber: vhci_hcd.10

[   47.337247][    T1] hub 54-0:1.0: USB hub found

[   47.339910][    T1] hub 54-0:1.0: 8 ports detected

[   47.364773][    T1] vhci_hcd vhci_hcd.11: USB/IP Virtual Host =
Controller

[   47.369870][    T1] vhci_hcd vhci_hcd.11: new USB bus registered, =
assigned bus number 55

[   47.376008][    T1] usb usb55: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   47.380841][    T1] usb usb55: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.384700][    T1] usb usb55: Product: USB/IP Virtual Host =
Controller

[   47.388060][    T1] usb usb55: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.391232][    T1] usb usb55: SerialNumber: vhci_hcd.11

[   47.400833][    T1] hub 55-0:1.0: USB hub found

[   47.403414][    T1] hub 55-0:1.0: 8 ports detected

[   47.423019][    T1] vhci_hcd vhci_hcd.11: USB/IP Virtual Host =
Controller

[   47.428507][    T1] vhci_hcd vhci_hcd.11: new USB bus registered, =
assigned bus number 56

[   47.433086][    T1] usb usb56: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   47.438882][    T1] usb usb56: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   47.443235][    T1] usb usb56: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.447156][    T1] usb usb56: Product: USB/IP Virtual Host =
Controller

[   47.450314][    T1] usb usb56: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.453455][    T1] usb usb56: SerialNumber: vhci_hcd.11

[   47.463018][    T1] hub 56-0:1.0: USB hub found

[   47.465593][    T1] hub 56-0:1.0: 8 ports detected

[   47.491673][    T1] vhci_hcd vhci_hcd.12: USB/IP Virtual Host =
Controller

[   47.496816][    T1] vhci_hcd vhci_hcd.12: new USB bus registered, =
assigned bus number 57

[   47.502936][    T1] usb usb57: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   47.507377][    T1] usb usb57: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.511229][    T1] usb usb57: Product: USB/IP Virtual Host =
Controller

[   47.514386][    T1] usb usb57: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.517621][    T1] usb usb57: SerialNumber: vhci_hcd.12

[   47.526935][    T1] hub 57-0:1.0: USB hub found

[   47.529929][    T1] hub 57-0:1.0: 8 ports detected

[   47.548865][    T1] vhci_hcd vhci_hcd.12: USB/IP Virtual Host =
Controller

[   47.554455][    T1] vhci_hcd vhci_hcd.12: new USB bus registered, =
assigned bus number 58

[   47.559068][    T1] usb usb58: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   47.564700][    T1] usb usb58: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   47.569090][    T1] usb usb58: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.572890][    T1] usb usb58: Product: USB/IP Virtual Host =
Controller

[   47.576002][    T1] usb usb58: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.579168][    T1] usb usb58: SerialNumber: vhci_hcd.12

[   47.588783][    T1] hub 58-0:1.0: USB hub found

[   47.591347][    T1] hub 58-0:1.0: 8 ports detected

[   47.615125][    T1] vhci_hcd vhci_hcd.13: USB/IP Virtual Host =
Controller

[   47.620518][    T1] vhci_hcd vhci_hcd.13: new USB bus registered, =
assigned bus number 59

[   47.626052][    T1] usb usb59: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   47.630775][    T1] usb usb59: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.634565][    T1] usb usb59: Product: USB/IP Virtual Host =
Controller

[   47.637814][    T1] usb usb59: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.640959][    T1] usb usb59: SerialNumber: vhci_hcd.13

[   47.658130][    T1] hub 59-0:1.0: USB hub found

[   47.660689][    T1] hub 59-0:1.0: 8 ports detected

[   47.680124][    T1] vhci_hcd vhci_hcd.13: USB/IP Virtual Host =
Controller

[   47.686572][    T1] vhci_hcd vhci_hcd.13: new USB bus registered, =
assigned bus number 60

[   47.691229][    T1] usb usb60: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   47.697038][    T1] usb usb60: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   47.701314][    T1] usb usb60: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.705080][    T1] usb usb60: Product: USB/IP Virtual Host =
Controller

[   47.708306][    T1] usb usb60: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.711402][    T1] usb usb60: SerialNumber: vhci_hcd.13

[   47.720827][    T1] hub 60-0:1.0: USB hub found

[   47.723384][    T1] hub 60-0:1.0: 8 ports detected

[   47.748346][    T1] vhci_hcd vhci_hcd.14: USB/IP Virtual Host =
Controller

[   47.753952][    T1] vhci_hcd vhci_hcd.14: new USB bus registered, =
assigned bus number 61

[   47.759551][    T1] usb usb61: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   47.763857][    T1] usb usb61: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.767760][    T1] usb usb61: Product: USB/IP Virtual Host =
Controller

[   47.770921][    T1] usb usb61: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.774016][    T1] usb usb61: SerialNumber: vhci_hcd.14

[   47.783245][    T1] hub 61-0:1.0: USB hub found

[   47.785814][    T1] hub 61-0:1.0: 8 ports detected

[   47.813396][    T1] vhci_hcd vhci_hcd.14: USB/IP Virtual Host =
Controller

[   47.818370][    T1] vhci_hcd vhci_hcd.14: new USB bus registered, =
assigned bus number 62

[   47.823089][    T1] usb usb62: We don't know the algorithms for LPM =
for this host, disabling LPM.

[   47.828830][    T1] usb usb62: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.16

[   47.833073][    T1] usb usb62: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.836892][    T1] usb usb62: Product: USB/IP Virtual Host =
Controller

[   47.839987][    T1] usb usb62: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.843060][    T1] usb usb62: SerialNumber: vhci_hcd.14

[   47.852413][    T1] hub 62-0:1.0: USB hub found

[   47.854929][    T1] hub 62-0:1.0: 8 ports detected

[   47.878929][    T1] vhci_hcd vhci_hcd.15: USB/IP Virtual Host =
Controller

[   47.884371][    T1] vhci_hcd vhci_hcd.15: new USB bus registered, =
assigned bus number 63

[   47.890021][    T1] usb usb63: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.16

[   47.894277][    T1] usb usb63: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1

[   47.898115][    T1] usb usb63: Product: USB/IP Virtual Host =
Controller

[   47.901198][    T1] usb usb63: Manufacturer: Linux 6.16.0-rc4 =
vhci_hcd

[   47.904281][    T1] usb usb63: SerialNumber: vhci_hcd.15

[   47.913890][    T1] hub 63-0:1.0: USB hub found

[   47.916438][    T1] hub 63-0:1.0: 8 ports detected

[   47.937675][    T1] vhci_hcd vhci_hcd.15: USB/IP Virtual Host =
Controller

[   47.940808][    T1] usbcore: failed to get bus number

[   47.943147][    T1] vhci_hcd: usb_add_hcd ss failed -7

[   47.945566][    T1] vhci_hcd vhci_hcd.15: remove, state 4

[   47.948706][    T1] usb usb63: USB disconnect, device number 1

[   47.973134][   T12] vhci_hcd: stop threads

[   47.975101][   T12] vhci_hcd: release socket

[   47.977258][   T12] vhci_hcd: disconnect device

[   47.979571][   T12] vhci_hcd: stop threads

[   47.981513][   T12] vhci_hcd: release socket

[   47.983487][   T12] vhci_hcd: disconnect device

[   47.985634][   T12] vhci_hcd: stop threads

[   47.988755][   T12] vhci_hcd: release socket

[   47.990746][   T12] vhci_hcd: disconnect device

[   47.992907][   T12] vhci_hcd: stop threads

[   47.994797][   T12] vhci_hcd: release socket

[   47.996863][   T12] vhci_hcd: disconnect device

[   47.999004][   T12] vhci_hcd: stop threads

[   48.000936][   T12] vhci_hcd: release socket

[   48.002905][   T12] vhci_hcd: disconnect device

[   48.005056][   T12] vhci_hcd: stop threads

[   48.009254][   T12] vhci_hcd: release socket

[   48.011236][   T12] vhci_hcd: disconnect device

[   48.013374][   T12] vhci_hcd: stop threads

[   48.015299][   T12] vhci_hcd: release socket

[   48.017378][   T12] vhci_hcd: disconnect device

[   48.019534][   T12] vhci_hcd: stop threads

[   48.021454][   T12] vhci_hcd: release socket

[   48.023423][   T12] vhci_hcd: disconnect device

[   48.025576][    T1] vhci_hcd vhci_hcd.15: USB bus 63 deregistered

[   48.031688][    T1] vhci_hcd vhci_hcd.15: probe with driver vhci_hcd =
failed with error -7

[   48.037041][    T1] usbcore: registered new device driver usbip-host

[   48.056619][    T1] i8042: PNP: PS/2 Controller =
[PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12

[   48.065613][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1

[   48.070720][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12

[   48.081222][    T1] mousedev: PS/2 mouse device common for all mice

[   48.087434][    T1] usbcore: registered new interface driver =
appletouch

[   48.094440][ T1004] input: AT Translated Set 2 keyboard as =
/devices/platform/i8042/serio0/input/input1

[   48.098315][    T1] usbcore: registered new interface driver bcm5974

[   48.103941][    T1] usbcore: registered new interface driver =
synaptics_usb

[   48.110848][    T1] usbcore: registered new interface driver iforce

[   48.114845][    T1] usbcore: registered new interface driver pxrc

[   48.120789][    T1] usbcore: registered new interface driver xpad

[   48.125106][    T1] usbcore: registered new interface driver =
usb_acecad

[   48.130144][    T1] usbcore: registered new interface driver aiptek

[   48.134695][    T1] usbcore: registered new interface driver hanwang

[   48.139402][    T1] usbcore: registered new interface driver kbtab

[   48.143612][    T1] usbcore: registered new interface driver =
pegasus_notetaker

[   48.149030][    T1] usbcore: registered new interface driver =
usbtouchscreen

[   48.153601][    T1] usbcore: registered new interface driver sur40

[   48.157918][    T1] usbcore: registered new interface driver =
ati_remote2

[   48.161041][    T1] cm109: Keymap for Komunikate KIP1000 phone loaded

[   48.165453][    T1] usbcore: registered new interface driver cm109

[   48.168699][    T1] cm109: CM109 phone driver: 20080805 (C) Alfred E. =
Heggestad

[   48.173445][    T1] usbcore: registered new interface driver ims_pcu

[   48.177928][    T1] usbcore: registered new interface driver =
keyspan_remote

[   48.182540][    T1] usbcore: registered new interface driver =
powermate

[   48.188928][    T1] usbcore: registered new interface driver yealink

[   48.199450][    T1] rtc_cmos 00:00: RTC can wake from S4

[   48.214783][    T1] rtc_cmos 00:00: registered as rtc0

[   48.217526][    T1] rtc_cmos 00:00: alarms up to one day, y3k, 114 =
bytes nvram, hpet irqs

[   48.223124][    T1] i2c_dev: i2c /dev entries driver

[   48.228898][    T1] usbcore: registered new interface driver =
i2c-diolan-u2c

[   48.235538][    T1] usbcore: registered new interface driver =
i2c-cp2615

[   48.240056][    T1] usbcore: registered new interface driver =
RobotFuzz Open Source InterFace, OSIF

[   48.245497][    T1] usbcore: registered new interface driver =
i2c-tiny-usb

[   48.256181][    T1] usbcore: registered new interface driver =
igorplugusb

[   48.261405][    T1] usbcore: registered new interface driver iguanair

[   48.266067][    T1] usbcore: registered new interface driver imon

[   48.269836][    T1] usbcore: registered new interface driver imon_raw

[   48.274699][    T1] usbcore: registered new interface driver mceusb

[   48.278571][    T1] usbcore: registered new interface driver redrat3

[   48.282344][    T1] usbcore: registered new interface driver =
streamzap

[   48.286187][    T1] usbcore: registered new interface driver ir_toy

[   48.290814][    T1] usbcore: registered new interface driver ttusbir

[   48.295222][    T1] usbcore: registered new interface driver =
ati_remote

[   48.299759][    T1] usbcore: registered new interface driver =
xbox_remote

[   48.305160][    T1] b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV =
receiver chip loaded successfully

[   48.311094][    T1] usbcore: registered new interface driver =
b2c2_flexcop_usb

[   48.315840][    T1] usbcore: registered new interface driver =
dvb_usb_vp7045

[   48.320533][    T1] usbcore: registered new interface driver =
dvb_usb_vp702x

[   48.325220][    T1] usbcore: registered new interface driver =
dvb_usb_gp8psk

[   48.329477][    T1] usbcore: registered new interface driver =
dvb_usb_dtt200u

[   48.333591][    T1] usbcore: registered new interface driver =
dvb_usb_a800

[   48.339109][    T1] usbcore: registered new interface driver =
dvb_usb_dibusb_mb

[   48.343991][    T1] usbcore: registered new interface driver =
dvb_usb_dibusb_mc

[   48.348430][    T1] usbcore: registered new interface driver =
dvb_usb_nova_t_usb2

[   48.352837][    T1] usbcore: registered new interface driver =
dvb_usb_umt_010

[   48.358302][    T1] usbcore: registered new interface driver =
dvb_usb_m920x

[   48.362829][    T1] usbcore: registered new interface driver =
dvb_usb_digitv

[   48.367822][    T1] usbcore: registered new interface driver =
dvb_usb_cxusb

[   48.372480][    T1] usbcore: registered new interface driver =
dvb_usb_ttusb2

[   48.378435][    T1] usbcore: registered new interface driver =
dvb_usb_dib0700

[   48.383090][    T1] usbcore: registered new interface driver opera1

[   48.387459][    T1] usbcore: registered new interface driver =
dvb_usb_af9005

[   48.390747][    T1] failing symbol_get of non-GPLONLY symbol =
af9005_rc_decode.

[   48.395330][    T1] failing symbol_get of non-GPLONLY symbol =
af9005_rc_decode.

[   48.398871][    T1] failing symbol_get of non-GPLONLY symbol =
rc_map_af9005_table.

[   48.403640][    T1] failing symbol_get of non-GPLONLY symbol =
rc_map_af9005_table.

[   48.407242][    T1] failing symbol_get of non-GPLONLY symbol =
rc_map_af9005_table_size.

[   48.412054][    T1] failing symbol_get of non-GPLONLY symbol =
rc_map_af9005_table_size.

[   48.415688][    T1] af9005: af9005_rc_decode function not found, =
disabling remote

[   48.420481][    T1] usbcore: registered new interface driver pctv452e

[   48.424763][    T1] usbcore: registered new interface driver dw2102

[   48.428672][    T1] usbcore: registered new interface driver =
dvb_usb_dtv5100

[   48.432788][    T1] usbcore: registered new interface driver =
cinergyT2

[   48.437050][    T1] usbcore: registered new interface driver =
dvb_usb_az6027

[   48.441119][    T1] usbcore: registered new interface driver =
dvb_usb_technisat_usb2

[   48.445920][    T1] usbcore: registered new interface driver =
dvb_usb_af9015

[   48.451189][    T1] usbcore: registered new interface driver =
dvb_usb_af9035

[   48.455723][    T1] usbcore: registered new interface driver =
dvb_usb_anysee

[   48.460484][    T1] usbcore: registered new interface driver =
dvb_usb_au6610

[   48.465047][    T1] usbcore: registered new interface driver =
dvb_usb_az6007

[   48.469672][    T1] usbcore: registered new interface driver =
dvb_usb_ce6230

[   48.474249][    T1] usbcore: registered new interface driver =
dvb_usb_ec168

[   48.478895][    T1] usbcore: registered new interface driver =
dvb_usb_lmedm04

[   48.483487][    T1] usbcore: registered new interface driver =
dvb_usb_gl861

[   48.488518][    T1] usbcore: registered new interface driver =
dvb_usb_mxl111sf

[   48.493632][    T1] usbcore: registered new interface driver =
dvb_usb_rtl28xxu

[   48.498615][    T1] usbcore: registered new interface driver =
dvb_usb_dvbsky

[   48.503067][    T1] usbcore: registered new interface driver zd1301

[   48.506930][    T1] usbcore: registered new interface driver s2255

[   48.511891][    T1] usbcore: registered new interface driver smsusb

[   48.516208][    T1] usbcore: registered new interface driver ttusb

[   48.527688][    T1] usbcore: registered new interface driver =
ttusb-dec

[   48.532247][    T1] usbcore: registered new interface driver Abilis =
Systems as10x usb driver

[   48.537582][    T1] usbcore: registered new interface driver airspy

[   48.540500][    T1] gspca_main: v2.14.0 registered

[   48.544056][    T1] usbcore: registered new interface driver benq

[   48.548369][    T1] usbcore: registered new interface driver conex

[   48.552663][    T1] usbcore: registered new interface driver cpia1

[   48.557472][    T1] usbcore: registered new interface driver dtcs033

[   48.562943][    T1] usbcore: registered new interface driver etoms

[   48.569465][    T1] usbcore: registered new interface driver finepix

[   48.571423][ T1004] input: ImExPS/2 Generic Explorer Mouse as =
/devices/platform/i8042/serio1/input/input3

[   48.573593][    T1] usbcore: registered new interface driver jeilinj

[   48.581689][    T1] usbcore: registered new interface driver =
jl2005bcd

[   48.586165][    T1] usbcore: registered new interface driver kinect

[   48.590739][    T1] usbcore: registered new interface driver konica

[   48.594821][    T1] usbcore: registered new interface driver mars

[   48.599226][    T1] usbcore: registered new interface driver mr97310a

[   48.603807][    T1] usbcore: registered new interface driver nw80x

[   48.608515][    T1] usbcore: registered new interface driver ov519

[   48.612847][    T1] usbcore: registered new interface driver ov534

[   48.617346][    T1] usbcore: registered new interface driver ov534_9

[   48.621994][    T1] usbcore: registered new interface driver pac207

[   48.626471][    T1] usbcore: registered new interface driver =
gspca_pac7302

[   48.631328][    T1] usbcore: registered new interface driver pac7311

[   48.635795][    T1] usbcore: registered new interface driver se401

[   48.640298][    T1] usbcore: registered new interface driver sn9c2028

[   48.645323][    T1] usbcore: registered new interface driver =
gspca_sn9c20x

[   48.657140][    T1] usbcore: registered new interface driver sonixb

[   48.661470][    T1] usbcore: registered new interface driver sonixj

[   48.665498][    T1] usbcore: registered new interface driver spca500

[   48.670110][    T1] usbcore: registered new interface driver spca501

[   48.674468][    T1] usbcore: registered new interface driver spca505

[   48.679008][    T1] usbcore: registered new interface driver spca506

[   48.683468][    T1] usbcore: registered new interface driver spca508

[   48.688162][    T1] usbcore: registered new interface driver spca561

[   48.692564][    T1] usbcore: registered new interface driver spca1528

[   48.697031][    T1] usbcore: registered new interface driver sq905

[   48.701283][    T1] usbcore: registered new interface driver sq905c

[   48.705407][    T1] usbcore: registered new interface driver sq930x

[   48.710695][    T1] usbcore: registered new interface driver sunplus

[   48.715069][    T1] usbcore: registered new interface driver stk014

[   48.719477][    T1] usbcore: registered new interface driver stk1135

[   48.723844][    T1] usbcore: registered new interface driver stv0680

[   48.728575][    T1] usbcore: registered new interface driver t613

[   48.732559][    T1] usbcore: registered new interface driver =
gspca_topro

[   48.737251][    T1] usbcore: registered new interface driver touptek

[   48.741693][    T1] usbcore: registered new interface driver tv8532

[   48.746202][    T1] usbcore: registered new interface driver vc032x

[   48.750626][    T1] usbcore: registered new interface driver vicam

[   48.755022][    T1] usbcore: registered new interface driver =
xirlink-cit

[   48.760422][    T1] usbcore: registered new interface driver =
gspca_zc3xx

[   48.765078][    T1] usbcore: registered new interface driver ALi =
m5602

[   48.769651][    T1] usbcore: registered new interface driver STV06xx

[   48.774014][    T1] usbcore: registered new interface driver =
gspca_gl860

[   48.778604][    T1] usbcore: registered new interface driver hackrf

[   48.782986][    T1] usbcore: registered new interface driver msi2500

[   48.787888][    T1] usbcore: registered new interface driver Philips =
webcam

[   48.794016][    T1] usbcore: registered new interface driver uvcvideo

[   48.797168][    T1] au0828: au0828 driver loaded

[   48.801028][    T1] usbcore: registered new interface driver au0828

[   48.805862][    T1] usbcore: registered new interface driver cx231xx

[   48.811907][    T1] usbcore: registered new interface driver em28xx

[   48.814941][    T1] em28xx: Registered (Em28xx v4l2 Extension) =
extension

[   48.818111][    T1] em28xx: Registered (Em28xx Audio Extension) =
extension

[   48.821322][    T1] em28xx: Registered (Em28xx dvb Extension) =
extension

[   48.824441][    T1] em28xx: Registered (Em28xx Input Extension) =
extension

[   48.829531][    T1] usbcore: registered new interface driver go7007

[   48.833935][    T1] usbcore: registered new interface driver =
go7007-loader

[   48.839868][    T1] usbcore: registered new interface driver hdpvr

[   48.845638][    T1] usbcore: registered new interface driver pvrusb2

[   48.848750][    T1] pvrusb2: V4L in-tree version:Hauppauge =
WinTV-PVR-USB2 MPEG2 Encoder/Tuner

[   48.852740][    T1] pvrusb2: Debug mask is 31 (0x1f)

[   48.857593][    T1] usbcore: registered new interface driver stk1160

[   48.861967][    T1] usbcore: registered new interface driver usbtv

[   48.872683][    T1] dvbdev: DVB: registering new adapter =
(dvb_vidtv_bridge)

[   48.883458][    T1] i2c i2c-0: DVB: registering adapter 0 frontend 0 =
(Dummy demod for DVB-T/T2/C/S/S2)...

[   48.888459][    T1] dvbdev: dvb_create_media_entity: media entity =
'Dummy demod for DVB-T/T2/C/S/S2' registered.

[   48.911703][    T1] dvbdev: dvb_create_media_entity: media entity =
'dvb-demux' registered.

[   48.927768][    T1] vidtv vidtv.0: Successfully initialized vidtv!

[   48.934795][    T1] vicodec vicodec.0: Device 'stateful-encoder' =
registered as /dev/video0

[   48.940384][    T1] vicodec vicodec.0: Device 'stateful-decoder' =
registered as /dev/video1

[   48.946585][    T1] vicodec vicodec.0: Device 'stateless-decoder' =
registered as /dev/video2

[   48.958068][    T1] vim2m vim2m.0: Device registered as /dev/video3

[   49.024484][    T1] vivid-000: using single planar format API

[   49.070180][    T1] vivid-000: CEC adapter cec0 registered for HDMI =
input

[   49.075701][    T1] vivid-000: V4L2 capture device registered as =
video7

[   49.080757][    T1] vivid-000: CEC adapter cec1 registered for HDMI =
output 0

[   49.085995][    T1] vivid-000: V4L2 output device registered as =
video8

[   49.091019][    T1] vivid-000: V4L2 capture device registered as =
vbi0, supports raw and sliced VBI

[   49.097113][    T1] vivid-000: V4L2 output device registered as vbi1, =
supports raw and sliced VBI

[   49.103217][    T1] vivid-000: V4L2 capture device registered as =
swradio0

[   49.108522][    T1] vivid-000: V4L2 receiver device registered as =
radio0

[   49.113406][    T1] vivid-000: V4L2 transmitter device registered as =
radio1

[   49.123804][    T1] vivid-000: V4L2 metadata capture device =
registered as video9

[   49.128680][    T1] vivid-000: V4L2 metadata output device registered =
as video10

[   49.134106][    T1] vivid-000: V4L2 touch capture device registered =
as v4l-touch0

[   49.139671][    T1] vivid-001: using multiplanar format API

[   49.182422][    T1] vivid-001: CEC adapter cec2 registered for HDMI =
input

[   49.187495][    T1] vivid-001: V4L2 capture device registered as =
video11

[   49.192464][    T1] vivid-001: CEC adapter cec3 registered for HDMI =
output 0

[   49.197664][    T1] vivid-001: V4L2 output device registered as =
video12

[   49.202563][    T1] vivid-001: V4L2 capture device registered as =
vbi2, supports raw and sliced VBI

[   49.208647][    T1] vivid-001: V4L2 output device registered as vbi3, =
supports raw and sliced VBI

[   49.214038][    T1] vivid-001: V4L2 capture device registered as =
swradio1

[   49.218556][    T1] vivid-001: V4L2 receiver device registered as =
radio2

[   49.223637][    T1] vivid-001: V4L2 transmitter device registered as =
radio3

[   49.228966][    T1] vivid-001: V4L2 metadata capture device =
registered as video13

[   49.234268][    T1] vivid-001: V4L2 metadata output device registered =
as video14

[   49.239637][    T1] vivid-001: V4L2 touch capture device registered =
as v4l-touch1

[   49.245124][    T1] vivid-002: using single planar format API

[   49.288916][    T1] vivid-002: CEC adapter cec4 registered for HDMI =
input

[   49.294018][    T1] vivid-002: V4L2 capture device registered as =
video15

[   49.298633][    T1] vivid-002: CEC adapter cec5 registered for HDMI =
output 0

[   49.303871][    T1] vivid-002: V4L2 output device registered as =
video16

[   49.308804][    T1] vivid-002: V4L2 capture device registered as =
vbi4, supports raw and sliced VBI

[   49.314797][    T1] vivid-002: V4L2 output device registered as vbi5, =
supports raw and sliced VBI

[   49.320846][    T1] vivid-002: V4L2 capture device registered as =
swradio2

[   49.326017][    T1] vivid-002: V4L2 receiver device registered as =
radio4

[   49.331089][    T1] vivid-002: V4L2 transmitter device registered as =
radio5

[   49.336335][    T1] vivid-002: V4L2 metadata capture device =
registered as video17

[   49.341793][    T1] vivid-002: V4L2 metadata output device registered =
as video18

[   49.346838][    T1] vivid-002: V4L2 touch capture device registered =
as v4l-touch2

[   49.352517][    T1] vivid-003: using multiplanar format API

[   49.395183][    T1] vivid-003: CEC adapter cec6 registered for HDMI =
input

[   49.399811][    T1] vivid-003: V4L2 capture device registered as =
video19

[   49.404941][    T1] vivid-003: CEC adapter cec7 registered for HDMI =
output 0

[   49.410106][    T1] vivid-003: V4L2 output device registered as =
video20

[   49.415211][    T1] vivid-003: V4L2 capture device registered as =
vbi6, supports raw and sliced VBI

[   49.421640][    T1] vivid-003: V4L2 output device registered as vbi7, =
supports raw and sliced VBI

[   49.427917][    T1] vivid-003: V4L2 capture device registered as =
swradio3

[   49.432891][    T1] vivid-003: V4L2 receiver device registered as =
radio6

[   49.438043][    T1] vivid-003: V4L2 transmitter device registered as =
radio7

[   49.442630][    T1] vivid-003: V4L2 metadata capture device =
registered as video21

[   49.448804][    T1] vivid-003: V4L2 metadata output device registered =
as video22

[   49.454011][    T1] vivid-003: V4L2 touch capture device registered =
as v4l-touch3

[   49.459057][    T1] vivid-004: using single planar format API

[   49.502819][    T1] vivid-004: CEC adapter cec8 registered for HDMI =
input

[   49.508190][    T1] vivid-004: V4L2 capture device registered as =
video23

[   49.513089][    T1] vivid-004: CEC adapter cec9 registered for HDMI =
output 0

[   49.517734][    T1] vivid-004: V4L2 output device registered as =
video24

[   49.522838][    T1] vivid-004: V4L2 capture device registered as =
vbi8, supports raw and sliced VBI

[   49.528926][    T1] vivid-004: V4L2 output device registered as vbi9, =
supports raw and sliced VBI

[   49.534964][    T1] vivid-004: V4L2 capture device registered as =
swradio4

[   49.539976][    T1] vivid-004: V4L2 receiver device registered as =
radio8

[   49.545078][    T1] vivid-004: V4L2 transmitter device registered as =
radio9

[   49.550365][    T1] vivid-004: V4L2 metadata capture device =
registered as video25

[   49.555871][    T1] vivid-004: V4L2 metadata output device registered =
as video26

[   49.560748][    T1] vivid-004: V4L2 touch capture device registered =
as v4l-touch4

[   49.566805][    T1] vivid-005: using multiplanar format API

[   49.610209][    T1] vivid-005: CEC adapter cec10 registered for HDMI =
input

[   49.615207][    T1] vivid-005: V4L2 capture device registered as =
video27

[   49.620380][    T1] vivid-005: CEC adapter cec11 registered for HDMI =
output 0

[   49.625534][    T1] vivid-005: V4L2 output device registered as =
video28

[   49.630627][    T1] vivid-005: V4L2 capture device registered as =
vbi10, supports raw and sliced VBI

[   49.636618][    T1] vivid-005: V4L2 output device registered as =
vbi11, supports raw and sliced VBI

[   49.642202][    T1] vivid-005: V4L2 capture device registered as =
swradio5

[   49.647781][    T1] vivid-005: V4L2 receiver device registered as =
radio10

[   49.653192][    T1] vivid-005: V4L2 transmitter device registered as =
radio11

[   49.658331][    T1] vivid-005: V4L2 metadata capture device =
registered as video29

[   49.663795][    T1] vivid-005: V4L2 metadata output device registered =
as video30

[   49.669032][    T1] vivid-005: V4L2 touch capture device registered =
as v4l-touch5

[   49.674139][    T1] vivid-006: using single planar format API

[   49.716682][    T1] vivid-006: CEC adapter cec12 registered for HDMI =
input

[   49.721536][    T1] vivid-006: V4L2 capture device registered as =
video31

[   49.726590][    T1] vivid-006: CEC adapter cec13 registered for HDMI =
output 0

[   49.732268][    T1] vivid-006: V4L2 output device registered as =
video32

[   49.737491][    T1] vivid-006: V4L2 capture device registered as =
vbi12, supports raw and sliced VBI

[   49.743784][    T1] vivid-006: V4L2 output device registered as =
vbi13, supports raw and sliced VBI

[   49.749920][    T1] vivid-006: V4L2 capture device registered as =
swradio6

[   49.754967][    T1] vivid-006: V4L2 receiver device registered as =
radio12

[   49.760328][    T1] vivid-006: V4L2 transmitter device registered as =
radio13

[   49.764931][    T1] vivid-006: V4L2 metadata capture device =
registered as video33

[   49.770481][    T1] vivid-006: V4L2 metadata output device registered =
as video34

[   49.776014][    T1] vivid-006: V4L2 touch capture device registered =
as v4l-touch6

[   49.781357][    T1] vivid-007: using multiplanar format API

[   49.824974][    T1] vivid-007: CEC adapter cec14 registered for HDMI =
input

[   49.829802][    T1] vivid-007: V4L2 capture device registered as =
video35

[   49.834899][    T1] vivid-007: CEC adapter cec15 registered for HDMI =
output 0

[   49.840239][    T1] vivid-007: V4L2 output device registered as =
video36

[   49.845199][    T1] vivid-007: V4L2 capture device registered as =
vbi14, supports raw and sliced VBI

[   49.851351][    T1] vivid-007: V4L2 output device registered as =
vbi15, supports raw and sliced VBI

[   49.857780][    T1] vivid-007: V4L2 capture device registered as =
swradio7

[   49.862806][    T1] vivid-007: V4L2 receiver device registered as =
radio14

[   49.867895][    T1] vivid-007: V4L2 transmitter device registered as =
radio15

[   49.872825][    T1] vivid-007: V4L2 metadata capture device =
registered as video37

[   49.878786][    T1] vivid-007: V4L2 metadata output device registered =
as video38

[   49.884347][    T1] vivid-007: V4L2 touch capture device registered =
as v4l-touch7

[   49.889915][    T1] vivid-008: using single planar format API

[   49.933254][    T1] vivid-008: CEC adapter cec16 registered for HDMI =
input

[   49.938795][    T1] vivid-008: V4L2 capture device registered as =
video39

[   49.943815][    T1] vivid-008: CEC adapter cec17 registered for HDMI =
output 0

[   49.949348][    T1] vivid-008: V4L2 output device registered as =
video40

[   49.953911][    T1] vivid-008: V4L2 capture device registered as =
vbi16, supports raw and sliced VBI

[   49.959681][    T1] vivid-008: V4L2 output device registered as =
vbi17, supports raw and sliced VBI

[   49.966578][    T1] vivid-008: V4L2 capture device registered as =
swradio8

[   49.972416][    T1] vivid-008: V4L2 receiver device registered as =
radio16

[   49.977970][    T1] vivid-008: V4L2 transmitter device registered as =
radio17

[   49.983192][    T1] vivid-008: V4L2 metadata capture device =
registered as video41

[   49.988781][    T1] vivid-008: V4L2 metadata output device registered =
as video42

[   49.994173][    T1] vivid-008: V4L2 touch capture device registered =
as v4l-touch8

[   50.000049][    T1] vivid-009: using multiplanar format API

[   50.043348][    T1] vivid-009: CEC adapter cec18 registered for HDMI =
input

[   50.049009][    T1] vivid-009: V4L2 capture device registered as =
video43

[   50.053584][    T1] vivid-009: CEC adapter cec19 registered for HDMI =
output 0

[   50.058461][    T1] vivid-009: V4L2 output device registered as =
video44

[   50.063654][    T1] vivid-009: V4L2 capture device registered as =
vbi18, supports raw and sliced VBI

[   50.069973][    T1] vivid-009: V4L2 output device registered as =
vbi19, supports raw and sliced VBI

[   50.076159][    T1] vivid-009: V4L2 capture device registered as =
swradio9

[   50.081404][    T1] vivid-009: V4L2 receiver device registered as =
radio18

[   50.087398][    T1] vivid-009: V4L2 transmitter device registered as =
radio19

[   50.092701][    T1] vivid-009: V4L2 metadata capture device =
registered as video45

[   50.098429][    T1] vivid-009: V4L2 metadata output device registered =
as video46

[   50.103331][    T1] vivid-009: V4L2 touch capture device registered =
as v4l-touch9

[   50.108414][    T1] vivid-010: using single planar format API

[   50.151911][    T1] vivid-010: CEC adapter cec20 registered for HDMI =
input

[   50.157292][    T1] vivid-010: V4L2 capture device registered as =
video47

[   50.162641][    T1] vivid-010: CEC adapter cec21 registered for HDMI =
output 0

[   50.168326][    T1] vivid-010: V4L2 output device registered as =
video48

[   50.173409][    T1] vivid-010: V4L2 capture device registered as =
vbi20, supports raw and sliced VBI

[   50.179680][    T1] vivid-010: V4L2 output device registered as =
vbi21, supports raw and sliced VBI

[   50.185855][    T1] vivid-010: V4L2 capture device registered as =
swradio10

[   50.191326][    T1] vivid-010: V4L2 receiver device registered as =
radio20

[   50.196461][    T1] vivid-010: V4L2 transmitter device registered as =
radio21

[   50.201775][    T1] vivid-010: V4L2 metadata capture device =
registered as video49

[   50.207636][    T1] vivid-010: V4L2 metadata output device registered =
as video50

[   50.213184][    T1] vivid-010: V4L2 touch capture device registered =
as v4l-touch10

[   50.218887][    T1] vivid-011: using multiplanar format API

[   50.262862][    T1] vivid-011: CEC adapter cec22 registered for HDMI =
input

[   50.268294][    T1] vivid-011: V4L2 capture device registered as =
video51

[   50.273014][    T1] vivid-011: CEC adapter cec23 registered for HDMI =
output 0

[   50.278980][    T1] vivid-011: V4L2 output device registered as =
video52

[   50.284040][    T1] vivid-011: V4L2 capture device registered as =
vbi22, supports raw and sliced VBI

[   50.290417][    T1] vivid-011: V4L2 output device registered as =
vbi23, supports raw and sliced VBI

[   50.296605][    T1] vivid-011: V4L2 capture device registered as =
swradio11

[   50.301920][    T1] vivid-011: V4L2 receiver device registered as =
radio22

[   50.307142][    T1] vivid-011: V4L2 transmitter device registered as =
radio23

[   50.312465][    T1] vivid-011: V4L2 metadata capture device =
registered as video53

[   50.317561][    T1] vivid-011: V4L2 metadata output device registered =
as video54

[   50.323412][    T1] vivid-011: V4L2 touch capture device registered =
as v4l-touch11

[   50.328935][    T1] vivid-012: using single planar format API

[   50.372349][    T1] vivid-012: CEC adapter cec24 registered for HDMI =
input

[   50.378068][    T1] vivid-012: V4L2 capture device registered as =
video55

[   50.383065][    T1] vivid-012: CEC adapter cec25 registered for HDMI =
output 0

[   50.388462][    T1] vivid-012: V4L2 output device registered as =
video56

[   50.393565][    T1] vivid-012: V4L2 capture device registered as =
vbi24, supports raw and sliced VBI

[   50.399885][    T1] vivid-012: V4L2 output device registered as =
vbi25, supports raw and sliced VBI

[   50.405567][    T1] vivid-012: V4L2 capture device registered as =
swradio12

[   50.410997][    T1] vivid-012: V4L2 receiver device registered as =
radio24

[   50.416461][    T1] vivid-012: V4L2 transmitter device registered as =
radio25

[   50.421343][    T1] vivid-012: V4L2 metadata capture device =
registered as video57

[   50.427105][    T1] vivid-012: V4L2 metadata output device registered =
as video58

[   50.433078][    T1] vivid-012: V4L2 touch capture device registered =
as v4l-touch12

[   50.438507][    T1] vivid-013: using multiplanar format API

[   50.482011][    T1] vivid-013: CEC adapter cec26 registered for HDMI =
input

[   50.487339][    T1] vivid-013: V4L2 capture device registered as =
video59

[   50.492393][    T1] vivid-013: CEC adapter cec27 registered for HDMI =
output 0

[   50.497875][    T1] vivid-013: V4L2 output device registered as =
video60

[   50.502319][    T1] vivid-013: V4L2 capture device registered as =
vbi26, supports raw and sliced VBI

[   50.508122][    T1] vivid-013: V4L2 output device registered as =
vbi27, supports raw and sliced VBI

[   50.514268][    T1] vivid-013: V4L2 capture device registered as =
swradio13

[   50.519375][    T1] vivid-013: V4L2 receiver device registered as =
radio26

[   50.524323][    T1] vivid-013: V4L2 transmitter device registered as =
radio27

[   50.529669][    T1] vivid-013: V4L2 metadata capture device =
registered as video61

[   50.535065][    T1] vivid-013: V4L2 metadata output device registered =
as video62

[   50.540804][    T1] vivid-013: V4L2 touch capture device registered =
as v4l-touch13

[   50.546041][    T1] vivid-014: using single planar format API

[   50.589890][    T1] vivid-014: CEC adapter cec28 registered for HDMI =
input

[   50.595011][    T1] vivid-014: V4L2 capture device registered as =
video63

[   50.599612][    T1] vivid-014: CEC adapter cec29 registered for HDMI =
output 0

[   50.604969][    T1] vivid-014: V4L2 output device registered as =
video64

[   50.609959][    T1] vivid-014: V4L2 capture device registered as =
vbi28, supports raw and sliced VBI

[   50.616694][    T1] vivid-014: V4L2 output device registered as =
vbi29, supports raw and sliced VBI

[   50.622991][    T1] vivid-014: V4L2 capture device registered as =
swradio14

[   50.628179][    T1] vivid-014: V4L2 receiver device registered as =
radio28

[   50.633324][    T1] vivid-014: V4L2 transmitter device registered as =
radio29

[   50.638444][    T1] vivid-014: V4L2 metadata capture device =
registered as video65

[   50.643737][    T1] vivid-014: V4L2 metadata output device registered =
as video66

[   50.648780][    T1] vivid-014: V4L2 touch capture device registered =
as v4l-touch14

[   50.654443][    T1] vivid-015: using multiplanar format API

[   50.697615][    T1] vivid-015: CEC adapter cec30 registered for HDMI =
input

[   50.702729][    T1] vivid-015: V4L2 capture device registered as =
video67

[   50.707912][    T1] vivid-015: CEC adapter cec31 registered for HDMI =
output 0

[   50.713158][    T1] vivid-015: V4L2 output device registered as =
video68

[   50.718183][    T1] vivid-015: V4L2 capture device registered as =
vbi30, supports raw and sliced VBI

[   50.724204][    T1] vivid-015: V4L2 output device registered as =
vbi31, supports raw and sliced VBI

[   50.730514][    T1] vivid-015: V4L2 capture device registered as =
swradio15

[   50.735170][    T1] vivid-015: V4L2 receiver device registered as =
radio30

[   50.739695][    T1] vivid-015: V4L2 transmitter device registered as =
radio31

[   50.745290][    T1] vivid-015: V4L2 metadata capture device =
registered as video69

[   50.750689][    T1] vivid-015: V4L2 metadata output device registered =
as video70

[   50.756016][    T1] vivid-015: V4L2 touch capture device registered =
as v4l-touch15

[   50.761605][    T1] vivid-016: using single planar format API

[   50.805256][    T1] vivid-016: CEC adapter cec32 registered for HDMI =
input

[   50.810549][    T1] vivid-016: V4L2 capture device registered as =
video71

[   50.815508][    T1] vivid-016: CEC adapter cec33 registered for HDMI =
output 0

[   50.820925][    T1] vivid-016: V4L2 output device registered as =
video72

[   50.825361][    T1] vivid-016: V4L2 capture device registered as =
vbi32, supports raw and sliced VBI

[   50.831006][    T1] vivid-016: V4L2 output device registered as =
vbi33, supports raw and sliced VBI

[   50.837271][    T1] vivid-016: V4L2 capture device registered as =
swradio16

[   50.842592][    T1] vivid-016: V4L2 receiver device registered as =
radio32

[   50.847798][    T1] vivid-016: V4L2 transmitter device registered as =
radio33

[   50.853504][    T1] vivid-016: V4L2 metadata capture device =
registered as video73

[   50.858935][    T1] vivid-016: V4L2 metadata output device registered =
as video74

[   50.864257][    T1] vivid-016: V4L2 touch capture device registered =
as v4l-touch16

[   50.869819][    T1] vivid-017: using multiplanar format API

[   50.913119][    T1] vivid-017: CEC adapter cec34 registered for HDMI =
input

[   50.917841][    T1] vivid-017: V4L2 capture device registered as =
video75

[   50.923045][    T1] vivid-017: CEC adapter cec35 registered for HDMI =
output 0

[   50.928428][    T1] vivid-017: V4L2 output device registered as =
video76

[   50.933389][    T1] vivid-017: V4L2 capture device registered as =
vbi34, supports raw and sliced VBI

[   50.939564][    T1] vivid-017: V4L2 output device registered as =
vbi35, supports raw and sliced VBI

[   50.945545][    T1] vivid-017: V4L2 capture device registered as =
swradio17

[   50.950948][    T1] vivid-017: V4L2 receiver device registered as =
radio34

[   50.956008][    T1] vivid-017: V4L2 transmitter device registered as =
radio35

[   50.960855][    T1] vivid-017: V4L2 metadata capture device =
registered as video77

[   50.966612][    T1] vivid-017: V4L2 metadata output device registered =
as video78

[   50.972191][    T1] vivid-017: V4L2 touch capture device registered =
as v4l-touch17

[   50.978242][    T1] vivid-018: using single planar format API

[   51.021695][    T1] vivid-018: CEC adapter cec36 registered for HDMI =
input

[   51.027224][    T1] vivid-018: V4L2 capture device registered as =
video79

[   51.031972][    T1] vivid-018: CEC adapter cec37 registered for HDMI =
output 0

[   51.037081][    T1] vivid-018: V4L2 output device registered as =
video80

[   51.041757][    T1] vivid-018: V4L2 capture device registered as =
vbi36, supports raw and sliced VBI

[   51.047985][    T1] vivid-018: V4L2 output device registered as =
vbi37, supports raw and sliced VBI

[   51.054236][    T1] vivid-018: V4L2 capture device registered as =
swradio18

[   51.059303][    T1] vivid-018: V4L2 receiver device registered as =
radio36

[   51.064397][    T1] vivid-018: V4L2 transmitter device registered as =
radio37

[   51.070132][    T1] vivid-018: V4L2 metadata capture device =
registered as video81

[   51.075435][    T1] vivid-018: V4L2 metadata output device registered =
as video82

[   51.080862][    T1] vivid-018: V4L2 touch capture device registered =
as v4l-touch18

[   51.086228][    T1] vivid-019: using multiplanar format API

[   51.130431][    T1] vivid-019: CEC adapter cec38 registered for HDMI =
input

[   51.135549][    T1] vivid-019: V4L2 capture device registered as =
video83

[   51.140596][    T1] vivid-019: CEC adapter cec39 registered for HDMI =
output 0

[   51.145328][    T1] vivid-019: V4L2 output device registered as =
video84

[   51.150055][    T1] vivid-019: V4L2 capture device registered as =
vbi38, supports raw and sliced VBI

[   51.156308][    T1] vivid-019: V4L2 output device registered as =
vbi39, supports raw and sliced VBI

[   51.162688][    T1] vivid-019: V4L2 capture device registered as =
swradio19

[   51.167866][    T1] vivid-019: V4L2 receiver device registered as =
radio38

[   51.172937][    T1] vivid-019: V4L2 transmitter device registered as =
radio39

[   51.178898][    T1] vivid-019: V4L2 metadata capture device =
registered as video85

[   51.184297][    T1] vivid-019: V4L2 metadata output device registered =
as video86

[   51.189773][    T1] vivid-019: V4L2 touch capture device registered =
as v4l-touch19

[   51.195113][    T1] vivid-020: using single planar format API

[   51.238776][    T1] vivid-020: CEC adapter cec40 registered for HDMI =
input

[   51.243493][    T1] vivid-020: V4L2 capture device registered as =
video87

[   51.249290][    T1] vivid-020: CEC adapter cec41 registered for HDMI =
output 0

[   51.254920][    T1] vivid-020: V4L2 output device registered as =
video88

[   51.260200][    T1] vivid-020: V4L2 capture device registered as =
vbi40, supports raw and sliced VBI

[   51.266571][    T1] vivid-020: V4L2 output device registered as =
vbi41, supports raw and sliced VBI

[   51.272767][    T1] vivid-020: V4L2 capture device registered as =
swradio20

[   51.277936][    T1] vivid-020: V4L2 receiver device registered as =
radio40

[   51.282953][    T1] vivid-020: V4L2 transmitter device registered as =
radio41

[   51.288844][    T1] vivid-020: V4L2 metadata capture device =
registered as video89

[   51.294247][    T1] vivid-020: V4L2 metadata output device registered =
as video90

[   51.299834][    T1] vivid-020: V4L2 touch capture device registered =
as v4l-touch20

[   51.305212][    T1] vivid-021: using multiplanar format API

[   51.349210][    T1] vivid-021: CEC adapter cec42 registered for HDMI =
input

[   51.354377][    T1] vivid-021: V4L2 capture device registered as =
video91

[   51.359458][    T1] vivid-021: CEC adapter cec43 registered for HDMI =
output 0

[   51.364322][    T1] vivid-021: V4L2 output device registered as =
video92

[   51.369165][    T1] vivid-021: V4L2 capture device registered as =
vbi42, supports raw and sliced VBI

[   51.375468][    T1] vivid-021: V4L2 output device registered as =
vbi43, supports raw and sliced VBI

[   51.381599][    T1] vivid-021: V4L2 capture device registered as =
swradio21

[   51.386802][    T1] vivid-021: V4L2 receiver device registered as =
radio42

[   51.391910][    T1] vivid-021: V4L2 transmitter device registered as =
radio43

[   51.397221][    T1] vivid-021: V4L2 metadata capture device =
registered as video93

[   51.403046][    T1] vivid-021: V4L2 metadata output device registered =
as video94

[   51.408502][    T1] vivid-021: V4L2 touch capture device registered =
as v4l-touch21

[   51.413853][    T1] vivid-022: using single planar format API

[   51.457331][    T1] vivid-022: CEC adapter cec44 registered for HDMI =
input

[   51.461909][    T1] vivid-022: V4L2 capture device registered as =
video95

[   51.467404][    T1] vivid-022: CEC adapter cec45 registered for HDMI =
output 0

[   51.473132][    T1] vivid-022: V4L2 output device registered as =
video96

[   51.478378][    T1] vivid-022: V4L2 capture device registered as =
vbi44, supports raw and sliced VBI

[   51.485155][    T1] vivid-022: V4L2 output device registered as =
vbi45, supports raw and sliced VBI

[   51.491410][    T1] vivid-022: V4L2 capture device registered as =
swradio22

[   51.496453][    T1] vivid-022: V4L2 receiver device registered as =
radio44

[   51.501230][    T1] vivid-022: V4L2 transmitter device registered as =
radio45

[   51.506573][    T1] vivid-022: V4L2 metadata capture device =
registered as video97

[   51.512103][    T1] vivid-022: V4L2 metadata output device registered =
as video98

[   51.517954][    T1] vivid-022: V4L2 touch capture device registered =
as v4l-touch22

[   51.523353][    T1] vivid-023: using multiplanar format API

[   51.567390][    T1] vivid-023: CEC adapter cec46 registered for HDMI =
input

[   51.572621][    T1] vivid-023: V4L2 capture device registered as =
video99

[   51.577698][    T1] vivid-023: CEC adapter cec47 registered for HDMI =
output 0

[   51.582903][    T1] vivid-023: V4L2 output device registered as =
video100

[   51.587911][    T1] vivid-023: V4L2 capture device registered as =
vbi46, supports raw and sliced VBI

[   51.593545][    T1] vivid-023: V4L2 output device registered as =
vbi47, supports raw and sliced VBI

[   51.599101][    T1] vivid-023: V4L2 capture device registered as =
swradio23

[   51.604401][    T1] vivid-023: V4L2 receiver device registered as =
radio46

[   51.609667][    T1] vivid-023: V4L2 transmitter device registered as =
radio47

[   51.614843][    T1] vivid-023: V4L2 metadata capture device =
registered as video101

[   51.620458][    T1] vivid-023: V4L2 metadata output device registered =
as video102

[   51.625814][    T1] vivid-023: V4L2 touch capture device registered =
as v4l-touch23

[   51.631223][    T1] vivid-024: using single planar format API

[   51.675213][    T1] vivid-024: CEC adapter cec48 registered for HDMI =
input

[   51.680314][    T1] vivid-024: V4L2 capture device registered as =
video103

[   51.685537][    T1] vivid-024: CEC adapter cec49 registered for HDMI =
output 0

[   51.688973][    T1] videodev: could not get a free minor

[   51.729398][    T1] usbcore: registered new interface driver =
radioshark2

[   51.733888][    T1] usbcore: registered new interface driver =
radioshark

[   51.738662][    T1] usbcore: registered new interface driver =
radio-si470x

[   51.742882][    T1] usbcore: registered new interface driver =
radio-usb-si4713

[   51.747654][    T1] usbcore: registered new interface driver dsbr100

[   51.752041][    T1] usbcore: registered new interface driver =
radio-keene

[   51.756498][    T1] usbcore: registered new interface driver =
radio-ma901

[   51.761056][    T1] usbcore: registered new interface driver =
radio-mr800

[   51.765509][    T1] usbcore: registered new interface driver =
radio-raremono

[   51.772808][    T1] usbcore: registered new interface driver powerz

[   51.777191][    T1] usbcore: registered new interface driver pcwd_usb

[   51.785437][    T1] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is =
disabled. Duplicate IMA measurements will not be recorded in the IMA =
log.

[   51.791581][    T1] device-mapper: uevent: version 1.0.3

[   51.796831][    T1] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) =
initialised: dm-devel@lists.linux.dev

[   51.804270][    T1] device-mapper: multipath round-robin: version =
1.2.0 loaded

[   51.807753][    T1] device-mapper: multipath queue-length: version =
0.2.0 loaded

[   51.811151][    T1] device-mapper: multipath service-time: version =
0.3.0 loaded

[   51.816571][    T1] Bluetooth: HCI UART driver ver 2.3

[   51.819048][    T1] Bluetooth: HCI UART protocol H4 registered

[   51.821759][    T1] Bluetooth: HCI UART protocol BCSP registered

[   51.825297][    T1] Bluetooth: HCI UART protocol LL registered

[   51.828463][    T1] Bluetooth: HCI UART protocol Three-wire (H5) =
registered

[   51.831905][    T1] Bluetooth: HCI UART protocol QCA registered

[   51.834703][    T1] Bluetooth: HCI UART protocol AG6XX registered

[   51.838970][    T1] Bluetooth: HCI UART protocol Marvell registered

[   51.843290][    T1] usbcore: registered new interface driver bcm203x

[   51.847626][    T1] usbcore: registered new interface driver bpa10x

[   51.851909][    T1] usbcore: registered new interface driver bfusb

[   51.856637][    T1] usbcore: registered new interface driver btusb

[   51.861830][    T1] usbcore: registered new interface driver ath3k

[   51.867035][    T1] Modular ISDN core version 1.1.29

[   51.871785][    T1] NET: Registered PF_ISDN protocol family

[   51.874382][    T1] DSP module 2.0

[   51.876014][    T1] mISDN_dsp: DSP clocks every 80 samples. This =
equals 1 jiffies.

[   51.926578][    T1] mISDN: Layer-1-over-IP driver Rev. 2.00

[   51.932177][    T1] 0 virtual devices registered

[   51.935962][    T1] usbcore: registered new interface driver =
HFC-S_USB

[   51.939380][    T1] amd_pstate: The CPPC feature is supported but =
currently disabled by the BIOS.

[   51.939380][    T1] Please enable it if your BIOS has the CPPC =
option.

[   51.946422][    T1] amd_pstate: the _CPC object is not present in =
SBIOS or ACPI disabled

[   51.950231][    T1] VUB300 Driver rom wait states =3D 1C irqpoll =
timeout =3D 0400

[   51.953876][    T1] usbcore: registered new interface driver vub300

[   51.961004][    T1] usbcore: registered new interface driver ushc

[   51.978288][    T1] iscsi: registered transport (iser)

[   51.985112][    T1] SoftiWARP attached

[   52.010074][    T1] hid: raw HID events driver (C) Jiri Kosina

[   52.134342][    T1] usbcore: registered new interface driver usbhid

[   52.137760][    T1] usbhid: USB HID core driver

[   52.148738][    T1] usbcore: registered new interface driver =
es2_ap_driver

[   52.151960][    T1] comedi: version 0.7.76 - http://www.comedi.org

[   52.155864][    T1] usbcore: registered new interface driver dt9812

[   52.160199][    T1] usbcore: registered new interface driver ni6501

[   52.164435][    T1] usbcore: registered new interface driver usbdux

[   52.168685][    T1] usbcore: registered new interface driver =
usbduxfast

[   52.172999][    T1] usbcore: registered new interface driver =
usbduxsigma

[   52.177062][    T1] usbcore: registered new interface driver vmk80xx

[   52.180530][    T1] greybus: registered new driver hid

[   52.183963][    T1] greybus: registered new driver gbphy

[   52.187159][    T1] gb_gbphy: registered new driver usb

[   52.189875][    T1] asus_wmi: ASUS WMI generic driver loaded

[   52.210590][    T1] gnss: GNSS driver registered with major 494

[   52.214205][    T1] usbcore: registered new interface driver gnss-usb

[   52.218217][    T1] usbcore: registered new interface driver hdm_usb

[   52.362946][    T1] usbcore: registered new interface driver =
snd-usb-audio

[   52.367500][    T1] usbcore: registered new interface driver =
snd-ua101

[   52.371718][    T1] usbcore: registered new interface driver =
snd-usb-usx2y

[   52.376390][    T1] usbcore: registered new interface driver =
snd-usb-us122l

[   52.382293][    T1] usbcore: registered new interface driver =
snd-usb-caiaq

[   52.386645][    T1] usbcore: registered new interface driver =
snd-usb-6fire

[   52.391757][    T1] usbcore: registered new interface driver =
snd-usb-hiface

[   52.396397][    T1] usbcore: registered new interface driver =
snd-bcd2000

[   52.401742][    T1] usbcore: registered new interface driver =
snd_usb_pod

[   52.406328][    T1] usbcore: registered new interface driver =
snd_usb_podhd

[   52.411124][    T1] usbcore: registered new interface driver =
snd_usb_toneport

[   52.415872][    T1] usbcore: registered new interface driver =
snd_usb_variax

[   52.423606][    T1] drop_monitor: Initializing network drop monitor =
service

[   52.427799][    T1] NET: Registered PF_LLC protocol family

[   52.430618][    T1] GACT probability on

[   52.432558][    T1] Mirror/redirect action on

[   52.434936][    T1] Simple TC action Loaded

[   52.444565][    T1] netem: version 1.3

[   52.446635][    T1] u32 classifier

[   52.448409][    T1]     Performance counters on

[   52.450560][    T1]     input device check on

[   52.452633][    T1]     Actions configured

[   52.459193][    T1] nf_conntrack_irc: failed to register helpers

[   52.462177][    T1] nf_conntrack_sane: failed to register helpers

[   52.571709][    T1] nf_conntrack_sip: failed to register helpers

[   52.580911][    T1] xt_time: kernel timezone is -0000

[   52.583528][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, =
ESP)

[   52.588232][    T1] IPVS: Connection hash table configured =
(size=3D4096, memory=3D32Kbytes)

[   52.593277][    T1] IPVS: ipvs loaded.

[   52.595086][    T1] IPVS: [rr] scheduler registered.

[   52.597484][    T1] IPVS: [wrr] scheduler registered.

[   52.599840][    T1] IPVS: [lc] scheduler registered.

[   52.602161][    T1] IPVS: [wlc] scheduler registered.

[   52.604524][    T1] IPVS: [fo] scheduler registered.

[   52.606894][    T1] IPVS: [ovf] scheduler registered.

[   52.609309][    T1] IPVS: [lblc] scheduler registered.

[   52.611740][    T1] IPVS: [lblcr] scheduler registered.

[   52.614181][    T1] IPVS: [dh] scheduler registered.

[   52.616522][    T1] IPVS: [sh] scheduler registered.

[   52.618927][    T1] IPVS: [mh] scheduler registered.

[   52.621224][    T1] IPVS: [sed] scheduler registered.

[   52.623560][    T1] IPVS: [nq] scheduler registered.

[   52.625911][    T1] IPVS: [twos] scheduler registered.

[   52.628531][    T1] IPVS: [sip] pe registered.

[   52.630939][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver

[   52.640191][    T1] gre: GRE over IPv4 demultiplexer driver

[   52.642806][    T1] ip_gre: GRE over IPv4 tunneling driver

[   52.664517][    T1] IPv4 over IPsec tunneling driver

[   52.675224][    T1] Initializing XFRM netlink socket

[   52.677900][    T1] IPsec XFRM device driver

[   52.680908][    T1] NET: Registered PF_INET6 protocol family

[   52.708170][    T1] Segment Routing with IPv6

[   52.710310][    T1] RPL Segment Routing with IPv6

[   52.712864][    T1] In-situ OAM (IOAM) with IPv6

[   52.715518][    T1] mip6: Mobile IPv6

[   52.725534][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling =
driver

[   52.744360][    T1] ip6_gre: GRE over IPv6 tunneling driver

[   52.756365][    T1] NET: Registered PF_PACKET protocol family

[   52.759309][    T1] NET: Registered PF_KEY protocol family

[   52.763095][    T1] Bridge firewalling registered

[   52.766617][    T1] NET: Registered PF_X25 protocol family

[   52.769494][    T1] X25: Linux Version 0.2

[   52.944709][    T1] NET: Registered PF_NETROM protocol family

[   53.026036][ T3380] kworker/u20:0 (3380) used greatest stack depth: =
26968 bytes left

[   53.119280][    T1] NET: Registered PF_ROSE protocol family

[   53.122311][    T1] NET: Registered PF_AX25 protocol family

[   53.125069][    T1] can: controller area network core

[   53.127961][    T1] NET: Registered PF_CAN protocol family

[   53.130596][    T1] can: raw protocol

[   53.132443][    T1] can: broadcast manager protocol

[   53.134825][    T1] can: netlink gateway - max_hops=3D1

[   53.137961][    T1] can: SAE J1939

[   53.139658][    T1] can: isotp protocol (max_pdu_size 8300)

[   53.143000][    T1] Bluetooth: RFCOMM TTY layer initialized

[   53.145721][    T1] Bluetooth: RFCOMM socket layer initialized

[   53.148744][    T1] Bluetooth: RFCOMM ver 1.11

[   53.150946][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3

[   53.153856][    T1] Bluetooth: BNEP filters: protocol multicast

[   53.156672][    T1] Bluetooth: BNEP socket layer initialized

[   53.159408][    T1] Bluetooth: HIDP (Human Interface Emulation) ver =
1.2

[   53.162526][    T1] Bluetooth: HIDP socket layer initialized

[   53.169769][    T1] NET: Registered PF_RXRPC protocol family

[   53.172512][    T1] Key type rxrpc registered

[   53.174589][    T1] Key type rxrpc_s registered

[   53.177957][    T1] NET: Registered PF_KCM protocol family

[   53.181844][    T1] lec:lane_module_init: lec.c: initialized

[   53.184594][    T1] mpoa:atm_mpoa_init: mpc.c: initialized

[   53.187716][    T1] l2tp_core: L2TP core driver, V2.0

[   53.190139][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0

[   53.192724][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)

[   53.195784][    T1] l2tp_netlink: L2TP netlink interface

[   53.198597][    T1] l2tp_eth: L2TP ethernet pseudowire support =
(L2TPv3)

[   53.201745][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 =
(L2TPv3)

[   53.205527][    T1] NET: Registered PF_PHONET protocol family

[   53.208643][    T1] 8021q: 802.1Q VLAN Support v1.8

[   53.211406][    T1] sctp: Hash tables configured (bind 32/56)

[   53.216832][    T1] NET: Registered PF_RDS protocol family

[   53.220499][    T1] Registered RDS/infiniband transport

[   53.224226][    T1] Registered RDS/tcp transport

[   53.226388][    T1] tipc: Activated (version 2.0.0)

[   53.229749][    T1] NET: Registered PF_TIPC protocol family

[   53.233716][    T1] tipc: Started in single node mode

[   53.237721][    T1] NET: Registered PF_SMC protocol family

[   53.241060][    T1] 9pnet: Installing 9P2000 support

[   53.244412][    T1] NET: Registered PF_CAIF protocol family

[   53.253520][    T1] NET: Registered PF_IEEE802154 protocol family

[   53.256942][    T1] Key type dns_resolver registered

[   53.259434][    T1] Key type ceph registered

[   53.262383][    T1] libceph: loaded (mon/osd proto 15/24)

[   53.267596][    T1] batman_adv: B.A.T.M.A.N. advanced 2025.2 =
(compatibility version 15) loaded

[   53.271887][    T1] openvswitch: Open vSwitch switching datapath

[   53.278936][    T1] NET: Registered PF_VSOCK protocol family

[   53.282082][    T1] mpls_gso: MPLS GSO support

[   53.365483][    T1] IPI shorthand broadcast: enabled

[   54.724851][    T1] registered taskstats version 1

[   54.750693][    T1] Loading compiled-in X.509 certificates

[   54.900931][    T1] Loaded X.509 cert 'Build time autogenerated =
kernel key: 8ba70d5a468c7ed3b71045d84263bfdc6283ff56'

[   55.513422][    T1] zswap: loaded using pool 842/zsmalloc

[   55.522073][    T1] Demotion targets for Node 0: null

[   55.524609][    T1] Demotion targets for Node 1: null

[   55.527197][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: =
Validating architecture page table helpers

[   55.535991][    T1] Key type .fscrypt registered

[   55.538315][    T1] Key type fscrypt-provisioning registered

[   55.552836][    T1] kAFS: Red Hat AFS client v0.1 registering.

[   55.594672][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, =
zoned=3Dyes, fsverity=3Dyes

[   55.599350][    T1] Key type big_key registered

[   55.601596][    T1] Key type encrypted registered

[   55.604015][    T1] ima: No TPM chip found, activating TPM-bypass!

[   55.607072][    T1] Loading compiled-in module X.509 certificates

[   55.754165][    T1] Loaded X.509 cert 'Build time autogenerated =
kernel key: 8ba70d5a468c7ed3b71045d84263bfdc6283ff56'

[   55.759232][    T1] ima: Allocated hash algorithm: sha256

[   55.762143][    T1] ima: No architecture policies found

[   55.765385][    T1] evm: Initialising EVM extended attributes:

[   55.768204][    T1] evm: security.selinux

[   55.770099][    T1] evm: security.SMACK64 (disabled)

[   55.772416][    T1] evm: security.SMACK64EXEC (disabled)

[   55.774851][    T1] evm: security.SMACK64TRANSMUTE (disabled)

[   55.777621][    T1] evm: security.SMACK64MMAP (disabled)

[   55.780081][    T1] evm: security.apparmor (disabled)

[   55.782403][    T1] evm: security.ima

[   55.784145][    T1] evm: security.capability

[   55.786129][    T1] evm: HMAC attrs: 0x1

[   55.791688][    T1] PM:   Magic number: 1:44:760

[   55.795473][    T1] printk: legacy console [netcon0] enabled

[   55.798291][    T1] netconsole: network logging started

[   55.801791][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)

[   55.814840][    T1] rdma_rxe: loaded

[   55.818440][    T1] cfg80211: Loading compiled-in X.509 certificates =
for regulatory database

[   55.828419][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'

[   55.836003][    T1] Loaded X.509 cert 'wens: =
61c038651aabdcf94bd0ac7ff06c7248db18c600'

[   55.841193][ T1007] platform regulatory.0: Direct firmware load for =
regulatory.db failed with error -2

[   55.845573][ T1007] platform regulatory.0: Falling back to sysfs =
fallback for: regulatory.db

[   55.847089][    T1] Unstable clock detected, switching default =
tracing clock to "global"

[   55.847089][    T1] If you want to keep using the local clock, then =
add:

[   55.847089][    T1]   "trace_clock=3Dlocal"

[   55.847089][    T1] on the kernel command line

[   55.861384][    T1] clk: Disabling unused clocks

[   55.863640][    T1] ALSA device list:

[   55.865468][    T1]   #0: Dummy 1

[   55.867992][    T1]   #1: Loopback 1

[   55.869705][    T1]   #2: Virtual MIDI Card 1

[   55.876322][    T1] md: Waiting for all devices to be available =
before autodetect

[   55.879250][    T1] md: If you don't use raid, use raid=3Dnoautodetect

[   55.881104][    T1] md: Autodetecting RAID arrays.

[   55.882541][    T1] md: autorun ...

[   55.883609][    T1] md: ... autorun DONE.

[   55.917932][    T1] EXT4-fs (sda): INFO: recovery required on =
readonly filesystem

[   55.920181][    T1] EXT4-fs (sda): write access will be enabled =
during recovery

[   55.988585][    T1] EXT4-fs (sda): recovery complete

[   55.994971][    T1] EXT4-fs (sda): mounted filesystem =
0645c0ca-13f1-4874-936a-93dfe93231c8 ro with ordered data mode. Quota =
mode: none.

[   55.999020][    T1] VFS: Mounted root (ext4 filesystem) readonly on =
device 8:0.

[   56.011459][    T1] devtmpfs: mounted

[   56.143970][    T1] Freeing unused kernel image (initmem) memory: =
27612K

[   56.148983][    T1] Write protecting the kernel read-only data: =
212992k

[   56.178216][    T1] Freeing unused kernel image (text/rodata gap) =
memory: 140K

[   56.189008][    T1] Freeing unused kernel image (rodata/data gap) =
memory: 824K

[   63.095818][    T1] x86/mm: Checked W+X mappings: passed, no W+X =
pages found.

[   63.105178][    T1] Failed to set sysctl parameter =
'max_rcu_stall_to_panic=3D1': parameter not found

[   63.109015][    T1] Run /sbin/init as init process

[   65.719457][    T1] SELinux:  Permission firmware_load in class =
system not defined in policy.

[   65.722019][    T1] SELinux:  Permission kexec_image_load in class =
system not defined in policy.

[   65.724504][    T1] SELinux:  Permission kexec_initramfs_load in =
class system not defined in policy.

[   65.727205][    T1] SELinux:  Permission policy_load in class system =
not defined in policy.

[   65.729628][    T1] SELinux:  Permission x509_certificate_load in =
class system not defined in policy.

[   65.732363][    T1] SELinux:  Permission watch_mountns in class file =
not defined in policy.

[   65.734756][    T1] SELinux:  Permission watch_mountns in class dir =
not defined in policy.

[   65.737194][    T1] SELinux:  Permission watch_mountns in class =
lnk_file not defined in policy.

[   65.739640][    T1] SELinux:  Permission watch_mountns in class =
chr_file not defined in policy.

[   65.742080][    T1] SELinux:  Permission watch_mountns in class =
blk_file not defined in policy.

[   65.744534][    T1] SELinux:  Permission watch_mountns in class =
sock_file not defined in policy.

[   65.747097][    T1] SELinux:  Permission watch_mountns in class =
fifo_file not defined in policy.

[   65.749788][    T1] SELinux:  Permission nlmsg in class =
netlink_route_socket not defined in policy.

[   65.752337][    T1] SELinux:  Permission nlmsg in class =
netlink_tcpdiag_socket not defined in policy.

[   65.754963][    T1] SELinux:  Permission nlmsg in class =
netlink_xfrm_socket not defined in policy.

[   65.758268][    T1] SELinux:  Permission nlmsg in class =
netlink_audit_socket not defined in policy.

[   65.761603][    T1] SELinux:  Class mctp_socket not defined in =
policy.

[   65.763488][    T1] SELinux:  Class anon_inode not defined in policy.

[   65.765357][    T1] SELinux:  Class io_uring not defined in policy.

[   65.767224][    T1] SELinux:  Class user_namespace not defined in =
policy.

[   65.769169][    T1] SELinux: the above unknown classes and =
permissions will be allowed

[   65.925272][    T1] SELinux:  policy capability =
network_peer_controls=3D1

[   65.927343][    T1] SELinux:  policy capability open_perms=3D1

[   65.929048][    T1] SELinux:  policy capability =
extended_socket_class=3D1

[   65.930923][    T1] SELinux:  policy capability =
always_check_network=3D0

[   65.932805][    T1] SELinux:  policy capability cgroup_seclabel=3D1

[   65.934553][    T1] SELinux:  policy capability =
nnp_nosuid_transition=3D1

[   65.936460][    T1] SELinux:  policy capability =
genfs_seclabel_symlinks=3D0

[   65.938527][    T1] SELinux:  policy capability ioctl_skip_cloexec=3D0

[   65.940397][    T1] SELinux:  policy capability =
userspace_initial_context=3D0

[   65.942366][    T1] SELinux:  policy capability netlink_xperm=3D0

[   65.944119][    T1] SELinux:  policy capability netif_wildcard=3D0

[   65.945862][    T1] SELinux:  policy capability =
genfs_seclabel_wildcard=3D0

[   66.244270][   T45] audit: type=3D1403 audit(1753318122.224:2): =
auid=3D4294967295 ses=3D4294967295 lsm=3Dselinux res=3D1

[   66.280985][    T1] systemd[1]: Successfully loaded SELinux policy in =
2.636281s.

[   66.795378][ T5210] modprobe (5210) used greatest stack depth: 23384 =
bytes left

[   67.775680][    T1] systemd[1]: Relabelled /dev, /dev/shm, /run, =
/sys/fs/cgroup in 976.339ms.

[   67.830674][    T1] systemd[1]: systemd 247.3-7+deb11u5 running in =
system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP =
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID =
+ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dunified)

[   67.844090][    T1] systemd[1]: Detected virtualization kvm.

[   67.845675][    T1] systemd[1]: Detected architecture x86-64.



Welcome to =1B[1mDebian GNU/Linux 11 (bullseye)=1B[0m!



[   67.860650][    T1] systemd[1]: Set hostname to <syzkaller>.

[   68.359558][ T5216] selinuxenabled (5216) used greatest stack depth: =
22824 bytes left

[   68.684023][ T5221] grep (5221) used greatest stack depth: 22536 =
bytes left

[   70.263180][    T1] systemd[1]: Queued start job for default target =
Graphical Interface.

[   70.321360][    T1] systemd[1]: Created slice system-getty.slice.

[=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39msystem-getty.slice=1B[0m.=


[   70.356181][    T1] systemd[1]: Created slice system-modprobe.slice.

[=1B[0;32m  OK  =1B[0m] Created slice =
=1B[0;1;39msystem-modprobe.slice=1B[0m.

[   70.380927][    T1] systemd[1]: Created slice =
system-serial\x2dgetty.slice.

[=1B[0;32m  OK  =1B[0m] Created slice =
=1B[0;1;39msystem-serial\x2dgetty.slice=1B[0m.

[   70.389513][    T1] systemd[1]: Started Dispatch Password Requests to =
Console Directory Watch.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDispatch Password =E2=80=A6ts =
to Console Directory Watch=1B[0m.

[   70.398966][    T1] systemd[1]: Started Forward Password Requests to =
Wall Directory Watch.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mForward Password R=E2=80=A6uest=
s to Wall Directory Watch=1B[0m.

[   70.425098][    T1] systemd[1]: Set up automount Arbitrary Executable =
File Formats File System Automount Point.

[=1B[0;32m  OK  =1B[0m] Set up automount =1B[0;1;39mArbitrary=E2=80=A6s =
File System Automount Point=1B[0m.

[   70.432346][    T1] systemd[1]: Reached target Local Encrypted =
Volumes.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLocal Encrypted =
Volumes=1B[0m.

[   70.438052][    T1] systemd[1]: Reached target Paths.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mPaths=1B[0m.

[   70.442700][    T1] systemd[1]: Reached target Remote File Systems.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mRemote File =
Systems=1B[0m.

[   70.448022][    T1] systemd[1]: Reached target Slices.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSlices=1B[0m.

[   70.452676][    T1] systemd[1]: Reached target Swap.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSwap=1B[0m.

[   70.469970][    T1] systemd[1]: Listening on Syslog Socket.

[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mSyslog Socket=1B[0m.

[   70.478552][    T1] systemd[1]: Listening on initctl Compatibility =
Named Pipe.

[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39minitctl Compatibility =
Named Pipe=1B[0m.

[   70.495020][    T1] systemd[1]: Listening on Journal Audit Socket.

[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Audit =
Socket=1B[0m.

[   70.506395][    T1] systemd[1]: Listening on Journal Socket =
(/dev/log).

[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Socket =
(/dev/log)=1B[0m.

[   70.521127][    T1] systemd[1]: Listening on Journal Socket.

[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Socket=1B[0m.

[   70.540070][    T1] systemd[1]: Listening on udev Control Socket.

[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mudev Control Socket=1B[0m.=


[   70.550780][    T1] systemd[1]: Listening on udev Kernel Socket.

[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mudev Kernel Socket=1B[0m.

[   70.556023][    T1] systemd[1]: Reached target Sockets.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSockets=1B[0m.

[   70.618816][    T1] systemd[1]: Mounting Huge Pages File System...

         Mounting =1B[0;1;39mHuge Pages File System=1B[0m...

[   70.677129][    T1] systemd[1]: Mounting POSIX Message Queue File =
System...

         Mounting =1B[0;1;39mPOSIX Message Queue File System=1B[0m...

[   70.732385][    T1] systemd[1]: Mounting /proc/sys/fs/binfmt_misc...

         Mounting =1B[0;1;39m/proc/sys/fs/binfmt_misc=1B[0m...

[   70.787438][    T1] systemd[1]: Mounting /sys/kernel/config...

         Mounting =1B[0;1;39m/sys/kernel/config=1B[0m...

[   70.841599][    T1] systemd[1]: Mounting /sys/kernel/debug...

         Mounting =1B[0;1;39m/sys/kernel/debug=1B[0m...

[   70.901905][    T1] systemd[1]: Mounting Kernel Trace File System...

         Mounting =1B[0;1;39mKernel Trace File System=1B[0m...

[   70.907966][    T1] systemd[1]: Condition check resulted in Create =
list of static device nodes for the current kernel being skipped.

[   70.963658][    T1] systemd[1]: Starting Load Kernel Module fuse...

         Starting =1B[0;1;39mLoad Kernel Module fuse=1B[0m...

[   71.074454][    T1] systemd[1]: Starting Journal Service...

         Starting =1B[0;1;39mJournal Service=1B[0m...

[   71.153381][    T1] systemd[1]: Starting Load Kernel Modules...

         Starting =1B[0;1;39mLoad Kernel Modules=1B[0m...

[   71.206054][    T1] systemd[1]: Starting Remount Root and Kernel File =
Systems...

         Starting =1B[0;1;39mRemount Root and Kernel File Systems=1B[0m...=


[   71.261996][    T1] systemd[1]: Starting Coldplug All udev Devices...

         Starting =1B[0;1;39mColdplug All udev Devices=1B[0m...

[   71.318928][    T1] systemd[1]: Mounted Huge Pages File System.

[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mHuge Pages File System=1B[0m.

[   71.327893][    T1] systemd[1]: Mounted POSIX Message Queue File =
System.

[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mPOSIX Message Queue File =
System=1B[0m.

[   71.336961][    T1] systemd[1]: Mounted /proc/sys/fs/binfmt_misc.

[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39m/proc/sys/fs/binfmt_misc=1B[0m.=


[   71.345177][    T1] systemd[1]: Mounted /sys/kernel/config.

[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39m/sys/kernel/config=1B[0m.

[   71.353909][    T1] systemd[1]: Mounted /sys/kernel/debug.

[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39m/sys/kernel/debug=1B[0m.

[   71.361976][    T1] systemd[1]: Mounted Kernel Trace File System.

[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mKernel Trace File System=1B[0m.=


[   71.380505][    T1] systemd[1]: modprobe@fuse.service: Succeeded.

[   71.417121][    T1] systemd[1]: Finished Load Kernel Module fuse.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Module fuse=1B[0m.=


[   71.492149][    T1] systemd[1]: Mounting FUSE Control File System...

         Mounting =1B[0;1;39mFUSE Control File System=1B[0m...

[   71.502890][    T1] systemd[1]: Condition check resulted in Set Up =
Additional Binary Formats being skipped.

[   71.546885][    T1] systemd[1]: Finished Load Kernel Modules.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Modules=1B[0m.

[   71.619330][    T1] systemd[1]: Starting Apply Kernel Variables...

         Starting =1B[0;1;39mApply Kernel Variables=1B[0m...

[   71.644845][    T1] systemd[1]: Mounted FUSE Control File System.

[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mFUSE Control File System=1B[0m.=


[   71.855346][ T5241] EXT4-fs (sda): re-mounted =
0645c0ca-13f1-4874-936a-93dfe93231c8 r/w.

[   71.946953][    T1] systemd[1]: Finished Remount Root and Kernel File =
Systems.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mRemount Root and Kernel File =
Systems=1B[0m.

[   71.963925][    T1] systemd[1]: Condition check resulted in Rebuild =
Hardware Database being skipped.

[   71.967130][    T1] systemd[1]: Condition check resulted in Platform =
Persistent Storage Archival being skipped.

[   72.018214][    T1] systemd[1]: Starting Load/Save Random Seed...

         Starting =1B[0;1;39mLoad/Save Random Seed=1B[0m...

[   72.078955][    T1] systemd[1]: Starting Create System Users...

         Starting =1B[0;1;39mCreate System Users=1B[0m...

[   72.117466][    T1] systemd[1]: Finished Apply Kernel Variables.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mApply Kernel Variables=1B[0m.

[   72.396892][    T1] systemd[1]: Finished Load/Save Random Seed.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad/Save Random Seed=1B[0m.

[   72.405223][    T1] systemd[1]: Condition check resulted in First =
Boot Complete being skipped.

[   72.691475][    T1] systemd[1]: Finished Create System Users.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mCreate System Users=1B[0m.

[   72.745910][    T1] systemd[1]: Starting Create Static Device Nodes =
in /dev...

         Starting =1B[0;1;39mCreate Static Device Nodes in /dev=1B[0m...

[   73.348650][    T1] systemd[1]: Finished Create Static Device Nodes =
in /dev.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mCreate Static Device Nodes =
in /dev=1B[0m.

[   73.357774][    T1] systemd[1]: Reached target Local File Systems =
(Pre).

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLocal File Systems =
(Pre)=1B[0m.

[   73.363367][    T1] systemd[1]: Reached target Local File Systems.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLocal File =
Systems=1B[0m.

[   73.379909][    T1] systemd[1]: Condition check resulted in Mark the =
need to relabel after reboot being skipped.

[   73.382744][    T1] systemd[1]: Condition check resulted in Store a =
System Token in an EFI Variable being skipped.

[   73.386185][    T1] systemd[1]: Condition check resulted in Commit a =
transient machine-id on disk being skipped.

[   73.473185][    T1] systemd[1]: Starting Rule-based Manager for =
Device Events and Files...

         Starting =1B[0;1;39mRule-based Manage=E2=80=A6for Device Events =
and Files=1B[0m...

[   74.277409][    T1] systemd[1]: Started Rule-based Manager for Device =
Events and Files.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mRule-based Manager for Device =
Events and Files=1B[0m.

[   75.187454][    T1] systemd[1]: Started Journal Service.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mJournal Service=1B[0m.

         Starting =1B[0;1;39mFlush Journal to Persistent Storage=1B[0m...

[   75.504938][ T5235] systemd-journald[5235]: Received client request =
to flush runtime journal.

[   75.608534][ T5235] systemd-journald[5235]: File =
/var/log/journal/2fbe6ef7c94c40ef9bb7b61a0dcf8355/system.journal =
corrupted or uncleanly shut down, renaming and replacing.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mFlush Journal to Persistent =
Storage=1B[0m.

         Starting =1B[0;1;39mCreate Volatile Files and =
Directories=1B[0m...

[=1B[0m=1B[0;31m*     =1B[0m] (1 of 3) A start job is running for=E2=80=A6=
g All udev Devices (8s / no limit)

=1BM
=1B[K[=1B[0;1;31m*=1B[0m=1B[0;31m*    =1B[0m] (1 of 3) A start job is =
running for=E2=80=A6g All udev Devices (8s / no limit)

=1BM
=1B[K[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mCreate Volatile Files =
and Directories=1B[0m.

=1B[K         Starting =1B[0;1;39mUpdate UTMP about System =
Boot/Shutdown=1B[0m...

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mUpdate UTMP about System =
Boot/Shutdown=1B[0m.

[=1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*   =1B[0m] (1 of 2) A start job =
is running for=E2=80=A6 All udev Devices (11s / no limit)

=1BM
=1B[K[ =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*  =1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (12s / 1min 30s)

=1BM
=1B[K[  =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m* =1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (12s / 1min 30s)

=1BM
=1B[K[   =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*=1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (13s / 1min 30s)

=1BM
=1B[K[    =1B[0;31m*=1B[0;1;31m*=1B[0m] (1 of 2) A start job is running =
for=E2=80=A6 All udev Devices (13s / no limit)

=1BM
=1B[K[     =1B[0;31m*=1B[0m] (1 of 2) A start job is running for=E2=80=A6 =
All udev Devices (14s / no limit)

=1BM
=1B[K[    =1B[0;31m*=1B[0;1;31m*=1B[0m] (1 of 2) A start job is running =
for=E2=80=A6 All udev Devices (14s / no limit)

=1BM
=1B[K[   =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*=1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (15s / 1min 30s)

=1BM
=1B[K[  =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m* =1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (15s / 1min 30s)

=1BM
=1B[K[ =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*  =1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (16s / 1min 30s)

=1BM
=1B[K[=1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*   =1B[0m] (1 of 2) A start =
job is running for=E2=80=A6 All udev Devices (16s / no limit)

=1BM
=1B[K[=1B[0;1;31m*=1B[0m=1B[0;31m*    =1B[0m] (1 of 2) A start job is =
running for=E2=80=A6 All udev Devices (17s / no limit)

=1BM
=1B[K[=1B[0m=1B[0;31m*     =1B[0m] (1 of 2) A start job is running =
for=E2=80=A6 All udev Devices (17s / no limit)

=1BM
=1B[K[=1B[0;1;31m*=1B[0m=1B[0;31m*    =1B[0m] (2 of 2) A start job is =
running for /dev/ttyS0 (18s / 1min 30s)

=1BM
=1B[K[=1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*   =1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (18s / 1min 30s)

=1BM
=1B[K[ =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*  =1B[0m] (2 of 2) A start =
job is running for /dev/ttyS0 (19s / 1min 30s)

[   89.439142][   T45] audit: type=3D1400 audit(1753318145.414:3): avc:  =
denied  { create } for  pid=3D7628 comm=3D"ifquery" name=3D"network" =
scontext=3Dsystem_u:system_r:udev_t:s0-s0:c0.c1023 =
tcontext=3Dsystem_u:object_r:var_run_t:s0 tclass=3Ddir permissive=3D1

=1BM
=1B[K[  =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m* =1B[0m] (1 of 2) A start =
job is running for=E2=80=A6 All udev Devices (19s / no limit)

=1BM
=1B[K[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mHardware =
activated USB gadget=1B[0m.

=1B[K[   90.319559][ T1007] cfg80211: failed to load regulatory.db

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSound Card=1B[0m.

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mColdplug All udev =
Devices=1B[0m.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSystem =
Initialization=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDaily apt download =
activities=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDaily apt upgrade and clean =
activities=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mPeriodic ext4 Onli=E2=80=A6ata =
Check for All Filesystems=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDiscard unused blocks once a =
week=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDaily rotation of log =
files=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDaily Cleanup of Temporary =
Directories=1B[0m.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mBasic System=1B[0m.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mTimers=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mRegular background program =
processing daemon=1B[0m.

         Starting =1B[0;1;39mRemove Stale Onli=E2=80=A6t4 Metadata Check =
Snapshots=1B[0m...

         Starting =1B[0;1;39mgetty on tty2-tty=E2=80=A6nd logind are not =
available=1B[0m...

         Starting =1B[0;1;39mHelper to synchronize boot up for =
ifupdown=1B[0m...

         Starting =1B[0;1;39mSystem Logging Service=1B[0m...

         Starting =1B[0;1;39mRotate log files=1B[0m...

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mgetty on tty2-tty=E2=80=A6 =
and logind are not available=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mSystem Logging Service=1B[0m.

[   =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*=1B[0m] (3 of 4) A start job =
is running for=E2=80=A6a Check Snapshots (27s / no limit)

=1BM
=1B[K         Starting =1B[0;1;39mOnline ext4 Metad=E2=80=A6a Check for =
All Filesystems=1B[0m...

=1B[K[    =1B[0;31m*=1B[0;1;31m*=1B[0m] (2 of 5) A start job is running =
for=E2=80=A6All Filesystems (693ms / no limit)

=1BM
=1B[K[     =1B[0;31m*=1B[0m] (3 of 5) A start job is running for=E2=80=A6t=
 up for ifupdown (28s / 3min 22s)

[   98.474929][ T9188] e2scrub_all (9188) used greatest stack depth: =
22328 bytes left

=1BM
=1B[K[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mOnline ext4 Metadata =
Check for All Filesystems=1B[0m.

=1B[K[    =1B[0;31m*=1B[0;1;31m*=1B[0m] (4 of 4) A start job is running =
for /dev/ttyS0 (30s / 1min 30s)

=1BM
=1B[K[   =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*=1B[0m] (4 of 4) A start =
job is running for /dev/ttyS0 (30s / 1min 30s)

=1BM
=1B[K[=1B[0;32m  OK  =1B[0m] Found device =1B[0;1;39m/dev/ttyS0=1B[0m.

=1B[K[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mLoad/Save RF =
=E2=80=A6itch Status /dev/rfkill Watch=1B[0m.

         Starting =1B[0;1;39mLoad/Save RF Kill Switch Status=1B[0m...

[  =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m* =1B[0m] (1 of 4) A start job =
is running for Rotate log files (10s / no limit)

=1BM
=1B[K[ =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*  =1B[0m] (1 of 4) A start =
job is running for Rotate log files (11s / no limit)

=1BM
=1B[K[=1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*   =1B[0m] (1 of 4) A start =
job is running for Rotate log files (11s / no limit)

=1BM
=1B[K[=1B[0;1;31m*=1B[0m=1B[0;31m*    =1B[0m] (2 of 4) A start job is =
running for=E2=80=A6t up for ifupdown (35s / 3min 22s)

=1BM
=1B[K[=1B[0m=1B[0;31m*     =1B[0m] (2 of 4) A start job is running =
for=E2=80=A6t up for ifupdown (35s / 3min 22s)

=1BM
=1B[K[=1B[0;1;31m*=1B[0m=1B[0;31m*    =1B[0m] (2 of 4) A start job is =
running for=E2=80=A6t up for ifupdown (36s / 3min 22s)

=1BM
=1B[K[=1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*   =1B[0m] (3 of 4) A start =
job is running for=E2=80=A6e RF Kill Switch Status (4s / 30s)

=1BM
=1B[K[ =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*  =1B[0m] (3 of 4) A start =
job is running for=E2=80=A6e RF Kill Switch Status (4s / 30s)

=1BM
=1B[K[  =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m* =1B[0m] (3 of 4) A start =
job is running for=E2=80=A6e RF Kill Switch Status (5s / 30s)

=1BM
=1B[K[   =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*=1B[0m] (4 of 4) A start =
job is running for=E2=80=A6a Check Snapshots (37s / no limit)

=1BM
=1B[K[    =1B[0;31m*=1B[0;1;31m*=1B[0m] (4 of 4) A start job is running =
for=E2=80=A6a Check Snapshots (38s / no limit)

=1BM
=1B[K[     =1B[0;31m*=1B[0m] (4 of 4) A start job is running for=E2=80=A6a=
 Check Snapshots (38s / no limit)

=1BM
=1B[K[    =1B[0;31m*=1B[0;1;31m*=1B[0m] (1 of 4) A start job is running =
for Rotate log files (15s / no limit)

=1BM
=1B[K[   =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*=1B[0m] (1 of 4) A start =
job is running for Rotate log files (15s / no limit)

=1BM
=1B[K[  =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m* =1B[0m] (1 of 4) A start =
job is running for Rotate log files (16s / no limit)

=1BM
=1B[K[ =1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*  =1B[0m] (2 of 4) A start =
job is running for=E2=80=A6t up for ifupdown (40s / 3min 22s)

=1BM
=1B[K[=1B[0;31m*=1B[0;1;31m*=1B[0m=1B[0;31m*   =1B[0m] (2 of 4) A start =
job is running for=E2=80=A6t up for ifupdown (40s / 3min 22s)

=1BM
=1B[K[=1B[0;1;31m*=1B[0m=1B[0;31m*    =1B[0m] (2 of 4) A start job is =
running for=E2=80=A6t up for ifupdown (40s / 3min 22s)

=1BM
=1B[K[=1B[0m=1B[0;31m*     =1B[0m] (3 of 4) A start job is running =
for=E2=80=A6e RF Kill Switch Status (8s / 30s)

=1BM
=1B[K[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mLoad/Save RF Kill Switch =
Status=1B[0m.

=1B[K[  112.504151][   T45] audit: type=3D1804 audit(1753318168.484:4): =
pid=3D9099 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
subj=3Dsystem_u:system_r:logrotate_t:s0 op=3Dinvalid_pcr =
cause=3Dopen_writers comm=3D"logrotate" name=3D"/var/lib/logrotate/status"=
 dev=3D"sda" ino=3D58 res=3D1 errno=3D0

[  112.557244][   T45] audit: type=3D1804 audit(1753318168.524:5): =
pid=3D9099 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
subj=3Dsystem_u:system_r:logrotate_t:s0 op=3Dinvalid_pcr =
cause=3Dopen_writers comm=3D"logrotate" name=3D"/var/log/syslog" =
dev=3D"sda" ino=3D45 res=3D1 errno=3D0

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mRemove Stale Onli=E2=80=A6ext4=
 Metadata Check Snapshots=1B[0m.

[  112.978337][   T45] audit: type=3D1804 audit(1753318168.954:6): =
pid=3D9099 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
subj=3Dsystem_u:system_r:logrotate_t:s0 op=3Dinvalid_pcr =
cause=3Dopen_writers comm=3D"logrotate" name=3D"/var/log/daemon.log" =
dev=3D"sda" ino=3D46 res=3D1 errno=3D0

[  113.158834][   T45] audit: type=3D1804 audit(1753318169.134:7): =
pid=3D9099 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
subj=3Dsystem_u:system_r:logrotate_t:s0 op=3Dinvalid_pcr =
cause=3Dopen_writers comm=3D"logrotate" name=3D"/var/log/kern.log" =
dev=3D"sda" ino=3D47 res=3D1 errno=3D0

[  113.613640][   T45] audit: type=3D1804 audit(1753318169.594:8): =
pid=3D9099 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
subj=3Dsystem_u:system_r:logrotate_t:s0 op=3Dinvalid_pcr =
cause=3Dopen_writers comm=3D"logrotate" name=3D"/var/log/debug" =
dev=3D"sda" ino=3D56 res=3D1 errno=3D0

[  113.820408][   T45] audit: type=3D1804 audit(1753318169.804:9): =
pid=3D9099 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
subj=3Dsystem_u:system_r:logrotate_t:s0 op=3Dinvalid_pcr =
cause=3Dopen_writers comm=3D"logrotate" name=3D"/var/log/messages" =
dev=3D"sda" ino=3D57 res=3D1 errno=3D0

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mHelper to synchronize boot =
up for ifupdown=1B[0m.

         Starting =1B[0;1;39mRaise network interfaces=1B[0m...

[  114.642968][ T9099] logrotate (9099) used greatest stack depth: 21656 =
bytes left

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mRotate log files=1B[0m.

[  115.253291][   T45] audit: type=3D1804 audit(1753318171.234:10): =
pid=3D9665 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
subj=3Dsystem_u:system_r:dhcpc_t:s0 op=3Dinvalid_pcr cause=3DToMToU =
comm=3D"dhclient" name=3D"/var/lib/dhcp/dhclient.enp0s4.leases" =
dev=3D"sda" ino=3D38 res=3D1 errno=3D0

[  115.331726][   T45] audit: type=3D1400 audit(1753318171.314:11): avc: =
 denied  { read } for  pid=3D9671 comm=3D"ip" =
path=3D"/var/lib/dhcp/dhclient.enp0s4.leases" dev=3D"sda" ino=3D38 =
scontext=3Dsystem_u:system_r:ifconfig_t:s0 =
tcontext=3Dsystem_u:object_r:dhcpc_state_t:s0 tclass=3Dfile permissive=3D1=


[  115.398973][ T1273] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, =
Flow Control: RX

[  115.413340][ T9671] 8021q: adding VLAN 0 to HW filter on device eth0

[  116.633467][ T9664] dhclient (9664) used greatest stack depth: 21400 =
bytes left

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mRaise network =
interfaces=1B[0m.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mNetwork=1B[0m.

         Starting =1B[0;1;39mOpenBSD Secure Shell server=1B[0m...

         Starting =1B[0;1;39mPermit User Sessions=1B[0m...

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mPermit User Sessions=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mGetty on tty1=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mGetty on tty2=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mGetty on tty3=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mGetty on tty4=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mGetty on tty5=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mGetty on tty6=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mSerial Getty on ttyS0=1B[0m.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLogin Prompts=1B[0m.

[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mOpenBSD Secure Shell =
server=1B[0m.

[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mMulti-User System=1B[0m.=


[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mGraphical =
Interface=1B[0m.

         Starting =1B[0;1;39mUpdate UTMP about System Runlevel =
Changes=1B[0m...

[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mUpdate UTMP about System =
Runlevel Changes=1B[0m.

[  118.396882][   T45] audit: type=3D1400 audit(1753318174.364:12): avc: =
 denied  { checkpoint_restore } for  pid=3D9706 comm=3D"agetty" =
capability=3D40  scontext=3Dsystem_u:system_r:getty_t:s0 =
tcontext=3Dsystem_u:system_r:getty_t:s0 tclass=3Dcapability2 =
permissive=3D1




Debian GNU/Linux 11 syzkaller ttyS0



syzkaller login: root


Linux syzkaller 6.16.0-rc4 #1 SMP PREEMPT_DYNAMIC Wed Jul  2 09:53:03 =
CST 2025 x86_64



The programs included with the Debian GNU/Linux system are free =
software;

the exact distribution terms for each program are described in the

individual files in /usr/share/doc/*/copyright.



Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent

permitted by applicable law.

Last login: Wed Dec 18 08:56:46 UTC 2024 on ttyS0

=1B[?2004hroot@syzkaller:~# passwd

=1B[?2004l
New password:=20

Retype new password:=20

passwd: password updated successfully

=1B[?2004hroot@syzkaller:~# =1B[7mnano /etc/ssh/sshd_config=1B[27m
=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[=
C=1B[C=1B[C=1B[Cnano /etc/ssh/sshd_config

=1B[?2004l
=1B[?2004h=1B)0=1B[1;24r=1B[m=1B(B=1B[4l=1B[?7h=1B[H=1B[J=1B[22;34H=1B[0;7=
m=1B(B[ Reading... ]=1B[m=1B(B=1B[22;32H=1B[0;7m=1B(B[ Read 123 lines =
]=1B[m=1B(B=1B[H=1B[0;7m=1B(B  GNU nano 5.4                  =
/etc/ssh/sshd_config                            =1B[1;79H=1B[m=1B(B
=1B[22B=1B[0;7m=1B(B^G=1B[m=1B(B Help=1B[6C=1B[0;7m=1B(B^O=1B[m=1B(B =
Write Out =1B[0;7m=1B(B^W=1B[m=1B(B Where Is  =1B[0;7m=1B(B^K=1B[m=1B(B =
Cut=1B[7C=1B[0;7m=1B(B^T=1B[m=1B(B Execute   =1B[0;7m=1B(B^C=1B[m=1B(B =
Location
=1B[1B=1B[0;7m=1B(B^X=1B[m=1B(B Exit=1B[6C=1B[0;7m=1B(B^R=1B[m=1B(B Read =
File =1B[0;7m=1B(B^\=1B[m=1B(B Replace   =1B[0;7m=1B(B^U=1B[m=1B(B Paste =
    =1B[0;7m=1B(B^J=1B[m=1B(B Justify   =1B[0;7m=1B(B^_=1B[m=1B(B Go To =
Line
=1B[22A#       $OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp =
$
=1B[2B# This is the sshd server system-wide configuration file.  See
=1B[1B# sshd_config(5) for more information.
=1B[2B# This sshd was compiled with PATH=3D/usr/bin:/bin:/usr/sbin:/sbin
=1B[2B# The strategy used for options in the default sshd_config shipped =
with
=1B[1B# OpenSSH is to specify options with their default value where
=1B[1B# possible, but leave them commented.  Uncommented options =
override the
=1B[1B# default value.
=1B[2B=1B[m=1B(BInclude /etc/ssh/sshd_config.d/*.conf
=1B[2B#Port 22
=1B[1B#AddressFamily any
=1B[1B#ListenAddress 0.0.0.0
=1B[1B#ListenAddress ::
=1B[2B#HostKey /etc/ssh/ssh_host_rsa_key
=1B[19A=1B[m=1B(B=1B[1B=1B[1;54H=1B[0;7m=1B(B*
=1B[21B=1B[m=1B(B=1B[K=1B[1;79H=1B[3;22r=1B[3;1H=1B[2L=1B[1;24r=1B[3;1HPer=
mitRootLogin yes
=1B[2BPasswordAuthentication yes
=1B[17B=1B[0;7m=1B(BSave modified buffer?                                =
                           =1B[23;1H Y=1B[m=1B(B Yes=1B[K
=1B[1B=1B[0;7m=1B(B N=1B[m=1B(B No  =1B[6C   =1B[0;7m=1B(B^C=1B[m=1B(B =
Cancel=1B[K=1B[22;23H
=1B[1B=1B[0;7m=1B(B^G=1B[m=1B(B Help=1B[23;21H=1B[0;7m=1B(BM-D=1B[m=1B(B =
DOS Format=1B[6C=1B[0;7m=1B(BM-A=1B[m=1B(B =
Append=1B[23;61H=1B[0;7m=1B(BM-B=1B[m=1B(B Backup File
=1B[1B=1B[0;7m=1B(B^C=1B[m=1B(B Cancel=1B[7C    =1B[0;7m=1B(BM-M=1B[m=1B(B=
 Mac Format=1B[6C=1B[0;7m=1B(BM-P=1B[m=1B(B =
Prepend=1B[24;61H=1B[0;7m=1B(B^T=1B[m=1B(B Browse
=1B[2A=1B[0;7m=1B(BFile Name to Write: =
/etc/ssh/sshd_config=1B[m=1B(B=1B[22;33H=1B[1K =1B[0;7m=1B(B[ Writing... =
]=1B[m=1B(B=1B[K=1B[1;54H=1B[0;7m=1B(B =1B[24C=1B[m=1B(B=1B[22;31H=1B[0;7m=
=1B(B[ Wrote 125 lines ]=1B[m=1B(B
=1B[J=1B[2B=1B[24;1H
=1B[?2004l=1B[?2004hroot@syzkaller:~# =1B[7msystemctl restart ssh=1B[27m




=1B[7msystemctl status ss=1B[27m=1B[A=1B[A=08systemctl restart ssh




systemctl status ss

=1B[?2004l

Unit ss.service could not be found.=1B[m


=1B[K=1B[?2004hroot@syzkaller:~# =1B[7msystemctl restart ssh=1B[27m




=1B[7msystemctl status ssh=1B[27m=1B[A=1B[A=08=08systemctl restart ssh




systemctl status ssh

=1B[?2004l

[  474.689782][   T45] audit: type=3D1804 audit(1753318530.674:13): =
pid=3D9777 uid=3D0 auid=3D0 ses=3D1 =
subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
op=3Dinvalid_pcr cause=3Dopen_writers comm=3D"systemctl" =
name=3D"/var/log/journal/2fbe6ef7c94c40ef9bb7b61a0dcf8355/system.journal" =
dev=3D"sda" ino=3D49 res=3D1 errno=3D0

=1B[0;1;32m=E2=97=8F=1B[0m ssh.service - OpenBSD Secure Shell server=1B[m

     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor =
preset: e=1B[m=1B[7m>=1B[27m

     Active: =1B[0;1;32mactive (running)=1B[0m since Thu 2025-07-24 =
00:55:30 UTC; 219ms ago=1B[m

       Docs: man:sshd(8)=1B[m

             man:sshd_config(5)=1B[m

    Process: 9774 ExecStartPre=3D/usr/sbin/sshd -t (code=3Dexited, =
status=3D0/SUCCESS)=1B[m

   Main PID: 9776 (sshd)=1B[m

      Tasks: 1 (limit: 752)=1B[m

     Memory: 1.4M=1B[m

        CPU: 621ms=1B[m

     CGroup: /system.slice/ssh.service=1B[m

             =E2=94=94=E2=94=809776 sshd: /usr/sbin/sshd -D [listener] 0 =
of 10-100 startups=1B[m

=1B[m

Jul 24 00:55:29 syzkaller systemd[1]: Starting OpenBSD Secure Shell =
server...=1B[m

Jul 24 00:55:30 syzkaller sshd[9776]: Server listening on 0.0.0.0 port =
22.=1B[m

Jul 24 00:55:30 syzkaller sshd[9776]: Server listening on :: port 22.=1B[m=


Jul 24 00:55:30 syzkaller systemd[1]: Started OpenBSD Secure Shell =
server.=1B[m

=1B[7mlines 1-17/17 (END)=1B[27m=1B[K=07
=1B[K=1B[7mlines 1-17/17 (END)=1B[27m=1B[K
=1B[K=1B[?2004hroot@syzkaller:~# [  876.374027][   T45] audit: type=3D1400=
 audit(1753318932.354:14): avc:  denied  { transition } for  pid=3D9790 =
comm=3D"sshd" path=3D"/usr/bin/bash" dev=3D"sda" ino=3D2775 =
scontext=3Dsystem_u:system_r:sshd_t:s0-s0:c0.c1023 =
tcontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
tclass=3Dprocess permissive=3D1

[  876.383558][   T45] audit: type=3D1400 audit(1753318932.354:15): avc: =
 denied  { noatsecure } for  pid=3D9790 comm=3D"sshd" =
scontext=3Dsystem_u:system_r:sshd_t:s0-s0:c0.c1023 =
tcontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
tclass=3Dprocess permissive=3D1

[  876.411768][   T45] audit: type=3D1400 audit(1753318932.394:16): avc: =
 denied  { rlimitinh } for  pid=3D9790 comm=3D"bash" =
scontext=3Dsystem_u:system_r:sshd_t:s0-s0:c0.c1023 =
tcontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
tclass=3Dprocess permissive=3D1

[  876.418258][   T45] audit: type=3D1400 audit(1753318932.394:17): avc: =
 denied  { siginh } for  pid=3D9790 comm=3D"bash" =
scontext=3Dsystem_u:system_r:sshd_t:s0-s0:c0.c1023 =
tcontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
tclass=3Dprocess permissive=3D1

[  909.918245][ T9805] cgroup: Unknown subsys name 'net'

[  910.131800][ T9805] cgroup: Unknown subsys name 'cpuset'

[  910.145384][ T9805] cgroup: Unknown subsys name 'rlimit'

[  911.903789][ T9805] Adding 124996k swap on ./swap-file.  Priority:0 =
extents:1 across:124996k=20

[  914.657935][   T45] audit: type=3D1400 audit(1753318970.644:18): avc: =
 denied  { execmem } for  pid=3D9823 comm=3D"syz-executor" =
scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
tcontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
tclass=3Dprocess permissive=3D1

[  915.583373][   T85] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50

[  915.585840][   T85] wlan0: Creating new IBSS network, BSSID =
50:50:50:50:50:50

[  915.920913][  T176] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50

[  915.923231][  T176] wlan1: Creating new IBSS network, BSSID =
50:50:50:50:50:50

[  916.041318][   T66] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 =
> 1

[  916.044352][   T66] Bluetooth: hci0: unexpected cc 0x1003 length: 249 =
> 9

[  916.055000][   T66] Bluetooth: hci0: unexpected cc 0x1001 length: 249 =
> 9

[  916.068585][   T66] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 =
> 4

[  916.071546][   T66] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 =
> 2

[  917.307544][T10031] chnl_net:caif_netlink_parms(): no params data =
found

[  917.482615][   T45] audit: type=3D1401 audit(1753318973.464:19): =
op=3Dsetxattr invalid_context=3D"u:object_r:app_data_file:s0:c512,c768"

[  917.717441][T10031] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  917.719884][T10031] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  917.722178][T10031] bridge_slave_0: entered allmulticast mode

[  917.725984][T10031] bridge_slave_0: entered promiscuous mode

[  917.734561][T10031] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  917.736986][T10031] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  917.739189][T10031] bridge_slave_1: entered allmulticast mode

[  917.742987][T10031] bridge_slave_1: entered promiscuous mode

[  917.845163][T10031] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  917.854867][T10031] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  918.171049][T10031] team0: Port device team_slave_0 added

[  918.176639][T10031] team0: Port device team_slave_1 added

[  918.187976][ T5195] Bluetooth: hci0: command tx timeout

[  918.281012][T10031] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  918.283083][T10031] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  918.290489][T10031] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  918.318373][T10031] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  918.320390][T10031] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  918.328874][T10031] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  918.432516][T10031] hsr_slave_0: entered promiscuous mode

[  918.435381][T10031] hsr_slave_1: entered promiscuous mode

[  918.744034][T10031] netdevsim netdevsim3 netdevsim0: renamed from =
eth0

[  918.753110][T10031] netdevsim netdevsim3 netdevsim1: renamed from =
eth1

[  918.759924][T10031] netdevsim netdevsim3 netdevsim2: renamed from =
eth2

[  918.766424][T10031] netdevsim netdevsim3 netdevsim3: renamed from =
eth3

[  918.872967][T10031] 8021q: adding VLAN 0 to HW filter on device bond0

[  918.896586][T10031] 8021q: adding VLAN 0 to HW filter on device team0

[  918.911290][ T1029] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  918.913516][ T1029] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  918.925439][   T85] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  918.927650][   T85] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  919.206142][T10031] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  919.258551][T10031] veth0_vlan: entered promiscuous mode

[  919.271135][T10031] veth1_vlan: entered promiscuous mode

[  919.306024][T10031] veth0_macvtap: entered promiscuous mode

[  919.313085][T10031] veth1_macvtap: entered promiscuous mode

[  919.331762][T10031] batman_adv: batadv0: Interface activated: =
batadv_slave_0

[  919.344985][T10031] batman_adv: batadv0: Interface activated: =
batadv_slave_1

[  919.353717][T10031] netdevsim netdevsim3 netdevsim0: set [1, 0] type =
2 family 0 port 6081 - 0

[  919.356297][T10031] netdevsim netdevsim3 netdevsim1: set [1, 0] type =
2 family 0 port 6081 - 0

[  919.359544][T10031] netdevsim netdevsim3 netdevsim2: set [1, 0] type =
2 family 0 port 6081 - 0

[  919.362025][T10031] netdevsim netdevsim3 netdevsim3: set [1, 0] type =
2 family 0 port 6081 - 0

[  919.560546][   T66] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 =
> 1

[  919.567377][   T66] Bluetooth: hci1: unexpected cc 0x1003 length: 249 =
> 9

[  919.570109][   T66] Bluetooth: hci1: unexpected cc 0x1001 length: 249 =
> 9

[  919.576154][   T66] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 =
> 4

[  919.579740][   T66] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 =
> 2

[  919.606639][T10835] Bluetooth: hci2: unexpected cc 0x0c03 length: 249 =
> 1

[  919.610129][T10835] Bluetooth: hci2: unexpected cc 0x1003 length: 249 =
> 9

[  919.619747][T10835] Bluetooth: hci2: unexpected cc 0x1001 length: 249 =
> 9

[  919.623023][T10835] Bluetooth: hci2: unexpected cc 0x0c23 length: 249 =
> 4

[  919.626159][T10835] Bluetooth: hci2: unexpected cc 0x0c38 length: 249 =
> 2

[  919.703639][ T5195] Bluetooth: hci3: unexpected cc 0x0c03 length: 249 =
> 1

[  919.708053][ T5195] Bluetooth: hci3: unexpected cc 0x1003 length: 249 =
> 9

[  919.712437][ T5195] Bluetooth: hci3: unexpected cc 0x1001 length: 249 =
> 9

[  919.717928][ T5195] Bluetooth: hci3: unexpected cc 0x0c23 length: 249 =
> 4

[  919.722762][ T5195] Bluetooth: hci3: unexpected cc 0x0c38 length: 249 =
> 2

[  919.755714][   T66] Bluetooth: hci4: unexpected cc 0x0c03 length: 249 =
> 1

[  919.759063][   T66] Bluetooth: hci4: unexpected cc 0x1003 length: 249 =
> 9

[  919.770371][   T66] Bluetooth: hci4: unexpected cc 0x1001 length: 249 =
> 9

[  919.800460][   T66] Bluetooth: hci4: unexpected cc 0x0c23 length: 249 =
> 4

[  919.804564][   T66] Bluetooth: hci4: unexpected cc 0x0c38 length: 249 =
> 2

[  919.872072][ T5195] Bluetooth: hci5: unexpected cc 0x0c03 length: 249 =
> 1

[  919.875504][ T5195] Bluetooth: hci5: unexpected cc 0x1003 length: 249 =
> 9

[  919.880327][ T5195] Bluetooth: hci5: unexpected cc 0x1001 length: 249 =
> 9

[  919.883700][ T5195] Bluetooth: hci5: unexpected cc 0x0c23 length: 249 =
> 4

[  919.886837][ T5195] Bluetooth: hci5: unexpected cc 0x0c38 length: 249 =
> 2

[  919.908964][ T5195] Bluetooth: hci7: unexpected cc 0x0c03 length: 249 =
> 1

[  919.927098][ T5195] Bluetooth: hci7: unexpected cc 0x1003 length: 249 =
> 9

[  919.935015][ T5195] Bluetooth: hci7: unexpected cc 0x1001 length: 249 =
> 9

[  919.938768][ T5195] Bluetooth: hci7: unexpected cc 0x0c23 length: 249 =
> 4

[  919.941866][ T5195] Bluetooth: hci7: unexpected cc 0x0c38 length: 249 =
> 2

[  920.008491][T10835] Bluetooth: hci6: unexpected cc 0x0c03 length: 249 =
> 1

[  920.011705][T10835] Bluetooth: hci6: unexpected cc 0x1003 length: 249 =
> 9

[  920.015616][ T5195] Bluetooth: hci6: unexpected cc 0x1001 length: 249 =
> 9

[  920.024527][ T5195] Bluetooth: hci6: unexpected cc 0x0c23 length: 249 =
> 4

[  920.029255][ T5195] Bluetooth: hci6: unexpected cc 0x0c38 length: 249 =
> 2

[  920.040518][T10835] Bluetooth: hci8: unexpected cc 0x0c03 length: 249 =
> 1

[  920.051808][   T66] Bluetooth: hci8: unexpected cc 0x1003 length: 249 =
> 9

[  920.057194][   T66] Bluetooth: hci8: unexpected cc 0x1001 length: 249 =
> 9

[  920.064886][   T66] Bluetooth: hci8: unexpected cc 0x0c23 length: 249 =
> 4

[  920.071478][   T66] Bluetooth: hci8: unexpected cc 0x0c38 length: 249 =
> 2

[  921.214627][   T12] netdevsim netdevsim3 netdevsim3 (unregistering): =
unset [1, 0] type 2 family 0 port 6081 - 0

[  921.299245][T10838] chnl_net:caif_netlink_parms(): no params data =
found

[  921.510123][T10845] chnl_net:caif_netlink_parms(): no params data =
found

[  921.535440][T10821] chnl_net:caif_netlink_parms(): no params data =
found

[  921.639333][   T66] Bluetooth: hci1: command tx timeout

[  921.707022][   T66] Bluetooth: hci2: command tx timeout

[  921.804680][T10829] chnl_net:caif_netlink_parms(): no params data =
found

[  921.867709][   T66] Bluetooth: hci3: command tx timeout

[  921.947451][   T66] Bluetooth: hci5: command tx timeout

[  921.956997][   T66] Bluetooth: hci4: command tx timeout

[  921.971062][T10844] chnl_net:caif_netlink_parms(): no params data =
found

[  922.029666][   T66] Bluetooth: hci7: command tx timeout

[  922.086036][   T12] netdevsim netdevsim3 netdevsim2 (unregistering): =
unset [1, 0] type 2 family 0 port 6081 - 0

[  922.107057][   T66] Bluetooth: hci6: command tx timeout

[  922.117291][   T66] Bluetooth: hci8: command tx timeout

[  922.193339][T10838] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  922.195618][T10838] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  922.198533][T10838] bridge_slave_0: entered allmulticast mode

[  922.202362][T10838] bridge_slave_0: entered promiscuous mode

[  922.208021][T10850] chnl_net:caif_netlink_parms(): no params data =
found

[  922.266535][   T12] netdevsim netdevsim3 netdevsim1 (unregistering): =
unset [1, 0] type 2 family 0 port 6081 - 0

[  922.368943][T10855] chnl_net:caif_netlink_parms(): no params data =
found

[  922.388709][T10838] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  922.390717][T10838] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  922.392766][T10838] bridge_slave_1: entered allmulticast mode

[  922.396489][T10838] bridge_slave_1: entered promiscuous mode

[  922.736935][T10845] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  922.738922][T10845] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  922.740932][T10845] bridge_slave_0: entered allmulticast mode

[  922.744564][T10845] bridge_slave_0: entered promiscuous mode

[  922.763595][   T12] netdevsim netdevsim3 netdevsim0 (unregistering): =
unset [1, 0] type 2 family 0 port 6081 - 0

[  922.783814][T10821] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  922.786034][T10821] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  922.788576][T10821] bridge_slave_0: entered allmulticast mode

[  922.792339][T10821] bridge_slave_0: entered promiscuous mode

[  922.856045][T10838] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  922.863297][T10838] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  922.884884][T10845] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  922.893549][T10845] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  922.895831][T10845] bridge_slave_1: entered allmulticast mode

[  922.899946][T10845] bridge_slave_1: entered promiscuous mode

[  922.946477][T10821] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  922.948757][T10821] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  922.950930][T10821] bridge_slave_1: entered allmulticast mode

[  922.954712][T10821] bridge_slave_1: entered promiscuous mode

[  923.181322][T10864] chnl_net:caif_netlink_parms(): no params data =
found

[  923.310105][T10829] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  923.312294][T10829] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  923.314465][T10829] bridge_slave_0: entered allmulticast mode

[  923.318449][T10829] bridge_slave_0: entered promiscuous mode

[  923.324422][T10829] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  923.326619][T10829] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  923.328957][T10829] bridge_slave_1: entered allmulticast mode

[  923.332691][T10829] bridge_slave_1: entered promiscuous mode

[  923.349559][T10838] team0: Port device team_slave_0 added

[  923.470914][T10844] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  923.473121][T10844] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  923.475310][T10844] bridge_slave_0: entered allmulticast mode

[  923.480689][T10844] bridge_slave_0: entered promiscuous mode

[  923.485561][T10844] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  923.489031][T10844] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  923.491166][T10844] bridge_slave_1: entered allmulticast mode

[  923.494833][T10844] bridge_slave_1: entered promiscuous mode

[  923.577674][T10821] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  923.583872][T10844] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  923.625694][T10838] team0: Port device team_slave_1 added

[  923.710629][T10845] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  923.713389][T10850] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  923.715630][T10850] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  923.717872][   T66] Bluetooth: hci1: command tx timeout

[  923.724438][T10850] bridge_slave_0: entered allmulticast mode

[  923.729452][T10850] bridge_slave_0: entered promiscuous mode

[  923.786885][   T66] Bluetooth: hci2: command tx timeout

[  923.801438][T10821] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  923.807493][T10844] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  923.887337][T10855] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  923.889532][T10855] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  923.891721][T10855] bridge_slave_0: entered allmulticast mode

[  923.895477][T10855] bridge_slave_0: entered promiscuous mode

[  923.911009][T10845] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  923.946978][T10850] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  923.949203][T10850] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  923.951448][T10850] bridge_slave_1: entered allmulticast mode

[  923.955270][T10850] bridge_slave_1: entered promiscuous mode

[  923.957409][   T66] Bluetooth: hci3: command tx timeout

[  924.027127][   T66] Bluetooth: hci4: command tx timeout

[  924.027207][ T5195] Bluetooth: hci5: command tx timeout

[  924.099184][T10829] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  924.116988][ T5195] Bluetooth: hci7: command tx timeout

[  924.137088][T10855] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  924.139254][T10855] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  924.141395][T10855] bridge_slave_1: entered allmulticast mode

[  924.145112][T10855] bridge_slave_1: entered promiscuous mode

[  924.197865][ T5195] Bluetooth: hci8: command tx timeout

[  924.197896][   T66] Bluetooth: hci6: command tx timeout

[  924.225510][T10845] team0: Port device team_slave_0 added

[  924.233468][T10845] team0: Port device team_slave_1 added

[  924.376019][T10844] team0: Port device team_slave_0 added

[  924.382128][T10829] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  924.388497][T10844] team0: Port device team_slave_1 added

[  924.392028][T10838] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  924.394102][T10838] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  924.404618][T10838] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  924.524389][T10850] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  924.609644][T10821] team0: Port device team_slave_0 added

[  924.612196][T10864] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  924.614410][T10864] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  924.616642][T10864] bridge_slave_0: entered allmulticast mode

[  924.622504][T10864] bridge_slave_0: entered promiscuous mode

[  924.701563][T10838] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  924.703647][T10838] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  924.712708][T10838] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  924.730699][T10855] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  924.734164][T10845] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  924.736190][T10845] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  924.743355][T10845] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  924.750994][T10845] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  924.752989][T10845] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  924.762371][T10845] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  924.769570][T10850] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  924.791884][T10821] team0: Port device team_slave_1 added

[  924.835320][T10864] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  924.838338][T10864] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  924.840495][T10864] bridge_slave_1: entered allmulticast mode

[  924.844275][T10864] bridge_slave_1: entered promiscuous mode

[  924.920415][T10844] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  924.922514][T10844] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  924.931588][T10844] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  924.938703][T10855] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  925.068796][   T12] bridge_slave_1: left allmulticast mode

[  925.070772][   T12] bridge_slave_1: left promiscuous mode

[  925.072998][   T12] bridge0: port 2(bridge_slave_1) entered disabled =
state

[  925.081744][   T12] bridge_slave_0: left allmulticast mode

[  925.083428][   T12] bridge_slave_0: left promiscuous mode

[  925.085160][   T12] bridge0: port 1(bridge_slave_0) entered disabled =
state

[  925.605030][   T12] bond0 (unregistering): (slave bond_slave_0): =
Releasing backup interface

[  925.611219][   T12] bond0 (unregistering): (slave bond_slave_1): =
Releasing backup interface

[  925.616219][   T12] bond0 (unregistering): Released all slaves

[  925.787192][   T66] Bluetooth: hci1: command tx timeout

[  925.809966][T10829] team0: Port device team_slave_0 added

[  925.837297][T10844] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  925.839331][T10844] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  925.846515][T10844] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  925.866902][   T66] Bluetooth: hci2: command tx timeout

[  925.900622][T10855] team0: Port device team_slave_0 added

[  925.907723][T10850] team0: Port device team_slave_0 added

[  925.912099][T10821] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  925.914121][T10821] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  925.922298][T10821] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  925.929994][T10864] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link

[  925.934483][T10829] team0: Port device team_slave_1 added

[  926.037026][   T66] Bluetooth: hci3: command tx timeout

[  926.062899][T10855] team0: Port device team_slave_1 added

[  926.108429][   T66] Bluetooth: hci5: command tx timeout

[  926.117388][   T66] Bluetooth: hci4: command tx timeout

[  926.156050][T10855] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  926.164459][T10855] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  926.172798][T10855] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  926.178508][T10850] team0: Port device team_slave_1 added

[  926.187410][   T66] Bluetooth: hci7: command tx timeout

[  926.221221][T10821] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  926.223309][T10821] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  926.231161][T10821] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  926.267124][   T66] Bluetooth: hci6: command tx timeout

[  926.268594][   T66] Bluetooth: hci8: command tx timeout

[  926.278056][T10864] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link

[  926.338943][T10838] hsr_slave_0: entered promiscuous mode

[  926.342819][T10838] hsr_slave_1: entered promiscuous mode

[  926.345119][T10838] debugfs: Directory 'hsr0' with parent 'hsr' =
already present!

[  926.350442][T10838] Cannot create hsr debugfs directory

[  926.433400][T10845] hsr_slave_0: entered promiscuous mode

[  926.437936][T10845] hsr_slave_1: entered promiscuous mode

[  926.440336][T10845] debugfs: Directory 'hsr0' with parent 'hsr' =
already present!

[  926.442499][T10845] Cannot create hsr debugfs directory

[  926.445274][T10855] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  926.449829][T10855] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  926.457923][T10855] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  926.706976][T10844] hsr_slave_0: entered promiscuous mode

[  926.710005][T10844] hsr_slave_1: entered promiscuous mode

[  926.712398][T10844] debugfs: Directory 'hsr0' with parent 'hsr' =
already present!

[  926.714611][T10844] Cannot create hsr debugfs directory

[  926.740331][T10850] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  926.742385][T10850] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  926.749626][T10850] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  926.755170][T10850] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  926.757263][T10850] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  926.764525][T10850] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  926.814240][T10829] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  926.816289][T10829] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  926.824002][T10829] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  926.829807][T10829] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  926.831820][T10829] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  926.839225][T10829] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  926.846477][T10864] team0: Port device team_slave_0 added

[  926.856627][T10864] team0: Port device team_slave_1 added

[  927.138347][T10864] batman_adv: batadv0: Adding interface: =
batadv_slave_0

[  927.140418][T10864] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  927.148768][T10864] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active

[  927.303685][T10821] hsr_slave_0: entered promiscuous mode

[  927.308093][T10821] hsr_slave_1: entered promiscuous mode

[  927.310539][T10821] debugfs: Directory 'hsr0' with parent 'hsr' =
already present!

[  927.312690][T10821] Cannot create hsr debugfs directory

[  927.399630][   T12] hsr_slave_0: left promiscuous mode

[  927.402229][   T12] hsr_slave_1: left promiscuous mode

[  927.404558][   T12] batman_adv: batadv0: Interface deactivated: =
batadv_slave_0

[  927.406866][   T12] batman_adv: batadv0: Removing interface: =
batadv_slave_0

[  927.410436][   T12] batman_adv: batadv0: Interface deactivated: =
batadv_slave_1

[  927.412589][   T12] batman_adv: batadv0: Removing interface: =
batadv_slave_1

[  927.433742][   T12] veth1_macvtap: left promiscuous mode

[  927.435578][   T12] veth0_macvtap: left promiscuous mode

[  927.438117][   T12] veth1_vlan: left promiscuous mode

[  927.439806][   T12] veth0_vlan: left promiscuous mode

[  927.867992][ T5195] Bluetooth: hci1: command tx timeout

[  927.929674][   T12] team0 (unregistering): Port device team_slave_1 =
removed

[  927.957048][ T5195] Bluetooth: hci2: command tx timeout

[  927.970077][   T12] team0 (unregistering): Port device team_slave_0 =
removed

[  928.117171][ T5195] Bluetooth: hci3: command tx timeout

[  928.187238][   T66] Bluetooth: hci5: command tx timeout

[  928.188747][ T5195] Bluetooth: hci4: command tx timeout

[  928.267092][ T5195] Bluetooth: hci7: command tx timeout

[  928.285982][T10864] batman_adv: batadv0: Adding interface: =
batadv_slave_1

[  928.294361][T10864] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.

[  928.301921][T10864] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active

[  928.347320][ T5195] Bluetooth: hci8: command tx timeout

[  928.348797][ T5195] Bluetooth: hci6: command tx timeout

[  928.385092][T10850] hsr_slave_0: entered promiscuous mode

[  928.389076][T10850] hsr_slave_1: entered promiscuous mode

[  928.634035][T10829] hsr_slave_0: entered promiscuous mode

[  928.640671][T10829] hsr_slave_1: entered promiscuous mode

[  928.643163][T10829] debugfs: Directory 'hsr0' with parent 'hsr' =
already present!

[  928.645404][T10829] Cannot create hsr debugfs directory

[  928.708210][T10855] hsr_slave_0: entered promiscuous mode

[  928.711092][T10855] hsr_slave_1: entered promiscuous mode

[  928.713552][T10855] debugfs: Directory 'hsr0' with parent 'hsr' =
already present!

[  928.715842][T10855] Cannot create hsr debugfs directory

[  929.501277][T10864] hsr_slave_0: entered promiscuous mode

[  929.504115][T10864] hsr_slave_1: entered promiscuous mode

[  929.506349][T10864] debugfs: Directory 'hsr0' with parent 'hsr' =
already present!

[  929.508451][T10864] Cannot create hsr debugfs directory

[  930.233190][T10838] netdevsim netdevsim2 netdevsim0: renamed from =
eth0

[  930.290580][T10838] netdevsim netdevsim2 netdevsim1: renamed from =
eth1

[  930.300060][T10838] netdevsim netdevsim2 netdevsim2: renamed from =
eth2

[  930.374594][T10838] netdevsim netdevsim2 netdevsim3: renamed from =
eth3

[  930.563270][T10838] 8021q: adding VLAN 0 to HW filter on device bond0

[  930.586046][T10838] 8021q: adding VLAN 0 to HW filter on device team0

[  930.596166][ T9967] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  930.598471][ T9967] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  930.612420][ T9967] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  930.614601][ T9967] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  930.743166][T10821] netdevsim netdevsim0 netdevsim0: renamed from =
eth0

[  930.751642][T10821] netdevsim netdevsim0 netdevsim1: renamed from =
eth1

[  930.758754][T10821] netdevsim netdevsim0 netdevsim2: renamed from =
eth2

[  930.771954][T10821] netdevsim netdevsim0 netdevsim3: renamed from =
eth3

[  930.858591][T10845] netdevsim netdevsim5 netdevsim0: renamed from =
eth0

[  930.870025][T10845] netdevsim netdevsim5 netdevsim1: renamed from =
eth1

[  930.896402][T10845] netdevsim netdevsim5 netdevsim2: renamed from =
eth2

[  930.926938][T10845] netdevsim netdevsim5 netdevsim3: renamed from =
eth3

[  931.017328][T10850] netdevsim netdevsim4 netdevsim0: renamed from =
eth0

[  931.026684][T10850] netdevsim netdevsim4 netdevsim1: renamed from =
eth1

[  931.045954][T10850] netdevsim netdevsim4 netdevsim2: renamed from =
eth2

[  931.059320][T10850] netdevsim netdevsim4 netdevsim3: renamed from =
eth3

[  931.076503][T10838] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  931.184168][T10829] netdevsim netdevsim1 netdevsim0: renamed from =
eth0

[  931.192305][T10829] netdevsim netdevsim1 netdevsim1: renamed from =
eth1

[  931.223126][T10821] 8021q: adding VLAN 0 to HW filter on device bond0

[  931.231471][T10829] netdevsim netdevsim1 netdevsim2: renamed from =
eth2

[  931.243441][T10829] netdevsim netdevsim1 netdevsim3: renamed from =
eth3

[  931.361510][T10855] netdevsim netdevsim6 netdevsim0: renamed from =
eth0

[  931.378596][T10855] netdevsim netdevsim6 netdevsim1: renamed from =
eth1

[  931.398064][T10821] 8021q: adding VLAN 0 to HW filter on device team0

[  931.413738][T10855] netdevsim netdevsim6 netdevsim2: renamed from =
eth2

[  931.424877][T10855] netdevsim netdevsim6 netdevsim3: renamed from =
eth3

[  931.487812][T10838] veth0_vlan: entered promiscuous mode

[  931.511767][ T1029] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  931.513987][ T1029] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  931.574276][T10845] 8021q: adding VLAN 0 to HW filter on device bond0

[  931.598509][ T1029] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  931.600707][ T1029] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  931.616459][T10864] netdevsim netdevsim7 netdevsim0: renamed from =
eth0

[  931.633371][T10864] netdevsim netdevsim7 netdevsim1: renamed from =
eth1

[  931.645884][T10864] netdevsim netdevsim7 netdevsim2: renamed from =
eth2

[  931.695277][T10838] veth1_vlan: entered promiscuous mode

[  931.712478][T10864] netdevsim netdevsim7 netdevsim3: renamed from =
eth3

[  931.761456][T10845] 8021q: adding VLAN 0 to HW filter on device team0

[  931.840241][ T9808] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  931.842438][ T9808] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  931.851608][T10844] netdevsim netdevsim3 netdevsim0: renamed from =
eth0

[  931.860082][T10844] netdevsim netdevsim3 netdevsim1: renamed from =
eth1

[  931.897456][ T9808] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  931.899648][ T9808] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  931.910110][T10844] netdevsim netdevsim3 netdevsim2: renamed from =
eth2

[  931.933446][T10844] netdevsim netdevsim3 netdevsim3: renamed from =
eth3

[  931.952701][T10850] 8021q: adding VLAN 0 to HW filter on device bond0

[  932.028273][T10838] veth0_macvtap: entered promiscuous mode

[  932.059592][T10829] 8021q: adding VLAN 0 to HW filter on device bond0

[  932.074396][T10850] 8021q: adding VLAN 0 to HW filter on device team0

[  932.081847][T10838] veth1_macvtap: entered promiscuous mode

[  932.124255][ T9808] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  932.126473][ T9808] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  932.186673][T10829] 8021q: adding VLAN 0 to HW filter on device team0

[  932.204394][   T96] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  932.206630][   T96] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  932.234640][T10838] batman_adv: batadv0: Interface activated: =
batadv_slave_0

[  932.243773][T10838] batman_adv: batadv0: Interface activated: =
batadv_slave_1

[  932.261975][ T1029] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  932.264138][ T1029] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  932.301801][T10855] 8021q: adding VLAN 0 to HW filter on device bond0

[  932.329964][T10838] netdevsim netdevsim2 netdevsim0: set [1, 0] type =
2 family 0 port 6081 - 0

[  932.332679][T10838] netdevsim netdevsim2 netdevsim1: set [1, 0] type =
2 family 0 port 6081 - 0

[  932.335234][T10838] netdevsim netdevsim2 netdevsim2: set [1, 0] type =
2 family 0 port 6081 - 0

[  932.340126][T10838] netdevsim netdevsim2 netdevsim3: set [1, 0] type =
2 family 0 port 6081 - 0

[  932.360551][T10025] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  932.362708][T10025] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  932.470065][T10855] 8021q: adding VLAN 0 to HW filter on device team0

[  932.509723][ T9808] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  932.511870][ T9808] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  932.532484][T10821] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  932.581787][   T38] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  932.583744][   T38] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  932.673051][T10845] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  932.803179][ T9808] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50

[  932.805490][ T9808] wlan0: Creating new IBSS network, BSSID =
50:50:50:50:50:50

[  932.840593][T10864] 8021q: adding VLAN 0 to HW filter on device bond0

[  932.993677][T10844] 8021q: adding VLAN 0 to HW filter on device bond0

[  933.009843][  T176] wlan1: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50

[  933.012301][  T176] wlan1: Creating new IBSS network, BSSID =
50:50:50:50:50:50

[  933.023774][T10864] 8021q: adding VLAN 0 to HW filter on device team0

[  933.070294][T10844] 8021q: adding VLAN 0 to HW filter on device team0

[  933.085120][T10821] veth0_vlan: entered promiscuous mode

[  933.093470][ T9964] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  933.095651][ T9964] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  933.103801][T10850] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  933.171641][ T9964] bridge0: port 1(bridge_slave_0) entered blocking =
state

[  933.173863][ T9964] bridge0: port 1(bridge_slave_0) entered =
forwarding state

[  933.190205][ T9964] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  933.192372][ T9964] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  933.229438][T10821] veth1_vlan: entered promiscuous mode

[  933.240901][ T9964] bridge0: port 2(bridge_slave_1) entered blocking =
state

[  933.243085][ T9964] bridge0: port 2(bridge_slave_1) entered =
forwarding state

[  933.507410][T10845] veth0_vlan: entered promiscuous mode

[  933.515747][T10855] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  933.605615][T10829] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  933.657726][T10845] veth1_vlan: entered promiscuous mode

[  933.722237][T10821] veth0_macvtap: entered promiscuous mode

[  933.831664][T10821] veth1_macvtap: entered promiscuous mode

[  933.916253][T10850] veth0_vlan: entered promiscuous mode

[  933.930123][T10850] veth1_vlan: entered promiscuous mode

[  934.001595][T10821] batman_adv: batadv0: Interface activated: =
batadv_slave_0

[  934.036308][T10821] batman_adv: batadv0: Interface activated: =
batadv_slave_1

[  934.049459][T10845] veth0_macvtap: entered promiscuous mode

[  934.054623][T10821] netdevsim netdevsim0 netdevsim0: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.067081][T10821] netdevsim netdevsim0 netdevsim1: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.069689][T10821] netdevsim netdevsim0 netdevsim2: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.072139][T10821] netdevsim netdevsim0 netdevsim3: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.081363][T10829] veth0_vlan: entered promiscuous mode

[  934.102088][T10844] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  934.112537][T10864] 8021q: adding VLAN 0 to HW filter on device =
batadv0

[  934.124127][T10845] veth1_macvtap: entered promiscuous mode

[  934.150885][T10829] veth1_vlan: entered promiscuous mode

[  934.194098][T10850] veth0_macvtap: entered promiscuous mode

[  934.240727][T10850] veth1_macvtap: entered promiscuous mode

[  934.300953][T10845] batman_adv: batadv0: Interface activated: =
batadv_slave_0

[  934.386854][T10829] veth0_macvtap: entered promiscuous mode

[  934.393273][T10845] batman_adv: batadv0: Interface activated: =
batadv_slave_1

[  934.453168][T10855] veth0_vlan: entered promiscuous mode

[  934.463878][T10850] batman_adv: batadv0: Interface activated: =
batadv_slave_0

[  934.523142][T10829] veth1_macvtap: entered promiscuous mode

[  934.531858][T10850] batman_adv: batadv0: Interface activated: =
batadv_slave_1

[  934.567817][ T9964] wlan0: Created IBSS using preconfigured BSSID =
50:50:50:50:50:50

[  934.568413][T10855] veth1_vlan: entered promiscuous mode

[  934.569780][ T9964] wlan0: Creating new IBSS network, BSSID =
50:50:50:50:50:50

[  934.585080][T10845] netdevsim netdevsim5 netdevsim0: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.595705][T10845] netdevsim netdevsim5 netdevsim1: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.599136][T10845] netdevsim netdevsim5 netdevsim2: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.601627][T10845] netdevsim netdevsim5 netdevsim3: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.639193][T10844] veth0_vlan: entered promiscuous mode

[  934.666595][T10829] batman_adv: batadv0: Interface activated: =
batadv_slave_0

[  934.676227][T10829] batman_adv: batadv0: Interface activated: =
batadv_slave_1

[  934.683517][T10829] netdevsim netdevsim1 netdevsim0: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.686196][T10829] netdevsim netdevsim1 netdevsim1: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.697322][T10829] netdevsim netdevsim1 netdevsim2: set [1, 0] type =
2 family 0 port 6081 - 0

[  934.699863][T10829] netdevsim netdevsim1 netdevsim3: set [1, 0] type =
2 family 0 port 6081 - 0

[  943.874779][    C0] hrtimer: interrupt took 23434971404 ns

[  958.067531][ T5195] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 =
> 1

[  958.070691][ T5195] Bluetooth: hci0: unexpected cc 0x1003 length: 249 =
> 9

[  958.073364][ T5195] Bluetooth: hci0: unexpected cc 0x1001 length: 249 =
> 9

[  958.077064][ T5195] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 =
> 4

[  958.079985][ T5195] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 =
> 2

[ 1039.556758][    C1] rcu: INFO: rcu_preempt detected stalls on =
CPUs/tasks:

[ 1039.556758][    C1] rcu: 	0-...!: (2 ticks this GP) =
idle=3Dce1c/1/0x4000000000000000 softirq=3D17149/17149 fqs=3D197

[ 1039.556758][    C1] rcu: 	Tasks blocked on level-0 rcu_node (CPUs =
0-3): P10850/1:b.el

[ 1039.556758][    C1] rcu: 	(detected by 1, t=3D10502 jiffies, =
g=3D13333, q=3D3256 ncpus=3D4)

[ 1039.556758][    C1] Sending NMI from CPU 1 to CPUs 0:

[  990.532229][    C0] NMI backtrace for cpu 0

[  990.532229][    C0] CPU: 0 UID: 0 PID: 10851 Comm: systemd-udevd Not =
tainted 6.16.0-rc4 #1 PREEMPT(full)=20

[  990.532229][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014

[  990.532229][    C0] RIP: 0010:__lock_acquire+0xb12/0x1ee0

[  990.532229][    C0] Code: c1 ea 2d 48 8d 04 d5 20 3a f5 96 49 89 d4 =
48 89 44 24 10 48 8b 04 d5 20 3a f5 96 48 85 c0 74 1c 48 83 e8 08 74 16 =
48 8b 50 18 <49> 39 d6 0f 84 cd fb ff ff 48 8b 40 08 48 85 c0 75 e4 44 =
89 04 24

[  990.532229][    C0] RSP: 0018:ffa0000000007ba8 EFLAGS: 00000086

[  990.532229][    C0] RAX: ffffffff93b813a0 RBX: ff110000222fb018 RCX: =
000000004fa421e6

[  990.532229][    C0] RDX: 97064f26aa3bd169 RSI: ff110000222fb018 RDI: =
ff110000222fb018

[  990.532229][    C0] RBP: ff110000222fa480 R08: 0000000000000000 R09: =
97064f26aa3bd169

[  990.532229][    C0] R10: 0000000000000000 R11: 0000000000000003 R12: =
0000000000033dff

[  990.532229][    C0] R13: 0000000000000001 R14: 97064f26aa3bd169 R15: =
0000000000000002

[  990.532229][    C0] FS:  0000000000000000(0000) =
GS:ff11000097b10000(0000) knlGS:0000000000000000

[  990.532229][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[  990.532229][    C0] CR2: 0000564811822118 CR3: 000000006e6ec000 CR4: =
0000000000751ef0

[  990.532229][    C0] PKRU: 55555554

[  990.532229][    C0] Call Trace:

[  990.532229][    C0]  <IRQ>

[  990.532229][    C0]  ? cache_seq_start_rcu+0x149/0x370

[  990.532229][    C0]  lock_acquire+0x17b/0x340

[  990.532229][    C0]  ? debug_object_activate+0x141/0x360

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? __pfx_debug_objects_fill_pool+0x10/0x10

[  990.532229][    C0]  _raw_spin_lock_irqsave+0x3d/0x60

[  990.532229][    C0]  ? debug_object_activate+0x141/0x360

[  990.532229][    C0]  debug_object_activate+0x141/0x360

[  990.532229][    C0]  ? __pfx_debug_object_activate+0x10/0x10

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? do_raw_spin_lock+0x122/0x2d0

[  990.532229][    C0]  ? __pfx_do_raw_spin_lock+0x10/0x10

[  990.532229][    C0]  enqueue_hrtimer+0x27/0x3c0

[  990.532229][    C0]  __hrtimer_run_queues+0xa7f/0xc60

[  990.532229][    C0]  ? __pfx___hrtimer_run_queues+0x10/0x10

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  hrtimer_interrupt+0x39a/0x880

[  990.532229][    C0]  __sysvec_apic_timer_interrupt+0x10d/0x400

[  990.532229][    C0]  sysvec_apic_timer_interrupt+0xa3/0xc0

[  990.532229][    C0]  </IRQ>

[  990.532229][    C0]  <TASK>

[  990.532229][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[  990.532229][    C0] RIP: 0010:write_comp_data+0x73/0x80

[  990.532229][    C0] Code: 00 48 8d 14 fd 28 00 00 00 48 39 d6 72 1b =
48 83 c1 01 48 89 08 4c 89 6c 10 e0 4c 89 64 10 e8 48 89 6c 10 f0 48 89 =
5c f8 20 5b <5d> 41 5c 41 5d 41 5e e9 9c 61 54 ff 90 90 90 90 90 90 90 =
90 90 90

[  990.532229][    C0] RSP: 0018:ffa0000008b8f780 EFLAGS: 00000246

[  990.532229][    C0] RAX: 0000000000000000 RBX: 0000000000056062 RCX: =
ffffffff8207f3d3

[  990.532229][    C0] RDX: 0000000000056062 RSI: ff110000222fa480 RDI: =
0000000000000003

[  990.532229][    C0] RBP: 0000000000056062 R08: 0000000000000000 R09: =
fffa7c000009d4a7

[  990.532229][    C0] R10: fffa7c000009d4a6 R11: ffd40000004ea533 R12: =
000000000007ffdf

[  990.532229][    C0] R13: 0000000000000006 R14: ff110000222fa480 R15: =
0000000000000000

[  990.532229][    C0]  ? vm_normal_page+0xf3/0x310

[  990.532229][    C0]  vm_normal_page+0xf3/0x310

[  990.532229][    C0]  ? __pfx_vm_normal_page+0x10/0x10

[  990.532229][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? =
__tlb_remove_folio_pages_size.constprop.0+0x171/0x560

[  990.532229][    C0]  ? check_kcov_mode+0x10/0x50

[  990.532229][    C0]  unmap_page_range+0xda6/0x43a0

[  990.532229][    C0]  ? __pfx_unmap_page_range+0x10/0x10

[  990.532229][    C0]  ? write_comp_data+0x29/0x80

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? mas_next_slot+0xb2a/0x11e0

[  990.532229][    C0]  unmap_single_vma.constprop.0+0x153/0x230

[  990.532229][    C0]  unmap_vmas+0x1e2/0x440

[  990.532229][    C0]  ? __pfx_unmap_vmas+0x10/0x10

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? write_comp_data+0x29/0x80

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? mas_next_slot+0xb2a/0x11e0

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? write_comp_data+0x29/0x80

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  exit_mmap+0x1b3/0xbe0

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? __pfx_exit_mmap+0x10/0x10

[  990.532229][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[  990.532229][    C0]  mmput+0x178/0x450

[  990.532229][    C0]  do_exit+0x838/0x2ef0

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? zap_other_threads+0x26a/0x310

[  990.532229][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[  990.532229][    C0]  ? __pfx_do_exit+0x10/0x10

[  990.532229][    C0]  ? do_group_exit+0x1c3/0x2a0

[  990.532229][    C0]  ? _raw_spin_unlock_irq+0x23/0x50

[  990.532229][    C0]  do_group_exit+0xd3/0x2a0

[  990.532229][    C0]  __x64_sys_exit_group+0x3e/0x50

[  990.532229][    C0]  x64_sys_call+0xf76/0x18a0

[  990.532229][    C0]  do_syscall_64+0xcf/0x4d0

[  990.532229][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[  990.532229][    C0] RIP: 0033:0x7f23a2e5cc79

[  990.532229][    C0] Code: Unable to access opcode bytes at =
0x7f23a2e5cc4f.

[  990.532229][    C0] RSP: 002b:00007ffed7737758 EFLAGS: 00000202 =
ORIG_RAX: 00000000000000e7

[  990.532229][    C0] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007f23a2e5cc79

[  990.532229][    C0] RDX: 000000000000003c RSI: 00000000000000e7 RDI: =
0000000000000000

[  990.532229][    C0] RBP: 0000564810fc2cf0 R08: fffffffffffffe00 R09: =
0000000000000000

[  990.532229][    C0] R10: 0000000000000008 R11: 0000000000000202 R12: =
0000564811843410

[  990.532229][    C0] R13: 00005648118afc20 R14: 00007ffed77377d0 R15: =
0000564811827170

[  990.532229][    C0]  </TASK>

[ 1039.556758][    C1] task:syz-executor    state:R  running task     =
stack:23848 pid:10850 tgid:10850 ppid:10840  task_flags:0x400140 =
flags:0x00004002

[ 1039.556758][    C1] Call Trace:

[ 1039.556758][    C1]  <TASK>

[ 1039.556758][    C1]  __schedule+0x125f/0x53f0

[ 1039.556758][    C1]  ? __kernel_text_address+0xd/0x40

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? arch_stack_walk+0x9c/0xf0

[ 1039.556758][    C1]  ? __pfx___schedule+0x10/0x10

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? __lock_acquire+0x65e/0x1ee0

[ 1039.556758][    C1]  preempt_schedule_irq+0x51/0x90

[ 1039.556758][    C1]  irqentry_exit+0x36/0x90

[ 1039.556758][    C1]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[ 1039.556758][    C1] RIP: 0010:lock_release+0x17e/0x2f0

[ 1039.556758][    C1] Code: 0f c1 05 7d f8 18 12 83 f8 01 0f 85 1d 01 =
00 00 9c 58 f6 c4 02 0f 85 08 01 00 00 41 f7 c5 00 02 00 00 74 01 fb 48 =
8b 44 24 10 <65> 48 33 05 92 b6 18 12 0f 85 58 01 00 00 48 83 c4 18 5d =
41 5c 41

[ 1039.556758][    C1] RSP: 0018:ffa0000003ae7898 EFLAGS: 00000206

[ 1039.556758][    C1] RAX: f0460f8e77cd8500 RBX: 00007fa0ff3af6fb RCX: =
ffa0000003ae78a4

[ 1039.556758][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000

[ 1039.556758][    C1] RBP: ffffffff8e3c1300 R08: 0000000000000001 R09: =
0ac0d5affe09d4ff

[ 1039.556758][    C1] R10: 0000000000000001 R11: 0000000000000003 R12: =
ffffffff81a66e92

[ 1039.556758][    C1] R13: 0000000000000206 R14: ff11000020c58000 R15: =
0000000000000001

[ 1039.556758][    C1]  ? is_module_text_address+0x62/0x100

[ 1039.556758][    C1]  is_module_text_address+0x67/0x100

[ 1039.556758][    C1]  kernel_text_address+0x35/0x90

[ 1039.556758][    C1]  __kernel_text_address+0xd/0x40

[ 1039.556758][    C1]  unwind_get_return_address+0x62/0xb0

[ 1039.556758][    C1]  ? __pfx_stack_trace_consume_entry+0x10/0x10

[ 1039.556758][    C1]  arch_stack_walk+0x9c/0xf0

[ 1039.556758][    C1]  stack_trace_save+0x8e/0xc0

[ 1039.556758][    C1]  ? __pfx_stack_trace_save+0x10/0x10

[ 1039.556758][    C1]  ? __entry_text_end+0x1020b5/0x1020b9

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  kasan_save_stack+0x24/0x50

[ 1039.556758][    C1]  ? kasan_save_stack+0x24/0x50

[ 1039.556758][    C1]  ? kasan_save_track+0x14/0x30

[ 1039.556758][    C1]  ? __kasan_slab_alloc+0x87/0x90

[ 1039.556758][    C1]  ? kmem_cache_alloc_noprof+0x166/0x4a0

[ 1039.556758][    C1]  ? security_inode_alloc+0x3e/0x2c0

[ 1039.556758][    C1]  ? inode_init_always_gfp+0xd15/0x1090

[ 1039.556758][    C1]  ? alloc_inode+0x8d/0x1f0

[ 1039.556758][    C1]  ? sock_alloc+0x40/0x270

[ 1039.556758][    C1]  ? __sock_create+0xc1/0x900

[ 1039.556758][    C1]  ? __sys_socket_create.part.0+0xc7/0x150

[ 1039.556758][    C1]  ? __sys_socket+0x6c/0x130

[ 1039.556758][    C1]  ? __x64_sys_socket+0x73/0xb0

[ 1039.556758][    C1]  ? do_syscall_64+0xcf/0x4d0

[ 1039.556758][    C1]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f

[ 1039.556758][    C1]  ? try_charge_memcg+0x3af/0xec0

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? __lock_acquire+0xad5/0x1ee0

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  kasan_save_track+0x14/0x30

[ 1039.556758][    C1]  __kasan_slab_alloc+0x87/0x90

[ 1039.556758][    C1]  kmem_cache_alloc_noprof+0x166/0x4a0

[ 1039.556758][    C1]  ? __pfx_map_id_range_down+0x10/0x10

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? security_inode_alloc+0x3e/0x2c0

[ 1039.556758][    C1]  security_inode_alloc+0x3e/0x2c0

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  inode_init_always_gfp+0xd15/0x1090

[ 1039.556758][    C1]  alloc_inode+0x8d/0x1f0

[ 1039.556758][    C1]  sock_alloc+0x40/0x270

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  __sock_create+0xc1/0x900

[ 1039.556758][    C1]  __sys_socket_create.part.0+0xc7/0x150

[ 1039.556758][    C1]  ? __pfx___sys_socket_create.part.0+0x10/0x10

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? write_comp_data+0x29/0x80

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  __sys_socket+0x6c/0x130

[ 1039.556758][    C1]  __x64_sys_socket+0x73/0xb0

[ 1039.556758][    C1]  ? lockdep_hardirqs_on+0x7c/0x110

[ 1039.556758][    C1]  do_syscall_64+0xcf/0x4d0

[ 1039.556758][    C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[ 1039.556758][    C1] RIP: 0033:0x7fa0ff3af6fb

[ 1039.556758][    C1] RSP: 002b:00007fffcaff6f68 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000029

[ 1039.556758][    C1] RAX: ffffffffffffffda RBX: 00007fffcaff7590 RCX: =
00007fa0ff3af6fb

[ 1039.556758][    C1] RDX: 0000000000000000 RSI: 0000000000080002 RDI: =
0000000000000001

[ 1039.556758][    C1] RBP: 00007fa0ff42bb19 R08: 0000000000008008 R09: =
00007fffcaff7716

[ 1039.556758][    C1] R10: 00007fa0ff42bb00 R11: 0000000000000246 R12: =
00007fffcaff6fc0

[ 1039.556758][    C1] R13: 00007fffcaff7040 R14: 00007fffcaff7040 R15: =
0000000000000040

[ 1039.556758][    C1]  </TASK>

[ 1039.556758][    C1] rcu: rcu_preempt kthread timer wakeup didn't =
happen for 8182 jiffies! g13333 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402

[ 1039.556758][    C1] rcu: 	Possible timer handling issue on cpu=3D0 =
timer-softirq=3D40149

[ 1039.556758][    C1] rcu: rcu_preempt kthread starved for 8183 =
jiffies! g13333 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0

[ 1039.556758][    C1] rcu: 	Unless rcu_preempt kthread gets =
sufficient CPU time, OOM is now expected behavior.

[ 1039.556758][    C1] rcu: RCU grace-period kthread stack dump:

[ 1039.556758][    C1] task:rcu_preempt     state:I stack:28552 pid:16   =
 tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000

[ 1039.556758][    C1] Call Trace:

[ 1039.556758][    C1]  <TASK>

[ 1039.556758][    C1]  __schedule+0x125f/0x53f0

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? write_comp_data+0x29/0x80

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? __pfx___schedule+0x10/0x10

[ 1039.556758][    C1]  ? _raw_spin_unlock_irqrestore+0x58/0x70

[ 1039.556758][    C1]  ? schedule+0x1e0/0x260

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  schedule+0xd4/0x260

[ 1039.556758][    C1]  schedule_timeout+0x11a/0x290

[ 1039.556758][    C1]  ? __pfx_schedule_timeout+0x10/0x10

[ 1039.556758][    C1]  ? __pfx_process_timeout+0x10/0x10

[ 1039.556758][    C1]  ? 0xffffffff81000000

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? _raw_spin_unlock_irqrestore+0x41/0x70

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? prepare_to_swait_event+0xb3/0x300

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  rcu_gp_fqs_loop+0x623/0xa30

[ 1039.556758][    C1]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? rcu_gp_kthread+0x2bc/0x360

[ 1039.556758][    C1]  ? _raw_spin_unlock_irqrestore+0x58/0x70

[ 1039.556758][    C1]  rcu_gp_kthread+0x257/0x360

[ 1039.556758][    C1]  ? __pfx_rcu_gp_kthread+0x10/0x10

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1039.556758][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1039.556758][    C1]  ? __kthread_parkme+0x1b2/0x260

[ 1039.556758][    C1]  ? __pfx_rcu_gp_kthread+0x10/0x10

[ 1039.556758][    C1]  kthread+0x447/0x8a0

[ 1039.556758][    C1]  ? __pfx_kthread+0x10/0x10

[ 1039.556758][    C1]  ? ret_from_fork+0x25/0x6e0

[ 1039.556758][    C1]  ? _raw_spin_unlock_irq+0x23/0x50

[ 1039.556758][    C1]  ? __pfx_kthread+0x10/0x10

[ 1039.556758][    C1]  ret_from_fork+0x45e/0x6e0

[ 1039.556758][    C1]  ? __pfx_kthread+0x10/0x10

[ 1039.556758][    C1]  ret_from_fork_asm+0x1a/0x30

[ 1039.556758][    C1]  </TASK>

[ 1080.070183][    C3] watchdog: BUG: soft lockup - CPU#3 stuck for =
113s! [systemd-udevd:10219]

[ 1080.070228][    C3] Modules linked in:

[ 1080.070248][    C3] irq event stamp: 204328

[ 1080.070264][    C3] hardirqs last  enabled at (204327): =
[<ffffffff8b79905b>] irqentry_exit+0x3b/0x90

[ 1080.070336][    C3] hardirqs last disabled at (204328): =
[<ffffffff8b79779f>] sysvec_apic_timer_interrupt+0xf/0xc0

[ 1080.070401][    C3] softirqs last  enabled at (204326): =
[<ffffffff817c85c1>] handle_softirqs+0x551/0x850

[ 1080.070491][    C3] softirqs last disabled at (204311): =
[<ffffffff817ca24d>] irq_exit_rcu+0xfd/0x150

[ 1080.070552][    C3] CPU: 3 UID: 0 PID: 10219 Comm: systemd-udevd Not =
tainted 6.16.0-rc4 #1 PREEMPT(full)=20

[ 1080.070611][    C3] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014

[ 1080.070641][    C3] RIP: =
0010:smp_call_function_many_cond+0x5db/0x1b00

[ 1080.070723][    C3] Code: e6 e8 e9 3b 0c 00 45 85 e4 74 48 48 8b 04 =
24 49 89 c5 83 e0 07 49 c1 ed 03 49 89 c4 4d 01 f5 41 83 c4 03 e8 b7 39 =
0c 00 f3 90 <41> 0f b6 45 00 41 38 c4 7c 08 84 c0 0f 85 df 11 00 00 8b =
45 08 31

[ 1080.070772][    C3] RSP: 0018:ffa00000116c7340 EFLAGS: 00000246

[ 1080.070808][    C3] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
ffffffff81afa4ff

[ 1080.070839][    C3] RDX: 0000000000000001 RSI: ff110000700b2480 RDI: =
0000000000000002

[ 1080.070870][    C3] RBP: ff1100002b6420a0 R08: 0000000000000000 R09: =
0000000000000001

[ 1080.070900][    C3] R10: fffffbfff210a8ea R11: ffffffff90854757 R12: =
0000000000000003

[ 1080.070932][    C3] R13: ffe21c00056c8415 R14: dffffc0000000000 R15: =
0000000000000001

[ 1080.070986][    C3] FS:  00007f23a2d608c0(0000) =
GS:ff110000ea610000(0000) knlGS:0000000000000000

[ 1080.071040][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[ 1080.071074][    C3] CR2: 0000564811800e80 CR3: 000000006ea54000 CR4: =
0000000000751ef0

[ 1080.071106][    C3] PKRU: 55555554

[ 1080.071122][    C3] Call Trace:

[ 1080.071137][    C3]  <TASK>

[ 1080.071161][    C3]  ? __pfx_flush_tlb_func+0x10/0x10

[ 1080.071256][    C3]  ? __pfx_smp_call_function_many_cond+0x10/0x10

[ 1080.071329][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.071392][    C3]  ? __lock_acquire+0xad5/0x1ee0

[ 1080.071462][    C3]  ? __pfx_flush_tlb_func+0x10/0x10

[ 1080.071549][    C3]  on_each_cpu_cond_mask+0x5a/0xa0

[ 1080.071620][    C3]  kvm_flush_tlb_multi+0x22f/0x380

[ 1080.071696][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.071775][    C3]  ? __pfx_kvm_flush_tlb_multi+0x10/0x10

[ 1080.071856][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.071919][    C3]  ? get_flush_tlb_info+0x1a0/0x2c0

[ 1080.072008][    C3]  flush_tlb_mm_range+0x420/0x1760

[ 1080.072054][    C3]  ? __pte_offset_map_lock+0x18f/0x330

[ 1080.072142][    C3]  ? __pfx___pte_offset_map_lock+0x10/0x10

[ 1080.072222][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.072291][    C3]  flush_tlb_batched_pending+0x93/0xd0

[ 1080.072353][    C3]  unmap_page_range+0xbe1/0x43a0

[ 1080.072446][    C3]  ? write_comp_data+0x29/0x80

[ 1080.072524][    C3]  ? __pfx_unmap_page_range+0x10/0x10

[ 1080.072609][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.072701][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.072771][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.072827][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.072897][    C3]  unmap_single_vma.constprop.0+0x153/0x230

[ 1080.072992][    C3]  unmap_vmas+0x1e2/0x440

[ 1080.073077][    C3]  ? __pfx_unmap_vmas+0x10/0x10

[ 1080.073156][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.073218][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.073274][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.073346][    C3]  ? __lock_acquire+0xad5/0x1ee0

[ 1080.073420][    C3]  ? mas_wr_walk+0xa27/0x1190

[ 1080.073469][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.073531][    C3]  ? write_comp_data+0x29/0x80

[ 1080.073583][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.073653][    C3]  vms_clear_ptes.part.0+0x36f/0x6a0

[ 1080.073735][    C3]  ? __pfx_vms_clear_ptes.part.0+0x10/0x10

[ 1080.073799][    C3]  ? vms_complete_munmap_vmas+0x7df/0xa90

[ 1080.073874][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.073936][    C3]  ? downgrade_write+0x147/0x3d0

[ 1080.074014][    C3]  ? __pfx_downgrade_write+0x10/0x10

[ 1080.074096][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.074167][    C3]  vms_complete_munmap_vmas+0x71b/0xa90

[ 1080.074236][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.074298][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.074354][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.074416][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.074485][    C3]  do_vmi_align_munmap+0x439/0x810

[ 1080.074559][    C3]  ? __pfx_do_vmi_align_munmap+0x10/0x10

[ 1080.074636][    C3]  ? __lock_acquire+0xad5/0x1ee0

[ 1080.074752][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.074814][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.074876][    C3]  do_vmi_munmap+0x1f3/0x3e0

[ 1080.074947][    C3]  __vm_munmap+0x199/0x390

[ 1080.075020][    C3]  ? __pfx___vm_munmap+0x10/0x10

[ 1080.075111][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.075173][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.075229][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.075291][    C3]  ? __secure_computing+0x254/0x390

[ 1080.075380][    C3]  __x64_sys_munmap+0x59/0x80

[ 1080.075427][    C3]  do_syscall_64+0xcf/0x4d0

[ 1080.075494][    C3]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[ 1080.075545][    C3] RIP: 0033:0x7f23a2e8a207

[ 1080.075582][    C3] Code: 38 eb 85 48 8b 15 89 8c 0d 00 f7 d8 64 89 =
02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 8c 0d 00 f7 d8 64 =
89 01 48

[ 1080.075630][    C3] RSP: 002b:00007ffed7737718 EFLAGS: 00000206 =
ORIG_RAX: 000000000000000b

[ 1080.075673][    C3] RAX: ffffffffffffffda RBX: 00005647e5fa3238 RCX: =
00007f23a2e8a207

[ 1080.075717][    C3] RDX: 00000000ffffffff RSI: 0000000000a38e0a RDI: =
00007f23a1400000

[ 1080.075749][    C3] RBP: 0000564811800e80 R08: 504284132a0169ca R09: =
3c9f09c8db351db1

[ 1080.075782][    C3] R10: 765f3e089b2c68fd R11: 0000000000000206 R12: =
0000564811847f30

[ 1080.075814][    C3] R13: 00005648118afd70 R14: 00007ffed77377f0 R15: =
0000564811848210

[ 1080.075870][    C3]  </TASK>

[ 1080.075887][    C3] Sending NMI from CPU 3 to CPUs 0-2:

[ 1080.246268][    C1] NMI backtrace for cpu 1

[ 1080.246302][    C1] CPU: 1 UID: 0 PID: 10025 Comm: kworker/u18:2 Not =
tainted 6.16.0-rc4 #1 PREEMPT(full)=20

[ 1080.246363][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014

[ 1080.246397][    C1] Workqueue: events_unbound toggle_allocation_gate

[ 1080.246480][    C1] RIP: =
0010:smp_call_function_many_cond+0x5db/0x1b00

[ 1080.246555][    C1] Code: e6 e8 e9 3b 0c 00 45 85 e4 74 48 48 8b 04 =
24 49 89 c5 83 e0 07 49 c1 ed 03 49 89 c4 4d 01 f5 41 83 c4 03 e8 b7 39 =
0c 00 f3 90 <41> 0f b6 45 00 41 38 c4 7c 08 84 c0 0f 85 df 11 00 00 8b =
45 08 31

[ 1080.246604][    C1] RSP: 0018:ffa000001262f8c8 EFLAGS: 00000246

[ 1080.246640][    C1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
ffffffff81afa4ff

[ 1080.246672][    C1] RDX: 0000000000000001 RSI: ff11000049582480 RDI: =
0000000000000002

[ 1080.246703][    C1] RBP: ff1100002b642060 R08: 0000000000000000 R09: =
0000000000000001

[ 1080.246749][    C1] R10: fffffbfff210a8ea R11: ffffffff90854757 R12: =
0000000000000003

[ 1080.246749][    C1] R13: ffe21c00056c840d R14: dffffc0000000000 R15: =
0000000000000001

[ 1080.246749][    C1] FS:  0000000000000000(0000) =
GS:ff110000ea510000(0000) knlGS:0000000000000000

[ 1080.246749][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[ 1080.246749][    C1] CR2: 00005648117ffc20 CR3: 000000000e180000 CR4: =
0000000000751ef0

[ 1080.246749][    C1] PKRU: 55555554

[ 1080.246749][    C1] Call Trace:

[ 1080.246749][    C1]  <TASK>

[ 1080.246749][    C1]  ? __pfx_do_sync_core+0x10/0x10

[ 1080.246749][    C1]  ? __pfx_smp_call_function_many_cond+0x10/0x10

[ 1080.246749][    C1]  ? __pfx___text_poke+0x10/0x10

[ 1080.246749][    C1]  ? __pfx_do_sync_core+0x10/0x10

[ 1080.246749][    C1]  on_each_cpu_cond_mask+0x5a/0xa0

[ 1080.246749][    C1]  ? kmem_cache_alloc_bulk_noprof+0x187/0xc00

[ 1080.246749][    C1]  smp_text_poke_batch_finish+0x27b/0xcd0

[ 1080.246749][    C1]  ? __pfx_smp_text_poke_batch_finish+0x10/0x10

[ 1080.246749][    C1]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? write_comp_data+0x29/0x80

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  arch_jump_label_transform_apply+0x1c/0x30

[ 1080.246749][    C1]  jump_label_update+0x379/0x550

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  static_key_enable_cpuslocked+0x1b7/0x270

[ 1080.246749][    C1]  static_key_enable+0x1a/0x20

[ 1080.246749][    C1]  toggle_allocation_gate+0xfe/0x250

[ 1080.246749][    C1]  ? __pfx_toggle_allocation_gate+0x10/0x10

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? _raw_spin_unlock_irq+0x23/0x50

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? write_comp_data+0x29/0x80

[ 1080.246749][    C1]  process_scheduled_works+0x5de/0x1be0

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? __pfx_process_scheduled_works+0x10/0x10

[ 1080.246749][    C1]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? assign_work+0x195/0x240

[ 1080.246749][    C1]  worker_thread+0x5a9/0xd10

[ 1080.246749][    C1]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246749][    C1]  ? __pfx_worker_thread+0x10/0x10

[ 1080.246749][    C1]  kthread+0x447/0x8a0

[ 1080.246749][    C1]  ? __pfx_kthread+0x10/0x10

[ 1080.246749][    C1]  ? ret_from_fork+0x25/0x6e0

[ 1080.246749][    C1]  ? _raw_spin_unlock_irq+0x23/0x50

[ 1080.246749][    C1]  ? __pfx_kthread+0x10/0x10

[ 1080.246749][    C1]  ret_from_fork+0x45e/0x6e0

[ 1080.246749][    C1]  ? __pfx_kthread+0x10/0x10

[ 1080.246749][    C1]  ret_from_fork_asm+0x1a/0x30

[ 1080.246749][    C1]  </TASK>

[ 1080.246741][    C2] NMI backtrace for cpu 2

[ 1080.246741][    C2] CPU: 2 UID: 0 PID: 10838 Comm: syz-executor Not =
tainted 6.16.0-rc4 #1 PREEMPT(full)=20

[ 1080.246741][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014

[ 1080.246741][    C2] RIP: 0010:write_comp_data+0x29/0x80

[ 1080.246741][    C2] Code: 90 41 56 41 55 49 89 fd bf 03 00 00 00 41 =
54 49 89 f4 55 48 89 d5 53 48 89 cb 65 4c 8b 35 07 21 f5 11 4c 89 f6 e8 =
d7 fe ff ff <84> c0 74 45 49 8b 86 28 16 00 00 41 8b b6 24 16 00 00 48 =
8b 08 48

[ 1080.246741][    C2] RSP: 0018:ffa0000002d27678 EFLAGS: 00000293

[ 1080.246741][    C2] RAX: 0000000000000000 RBX: ffffffff81afa4ff RCX: =
ffffffff81afa4ff

[ 1080.246741][    C2] RDX: 0000000000000001 RSI: ff1100001eae2480 RDI: =
0000000000000003

[ 1080.246741][    C2] RBP: 0000000000000001 R08: 0000000000000000 R09: =
0000000000000001

[ 1080.246741][    C2] R10: fffffbfff210a8ea R11: ffffffff90854757 R12: =
0000000000000000

[ 1080.246741][    C2] R13: 0000000000000005 R14: ff1100001eae2480 R15: =
0000000000000001

[ 1080.246741][    C2] FS:  0000000000000000(0000) =
GS:ff11000097c10000(0000) knlGS:0000000000000000

[ 1080.246741][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[ 1080.246741][    C2] CR2: 000000c0006bff80 CR3: 000000000e180000 CR4: =
0000000000751ef0

[ 1080.246741][    C2] PKRU: 00000000

[ 1080.246741][    C2] Call Trace:

[ 1080.246741][    C2]  <TASK>

[ 1080.246741][    C2]  smp_call_function_many_cond+0x5ff/0x1b00

[ 1080.246741][    C2]  ? __pfx_flush_tlb_func+0x10/0x10

[ 1080.246741][    C2]  ? __pfx_smp_call_function_many_cond+0x10/0x10

[ 1080.246741][    C2]  ? tlb_remove_table+0xdf/0x620

[ 1080.246741][    C2]  ? __phys_addr+0xeb/0x180

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? write_comp_data+0x29/0x80

[ 1080.246741][    C2]  ? __pfx_flush_tlb_func+0x10/0x10

[ 1080.246741][    C2]  on_each_cpu_cond_mask+0x5a/0xa0

[ 1080.246741][    C2]  kvm_flush_tlb_multi+0x22f/0x380

[ 1080.246741][    C2]  ? __pfx_kvm_flush_tlb_multi+0x10/0x10

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? get_flush_tlb_info+0x1a0/0x2c0

[ 1080.246741][    C2]  flush_tlb_mm_range+0x420/0x1760

[ 1080.246741][    C2]  ? __pfx_free_pgtables+0x10/0x10

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  tlb_flush_mmu+0x45e/0x750

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  tlb_finish_mmu+0x97/0x3f0

[ 1080.246741][    C2]  exit_mmap+0x426/0xbe0

[ 1080.246741][    C2]  ? __pfx_exit_mmap+0x10/0x10

[ 1080.246741][    C2]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.246741][    C2]  mmput+0x178/0x450

[ 1080.246741][    C2]  do_exit+0x838/0x2ef0

[ 1080.246741][    C2]  ? __free_object+0x276/0x470

[ 1080.246741][    C2]  ? __pfx_do_exit+0x10/0x10

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? find_held_lock+0x2b/0x80

[ 1080.246741][    C2]  ? get_signal+0x9c1/0x2760

[ 1080.246741][    C2]  do_group_exit+0xd3/0x2a0

[ 1080.246741][    C2]  get_signal+0x2509/0x2760

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? __pfx_get_signal+0x10/0x10

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  arch_do_signal_or_restart+0x80/0x8c0

[ 1080.246741][    C2]  ? __pfx_arch_do_signal_or_restart+0x10/0x10

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? common_nsleep+0xaa/0xd0

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  ? __x64_sys_clock_nanosleep+0x34c/0x490

[ 1080.246741][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.246741][    C2]  exit_to_user_mode_loop+0xa0/0x130

[ 1080.246741][    C2]  do_syscall_64+0x3fb/0x4d0

[ 1080.246741][    C2]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[ 1080.246741][    C2] RIP: 0033:0x7f88893deebf

[ 1080.246741][    C2] Code: Unable to access opcode bytes at =
0x7f88893dee95.

[ 1080.246741][    C2] RSP: 002b:00007ffc1a1b8310 EFLAGS: 00000293 =
ORIG_RAX: 00000000000000e6

[ 1080.246741][    C2] RAX: fffffffffffffdfc RBX: 0000000000000001 RCX: =
00007f88893deebf

[ 1080.246741][    C2] RDX: 00007ffc1a1b8390 RSI: 0000000000000000 RDI: =
0000000000000000

[ 1080.246741][    C2] RBP: 0000000000000000 R08: 0000000000000000 R09: =
000000000001f4e6

[ 1080.246741][    C2] R10: 0000000000000000 R11: 0000000000000293 R12: =
00007ffc1a1b8390

[ 1080.246741][    C2] R13: 0000000000000000 R14: 0000000000000003 R15: =
00007ffc1a1b8450

[ 1080.246741][    C2]  </TASK>

[ 1063.835131][    C0] NMI backtrace for cpu 0

[ 1063.835131][    C0] CPU: 0 UID: 0 PID: 10851 Comm: systemd-udevd Not =
tainted 6.16.0-rc4 #1 PREEMPT(full)=20

[ 1063.835131][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014

[ 1063.835131][    C0] RIP: 0010:__kasan_check_byte+0x17/0x50

[ 1063.835131][    C0] Code: 00 66 90 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 66 0f 1f 00 41 55 49 89 f5 41 54 55 48 89 fd e8 3c 24 00 =
00 41 89 c4 <84> c0 74 0d 44 89 e0 5d 41 5c 41 5d e9 03 e9 ec fe 4c 89 =
e9 48 89

[ 1063.835131][    C0] RSP: 0018:ffa0000000007ce0 EFLAGS: 00000097

[ 1063.835131][    C0] RAX: 0000000000000001 RBX: 0000000000000000 RCX: =
0000000000000002

[ 1063.835131][    C0] RDX: 0000000000000000 RSI: ffffffff89857f11 RDI: =
fffffbfff1c78260

[ 1063.835131][    C0] RBP: ffffffff8e3c1300 R08: 0000000000000000 R09: =
0000000000000000

[ 1063.835131][    C0] R10: ffe21c000aabda5d R11: ff110000555ed2eb R12: =
0000000000000001

[ 1063.835131][    C0] R13: ffffffff89857f11 R14: 0000000000000000 R15: =
0000000000000000

[ 1063.835131][    C0] FS:  0000000000000000(0000) =
GS:ff11000097b10000(0000) knlGS:0000000000000000

[ 1063.835131][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[ 1063.835131][    C0] CR2: 0000564811822118 CR3: 000000006e6ec000 CR4: =
0000000000751ef0

[ 1063.835131][    C0] PKRU: 55555554

[ 1063.835131][    C0] Call Trace:

[ 1063.835131][    C0]  <IRQ>

[ 1063.835131][    C0]  lock_acquire+0xfd/0x340

[ 1063.835131][    C0]  ? advance_sched+0x683/0xd30

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  advance_sched+0x6f1/0xd30

[ 1063.835131][    C0]  ? advance_sched+0x6e0/0xd30

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? __pfx_advance_sched+0x10/0x10

[ 1063.835131][    C0]  __hrtimer_run_queues+0x1af/0xc60

[ 1063.835131][    C0]  ? __pfx___hrtimer_run_queues+0x10/0x10

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  hrtimer_interrupt+0x39a/0x880

[ 1063.835131][    C0]  __sysvec_apic_timer_interrupt+0x10d/0x400

[ 1063.835131][    C0]  sysvec_apic_timer_interrupt+0xa3/0xc0

[ 1063.835131][    C0]  </IRQ>

[ 1063.835131][    C0]  <TASK>

[ 1063.835131][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[ 1063.835131][    C0] RIP: 0010:write_comp_data+0x73/0x80

[ 1063.835131][    C0] Code: 00 48 8d 14 fd 28 00 00 00 48 39 d6 72 1b =
48 83 c1 01 48 89 08 4c 89 6c 10 e0 4c 89 64 10 e8 48 89 6c 10 f0 48 89 =
5c f8 20 5b <5d> 41 5c 41 5d 41 5e e9 9c 61 54 ff 90 90 90 90 90 90 90 =
90 90 90

[ 1063.835131][    C0] RSP: 0018:ffa0000008b8f780 EFLAGS: 00000246

[ 1063.835131][    C0] RAX: 0000000000000000 RBX: 0000000000056062 RCX: =
ffffffff8207f3d3

[ 1063.835131][    C0] RDX: 0000000000056062 RSI: ff110000222fa480 RDI: =
0000000000000003

[ 1063.835131][    C0] RBP: 0000000000056062 R08: 0000000000000000 R09: =
fffa7c000009d4a7

[ 1063.835131][    C0] R10: fffa7c000009d4a6 R11: ffd40000004ea533 R12: =
000000000007ffdf

[ 1063.835131][    C0] R13: 0000000000000006 R14: ff110000222fa480 R15: =
0000000000000000

[ 1063.835131][    C0]  ? vm_normal_page+0xf3/0x310

[ 1063.835131][    C0]  vm_normal_page+0xf3/0x310

[ 1063.835131][    C0]  ? __pfx_vm_normal_page+0x10/0x10

[ 1063.835131][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? =
__tlb_remove_folio_pages_size.constprop.0+0x171/0x560

[ 1063.835131][    C0]  ? check_kcov_mode+0x10/0x50

[ 1063.835131][    C0]  unmap_page_range+0xda6/0x43a0

[ 1063.835131][    C0]  ? __pfx_unmap_page_range+0x10/0x10

[ 1063.835131][    C0]  ? write_comp_data+0x29/0x80

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? mas_next_slot+0xb2a/0x11e0

[ 1063.835131][    C0]  unmap_single_vma.constprop.0+0x153/0x230

[ 1063.835131][    C0]  unmap_vmas+0x1e2/0x440

[ 1063.835131][    C0]  ? __pfx_unmap_vmas+0x10/0x10

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? write_comp_data+0x29/0x80

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? mas_next_slot+0xb2a/0x11e0

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? write_comp_data+0x29/0x80

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  exit_mmap+0x1b3/0xbe0

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? __pfx_exit_mmap+0x10/0x10

[ 1063.835131][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1063.835131][    C0]  mmput+0x178/0x450

[ 1063.835131][    C0]  do_exit+0x838/0x2ef0

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? zap_other_threads+0x26a/0x310

[ 1063.835131][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1063.835131][    C0]  ? __pfx_do_exit+0x10/0x10

[ 1063.835131][    C0]  ? do_group_exit+0x1c3/0x2a0

[ 1063.835131][    C0]  ? _raw_spin_unlock_irq+0x23/0x50

[ 1063.835131][    C0]  do_group_exit+0xd3/0x2a0

[ 1063.835131][    C0]  __x64_sys_exit_group+0x3e/0x50

[ 1063.835131][    C0]  x64_sys_call+0xf76/0x18a0

[ 1063.835131][    C0]  do_syscall_64+0xcf/0x4d0

[ 1063.835131][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[ 1063.835131][    C0] RIP: 0033:0x7f23a2e5cc79

[ 1063.835131][    C0] Code: Unable to access opcode bytes at =
0x7f23a2e5cc4f.

[ 1063.835131][    C0] RSP: 002b:00007ffed7737758 EFLAGS: 00000202 =
ORIG_RAX: 00000000000000e7

[ 1063.835131][    C0] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007f23a2e5cc79

[ 1063.835131][    C0] RDX: 000000000000003c RSI: 00000000000000e7 RDI: =
0000000000000000

[ 1063.835131][    C0] RBP: 0000564810fc2cf0 R08: fffffffffffffe00 R09: =
0000000000000000

[ 1063.835131][    C0] R10: 0000000000000008 R11: 0000000000000202 R12: =
0000564811843410

[ 1063.835131][    C0] R13: 00005648118afc20 R14: 00007ffed77377d0 R15: =
0000564811827170

[ 1063.835131][    C0]  </TASK>

[ 1080.076740][    C3] Kernel panic - not syncing: softlockup: hung =
tasks

[ 1080.076740][    C3] CPU: 3 UID: 0 PID: 10219 Comm: systemd-udevd =
Tainted: G             L      6.16.0-rc4 #1 PREEMPT(full)=20

[ 1080.076740][    C3] Tainted: [L]=3DSOFTLOCKUP

[ 1080.076740][    C3] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014

[ 1080.076740][    C3] Call Trace:

[ 1080.076740][    C3]  <IRQ>

[ 1080.076740][    C3]  dump_stack_lvl+0x3d/0x1b0

[ 1080.076740][    C3]  panic+0x70a/0x7c0

[ 1080.076740][    C3]  ? __pfx_panic+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? write_comp_data+0x29/0x80

[ 1080.076740][    C3]  ? write_comp_data+0x29/0x80

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? write_comp_data+0x29/0x80

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? write_comp_data+0x29/0x80

[ 1080.076740][    C3]  ? write_comp_data+0x29/0x80

[ 1080.076740][    C3]  ? watchdog_timer_fn+0x5e3/0x780

[ 1080.076740][    C3]  watchdog_timer_fn+0x601/0x780

[ 1080.076740][    C3]  ? __pfx_watchdog_timer_fn+0x10/0x10

[ 1080.076740][    C3]  __hrtimer_run_queues+0x5f3/0xc60

[ 1080.076740][    C3]  ? __pfx___hrtimer_run_queues+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  hrtimer_interrupt+0x39a/0x880

[ 1080.076740][    C3]  __sysvec_apic_timer_interrupt+0x10d/0x400

[ 1080.076740][    C3]  sysvec_apic_timer_interrupt+0xa3/0xc0

[ 1080.076740][    C3]  </IRQ>

[ 1080.076740][    C3]  <TASK>

[ 1080.076740][    C3]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[ 1080.076740][    C3] RIP: =
0010:smp_call_function_many_cond+0x5db/0x1b00

[ 1080.076740][    C3] Code: e6 e8 e9 3b 0c 00 45 85 e4 74 48 48 8b 04 =
24 49 89 c5 83 e0 07 49 c1 ed 03 49 89 c4 4d 01 f5 41 83 c4 03 e8 b7 39 =
0c 00 f3 90 <41> 0f b6 45 00 41 38 c4 7c 08 84 c0 0f 85 df 11 00 00 8b =
45 08 31

[ 1080.076740][    C3] RSP: 0018:ffa00000116c7340 EFLAGS: 00000246

[ 1080.076740][    C3] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
ffffffff81afa4ff

[ 1080.076740][    C3] RDX: 0000000000000001 RSI: ff110000700b2480 RDI: =
0000000000000002

[ 1080.076740][    C3] RBP: ff1100002b6420a0 R08: 0000000000000000 R09: =
0000000000000001

[ 1080.076740][    C3] R10: fffffbfff210a8ea R11: ffffffff90854757 R12: =
0000000000000003

[ 1080.076740][    C3] R13: ffe21c00056c8415 R14: dffffc0000000000 R15: =
0000000000000001

[ 1080.076740][    C3]  ? smp_call_function_many_cond+0x5ff/0x1b00

[ 1080.076740][    C3]  ? __pfx_flush_tlb_func+0x10/0x10

[ 1080.076740][    C3]  ? __pfx_smp_call_function_many_cond+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __lock_acquire+0xad5/0x1ee0

[ 1080.076740][    C3]  ? __pfx_flush_tlb_func+0x10/0x10

[ 1080.076740][    C3]  on_each_cpu_cond_mask+0x5a/0xa0

[ 1080.076740][    C3]  kvm_flush_tlb_multi+0x22f/0x380

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __pfx_kvm_flush_tlb_multi+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? get_flush_tlb_info+0x1a0/0x2c0

[ 1080.076740][    C3]  flush_tlb_mm_range+0x420/0x1760

[ 1080.076740][    C3]  ? __pte_offset_map_lock+0x18f/0x330

[ 1080.076740][    C3]  ? __pfx___pte_offset_map_lock+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  flush_tlb_batched_pending+0x93/0xd0

[ 1080.076740][    C3]  unmap_page_range+0xbe1/0x43a0

[ 1080.076740][    C3]  ? write_comp_data+0x29/0x80

[ 1080.076740][    C3]  ? __pfx_unmap_page_range+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  unmap_single_vma.constprop.0+0x153/0x230

[ 1080.076740][    C3]  unmap_vmas+0x1e2/0x440

[ 1080.076740][    C3]  ? __pfx_unmap_vmas+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __lock_acquire+0xad5/0x1ee0

[ 1080.076740][    C3]  ? mas_wr_walk+0xa27/0x1190

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? write_comp_data+0x29/0x80

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  vms_clear_ptes.part.0+0x36f/0x6a0

[ 1080.076740][    C3]  ? __pfx_vms_clear_ptes.part.0+0x10/0x10

[ 1080.076740][    C3]  ? vms_complete_munmap_vmas+0x7df/0xa90

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? downgrade_write+0x147/0x3d0

[ 1080.076740][    C3]  ? __pfx_downgrade_write+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  vms_complete_munmap_vmas+0x71b/0xa90

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  do_vmi_align_munmap+0x439/0x810

[ 1080.076740][    C3]  ? __pfx_do_vmi_align_munmap+0x10/0x10

[ 1080.076740][    C3]  ? __lock_acquire+0xad5/0x1ee0

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.076740][    C3]  do_vmi_munmap+0x1f3/0x3e0

[ 1080.076740][    C3]  __vm_munmap+0x199/0x390

[ 1080.076740][    C3]  ? __pfx___vm_munmap+0x10/0x10

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __sanitizer_cov_trace_pc+0x20/0x50

[ 1080.076740][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1080.076740][    C3]  ? __secure_computing+0x254/0x390

[ 1080.076740][    C3]  __x64_sys_munmap+0x59/0x80

[ 1080.076740][    C3]  do_syscall_64+0xcf/0x4d0

[ 1080.076740][    C3]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[ 1080.076740][    C3] RIP: 0033:0x7f23a2e8a207

[ 1080.076740][    C3] Code: 38 eb 85 48 8b 15 89 8c 0d 00 f7 d8 64 89 =
02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 8c 0d 00 f7 d8 64 =
89 01 48

[ 1080.076740][    C3] RSP: 002b:00007ffed7737718 EFLAGS: 00000206 =
ORIG_RAX: 000000000000000b

[ 1080.076740][    C3] RAX: ffffffffffffffda RBX: 00005647e5fa3238 RCX: =
00007f23a2e8a207

[ 1080.076740][    C3] RDX: 00000000ffffffff RSI: 0000000000a38e0a RDI: =
00007f23a1400000

[ 1080.076740][    C3] RBP: 0000564811800e80 R08: 504284132a0169ca R09: =
3c9f09c8db351db1

[ 1080.076740][    C3] R10: 765f3e089b2c68fd R11: 0000000000000206 R12: =
0000564811847f30

[ 1080.076740][    C3] R13: 00005648118afd70 R14: 00007ffed77377f0 R15: =
0000564811848210

[ 1080.076740][    C3]  </TASK>

[ 1080.076740][    C3] Shutting down cpus with NMI

[ 1080.076740][    C3] Dumping ftrace buffer:

[ 1080.076740][    C3] ---------------------------------

[ 1080.076740][    C3]   <idle>-0         0d.h1. 15048us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 15225us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 15261us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 15284us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 31174us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 31376us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 32558us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 32728us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 41276us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 41447us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 42378us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 42548us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 45461us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 45632us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 46736us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 46921us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 47735us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 47894us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 52501us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 52687us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 54734us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 54917us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56531us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56704us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 62221us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 62395us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 63375us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 63545us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 64320us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 64491us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 65927us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66102us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66981us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 67168us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 68114us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 68277us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 69077us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 69238us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 69870us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 70044us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 71551us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 71715us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 72360us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 72524us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 73643us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 73807us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 74750us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 74926us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 75619us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 75786us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77256us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77422us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 78110us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 78279us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 79774us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 79950us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80594us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80762us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82142us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82971us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 83160us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 84135us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 84305us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 85223us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 85393us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3dNH2. 86112us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3dNH2. 86292us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 87340us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 87518us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 88272us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 88448us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 89770us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 89951us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 90562us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 90737us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92036us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92209us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92808us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92989us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 97725us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 97911us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98794us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98985us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 99573us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 99757us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 102283us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 102464us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 103571us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 103752us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 104423us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 104604us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 105314us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 105494us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 106194us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 106375us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 107112us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 107317us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 108215us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 108398us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 108959us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 109142us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 109808us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 110004us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 110679us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 110862us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 111593us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 111779us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 112459us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 112645us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 113326us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 113512us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 114192us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 114379us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 115065us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 115266us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 115855us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116068us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116923us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 117131us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 118073us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 118203us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 119636us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 119828us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 120402us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 120530us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 129827us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 130042us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 130374us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 130504us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 131338us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 131531us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 131835us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 131969us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 141207us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 141403us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 142692us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 142887us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 143493us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 143689us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 144212us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 144408us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 147452us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 147658us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 149259us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 149457us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7254350us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7254598us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7256313us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7256528us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7257390us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7257580us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7262144us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7262344us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7264319us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7264507us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7265468us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7265656us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7269734us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7269941us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7271249us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7271396us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7272830us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7272983us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7274033us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7274174us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7275529us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7275672us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7279779us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7279943us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7281721us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7281873us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7282579us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7282722us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7283594us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7283737us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7287954us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7288136us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7289627us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7289777us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7290965us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7291128us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7293389us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7293538us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7294286us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7294433us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7299501us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7299651us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7300734us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7300893us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7301971us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7302122us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7303384us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7303534us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7304826us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7304984us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 7306363us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 7306516us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7309550us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7309703us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7310969us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7311144us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7312458us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7312612us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7313901us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7314055us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7315434us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7315590us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7316950us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7317109us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7318423us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7318580us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7319829us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7320000us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7322542us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7322703us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7327070us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7327260us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7328904us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7329064us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7329970us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7330128us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7331026us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7331201us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7331896us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7332055us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7335977us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7336164us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7337924us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7338087us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7338867us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7339051us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h2. 7340001us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h2. 7340164us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7340845us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7341017us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7344503us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7344667us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7345579us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7345744us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7352086us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7352253us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7355537us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7355704us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7359929us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7360095us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7360962us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7361128us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7362282us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7362449us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7363596us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7363764us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7365071us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7365240us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7366745us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7366924us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7368254us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7368424us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7369775us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7369954us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7371271us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7371442us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7372749us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7372928us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7374205us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7374378us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7375743us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7375928us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7377281us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7377455us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7378772us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7378950us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7380290us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7380469us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7381863us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7382038us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7383337us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7383512us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7384845us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7385028us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H2. 7386384us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H2. 7386565us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7388070us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7388248us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7389573us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7389750us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7391040us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7391246us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7398777us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7398970us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7400669us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7400860us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7401725us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7401922us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7403325us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7403506us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7404244us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7404425us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7409266us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7409450us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7410154us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7410336us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7411263us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7411475us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7412361us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7412570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7418736us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7418935us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7419685us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7419881us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7420731us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7420935us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7421838us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7422037us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7426921us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7427125us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7428701us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7428841us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7429495us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7429634us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7430461us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7430601us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7431588us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7431729us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7432810us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7432961us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7438614us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7438756us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7439438us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7439581us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7440332us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7440475us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7445812us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7445976us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7446836us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7446987us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7447829us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7447988us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7448700us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7448845us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7455451us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7455599us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 7456316us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 7456464us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7464418us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7464567us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7470466us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7470617us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7471294us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7471442us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7472257us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7472407us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7478846us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7479008us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7479707us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7479866us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7480699us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7480859us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7481832us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7481992us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7483112us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7483265us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7484545us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7484700us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7486048us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7486208us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7487612us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7487767us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7489088us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7489243us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7490513us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7490669us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7492285us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7492441us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7493720us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7493886us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7495197us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7495356us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7496730us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7496898us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7498182us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7498342us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7499950us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7500111us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7501331us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7501491us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7508927us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7509092us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7509709us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7509877us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 7516118us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 7516286us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7518998us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7519183us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7520023us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7520186us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7521137us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7521301us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7522260us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7522423us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h2. 7529106us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h2. 7529274us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7529974us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7530141us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7536794us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7536971us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7537629us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7537795us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7538628us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7538796us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7539700us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7539880us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h2. 7548365us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h2. 7548536us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7549199us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7549369us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7550247us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7550417us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7551397us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7551568us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7552676us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7552846us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7554148us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7554320us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7555683us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7555869us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7558115us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7558289us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7559654us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7559828us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7561129us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7561304us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7562659us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7562834us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7563919us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7564094us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7572023us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7572202us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7572907us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7573085us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7580149us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7580334us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7581033us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7581210us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7582079us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7582258us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7583073us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7583274us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7590077us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7590260us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7590946us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7591145us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7592012us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7592192us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7593199us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7593379us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7594487us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7594668us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H.. 7596037us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H.. 7596225us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7598378us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7598561us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7599880us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7600063us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7601389us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7601574us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7609407us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7609593us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7610292us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7610480us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7611319us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7611505us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7612494us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7612632us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7620288us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7620429us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7621051us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7621190us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7628489us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7628632us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7629277us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7629417us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7630275us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7630416us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7631243us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7631385us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7641598us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7641743us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7642385us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7642527us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7643365us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7643508us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7644483us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7644628us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7645714us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7645866us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7647364us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7647511us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7648825us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7648984us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7657155us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7657303us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7657934us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7658081us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h2. 7665561us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h2. 7665716us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7666496us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7666647us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7667525us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7667675us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7668637us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7668787us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7669842us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7670000us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7671275us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7671427us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7672728us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7672888us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7674143us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7674296us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7675613us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7675766us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7679121us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7679276us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7680572us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7680727us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7682006us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7682162us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7683479us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7683635us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7684923us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7685080us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 7686370us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 7686530us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7690282us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7690441us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7691789us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7691962us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7693175us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7693334us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7694664us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7694824us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 7696125us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 7696287us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7697700us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7697869us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7699155us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7699317us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7700626us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7700789us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7702073us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7702236us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7703571us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7703735us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7704904us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7705068us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7716242us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7716410us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7717124us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7717291us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7718104us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7718270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7719114us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7719282us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7763454us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7763631us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7764866us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7765036us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 7766202us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 7766372us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7770736us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7770921us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7784832us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7785018us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7793278us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7793452us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7794108us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7794280us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7795152us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7795324us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3dNH1. 7796335us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3dNH1. 7796509us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7798339us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7798512us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7799858us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7800032us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7801324us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7801499us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7802739us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7802927us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7816949us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7817132us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7818041us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7818219us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7822229us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7822416us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7824228us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 7824405us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 7825512us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 7825690us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7826469us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7826651us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7827529us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7827709us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7828694us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7828880us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7829986us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7830166us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7831524us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7831705us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7833022us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7833203us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7834518us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7834700us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 7836074us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 7836260us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7837692us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7837883us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7839219us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7839403us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7840700us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7840896us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7842221us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7842406us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7843723us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7843923us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7845251us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7845438us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7847469us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7847610us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 7848908us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 7849050us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7850307us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7850448us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 7851694us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 7851835us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10427399us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10427549us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10428887us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10429032us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10431098us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10431245us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10433827us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10433981us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10434613us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10434757us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10435630us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10435775us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10436903us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10437049us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10438125us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10438270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10439576us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10439723us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10441011us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10441158us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10442408us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10442555us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10443927us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10444076us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10445285us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10445435us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10447325us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10447476us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10448731us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10448894us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10450194us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10450348us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10451889us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10452042us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10453318us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10453472us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10454732us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10454894us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H1. 10456224us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H1. 10456381us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10457852us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10458008us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10459341us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10459497us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10460760us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10460924us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10462231us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10462388us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10463684us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10463856us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10465154us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10465312us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10466665us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10466826us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10468159us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10468319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10469577us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10469738us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10471109us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10471270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10472553us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10472714us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10474009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10474171us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10475447us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10475609us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10477045us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10477208us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10478525us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10478688us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10480032us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10480196us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10481481us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10481645us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10482943us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10483126us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10484424us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10484590us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10485901us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10485973us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10489519us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10489688us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10491122us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10491301us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10492773us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10492953us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10494288us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10494456us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10495781us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10495979us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 10497390us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 10497560us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10498908us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10499105us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10500442us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10500613us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10502001us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10502172us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10503410us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10503581us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10504902us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10505074us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10507643us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10507816us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10509135us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10509314us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10510684us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10510870us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10512195us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10512370us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10513697us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10513885us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10515181us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10515359us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10516836us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10517017us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10518324us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10518502us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10519924us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10520103us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10521443us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10521622us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10658011us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10658199us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h3. 10658917us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h3. 10659118us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10661553us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10661736us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 10662751us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 10662942us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10664125us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10664311us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3D.h.. 10665461us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3D.h.. 10665644us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10791298us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10791491us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10792874us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10793062us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10794280us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10794463us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H2. 10796387us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H2. 10796574us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10799175us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10799366us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10802009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10802199us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10803862us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10804050us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10805726us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10805879us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10866409us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10866606us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10867899us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10868064us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10869433us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10869574us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10870589us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10870734us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10871441us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 10871584us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10874477us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10874624us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10875296us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10875440us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10879448us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10879593us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10880460us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] modprobe-5210      3d.h.. 10880604us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11942324us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11942527us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11945008us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11945175us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11946513us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11946679us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11951484us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11951652us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11987825us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11988021us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11991522us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11991690us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 11994630us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 11994742us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 11994834us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 11996351us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 11996477us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 11996531us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11998975us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 11999177us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 12018868us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 12019072us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 12326778us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 12326955us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12351704us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12351897us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h4. 12356750us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h4. 12356932us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12358060us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12358232us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12359691us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12359868us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h1. 12360534us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h1. 12360702us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h1. 12361878us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h1. 12362047us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12362833us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12363002us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12368691us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12368877us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12384485us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12384674us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12385256us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12385426us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12403715us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12403913us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12405009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12405178us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12416953us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12417139us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12417969us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12418140us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12436966us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12437129us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12479028us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12479249us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12483096us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12483273us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12487487us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12487673us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12496165us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12496354us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h1. 12502729us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h1. 12502932us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12507268us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12507459us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12508263us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12508441us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 12533325us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 12533560us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 12534600us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 12534779us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12538932us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12539126us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12572627us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12572862us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12576557us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12576760us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12586974us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12587209us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12588016us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12588204us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12589138us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12589326us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12590640us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12590843us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12608787us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12609027us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12652212us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12652445us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12653738us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12653943us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h3. 12658016us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h3. 12658224us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12659539us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12659735us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12667552us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12667754us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12668797us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12669005us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12669946us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12670124us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h1. 12670894us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h1. 12671103us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12672668us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12672876us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12674882us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12675104us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12676616us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12676827us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12678348us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12678541us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12679181us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12679374us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12689288us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12689508us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12691951us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12692154us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12694538us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12694742us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12698315us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12698521us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12708330us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12708555us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12709184us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12709383us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12711870us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12712074us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12713491us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12713697us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12716198us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12716406us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12728410us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12728637us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12729277us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12729477us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h1. 12730168us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h1. 12730367us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12731152us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12731352us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12732288us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12732498us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12733631us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12733783us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12734873us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12735027us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 12736228us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 12736388us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12747579us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h2. 12747766us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12748846us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12749004us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12750357us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12750516us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12751663us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12751839us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12752934us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12753099us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12754184us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12754346us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12761799us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (direxec-5224      3d.h.. 12761980us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12769158us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (sd-exec-5211      3d.h.. 12769330us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12771756us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12771938us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12772581us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12772741us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5218      3d.h.. 12773848us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5218      3d.h.. 12774013us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12776835us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12777008us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h.. 12777831us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h.. 12777999us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5219      3d.h1. 12778919us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5219      3d.h1. 12779102us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 12993729us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 12993918us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13206289us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13206475us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13208850us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13209028us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13210557us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13210736us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13211548us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13211726us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13214432us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13214611us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13356470us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13356658us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13360357us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13360539us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13362147us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13362328us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13363973us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13364155us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13365717us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13365895us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13572917us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13573126us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13577253us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13577441us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13597319us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13597512us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13619094us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13619289us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13620569us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13620759us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13622032us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13622213us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13625548us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13625738us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13633744us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13633949us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13645426us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13645622us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13655004us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13655225us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13666862us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13667082us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13668932us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13669119us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13693016us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13693218us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13700309us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13700504us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13706295us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13706494us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13713305us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13713500us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13718835us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13719053us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13724934us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13725133us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13731381us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13731577us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13735497us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13735695us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13741751us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13741963us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13747902us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13748101us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13753541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13753744us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13759142us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13759345us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13764494us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13764697us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13771092us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13771294us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13779972us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13780177us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13785090us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13785296us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13791260us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13791465us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13797434us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13797651us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13804002us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13804210us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13810668us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13810891us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13817310us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13817515us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13825117us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13825325us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13836787us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13837006us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13843992us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13844203us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13850871us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13851097us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13855907us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13856116us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13869666us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13869888us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13878368us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13878581us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13883884us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13884096us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13889988us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13890201us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13896062us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13896278us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13901062us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13901276us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13906322us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13906537us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13910246us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13910460us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13914966us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13915192us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13926084us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13926301us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13933342us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13933560us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13938505us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13938771us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13944275us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13944443us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13953989us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13954161us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13958988us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13959170us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13969057us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13969228us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13973604us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13973777us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13978892us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13979076us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13982971us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13983156us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13994606us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13994780us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13996195us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 13996366us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14002618us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14002794us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14009901us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14010077us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14015153us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14015331us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14020216us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14020391us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14022840us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14023016us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14026960us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14027167us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14028722us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14028912us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14029843us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14030022us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14030961us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14031156us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14032426us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14032603us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14038618us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14038800us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14042862us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14043063us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14050363us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14050544us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14054573us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14054757us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14059347us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14059532us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14064033us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14064217us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14068268us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14068451us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14072891us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14073076us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14079846us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14080032us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14091524us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14091715us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14095660us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14095858us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14100929us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14101117us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14107946us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14108131us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14111392us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14111570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14119496us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14119684us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14123551us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14123742us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14127953us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14128144us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14132647us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14132852us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14138277us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14138471us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14143442us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14143637us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14152757us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14152964us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14161659us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14161863us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14168162us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14168357us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14174421us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14174618us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14179255us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14179452us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14206983us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14207205us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14208649us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14208867us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14210292us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14210479us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14211686us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14211877us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14213068us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14213252us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14223440us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14223633us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14229224us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14229425us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14233872us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14234072us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14256643us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14256861us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14260618us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14260835us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14265438us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14265643us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14270502us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14270705us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14281653us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14281900us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14286232us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14286438us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14290344us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14290550us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14302999us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14303235us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14304898us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14305108us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14309092us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14309301us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14318530us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14318740us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14328923us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14329129us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14330511us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14330707us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14334110us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14334319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14340703us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14340928us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14351176us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14351389us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14355013us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14355253us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14360308us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14360522us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14373917us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14374133us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14375472us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14375686us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14378925us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14379158us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14384839us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14385054us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14390341us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14390559us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14470125us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14471919us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14471961us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14471986us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14475425us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14475469us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14475505us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14475532us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14498860us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14500750us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14500791us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14500828us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14523483us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14525500us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14525543us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14525573us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14532418us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14534919us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14534962us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14534993us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14541851us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14544359us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14544404us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14544436us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14568535us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14571000us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14571066us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14571101us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14574721us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14576947us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 14577044us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 14577080us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14580089us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14581568us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14581614us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14581650us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14585017us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14586902us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14586949us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14586986us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14590014us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14591540us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14591589us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14591627us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14594618us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14596114us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 14596210us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 14596250us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14601071us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14601303us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14612317us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14613909us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14613963us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14614004us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14621330us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14623534us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14623588us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14623630us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14637756us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14639604us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14639672us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14639715us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14649189us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14651139us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14651196us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14651241us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14663375us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14664999us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14665057us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14665103us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14682424us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14684239us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14684298us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14684345us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14693113us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14694912us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14694972us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14695021us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14698113us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14699675us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14699736us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14699786us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14761355us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14762913us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14762976us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14763047us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14768025us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 14768224us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]    mount-5228      3d.h.. 14768941us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]    mount-5228      3d.h.. 14769210us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]    mount-5228      3d.h.. 14772069us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]    mount-5228      3d.h.. 14772209us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14819929us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14821712us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14821778us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 14821845us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (mount)-5230      0d.h1. 14874929us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (mount)-5230      0d.h1. 14876582us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  (mount)-5230      0d.H1. 14876698us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (mount)-5230      0d.H1. 14876752us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    mount-5231      0d.h1. 14929807us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    mount-5231      0d.h1. 14931325us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]    mount-5231      0d.h1. 14931386us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    mount-5231      0d.h1. 14931441us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    mount-5231      0d.h.. 14983919us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    mount-5231      0d.h.. 14985453us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]    mount-5231      0d.h.. 14985516us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    mount-5231      0d.h.. 14985572us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 15044433us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 15046061us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0dNH1. 15046312us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0dNH1. 15046369us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] rcu_pree-16        0d.h1. 15106553us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] rcu_pree-16        0d.h1. 15107883us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] rcu_pree-16        0d.h1. 15107947us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] rcu_pree-16        0d.h1. 15108005us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 15154405us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 15154599us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 15217215us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 15218639us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 15218704us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 15218764us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 15222308us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 15222455us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 15224956us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 15225103us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.H.. 15226020us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.H.. 15226165us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15228424us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15228573us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h1. 15229626us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h1. 15229771us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15230915us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15231073us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15231892us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15232036us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15236669us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15236823us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15238045us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15238191us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15295696us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15297227us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.H.. 15297359us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.H.. 15297420us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15302654us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15302855us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15303618us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15303783us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15342712us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15342918us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      0d.h.. 15348745us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5237      0d.h.. 15350855us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      0d.h.. 15350924us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5237      0d.h.. 15350989us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.H1. 15381653us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H1. 15381857us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15382672us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15382860us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15384243us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15384394us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15385080us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15385230us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15391638us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15391809us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15392646us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15392810us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15401100us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15401277us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15404542us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15406244us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.H.. 15406374us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.H.. 15406438us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15434404us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15434592us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15435541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15435716us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15436597us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15436771us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15440272us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15440448us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 15441355us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 15441513us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15446393us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15446570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15451149us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15451327us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15452628us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15452813us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15453738us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15453927us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15455016us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15455218us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15456354us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15456533us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h1. 15461202us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h1. 15463040us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h1. 15463112us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h1. 15463176us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15467433us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15467647us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15468875us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15469079us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15470163us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15470342us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15470456us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5235      3d.h.. 15471424us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15471684us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15472610us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15472684us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15472749us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5236      0d.h1. 15479188us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h1. 15481078us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h1. 15481153us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h1. 15481220us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15487954us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15489625us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15489703us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15489771us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15496122us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15497732us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15497813us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15497883us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15504151us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.h.. 15505967us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.H.. 15506129us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0d.H.. 15506200us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15518900us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15519114us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15559606us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5235      3d.h.. 15560991us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15561259us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0d.h.. 15561650us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5236      0dNh1. 15561767us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5236      0dNh1. 15561852us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15562882us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15563092us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15563825us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15564009us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kcompact-51        3d.h1. 15571088us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kcompact-51        3d.h1. 15571257us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15579766us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15579975us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15596323us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15596525us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15597313us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15597506us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15598199us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15598388us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15599003us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15599209us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15599805us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15599985us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h2. 15600585us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h2. 15600773us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15601392us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15601574us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15602165us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15602351us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15602948us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15603161us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15603741us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15603937us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15604525us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15604711us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15605305us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15605497us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H1. 15606121us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H1. 15606310us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H1. 15606963us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H1. 15607162us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H2. 15607755us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H2. 15607948us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15609160us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15609353us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      3d.h.. 15620158us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5237      3d.h.. 15620364us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      3d.h.. 15625541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5237      3d.h.. 15625757us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      3d.h.. 15630497us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5237      3d.h.. 15630682us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15631592us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15631864us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 15634618us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 15636227us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 15636360us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 15636436us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15639014us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15639246us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15641044us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15641247us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      3d.h.. 15643194us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5237      3d.h.. 15643437us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      3d.h.. 15653848us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5237      3d.h.. 15654063us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      3d.h1. 15655732us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5237      3d.h1. 15655953us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5237      3d.h.. 15673686us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5237      3d.h.. 15673912us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15675876us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15675982us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]    mount-5239      0d.H1. 15689138us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    mount-5239      0d.H1. 15690803us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]    mount-5239      0dNH1. 15690915us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    mount-5239      0dNH1. 15691066us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15693540us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15693731us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15745189us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15745436us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15747113us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15747317us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15748439us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15748642us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 15762574us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 15763711us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 15763740us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 15763763us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 15763911us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 15763934us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15776899us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15777093us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5240      3d.h.. 15777833us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5240      3d.h.. 15778022us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15779205us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15779394us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 15780192us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 15780379us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15781034us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15781275us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15783576us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15783739us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15786436us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15786598us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 15788129us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 15789498us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 15789528us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 15789552us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 15789693us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 15789718us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15858172us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15858376us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15863604us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15863772us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15880516us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15880690us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15993008us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15993216us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 15993565us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 15993665us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5240      0d.h3. 16089766us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5240      0d.h3. 16091769us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5240      0dNh3. 16091845us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5240      0dNh3. 16091872us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16095570us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16095780us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16099094us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16099250us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16101390us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16101563us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16121669us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16121861us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16124368us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16124540us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16126049us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16126217us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16131005us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16131200us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16139234us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16139411us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5240      0d.h.. 16160646us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5240      0d.h.. 16162139us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5240      0d.h.. 16162173us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5240      0d.h.. 16162201us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 16181097us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 16181301us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 16181969us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 16182131us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16186367us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16186544us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5244      0d.h.. 16221395us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5244      0d.h.. 16222868us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5244      0d.h.. 16222904us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5244      0d.h.. 16222934us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16251052us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16251261us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16251966us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16252138us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16255069us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16255244us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5244      0d.h.. 16259939us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5244      0d.h.. 16261752us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5244      0dNh1. 16261831us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5244      0dNh1. 16261861us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16427944us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16428161us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16432171us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16432362us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 16434434us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 16434614us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16435527us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16435707us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16437847us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16438024us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16439262us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16439441us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16440900us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16441083us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 16444092us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 16444253us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 16448102us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 16448274us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16450514us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16450611us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16451184us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16451343us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.h1. 16451663us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.h1. 16451758us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 16457751us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 16457948us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16459167us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16459348us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16460115us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16460235us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16460761us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16460952us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16461273us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16461390us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16510474us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16510689us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5245      0d.h.. 16539451us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5245      0d.h.. 16541248us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5245      0dNh1. 16541327us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5245      0dNh1. 16541360us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16674333us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16674561us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H.. 16676232us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H.. 16676429us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16683051us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16683247us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16687865us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16688062us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 16689998us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 16690192us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16694326us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16694526us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H1. 16696061us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H1. 16696255us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16699418us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16699613us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16700294us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16700484us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16701137us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16701328us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 16833779us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 16835505us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 16835550us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 16835583us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  udevadm-5238      0d.h.. 16894132us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  udevadm-5238      0d.h.. 16895982us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-5238      0dNH.. 16896298us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  udevadm-5238      0dNH.. 16896334us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16896335us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16896571us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 16897208us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 16897399us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 16900909us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 16901108us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17267544us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17267769us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17269397us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17269594us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 17271541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 17271742us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17274946us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17275161us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17278065us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17278264us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 17283344us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 17283547us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-5238      2d.h.. 17286540us : =
irq_handler_entry: irq=3D11 name=3Dvirtio0

[ 1080.076740][    C3]  udevadm-5238      2d.h.. 17286615us : =
irq_handler_exit: irq=3D11 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17288430us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17288634us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17291185us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17291385us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17312221us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17312431us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 17314762us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 17314975us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17318998us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17319226us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17324406us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17324611us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17329153us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17329360us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17340587us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17340810us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17343696us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17343910us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 17348010us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 17348219us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17491398us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17493567us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17493616us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17493653us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17500226us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17502220us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17502285us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17502322us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17516278us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 17518192us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0dNh1. 17518272us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0dNh1. 17518312us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 17617233us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 17619084us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 17619133us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 17619172us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 17619331us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 17619370us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18027221us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18027468us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18028087us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18028293us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18029308us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18029517us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18030266us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18030474us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18031364us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18031570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18032605us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18032818us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18033950us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18034159us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18035234us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18035443us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18036898us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18037108us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18038213us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18038373us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18039476us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18039647us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18040718us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18040890us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18042026us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18042187us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18043296us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18043460us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18044607us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18044772us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18045860us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18045974us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18047260us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18047426us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18048805us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18048972us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18050089us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18050256us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18051372us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18051538us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18052650us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18052827us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18053936us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18054105us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18055240us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18055410us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H.. 18057414us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H.. 18057584us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H.. 18058683us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H.. 18058851us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18059983us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18060150us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 18061291us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 18061456us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18062546us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18062709us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18063864us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18064029us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18065146us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18065315us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18066507us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18066683us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18067838us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18068012us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18069124us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18069299us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18070637us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18070827us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18071980us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18072158us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18073322us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18073498us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18074635us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18074825us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18075955us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18075985us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18077314us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18077489us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18078577us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18078749us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18079891us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 18080065us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18081140us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18081319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18082440us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18082622us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18083723us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18083912us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18085044us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18085228us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18086301us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18086484us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18088986us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18089171us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18090275us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18090460us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18091854us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18092039us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18093112us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18093299us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18094411us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18094596us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18095735us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18095953us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18097162us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18097350us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18098412us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18098599us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18099736us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18099943us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18101022us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18101210us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18102328us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18102517us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18103612us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18103809us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18104924us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18105115us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H.. 18106230us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H.. 18106421us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18109963us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18110157us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18111266us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18111458us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18112529us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18112722us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18113774us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18113974us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18115089us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18115283us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18116452us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18116648us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18118022us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18118217us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18119074us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18119269us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18120154us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18120348us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18121454us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18121652us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18122715us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18122920us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18124043us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18124240us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18125301us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18125498us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18126717us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18126931us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18128023us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18128224us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18129318us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18129517us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18130572us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18130771us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18131919us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18132121us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18133327us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18133533us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18134623us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18134834us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18135953us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18135975us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18137723us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18137939us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18138998us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18139225us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18140620us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18140839us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18141872us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18142076us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H1. 18158285us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H1. 18158502us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18160061us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18160273us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18161954us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18162117us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18165706us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18165880us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18174145us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18174314us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18176032us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18176197us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18178697us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18178882us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18181390us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18181556us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18183634us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18183833us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18201933us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18202109us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.H1. 18206036us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.H1. 18206204us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18210097us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18210270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18215389us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18215560us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18220669us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18220850us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18225425us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18225599us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18229207us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18229383us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18232122us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18232294us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18235729us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18235917us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18242986us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18243175us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18249925us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18250104us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18256671us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18256857us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18275355us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18275536us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18279927us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18280105us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18283935us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18284114us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18289109us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18289290us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18293218us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18293399us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18296756us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18296946us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18300861us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18301044us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18304984us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18305167us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18308834us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18309020us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18320837us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18321048us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18332346us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18332562us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18337763us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18337975us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18341439us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18341629us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18345082us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18345270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18348362us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18348549us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 18363088us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 18363317us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18380789us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18381015us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18384488us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18384683us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18388255us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18388449us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18392444us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18392636us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18395039us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18395233us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18398508us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18398701us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 18401011us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 18401202us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNh1. 18421074us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNh1. 18423103us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNh1. 18423152us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNh1. 18423193us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 18423455us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 18423498us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0dNh1. 19330719us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNh1. 19331922us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNh1. 19331975us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNh1. 19332018us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 19332247us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 19332291us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] (urnalct-5249      0d.h1. 19389944us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] (urnalct-5249      0d.h1. 19391933us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] (urnalct-5249      0d.h1. 19391986us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] (urnalct-5249      0d.h1. 19392032us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19399807us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19400032us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19400725us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19400916us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19404467us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19404651us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19453388us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19453603us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19461737us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19461955us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19467435us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19467638us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19476870us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19477072us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.H1. 19496289us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.H1. 19496495us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19502731us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19502944us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19510788us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19510992us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19528884us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19529094us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19549228us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19549437us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19557747us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19557966us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19605993us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19606220us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19607382us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19607588us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19638838us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19639080us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19642865us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19643092us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19648149us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19648329us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19649690us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19649878us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19651166us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19651348us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19653201us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19653382us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19655240us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19655423us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19658177us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19658360us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19659449us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19659634us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19660374us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19660557us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 19661469us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 19661651us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19662711us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19662904us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19663942us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19664124us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19665308us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19665491us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19666947us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19667157us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3D.h.. 19668607us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3D.h.. 19668798us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19670159us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19670345us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19671816us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19672003us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 19674305us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 19674494us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3D.h.. 19675743us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3D.h.. 19675953us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19735035us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19735271us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19738318us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19738413us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19739053us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19739209us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19739570us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19739662us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19741847us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19741991us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19743289us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19743435us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19744367us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19744531us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19745241us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19745336us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19745894us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19746071us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19746428us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19746527us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19788920us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19789071us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19789666us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19789824us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19790738us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19790899us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19791512us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19791660us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19792503us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19792652us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19793238us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19793386us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19794226us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19794375us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 19794974us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 19795138us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.H1. 19796037us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.H1. 19796189us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19796779us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19796932us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19797541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19797710us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19798297us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19798459us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19799022us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19799186us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19799691us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19799865us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19800401us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19800567us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19801107us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19801274us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19809374us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19809553us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19810403us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19810572us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19813242us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19813412us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19815972us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19816149us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19817356us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19817469us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19818040us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19818211us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19818541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19818651us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19819336us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19819447us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19821252us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 19821423us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 19989822us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 19990035us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 19991873us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 19992056us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 19992873us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 19993048us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 19993751us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 19993934us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 19994877us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 19995069us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 19996338us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 19996519us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 19998093us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 19998272us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 20000208us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 20000387us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 20002310us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 20002489us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h2. 20004342us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h2. 20004522us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 20006546us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 20006728us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h.. 20009673us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h.. 20009869us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h3. 20011621us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h3. 20011812us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3dNh.. 20015316us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3dNh.. 20015507us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.H2. 20016407us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.H2. 20016580us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20017624us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20017822us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20018908us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20019120us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h.. 20020281us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h.. 20020468us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20026235us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20026431us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] journal--5250      3d.h.. 20027173us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] journal--5250      3d.h.. 20027364us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20029656us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20029852us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h1. 20030496us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h1. 20030687us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20033388us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20033588us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20034604us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20034732us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20035321us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20035510us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20035851us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20035988us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20037078us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20037257us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20038189us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20038388us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20038974us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20039125us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20039870us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20040068us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20040514us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20040645us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20074134us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20074351us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 20075401us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 20075604us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20076265us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20076472us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20077749us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20077957us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20078701us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20078906us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 20079818us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 20080018us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20081022us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20081217us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20082267us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20082463us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20083494us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20083691us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20084743us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20084951us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.H.. 20086019us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.H.. 20086230us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20087474us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20087682us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20088676us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20088887us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20090938us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20091107us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20092510us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20092669us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20093519us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20093681us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20134174us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20134351us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20135021us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20135180us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20136280us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20136437us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20137324us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20137479us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20138353us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20138511us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20139613us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20139778us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20140845us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20141004us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20142084us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20142242us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20143352us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20143512us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20144561us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20144721us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20145919us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 20146083us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20195386us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20195577us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20197039us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20197210us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20197834us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20198002us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20199044us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20199212us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5270      3d.h1. 20200067us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5270      3d.h1. 20200238us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20201121us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20201292us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5274      3d.h.. 20202337us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5274      3d.h.. 20202509us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20203641us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20203821us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h1. 20204848us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h1. 20205024us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5276      3d.h.. 20206141us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5276      3d.h.. 20206315us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20208485us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20208661us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20209740us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 20209923us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20210978us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20211183us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20213641us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20213821us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20214780us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20214956us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3dNH.. 20216119us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3dNH.. 20216297us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5281      3d.h.. 20217166us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5281      3d.h.. 20217358us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20219729us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20219925us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20221319us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20221500us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h1. 20222561us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h1. 20222741us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20223831us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20224015us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20225061us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 20225238us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20226296us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20226477us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20227863us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20228054us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20229029us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20229212us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20270686us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20270899us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20272632us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20272818us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h3. 20273412us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h3. 20273587us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 20274576us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 20274778us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 20275538us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 20275725us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5332      3d.h.. 20277403us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5332      3d.h.. 20277592us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5333      3d.h.. 20278649us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5333      3d.h.. 20278847us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 20279921us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 20280109us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h1. 20281120us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h1. 20281310us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20282380us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20282570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20283617us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20283806us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h3. 20284867us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h3. 20285048us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20286101us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20286286us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h3. 20288981us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h3. 20289178us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20290161us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20290347us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20291089us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20291277us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20293365us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20293556us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20294951us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20295167us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.H.. 20296262us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.H.. 20296460us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20298494us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20298696us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20300217us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20300414us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20301433us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20301620us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20302684us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20302886us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20303904us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20304095us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h1. 20346359us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h1. 20346580us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h1. 20348704us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h1. 20348922us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h1. 20349815us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h1. 20350016us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 20351602us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 20351815us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5397      3d.h1. 20352540us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5397      3d.h1. 20352740us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 20353647us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 20353855us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 20354868us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 20355087us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3dNH.. 20356118us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3dNH.. 20356321us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20357888us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20358092us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20359080us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20359286us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20360324us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20360522us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20361576us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20361783us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20362753us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20362958us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20364637us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20364853us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20365470us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20365678us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 20366319us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 20366479us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h1. 20368009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h1. 20368173us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20368708us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20368873us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20369405us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20369562us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20370169us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20370324us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3dNh3. 20372254us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3dNh3. 20372417us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20373375us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20373540us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h2. 20375086us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h2. 20375252us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3dNH3. 20376307us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3dNH3. 20376469us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 20423026us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 20423208us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20427418us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20427589us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 20428836us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 20428944us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20429466us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20429638us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h1. 20429945us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h1. 20430050us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      0d.h.. 20623441us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5374      0d.h.. 20625978us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      0dNH.. 20626173us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5374      0dNH.. 20626221us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5288      0d.h.. 20792798us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5288      0d.h.. 20794776us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5288      0dNh1. 20794860us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5288      0dNh1. 20794908us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5374      0d.h.. 20799103us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5374      0d.h.. 20799188us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5374      0d.h.. 20799244us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5374      0d.h.. 20799294us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 20904376us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 20904589us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.H.. 20926420us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.H.. 20926602us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20973329us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20973526us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20992056us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20992255us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20995023us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20995196us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 20995786us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 20995974us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 20999838us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 21000014us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 21003834us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 21004012us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21007842us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21007997us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21009157us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21009319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h.. 21013172us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h.. 21013349us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 21014156us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 21014319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h1. 21015265us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h1. 21015435us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 21022297us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 21022477us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 21023393us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 21023568us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.1 21024360us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.1 21024535us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5209      3d.h.. 21025295us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.h.. 21025478us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5209      3d.h1. 21026417us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.h1. 21026579us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 21027778us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 21027938us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h.. 21028557us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h.. 21028717us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 21029676us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 21029852us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h.. 21030484us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h.. 21030644us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 21032049us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 21032213us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h1. 21032872us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h1. 21033034us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.H.1 21038122us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.H.1 21038313us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21040645us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21040843us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21057910us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21058111us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21059245us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21059429us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21060119us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21060301us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 21066472us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 21066665us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 21067978us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 21068164us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 21070526us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 21070716us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 21071417us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 21071606us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 21072220us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 21072394us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 21073242us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 21073427us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h2. 21074356us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h2. 21074547us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 21075157us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 21075342us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 21076447us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 21076640us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 21077289us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 21077472us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h1. 21078218us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h1. 21078412us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21079028us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21079218us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21079828us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21080017us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 21101081us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 21101265us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h1. 21111486us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h1. 21111669us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21220205us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21220395us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21306940us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21307149us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h1. 21331874us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h1. 21332065us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h1. 21555194us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h1. 21555386us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 21556122us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 21556302us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 21612262us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 21612450us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 22276180us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 22276371us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5420      0d.h.. 22279957us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5420      0d.h.. 22280306us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5420      0d.h.. 22280361us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5420      0d.h.. 22280484us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.H.. 22346022us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.H.. 22346218us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22370495us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22370716us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h1. 22371856us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h1. 22372059us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22381378us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22381606us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22388487us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22388704us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22390724us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22390945us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22392211us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22392404us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22394252us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22394462us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22395359us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22395565us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22447110us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22447330us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22449293us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3dnh1. 22449488us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22451999us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3dnh1. 22452193us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22461210us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22461402us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22491477us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22491623us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h1. 22505559us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h1. 22505703us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22511029us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22511172us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 22518100us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 22518254us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 22520808us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 22520953us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 22521697us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 22521849us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5322      3d.h.. 22523016us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5322      3d.h.. 22523162us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.H1. 22526402us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.H1. 22526549us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6488      3d.h1. 22531842us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6488      3d.h1. 22531989us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 22553977us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 22554127us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22555653us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22555805us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.H1. 22566352us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.H1. 22566501us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6507      3d.h.. 22600691us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6507      3d.h.. 22600856us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22630603us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22630763us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22631410us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22631560us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22632418us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22632568us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22633161us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22633311us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22634139us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22634290us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h1. 22634863us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h1. 22635038us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6529      3d.h.. 22640513us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6529      3d.h.. 22640666us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22641297us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22641450us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6529      3d.h.. 22642260us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6529      3d.h.. 22642413us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3d.h.. 22643084us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3d.h.. 22643241us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6529      3d.h1. 22644061us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6529      3d.h1. 22644215us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6529      3d.h2. 22644850us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6529      3d.h2. 22645005us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5685      3dNH1. 22646232us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5685      3dNH1. 22646388us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5209      3d.h.. 22649436us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.h.. 22649593us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-176       0d.h.. 22651459us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-176       0d.h.. 22654100us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] kworker/-176       0d.h.. 22654161us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-176       0d.h.. 22654213us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-6544      0d.h.. 22663553us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-6544      0d.h.. 22663634us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-6544      0d.h.. 22663695us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-6544      0d.h.. 22663758us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22945443us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22945657us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 22948714us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 22948908us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 22973545us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 22973736us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 22975037us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 22975219us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h1. 22975784us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h1. 22975970us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5288      3d.h.. 22987484us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5288      3d.h.. 22987674us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6737      3d.h.. 22991965us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6737      3d.h.. 22992154us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22993222us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 22993418us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      3d.h.. 22995533us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5374      3d.h.. 22995714us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 23001266us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 23001455us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5209      3d.h.. 23005401us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.h.. 23005589us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3dNh1. 23009100us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3dNh1. 23009286us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5288      3d.h.. 23011512us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5288      3d.h.. 23011699us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6755      3d.h.. 23014724us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6755      3d.h.. 23014927us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.H.. 23018326us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.H.. 23018517us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5209      3d.h.. 23020729us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.h.. 23020931us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23023961us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23024163us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      3d.h.. 23025920us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5374      3d.h.. 23026130us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6765      3d.h.. 23030132us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6765      3d.h.. 23030324us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      3d.h.. 23032321us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5374      3d.h.. 23032513us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.H1. 23036274us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.H1. 23036465us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-5238      0d.h.. 23053230us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  udevadm-5238      0d.h.. 23055977us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-5238      0dNH.. 23056515us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  udevadm-5238      0dNH.. 23056572us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-5209      3d.h.. 23182038us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.h.. 23182281us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 23221394us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 23221623us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      3d.h.. 23223242us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5374      3d.h.. 23223447us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23228359us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23228568us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      3d.h.. 23243474us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5374      3d.h.. 23243681us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5209      3d.h1. 23247666us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.h1. 23247871us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23249026us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23249211us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23256920us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23257131us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 23259755us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 23259954us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 23261134us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 23261329us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5420      0d.h.. 23348390us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5420      0d.h.. 23350895us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5420      0d.h.. 23350964us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5420      0d.h.. 23351048us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5288      3d.h.. 23360701us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5288      3d.h.. 23360950us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23362835us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23363050us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h2. 23373270us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h2. 23373482us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23375229us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23375438us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      3d.h.. 23388253us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5374      3d.h.. 23388482us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-6961      3d.h.. 23400772us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-6961      3d.h.. 23400964us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3dNH1. 23406286us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3dNH1. 23406473us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 23424141us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 23424375us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7004      3d.h1. 23470951us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-7004      3d.h1. 23471224us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5420      0d.h3. 23488617us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5420      0d.h3. 23490695us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5420      0d.h3. 23490764us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5420      0d.h3. 23490823us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5288      3d.h1. 23500146us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5288      3d.h1. 23500392us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23505037us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23505259us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h1. 23507711us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h1. 23507933us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 23550753us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 23551012us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 23562646us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 23562898us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5493      3d.h.. 23563541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5493      3d.h.. 23563755us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 23572202us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 23572433us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 23593871us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 23594114us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7080      3d.h1. 23601422us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-7080      3d.h1. 23601650us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23620541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23620796us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7085      3d.h1. 23627750us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-7085      3d.h1. 23627967us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 23640409us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 23640577us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.H.. 23658504us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.H.. 23658680us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5288      3dNh3. 23667900us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5288      3dNh3. 23668055us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h3. 23675276us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h3. 23675442us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5374      3d.h.. 23688393us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5374      3d.h.. 23688569us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5288      3d.h.. 23695465us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5288      3d.h.. 23695633us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5288      3d.h.. 23707523us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5288      3d.h.. 23707698us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h1. 23780767us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h1. 23780960us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 23796297us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 23796475us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 23802779us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 23802959us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 23810845us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 23811033us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5271      3d.h.. 23812091us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5271      3d.h.. 23812260us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23814726us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23814906us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23816267us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23816444us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 23820865us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 23821041us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5388      3d.h.. 23821883us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5388      3d.h.. 23822053us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23822730us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23822908us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23824556us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23824721us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23842008us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23842189us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23842804us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23842988us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23849808us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23849983us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23851790us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23851962us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23853414us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23853582us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23856652us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23856845us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23859703us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23859889us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23861929us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23862105us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23881329us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23881521us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23895368us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23895548us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23897771us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23897950us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23900693us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23900873us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23902089us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23902265us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23902866us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23903057us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23904055us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23904230us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23905186us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23905359us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23907676us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23907866us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23909140us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 23909319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 23959334us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 23961727us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 23961814us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 23961874us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24099565us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24099804us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24100506us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24100686us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24101786us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24101967us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24113532us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24113750us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24115623us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24115825us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24119975us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24120182us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24123309us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24123504us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24124582us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24124784us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24129151us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24129341us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24132133us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24132314us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24134786us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24135008us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24137541us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24137728us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24141122us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24141308us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24143701us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24143891us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24147799us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24147999us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24151009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24151196us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24153844us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24154030us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24158796us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24159013us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24160900us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24161090us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24163489us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24163677us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rcu_pree-16        3d.h1. 24166123us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rcu_pree-16        3d.h1. 24166318us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24168906us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24169099us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24171524us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24171716us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24174212us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24174402us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24177165us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24177356us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24180477us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 24180674us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 24327628us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 24327994us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 24328059us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 24328197us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 26046113us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 26049373us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 26049478us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 26049543us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26249487us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26249745us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26251486us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26251632us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26252146us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26252344us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26252669us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 26252812us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26406659us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26407046us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26407112us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26407253us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26546066us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26549213us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26549293us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 26549359us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 27045986us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 27049164us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 27049295us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 27049365us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5456      0d.h1. 27557687us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5456      0d.h1. 27560867us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5456      0d.h1. 27560950us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5456      0d.h1. 27561018us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28046035us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28049141us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28049254us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28049339us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-96        0d.h.. 28487211us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        0d.h.. 28487577us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        0d.h.. 28487671us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        0d.h.. 28487838us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28545961us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28548858us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28548946us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 28549019us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29046005us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29049048us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29049142us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29049216us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29545964us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29549098us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29549187us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 29549262us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30046462us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30049576us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30049612us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30049635us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30546041us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30549109us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 30549179us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 30549204us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30566762us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30567064us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30567092us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 30567191us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31045957us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31049361us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31049404us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31049430us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31546118us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31549302us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31549347us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 31549375us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32046069us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32048941us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32048990us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32049019us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32546055us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32548951us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32548996us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32549026us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32646724us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32647074us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32647110us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 32647218us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      0d.h.. 33051586us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7249      0d.h.. 33054715us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      0d.h.. 33054756us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7249      0d.h.. 33054790us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7324      0d.h.. 33260108us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      0d.h.. 33260432us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      0d.h.. 33260468us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      0d.h.. 33260576us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      0d.h.. 33262812us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      0dnh.. 33263121us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h1. 33282887us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h1. 33283156us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33297293us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33297549us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33302001us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33302227us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 33309048us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 33309270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h1. 33322026us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h1. 33322256us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-7540      0d.h.. 33340367us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-7540      0d.h.. 33340707us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-7540      0d.h.. 33340741us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-7540      0d.h.. 33340956us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33345378us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0dNh.. 33345639us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7570      0d.h.. 33398658us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-7570      0d.h.. 33399024us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7570      0d.h.. 33399060us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-7570      0d.h.. 33399277us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33426626us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33427035us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h2. 33489891us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h2. 33490151us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 33491219us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 33491432us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33492399us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33492609us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33494504us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33494721us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33495572us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33495785us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33502827us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33503065us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 33506630us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 33506806us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 33516754us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 33516930us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 33521792us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 33521959us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 33522598us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 33522764us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33525281us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33525447us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 33545151us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 33545328us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h.. 33546892us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h.. 33547072us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 33551601us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 33551787us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 33553945us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 33554114us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33557086us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33557255us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  ifquery-7628      0d.h1. 33557999us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7308      3d.h.. 33558813us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33559047us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33559883us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33560155us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33561001us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33561330us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  ifquery-7628      0d.h1. 33561573us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  ifquery-7628      0d.h1. 33561623us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  ifquery-7628      0d.h1. 33561664us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33562048us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33562215us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 33570116us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 33570293us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33571027us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33571184us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33571873us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33572044us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33572721us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33572891us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33573723us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33573893us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 33577717us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 33577890us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 33583416us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 33583668us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h1. 33588780us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h1. 33588964us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33589997us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33590172us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33592483us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33592660us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33593295us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33593467us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h2. 33595425us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h2. 33595602us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-4571      3d.h.. 33596298us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-4571      3d.h.. 33596473us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33597997us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33598175us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 33601790us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 33601972us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.H1. 33607054us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.H1. 33607238us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3dNH.. 33608768us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3dNH.. 33608943us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 33609878us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 33610055us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 33616620us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 33616822us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33621716us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33621902us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33630984us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33631173us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33631960us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33632145us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33636954us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33637145us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 33638311us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 33638497us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 33640340us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 33640530us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33659402us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 33659597us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h.. 33669694us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h.. 33669904us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 33689273us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 33689472us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h.. 33692402us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h.. 33692589us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.H.. 33694452us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.H.. 33694633us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.H.. 33695292us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.H.. 33695472us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 33696828us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 33697018us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 33697642us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 33697837us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 33698777us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 33699004us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 33699768us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 33699957us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h1. 33703155us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h1. 33703350us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 33704283us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 33704476us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33705118us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33705413us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33705452us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33705565us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33706207us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0dNh.. 33706466us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h1. 33710439us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h1. 33710638us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 33711722us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 33711911us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h1. 33713080us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h1. 33713267us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 33713948us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 33714133us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 33715266us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 33715453us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      0d.h.. 33808407us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      0d.h.. 33808790us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      0d.h.. 33808830us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      0d.h.. 33809051us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7695      0d.h.. 33819699us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7695      0dNh.. 33820005us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 33898853us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 33899248us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 33899291us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 33899516us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33900347us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33900617us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33900666us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33900793us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33902386us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33902655us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33902714us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33902833us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7695      0d.h.. 33917438us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7695      0d.h.. 33917739us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7695      0d.h.. 33917784us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7695      0d.h.. 33917904us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7837      3d.h.. 33922122us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-7837      3d.h.. 33922487us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      0d.H1. 33922664us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      0d.H1. 33922875us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33930583us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33930881us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33930959us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33931079us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33931581us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0dNh.. 33932151us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33978793us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33979182us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 33979234us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 33979466us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34021619us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34021865us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7910      3d.h.. 34023563us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-7910      3d.h.. 34023773us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7912      3d.h1. 34026333us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-7912      3d.h1. 34026539us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3dNh.. 34032716us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3dNh.. 34032919us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34035403us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34035606us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.H1. 34037108us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.H1. 34037307us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-7924      3d.h2. 34047147us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-7924      3d.h2. 34047353us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h.. 34053116us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h.. 34053325us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34054110us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34054312us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34057179us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34057388us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 34064204us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 34065976us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNH1. 34067230us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNH1. 34067284us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34072591us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34072819us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 34094684us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 34094742us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34114032us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34114262us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 34123744us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 34125660us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 34125734us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 34125790us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0dNH1. 34126035us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNH1. 34126092us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 34126324us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 34126380us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34165849us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34165983us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34203401us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34203593us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34224899us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34225254us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34225310us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34225441us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      0d.h1. 34226390us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      0dNh1. 34226699us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34276156us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34276351us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34289395us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34289785us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34289847us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34290092us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34291866us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34292153us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34292211us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34292352us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34292989us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34293334us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34294146us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34294430us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34294490us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 34294620us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34295183us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0dNh.. 34295466us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34340934us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34341130us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 34341890us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 34342076us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34353340us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34353529us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      0d.h.. 34371797us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      0d.h.. 34372179us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      0d.h.. 34372242us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      0d.h.. 34372486us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34378009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34378203us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34381113us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34381305us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7695      3dNH1. 34396204us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7695      3dNH1. 34396394us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1007      3dNh3. 34419572us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1007      3dNh3. 34419732us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 34435008us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 34435157us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1007      3dNh3. 34441181us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1007      3dNh3. 34441325us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34472228us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34472373us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34476168us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34476312us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34481146us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34481294us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34481984us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34482128us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-8171      3d.h.. 34485307us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-8171      3d.h.. 34485453us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rcu_exp_-18        3d.h1. 34713599us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rcu_exp_-18        3d.h1. 34713811us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rcu_exp_-18        3d.H1. 34714444us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rcu_exp_-18        3d.H1. 34714603us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-8311      3d.h1. 34735723us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-8311      3d.h1. 34735910us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34795080us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34795280us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-8333      3d.h.. 34801063us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-8333      3d.h.. 34801237us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 34802812us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 34802994us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34810336us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h1. 34810511us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34819161us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34819339us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34819975us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 34820145us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  ifquery-8345      3d.h1. 34843271us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  ifquery-8345      3d.h1. 34843454us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  ifquery-8345      3d.h1. 34844172us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  ifquery-8345      3d.h1. 34844343us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0d.h.. 34845816us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0d.h.. 34845964us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0dNh1. 34847661us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0dNh1. 34847742us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34848261us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5247      0d.h.. 34848358us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 34848431us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5247      0d.h.. 34848499us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 34912739us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 34912940us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--8423      3d.h1. 35029087us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--8423      3d.h1. 35029298us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35038957us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35039141us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0dNH.. 35096044us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0dNH.. 35096416us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0dNH.. 35096506us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0dNH.. 35096672us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0d.h.. 35097494us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      0dNh.. 35097810us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--8423      3d.h.. 35125005us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--8423      3d.h.. 35125226us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35190581us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35190806us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.H1. 35216852us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.H1. 35217253us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.H1. 35217321us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.H1. 35217609us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 35219041us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      0d.h.. 35219198us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35350788us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35351023us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h2. 35406209us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h2. 35406421us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h1. 35414384us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h1. 35414571us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35453772us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35453975us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h2. 35472682us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h2. 35472876us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.H1. 35476250us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.H1. 35476431us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35485353us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35485555us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-8712      3d.h1. 35487394us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-8712      3d.h1. 35487579us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-8713      3d.h1. 35488897us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-8713      3d.h1. 35489079us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-8721      3d.h.. 35501856us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-8721      3d.h.. 35502067us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35514538us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35514753us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35521713us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35521917us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35523401us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35523585us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35525049us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35525239us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h.. 35526248us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h.. 35526434us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 35534372us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 35534570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35543172us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35543373us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 35547194us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 35547384us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 35548198us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 35548383us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 35549670us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 35549858us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 35553498us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 35553702us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 35554316us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 35554502us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35562209us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35562413us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h1. 35619774us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h1. 35620003us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35621201us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35621394us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h1. 35622576us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h1. 35622776us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35625288us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35625485us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 35725677us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 35725912us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35726645us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-7130      3d.h.. 35726855us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 36337507us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 36337761us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 36338550us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 36338763us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 36359584us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 36359837us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 36431063us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5247      0d.h.. 36433030us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 36433172us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5247      0d.h.. 36433194us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 36437958us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5247      0d.h.. 36440014us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      0d.h.. 36440045us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5247      0d.h.. 36440068us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 36450322us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 36450561us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 36460386us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 36460602us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h1. 36461317us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h1. 36461516us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h2. 36464799us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h2. 36464997us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h2. 36465522us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h2. 36465718us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 36467882us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 36468083us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 36468629us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 36468836us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36497175us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36497419us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36498086us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36498281us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36498952us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36499146us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36499746us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36499939us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36500485us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36500689us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36501311us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36501504us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36502075us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36502270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36502866us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36503081us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36503628us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36503832us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 36504856us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 36505055us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36509840us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36511401us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36511432us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36511455us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36511601us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36511626us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36540771us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36542527us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36542561us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36542587us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36542741us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36542768us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36560805us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36562920us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNh1. 36562989us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNh1. 36563018us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36586264us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36586295us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36595740us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36595971us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNH1. 36597489us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNH1. 36597519us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36616237us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36616269us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36621670us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36623190us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36623229us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36623261us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36623412us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36623444us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36648986us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36650775us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36650815us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36650848us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36651030us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36651065us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36653419us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36654706us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36654747us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36654782us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36654959us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36654996us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36677124us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36678259us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36678302us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36678339us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36678498us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36678537us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 36741189us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 36741443us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h1. 36749832us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h1. 36750053us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 36808527us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 36808787us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 36813360us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 36813571us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 36814270us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 36814527us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36861001us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36863012us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36863058us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36863098us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 36863260us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 36863299us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 36872152us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 36872351us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9041      3d.h2. 36876551us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9041      3d.h2. 36876728us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9041      3d.h1. 36880328us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9041      3d.h1. 36880487us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h2. 37103244us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h2. 37103451us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 37130377us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 37130572us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]     cron-9034      0d.h1. 37136895us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]     cron-9034      0d.h1. 37139272us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]     cron-9034      0d.h1. 37139321us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]     cron-9034      0d.h1. 37139361us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   v4l_id-9048      3d.h1. 37140412us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9048      3d.h1. 37140584us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9048      3d.h.. 37210383us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9048      3d.h.. 37210587us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9048      3d.h.. 37213050us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9048      3d.h.. 37213213us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9048      3d.h1. 37214731us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9048      3d.h1. 37214919us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9048      3dNh1. 37216037us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9048      3dNh1. 37216206us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37227244us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37227420us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]     cron-9034      0d.h.. 37296800us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]     cron-9034      0d.h.. 37297124us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]     cron-9034      0d.h.. 37297164us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]     cron-9034      0d.h.. 37297279us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9053      3d.h1. 37300804us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9053      3d.h1. 37301015us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]     cron-9034      0d.h.. 37308922us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]     cron-9034      0d.h.. 37311291us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]     cron-9034      0d.h.. 37311342us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]     cron-9034      0d.h.. 37311387us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 37320482us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 37320678us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37321312us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37321481us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9053      3d.h1. 37329385us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9053      3d.h1. 37329567us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37330318us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37330480us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37331448us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37331612us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37332718us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37332883us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37334011us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37334175us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37335276us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9053      3d.h.. 37335442us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 37342063us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 37342242us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h1. 37347808us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h1. 37347994us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h2. 37350103us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h2. 37350282us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37356895us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37357078us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37358196us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9052      3d.h.. 37358373us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9052      3d.h1. 37359405us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9052      3d.h1. 37359582us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 37398485us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 37398689us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 37403985us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 37404167us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h2. 37475850us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h2. 37475984us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0d.h.. 37838949us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7341      0d.h.. 37841128us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0d.h.. 37841186us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7341      0d.h.. 37841232us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   v4l_id-9078      3d.h1. 37962444us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9078      3d.h1. 37962677us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9078      3d.h1. 37971303us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9078      3d.h1. 37971494us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9080      3d.h.. 37976517us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9080      3d.h.. 37976711us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9080      3d.h.. 37977312us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9080      3d.h.. 37977486us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]       sh-9082      0d.h.. 38011004us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]       sh-9082      0d.h.. 38012671us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]       sh-9082      0d.h.. 38012726us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]       sh-9082      0d.h.. 38012773us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 38022731us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 38022960us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h1. 38033902us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h1. 38034101us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 38035437us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 38035615us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9080      3d.h.. 38040135us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9080      3d.h.. 38040327us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9085      3d.h2. 38041039us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9085      3d.h2. 38041229us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 38043864us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 38044055us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 38046536us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 38046738us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 38047592us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 38047788us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 38049011us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 38049205us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9085      3d.h2. 38055921us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9085      3d.h2. 38055985us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 38066722us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 38066929us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 38068984us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 38069170us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 38070230us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 38070413us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h3. 38122385us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h3. 38122605us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 38185746us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 38185972us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38193663us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38193859us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9090      3d.h.. 38199565us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9090      3d.h.. 38199770us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h1. 38233130us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h1. 38233342us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h1. 38234552us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h1. 38234743us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h2. 38235354us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h2. 38235539us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38237115us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38237311us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38238269us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38238458us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h3. 38239174us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h3. 38239361us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38239938us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38240125us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38242328us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38242518us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38244491us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38244686us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38251006us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38251209us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38251787us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38251978us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38254006us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38254211us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38257265us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38257402us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38258087us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38258280us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38258562us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38258699us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38259754us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38259947us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38270823us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38271039us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38271648us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38271850us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38272556us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38272766us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38273477us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38273687us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38274564us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38274776us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38275863us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9092      3d.h.. 38275981us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9094      3d.h.. 38287264us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9094      3d.h.. 38287475us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9094      3d.H1. 38288412us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9094      3d.H1. 38288611us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38295003us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38295211us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38295772us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38295977us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9094      3d.h1. 38331697us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9094      3d.h1. 38331938us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38336570us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38336846us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9093      3d.h1. 38347392us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9093      3d.h1. 38347559us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9093      3d.h1. 38350511us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9093      3d.h1. 38350678us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9094      3d.h1. 38368231us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9094      3d.h1. 38368406us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 38400492us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 38400655us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9093      3d.h1. 38481786us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9093      3d.h1. 38481992us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9093      3d.h.. 38482648us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9093      3d.h.. 38482810us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 38489532us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 38490570us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 38490625us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 38490688us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 38490855us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 38490931us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38544029us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38544186us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.h.. 38546071us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.h.. 38546218us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38547287us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38547450us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38557185us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38557333us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38558382us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38558531us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9102      3d.h1. 38559515us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9102      3d.h1. 38559673us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9102      3d.h.. 38560902us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9102      3d.h.. 38561051us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38562607us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38562765us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38563372us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38563521us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38584718us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38584871us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38590237us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38590389us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38597962us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38598113us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38620382us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38620536us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38625061us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38625218us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38625848us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38625975us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38626770us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38626936us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38627601us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38627766us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38628459us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38628613us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38629280us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38629434us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38630240us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38630396us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1029      3d.h1. 38631011us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1029      3d.h1. 38631167us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38631838us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38631996us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1029      3d.h2. 38632611us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1029      3d.h2. 38632782us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3dNh1. 38633479us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3dNh1. 38633644us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h1. 38634222us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h1. 38634380us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38635437us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38635598us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.h1. 38636293us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.h1. 38636452us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38637059us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38637236us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38638336us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38638504us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38646770us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38646948us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.h1. 38648097us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.h1. 38648260us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38648806us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38648968us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38649874us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38650037us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38650930us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38651095us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38653957us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38654123us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h1. 38654981us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h1. 38655147us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h1. 38657294us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h1. 38657462us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-39        3d.h2. 38658196us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-39        3d.h2. 38658379us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h2. 38659656us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h2. 38659844us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.h1. 38660765us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.h1. 38660937us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38661534us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1029      3d.h.. 38661715us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-79        3d.h1. 38662486us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-79        3d.h1. 38662671us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38663492us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38663679us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38668532us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38668711us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38669375us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38669548us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38670381us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38670553us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38671257us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38671444us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38672301us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38672481us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38673264us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38673453us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38674026us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38674200us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38676087us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38676281us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38677009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38677199us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38677749us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38677940us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38691824us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38692004us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38692674us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h1. 38692852us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38693850us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38694028us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38696930us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38697110us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38698189us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38698378us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38699271us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38699453us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38700246us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38700426us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38701100us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38701280us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38702227us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38702408us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38703098us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38703281us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38704106us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38704289us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38704978us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38705164us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38706021us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38706206us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38706855us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38707061us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38707947us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38708132us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h.. 38709404us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h.. 38709589us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38711150us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38711336us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38712005us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38712192us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38716846us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38717035us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38717770us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38717909us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38724031us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38724195us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38727163us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38727305us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-96        3d.h1. 38727994us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-96        3d.h1. 38728135us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38736416us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38736592us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38737830us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38737991us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38739430us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38739590us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38747015us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38747160us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h2. 38749788us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h2. 38749935us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38750597us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38750758us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38758263us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38758437us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38760960us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38761122us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38763901us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38764067us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38770583us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38770748us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h2. 38771402us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h2. 38771552us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38772292us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rsyslogd-9084      3d.h.. 38772465us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38778219us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38778395us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38797273us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38797453us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38799918us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38800090us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38819369us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38819556us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38829574us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h2. 38829763us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38830404us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38830570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38834528us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38834715us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38836685us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38836857us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38839350us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38839521us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38856675us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38856863us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38857620us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38857800us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38860600us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38860789us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38870599us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38870798us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38872207us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38872390us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38874211us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38874392us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38875117us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38875293us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38880564us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h.. 38880736us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 38886683us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 38886891us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 38887571us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 38887766us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 38889797us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 38889974us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38896584us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  kswapd0-116       3d.h1. 38896768us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9112      3d.h1. 38903510us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9112      3d.h1. 38903708us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9112      3dNh1. 38904447us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9112      3dNh1. 38904631us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         3d.h.. 38905291us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         3d.h.. 38905462us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9112      3d.h1. 38911771us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9112      3d.h1. 38911948us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 38913260us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 38913445us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 38949453us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 38949664us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9114      3d.h.. 39021007us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9114      3d.h.. 39021244us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39026620us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39026846us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9114      3d.h.. 39036602us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9114      3d.h.. 39036825us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9114      3d.h1. 39037927us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9114      3d.h1. 39038117us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9114      3d.h1. 39038772us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9114      3d.h1. 39038976us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39045339us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39045535us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h1. 39047088us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h1. 39047278us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39048929us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39049117us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39050552us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39050749us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39051452us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39051642us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39057647us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39057862us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39058510us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39058707us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39059344us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39059528us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 39060276us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 39060461us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9117      0d.h.. 39065240us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9117      0d.h.. 39067505us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9117      0dNH.. 39068406us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9117      0dNH.. 39068459us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9120      3d.h.. 39069017us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9120      3d.h.. 39069231us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39069849us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39070044us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39070652us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39070845us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39071729us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39071918us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9120      3d.h2. 39072558us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9120      3d.h2. 39072755us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39075823us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9120      3d.h1. 39075983us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9119      3d.h1. 39085445us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9119      3d.h1. 39085672us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 39086297us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 39086493us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] in:imklo-9111      0d.h.. 39088402us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] in:imklo-9111      0d.h.. 39090333us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] in:imklo-9111      0d.h.. 39090391us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] in:imklo-9111      0d.h.. 39090442us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9118      3d.h1. 39099257us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9118      3d.h1. 39099487us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9118      3d.h1. 39102544us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9118      3d.h1. 39102747us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9119      3d.h.. 39122916us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9119      3d.h.. 39123130us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9119      3d.h.. 39123789us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9119      3d.h.. 39123984us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9121      3d.h.. 39173159us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9121      3d.h.. 39173384us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h2. 39385629us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h2. 39385836us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h2. 39387959us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h2. 39388148us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      0d.h.. 39398063us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      0d.h.. 39398409us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      0d.h.. 39398459us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      0d.h.. 39398585us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9129      3d.h.. 39447084us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9129      3d.h.. 39447274us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] logrotat-9099      3d.h.. 39629112us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] logrotat-9099      3d.h.. 39629307us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9135      3d.h1. 39629992us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9135      3d.h1. 39630178us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] (crub_al-9045      3d.h1. 39634433us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] (crub_al-9045      3d.h1. 39634626us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9154      3d.h.. 40150251us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9154      3d.h.. 40150509us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 40181603us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 40181857us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9161      3d.h.. 40385116us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9161      3d.h.. 40385324us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 40387254us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 40387422us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h1. 40388841us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h1. 40389002us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9161      3d.h.. 40396930us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9161      3d.h.. 40397114us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 40558227us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 40558432us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 40675129us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 40675342us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 40676369us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 40676534us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9169      3d.h1. 40684394us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9169      3d.h1. 40684579us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 40858240us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 40858451us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9174      3d.h1. 40898176us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9174      3d.h1. 40898380us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 40916932us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 40917123us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 40921258us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 40921440us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 40922703us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 40922882us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9174      3d.h1. 40971044us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9174      3d.h1. 40971246us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 40999801us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 40999959us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41091202us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41091417us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 41258958us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 41259177us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41282530us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41282747us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41285215us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41285393us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-5209      3d.H1. 41297236us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-5209      3d.H1. 41297415us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41300346us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41300519us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41301832us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41302000us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3dNh1. 41306037us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3dNh1. 41306214us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41307714us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41307885us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41316852us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41317038us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41317945us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41318124us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41318915us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41319091us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41320988us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41321169us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41335453us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41335647us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41337318us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41337502us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41340570us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41340763us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41341425us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41341599us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 41342162us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 41342341us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41344035us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41344219us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41345517us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41345706us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41346364us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41346544us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41360695us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41360891us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41367201us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41367391us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41368038us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41368219us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41368796us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41368981us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41369611us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41369803us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41371027us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41371216us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41371916us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41372110us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 41373293us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 41373484us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41374120us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41374306us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41385904us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41385990us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41387140us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41387330us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41387967us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41388154us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41389188us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41389379us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41390022us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h.. 41390211us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41390824us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9181      3d.h1. 41391038us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41394695us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41394901us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41395484us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41395688us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41406543us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41406752us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 41407529us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 41407728us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41408337us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41408525us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41409624us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41409819us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h11 41411446us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h11 41411659us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41416918us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41417117us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41417762us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41417958us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41419577us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41419788us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41421142us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41421343us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h1. 41421961us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h1. 41422158us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h1. 41426294us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h1. 41426494us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h1. 41428659us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h1. 41428860us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 41429968us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 41430169us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 41430735us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 41430951us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 41436983us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 41437193us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 41439594us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 41439799us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41441128us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41441332us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h11 41442025us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h11 41442225us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h1. 41443246us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h1. 41443448us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41444131us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41444333us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0d.h.. 41446529us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      0d.h.. 41446827us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0d.h.. 41446904us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      0d.h.. 41447028us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0d.h1. 41448787us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0d.h1. 41451764us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0dNh1. 41451868us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0dNh1. 41451923us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7200      0d.h1. 41456089us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7200      0d.h1. 41456164us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7200      0d.h1. 41456225us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7200      0d.h1. 41456282us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41457269us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41457482us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 41458106us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 41458310us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41464252us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41464462us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41483166us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41483382us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41485240us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41485451us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41486150us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41486309us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 41515868us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 41515980us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 41545910us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 41545973us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 41549331us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 41549498us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 41592202us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 41592391us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 41594657us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 41594822us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41606924us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41607097us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41607931us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41608087us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41609017us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41609172us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41610353us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41610509us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41611579us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41611751us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41612355us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41612511us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41613173us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41613330us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 41617111us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 41617277us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 41618202us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 41618361us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 41619231us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 41619390us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 41624163us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 41624332us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41624966us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41625131us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 41625870us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 41625970us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41637305us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41637484us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41639763us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41639939us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41640781us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41640951us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41641568us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41641746us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41643113us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41643288us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 41643907us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 41644081us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41647979us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41648158us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 41681260us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 41681460us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41688985us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41689171us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41689964us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41690138us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9193      3d.h1. 41798532us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9193      3d.h1. 41798710us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41858130us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41858360us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 41860139us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 41860314us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h2. 41866577us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h2. 41866779us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h2. 41867490us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h2. 41867672us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h2. 41868560us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h2. 41868745us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h2. 41870763us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h2. 41870962us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 41877468us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 41877668us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 41880549us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 41880735us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9193      3d.h.. 41887403us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9193      3d.h.. 41887600us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h1. 41889298us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h1. 41889464us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3dNh1. 41896048us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3dNh1. 41896245us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9193      3d.h.. 41911611us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9193      3d.h.. 41911826us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 42092954us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 42093190us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h1. 42098586us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h1. 42098797us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 42099445us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 42099637us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0d.h.. 42100817us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0d.h.. 42103319us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0d.h.. 42103385us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0d.h.. 42103443us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 42106665us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 42106880us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 42107589us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 42107789us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 42108657us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 42108846us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 42109463us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 42109667us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 42113908us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 42114103us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42114755us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42114971us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42115661us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42115851us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0d.h.. 42124506us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7341      0d.h.. 42125969us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0dNH.. 42127495us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7341      0dNH.. 42127555us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7224      3d.h2. 42129365us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h2. 42129574us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 42135740us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 42135950us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 42176861us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 42177082us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42206800us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42207039us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.H.. 42208084us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.H.. 42208274us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 42217073us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 42217277us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 42218090us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 42218289us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 42219387us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 42219585us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 42220601us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 42220808us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h3. 42221900us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h3. 42222091us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 42223149us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 42223340us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 42224350us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 42224541us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h2. 42225574us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h2. 42225772us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42248049us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42248270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h2. 42315102us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h2. 42315347us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42334221us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42334446us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42344873us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42345072us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42346207us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42346406us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42351779us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42351989us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42354918us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42355126us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3dNH1. 42356063us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3dNH1. 42356256us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 42357052us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 42357261us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h1. 42358019us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h1. 42358226us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42358773us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42358995us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42364925us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42365136us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 42367820us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 42368033us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42376550us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42376727us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42386548us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42386724us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42387661us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42387815us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42397439us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42397608us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42398331us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42398486us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9207      3d.h.. 42406469us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9207      3d.h.. 42406649us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9207      3d.h1. 42407260us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9207      3d.h1. 42407422us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42417345us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h1. 42417520us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h2. 42418261us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h2. 42418419us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42426605us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42426791us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9207      3d.h1. 42437572us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9207      3d.h1. 42437762us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42457354us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42457538us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42458255us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42458421us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42474481us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42474676us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 42478983us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 42479165us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42485802us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42485981us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42489719us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9209      3d.h.. 42489894us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42491092us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42491265us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42494395us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42494573us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42506560us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42506750us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42512911us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42513094us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1007      3d.h1. 42519243us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1007      3d.h1. 42519421us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 42541869us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 42542079us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 42543638us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 42543816us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3dNh1. 42545285us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3dNh1. 42545466us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      0d.h.. 42545807us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5247      3d.h.. 42546947us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42547256us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      0d.h.. 42547391us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      0dNH.. 42548922us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7249      0dNH.. 42548984us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5247      3dNh.. 42550007us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3dNh.. 42550189us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 42553755us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 42553939us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9217      3d.h.. 42555777us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9217      3d.h.. 42555977us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9217      3d.h1. 42557471us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9217      3d.h1. 42557661us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.H1. 42577941us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.H1. 42578146us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.H.. 42579738us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.H.. 42579918us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 42580505us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 42580686us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42595709us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42595898us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42597413us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42597600us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 42599895us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 42600074us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   v4l_id-9221      3d.h1. 42658483us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   v4l_id-9221      3d.h1. 42658717us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      0d.h.. 42739793us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7308      0d.h.. 42742540us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      0dNh1. 42742657us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7308      0dNh1. 42742719us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 43526576us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 43526921us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 43526982us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 43527116us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h2. 44182465us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h2. 44182713us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h1. 44190454us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h1. 44190585us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9260      3d.h1. 44191292us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9260      3d.h1. 44191478us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9260      3d.h2. 44191921us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9260      3d.h2. 44192035us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      0d.h.. 44795828us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7269      0d.h.. 44797529us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      0dNh1. 44798506us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7269      0dNh1. 44798571us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7145      0d.h.. 45307686us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0d.h.. 45310767us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      0d.h.. 45310861us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7145      0d.h.. 45310928us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 45405661us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 45405887us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7177      3d.h.. 45406666us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7177      3d.h.. 45406874us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h2. 45416649us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h2. 45416843us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h1. 45417475us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h1. 45417667us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7177      3d.h.. 45555252us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7177      3d.h.. 45555476us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0d.h.. 45616895us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      0d.h.. 45617225us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0d.h.. 45617290us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      0d.h.. 45617428us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      3d.h.. 45743761us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      3d.h.. 45743997us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      0d.h.. 45749222us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5235      0d.h.. 45751126us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      0dNh1. 45751235us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--5235      0dNh1. 45751304us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46534157us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46534387us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46674102us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46674327us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 46678854us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 46679051us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h1. 46688932us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h1. 46689132us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46694949us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46695145us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9300      0d.h.. 46723893us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ifupdown-9300      0d.h.. 46726008us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9300      0dNH.. 46726598us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ifupdown-9300      0dNH.. 46726670us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7288      3d.h2. 46769090us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h2. 46769315us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h2. 46769977us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h2. 46770163us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46783294us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46783498us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h3. 46818484us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h3. 46818703us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 46819382us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 46819571us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 46820173us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 46820362us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 46824655us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 46824855us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46827409us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46827616us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46828284us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46828485us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46829188us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46829381us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46830002us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46830192us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46830782us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46831012us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46833464us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46833677us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h1. 46836140us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h1. 46836350us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 46838782us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 46839013us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46846738us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46846964us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46852275us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46852483us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46853785us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46853991us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46854684us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46854913us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h2. 46858458us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h2. 46858673us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 46862849us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 46863055us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46866528us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46866763us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46870003us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46870213us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46870800us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46871039us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h1. 46871750us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h1. 46871969us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46872885us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46873039us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46874013us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46874166us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46874730us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46874895us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46875454us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46875612us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h2. 46876313us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h2. 46876475us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46877123us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46877282us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h2. 46877919us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h2. 46878081us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46878641us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46878798us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46879369us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46879533us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46880071us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46880237us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46881292us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h.. 46881457us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46882028us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46882186us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46882729us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46882921us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 46883485us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 46883657us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 46884304us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 46884470us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46885020us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46885191us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46885763us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46885930us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46897087us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46897268us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46899878us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46900052us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46900841us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46901014us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h1. 46902076us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h1. 46902253us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46906774us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46906968us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h2. 46907864us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h2. 46908029us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46908586us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46908750us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46916871us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46917047us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h2. 46917924us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h2. 46918090us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46919176us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46919344us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46920312us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46920480us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46921123us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46921291us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46922145us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46922313us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46922857us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46923026us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46924177us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46924349us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h.. 46924911us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h.. 46925081us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46925773us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46925955us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h.. 46926929us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h.. 46927110us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h.. 46927688us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h.. 46927867us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h.. 46928802us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h.. 46928983us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h.. 46929532us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h.. 46929724us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h1. 46930265us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h1. 46930446us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h.. 46931011us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h.. 46931192us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46936804us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46936971us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1130      3d.h1. 46946488us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1130      3d.h1. 46946666us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46947379us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46947546us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 46949846us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 46950038us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1130      3d.h.. 46951156us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1130      3d.h.. 46951342us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46952495us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9310      3d.h1. 46952676us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h2. 46956839us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h2. 46957028us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h2. 46957772us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h2. 46957954us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7249      3d.h2. 46958953us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7249      3d.h2. 46959133us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46962764us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46962975us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h.. 46964075us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h.. 46964263us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46964964us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] mtd_prob-9307      3d.h1. 46965149us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 46997087us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 46997263us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9306      0d.h.. 47073416us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9306      0d.h.. 47075329us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9306      0d.h.. 47075408us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9306      0d.h.. 47075480us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47085250us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47085442us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  ifquery-9326      3d.h.. 47141837us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  ifquery-9326      3d.h.. 47142054us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  ifquery-9326      3dNH.. 47146125us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  ifquery-9326      3dNH.. 47146324us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h2. 47149133us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h2. 47149332us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h2. 47243601us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h2. 47243829us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h2. 47244631us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h2. 47244822us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47261986us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47262198us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47263991us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47264183us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47264765us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47264955us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47265844us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47265985us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9312      3d.h.. 47266898us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ifupdown-9312      3d.h.. 47267101us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47314465us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47314690us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h1. 47340391us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h1. 47340623us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h2. 47355528us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h2. 47355742us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47358155us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47358362us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47361665us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47361868us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47368602us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47368810us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47394733us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47394963us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47395628us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47395826us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47410809us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47411040us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h1. 47411743us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h1. 47411942us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47412547us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47412758us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47413717us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47413917us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47415163us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47415365us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47423508us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47423735us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47437238us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47437405us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47438047us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47438199us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47461782us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47461926us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47464710us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47464874us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47511411us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47511607us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.H.. 47512613us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.H.. 47512771us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47514999us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47515166us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.h1. 47516286us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.h1. 47516448us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 47517201us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 47517358us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 47519593us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 47519753us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47537495us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47537681us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h1. 47538514us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h1. 47538689us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47544759us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47544932us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3dNH.. 47546041us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3dNH.. 47546210us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47575255us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47575436us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47580105us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47580281us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47582806us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47583003us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47583683us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47583855us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47588123us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47588297us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47589124us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47589289us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47589903us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47590068us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47607875us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47608058us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47608711us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47608884us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47621601us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47621785us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47627160us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47627338us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47630880us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47631066us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47632876us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47633053us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47637091us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47637270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h1. 47637882us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h1. 47638058us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47639356us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47639533us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47657136us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47657327us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3dNH.. 47666020us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3dNH.. 47666202us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47667835us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47668019us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47683463us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47683663us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-4739      0d.h1. 47706568us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-4739      0d.h1. 47706907us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-4739      0d.h1. 47706978us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-4739      0d.h1. 47707120us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47720832us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47721030us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47725775us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47725973us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47738416us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47738621us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47746478us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47746680us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47747338us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47747515us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47754867us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47755059us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47767458us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47767691us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47768293us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47768470us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47769121us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47769306us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h.. 47783046us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h.. 47783284us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47807127us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47807357us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47808094us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47808281us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 47809770us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 47809962us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 47830994us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 47831229us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47838555us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47838774us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47839538us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47839739us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h.. 47902859us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h.. 47903094us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9332      3d.h1. 48038781us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9332      3d.h1. 48039041us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9336      3d.h.. 48047270us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9336      3d.h.. 48047498us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9333      3d.h3. 48087437us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9333      3d.h3. 48087681us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 48247304us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 48247547us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 48248210us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 48248405us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 48333759us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 48333998us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h2. 48357900us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h2. 48358139us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h2. 48358802us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h2. 48359023us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9359      3d.h.. 48373986us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ifupdown-9359      3d.h.. 48374222us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9359      3d.h.. 48374911us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ifupdown-9359      3d.h.. 48375111us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9359      3d.h.. 48457192us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ifupdown-9359      3d.h.. 48457443us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 48471696us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 48471943us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9365      3d.h1. 48480697us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9365      3d.h1. 48480937us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9365      3d.h.. 48546265us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9365      3d.h.. 48546515us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      0d.h.. 48795857us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7224      0d.h.. 48798042us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      0dNh1. 48799215us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7224      0dNh1. 48799347us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9383      3d.h1. 48977064us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9383      3d.h1. 48977307us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9378      0d.h.. 49208384us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9378      0d.h.. 49211812us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9378      0dNh1. 49211877us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9378      0dNh1. 49211900us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9402      0d.h.. 49567061us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9402      0d.h.. 49570459us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9402      0d.h.. 49570492us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9402      0d.h.. 49570515us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9414      0d.h.. 49766609us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9414      0d.h.. 49766956us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9414      0d.h.. 49766980us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9414      0d.h.. 49767077us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--9410      0d.h.. 49899873us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9410      0d.h.. 49903209us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9410      0d.h.. 49903248us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9410      0d.h.. 49903274us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--9423      0d.h.. 50252969us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9423      0d.h.. 50255906us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9423      0d.h.. 50255952us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9423      0d.h.. 50255975us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9439      0d.h1. 50590722us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9439      0d.h1. 50593935us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9439      0d.h1. 50593972us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9439      0d.h1. 50594008us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 50602760us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 50603027us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 50606228us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 50606374us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 50606870us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 50607071us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 50607357us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 50607494us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9452      0d.h.. 51020996us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9452      0d.h.. 51024439us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9452      0d.H.. 51024481us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9452      0d.H.. 51024512us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--9464      0d.h.. 51407405us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9464      0d.h.. 51410835us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9464      0d.h.. 51410876us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9464      0d.h.. 51410908us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--9475      0d.h1. 51751915us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9475      0d.h1. 51755297us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9475      0d.h1. 51755338us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9475      0d.h1. 51755372us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9478      0d.h1. 51849342us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9478      0d.h1. 51849669us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9478      0d.h1. 51849701us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  (spawn)-9478      0d.h1. 51849808us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0d.h2. 52143627us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7341      0d.h2. 52145977us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      0dNH2. 52147152us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7341      0dNH2. 52147191us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  (spawn)-9508      0d.h.. 52518588us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9508      0d.h.. 52521651us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  (spawn)-9508      0d.H.. 52521699us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  (spawn)-9508      0d.H.. 52521739us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--9503      0d.h.. 52910869us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9503      0d.h.. 52913677us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9503      0d.h.. 52913724us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9503      0d.h.. 52913763us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7288      0d.h2. 53295779us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7288      0d.h2. 53295982us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      0dNH2. 53298859us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7288      0dNH2. 53298904us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] ifupdown-9548      0d.h.. 53751187us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ifupdown-9548      0d.h.. 53754567us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9548      0d.h.. 53754617us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ifupdown-9548      0d.h.. 53754659us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] ifupdown-9549      2d.h.. 53766638us : =
irq_handler_entry: irq=3D11 name=3Dvirtio0

[ 1080.076740][    C3] ifupdown-9549      2d.h.. 53766697us : =
irq_handler_exit: irq=3D11 ret=3Dhandled

[ 1080.076740][    C3] kcompact-50        0d.h1. 53942143us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kcompact-50        0d.h1. 53942476us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kcompact-50        0d.h1. 53942517us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kcompact-50        0d.h1. 53942647us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 54121199us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 54121454us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H1. 54131930us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ksoftirq-15        0d.H1. 54135308us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H1. 54135363us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ksoftirq-15        0d.H1. 54135409us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 54161223us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 54161469us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 54168097us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 54168307us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--5247      3d.h.. 54168901us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5247      3d.h.. 54169101us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9564      3d.h.. 54340423us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ifupdown-9564      3d.h.. 54340685us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ifupdown-9564      3d.h.. 54341802us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ifupdown-9564      3d.h.. 54342012us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 54550168us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 54553588us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 54553648us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] ksoftirq-15        0d.H.. 54553694us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 54922399us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 54925330us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 54925385us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 54925434us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 54925615us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 54925663us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7288      0d.h2. 55299875us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7288      0d.h2. 55303071us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      0d.h2. 55303128us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7288      0d.h2. 55303179us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--9596      0d.h.. 55673195us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9596      0d.h.. 55675978us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9596      0dNH.. 55676302us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9596      0dNH.. 55676354us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--9615      3d.h.. 55738923us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9615      3d.h.. 55739176us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9615      3d.h.. 55741705us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9615      3d.h.. 55741805us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9615      3d.h.. 55742504us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9615      3d.h.. 55742668us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9615      3d.h.. 55743092us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9615      3d.h.. 55743186us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h2. 55848751us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h2. 55848964us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h1. 55850734us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h1. 55850907us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 55852241us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 55852398us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 55897894us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 55898085us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 55898796us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 55898956us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 55902205us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 55902376us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 55903424us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 55903605us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 55910579us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 55910748us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9615      3d.h.. 55936239us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9615      3d.h.. 55936421us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 55985573us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 55986969us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNH1. 55987541us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNH1. 55987596us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 56003023us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 56003080us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 56003278us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 56003335us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-4739      0d.h1. 56016697us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-4739      0d.h1. 56017009us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-4739      0d.h1. 56017061us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-4739      0d.h1. 56017187us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 56228925us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 56229145us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h1. 56230705us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h1. 56230897us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 56233959us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 56234135us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56243764us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56243944us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56245281us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56245456us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 56256321us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 56256506us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56299198us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56299411us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56320897us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56321098us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9625      3d.h.. 56344678us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9625      3d.h.. 56344875us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56346125us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56346308us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56348634us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56348813us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56349777us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56349947us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56350621us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56350801us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56351386us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56351565us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56353303us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56353489us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9627      3d.h.. 56354135us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9627      3d.h.. 56354307us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56359202us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56359387us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h1. 56394594us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h1. 56394824us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56443861us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56444062us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56444730us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56444910us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56491042us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56491256us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h1. 56493575us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h1. 56493763us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 56520049us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 56520250us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 56522615us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H.. 56522815us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56541276us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56541476us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56543562us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56543754us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56553051us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56553242us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h1. 56571027us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h1. 56571227us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56573146us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3dnh.. 56573335us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9632      3d.h.. 56586203us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9632      3d.h.. 56586398us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 56604228us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 56604443us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 56618436us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 56618654us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 56623323us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 56623525us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.H.. 56636352us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.H.. 56636563us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 56639931us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 56640118us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.1 56697466us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.1 56697804us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56702952us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56703135us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56703788us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56703974us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 56709940us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 56710138us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 56710973us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 56711167us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56712125us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56712329us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56713047us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56713233us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56714114us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56714301us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56715710us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56715895us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56716849us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56717033us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 56744109us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 56744324us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 56745188us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 56745386us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56752848us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 56753051us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] logrotat-9634      3d.h.. 56780272us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] logrotat-9634      3d.h.. 56780454us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] logrotat-9634      3d.h.. 56781072us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] logrotat-9634      3d.h.. 56781251us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] logrotat-9634      3dNh1. 56791690us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] logrotat-9634      3dNh1. 56791886us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h.. 57048116us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-10        0d.h.. 57050730us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0dNh1. 57050854us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-10        0dNh1. 57050913us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-12        3d.h2. 57069444us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-12        3d.h2. 57069693us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7145      3d.h.. 57073605us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7145      3d.h.. 57073805us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h1. 57080787us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h1. 57080929us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h1. 57081416us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h1. 57081645us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 57081942us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 57082076us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 57091442us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 57091673us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3dNh1. 57110581us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3dNh1. 57110833us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3dNh1. 57121116us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3dNh1. 57121409us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h1. 57122529us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h1. 57122810us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 57124298us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 57124509us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 57125351us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 57125570us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] rs:main -9113      3d.h.. 57126622us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] rs:main -9113      3d.h.. 57126852us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 57127435us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 57127654us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57131935us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57132163us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-9088      3d.h1. 57138722us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-9088      3d.h1. 57138960us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57267606us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57267754us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 57269847us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 57270017us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 57271769us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 57271870us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 57272380us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 57272553us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 57272862us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 57272954us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7324      3d.h.. 57301594us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7324      3d.h.. 57301829us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h1. 57302637us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h1. 57302890us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 57305087us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 57305255us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57306599us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57306786us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57307672us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57307835us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 57308486us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 57308662us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57309821us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 57309989us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3dNh1. 57311663us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3dNh1. 57311830us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 57316797us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 57316970us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h1. 57320168us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h1. 57320342us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 57321232us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 57321400us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 57649553us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 57649766us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 57660089us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 57660283us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 57661809us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3dnh.. 57661925us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 57662424us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 57662605us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 57662933us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 57663038us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h2. 57762959us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h2. 57763177us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h1. 57763801us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h1. 57763979us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h1. 57764577us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h1. 57764753us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 57765289us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 57765466us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h1. 57950570us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h1. 57950810us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 57952833us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 57952999us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7200      3d.h.. 57954182us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7200      3d.h.. 57954278us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h1. 57954850us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h1. 57955008us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h1. 57955350us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h1. 57955444us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 57962394us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 57962672us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7341      3d.h.. 57966577us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7341      3d.h.. 57966788us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 57995819us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 57995980us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 58005060us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 58005261us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.H.. 58006036us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.H.. 58006218us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      3d.h.. 58008741us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7308      3d.h.. 58008928us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      0d.h.. 58086839us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      0d.h.. 58087152us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] systemd--7269      0d.h.. 58087210us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] systemd--7269      0d.h.. 58087337us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] logrotat-9099      3d.h.. 58102105us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] logrotat-9099      3d.h.. 58102277us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] logrotat-9099      3d.h.. 58153311us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] logrotat-9099      3d.h.. 58153482us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7224      3d.h.. 58154222us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7224      3d.h.. 58154387us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] logrotat-9099      3d.h.. 58225180us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] logrotat-9099      3d.h.. 58225351us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.H1. 58226086us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.H1. 58226251us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 58487945us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 58488174us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58490301us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58490499us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58491988us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58492096us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58493125us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58493308us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58493747us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58493896us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-9088      3d.h.. 58545529us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-9088      3d.h.. 58545860us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-9088      3d.H.. 58548164us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-9088      3d.H.. 58548367us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-9088      3d.h1. 58550196us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-9088      3d.h1. 58550391us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-9088      3d.h.. 58551410us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-9088      3d.h.. 58551605us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-9088      3d.h1. 58553043us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-9088      3d.h1. 58553231us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  udevadm-9088      3d.h.. 58575628us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]  udevadm-9088      3d.h.. 58575867us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 58576634us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] ksoftirq-33        3d.H1. 58576826us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 58630070us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 58632376us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0dNh1. 58632481us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0dNh1. 58632557us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58642735us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58642999us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58643990us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58644181us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58651488us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58651699us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58653298us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58653506us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58674918us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58675128us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58679255us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58679459us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58680193us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58680389us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58681063us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58681255us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]     ifup-9647      3d.h.. 58685161us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]     ifup-9647      3d.h.. 58685372us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]     ifup-9647      3d.h1. 58687645us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]     ifup-9647      3d.h1. 58687848us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]     ifup-9647      3d.h.. 58688479us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]     ifup-9647      3d.h.. 58688698us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 58690165us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 58691830us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 58691903us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 58691963us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--5235      3d.h.. 58715914us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--5235      3d.h.. 58716122us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58718084us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58718291us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58719397us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58719604us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58720719us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58720921us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58721884us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58722082us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58723699us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58723898us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58725684us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58725882us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58727649us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58727854us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58751262us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58751478us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58753151us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58753359us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58754762us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58754902us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58755386us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58755596us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58755906us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58756065us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58790159us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58790357us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58791162us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58791305us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58813141us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58813317us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58815179us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58815337us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]     ifup-9647      0d.h.. 58826252us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]     ifup-9647      0d.h.. 58828013us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]     ifup-9647      0d.h.. 58828112us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]     ifup-9647      0d.h.. 58828174us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.H1. 58857274us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.H1. 58857457us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58858112us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58858270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58865453us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58865626us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58866397us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58866573us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58867570us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58867727us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58868830us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58868989us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58870160us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58870320us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58879839us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58880014us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58880633us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58880794us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58881532us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58881698us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58882462us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58882621us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58887951us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58888123us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58888724us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58888886us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58889607us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58889771us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58894296us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58894470us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58895036us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58895198us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58900032us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58900201us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58900754us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58900919us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58901634us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58901802us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58923632us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58923813us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58924359us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 58924533us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59053838us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59054052us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59184956us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59185174us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59185864us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59186052us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59193634us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59193820us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59194605us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59194813us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59195761us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59195934us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59197829us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59198002us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59198973us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59199146us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59208240us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59208432us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59209113us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59209299us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59210096us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59210283us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59211073us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59211250us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59212301us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59212477us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59213624us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59213801us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59214995us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59215175us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3dNh1. 59216379us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3dNh1. 59216589us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59217924us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59218110us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59219274us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59219454us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59220621us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59220801us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59221933us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59222120us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59223313us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59223495us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59224644us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59224840us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59225992us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59226176us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59231558us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59231743us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59232891us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59233073us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59234203us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59234391us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59235568us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59235756us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59236902us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59237094us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59243042us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59243233us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59243917us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59244103us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59244859us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59245059us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59245851us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59246040us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59249173us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59249362us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59250563us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59250775us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59294813us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59294997us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] dhclient-9665      3d.h.. 59296722us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] dhclient-9665      3d.h.. 59296903us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59298119us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59298304us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59299906us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59300088us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59302175us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59302364us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59304337us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59304529us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59307314us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59307515us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] dhclient-9665      3d.h.. 59308924us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] dhclient-9665      3d.h.. 59309106us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59310724us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59310933us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59312853us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59313041us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59315475us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59315696us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59317314us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59317508us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59320430us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59320632us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59322027us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59322211us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59323769us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59323955us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59325684us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59325887us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59365971us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59366180us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59383751us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59383942us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59385719us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59385908us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59389082us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59389270us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59402198us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59402370us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59454637us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59454833us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59462606us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59462798us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 59525690us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 59525817us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1273      1d.h.. 59543210us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3] kworker/-1273      1d.h.. 59543275us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59586932us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59587083us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] modprobe-9675      1d.h.. 59587693us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3] modprobe-9675      1d.h.. 59587797us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59595537us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 59595704us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] modprobe-9681      1d.h1. 59619399us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3] modprobe-9681      1d.h1. 59619511us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 59726429us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 59726584us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 59981855us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 59981964us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60166897us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60167224us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60167325us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60167476us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 60557062us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 60557182us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] systemd--5235      1d.h.. 60561581us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3] systemd--5235      1d.h.. 60561664us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60754259us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60754461us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60757484us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60757674us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60760111us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60760217us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60760719us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60760880us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60761199us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60761296us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60891778us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60893721us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60893788us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60893853us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60897676us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60899261us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60899329us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 60899395us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] kworker/-1007      3d.h.. 60900763us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-1007      3d.h.. 60900986us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60931778us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60931960us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   (sshd)-9697      0d.h1. 60956339us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   (sshd)-9697      0d.h1. 60958094us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   (sshd)-9697      0d.h1. 60958159us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   (sshd)-9697      0d.h1. 60958227us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60998361us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60998566us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60999304us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 60999466us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61003462us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61003637us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61004467us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61004647us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h2. 61005661us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h2. 61005836us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61007115us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61007287us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61008473us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61008653us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9309      0d.h.. 61009586us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9309      0d.h.. 61011175us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--9309      0d.h.. 61011243us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--9309      0d.h.. 61011313us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61011419us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61011605us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61012770us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61012947us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61018740us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61018897us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   (sshd)-9697      1d.h.. 61046911us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   (sshd)-9697      1d.h.. 61047032us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   (sshd)-9697      1d.h.. 61047271us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   (sshd)-9697      1d.h.. 61047342us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61061732us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61061938us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61062682us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61062890us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61077988us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61078185us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61086085us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61086269us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61110316us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61110520us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61111246us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61111421us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61112218us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61112395us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61113189us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61113367us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61114250us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61114430us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61121643us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61121833us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61122547us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61122723us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61123461us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61123657us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61124461us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61124649us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61125627us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61125809us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61130226us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61130411us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61131599us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61131779us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61132934us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61133135us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61134246us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61134432us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61141499us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61141692us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61142359us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61142554us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61156311us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61156510us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61157109us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61157292us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61157984us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61158168us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61221576us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61221791us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61222456us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61222653us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61223426us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61223618us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61224358us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61224558us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61236901us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61237107us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61237773us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61237961us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61238570us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61238786us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61247308us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61247519us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61248204us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61248397us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61266357us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61266574us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61267221us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61267415us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61268273us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61268466us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h2. 61269256us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h2. 61269456us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61291450us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61291648us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61293558us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61293739us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61295032us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61295213us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61325237us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61325425us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61327319us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61327507us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61328873us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61329078us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.H.. 61336452us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.H.. 61336673us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61339349us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61339567us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61341737us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61341943us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h3. 61369506us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h3. 61369725us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61373814us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61374022us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61377076us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61377291us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61378779us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61378986us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61381818us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61382027us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h1. 61384067us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h1. 61384274us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--9698      3d.h.. 61386855us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--9698      3d.h.. 61387066us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.H1. 61528207us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-10        0d.H1. 61530081us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0dNH1. 61530183us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] kworker/-10        0dNH1. 61530254us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 61585291us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.h1. 61586879us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.H1. 61587005us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]   <idle>-0         0d.H1. 61587079us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         1d.h.. 61588599us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]  systemd-1         1d.h.. 61588725us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1273      1d.h.. 61607821us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3] kworker/-1273      1d.h.. 61607896us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61648434us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61649600us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61649669us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61649741us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61649924us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61649998us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 61666569us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 61666686us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61707440us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61708593us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61708663us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61708738us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61708920us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61708996us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61748476us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61748683us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61751919us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 61752117us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61765555us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61766090us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNH1. 61766785us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNH1. 61766809us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61767028us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61767052us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61824031us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61825122us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61825143us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61825167us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61825299us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61825324us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61884266us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61885351us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61885374us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61885400us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61885551us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61885578us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61947337us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61948637us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61948662us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61948690us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61948826us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61948855us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61952938us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61954169us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61954197us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61954227us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61954365us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61954395us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61965509us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61965980us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.H1. 61967115us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.H1. 61967148us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61967310us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61967342us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61971195us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61972620us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61972651us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61972685us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61972831us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61972865us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61975264us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61976743us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.H1. 61976839us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.H1. 61976876us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 61977035us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 61977071us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 62031554us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 62033202us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 62033235us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 62033274us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 62033423us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 62033462us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 62246679us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         0d.h1. 62246991us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 62247028us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]  systemd-1         0d.h1. 62247137us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 62253338us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 62253598us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNh1. 62313747us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNh1. 62315680us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]  systemd-1         0dNh1. 62315718us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0dNh1. 62315759us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]  systemd-1         0d.h1. 62326451us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]  systemd-1         0d.h1. 62326507us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3] systemd--7308      0d.h.. 62342514us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7308      0d.h.. 62342679us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3] systemd--7308      0d.h.. 62342755us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3] systemd--7308      0d.h.. 62342798us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      3d.h.. 62398261us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]    login-9707      3d.h.. 62398527us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] systemd--7288      3d.h.. 62401699us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] systemd--7288      3d.h.. 62401841us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   agetty-9705      3d.H1. 62546052us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   agetty-9705      3d.H1. 62546254us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63533701us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63533749us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63533916us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63533961us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63534479us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63535106us : =
irq_handler_exit: irq=3D4 ret=3Dhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63535147us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63535193us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63535348us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63535394us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63535565us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63535611us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      0dNH1. 63536058us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0dNH1. 63536107us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63536388us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63536437us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]    login-9707      0d.h1. 63536746us : =
irq_handler_entry: irq=3D4 name=3DttyS0

[ 1080.076740][    C3]    login-9707      0d.h1. 63536794us : =
irq_handler_exit: irq=3D4 ret=3Dunhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 63687969us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 63688092us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 64327269us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 64327619us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 64327672us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 64327799us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 65767468us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 65767585us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 66406619us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 66406968us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 66407050us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 66407179us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66568207us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66568414us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66570053us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66570155us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66570685us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66570879us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66571215us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 66571313us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 67847674us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 67847820us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 68486885us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 68487150us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 68487203us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 68487309us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 69927598us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 69927744us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 70567016us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 70567289us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 70567344us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 70567460us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 72007568us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 72007693us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 72647956us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 72648230us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 72648286us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 72648396us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 74087565us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 74087693us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 74728199us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 74728487us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 74728545us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 74728659us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 76167752us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 76167871us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 76806997us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 76807269us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 76807327us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 76807451us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77130036us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77130222us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77131243us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77131415us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77133133us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77133292us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77134100us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77134273us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77134903us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77135052us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77207703us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77207890us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77208650us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77208814us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77209515us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77209678us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77210335us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77210507us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77211198us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77211360us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77212303us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77212474us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77213243us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77213416us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77215916us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77216089us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77217068us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77217243us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77218139us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77218305us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77219012us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77219181us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77219852us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77220017us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77220765us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77220931us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77221632us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77221805us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77222518us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77222707us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77223350us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77223530us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77224166us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77224337us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77224974us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77225143us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77225791us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77225960us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77226697us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77226870us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77227550us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77227718us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77228341us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77228520us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77229146us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77229319us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77229985us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77230156us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77230809us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77230982us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77231594us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77231767us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77232914us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77233090us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77233777us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77233953us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77235919us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 77236100us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 78247355us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 78247493us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 78886846us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 78887160us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 78887228us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 78887378us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 80327567us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 80327696us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80888143us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80888404us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80889154us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80889341us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80890092us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80890277us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80890981us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80891166us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80891831us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80892018us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80892692us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80892881us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80893538us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80893720us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80894378us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80894566us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80895327us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80895523us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h1. 80896188us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h1. 80896393us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80897314us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80897509us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h.. 80899016us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h.. 80899192us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80900195us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80900388us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h.. 80901009us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h.. 80901183us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80902002us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80902181us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h.. 80902871us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h.. 80903047us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80904422us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80904601us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-42        3d.h.. 80905346us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-42        3d.h.. 80905538us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-128       3d.H1. 80906367us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3] kworker/-128       3d.H1. 80906577us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80907802us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80907981us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80908664us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80908860us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80909617us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80909816us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80910466us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80910676us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80911324us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80911531us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80912219us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80912429us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80913048us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80913245us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80913886us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80914079us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80914738us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80914936us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80915882us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80916095us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80917007us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80917211us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80917950us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80918154us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80918863us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 80919063us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 80966777us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 80967096us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 80967162us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 80967297us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82247896us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82248157us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82249482us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82249639us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82250261us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82250489us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82250899us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 82251044us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 82407942us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 82408085us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 83046849us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 83047192us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 83047265us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 83047424us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 84487477us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 84487595us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 85126956us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 85127239us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 85127304us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 85127443us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 86567652us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 86567781us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 87207147us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 87207452us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 87207519us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 87207640us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 87209536us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 87209769us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 87210992us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 87211154us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 88647571us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 88647694us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 89287021us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 89287341us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 89287431us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 89287554us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 89422997us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 89423184us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 90727492us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 90727611us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 91367019us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 91367368us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 91367474us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 91367624us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 91928928us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 91929159us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92248582us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92248811us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92250342us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92250550us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92251558us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92251659us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92252287us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92252449us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92252794us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92252895us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92487563us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92487780us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92488613us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 92488794us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 92807547us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 92807699us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 93447394us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 93447681us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 93447761us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 93447886us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 94887539us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 94887671us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 95526825us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 95527110us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 95527182us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 95527317us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 96967845us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 96967979us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 97607637us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 97607965us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 97608071us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 97608232us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98567817us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98568047us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98569026us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98569146us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98570093us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98570291us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98570887us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 98570993us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 99047572us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 99047704us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 99686820us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 99687104us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 99687245us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 99687321us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 101127576us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 101127710us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 101766832us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 101767067us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 101767114us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 101767191us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 103207567us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 103207677us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 103846815us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 103847075us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 103847106us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 103847210us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 105287480us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 105287615us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 105926789us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 105927069us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 105927100us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 105927212us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 107367641us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 107367751us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 108006664us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 108006917us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 108006949us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 108007046us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 109447574us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 109447683us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 110087523us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 110087773us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 110087804us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 110087888us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 111527600us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 111527736us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]  aoe_tx0-1364      2D.h3. 112009907us : =
irq_handler_entry: irq=3D11 name=3Dvirtio0

[ 1080.076740][    C3]  aoe_tx0-1364      2D.h3. 112009982us : =
irq_handler_exit: irq=3D11 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 112010283us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 112010428us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 112167040us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 112167356us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 112167428us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 112167544us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 113607577us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 113607716us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 114247627us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 114247871us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 114247903us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 114247989us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 115687573us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 115687705us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116167400us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116167646us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116168275us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116168457us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116169531us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116169714us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116170419us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116170607us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116171426us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116171602us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116172254us : =
irq_handler_entry: irq=3D14 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         3d.h1. 116172425us : =
irq_handler_exit: irq=3D14 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 116327406us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 116327651us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 116327684us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 116327771us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 117768027us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 117768193us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 118406909us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 118407170us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 118407226us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 118407314us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 119847589us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 119847748us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 120487531us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 120487832us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 120487877us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 120487990us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 121927636us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 121927783us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 122567009us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 122567334us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 122567382us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 122567500us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 124007610us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 124007756us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 124646843us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 124647150us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 124647196us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 124647313us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 126087487us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 126087635us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 126726805us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 126727070us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 126727110us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 126727204us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 128167588us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 128167728us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 128806735us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 128806991us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 128807045us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 128807141us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 130247610us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 130247747us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 130886845us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 130887113us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 130887156us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 130887253us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 132327563us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 132327712us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 132967311us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 132967568us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 132967613us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 132967711us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 134407612us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 134407760us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 135046865us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 135047133us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 135047179us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 135047280us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 136487488us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 136487629us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 137126949us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 137127223us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 137127291us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 137127393us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 138567574us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 138567726us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 139207058us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 139207320us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 139207369us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 139207471us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 140647808us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 140647932us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 141286964us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 141287282us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 141287344us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 141287469us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 142727828us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 142727982us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 143366891us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 143367220us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 143367283us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 143367408us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 144807747us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 144807902us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 145446993us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 145447300us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 145447365us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 145447495us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 146887757us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 146887880us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 147526958us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 147527278us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 147527346us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 147527478us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 148967651us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 148967800us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 149606732us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 149607014us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 149607070us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 149607179us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 151047516us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 151047648us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 151696725us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 151697003us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-10        0d.h1. 151697060us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-10        0d.h1. 151697170us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 153127608us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 153127793us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 153766843us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 153767131us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 153767195us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 153767308us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 155207579us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 155207728us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 155846896us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 155847168us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 155847228us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 155847341us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 157287498us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 157287641us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 157926822us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 157927108us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 157927170us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 157927285us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 159367601us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 159367746us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 160006783us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 160007072us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 160007135us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 160007251us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 161447573us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 161447727us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 162086872us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 162087197us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 162087270us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 162087409us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 163527571us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 163527722us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 164166728us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 164167103us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 164167190us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 164167353us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 165607563us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 165607724us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 166246846us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 166247214us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 166247306us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 166247474us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 167687520us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 167687683us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 168326776us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 168327059us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 168327127us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 168327264us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 169767496us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 169767661us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 170406702us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 170406994us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 170407063us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 170407187us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 171847532us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 171847696us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 172486920us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 172487203us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 172487274us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 172487399us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]  aoe_tx0-1364      2D.h2. 173450171us : =
irq_handler_entry: irq=3D11 name=3Dvirtio0

[ 1080.076740][    C3]  aoe_tx0-1364      2D.h2. 173450244us : =
irq_handler_exit: irq=3D11 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 173450439us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 173450608us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 173927541us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 173927705us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 174566832us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 174567118us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 174567190us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 174567370us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 176007596us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 176007780us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 176647046us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 176647389us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         0d.h1. 176647463us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3]   <idle>-0         0d.h1. 176647583us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 178087531us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 178087703us : =
irq_handler_exit: irq=3D10 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 178726814us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 178727049us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3] kworker/-1242      0d.h1. 178727074us : =
irq_handler_entry: irq=3D15 name=3Data_piix

[ 1080.076740][    C3] kworker/-1242      0d.h1. 178727156us : =
irq_handler_exit: irq=3D15 ret=3Dhandled

[ 1080.076740][    C3]   <idle>-0         1d.h1. 180167430us : =
irq_handler_entry: irq=3D10 name=3Deth0

[ 1080.076740][    C3]   <idle>-0         1d.h1. 180167595us : =
irq_handler_exit: irq=3D10 ret=3Dhandled


--Apple-Mail=_544FB0F3-7181-41A1-B559-5F64E0DD7181
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

>=20
>> Our reproducer uses mounts a constructed filesystem image.
>>=20
>> The error occurred around line 880 of the code, specifically during
>> the call to csd_lock_wait. The status of CPU 1 (RCU GP kthread):
>> executing the perf_event_open system call, needs to update tracepoint
>=20
> I can't find a perf_event_open() syscall in the C reproducer. So how =
is
> that supposed to be reproduced?
>=20
>> calls on all CPUs, and smp_call_function_many_cond is stuck waiting
>> for CPU 2 to respond to the IPI.  We have reproduced this issue
>> several times on 6.14 again.
>=20
> Again not the latest kernel. Please run it against Linus latest tree =
and
> if it still triggers, provide proper information how to reproduce. If
> not you should be able to bisect the fix.
>=20
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu: 2-...!: (3 GPs behind) idle=3Db834/1/0x4000000000000000 =
softirq=3D23574/23574 fqs=3D5
>> rcu: (detected by 1, t=3D10502 jiffies, g=3D19957, q=3D594 ncpus=3D4)
>=20
> So CPU 1 detects an RCU stall on CPU2
>=20
>> Sending NMI from CPU 1 to CPUs 2:
>> NMI backtrace for cpu 2
>> CPU: 2 UID: 0 PID: 9461 Comm: sshd Not tainted 6.14.0 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
>> RIP: 0010:__lock_acquire+0x106/0x46b0
>> Code: ff df 4c 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 ec 35 00 00 49 8b =
45 00 48 3d a0 c7 8a 93 0f 84 29 0f 00 00 44 8b 05 2a dc 74 0c <45> 85 =
c0 0f 84 ad 06 00 00 48 3d e0 c7 8a 93 0f 84 a1 06 00 00 41
>> RSP: 0018:ffffc90000568ac8 EFLAGS: 00000002
>> RAX: ffffffff9aab9a20 RBX: 0000000000000000 RCX: 1ffff920000ad16c
>> RDX: 1ffffffff35692cf RSI: 0000000000000000 RDI: ffffffff9ab49678
>> RBP: ffff8880201aa480 R08: 0000000000000001 R09: 0000000000000001
>> R10: 0000000000000001 R11: ffffffff90617d17 R12: 0000000000000000
>> R13: ffffffff9ab49678 R14: 0000000000000000 R15: 0000000000000000
>> FS:  00007fa644657900(0000) GS:ffff88802b900000(0000) =
knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f0fa92178a9 CR3: 0000000000e90000 CR4: 0000000000750ef0
>> PKRU: 55555554
>> Call Trace:
>> <NMI>
>> </NMI>
>> <IRQ>
>> lock_acquire+0x1b6/0x570
>> _raw_spin_lock_irqsave+0x3d/0x60
>> debug_object_deactivate+0x139/0x390
>> __hrtimer_run_queues+0x416/0xc30
>> hrtimer_interrupt+0x398/0x890
>> __sysvec_apic_timer_interrupt+0x114/0x400
>> sysvec_apic_timer_interrupt+0xa3/0xc0
>=20
> which handles the timer interrupt. What you cut off in your report is:
>=20
> [  321.491987][    C2] hrtimer: interrupt took 31336677795 ns
>=20
> That means the hrtimer interrupt got stuck for 32 seconds (!!!). That
> warning is only emitted once, so I assume there is something weird =
going
> on with hrtimers and one of their callbacks. But there is no =
indication
> where this comes from.
>=20
> Can you enable the hrtimer_expire_entry/exit tracepoints on the kernel
> command line and add 'ftrace_dump_on_oops' as well, so that the trace
> gets dumped with the rcu stall splat?
>=20
> Thanks,
>=20
>        tglx
>=20
>=20
>=20


--Apple-Mail=_544FB0F3-7181-41A1-B559-5F64E0DD7181--

