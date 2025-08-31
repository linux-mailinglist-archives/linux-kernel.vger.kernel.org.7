Return-Path: <linux-kernel+bounces-793591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37497B3D5AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ABB1898DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2775247298;
	Sun, 31 Aug 2025 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+TOXgci"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC01C3F0C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756681102; cv=none; b=F4KwsgZy5nFBYQOD+7u0+GC0cbNTBAoAUz3RWvHcJabipJXpalKE/7Ztc518zDaIV6vqdv5U3J98BxGaQ6s8ueFeBHd5Jav8QwLQ4Hl316T5Hc2jRL/Lf6ChZgZvLW0fAxNWxc75SnI4+9qvgstwLmhwneCaN/17nV2JTo/RADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756681102; c=relaxed/simple;
	bh=2CCJPgHWEfeB3XEI8F9pNF4NtjSz2+5fTX2+MwvETfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SsgGrjbiyrb0nOYouBvX1pr4c/AW33TgDIznhouPw/uJuVze/3ezGmUi0jIA7mIZ9djOy7Mz+8pjYgNLwvKR7Fh6DmA+FP0JMvroG/WiyH/lF3WNt5f/428sX1g+rpbt/4zl2VgGT4njhkQ+kjg9otWQsqCpY8Bqwn4/p6K4qEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+TOXgci; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb732eee6so652721166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756681096; x=1757285896; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SQD16mJMU98BFnCkvbHmsHGR+MKAJdjquCRRaZ/szw=;
        b=c+TOXgcia/z01hGgrLiufRnz2UB6x5yjbEp1MXP4nhLPGFZVihSy1NqFzWwlXJuSuX
         WQDE0zxpbJ8x+t/SfjoGIU8bg/cTlpNPPCNlDAXa5IbiBk3GuJ0zFtz6rxGus6Zd81mq
         OzvGsRFiwmlGvFft4w8vHiECG2APqiyZeg7Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756681096; x=1757285896;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SQD16mJMU98BFnCkvbHmsHGR+MKAJdjquCRRaZ/szw=;
        b=VFzG+P6sBQNbbJG5BwdNuXnHe5kcQlNvQvgqhdn+OdfzssoDLhwoARwklgTq8Zl0dC
         0kog8WhKNoFnPig8qTRJG19VLA23f6vQUDKmJl40yXS+EuawByy8hGr+60RyohzpgC8r
         ARm9XeZbkWpMmQLn09rYtv7RnB5idTJHOlrMb69tP/Ffs5DGKB5CetADpbB3XkOVSkqS
         isHPpuM6M3XjEnOAuxWCRW+W84s51cTeijFyuH5IUbaz7kjE6MqPZP+bZuBAGVKLOdgM
         5spXI+K7xTWvQ3O+A+U6r2qXc+VSefomS4yXPC4gYa1fUhZDzlk7w8flcgyyal1UhudM
         AqrA==
X-Gm-Message-State: AOJu0Yy/l15QQjv4yaVVNLb19qj0d+AkB8jD24vKxYYom6qDLozXbHLh
	O4+mlBKhStAG/fD3ej0wssisebTlKGGj4NJvn+fflk6llqh00/0S02jZ9QwK0YnT5Z53nGW13Rg
	RQdkZPA0=
X-Gm-Gg: ASbGnctueUn6Ye4smSm8TfgTmdsdiLkFJ5Hn2BCwCOB5Zx3OWbsnRaOdulUc5H4V1/N
	kRYS/dRupUVXDL7re/K5VUEyQ+7kSH1Vu+KcJiVPYf9Skltxrp9xoQxzaVqtqCduVUCKdjgUizm
	MSMiQcrh507n8uPPqJTUtg4t2ViI497O705CIGVT27VjshwfzDXW68/I5i8opuRC/M0SOJNu+b9
	o0RL3p2qMBUveibQjBF+ahIaGjM48JnHp61Ecxv8GThoiPyKnx6zEV8T2sd9FqhTcLU3ejIWK62
	AD0zG/Z50cNvpa/kQDHBx/bILGt14wlyeGSrb++I/cZ1Ky2Hkim6YR9qcwuVjGQmm07oQYQWMlM
	3EAbDJlKhCgKABUD/GNsDbJ2uulTyHQUirxTz5dbF2EY2zQy9ci0WA2tIu1l27ylVIJqnsAVh
X-Google-Smtp-Source: AGHT+IE2PF6Vt5hKWKhNPsQPHGyIcjzlnQE+MM+cKNQstBkh/EhCiECK7lp3AHj9zaRf1CbnLGn23Q==
X-Received: by 2002:a17:907:3f94:b0:afe:7cb6:60f0 with SMTP id a640c23a62f3a-b01d8c86d85mr515070966b.29.1756681095893;
        Sun, 31 Aug 2025 15:58:15 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042b0046ecsm112800566b.71.2025.08.31.15.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 15:58:15 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61e8fe26614so1014867a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 15:58:14 -0700 (PDT)
X-Received: by 2002:a05:6402:d0e:b0:61c:8114:8832 with SMTP id
 4fb4d7f45d1cf-61d2699b037mr5175579a12.16.1756681094164; Sun, 31 Aug 2025
 15:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 31 Aug 2025 15:57:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHNCj4Xw5xWoKhgP0BAOe0msFRVXKSQku9Qgxhc0eHbQ@mail.gmail.com>
X-Gm-Features: Ac12FXxgLxvKNgdbc3X2ac5Q6ZsZ1WXGcsUF1yInLYisJ-zar0weucl8jsc0CZ8
Message-ID: <CAHk-=whHNCj4Xw5xWoKhgP0BAOe0msFRVXKSQku9Qgxhc0eHbQ@mail.gmail.com>
Subject: Linux 6.17-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Let's get the version number right in the subject line this time ;^]

It's been another week, and I'm finally over all my August travels,
and have actually caught up with all the emails and other stuff that I
let slide during this month. It didn't affect pull requests much,
because I made sure to prioritize those even during travels, but other
email responses may have suffered a bit.

But everything _should_ now be back to normal, and I can't blame
travel for any mistakes or missed emails any more.

Anyway, last week felt pretty normal, and rc4 stats bear that out,
both in commit numbers and in the diffstat. Nothing strange jumps out
at you: there's one slightly larger driver fix series (Intel idpf
network driver: "infrastructure data path function driver"), and some
arm64 kvm system register handling updates that are slightly bigger,
but honestly neither of those are exactly huge - and the rest of rc4
really is just one-liners and few-lines.

So it all looks fairly good.

Please do keep testing, and we'll get 6.17 out in a timely manner and
in good shape.

Knock wood.

           Linus

---

Aaron Ma (2):
      HID: intel-thc-hid: intel-quicki2c: Fix ACPI dsd ICRS/ISUB length
      HID: intel-thc-hid: intel-thc: Fix incorrect pointer arithmetic
in I2C regs save

Adrian Ng Ho Yin (1):
      MAINTAINERS: Change Altera-PIO driver maintainer

Alex Deucher (4):
      drm/amdgpu/gfx11: set MQD as appriopriate for queue types
      drm/amdgpu/gfx12: set MQD as appriopriate for queue types
      Revert "drm/amdgpu: fix incorrect vm flags to map bo"
      drm/amdgpu/userq: fix error handling of invalid doorbell

Alexander Duyck (2):
      fbnic: Fixup rtnl_lock and devl_lock handling related to mailbox code
      fbnic: Move phylink resume out of service_task and into open/close

Alexei Lazar (3):
      net/mlx5e: Update and set Xon/Xoff upon MTU set
      net/mlx5e: Update and set Xon/Xoff upon port speed set
      net/mlx5e: Set local Xoff after FW update

Alexey Gladkov (1):
      pinctrl: meson: Fix typo in device table macro

Alice Ryhl (1):
      drm/gpuvm: fix various typos in .c and .h gpuvm file

Andrew Donnellan (1):
      KVM: PPC: Fix misleading interrupts comment in kvmppc_prepare_to_ente=
r()

Antheas Kapenekakis (1):
      HID: quirks: add support for Legion Go dual dinput modes

Antonino Maniscalco (1):
      drm/msm: skip re-emitting IBs for unusable VMs

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Arnd Bergmann (2):
      kvm: arm64: use BUG() instead of BUG_ON(1)
      ARM: stacktrace: include asm/sections.h in asm/stacktrace.h

Ayushi Makhija (1):
      drm/msm: update the high bitfield of certain DSI registers

Bagas Sanjaya (2):
      of: Clarify OF device context in of_match_device() comment
      drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected usage in
literal code block

Bart Van Assche (1):
      blk-zoned: Fix a lockdep complaint about recursive locking

Boon Khai Ng (1):
      MAINTAINERS: Update maintainer information for Altera Triple
Speed Ethernet Driver

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Handle the case of no BIOS microcode

Carlos Llamas (1):
      drm/xe: switch to local xbasename() helper

Chenyuan Yang (1):
      drm/msm/dpu: Add a null ptr check for dpu_encoder_needs_modeset

Christoph Hellwig (3):
      xfs: remove xfs_last_used_zone
      xfs: kick off inodegc when failing to reserve zoned blocks
      xfs: reject swapon for inodes on a zoned file system earlier

Christophe JAILLET (1):
      media: rkvdec: Fix an error handling path in rkvdec_probe()

Colin Ian King (2):
      drm/msm: Fix dereference of pointer minor before null check
      HID: Kconfig: Fix spelling mistake "enthropy" -> "entropy"

Coly Li (1):
      bcache: change maintainer's email address

Damien Le Moal (2):
      xfs: Default XFS_RT to Y if CONFIG_BLK_DEV_ZONED is enabled
      ata: ahci: Allow ignoring the external/hotplug capability of ports

Dan Carpenter (3):
      media: rkvdec: Fix a NULL vs IS_ERR() bug in probe()
      of: dynamic: Fix use after free in of_changeset_add_prop_helper()
      irqchip/mvebu-gicp: Fix an IS_ERR() vs NULL check in probe()

David Kaplan (1):
      x86/bugs: Add attack vector controls for SSB

Dipayaan Roy (1):
      net: hv_netvsc: fix loss of early receive events from host
during channel open.

Dmitry Baryshkov (8):
      drm/msm/kms: move snapshot init earlier in KMS init
      drm/msm/dpu: correct dpu_plane_virtual_atomic_check()
      soc: qcom: ubwc: provide no-UBWC configuration
      dt-bindings: display/msm: qcom,mdp5: drop lut clock
      soc: qcom: ubwc: use no-uwbc config for MSM8917
      soc: qcom: ubwc: add more missing platforms
      soc: qcom: add configuration for MSM8929
      soc: qcom: use no-UBWC config for MSM8956/76

Dongcheng Yan (1):
      platform/x86: int3472: add hpd pin support

Edgar Bonet (1):
      irqchip/atmel-aic[5]: Fix incorrect lock guard conversion

Emil Tantilov (1):
      ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset

Eric Dumazet (3):
      sctp: initialize more fields in sctp_v6_from_sk()
      l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
      net: rose: fix a typo in rose_clear_routes()

Eric Sandeen (1):
      xfs: do not propagate ENODATA disk errors into xattr code

Even Xu (1):
      HID: intel-thc-hid: Intel-quicki2c: Enhance driver re-install flow

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Fangyu Yu (1):
      RISC-V: KVM: Fix pte settings within kvm_riscv_gstage_ioremap()

Fuad Tabba (3):
      KVM: arm64: Handle AIDR_EL1 and REVIDR_EL1 in host for protected VMs
      KVM: arm64: Sync protected guest VBAR_EL1 on injecting an undef excep=
tion
      arm64: vgic-v2: Fix guest endianness check in hVHE mode

Hariprasad Kelam (2):
      Octeontx2-vf: Fix max packet length errors
      Octeontx2-af: Fix NIX X2P calibration failures

Horatiu Vultur (1):
      phy: mscc: Fix when PTP clock is register and unregister

Huacai Chen (1):
      sched/deadline: Fix dl_server_stopped()

Ian Rogers (2):
      perf symbol-minimal: Fix ehdr reading in filename__read_build_id
      perf symbol: Add blocking argument to filename__read_build_id

Igor Torrente (1):
      Revert "virtio: reject shm region if length is zero"

Jacob Keller (2):
      ice: don't leave device non-functional if Tx scheduler config fails
      ice: use fixed adapter index for E825C embedded devices

Jakub Kicinski (1):
      MAINTAINERS: retire Boris from TLS maintainers

James Jones (1):
      drm/nouveau/disp: Always accept linear modifier

Jan Kiszka (4):
      efi: stmm: Fix incorrect buffer allocation method
      efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
      efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
      efi: stmm: Drop unneeded null pointer check

Jason-JH Lin (1):
      drm/mediatek: Add error handling for old state CRTC in atomic_disable

Jedrzej Jagielski (1):
      ixgbe: fix ixgbe_orom_civd_info struct layout

Jens Axboe (1):
      io_uring/kbuf: always use READ_ONCE() to read ring provided buffer le=
ngths

Jesse.Zhang (1):
      drm/amdgpu: update firmware version checks for user queue support

Jiri Slaby (SUSE) (1):
      powerpc: Use dev_fwnode()

Johannes Berg (1):
      PM: sleep: annotate RCU list iterations

Joshua Hay (6):
      idpf: add support for Tx refillqs in flow scheduling mode
      idpf: improve when to set RE bit logic
      idpf: simplify and fix splitq Tx packet rollback error path
      idpf: replace flow scheduling buffer ring with buffer pool
      idpf: stop Tx if there are insufficient buffer resources
      idpf: remove obsolete stashing code

Jos=C3=A9 Exp=C3=B3sito (2):
      HID: input: rename hidinput_set_battery_charge_status()
      HID: input: report battery status changes immediately

Junhui Pei (1):
      ubsan: Fix incorrect hand-side used in handle

Junjie Cao (1):
      gpio: timberdale: fix off-by-one in IRQ type boundary check

Junnan Wu (1):
      virtio_net: adjust the execution order of function
`virtnet_close` during freeze

Juri Lelli (1):
      sched/deadline: Always stop dl-server before changing parameters

K Prateek Nayak (1):
      x86/cpu/topology: Use initial APIC ID from XTOPOLOGY leaf on AMD/HYGO=
N

Kamal Wadhwa (1):
      regulator: pm8008: fix probe failure due to negative voltage selector

Kees Cook (1):
      arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function signatur=
e

Kuniyuki Iwashima (1):
      atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Lama Kayal (4):
      net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
      net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error=
 flow
      net/mlx5: HWS, Fix uninitialized variables in
mlx5hws_pat_calc_nop error flow
      net/mlx5: HWS, Fix pattern destruction in
mlx5hws_pat_get_pattern error path

Li Nan (1):
      efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

Liming Wu (1):
      virtio_pci: Fix misleading comment for queue vector

Linus Torvalds (2):
      MAINTAINERS: mark bcachefs externally maintained
      Linux 6.17-rc4

Lizhi Hou (1):
      of: dynamic: Fix memleak when of_pci_add_properties() failed

Loic Poulain (1):
      drm/msm/dsi: Fix 14nm DSI PHY PLL Lock issue

Lorenzo Bianconi (1):
      pinctrl: airoha: Fix return value in pinconf callbacks

Lorenzo Pieralisi (2):
      irqchip/gic-v5: Fix kmemleak L2 IST table entries false positives
      irqchip/gic-v5: Remove undue WARN_ON()s in the IRS affinity parsing

Louis-Alexis Eyraud (2):
      drm/mediatek: dsi: Fix DSI host and panel bridge pre-enable order
      drm/mediatek: mtk_hdmi: Fix inverted parameters in some
regmap_update_bits calls

Luca Weiss (1):
      soc: qcom: ubwc: Add missing UBWC config for SM7225

Ludovico de Nittis (2):
      Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
      Bluetooth: hci_event: Mark connection as closed during suspend discon=
nect

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Make unacked packet handling more robust
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Ma Ke (1):
      drm/mediatek: Fix device/node reference count leaks in
mtk_drm_get_all_drm_priv

Madhavan Srinivasan (3):
      powerpc/kvm: Fix ifdef to remove build warning
      powerpc/prom_init: Fix shellcheck warnings
      powerpc/boot/install.sh: Fix shellcheck warnings

Marc Zyngier (14):
      KVM: arm64: nv: Properly check ESR_EL2.VNCR on taking a VNCR_EL2
related fault
      KVM: arm64: selftest: Add standalone test checking for KVM's own UUID
      KVM: arm64: Correctly populate FAR_EL2 on nested SEA injection
      arm64: Add capability denoting FEAT_RASv1p1
      KVM: arm64: Handle RASv1p1 registers
      KVM: arm64: Ignore HCR_EL2.FIEN set by L1 guest's EL2
      KVM: arm64: Make ID_AA64PFR0_EL1.RAS writable
      KVM: arm64: Make ID_AA64PFR1_EL1.RAS_frac writable
      KVM: arm64: Get rid of ARM64_FEATURE_MASK()
      KVM: arm64: Check for SYSREGS_ON_CPU before accessing the 32bit state
      KVM: arm64: Simplify sysreg access on exception delivery
      KVM: arm64: Fix vcpu_{read,write}_sys_reg() accessors
      KVM: arm64: Remove __vcpu_{read,write}_sys_reg_{from,to}_cpu()
      KVM: arm64: nv: Fix ATS12 handling of single-stage translation

Mario Limonciello (AMD) (1):
      gpiolib: acpi: Add quirk for ASUS ProArt PX13

Mark Brown (2):
      KVM: arm64: selftests: Sync ID_AA64MMFR3_EL1 in set_id_regs
      kselftest/arm64: Don't open code SVE_PT_SIZE() in fp-ptrace

Martin Hilgendorf (1):
      HID: elecom: add support for ELECOM M-DT2DRBK

Masahiro Yamada (2):
      powerpc: use always-y instead of extra-y in Makefiles
      powerpc: unify two CONFIG_POWERPC64_CPU entries in the same choice bl=
ock

Matt Coffin (1):
      HID: logitech: Add ids for G PRO 2 LIGHTSPEED

Matthew Brost (1):
      drm/xe: Don't trigger rebind on initial dma-buf validation

Ma=C3=ADra Canal (1):
      drm/msm: Update global fault counter when faulty process has already =
ended

Michael Chan (2):
      bnxt_en: Adjust TX rings if reservation is less than requested
      bnxt_en: Fix stats context reservation logic

Michal Kubiak (1):
      ice: fix incorrect counter for buffer allocation failures

Mike Rapoport (Microsoft) (1):
      memblock: fix kernel-doc for MEMBLOCK_RSRV_NOINIT

Mina Almasry (1):
      page_pool: fix incorrect mp_ops error handling

Ming Lei (2):
      ublk: avoid ublk_io_release() called after ublk char dev is closed
      ublk selftests: add --no_ublk_fixed_fd for not using registered
ublk char device

Minjong Kim (1):
      HID: hid-ntrig: fix unable to handle page fault in ntrig_report_versi=
on()

Moshe Shemesh (4):
      net/mlx5: Reload auxiliary drivers on fw_activate
      net/mlx5: Fix lockdep assertion on sync reset unload event
      net/mlx5: Nack sync reset when SFs are present
      net/mlx5: Prevent flow steering mode changes in switchdev mode

Namhyung Kim (13):
      perf test: Fix a build error in x86 topdown test
      tools headers: Sync KVM headers with the kernel source
      tools headers: Sync linux/bits.h with the kernel source
      tools headers: Sync linux/cfi_types.h with the kernel source
      tools headers: Sync x86 headers with the kernel source
      tools headers: Sync arm64 headers with the kernel source
      tools headers: Sync powerpc headers with the kernel source
      tools headers: Sync syscall tables with the kernel source
      tools headers: Sync uapi/linux/fcntl.h with the kernel source
      tools headers: Sync uapi/linux/fs.h with the kernel source
      tools headers: Sync uapi/linux/prctl.h with the kernel source
      tools headers: Sync uapi/linux/vhost.h with the kernel source
      vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER

Nathan Chancellor (2):
      drm/msm/dpu: Initialize crtc_state to NULL in
dpu_plane_virtual_atomic_check()
      hardening: Require clang 20.1.0 for __counted_by

Neil Mandir (1):
      net: macb: Disable clocks once

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Nilay Shroff (1):
      block: validate QoS before calling __rq_qos_done_bio()

Oliver Upton (1):
      KVM: arm64: nv: Handle SEAs due to VNCR redirection

Oreoluwa Babatunde (1):
      of: reserved_mem: Restructure call site for dma_contiguous_early_fixu=
p()

Oscar Maes (1):
      net: ipv4: fix regression in local-broadcast routes

Pavel Shpakovskiy (1):
      Bluetooth: hci_sync: fix set_local_name race condition

Ping Cheng (1):
      HID: wacom: Add a new Art Pen 2

Pratyush Brahma (2):
      mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
      mm: numa,memblock: Use SZ_1M macro to denote bytes to MB conversion

Pritesh Patel (1):
      dt-bindings: vendor-prefixes: add eswin

Qasim Ijaz (2):
      HID: multitouch: fix slab out-of-bounds access in mt_report_fixup()
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation

Qianfeng Rong (1):
      ata: ahci_xgene: Use int type for 'rc' to store error codes

Qingyue Zhang (1):
      io_uring/kbuf: fix signedness in this_len calculation

Quan Zhou (1):
      RISC-V: KVM: Correct kvm_riscv_check_vcpu_requests() comment

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      RISC-V: KVM: fix stack overrun when loading vlenb

Raghavendra Rao Ananta (3):
      KVM: arm64: Don't attempt vLPI mappings when vPE allocation is disabl=
ed
      KVM: arm64: Split kvm_pgtable_stage2_destroy()
      KVM: arm64: Reschedule as needed when destroying the stage-2 page-tab=
les

Randy Dunlap (1):
      pinctrl: STMFX: add missing HAS_IOMEM dependency

Rob Clark (15):
      drm/msm: Fix build with KMS disabled
      drm/msm: Fix pagetables setup/teardown serialization
      drm/msm: Fix refcnt underflow in error path
      drm/msm: Fix submit error path cleanup
      drm/msm: Defer fd_install in SUBMIT ioctl
      drm/msm: Defer fd_install in VM_BIND ioctl
      drm/msm: Add missing "location"s to devcoredump
      drm/msm: Fix section names and sizes
      drm/msm: Fix order of selector programming in cluster snapshot
      drm/msm: Constify snapshot tables
      drm/msm: Fix a7xx debugbus read
      drm/msm: Fix debugbus snapshot
      drm/msm: Fix a7xx TPL1 cluster snapshot
      drm/msm: Fix a few comments
      drm/msm: Handle in-place remaps

Rob Herring (Arm) (1):
      of: reserved_mem: Add missing IORESOURCE_MEM flag on resources

Rohan G Thomas (3):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts
      net: stmmac: xgmac: Correct supported speed modes
      net: stmmac: Set CIC bit only for TX queues with COE

Sakari Ailus (2):
      media: rkvdec: Remove redundant pm_runtime_mark_last_busy() calls
      media: Remove redundant pm_runtime_mark_last_busy() calls

Sasha Levin (1):
      drm/msm: Fix objtool warning in submit_lock_objects()

Sean Anderson (1):
      net: macb: Fix offset error in gem_update_stats

Sean Christopherson (1):
      selftests: harness: Rename is_signed_type() to avoid collision
with overflow.h

Shanker Donthineni (1):
      dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted

Shuhao Fu (1):
      fs/smb: Fix inconsistent refcnt update

Sreekanth Reddy (1):
      bnxt_en: Fix memory corruption when FW resources change during ifdown

Steve French (1):
      smb3 client: fix return code mapping of remap_file_range

Subash Abhinov Kasiviswanathan (1):
      MAINTAINERS: rmnet: Update email addresses

Suchit Karunakaran (1):
      x86/cpu/intel: Fix the constant_tsc model check for Pentium 4

Takamitsu Iwai (3):
      net: rose: split remove and free operations in rose_remove_neigh()
      net: rose: convert 'use' field to refcount_t
      net: rose: include node references in rose_neigh refcount

Thijs Raymakers (1):
      KVM: x86: use array_index_nospec with indices that come from guest

Thomas Hellstr=C3=B6m (2):
      drm/xe/vm: Don't pin the vm_resv during validation
      drm/xe/vm: Clear the scratch_pt pointer on error

Thomas Wei=C3=9Fschuh (1):
      drm/msm: Don't use %pK through printk

Thomas Zimmermann (2):
      drm/amdgpu: Pin buffers while vmap'ing exported dma-buf objects
      Revert "drm/tegra: Use dma_buf from GEM object instance"

Timur Tabi (3):
      drm/nouveau: fix error path in nvkm_gsp_fwsec_v2
      drm/nouveau: remove unused increment in gm200_flcn_pio_imem_wr
      drm/nouveau: remove unused memory target test

Vladimir Riabchun (1):
      mISDN: hfcpci: Fix warning when deleting uninitialized timer

Will Deacon (2):
      net: Introduce skb_copy_datagram_from_iter_full()
      vsock/virtio: Fix message iterator handling on transmit path

Xichao Zhao (1):
      powerpc/64: Drop unnecessary 'rc' variable

Yang Li (1):
      Bluetooth: hci_event: Disconnect device when BIG sync is lost

Yang Wang (1):
      drm/amd/amdgpu: disable hwmon power1_cap* for gfx 11.0.3 on vf mode

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly

Yicong Yang (1):
      sched/deadline: Don't count nr_running for dl_server proxy tasks

Ying Gao (1):
      virtio_input: Improve freeze handling

Yu Kuai (1):
      loop: fix zero sized loop for block special file

Yury Norov (1):
      KVM: SEV: don't check have_run_cpus in sev_writeback_caches()

Zbigniew Kempczy=C5=84ski (1):
      drm/xe/xe_sync: avoid race during ufence signaling

Zhang Lixu (1):
      HID: intel-ish-hid: Increase ISHTP resume ack timeout to 300ms

kuyo chang (1):
      sched/deadline: Fix RT task potential starvation when expiry time pas=
sed

luoguangfei (1):
      net: macb: fix unregister_netdev call order in macb_remove()

