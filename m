Return-Path: <linux-kernel+bounces-784856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F72B342A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3D25E4D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249B52EDD78;
	Mon, 25 Aug 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8CINZ5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F82EE608
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130104; cv=none; b=s+W5uErzKgYYtFPa38j10AmwW9BwZqKUiS91B5av3EuqUyxYwUP0VmIqd+9s89ZC/dY4f7YlIkt4hfdY0JPBieyfEd8w4EvQddevUpGOvSIGrOnwYCPBg4CdmG1IeRt1kQBeL8FBpmXc1jzRPYGyqmlHfEU0CKkbiTca8sEDLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130104; c=relaxed/simple;
	bh=cvEhUlh/at1MYhYP9O/AhyCcG9/rDmrBEzSWnFV4v7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCtCivAtaVJnjVtfw2Z3zQGp0r6mTxkkyeP44g45CQ3tR8PSaTyTfU67NRL7zW7FMa2sHtVkNwQMjA4SQH0OzJU0ccDcq2DZ4+8p5VHbDAMbDiLSQg1CutpqzWXZA6VYyckoWgir3TPBCMPIrR+og4RaUIrd3NzaHpPB65Bb0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8CINZ5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC34C4CEED;
	Mon, 25 Aug 2025 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756130103;
	bh=cvEhUlh/at1MYhYP9O/AhyCcG9/rDmrBEzSWnFV4v7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8CINZ5JC6+BcL7DOxhfO+G6hu3+Cqv/csP6zLOb6b3d9Sif+fbzZYtCw3ebaFWpH
	 f4A/glB5wAT6+knnUndKosxALKyg67ufy97VhGFDRn7IirNKBMthfG/tRGwsjd+lsM
	 Zb5csNR50Co29el2FLClbtJ9kNsdtngVtobMA3LF4qbbBqsfn5/VoSoptzN183jXIS
	 h6Q0dvMy+5rlIvn7nggERm4sNSrwyWpiNgYs3jz2ULpqlt7ScZLyrcdCXnqmoKRGCb
	 MJktIa70CcNKCc/WxfO2MaBz4zLj082c0vs0xvV9/Fy0RiNarsFDTQIvK8c+dEuBe9
	 YfvdOqe+WLu8g==
Date: Mon, 25 Aug 2025 15:55:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 3/4] Workqueue: WQ_PERCPU added to all the remaining
 users
Message-ID: <aKxrNPfjjACwqSAa@localhost.localdomain>
References: <20250825132906.1050437-1-marco.crivellari@suse.com>
 <20250825132906.1050437-4-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825132906.1050437-4-marco.crivellari@suse.com>

Le Mon, Aug 25, 2025 at 03:29:05PM +0200, Marco Crivellari a écrit :
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This patch adds a new WQ_PERCPU flag to explicitly request the use of
> the per-CPU behavior. Both flags coexist for one release cycle to allow
> callers to transition their calls.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> All existing users have been updated accordingly.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

A similar per subsystem patch cut should be done here.

> ---
>  block/bio-integrity-auto.c                    |  5 +++--
>  block/bio.c                                   |  3 ++-
>  block/blk-core.c                              |  3 ++-
>  block/blk-throttle.c                          |  3 ++-
>  block/blk-zoned.c                             |  3 ++-

One for block.

>  crypto/cryptd.c                               |  3 ++-

One for crypto API.

>  drivers/acpi/ec.c                             |  3 ++-
>  drivers/acpi/osl.c                            |  4 ++--
>  drivers/acpi/thermal.c                        |  3 ++-
>  drivers/ata/libata-sff.c                      |  3 ++-
>  drivers/base/core.c                           |  2 +-
>  drivers/block/aoe/aoemain.c                   |  2 +-
>  drivers/block/rbd.c                           |  2 +-
>  drivers/block/rnbd/rnbd-clt.c                 |  2 +-
>  drivers/block/sunvdc.c                        |  2 +-
>  drivers/block/virtio_blk.c                    |  2 +-
>  drivers/bus/mhi/ep/main.c                     |  2 +-
>  drivers/char/tpm/tpm-dev-common.c             |  3 ++-
>  drivers/char/xillybus/xillybus_core.c         |  2 +-
>  drivers/char/xillybus/xillyusb.c              |  4 ++--
>  drivers/cpufreq/tegra194-cpufreq.c            |  3 ++-
>  drivers/crypto/atmel-i2c.c                    |  2 +-
>  drivers/crypto/cavium/nitrox/nitrox_mbx.c     |  2 +-
>  drivers/crypto/intel/qat/qat_common/adf_aer.c |  4 ++--
>  drivers/crypto/intel/qat/qat_common/adf_isr.c |  3 ++-
>  .../crypto/intel/qat/qat_common/adf_sriov.c   |  3 ++-
>  .../crypto/intel/qat/qat_common/adf_vf_isr.c  |  3 ++-
>  drivers/firewire/core-transaction.c           |  3 ++-
>  drivers/firewire/ohci.c                       |  3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 ++-
>  drivers/gpu/drm/bridge/analogix/anx7625.c     |  3 ++-
>  .../drm/i915/display/intel_display_driver.c   |  3 ++-
>  drivers/gpu/drm/i915/i915_driver.c            |  3 ++-
>  .../gpu/drm/i915/selftests/i915_sw_fence.c    |  2 +-
>  .../gpu/drm/i915/selftests/mock_gem_device.c  |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_drm.c         |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_sched.c       |  3 ++-
>  drivers/gpu/drm/radeon/radeon_display.c       |  3 ++-
>  drivers/gpu/drm/xe/xe_device.c                |  4 ++--
>  drivers/gpu/drm/xe/xe_ggtt.c                  |  2 +-
>  drivers/gpu/drm/xe/xe_hw_engine_group.c       |  3 ++-
>  drivers/gpu/drm/xe/xe_sriov.c                 |  2 +-
>  drivers/greybus/operation.c                   |  2 +-
>  drivers/hid/hid-nintendo.c                    |  3 ++-
>  drivers/hv/mshv_eventfd.c                     |  2 +-
>  drivers/i3c/master.c                          |  2 +-
>  drivers/infiniband/core/cm.c                  |  2 +-
>  drivers/infiniband/core/device.c              |  4 ++--
>  drivers/infiniband/hw/hfi1/init.c             |  3 +--
>  drivers/infiniband/hw/hfi1/opfn.c             |  3 +--
>  drivers/infiniband/hw/mlx4/cm.c               |  2 +-
>  drivers/infiniband/sw/rdmavt/cq.c             |  3 ++-
>  drivers/infiniband/ulp/iser/iscsi_iser.c      |  2 +-
>  drivers/infiniband/ulp/isert/ib_isert.c       |  2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c        |  2 +-
>  drivers/input/mouse/psmouse-smbus.c           |  2 +-
>  drivers/isdn/capi/kcapi.c                     |  2 +-
>  drivers/md/bcache/btree.c                     |  3 ++-
>  drivers/md/bcache/super.c                     | 10 ++++++----
>  drivers/md/bcache/writeback.c                 |  2 +-
>  drivers/md/dm-bufio.c                         |  3 ++-
>  drivers/md/dm-cache-target.c                  |  3 ++-
>  drivers/md/dm-clone-target.c                  |  3 ++-
>  drivers/md/dm-crypt.c                         |  6 ++++--
>  drivers/md/dm-delay.c                         |  4 +++-
>  drivers/md/dm-integrity.c                     | 15 ++++++++++-----
>  drivers/md/dm-kcopyd.c                        |  3 ++-
>  drivers/md/dm-log-userspace-base.c            |  3 ++-
>  drivers/md/dm-mpath.c                         |  5 +++--
>  drivers/md/dm-raid1.c                         |  5 +++--
>  drivers/md/dm-snap-persistent.c               |  3 ++-
>  drivers/md/dm-stripe.c                        |  2 +-
>  drivers/md/dm-verity-target.c                 |  4 +++-
>  drivers/md/dm-writecache.c                    |  3 ++-
>  drivers/md/dm.c                               |  3 ++-
>  drivers/md/md.c                               |  4 ++--
>  drivers/media/pci/ddbridge/ddbridge-core.c    |  2 +-
>  .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  6 ++++--
>  drivers/message/fusion/mptbase.c              |  7 +++++--
>  drivers/mmc/core/block.c                      |  3 ++-
>  drivers/mmc/host/omap.c                       |  2 +-
>  drivers/net/can/spi/hi311x.c                  |  3 ++-
>  drivers/net/can/spi/mcp251x.c                 |  3 ++-
>  .../net/ethernet/cavium/liquidio/lio_core.c   |  2 +-
>  .../net/ethernet/cavium/liquidio/lio_main.c   |  8 +++++---
>  .../ethernet/cavium/liquidio/lio_vf_main.c    |  3 ++-
>  .../cavium/liquidio/request_manager.c         |  2 +-
>  .../cavium/liquidio/response_manager.c        |  3 ++-
>  .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  2 +-
>  .../hisilicon/hns3/hns3pf/hclge_main.c        |  3 ++-
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
>  .../net/ethernet/marvell/octeontx2/af/cgx.c   |  2 +-
>  .../marvell/octeontx2/af/mcs_rvu_if.c         |  2 +-
>  .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  2 +-
>  .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  2 +-
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       |  3 ++-
>  .../ethernet/marvell/prestera/prestera_main.c |  2 +-
>  .../ethernet/marvell/prestera/prestera_pci.c  |  2 +-
>  drivers/net/ethernet/mellanox/mlxsw/core.c    |  4 ++--
>  drivers/net/ethernet/netronome/nfp/nfp_main.c |  2 +-
>  drivers/net/ethernet/qlogic/qed/qed_main.c    |  3 ++-
>  drivers/net/ethernet/wiznet/w5100.c           |  2 +-
>  drivers/net/fjes/fjes_main.c                  |  5 +++--
>  drivers/net/wireguard/device.c                |  6 ++++--
>  drivers/net/wireless/ath/ath6kl/usb.c         |  2 +-
>  .../net/wireless/marvell/libertas/if_sdio.c   |  3 ++-
>  .../net/wireless/marvell/libertas/if_spi.c    |  3 ++-
>  .../net/wireless/marvell/libertas_tf/main.c   |  2 +-
>  drivers/net/wireless/quantenna/qtnfmac/core.c |  3 ++-
>  drivers/net/wireless/realtek/rtlwifi/base.c   |  2 +-
>  drivers/net/wireless/realtek/rtw88/usb.c      |  3 ++-
>  drivers/net/wireless/silabs/wfx/main.c        |  2 +-
>  drivers/net/wireless/st/cw1200/bh.c           |  4 ++--
>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c    |  3 ++-
>  drivers/net/wwan/wwan_hwsim.c                 |  2 +-
>  drivers/nvme/host/tcp.c                       |  2 ++
>  drivers/nvme/target/core.c                    |  5 +++--
>  drivers/nvme/target/fc.c                      |  6 +++---
>  drivers/nvme/target/tcp.c                     |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  5 +++--
>  drivers/pci/endpoint/functions/pci-epf-test.c |  3 ++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  5 +++--
>  drivers/pci/hotplug/pnv_php.c                 |  3 ++-
>  drivers/pci/hotplug/shpchp_core.c             |  3 ++-
>  .../platform/surface/surface_acpi_notify.c    |  2 +-
>  drivers/power/supply/ab8500_btemp.c           |  3 ++-
>  drivers/power/supply/ipaq_micro_battery.c     |  3 ++-
>  drivers/rapidio/rio.c                         |  2 +-
>  drivers/s390/char/tape_3590.c                 |  2 +-
>  drivers/scsi/be2iscsi/be_main.c               |  3 ++-
>  drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |  2 +-
>  drivers/scsi/device_handler/scsi_dh_alua.c    |  2 +-
>  drivers/scsi/fcoe/fcoe.c                      |  2 +-
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c      |  3 ++-
>  drivers/scsi/lpfc/lpfc_init.c                 |  2 +-
>  drivers/scsi/pm8001/pm8001_init.c             |  2 +-
>  drivers/scsi/qedf/qedf_main.c                 | 15 ++++++++++-----
>  drivers/scsi/qedi/qedi_main.c                 |  2 +-
>  drivers/scsi/qla2xxx/qla_os.c                 |  2 +-
>  drivers/scsi/qla2xxx/qla_target.c             |  2 +-
>  drivers/scsi/qla2xxx/tcm_qla2xxx.c            |  2 +-
>  drivers/scsi/qla4xxx/ql4_os.c                 |  3 ++-
>  drivers/scsi/scsi_transport_fc.c              |  7 ++++---
>  drivers/soc/fsl/qbman/qman.c                  |  2 +-
>  drivers/staging/greybus/sdio.c                |  2 +-
>  drivers/target/target_core_transport.c        |  4 ++--
>  drivers/target/target_core_xcopy.c            |  2 +-
>  drivers/target/tcm_fc/tfc_conf.c              |  2 +-
>  drivers/usb/core/hub.c                        |  2 +-
>  drivers/usb/gadget/function/f_hid.c           |  3 +--
>  drivers/usb/storage/uas.c                     |  2 +-
>  drivers/usb/typec/anx7411.c                   |  3 +--
>  drivers/vdpa/vdpa_user/vduse_dev.c            |  3 ++-
>  drivers/virt/acrn/irqfd.c                     |  3 ++-
>  drivers/virtio/virtio_balloon.c               |  3 ++-
>  drivers/xen/privcmd.c                         |  3 ++-

One for drivers.

>  include/linux/workqueue.h                     |  4 ++--

One for workqueue.

>  kernel/bpf/cgroup.c                           |  3 ++-

One for BPF.

>  kernel/cgroup/cgroup-v1.c                     |  2 +-
>  kernel/cgroup/cgroup.c                        |  2 +-

One for cgroup.

>  kernel/padata.c                               |  5 +++--

One for padata.

>  kernel/power/main.c                           |  2 +-

One for power.

>  kernel/rcu/tree.c                             |  4 ++--

One for RCU.

>  kernel/workqueue.c                            | 19 ++++++++++---------

Join the workqueue change above.

>  virt/kvm/eventfd.c                            |  2 +-

And one for KVM.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

