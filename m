Return-Path: <linux-kernel+bounces-881984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E9C29604
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F288188C4D4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CCF1D5ADE;
	Sun,  2 Nov 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GyIiS9Yu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D733086
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762113058; cv=none; b=NsfklfuMQG+EVC/azFEcjw0cI+mgn2NFkpGxPwrsPHbmlGuZRktWm+/DhiLyDRp7p4LNKegaL1z8k6aJ8qQZB3ujYnltroVuxHxmFd5cv++tm5ioT4CDELrncgfk+f1gt+5W9ZPzcX6CW3mFpTZUxl2PrhgJS1ulKyF5ww8WAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762113058; c=relaxed/simple;
	bh=PPz5nTK7+Os7ep4qbWpDhB+Crapga2hsr5H8ItTy5Vw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=S9KD1EqbbHgKXEfYL/6DogQ3w62glFZW5vvTkLPw2fuMO/utzl48bEtYFqlox3bSVauWfjYtiZa0mvFFNL1UP7G9PbVlfLbmq/x8cfl4IauC65gPFHVdsgu5fkxCmpqQgU/0R9b0jgYayT6iiSiHTM4uTyOU/Th57UcLbm0PHBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GyIiS9Yu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so495338666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762113053; x=1762717853; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/Z7ssAqbH5tvEZik2b8TxnfAwvwREJRDTulBqIOkjY=;
        b=GyIiS9Yu8jN8wsLv5DGO2i8iQlRdAolbqapB4lnf/KB0/e4U6BqVB2uPakDoEd+DSi
         Ull0VBDDhsMZ90uLzYPKxn5iUnI3FIe2e4/e7NBnD7Vr61LnJNuLc7VWrxZtvR/udmO5
         9SdaudGsN6UtskJV88dJx/LtJOrsvUaETwte8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762113053; x=1762717853;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/Z7ssAqbH5tvEZik2b8TxnfAwvwREJRDTulBqIOkjY=;
        b=lCaH+UZjRZAeEVxmJvjVeQ1TtWG6gudpIh8V+aFIxQDYcXnqirGQGTbJ8gQvpxXPLH
         PbzoNvr0bqm0L43d716U6cco4o0xZdRQe3oh7VLm1e0jOGFqUXIVilvvTm7tzbDNxBuX
         XzruBArk3FSeyBAysvekca1ZtENTeoL9Eb+JK4K2Z2n49iFRDEjZz6ehqKtRw/zturab
         wBh9r+NfH8YlhwDLppXDQ/PBuehmeL/zVUXMm1qgWBus8VWC2G1a93Ec9yuxaI0kFVAi
         OesVCsLLW0P/+FOadr3B7X7oUtsrCHvIjyv/NFXZYBqnifAWHU3dLDcVewZbfGO3WzGg
         IZRw==
X-Gm-Message-State: AOJu0YyV9t/4614II6VG0dlIlfUeBTPvdVgq1JKkPwq87o7ZasgGfJCP
	9dP0UXOJSTqmqiAbC/g0ckf0uukP81p44LkxQs88w7dwgrqkuMW+teS5KZ6u5zm6QwFBzhLHFfR
	zscz798c=
X-Gm-Gg: ASbGncu8ghxVh3tEWAXUscjP+OZ+XUkvXSS/njphAFASXXQIdzblvxzyhpgCqo0ux0+
	zQ0W8pXWT5EOoHjQ11mtOzpcoiy+LlwRyUmvP4YHpoLI6mrLvzVqIqKwsNSl9u4t5pNn7kR8sXJ
	0UvLNGNbpGxKydtAXHwmpEpP7dtokZO5lZaGoDmA9ylvIeuzVL63eygXSYFHk+C/PEIJCM/oVYz
	ny0qtJ/+5RXu6EqW+E+jYbEGwKFjcM6AyiRWcdZ9Qp+RcMUiUFF2EXcb20qQmtlvaL0M+pG0MZp
	sZkoyLBv8t+pVlmVOZ+W6XtuqFjQfvAzjFEHPyHLP0170V4zv8Mz2xd03eYcf2rI/JMyfJG/ETO
	dfRQdAfvIp+VO+Rw+mAEPJGHO9n+g1x4Mmrp4sohM7/lzflXNpFRfMfq88p1kG8ugWeJRNenrK+
	EhW2/RIq3qelz3xZL5+AWvKEk59I05l7sTiG6MD54uHIz9TbN4mriHXXQvtaXj
X-Google-Smtp-Source: AGHT+IF8DrV/JnTeKggv/34VuaPbFpDZHDKd8Bl9YCvN3aFdXGPRYTEeezgnrf3un0hXgqUjgF9ONw==
X-Received: by 2002:a17:907:72c1:b0:b57:1d99:ac93 with SMTP id a640c23a62f3a-b707085974emr1009991866b.51.1762113052510;
        Sun, 02 Nov 2025 11:50:52 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b67d118fsm201264566b.29.2025.11.02.11.50.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 11:50:51 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so623321a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:50:51 -0800 (PST)
X-Received: by 2002:a17:907:3cd6:b0:b6d:79fa:b166 with SMTP id
 a640c23a62f3a-b70708b1503mr903311766b.63.1762113050995; Sun, 02 Nov 2025
 11:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Nov 2025 11:50:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWN96sqa17ZzmWWT2uomirTk08k9tmVySYMG80X+KDhw@mail.gmail.com>
X-Gm-Features: AWmQ_bmq75TFXXgKoROR1A51_60ZDI7lUMqIhogm54J5M5ov3pqL5dhjbOunqvg
Message-ID: <CAHk-=whWN96sqa17ZzmWWT2uomirTk08k9tmVySYMG80X+KDhw@mail.gmail.com>
Subject: Linux 6.18-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm cutting rc4 a couple of hours early, because I am about to get on
a plane for conference travel. But things look calm and pretty normal,
and I'm traveling with my laptop, so apart from slight timing oddities
that shouldn't affect anything.

Last week in fact felt *so* calm that I was surprised to notice that
rc4 isn't really smaller than usual: all the stats look very normal,
both in number of changes and where the changes are. The bulk is
driver fixes, with - as is the norm - gpu, networking and sound driver
leading the charge.

The non-driver changes are pretty spread out: we've got core
networking, we've got filesystems (smb, xfs and nfsd), and we've got
core kernel (sched_ext) and architecture fixes (s390 and x86).

And some new selftests for the issues found (mainly vfio).

None of it looks particularly scary, and a lot of it is trivial one-
and few-liners.

Shortlog appended for people who want to get more of a detailed look
into the fixes from last week, but in general it all feels like we're
on schedule and doing fine.

Talking about schedule: while 6.18 looks normal so far (knock wood),
during the next release we will have not only the yearly kernel
maintainer summit and associated travel during the merge window, we'll
also have the whole holiday season thing going on later in the
release. Right now I don't think it will affect things much - I
suspect I'll do the by now usual "we'll drag out the 6.19 release by a
week to make up for time lost to holidays", but that obviously depends
on 6.18 all continuing as normal etc. So things can still change.

                   Linus

---

Abdun Nihaal (2):
      sfc: fix potential memory leak in efx_mae_process_mport()
      nfp: xsk: fix memory leak in nfp_net_alloc()

Akash Goel (1):
      dma-fence: Fix safe access wrapper to call timeline name method

Akhil P Oommen (1):
      drm/msm/a6xx: Fix GMU firmware parser

Alex Deucher (4):
      drm/amdgpu: fix SPDX headers on amdgpu_cper.c/h
      drm/amdgpu: fix SPDX header on amd_cper.h
      drm/amdgpu: fix SPDX header on irqsrcs_vcn_5_0.h
      drm/amdgpu: fix SPDX header on cyan_skillfish_reg_init.c

Alex Hung (1):
      drm/amd/display: Add HDR workaround for a specific eDP

Alex Mastro (5):
      vfio/type1: sanitize for overflow using check_*_overflow()
      vfio/type1: move iova increment to unmap_unpin_*() caller
      vfio/type1: handle DMA map/unmap up to the addressable limit
      vfio: selftests: update DMA map/unmap helpers to support more test ki=
nds
      vfio: selftests: add end of address space DMA map/unmap tests

Alexey Klimov (1):
      regmap: slimbus: fix bus_context pointer in regmap init calls

Aloka Dixit (1):
      wifi: mac80211: reset FILS discovery and unsol probe resp intervals

Andrea Righi (1):
      sched_ext: Fix scx_kick_pseqs corruption on concurrent scheduler load=
s

Andrii Melnychenko (1):
      netfilter: nft_ct: add seqadj extension for natted connections

Andrii Nakryiko (1):
      libbpf: Fix powerpc's stack register definition in bpf_tracing.h

Anna Maniscalco (1):
      drm/msm: make sure last_fence is always updated

Armin Wolf (2):
      ACPI: fan: Use ACPI handle when retrieving _FST
      ACPI: fan: Use platform device for devres-related actions

Bagas Sanjaya (2):
      MAINTAINERS: mark ISDN subsystem as orphan
      Documentation: netconsole: Remove obsolete contact people

Bard Liao (1):
      ASoC: soc_sdw_utils: remove cs42l43 component_name

Bart Van Assche (2):
      scsi: core: Fix a regression triggered by scsi_host_busy()
      scsi: core: Fix the unit attention counter implementation

Bjorn Helgaas (1):
      Revert "PCI: qcom: Remove custom ASPM enablement code"

Borislav Petkov (AMD) (2):
      x86/microcode/AMD: Limit Entrysign signature checking to known genera=
tions
      x86/CPU/AMD: Extend Zen6 model range

Bui Quang Minh (1):
      virtio-net: drop the multi-buffer XDP packet in zerocopy

Calvin Owens (1):
      Bluetooth: fix corruption in h4_recv_buf() after cleanup

Carlos Llamas (2):
      kunit: prevent log overwrite in param_tests
      blk-crypto: use BLK_STS_INVAL for alignment errors

Cen Zhang (1):
      Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Cezary Rojewski (3):
      ASoC: Intel: avs: Unprepare a stream when XRUN occurs
      ASoC: Intel: avs: Disable periods-elapsed work when closing PCM
      ASoC: Intel: avs: Use snd_codec format when initializing probe

Chang S. Bae (1):
      x86/fpu: Ensure XFD state on signal delivery

Chris Lu (1):
      Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during =
reset

Christoph Hellwig (2):
      xfs: prevent gc from picking the same zone twice
      xfs: document another racy GC case in xfs_zoned_map_extent

Chuck Lever (3):
      NFSD: Define actions for the new time_deleg FATTR4 attributes
      NFSD: Fix crash in nfsd4_read_release()
      Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOU=
ND"

Claudiu Beznea (1):
      ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume

Cosmin Ratiu (1):
      net/mlx5: Don't zero user_count when destroying FDB tables

Damien Le Moal (2):
      block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
      block: make REQ_OP_ZONE_OPEN a write operation

Dan Carpenter (1):
      wifi: iwlwifi: fix potential use after free in iwl_mld_remove_link()

Daniel Borkmann (1):
      bpf: Reject negative head_room in __bpf_skb_change_head

Daniel Palmer (3):
      drm/radeon: Do not kfree() devres managed rdev
      drm/radeon: Remove calls to drm_put_dev()
      fbdev: atyfb: Check if pll_ops->init_pll failed

Dapeng Mi (2):
      perf/x86/intel: Fix KASAN global-out-of-bounds warning
      perf/x86/intel: Add PMU support for WildcatLake

David Rosca (1):
      drm/sched: avoid killing parent entity on child SIGKILL

Dimitri John Ledkov (1):
      kbuild: align modinfo section for Secureboot Authenticode EDK2 compat

Dr. David Alan Gilbert (1):
      MAINTAINERS: wcn36xx: Add linux-wireless list

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable mic on Vaio RPL

Emanuele Ghidoli (1):
      net: phy: dp83867: Disable EEE support as not implemented

Emil Tsalapatis (2):
      sched_ext: defer queue_balance_callback() until after ops.dispatch
      sched_ext: fix flag check for deferred callbacks

Emmanuel Grumbach (1):
      wifi: nl80211: call kfree without a NULL check

Eren Demir (1):
      ALSA: hda/realtek: Fix mute led for HP Victus 15-fa1xxx (MB 8C2D)

Eric Dumazet (3):
      trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
      tcp: add newval parameter to tcp_rcvbuf_grow()
      tcp: fix too slow tcp_rcvbuf_grow() action

Farhan Ali (1):
      s390/pci: Restore IRQ unconditionally for the zPCI device

Fernando Fernandez Mancera (1):
      netfilter: nft_connlimit: fix possible data race on connection count

Florian Fuchs (1):
      fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS

Florian Schmaus (1):
      kunit: test_dev_action: Correctly cast 'priv' pointer to long*

Florian Westphal (1):
      netfilter: nft_ct: enable labels for get case too

Fr=C3=A9d=C3=A9ric Danis (1):
      Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"

Gerd Bayer (1):
      s390/pci: Avoid deadlock between PCI error recovery and mlx5 crdump

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in
standalone AP Mode

Gregory Price (1):
      x86/CPU/AMD: Add RDSEED fix for Zen5

Grzegorz Nitka (3):
      ice: fix lane number calculation
      ice: fix destination CGU for dual complex E825
      ice: fix usage of logical PF id

Gustavo Luiz Duarte (1):
      netconsole: Fix race condition in between reader and writer of userda=
ta

Hangbin Liu (1):
      tools: ynl: avoid print_field when there is no reply

Hannes Reinecke (1):
      nvmet-auth: update sc_c in host response

Hans Holmberg (1):
      null_blk: set dma alignment to logical block size

Haotian Zhang (2):
      crypto: aspeed - fix double free caused by devm
      ASoC: mediatek: Fix double pm_runtime_disable in remove functions

Harald Freudenberger (1):
      crypto: s390/phmac - Do not modify the req->nbytes value

Heikki Krogerus (1):
      spi: intel: Add support for Oak Stream SPI serial flash

Heiko Carstens (2):
      s390: Update defconfigs
      s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

Henrique Carvalho (1):
      smb: client: fix potential cfid UAF in smb2_query_info_compound

Ilpo J=C3=A4rvinen (1):
      PCI: Do not size non-existing prefetchable window

Ivan Lipski (1):
      drm/amd/display: Fix incorrect return of vblank enable on
unconfigured crtc

Ivan Vecera (1):
      dpll: zl3073x: Fix output pin registration

J-Donald Tournier (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 2-in-1 14AKP10

Jakub Hork=C3=BD (2):
      kconfig/mconf: Initialize the default locale at startup
      kconfig/nconf: Initialize the default locale at startup

James Le Cuirot (1):
      kbuild: install-extmod-build: Fix when given dir outside the build di=
r

Jessica Zhang (1):
      drm/msm/dpu: Fix adjusted mode clock check for 3d merge

Jijie Shao (4):
      net: hns3: return error code when function fails
      net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issu=
e
      net: hibmcge: remove unnecessary check for np_link_fail in
scenarios without phy.
      net: hibmcge: fix the inappropriate netif_device_detach()

Jinliang Wang (1):
      net: mctp: Fix tx queue stall

Johan Hovold (2):
      Bluetooth: rfcomm: fix modem control handling
      drm/mediatek: Fix device use-after-free on unbind

Johannes Berg (1):
      wifi: mac80211: fix key tailroom accounting leak

John Smith (2):
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Iceland

Josh Poimboeuf (1):
      objtool: Fix skip_alt_group() for non-alternative STAC/CLAC

Junjie Cao (1):
      fbdev: bitblit: bound-check glyph index in bit_putcs*

Karthik M (1):
      wifi: ath12k: free skb during idr cleanup callback

Kaushlendra Kumar (1):
      ACPI: button: Call input_free_device() on failing input device
registration

Keith Busch (1):
      nvme-pci: use blk_map_iter for p2p metadata

Kenneth Feng (1):
      drm/amd/display: pause the workload setting in dm

Kiran K (1):
      Bluetooth: btintel_pcie: Fix event packet loss issue

Kohei Enju (5):
      ixgbe: fix memory leak and use-after-free in ixgbe_recovery_probe()
      igc: power up the PHY before the link test
      igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
      igc: use EOPNOTSUPP instead of ENOTSUPP in igc_ethtool_get_sset_count=
()
      ixgbe: use EOPNOTSUPP instead of ENOTSUPP in ixgbe_ptp_feature_enable=
()

Krzysztof Kozlowski (1):
      dt-bindings: net: sparx5: Narrow properly LAN969x register space wind=
ows

Linus Torvalds (1):
      Linux 6.18-rc4

Lizhi Xu (1):
      usbnet: Prevents free active kevent

Loic Poulain (1):
      wifi: ath10k: Fix memory leak on unsupported WMI command

Luca Ceresoli (2):
      drm/imx: parallel-display: convert to devm_drm_bridge_alloc() API
      drm/imx: parallel-display: add the bridge before attaching it

Luiz Augusto von Dentz (5):
      Bluetooth: ISO: Fix BIS connection dst_type handling
      Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
      Bluetooth: ISO: Fix another instance of dst_type handling
      Bluetooth: hci_conn: Fix connection cleanup with BIG with 2 or more B=
IS
      Bluetooth: hci_core: Fix tracking of periodic advertisement

Maarten Zanders (1):
      ASoC: fsl_sai: Fix sync error in consumer mode

Madhur Kumar (1):
      selftests/cachestat: add tmpshmcstat file to .gitignore

Malin Jonsson (1):
      bpf: Conditionally include dynptr copy kfuncs

Mario Limonciello (1):
      drm/amd: Check that VPE has reached DPM0 in idle handler

Mark Brown (1):
      ASoC: Fix build for sdw_utils

Mark Pearson (1):
      wifi: ath11k: Add missing platform IDs for quirk table

Matthew Brost (1):
      drm/xe: Do not wake device during a GT reset

Matthew Schwartz (1):
      drm/amd/display: Don't program BLNDGAM_MEM_PWR_FORCE when CM
low-power is disabled on DCN30

Maud Spierings (1):
      regulator: bd718x7: Fix voltages scaled by resistor divider

Miaoqian Lin (3):
      fbdev: valkyriefb: Fix reference count leak in valkyriefb_init
      s390/mm: Fix memory leak in add_marker() when kvrealloc() fails
      net: usb: asix_devices: Check return value of usbnet_get_endpoints

Nathan Chancellor (4):
      nfsd: Avoid strlen conflict in nfsd4_encode_components_esc()
      MAINTAINERS: Update Kconfig section
      KMSAN: Restore dynamic check for '-fsanitize=3Dkernel-memory'
      x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbo=
ls

Neil Armstrong (1):
      drm/msm: dsi: fix PLL init in bonded mode

Noorain Eqbal (1):
      bpf: Sync pending IRQ work before freeing ring buffer

Ondrej Mosnacek (1):
      bpf: Do not audit capability check in do_jit()

PIYUSH CHOUDHARY (1):
      video: fb: Fix typo in comment in fb.h

Paolo Abeni (5):
      mptcp: fix subflow rcvbuf adjust
      mptcp: drop bogus optimization in __mptcp_check_push()
      mptcp: fix MSG_PEEK stream corruption
      mptcp: restore window probe
      mptcp: zero window probe mib

Pauli Virtanen (1):
      Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete

Paulo Alcantara (1):
      smb: client: handle lack of IPC in dfs_cache_refresh()

Pavel Zhigulin (1):
      net: cxgb4/ch_ipsec: fix potential use-after-free in
ch_ipsec_xfrm_add_state() callback

Peter Wang (1):
      scsi: ufs: core: Fix error handler host_sem issue

Peter Zijlstra (1):
      x86/build: Disable SSE4a

Petr Oros (3):
      tools: ynl: fix string attribute length to include null terminator
      dpll: spec: add missing module-name and clock-id to pin-get reply
      dpll: fix device-id-get and pin-id-get to return errors properly

Philipp Stanner (2):
      drm/sched: Fix race in drm_sched_entity_select_rq()
      drm/nouveau: Fix race in nouveau_sched_fini()

Po-Hsu Lin (1):
      selftests: net: use BASH for bareudp testing

Punit Agrawal (1):
      ACPI: SPCR: Check for table version when using precise baudrate

Puranjay Mohan (1):
      bpf/arm64: Fix BPF_ST into arena memory

Qianchang Zhao (1):
      ksmbd: transport_ipc: validate payload size before reading handle

Quanmin Yan (1):
      fbcon: Set fb_display[i]->mode to NULL when the mode is released

Rae Moar (1):
      MAINTAINERS: Update KUnit email address for Rae Moar

Rafael J. Wysocki (2):
      cpuidle: governors: menu: Select polling state in some more cases
      PM: sleep: Allow pm_restrict_gfp_mask() stacking

Rafa=C5=82 Mi=C5=82ecki (1):
      bcma: don't register devices disabled in OF

Rameshkumar Sundaram (1):
      wifi: ath11k: avoid bit operation on key flags

Ranganath V N (1):
      net: sctp: fix KMSAN uninit-value in sctp_inq_pop

Richard Fitzgerald (1):
      ASoC: cs-amp-lib-test: Fix missing include of kunit/test-bug.h

Rob Clark (4):
      drm/msm: Fix GEM free for imported dma-bufs
      drm/msm: Fix pgtable prealloc error path
      drm/msm: Reject MAP_NULL op if no PRR
      drm/msm: Ensure vm is created in VM_BIND ioctl

Rohan G Thomas (3):
      net: stmmac: vlan: Disable 802.1AD tag insertion offload
      net: stmmac: Consider Tx VLAN offload tag length for maxSDU
      net: stmmac: est: Fix GCL bounds checks

Roy Vegard Ovesen (2):
      ALSA: usb-audio: fix control pipe direction
      ALSA: usb-audio: don't log messages meant for 1810c when
initializing 1824c

Samuel Wu (1):
      Revert "PM: sleep: Make pm_wakeup_clear() call more clear"

Sebastian Fleer (1):
      drm/panel: kingdisplay-kd097d04: Disable EoTp

Sebastian Reichel (1):
      drm/panel: sitronix-st7789v: fix sync flags for t28cp45tn89

Shahar Shitrit (3):
      net: tls: Change async resync helpers argument
      net: tls: Cancel RX async resync request on rcd_delta overflow
      net/mlx5e: kTLS, Cancel RX async resync request in error flows

Sharique Mohammad (1):
      ASOC: max98090/91: fix for filter configuration: AHPF removed
DMIC2_HPF added

Shawn Guo (1):
      regmap: irq: Correct documentation of wake_invert flag

Shengjiu Wang (2):
      ASoC: fsl_sai: fix bit order for DSD format
      ASoC: fsl_micfil: correct the endian format for DSD

Shivaji Kant (1):
      net: devmem: refresh devmem TX dst in case of route invalidation

Shuming Fan (2):
      ASoC: sdw_utils: add name_prefix for rt1321 part id
      ASoC: rt721: fix prepare clock stop failed

Sidharth Seela (1):
      selftests: cachestat: Fix warning on declaration under label

Simon Trimmer (3):
      ASoC: cs530x: Correct log message with expected variable
      ASoC: amd: acp: Add ACP7.0 match entries for cs35l56 and cs42l43
      ASoC: Intel: soc-acpi-intel-ptl-match: Remove cs42l43 match from sdw =
link3

Srinivas Kandagatla (2):
      ASoC: qdsp6: q6asm: do not sleep while atomic
      ASoC: dt-bindings: pm4125-sdw: correct number of soundwire ports

Stefan Metzmacher (3):
      smb: server: call smb_direct_post_recv_credits() when the
negotiation is done
      smb: server: let smb_direct_cm_handler() call ib_drain_qp()
after smb_direct_disconnect_rdma_work()
      smb: client: call smbd_destroy() in the same splace as
kernel_sock_shutdown()/sock_release()

Steve French (1):
      cifs: fix typo in enable_gcm_256 module parameter

Sven Eckelmann (1):
      batman-adv: Release references to inactive interfaces

Tejun Heo (3):
      sched_ext: Mark scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU
      sched_ext: Sync error_irq_work before freeing scx_sched
      sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()

Thanh Quan (1):
      net: phy: dp83869: fix STRAP_OPMODE bitmask

Thomas Hellstr=C3=B6m (1):
      drm/xe: Fix uninitialized return value from xe_validation_guard()

Thomas Zimmermann (2):
      drm/sysfb: Do not dereference NULL pointer in plane reset
      drm/ast: Clear preserved bits from register output value

Tomeu Vizoso (1):
      drm/etnaviv: fix flush sequence logic

Tony Luck (2):
      ACPI: MRRM: Check revision of MRRM table
      x86/cpu: Add/fix core comments for {Panther,Nova} Lake

Vignesh Raman (1):
      drm/ci: disable broken MR check in sanity job

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/dmc: Clear HRR EVT_CTL/HTP to zero on ADL-S

Vladimir Lypak (6):
      drm/msm/dpu: Fix allocation of RGB SSPPs without scaling
      drm/msm/dpu: Propagate error from dpu_assign_plane_resources
      drm/msm/dpu: Disable scaling for unsupported scaler types
      drm/msm/dpu: Fix pixel extension sub-sampling
      drm/msm/dpu: Require linear modifier for writeback framebuffers
      drm/msm/dpu: Disable broken YUV on QSEED2 hardware

Wonkon Kim (2):
      scsi: ufs: core: Initialize value of an attribute returned by uic cmd
      scsi: ufs: core: Declare tx_lanes witout initialization

Yang Wang (1):
      drm/amd/pm: fix smu table id bound check issue in smu_cmn_update_tabl=
e()

Yonghong Song (1):
      bpf: Make migrate_disable always inline to avoid partial inlining

Yuhao Jiang (1):
      ACPI: video: Fix use-after-free in acpi_video_switch_brightness()

dongsheng (1):
      perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake

