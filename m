Return-Path: <linux-kernel+bounces-729201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E81B0331E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 23:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7CB7AAC68
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1DE1F3FF8;
	Sun, 13 Jul 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W80PqNOi"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F88635C
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442915; cv=none; b=eFkXHlKHPJJxyKqLjAonM6/YbmXwU1rTNh86z5PosFuSEc7WWLUUtvXNdBZ8SY1vewlNc7G+Kr5E0SsMrmi5eP04CWrgvikrNubbI2nJyC222Ts1uLFvxwdmMf4ShNrv2ztwmvnsbHpx/Lu7Z7d859hA4uC5421FppfexhT03R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442915; c=relaxed/simple;
	bh=M84devh4VzN3KWQZifoiMVxUdkLH2cFZE3zkh8oztY0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hzdiYILsI23nWZ52XMHS+D3Qp2bIWPr4rnT/TXrp/GtKTvitOHmISKvJsc5p90GB9V+IbyxYGs7KL0EVhG1aMRbudquclbz8qevg3VIIacpZvPb9Hv4FGr4TOPw8K7lfGyDqhX0jKK2B9n/yb4NqblkL0FMZEGSVoFbtvugwAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W80PqNOi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so5673506a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752442910; x=1753047710; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jhQiVvPDHzHn8YILCDQ4b5fxwaaoVWmsvpP6HLQt1Gk=;
        b=W80PqNOiC4KRoMRJw1QXQBJ/Q40tIDP6MMEtGkFT/OSUbdSaXYG+Z6R3VwrhJ7Z2ge
         qAtoF3DFu/3210rrEvrrA3yABrYZMfm/tahYWCDACjoa8icFJmMJzu1lkDAx8G3LaslY
         glyiSYqdr2E3XyCx7uZiTIg1esZtURGP7UHtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752442910; x=1753047710;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhQiVvPDHzHn8YILCDQ4b5fxwaaoVWmsvpP6HLQt1Gk=;
        b=Bh8E+/wOQOqV2c3mNKyXZ+xg8/b74nG4seJEHWGQApl9H6zLYk6yh8Qk/EsqJ232DP
         sdAlvLgPwL4XChsfH+cg7Vy9/m3icoDZ5TQhjJTO8Lp1SbuVmW3kNNAPP+KOe7ACvE5l
         68jaH+z9tZSwvE+7DUiBGGWQdr+FgmqDdRrgVMLBVgi1aI3EGX2WXqO2AwqtUtBTwiIB
         3jF2/sXaSOA/V1/AT6SBBz+EhnSTEhXpyW16up+IBNkq6gs+8aEFq1g8j85I+cjVfTmf
         jpfoXC1UP7zCGyG+ejFa+52NC6KfjOS1mDIxGGZuaJN4lrOlWvNs4QYTjGJWdt4QqYjq
         uczg==
X-Gm-Message-State: AOJu0YxFiipUdQuH09J6PnORjwGFPQog8GgtdEu3DpaQzJ0D1Ayrl7Hs
	MPNoDZYLSpaOJL4yvZhbaygTk91fHbJJuV+/5Gkpe2AHf8FHIQH8Bot8tTjiJOgEk56xeB0HUIT
	GA8E6
X-Gm-Gg: ASbGncv10MsJmhDJpYiWldbOwzh8Fc196TFhle5GlyFQf3VUdJTC1GZ/ZkrfQJqbp0H
	jvA+xdBoXmubL1iyb1O2Ag8NO6XYe1pcGlJzEusW58BHL4DL1YbfshMqT/AZEDuPAPmHaKTWRdn
	Bw5zsNpjLH3AtHXXsPfi5Zl2k2Wltk09X64wz2wQx33FksYvAZSA/bKQdibMsV3S6S/A1L9JXRi
	Se+v9/npWpyonMttxsGad6W3hOcHvHKRouEoAoDXfPofjFkKcszTGJwULBFxqzDsjzf9gr0fUPi
	0puJB/5HbOPHHoDAadRzeAAHFTcoFJ9agOacww/VefN5Mc1Bjs0K/96q86amLxfceB489GXjwNw
	m/gRk1U2yj4/SOxv/JFQOuFDlU15Lfb+ajcVW3JgMcSt84bwfJEZSKTn/2SbYno4cYKkXY01D
X-Google-Smtp-Source: AGHT+IF2KC9T6dHcyorS3QP4C9m5k7mGro1NHYlgrJVQufawrEzEX3hlpkccM60dh9BVa5NQIZiFcg==
X-Received: by 2002:a17:907:c1c:b0:add:fb01:c64a with SMTP id a640c23a62f3a-ae6fcac8546mr1180964666b.43.1752442909599;
        Sun, 13 Jul 2025 14:41:49 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee8d9fsm697447866b.46.2025.07.13.14.41.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 14:41:48 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso6163443a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 14:41:48 -0700 (PDT)
X-Received: by 2002:a05:6402:40c2:b0:5f8:357e:bb1 with SMTP id
 4fb4d7f45d1cf-611e84a7d9fmr9981805a12.22.1752442907834; Sun, 13 Jul 2025
 14:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 13 Jul 2025 14:41:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMZkz3O5d3aHvbw3uN9JyF1Lt1xrpTYdEuZmU7aUYJ3w@mail.gmail.com>
X-Gm-Features: Ac12FXwLz_94H_8AZpibZQkx0ThvhajlA4yU66VmjHjnH5f6k9l2nqhSyQr1pkw
Message-ID: <CAHk-=wgMZkz3O5d3aHvbw3uN9JyF1Lt1xrpTYdEuZmU7aUYJ3w@mail.gmail.com>
Subject: Linux 6.16-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So I had a little scare this week, noticing some odd instability on
Thursday, and basically then lost a day to trying to figure that whole
thing out. The fix ended up being a simple revert in the end, but for
a while there I was getting "Uh-oh, we're in trouble" vibes, because I
had trouble reproducing the issue consistently, and it wasn't at all
obvious even what subsystem had broken things.

So I was flailing around blaming everybody and their pet hamster,
because for a while it looked like a drm issue and then a netlink
problem (it superficially coincided with separate issues with both of
those subsystems).

But I did eventually figure out how to trigger it reliably and then it
bisected nicely, and a couple of days have passed, and I'm feeling
much better about the release again. We're back on track, and despite
that little scare, I think we're in good shape.

Below you'll find the shortlog for the week - no real pattern stands
out. It's random fixes spread out fairly evenly, so we've got a bit of
everything: drivers, arch fixes, filesystems, networking, tooling,
documentation.

We've got a couple more weeks to go for this release, let's hope they
go more smoothly than the last one. But please do keep testing,

                Linus

---

Aaron Thompson (1):
      drm/nouveau: Do not fail module init on debugfs errors

Achill Gilgenast (1):
      kallsyms: fix build without execinfo

Al Viro (1):
      ksmbd: fix a mount write count leak in ksmbd_vfs_kern_path_locked()

Alessio Belle (1):
      drm/imagination: Fix kernel crash when hard resetting the GPU

Alexander Gordeev (1):
      mm/vmalloc: leave lazy MMU mode on PTE mapping error

Alexander Stein (1):
      gpio: of: initialize local variable passed to the .of_xlate() callbac=
k

Alexander Tsoy (1):
      ALSA: usb-audio: Improve filtering of sample rates on Focusrite devic=
es

Alok Tiwari (2):
      net: thunderx: avoid direct MTU assignment after WRITE_ONCE()
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam=
()

Anshuman Khandual (1):
      arm64/mm: Drop wrong writes into TCR2_EL1

Arnd Bergmann (2):
      arm64: move smp_send_stop() cpu mask off stack
      irqchip/irq-msi-lib: Fix build with PCI disabled

Arun Raghavan (1):
      ASoC: fsl_sai: Force a software reset when starting in consumer mode

Baojun Xu (1):
      ALSA: hda/tas2781: Fix calibration data parser issue

Baolin Wang (1):
      mm: fix the inaccurate memory statistics issue for users

Bard Liao (1):
      ASoC: Intel: SND_SOC_INTEL_SOF_BOARD_HELPERS select
SND_SOC_ACPI_INTEL_MATCH

Bartosz Golaszewski (3):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts
      MAINTAINERS: drop bouncing Lakshmi Sowjanya D
      MAINTAINERS: remove bouncing address for Nandor Han

Ben Skeggs (1):
      drm/nouveau/gsp: fix potential leak of memory used during acpi init

Binbin Wu (1):
      Documentation: KVM: Fix unexpected unindent warnings

Borislav Petkov (AMD) (5):
      x86/bugs: Rename MDS machinery to something more generic
      x86/bugs: Add a Transient Scheduler Attacks mitigation
      KVM: SVM: Advertise TSA CPUID bits to guests
      x86/microcode/AMD: Add TSA microcode SHAs
      x86/process: Move the buffer clearing before MONITOR

Breno Leitao (1):
      arm64: efi: Fix KASAN false positive for EFI runtime stack

Carolina Jubran (2):
      net/mlx5: Reset bw_share field when changing a node's parent
      net/mlx5e: Fix race between DIM disable and net_dim()

Chao Yu (3):
      erofs: fix to add missing tracepoint in erofs_readahead()
      erofs: fix to add missing tracepoint in erofs_read_folio()
      erofs: allow readdir() to be interrupted

Charles Keepax (1):
      ASoC: Intel: soc-acpi: arl: Correct order of cs42l43 matches

Chen Yu (1):
      Revert "sched/numa: add statistics of numa balance task"

Chen-Yu Tsai (1):
      dt-bindings: net: sun8i-emac: Rename A523 EMAC0 to GMAC0

Chenyi Qiang (1):
      KVM: selftests: Add back the missing check of MONITOR/MWAIT availabil=
ity

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting
for skb_shared_info

Christoph Berg (1):
      mm/migrate: fix do_pages_stat in compat mode

Christophe JAILLET (1):
      net: airoha: Fix an error handling path in airoha_probe()

Daniel Dadap (1):
      ALSA: hda: Add missing NVIDIA HDA codec IDs

Daniel Gomez (1):
      MAINTAINERS: update Daniel Gomez's role and email address

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in
zd_mac_tx_to_dev()

Danilo Krummrich (1):
      rust: drm: device: drop_in_place() the drm::Device in release()

Dave Airlie (1):
      nouveau/gsp: add a 50ms delay between fbsr and driver unload rpcs

David Howells (3):
      rxrpc: Fix over large frame size warning
      rxrpc: Fix bug due to prealloc collision
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

David Woodhouse (1):
      KVM: x86/xen: Allow 'out of range' event channel ports in IRQ
routing table.

Deren Wu (2):
      wifi: mt76: mt7925: prevent NULL pointer dereference in
mt7925_sta_set_decap_offload()
      wifi: mt76: mt7921: prevent decap offload config before STA initializ=
ation

Edip Hazuri (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 15-fb2xxx

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset Mic on Positivo K116J

Eric Biggers (1):
      crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2

Eric Dumazet (3):
      tcp: refine sk_rcvbuf increase for ooo packets
      selftests/net: packetdrill: add tcp_ooo-before-and-after-accept.pkt
      netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_pr=
oto()

EricChan (1):
      net: stmmac: Fix interrupt handling for level-triggered mode in DWC_X=
GMAC2

Felix Fietkau (3):
      wifi: rt2x00: fix remove callback type mismatch
      wifi: mt76: add a wrapper for wcid access with validation
      wifi: mt76: fix queue assignment for deauth packets

Feng Tang (1):
      dma-contiguous: hornor the cma address limit setup by user

Florian Fainelli (3):
      scripts/gdb: fix interrupts display after MCP on x86
      scripts/gdb: fix interrupts.py after maple tree conversion
      scripts/gdb: de-reference per-CPU MCE interrupts

Gao Xiang (3):
      erofs: use memcpy_to_folio() to replace copy_to_iter()
      erofs: address D-cache aliasing
      erofs: fix large fragment handling

Geert Uytterhoeven (1):
      PCI: host-generic: Set driver_data before calling gen_pci_init()

Guillaume Nault (2):
      gre: Fix IPv6 multicast route creation.
      selftests: Add IPv6 multicast route generation tests for GRE devices.

Hangbin Liu (1):
      selftests: net: lib: fix shift count out of range

Hans de Goede (1):
      drm/i915/bios: Apply vlv_fixup_mipi_sequences() to v2 mipi-sequences =
too

Haoxiang Li (1):
      net: ethernet: rtsn: Fix a null pointer dereference in rtsn_probe()

Harry Yoo (1):
      lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_user=
s()

Henry Martin (1):
      wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()

Himanshu Madhani (1):
      PCI/MSI: Prevent recursive locking in pci_msix_write_tph_tag()

Honggyu Kim (4):
      samples/damon: fix damon sample prcl for start failure
      samples/damon: fix damon sample wsse for start failure
      samples/damon: fix damon sample mtier for start failure
      mm/damon: fix divide by zero in damon_get_intervals_score()

Hugo Villeneuve (1):
      gpiolib: fix performance regression when using gpio_chip_get_multiple=
()

H=C3=A5kon Bugge (1):
      md/md-bitmap: fix GPF in bitmap_get_stats()

Illia Ostapyshyn (1):
      scripts: gdb: vfs: support external dentry names

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Jason Xing (1):
      bnxt_en: eliminate the compile warning in bnxt_request_irq due
to CONFIG_RFS_ACCEL

Jens Axboe (2):
      io_uring/msg_ring: ensure io_kiocb freeing is deferred for RCU
      Revert "io_uring: gate REQ_F_ISREG on !S_ANON_INODE as well"

Jianbo Liu (1):
      net/mlx5e: Add new prio for promiscuous mode

Jiayuan Chen (1):
      tcp: Correct signedness in skb remaining space calculation

Johannes Berg (2):
      wifi: mac80211: clear frame buffer to never leak stack
      wifi: mac80211: fix non-transmitted BSSID profile search

Julia Filipchuk (1):
      drm/xe/guc: Recommend GuC v70.46.2 for BMG, LNL, DG2

Julien Massot (1):
      dt-bindings: clock: mediatek: Add #reset-cells property for MT8188

Kent Overstreet (10):
      bcachefs: bch2_fpunch_snapshot()
      bcachefs: Fix bch2_io_failures_to_text()
      bcachefs: Fix btree for nonexistent tree depth
      bcachefs: Tweak btree cache helpers for use by btree node scan
      bcachefs: btree node scan no longer uses btree cache
      bcachefs: btree read retry fixes
      bcachefs: Fix bch2_btree_transactions_read() synchronization
      bcachefs: Don't schedule non persistent passes persistently
      bcachefs: Fix additional misalignment in journal space calculations
      bcachefs: Don't set BCH_FS_error on transaction restart

Kevin Brodsky (1):
      arm64: poe: Handle spurious Overlay faults

Kirill A. Shutemov (1):
      MAINTAINERS: Update Kirill Shutemov's email address for TDX

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kuniyuki Iwashima (6):
      netlink: Fix wraparounds of sk->sk_rmem_alloc.
      tipc: Fix use-after-free in tipc_conn_close().
      atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      atm: clip: Fix memory leak of struct clip_vcc.
      atm: clip: Fix infinite recursive call of clip_push().
      netlink: Fix rmem check in netlink_broadcast_deliver().

Lachlan Hodges (2):
      wifi: cfg80211: fix S1G beacon head validation in nl80211
      wifi: mac80211: correctly identify S1G short beacon

Lance Yang (1):
      mm/rmap: fix potential out-of-bounds page table access during
batched unmap

Leon Yen (1):
      wifi: mt76: mt792x: Limit the concurrent STA and SoftAP to
operate on the same channel

Liam Merwick (1):
      KVM: Allow CPU to reschedule while setting per-page memory attributes

Linus Torvalds (3):
      eventpoll: don't decrement ep refcount while still holding the ep mut=
ex
      Revert "eventpoll: Fix priority inversion problem"
      Linux 6.16-rc6

Lorenzo Bianconi (5):
      wifi: mt76: Assume __mt76_connac_mcu_alloc_sta_req runs in atomic con=
text
      wifi: mt76: Move RCU section in mt7996_mcu_set_fixed_field()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl()
      wifi: mt76: Remove RCU section in mt7996_mac_sta_rc_work()

Louis Peens (1):
      MAINTAINERS: remove myself as netronome maintainer

Lucas De Marchi (1):
      drm/xe/guc: Default log level to non-verbose

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix not disabling advertising instance
      Bluetooth: hci_core: Remove check of BDADDR_ANY in
hci_conn_hash_lookup_big_state
      Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS han=
dle
      Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected

Lukas Wunner (1):
      agp/amd64: Check AGP Capability before binding to unsupported devices

Luo Jie (2):
      net: phy: qcom: move the WoL function to shared library
      net: phy: qcom: qca808x: Fix WoL issue by utilizing at8031_set_wol()

Manuel Andreas (1):
      KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush

Marc Zyngier (4):
      PCI: apple: Add tracking of probed root ports
      Revert "PCI: ecam: Allow cfg->priv to be pre-populated from the
root port device"
      KVM: arm64: Fix handling of FEAT_GTG for unimplemented granule sizes
      arm64: Unconditionally select CONFIG_JUMP_LABEL

Mario Limonciello (1):
      pinctrl: amd: Clear GPIO debounce for suspend

Mark Brown (2):
      arm64/gcs: Don't try to access GCS registers if arm64.nogcs is enable=
d
      arm64: Filter out SME hwcaps when FEAT_SME isn't implemented

Mark Rutland (1):
      KVM: arm64: Remove kvm_arch_vcpu_run_map_fp()

Mathy Vanhoef (1):
      wifi: prevent A-MSDU attacks in mesh networks

Matthew Auld (1):
      drm/xe/bmg: fix compressed VRAM handling

Matthew Brost (2):
      drm/xe: Allocate PF queue size on pow2 boundary
      Revert "drm/xe/xe2: Enable Indirect Ring State support for Xe2"

Michael Lo (1):
      wifi: mt76: mt7925: fix invalid array index in ssid assignment
during hw scan

Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_lo=
cal`

Michal Wajdeczko (2):
      drm/xe/pf: Clear all LMTT pages on alloc
      drm/xe/bmg: Don't use WA 16023588340 and 22019338487 on VF

Mikhail Paulyshka (2):
      x86/rdrand: Disable RDSEED on AMD Cyan Skillfish
      x86/CPU/AMD: Disable INVLPGB on Zen2

Mikko Perttunen (1):
      drm/tegra: nvdec: Fix dma_alloc_coherent error check

Milan Krstic (1):
      pinctrl: aw9523: fix can_sleep flag for GPIO chip

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: fix the wrong config for tx interrupt
      wifi: mt76: mt7925: fix incorrect scan probe IE handling for hw_scan

Mingming Cao (1):
      ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof

Miquel Raynal (1):
      pinctrl: nuvoton: Fix boot on ma35dx platforms

Miri Korenblit (2):
      wifi: mac80211: always initialize sdata::key_list
      wifi: mac80211: add the virtual monitor after reconfig complete

Moon Hee Lee (1):
      wifi: mac80211: reject VHT opmode for unsupported channel widths

Mostafa Saleh (1):
      KVM: arm64: Fix error path in init_hyp_mode()

Namjae Jeon (1):
      ksmbd: fix potential use-after-free in oplock/lease break ack

Nigel Croxon (1):
      raid10: cleanup memleak at raid10_make_request

Nikunj A Dadhania (1):
      KVM: SVM: Add missing member in SNP_LAUNCH_START command structure

Ofir Bitton (1):
      MAINTAINERS: Change habanalabs maintainer

Oleksij Rempel (5):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Force predictable MDI-X state on LAN87xx
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
      net: phy: microchip: Use genphy_soft_reset() to purge stale LPA bits
      net: phy: microchip: limit 100M workaround to link-down events on LAN=
88xx

Pagadala Yesu Anjaneyulu (1):
      wifi: mac80211: Fix uninitialized variable with __free() in
ieee80211_ml_epcs()

Pankaj Raghav (1):
      block: reject bs > ps block devices when THP is disabled

Paolo Bonzini (3):
      KVM: TDX: Exit to userspace for SetupEventNotifyInterrupt
      KVM: TDX: Report supported optional TDVMCALLs in TDX capabilities
      KVM: x86: avoid underflow when scaling TSC frequency

Pavel Begunkov (1):
      io_uring/zcrx: fix pp destruction warnings

Peter Ujfalusi (1):
      ALSA: hda/realtek: Add quirk for ASUS ExpertBook B9403CVAR

Petr Pavlu (2):
      module: Fix memory deallocation on error path in move_module()
      module: Avoid unnecessary return value initialization in move_module(=
)

Quentin Perret (2):
      KVM: arm64: Adjust range correctly during host stage-2 faults
      KVM: arm64: Don't free hyp pages with pKVM on GICv2

Rafael J. Wysocki (1):
      PM: sleep: Call pm_restore_gfp_mask() after dpm_resume()

Richard Fitzgerald (1):
      ASoC: cs35l56: probe() should fail if the device ID is not recognized

Ryo Takakura (1):
      net: bcmgenet: Initialize u64 stats seq counter

Sascha Hauer (1):
      clk: scmi: Handle case where child clocks are initialized before
their parents

Sean Christopherson (3):
      KVM: SVM: Reject SEV{-ES} intra host migration if vCPU creation
is in-flight
      KVM: SVM: Initialize vmsa_pa in VMCB to INVALID_PAGE if VMSA page is =
NULL
      KVM: x86/hyper-v: Use preallocated per-vCPU buffer for
de-sparsified vCPU masks

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx
message to debug level

Sebastian Andrzej Siewior (1):
      module: Make sure relocations are applied to the per-CPU section

SeongJae Park (1):
      mm/damon/core: handle damon_call_control as normal under kdmond
deactivation

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Shruti Parab (1):
      bnxt_en: Flush FW trace before copying to the coredump

Shuicheng Lin (3):
      drm/xe/pm: Restore display pm if there is error after display suspend
      drm/xe: Release runtime pm for error path of xe_devcoredump_read()
      drm/xe/pm: Correct comment of xe_pm_set_vram_threshold()

Simon Trimmer (1):
      ASoC: Intel: sof_sdw: Add quirks for Lenovo P1 and P16

Simona Vetter (1):
      drm/gem: Fix race in drm_gem_handle_create_tail()

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Srinivas Kandagatla (1):
      MAINTAINERS: update Qualcomm audio codec drivers list

Stefan Metzmacher (1):
      smb: server: make use of rdma_destroy_qp()

Stefano Garzarella (1):
      vsock: fix `vsock_proto` declaration

Tamir Duberstein (1):
      rust: drm: remove unnecessary imports

Tetsuo Handa (1):
      perf/core: Fix WARN in perf_sigtrap()

Thomas Wei=C3=9Fschuh (2):
      uapi: bitops: use UAPI-safe variant of BITS_PER_LONG again (2)
      MAINTAINERS: bitmap: add UAPI headers

Thomas Zimmermann (1):
      drm/framebuffer: Acquire internal references on GEM handles

Thorsten Blum (1):
      ALSA: ad1816a: Fix potential NULL pointer deref in snd_card_ad1816a_p=
np()

Uwe Kleine-K=C3=B6nig (2):
      pwm: Fix invalid state detection
      pwm: mediatek: Ensure to disable clocks in error path

Victor Nogueira (2):
      selftests/tc-testing: Create test case for UAF scenario with
DRR/NETEM/BLACKHOLE chain
      net/sched: Abort __tc_modify_qdisc if parent class does not exist

Vitaly Kuznetsov (2):
      efi: Drop preprocessor directives from zboot.lds
      efi: Fix .data section size calculations when .sbat is present

Vitor Soares (1):
      wifi: mwifiex: discard erroneous disassoc frames on STA interface

Vivek Kasireddy (1):
      mm/hugetlb: don't crash when allocating a folio if there are no resv

Wang Jinchao (1):
      md/raid1: Fix stack memory use after return in raid1_reshape

Wei Yang (1):
      maple_tree: fix mt_destroy_walk() on root leaf node

Wei-Lin Chang (1):
      KVM: arm64: nv: Fix MI line level calculation in
vgic_v3_nested_update_mi()

Xiang Mei (1):
      net/sched: sch_qfq: Fix null-deref in agg_dequeue

Xiaolei Wang (1):
      clk: imx: Fix an out-of-bounds access in dispmix_csr_clk_dev_data

Yeoreum Yun (1):
      kasan: remove kasan_find_vm_area() to prevent possible deadlock

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Zheng Qixing (2):
      md/raid1,raid10: strip REQ_NOWAIT from member bios
      nbd: fix uaf in nbd_genl_connect() error path

