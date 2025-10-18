Return-Path: <linux-kernel+bounces-859101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A51BECC8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DC7624860
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A42D8DB1;
	Sat, 18 Oct 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSlHr8gm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998802773F9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779810; cv=none; b=GTEXLettMK4BvCnKGNOjDtoS1JIPGxItZiQGzYOujo8vi7Ybo+odreN9X4XI8e/W6Sz+Z8CnlJAZtj37W239kwU3Ac5cow02k+vWabkPcvMvbI41wjj9pnMJQ4R+T0+G/zCVSBWlcUxlMyA0d+qrDjON7ijBOj/YatHzWVm8gFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779810; c=relaxed/simple;
	bh=00sr5d1R0M7+rj7KbFi67mxXjnxGW5uSdQ0zh0RL3MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6aDMEHOwPTWMDrMHBXSiTSbBYUYZq+El6ALzdcNWKKqC1ekyqmCQsfHGR9P3lfRVzhBf+lxvmV5eztrNRh6D50nZGIfmzvSKHiAWqBXHsWqhO672/jQ70cLXZ5LeQODmeatr8DSJjsh33jkFIkbvU/5Q4Isi6IBlGudshOORj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSlHr8gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467F0C4CEF8;
	Sat, 18 Oct 2025 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760779810;
	bh=00sr5d1R0M7+rj7KbFi67mxXjnxGW5uSdQ0zh0RL3MU=;
	h=From:To:Cc:Subject:Date:From;
	b=WSlHr8gmJkqQjYToJz5EaOQBh55A0VT2gnzGdARZPywn1gR6bUbhpxUD0mF2qTHcc
	 9tvtc7lsucsiIOqZl7m+XUJ+RL+QhVKPrqRuNVnU+M9y5aKth5PL1LQmwDF0YsR+NU
	 v/hE1IdmQjcOK1pWp0/T948nCOVSd1//3D9uONcTeCMv049iGQNrglVNr8bHlAdvAj
	 cTBPzi9WFy/J0oyNMTCO5+3rROZ6XAfjKkVDu3Wl7buvCk8/BTKd6qmToPqJ0oHt69
	 8PtD0P0E3igLtra6nh50TXOvakNotAAd4SzV/mjXVzonllA7fQ+92Z+AWo8utaCBYo
	 aKia/yad9ZlZg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
Date: Sat, 18 Oct 2025 12:29:59 +0300
Message-ID: <20251018093002.3660549-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Vast majority of allocations that use get_free_pages() and its derivatives
cast the returned unsigned long to a pointer and then cast it back to
unsigned long when freeing the memory.

These castings are useless and only obfuscate the code.

Make get_free_pages() and friends return 'void *' and free_pages() accept
'void *' as its address parameter.

The call site conversion is done using coccinelle scripts, see commit
messages for more details.

As the treewide changes are automated I heavily trimmed the list of ~400
entries get_maintainers.pl gave me to include people that maintain files
with not completely mechanical changes and Julia to verify my coccinelle
scripts Do The Right Thing :)

Mike Rapoport (Microsoft) (3):
  mm, vc_screen: move __free() handler that frees a page to a common header
  mm, treewide: make get_free_pages() and friends return void *
  mm, treewide: make addr parameter of free_pages() void *

 arch/alpha/kernel/pci_iommu.c                 |  6 +--
 arch/alpha/kernel/srm_env.c                   |  8 +--
 arch/arc/kernel/setup.c                       |  4 +-
 arch/arm/kernel/irq.c                         |  2 +-
 arch/arm/kernel/traps.c                       |  2 +-
 arch/arm/xen/enlighten.c                      |  2 +-
 arch/arm64/kernel/vdso.c                      |  4 +-
 arch/arm64/kvm/arm.c                          | 11 ++--
 arch/arm64/kvm/mmu.c                          |  6 +--
 arch/arm64/kvm/nested.c                       |  4 +-
 arch/arm64/kvm/reset.c                        |  2 +-
 arch/arm64/mm/mmu.c                           |  4 +-
 arch/loongarch/kvm/main.c                     |  5 +-
 arch/loongarch/kvm/mmu.c                      |  4 +-
 arch/loongarch/kvm/vm.c                       |  4 +-
 arch/m68k/sun3/sun3dvma.c                     |  6 +--
 arch/mips/include/asm/mach-generic/floppy.h   |  2 +-
 arch/mips/include/asm/mach-jazz/floppy.h      |  2 +-
 arch/mips/jazz/jazzdma.c                      |  2 +-
 arch/mips/kernel/irq.c                        |  2 +-
 arch/mips/kvm/mmu.c                           |  2 +-
 arch/nios2/mm/init.c                          |  2 +-
 arch/parisc/include/asm/floppy.h              |  2 +-
 arch/parisc/kernel/pci-dma.c                  |  6 +--
 arch/powerpc/include/asm/book3s/64/pgalloc.h  |  6 +--
 arch/powerpc/kernel/iommu.c                   |  4 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |  8 +--
 arch/powerpc/kvm/book3s_pr.c                  |  6 +--
 arch/powerpc/kvm/book3s_xive.c                |  5 +-
 arch/powerpc/kvm/booke.c                      |  6 +--
 arch/powerpc/kvm/e500.c                       |  4 +-
 arch/powerpc/kvm/e500mc.c                     |  4 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       | 10 ++--
 arch/powerpc/mm/init_64.c                     |  4 +-
 arch/powerpc/perf/imc-pmu.c                   |  8 +--
 arch/powerpc/platforms/cell/spufs/inode.c     |  5 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |  2 +-
 arch/powerpc/platforms/ps3/system-bus.c       |  6 +--
 arch/powerpc/platforms/pseries/iommu.c        |  4 +-
 .../platforms/pseries/pseries_energy.c        |  6 +--
 arch/powerpc/sysdev/xive/native.c             |  2 +-
 arch/powerpc/sysdev/xive/spapr.c              |  2 +-
 arch/riscv/kvm/aia_imsic.c                    |  6 +--
 arch/riscv/kvm/mmu.c                          |  2 +-
 arch/riscv/kvm/nacl.c                         |  3 +-
 arch/s390/crypto/aes_s390.c                   |  4 +-
 arch/s390/crypto/des_s390.c                   |  4 +-
 arch/s390/crypto/paes_s390.c                  |  4 +-
 arch/s390/crypto/prng.c                       |  4 +-
 arch/s390/hypfs/hypfs_diag_fs.c               |  6 +--
 arch/s390/hypfs/hypfs_sprp.c                  | 10 ++--
 arch/s390/include/asm/idals.h                 |  6 +--
 arch/s390/kernel/ipl.c                        | 38 +++++++-------
 arch/s390/kernel/perf_cpum_sf.c               | 20 +++----
 arch/s390/kernel/perf_pai_crypto.c            | 14 ++---
 arch/s390/kernel/perf_pai_ext.c               | 10 ++--
 arch/s390/kernel/smp.c                        | 13 ++---
 arch/s390/kernel/sthyi.c                      | 14 ++---
 arch/s390/kernel/sysinfo.c                    | 14 ++---
 arch/s390/kernel/time.c                       |  4 +-
 arch/s390/kvm/intercept.c                     |  8 +--
 arch/s390/kvm/interrupt.c                     |  8 +--
 arch/s390/kvm/kvm-s390.c                      | 22 ++++----
 arch/s390/kvm/pci.c                           |  2 +-
 arch/s390/kvm/priv.c                          |  8 +--
 arch/s390/kvm/pv.c                            | 30 ++++++-----
 arch/s390/kvm/vsie.c                          |  4 +-
 arch/s390/mm/cmm.c                            | 12 ++---
 arch/s390/mm/gmap.c                           |  2 +-
 arch/s390/mm/maccess.c                        |  4 +-
 arch/s390/mm/vmem.c                           |  4 +-
 arch/s390/pci/pci_clp.c                       |  4 +-
 arch/s390/pci/pci_report.c                    |  4 +-
 arch/sh/boards/mach-hp6xx/pm.c                |  4 +-
 arch/sh/kernel/vsyscall/vsyscall.c            |  2 +-
 arch/sparc/kernel/iommu.c                     |  6 +--
 arch/sparc/kernel/irq_64.c                    |  6 +--
 arch/sparc/kernel/ldc.c                       | 10 ++--
 arch/sparc/kernel/pci_fire.c                  |  5 +-
 arch/sparc/kernel/pci_sun4v.c                 | 17 +++---
 arch/sparc/kernel/traps_64.c                  |  2 +-
 arch/sparc/mm/io-unit.c                       |  4 +-
 arch/sparc/mm/iommu.c                         |  6 +--
 arch/um/drivers/mconsole_kern.c               |  2 +-
 arch/um/kernel/process.c                      |  4 +-
 arch/um/kernel/skas/mmu.c                     |  7 +--
 arch/x86/coco/sev/core.c                      |  4 +-
 arch/x86/events/intel/ds.c                    |  4 +-
 arch/x86/events/intel/pt.c                    |  2 +-
 arch/x86/hyperv/ivm.c                         |  6 +--
 arch/x86/include/asm/floppy.h                 |  2 +-
 arch/x86/kernel/amd_gart_64.c                 |  6 +--
 arch/x86/kernel/ldt.c                         |  4 +-
 arch/x86/kernel/machine_kexec_32.c            | 20 +++----
 arch/x86/kernel/machine_kexec_64.c            | 16 +++---
 arch/x86/kvm/lapic.c                          |  4 +-
 arch/x86/kvm/mmu/mmu.c                        | 20 +++----
 arch/x86/kvm/mmu/tdp_mmu.c                    |  6 +--
 arch/x86/kvm/svm/avic.c                       |  8 +--
 arch/x86/kvm/svm/sev.c                        |  4 +-
 arch/x86/kvm/vmx/nested.c                     |  4 +-
 arch/x86/kvm/vmx/sgx.c                        |  6 +--
 arch/x86/kvm/vmx/vmx.c                        | 12 ++---
 arch/x86/kvm/x86.c                            |  4 +-
 arch/x86/mm/init.c                            |  2 +-
 arch/x86/mm/init_64.c                         |  2 +-
 arch/x86/mm/pat/set_memory.c                  | 12 ++---
 arch/x86/mm/pgtable.c                         |  4 +-
 arch/x86/mm/pti.c                             |  8 +--
 arch/x86/pci/pcbios.c                         |  4 +-
 arch/x86/platform/efi/efi.c                   |  4 +-
 arch/x86/platform/efi/efi_64.c                |  6 +--
 arch/x86/virt/svm/sev.c                       |  2 +-
 arch/x86/xen/mmu_pv.c                         |  8 +--
 arch/x86/xen/p2m.c                            |  4 +-
 arch/x86/xen/pmu.c                            |  6 +--
 arch/x86/xen/time.c                           |  6 +--
 block/partitions/core.c                       |  6 +--
 crypto/scatterwalk.c                          |  4 +-
 crypto/scompress.c                            |  2 +-
 crypto/tcrypt.c                               | 10 ++--
 crypto/testmgr.c                              |  6 +--
 crypto/xor.c                                  |  4 +-
 drivers/acpi/nvs.c                            |  4 +-
 drivers/atm/eni.c                             |  4 +-
 drivers/atm/lanai.c                           |  4 +-
 drivers/auxdisplay/cfag12864b.c               |  6 +--
 drivers/auxdisplay/ht16k33.c                  |  6 +--
 drivers/base/devres.c                         |  6 +--
 drivers/block/aoe/aoecmd.c                    |  2 +-
 drivers/block/drbd/drbd_main.c                |  8 +--
 drivers/block/floppy.c                        |  2 +-
 drivers/block/ps3vram.c                       |  6 +--
 drivers/block/ublk_drv.c                      |  4 +-
 drivers/char/agp/agp.h                        |  4 +-
 drivers/char/agp/amd-k7-agp.c                 |  4 +-
 drivers/char/agp/ati-agp.c                    |  6 +--
 drivers/char/agp/efficeon-agp.c               |  4 +-
 drivers/char/agp/sworks-agp.c                 |  4 +-
 drivers/char/agp/uninorth-agp.c               |  6 +--
 drivers/char/hw_random/s390-trng.c            |  4 +-
 drivers/char/tpm/tpm-buf.c                    |  6 +--
 drivers/char/tpm/tpm_ibmvtpm.c                |  6 +--
 drivers/char/xilinx_hwicap/xilinx_hwicap.c    | 18 +++----
 drivers/char/xillybus/xillyusb.c              | 10 ++--
 drivers/comedi/comedi_buf.c                   |  4 +-
 drivers/crypto/atmel-aes.c                    |  4 +-
 drivers/crypto/atmel-tdes.c                   | 12 ++---
 drivers/crypto/ccp/tee-dev.c                  |  5 +-
 .../crypto/inside-secure/eip93/eip93-common.c |  4 +-
 drivers/crypto/nx/nx-842.c                    | 12 ++---
 drivers/crypto/omap-crypto.c                  |  4 +-
 drivers/crypto/omap-sham.c                    |  5 +-
 drivers/crypto/s5p-sss.c                      |  9 ++--
 drivers/crypto/stm32/stm32-hash.c             |  4 +-
 drivers/dma/nbpfaxi.c                         |  4 +-
 drivers/dma/sh/rcar-dmac.c                    |  6 +--
 drivers/dma/ste_dma40.c                       | 12 ++---
 drivers/extcon/extcon.c                       |  4 +-
 drivers/firewire/ohci.c                       |  6 +--
 drivers/firmware/efi/efi.c                    |  4 +-
 drivers/firmware/psci/psci_checker.c          |  4 +-
 drivers/fsi/fsi-occ.c                         |  4 +-
 drivers/fsi/fsi-sbefifo.c                     |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  6 +--
 drivers/gpu/drm/i915/gt/selftest_lrc.c        |  4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c    |  6 +--
 drivers/gpu/drm/i915/gvt/gtt.c                |  8 +--
 drivers/gpu/drm/i915/gvt/opregion.c           |  4 +-
 drivers/gpu/drm/i915/i915_gpu_error.c         |  2 +-
 drivers/gpu/drm/msm/msm_iommu.c               |  2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  2 +-
 drivers/gpu/drm/tegra/drm.c                   |  6 +--
 drivers/hsi/clients/cmt_speech.c              |  6 +--
 drivers/hv/connection.c                       | 14 +++--
 drivers/hv/hv.c                               | 16 +++---
 drivers/hv/hv_proc.c                          |  4 +-
 drivers/hv/mshv_root_hv_call.c                |  2 +-
 drivers/hv/mshv_root_main.c                   |  2 +-
 drivers/infiniband/core/umem.c                |  4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 16 +++---
 drivers/infiniband/hw/bnxt_re/main.c          |  8 +--
 drivers/infiniband/hw/cxgb4/device.c          |  6 +--
 drivers/infiniband/hw/cxgb4/mem.c             |  4 +-
 drivers/infiniband/hw/mlx4/mr.c               |  6 +--
 drivers/infiniband/hw/mlx5/main.c             |  8 +--
 drivers/infiniband/hw/mlx5/odp.c              |  4 +-
 drivers/infiniband/hw/mlx5/umr.c              |  8 +--
 drivers/infiniband/hw/mthca/mthca_allocator.c |  6 +--
 drivers/infiniband/hw/mthca/mthca_provider.c  |  4 +-
 drivers/infiniband/hw/qedr/verbs.c            |  6 +--
 drivers/infiniband/hw/usnic/usnic_uiom.c      |  4 +-
 drivers/infiniband/sw/rdmavt/qp.c             |  6 +--
 drivers/input/misc/xen-kbdfront.c             |  4 +-
 drivers/iommu/amd/iommu.c                     |  2 +-
 drivers/iommu/fsl_pamu.c                      |  2 +-
 drivers/iommu/io-pgtable-arm-v7s.c            |  6 +--
 drivers/iommu/iommufd/iova_bitmap.c           |  4 +-
 drivers/iommu/iommufd/selftest.c              |  6 +--
 drivers/irqchip/irq-gic-v3-its.c              |  2 +-
 drivers/macintosh/rack-meter.c                |  6 +--
 drivers/mailbox/riscv-sbi-mpxy-mbox.c         |  2 +-
 drivers/md/bcache/bset.c                      | 18 +++----
 drivers/md/bcache/btree.c                     |  4 +-
 drivers/md/bcache/journal.c                   |  8 +--
 drivers/md/bcache/super.c                     |  6 +--
 drivers/md/dm-bufio.c                         |  6 +--
 drivers/media/pci/intel/ipu6/ipu6-mmu.c       | 26 +++++-----
 drivers/media/pci/pt1/pt1.c                   |  6 +--
 drivers/media/pci/saa7134/saa7134-go7007.c    | 12 ++---
 drivers/media/pci/solo6x10/solo6x10-p2m.c     | 10 ++--
 drivers/media/platform/ti/omap/omap_voutlib.c |  4 +-
 drivers/misc/ibmvmc.c                         |  6 +--
 drivers/misc/lkdtm/core.c                     | 16 +++---
 drivers/misc/lkdtm/heap.c                     | 26 +++++-----
 drivers/misc/ocxl/link.c                      |  4 +-
 drivers/misc/sgi-gru/grufile.c                |  4 +-
 drivers/misc/sgi-xp/xpc_uv.c                  |  4 +-
 drivers/misc/vmw_balloon.c                    |  2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  4 +-
 drivers/net/ethernet/amd/mvme147.c            |  4 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |  2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_sp.c    |  4 +-
 drivers/net/ethernet/cirrus/cs89x0.c          |  3 +-
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 20 +++----
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 14 ++---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  3 +-
 drivers/net/ethernet/i825xx/82596.c           |  4 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c     | 52 +++++++++----------
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c      | 14 ++---
 drivers/net/ethernet/ibm/ibmveth.c            | 12 ++---
 drivers/net/ethernet/ibm/ibmvnic.c            | 12 ++---
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  4 +-
 drivers/net/ethernet/mediatek/mtk_wed.c       |  4 +-
 .../mellanox/mlx5/core/diag/fw_tracer.c       |  6 +--
 .../ethernet/mellanox/mlx5/core/lib/clock.c   |  4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 30 +++++------
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  2 +-
 drivers/net/ethernet/sfc/mcdi.c               |  6 +--
 drivers/net/ethernet/sfc/siena/mcdi.c         |  6 +--
 drivers/net/ethernet/sun/niu.c                |  4 +-
 .../net/ethernet/toshiba/ps3_gelic_wireless.c | 24 ++++-----
 drivers/net/rionet.c                          |  9 ++--
 drivers/net/usb/kaweth.c                      |  4 +-
 drivers/net/wireless/broadcom/b43/debugfs.c   | 10 ++--
 .../net/wireless/broadcom/b43legacy/debugfs.c | 10 ++--
 drivers/net/wireless/intel/iwlegacy/common.h  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +-
 .../net/wireless/marvell/libertas/debugfs.c   | 32 ++++++------
 .../net/wireless/marvell/mwifiex/debugfs.c    | 36 ++++++-------
 drivers/net/wireless/ti/wlcore/main.c         | 12 ++---
 drivers/parisc/ccio-dma.c                     |  8 +--
 drivers/parisc/sba_iommu.c                    | 28 +++++-----
 drivers/perf/riscv_pmu_sbi.c                  |  2 +-
 drivers/platform/goldfish/goldfish_pipe.c     | 10 ++--
 drivers/platform/x86/dell/dell_rbu.c          | 13 +++--
 drivers/power/supply/power_supply_sysfs.c     |  4 +-
 drivers/ptp/ptp_kvm_x86.c                     |  2 +-
 drivers/ptp/ptp_ocp.c                         |  4 +-
 drivers/ras/cec.c                             |  4 +-
 drivers/s390/block/dasd.c                     | 18 +++----
 drivers/s390/block/dasd_diag.c                |  4 +-
 drivers/s390/block/dasd_eckd.c                | 14 ++---
 drivers/s390/block/dasd_eer.c                 |  4 +-
 drivers/s390/block/dasd_fba.c                 |  8 +--
 drivers/s390/block/scm_blk.c                  |  4 +-
 drivers/s390/char/con3270.c                   |  8 +--
 drivers/s390/char/diag_ftp.c                  |  4 +-
 drivers/s390/char/hmcdrv_cache.c              |  5 +-
 drivers/s390/char/hmcdrv_ftp.c                |  8 +--
 drivers/s390/char/sclp.c                      |  8 +--
 drivers/s390/char/sclp_ap.c                   |  4 +-
 drivers/s390/char/sclp_cmd.c                  | 12 ++---
 drivers/s390/char/sclp_con.c                  |  4 +-
 drivers/s390/char/sclp_config.c               |  4 +-
 drivers/s390/char/sclp_cpi_sys.c              |  4 +-
 drivers/s390/char/sclp_ctl.c                  |  4 +-
 drivers/s390/char/sclp_ftp.c                  |  8 +--
 drivers/s390/char/sclp_mem.c                  | 12 ++---
 drivers/s390/char/sclp_pci.c                  |  8 +--
 drivers/s390/char/sclp_sd.c                   |  4 +-
 drivers/s390/char/sclp_sdias.c                |  4 +-
 drivers/s390/char/sclp_tty.c                  |  4 +-
 drivers/s390/char/sclp_vt220.c                |  4 +-
 drivers/s390/char/uvdevice.c                  |  4 +-
 drivers/s390/char/vmcp.c                      |  4 +-
 drivers/s390/char/vmlogrdr.c                  |  4 +-
 drivers/s390/char/vmur.c                      |  8 +--
 drivers/s390/char/zcore.c                     |  8 +--
 drivers/s390/cio/chsc.c                       | 20 +++----
 drivers/s390/cio/chsc_sch.c                   | 44 ++++++++--------
 drivers/s390/cio/cmf.c                        |  6 +--
 drivers/s390/cio/qdio_main.c                  | 18 +++----
 drivers/s390/cio/qdio_setup.c                 | 12 ++---
 drivers/s390/cio/scm.c                        |  4 +-
 drivers/s390/crypto/zcrypt_api.c              |  6 +--
 drivers/s390/crypto/zcrypt_msgtype6.c         |  8 +--
 drivers/s390/net/qeth_core_main.c             |  4 +-
 drivers/s390/net/qeth_l2_main.c               |  4 +-
 drivers/s390/scsi/zfcp_fc.c                   |  4 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                |  6 +--
 drivers/scsi/ibmvscsi/ibmvscsi.c              |  6 +--
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c      |  6 +--
 drivers/scsi/ipr.c                            |  4 +-
 drivers/scsi/libiscsi.c                       |  8 ++-
 drivers/scsi/megaraid/megaraid_sas_base.c     |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c   | 12 ++---
 drivers/scsi/ncr53c8xx.c                      |  5 +-
 drivers/scsi/qedi/qedi_main.c                 | 14 ++---
 drivers/scsi/scsi_devinfo.c                   |  4 +-
 drivers/scsi/scsi_proc.c                      |  8 +--
 drivers/scsi/sym53c8xx_2/sym_hipd.h           |  4 +-
 drivers/scsi/vmw_pvscsi.c                     |  7 ++-
 drivers/sh/maple/maple.c                      |  4 +-
 drivers/spi/spi-ep93xx.c                      |  6 +--
 drivers/spi/spi-rockchip-sfc.c                |  6 +--
 drivers/spi/spi-sh-msiof.c                    | 12 ++---
 .../staging/media/atomisp/pci/mmu/isp_mmu.c   |  4 +-
 drivers/staging/media/av7110/av7110_ca.c      |  4 +-
 drivers/staging/media/ipu3/ipu3-mmu.c         | 10 ++--
 drivers/staging/media/ipu7/ipu7-mmu.c         | 26 +++++-----
 drivers/target/target_core_file.c             |  4 +-
 drivers/tee/amdtee/core.c                     |  4 +-
 drivers/tee/amdtee/shm_pool.c                 |  6 +--
 drivers/thunderbolt/debugfs.c                 | 24 ++++-----
 drivers/tty/amiserial.c                       |  8 +--
 drivers/tty/hvc/hvc_iucv.c                    |  6 +--
 drivers/tty/hvc/hvc_xen.c                     |  4 +-
 drivers/tty/hvc/hvcs.c                        |  6 +--
 drivers/tty/serial/men_z135_uart.c            |  6 +--
 drivers/tty/serial/pch_uart.c                 |  6 +--
 drivers/tty/serial/serial_core.c              |  6 +--
 drivers/tty/tty_port.c                        |  6 +--
 drivers/tty/vt/vc_screen.c                    |  6 +--
 drivers/usb/atm/cxacru.c                      | 16 +++---
 drivers/usb/atm/speedtch.c                    |  4 +-
 drivers/usb/core/buffer.c                     |  6 +--
 drivers/usb/core/devices.c                    |  6 +--
 drivers/usb/core/devio.c                      |  4 +-
 drivers/usb/host/ohci-dbg.c                   |  4 +-
 drivers/usb/mon/mon_bin.c                     |  6 +--
 drivers/usb/serial/usb_wwan.c                 |  6 +--
 drivers/vfio/vfio_iommu_type1.c               |  4 +-
 drivers/vhost/vdpa.c                          |  4 +-
 drivers/video/fbdev/ssd1307fb.c               |  2 +-
 drivers/video/fbdev/xen-fbfront.c             |  4 +-
 drivers/virt/vboxguest/vboxguest_utils.c      |  4 +-
 drivers/xen/events/events_base.c              |  8 +--
 drivers/xen/events/events_fifo.c              | 10 ++--
 drivers/xen/evtchn.c                          |  4 +-
 drivers/xen/grant-table.c                     |  8 +--
 drivers/xen/pvcalls-front.c                   |  6 +--
 drivers/xen/swiotlb-xen.c                     |  6 +--
 drivers/xen/xenbus/xenbus_probe.c             |  4 +-
 fs/affs/file.c                                |  2 +-
 fs/affs/inode.c                               |  2 +-
 fs/bfs/inode.c                                |  4 +-
 fs/binfmt_misc.c                              |  4 +-
 fs/ceph/mds_client.c                          |  4 +-
 fs/configfs/file.c                            |  6 +--
 fs/ecryptfs/crypto.c                          |  2 +-
 fs/ext4/super.c                               |  4 +-
 fs/fuse/ioctl.c                               |  4 +-
 fs/isofs/dir.c                                |  4 +-
 fs/jbd2/journal.c                             |  4 +-
 fs/jfs/jfs_dtree.c                            |  8 +--
 fs/libfs.c                                    |  6 +--
 fs/namespace.c                                |  4 +-
 fs/nfs/nfs4namespace.c                        |  8 +--
 fs/nfs/super.c                                |  4 +-
 fs/nfsd/vfs.c                                 |  4 +-
 fs/nilfs2/ioctl.c                             |  4 +-
 fs/ocfs2/dlm/dlmdebug.c                       | 12 ++---
 fs/ocfs2/dlm/dlmdomain.c                      |  4 +-
 fs/ocfs2/dlm/dlmmaster.c                      |  4 +-
 fs/ocfs2/dlm/dlmrecovery.c                    |  4 +-
 fs/proc/base.c                                | 16 +++---
 fs/proc/vmcore.c                              | 10 ++--
 fs/quota/dquot.c                              |  2 +-
 fs/select.c                                   |  4 +-
 include/linux/gfp.h                           | 10 ++--
 init/do_mounts.c                              |  4 +-
 kernel/dma/debug.c                            |  2 +-
 kernel/dma/swiotlb.c                          | 22 ++++----
 kernel/kexec_handover.c                       |  6 +--
 kernel/power/snapshot.c                       |  6 +--
 kernel/power/swap.c                           | 24 ++++-----
 kernel/trace/ftrace.c                         | 12 ++---
 kernel/trace/ring_buffer.c                    | 10 ++--
 kernel/trace/trace.c                          |  2 +-
 kernel/trace/trace_sched_switch.c             |  2 +-
 kernel/trace/trace_uprobe.c                   |  5 +-
 kernel/trace/tracing_map.c                    |  4 +-
 kernel/vmcore_info.c                          |  4 +-
 lib/raid6/algos.c                             |  4 +-
 lib/scatterlist.c                             |  4 +-
 lib/stackdepot.c                              |  2 +-
 lib/test_free_pages.c                         |  4 +-
 mm/kasan/kasan_test_c.c                       | 10 ++--
 mm/kasan/shadow.c                             |  4 +-
 mm/mincore.c                                  |  4 +-
 mm/mmu_gather.c                               |  8 +--
 mm/page_alloc.c                               | 33 ++++++------
 mm/slab_common.c                              | 10 ++--
 mm/slub.c                                     |  6 +--
 net/9p/trans_xen.c                            |  6 +--
 net/atm/mpoa_proc.c                           |  6 +--
 net/atm/proc.c                                |  4 +-
 net/netfilter/nf_tables_api.c                 |  4 +-
 net/packet/af_packet.c                        |  7 ++-
 net/rds/cong.c                                |  6 +--
 net/sctp/protocol.c                           | 12 ++---
 net/sunrpc/backchannel_rqst.c                 |  4 +-
 net/sunrpc/xprtsock.c                         |  2 +-
 net/xfrm/xfrm_hash.c                          |  4 +-
 security/apparmor/apparmorfs.c                |  4 +-
 security/integrity/ima/ima_crypto.c           |  6 +--
 security/selinux/hooks.c                      |  4 +-
 security/selinux/selinuxfs.c                  | 12 ++---
 sound/drivers/dummy.c                         |  4 +-
 virt/kvm/coalesced_mmio.c                     |  2 +-
 virt/kvm/kvm_main.c                           |  8 +--
 426 files changed, 1469 insertions(+), 1476 deletions(-)


base-commit: 593609b026ef42759336ca5cc3ff6ddf06a9e2f6
--
2.50.1

