Return-Path: <linux-kernel+bounces-826444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9910B8E8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C0116473A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D228B7EA;
	Sun, 21 Sep 2025 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wnkeatg0"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D212F5A5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758493565; cv=none; b=UCyqq4tMdmuj11agz2g/C8XHDQw7dwDekfe8bxNMf7fpckzSxN6dLRK35KV53nkjV3ntkULa65MqdJCtGCwxmS1DyIy7QDW7s5Aojzyc0H6SvGtBta0P97Q7SQWnxLEfJxu87uqJCligOsg2iVuLhrZMMFwOA9lujnMUnzdGx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758493565; c=relaxed/simple;
	bh=KvyUMCDpK3ONCyWXt8HNnKTuiOvwqUpumWEQU91UImQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cdcg4Ri+AjjFSBvUWhLNdl3a+qQQSPOzFWfvt5x4bLCzsAa3wDx/XZ1O3yDvx0kUW1deRQ6UGswU4cBPfp0GZ/OWIeV0i47VZamoJabXGBDQ8K1dJDfFfzoxPH0fJ6pEknoU0KAjuNBoZvkYPmgpxER40QSfdxv4ZV5P9KIK5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wnkeatg0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso2101657a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758493560; x=1759098360; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYt7CP8ZB2dTFwLKNjlmybYql4/jO9DxLCD8ZXYli3g=;
        b=Wnkeatg0U0AofbhOzWN19cSbiuPozJLtpgmsT/z6oRXPm3PPaoDKHTr+ocLH33nZO9
         8HFWHON7FNi6t0Neyz5iSmWLCFC4QmpYNpqdy7JjKyBV3x6BMJx5WF7rOOB4kdXjtwU3
         ++4LO2G0iGVLnP29l2Qa3YPeI2rNSkUO9MrKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758493560; x=1759098360;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYt7CP8ZB2dTFwLKNjlmybYql4/jO9DxLCD8ZXYli3g=;
        b=DAJVrIgSK0EXdblTh8F8FGUO1t4rOPWr9F6mDRVYYmghJR9WqKU4b2JFSIHIn7BuoZ
         CGUEt0NOTljiyt4MopXQkI4Po3fd6oxuQMyXeyDQJ+GVYVNIf1eiKkYY3IufBcSL06oI
         0JnlQlIytq39KYdip3gxYx5uZ6wrlMeN9HL+iEnI7hYztHatBRKleZC+1JpMhbBWEaFt
         S0cducBGrZMcj/76R/H9ofZrOMJlIPZTPj6bIApQHVCCvSQmfZPfVWGHCmkgSAGnhqre
         K238uZHbWV9B76Y86yoiS1LPdZiRbqLRXyn0vGNdcr66JPDDWz4I7tvFHhNhvd7XcUST
         xQYA==
X-Gm-Message-State: AOJu0Yzg4JyiIiZFOUZE7H5+fz61FEMcNQPpbwvr1C16OYyRxDzj+rEB
	a/jGj5dg0l5l/5xGlO8h33FYX/fgM+Vuaxqe3lQcMwNAU8wWVXsoG1ntkk/aVSO/38eBl9+ztV7
	6llyus78=
X-Gm-Gg: ASbGncvnXQY422DAquNzNbQHZdKNFWEnZO2a9lC2O/lm6S3PtCZ0Zj7KpHTzW59o/uS
	2k0NS2Gx+YJ9KAW0D9AiV8vU+Q1HZe+DFjfbh3q7QT1Bk2ZOLKgKLd5lrUXJRF4uBSjV7pXHd/0
	ybTQp+LoePb1lQHNnhRh2BLuy9JXFH+tQMbHq98QIXZjjsbiCGUPCh0rg7BJ+KfV05caP+FjyLR
	iC65GOD9O4fLHN7WP5o0TtO1EuvLLSRefPp2uXUnc5OmEYcANEv95MBDKwLnje/9ILg8m2J3Lpd
	qr8YJN7hqjTaCtUgPmKrE/yhfKdpslRWNdlSh6vz18+t2ZHoUJpnbSfx1mf1DSmGv3CHpQoyA3W
	owgkPKr0GfN8QNhXjks86SLtDX/VR5WmWEQd9qqO4z3QGSu+3/u7nSaDcGaBoo90yAwafHedu
X-Google-Smtp-Source: AGHT+IGbxZ144C+zx4CqLRLWQfQEq2r7/1UB7MtkXhao8dOVWlMBFdryr/2ko5PEfmhHlgLS5/77cA==
X-Received: by 2002:a50:bace:0:b0:62f:a2dd:86d5 with SMTP id 4fb4d7f45d1cf-62fa2dd8765mr9900136a12.17.1758493559496;
        Sun, 21 Sep 2025 15:25:59 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f287d9sm7872249a12.44.2025.09.21.15.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 15:25:58 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07e3a77b72so695880766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:25:57 -0700 (PDT)
X-Received: by 2002:a17:907:2685:b0:b0e:d477:4978 with SMTP id
 a640c23a62f3a-b1faf817706mr1560945666b.32.1758493556664; Sun, 21 Sep 2025
 15:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Sep 2025 15:25:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZvXYrdE3J2dUcO=V1Wywf7EJv77TyBQr836+jjTXmFQ@mail.gmail.com>
X-Gm-Features: AS18NWAqzV8ZIlsV34nfR6yNk_5qA1kRcUSmWS33v_D5J8BWZupu-E_yZM6KRK8
Message-ID: <CAHk-=whZvXYrdE3J2dUcO=V1Wywf7EJv77TyBQr836+jjTXmFQ@mail.gmail.com>
Subject: Linux 6.17-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Normal week, and unless something oidd happens this is the last rc before 6=
.17.

Mixed random small changes all over with nothing really jumping out.
It's all fairly spread out, with no obvious big concentration of fixes
anywhere.

There's obviously the usual driver side (gpu, networking and sound
being most of it),  and the rest is all fairly random: selftests, arch
fixes (mostly kvm-related), filesystems (mostly smb) and some core
kernel, mm and net code.

I don't think there's much of a pattern to any of it, but the shortlog
is appended for people who want to look around.

Let's keep the testing going, and we'll have the final 6.17 in a week,

                  Linus

---

Aaron Ma (1):
      drm/i915/backlight: Honor VESA eDP backlight luminance control capabi=
lity

Akhilesh Patil (1):
      include/linux/rv.h: remove redundant include file

Alex Deucher (2):
      drm/amdkfd: add proper handling for S0ix
      drm/amdgpu: suspend KFD and KGD user queues for S0ix

Alexandru Elisei (2):
      KVM: arm64: Initialize PMSCR_EL1 when in VHE
      KVM: arm64: VHE: Save and restore host MDCR_EL2 value correctly

Alexey Nepomnyashih (1):
      net: liquidio: fix overflow in octeon_init_instr_queue()

Alok Tiwari (2):
      scsi: ufs: mcq: Fix memory allocation checks for SQE and CQE
      KVM: arm64: vgic: fix incorrect spinlock API usage

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: Intel: catpt: Expose correct bit depth to userspace

Anderson Nascimento (1):
      net/tcp: Fix a NULL pointer dereference when using TCP-AO with TCP_RE=
PAIR

Andrea Righi (1):
      Revert "sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()"

Antheas Kapenekakis (4):
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
      platform/x86: oxpec: Add support for OneXPlayer X1Pro EVA-02
      platform/x86: oxpec: Add support for AOKZOE A1X
      platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk

Bagas Sanjaya (1):
      Revert "drm: Add directive to format code in comment"

Balamurugan C (1):
      ASoC: Intel: PTL: Add entry for HDMI-In capture support to
non-I2S codec boards.

Ben Chuang (3):
      mmc: sdhci: Move the code related to setting the clock from
sdhci_set_ios_common() into sdhci_set_ios()
      mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
      mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II
interface during a power-on

Bibo Mao (5):
      LoongArch: KVM: Fix VM migration failure with PTW enabled
      LoongArch: KVM: Avoid copy_*_user() with lock hold in
kvm_eiointc_ctrl_access()
      LoongArch: KVM: Avoid copy_*_user() with lock hold in
kvm_eiointc_regs_access()
      LoongArch: KVM: Avoid copy_*_user() with lock hold in
kvm_eiointc_sw_status_access()
      LoongArch: KVM: Avoid copy_*_user() with lock hold in
kvm_pch_pic_regs_access()

Borislav Petkov (AMD) (1):
      crypto: ccp - Always pass in an error pointer to
__sev_platform_shutdown_locked()

Bou-Saan Che (3):
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 5
      ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 5
      ALSA: hda/realtek: Fix volume control on Lenovo Thinkbook 13x Gen 4

Charles Keepax (6):
      ASoC: wm8940: Correct PLL rate rounding
      ASoC: wm8940: Correct typo in control name
      ASoC: wm8974: Correct PLL rate rounding
      ASoC: SDCA: Fix return value in sdca_regmap_mbq_size()
      ASoC: SDCA: Fix return value in detected_mode_handler()
      ASoC: SDCA: Reorder members of hide struct to remove holes

Chen Ridong (2):
      cgroup: split cgroup_destroy_wq into 3 workqueues
      cgroup/psi: Set of->priv to NULL upon file release

Chen-Yu Tsai (1):
      clk: sunxi-ng: mp: Fix dual-divider clock rate readback

Claudio Imbrenda (2):
      KVM: s390: Fix incorrect usage of mmu_notifier_register()
      KVM: s390: Fix FOLL_*/FAULT_FLAG_* confusion

Colin Ian King (1):
      ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error me=
ssage

Cosmin Ratiu (1):
      devlink rate: Remove unnecessary 'static' from a couple places

Dan Carpenter (2):
      ASoC: codec: sma1307: Fix memory corruption in sma1307_setting_loaded=
()
      drm/xe: Fix a NULL vs IS_ERR() in xe_vm_add_compute_exec_queue()

Daniel Baluta (1):
      ASoC: SOF: imx: Fix devm_ioremap_resource check

Daniele Ceraolo Spurio (2):
      drm/xe: Fix error handling if PXP fails to start
      drm/xe/guc: Set RCS/CCS yield policy

David Howells (2):
      rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()
      rxrpc: Fix untrusted unsigned subtract

David Sterba (1):
      btrfs: ref-verify: handle damaged extent root tree

Denis Kirjanov (1):
      MAINTAINERS: update sundance entry

Donald Menig (1):
      ALSA: hda/realtek: Add ALC295 Dell TAS2781 I2C fixup

Dongha Lee (1):
      KVM: arm64: nv: Fix incorrect VNCR invalidation range calculation

Duoming Zhou (2):
      cnic: Fix use-after-free bugs in cnic_delete_task
      octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()

Eric Dumazet (1):
      net: clear sk->sk_ino in sk_set_socket(sk, NULL)

Eugene Koira (1):
      iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()

Filipe Manana (2):
      btrfs: fix invalid extref key setup when replaying dentry
      btrfs: annotate block group access with data_race() when sorting
for reclaim

Fuad Tabba (1):
      KVM: arm64: Fix parameter ordering for VBAR_EL1 assignment

Geert Uytterhoeven (2):
      clk: renesas: mstp: Add genpd OF provider at postcore_initcall()
      pmdomain: renesas: rcar-sysc: Make rcar_sysc_onecell_np __initdata

Geliang Tang (1):
      selftests: mptcp: sockopt: fix error messages

Geonha Lee (1):
      KVM: arm64: nv: fix VNCR TLB ASID match logic for non-Global entries

Guangshuo Li (1):
      LoongArch: vDSO: Check kcalloc() result in init_vdso()

H. Nikolaus Schaller (2):
      power: supply: bq27xxx: fix error return in case of no bq27000 hdq ba=
ttery
      power: supply: bq27xxx: restrict no-battery detection to bq27000

Hangbin Liu (4):
      bonding: set random address only when slaves already exist
      selftests: bonding: add fail_over_mac testing
      bonding: don't set oif to bond dev when getting NS target destination
      selftests: bonding: add vlan over bond testing

Hans de Goede (1):
      net: rfkill: gpio: Fix crash due to dereferencering uninitialized poi=
nter

Herbert Xu (2):
      crypto: af_alg - Set merge to zero early in af_alg_sendmsg
      crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg

Huacai Chen (1):
      LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled

Hugh Dickins (5):
      mm/gup: check ref_count instead of lru before migration
      mm/gup: local lru_add_drain() to avoid lru_add_drain_all()
      mm: revert "mm/gup: clear the LRU flag of a page before adding
to LRU batch"
      mm: revert "mm: vmscan.c: fix OOM on swap stress test"
      mm: folio_may_be_lru_cached() unless folio_test_large()

H=C3=A5kon Bugge (1):
      rds: ib: Increment i_fastreg_wrs before bailing out

Ian Rogers (2):
      perf lock: Provide a host_env for session new
      perf maps: Ensure kmap is set up for all inserts

Ilya Maximets (2):
      net: dst_metadata: fix IP_DF bit not extracted from tunnel headers
      selftests: openvswitch: add a simple test for tunnel metadata

Ioana Ciornei (1):
      dpaa2-switch: fix buffer pool seeding for control traffic

Ivan Lipski (1):
      drm/amd/display: Allow RX6xxx & RX7700 to invoke amdgpu_irq_get/put

Ivan Vecera (1):
      dpll: fix clock quality level reporting

Jack Yu (1):
      ASoC: rt5682s: Adjust SAR ADC button mode to fix noise issue

Jacob Keller (1):
      ice: fix Rx page leak on multi-buffer frames

Jakub Kicinski (3):
      MAINTAINERS: make the DPLL entry cover drivers
      tls: make sure to abort the stream if headers are bogus
      selftests: tls: test skb copy under mem pressure and OOB

Jamie Bainbridge (1):
      qed: Don't collect too many protection override GRC elements

Jedrzej Jagielski (2):
      ixgbe: initialize aci.lock before it's used
      ixgbe: destroy aci.lock later within ixgbe_remove path

Jens Axboe (2):
      io_uring: include dying ring in task_work "should cancel" state
      io_uring/msg_ring: kill alloc_cache for io_kiocb allocations

Jianbo Liu (1):
      net/mlx5e: Harden uplink netdev access against device unbind

Johannes Berg (1):
      wifi: iwlwifi: pcie: fix byte count table for some devices

Johannes Thumshirn (1):
      btrfs: zoned: fix incorrect ASSERT in btrfs_zoned_reserve_data_reloc_=
bg()

Kamal Heib (1):
      octeon_ep: Validate the VF ID

Kohei Enju (1):
      igc: don't fail igc_probe() on LED setup error

Krzysztof Kozlowski (3):
      ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if
source graph failed
      ASoC: codecs: lpass-rx-macro: Fix playback quality distortion
      ASoC: codecs: lpass-wsa-macro: Fix speaker quality distortion

Kuniyuki Iwashima (2):
      tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
      selftest: packetdrill: Add tcp_fastopen_server_reset-after-disconnect=
.pkt.

Lama Kayal (1):
      net/mlx5e: Add a miss level for ipsec crypto offload

Lance Yang (1):
      MAINTAINERS: add Lance Yang as a THP reviewer

Li Tian (1):
      net/mlx5: Not returning mlx5_link_info table when speed is unknown

Linus Torvalds (1):
      Linux 6.17-rc7

Loic Poulain (1):
      drm: bridge: anx7625: Fix NULL pointer dereference with early IRQ

Lorenzo Stoakes (1):
      MAINTAINERS: add Jann Horn as rmap reviewer

Mac Chiang (1):
      ASoC: Intel: sof_sdw: use PRODUCT_FAMILY for Fatcat series

Maciej Fijalkowski (1):
      i40e: remove redundant memory barrier when cleaning Tx descs

Maciej S. Szmigiero (1):
      KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active

Maciej Strozek (1):
      ASoC: SDCA: Add quirk for incorrect function types for 3 systems

Mallesh Koujalagi (1):
      drm/xe/hwmon: Remove type casting

Marc Zyngier (1):
      KVM: arm64: Mark freed S2 MMUs as invalid

Mario Limonciello (1):
      drm/amd: Only restore cached manual clock settings in restore if
OD enabled

Mario Limonciello (AMD) (1):
      gpiolib: acpi: Program debounce when finding GPIO

Matthew Rosato (1):
      iommu/s390: Fix memory corruption when using identity domain

Matthieu Baerts (NGI0) (9):
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      selftests: mptcp: print trailing bytes with od
      selftests: mptcp: connect: print pcap prefix
      mptcp: set remote_deny_join_id0 on SYN recv
      mptcp: pm: nl: announce deny-join-id0 flag
      selftests: mptcp: userspace pm: validate deny-join-id0 flag
      mptcp: tfo: record 'deny join id0' info

Max Kellermann (1):
      io_uring/io-wq: fix `max_workers` breakage and `nr_workers` underflow

Miaoqian Lin (1):
      um: virtio_uml: Fix use-after-free after put_device in probe

Michal Wajdeczko (1):
      drm/xe/pf: Drop rounddown_pow_of_two fair LMEM limitation

Mikulas Patocka (3):
      dm-stripe: fix a possible integer overflow
      dm-integrity: limit MAX_TAG_SIZE to 255
      dm-raid: don't set io_min and io_opt for raid1

Mohammad Rafi Shaik (4):
      ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S inte=
rface
      ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
      ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S interf=
aces
      ASoC: qcom: sc8280xp: Fix sound card driver name match data for QCS82=
75

Nam Cao (1):
      rv: Fix wrong type cast in enabled_monitors_next()

Namjae Jeon (1):
      ksmbd: smbdirect: validate data_offset and data_length field of
smb_direct_data_transfer

Nathan Chancellor (1):
      nilfs2: fix CFI failure when accessing /sys/fs/nilfs2/features/*

Niklas Schnelle (1):
      iommu/s390: Make attach succeed when the device was surprise removed

Nitin Gote (1):
      drm/xe: defer free of NVM auxiliary container to device release callb=
ack

Oliver Upton (8):
      KVM: arm64: vgic: Drop stale comment on IRQ active state
      KVM: arm64: vgic-v3: Use bare refcount for VGIC LPIs
      KVM: arm64: Spin off release helper from vgic_put_irq()
      KVM: arm64: vgic-v3: Erase LPIs from xarray outside of raw spinlocks
      KVM: arm64: vgic-v3: Don't require IRQs be disabled for LPI xarray lo=
ck
      KVM: arm64: vgic-v3: Indicate vgic_put_irq() may take LPI xarray lock
      Revert "KVM: arm64: Reschedule as needed when destroying the
stage-2 page-tables"
      Revert "KVM: arm64: Split kvm_pgtable_stage2_destroy()"

Palmer Dabbelt (1):
      rv: Support systems with time64-only syscalls

Paul Menzel (1):
      ALSA: docs: Remove 3rd person singular s in *to indicate*

Paulo Alcantara (2):
      smb: client: fix filename matching of deferred files
      smb: client: fix file open check in __cifs_unlink()

Praful Adiga (1):
      ALSA: hda/realtek: Fix mute led for HP Laptop 15-dw4xx

Qi Xi (1):
      drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path

Qu Wenruo (2):
      btrfs: tree-checker: fix the incorrect inode ref size check
      btrfs: reject invalid compression level

Remy D. Farley (1):
      doc/netlink: Fix typos in operation attributes

Richard Fitzgerald (1):
      ALSA: hda: intel-dsp-config: Prevent SEGFAULT if ACPI_HANDLE() is NUL=
L

Richard Weinberger (1):
      um: Don't mark stack executable

Russell King (Oracle) (1):
      net: ethtool: handle EOPNOTSUPP from ethtool get_ts_info() method

Samiullah Khawaja (1):
      net: Use NAPI_* in test_bit when stopping napi kthread

Sathesh B Edara (1):
      octeon_ep: fix VF MAC address lifecycle handling

SeongJae Park (5):
      mm/damon/core: introduce damon_call_control->dealloc_on_cancel
      mm/damon/sysfs: use dynamically allocated repeat mode damon_call_cont=
rol
      samples/damon/wsse: avoid starting DAMON before initialization
      samples/damon/prcl: avoid starting DAMON before initialization
      samples/damon/mtier: avoid starting DAMON before initialization

Sergey Senozhatsky (1):
      zram: fix slot write race condition

Shenghao Ding (2):
      ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data
      ALSA: hda/tas2781: Fix a potential race condition that causes a
NULL pointer in case no efi.get_variable exsits

Shuicheng Lin (1):
      drm/xe/tile: Release kobject for the failure path

Shuming Fan (1):
      ASoC: rt712: avoid skipping the blind write

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Support new ACPI ID AMDI0108

Srinivasan Shanmugam (1):
      drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.0.1/11.0.4 GPU=
s

Stefan Metzmacher (6):
      smb: server: let smb_direct_writev() respect SMB_DIRECT_MAX_SEND_SGES
      ksmbd: smbdirect: verify remaining_data_length respects
max_fragmented_recv_size
      smb: client: let recv_done verify data_offset, data_length and
remaining_data_length
      smb: client: use disable[_delayed]_work_sync in smbdirect.c
      smb: client: let smbd_destroy() call
disable_work_sync(&info->post_send_credits_work)
      smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error pat=
h

Steven Rostedt (1):
      rv: Add Gabriele Monaco as maintainer for Runtime Verification

Syed Saba Kareem (1):
      ASoC: amd: amd_sdw: Add quirks for some new Dell laptops

S=C3=A9bastien Szymanski (1):
      gpiolib: acpi: initialize acpi_gpio_info struct

Takashi Iwai (1):
      ALSA: usb: qcom: Fix false-positive address space check

Takashi Sakamoto (1):
      firewire: core: fix overlooked update of subsystem ABI version

Tao Cui (3):
      LoongArch: Check the return value when creating kobj
      LoongArch: Replace sprintf() with sysfs_emit()
      LoongArch: KVM: Remove unused returns and semicolons

Tariq Toukan (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"

Tejun Heo (1):
      sched_ext, sched/core: Fix build failure when !FAIR_GROUP_SCHED
&& EXT_GROUP_SCHED

Thomas Fourier (1):
      mmc: mvsdio: Fix dma_unmap_sg() nents value

Thomas Huth (1):
      KVM: s390: Fix access to unavailable adapter indicator pages
during postcopy

Tiezhu Yang (6):
      objtool/LoongArch: Mark types based on break immediate code
      objtool/LoongArch: Mark special atomic instruction as INSN_BUG type
      LoongArch: Make LTO case independent in Makefile
      LoongArch: Handle jump tables options for RUST
      LoongArch: Update help info of ARCH_STRICT_ALIGN
      LoongArch: Fix unreliable stack for live patching

Tiwei Bie (1):
      um: Fix FD copy size in os_rcv_fd_msg()

Tom Lendacky (1):
      x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT

Ulf Hansson (5):
      pmdomain: core: Restore behaviour for disabling unused PM domains
      pmdomain: rockchip: Fix regulator dependency with GENPD_FLAG_NO_STAY_=
ON
      pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
      pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains power=
ed-on
      pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered=
-on

Vasant Hegde (2):
      iommu/amd: Fix alias device DTE setting
      iommu/amd/pgtbl: Fix possible race while increase page table level

Venkata Prasad Potturu (2):
      ASoC: amd: acp: Adjust pdm gain value
      ASoC: amd: acp: Fix incorrect retrival of acp_chip_info

Wang Liang (1):
      tracing: kprobe-event: Fix null-ptr-deref in
trace_kprobe_create_internal()

Wei-Lin Chang (1):
      KVM: arm64: Remove stage 2 read fault check

Yang Xiuwei (1):
      io_uring: fix incorrect io_kiocb reference in io_link_skb

Yeounsu Moon (1):
      net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` fail=
ure

Zhang Yi (2):
      md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
      drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter

Zhen Ni (2):
      iommu/amd: Fix ivrs_base memleak in early_amd_iommu_init()
      rv: Fix missing mutex unlock in rv_register_monitor()

Zongyao Bai (1):
      drm/xe/sysfs: Add cleanup action in xe_device_sysfs_init

aprilgrimoire (1):
      platform/x86/amd/pmc: Add MECHREVO Yilong15Pro to spurious_8042 list

austinchang (1):
      btrfs: initialize inode::file_extent_tree after i_mode has been set

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty

