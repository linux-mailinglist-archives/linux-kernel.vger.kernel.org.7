Return-Path: <linux-kernel+bounces-892212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB99C44A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4430E4E5BFA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF822253B42;
	Sun,  9 Nov 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DeNhMP+q"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9192B221299
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730518; cv=none; b=uwgochqaF7in7gHv/ENum+D64aHZnMmPVjf54hp8KM/k1VSTdnp1RfEMdjxF/wKYyA5qfHLP3xrMEOYnpXydm0s4kvb1V3GMGVGpjZScRRtkbjqA1fUt97gDOKSDKLc1LLGm239abK7nrWY0mCVP7aOQwrM3sgNk/oGel7+6De0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730518; c=relaxed/simple;
	bh=C1R4XLkk8Pa/nBIK4Op3SKD5SJlpuUnRw2sygLvSkvY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eBjIwWdkecyT2uyn77XLLqdMDyozkqSsGTuPrG6yoe/GKQAe1s5IE7A4S+i2oc2wBGTpjjcIhru2WftpQOi6+MYWoEQj2/ld6r0Zh+lmU2CPtl8TKhJEq4Mylpf+FoACLlo7wBTAEnlJlpIhMEptkAOHu07O5ZhjB53l2VYvDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DeNhMP+q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b71397df721so256513066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762730514; x=1763335314; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2p3qVhtwKxv43T/CNL7XVix9vFdkRb83ctndgQ9J3PY=;
        b=DeNhMP+qMqGM7mp+QLanSUhMasDXllUbHKeg0u1H4buOpmQFDi+cXPU6QQxMWgKc47
         jCRlwIEsdQAaVOAodaZejbD1oFHsl0DVT1VfxsOzqCUTOydBLXJLT2XQJnFqqNhlYdsd
         KmZnCyzvDKSY+wdY/yuVLOFX6yNjivxjAtbFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730514; x=1763335314;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p3qVhtwKxv43T/CNL7XVix9vFdkRb83ctndgQ9J3PY=;
        b=dOufELgKGkJLPIuirBPVbTG9UhHu1FoYMIuAN/pg6I1WN9XigQ8ovo1YZt7cOv7kLA
         s/8CplQatG6SlBLpAfYJrKbmPVUFhwhaHuZiO+S7UoIYMidj8P/IeOE9ZCXVqruLqJ4L
         whBgibGjzrU1traFet9Knof9rnfw3j1YwryJOjb2oMfPIzGayhugNROh6qkNGXZv5Ll0
         mr9YOhL4kBHYqb3c3Xq6A5sjpenRsR0lT+k6LidyNcWwm6zqifLWwWAkZ8bDA+BjlUiW
         fu3ZHhvKOAyuX266qfqVaWbnPxB3uiAYoMW/NTL/jQvvTkI5le/jUItvYzFec0OxQm3p
         Pixw==
X-Gm-Message-State: AOJu0YzdPxOi6wxrflTEj3hR+o50u6hqTquciHGJ8qRNV77VcUYQzea9
	mcf4KobvDxF17BwhsL50DOQtwZHdoCF68qVs5VJnzZChIGOyJ1Nt07jtmB3iIfOGtqIHAsXQ4nL
	m5XpAZKE=
X-Gm-Gg: ASbGncv1MqYUItSgif1ImwtSLhtFeCrKFb793jQJtJB6kYvVi2m/siA6q5LQ1+2QnAj
	Rtbimhjb1sFuCsey71YKESSJt6FmpZRfe+xnxpIywtsDqdkMPJfninJZgKOZAdQlx4/3mN50pUv
	tEWv8E6pn5NNIDe2gdFSm4ge1SpxS2kXOD9hiZ7Dq9hNNCXIppRZiQZ7wGO2Bf4mGhOo+ilkdsh
	MWRTT5VhEB0ee3YlyvIKJN85T7mjevkJo8g6dDWWm0ASb4duwNA0XjglCUzK3N2/uz243qT4Sfx
	xrsvERH8EVmMsLwUyALyqFLJC5QVporKNYp0AMvEdgIKbZsBVbc17GtRmX/72t9/7Vm3RCgorkY
	KfTGNXQ2eBtSbejTEDdEfkPnCoVzNmZEV/bPh1CULzJxNYF475sEONDtuJnqEFHp/s7uEPiVW49
	0nf/9hiaH8Fd/UO6Yk5P4/aM4eHEBlx3+61FabE7XY68/0nJhQmU1MDnZtWGJW
X-Google-Smtp-Source: AGHT+IEXB/N+6g8YSnBMnBxPRYD8i8Tfdxa1h4noAYmrnLIGt3vIgM+BCRnMzSUoaS+i5X7xlGG79g==
X-Received: by 2002:a17:906:6a27:b0:b45:60ad:daf9 with SMTP id a640c23a62f3a-b72e028a602mr679603566b.3.1762730513382;
        Sun, 09 Nov 2025 15:21:53 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d1b4916dsm812431466b.15.2025.11.09.15.21.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:21:52 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso362893266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:21:52 -0800 (PST)
X-Received: by 2002:a17:907:84d:b0:b72:c261:3ad4 with SMTP id
 a640c23a62f3a-b72e0410a5dmr665710466b.34.1762730511909; Sun, 09 Nov 2025
 15:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 15:21:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3Tbqg7xONe_KCwiAaDVswAzLRcYxyp8_VZa_SAY1hZA@mail.gmail.com>
X-Gm-Features: AWmQ_bkgBwvNPGUEfhLSnj8Z8n_YtXCaILTKfjkD-7tyv3Shf9y0UAfbPBKzugY
Message-ID: <CAHk-=wi3Tbqg7xONe_KCwiAaDVswAzLRcYxyp8_VZa_SAY1hZA@mail.gmail.com>
Subject: Linux 6.18-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Things remain calm and small, and everything looks pretty normal. The
rc5 diffstat is mostly drivers, with misc random noise in
architectures (x86, some risc-v), tooling (mostly just a perf header
file sync, some selftest fixes), some core networking, and minor
filesystem fixes (xfs, smb, btrfs).

There's a blip in io_uring, but that's mostly removing a new ABI that
wasn't quite ready for prime-time.

In other words: it all looks just the way I like it at this point:
small and boring.

Let's hope it stays that way,

                 Linus

---
Aaron Lu (1):
      sched/fair: Prevent cfs_rq from being unthrottled with zero
runtime_remaining

Abdun Nihaal (3):
      wifi: zd1211rw: fix potential memory leak in __zd_usb_enable_rx()
      Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Adrian Hunter (4):
      scsi: ufs: ufs-pci: Fix S0ix/S3 for Intel controllers
      scsi: ufs: core: Add a quirk to suppress link_startup_again
      scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE
for Intel ADL
      scsi: ufs: core: Fix invalid probe error return value

Alex Deucher (3):
      drm/amdgpu: set default gfx reset masks for gfx6-8
      drm/amdgpu: Drop PMFW RLC notifier from amdgpu_device_suspend()
      drm/amdgpu/smu: Handle S0ix for vangogh

Alex Hung (1):
      drm/amd/display: Fix black screen with HDMI outputs

Alok Tiwari (1):
      net: mdio: Check regmap pointer returned by device_node_to_regmap()

Anubhav Singh (2):
      selftests/net: fix out-of-order delivery of FIN in gro:tcp test
      selftests/net: use destination options instead of hop-by-hop

Ariel D'Alessandro (1):
      drm/mediatek: Disable AFBC support on Mediatek DRM driver

Arnaldo Carvalho de Melo (14):
      tools arch x86: Sync msr-index.h to pick
AMD64_{PERF_CNTR_GLOBAL_STATUS_SET,SAVIC_CONTROL},
IA32_L3_QOS_{ABMC,EXT}_CFG
      tools headers uapi: Update fs.h with the kernel sources
      tools headers: Sync uapi/linux/prctl.h with the kernel source
      tools headers: Sync uapi/linux/fcntl.h with the kernel sources
      tools headers x86: Sync table due to introducion of uprobe syscall
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h to pick
DRM_IOCTL_GEM_CHANGE_HANDLE
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      MAINTAINERS: Add James Clark as a perf tools reviewer
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools headers svm: Sync svm headers with the kernel sources
      tools headers UAPI: Sync KVM's vmx.h header with the kernel
sources to handle new exit reasons
      tools headers asm: Sync fls headers header with the kernel sources
      perf symbols: Handle '1' symbols in /proc/kallsyms

Balasubramani Vivekanandan (1):
      drm/xe/guc: Synchronize Dead CT worker with unbind

Baochen Qiang (1):
      Revert "wifi: ath10k: avoid unnecessary wait for service ready messag=
e"

Bart Van Assche (3):
      scsi: ufs: core: Fix a race condition related to the "hid" attribute =
group
      scsi: ufs: core: Reduce link startup failure logging
      scsi: ufs: core: Revert "Make HID attributes visible"

Bartosz Golaszewski (2):
      gpio: swnode: don't use the swnode's name as the key for GPIO lookup
      gpiolib: fix invalid pointer access in debugfs

Ben Dooks (1):
      riscv: asm: use .insn for making custom instructions

Benjamin Berg (4):
      wifi: cfg80211: add an hrtimer based delayed work item
      wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
      wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
      wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work

Bobby Eshleman (1):
      selftests/vsock: avoid false-positives when checking dmesg

Breno Leitao (1):
      netpoll: Fix deadlock in memory allocation under spinlock

Bui Quang Minh (1):
      virtio-net: fix received length check in big packets

Carolina Jubran (1):
      ptp: Allow exposing cycles only for clocks with free-running counter

Chengchang Tang (1):
      RDMA/hns: Fix recv CQ and QP cache affinity

Christoph Hellwig (3):
      xfs: fix a rtgroup leak when xfs_init_zone fails
      xfs: fix zone selection in xfs_select_open_zone_mru
      xfs: free xfs_busy_extents structure when no RT extents are queued

Chu Guangqing (1):
      ACPI: CPPC: Fix typo in a comment

Chunyan Zhang (1):
      riscv: stacktrace: Disable KASAN checks for non-current tasks

Dan Carpenter (3):
      EDAC/versalnet: Fix off by one in handle_error()
      ACPI: SBS: Fix present test in acpi_battery_read()
      octeontx2-pf: Fix devm_kcalloc() error checking

Dapeng Mi (1):
      perf/core: Fix system hang caused by cpu-clock usage

Darrick J. Wong (2):
      xfs: fix delalloc write failures in software-provided atomic writes
      xfs: fix various problems in xfs_atomic_write_cow_iomap_begin

Dave Airlie (1):
      Revert "drm/nouveau: set DMA mask before creating the flush page"

Dragos Tatulea (3):
      net/mlx5e: SHAMPO, Fix header mapping for 64K pages
      net/mlx5e: SHAMPO, Fix skb size check for 64K pages
      net/mlx5e: SHAMPO, Fix header formulas for higher MTUs and 64K pages

Eric Biggers (1):
      lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN

Filipe Manana (1):
      btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new na=
me

Gal Pressman (1):
      net/mlx5e: Fix return value in case of module EEPROM read error

Gautam R A (1):
      bnxt_en: Fix null pointer dereference in bnxt_bs_trace_check_wrap()

Guofeng Yue (1):
      RDMA/hns: Remove an extra blank line

Gustavo Luiz Duarte (1):
      netconsole: Acquire su_mutex before navigating configs hierarchy

Hangbin Liu (2):
      net: vlan: sync VLAN features with lower device
      bonding: fix NULL pointer dereference in actor_port_prio setting

Hans de Goede (3):
      media: v4l2-subdev / pdx86: int3472: Use "privacy" as con_id for
the privacy LED
      Input: Add keycodes for electronic privacy screen on/off hotkeys
      platform/x86: dell-wmi-base: Handle electronic privacy screen
on/off events

Haotian Zhang (1):
      net: wan: framer: pef2256: Switch to devm_mfd_add_devices()

Helge Deller (1):
      parisc: Avoid crash due to unaligned access in unwinder

Henrique Carvalho (1):
      smb: client: fix potential UAF in smb2_close_cached_fid()

Horatiu Vultur (3):
      net: phy: micrel: lan8842 errata
      net: phy: micrel: lan8842 errata
      lan966x: Fix sleeping in atomic context

Huiwen He (1):
      sctp: make sctp_transport_init() void

Ilia Gavrilov (1):
      Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Jacob Moroni (2):
      RDMA/irdma: Fix SD index calculation
      RDMA/irdma: Set irdma_cq cq_num field during CQ create

Jacopo Mondi (2):
      media: cx18: Fix invalid access to file *
      media: ivtv: Fix invalid access to file *

James Jones (2):
      drm: define NVIDIA DRM format modifiers for GB20x
      drm/nouveau: Advertise correct modifiers on GB20x

Janusz Krzysztofik (1):
      drm/i915: Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD

Jason Gunthorpe (2):
      iommufd: Don't overflow during division for dirty tracking
      iommufd: Make vfio_compat's unmap succeed if the range is already emp=
ty

Jason-JH Lin (1):
      drm/mediatek: Add pm_runtime support for GCE power control

Jay Bhat (1):
      RDMA/irdma: Fix vf_id size to u16 to avoid overflow

Jean Delvare (1):
      kbuild: Let kernel-doc.py use PYTHON3 override

Jiawen Wu (1):
      net: libwx: fix device bus LAN ID

Jihed Chaibi (1):
      dt-bindings: gpio: ti,twl4030: Correct the schema $id path

Jon Hunter (2):
      Revert "rtc: tps6586x: Fix initial enable_irq/disable_irq balance"
      Revert "rtc: cpcap: Fix initial enable_irq/disable_irq balance"

Jonas Gorski (8):
      net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bc=
m63xx
      Documentation: ACPI: i2c-muxes: fix I2C device references
      MAINTAINERS: add brcm tag driver to b53
      net: dsa: b53: fix resetting speed and pause on forced link
      net: dsa: b53: fix bcm63xx RGMII port link adjustment
      net: dsa: b53: fix enabling ip multicast
      net: dsa: b53: stop reading ARL entries if search is done
      net: dsa: b53: properly bound ARL searches for < 4 ARL bin chips

Josephine Pfeiffer (1):
      riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro

Joshua Rogers (1):
      smb: client: validate change notify buffer before copy

Jouni H=C3=B6gander (1):
      drm/xe: Do clean shutdown also when using flr

Junxian Huang (1):
      RDMA/hns: Fix wrong WQE data when QP wraps around

Kalesh AP (1):
      bnxt_en: Fix a possible memory leak in bnxt_ptp_init

Kashyap Desai (1):
      bnxt_en: Always provide max entry and entry size in coredump segments

Krzysztof Czurylo (1):
      MAINTAINERS: Update irdma maintainers

Krzysztof Kozlowski (2):
      i2c: muxes: pca954x: Fix broken reset-gpio usage
      gpio: tb10x: Drop unused tb10x_set_bits() function

Lazar Aleksic (1):
      platform: x86: Kconfig: fix minor typo in help for WIRELESS_HOTKEY

LiangCheng Wang (1):
      drm/tiny: pixpaper: add explicit dependency on MMU

Lijo Lazar (1):
      drm/amdgpu: Fix wait after reset sequence in S3

Linus Torvalds (2):
      x86: uaccess: don't use runtime-const rewriting in modules
      Linux 6.18-rc5

Marek Szyprowski (1):
      media: videobuf2: forbid remove_bufs when legacy fileio is active

Mario Limonciello (2):
      x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode
      drm/amd: Fix suspend failure with secure display TA

Mario Limonciello (AMD) (2):
      drm/amd/display: Don't stretch non-native images by default in eDP
      x86/microcode/AMD: Add more known models to entry sign checking

Martin Willi (1):
      wifi: mac80211_hwsim: Limit destroy_on_close radio removal to netgrou=
p

Masami Hiramatsu (Google) (2):
      tracing: tprobe-events: Fix to register tracepoint correctly
      tracing: tprobe-events: Fix to put tracepoint_user when disable the t=
probe

Matt Coster (1):
      drm/imagination: Optionally depend on POWER_SEQUENCING

Matthew Brost (1):
      drm/xe: Enforce correct user fence signaling order using

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix fdb hash size configuration

Miaoqian Lin (1):
      riscv: Fix memory leak in module_frob_arch_sections()

Miaoqing Pan (1):
      Revert "wifi: ath12k: Fix missing station power save configuration"

Michael Chan (1):
      bnxt_en: Shutdown FW DMA in bnxt_shutdown()

Michael S. Tsirkin (1):
      virtio_net: fix alignment for virtio_net_hdr_v1_hash

Michal Swiatkowski (1):
      libie: depend on DEBUG_FS when building LIBIE_FWLOG

Miguel Ojeda (5):
      rust: devres: fix private intra-doc link
      rust: condvar: fix broken intra-doc link
      rust: kbuild: treat `build_error` and `rustdoc` as kernel objects
      rust: kbuild: workaround `rustdoc` doctests modifier bug
      rust: kbuild: support `-Cjump-tables=3Dn` for Rust 1.93.0

Mohammad Heib (2):
      net: ionic: add dma_wmb() before ringing TX doorbell
      net: ionic: map SKB after pseudo-header checksum prep

Namjae Jeon (2):
      ksmbd: detect RDMA capable lower devices when bridge and vlan
netdev is used
      ksmbd: detect RDMA capable netdevs include IPoIB

Nathan Chancellor (5):
      compiler_types: Introduce __nocfi_generic
      ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
      libeth: xdp: Disable generic kCFI pass for libeth_xdp_tx_xmit_bulk()
      lib/crypto: curve25519-hacl64: Fix older clang KASAN workaround for G=
CC
      kbuild: Strip trailing padding bytes from modules.builtin.modinfo

Nicolin Chen (1):
      iommufd/selftest: Fix ioctl return value in _test_cmd_trigger_vevents=
()

Nikolay Aleksandrov (2):
      net: bridge: fix use-after-free due to MST port state bypass
      net: bridge: fix MST static key usage

Nishanth Menon (1):
      net: ethernet: ti: netcp: Standardize knav_dma_open_channel to
return NULL on error

Nitin Rawat (1):
      scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS power down (PC=3D3)

Pavel Begunkov (3):
      io_uring/zcrx: remove sync refill uapi
      io_uring: fix types for region size calulation
      io_uring: fix regbuf vector size truncation

Peter Zijlstra (2):
      futex: Optimize per-cpu reference counting
      compiler_types: Move unused static inline functions warning to W=3D2

Philip Yang (1):
      drm/amdkfd: Don't clear PT after process killed

Pierre-Eric Pelloux-Prayer (1):
      drm/sched: Fix deadlock in drm_sched_entity_kill_jobs_cb

Qendrim Maxhuni (1):
      net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup

Qiu Wenbo (1):
      platform/x86: int3472: Fix double free of GPIO device during unregist=
er

Qu Wenruo (1):
      btrfs: ensure no dirty metadata is written back for an fs with errors

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: hci_event: validate skb length for unknown CC opcode

Ricardo Ribalda (1):
      media: uvcvideo: Use heuristic to find stream entity

Rong Zhang (1):
      drm/amd/display: Fix NULL deref in debugfs odm_combine_segments

Sakari Ailus (1):
      MAINTAINERS: Update int3472 maintainers

Samuel Zhang (1):
      drm/amdgpu: fix gpu page fault after hibernation on PF passthrough

Sebastian Andrzej Siewior (1):
      net: gro_cells: Reduce lock scope in gro_cell_poll

Shantiprasad Shettar (1):
      bnxt_en: Fix warning in bnxt_dl_reload_down()

Shardul Bankar (1):
      btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation

Shuhao Fu (2):
      RDMA/uverbs: Fix umem release in UVERBS_METHOD_CQ_CREATE
      smb: client: fix refcount leak in smb2_set_path_attr

Stefan Wiehler (3):
      sctp: Hold RCU read lock while iterating over address list
      sctp: Prevent TOCTOU out-of-bounds write
      sctp: Hold sock lock while iterating over address list

Steven Rostedt (1):
      ring-buffer: Do not warn in ring_buffer_map_get_reader() when
reader catches up

Tejas Upadhyay (1):
      drm/xe: Move declarations under conditional branch

Thomas Richard (1):
      gpio: aggregator: restore the set_config operation

Thorsten Blum (2):
      riscv: KGDB: Replace deprecated strcpy in kgdb_arch_handle_qxfer_pkt
      cpuidle: riscv-sbi: Replace deprecated strcpy in sbi_cpuidle_init_cpu

Tim Hostetler (2):
      gve: Implement gettimex64 with -EOPNOTSUPP
      gve: Implement settime64 with -EOPNOTSUPP

Timur Tabi (1):
      drm/nouveau: set DMA mask before creating the flush page

Tristram Ha (1):
      net: dsa: microchip: Fix reserved multicast address table programming

Umesh Nerlige Ramappa (1):
      drm/i915: Fix conversion between clock ticks and nanoseconds

Vivian Wang (3):
      riscv: tests: Rename kprobes_test_riscv to kprobes_riscv
      riscv: tests: Make RISCV_KPROBES_KUNIT tristate
      net: spacemit: Check netif_running() in emac_set_pauseparam()

Vlastimil Babka (1):
      slab: prevent infinite loop in kmalloc_nolock() with debugging

Wang Liang (1):
      selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing
ethtool-common.sh

Wayne Lin (1):
      drm/amd/display: Enable mst when it's detected but yet to be initiali=
zed

YanLong Dai (1):
      RDMA/bnxt_re: Fix a potential memory leak in destroy_gsi_sqp

Yang Wang (1):
      drm/amd/pm: fix missing device_attr cleanup in amdgpu_pm_sysfs_init()

Yazen Ghannam (1):
      x86/amd_node: Fix AMD root device caching

Yongpeng Yang (1):
      fscrypt: fix left shift underflow when inode->i_blkbits > PAGE_SHIFT

Yuta Hayama (1):
      rtc: rx8025: fix incorrect register reference

Zhang Chujun (1):
      tracing/tools: Fix incorrcet short option in usage text for --threads

Zilin Guan (1):
      tracing: Fix memory leaks in create_field_var()

austinchang (1):
      btrfs: mark dirty extent range for out of bound prealloc extents

wenglianfa (1):
      RDMA/hns: Fix the modification of max_send_sge

