Return-Path: <linux-kernel+bounces-873394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D1FC13D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CB2C566552
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F0303A03;
	Tue, 28 Oct 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rvg5zJLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2B303C85;
	Tue, 28 Oct 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643759; cv=none; b=myI/V0+U1ey3ySoFOQD3SQjztg35zDeLYwrTyInHvD68XZSduX3ytJZfK5Vl9xvnDZyn7dGkz/vdhZzevwcoyXhAMRhIXkacPv7W1VfwjiF0LjoQ9iLnZ+PPUpMDssw4fnqRQ3A13J2xGTvva8RNULTqX2iHUcdYfuHBZIZunK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643759; c=relaxed/simple;
	bh=445heezdjBWJpefRw4RQtDYbWl5z2fdWhXq66ZfLFTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Epdxh4TNub1t4aHLMRz27OUGDfEoW6dAKQUqTIv/oe2lyuetZg0Qs4VWvxFpX6p/WVRBvnK8XKPrfkfCKr27RvOzxA9xeJvHnXyz+f5rG9q/e5oGUHE6wQdsu/9NahoIycHyb1wevHi+bX0SXZIlv2zll+hFySs7ytQ9UkaJO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rvg5zJLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE004C113D0;
	Tue, 28 Oct 2025 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761643758;
	bh=445heezdjBWJpefRw4RQtDYbWl5z2fdWhXq66ZfLFTg=;
	h=From:To:Cc:Subject:Date:From;
	b=Rvg5zJLEWf+ZEtA5Ss3yATYP0fhhx2VDUdQM2TNxFHMcTAr9AtfDNnvU557jzb0Dz
	 bdlQr9wkEUrEtlqFKHXvxoiF34mYdhCcYDPHjgbMGjbYXtDtAr4RqJmv7ub7Nap2PB
	 tkX1wfjQwuPasHfAbJGPqn5rKURvKSngfNQhjwO0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com
Subject: [PATCH 5.15 000/117] 5.15.196-rc2 review
Date: Tue, 28 Oct 2025 10:29:12 +0100
Message-ID: <20251028092823.507383588@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.196-rc2
X-KernelTest-Deadline: 2025-10-30T09:28+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.196 release.
There are 117 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 30 Oct 2025 09:28:07 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.196-rc2

Marek Vasut <marek.vasut+renesas@mailbox.org>
    PCI: rcar: Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup()

Zhengchao Shao <shaozhengchao@huawei.com>
    net: rtnetlink: fix module reference count leak issue in rtnetlink_rcv_msg

Kuen-Han Tsai <khtsai@google.com>
    usb: gadget: f_acm: Refactor bind path to use __free()

Kuen-Han Tsai <khtsai@google.com>
    usb: gadget: f_ncm: Refactor bind path to use __free()

Kuen-Han Tsai <khtsai@google.com>
    usb: gadget: Introduce free_usb_request helper

Kuen-Han Tsai <khtsai@google.com>
    usb: gadget: Store endpoint pointer in usb_request

Kaushlendra Kumar <kaushlendra.kumar@intel.com>
    arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()

Darrick J. Wong <djwong@kernel.org>
    xfs: always warn about deprecated mount options

Maarten Lankhorst <dev@lankhorst.se>
    devcoredump: Fix circular locking dependency with devcd->mutex.

Niklas Cassel <cassel@kernel.org>
    PCI: tegra194: Reset BARs when running in PCIe endpoint mode

Marek Vasut <marek.vasut+renesas@mailbox.org>
    PCI: rcar-host: Drop PMSR spinlock

Marek Vasut <marek.vasut+renesas@gmail.com>
    PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()

Vidya Sagar <vidyas@nvidia.com>
    PCI: tegra194: Handle errors in BPMP response

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix wrong block mapping for multi-devices

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Jan Kara <jack@suse.cz>
    vfs: Don't leak disconnected dentries on umount

Gui-Dong Han <hanguidong02@gmail.com>
    drm/amdgpu: use atomic functions with memory barriers for vm fault info

Marek Vasut <marek.vasut+renesas@mailbox.org>
    PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock

Muhammad Usama Anjum <usama.anjum@collabora.com>
    wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: j721e: Fix programming sequence of "strap" settings

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists

Darrick J. Wong <djwong@kernel.org>
    fuse: fix livelock in synchronous file put from fuseblk workers

Amir Goldstein <amir73il@gmail.com>
    fuse: allocate ff->release_args only if release is needed

Xiao Liang <shaw.leon@gmail.com>
    padata: Reset next CPU when reorder sequence wraps around

Sean Nyekjaer <sean@geanix.com>
    iio: imu: inv_icm42600: Simplify pm_runtime setup

Bence Csókás <csokas.bence@prolan.hu>
    PM: runtime: Add new devm functions

Sean Nyekjaer <sean@geanix.com>
    iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended

David Lechner <dlechner@baylibre.com>
    iio: imu: inv_icm42600: use = { } instead of memset()

Sergey Bashirov <sergeybashirov@gmail.com>
    NFSD: Fix last write offset handling in layoutcommit

Sergey Bashirov <sergeybashirov@gmail.com>
    NFSD: Minor cleanup in layoutcommit processing

Sergey Bashirov <sergeybashirov@gmail.com>
    NFSD: Rework encoding and decoding of nfsd4_deviceid

Christoph Hellwig <hch@lst.de>
    xfs: fix log CRC mismatches between i386 and other architectures

Christoph Hellwig <hch@lst.de>
    xfs: rename the old_crc variable in xlog_recover_process

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/cio: Update purge function to unregister the unused subchannels

Mark Rutland <mark.rutland@arm.com>
    arm64: errata: Apply workarounds for Neoverse-V3AE

Mark Rutland <mark.rutland@arm.com>
    arm64: cputype: Add Neoverse-V3AE definitions

Florian Eckert <fe@dev.tdt.de>
    serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018

Victoria Votokina <Victoria.Votokina@kaspersky.com>
    most: usb: hdm_probe: Fix calling put_device() before device initialization

Victoria Votokina <Victoria.Votokina@kaspersky.com>
    most: usb: Fix use-after-free in hdm_disconnect

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add wildcat lake P DID

Deepanshu Kartikey <kartikey406@gmail.com>
    comedi: fix divide-by-zero in comedi_buf_munge()

Alice Ryhl <aliceryhl@google.com>
    binder: remove "invalid inc weak" check

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: dbc: enable back DbC in resume if it was enabled before suspend

Andrey Konovalov <andreyknvl@gmail.com>
    usb: raw-gadget: do not limit transfer length

Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
    usb/core/quirks: Add Huawei ME906S to wakeup quirk

LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
    USB: serial: option: add Telit FN920C04 ECM compositions

Reinhard Speyerer <rspmn@arcor.de>
    USB: serial: option: add Quectel RG255C

Renjun Wang <renjunw0@foxmail.com>
    USB: serial: option: add UNISOC UIS7720

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    net: ravb: Ensure memory write completes before ringing TX doorbell

Michal Pecio <michal.pecio@gmail.com>
    net: usb: rtl8150: Fix frame padding

Stefano Garzarella <sgarzare@redhat.com>
    vsock: fix lock inversion in vsock_assign_transport()

Deepanshu Kartikey <kartikey406@gmail.com>
    ocfs2: clear extent cache after moving/defragmenting extents

Maciej W. Rozycki <macro@orcam.me.uk>
    MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Revert "cpuidle: menu: Avoid discarding useful information"

Tonghao Zhang <tonghao@bamaicloud.com>
    net: bonding: fix possible peer notify event loss or dup issue

Alexey Simakov <bigalex934@gmail.com>
    sctp: avoid NULL dereference when chunk data buffer is missing

Huang Ying <ying.huang@linux.alibaba.com>
    arm64, mm: avoid always making PTE dirty in pte_mkwrite()

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path

Wei Fang <wei.fang@nxp.com>
    net: enetc: correct the value of ENETC_RXB_TRUESIZE

Johannes Wiesböck <johannes.wiesboeck@aisec.fraunhofer.de>
    rtnetlink: Allow deleting FDB entries in user namespace

Nikolay Aleksandrov <razor@blackwall.org>
    net: rtnetlink: add NLM_F_BULK support to rtnl_fdb_del

Nikolay Aleksandrov <razor@blackwall.org>
    net: add ndo_fdb_del_bulk

Nikolay Aleksandrov <razor@blackwall.org>
    net: rtnetlink: add bulk delete support flag

Nikolay Aleksandrov <razor@blackwall.org>
    net: netlink: add NLM_F_BULK delete request modifier

Nikolay Aleksandrov <razor@blackwall.org>
    net: rtnetlink: use BIT for flag values

Nikolay Aleksandrov <razor@blackwall.org>
    net: rtnetlink: add helper to extract msg type's kind

Geert Uytterhoeven <geert@linux-m68k.org>
    m68k: bitops: Fix find_*_bit() signatures

Yangtao Li <frank.li@vivo.com>
    hfsplus: return EIO when type of hidden directory mismatch in hfsplus_fill_super()

Viacheslav Dubeyko <slava@dubeyko.com>
    hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()

Alexander Aring <aahringo@redhat.com>
    dlm: check for defined force value in dlm_lockspace_release

Viacheslav Dubeyko <slava@dubeyko.com>
    hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()

Yang Chenzhi <yang.chenzhi@vivo.com>
    hfs: validate record offset in hfsplus_bmap_alloc

Viacheslav Dubeyko <slava@dubeyko.com>
    hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()

Viacheslav Dubeyko <slava@dubeyko.com>
    hfs: make proper initalization of struct hfs_find_data

Viacheslav Dubeyko <slava@dubeyko.com>
    hfs: clear offset and space out of valid records in b-tree node

Simon Schuster <schuster.simon@siemens-energy.com>
    nios2: ensure that memblock.current_limit is set when setting pfn limits

Xichao Zhao <zhao.xichao@vivo.com>
    exec: Fix incorrect type for ret

Niko Mauno <niko.mauno@vaisala.com>
    Revert "perf test: Don't leak workload gopipe in PERF_RECORD_*"

Brian Norris <briannorris@google.com>
    PCI/sysfs: Ensure devices are powered for config reads (part 2)

Viacheslav Dubeyko <slava@dubeyko.com>
    hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()

Jiaming Zhang <r772577952@gmail.com>
    ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Randy Dunlap <rdunlap@infradead.org>
    ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Vincent Guittot <vincent.guittot@linaro.org>
    sched/fair: Fix pelt lost idle time detection

Ingo Molnar <mingo@kernel.org>
    sched/balancing: Rename newidle_balance() => sched_balance_newidle()

Timur Kristóf <timur.kristof@gmail.com>
    drm/amd/powerplay: Fix CIK shutdown temperature

Fabian Vogt <fvogt@suse.de>
    riscv: kprobes: Fix probe address validation

I Viswanath <viswanathiyyappan@gmail.com>
    net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset

Oleksij Rempel <linux@rempel-privat.de>
    net: usb: lan78xx: Add error handling to lan78xx_init_mac_address

Jakub Kicinski <kuba@kernel.org>
    net: usb: use eth_hw_addr_set() instead of ether_addr_copy()

Sabrina Dubroca <sd@queasysnail.net>
    tls: don't rely on tx_work during send()

Sabrina Dubroca <sd@queasysnail.net>
    tls: always set record_type in tls_process_cmsg

Sabrina Dubroca <sd@queasysnail.net>
    tls: wait for async encrypt in case of error during latter iterations of sendmsg

Sascha Hauer <s.hauer@pengutronix.de>
    net: tls: wait for async completion on last message

David Howells <dhowells@redhat.com>
    splice, net: Add a splice_eof op to file-ops and socket-ops

Alexey Simakov <bigalex934@gmail.com>
    tg3: prevent use of uninitialized remote_adv and local_adv variables

Eric Dumazet <edumazet@google.com>
    tcp: fix tcp_tso_should_defer() vs large RTT

Raju Rangoju <Raju.Rangoju@amd.com>
    amd-xgbe: Avoid spurious link down messages during interface toggle

Dmitry Safonov <0x7f454c46@gmail.com>
    net/ip6_tunnel: Prevent perpetual tunnel growth

Linmao Li <lilinmao@kylinos.cn>
    r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    doc: fix seg6_flowlabel path

Yeounsu Moon <yyyynoom@gmail.com>
    net: dlink: handle dma_map_single() failure properly

Marc Kleine-Budde <mkl@pengutronix.de>
    can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()

Yuezhang Mo <Yuezhang.Mo@sony.com>
    dax: skip read lock assertion for read-only filesystems

Benjamin Tissoires <bentiss@kernel.org>
    HID: multitouch: fix sticky fingers

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay

Thomas Fourier <fourier.thomas@gmail.com>
    crypto: rockchip - Fix dma_unmap_sg() nents value

Kaustabh Chakraborty <kauschluss@disroot.org>
    drm/exynos: exynos7_drm_decon: remove ctx->suspended

Kaustabh Chakraborty <kauschluss@disroot.org>
    drm/exynos: exynos7_drm_decon: properly clear channels during bind

Kaustabh Chakraborty <kauschluss@disroot.org>
    drm/exynos: exynos7_drm_decon: fix uninitialized crtc reference in functions

Yu Kuai <yukuai3@huawei.com>
    blk-crypto: fix missing blktrace bio split events

Ma Ke <make24@iscas.ac.cn>
    media: lirc: Fix error handling in lirc_register()

keliu <liuke94@huawei.com>
    media: rc: Directly use ida_free()

Arnd Bergmann <arnd@arndb.de>
    media: s5p-mfc: remove an unused/uninitialized variable

Filipe Manana <fdmanana@suse.com>
    btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running

Deepanshu Kartikey <kartikey406@gmail.com>
    ext4: detect invalid INLINE_DATA + EXTENTS flag combination

Zhang Yi <yi.zhang@huawei.com>
    jbd2: ensure that all ongoing I/O complete before freeing blocks

Yi Cong <yicong@kylinos.cn>
    r8152: add error handling in rtl8152_driver_init


-------------

Diffstat:

 Documentation/arm64/silicon-errata.rst             |   2 +
 Documentation/networking/seg6-sysctl.rst           |   3 +
 Makefile                                           |   4 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/include/asm/pgtable.h                   |   3 +-
 arch/arm64/kernel/cpu_errata.c                     |   1 +
 arch/m68k/include/asm/bitops.h                     |  25 ++--
 arch/mips/mti-malta/malta-setup.c                  |   2 +-
 arch/nios2/kernel/setup.c                          |  15 +++
 arch/riscv/kernel/probes/kprobes.c                 |  13 +-
 block/blk-crypto-fallback.c                        |   3 +
 drivers/android/binder.c                           |  11 +-
 drivers/base/arch_topology.c                       |   2 +-
 drivers/base/devcoredump.c                         | 138 +++++++++++++--------
 drivers/base/power/runtime.c                       |  44 +++++++
 drivers/comedi/comedi_buf.c                        |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  14 ++-
 drivers/cpuidle/governors/menu.c                   |  21 ++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   7 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   3 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |  98 +++++----------
 drivers/hid/hid-multitouch.c                       |  27 ++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  35 ++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   5 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c    |  35 ++----
 drivers/media/rc/lirc_dev.c                        |  15 +--
 drivers/media/rc/rc-main.c                         |   6 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +
 drivers/most/most_usb.c                            |  13 +-
 drivers/net/bonding/bond_main.c                    |  40 +++---
 drivers/net/can/m_can/m_can_platform.c             |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |   1 -
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   1 +
 drivers/net/ethernet/broadcom/tg3.c                |   5 +-
 drivers/net/ethernet/dlink/dl2k.c                  |  23 ++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   3 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   5 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   8 ++
 drivers/net/usb/aqc111.c                           |   2 +-
 drivers/net/usb/lan78xx.c                          |  42 +++++--
 drivers/net/usb/r8152.c                            |   9 +-
 drivers/net/usb/rndis_host.c                       |   2 +-
 drivers/net/usb/rtl8150.c                          |  13 +-
 drivers/net/wireless/ath/ath11k/core.c             |   6 +-
 drivers/net/wireless/ath/ath11k/hal.c              |  16 +++
 drivers/net/wireless/ath/ath11k/hal.h              |   1 +
 drivers/pci/controller/cadence/pci-j721e.c         |  64 +++++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   1 +
 drivers/pci/controller/dwc/pcie-tegra194.c         |  28 ++++-
 drivers/pci/controller/pcie-rcar-host.c            |  83 +++++++------
 drivers/pci/pci-sysfs.c                            |  10 +-
 drivers/s390/cio/device.c                          |  37 ++++--
 drivers/tty/serial/8250/8250_exar.c                |  11 ++
 drivers/usb/core/quirks.c                          |   2 +
 drivers/usb/gadget/function/f_acm.c                |  42 +++----
 drivers/usb/gadget/function/f_ncm.c                |  78 +++++-------
 drivers/usb/gadget/legacy/raw_gadget.c             |   2 -
 drivers/usb/gadget/udc/core.c                      |   3 +
 drivers/usb/host/xhci-dbgcap.c                     |   9 +-
 drivers/usb/serial/option.c                        |  10 ++
 fs/btrfs/relocation.c                              |  13 +-
 fs/dax.c                                           |   2 +-
 fs/dcache.c                                        |   2 +
 fs/dlm/lockspace.c                                 |   2 +-
 fs/exec.c                                          |   2 +-
 fs/ext4/inode.c                                    |   8 ++
 fs/f2fs/data.c                                     |   2 +-
 fs/fuse/dir.c                                      |   2 +-
 fs/fuse/file.c                                     |  75 ++++++-----
 fs/fuse/fuse_i.h                                   |   2 +-
 fs/hfs/bfind.c                                     |   8 +-
 fs/hfs/brec.c                                      |  27 +++-
 fs/hfs/mdb.c                                       |   2 +-
 fs/hfsplus/bfind.c                                 |   8 +-
 fs/hfsplus/bnode.c                                 |  41 ------
 fs/hfsplus/btree.c                                 |   6 +
 fs/hfsplus/hfsplus_fs.h                            |  42 +++++++
 fs/hfsplus/super.c                                 |  25 +++-
 fs/hfsplus/unicode.c                               |  24 ++++
 fs/jbd2/transaction.c                              |  13 +-
 fs/nfsd/blocklayout.c                              |   5 +-
 fs/nfsd/blocklayoutxdr.c                           |   7 +-
 fs/nfsd/flexfilelayout.c                           |   8 ++
 fs/nfsd/flexfilelayoutxdr.c                        |   3 +-
 fs/nfsd/nfs4layouts.c                              |   1 -
 fs/nfsd/nfs4proc.c                                 |  34 +++--
 fs/nfsd/nfs4xdr.c                                  |  14 +--
 fs/nfsd/xdr4.h                                     |  36 +++++-
 fs/ocfs2/move_extents.c                            |   5 +
 fs/splice.c                                        |  31 ++++-
 fs/xfs/libxfs/xfs_log_format.h                     |  30 ++++-
 fs/xfs/xfs_log.c                                   |   8 +-
 fs/xfs/xfs_log_priv.h                              |   4 +-
 fs/xfs/xfs_log_recover.c                           |  34 +++--
 fs/xfs/xfs_ondisk.h                                |   2 +
 fs/xfs/xfs_super.c                                 |  33 +++--
 include/linux/cpufreq.h                            |   3 +
 include/linux/fs.h                                 |   1 +
 include/linux/net.h                                |   1 +
 include/linux/netdevice.h                          |   9 ++
 include/linux/pm_runtime.h                         |   4 +
 include/linux/splice.h                             |   1 +
 include/linux/usb/gadget.h                         |  25 ++++
 include/net/ip_tunnels.h                           |  15 +++
 include/net/rtnetlink.h                            |   9 +-
 include/net/sock.h                                 |   1 +
 include/uapi/linux/netlink.h                       |   1 +
 kernel/padata.c                                    |   6 +-
 kernel/sched/fair.c                                |  38 +++---
 net/core/rtnetlink.c                               |  81 ++++++++----
 net/ipv4/ip_tunnel.c                               |  14 ---
 net/ipv4/tcp_output.c                              |  19 ++-
 net/ipv6/ip6_tunnel.c                              |   3 +-
 net/sctp/inqueue.c                                 |  13 +-
 net/socket.c                                       |  10 ++
 net/tls/tls_main.c                                 |   7 +-
 net/tls/tls_sw.c                                   |  22 +++-
 net/vmw_vsock/af_vsock.c                           |  38 +++---
 sound/firewire/amdtp-stream.h                      |   2 +-
 sound/usb/card.c                                   |  10 +-
 tools/perf/tests/perf-record.c                     |   4 -
 128 files changed, 1305 insertions(+), 728 deletions(-)



