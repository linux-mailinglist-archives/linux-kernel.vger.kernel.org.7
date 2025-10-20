Return-Path: <linux-kernel+bounces-859947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7BBEF060
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A3874E5268
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0B1E8329;
	Mon, 20 Oct 2025 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CLPP0IsH"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5631E32B9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760924293; cv=none; b=bB6wDu85uvN8KUInQZM3qITC862kspztfPDhtrxWDTkGOdiqAUhDSzcSReio1gZRZ+IylHBq1VbskoWXJiTzcw1ctyftGtqqA12DjoplpuaXWyguZJVCMc7DcD7oi/pGdUesPFGkwak9FT+s1BgZAV9dj9FWZxqa96/WQ+NP38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760924293; c=relaxed/simple;
	bh=e4UV/V/OrRadSWnnOTB6uThTLuB+KqkotS1PlV2uHec=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=f4zh0H580sE+wlswRGguWBRS/64BIcZ6/tDJP0Oe2jw1U0KcziF+uB16alWs8HQ/d2Pv0yvRtkDjVVN92uxhkWkqE2ecqwRsKPmjF5Sja7z0kiennH+ip/kqjI5yV8rSbv4PBia8t/2P0ty6wI+iHv2ECzHAeHno1/SIgsIkCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CLPP0IsH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso8676222a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760924286; x=1761529086; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mzzjmTpWeGCLQu9hrZSiXhqlAuDxq27NUGYksf/9m7k=;
        b=CLPP0IsHphKIY8JhxWG09CD7F2L12d/6VUcgpKya6lFMeKpnRDtTapGFVS4eM26Nnl
         Md0a70bHVF3vyiK2Ecw/2pMr2F0SFvpEdRzCaV9uL8AoFNTDPj+VSsrg3TAmWq9EyXSv
         GamAv8BFormHLXFk8PaK13FEpZDYAKrkiivnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760924286; x=1761529086;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzzjmTpWeGCLQu9hrZSiXhqlAuDxq27NUGYksf/9m7k=;
        b=NlJurWzJ7oOM7u0W46B5IxG4PcSQnHvXHxdSJuLN0vjJx7xnuZRP/5eZFiliElvaS9
         47l5anCIvVLb5B41NlV7UwCz9aNHwQl8/AdQg3saylPThLIX+CG+GSRRv7/lQ4SPl8gb
         c+7Dspp/y38gxG6GdPxemD7oAoxdB0fzIRxBBWi97SGcyv3iyMK4wCcWMtt1igJP5Pp6
         hdjsTExT+VSouSVYC87pOLIXbszmki3BJm8yhKxsnczlLEGy/v2F/orN2NXKxwwYnamK
         NfLaGCeEjeR/LU/h30+4Hr/QdOSEIqp0ed2aV9nqdUvq0Xrla3oMeeeq8BDFZxI67JzR
         8CSg==
X-Gm-Message-State: AOJu0Ywn/QsVNHTZc8+yYMU3pFi3c8uwvZtAxsoLMrE+41gcqROpPJ55
	YX/AhE6Rr5xDiv/bM+0he2u+fiGJz9szaU6YxdPA4TVT4y5M9aOgkG/NuPnMiihyNOvneJJY4xZ
	1HPoaWuA=
X-Gm-Gg: ASbGncuECkjVTwZYT6mg/ZeyUdA9M7ZmcDq7zMCnzS3ZmP3sleFK5+VWPYcSF2KPRxy
	nY4myB0Seaf2Pig7VjcRzrqIfa7u24RJeUPWJWwWgswAKEhmar9ZBUln9nEXaIVomd83Ekz/rAR
	hvuwGALBITdOqwSWEmzG8EqSWEpfCQgEa385Vv3OnQMaaE6aDk2NScDGUkb/iUWywBEtGTVoVCd
	PfJAFBtSXFp1E6gl2gyqAnMzMX7ZKzKdB9psXFaLqGrnbx7ysKzfQVKYFlGINCT+Q5IDqUaSGe1
	oeVjcTxIugxnVlF84iiQKBftr+lT1T8XBUYljs4zufEvW2mlVNtCqMp5dIExPWXTXmfuFsJ/BAy
	vIgZtoxL55+L/ltDyxVzyxk195aV/VWF7ZBbvecuzrHTiERLv/Q3tY5YreDrREsdbs0aRCpr7Ro
	IcXnGliKhYJaFpF+ZCtXx1Zw3LcMmwOmlruCbl01U9khhgrrtSYw==
X-Google-Smtp-Source: AGHT+IGmCCU4K3fKqm79UVRyEHDFT2dHG+Vf3G2Nhe7meSXhBCvclF4wbY+trvBqhN5vopMPWTCF6Q==
X-Received: by 2002:a05:6402:42c8:b0:63c:13b9:58b0 with SMTP id 4fb4d7f45d1cf-63c1e1f1fb8mr11614422a12.5.1760924285743;
        Sun, 19 Oct 2025 18:38:05 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945efb0sm5290943a12.30.2025.10.19.18.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 18:38:04 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c12ff0c5eso7529147a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:38:03 -0700 (PDT)
X-Received: by 2002:a05:6402:304a:10b0:63c:1ea9:9ebf with SMTP id
 4fb4d7f45d1cf-63c1ea9a0a0mr8715552a12.15.1760924282911; Sun, 19 Oct 2025
 18:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Oct 2025 15:37:46 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjTG+K6gRhkZDVEDaAmKhSKSz=_ZEso2_djy+DB7JgxtQ@mail.gmail.com>
X-Gm-Features: AS18NWC-pKXqQER6kYWM3VlJI_nHsgvLaYeL8NCLjGEI8lH_l_waFO-afr1WiBA
Message-ID: <CAHk-=wjTG+K6gRhkZDVEDaAmKhSKSz=_ZEso2_djy+DB7JgxtQ@mail.gmail.com>
Subject: Linux 6.18-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No huge surprises here. We had a number of regressions in rc1 reported
by Guenter's automated test system, so it's not like this release has
been all smooth sailing, but at least _some_ of them turned out to be
trivial configuration issues, or in the case of big-endian SH4 they
seem to have been "just" bugs in the qemu test environment, not
actually new kernel bugs.

End result: rc2 is on the bigger side, and we still have some of the
remaining regressions outstanding, but we should be making slow
progress. It's fairly early days yet, so I'm not very worried. Things
on the whole look fairly normal.

Please do keep testing,

            Linus

---

Abhishek Tamboli (1):
      HID: intel-thc-hid: intel-quickspi: Add ARL PCI Device Id's

Ackerley Tng (1):
      KVM: selftests: Add test coverage for guest_memfd without
GUEST_MEMFD_FLAG_MMAP

Ada Couprie Diaz (1):
      arm64: debug: always unmask interrupts in el0_softstp()

Adrian Hunter (3):
      perf/core: Fix address filter match with backing files
      perf/core: Fix MMAP event path names with backing files
      perf/core: Fix MMAP2 event device with backing files

Alex Deucher (4):
      drm/amdgpu: fix handling of harvesting for ip_discovery firmware
      drm/amdgpu: handle wrap around in reemit handling
      drm/amdgpu: set an error on all fences from a bad context
      drm/amdgpu: drop unused structures in amdgpu_drm.h

Alexei Starovoitov (1):
      bpf: Replace bpf_map_kmalloc_node() with kmalloc_nolock() to
allocate bpf_async_cb structures.

Alexey Simakov (1):
      tg3: prevent use of uninitialized remote_adv and local_adv variables

Alison Schofield (2):
      cxl/region: Use %pa printk format to emit resource_size_t
      cxl/trace: Subtract to find an hpa_alias0 in cxl_poison events

Alok Tiwari (1):
      drm/rockchip: vop2: use correct destination rectangle height check

Amit Chaudhary (1):
      nvme-multipath: Skip nr_active increments in RETRY disposition

Andrey Albershteyn (2):
      Revert "fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP"
      fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls

Andrii Nakryiko (1):
      selftests/bpf: make arg_parsing.c more robust to crashes

Ankan Biswas (1):
      drm/gpuvm: Fix kernel-doc warning for drm_gpuvm_map_req.map

Babu Moger (1):
      x86/resctrl: Fix miscount of bandwidth event when reactivating
previously unavailable RMID

Baojun Xu (2):
      ASoC: tas2781: Support more newly-released amplifiers tas58xx in
the driver
      ASoC: tas2781: Update ti,tas2781.yaml for adding tas58xx

Bean Huo (1):
      rpmb: move rpmb_frame struct and constants to common header

Benjamin Tissoires (2):
      HID: multitouch: fix sticky fingers
      selftests/hid: add tests for missing release on the Dell Synaptics

Bhanu Seshu Kumar Valluri (1):
      net: usb: lan78xx: Fix lost EEPROM write timeout
error(-ETIMEDOUT) in lan78xx_write_raw_eeprom

Boris Burkov (1):
      btrfs: fix incorrect readahead expansion length

Brahmajit Das (1):
      selftests/bpf: Fix redefinition of 'off' as different kind of symbol

Breno Leitao (1):
      netdevsim: set the carrier when the device goes up

Celeste Liu (2):
      can: gs_usb: increase max interface to U8_MAX
      can: gs_usb: gs_make_candev(): populate net_device->dev_port

Christian Brauner (1):
      coredump: fix core_pattern input validation

Christian K=C3=B6nig (3):
      drm/amdgpu: remove two invalid BUG_ON()s
      drm/amdgpu: block CE CS if not explicitely allowed by module option
      drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

Christophe Leroy (1):
      ASoC: codecs: Fix gain setting ranges for Renesas IDT821034 codec

Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Colin Ian King (1):
      HID: hid-debug: Fix spelling mistake "Rechargable" -> "Rechargeable"

Conor Dooley (1):
      rust: cfi: only 64-bit arm and x86 support CFI_CLANG

Cristian Ciocaltea (5):
      ASoC: nau8821: Cancel jdet_work before handling jack ejection
      ASoC: nau8821: Generalize helper to clear IRQ status
      ASoC: nau8821: Consistently clear interrupts before unmasking
      ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit
      ASoC: nau8821: Avoid unnecessary blocking in IRQ handler

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for Huawei Technologies Co., Ltd. CM-Q3

Damien Le Moal (1):
      ata: libata-core: relax checks in ata_read_log_directory()

Dan Carpenter (3):
      mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
      mfd: ls2kbmc: check for devm_mfd_add_devices() failure
      btrfs: tree-checker: fix bounds check in check_inode_extref()

Danil Skrebenkov (1):
      RISC-V: clear hot-unplugged cores from all task mm_cpumasks to
avoid rfence errors

Dapeng Mi (1):
      KVM: x86/pmu: Don't try to get perf capabilities for hybrid CPUs

Dave Jiang (4):
      cxl/features: Add check for no entries in cxl_feature_info
      cxl/acpi: Fix setup of memory resource in cxl_acpi_set_cache_size()
      cxl: Set range param for region_res_match_cxl_range() as const
      cxl: Fix match_region_by_range() to use region_res_match_cxl_range()

Dawn Gardner (1):
      ALSA: hda/realtek: Fix mute led for HP Omen 17-cb0xxx

Deepak Sharma (1):
      HID: cp2112: Add parameter validation to data length

Deepanshu Kartikey (2):
      nsfs: handle inode number mismatches gracefully in file handles
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination

Denis Arefev (2):
      ALSA: hda: cs35l41: Fix NULL pointer dereference in
cs35l41_get_acpi_mute_state()
      ALSA: hda: Fix missing pointer check in
hda_component_manager_init function

Dmitry Safonov (1):
      net/ip6_tunnel: Prevent perpetual tunnel growth

Dmitry Torokhov (1):
      HID: hid-input: only ignore 0 battery events for digitizers

Eric Biggers (8):
      smb: client: Use SHA-512 library for SMB3.1.1 preauth hash
      smb: client: Use HMAC-SHA256 library for key generation
      smb: client: Use HMAC-SHA256 library for SMB2 signature calculation
      smb: client: Use MD5 library for M-F symlink hashing
      smb: client: Use MD5 library for SMB1 signature calculation
      smb: client: Use HMAC-MD5 library for NTLMv2
      smb: client: Remove obsolete crypto_shash allocations
      smb: client: Consolidate cmac(aes) shash allocation

Eric Dumazet (2):
      tcp: fix tcp_tso_should_defer() vs large RTT
      udp: do not use skb_release_head_state() before skb_attempt_defer_fre=
e()

Eugene Korenevsky (1):
      cifs: parse_dfs_referrals: prevent oob on malformed input

Even Xu (1):
      HID: intel-thc-hid: Intel-quickspi: switch first interrupt from
level to edge detection

Fabian Vogt (1):
      riscv: kprobes: Fix probe address validation

Filipe Manana (2):
      btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation
already running
      btrfs: do not assert we found block group item when creating
free space tree

Florian Schmaus (1):
      riscv: entry: fix typo in comment 'instruciton' -> 'instruction'

Florian Westphal (1):
      net: core: fix lockdep splat on device unregister

Francesco Valla (1):
      drm/draw: fix color truncation in drm_draw_fill24

Frank Li (1):
      ASoC: dt-bindings: Add compatible string fsl,imx-audio-tlv320

Guenter Roeck (1):
      ipmi: Fix handling of messages with provided receive message pointer

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault in=
fo

Gustavo A. R. Silva (1):
      btrfs: send: fix -Wflex-array-member-not-at-end warning in struct sen=
d_ctx

Han Gao (1):
      riscv: acpi: avoid errors caused by probing DT devices when ACPI is u=
sed

Hans Zhang (1):
      PCI: cadence: Search for MSI Capability with correct ID

Hans de Goede (1):
      i2c: usbio: Add ACPI device-id for MTL-CVF devices

Hao Ge (1):
      slab: reset slab->obj_ext when freeing and it is OBJEXTS_ALLOC_FAIL

Harshit Mogalapalli (1):
      Octeontx2-af: Fix missing error code in cgx_probe()

I Viswanath (1):
      net: usb: lan78xx: fix use of improperly initialized dev->chipid
in lan78xx_reset

Ilpo J=C3=A4rvinen (1):
      PCI: Revert early bridge resource set up

Ingo Molnar (1):
      x86/mm: Fix SMP ordering in switch_mm_irqs_off()

Inochi Amaoto (1):
      PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_i=
nfo()

Ivan Vecera (2):
      dpll: zl3073x: Increase maximum size of flash utility
      dpll: zl3073x: Handle missing or corrupted flash configuration

Jaegeuk Kim (1):
      f2fs: fix wrong block mapping for multi-devices

Jaehun Gou (1):
      exfat: fix improper check of dentry.stream.valid_size

Jakub Kicinski (1):
      selftests: drv-net: update remaining Python init files

Jan Kara (2):
      vfs: Don't leak disconnected dentries on umount
      ext4: free orphan info with kvfree

Jedrzej Jagielski (4):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
      ixgbevf: fix mailbox API compatibility by negotiating supported featu=
res
      ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd

Jeff Hugo (1):
      accel/qaic: Fix bootlog initialization ordering

Jens Axboe (2):
      Revert "io_uring/rw: drop -EOPNOTSUPP check in __io_complete_rw_commo=
n()"
      io_uring/rw: check for NULL io_br_sel when putting a buffer

Jeongjun Park (1):
      exfat: fix out-of-bounds in exfat_nls_to_ucs2()

Jesse.Zhang (1):
      drm/amdgpu: Fix NULL pointer dereference in VRAM logic for APU device=
s

Jiaming Zhang (1):
      ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

Jiri Olsa (1):
      uprobe: Move arch_uprobe_optimize right after handlers execution

Jonas Gorski (1):
      MAINTAINERS: add myself as maintainer for b53

Jonathan Denose (1):
      HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC

Jonathan Kim (5):
      drm/amdgpu: fix gfx12 mes packet status return check
      drm/amdgpu: fix initialization of doorbell array for detect and hang
      drm/amdgpu: fix hung reset queue array memory allocation
      drm/amdgpu: enable suspend/resume all for gfx 12
      drm/amdkfd: fix suspend/resume all calls in mes based eviction path

Joshua Watt (2):
      NFS4: Apply delay_retrans to async operations
      NFS4: Fix state renewals missing after boot

Jouni H=C3=B6gander (1):
      drm/i915/psr: Deactivate PSR only on LNL and when selective fetch ena=
bled

Justin Iurman (1):
      MAINTAINERS: new entry for IPv6 IOAM

Kamil Hor=C3=A1k - 2N (1):
      net: phy: bcm54811: Fix GMII/MII/MII-Lite selection

Kenneth Graunke (1):
      drm/xe: Increase global invalidation timeout to 1000us

Ketil Johnsen (1):
      drm/panthor: Ensure MCU is disabled on suspend

Koichiro Den (1):
      ixgbe: fix too early devlink_free() in ixgbe_remove()

Le Qi (2):
      ASoC: dt-bindings: qcom,sm8250: Add QCS615 sound card
      ASoC: qcom: sc8280xp: Add support for QCS615

Li Ming (1):
      cxl/port: Avoid missing port component registers setup

Li Qiang (1):
      ASoC: amd/sdw_utils: avoid NULL deref when devm_kasprintf() fails

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Linus Torvalds (2):
      Remove long-stale ext3 defconfig option
      Linux 6.18-rc2

Lorenzo Bianconi (1):
      net: airoha: Take into account out-of-order tx completions in
airoha_dev_xmit()

Lorenzo Pieralisi (1):
      arm64/sysreg: Fix GIC CDEOI instruction encoding

Lucas De Marchi (1):
      drm/xe: Move rebar to be done earlier

Marc Kleine-Budde (5):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state
transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM
      can: m_can: replace Dong Aisheng's old email address

Marc Zyngier (15):
      KVM: arm64: nv: Don't advance PC when pending an SVE exception
      KVM: arm64: Hide CNTHV_*_EL2 from userspace for nVHE guests
      KVM: arm64: Introduce timer_context_to_vcpu() helper
      KVM: arm64: Replace timer context vcpu pointer with timer_id
      KVM: arm64: Make timer_set_offset() generally accessible
      KVM: arm64: Add timer UAPI workaround to sysreg infrastructure
      KVM: arm64: Move CNT*_CTL_EL0 userspace accessors to generic
infrastructure
      KVM: arm64: Move CNT*_CVAL_EL0 userspace accessors to generic
infrastructure
      KVM: arm64: Move CNT*CT_EL0 userspace accessors to generic infrastruc=
ture
      KVM: arm64: Fix WFxT handling of nested virt
      KVM: arm64: Kill leftovers of ad-hoc timer userspace access
      KVM: arm64: selftests: Make dependencies on VHE-specific
registers explicit
      KVM: arm64: selftests: Add an E2H=3D0-specific configuration to get_r=
eg_list
      KVM: arm64: selftests: Fix misleading comment about virtual timer enc=
oding
      arm64: Revamp HCR_EL2.E2H RES1 detection

Marek Vasut (2):
      drm/bridge: lt9211: Drop check for last nibble of version register
      net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present

Mario Limonciello (AMD) (1):
      PCI/VGA: Select SCREEN_INFO on X86

Marios Makassikis (1):
      ksmbd: fix recursive locking in RPC handle list access

Markus Elfring (3):
      smb: server: Use common error handling code in smb_direct_rdma_xmit()
      smb: client: Return a status code only as a constant in sid_to_id()
      smb: client: Omit one redundant variable assignment in cifs_xattr_set=
()

Martin George (1):
      nvme-auth: update sc_c in host response

Mateusz Guzik (1):
      f2fs: don't call iput() from f2fs_drop_inode()

Matt Roper (1):
      drm/xe/kunit: Fix kerneldoc for parameterized tests

Matthew Auld (2):
      drm/xe/migrate: don't misalign current bytes
      drm/xe/evict: drop bogus assert

Matthew Brost (2):
      drm/xe: Don't allow evicting of BOs in same VM in array of VM binds
      drm/xe: Handle mixed mappings and existing VRAM on atomic faults

Matthew Schwartz (1):
      Revert "drm/amd/display: Only restore backlight after
amdgpu_dm_init or dm_resume"

Miguel Ojeda (5):
      rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning
      docs: rust: add section on imports formatting
      rust: alloc: employ a trailing comment to keep vertical layout
      rust: cpufreq: fix formatting
      rust: bitmap: fix formatting

Mike Snitzer (1):
      NFSv4/flexfiles: fix to allocate mirror->dss before use

Milena Olech (1):
      idpf: cleanup remaining SKBs in PTP flows

Ming Lei (1):
      block: Remove elevator_lock usage from blkg_conf frozen operations

Miquel Sabat=C3=A9 Sol=C3=A0 (3):
      riscv: kgdb: Ensure that BUFMAX > NUMREGBYTES
      btrfs: fix memory leak on duplicated memory in the qgroup assign ioct=
l
      btrfs: fix memory leaks when rejecting a non SINGLE data profile
without an RST

Mukesh Ojha (1):
      KVM: arm64: Guard PMSCR_EL1 initialization with SPE presence check

Nam Cao (2):
      powerpc/pseries/msi: Fix NULL pointer dereference at irq domain teard=
own
      powerpc, ocxl: Fix extraction of struct xive_irq_data

Nicolas Dichtel (1):
      doc: fix seg6_flowlabel path

Nicolas Frattaroli (1):
      PM / devfreq: rockchip-dfi: switch to FIELD_PREP_WM16 macro

Oleg Makarenko (1):
      HID: quirks: Add ALWAYS_POLL quirk for VRS R295 steering wheel

Oliver Upton (9):
      KVM: arm64: nv: Don't treat ZCR_EL2 as a 'mapped' register
      KVM: arm64: Use the in-context stage-1 in __kvm_find_s1_desc_level()
      KVM: arm64: selftests: Test effective value of HCR_EL2.AMO
      KVM: arm64: Prevent access to vCPU events before init
      KVM: arm64: Document vCPU event ioctls as requiring init'ed vCPU
      KVM: selftests: Fix irqfd_test for non-x86 architectures
      KVM: arm64: selftests: Actually enable IRQs in vgic_lpi_stress
      KVM: arm64: Compute per-vCPU FGTs at vcpu_load()
      KVM: arm64: nv: Use FGT write trap of MDSCR_EL1 when available

Osama Abdelkader (1):
      KVM: arm64: Remove unreachable break after return

Paul Walmsley (1):
      riscv: kprobes: convert one final __ASSEMBLY__ to __ASSEMBLER__

Pauli Virtanen (3):
      ALSA: usb-audio: add mixer_playback_min_mute quirk for Logitech H390
      ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
      ALSA: usb-audio: fix vendor quirk for Logitech H390

Pavel Begunkov (2):
      io_uring: protect mem region deregistration
      io_uring: fix unexpected placement on same size resizing

Peter Zijlstra (Intel) (1):
      sched/deadline: Stop dl_server before CPU goes offline

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Synchronize access to DBC request queue head & tail point=
er

Qu Wenruo (2):
      btrfs: only set the device specific options after devices are opened
      btrfs: do not use folio_test_partial_kmap() in ASSERT()s

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Rex Lu (1):
      net: mtk: wed: add dma mask limitation and GFP_DMA32 for device
with more than 4GB DRAM

Rik van Riel (1):
      x86/mm: Fix overflow in __cpa_addr()

Rob Herring (Arm) (1):
      dt-bindings: i2c: Convert apm,xgene-slimpro-i2c to DT schema

Rong Zhang (1):
      x86/CPU/AMD: Prevent reset reasons from being retained across reboot

Sabrina Dubroca (7):
      tls: trim encrypted message to match the plaintext on short splice
      tls: wait for async encrypt in case of error during latter
iterations of sendmsg
      tls: always set record_type in tls_process_cmsg
      tls: wait for pending async decryptions if tls_strp_msg_hold fails
      tls: don't rely on tx_work during send()
      selftests: net: tls: add tests for cmsg vs MSG_MORE
      selftests: tls: add test for short splice due to full skmsg

Sahil Chandna (1):
      bpf: Do not disable preemption in bpf_test_run().

Sakari Ailus (1):
      i2c: Remove redundant pm_runtime_mark_last_busy() calls

Sascha Bischoff (2):
      KVM: arm64: gic-v3: Only set ICH_HCR traps for v2-on-v3 or v3 guests
      Documentation: KVM: Update GICv3 docs for GICv5 hosts

Sathishkumar S (1):
      drm/amdgpu: fix bit shift logic

Scott Mayhew (1):
      NFS: check if suid/sgid was cleared after a write as needed

Sean Christopherson (13):
      KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS
      KVM: guest_memfd: Add INIT_SHARED flag, reject user page faults if no=
t set
      KVM: guest_memfd: Invalidate SHARED GPAs if gmem supports INIT_SHARED
      KVM: Explicitly mark KVM_GUEST_MEMFD as depending on
KVM_GENERIC_MMU_NOTIFIER
      KVM: guest_memfd: Allow mmap() on guest_memfd for x86 VMs with
private memory
      KVM: selftests: Stash the host page size in a global in the
guest_memfd test
      KVM: selftests: Create a new guest_memfd for each testcase
      KVM: selftests: Add wrappers for mmap() and munmap() to assert succes=
s
      KVM: selftests: Isolate the guest_memfd Copy-on-Write negative testca=
se
      KVM: selftests: Add wrapper macro to handle and assert on expected SI=
GBUS
      KVM: selftests: Verify that faulting in private guest_memfd memory fa=
ils
      KVM: selftests: Verify that reads to inaccessible guest_memfd VMAs SI=
GBUS
      KVM: arm64: selftests: Track width of timer counter as "int",
not "uint64_t"

Sebastian Andrzej Siewior (1):
      net: gro_cells: Use nested-BH locking for gro_cell

Seong-Gwang Heo (1):
      ovl: remove redundant IOCB_DIO_CALLER_COMP clearing

Shardul Bankar (2):
      bpf: test_run: Fix ctx leak in bpf_prog_test_run_xdp error path
      bpf: Fix memory leak in __lookup_instance error path

Sharique Mohammad (1):
      ASoC: max98090/91: fixed max98091 ALSA widget powering up/down

Shenghao Ding (1):
      ALSA: hda/tas2781: Set tas2781_hda::tasdevice_priv::chip_id as
TAS5825 in case of tas5825

Shuhao Fu (1):
      smb: client: Fix refcount leak for cifs_sb_tlink

Shuicheng Lin (1):
      drm/xe/guc: Check GuC running state before deregistering exec queue

Shuming Fan (1):
      ASoC: sdw_utils: add rt1321 part id to codec_info_list

Sourabh Jain (1):
      powerpc/fadump: skip parameter area allocation when fadump is disable=
d

Srinivas Kandagatla (1):
      ASoC: codecs: wcd938x-sdw: remove redundant runtime pm calls

Stefan Metzmacher (11):
      smb: smbdirect: introduce smbdirect_mr_io.{kref,mutex} and
SMBDIRECT_MR_DISABLED
      smb: client: change smbd_deregister_mr() to return void
      smb: client: let destroy_mr_list() call list_del(&mr->list)
      smb: client: let destroy_mr_list() remove locked from the list
      smb: client: improve logic in allocate_mr_list()
      smb: client: improve logic in smbd_register_mr()
      smb: client: improve logic in smbd_deregister_mr()
      smb: client: call ib_dma_unmap_sg if mr->sgt.nents is not 0
      smb: client: let destroy_mr_list() call ib_dereg_mr() before
ib_dma_unmap_sg()
      smb: client: let destroy_mr_list() keep smbdirect_mr_io memory
if registered
      smb: client: let smbd_destroy() wait for SMBDIRECT_SOCKET_DISCONNECTE=
D

Stuart Hayhurst (2):
      ALSA: hda/intel: Add MSI X870E Tomahawk to denylist
      HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL

Stuart Yoder (1):
      tpm_crb: Add idle support for the Arm FF-A start method

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk entry for HP ZBook 17 G6

Tetsuo Handa (1):
      can: j1939: add missing calls in NETDEV_UNREGISTER notification handl=
er

Thadeu Lima de Souza Cascardo (1):
      HID: multitouch: fix name of Stylus input devices

Theodore Ts'o (1):
      Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of the defconfigs

Thomas Hellstr=C3=B6m (2):
      drm/xe/migrate: Fix an error path
      drm/xe/svm: Ensure data will be migrated to system if indicated
by madvise.

Thomas Wei=C3=9Fschuh (1):
      riscv: Respect dependencies of ARCH_HAS_ELF_CORE_EFLAGS

Thomas Zimmermann (1):
      drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync of=
f

Tim Hostetler (1):
      gve: Check valid ts bit on RX descriptor before hw timestamping

Timur Krist=C3=B3f (3):
      drm/amd/pm: Disable MCLK switching on SI at high pixel clocks
      drm/amd: Disable ASPM on SI
      drm/amd/powerplay: Fix CIK shutdown temperature

Tong Li (1):
      rust: file: add intra-doc link for 'EBADF'

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Tvrtko Ursulin (1):
      drm/sched: Fix potential double free in
drm_sched_job_add_resv_dependencies

Vicki Pfau (3):
      HID: core: Add printk_ratelimited variants to hid_warn() etc
      HID: nintendo: Wait longer for initial probe
      HID: nintendo: Rate limit IMU compensation message

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/frontbuffer: Move bo refcounting
intel_frontbuffer_{get,release}()
      drm/i915/fb: Fix the set_tiling vs. addfb race, again

Vinay Belgaumkar (1):
      drm/xe: Enable media sampler power gating

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

Vincent Mailhol (2):
      can: remove false statement about 1:1 mapping between DLC and length
      can: add Transmitter Delay Compensation (TDC) documentation

Vlastimil Babka (1):
      slab: fix clearing freelist in free_deferred_objects()

Wang Liang (1):
      selftests: net: check jq command is supported

Wilfred Mallawa (1):
      nvme/tcp: handle tls partially sent records in write_space()

Xing Guo (1):
      selftests: arg_parsing: Ensure data is flushed to disk before reading=
.

Xinpeng Sun (1):
      HID: intel-thc-hid: intel-quicki2c: Fix wrong type casting

Yan Zhao (1):
      KVM: selftests: Test prefault memory during concurrent memslot remova=
l

Yeounsu Moon (1):
      net: dlink: handle dma_map_single() failure properly

Yi Cong (1):
      r8152: add error handling in rtl8152_driver_init

Youssef Samir (1):
      accel/qaic: Treat remaining =3D=3D 0 as error in find_and_map_user_pa=
ges()

Yu Kuai (1):
      blk-mq: fix stale tag depth for shared sched tags in
blk_mq_update_nr_requests()

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Zenghui Yu (2):
      KVM: arm64: selftests: Sync ID_AA64PFR1, MPIDR, CLIDR in guest
      KVM: arm64: selftests: Allocate vcpus with correct size

Zeno Endemann (1):
      ext4, doc: fix and improve directory hash tree description

Zhang Yi (2):
      jbd2: ensure that all ongoing I/O complete before freeing blocks
      ext4: wait for ongoing I/O to complete before freeing blocks

ZhangGuoDong (3):
      smb/server: fix possible memory leak in smb2_read()
      smb/server: fix possible refcount leak in smb2_sess_setup()
      smb: move some duplicate definitions to common/cifsglob.h

Zhanjun Dong (1):
      drm/i915/guc: Skip communication warning on reset in progress

Zhou Yuhang (1):
      fs: update comment in init_file()

Zqiang (1):
      usbnet: Fix using smp_processor_id() in preemptible code warnings

