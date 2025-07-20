Return-Path: <linux-kernel+bounces-738480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D82B0B8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05073171C0C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99981EE019;
	Sun, 20 Jul 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h1MvuNXa"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2E8BEE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051767; cv=none; b=r1Ob2c3vTUpEbLsRa324JUPcZUnpisXiuNYlDpfRazAM+ocpx50uGFVewnJxxGM9KK0HpuvYBcNTGrItTW4XL4d5NyGzD10NuFMTGvwN7BRdYXsz7G7L5b9ckY46Xcc3H3nO6oFVytZA5HTHhF7lilU+mbJ/W2XyGWsgs776lZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051767; c=relaxed/simple;
	bh=pILwZ24WXIiHnR6wLMRxWRh7YBxNdOUHnj0VXmZDzxU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qRyZ1p6C0zslzzfktA0k6Xi/CPSKkPHZvh/N2JiluVe9mt1QOgT00Pb8XdCUxKdv+1Ax42EHD+LkB+gWJJxy+jwDoNT7exbCrdSsFqAAbhnzKmf5qNJ3iQuKG0p8JLJMoCCLyhPAFFCrN9kQYosoqSeNe45qVGk7xWSNnFZksec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h1MvuNXa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so605658666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753051762; x=1753656562; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFZMk0D2rissCoRM6H1kBh0R0QRk4mNShKivPRwsMZI=;
        b=h1MvuNXalVX8B6NyZAJ1qt/1p5aIv5twanBvj9Z9E6glUfea5YAccYJ0RACtHc5CyB
         WrhclshDvoHchnFmyect7lY7BHUJ/d0hDPdrAZ1JjBlYrQnMlD9ye5ZUuygPK7ke/o1K
         lQ+YUNi9JwvOAziLgSVNbdueotsrlW32lIfRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753051762; x=1753656562;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFZMk0D2rissCoRM6H1kBh0R0QRk4mNShKivPRwsMZI=;
        b=mXMgkSgMIhmsj1IP+B5yMmOfNKXYNe4ePeQ3UMKnusotN8FRSFEr4Ht/LEQg5t9LlN
         zSijfXnHHjWQmLoquplzc0gDMzY6iTZEwP7WOYdr1nUTF5Uq+d2Ib60yy3Kdp9H8vBwf
         V3cZc5tKjGEBboWOhBEMi6UkJE+8xxymBT8GHQwqmbLP8halPQvQlxkQkusIq2IB9Uqo
         nyziqlZcaKijMQ3yvnr/w+lwtYP4Pdj3+y8bLbs2/AJj9Dah+Slk7/ITq4g6Eelrh/JI
         5b7gw7QYVBWwHULgrTlm156dOJnr6sHcP3zA5Ro9wDHQaWWnOtrNmbg+l5PZSHyAzfND
         +juw==
X-Gm-Message-State: AOJu0Yx5lIg47L0a+P1cB7QFfWU5jy2Ifp/tbD/7bTilMrdqW3xhVARm
	QzSXJ302AFR2HXnXwPEskMB6c0dgXpjwt2r+xZ8hePAaP9FOaT4wx5CCgroyVvOcCkxZcsqzOPT
	zmPOB2Ho=
X-Gm-Gg: ASbGncu1dj9+sdGCIVUzREENM4GIatCOy7im4xiX97Tn4XxcXKcbTYKcuFxAjKK+lvM
	V7AigQ9ib9v86Dsj9SBauGGHuODXdc0V7AmtacBeikRR5CnAAyiYB8jgwxEf+II4p2wFJK6jU3a
	/2I+CJ0g4RHlyoWPEyDfOJiEiwb9e1VvFO97kcZRjFQkuhRRhO/4SZ2ZnDf+p6z8wlnaEiMQfn+
	OGOZuA8ESQsIVzaQSq7veqyU2UX0ruSsB1UcZHlhnJ2b6gpvWV4tpK12t+QKe/xn2nc7BIZ53J+
	fwocCiWJcQbPjLyPrEQlhJepEwd4ELg4S3wJF07+G5kxSxHBx7q0NP7GjaF1z1c0W0rcZE8/7jV
	Q6FbAqpL4j0X09xugjIvapDC2GZL2lSFcJixVgKcnVpGnq9mg/7Bs+0K2CQayUFvP/I/+SD2BJz
	v625oWt1A=
X-Google-Smtp-Source: AGHT+IH/Y3qPJBluRW3NxFAfCPIj6ptM9i8qyBDQt8G4rgDRi8QTiAk080TRSfCdtTG0k4T3zWsREQ==
X-Received: by 2002:a17:907:d2cd:b0:ae3:60fb:1b3b with SMTP id a640c23a62f3a-ae9ce1b162dmr1656086966b.58.1753051761626;
        Sun, 20 Jul 2025 15:49:21 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d6d34sm570909866b.48.2025.07.20.15.49.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 15:49:21 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so5393746a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 15:49:20 -0700 (PDT)
X-Received: by 2002:a05:6402:164d:b0:60c:5853:5b7f with SMTP id
 4fb4d7f45d1cf-61285dfca8dmr14468291a12.32.1753051760200; Sun, 20 Jul 2025
 15:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Jul 2025 15:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdXcZfQEL2Xa+GEEtcC7Ez9SEWnGaB76R76VZsYcMOnA@mail.gmail.com>
X-Gm-Features: Ac12FXx_HiA6nnyoUTXhEht026c0dUXxbOsWxXJuebyWKDsjuUcyobqhYdP9lhQ
Message-ID: <CAHk-=wgdXcZfQEL2Xa+GEEtcC7Ez9SEWnGaB76R76VZsYcMOnA@mail.gmail.com>
Subject: Linux 6.16-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So last week started very quiet and that always makes me happy. Then
on Thursday I started getting some updates, and I went "ok, so at
least we have some networking fixes", but things otherwise still felt
like this was going to be a tiny rc7.

And then Friday came along.

And the weekend.

And here we are, with a not inconsiderable rc7.

That said, the last few days I ended up getting a fair amount of pull
requests, but pretty much all of them were tiny. A lot of single-fix
pulls, and while rc7 isn't the tiny release it looked like mid-week,
it's also not really any bigger than usual.

So there are fixes all over, they are all pretty small.

Nothing really stands out - the biggest patches in here are for some
documentation and self-tests or tooling, not actual kernel code
changes.

So unlike the week before, it all feels very trivial and I think we're
in good shape. Knock wood,

            Linus

---

Abdun Nihaal (1):
      regmap: fix potential memory leak of regmap_bus

Abinash Singh (1):
      dma: dw-edma: Fix build warning in dw_edma_pcie_probe()

Adam Queler (1):
      ASoC: amd: yc: Add DMI entries to support HP 15-fb1xxx

Akshay Gupta (3):
      misc: amd-sbi: Address potential integer overflow issue reported in s=
match
      misc: amd-sbi: Address copy_to/from_user() warning reported in smatch
      misc: amd-sbi: Explicitly clear in/out arg "mb_in_out"

Al Viro (1):
      fix a leak in fcntl_dirnotify()

Alessandro Gasbarroni (1):
      Bluetooth: hci_sync: fix connectable extended advertising when
using static random address

Alexandre Ghiti (3):
      riscv: Stop considering R_RISCV_NONE as bad relocations
      riscv: ftrace: Properly acquire text_mutex to fix a race condition
      riscv: Stop supporting static ftrace

Alexandru Andries (1):
      ASoC: amd: yc: add DMI quirk for ASUS M6501RM

Alexey Charkov (1):
      arm64: dts: rockchip: list all CPU supplies on ArmSoM Sige5

Alok Tiwari (3):
      thunderbolt: Fix bit masking in tb_dp_port_set_hops()
      net: emaclite: Fix missing pointer increment in aligned_read()
      net: airoha: fix potential use-after-free in airoha_npu_get()

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: Intel: avs: Fix NULL ptr deref on rmmod

Amit Pundir (1):
      soundwire: Revert "soundwire: qcom: Add set_channel_map api support"

Andrea Righi (2):
      selftests/sched_ext: Fix exit selftest hang on UP
      sched_ext: idle: Handle migration-disabled tasks in idle selection

Andreas Schwab (1):
      riscv: traps_misaligned: properly sign extend value in
misaligned load handler

Andrew Jeffery (2):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled

Andrii Nakryiko (1):
      libbpf: Fix handling of BPF arena relocations

Andr=C3=A9 Draszik (1):
      gpiolib: devres: release GPIOs in devm_gpiod_put_array()

Andy Shevchenko (1):
      HID: debug: Remove duplicate entry (BTN_WHEEL)

Andy Yan (3):
      arm64: dts: rockchip: Adjust the HDMI DDC IO driver strength for rk35=
88
      arm64: dts: rockchip: Add cd-gpios for sdcard detect on Cool Pi CM5
      arm64: dts: rockchip: Add cd-gpios for sdcard detect on Cool Pi 4B

Angelo Dureghello (1):
      dt-bindings: iio: adc: adi,ad7606: fix dt_schema validation warning

Antonio Quartulli (1):
      ovpn: reject unexpected netlink attributes

Anup Patel (2):
      RISC-V: KVM: Disable vstimecmp before exiting to user-space
      RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC virtualization

Ard Biesheuvel (1):
      x86/sev: Work around broken noinstr on GCC

Arnd Bergmann (4):
      ALSA: compress_offload: tighten ioctl command number checks
      drm/nouveau: check ioctl command codes better
      ASoC: Intel: fix SND_SOC_SOF dependencies
      ethernet: intel: fix building with large NR_CPUS

Aruna Ramakrishna (1):
      sched: Change nr_uninterruptible type to unsigned long

Balasubramani Vivekanandan (1):
      drm/xe/mocs: Initialize MOCS index early

Bard Liao (1):
      ASoC: Intel: soc-acpi: add support for HP Omen14 ARL

Ben Horgan (1):
      KVM: arm64: Fix enforcement of upper bound on MDCR_EL2.HPMN

Benjamin Tissoires (4):
      HID: core: ensure the allocated report buffer can contain the
reserved report ID
      HID: core: ensure __hid_request reserves the report ID as the first b=
yte
      HID: core: do not bypass hid_hw_raw_request
      selftests/hid: add a test case for the recent syzbot underflow

Bharath SM (1):
      smb: invalidate and close cached directory when creating child entrie=
s

Binbin Wu (1):
      Documentation: KVM: Fix unexpected unindent warning

Bjorn Andersson (1):
      arm64: defconfig: Enable Qualcomm CPUCP mailbox driver

Breno Leitao (2):
      sched/ext: Prevent update_locked_rq() calls with NULL rq
      efivarfs: Fix memory leak of efivarfs_fs_info in fs_context error pat=
hs

Brett Werling (1):
      can: tcan4x5x: fix reset gpio usage during probe

Chen Ni (1):
      iio: adc: stm32-adc: Fix race in installing chained IRQ handler

Chen Ridong (2):
      sched,freezer: Remove unnecessary warning in __thaw_task
      Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"

Chen-Yu Tsai (1):
      iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps

Cheng Ming Lin (1):
      spi: Add check for 8-bit transfer with 8 IO mode support

Christian Brauner (2):
      secretmem: use SB_I_NOEXEC
      MAINTAINERS: add block and fsdevel lists to iov_iter

Christian Eggers (3):
      Bluetooth: hci_core: fix typos in macros
      Bluetooth: hci_core: add missing braces when using macro parameters
      Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap

Christoph Hellwig (8):
      xfs: clean up the initial read logic in xfs_readsb
      xfs: remove the call to sync_blockdev in xfs_configure_buftarg
      xfs: add a xfs_group_type_buftarg helper
      xfs: refactor xfs_calc_atomic_write_unit_max
      xfs: rename the bt_bdev_* buftarg fields
      xfs: remove the bt_bdev_file buftarg field
      nvme: revert the cross-controller atomic write size validation
      xfs: don't allocate the xfs_extent_busy structure for zoned RTGs

Christoph Paasch (1):
      net/mlx5: Correctly set gso_size when LRO is used

Christophe JAILLET (2):
      i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()
      i2c: omap: Fix an error handling path in omap_i2c_probe()

Clayton King (1):
      drm/amd/display: Free memory allocation

Cl=C3=A9ment Le Goffic (2):
      i2c: stm32: fix the device used for the DMA map
      i2c: stm32f7: unmap DMA mapped buffer

Dan Carpenter (1):
      dmaengine: nbpfaxi: Fix memory corruption in probe()

Daniel Lezcano (1):
      cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=3Dy

Dave Ertman (1):
      ice: add NULL check in eswitch lag check

David Howells (7):
      netfs: Fix copy-to-cache so that it performs collection with ceph+fsc=
ache
      netfs: Fix race between cache write completion and ALL_QUEUED being s=
et
      rxrpc: Fix irq-disabled in local_bh_enable()
      rxrpc: Fix recv-recv race of completed call
      rxrpc: Fix notification vs call-release vs recvmsg
      rxrpc: Fix transmission of an abort in response to an abort
      rxrpc: Fix to use conn aborts for conn-wide failures

David Lechner (3):
      iio: adc: adi-axi-adc: fix ad7606_bus_reg_read()
      iio: adc: ad7949: use spi_is_bpw_supported()
      iio: adc: ad7380: fix adi,gain-milli property parsing

Diederik de Haas (1):
      arm64: dts: rockchip: Add missing fan-supply to rk3566-quartz64-a

Dmitry Baryshkov (1):
      phy: use per-PHY lockdep keys

Dong Chenchen (2):
      net: vlan: fix VLAN 0 refcount imbalance of toggling filtering
during runtime
      selftests: Add test cases for vlan_filter modification during runtime

Drew Hamilton (1):
      usb: musb: fix gadget state on disconnect

Edip Hazuri (1):
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-r0xxx

Edson Juliano Drosdeck (1):
      mmc: sdhci-pci: Quirk for broken command queuing on Intel
GLK-based Positivo models

Eeli Haapalainen (1):
      drm/amdgpu/gfx8: reset compute ring wptr on the GPU on resume

Fabio Estevam (2):
      iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
      iio: adc: max1363: Reorder mode_list[] entries

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition

Felix Fietkau (1):
      net: fix segmentation after TCP/UDP fraglist GRO

Florian Westphal (6):
      selftests: netfilter: conntrack_resize.sh: extend resize test
      selftests: netfilter: add conntrack clash resolution test case
      selftests: netfilter: conntrack_resize.sh: also use udpclash tool
      selftests: netfilter: nft_concat_range.sh: send packets to empty set
      netfilter: nf_tables: hide clash bit from userspace
      netfilter: nf_conntrack: fix crash due to removal of uninitialised en=
try

Francesco Dolcini (1):
      arm64: dts: freescale: imx8mm-verdin: Keep LDO5 always on

Gabor Juhos (3):
      interconnect: increase ICC_DYN_ID_START
      interconnect: icc-clk: destroy nodes in case of memory allocation fai=
lures
      interconnect: avoid memory allocation when 'icc_bw_lock' is held

Haotien Hsu (1):
      phy: tegra: xusb: Disable periodic tracking on Tegra234

Harshit Mogalapalli (1):
      phy: qcom: fix error code in snps_eusb2_hsphy_probe()

Herbert Xu (2):
      crypto: chelsio - Use crypto_shash_export_core
      crypto: qat - Use crypto_shash_export_core

Ian Abbott (9):
      comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
      comedi: Fix some signed shift left operations
      comedi: das16m1: Fix bit shift out of bounds
      comedi: pcl812: Fix bit shift out of bounds
      comedi: aio_iiro_16: Fix bit shift out of bounds
      comedi: das6402: Fix bit shift out of bounds
      comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
      comedi: Fix initialization of data for instructions that write
to subdevice
      comedi: comedi_test: Fix possible deletion of uninitialized timers

Icenowy Zheng (1):
      drm/mediatek: only announce AFBC if really supported

Ilya Leoshkevich (2):
      s390/bpf: Fix bpf_arch_text_poke() with new_addr =3D=3D NULL again
      selftests/bpf: Stress test attaching a BPF prog to another BPF prog

Imre Deak (1):
      drm/dp: Change AUX DPCD probe address from LANE0_1_STATUS to
TRAINING_PATTERN_SET

Jackie Dong (1):
      ALSA: hda/realtek: Support mute LED for Yoga with ALC287

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: use cs-gpios for spi1 on ringneck

Jakub Kicinski (1):
      tls: always refresh the queue when reading sock

Jan Kara (1):
      isofs: Verify inode mode when loading from disk

Janne Grunau (1):
      rust: init: Fix generics in *_init! macros

Jason-JH Lin (1):
      drm/mediatek: Add wait_event_timeout when disabling plane

Jiawen Wu (4):
      net: libwx: remove duplicate page_pool_put_full_page()
      net: libwx: fix the using of Rx buffer DMA
      net: libwx: properly reset Rx ring descriptor
      net: libwx: fix multicast packets received count

Jinliang Zheng (1):
      iomap: avoid unnecessary ifs_set_range_uptodate() with locks

Johan Hovold (4):
      arm64: dts: qcom: sc8280xp-x13s: describe uefi rtc offset
      arm64: dts: qcom: x1e80100: describe uefi rtc offset
      interconnect: exynos: handle node name allocation failure
      serial: core: fix OF node leak

Johannes Berg (2):
      wifi: iwlwifi: pcie: fix locking on invalid TOP reset
      wifi: cfg80211: remove scan request n_channels counted_by

John Garry (1):
      nvme: fix endianness of command word prints in nvme_log_err_passthru(=
)

Jonas Rebmann (1):
      hwmon: (ina238) Report energy in microjoules

Joseph Huang (1):
      net: bridge: Do not offload IGMP/MLD messages

Judith Mendez (1):
      mmc: sdhci_am654: Workaround for Errata i2312

Kai Huang (1):
      KVM: x86: Reject KVM_SET_TSC_KHZ vCPU ioctl for TSC protected guest

Kent Overstreet (7):
      bcachefs: io_read: remove from async obj list in rbio_done()
      bcachefs: Fix triggering of discard by the journal path
      bcachefs: Tweak threshold for allocator triggering discards
      bcachefs: Don't build aux search tree when still repairing node
      bcachefs: Fix reference to invalid bucket in copygc
      bcachefs: Fix build when CONFIG_UNICODE=3Dn
      bcachefs: Fix bch2_maybe_casefold() when CONFIG_UTF8=3Dn

Kim Seer Paller (1):
      iio: dac: ad3530r: Fix incorrect masking for channels 4-7 in
powerdown mode

Krishna Kurapati (1):
      usb: dwc3: qcom: Don't leave BCR asserted

Krzysztof Kozlowski (1):
      mux: mmio: Fix missing CONFIG_REGMAP_MMIO

Kuniyuki Iwashima (3):
      rpl: Fix use-after-free in rpl_do_srh_inline().
      smc: Fix various oops due to inet_sock type confusion.
      Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()

Lane Odenbach (1):
      ASoC: amd: yc: Add DMI quirk for HP Laptop 17 cp-2033dx

Laura Brehm (1):
      coredump: fix PIDFD_INFO_COREDUMP ioctl check

Li Tian (1):
      hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to
prevent IPv6 addrconf

Lijo Lazar (1):
      drm/amdgpu: Increase reset counter only on success

Linus Torvalds (1):
      Linux 6.16-rc7

Lorenz Bauer (1):
      btf: Fix virt_to_phys() on arm64 when mmapping BTF

Louis-Alexis Eyraud (1):
      drm/mediatek: mtk_dpi: Reorder output formats on MT8195/88

Lucas De Marchi (1):
      drm/xe/migrate: Fix alignment check

Luiz Augusto von Dentz (4):
      Bluetooth: btintel: Check if controller is ISO capable on
btintel_classify_pkt_type
      Bluetooth: SMP: If an unallowed command is received consider it a fai=
lure
      Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
      Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU

Maor Gottlieb (1):
      net/mlx5: Update the list of the PCI supported devices

Mario Limonciello (2):
      gpiolib: acpi: Add a quirk for Acer Nitro V15
      thunderbolt: Fix wake on connect at runtime

Marius Zachmann (1):
      hwmon: (corsair-cpro) Validate the size of the received input buffer

Markus Bl=C3=B6chl (1):
      net: stmmac: intel: populate entire system_counterval_t in
get_time_fn() callback

Markus Burri (2):
      iio: backend: fix out-of-bound write
      iio: fix potential out-of-bound write

Mathias Nyman (1):
      usb: hub: Don't try to recover devices lost during warm reset.

Matthew Auld (1):
      drm/xe/migrate: fix copy direction in access_memory

Matthew Brost (1):
      drm/xe: Move page fault init after topology init

Maud Spierings (1):
      iio: common: st_sensors: Fix use of uninitialize device structs

Maulik Shah (1):
      pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu=
_gov

Maurizio Lombardi (1):
      nvmet-tcp: fix callback lock for TLS handshake

Melissa Wen (1):
      drm/amd/display: Disable CRTC degamma LUT for DCN401

Meng Li (1):
      arm64: dts: add big-endian property back into watchdog node

Michael C. Pratt (1):
      nvmem: layouts: u-boot-env: remove crc32 endianness conversion

Michael Kelley (1):
      Drivers: hv: Select CONFIG_SYSFB only if EFI is enabled

Michal Swiatkowski (1):
      ice: check correct pointer in fwlog debugfs

Michal Wajdeczko (2):
      drm/xe/pf: Prepare to stop SR-IOV support prior GT reset
      drm/xe/pf: Resend PF provisioning after GT reset

Miguel Ojeda (2):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.89.0
      rust: use `#[used(compiler)]` to fix build and `modpost` with
Rust >=3D 1.89.0

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY

Ming Lei (2):
      block: fix kobject leak in blk_unregister_queue
      loop: use kiocb helpers to fix lockdep warning

Mukesh Rathor (1):
      PCI: hv: Don't load the driver for baremetal root partition

Nam Cao (1):
      riscv: Enable interrupt during exception handling

Naman Jain (7):
      Drivers: hv: Fix the check for HYPERVISOR_CALLBACK_VECTOR
      Drivers: hv: Fix warnings for missing export.h header inclusion
      x86/hyperv: Fix warnings for missing export.h header inclusion
      clocksource: hyper-v: Fix warnings for missing export.h header inclus=
ion
      PCI: hv: Fix warnings for missing export.h header inclusion
      net: mana: Fix warnings for missing export.h header inclusion
      tools/hv: fcopy: Fix irregularities with size of ring buffer

Nathan Chancellor (4):
      tracing/probes: Avoid using params uninitialized in parse_btf_arg()
      memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()
      riscv: uaccess: Fix -Wuninitialized and -Wshadow in __put_user_nochec=
k
      phonet/pep: Move call to pn_skb_get_dst_sockaddr() earlier in
pep_sock_accept()

Nilton Perim Neto (1):
      Input: xpad - set correct controller type for Acer NGR200

Nithyanantham Paramasivam (1):
      wifi: ath12k: Fix packets received in WBM error ring with REO LUT ena=
bled

Nuno Das Neves (3):
      x86/hyperv: Fix usage of cpu_online_mask to get valid cpu
      x86/hyperv: Clean up hv_map/unmap_interrupt() return values
      Drivers: hv: Use nested hypercall for post message and signal event

Oder Chiou (1):
      ASoC: rt5660: Fix the dmic data source from GPIO2

Oliver Neukum (1):
      usb: net: sierra: check for no status endpoint

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mask reserved bits in chan_state_active_bitmap

Paolo Abeni (4):
      selftests: net: increase inter-packet timeout in udpgro.sh
      mptcp: make fallback action and fallback decision atomic
      mptcp: plug races between subflow fail and subflow creation
      mptcp: reset fallback status gracefully at disconnect() time

Paolo Bonzini (2):
      KVM: Documentation: minimal updates to review-checklist.rst
      KVM: Documentation: document how KVM is tested

Paul Chaignon (2):
      bpf: Reject %p% format string in bprintf-like helpers
      selftests/bpf: Add negative test cases for snprintf

Pavel Begunkov (2):
      io_uring/zcrx: disallow user selected dmabuf offset and size
      io_uring/poll: fix POLLERR handling

Phil Sutter (1):
      Revert "netfilter: nf_tables: Add notifications for hook changes"

Philipp Stanner (1):
      drm/panfrost: Fix scheduler workqueue bug

Pranav Tyagi (1):
      xfs: replace strncpy with memcpy in xattr listing

Qiu-ji Chen (1):
      dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()

Rafael J. Wysocki (2):
      PM: suspend: Drop a misplaced pm_restore_gfp_mask() call
      PM: sleep: Update power.completion for all devices on errors

Ralf Lici (2):
      ovpn: propagate socket mark to skb in UDP
      ovpn: reset GSO metadata after decapsulation

Richard Fitzgerald (1):
      ALSA: hda/cs35l56: Workaround bad dev-index on Lenovo Yoga Book 9i Ge=
nX

Richard Zhu (1):
      arm64: dts: imx95: Correct the DMA interrupter number of pcie0_ep

Rodrigo Gobbi (1):
      dt-bindings: iio: gyro: invensense,mpu3050: change irq maxItems

Ryan Mann (NDI) (1):
      USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI

Sean Anderson (1):
      net: phy: Don't register LEDs for genphy

Sean Christopherson (1):
      KVM: VMX: Ensure unused kvm_tdx_capabilities fields are zeroed out

Sean Nyekjaer (1):
      iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush

Shawn Lin (1):
      arm64: dts: rockchip: fix rk3576 pcie1 linux,pci-domain

Sheng Yong (1):
      dm-bufio: fix sched in atomic context

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W640

Stanislav Kinsburskii (2):
      x86/hyperv: Expose hv_map_msi_interrupt()
      PCI: hv: Use the correct hypercall for unmasking interrupts on nested

Stefan Wahren (3):
      Revert "staging: vchiq_arm: Improve initial VCHIQ connect"
      Revert "staging: vchiq_arm: Create keep-alive thread during probe"
      staging: vchiq_arm: Make vchiq_shutdown never fail

Steffen B=C3=A4tz (1):
      nvmem: imx-ocotp: fix MAC address byte length

Steve French (1):
      Fix SMB311 posix special file creation to servers which do not
advertise reparse support

Steven Rostedt (1):
      tracing: Add down_write(trace_event_sem) when adding trace event

Sunil V L (1):
      ACPI: RISC-V: Remove unnecessary CPPC debug message

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG Strix G712LWS

Tamir Duberstein (1):
      MAINTAINERS: add miscdevice Rust abstractions

Tejas Upadhyay (1):
      drm/xe: Dont skip TLB invalidations on VF

Terry Tritton (1):
      selftests/futex: Convert 32-bit timespec to 64-bit version for
32-bit compatibility mode

Thomas Fourier (2):
      mmc: bcm2835: Fix dma_unmap_sg() nents value
      pch_uart: Fix dma_sync_sg_for_device() nents value

Thomas Zimmermann (2):
      drm/radeon: Do not hold console lock while suspending clients
      drm/radeon: Do not hold console lock during resume

Tim Harvey (4):
      arm64: dts: imx8mp-venice-gw71xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw72xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw73xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw74xx: fix TPM SPI frequency

Tomas Glozar (1):
      tracing/osnoise: Fix crash in timerlat_dump_stack()

Torben Nielsen (1):
      hwmon: (pmbus/ucd9000) Fix error in ucd9000_gpio_set

Victor Nogueira (1):
      selftests/tc-testing: Create test cases for adding qdiscs to
invalid qdisc parents

Vijendar Mukunda (2):
      soundwire: amd: fix for handling slave alerts after link is down
      soundwire: amd: fix for clearing command status register

Ville Syrj=C3=A4l=C3=A4 (1):
      wifi: iwlwifi: Fix botched indexing conversion

Wang Zhaolong (2):
      smb: client: fix use-after-free in cifs_oplock_break
      smb: client: fix use-after-free in crypt_message when using async cry=
pto

Wayne Chang (2):
      phy: tegra: xusb: Decouple CYA_TRK_CODE_UPDATE_ON_IDLE from trk_hw_mo=
de
      phy: tegra: xusb: Fix unbalanced regulator disable in UTMI PHY mode

Wei Fang (2):
      arm64: dts: imx95-19x19-evk: fix the overshoot issue of NETC
      arm64: dts: imx95-15x15-evk: fix the overshoot issue of NETC

William Liu (2):
      net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtre=
e
      selftests/tc-testing: Test htb_dequeue_tree with deactivation
and row emptying

Xiang Mei (1):
      net/sched: sch_qfq: Fix race condition on qfq_aggregate

Xiaoyao Li (1):
      KVM: TDX: Don't report base TDVMCALLs

Xilin Wu (1):
      interconnect: qcom: sc7280: Add missing num_links to xm_pcie3_1 node

Xinyu Liu (1):
      usb: gadget: configfs: Fix OOB read on empty string write

Yasumasa Suenaga (1):
      tools/hv: fcopy: Fix incorrect file path conversion

Yu Kuai (1):
      nvme: fix misaccounting of nvme-mpath inflight I/O

Yue Haibing (1):
      ipv6: mcast: Delay put pmc->idev in mld_del_delrec()

Yun Lu (2):
      af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_sn=
d()
      af_packet: fix soft lockup issue caused by tpacket_snd()

Zheng Qixing (1):
      nvme: fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_l=
ist()

Zigit Zo (1):
      virtio-net: fix recursived rtnl_lock() during probe()

Zihuan Zhang (1):
      PM: suspend: clean up redundant filesystems_freeze/thaw() handling

Zijun Hu (1):
      Bluetooth: btusb: QCA: Fix downloading wrong NVM for WCN6855 GF
variant without board ID

Zizhi Wo (1):
      cachefiles: Fix the incorrect return value in __cachefiles_write()

