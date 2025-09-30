Return-Path: <linux-kernel+bounces-838087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6FDBAE670
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D1F320522
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74A2853F2;
	Tue, 30 Sep 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIXfduhq"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E02848A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259370; cv=none; b=a6Xe/OVYpzslYhNWOu91tCfdNCJFc19PyYwJjH4hMtvIVa6BL25cbTUVyD0tzRbhvs3TanexQPasrGvn99urUcoTtphPTDTCVMV7i2EnigEmhozZY92T6xPjNGbdc2h8L+vuH7TRCrALz1z+O6a7bZfuaTJoSkbPIKUfYweIQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259370; c=relaxed/simple;
	bh=bbZxvIy2hbJe7+pgf3XglY+1Tet2ksdvpRtPVzhGnS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItRmnhm7WFcLjXJb5J7R8DwNFyEuin5+nIgtKYVLe5a4g5DJvr5y7Cz6vrVw+EsHxKabi/SmkrSdKg/gvo0h+APrWVnr3QsRErqeIdJrfgFjgCh9L0EhI8xmf+nioCjEMvQdnYDXTXc8fNxFYzqkJtWfj9ltADBlkwUzcg4ob+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIXfduhq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-371e4858f74so2530771fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759259366; x=1759864166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr2i4Zt3ljJvXz2aVr8Ei43WbyDqLQIKGEe96L2A+QU=;
        b=RIXfduhqIEp/n9i0OIjOCuMtfJ2uu1tvbPta+fJ5g6NvIaAq4aEF5XNNvKl2NiIKgN
         3j48PR1E00Oe+t+Rzi+b0If8ZLwiLqN077FValyCdW/KNdPw8hDs2zWdkbI0j4ZJdQm5
         mupcbhEH+MHEkX2dq9/DkfZvFF4k2xHFB7BFZ3/4AkehNkbbZt4l+HsnefYBM8Ph/BRE
         8DGKKXAkEvupKHZe6h252/uPGhexJ3QeeyHAQ25bFQY3aMiCNGF5AG/6KcklszNQbEbm
         BrMg/Vl6UZgKhWaRpPMSUyZeQUYeCbPTrPcMMrqPXh9flbFmXrBfmUCF6YfbdhyYLaJZ
         tMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259366; x=1759864166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr2i4Zt3ljJvXz2aVr8Ei43WbyDqLQIKGEe96L2A+QU=;
        b=SdU0Cjf2PJsPSIfaG0RK8fRfNuapDnY2HZSMSn9HFYrnCZqAWbFOzBC1Mi4JCm1tNp
         YRv34sf82d+A2umfgNiIYkXBlDypdqVr+vIoOa6F0sMt2q+9sd0ZooUCa4fM0zxl57sC
         DE710aggEmuVUIf/7g4vZyDrAHZwt1pPRp9aBZ25jM6w4MVw3sXfLkLo5rrzc72elslf
         RrolKTngNRMQy9uZbXA92uUDobIgoUJCmm5UbHYFZ1iX5Lj/Sn/g7+JEcRD3UAxP0I3k
         hRxn4lZdSAEwwHEetQRQbDUZffSY+61iKzZFfL0jMpTG11+TmdQhRTPIrQ1JB8bGL8tu
         pWVw==
X-Gm-Message-State: AOJu0YxFKSGT4PYItDD02MDVdAjm0o36bDKqnLHCXIoPaCnMno3qdCqh
	zTtmB3lTYQwRDYPjlOKrDiMczsnrNBhu3QCetUH3Y6oFLgDLt9BnUuDc+rQUmFI5HIbU/BI8n5n
	NAmOREPdpNyIcTgBlZV/KtHdjnoGbAN4=
X-Gm-Gg: ASbGncs0E3QsKhx6lDkQ6dMoBPXJQwU2oXziP5sfEVuPwJBqwlTbKNK3bXOoPFpqNcx
	tsxhX+ZDs/6Q3Br1w1GN85M7iYQMF5kDIZEtiJggaQ2F7xpLN509gTIswKfmCINmY/itpipXeU8
	g8cc/QibfokU7FwMgPHOhipTEsIJXIQ7OUjyeZLnFQDxxgsNP77OzaLxoYxkMVUuwnWvEykrbQc
	fkI1NSeO080Fus3CrN3xZKkdpsPm/dmwdNUViR0FcRk+K35MIKuTZdYh4zIhzQ=
X-Google-Smtp-Source: AGHT+IH09+1GgISZlww6rJBm+ynvYOWvA4/6w7K2PpR3uYUvgVaJlWKh5NJvoZ85tmLedChQtyaTYzqNBnxQkewcPnA=
X-Received: by 2002:a05:651c:25ce:10b0:369:26f1:c428 with SMTP id
 38308e7fff4ca-372ffc59b70mr13500791fa.15.1759259365713; Tue, 30 Sep 2025
 12:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru>
In-Reply-To: <87v7l03pqe.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Sep 2025 16:09:13 -0300
X-Gm-Features: AS18NWBkyAiH9GYbiyKwFDT2szrZBm6BTp6R_LzFvbns1Bril1GTr4W6dPuF5f4
Message-ID: <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Tue, Sep 30, 2025 at 12:49=E2=80=AFPM Sergey Organov <sorganov@gmail.com=
> wrote:
>
> Hello,
>
> I'm looking for help with the following issue.
>
> I'm trying to upgrade kernel on my custom iMX6sx board from very old
> 4.9.146 to resent 6.17. The board has eMMC connected to usdhc4, and
> u-boot happily starts kernel from eMMC. The kernel boot sequence,
> however, hangs waiting for root file-system as it doesn't see eMMC.

I tried booting 6.17 on an imx6sx-sdb board and it booted successfully:

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.17.0 (fabio@fabio-Precision-3551)
(arm-linux-gnueabihf-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld
(GNU Binutils for Ubuntu) 2.38) #300 SMP Tue Sep 30 16:03:46 -03 2025
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Freescale i.MX6 SoloX SDB RevA Board
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
root=3DPARTUUID=3D00000000-02 rootwait rw
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
[    0.000020] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.001475] Console: colour dummy device 80x30
[    0.001526] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.001540] CPU: Testing write buffer coherency: ok
[    0.001596] CPU0: Spectre v2: using BPIALL workaround
[    0.001604] pid_max: default: 32768 minimum: 301
[    0.001771] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[    0.001791] Mountpoint-cache hash table entries: 2048 (order: 1,
8192 bytes, linear)
[    0.002740] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004348] Setting up static identity map for 0x80100000 - 0x80100078
[    0.004671] rcu: Hierarchical SRCU implementation.
[    0.004680] rcu: Max phase no-delay instances is 1000.
[    0.005605] smp: Bringing up secondary CPUs ...
[    0.005634] smp: Brought up 1 node, 1 CPU
[    0.005644] SMP: Total of 1 processors activated (6.00 BogoMIPS).
[    0.005654] CPU: All CPU(s) started in SVC mode.
[    0.005770] Memory: 949784K/1048576K available (14336K kernel code,
1286K rwdata, 4344K rodata, 1024K init, 391K bss, 31384K reserved,
65536K cma-reserved, 196608K highmem)
[    0.006276] devtmpfs: initialized
[    0.014120] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.014588] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.014622] posixtimers hash table entries: 512 (order: 0, 4096
bytes, linear)
[    0.014654] futex hash table entries: 256 (16384 bytes on 1 NUMA
nodes, total 16 KiB, linear).
[    0.016481] pinctrl core: initialized pinctrl subsystem
[    0.018074] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.024573] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.025789] thermal_sys: Registered thermal governor 'step_wise'
[    0.025879] cpuidle: using governor menu
[    0.032394] /soc/bus@2000000/clock-controller@20c4000: Fixed
dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
[    0.032536] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
with /soc/bus@2000000/clock-controller@20c4000
[    0.034758] /soc/bus@2000000/clock-controller@20c4000: Fixed
dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
[    0.034894] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
with /soc/bus@2000000/clock-controller@20c4000
[    0.045375] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
with /soc/bus@2000000/clock-controller@20c4000
[    0.057574] /soc/bus@2200000/spba-bus@2240000/lcdif@2220000: Fixed
dependency cycle(s) with /panel
[    0.057688] /panel: Fixed dependency cycle(s) with
/soc/bus@2200000/spba-bus@2240000/lcdif@2220000
[    0.059094] No ATAGs?
[    0.059166] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.059179] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.061584] imx6sx-pinctrl 20e0000.pinctrl: initialized IMX pinctrl driv=
er
[    0.066796] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    0.068582] gpio gpiochip0: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.071039] gpio gpiochip1: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.073218] gpio gpiochip2: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.075369] gpio gpiochip3: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.077550] gpio gpiochip4: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.079720] gpio gpiochip5: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.082054] gpio gpiochip6: Static allocation of GPIO base is
deprecated, use dynamic allocation.
[    0.092467] SCSI subsystem initialized
[    0.093116] usbcore: registered new interface driver usbfs
[    0.093172] usbcore: registered new interface driver hub
[    0.093222] usbcore: registered new device driver usb
[    0.093410] usb_phy_generic usbphynop1: dummy supplies not allowed
for exclusive requests (id=3Dvbus)
[    0.095428] i2c i2c-0: IMX I2C adapter registered
[    0.096109] i2c i2c-2: IMX I2C adapter registered
[    0.097172] i2c i2c-3: IMX I2C adapter registered
[    0.097952] mc: Linux media interface: v0.10
[    0.098037] videodev: Linux video capture interface: v2.00
[    0.098172] pps_core: LinuxPPS API ver. 1 registered
[    0.098180] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.098202] PTP clock support registered
[    0.098983] Advanced Linux Sound Architecture Driver Initialized.
[    0.100422] Bluetooth: Core ver 2.22
[    0.100484] NET: Registered PF_BLUETOOTH protocol family
[    0.100491] Bluetooth: HCI device and connection manager initialized
[    0.100507] Bluetooth: HCI socket layer initialized
[    0.100516] Bluetooth: L2CAP socket layer initialized
[    0.100533] Bluetooth: SCO socket layer initialized
[    0.101476] vgaarb: loaded
[    0.101970] clocksource: Switched to clocksource mxc_timer1
[    0.102328] VFS: Disk quotas dquot_6.6.0
[    0.102383] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.115216] NET: Registered PF_INET protocol family
[    0.115511] IP idents hash table entries: 16384 (order: 5, 131072
bytes, linear)
[    0.117359] tcp_listen_portaddr_hash hash table entries: 512
(order: 0, 4096 bytes, linear)
[    0.117397] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.117698] TCP established hash table entries: 8192 (order: 3,
32768 bytes, linear)
[    0.117788] TCP bind hash table entries: 8192 (order: 5, 131072
bytes, linear)
[    0.118029] TCP: Hash tables configured (established 8192 bind 8192)
[    0.118179] UDP hash table entries: 512 (order: 2, 28672 bytes, linear)
[    0.118258] UDP-Lite hash table entries: 512 (order: 2, 28672 bytes, lin=
ear)
[    0.118501] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.119221] RPC: Registered named UNIX socket transport module.
[    0.119235] RPC: Registered udp transport module.
[    0.119239] RPC: Registered tcp transport module.
[    0.119244] RPC: Registered tcp-with-tls transport module.
[    0.119248] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.120819] PCI: CLS 0 bytes, default 64
[    0.122622] Initialise system trusted keyrings
[    0.122971] workingset: timestamp_bits=3D30 max_order=3D18 bucket_order=
=3D0
[    0.123839] NFS: Registering the id_resolver key type
[    0.123885] Key type id_resolver registered
[    0.123892] Key type id_legacy registered
[    0.123924] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.123931] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    0.124001] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.124405] fuse: init (API version 7.44)
[    0.327260] Key type asymmetric registered
[    0.327276] Asymmetric key parser 'x509' registered
[    0.327351] io scheduler mq-deadline registered
[    0.327362] io scheduler kyber registered
[    0.327394] io scheduler bfq registered
[    0.341926] mxs-dma 1804000.dma-controller: initialized
[    0.352497] pfuze100-regulator 0-0008: Full layer: 2, Metal layer: 1
[    0.353080] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq =3D 266,
base_baud =3D 1500000) is a IMX
[    0.353315] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
[    0.353332] pfuze100-regulator 0-0008: pfuze100 found.
[    0.354080] printk: console [ttymxc0] enabled
[    1.297461] 21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq =3D 267,
base_baud =3D 1500000) is a IMX
[    1.325646] etnaviv etnaviv: bound 1800000.gpu (ops 0xc0fcdba8)
[    1.332307] etnaviv-gpu 1800000.gpu: model: GC400, revision: 4645
[    1.338763] etnaviv-gpu 1800000.gpu: Need to move linear window on
MC1.0, disabling TS
[    1.347488] [drm] Initialized etnaviv 1.4.0 for etnaviv on minor 0
[    1.356326] [drm] Initialized mxsfb-drm 1.0.0 for 2220000.lcdif on minor=
 1
[    1.509483] Console: switching to colour frame buffer device 100x30
[    1.525838] mxsfb 2220000.lcdif: [drm] fb0: mxsfb-drmdrmfb frame
buffer device
[    1.547910] brd: module loaded
[    1.558833] loop: module loaded
[    1.567600] spi-nor spi5.0: supply vcc not found, using dummy regulator
[    1.577426] spi-nor spi5.2: supply vcc not found, using dummy regulator
[    1.589284] CAN device driver interface
[    1.595023] flexcan 2090000.can: registering netdev failed
[    1.600603] flexcan 2090000.can: probe with driver flexcan failed
with error -110
[    1.609965] flexcan 2094000.can: registering netdev failed
[    1.615633] flexcan 2094000.can: probe with driver flexcan failed
with error -110
[    1.632998] fec 2188000.ethernet: Invalid MAC address: 00:00:00:00:00:00
[    1.633075] fec 2188000.ethernet: Using random MAC address: 5a:54:5d:3a:=
ce:b8
[    1.653724] fec 2188000.ethernet eth0: registered PHC device 0
[    1.663301] fec 21b4000.ethernet: Invalid MAC address: 00:00:00:00:00:00
[    1.663376] fec 21b4000.ethernet: Using random MAC address: 8e:50:50:68:=
f7:cd
[    1.800016] fec 21b4000.ethernet eth1: registered PHC device 1
[    1.806868] usbcore: registered new device driver r8152-cfgselector
[    1.813379] usbcore: registered new interface driver r8152
[    1.818997] usbcore: registered new interface driver lan78xx
[    1.824849] usbcore: registered new interface driver asix
[    1.830361] usbcore: registered new interface driver ax88179_178a
[    1.836622] usbcore: registered new interface driver cdc_ether
[    1.842619] usbcore: registered new interface driver smsc95xx
[    1.848471] usbcore: registered new interface driver net1080
[    1.854262] usbcore: registered new interface driver cdc_subset
[    1.860293] usbcore: registered new interface driver zaurus
[    1.865997] usbcore: registered new interface driver MOSCHIP
usb-ethernet driver
[    1.866060] usbcore: registered new interface driver cdc_ncm
[    1.866116] usbcore: registered new interface driver r8153_ecm
[    1.866242] usbcore: registered new interface driver usb-storage
[    1.866671] usbcore: registered new device driver onboard-usb-dev
[    1.870106] imx_usb 2184000.usb: No over current polarity defined
[    1.914000] imx_usb 2184200.usb: No over current polarity defined
[    1.924420] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.929494] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    1.952000] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.957723] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.17
[    1.957757] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    1.957772] usb usb1: Product: EHCI Host Controller
[    1.957783] usb usb1: Manufacturer: Linux 6.17.0 ehci_hcd
[    1.957794] usb usb1: SerialNumber: ci_hdrc.1
[    1.988868] hub 1-0:1.0: USB hub found
[    1.992869] hub 1-0:1.0: 1 port detected
[    1.999706] input: 20cc000.snvs:snvs-powerkey as
/devices/platform/soc/2000000.bus/20cc000.snvs/20cc000.snvs:snvs-powerkey/i=
nput/input0
[    2.016843] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc0
[    2.023414] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock
to 1970-01-01T00:00:00 UTC (0)
[    2.032763] i2c_dev: i2c /dev entries driver
[    2.043669] Bluetooth: HCI UART driver ver 2.3
[    2.043723] Bluetooth: HCI UART protocol H4 registered
[    2.053492] Bluetooth: HCI UART protocol LL registered
[    2.058879] Bluetooth: HCI UART protocol Broadcom registered
[    2.065533] sdhci: Secure Digital Host Controller Interface driver
[    2.065575] sdhci: Copyright(c) Pierre Ossman
[    2.065584] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.085924] sdhci-esdhc-imx 2198000.mmc: Got CD GPIO
[    2.091064] sdhci-esdhc-imx 2198000.mmc: Got WP GPIO
[    2.098186] sdhci-esdhc-imx 219c000.mmc: Got CD GPIO
[    2.103406] sdhci-esdhc-imx 219c000.mmc: Got WP GPIO
[    2.110029] caam 2100000.crypto: device ID =3D 0x0a16010000000200 (Era 4=
)
[    2.110090] caam 2100000.crypto: job rings =3D 2, qi =3D 0
[    2.129362] caam algorithms registered in /proc/crypto
[    2.134904] caam 2100000.crypto: registering rng-caam
[    2.140299] caam 2100000.crypto: rng crypto API alg registered prng-caam
[    2.149857] usbcore: registered new interface driver usbhid
[    2.149909] usbhid: USB HID core driver
[    2.160041] mmc1: SDHCI controller on 2194000.mmc [2194000.mmc] using AD=
MA
[    2.168084] mmc3: SDHCI controller on 219c000.mmc [219c000.mmc] using AD=
MA
[    2.175706] mmc2: SDHCI controller on 2198000.mmc [2198000.mmc] using AD=
MA
[    2.186875] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 (8000003f) counters available
[    2.206484] wm8962 3-001a: customer id 0 revision D
[    2.234678] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.242411] mmc3: new high speed SDHC card at address aaaa
[    2.249018] mmcblk3: mmc3:aaaa SE32G 29.7 GiB
[    2.260391] NET: Registered PF_INET6 protocol family
[    2.265664]  mmcblk3: p1 p2
[    2.271035] Segment Routing with IPv6
[    2.274953] In-situ OAM (IOAM) with IPv6
[    2.279131] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.286065] NET: Registered PF_PACKET protocol family
[    2.286119] can: controller area network core
[    2.295749] NET: Registered PF_CAN protocol family
[    2.295785] can: raw protocol
[    2.303889] can: broadcast manager protocol
[    2.308170] can: netlink gateway - max_hops=3D1
[    2.312777] Key type dns_resolver registered
[    2.319085] Registering SWP/SWPB emulation handler
[    2.336473] Loading compiled-in X.509 certificates
[    2.365709] imx6q-pcie 8ffc000.pcie: host bridge /soc/pcie@8ffc000 range=
s:
[    2.365787] imx6q-pcie 8ffc000.pcie:       IO
0x0008f80000..0x0008f8ffff -> 0x0000000000
[    2.365819] imx6q-pcie 8ffc000.pcie:      MEM
0x0008000000..0x0008efffff -> 0x0008000000
[    2.365918] imx6q-pcie 8ffc000.pcie: config reg[1] 0x08f00000 =3D=3D
cpu 0x08f00000
[    2.365918] ; no fixup was ever needed for this devicetree
[    2.402815] imx_thermal 20c8000.anatop:tempmon: Extended Commercial
CPU temperature grade - max:105C critical:100C passive:95C
[    2.417767] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.429461] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.439333] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    2.447697] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    2.450641] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    2.470044] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.478838] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    2.486404] clk: Disabling unused clocks
[    2.490534] faux_driver regulatory: Direct firmware load for
regulatory.db failed with error -2
[    2.490563] cfg80211: failed to load regulatory.db
[    2.504775] PM: genpd: Disabling unused power domains
[    2.509900] mmc1: Failed to initialize a non-removable card
[    2.510002] ALSA device list:
[    2.518716]   #0: ASRC-M2M
[    2.521661] check access for rdinit=3D/init failed: -2, ignoring
[    2.595029] random: crng init done
[    2.623274] imx6q-pcie 8ffc000.pcie: iATU: unroll F, 4 ob, 4 ib,
align 64K, limit 4G
[    2.631588] imx6q-pcie 8ffc000.pcie: Link: Only Gen1 is enabled
[    3.622143] imx6q-pcie 8ffc000.pcie: Phy link never came up
[    3.629729] imx6q-pcie 8ffc000.pcie: PCI host bridge to bus 0000:00
[    3.636231] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.641823] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    3.648291] pci_bus 0000:00: root bus resource [mem 0x08000000-0x08effff=
f]
[    3.655497] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
PCIe Root Port
[    3.655586] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[    3.655623] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    3.655650] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    3.655681] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    3.655705] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff=
]
[    3.655733] pci 0000:00:00.0:   bridge window [mem
0x00000000-0x000fffff pref]
[    3.663269] pci 0000:00:00.0: supports D1
[    3.663293] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    3.669460] PCI: bus0: Fast back to back transfers disabled
[    3.669914] PCI: bus1: Fast back to back transfers enabled
[    3.669988] pci 0000:00:00.0: BAR 0 [mem 0x08000000-0x080fffff]: assigne=
d
[    3.670030] pci 0000:00:00.0: ROM [mem 0x08100000-0x0810ffff pref]: assi=
gned
[    3.670059] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    3.670091] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    3.670112] pci_bus 0000:00: resource 5 [mem 0x08000000-0x08efffff]
[    3.764048] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    3.924328] EXT4-fs (mmcblk3p2): recovery complete
[    3.930941] EXT4-fs (mmcblk3p2): mounted filesystem
d5a64ac5-7eae-43d4-a70e-6936f55c77f6 r/w with ordered data mode. Quota
mode: none.
[    3.943706] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    3.952233] devtmpfs: mounted
[    3.956327] Freeing unused kernel image (initmem) memory: 1024K
[    3.962681] Run /sbin/init as init process
[    4.122080] EXT4-fs (mmcblk3p2): re-mounted
d5a64ac5-7eae-43d4-a70e-6936f55c77f6.
Seeding 256 bits and crediting
Saving 256 bits of creditable seed for next boot
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [    4.375835] udevd[102]: starting version 3.2=
.14
[    4.421898] udevd[103]: starting eudev-3.2.14
done
Starting network: OK
Starting crond: OK

Welcome to Buildroot
buildroot login: [   12.654047] fsl-ssi-dai 202c000.ssi: No cache
defaults, reading back from HW
[   12.669232] platform sound: deferred probe pending: fsl-asoc-card:
snd_soc_register_card failed
[   12.669423] platform sound-spdif: deferred probe pending:
fsl-asoc-card: snd_soc_register_card failed
[   12.669505] platform 202c000.ssi: deferred probe pending:
fsl-ssi-dai: Failed to init PCM DMA
[   12.669546] platform 2004000.spdif: deferred probe pending:
fsl-spdif-dai: imx_pcm_dma_init failed

Welcome to Buildroot
buildroot login: root
#
#
# uname -r
6.17.0

