Return-Path: <linux-kernel+bounces-815917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7AB56CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1429E189A8BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A8C23E355;
	Sun, 14 Sep 2025 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xm+fGx9Q"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72C1B3923
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757891521; cv=none; b=ebXvQLaLiXXNrKLrG32vSjmAgJWU2RNsMeHk7plAv/P0ExAHoxf7FXUnDImiK2RWl3HpUY+1JAXC4fXo1xLAMhli906rhqcMcN2HmoNXvp+iFgMKXCbYtvaLFMke4FvgtB2ZknBNWkNb8t+j1urudRnS0KIqpTnsv2XqNPW19/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757891521; c=relaxed/simple;
	bh=/sTCK7iwTsf2BC1hG5XLFGuyTFKYtZcTEYlz0dsMdaw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TID5iqg7orgmaa+LfxVZcKU4yR8Y+uTJyOmnafzU4JlNXVeun47KDMGFj89RCimMsPV8BZcEGf/cFOBY+KKsxHXQNf3to0KZn/BH2GcvhS55i8708dy/7vP1Zf0OE0E78sbnxVvp2tYZhkk3XcPn/axJCGKvdYUuCJO/m9RPO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xm+fGx9Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042cc39551so602163766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757891516; x=1758496316; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T+fnhEKvKSsy0PJs09jGpHahZJn15p/rBzAL+jR8EBE=;
        b=Xm+fGx9QFEckKJ86cIdXHu8TQcmyYpsRwit6jmdreTA4IMFMG/FA6OB2RO+hjgobeK
         JC2VHT922FzM4TU6sGS9vrzl31SvXxl9Ep20rTF25c1gAtREQxWHVyhcWUIcodWd+Ao2
         rR00eanUDbCzS4VU2iZCetHiB+8kix7upYNlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757891516; x=1758496316;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+fnhEKvKSsy0PJs09jGpHahZJn15p/rBzAL+jR8EBE=;
        b=BBMf3TOrB5+k99eHz9fRGNx3Mbc/vgcThm41TKJUncfaYVFxTA+GQ1CM6Jq30Ud5fe
         I2vtaHJ3Iw6A+1wBrF7+WSVJcbGDinFCoS3Mb8b/6F6f4jwiBOgAbmVkhZwRSP3jCjCA
         ZBP8H3HhzkFTd8J4YBGLZ7SGFfplT09+EJSBRI+6Lv4NO1TUIpWJW3c96rnSfM3JdtvK
         KbIN+ghNxVzm8DgCBkx/5t5sZQIdEE6mpjzCkryIGSYXuw4dtaE4ZfRSD895nG3WwpZm
         awHoSMMt2Gk8hP0dFDVv4pnIY/wCU1WqkR2GapeOD2LwU+MjzdwpgZXEWa3EXaPvVGat
         J36w==
X-Gm-Message-State: AOJu0Yy0rrIguGUlKFcmQ7Gkb9kp4gMh9I6hFZ1Y/euhY9nj82EbBfRX
	p8EY9ht+PP/iNTr3VjNf62Ik1rR5TqotCJjxcNKx1DKwYt045VwjSX8raIfVQLQkJ5ZvofIB8PO
	FM1zOQXU=
X-Gm-Gg: ASbGncuLctGpbo3ZB+XXfnN6UAkNsLudxmr4eo1CW7UfW/eOqomG2AHmnyp8AWhGThb
	UdZI4X3BK6nrvKDlGfC0JiITlrPaWwIVryxEW3OYfeEsNuFCZz6LHatb/2vvoOUztBk2sXF8/iX
	8M25a3DtYLf4m6DNj/fcGjtRjdwra9UpmyLwDyFz3Rx4yym4NxI9SNsUZ/e/OpjFSxz1cuFx2Eu
	7Eaptbu0FpUP7sXLxvdi32pYDDnsxDEP4bgM7QWSJwYxozqbOhFmsYPCdfaksXozkCaPrbMDGkQ
	sS228p0yLh+EW56BscuKH4JOpuKovhIq42xhM5AxLkWZjXL/FyIG2SOMHEVYHEznjSpTkH0dmrM
	GdUu/P3dA0iK0HMkEwiIRUOq6kruzOS5J9LD3bkp5tCUg7+W7i3pRTL/4Oq1iEo9JwiUY4vJS
X-Google-Smtp-Source: AGHT+IFi9MvZlgzEIlIQ3SUA8s4zib2WaRfJbAPxsD4xq90IYVyoRmdv6Znop6p8Cs05f8cfYnHekA==
X-Received: by 2002:a17:907:980c:b0:b07:6444:a6dc with SMTP id a640c23a62f3a-b07c3878986mr1091469066b.56.1757891515468;
        Sun, 14 Sep 2025 16:11:55 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd3efsm817306066b.55.2025.09.14.16.11.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 16:11:54 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so523848866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:11:53 -0700 (PDT)
X-Received: by 2002:a17:906:498:b0:b0b:47af:1652 with SMTP id
 a640c23a62f3a-b0b47af1e74mr434336366b.39.1757891513087; Sun, 14 Sep 2025
 16:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 14 Sep 2025 16:11:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wganrF=w6xndv5kFeM9v2QwtZW4yzgHY=0=SwnjxxFVaA@mail.gmail.com>
X-Gm-Features: Ac12FXybwxTeR7EJ2VyglwgFL3S-dW81jMFvtrapz4NYz-p_3VZx4dDrcL76qSQ
Message-ID: <CAHk-=wganrF=w6xndv5kFeM9v2QwtZW4yzgHY=0=SwnjxxFVaA@mail.gmail.com>
Subject: Linux 6.17-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Things remain pretty calm, and for some reason this release seems to
just not have a ton of problems. Hopefully I'm not jinxing it.

It might just have been people being on vacation in August (read:
Europe) which has caused this release to be nice and calm, but
whatever the reason I'm certainly not complaining.

Somewhat unusually, almost a third of the patch is from filesystem
fixes, but that seems to be pure coincidence: not because there are
any particularly large fixes, but because we just happened to
independently have fixes in several different filesystems (ceph, smb
client, nfs, erofs, btrfs). So just random timing.

Another third is driver fixes (gpu being half of it, the rest being
other random drivers), and the final third is just "misc other stuff":
core networking, another CPU speculation mitigation, some
documentation fixes, some selftest updates, and minor noise elsewhere.
Shortlog appended as usual.

But really, none of it is very large. So everything seems slated for a
normal release in two weeks.

Please do keep testing, so that we don't get complacent,

            Linus

---

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels

Alex Deucher (2):
      drm/amdgpu: fix a memory leak in fence cleanup when unloading
      drm/amd/display: use udelay rather than fsleep

Alex Elder (2):
      dt-bindings: serial: 8250: move a constraint
      dt-bindings: serial: 8250: allow "main" and "uart" as clock names

Alex Markuze (2):
      ceph: fix race condition validating r_parent before applying state
      ceph: fix race condition where r_parent becomes stale before
sending message

Alex Tran (1):
      docs: networking: can: change bcm_msg_head frames member to
support flexible array

Alexander Sverdlin (1):
      mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing

Alok Tiwari (1):
      genetlink: fix genl_bind() invoking bind() after -EPERM

Amir Goldstein (2):
      fuse: do not allow mapping a non-regular backing file
      fhandle: use more consistent rules for decoding file handle from user=
ns

Anders Roxell (1):
      dmaengine: ti: edma: Fix memory allocation size for queue_priority_ma=
p

Andreas Kemnade (1):
      regulator: sy7636a: fix lifecycle of power good gpio

Anssi Hannula (1):
      can: xilinx_can: xcan_write_frame(): fix use-after-free of transmitte=
d SKB

Antheas Kapenekakis (1):
      Input: xpad - add support for Flydigi Apex 5

Antoine Tenart (1):
      tunnels: reset the GSO metadata before reusing the skb

Baochen Qiang (1):
      dma-debug: don't enforce dma mapping check on noncoherent allocations

Boris Burkov (1):
      btrfs: fix squota compressed stats leak

Breno Leitao (3):
      arm64: kexec: initialize kexec_buf struct in load_other_segments()
      riscv: kexec: initialize kexec_buf struct
      s390: kexec: initialize kexec_buf struct

Calvin Owens (1):
      btrfs: accept and ignore compression level for lzo

Carlos Llamas (1):
      mm/mremap: fix regression in vrm->new_addr check

Carolina Jubran (1):
      net: dev_ioctl: take ops lock in hwtstamp lower paths

Chen Ridong (1):
      kernfs: Fix UAF in polling when open file is released

Chia-I Wu (1):
      drm/panthor: validate group queue count

Christian Brauner (1):
      coredump: don't pointlessly check and spew warnings

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk t=
able

Christoph Hellwig (2):
      fs: add a FMODE_ flag to indicate IOCB_HAS_METADATA availability
      block: don't silently ignore metadata for sync read/write

Christophe JAILLET (1):
      mtd: rawnand: nuvoton: Fix an error handling path in
ma35_nand_chips_init()

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: avoid overlapping mappings on ECC buffer
      mtd: rawnand: stm32_fmc2: fix ECC overwrite

Dan Carpenter (1):
      dmaengine: idxd: Fix double free in idxd_setup_wqs()

Daniel Borkmann (2):
      bpf: Fix out-of-bounds dynptr write in bpf_crypto_crypt
      selftests/bpf: Extend crypto_sanity selftest with invalid dst buffer

Danilo Krummrich (5):
      gpu: nova-core: depend on CONFIG_64BIT
      rust: device: fix unresolved link to drm::Device
      MAINTAINERS: Add drm-rust tree for Rust DRM drivers and infrastructur=
e
      MAINTAINERS: drm-misc: fix X: entries for nova/nouveau
      MAINTAINERS: Update the DMA Rust entry

David Rosca (2):
      drm/amdgpu/vcn4: Fix IB parsing with multiple engine info packages
      drm/amdgpu/vcn: Allow limiting ctx to instance 0 for AV1 at any time

Davide Caratti (1):
      selftests: can: enable CONFIG_CAN_VCAN as a module

Eduard Zingerman (1):
      bpf: Update the list of BPF selftests maintainers

Edward Adam Davis (2):
      fuse: Block access to folio overlimit
      USB: core: remove the move buf action

Eric Huang (1):
      drm/amdkfd: fix p2p links bug in topology

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Fangzhi Zuo (1):
      drm/amd/display: Disable DPCD Probe Quirk

Florian Westphal (7):
      netfilter: nft_set_bitmap: fix lockdep splat due to missing annotatio=
n
      netfilter: nft_set_pipapo: don't check genbit from packetpath lookups
      netfilter: nft_set_rbtree: continue traversal if element is inactive
      netfilter: nf_tables: place base_seq in struct net
      netfilter: nf_tables: make nft_set_do_lookup available unconditionall=
y
      netfilter: nf_tables: restart set lookup on base_seq change
      MAINTAINERS: add Phil as netfilter reviewer

Gao Xiang (2):
      erofs: fix invalid algorithm for encoded extents
      erofs: fix long xattr name prefix placement

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Fix setting of CPPC.min_perf in active mode
for performance governor

Geert Uytterhoeven (2):
      mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Geoffrey McRae (1):
      drm/amd/display: remove oem i2c adapter on finish

Gerald Schaefer (1):
      s390/mm: Prevent possible preempt_count overflow

Guenter Roeck (1):
      trace/fgraph: Fix error handling

Guopeng Zhang (1):
      fs: fix indentation style

Haiyue Wang (1):
      fuse: virtio_fs: fix page fault for DAX page address

Hangbin Liu (3):
      hsr: use rtnl lock when iterating over ports
      hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr
      hsr: hold rcu and dev lock for hsr_get_port_ndev

Harshit Shah (1):
      serial: xilinx_uartps: read reg size from DTS

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in flow control levels init

Ilya Dryomov (1):
      libceph: fix invalid accesses to ceph_connection_v1_info

Ilya Leoshkevich (1):
      selftests/bpf: Fix "expression result unused" warnings with icecc

Jacob Keller (1):
      i40e: fix Jumbo Frame support after iPXE boot

James Guan (1):
      wifi: virt_wifi: Fix page fault on connect

Jani Nikula (1):
      drm/i915/power: fix size for for_each_set_bit() in abox iteration

Jeff LaBundy (1):
      Input: iqs7222 - avoid enabling unused interrupts

Jeongjun Park (1):
      mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()

Jesper Dangaard Brouer (1):
      bpf, cpumap: Disable page_pool direct xdp_return need larger scope

Jiawen Wu (1):
      net: libwx: fix to enable RSS

Jinjiang Tu (1):
      mm/memory_hotplug: fix hwpoisoned large folio handling in
do_migrate_range()

Jiri Olsa (1):
      bpf: Check the helper function is valid in get_helper_proto

Joanne Koong (2):
      fuse: reflect cached blocksize if blocksize was changed
      fuse: fix fuseblk i_blkbits for iomap partial writes

Johan Hovold (5):
      phy: tegra: xusb: fix device and OF node leak at probe
      phy: ti: omap-usb2: fix device leak at unbind
      phy: ti-pipe3: fix device leak at unbind
      drm/mediatek: fix potential OF node use-after-free
      drm/mediatek: clean up driver data initialisation

Johannes Berg (2):
      wifi: iwlwifi: fix 130/1030 configs
      wifi: nl80211: completely disable per-link stats for now

Jonas Gorski (1):
      net: dsa: b53: fix ageing time for BCM53101

Jonas Rebmann (1):
      net: phy: NXP_TJA11XX: Update Kconfig with TJA1102 support

Jonathan Curley (1):
      NFSv4/flexfiles: Fix layout merge mirror check.

Josef Bacik (1):
      MAINTAINERS: update btrfs entry

Julia Filipchuk (1):
      drm/xe: Extend Wa_13011645652 to PTL-H, WCL

Julien Massot (1):
      Input: mtk-pmic-keys - MT6359 has a specific release irq

Justin Worrell (1):
      SUNRPC: call xs_sock_process_cmsg for all cmsg

K Prateek Nayak (1):
      x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon

KaFai Wan (1):
      bpf: Allow fall back to interpreter for programs with stack size <=3D=
 512

Klaus Kudielka (1):
      PCI: mvebu: Fix use of for_each_of_range() iterator

Kohei Enju (1):
      igb: fix link test skipping when interface is admin down

Krister Johansen (1):
      mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN

Krzysztof Kozlowski (2):
      dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks
      MAINTAINERS: Input: Drop melfas-mip4 section

Kumar Kartikeya Dwivedi (1):
      rqspinlock: Choose trylock fallback for NMI waiters

Kuniyuki Iwashima (1):
      tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to
allocate psock->cork.

Kyle Meyer (1):
      mm/memory-failure: fix redundant updates for already poisoned pages

Leon Hwang (2):
      bpf: Reject bpf_timer for PREEMPT_RT
      selftests/bpf: Skip timer cases when bpf_timer is not supported

Lijo Lazar (1):
      drm/amdgpu: Wait for bootloader after PSPv11 reset

Linus Torvalds (1):
      Linux 6.17-rc6

Luo Gengkun (1):
      tracing: Fix tracing_marker may trigger page fault during preempt_dis=
able

Maciej Fijalkowski (1):
      xsk: Fix immature cq descriptor production

Mario Limonciello (AMD) (2):
      cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume
      drm/amd/display: Drop dm_prepare_suspend() and dm_complete()

Mark Harmstone (1):
      btrfs: don't allow adding block device of less than 1 MB

Mark Tinguely (1):
      ocfs2: fix recursive semaphore deadlock in fiemap call

Mathias Nyman (3):
      xhci: dbc: decouple endpoint allocation from initialization
      xhci: dbc: Fix full DbC transfer ring after several reconnects
      xhci: fix memory leak regression when freeing xhci vdev devices
depth first

Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: fix if-idx attribute type
      doc: mptcp: net.mptcp.pm_type is deprecated
      selftests: mptcp: shellcheck: support v0.11.0

Max Kellermann (2):
      ceph: always call ceph_shift_unused_folios_left()
      ceph: fix crash after fscrypt_encrypt_pagecache_blocks() error

Miaohe Lin (1):
      mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when
unpoison memory

Miaoqian Lin (1):
      dmaengine: dw: dmamux: Fix device reference leak in
rzn1_dmamux_route_allocate

Miaoqing Pan (2):
      wifi: ath12k: Fix missing station power save configuration
      wifi: ath12k: fix WMI TLV header misalignment

Michael Walle (1):
      phy: ti: gmii-sel: Always write the RGMII ID setting

Michal Schmidt (1):
      i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Michal Wajdeczko (1):
      drm/xe/configfs: Don't touch survivability_mode on fini

Mike Rapoport (Microsoft) (2):
      init/main.c: fix boot time tracing crash
      MAINTAINERS: add tree entry to numa memblocks and emulation block

Mike Snitzer (1):
      nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Nathan Chancellor (1):
      compiler-clang.h: define __SANITIZE_*__ macros only when undefined

Nithyanantham Paramasivam (1):
      wifi: cfg80211: Fix "no buffer space available" error in
nl80211_get_station() for MLO

Oleksij Rempel (1):
      net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO
runtime PM wakeups

Omar Sandoval (1):
      btrfs: fix subvolume deletion lockup caused by inodes xarray race

Oscar Maes (1):
      selftests: net: add test for destination in broadcast packets

Ovidiu Bunea (1):
      drm/amd/display: Correct sequences and delays for DCN35 PG & RCG

Paolo Abeni (1):
      Revert "net: usb: asix: ax88772: drop phylink use in PM to avoid
MDIO runtime PM wakeups"

Paulo Alcantara (2):
      smb: client: fix compound alignment with encryption
      smb: client: fix data loss due to broken rename(2)

Pawan Gupta (7):
      Documentation/hw-vuln: Add VMSCAPE documentation
      x86/vmscape: Enumerate VMSCAPE bug
      x86/vmscape: Add conditional IBPB mitigation
      x86/vmscape: Enable the mitigation
      x86/bugs: Move cpu_bugs_smt_update() down
      x86/vmscape: Warn when STIBP is disabled with SMT
      x86/vmscape: Add old Intel CPUs to affected list

Peilin Ye (1):
      bpf: Tell memcg to use allow_spinning=3Dfalse path in bpf_timer_init(=
)

Pengyu Luo (1):
      phy: qualcomm: phy-qcom-eusb2-repeater: fix override properties

Petr Machata (1):
      net: bridge: Bounce invalid boolopts

Philipp Stanner (1):
      Revert "drm/nouveau: Remove waitque for sched teardown"

Pratap Nirujogi (1):
      drm/amd/amdgpu: Declare isp firmware binary file

Pu Lehui (1):
      tracing: Silence warning when chunk allocation fails in trace_pid_wri=
te

Qianfeng Rong (1):
      trace: Remove redundant __GFP_NOWARN

Qu Wenruo (1):
      btrfs: fix corruption reading compressed range when block size
is smaller than page size

Quanmin Yan (2):
      mm/damon/lru_sort: avoid divide-by-zero in
damon_lru_sort_apply_parameters()
      mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_paramet=
ers()

RD Babiera (1):
      usb: typec: tcpm: properly deliver cable vdms to altmode drivers

Rafael J. Wysocki (2):
      PM: EM: Add function for registering a PD without capacity update
      PM: hibernate: Restrict GFP mask in hibernation_snapshot()

Reinette Chatre (1):
      fs/resctrl: Eliminate false positive lockdep warning when
reading SNC counters

Rob Herring (Arm) (1):
      dt-bindings: phy: marvell,comphy-cp110: Fix clock and child node
constraints

Rong Tao (2):
      bpf: Fix bpf_strnstr() to handle suffix match cases better
      selftests/bpf: Add tests for bpf_strnstr

Russell King (Oracle) (2):
      net: phy: fix phy_uses_state_machine()
      net: ethtool: fix wrong type used in struct kernel_ethtool_ts_info

Sang-Heon Jeon (1):
      mm/damon/core: set quota->charged_from to jiffies at first charge win=
dow

Santhosh Kumar K (1):
      mtd: spinand: winbond: Fix oob_layout for W25N01JW

Scott Mayhew (1):
      nfs/localio: restore creds before releasing pageio data

Stanislav Fomichev (1):
      macsec: sync features on RTM_NEWLINK

Stanislav Fort (1):
      mm/damon/sysfs: fix use-after-free in state_show()

Stefan Wahren (1):
      net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()

Stephan Gerhold (3):
      dt-bindings: dma: qcom: bam-dma: Add missing required properties
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees
      phy: qcom: qmp-pcie: Fix PHY initialization when powered down by firm=
ware

Takashi Iwai (2):
      usb: gadget: midi2: Fix missing UMP group attributes initialization
      usb: gadget: midi2: Fix MIDI2 IN EP max packet size

Tetsuo Handa (3):
      can: j1939: implement NETDEV_UNREGISTER notification handler
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately
when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when
j1939_local_ecu_get() fails

Thomas Hellstr=C3=B6m (3):
      drm/xe: Attempt to bring bos back to VRAM after eviction
      drm/xe: Allow the pm notifier to continue on failure
      drm/xe: Block exec and rebind worker while evicting for suspend
/ hibernate

Thomas Richter (2):
      s390/pai: Deny all events not handled by this PMU
      s390/cpum_cf: Deny all sampling events by counter PMU

Tianyu Xu (1):
      igb: Fix NULL pointer dereference in ethtool loopback test

Tigran Mkrtchyan (1):
      flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_=
read

Trond Myklebust (13):
      NFSv4: Don't clear capabilities that won't be reset
      NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
      NFSv4: Clear NFS_CAP_OPEN_XOR and NFS_CAP_DELEGTIME if not supported
      NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
      NFS: Protect against 'eof page pollution'
      NFSv4.2: Protect copy offload and clone against 'eof page pollution'
      NFS: Serialise O_DIRECT i/o and truncate()
      NFSv4.2: Serialise O_DIRECT i/o and fallocate()
      NFSv4.2: Serialise O_DIRECT i/o and clone range
      NFSv4.2: Serialise O_DIRECT i/o and copy range
      NFS: nfs_invalidate_folio() must observe the offset and size argument=
s
      NFS: Fix the marking of the folio as up to date
      Revert "SUNRPC: Don't allow waiting for exiting tasks"

Uladzislau Rezki (Sony) (1):
      mm/vmalloc, mm/kasan: respect gfp mask in kasan_populate_vmalloc()

Vlad Dumitrescu (1):
      percpu: fix race on alloc failed warning limit

Vladimir Oltean (2):
      net: phylink: add lock for serializing concurrent pl->phydev
writes with resolver
      net: phy: transfer phy_config_inband() locking responsibility to phyl=
ink

Vladimir Riabchun (1):
      ftrace/samples: Fix function size computation

Wang Liang (1):
      tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()

Wei Yang (1):
      mm/khugepaged: fix the address passed to notifier on testing young

Xing Guo (1):
      selftests/fs/mount-notify: Fix compilation failure.

Xiongfeng Wang (1):
      hrtimers: Unconditionally update target CPU base after offline
timer migration

Yi Sun (2):
      dmaengine: idxd: Remove improper idxd_free
      dmaengine: idxd: Fix refcount underflow on module unload

Yifan Zhang (1):
      amd/amdkfd: correct mem limit calculation for small APUs

Yuezhang Mo (1):
      erofs: fix runtime warning on truncate_folio_batch_exceptionals()

Ziyue Zhang (1):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy binding=
s

wangzijie (1):
      proc: fix type confusion in pde_set_flags()

