Return-Path: <linux-kernel+bounces-804860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46AB48104
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B2274E14BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26863223DD4;
	Sun,  7 Sep 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ph+JUE6H"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C422258C
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283971; cv=none; b=tQW8awLxNUQLDTYTj+LHockpbGQRc1QX3N2+6C32uhNx6DoaM2lppO+9n8pJhsjuhOwUMQ5XXGONnqISG/+AuNEvVL9ZKmXcU9GE2g7UhJH+6EsOMVKYxaH7WJ5pvbAYZw6CA7oZ80Bbst6Gp76ZZbkuy79xHuo33qSLBko/4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283971; c=relaxed/simple;
	bh=fxpqjk8mbcle3tPCazvjx+VyP+aL0OZO3EGDkqavAmo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BtNWdWVwRJnz0RM4x8tT9du8S4ZAbefinMkGploxc2YCWMBvMVDOfn/VQvwj3HCDTzPT4hSQj8Y9PpW/ZE8bBSLoWus+FsTIB++xJNgDHciLfixcchUyUIapog9iuJQKazMkWgpFzBRAVptn0Vp3QK9q4LHcmp1DS2I3N+tLJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ph+JUE6H; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0411b83aafso646309766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757283966; x=1757888766; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhqRwH8ljWnARWY/qODK0eMC2ON2oflrFXNR2rr/S4E=;
        b=Ph+JUE6HBjxkWYw/eNyllI0dqcuGWkUEn+ypt5GsBRLFYcnJE7YV/DH4XLqr7YZfvy
         KZAJ6PtUXNG/PG64qw5KYoGT/uv5CcPtJqyKwgu7yY9jNxYK3t6KLstgLzRWuXbk9HJN
         Nd6vKmx0v1gh+UmSlnlwgP9mznL53uyD6gBJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757283966; x=1757888766;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhqRwH8ljWnARWY/qODK0eMC2ON2oflrFXNR2rr/S4E=;
        b=dJVa04Jn4Q/13O/iuyOYQ8mY+CebZFqM8MT4Zdyqzk3H8lrRqvG3ZEBMjbhyWKwTpK
         +d2QhuB9s6wQfndxelNn/1+Fk8xEbYSLxbBvzTr0BjlZ2pFNyYqNfImaRu66U1VH1Nvw
         r+M6NbdgVi0OelXfqDH+AKcvaxBxSrP578BTD92ffK8ib29o6drNaq4U72+G1HHNzcY3
         kEtgzH1UGzLj8iGymll+ZjxxtMNEhUFw04jxOFQCE18x+o+Asg21cSO8BY2eD1yQvNkh
         tVb/V2hKUA3u5ZTA9QwFWUWswa6cF/3wDXx29ACS0uphrCqDacluBIqaiHzHoVB3eg0k
         +jMA==
X-Gm-Message-State: AOJu0YyDn5pqVzVlBUAhSgkAXKJ2zjsgJdpVl76CpLjKdZev/pnCLcI2
	rAkGdjkaBoNgtubGYN/vbD8wev8BwtaSH1VKWVd+xbgDZTepH/rN0y+aZcG1nWMtog5x8lPq7fo
	4+HNxyuY=
X-Gm-Gg: ASbGncsU30lXCPwO7qI+iOo2zuO2XOPFmwTdRdiBSy7yWyaofT/cK9sKysnclnOGgHC
	qLjVvFsL6Xn0puCKDUGxrfy0BVjutyGOWTJDKOPZrYiNJRpmxx1Lk4n2UbSAw8XlbjumvWNtou1
	YfJUtM+0uJsrR2AIaWsak8y3IC406a9znm2GFNGU0M7DxCPG+5JaY5c/jo77aEUc+l7cF98gknr
	rZ5RA+P8rwn09yaI7UstU6hhWfqiFbi8ZtH9vZU0n2QyfAoH87YtzOSo6QX2MGUTaqqAqAzfqeL
	rFEwjLXRtKlI4SUZG6acbw+eHu6I5jF1nvRojf0hvLyDUVEIm+sNdmeafoZkyT4777mcVHY9k4d
	Ll5EIuT2aYTqFPD/WQT3NhZMbHrDxaaDhL+tJ/aI1O4Q00Ml9upFDp5ww3kcbOafrv5XDnW6KZx
	E9LWEuxiw=
X-Google-Smtp-Source: AGHT+IG6etFM5XS9Ko0O/6cdxgp5z94cHKgAWyLXIY5FzG7Cd0L6vv7T8M30ilNL2jnnYHXDTHp5AA==
X-Received: by 2002:a17:907:6e92:b0:b04:54dc:3048 with SMTP id a640c23a62f3a-b04b148f4damr577813666b.21.1757283966207;
        Sun, 07 Sep 2025 15:26:06 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0d9b1b53sm2253190466b.96.2025.09.07.15.26.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:26:05 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso5806530a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 15:26:05 -0700 (PDT)
X-Received: by 2002:a05:6402:278f:b0:61e:ae59:5eff with SMTP id
 4fb4d7f45d1cf-6237abde395mr5988044a12.5.1757283964470; Sun, 07 Sep 2025
 15:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Sep 2025 15:25:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
X-Gm-Features: Ac12FXxtbbOxcNUTTeBDihuDmADbctnGpA8zqv3b-HwBWZEbvL6M8gbMC46H3ts
Message-ID: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
Subject: Linux 6.17-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Things remain normal - both the diffstat and the commit counts look
entirely sane. I'd claim that it's all small patches, but we do have
one larger one: the DLink/Sundance driver was resurrected, so in
between all the one- and few-liners, there's a revert that brings back
2k lines in the form that driver.

But if you ignore that one-off oddity, the rest is very much normal.
As usual, it's half drivers (networking, gpu and sound stand out,
although there's also some unusual pcmcia noise in the form of dead
code removal).

The rest mostly is a mix of tooling (perf and selftests), some random
filesystem, architecture and mm fixes. And other smaller stuff.

Nothing particular to report, the shortlog below gives some rough idea
of what's been going on if you care for details.

The one discussion that I was part of that happened last week that
might be worth mentioning is that I've been complaining for years
about useless "Link:" entries in commit messages that don't point to
any new information. When I merge things and note something
questionable and start digging deeper in order to understand what's
going on, one of the things I do is follow links. And if that link
ends up being just a pointer to the email that became that commit -
with nothing else - that allegedly helpful link only added human cost
for me.

The same ends up being true when chasing down bug reports.

So please: don't add useless information to commits in general, but in
_particular_ don't add "Link:" tags that only point back to the
original submission email. Yes, we have tooling that does it
automatically, but tooling should not be used to increase the human
burden. Tooling should _help_, not hurt.

Make the links be something *useful*. Make them point to the report
for the bug that was the cause of the commit. Make them point to the
discussion that explains the impetus for the commit. But do *not*
mindlessly just use tooling to create a link that doesn't add anything
that isn't already right there in the commit.

I realize that people think the link makes the commit look more "real"
or whatever. And I've heard people claim that discussion happens later
in the thread that the link points to. Neither of those are actually
true. When bugs happen, people don't go to the original emailed patch
to talk about them. Much of the time the reporter can't even tell
which patch caused it - and if they did bisect it, we already have the
information - there's no value add in going back to the original
emailed patch.

So if a link doesn't have any extra relevant information in it, just
don't add it at all in some misguided hope that tomorrow it will be
useful.

Make "Link:" tags be something to celebrate, not something to curse
because they are worthless and waste peoples time.

Please?

            Linus

---

Aaron Erhardt (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6[AF]R5xxY

Abin Joseph (1):
      net: xilinx: axienet: Add error handling for RX metadata pointer retr=
ieval

Ada Couprie Diaz (1):
      kasan: fix GCC mem-intrinsic prefix with sw tags

Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: avoid buffer overflow in WID string configuration

Ajye Huang (1):
      ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for FLYPRO copper SFP+ module

Alex Deucher (2):
      drm/amdgpu/mes11: make MES_MISC_OP_CHANGE_CONFIG failure non-fatal
      drm/amdgpu: drop hw access in non-DC audio fini

Alexander Gordeev (2):
      mm/kasan: fix vmalloc shadow memory (de-)population races
      mm/kasan: avoid lazy MMU mode hazards

Alexandre Ghiti (2):
      riscv: Fix sparse warning in __get_user_error()
      riscv: Fix sparse warning about different address spaces

Alice Ryhl (1):
      rust: use the new name Location::file_as_c_str() in Rust >=3D 1.91.0

Alok Tiwari (4):
      xirc2ps_cs: fix register access when enabling FullDuplex
      bnxt_en: fix incorrect page count in RX aggr ring log
      ixgbe: fix incorrect map used in eee linkmode
      mctp: return -ENOPROTOOPT for unknown getsockopt options

Antheas Kapenekakis (2):
      platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk
      platform/x86: asus-wmi: Fix ROG button mapping, tablet mode on
ASUS ROG Z13

Anton Khirnov (1):
      platform/x86: asus-wmi: map more keys on ExpertBook B9

Anup Patel (1):
      ACPI: RISC-V: Fix FFH_CPPC_CSR error handling

Armin Wolf (1):
      platform/x86: acer-wmi: Stop using ACPI bitmap for platform
profile choices

Arnd Bergmann (2):
      wifi: rt2800: select CONFIG_RT2X00_LIB as needed
      wifi: rt2x00: fix CRC_CCITT dependency

Asbj=C3=B8rn Sloth T=C3=B8nnesen (1):
      tools: ynl-gen: fix nested array counting

Aurelien Jarno (1):
      riscv: uaccess: fix __put_user_nocheck for unaligned accesses

Bagas Sanjaya (1):
      pcmcia: ds: Emphasize "really" epizeuxis

Baptiste Lepers (1):
      rust: mm: mark VmaNew as transparent

Bartosz Golaszewski (1):
      gpio: fix GPIO submenu in Kconfig

Benjamin Berg (1):
      wifi: mac80211: do not permit 40 MHz EHT operation on 5/6 GHz

Bharath SM (3):
      smb: client: fix spellings in comments
      smb: client: add new tracepoint to trace lease break notification
      smb: client: show negotiated cipher in DebugData

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Brady Norander (1):
      ALSA: hda: intel-dsp-config: Select SOF driver on MTL Chromebooks

Breno Leitao (1):
      riscv: kexec: Initialize kexec_buf struct

Brian Mak (1):
      kexec: add KEXEC_FILE_NO_CMA as a legal flag

Chad Monroe (1):
      wifi: mt76: mt7996: use the correct vif link for scanning/roc

Chen Ni (1):
      pcmcia: omap: Add missing check for platform_get_resource

Chen-Yu Tsai (1):
      arm64: dts: rockchip: Add supplies for eMMC on rk3588-orangepi-5

Chiasheng Lee (1):
      i2c: i801: Hide Intel Birch Stream SoC TCO WDT

Chris Packham (1):
      hwmon: (ina238) Correctly clamp temperature

Christian Loehle (1):
      sched: Fix sched_numa_find_nth_cpu() if mask offline

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious
8042 quirks list

Christoph Hellwig (1):
      nvme: fix PI insert on write

Christoph Paasch (1):
      net/tcp: Fix socket memory leak in TCP-AO failure handling for IPv6

Chukun Pan (1):
      arm64: dts: rockchip: mark eeprom as read-only for Radxa E52C

Colin Ian King (1):
      drm/amd/amdgpu: Fix missing error return on kzalloc failure

Conor Dooley (1):
      spi: microchip-core-qspi: stop checking viability of
op->max_freq in supports_op callback

Cryolitia PukNgae (4):
      ALSA: usb-audio: Add mute TLV for playback volumes on some devices
      ASoC: codecs: idt821034: fix wrong log in
idt821034_chip_direction_output()
      ALSA: usb-audio: move mixer_quirks' min_mute into common quirk
      ALSA: docs: Add documents for recently changes in snd-usb-audio

Dan Carpenter (4):
      wifi: cw1200: cap SSID length in cw1200_do_join()
      wifi: libertas: cap SSID len in lbs_associate()
      wifi: cfg80211: sme: cap SSID length in __cfg80211_connect_result()
      ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()

Daniel Dadap (1):
      ALSA: hda/hdmi: Restore missing HDMI codec entries

Dave Airlie (1):
      nouveau: fix disabling the nonstall irq due to storm code

David Arcari (1):
      platform/x86/intel: power-domains: Use
topology_logical_package_id() for package ID

Dmitry Antipov (1):
      wifi: cfg80211: fix use-after-free in cmp_bss()

Dr. David Alan Gilbert (1):
      pcmcia: cs: Remove unused pcmcia_get_socket_by_nr

Duoming Zhou (2):
      wifi: brcmfmac: fix use-after-free when rescheduling
brcmf_btcoex_info work
      ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog

Edip Hazuri (1):
      platform/x86: hp-wmi: Add support for Fn+P hotkey

Edward Adam Davis (1):
      ocfs2: prevent release journal inode after journal shutdown

Emil Tantilov (1):
      idpf: set mac type when adding and removing MAC filters

Emmanuel Grumbach (1):
      wifi: iwlwifi: if scratch is ~0U, consider it a failure

Eric Biggers (3):
      crypto: sha1 - Implement export_core() and import_core()
      crypto: sha256 - Implement export_core() and import_core()
      crypto: sha512 - Implement export_core() and import_core()

Eric Dumazet (3):
      net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=3Dy
      net: lockless sock_i_ino()
      ax25: properly unshare skbs in ax25_kiss_rcv()

Fabian Bl=C3=A4se (1):
      icmp: fix icmp_ndo_send address translation for reply direction

Faith Ekstrand (1):
      nouveau: Membar before between semaphore writes and the interrupt

Felix Fietkau (9):
      wifi: mt76: prevent non-offchannel mgmt tx during scan/roc
      wifi: mt76: mt7996: disable beacons when going offchannel
      wifi: mt76: mt7996: fix crash on some tx status reports
      wifi: mt76: do not add non-sta wcid entries to the poll list
      wifi: mt76: mt7996: add missing check for rx wcid entries
      wifi: mt76: mt7915: fix list corruption after hardware restart
      wifi: mt76: free pending offchannel tx frames on wcid cleanup
      wifi: mt76: fix linked list corruption
      net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets

Filipe Manana (6):
      btrfs: abort transaction on failure to add link to inode
      btrfs: fix inode leak on failure to add link to inode
      btrfs: simplify error handling logic for btrfs_link()
      btrfs: fix race between logging inode and checking if it was logged b=
efore
      btrfs: fix race between setting last_dir_index_offset and inode loggi=
ng
      btrfs: avoid load/store tearing races when checking if an inode was l=
ogged

Florian Westphal (2):
      netfilter: nft_flowtable.sh: re-run with random mtu sizes
      selftests: netfilter: fix udpclash tool hang

Gabor Juhos (1):
      spi: spi-qpic-snand: unregister ECC engine on probe error and
device remove

Geert Uytterhoeven (1):
      pcmcia: omap_cf: Mark driver struct with __refdata to prevent
section mismatch

Gergo Koteles (2):
      ALSA: hda: tas2781: fix tas2563 EFI data endianness
      ALSA: hda: tas2781: reorder tas2563 calibration variables

Gu Bowen (1):
      mm: fix possible deadlock in kmemleak

Guenter Roeck (2):
      hwmon: (ina238) Correctly clamp shunt voltage limit
      hwmon: (ina238) Correctly clamp power limits

Haibo Chen (1):
      arm64: dts: imx95-19x19-evk: correct the phy setting for flexcan1/2

Harry Yoo (3):
      mm: move page table sync declarations to linux/pgtable.h
      mm: introduce and use {pgd,p4d}_populate_kernel()
      x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and
arch_sync_kernel_mappings()

Harshit Mogalapalli (1):
      wifi: mt76: mt7925: fix locking in mt7925_change_vif_links()

Harshit Shah (1):
      arm64: dts: axiado: Add missing UART aliases

Horatiu Vultur (1):
      phy: mscc: Stop taking ts_lock for tx_queue and use its own lock

Ian Rogers (4):
      perf bpf-event: Fix use-after-free in synthesis
      perf bpf-utils: Constify bpil_array_desc
      perf bpf-utils: Harden get_bpf_prog_info_linear
      perf symbol-elf: Add support for the block argument for libbfd

Ido Schimmel (3):
      vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
      vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects
      selftests: net: Add a selftest for VXLAN with FDB nexthop groups

Ivan Lipski (1):
      drm/amd/display: Clear the CUR_ENABLE register on DCN314 w/out DPP PG

Ivan Pravdin (1):
      Bluetooth: vhci: Prevent use-after-free by removing debugfs files ear=
ly

Jacob Keller (3):
      ice: fix NULL access of tx->in_use in ice_ptp_ts_irq
      ice: fix NULL access of tx->in_use in ice_ll_ts_intr
      i40e: remove read access to debugfs files

Jakub Kicinski (4):
      selftests: drv-net: csum: fix interface name for remote host
      Revert "eth: remove the DLink/Sundance (ST201) driver"
      eth: sundance: fix endian issues
      MAINTAINERS: add Sabrina to TLS maintainers

James Clark (4):
      spi: spi-fsl-lpspi: Constify devtype datas
      spi: spi-fsl-lpspi: Treat prescale_max =3D=3D 0 as no erratum
      spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware
      perf tests: Fix "PE file support" test build

James Jones (1):
      MAINTAINERS: Update git entry for nouveau

Janusz Dziedzic (1):
      wifi: mt76: mt7921: don't disconnect when CSA to DFS chan

Jeremy Kerr (2):
      net: mctp: mctp_fraq_queue should take ownership of passed skb
      net: mctp: usb: initialise mac header in RX path

Jeroen de Borst (1):
      gve: update MAINTAINERS

Jesse.Zhang (1):
      drm/amdgpu/sdma: bump firmware version checks for user queue support

Johannes Berg (5):
      wifi: iwlwifi: acpi: check DSM func validity
      wifi: iwlwifi: uefi: check DSM item validity
      wifi: iwlwifi: cfg: restore some 1000 series configs
      wifi: iwlwifi: fix byte count table for old devices
      wifi: iwlwifi: cfg: add back more lost PCI IDs

John Evans (1):
      scsi: lpfc: Fix buffer free/clear order in deferred receive path

Jonas Jelonek (3):
      i2c: rtl9300: fix channel number bound check
      i2c: rtl9300: ensure data length is within supported range
      i2c: rtl9300: remove broken SMBus Quick operation support

Joshua Hay (1):
      idpf: fix UAF in RDMA core aux dev deinitialization

Kaison Deng (1):
      arm64: dts: rockchip: fix es8388 address on rk3588s-roc-pc

Kan Liang (1):
      perf: Fix the POLL_HUP delivery breakage

Karol Wachowski (1):
      accel/ivpu: Prevent recovery work from being queued during device rem=
oval

Khairul Anuar Romli (1):
      spi: cadence-quadspi: Implement refcount to handle unbind during busy

Kohei Enju (1):
      docs: remove obsolete description about threaded NAPI

Krzysztof Kozlowski (3):
      ARM: dts: rockchip: Minor whitespace cleanup
      arm64: dts: rockchip: Minor whitespace cleanup
      arm64: dts: rockchip: Fix Bluetooth interrupts flag on Neardi LBA3368

Kuninori Morimoto (3):
      ASoC: soc-core: care NULL dirver name on
snd_soc_lookup_component_nolocked()
      ASoC: soc-core: tidyup snd_soc_lookup_component_nolocked()
      ASoC: rsnd: tidyup direction name on rsnd_dai_connect()

Kuniyuki Iwashima (2):
      Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
      selftest: net: Fix weird setsockopt() in bind_bhash.c.

Lachlan Hodges (1):
      wifi: mac80211: increase scan_ies_len for S1G

Lad Prabhakar (1):
      net: pcs: rzn1-miic: Correct MODCTRL register offset

Larisa Grigore (6):
      spi: spi-fsl-lpspi: Fix transmissions when using CONT
      spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
      spi: spi-fsl-lpspi: Clear status register after disabling the module
      dt-bindings: lpspi: Document support for S32G
      spi: spi-fsl-lpspi: Add compatible for S32G

Li Nan (1):
      md: prevent incorrect update of resync/recovery offset

Li Qiong (1):
      mm/slub: avoid accessing metadata when pointer is invalid in object_e=
rr()

Li Yifan (1):
      platform/x86/intel/pmc: Add Bartlett Lake support to intel_pmc_core

Liao Yuanhong (1):
      wifi: mac80211: fix incorrect type for ret

Linus Torvalds (1):
      Linux 6.17-rc5

Liu Jian (1):
      net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()

Lukas Bulwahn (1):
      pcmcia: remove PCCARD_IODYN

Ma Ke (1):
      pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()

Mahanta Jambigi (1):
      net/smc: Remove validation of reserved bits in CLC Decline message

Makar Semyonov (1):
      cifs: prevent NULL pointer dereference in UTF16 conversion

Marek Vasut (3):
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on DH
electronics i.MX8M Plus DHCOM
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on Data Modul
i.MX8M Plus eDM SBC
      arm64: dts: imx95: Fix JPEG encoder node assigned clock

Mario Limonciello (1):
      drm/amd: Re-enable common modes for eDP and LVDS

Markus Niebel (2):
      arm64: dts: imx8mp-tqma8mpql: fix LDO5 power off
      arm64: dts: imx8mp-tqma8mpql: remove virtual 3.3V regulator

Maud Spierings (1):
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5 p=
lus

Miaoqian Lin (4):
      mISDN: Fix memory leak in dsp_hwec_enable()
      eth: mlx4: Fix IS_ERR() vs NULL check bug in mlx4_en_create_rx_ring
      net: dsa: mv88e6xxx: Fix fwnode reference leaks in
mv88e6xxx_port_setup_leds
      ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()

Michael Walle (1):
      drm/bridge: ti-sn65dsi86: fix REFCLK setting

Miguel Ojeda (1):
      rust: support Rust >=3D 1.91.0 target spec

Ming Lei (1):
      scsi: sr: Reinstate rotational media flag

Ming Yen Hsieh (3):
      wifi: mt76: mt7925: fix the wrong bss cleanup for SAP
      wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete
      wifi: mt76: mt7925: skip EHT MLD TLV on non-MLD and pass
conn_state for sta_cmd

Nathan Chancellor (2):
      wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()
      riscv: Only allow LTO with CMODEL_MEDANY

Nicolas Frattaroli (2):
      arm64: dts: rockchip: fix USB on RADXA ROCK 5T
      arm64: dts: rockchip: fix second M.2 slot on ROCK 5T

Nishanth Menon (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix null pointer dereference for n=
dev

Nobuhiro Iwamatsu (1):
      MAINTAINERS: Update Nobuhiro Iwamatsu's email address

Pei Xiao (2):
      tee: fix NULL pointer dereference in tee_shm_put
      tee: fix memory leak in tee_dyn_shm_alloc_helper

Peter Robinson (2):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3399-pinebook-=
pro
      arm64: dts: rockchip: Add vcc-supply to SPI flash on Pinephone Pro

Phil Sutter (2):
      netfilter: conntrack: helper: Replace -EEXIST by -EBUSY
      netfilter: nf_tables: Introduce NFTA_DEVICE_PREFIX

Philipp Kerling (1):
      ksmbd: allow a filename to contain colons on SMB3.1.1 posix extension=
s

Pierre-Eric Pelloux-Prayer (1):
      drm/sched: Fix racy access to drm_sched_entity.dependency

Qianfeng Rong (1):
      wifi: mwifiex: Initialize the chan_stats array to zero

Qingfang Deng (1):
      ppp: fix memory leak in pad_compress_skb

Quanmin Yan (1):
      mm/damon/core: prevent unnecessary overflow in damos_set_effective_qu=
ota()

Radim Kr=C4=8Dm=C3=A1=C5=99 (4):
      riscv: use lw when reading int cpu in new_vmalloc_check
      riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
      riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id
      riscv: use lw when reading int cpu in asm_per_cpu

Rameshkumar Sundaram (1):
      wifi: ath11k: fix group data packet drops during rekey

Ramya Gnanasekar (1):
      wifi: ath12k: Set EMLSR support flag in MLO flags for EML-capable sta=
tions

Robert Marko (1):
      ARM: at91: select ARCH_MICROCHIP

Rosen Penev (2):
      net: thunder_bgx: add a missing of_node_put
      net: thunder_bgx: decrement cleanup index before use

Russell King (Oracle) (4):
      net: phy: add phy_interface_weight()
      net: phylink: provide phylink_get_inband_type()
      net: phylink: disable autoneg for interfaces that have no inband
      net: phylink: move PHY interrupt request to non-fail path

Ryan Wanner (1):
      ARM: dts: microchip: sama7d65: Force SDMMC Legacy mode

Sabrina Dubroca (1):
      macsec: read MACSEC_SA_ATTR_PN with nla_get_uint

Salah Triki (1):
      EDAC/altera: Delete an inappropriate dma_free_coherent() call

Sasha Levin (1):
      mm/userfaultfd: fix kmap_local LIFO ordering for CONFIG_HIGHPTE

Sean Anderson (1):
      net: macb: Fix tx_ptr_lock locking

Sebastian Andrzej Siewior (1):
      futex: Move futex_hash_free() back to __mmput()

Sebastian Reichel (2):
      arm64: dts: rockchip: correct network description on Sige5
      MAINTAINERS: exclude defconfig from ARM64 PORT

Shenghao Ding (1):
      ALSA: hda/tas2781: Fix EFI name for calibration beginning with 1
instead of 0

Stanislav Fort (2):
      batman-adv: fix OOB read/write in network-coding decode
      audit: fix out-of-bounds read in audit_compare_dname_path()

Stefan Wahren (3):
      net: ethernet: oa_tc6: Handle failure of spi_setup
      microchip: lan865x: Fix module autoloading
      microchip: lan865x: Fix LAN8651 autoloading

Sumanth Korikkar (1):
      mm: fix accounting of memmap pages

Sungbae Yoo (1):
      tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"

Takashi Iwai (3):
      platform/x86: asus-wmi: Fix racy registrations
      ALSA: hda: Avoid binding with SOF for SKL/KBL platforms
      ALSA: hda/hdmi: Add pin fix for another HP EliteDesk 800 G4 model

Takashi Sakamoto (1):
      ALSA: firewire-motu: drop EPOLLOUT from poll return values as
write is not supported

Thomas Hellstr=C3=B6m (1):
      drm/xe: Fix incorrect migration of backed-up object to VRAM

Thomas Richter (1):
      perf test: Checking BPF metadata collection fails on version string

Thomas Wei=C3=9Fschuh (2):
      vdso/vsyscall: Avoid slow division loop in auxiliary clock update
      arm64: uapi: Provide correct __BITS_PER_LONG for the compat vDSO

Thorsten Blum (1):
      pcmcia: Use str_off_on() and str_yes_no() helpers

Tina Wuest (1):
      ALSA: usb-audio: Allow Focusrite devices to use low samplerates

Vadim Pasternak (1):
      hwmon: mlxreg-fan: Prevent fans from getting stuck at 0 RPM

Vitaly Lifshits (1):
      e1000e: fix heap overflow in e1000_set_eeprom

Wang Liang (2):
      netfilter: br_netfilter: do not check confirmed bit in
br_nf_local_in() after confirm
      net: atm: fix memory leak in atm_register_sysfs when device_register =
fail

Wang Zhaolong (1):
      smb: client: Fix NULL pointer dereference in cifs_debug_dirs_proc_sho=
w()

Wentao Liang (1):
      pcmcia: Add error handling for add_interval() in do_validate_mem()

Yeoreum Yun (1):
      kunit: kasan_test: disable fortify string checker on kasan_strings() =
test

Yin Tirui (1):
      of_numa: fix uninitialized memory nodes causing kernel panic

Yu Kuai (1):
      md/raid1: fix data lost for writemostly rdev

Yue Haibing (1):
      ipv6: annotate data-races around devconf->rpl_seg_enabled

Zhen Ni (2):
      platform/x86/amd: hfi: Fix pcct_tbl leak in amd_hfi_metadata_parser()
      i40e: Fix potential invalid access when MAC list is empty

Zi Yan (1):
      selftests/mm: fix FORCE_READ to read input value correctly

panfan (1):
      arm64: ftrace: fix unreachable PLT for ftrace_caller in
init_module with CONFIG_DYNAMIC_FTRACE

qaqland (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on more devices

wangzijie (1):
      proc: fix missing pde_set_flags() for net proc files

yangshiguang (1):
      mm: slub: avoid wake up kswapd in set_track_prepare

zhang jiao (1):
      tools: gpio: remove the include directory on make clean

