Return-Path: <linux-kernel+bounces-785961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA0B352F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F08720063B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8C2D6E75;
	Tue, 26 Aug 2025 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGhs39VU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08530169AD2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184661; cv=none; b=aPvXmTfs1QKQ/rEAOTsK2XpEunEloOJYcPEqEReOp0d8s9GXlRtxctebu7r590Pqr7MaRKQr8B5vlFmnLE3YcFl4kYz+cKdUMN9UAxKeR+8YGJp1X7AZHJqgK1mGk+Pi+MDgdhTnVLYnY4cXdYH+nsmf9yhF/cbKbYTQ2igD2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184661; c=relaxed/simple;
	bh=sCsNRnnikQA2zDkAn6Pd6aM9Mf7sboiW70nNQJN4ciw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNKpDCMkmbD4SrEaRKXRjajz1ASb10NpHIUMByD/L8zc+taqu2legPAqueAWLTYZqYywoTwduRNZ2L/o7gTDpY56pB8XzK3erSDxTd1VCrIfKF46XsbmqhFSmJNWOqBHVJjanT4MP2TCTkl4a+AiCvZmo5cPcJStsgI/Hf55D0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGhs39VU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2469325d158so16315335ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756184658; x=1756789458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vm/MdjAQvPkcvDtw2F1unKV275w/EXoUzcw7DJMCG0=;
        b=OGhs39VUcKoQkgu7FnTXR+LfKMhYgd1MYi8Jrgn6BkNPc2FFD0sT/WDsrNYFkzG4/K
         kV2idaypZThwE7sywfJFYWjqDexR1cW9iYnt2ArL5+/kOMs7VM6WfnS/TVSosiYvEuVm
         KITtBftSMDBgaqHeQluNJrVLNkXCXQqsQ+Vy8a3MX/Gyvv1TD6/IMsxq5RvmXlz7L91E
         oVfAfMHNHXXVeU+5HPwbJuLkZuPt8mJLBqdeVhh5anGQCL5At10bDC6WGltjglucLYFZ
         /gL23K93bf2Eqx3VfvWAWQjwk1HiQ4my33wNhyLemEWfTCqCrnWlQkNdTglKA65l6nBA
         NMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756184658; x=1756789458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vm/MdjAQvPkcvDtw2F1unKV275w/EXoUzcw7DJMCG0=;
        b=UjJKJpHH/nofcFE+RqTyq6gKcjinWjmQj3OQ6RRUVkhhBH62RvoF/7DDtdD3HRZUh5
         ALOjwaNsz9H9x7vKu2oPQ6Tc8oLaQVAotsg0IRSLaaDhJ/vlg+oQx/SwhLOJ1wOsIu8m
         5PxufBijPP2aRQv7bqeh4dUbQuEDXzvP54xym4j7p3IWv83/8m3FtXHP7hKr8utN8xac
         OmCX9Iwj5nGrvc4i9EdUcclbYxcQICzQ6cKI6eLWBLwk85kwcBtSFkfjCNB0OZj5fV+N
         GHiaK51RE25s62k1QXrQlc7JxD5dK6t7S7SimLym9lzDcmHLOk/FJZYjP8WBYYOnkEF+
         opNw==
X-Gm-Message-State: AOJu0YwwkK8m3Qn1YXWtBTDIT3jSUUXSuBrp/HYD/OcJBUL2sNMA8guJ
	bHQHZBdz1ynxLHUJiqbeRNAgu6PzYreZwlxya1DuvDXFhR7zTvB1TDvxeqZM6EIUR25wLuO+jX0
	RzKidqdidf4RKUWCfLWSoguDCs91Ch6w=
X-Gm-Gg: ASbGncubvPVkd5L/pfzE73hCKU6xroqpE7LQJEo+4bXISRk67KHUCZH2S3YS2iL/Wtl
	jtmzof22b50+mvX5AJ72pK8N8P4n4xuEhCDooAoADRbhIWcrXmLVCk/WgbTf/XMi24fX8xGVfZI
	S52W9W8DkMKwZYQEdWkxwpzwQIW49r7Ho6YnyyLV0VYfQpBR4L2oOgF+g/m5kjufQjhAqAlTNKS
	3fwuMw7eKMhCNNF923ZkpO2oylwmHr8qEyHTlw=
X-Google-Smtp-Source: AGHT+IF7fHBbP38GQrO6OTjA63N6nwlPQaHiwbnGxe+P8S4blDoOTlEV0cSqnXYb0c+YjrJ0fUeonfEBSSdp9db4fd8=
X-Received: by 2002:a17:902:c94c:b0:246:1c6a:7026 with SMTP id
 d9443c01a7336-2462ef5fceemr200391425ad.40.1756184657263; Mon, 25 Aug 2025
 22:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgKmy+gOftf32wT86F+mSvdq2=XZe8Tcb5m0NaQTZt-dg@mail.gmail.com>
In-Reply-To: <CAHk-=wgKmy+gOftf32wT86F+mSvdq2=XZe8Tcb5m0NaQTZt-dg@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 26 Aug 2025 06:04:04 +0100
X-Gm-Features: Ac12FXy8g016JYff1ld-hEdwRmKsBgC5p7GQw_rm1ehJusg4fYfHZMvnQlkG5UQ
Message-ID: <CADo9pHjbJw9HXBqboLHaywAAjeEmMjnQfZnCXjTRVF3nHZh8rw@mail.gmail.com>
Subject: Re: Linux 3.17-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

3.17 I thought it was 6.17 ?

Den m=C3=A5n 25 aug. 2025 kl 12:09 skrev Linus Torvalds
<torvalds@linux-foundation.org>:
>
> I'm still traveling for family reasons, so slightly unusual timing for
> rc3, but it's (barely) afternoon here on the East coast, so the usual
> Sunday afternoon schedule technically still holds.
>
> As suspected, rc3 ends up being a bit larger than usual, to balance
> out the tiny rc2. Yes, 3.17 seems to be generally in pretty good
> shape, but nobody *really* believed that it was as good as that tiny
> rc2 would make it seem.
>
> And while rc3 is on the larger side, it's by no means anything
> outrageously so, it's well within the normal parameters.
>
> The diffstat looks fairly normal too: about half drivers (spread all
> over, we've got a bit of everything, but mellanox mlx5 stands out if
> you want to pick out any particular area). There's a fair chunk of
> added selftests and some more Rust support, and then a random
> collection of fixes all over: architecture code, filesystems, VM and
> core networking.
>
> Anyway, things seem fairly normal for this phase in the release cycle,
> nothing stands out. Please keep testing,
>
>              Linus
>
> ---
>
> Adrian Huang (Lenovo) (2):
>       pidfs: Fix memory leak in pidfd_info()
>       signal: Fix memory leak for PIDFD_SELF* sentinels
>
> Adrian Hunter (1):
>       scsi: ufs: ufs-pci: Add support for Intel Wildcat Lake
>
> Akhilesh Patil (3):
>       RDMA/core: Free pfn_list with appropriate kvfree call
>       selftests: ublk: Use ARRAY_SIZE() macro to improve code
>       iommufd: viommu: free memory allocated by kvcalloc() using kvfree()
>
> Al Viro (4):
>       fix the softlockups in attach_recursive_mnt()
>       propagate_umount(): only surviving overmounts should be reparented
>       use uniform permission checks for all mount propagation changes
>       change_mnt_propagation(): calculate propagation source only if
> we'll need it
>
> Alan Stern (1):
>       USB: core: Update kerneldoc for usb_hcd_giveback_urb()
>
> Aleksa Sarai (2):
>       open_tree_attr: do not allow id-mapping changes without OPEN_TREE_C=
LONE
>       selftests/mount_setattr: add smoke tests for open_tree_attr(2) bug
>
> Aleksander Jan Bajkowski (2):
>       mips: dts: lantiq: danube: add missing burst length property
>       mips: lantiq: xway: sysctrl: rename the etop node
>
> Alessandro Ratti (1):
>       iommufd: Fix spelling errors in iommufd.rst
>
> Alex Deucher (1):
>       drm/amdgpu/swm14: Update power limit logic
>
> Alex Guo (1):
>       i2c: rtl9300: Fix out-of-bounds bug in rtl9300_i2c_smbus_xfer
>
> Alex Vesker (1):
>       net/mlx5: HWS, Fix table creation UID
>
> Alexandra Winter (1):
>       MAINTAINERS: update s390/net
>
> Alexei Lazar (1):
>       net/mlx5e: Query FW for buffer ownership
>
> Alice Ryhl (1):
>       mm: rust: add page.rs to MEMORY MANAGEMENT - RUST
>
> Amir Goldstein (1):
>       ovl: fix possible double unlink
>
> Amit Sunil Dhamne (2):
>       usb: typec: maxim_contaminant: disable low power mode when
> reading comparator values
>       usb: typec: maxim_contaminant: re-enable cc toggle if cc is open
> and port is clean
>
> Anantha Prabhu (1):
>       RDMA/bnxt_re: Fix to initialize the PBL array
>
> Andrea Righi (1):
>       sched/ext: Fix invalid task state transitions on class switch
>
> Andreas Dilger (1):
>       ext4: check fast symlink for ea_inode correctly
>
> Antonio Quartulli (1):
>       ext4: remove useless if check
>
> Armen Ratner (1):
>       net/mlx5e: Preserve shared buffer capacity during headroom updates
>
> Armin Wolf (1):
>       platform/x86: dell-smbios-wmi: Stop touching WMI device ID
>
> Avizrat, Yaron (1):
>       MAINTAINERS: Change habanalabs maintainers
>
> Axel Rasmussen (1):
>       MAINTAINERS: mark MGLRU as maintained
>
> Baihan Li (5):
>       drm/hisilicon/hibmc: fix the i2c device resource leak when vdac
> init failed
>       drm/hisilicon/hibmc: fix irq_request()'s irq name variable is local
>       drm/hisilicon/hibmc: fix the hibmc loaded failed bug
>       drm/hisilicon/hibmc: fix rare monitors cannot display problem
>       drm/hisilicon/hibmc: fix dp and vga cannot show together
>
> Baokun Li (3):
>       ext4: show the default enabled i_version option
>       ext4: preserve SB_I_VERSION on remount
>       jbd2: prevent softlockup in jbd2_log_do_checkpoint()
>
> Baolin Liu (1):
>       ext4: fix incorrect function name in comment
>
> Bart Van Assche (4):
>       scsi: ufs: core: Fix IRQ lock inversion for the SCSI host lock
>       scsi: ufs: core: Remove WARN_ON_ONCE() call from ufshcd_uic_cmd_com=
pl()
>       scsi: ufs: core: Fix the return value documentation
>       scsi: ufs: core: Rename ufshcd_wait_for_doorbell_clr()
>
> Ben Hutchings (1):
>       bootconfig: Fix negative seeks on 32-bit with LFS enabled
>
> Bibo Mao (3):
>       LoongArch: KVM: Make function kvm_own_lbt() robust
>       LoongArch: KVM: Fix stack protector issue in send_ipi_data()
>       LoongArch: KVM: Add address alignment check in pch_pic register acc=
ess
>
> Boshi Yu (2):
>       RDMA/erdma: Fix ignored return value of init_kernel_qp
>       RDMA/erdma: Fix unset QPN of GSI QP
>
> Carolina Jubran (5):
>       net/mlx5: Remove default QoS group and attach vports directly to ro=
ot TSAR
>       net/mlx5e: Preserve tc-bw during parent changes
>       net/mlx5: Destroy vport QoS element when no configuration remains
>       net/mlx5: Fix QoS reference leak in vport enable error path
>       net/mlx5: Restore missing scheduling node cleanup on vport enable f=
ailure
>
> Chandra Mohan Sundar (1):
>       net: libwx: Fix the size in RSS hash key population
>
> Charalampos Mitrodimas (1):
>       debugfs: fix mount options not being applied
>
> Charles Han (1):
>       ACPI: APEI: EINJ: fix potential NULL dereference in __einj_error_in=
ject()
>
> Chen Yu (1):
>       ACPI: pfr_update: Fix the driver update version check
>
> Chenyuan Yang (1):
>       drm/amd/display: Add null pointer check in mod_hdcp_hdcp1_create_se=
ssion()
>
> Christian Brauner (1):
>       kernfs: don't fail listing extended attributes
>
> Christoph Hellwig (4):
>       scsi: fnic: Remove a useless struct mempool forward declaration
>       block: handle pi_tuple_size in queue_limits_stack_integrity
>       block: remove newlines from the warnings in blk_validate_integrity_=
limits
>       block: tone down bio_check_eod
>
> Christoph Manszewski (1):
>       drm/xe: Fix vm_bind_ioctl double free bug
>
> Christoph Paasch (1):
>       mptcp: drop skb if MPTCP skb extension allocation fails
>
> Claudiu Beznea (2):
>       iio: adc: rzg2l: Cleanup suspend/resume path
>       iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
>
> D. Wythe (1):
>       net/smc: fix UAF on smcsk after smc_listen_out()
>
> Dan Carpenter (4):
>       scsi: qla4xxx: Prevent a potential error pointer dereference
>       ALSA: usb-audio: Fix size validation in convert_chmap_v3()
>       coredump: Fix return value in coredump_parse()
>       regulator: tps65219: regulator: tps65219: Fix error codes in probe(=
)
>
> Daniel Jurgens (1):
>       net/mlx5: Base ECVF devlink port attrs from 0
>
> Danilo Krummrich (10):
>       mm/vmscan: fix inverted polarity in lru_gen_seq_show()
>       MAINTAINERS: entry for DRM GPUVM
>       rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
>       rust: drm: ensure kmalloc() compatible Layout
>       rust: drm: remove pin annotations from drm::Device
>       rust: drm: don't pass the address of drm::Device to drm_dev_put()
>       device: rust: expand documentation for DeviceContext
>       device: rust: expand documentation for Device
>       driver: rust: expand documentation for driver infrastructure
>       rust: devres: fix leaking call to devm_add_action()
>
> Dave Hansen (1):
>       MAINTAINERS: Remove bouncing irdma maintainer
>
> David Hildenbrand (1):
>       mm/mremap: fix WARN with uffd that has remap events disabled
>
> David Howells (2):
>       netfs: Fix unbuffered write error handling
>       cifs: Fix oops due to uninitialised variable
>
> David Lechner (6):
>       iio: accel: sca3300: fix uninitialized iio scan data
>       iio: proximity: isl29501: fix buffered read on big-endian systems
>       iio: adc: ad7173: prevent scan if too many setups requested
>       iio: temperature: maxim_thermocouple: use DMA-safe buffer for spi_r=
ead()
>       iio: adc: ad7124: fix channel lookup in syscalib functions
>       iio: adc: ad7380: fix missing max_conversion_rate_hz on adaq4381-4
>
> Devyn Liu (1):
>       MAINTAINERS: i2c: Update i2c_hisi entry
>
> Dewei Meng (1):
>       ALSA: timer: fix ida_free call while not allocated
>
> Dominique Martinet (1):
>       iov_iter: iterate_folioq: fix handling of offset >=3D folio size
>
> Easwar Hariharan (1):
>       .mailmap: add entry for Easwar Hariharan
>
> Edip Hazuri (1):
>       platform/x86: hp-wmi: mark Victus 16-r1xxx for victus_s fan and
> thermal profile support
>
> Edward Adam Davis (1):
>       comedi: pcl726: Prevent invalid irq number
>
> Eric Biggers (2):
>       lib/crypto: sha: Update Kconfig help for SHA1 and SHA256
>       ipv6: sr: Fix MAC comparison to be constant-time
>
> Evgeniy Harchenko (1):
>       ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and
> EliteBook 830 G6
>
> Fanhua Li (1):
>       drm/nouveau/nvif: Fix potential memory leak in nvif_vmm_ctor().
>
> Filipe Manana (1):
>       btrfs: do not set mtime/ctime to current time when unlinking for
> log replay
>
> Florian Westphal (1):
>       netfilter: nf_reject: don't leak dst refcount for loopback packets
>
> Gabe Teeger (1):
>       drm/amd/display: Revert Add HPO encoder support to Replay
>
> Gabor Juhos (2):
>       spi: spi-qpic-snand: use correct CW_PER_PAGE value for OOB write
>       spi: spi-qpic-snand: fix calculating of ECC OOB regions' properties
>
> Geliang Tang (3):
>       mptcp: remove duplicate sk_reset_timer call
>       mptcp: disable add_addr retransmission when timeout is 0
>       selftests: mptcp: disable add_addr retrans in endpoint_tests
>
> Hangbin Liu (3):
>       bonding: update LACP activity flag after setting lacp_active
>       bonding: send LACPDUs periodically in passive mode after
> receiving partner's LACPDU
>       selftests: bonding: add test for passive LACP mode
>
> Hariprasad Kelam (1):
>       Octeontx2-af: Skip overlap check for SPI field
>
> Harshal Gohel (1):
>       i2c: rtl9300: Fix multi-byte I2C write
>
> Heikki Krogerus (1):
>       usb: dwc3: pci: add support for the Intel Wildcat Lake
>
> Heiko Carstens (3):
>       s390/configs: Update defconfigs
>       s390/configs: Set HZ=3D1000
>       s390/mm: Do not map lowcore with identity mapping
>
> Herton R. Krzesinski (1):
>       mm/debug_vm_pgtable: clear page table entries at destroy_args()
>
> Horatiu Vultur (1):
>       phy: mscc: Fix timestamping for vsc8584
>
> Huacai Chen (3):
>       mm/migrate: fix NULL movable_ops if CONFIG_ZSMALLOC=3Dm
>       LoongArch: Save LBT before FPU in setup_sigcontext()
>       LoongArch: Rename GCC_PLUGIN_STACKLEAK to KSTACK_ERASE
>
> Ian Abbott (2):
>       comedi: Fix use of uninitialized memory in do_insn_ioctl() and
> do_insnlist_ioctl()
>       comedi: Make insn_rw_emulate_bits() do insn->n samples
>
> Ido Schimmel (2):
>       mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
>       selftest: forwarding: router: Add a test case for IPv4
> link-local source IP
>
> Imre Deak (5):
>       drm/i915/lnl+/tc: Fix handling of an enabled/disconnected dp-alt si=
nk
>       drm/i915/icl+/tc: Cache the max lane count value
>       drm/i915/lnl+/tc: Fix max lane count HW readout
>       drm/i915/lnl+/tc: Use the cached max lane count value
>       drm/i915/icl+/tc: Convert AUX powered WARN to a debug message
>
> JP Kobryn (1):
>       cgroup: avoid null de-ref in css_rstat_exit()
>
> Jakub Acs (1):
>       net, hsr: reject HSR frame if skb can't hold tag
>
> Jakub Kicinski (3):
>       selftests: tls: make the new data_steal test less flaky
>       tls: fix handling of zero-length records on the rx_list
>       selftests: tls: add tests for zero-length records
>
> Jakub Ramaseuski (1):
>       net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6=
_CSUM
>
> Jan Beulich (1):
>       compiler: remove __ADDRESSABLE_ASM{_STR,}() again
>
> Jan Kara (1):
>       iomap: Fix broken data integrity guarantees for O_SYNC writes
>
> Jani Nikula (1):
>       drm/i915: silence rpm wakeref asserts on GEN11_GU_MISC_IIR access
>
> Jason Xing (1):
>       ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_z=
c
>
> Javier Garcia (1):
>       drm: Add directive to format code in comment
>
> Jean-Baptiste Maneyrol (1):
>       iio: imu: inv_icm42600: change invalid data error to -EBUSY
>
> Jens Axboe (2):
>       io_uring/futex: ensure io_futex_wait() cleans up properly on failur=
e
>       io_uring: clear ->async_data as part of normal init
>
> Jiande Lu (1):
>       Bluetooth: btmtk: Fix wait_on_bit_timeout interruption during shutd=
own
>
> Jiapeng Chong (1):
>       selftests/sched_ext: Remove duplicate sched.h header
>
> Jiayi Li (1):
>       memstick: Fix deadlock by moving removing flag earlier
>
> Jinjiang Tu (1):
>       mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn
>
> Jiufei Xue (1):
>       fs: writeback: fix use-after-free in __mark_inode_dirty()
>
> Joanne Koong (1):
>       fuse: keep inode->i_blkbits constant
>
> Jocelyn Falempe (1):
>       drm/panic: Add a u64 divide by 10 for arm32
>
> Johannes Thumshirn (1):
>       btrfs: zoned: skip ZONE FINISH of conventional zones
>
> Jonas Gorski (1):
>       net: dsa: b53: fix reserved register access in b53_fdb_dump()
>
> Jonathan Cameron (1):
>       iio: light: as73211: Ensure buffer holes are zeroed
>
> Jordan Rhee (1):
>       gve: prevent ethtool ops after shutdown
>
> Jos=C3=A9 Exp=C3=B3sito (2):
>       drm/tests: Fix endian warning
>       drm/tests: Fix drm_test_fb_xrgb8888_to_xrgb2101010() on big-endian
>
> Judith Mendez (1):
>       mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
>
> Juergen Gross (1):
>       drivers/xen/xenbus: remove quirk for Xen 3.x
>
> Junxian Huang (1):
>       RDMA/hns: Fix dip entries leak on devices newer than hip09
>
> Justin Lai (1):
>       rtase: Fix Rx descriptor CRC error bit definition
>
> Kailang Yang (1):
>       ALSA: hda/realtek: Audio disappears on HP 15-fc000 after warm boot =
again
>
> Kalesh AP (1):
>       RDMA/bnxt_re: Fix a possible memory leak in the driver
>
> Kanglong Wang (1):
>       LoongArch: Optimize module load time by optimizing PLT/GOT counting
>
> Kashyap Desai (2):
>       RDMA/bnxt_re: Fix to do SRQ armena by default
>       RDMA/bnxt_re: Fix to remove workload check in SRQ limit path
>
> Kees Cook (1):
>       iommu/amd: Avoid stack buffer overflow from kernel cmdline
>
> Kory Maincent (2):
>       net: pse-pd: pd692x0: Fix power budget leak in manager setup error =
path
>       net: pse-pd: pd692x0: Skip power budget configuration when undefine=
d
>
> Krzysztof Kozlowski (1):
>       regulator: dt-bindings: infineon,ir38060: Add Guenter as
> maintainer from IBM
>
> Kuen-Han Tsai (1):
>       usb: dwc3: Ignore late xferNotReady event to prevent halt timeout
>
> Kyoji Ogasawara (3):
>       btrfs: fix incorrect log message for nobarrier mount option
>       btrfs: restore mount option info messages during mount
>       btrfs: fix printing of mount info messages for NODATACOW/NODATASUM
>
> Li RongQing (1):
>       x86/bugs: Fix GDS mitigation selecting when mitigation is off
>
> Liao Yuanhong (2):
>       ext4: use kmalloc_array() for array space allocation
>       ring-buffer: Remove redundant semicolons
>
> Linus Torvalds (1):
>       Linux 6.17-rc3
>
> Liu Ying (1):
>       drm/bridge: analogix_dp: Fix bailout for devm_drm_bridge_alloc()
>
> Lorenzo Bianconi (1):
>       net: airoha: ppe: Do not invalid PPE entries in case of SW hash col=
lision
>
> Lorenzo Stoakes (4):
>       tools/testing: add linux/args.h header and fix radix, VMA tests
>       mm/mremap: allow multi-VMA move when filesystem uses thp_get_unmapp=
ed_area
>       mm/mremap: catch invalid multi VMA moves earlier
>       selftests/mm: add test for invalid multi VMA operations
>
> Lubomir Rintel (1):
>       cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as WWAN
>
> Luiz Augusto von Dentz (7):
>       Bluetooth: hci_sync: Fix scan state after PA Sync has been establis=
hed
>       Bluetooth: ISO: Fix getname not returning broadcast fields
>       Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_=
LINK
>       Bluetooth: hci_conn: Fix not cleaning up Broadcaster/Broadcast Sour=
ce
>       Bluetooth: hci_core: Fix using {cis,bis}_capable for current settin=
gs
>       Bluetooth: hci_core: Fix using ll_privacy_capable for current setti=
ngs
>       Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separa=
tely
>
> MD Danish Anwar (1):
>       net: ti: icssg-prueth: Fix HSR and switch offload Enablement
> during firwmare reload.
>
> Maciej Fijalkowski (1):
>       ixgbe: fix ndo_xdp_xmit() workloads
>
> Madhur Kumar (1):
>       drm/nouveau: fix typos in comments
>
> Mael GUERIN (1):
>       USB: storage: Add unusual-devs entry for Novatek NTK96550-based cam=
era
>
> Marek Vasut (1):
>       usb: renesas-xhci: Fix External ROM access timeouts
>
> Mario Limonciello (2):
>       platform/x86/amd: pmc: Drop SMU F/W match for Cezanne
>       drm/amd/display: Avoid a NULL pointer dereference
>
> Masami Hiramatsu (Google) (1):
>       tracing: fprobe-event: Sanitize wildcard for fprobe event name
>
> Matthieu Baerts (NGI0) (4):
>       mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
>       selftests: mptcp: pm: check flush doesn't reset limits
>       selftests: mptcp: connect: fix C23 extension warning
>       selftests: mptcp: sockopt: fix C23 extension warning
>
> Matti Vaittinen (1):
>       iio: adc: bd79124: Add GPIOLIB dependency
>
> Miao Li (1):
>       usb: quirks: Add DELAY_INIT quick for another SanDisk 3.2Gen1 Flash=
 Drive
>
> Miaoqian Lin (1):
>       most: core: Drop device reference after usage in get_channel()
>
> Michael Chan (1):
>       bnxt_en: Fix lockdep warning during rmmod
>
> Miguel Ojeda (3):
>       rust: faux: fix C header link
>       drm: nova-drm: fix 32-bit arm build
>       rust: alloc: fix `rusttest` by providing `Cmalloc::aligned_layout` =
too
>
> Ming Lei (1):
>       blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues
>
> Ming Wang (1):
>       LoongArch: Increase COMMAND_LINE_SIZE up to 4096
>
> Minhong He (1):
>       ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add
>
> Miquel Raynal (1):
>       spi: spi-mem: Add missing kdoc argument
>
> Nam Cao (3):
>       selftests/coredump: Remove the read() that fails the test
>       PCI: xilinx: Fix NULL pointer dereference in xilinx_pcie_intr_handl=
er()
>       PCI: vmd: Remove MSI-X check on child devices
>
> Namjae Jeon (1):
>       ksmbd: extend the connection limiting mechanism to support IPv6
>
> Naohiro Aota (5):
>       btrfs: zoned: fix data relocation block group reservation
>       btrfs: zoned: fix write time activation failure for metadata block =
group
>       btrfs: zoned: limit active zones to max_open_zones
>       btrfs: subpage: keep TOWRITE tag until folio is cleaned
>       btrfs: fix buffer index in wait_eb_writebacks()
>
> Neeraj Sanjay Kale (1):
>       Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling
>
> NeilBrown (1):
>       ovl: use I_MUTEX_PARENT when locking parent in ovl_create_temp()
>
> Nicolin Chen (2):
>       iommu/tegra241-cmdqv: Fix missing cpu_to_le64 at lvcmdq_err_map
>       iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters decrement
>
> Niklas Neronin (1):
>       usb: xhci: fix host not responding after suspend and resume
>
> Nilay Shroff (3):
>       block: skip q->rq_qos check in rq_qos_done_bio()
>       block: decrement block_rq_qos static key in rq_qos_del()
>       block: avoid cpu_hotplug_lock depedency on freeze_lock
>
> Nitin Gote (1):
>       iosys-map: Fix undefined behavior in iosys_map_clear()
>
> Nitin Rawat (1):
>       scsi: ufs: ufs-qcom: Fix ESI null pointer dereference
>
> Ojaswin Mujoo (2):
>       ext4: fix fsmap end of range reporting with bigalloc
>       ext4: fix reserved gdt blocks handling in fsmap
>
> Parthiban Veerasooran (2):
>       microchip: lan865x: fix missing netif_start_queue() call on device =
open
>       microchip: lan865x: fix missing Timer Increment config for Rev.B0/B=
1
>
> Pasha Tatashin (3):
>       kho: init new_physxa->phys_bits to fix lockdep
>       kho: mm: don't allow deferred struct page with KHO
>       kho: warn if KHO is disabled due to an error
>
> Pauli Virtanen (1):
>       Bluetooth: hci_event: fix MTU for BN =3D=3D 0 in CIS Established
>
> Peng Fan (1):
>       regulator: pca9450: Use devm_register_sys_off_handler
>
> Peter Oberparleiter (3):
>       s390/sclp: Fix SCCB present check
>       s390/hypfs: Avoid unnecessary ioctl registration in debugfs
>       s390/hypfs: Enable limited access during lockdown
>
> Phillip Lougher (1):
>       squashfs: fix memory leak in squashfs_fill_super
>
> Piotr Pi=C3=B3rkowski (2):
>       drm/xe: Assign ioctl xe file handler to vm in xe_vm_create
>       drm/xe: Move ASID allocation and user PT BO tracking into xe_vm_cre=
ate
>
> Piotr Zalewski (1):
>       drm/rockchip: vop2: make vp registers nonvolatile
>
> Pu Lehui (1):
>       tracing: Limit access to parser->buffer when trace_get_user failed
>
> Qianfeng Rong (2):
>       ext4: remove redundant __GFP_NOWARN
>       drm/nouveau/gsp: fix mismatched alloc/free for kvmalloc()
>
> Qingfang Deng (2):
>       net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
>       ppp: fix race conditions in ppp_fill_forward_path
>
> Qu Wenruo (3):
>       btrfs: clear block dirty if submit_one_sector() failed
>       btrfs: clear block dirty if btrfs_writepage_cow_fixup() failed
>       btrfs: clear TAG_TOWRITE from buffer tree when submitting a tree bl=
ock
>
> Rafael J. Wysocki (1):
>       cpuidle: governors: menu: Avoid selecting states with too much late=
ncy
>
> Rajeev Mishra (2):
>       loop: Consolidate size calculation logic into lo_calculate_size()
>       loop: use vfs_getattr_nosec for accurate file size
>
> Raphael Gallais-Pou (1):
>       spi: st: fix PM macros to use CONFIG_PM instead of CONFIG_PM_SLEEP
>
> Richard Fitzgerald (1):
>       ASoC: cs35l56: Handle new algorithms IDs for CS35L63
>
> Robin Murphy (1):
>       iommu/virtio: Make instance lookup robust
>
> Rudi Heitbaum (1):
>       drm/rockchip: cdn-dp: select bridge for cdp-dp
>
> Russell King (Oracle) (1):
>       usb: gadget: tegra-xudc: fix PM use count underflow
>
> Ryan Wanner (1):
>       Revert "net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag"
>
> Sai Krishna Potthuri (1):
>       mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up
>
> Salah Triki (1):
>       iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()
>
> Sang-Heon Jeon (3):
>       mm/damon/core: fix commit_ops_filters by using correct nth function
>       selftests/damon: fix selftests by installing drgn related script
>       mm/damon/core: fix damos_commit_filter not changing allow
>
> Sebastian Andrzej Siewior (1):
>       kcov, usb: Don't disable interrupts in kcov_remote_start_usb_softir=
q()
>
> Sebastian Brzezinka (1):
>       drm/i915/gt: Relocate compression repacking WA for JSL/EHL
>
> Sebastian Reichel (1):
>       usb: typec: fusb302: Revert incorrect threaded irq fix
>
> Selvarasu Ganesan (1):
>       usb: dwc3: Remove WARN_ON for device endpoint command timeouts
>
> SeongJae Park (1):
>       mm/damon/sysfs-schemes: put damos dests dir after removing its file=
s
>
> Sergey Shtylyov (1):
>       Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()
>
> Shenghao Ding (1):
>       ALSA: hda/tas2781: Add name prefix tas2781 for tas2781's dvc_tlv
> and amp_vol_tlv
>
> Shinji Nomoto (2):
>       cpupower: Fix a bug where the -t option of the set subcommand
> was not working.
>       cpupower: Allow control of boost feature on non-x86 based
> systems with boost support.
>
> Soham Metha (1):
>       docs: cgroup: fixed spelling mistakes in documentation
>
> Song Gao (1):
>       LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of kvm_get_vcpu()
>
> Srinivas Pandruvada (1):
>       platform/x86/intel-uncore-freq: Check write blocked for ELC
>
> Stefan Binding (2):
>       ASoC: cs35l56: Update Firmware Addresses for CS35L63 for
> production silicon
>       ASoC: cs35l56: Remove SoundWire Clock Divider workaround for CS35L6=
3
>
> Stefan Metzmacher (1):
>       smb: server: split ksmbd_rdma_stop_listening() out of ksmbd_rdma_de=
stroy()
>
> Stefan Wahren (1):
>       spi: spi-fsl-lpspi: Clamp too high speed_hz
>
> Steven Rostedt (2):
>       fgraph: Copy args in intermediate storage with entry
>       ftrace: Also allocate and copy hash for reading of filter files
>
> Suma Hegde (2):
>       platform/x86/amd/hsmp: Ensure sock->metric_tbl_addr is non-NULL
>       platform/x86/amd/hsmp: Ensure success even if hwmon registration fa=
ils
>
> Suraj Gupta (1):
>       net: xilinx: axienet: Fix RX skb ring management in DMAengine mode
>
> Sven Eckelmann (2):
>       i2c: rtl9300: Increase timeout for transfer polling
>       i2c: rtl9300: Add missing count byte for SMBus Block Ops
>
> Takashi Iwai (2):
>       ALSA: hda: tas2781: Fix wrong reference of tasdevice_priv
>       ALSA: usb-audio: Use correct sub-type for UAC3 feature unit validat=
ion
>
> Tal Zussman (1):
>       lib/crypto: ensure generated *.S files are removed on make clean
>
> Tao Chen (2):
>       tools/latency-collector: Check pkg-config install
>       rtla: Check pkg-config install
>
> Tengda Wu (1):
>       ftrace: Fix potential warning in trace_printk_seq during ftrace_dum=
p
>
> Theodore Ts'o (2):
>       ext4: fix unused variable warning in ext4_init_new_dir
>       ext4: don't try to clear the orphan_present feature block device is=
 r/o
>
> Thomas Bertschinger (1):
>       fhandle: do_handle_open() should get FD with user flags
>
> Thomas Zimmermann (1):
>       Revert "drm/amdgpu: Use dma_buf from GEM object instance"
>
> Thorsten Blum (4):
>       usb: storage: realtek_cr: Use correct byte order for bcs->Residue
>       accel/habanalabs/gaudi2: Use kvfree() for memory allocated with kvc=
alloc()
>       params: Replace deprecated strcpy() with strscpy() and memcpy()
>       cdx: Fix off-by-one error in cdx_rpmsg_probe()
>
> Tianxiang Peng (1):
>       x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper
>
> Tianyu Xu (1):
>       spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()
>
> Tiezhu Yang (2):
>       objtool/LoongArch: Get table size correctly if LTO is enabled
>       LoongArch: Pass annotate-tablejump option if LTO is enabled
>
> Timur Krist=C3=B3f (8):
>       drm/amd/display: Don't overclock DCE 6 by 15%
>       drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
>       drm/amd/display: Find first CRTC and its line time in
> dce110_fill_display_configs
>       drm/amd/display: Fill display clock and vblank time in
> dce110_fill_display_configs
>       drm/amd/display: Don't warn when missing DCE encoder caps
>       drm/amd/display: Don't print errors for nonexistent connectors
>       drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
>       drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
>
> Tom Chung (1):
>       drm/amd/display: Fix Xorg desktop unresponsive on Replay panel
>
> Tony Luck (1):
>       ACPI: APEI: EINJ: Check if user asked for EINJV2 injection
>
> Tristram Ha (1):
>       net: dsa: microchip: Fix KSZ9477 HSR port setup issue
>
> Trond Myklebust (1):
>       NFS: Fix a race when updating an existing write
>
> Uwe Kleine-K=C3=B6nig (1):
>       ACPI: APEI: EINJ: Fix resource leak by remove callback in .exit.tex=
t
>
> ValdikSS (1):
>       igc: fix disabling L1.2 PCI-E link substate on I226 on init
>
> Vasiliy Kovalev (1):
>       ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14
>
> Victor Nogueira (1):
>       net/sched: sch_dualpi2: Run prob update timer in softirq to avoid d=
eadlock
>
> Victor Shih (3):
>       mmc: sdhci-pci-gli: Add a new function to simplify the code
>       mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consi=
stency
>       mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
>
> Vlad Dogaru (1):
>       net/mlx5: CT: Use the correct counter offset
>
> Vlastimil Babka (1):
>       module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_M=
ODULES
>
> Waiman Long (3):
>       cgroup/cpuset: Use static_branch_enable_cpuslocked() on
> cpusets_insane_config_key
>       cgroup/cpuset: Fix a partition error with CPU hotplug
>       cgroup/cpuset: Remove the unnecessary css_get/put() in
> cpuset_partition_write()
>
> Wang Liang (1):
>       net: bridge: fix soft lockup in br_multicast_query_expired()
>
> Weitao Wang (1):
>       usb: xhci: Fix slot_id resource race conflict
>
> William Liu (4):
>       net/sched: Fix backlog accounting in qdisc_dequeue_internal
>       selftests/tc-testing: Check backlog stats in gso_skb case
>       net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_li=
mit
>       net/sched: Remove unnecessary WARNING condition for empty child
> qdisc in htb_activate
>
> Willy Tarreau (2):
>       Documentation: clarify the expected collaboration with security
> bugs reporters
>       Documentation: smooth the text flow in the security bug reporting p=
rocess
>
> XianLiang Huang (1):
>       iommu/riscv: prevent NULL deref in iova_to_phys
>
> Xianglai Li (1):
>       LoongArch: Add cpuhotplug hooks to fix high cpu usage of vCPU threa=
ds
>
> Xiao Ni (2):
>       md: add legacy_async_del_gendisk mode
>       md: keep recovery_cp in mdp_superblock_s
>
> Xu Yang (2):
>       usb: core: hcd: fix accessing unmapped memory in
> SINGLE_STEP_SET_FEATURE test
>       usb: chipidea: imx: improve usbmisc_imx7d_pullup()
>
> Xu Yilun (1):
>       fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()
>
> Yang Li (2):
>       Bluetooth: hci_sync: Avoid adding default advertising on startup
>       Bluetooth: hci_sync: Prevent unintended PA sync when SID is 0xFF
>
> Yao Zi (1):
>       net: stmmac: thead: Enable TX clock before MAC initialization
>
> Yazen Ghannam (1):
>       x86/CPU/AMD: Ignore invalid reset reason value
>
> Ye Bin (1):
>       fs/buffer: fix use-after-free when call bh_read() helper
>
> Ye Weihua (1):
>       trace/fgraph: Fix the warning caused by missing unregister notifier
>
> Yevgeny Kliteynik (5):
>       net/mlx5: HWS, fix bad parameter in CQ creation
>       net/mlx5: HWS, fix simple rules rehash error flow
>       net/mlx5: HWS, fix complex rules rehash error flow
>       net/mlx5: HWS, prevent rehash from filling up the queues
>       net/mlx5: HWS, don't rehash on every kind of insertion failure
>
> Yuichiro Tsuji (1):
>       net: usb: asix_devices: Fix PHY address mask in MDIO bus initializa=
tion
>
> Yunseong Kim (1):
>       perf: Avoid undefined behavior from stopping/starting inactive even=
ts
>
> Yuntao Wang (1):
>       fs: fix incorrect lflags value in the move_mount syscall
>
> Zenm Chen (1):
>       USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi do=
ngles
>
> Zhang Yi (2):
>       ext4: fix hole length calculation overflow in non-extent inodes
>       ASoC: codecs: ES9389: Modify the standby configuration
>
> Zheng Qixing (2):
>       md: add helper rdev_needs_recovery()
>       md: fix sync_action incorrect display during resync
>
> Zhu Yanjun (1):
>       RDMA/rxe: Flush delayed SKBs while releasing RXE resources
>
> Ziyan Xu (1):
>       ksmbd: fix refcount leak causing resource not released
>
> wenglianfa (1):
>       RDMA/hns: Fix querying wrong SCC context for DIP algorithm
>

