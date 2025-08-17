Return-Path: <linux-kernel+bounces-772650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286BB295A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F2E2026E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83C136358;
	Sun, 17 Aug 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WUz8L9Pn"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF63176F1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755471684; cv=none; b=us2xLRp3Qivhml31WxPAWP/yX2eahPUyCnIpzlPnjXsDerUYc3ycMVKD5S0nDQ5JTqwo+HtyzX0KVyhhMalGFIvl/LCgN+y4Ywfe8PFAS7p1UxSreuoQPH4hcikfgZzP5DTzcnMgwTkNSUuj+xWEpLxmI0cgr6u5+dBDVQGH/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755471684; c=relaxed/simple;
	bh=Fn4C4wXPrkcXJRy0T94ibXqlhbchhBNDB7NSq25GYB0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dcLujVPoUMEumPUw8x+A8Cbxv5U46Q940/L9DtyOfg6exAA/xKPDlzio0NHGGxuftc5yFQbX0GCDLokC7vHwcl+8pK7MXDBoBvxFv8uZfnccH+ZAYoHuXrrZNlBRB/GX3v6QmxGhchxHEa7jMN838A74ed6uHhjYRQa7qCaUWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WUz8L9Pn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78da8a7so576267966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755471679; x=1756076479; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4emL4sl8it/o7ZuzgRaLQHdjwzQ9s3HbLDKZ6uMKxc0=;
        b=WUz8L9PnnQMcbSgDq6/7QvYKIB7H4e3b3wg7Zryx0G/gRF7+sAlpG91xHKNqaoTxHq
         0EnjBaSOiGfMcuZ908SrDSJPHkSxWSATE+n7c1wRupMAxl6luCUdTPiOJZv/qIM4wpTh
         V2nf7vUOiiQyj8uyX/mEtzT97nnG2hInALlPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755471679; x=1756076479;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4emL4sl8it/o7ZuzgRaLQHdjwzQ9s3HbLDKZ6uMKxc0=;
        b=hQvF1EjNFQ76PZ4f4KyYnJtTh2mzoq2sZcnXXPg5nl10J8vC0HY5CxdCK9J8vlQeMq
         tGtoz7F3TprhiCrqrr9bDwBcxpqPz7YTeeIv3WJglnTc2oy1Hp36ZfMrRZHTwtsxzMjZ
         ycpeD2n1AlO83hDs/U1l1/VXz+Bvre5OugBAqLrHdkz8NWr9/e0GT7IGy8oIS9fCdpmH
         p8XyGaXjGx7FA3pCze9IOgEZMhKD5GNUjQE72IJ0V+8j+bglgttCMxgZDynIfYWxsrkm
         cbf5oUM5qZMwOPb7r2qogjFvmjImzxnch5Llah07QLRiPEfUl7SaB+7j1vu1luuF+W8t
         m0aQ==
X-Gm-Message-State: AOJu0YxQKWymSbGIsRh0kBlGmdu5VO1rmS0NGgjDOYEOnJEeYnAvjl49
	ge3AZJv2MUiw5lnnRjIdUxTrMULCfnWFEflRMa10Qu5VJN8eLY4BRScX4eGQiYhU+oN4RN4wIg3
	7eTd4Ggo=
X-Gm-Gg: ASbGncs8/ln3uRwW+xqLxDmCSuFtfo3wtu6Z83IvjP3qLqSTHCHDiuw65lJIMlR1oIt
	OHpu9y7jcfu0a1TYo9esJTNN6fIUNFxvZ6FGk54ujoR5vXbTnH/Itiyi2D+n3PiP5GcsgbZZKhU
	gRpgXfKGo0R7o9SIjTPM1PW9VyO95RlfeNgiVZEOg8FqrXqGbiTBImy+s2VGAIqrqbcSPXhijuo
	FCvmLRPGxnYBoaLwTKgGfk82Qb9GNwn7N+cMAlMMnYbll0PA9mEujFnFSsjB1KVrvthoDlo3pGb
	X59SBV/PaHKTzu7btf9mJCcHP6JZO8co5KqiWDzbb9Hw2eEb1xWjQZO7TDDKk1DqdnHPBDEz/bl
	/lM4ARt3ZDX3TdBvVyAFHMP4OcYuD1qhEpmsn9V1XdQor6zlIzN5AkOOYHwPnrVJqTUzWng51Ti
	HKzSJbXv0=
X-Google-Smtp-Source: AGHT+IG1/WjSvmabpzTQAQ312dJv7/RgELr+TIv3E4YtiEIQbeT29bjhJ789/gZoPo+qlMnlSbi1TQ==
X-Received: by 2002:a17:907:2d1e:b0:af9:b1c7:844d with SMTP id a640c23a62f3a-afcdc412874mr908772066b.52.1755471678915;
        Sun, 17 Aug 2025 16:01:18 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce9edbesm670065566b.58.2025.08.17.16.01.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 16:01:18 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-619ff42ae79so2083883a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 16:01:18 -0700 (PDT)
X-Received: by 2002:a05:6402:2686:b0:618:6af8:3f71 with SMTP id
 4fb4d7f45d1cf-618b05322cfmr7042205a12.9.1755471676844; Sun, 17 Aug 2025
 16:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Aug 2025 16:01:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLHgdvJQkEW-pHcUuXOBJ9JOoKcZkzMaPSW60_-Mh90A@mail.gmail.com>
X-Gm-Features: Ac12FXwi3VdbKIYkK85D8-V39loWQ1nLj5IytoYaIsrQkIJisM4Ebs8k2fvWXK4
Message-ID: <CAHk-=wiLHgdvJQkEW-pHcUuXOBJ9JOoKcZkzMaPSW60_-Mh90A@mail.gmail.com>
Subject: Linux 6.17-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So it's been a very calm week, and this is one of the smaller rc2
releases we've had lately. I'm definitely not complaining, since I've
been jetlagged much of the week, but I have this suspicion that it
just means that next week will see more noise. And I'll be traveling
again later in the week.

But hey, let's not be pessimistic. Maybe rc2 is small because this
merge window just didn't have any real issues? Because that's bound to
happen _eventually_, right?  One day we're bound to hit that mythical
merge window that doesn't introduce any bugs at all.

This merge window wasn't _that_ good, but maybe it was simply better than m=
ost?

Or maybe it's that much of Europe is still on vacation because it's August?

Anyway, most of the fixes in rc2 were to drivers - particularly block
(although the biggest chunk of that was simply a removal of the drbd
page pool code). The rest is mostly gpu, networking driver, and sound
fixes. Some SCSI and firewire fixes too.

Outside of drivers, it's filesystems (smb, xfs, erofs, btrfs), core
networking (including some new selftests), and some architecture fixes
(mainly x86).

Other than that, minor random fixes. Shortlog appended.

Let's hope next week ends up as quiet. Wouldn't that be nice?

        Linus

---

Adri=C3=A1n Larumbe (1):
      drm/panfrost: Print RSS for tiler heap BO's in debugfs GEMS file

Ahmed S. Darwish (1):
      x86/cpuid: Remove transitional <asm/cpuid.h> header

Al Viro (1):
      habanalabs: fix UAF in export_dmabuf()

Alexey Klimov (1):
      ASoC: codecs: tx-macro: correct tx_macro_component_drv name

Alok Tiwari (1):
      net: ti: icss-iep: Fix incorrect type for return value in extts_enabl=
e()

Andrey Albershteyn (1):
      xfs: fix scrub trace with null pointer in quotacheck

Andy Yan (1):
      drm/bridge: Describe the newly introduced drm_connector
parameter for drm_bridge_detect

Armin Wolf (1):
      ACPI: EC: Relax sanity check of the ECDT ID string

Arnd Bergmann (1):
      netfilter: add back NETFILTER_XTABLES dependencies

Baojun Xu (2):
      ASoC: tas2781: Normalize the volume kcontrol name
      ALSA: hda/tas2781: Normalize the volume kcontrol name

Barry Song (1):
      mm: fix the race between collapse and PT_RECLAIM under per-vma lock

Boris Burkov (1):
      btrfs: fix iteration bug in __qgroup_excl_accounting()

Breno Leitao (1):
      mm/kmemleak: avoid deadlock by moving pr_warn() outside kmemleak_lock

Buday Csaba (1):
      net: mdiobus: release reset_gpio in mdiobus_unregister_device()

Budimir Markovic (1):
      vsock: Do not allow binding to VMADDR_PORT_ANY

Caleb Sander Mateos (1):
      ublk: check for unprivileged daemon on each I/O fetch

Christoph Hellwig (4):
      xfs: fix frozen file system assert in xfs_trans_alloc
      xfs: fully decouple XFS_IBULK* flags from XFS_IWALK* flags
      xfs: remove XFS_IBULK_SAME_AG
      xfs: split xfs_zone_record_blocks

Christopher Eby (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (AMD Ryzen AI 300) to quir=
ks

Clark Wang (1):
      net: phy: nxp-c45-tja11xx: fix the PHY ID mismatch issue when using C=
45

Colin Ian King (3):
      scsi: scsi_debug: Make read-only arrays static const
      ASoC: codec: sma1307: replace spelling mistake with new error message
      ASoC: tas2781: Fix spelling mistake "dismatch" -> "mismatch"

Damien Le Moal (2):
      scsi: core: sysfs: Correct sysfs attributes access rights
      ata: libata-eh: Fix link state check for IDE/PATA ports

Dan Carpenter (1):
      netfilter: conntrack: clean up returns in
nf_conntrack_log_invalid_sysctl()

Dave Hansen (4):
      MAINTAINERS: Mark Intel WWAN IOSM driver as orphaned
      MAINTAINERS: Mark Intel PTP DFL ToD as orphaned
      MAINTAINERS: Remove bouncing T7XX reviewer
      MAINTAINERS: Remove bouncing kprobes maintainer

David Howells (1):
      cifs: Fix collect_sample() to handle any iterator type

David Kaplan (1):
      x86/bugs: Select best SRSO mitigation

David Thompson (2):
      Revert "gpio: mlxbf3: only get IRQ for device instance 0"
      gpio: mlxbf3: use platform_get_irq_optional()

David Wei (1):
      bnxt: fill data page pool with frags if PAGE_SIZE > BNXT_RX_PAGE_SIZE

Davide Caratti (2):
      net/sched: ets: use old 'nbands' while purging unused classes
      selftests: net/forwarding: test purge of active DWRR classes

Dev Jain (1):
      mm: pass page directly instead of using folio_page

Dmitry Antipov (1):
      cifs: avoid extra calls to strlen() in cifs_get_spnego_key()

Dmitry Baryshkov (1):
      drm/bridge: document HDMI CEC callbacks

Erick Karanja (1):
      Docs: admin-guide: Correct spelling mistake

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio composition

Fengnan Chang (1):
      io_uring/io-wq: add check free worker before create new worker

Filipe Manana (1):
      btrfs: error on missing block group when unaccounting log tree
extent buffers

Florian Westphal (5):
      MAINTAINERS: resurrect my netfilter maintainer entry
      netfilter: ctnetlink: fix refcount leak on table dump
      netfilter: ctnetlink: remove refcounting in expectation dumpers
      netfilter: nft_set_pipapo: don't return bogus extension pointer
      netfilter: nft_set_pipapo: fix null deref for empty set

Frank Min (1):
      drm/amdgpu: Add PSP fw version check for fw reserve GFX command

Frederic Weisbecker (2):
      rcu: Fix racy re-initialization of irq_work causing hangs
      ipvs: Fix estimator kthreads preferred affinity

Fushuai Wang (1):
      x86/fpu: Fix NULL dereference in avx512_status()

Gao Xiang (1):
      erofs: fix block count report when 48-bit layout is on

Geert Uytterhoeven (1):
      erofs: Do not select tristate symbols from bool symbols

Haiyang Zhang (1):
      hv_netvsc: Fix panic during namespace deletion with VF

Igor Pylypiv (1):
      ata: libata-scsi: Fix CDL control

Imre Deak (3):
      drm/omap: Pass along the format info from .fb_create() to
drm_helper_mode_fill_fb_struct()
      drm/nouveau: Pass along the format info from .fb_create() to
drm_helper_mode_fill_fb_struct()
      drm/radeon: Pass along the format info from .fb_create() to
drm_helper_mode_fill_fb_struct()

Jack Xiao (1):
      drm/amdgpu: fix incorrect vm flags to map bo

Jakub Kicinski (6):
      net: page_pool: allow enabling recycling late, fix false positive war=
ning
      selftests: drv-net: don't assume device has only 2 queues
      net: update NAPI threaded config even for disabled NAPIs
      net: prevent deadlocks when enabling NAPIs with mixed kthread config
      tls: handle data disappearing from under the TLS ULP
      selftests: tls: test TCP stealing data from under the TLS socket

Jann Horn (1):
      kasan/test: fix protection against compiler elision

Jean Delvare (1):
      scsi: lpfc: Fix wrong function reference in a comment

Jedrzej Jagielski (2):
      devlink: let driver opt out of automatic phys_port_name generation
      ixgbe: prevent from unwanted interface name changes

Jeff Layton (2):
      nfsd: don't set the ctime on delegated atime updates
      ref_tracker: use %p instead of %px in debugfs dentry name

Jens Axboe (1):
      io_uring/net: commit partial buffers on retry

Jeongjun Park (1):
      ptp: prevent possible ABBA deadlock in ptp_clock_freerun()

Jialin Wang (1):
      proc: proc_maps_open allow proc_mem_open to return NULL

Jiasheng Jiang (1):
      scsi: lpfc: Remove redundant assignment to avoid memory leak

Jijie Shao (3):
      net: hibmcge: fix rtnl deadlock issue
      net: hibmcge: fix the division by zero issue
      net: hibmcge: fix the np_link_fail error reporting issue

Jinjiang Tu (2):
      mm/smaps: fix race between smaps_hugetlb_range and migration
      fs/proc/task_mmu: hold PTL in pagemap_hugetlb_range and
gather_hugetlb_stats

Johan Hovold (1):
      drm/bridge: fix OF node leak

John Garry (3):
      fs/dax: Reject IOCB_ATOMIC in dax_iomap_rw()
      xfs: disallow atomic writes on DAX
      xfs: reject max_atomic_write mount option for no reflink

John Stultz (1):
      locking: Fix __clear_task_blocked_on() warning from
__ww_mutex_wound() path

Jon Hunter (1):
      soc/tegra: pmc: Ensure power-domains are in a known state

Jordan Rife (1):
      docs: Fix name for net.ipv4.udp_child_hash_entries

Jouni H=C3=B6gander (1):
      drm/i915/psr: Do not trigger Frame Change events from frontbuffer flu=
sh

Julian Sun (1):
      block: restore default wbt enablement

Junli Liu (1):
      erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

Karthik Poosa (1):
      drm/xe/hwmon: Add SW clamp for power limits writes

Kuninori Morimoto (1):
      ASoC: generic: tidyup standardized ASoC menu for generic

Kuniyuki Iwashima (1):
      netdevsim: Fix wild pointer access in nsim_queue_free().

Len Brown (1):
      intel_idle: Allow loading ACPI tables for any family

Leo Martins (1):
      btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()

Linus Torvalds (1):
      Linux 6.17-rc2

Liu01 Tong (1):
      drm/amdgpu: fix task hang from failed job submission during process k=
ill

Lorenzo Stoakes (1):
      mm/mremap: avoid expensive folio lookup on mremap folio pte batch

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix emac link speed handling

Mario Limonciello (AMD) (1):
      Revert "ALSA: hda: Add ASRock X670E Taichi to denylist"

Masami Hiramatsu (Google) (1):
      MAINTAINERS: add Masami as a reviewer of hung task detector

Matt Johnston (1):
      net: mctp: Fix bad kfree_skb in bind lookup test

Matthew Auld (3):
      drm/xe/migrate: prevent infinite recursion
      drm/xe/migrate: don't overflow max copy size
      drm/xe/migrate: prevent potential UAF

Micha=C5=82 Winiarski (1):
      drm/xe/pf: Set VF LMEM BAR size

Miguel Ojeda (2):
      rust: workaround `rustdoc` target modifiers bug
      rust: kbuild: clean output before running `rustdoc`

Naohiro Aota (1):
      btrfs: zoned: do not select metadata BG as finish target

NeilBrown (1):
      nfsd: avoid ref leak in nfsd_open_local_fh()

Nikunj A Dadhania (1):
      x86/sev: Improve handling of writes to intercepted TSC MSRs

Nitin Rawat (1):
      scsi: ufs: core: Fix interrupt handling for MCQ Mode

Olga Kornievskaia (1):
      sunrpc: fix handling of server side tls alerts

Pablo Neira Ayuso (2):
      netfilter: nft_socket: remove WARN_ON_ONCE with huge level value
      netfilter: nf_tables: reject duplicate device on updates

Paulo Alcantara (2):
      smb: client: fix race with concurrent opens in unlink(2)
      smb: client: fix race with concurrent opens in rename(2)

Peter Wang (1):
      scsi: ufs: mediatek: Fix out-of-bounds access in MCQ IRQ mapping

Philipp Reisner (1):
      drbd: Remove the open-coded page pool

Qianfeng Rong (2):
      block, bfq: remove redundant __GFP_NOWARN
      blk-cgroup: remove redundant __GFP_NOWARN

Qu Wenruo (3):
      btrfs: make btrfs_cleanup_ordered_extents() support large folios
      btrfs: fix wrong length parameter for btrfs_cleanup_ordered_extents()
      btrfs: do not allow relocation of partially dropped subvolumes

Rafael J. Wysocki (2):
      cpuidle: governors: menu: Avoid using invalid recent intervals data
      ACPI: processor: perflib: Move problematic pr->performance check

Russell King (Oracle) (2):
      net: stmmac: rk: put the PHY clock on remove
      net: stmmac: dwc-qos: fix clk prepare/enable leak on probe failure

Sabrina Dubroca (4):
      xfrm: flush all states in xfrm_state_fini
      xfrm: restore GSO for SW crypto
      xfrm: bring back device check in validate_xmit_xfrm
      udp: also consider secpath when evaluating ipsec use for checksumming

Sergio Perez Gonzalez (1):
      ASoC: stm: stm32_i2s: Fix calc_clk_div() error handling in
determine_rate()

Shengjiu Wang (1):
      ASoC: fsl_sai: replace regmap_write with regmap_update_bits

Shuming Fan (2):
      ASoC: rt721: fix FU33 Boost Volume control not working
      ASoC: rt1320: fix random cycle mute issue

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Support Clearwater Forest OOB mode

Stanislav Fomichev (2):
      net: lapbether: ignore ops-locked netdevs
      hamradio: ignore ops-locked netdevs

Stefan Metzmacher (1):
      smb: client: don't wait for info->send_pending =3D=3D 0 on error

Steve French (2):
      smb3: fix for slab out of bounds on mount to ksmbd
      cifs: update internal version number

Sukrut Heroorkar (1):
      selftests/proc: fix string literal warning in proc-maps-race.c

Suren Baghdasaryan (1):
      userfaultfd: fix a crash in UFFDIO_MOVE when PMD is a migration entry

Sven Stegemann (1):
      net: kcm: Fix race condition in kcm_unattach()

Takashi Iwai (3):
      ALSA: azt3328: Put __maybe_unused for inline functions for gameport
      ALSA: usb-audio: Validate UAC3 power domain descriptors, too
      ALSA: usb-audio: Validate UAC3 cluster segment descriptors

Takashi Sakamoto (4):
      firewire: core: use reference counting to invoke address handlers saf=
ely
      firewire: core: call handler for exclusive regions outside RCU
read-side critical section
      firewire: core: call FCP address handlers outside RCU read-side
critical section
      firewire: core: reallocate buffer for FCP address handlers when
more than 4 are registered

Tang Yizhou (3):
      blk-wbt: Optimize wbt_done() for non-throttled writes
      blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
      blk-wbt: doc: Update the doc of the wbt_lat_usec interface

Thomas Hellstr=C3=B6m (1):
      drm/xe: Defer buffer object shrinker write-backs and GPU waits

Thorsten Blum (1):
      ASoC: codecs: Call strscpy() with correct size argument

Tom Lendacky (3):
      x86/sev: Evict cache lines during SNP memory validation
      virt: sev-guest: Satisfy linear mapping requirement in get_derived_ke=
y()
      x86/sev: Ensure SVSM reserved fields in a page validation entry
are initialized to zero

Tristram Ha (1):
      net: dsa: microchip: Fix KSZ8863 reset problem

Uday Shankar (1):
      ublk: don't quiesce in ublk_ch_release

Vasiliy Kovalev (1):
      ALSA: hda/realtek: Fix headset mic on HONOR BRB-X

Vinod Govindapillai (1):
      drm/i915/fbc: fix the implementation of wa_18038517565

Waiman Long (2):
      mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()
      futex: Use user_write_access_begin/_end() in futex_put_value()

Wang Zhaolong (2):
      smb: client: fix mid_q_entry memleak leak with per-mid locking
      smb: client: remove redundant lstrp update in negotiate protocol

Waqar Hameed (1):
      scsi: ufs: core: Remove error print for devm_add_action_or_reset()

Xin Long (1):
      sctp: linearize cloned gso packets in sctp_rcv

Xu Yang (1):
      net: usb: asix_devices: add phy_mask for ax88772 mdio bus

Yao Zi (3):
      dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
      net: stmmac: thead: Get and enable APB clock on initialization
      riscv: dts: thead: Add APB clocks for TH1520 GMACs

YiPeng Chai (1):
      drm/amdgpu: fix vram reservation issue

Yuezhang Mo (1):
      erofs: Fallback to normal access if DAX is not supported on extra dev=
ice

Zheng Qixing (1):
      block: fix kobject double initialization in add_disk

