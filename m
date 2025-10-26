Return-Path: <linux-kernel+bounces-870675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23257C0B6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A7024E92DF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91723002A4;
	Sun, 26 Oct 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JQsWr0hC"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5925C821
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520417; cv=none; b=LAMCimSW3Q2Y3C52MVrlz1n2TQQAZQmoMwT2koNdZycn9dpX9YJnJSwS9dIEb6Nph0V4E2jpkUgAr1jzHOzsnnEsqMe363MPLeWROAQiS6E16VFXMtM2D+vSGRJTUQzFVUeWH0k/bSYIXMWGQQDVetYDaIeOpyiKgbgl/mv00e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520417; c=relaxed/simple;
	bh=eO0nwdk2c6o/JN6xEvUtuHAF3pSfAmm66FYnshLGmdw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F4eT/vPNf56+48Zxq5ONktK/k0QhJGyI4tfajbWIgftExld/buTm2TGSbJelKOGezRsuEJO0VOa7bf2JQGcoiSkqv7sAQlMd8dFqfEzuyCOmil2NwZDhHak1VfNUHiX5kVbHh9iqrsvWZTnqG5CuBfuvGNJaCiIlph7fHQL2Y48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JQsWr0hC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63d6ee383bdso8720608a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761520412; x=1762125212; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JReBd9E3vzOItcX3x7JBEHzm3+vyVU7bbkZFllB5ZFI=;
        b=JQsWr0hC/xhlaEjzkGln0qv1EV5PGRYoi+wZmBCRahu3mXKA1YLyH4ZUPVqCu4dunb
         QrvTdFMHUrsgW1QR4pLw0xbYJoMeWybgbzecVZUr4BRBsbrtgjiIHOucWIe1tsqPX8xH
         dAF+nx4z3ef2blpakQg0xq5BHAxF1dJySCKYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761520412; x=1762125212;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JReBd9E3vzOItcX3x7JBEHzm3+vyVU7bbkZFllB5ZFI=;
        b=Q+2I8T71+isnUinx8pc9+I7HfMm7eg3afvO75mpck3RXzyWOEqwqRlSSiMT4YnekmV
         q+a+XEmnREBVXjZiF/CJPZbDz3ZTczseLe/FjDRjccHS6x8aqs6hrAoktnbXtdJZ/XEu
         6x0MccQ6mn/N/vPSUFShrz/lQ5IfNREmc7KZuBws6SFQ1n62ffu8d8slgb4RXD690zzU
         Q6GrWv8YJD/zykQtI1gcysyQwh1Bq8YEF8mHx93aAxf6SmA5kBt1rRrCkkQwFk5gVG78
         kQht0jSd96is+0//7P2zU6byTRtWoa/cWZxqEBFIom80a+M7X5ZYvKn4alEwgJUFseTO
         BZXw==
X-Gm-Message-State: AOJu0YzM5FMug+9ITvqOSn2SZSGr00v3D+ylKyKN9rgP9WNiF8cKbDzk
	GGueGE/DidtYi+haOFrgNOUki1jBWJoyRN37rSRvo4oRSy0GkBss84mc8JroRL7fImaXTg3PTEt
	HufJdYx8=
X-Gm-Gg: ASbGnctwIhgddxCTKcDGQ3CFYKdqrNaSfwq03MgxU/q4iOtrgYjvGji0LKva4fZyx9U
	nqx1XvrGvqGn5TkTmJLj/RgZHLgjIbLqiX32ICnTnnYT09bEq6umilomr4/WDmHWYkoHgFqaFQE
	Z8ZSX71LT1vB7ZodhowIYwp276AvHyO6U92hYAowxYIu5U1U7d4sI86zoDPUiEPtF3/z1O/xWZi
	W8VsU45Rpd77o9Om3M7T2Z1cPUaeQQKe7A9IMV64HcrR+in4eZN+FQMM2ODZG6ok6Iu2E4Mgj7U
	gKxjKsdQOKQnYrcxCpcFK3UpP74XbilW3uRRMyhgubmvaNaUsQPFcnX44Cak+OvClsegRow/dx2
	Uh/5v0/ABRWr2lacqJ7twy9HFNjW7ju4E7j1nuAP8u0yEDWR7wUyd0Mx6rCJQknxxuMTvNAK3EM
	5FypPmwNVrw6bv148YxfKCTA8pkXhgr5ppIH0dm3nmo6oT0X7NeQ==
X-Google-Smtp-Source: AGHT+IHdOMRsZBZCwWRIVncQJB1+uN+8k34N+FEGOadOoYn/L5x2e1bIHVGLJe3QrxG1bvgKWySTEQ==
X-Received: by 2002:a05:6402:5cb:b0:61c:8114:8832 with SMTP id 4fb4d7f45d1cf-63c1f63448dmr35433013a12.16.1761520412142;
        Sun, 26 Oct 2025 16:13:32 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85369697sm595471266b.26.2025.10.26.16.13.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 16:13:31 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so7711780a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:13:31 -0700 (PDT)
X-Received: by 2002:a05:6402:40ca:b0:63e:17ef:a62d with SMTP id
 4fb4d7f45d1cf-63e17efa78dmr16638032a12.15.1761520410783; Sun, 26 Oct 2025
 16:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Oct 2025 16:13:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBupL1jY0k4ZcPkGw6XZr9+SBG75b181XenzwFJuHD-A@mail.gmail.com>
X-Gm-Features: AWmQ_bnE5Dao5lR5ikXma71ele4txrf8qpCmPvdeN4ACV3OcXzEfqV0m5eZNLak
Message-ID: <CAHk-=whBupL1jY0k4ZcPkGw6XZr9+SBG75b181XenzwFJuHD-A@mail.gmail.com>
Subject: Linux 6.18-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Things feel fairly normal, and in fact the numbers say it's been a bit
calmer than usual, but that's likely just the usual fluctuation in
pull request timing rather than anything else. The diffstat certainly
is pretty short and flat, I think the biggest change is from some
smbdirect fixes (both client and server side), the rest really looks
pretty minimal.

The high-level stats look very normal too, with half the patches being
drivers (counting devicetree bindings there too), and the rest being
pretty random and spread out. So we have the aforementioned smb fixes,
some xfs fixes, and then random noise elsewhere. See the shortlog
below for details.

           Linus

---

Akash Goel (1):
      drm/panthor: Fix kernel panic on partial unmap of a GPU VA region

Aksh Garg (1):
      net: ethernet: ti: am65-cpts: fix timestamp loss due to race conditio=
ns

Aleksander Jan Bajkowski (1):
      net: phy: realtek: fix rtl8221b-vm-cg name

Alex Williamson (1):
      MAINTAINERS: Update Alex Williamson's email address

Alexander Usyskin (2):
      mei: me: add wildcat lake P DID
      mei: txe: fix initialization order

Alexei Lazar (2):
      net/mlx5: Add PPHCR to PCAM supported registers mask
      net/mlx5e: Skip PPHCR register query if not supported by the device

Alexei Starovoitov (1):
      mm: don't spin in add_stack_record when gfp flags don't allow

Alexey Simakov (1):
      sctp: avoid NULL dereference when chunk data buffer is missing

Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Update adpm12160 coeff due to latest FW

Alice Ryhl (5):
      rust_binder: remove warning about orphan mappings
      rust_binder: freeze_notif_done should resend if wrong state
      rust_binder: don't delete FreezeListener if there are pending duplica=
tes
      rust_binder: report freeze notification only when fully frozen
      binder: remove "invalid inc weak" check

Alok Tiwari (4):
      scsi: qla4xxx: Fix typos in comments
      drm/rockchip: dw_hdmi: use correct SCLIN mask for RK3228
      io_uring: fix incorrect unlikely() usage in io_waitid_prep()
      io_uring: correct __must_hold annotation in io_install_fixed_file

Amery Hung (2):
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy=
 RQ
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for stridi=
ng RQ

Amit Dhingra (1):
      btrfs: ref-verify: fix IS_ERR() vs NULL check in btrfs_build_ref_tree=
()

Andrew Cooper (1):
      x86/microcode: Fix Entrysign revision check for Zen1/Naples

Andrey Konovalov (1):
      usb: raw-gadget: do not limit transfer length

Andy Shevchenko (3):
      gpiolib: acpi: Use %pe when passing an error pointer to dev_err()
      x86/bugs: Remove dead code which might prevent from building
      sched: Remove never used code in mm_cid_get()

Anup Patel (2):
      RISC-V: Define pgprot_dmacoherent() for non-coherent devices
      RISC-V: Don't print details of CPUs disabled in DT

Arnd Bergmann (1):
      soc: officially expand maintainership team

Artem Shimko (3):
      spi: dw-mmio: add error handling for reset_control_deassert()
      firmware: arm_scmi: Fix premature SCMI_XFER_FLAG_IS_RAW clearing
in raw mode
      serial: 8250_dw: handle reset control deassert error

Aurabindo Pillai (1):
      drm/amd/display: use GFP_NOWAIT for allocation in interrupt handler

Babu Moger (1):
      x86,fs/resctrl: Fix NULL pointer dereference with events
force-disabled in mbm_event mode

Bagas Sanjaya (2):
      net: rmnet: Fix checksum offload header v5 and aggregation
packet formatting
      Documentation: net: net_failover: Separate cloud-ifupdown-helper
and reattach-vf.sh code blocks marker

Bjorn Helgaas (1):
      PCI/ASPM: Enable only L0s and L1 for devicetree platforms

Catalin Marinas (1):
      arm64: mte: Do not warn if the page is already tagged in copy_highpag=
e()

Charlene Liu (1):
      drm/amd/display: increase max link count and fix link->enc NULL
pointer access

Charles Keepax (3):
      genirq/chip: Add buslock back in to irq_set_handler()
      genirq/manage: Add buslock back in to __disable_irq_nosync()
      genirq/manage: Add buslock back in to enable_irq()

Christoph Hellwig (4):
      xfs: avoid busy loops in GCD
      xfs: cache open zone in inode->i_private
      xfs: don't use __GFP_NOFAIL in xfs_init_fs_context
      block: require LBA dma_alignment when using PI

Christophe JAILLET (1):
      usb: dwc3: Don't call clk_bulk_disable_unprepare() twice

Conor Dooley (1):
      spi: dt-bindings: cadence: add soc-specific compatible strings
for zynqmp and versal-net

Cosmin Ratiu (1):
      net/mlx5e: psp, avoid 'accel' NULL pointer dereference

Cosmin Tanislav (2):
      nvmem: rcar-efuse: add missing MODULE_DEVICE_TABLE
      tty: serial: sh-sci: fix RSCI FIFO overrun handling

Cristian Marussi (3):
      firmware: arm_scmi: Account for failed debug initialization
      include: trace: Fix inflight count helper on failed initialization
      firmware: arm_scmi: Skip RAW initialization on failure

Damien Le Moal (2):
      xfs: Improve CONFIG_XFS_RT Kconfig help
      xfs: do not tightly pack-write large files

Dan Carpenter (3):
      tee: qcom: prevent potential off by one read
      tee: qcom: return -EFAULT instead of -EINVAL if copy_from_user() fail=
s
      scsi: libfc: Prevent integer overflow in fc_fcp_recv_data()

Daniel Golle (1):
      serial: 8250_mtk: Enable baud clock and manage in runtime PM

Danilo Krummrich (1):
      rust: device: fix device context of Device::parent()

Darrick J. Wong (4):
      xfs: don't set bt_nr_sectors to a negative number
      xfs: always warn about deprecated mount options
      xfs: loudly complain about defunct mount options
      xfs: fix locking in xchk_nlinks_collect_dir

Dave Penkler (3):
      staging: gpib: Fix no EOI on 1 and 2 byte writes
      staging: gpib: Fix sending clear and trigger events
      staging: gpib: Return -EINTR on device clear

David Hildenbrand (1):
      vmw_balloon: indicate success when effectively deflating during migra=
tion

David Howells (4):
      cifs: Add a couple of missing smb3_rw_credits tracepoints
      cifs: Fix TCP_Server_Info::credits to be signed
      cifs: Call the calc_signature functions directly
      cifs: #include cifsglob.h before trace.h to allow structs in tracepoi=
nts

David Kaplan (1):
      x86/bugs: Qualify RETBLEED_INTEL_MSG

David Thompson (1):
      platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock in=
it

David Wei (1):
      io_uring zcrx: add MAINTAINERS entry

Deepanshu Kartikey (3):
      ocfs2: clear extent cache after moving/defragmenting extents
      hugetlbfs: move lock assertions after early returns in huge_pmd_unsha=
re()
      comedi: fix divide-by-zero in comedi_buf_munge()

Denis Benato (1):
      MAINTAINERS: add Denis Benato as maintainer for asus notebooks

Dewei Meng (1):
      btrfs: directly free partially initialized fs_info in
btrfs_check_leaked_roots()

Dominique Martinet (1):
      Revert "fs/9p: Refresh metadata in d_revalidate for uncached mode too=
"

Enze Li (1):
      mm/damon/core: fix potential memory leak by cleaning ops_filter
in damon_destroy_scheme

Eric Biggers (1):
      lib/crypto: poly1305: Restore dependency of arch code on !KMSAN

Eric Dumazet (2):
      net: gro: clear skb_shinfo(skb)->hwtstamps in napi_reuse_skb()
      net: gro_cells: fix lock imbalance in gro_cells_receive()

Erick Karanja (1):
      hwmon: (pmbus/isl68137) Fix child node reference leak on early return

Fernando Fernandez Mancera (2):
      sysfs: check visibility before changing group attribute ownership
      net: hsr: prevent creation of HSR device with slaves from another net=
ns

Florian Eckert (1):
      serial: 8250_exar: add support for Advantech 2 port card with
Device ID 0x0018

Gao Xiang (3):
      erofs: fix crafted invalid cases for encoded extents
      erofs: avoid infinite loops due to corrupted subpage compact indexes
      erofs: consolidate z_erofs_extent_lookback()

Geert Uytterhoeven (3):
      tee: QCOMTEE should depend on ARCH_QCOM
      xfs: XFS_ONLINE_SCRUB_STATS should depend on DEBUG_FS
      dt-bindings: serial: sh-sci: Fix r8a78000 interrupts

Guenter Roeck (1):
      hwmon: (sht3x) Fix error handling

Haibo Chen (2):
      spi: spi-nxp-fspi: re-config the clock rate when operation
require new clock rate
      spi: spi-nxp-fspi: limit the clock rate for different sample
clock source selection

Han Xu (1):
      spi: spi-nxp-fspi: add extra delay after dll locked

Hans de Goede (1):
      gpiolib: acpi: Make set debounce errors non fatal

Hao Ge (2):
      slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
      slab: Fix obj_ext mistakenly considered NULL due to race condition

Haofeng Li (1):
      timekeeping: Fix aux clocks sysfs initialization loop bound

Haotian Zhang (1):
      gpio: ljca: Fix duplicated IRQ mapping

Harshit Mogalapalli (2):
      hwmon: (gpd-fan) Fix return value when platform_get_resource() fails
      hwmon: (gpd-fan) Fix error handling in gpd_fan_probe()

Heiko Stuebner (1):
      spi: dt-bindings: spi-rockchip: Add RK3506 compatible

Heiner Kallweit (1):
      net: hibmcge: select FIXED_PHY

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

Hugo Villeneuve (1):
      serial: sc16is7xx: remove useless enable of enhanced features

Ilpo J=C3=A4rvinen (1):
      MIPS: Malta: Use pcibios_align_resource() to block io range

Ioana Ciornei (2):
      dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path
      gpio: regmap: add the .fixed_direction_output configuration parameter

Jakub Acs (1):
      fs/notify: call exportfs_encode_fid with s_umount

Jan Kara (1):
      expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID

Jani Nikula (1):
      drm/i915/panic: fix panic structure allocation memory leak

Jason Wang (1):
      virtio-net: zero unused hash fields

Jean Delvare (1):
      misc: amd-sbi: Clarify that this is a BMC driver

Jens Axboe (2):
      io_uring/sqpoll: switch away from getrusage() for CPU accounting
      io_uring/sqpoll: be smarter on when to update the stime usage

Jianpeng Chang (1):
      net: enetc: fix the deadlock of enetc_mdio_lock

Jiasheng Jiang (1):
      ptp: ocp: Fix typo using index 1 instead of i in SMA initialization l=
oop

Jingwei Wang (1):
      riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot

Jingyi Wang (1):
      scsi: ufs: phy: dt-bindings: Add QMP UFS PHY compatible for Kaanapali

Jocelyn Falempe (6):
      drm/panic: Fix drawing the logo on a small narrow screen
      drm/panic: Fix overlap between qr code and logo
      drm/panic: Fix qr_code, ensure vmargin is positive
      drm/panic: Fix kmsg text drawing rectangle
      drm/panic: Fix divide by 0 if the screen width < font width
      drm/panic: Fix 24bit pixel crossing page boundaries

Johannes Wiesb=C3=B6ck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

Junhao Xie (1):
      misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup

K Prateek Nayak (1):
      sched/fair: Start a cfs_rq on throttled hierarchy with PELT
clock throttled

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capaci=
ty()

Kriish Sharma (1):
      binder: Fix missing kernel-doc entries in binder.c

Krishna Chaitanya Chundru (2):
      PCI: dwc: Use custom pci_ops for root bus DBI vs ECAM config access
      Revert "PCI: qcom: Prepare for the DWC ECAM enablement"

Krishna Kurapati (1):
      dt-bindings: usb: qcom,snps-dwc3: Fix bindings for X1E80100

Kurt Borja (1):
      platform/x86: alienware-wmi-wmax: Fix NULL pointer dereference
in sleep handlers

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (2):
      net: ravb: Enforce descriptor type ordering
      net: ravb: Ensure memory write completes before ringing TX doorbell

Lance Yang (1):
      hung_task: fix warnings caused by unaligned lock pointers

Leo Martins (1):
      btrfs: fix delayed_node ref_tracker use after free

Li Qiang (1):
      hwmon: (cgbc-hwmon) Add missing NULL check after devm_kzalloc()

Linus Torvalds (1):
      Linux 6.18-rc3

Long Li (1):
      scsi: storvsc: Prefer returning channel with the same CPU as on
the I/O issuing CPU

Lorenzo Pieralisi (3):
      of/irq: Add msi-parent check to of_msi_xlate()
      of/irq: Fix OF node refcount in of_msi_get_domain()
      of/irq: Export of_msi_xlate() for module usage

Lorenzo Stoakes (1):
      mm/mremap: correctly account old mapping after MREMAP_DONTUNMAP remap

Ma Ke (1):
      staging: gpib: Fix device reference leak in fmh_gpib driver

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (2):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from
registering
      MIPS: Malta: Fix PCI southbridge legacy resource reservations

Marc Kleine-Budde (4):
      can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb()
instead of can_dropped_invalid_skb()
      can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of
can_dropped_invalid_skb()
      can: rockchip-canfd: rkcanfd_start_xmit(): use
can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: netlink: can_changelink(): allow disabling of automatic restart

Marek Szyprowski (2):
      spi: rockchip-sfc: Fix DMA-API usage
      dma-debug: don't report false positives with DMA_BOUNCE_UNALIGNED_KMA=
LLOC

Mario Limonciello (AMD) (1):
      cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate

Mathias Nyman (2):
      xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with
stall event
      xhci: dbc: enable back DbC in resume if it was enabled before suspend

Matthew Brost (1):
      drm/xe: Check return value of GGTT workqueue allocation

Matthieu Baerts (NGI0) (5):
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
      selftests: mptcp: join: mark 'flush re-add' as skipped if not support=
ed
      selftests: mptcp: join: mark implicit tests as skipped if not support=
ed
      selftests: mptcp: join: mark 'delete re-add signal' as skipped
if not supported
      selftests: mptcp: join: mark laminar tests as skipped if not supporte=
d

Mattijs Korpershoek (1):
      spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix NULL pointer dereference

Michael Grzeschik (1):
      tcpm: switch check for role_sw device with fw_node

Michal Pecio (2):
      usb: xhci-pci: Fix USB2-only root hub registration
      net: usb: rtl8150: Fix frame padding

Miguel Ojeda (2):
      rust_binder: clean `clippy::mem_replace_with_default` warning
      objtool/rust: add one more `noreturn` Rust function

Mika Westerberg (3):
      spi: intel: Add support for 128M component density
      spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
      spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash

Mikhail Kshevetskiy (4):
      spi: airoha: return an error for continuous mode dirmap creation case=
s
      spi: airoha: add support of dual/quad wires spi modes to exec_op() ha=
ndler
      spi: airoha: switch back to non-dma mode in the case of error
      spi: airoha: fix reading/writing of flashes with more than one
plane per lun

Mikulas Patocka (1):
      objtool: Fix failure when being compiled on x32 system

Ming Lei (1):
      io_uring: fix buffer auto-commit for multishot uring_cmd

Nam Cao (2):
      rv: Fully convert enabled_monitors to use list_head as iterator
      rv: Make rtapp/pagefault monitor depends on CONFIG_MMU

Nathan Chancellor (2):
      net/mlx5e: Return 1 instead of 0 in invalid case in
mlx5e_mpwrq_umr_entry_size()
      mei: late_bind: Fix -Wincompatible-function-pointer-types-strict

Neil Armstrong (1):
      dt-bindings: usb: switch: split out ports definition

Nirbhay Sharma (2):
      cgroup: Fix seqcount lockdep assertion in cgroup freezer
      firewire: init_ohci1394_dma: add missing function parameter documenta=
tion

Nitin Rawat (1):
      scsi: ufs: qcom: dt-bindings: Document the Kaanapali UFS controller

Ondrej Mosnacek (1):
      nbd: override creds to kernel when calling sock_{send,recv}msg()

Patrisious Haddad (2):
      net/mlx5: Refactor devcom to return NULL on failure
      net/mlx5: Fix IPsec cleanup over MPV device

Paul Walmsley (3):
      riscv: add a forward declaration for cpuinfo_op
      riscv: cpufeature: avoid uninitialized variable in
has_thead_homogeneous_vlenb()
      riscv: hwprobe: avoid uninitialized variable use in hwprobe_arch_id()

Paulo Alcantara (1):
      smb: client: get rid of d_drop() in cifs_do_rename()

Peter Robinson (2):
      usb: misc: Add x86 dependency for Intel USBIO driver
      arm64: dts: broadcom: bcm2712: Define VGIC interrupt

Qiuxu Zhuo (1):
      mm: prevent poison consumption when splitting THP

Rafael J. Wysocki (2):
      Revert "cpuidle: menu: Avoid discarding useful information"
      PM: runtime: Fix conditional guard definitions

Ralf Lici (3):
      net: datagram: introduce datagram_poll_queue for custom receive queue=
s
      espintcp: use datagram_poll_queue for socket readiness
      ovpn: use datagram_poll_queue for socket readiness in TCP

Randy Dunlap (2):
      cgroup/misc: fix misc_res_type kernel-doc warning
      Documentation: networking: ax25: update the mailing list info.

Ranganath V N (1):
      io_uring: Fix code indentation error

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Robert Marko (1):
      net: phy: micrel: always set shared->phydev for LAN8814

Samuel Holland (3):
      riscv: Register IPI IRQs with unique names
      riscv: mm: Define MAX_POSSIBLE_PHYSMEM_BITS for zsmalloc
      riscv: Remove the PER_CPU_OFFSET_SHIFT macro

Sebastian Chlad (2):
      selftests: cgroup: add values_close_report helper
      selftests: cgroup: Use values_close_report in test_cpu

Sebastian Reichel (1):
      net: stmmac: dwmac-rk: Fix disabling set_clock_selection

SeongJae Park (4):
      mm/damon/sysfs: catch commit test ctx alloc failure
      mm/damon/sysfs: dealloc commit test ctx always
      mm/damon/core: fix list_add_tail() call on damon_call()
      mm/damon/core: use damos_commit_quota_goal() for new goal commit

Stefan Metzmacher (8):
      smb: client: allocate enough space for MR WRs and ib_drain_qp()
      smb: server: allocate enough space for RW WRs and ib_drain_qp()
      smb: smbdirect: introduce smbdirect_socket.send_io.lcredits.*
      smb: server: smb_direct_disconnect_rdma_connection() already
wakes all waiters on error
      smb: server: simplify sibling_list handling in
smb_direct_flush_send_list/send_done
      smb: server: make use of smbdirect_socket.send_io.lcredits.*
      smb: client: make use of smbdirect_socket.send_io.lcredits.*
      smb: server: let free_transport() wait for SMBDIRECT_SOCKET_DISCONNEC=
TED

Stefan Wahren (1):
      ARM: dts: broadcom: rpi: Switch to V3D firmware clock

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

Stephen Rothwell (1):
      MAINTAINERS: add Mark Brown as a linux-next maintainer

Sudeep Holla (1):
      firmware: arm_ffa: Add support for IMPDEF value in the memory
access descriptor

Sunil V L (2):
      ACPI: RIMT: Fix unused function warnings when CONFIG_IOMMU_API is dis=
abled
      ACPI: property: Fix argument order in __acpi_node_get_property_refere=
nce()

Takashi Sakamoto (1):
      firewire: core: fix __must_hold() annotation

Thomas Hellstr=C3=B6m (2):
      drm/xe: Retain vma flags when recreating and splitting vmas for madvi=
se
      drm/xe/uapi: Hide the madvise autoreset behind a VM_BIND flag

Thomas Wei=C3=9Fschuh (1):
      csky: abiv2: adapt to new folio flags field

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Ting-Chang Hou (1):
      btrfs: send: fix duplicated rmdir operations when using extrefs

Tonghao Zhang (2):
      net: bonding: update the slave array for broadcast mode
      net: bonding: fix possible peer notify event loss or dup issue

Ulf Hansson (1):
      driver core: fw_devlink: Don't warn about sync_state() pending

Victoria Votokina (2):
      most: usb: Fix use-after-free in hdm_disconnect
      most: usb: hdm_probe: Fix calling put_device() before device
initialization

Vlastimil Babka (1):
      slab: fix slab accounting imbalance due to defer_deactivate_slab()

Wang Liang (1):
      net/smc: fix general protection fault in __smc_diag_dump

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

William Breathitt Gray (3):
      gpio: 104-idio-16: Define maximum valid register address offset
      gpio: pci-idio-16: Define maximum valid register address offset
      gpio: idio-16: Define fixed direction of the GPIO lines

Xi Ruoyao (1):
      ACPICA: Work around bogus -Wstringop-overread warning since GCC 11

Xianwei Zhao (1):
      spi: amlogic: fix spifc build error

Xin Long (1):
      selftests: net: fix server bind failure in sctp_vrf.sh

Xu Yang (1):
      dt-bindings: usb: dwc3-imx8mp: dma-range is required only for imx8mp

Yeounsu Moon (1):
      net: dlink: use dev_kfree_skb_any instead of dev_kfree_skb

tr1x_em (1):
      platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530

