Return-Path: <linux-kernel+bounces-848435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3645EBCDC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3E73A5122
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2FD2F8BFA;
	Fri, 10 Oct 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwN1d4G+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2E257AC2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109301; cv=none; b=EJG6sh509kA4cQYU7qZbE38NDDlcLFML/Pc9Wp95tfMXlwepeSrhaHpcu4ohIs1SriZcR+O09NcvumF62fXc4kpyiMQTfw5f0GGtUSyY7diDVb+FqayzOHNKAxk8W62NxBljdk6wFO5lOX4LDtw2VIJyBYC33H+ciGwdm/5pMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109301; c=relaxed/simple;
	bh=GLx0fjSCklF74zEj0uoC/yOLled54tUWxZw60mPFv6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlbUfsFXv4CGuPGjtaxdMC2cccEJE8bXfQ7/OSAwzRLqC1/krZBIe65lrhhYPsUykJQiiTeZuMz/VDdWqNGiBoMtsQLUvpTAHCU+p4+556gorVmRRfLVf4AMYGUgCH9ODf3ONZJZnJBAj7A80jJfbtdhS2Qegxaxo0lIVViNfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwN1d4G+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59093250a7bso192545e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760109297; x=1760714097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dczIBbTGnQLCQAbzklg6jI915mYkTZ5KoQXOxl7w74=;
        b=LwN1d4G+/dPJNTpwZQarnHW6DK1vx/0wtkb0VYhfqTh0ON7KiEH56OjA+AnzlY8O2o
         kgTXkoqWQNcforagMMekvFnmrHTjzxrysHypFcHX0UlJTLL3dp6PgUfwIIpxrQnC1amr
         OCk4w1BjIAs6UculiNdw+NV3tQnaUp/TT2Wko3tKzFW8O7+TDDinErNmFQRmpo3xI1Iy
         SQhWjgHXbGn/Vmhuu/WmY1CPorKyVY/soC9h/+PiCjf4x/LkBu0nI3oynWtah2JveJRs
         9vqJLiYlRgKP9UpyQpzX1Tk6wJ+r92iYmueQgja0i2ACBGElF5S6q2BWnvbOpvQg6J4r
         66EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760109297; x=1760714097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dczIBbTGnQLCQAbzklg6jI915mYkTZ5KoQXOxl7w74=;
        b=p/USN7H5P2EW1X3kOLcnMuJcsJuFs+KYLqQePk0GhiJ8FTxKvMLUJlRvEnWTvXev4+
         tjO7bfwRjd8w73tIF3EWsdDm9Naxu5OepuQVxA4v/h/XFabCF0yMiUWnAWRHKOB+joQM
         rc8j5ZnpnMHNSEO7zH3C1aR+Uay/Gn9AnkHro7aWlOrUgfQoQ1cpm74QZ/aCzIzw22Yc
         8YHwDH6EV5DNzKn+e1qUXTE7rtBiyKR1mLDVI/4yYcmekASr9GiimLnFH95VWTP/+V5X
         oLbXRlHBhf/W4ohnUTjIYyAeHv7e3EXQoNjfBAXMN85ZlLkQCzdCUJobPkFHoknHyc3G
         SRfg==
X-Gm-Message-State: AOJu0Yx1jSzl6VE0Y0M0+dWu4mEO4D+bDJoZ+FIybjXKSVCczGMcRQtf
	v32HHgVz7XJRZlrea5C8zEEIntme/lBx+tPWGxO22MblYP0Svvie3vxg8POqGoxOpIKUDkQ6OhD
	P5iZG+MRlbClPWSlq8cpFQy2a76Z7lY4=
X-Gm-Gg: ASbGncuZLrpr+2RIAO1MlF6wLux47yP+TkaAWM8dpPezQQBUL4depuGA8mB+qh+yIcv
	gESJF+4xwhxnPwamEfBWrTlVZBEM5yVcl/5Ort+MuWla0itbzJZKK0qqrpPg/7nntmy7b+p7T9p
	KsJR/jl6ypuLHg144bs3jkNWi3wRUrXSYTKEVv0z6fN1Zi1P0gYW8eXhZwSyTaU12LuCS99/QCw
	bKqXjO3Onj6GO7HBzJYlDZT6PuRVWGL/YxD7htV4skn+U7GIFRbvWI1jw==
X-Google-Smtp-Source: AGHT+IHiZ1x8QUV4lOoYWZt5v4SzjCu9CZfqnHqMm9X8nlUKRLRoK5yH5B57gMDynkzqniE8o/D7jAYt5t2ESGvCCH0=
X-Received: by 2002:a05:6512:3b8e:b0:58b:211:3317 with SMTP id
 2adb3069b0e04-5906db0cb8cmr3396423e87.11.1760109296773; Fri, 10 Oct 2025
 08:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <87zfa016bd.fsf@osv.gnss.ru> <CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
 <87v7ko11iw.fsf@osv.gnss.ru> <CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
 <87plav2186.fsf@osv.gnss.ru> <CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
 <87y0piiz04.fsf@osv.gnss.ru>
In-Reply-To: <87y0piiz04.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 10 Oct 2025 12:14:44 -0300
X-Gm-Features: AS18NWCxlEa1Tc2vQOQq3BzaIgaOirL_qFErojQdbvQQ1zF2bWgrqIIgjnZfUBA
Message-ID: <CAOMZO5A2YMQQV8J6jg2o0C3qeFif0fSc5j6-98xhqNz=Lk4T+Q@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Angelo Dureghello <angelo@kernel-space.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Fri, Oct 10, 2025 at 11:59=E2=80=AFAM Sergey Organov <sorganov@gmail.com=
> wrote:

> OK, sent resulting u-boot image off-list.

It still boots for me. Please see the log below. I tested several boots.

My board is a very old one, with i.MX6SX version 1.0.

Looking at the commit you mentioned:

https://github.com/nxp-imx/linux-imx/commit/816978f83b1d8dd6ce3bd5dd62223db=
fdf74bdd3

It does add an 'if (imx_get_soc_revision() >=3D IMX_CHIP_REVISION_1_2) '
check, so maybe this cpuidle fix is silicon version dependent?

Such a commit is huge. Could you add only the code under the above
'if' logic to see if it works in mainline?

U-Boot 2016.03-00348-g43bff39513 (Oct 10 2025 - 17:53:30 +0300)

CPU:   Freescale i.MX6SX rev1.0 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 39C
Reset cause: POR
Board: MX6SX SABRE SDB
I2C:   ready
DRAM:  1 GiB
PMIC:  PFUZE100 ID=3D0x10
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
*** Warning - bad CRC, using default environment

Display: Hannstar-XGA (1024x768)
Video: 1024x768x18
In:    serial
Out:   serial
Err:   serial
switch to partitions #0, OK
mmc2 is current device
Net:   FEC [PRIME]
Normal Boot
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc2 is current device
switch to partitions #0, OK
mmc2 is current device
reading boot.scr
** Unable to read file boot.scr **
reading zImage
9815600 bytes read in 472 ms (19.8 MiB/s)
Booting from mmc ...
reading imx6sx-sdb.dtb
40665 bytes read in 17 ms (2.3 MiB/s)
Kernel image @ 0x80800000 [ 0x000000 - 0x95c630 ]
## Flattened Device Tree blob at 83000000
   Booting using the fdt blob at 0x83000000
   Using Device Tree in place at 83000000, end 8300ced8

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.17.0 (fabio@fabio-Precision-3551)
(arm-linux-gnueabihf-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld
(GNU Binutils for Ubuntu) 2.38) #300 SMP Tue Sep 30 16:03:46 -03 2025
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Freescale i.MX6 SoloX SDB RevB Board
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 64 MiB at 0xbc000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080000000-0x00000000afffffff]
[    0.000000]   HighMem  [mem 0x00000000b0000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000bffff=
fff]
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory
node in the DT
[    0.000000] percpu: Embedded 14 pages/cpu s27212 r8192 d21940 u57344
[    0.000000] Kernel command line: console=3Dttymxc0,115200
root=3D/dev/mmcblk3p2 rootwait rw
[    0.000000] printk: log buffer data + meta data: 262144 + 819200 =3D
1081344 bytes
[    0.000000] Dentry cache hash table entries: 131072 (order: 7,
524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 26214=
4
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU event tracing is enabled.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D1=
.
[    0.000000] Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.000000] RCU Tasks Trace: Setting shift to 0 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D1.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76430001
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000001] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000019] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.001477] Console: colour dummy device 80x30
[    0.001528] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.001542] CPU: Testing write buffer coherency: ok
[    0.001599] CPU0: Spectre v2: using BPIALL workaround
[    0.001608] pid_max: default: 32768 minimum: 301
[    0.001774] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[    0.001795] Mountpoint-cache hash table entries: 2048 (order: 1,
8192 bytes, linear)
[    0.002749] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004362] Setting up static identity map for 0x80100000 - 0x80100078
[    0.004684] rcu: Hierarchical SRCU implementation.
[    0.004693] rcu: Max phase no-delay instances is 1000.
[    0.005615] smp: Bringing up secondary CPUs ...
[    0.005646] smp: Brought up 1 node, 1 CPU
[    0.005656] SMP: Total of 1 processors activated (6.00 BogoMIPS).
[    0.005665] CPU: All CPU(s) started in SVC mode.
[    0.005782] Memory: 949792K/1048576K available (14336K kernel code,
1286K rwdata, 4344K rodata, 1024K init, 391K bss, 31376K reserved,
65536K cma-reserved, 196608K highmem)
[    0.006277] devtmpfs: initialized
[    0.014074] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.014549] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.014582] posixtimers hash table entries: 512 (order: 0, 4096
bytes, linear)
[    0.014614] futex hash table entries: 256 (16384 bytes on 1 NUMA
nodes, total 16 KiB, linear).
[    0.016406] pinctrl core: initialized pinctrl subsystem
[    0.017989] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.024565] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.025768] thermal_sys: Registered thermal governor 'step_wise'
[    0.025862] cpuidle: using governor menu
[    0.032358] /soc/bus@2000000/clock-controller@20c4000: Fixed
dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
[    0.032499] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
with /soc/bus@2000000/clock-controller@20c4000
[    0.034753] /soc/bus@2000000/clock-controller@20c4000: Fixed
dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
[    0.034888] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
with /soc/bus@2000000/clock-controller@20c4000
[    0.042579] mxs_phy 20c9000.usbphy: supply phy-3p0 not found, using
dummy regulator
[    0.043218] mxs_phy 20ca000.usbphy: supply phy-3p0 not found, using
dummy regulator
[    0.044533] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
with /soc/bus@2000000/clock-controller@20c4000
[    0.056050] /soc/bus@2200000/spba-bus@2240000/lcdif@2220000: Fixed
dependency cycle(s) with /panel
[    0.056162] /panel: Fixed dependency cycle(s) with
/soc/bus@2200000/spba-bus@2240000/lcdif@2220000
[    0.057453] No ATAGs?
[    0.057523] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.057537] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.059736] imx6sx-pinctrl 20e0000.pinctrl: initialized IMX pinctrl driv=
er
[    0.065156] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    0.066895] gpio gpiochip0: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.069262] gpio gpiochip1: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.071608] gpio gpiochip2: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.073754] gpio gpiochip3: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.075952] gpio gpiochip4: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.078113] gpio gpiochip5: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.080306] gpio gpiochip6: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.090379] SCSI subsystem initialized
[    0.091281] usbcore: registered new interface driver usbfs
[    0.091334] usbcore: registered new interface driver hub
[    0.091387] usbcore: registered new device driver usb
[    0.091575] usb_phy_generic usbphynop1: dummy supplies not allowed
for exclusive requests (id=3Dvbus)
[    0.093585] i2c i2c-0: IMX I2C adapter registered
[    0.094270] i2c i2c-2: IMX I2C adapter registered
[    0.095330] i2c i2c-3: IMX I2C adapter registered
[    0.096127] mc: Linux media interface: v0.10
[    0.096213] videodev: Linux video capture interface: v2.00
[    0.096348] pps_core: LinuxPPS API ver. 1 registered
[    0.096356] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.096378] PTP clock support registered
[    0.097142] Advanced Linux Sound Architecture Driver Initialized.
[    0.098606] Bluetooth: Core ver 2.22
[    0.098680] NET: Registered PF_BLUETOOTH protocol family
[    0.098688] Bluetooth: HCI device and connection manager initialized
[    0.098704] Bluetooth: HCI socket layer initialized
[    0.098713] Bluetooth: L2CAP socket layer initialized
[    0.098740] Bluetooth: SCO socket layer initialized
[    0.099388] vgaarb: loaded
[    0.099866] clocksource: Switched to clocksource mxc_timer1
[    0.100243] VFS: Disk quotas dquot_6.6.0
[    0.100297] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.113300] NET: Registered PF_INET protocol family
[    0.113594] IP idents hash table entries: 16384 (order: 5, 131072
bytes, linear)
[    0.115446] tcp_listen_portaddr_hash hash table entries: 512
(order: 0, 4096 bytes, linear)
[    0.115483] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.115791] TCP established hash table entries: 8192 (order: 3,
32768 bytes, linear)
[    0.115882] TCP bind hash table entries: 8192 (order: 5, 131072
bytes, linear)
[    0.116123] TCP: Hash tables configured (established 8192 bind 8192)
[    0.116282] UDP hash table entries: 512 (order: 2, 28672 bytes, linear)
[    0.116361] UDP-Lite hash table entries: 512 (order: 2, 28672 bytes, lin=
ear)
[    0.116607] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.117304] RPC: Registered named UNIX socket transport module.
[    0.117318] RPC: Registered udp transport module.
[    0.117323] RPC: Registered tcp transport module.
[    0.117327] RPC: Registered tcp-with-tls transport module.
[    0.117331] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.118908] PCI: CLS 0 bytes, default 64
[    0.120731] Initialise system trusted keyrings
[    0.121048] workingset: timestamp_bits=3D30 max_order=3D18 bucket_order=
=3D0
[    0.121934] NFS: Registering the id_resolver key type
[    0.121994] Key type id_resolver registered
[    0.122001] Key type id_legacy registered
[    0.122033] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.122041] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    0.122111] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.122514] fuse: init (API version 7.44)
[    0.325506] Key type asymmetric registered
[    0.325520] Asymmetric key parser 'x509' registered
[    0.325595] io scheduler mq-deadline registered
[    0.325605] io scheduler kyber registered
[    0.325639] io scheduler bfq registered
[    0.340443] mxs-dma 1804000.dma-controller: initialized
[    0.349829] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq =3D 266,
base_baud =3D 1500000) is a IMX
[    0.350414] pfuze100-regulator 0-0008: Full layer: 2, Metal layer: 1
[    0.350482] printk: console [ttymxc0] enabled
[    0.387965] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
[    0.387981] pfuze100-regulator 0-0008: pfuze200 found.
[    1.183507] 21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq =3D 267,
base_baud =3D 1500000) is a IMX
[    1.337218] [drm] Initialized mxsfb-drm 1.0.0 for 2220000.lcdif on minor=
 0
[    1.487388] Console: switching to colour frame buffer device 100x30
[    1.503746] mxsfb 2220000.lcdif: [drm] fb0: mxsfb-drmdrmfb frame
buffer device
[    1.525732] brd: module loaded
[    1.536673] loop: module loaded
[    1.545484] spi-nor spi5.0: supply vcc not found, using dummy regulator
[    1.552759] spi-nor spi5.0: found s25fl128s1, expected n25q256a
[    1.561432] spi-nor spi5.2: supply vcc not found, using dummy regulator
[    1.568525] spi-nor spi5.2: found s25fl128s1, expected n25q256a
[    1.579368] CAN device driver interface
[    1.585042] flexcan 2090000.can: registering netdev failed
[    1.590713] flexcan 2090000.can: probe with driver flexcan failed
with error -110
[    1.600009] flexcan 2094000.can: registering netdev failed
[    1.605628] flexcan 2094000.can: probe with driver flexcan failed
with error -110
[    1.629432] fec 2188000.ethernet eth0: registered PHC device 0
[    1.639049] fec 21b4000.ethernet: Invalid MAC address: 00:00:00:00:00:00
[    1.639125] fec 21b4000.ethernet: Using random MAC address: ba:03:d1:6c:=
c7:04
[    1.775691] fec 21b4000.ethernet eth1: registered PHC device 1
[    1.782537] usbcore: registered new device driver r8152-cfgselector
[    1.788982] usbcore: registered new interface driver r8152
[    1.794672] usbcore: registered new interface driver lan78xx
[    1.800571] usbcore: registered new interface driver asix
[    1.806100] usbcore: registered new interface driver ax88179_178a
[    1.812353] usbcore: registered new interface driver cdc_ether
[    1.818311] usbcore: registered new interface driver smsc95xx
[    1.824191] usbcore: registered new interface driver net1080
[    1.829992] usbcore: registered new interface driver cdc_subset
[    1.836040] usbcore: registered new interface driver zaurus
[    1.841746] usbcore: registered new interface driver MOSCHIP
usb-ethernet driver
[    1.849245] usbcore: registered new interface driver cdc_ncm
[    1.855064] usbcore: registered new interface driver r8153_ecm
[    1.861109] usbcore: registered new interface driver usb-storage
[    1.867603] usbcore: registered new device driver onboard-usb-dev
[    1.877367] imx_usb 2184000.usb: No over current polarity defined
[    1.890450] imx_usb 2184200.usb: No over current polarity defined
[    1.900917] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.905904] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    1.929895] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.935605] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.17
[    1.935639] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    1.935654] usb usb1: Product: EHCI Host Controller
[    1.935665] usb usb1: Manufacturer: Linux 6.17.0 ehci_hcd
[    1.935674] usb usb1: SerialNumber: ci_hdrc.1
[    1.966848] hub 1-0:1.0: USB hub found
[    1.970849] hub 1-0:1.0: 1 port detected
[    1.977715] input: 20cc000.snvs:snvs-powerkey as
/devices/platform/soc/2000000.bus/20cc000.snvs/20cc000.snvs:snvs-powerkey/i=
nput/input0
[    1.994792] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc0
[    2.001658] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock
to 1970-01-01T00:00:00 UTC (0)
[    2.010988] i2c_dev: i2c /dev entries driver
[    2.022001] Bluetooth: HCI UART driver ver 2.3
[    2.022058] Bluetooth: HCI UART protocol H4 registered
[    2.031844] Bluetooth: HCI UART protocol LL registered
[    2.037232] Bluetooth: HCI UART protocol Broadcom registered
[    2.043814] sdhci: Secure Digital Host Controller Interface driver
[    2.043827] sdhci: Copyright(c) Pierre Ossman
[    2.043833] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.064906] sdhci-esdhc-imx 2198000.mmc: Got CD GPIO
[    2.071475] caam 2100000.crypto: Entropy delay =3D 12000
[    2.077833] sdhci-esdhc-imx 219c000.mmc: Got CD GPIO
[    2.118166] caam 2100000.crypto: Instantiated RNG4 SH0
[    2.164774] caam 2100000.crypto: Instantiated RNG4 SH1
[    2.164929] sdhci-esdhc-imx 2198000.mmc: Got WP GPIO
[    2.165540] sdhci-esdhc-imx 219c000.mmc: Got WP GPIO
[    2.181212] mmc1: SDHCI controller on 2194000.mmc [2194000.mmc] using AD=
MA
[    2.196638] caam 2100000.crypto: device ID =3D 0x0a16010000000200 (Era 4=
)
[    2.196687] caam 2100000.crypto: job rings =3D 2, qi =3D 0
[    2.214056] caam algorithms registered in /proc/crypto
[    2.219700] caam 2100000.crypto: registering rng-caam
[    2.225373] caam 2100000.crypto: rng crypto API alg registered prng-caam
[    2.232978] mmc3: SDHCI controller on 219c000.mmc [219c000.mmc] using AD=
MA
[    2.240337] mmc2: SDHCI controller on 2198000.mmc [2198000.mmc] using AD=
MA
[    2.250853] usbcore: registered new interface driver usbhid
[    2.250893] usbhid: USB HID core driver
[    2.263780] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 (8000003f) counters available
[    2.283526] wm8962 3-001a: customer id 0 revision D
[    2.311610] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.318944] random: crng init done
[    2.322888] mmc3: new high speed SDHC card at address aaaa
[    2.329640] mmcblk3: mmc3:aaaa SE32G 29.7 GiB
[    2.338439]  mmcblk3: p1 p2
[    2.343718] NET: Registered PF_INET6 protocol family
[    2.350820] Segment Routing with IPv6
[    2.354736] In-situ OAM (IOAM) with IPv6
[    2.358922] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.366139] NET: Registered PF_PACKET protocol family
[    2.366184] can: controller area network core
[    2.375991] NET: Registered PF_CAN protocol family
[    2.376047] can: raw protocol
[    2.383943] can: broadcast manager protocol
[    2.388235] can: netlink gateway - max_hops=3D1
[    2.393006] Key type dns_resolver registered
[    2.398331] Registering SWP/SWPB emulation handler
[    2.415530] Loading compiled-in X.509 certificates
[    2.453192] imx6q-pcie 8ffc000.pcie: host bridge /soc/pcie@8ffc000 range=
s:
[    2.453291] imx6q-pcie 8ffc000.pcie:       IO
0x0008f80000..0x0008f8ffff -> 0x0000000000
[    2.453331] imx6q-pcie 8ffc000.pcie:      MEM
0x0008000000..0x0008efffff -> 0x0008000000
[    2.453449] imx6q-pcie 8ffc000.pcie: config reg[1] 0x08f00000 =3D=3D
cpu 0x08f00000
[    2.453449] ; no fixup was ever needed for this devicetree
[    2.494497] mmc1: Failed to initialize a non-removable card
[    2.494997] etnaviv etnaviv: bound 1800000.gpu (ops 0xc0fcdba8)
[    2.507464] etnaviv-gpu 1800000.gpu: model: GC400, revision: 4645
[    2.514044] etnaviv-gpu 1800000.gpu: Need to move linear window on
MC1.0, disabling TS
[    2.522615] [drm] Initialized etnaviv 1.4.0 for etnaviv on minor 1
[    2.533387] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.544977] imx_thermal 20c8000.anatop:tempmon: Extended Commercial
CPU temperature grade - max:105C critical:100C passive:95C
[    2.561969] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.573622] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.583157] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    2.593285] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.602850] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    2.613612] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.621522] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    2.628814] clk: Disabling unused clocks
[    2.632933] faux_driver regulatory: Direct firmware load for
regulatory.db failed with error -2
[    2.641806] cfg80211: failed to load regulatory.db
[    2.646897] PM: genpd: Disabling unused power domains
[    2.652154] ALSA device list:
[    2.655186]   #0: ASRC-M2M
[    2.658111] check access for rdinit=3D/init failed: -2, ignoring
[    2.691677] imx6q-pcie 8ffc000.pcie: iATU: unroll F, 4 ob, 4 ib,
align 64K, limit 4G
[    2.699842] imx6q-pcie 8ffc000.pcie: Link: Only Gen1 is enabled
[    3.690100] imx6q-pcie 8ffc000.pcie: Phy link never came up
[    3.697182] imx6q-pcie 8ffc000.pcie: PCI host bridge to bus 0000:00
[    3.703916] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.709667] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    3.716597] pci_bus 0000:00: root bus resource [mem 0x08000000-0x08effff=
f]
[    3.724048] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
PCIe Root Port
[    3.724254] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[    3.724325] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    3.724379] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    3.724438] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    3.724488] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff=
]
[    3.724541] pci 0000:00:00.0:   bridge window [mem
0x00000000-0x000fffff pref]
[    3.770719] pci 0000:00:00.0: supports D1
[    3.770742] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    3.783481] PCI: bus0: Fast back to back transfers disabled
[    3.789368] PCI: bus1: Fast back to back transfers enabled
[    3.795042] pci 0000:00:00.0: BAR 0 [mem 0x08000000-0x080fffff]: assigne=
d
[    3.795081] pci 0000:00:00.0: ROM [mem 0x08100000-0x0810ffff pref]: assi=
gned
[    3.795098] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    3.795115] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    3.795126] pci_bus 0000:00: resource 5 [mem 0x08000000-0x08efffff]
[    3.829022] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    3.906629] EXT4-fs (mmcblk3p2): recovery complete
[    3.913008] EXT4-fs (mmcblk3p2): mounted filesystem
d5a64ac5-7eae-43d4-a70e-6936f55c77f6 r/w with ordered data mode. Quota
mode: none.
[    3.925333] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    3.933683] devtmpfs: mounted
[    3.937597] Freeing unused kernel image (initmem) memory: 1024K
[    3.943900] Run /sbin/init as init process
[    4.109987] EXT4-fs (mmcblk3p2): re-mounted
d5a64ac5-7eae-43d4-a70e-6936f55c77f6.
Seeding 256 bits and crediting
Saving 256 bits of creditable seed for next boot
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [    4.356949] udevd[101]: starting version 3.2=
.14
[    4.413840] udevd[102]: starting eudev-3.2.14
done
Starting network: OK
Starting crond: OK

Welcome to Buildroot
buildroot login: root
# uname -r
6.17.0

