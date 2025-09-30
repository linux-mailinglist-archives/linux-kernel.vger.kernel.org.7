Return-Path: <linux-kernel+bounces-837883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A4BADF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306D23AA2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8C30595D;
	Tue, 30 Sep 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLc8xIGK"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB9264A60
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247358; cv=none; b=E622x8nSx8Pinz9DkEDw6vs2LqepVd+wUisiRSFqynKbI6bDVIzv6BgPKGvrG3xm/V3RhhRNFnCcExkB4ZBFizr4JvfXLdVybD/R9Z/OVDezzvMdonraPgR6sF9DFc6SScTk3BTjlqNNn87Ya9jsemEllmoscZ1PdLSwh9osxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247358; c=relaxed/simple;
	bh=651iNEyPnuC4XVqGs6PDaa7AFxwXcX30XoLbQZPu164=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTGZ1CJUG4vvmSpT7X26x5bl9OKLorADmX6ZlbWGaTG4yAY04c108bVLsGyzFdvzjvGfrjoV2W+BdawcvfPzkmnFe28ySXEGzsMeX2+ISuIJ7UF3t8tctANZMWwO4Pmnns/Om58hEHt4gyiDa3lKAYcnieS5rhb5QmRmvh25woI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLc8xIGK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5821dec0408so5179504e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759247355; x=1759852155; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CINs5Fa01L0BfH85qAB6izExnuzWByIm2wKMiGmi/w0=;
        b=JLc8xIGKieKpVbaFfyBApoLH3fxlOQRCYm4NSGUr1f42Vz1LCbO6OmCMAz9i4tgeCg
         TFlqsu9sf5ysQNunSdohaycRtb9EQ6wDxPXdCyg3j6hYkdhvMb9U50MsMjRkP2lgZ+lz
         jpL9TYN5/MbwYoHaR5O1KylLouGyuUWBtI04MNPTPZGsAKW5r/hS51MvCAfywLPKHdwQ
         fd9BsciAtN4gBSUXDXv4Vb4W6T9KCSu+WaPfgMF2tTyMst5Z2LtiMudaQVvoy3b6j8xp
         riLzteqKGiOSTTzOscbKxBD0GSZUbkCDNZWrnBQ/FMPw6XkM1nj0SCYVHSFQqAhzSYd1
         N+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247355; x=1759852155;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CINs5Fa01L0BfH85qAB6izExnuzWByIm2wKMiGmi/w0=;
        b=nNtQ01qNZkUaNYy21j73l5PM0GYWupJ0iysdgQF7ahhjFb18UxAxoLSK8mD9/Zc6kb
         18eEA9uwXsO2lRN8hLsnYVEuUnFwRw9+y7O3DmmSx0kFYKXzo7gyzfuMj1mkPlJg/bJO
         MJZUAuFX8TGNZGr+BUHosdjjTfYU1zPu5VllK3PJJi9YHLYtFHQ1XRS5M4KX/gfmxOZB
         3r8Lt8x3bi4Raa5vgZ9URSo4l3NhavLsubi92KOGHxppG+hKCNV58o250ENzviHZZR2q
         d8oqwqauhwgxm/vDY9ABwH0YGTdHTHjgilJt4xAoaBn/gqfgHS/0m5+DTVK32mPQoJ+d
         qJ5w==
X-Gm-Message-State: AOJu0YxLdMLO/LbdiTdxaVtOSkSQ9d3MOHON+dhVZK6qm6zyUixbTEKv
	s7//wiXrbMlrGb1IIOQ/OIN3IqA+fXd1hGr6KryWVPyJETJdh0C9mxFz
X-Gm-Gg: ASbGncth8rBAFYMMq3NKHvdWPMrTDckJRL7Og/ht/UnlEGRLm3RAA9seWHYzOFIYG+D
	m8pycP2aya2UNvHD2gzWFzZgP18mH5L5qyeJf20FTJp6k9Bqznx2iNGp+tszUvEcCTPTvV6SwIf
	J1YRpHtWiA6ZahmZEEu3YJ4qhic64Vtusg6P+WwTdXTfxychE/NIUwyl/A8ZZYYvXyZWwfyskIq
	GEm9wkHCC+Dv5MSU0OHjlBeHC1+PFB+QfHi9zhTS5QWrM9CRWvrLXZylWreIT8E8YDkDfVqQcnp
	7r4+hbieAuZ0VZAUZaEL03h6CEmFk9p4nJtPBenD2NVM4apU4crxZ6EvzLwID/zokzVJ0Lf0yAi
	rWwosP5nngMTVpF09Jszqxpct9RPQSUVU4bmjpZ2Xa/Ts/ygBWX/6xe+hjWkP
X-Google-Smtp-Source: AGHT+IHFKVuOTb/fMdJaV1lNsutSC8CSY7ocx2A9//tLor6D6u/b1NMIrDmAUHrxcw3uukBLnWkUqQ==
X-Received: by 2002:a05:6512:2394:b0:581:b92e:666a with SMTP id 2adb3069b0e04-582d3e8254bmr6595238e87.48.1759247354175;
        Tue, 30 Sep 2025 08:49:14 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-587b8ecb6ccsm1845349e87.99.2025.09.30.08.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 08:49:13 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
    Shawn Guo <shawnguo@kernel.org>,
    Fabio Estevam <festevam@gmail.com>,
    "Rob Herring (Arm)" <robh@kernel.org>,
    Anson Huang <Anson.Huang@nxp.com>
Subject: ARM iMX6sx board fails to boot with kernel 6.17
Date: Tue, 30 Sep 2025 18:49:13 +0300
Message-ID: <87v7l03pqe.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

I'm looking for help with the following issue.

I'm trying to upgrade kernel on my custom iMX6sx board from very old
4.9.146 to resent 6.17. The board has eMMC connected to usdhc4, and
u-boot happily starts kernel from eMMC. The kernel boot sequence,
however, hangs waiting for root file-system as it doesn't see eMMC.

I figured that if I disable DTS "gpc/pgc/pd_pu" node in imx6sx.dtsi one
way or another, the board starts to boot, so it seems that with default
configuration the kernel power or clock management renders either usdhc4
or eMMC inactive.

Two methods to effectively disable "gpc/pgc/pd_pu" I've used to
work-around the problem are:

modified   arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -800,7 +800,7 @@ gpc: gpc@20dc000 {
                                 interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
                                 interrupt-parent = <&intc>;
                                 clocks = <&clks IMX6SX_CLK_IPG>;
-                                clock-names = "ipg";
+                                /*clock-names = "ipg";*/

                                 pgc {
                                         #address-cells = <1>;

or:

modified   drivers/pmdomain/imx/gpc.c
@@ -311,7 +311,7 @@ static const struct imx_gpc_dt_data imx6sl_dt_data = {
 };

 static const struct imx_gpc_dt_data imx6sx_dt_data = {
-        .num_domains = 4,
+        .num_domains = 1,
         .err009619_present = false,
         .err006287_present = false,
 };

and any of the two gives kernel that boots.

I looked at DTS files in the kernel that use imx6sx.dtsi as well, but
didn't find anything specific that'd help me with the problem.

I'm not sure how to debug this further and actually fix the issue. Any
ideas, please?

Below is success boot log. Failing boot hangs at or sometimes slightly
above the "Waiting for root device /dev/mmcblk0p2..." line, and has
additional

"imx-gpc 20dc000.gpc: probe with driver imx-gpc failed with error -2"

diagnostic due to my hack to disable "gpc" DTS node by commenting-out
"ipg" clock.

The only suspect thing I see in the log is:

/soc/bus@2000000/clock-controller@20c4000: Fixed dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000
/soc/bus@2000000/clock-controller@20c4000: Fixed dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000

and I'm not sure if it's relevant or expected.

<boot log>
Booting Linux on physical CPU 0x0
Linux version 6.17.0-javad-4 (osv@firman) (arm-javad-linux-gnueabihf-gcc.br_real (Buildroot 2024.11-1178-g8f0639fe6f) 14.2.0, GNU ld (GNU Binutils) 2.43.1) #34 PREEMPT Tue Sep 30 01:23:27 MSK 2025
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: JAVAD TRE-3S
Memory policy: Data cache writeback
Zone ranges:
  Normal   [mem 0x0000000080000000-0x00000000bfffffff]
  HighMem  empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080000000-0x00000000bfffffff]
Initmem setup node 0 [mem 0x0000000080000000-0x00000000bfffffff]
OF: reserved mem: Reserved memory: No reserved-memory node in the DT
CPU: All CPU(s) started in SVC mode.
Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk0p2 rootwait rw panic=30 oops=panic
printk: log buffer data + meta data: 262144 + 819200 = 1081344 bytes
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 262144
mem auto-init: stack:all(zero), heap alloc:off, heap free:off
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU event tracing is enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
L2C-310 erratum 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 16 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 256 kB
L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76430001
rcu: srcu_init: Setting srcu_struct sizes based on contention.
Switching to timer-based delay loop, resolution 333ns
sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=3000)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: using BPIALL workaround
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=capability
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Setting up static identity map for 0x80100000 - 0x80100060
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
Memory: 1023036K/1048576K available (9216K kernel code, 1039K rwdata, 2496K rodata, 1024K init, 348K bss, 23868K reserved, 0K cma-reserved, 0K highmem)
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
posixtimers hash table entries: 512 (order: -1, 2048 bytes, linear)
futex hash table entries: 256 (4096 bytes on 1 NUMA nodes, total 4 KiB, linear).
pinctrl core: initialized pinctrl subsystem
NET: Registered PF_NETLINK/PF_ROUTE protocol family
DMA: preallocated 256 KiB pool for atomic coherent allocations
thermal_sys: Registered thermal governor 'step_wise'
cpuidle: using governor menu
/soc/bus@2000000/clock-controller@20c4000: Fixed dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000
/soc/bus@2000000/clock-controller@20c4000: Fixed dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000
/soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s) with /soc/bus@2000000/clock-controller@20c4000
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
imx6sx-pinctrl 20e0000.pinctrl: initialized IMX pinctrl driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests (id=vbus)
i2c i2c-0: IMX I2C adapter registered
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
clocksource: Switched to clocksource mxc_timer1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NET: Registered PF_INET protocol family
IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 4096 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
Initialise system trusted keyrings
workingset: timestamp_bits=30 max_order=18 bucket_order=0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
fuse: init (API version 7.44)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
imx-sdma 20ec000.dma-controller: external firmware not found, using ROM firmware
mxs-dma 1804000.dma-controller: initialized
imx-gpc 20dc000.gpc: probe with driver imx-gpc failed with error -2
2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 19, base_baud = 1500000) is a IMX
printk: console [ttymxc0] enabled
21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 20, base_baud = 1500000) is a IMX
21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 21, base_baud = 1500000) is a IMX
21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 22, base_baud = 1500000) is a IMX
21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq = 23, base_baud = 1500000) is a IMX
22a0000.serial: ttymxc5 at MMIO 0x22a0000 (irq = 24, base_baud = 1500000) is a IMX
brd: module loaded
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver usb_ehset_test
snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc0
snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock to 2025-09-30T13:57:32 UTC (1759240652)
i2c_dev: i2c /dev entries driver
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 (8000003f) counters available
NET: Registered PF_LLC protocol family
xt_time: kernel timezone is -0000
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered PF_PACKET protocol family
Bridge firewalling registered
mmc0: SDHCI controller on 219c000.mmc [219c000.mmc] using ADMA
Loading compiled-in X.509 certificates
clk: Disabling unused clocks
PM: genpd: Disabling unused power domains
check access for rdinit=/init failed: -2, ignoring
Waiting for root device /dev/mmcblk0p2...
mmc0: new high speed DDR MMC card at address 0001
mmcblk0: mmc0:0001 IX2964 58.3 GiB
 mmcblk0: p1 p2 p3 p4 < p5 p6 >
mmcblk0boot0: mmc0:0001 IX2964 4.00 MiB
mmcblk0boot1: mmc0:0001 IX2964 4.00 MiB
mmcblk0rpmb: mmc0:0001 IX2964 4.00 MiB, chardev (246:0)
EXT4-fs (mmcblk0p2): recovery complete
EXT4-fs (mmcblk0p2): mounted filesystem 2562e8d0-a3bb-46ec-ba28-e5ed2f5fc824 r/w with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) on device 179:2.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 1024K
Run /sbin/init as init process
</boot log>

-- 
Sergey Organov

